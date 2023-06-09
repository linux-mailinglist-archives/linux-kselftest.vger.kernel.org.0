Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DED72A535
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjFIVPw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIVPv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0F35A3;
        Fri,  9 Jun 2023 14:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B994E65C48;
        Fri,  9 Jun 2023 21:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAC2C433EF;
        Fri,  9 Jun 2023 21:15:48 +0000 (UTC)
Date:   Fri, 9 Jun 2023 17:15:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     mhiramat@kernel.org, corbet@lwn.net, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 tracing 3/6] tracing: support IPv6 filter predicates
Message-ID: <20230609171546.4bd8097f@gandalf.local.home>
In-Reply-To: <20230609171227.56dc45b6@gandalf.local.home>
References: <1682696089-27937-1-git-send-email-alan.maguire@oracle.com>
        <1682696089-27937-4-git-send-email-alan.maguire@oracle.com>
        <20230609171227.56dc45b6@gandalf.local.home>
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

On Fri, 9 Jun 2023 17:12:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +		while (isalnum(str[i]) || str[i] == ':') {
> > +			switch (str[i]) {
> > +			case ':':
> > +				i++;
> > +				/* mark "::" index by setting gap */
> > +				if (str[i] == ':') {
> > +					gap = index;
> > +					gap_count++;
> > +					i++;
> > +				}
> > +				if (gap_count > 1) {
> > +					parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP,
> > +						    pos + s);
> > +					goto err_free;
> > +				}
> > +				break;
> > +			default:
> > +				if (sscanf(&str[i], "%hx", &tmp_v6addr[index]) != 1) {
> > +					parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP,
> > +						    pos + s);
> > +					goto err_free;
> > +				}
> > +				index++;
> > +				while (isalnum(str[i]))
> > +					i++;
> > +				break;

There should also be a lot more checks here where the input coming in is
correct. It also accepted:

 "123456789abcdef0" as "def0", where I expected it to fail.

-- Steve


> > +			}
> > +		}  
> 
> There appears to be no limit to the above loop. I panic'd my machine with:
> 
>  # echo 'saddr_v6 == 0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef:0123:4567:89ab:cdef' > /sys/kernel/tracing/events/sock/inet_sk_error_report/filter
> 
> -- Steve
> 
> > +		/* The gap_size here represents the number of u16s the "::"
> > +		 * represents; for ::1 the gap size is 7, for feed::face
> > +		 * it is 6, etc.
> > +		 */
> > +		gap_size = 8 - index;
> > +		index = 0;
> > +		for (j = 0; j < 8; ) {
> > +			if (gap_size > 0 && j == gap) {
> > +				j += gap_size;
> > +			} else {
> > +#ifdef __BIG_ENDIAN
> > +				v6addr[j++] = tmp_v6addr[index];
> > +#else
> > +				v6addr[j++] = ((tmp_v6addr[index] & 0xff) << 8) +
> > +					      ((tmp_v6addr[index] & 0xff00) >> 8);
> > +#endif
> > +				index++;
> > +			}
> > +		}
> > +		pred_val = kzalloc(field->size, GFP_KERNEL);
> > +		memcpy(pred_val, v6addr, field->size);
> > +		pred->val = (u64)pred_val;
> > +		pred->fn_num = FILTER_PRED_FN_MEMCMP;
> > +		if (pred->op == OP_NE)
> > +			pred->not = 1;
> > +
> >  	} else if (str[i] == '0' && tolower(str[i + 1]) == 'x' &&
> >  		   field->size > 8) {
> >  		/* For sizes > 8 bytes, we store hex bytes for comparison;  

