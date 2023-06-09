Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA172A521
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjFIVMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIVMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9913035A2;
        Fri,  9 Jun 2023 14:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36BE260F4D;
        Fri,  9 Jun 2023 21:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C035C433EF;
        Fri,  9 Jun 2023 21:12:29 +0000 (UTC)
Date:   Fri, 9 Jun 2023 17:12:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     mhiramat@kernel.org, corbet@lwn.net, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 tracing 3/6] tracing: support IPv6 filter predicates
Message-ID: <20230609171227.56dc45b6@gandalf.local.home>
In-Reply-To: <1682696089-27937-4-git-send-email-alan.maguire@oracle.com>
References: <1682696089-27937-1-git-send-email-alan.maguire@oracle.com>
        <1682696089-27937-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


BTW, the subjects for the tracing subsystem should always start with a
capital letter.

  "tracing: Support IPv6 filter predicates"

But that's not why I'm replying here.

On Fri, 28 Apr 2023 16:34:46 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> Support '==' and '!=' predicates for IPv6 addresses;
> for example
> 
>  cd /sys/kernel/debug/tracing/events/tcp/tcp_receive_reset
>  echo "saddr_v6 == ::1" > filter
> 
>  or equivalently
> 
>  echo "saddr_v6 == 0:0:0:0:0:0:0:1" > filter
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/trace/trace_events_filter.c | 73 ++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index d8e08d3c3594..e2521574f3c4 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1665,6 +1665,79 @@ static int parse_pred(const char *str, void *data,
>  		if (pred->op == OP_NE)
>  			pred->not = 1;
>  
> +	} else if (field->size == 16 &&
> +		   (str[i] == ':' ||
> +		    (isalnum(str[i]) && tolower(str[i + 1]) != 'x'))) {
> +		u8 j, gap_size, gap = 0, gap_count = 0, index = 0;
> +		u16 tmp_v6addr[8] = {};
> +		u16 v6addr[8] = {};
> +
> +		/* For IPv6 addresses, only '==' or '!=' are supported. */
> +		if (pred->op != OP_EQ && pred->op != OP_NE) {
> +			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
> +			goto err_free;
> +		}
> +		/* Store the u16s in the address string consecutively in
> +		 * tmp_v6addr while tracking the presence of a "::" (if any)
> +		 * in the IPv6 address string; we will use its location
> +		 * to determine how many u16s it represents (the gap_size
> +		 * below).  Only one "::" is allowed in an IPv6 address
> +		 * string.
> +		 */
> +		while (isalnum(str[i]) || str[i] == ':') {
> +			switch (str[i]) {
> +			case ':':
> +				i++;
> +				/* mark "::" index by setting gap */
> +				if (str[i] == ':') {
> +					gap = index;
> +					gap_count++;
> +					i++;
> +				}
> +				if (gap_count > 1) {
> +					parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP,
> +						    pos + s);
> +					goto err_free;
> +				}
> +				break;
> +			default:
> +				if (sscanf(&str[i], "%hx", &tmp_v6addr[index]) != 1) {
> +					parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP,
> +						    pos + s);
> +					goto err_free;
> +				}
> +				index++;
> +				while (isalnum(str[i]))
> +					i++;
> +				break;
> +			}
> +		}

There appears to be no limit to the above loop. I panic'd my machine with:

 # echo 'saddr_v6 == 0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef' > /sys/kernel/tracing/events/sock/inet_sk_error_report/filter

-- Steve

> +		/* The gap_size here represents the number of u16s the "::"
> +		 * represents; for ::1 the gap size is 7, for feed::face
> +		 * it is 6, etc.
> +		 */
> +		gap_size = 8 - index;
> +		index = 0;
> +		for (j = 0; j < 8; ) {
> +			if (gap_size > 0 && j == gap) {
> +				j += gap_size;
> +			} else {
> +#ifdef __BIG_ENDIAN
> +				v6addr[j++] = tmp_v6addr[index];
> +#else
> +				v6addr[j++] = ((tmp_v6addr[index] & 0xff) << 8) +
> +					      ((tmp_v6addr[index] & 0xff00) >> 8);
> +#endif
> +				index++;
> +			}
> +		}
> +		pred_val = kzalloc(field->size, GFP_KERNEL);
> +		memcpy(pred_val, v6addr, field->size);
> +		pred->val = (u64)pred_val;
> +		pred->fn_num = FILTER_PRED_FN_MEMCMP;
> +		if (pred->op == OP_NE)
> +			pred->not = 1;
> +
>  	} else if (str[i] == '0' && tolower(str[i + 1]) == 'x' &&
>  		   field->size > 8) {
>  		/* For sizes > 8 bytes, we store hex bytes for comparison;

