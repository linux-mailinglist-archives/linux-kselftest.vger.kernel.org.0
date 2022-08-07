Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA95F58BE16
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 00:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiHGWxW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 18:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHGWxV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 18:53:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A048E21A5;
        Sun,  7 Aug 2022 15:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8624BB80D7F;
        Sun,  7 Aug 2022 22:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DAEC433D6;
        Sun,  7 Aug 2022 22:53:15 +0000 (UTC)
Date:   Sun, 7 Aug 2022 18:53:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     corbet@lwn.net, mingo@redhat.com, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC tracing 1/4] tracing: predicate matching trigger crashes
 for > 8-byte arrays
Message-ID: <20220807185220.6aaa0593@rorschach.local.home>
In-Reply-To: <1659910883-18223-2-git-send-email-alan.maguire@oracle.com>
References: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
        <1659910883-18223-2-git-send-email-alan.maguire@oracle.com>
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

On Sun,  7 Aug 2022 23:21:20 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> The following (wrong) use of tracepoint filtering was enough to trigger
> a null-pointer dereference crash:
> 
> 	cd /sys/kernel/debug/tracing
> 	echo "saddr_v6 == 0x0100007f" > tcp/tcp_receive_reset/filter
> 	echo 1 > tcp/tcp_receive_reset/enable
> 	wget https://localhost
> 
> This works fine if saddr - a 4-byte array representing the source address -
> is used instead.
> 

The patch series is a new feature so it would need to go into the next
merge window. But this patch looks to be a bug fix, so I'll pull this
one in separately, and tag it for stable.

Thanks,

-- Steve


> Fix is to handle case where we encounter an unexpected size.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/trace/trace_events_filter.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 4b1057ab9d96..65e01c8d48d9 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1490,6 +1490,11 @@ static int parse_pred(const char *str, void *data,
>  		else {
>  			pred->fn = select_comparison_fn(pred->op, field->size,
>  							field->is_signed);
> +			if (!pred->fn) {
> +				parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP,
> +					    pos + i);
> +				goto err_free;
> +			}
>  			if (pred->op == OP_NE)
>  				pred->not = 1;
>  		}

