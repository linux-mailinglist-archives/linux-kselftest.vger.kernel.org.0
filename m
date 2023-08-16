Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D323377EA9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbjHPUUu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbjHPUUX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 16:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DFB2690;
        Wed, 16 Aug 2023 13:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 529D06101E;
        Wed, 16 Aug 2023 20:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DE7C433C7;
        Wed, 16 Aug 2023 20:20:20 +0000 (UTC)
Date:   Wed, 16 Aug 2023 16:20:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     <mhiramat@kernel.org>, <shuah@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: let traceonoff_triggers testcase
 without md5sum
Message-ID: <20230816162023.79ad9a47@gandalf.local.home>
In-Reply-To: <20230814025918.2726807-1-zouyipeng@huawei.com>
References: <20230814025918.2726807-1-zouyipeng@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 14 Aug 2023 10:59:18 +0800
Yipeng Zou <zouyipeng@huawei.com> wrote:

> So I directly dump the trace file before md5sum, the diff shows that:
> 
> [root@localhost]# diff trace_1.log trace_2.log -y --suppress-common-lines
> dockerd-12285   [036] d.... 18385.510290: sched_stat | <...>-12285   [036] d.... 18385.510290: sched_stat
> dockerd-12285   [036] d.... 18385.510291: sched_swit | <...>-12285   [036] d.... 18385.510291: sched_swit
> <...>-740       [044] d.... 18385.602859: sched_stat | kworker/44:1-740 [044] d.... 18385.602859: sched_stat
> <...>-740       [044] d.... 18385.602860: sched_swit | kworker/44:1-740 [044] d.... 18385.602860: sched_swit

So the problem is the <..> being added?

> 
> And we can see that the saved_cmdlines in kernel was changed.
> 
> So Maybe there is no safe to use md5sum here to verify whether
> the file whether it has changed.
> 
> >From my point of view, we only need to verify traceoff event  
> is valid there.
> 
> Maybe it is enough to check first that the tracing_on equals 0,
> and then check that the total number of rows of trace does not
> increase?
> 
> Fixes: d87b29179aa0 ("selftests: ftrace: Use md5sum to take less time of checking logs")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> ---
>  .../test.d/ftrace/func_traceonoff_triggers.tc    | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> index aee22289536b..180c60605d7b 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> @@ -77,25 +77,17 @@ if [ $cnt -ne 1 ]; then
>     fail "Did not find traceoff trigger"
>  fi
>  
> -cnt=`cnt_trace`
> -sleep $SLEEP_TIME
> -cnt2=`cnt_trace`
> -
> -if [ $cnt -ne $cnt2 ]; then
> -   fail "Tracing is not stopped"
> -fi
> -
>  on=`cat tracing_on`
>  if [ $on != "0" ]; then
>      fail "Tracing is not off"
>  fi
>  
> -csum1=`md5sum trace`

What about just changing the above to:

 # Can not rely on names being around as they are only cached
 csum1=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`

> +cnt=`cnt_trace`
>  sleep $SLEEP_TIME
> -csum2=`md5sum trace`

And this:

 csum2=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`

That will strip off the names an leave just the -[PID]... part of the line?

-- Steve



> +cnt2=`cnt_trace`
>  
> -if [ "$csum1" != "$csum2" ]; then
> -    fail "Tracing file is still changing"
> +if [ $cnt -ne $cnt2 ]; then
> +   fail "Tracing is not stopped"
>  fi
>  
>  clear_trace

