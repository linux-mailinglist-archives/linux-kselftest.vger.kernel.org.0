Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E7782CFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjHUPNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjHUPNr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 11:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC3BC;
        Mon, 21 Aug 2023 08:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614B163852;
        Mon, 21 Aug 2023 15:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEBCC433C8;
        Mon, 21 Aug 2023 15:13:43 +0000 (UTC)
Date:   Mon, 21 Aug 2023 11:13:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     <mhiramat@kernel.org>, <shuah@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] selftests/ftrace: traceonoff_triggers: strip off
 names
Message-ID: <20230821111358.7540bdc9@gandalf.local.home>
In-Reply-To: <20230818013226.2182299-1-zouyipeng@huawei.com>
References: <20230818013226.2182299-1-zouyipeng@huawei.com>
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

On Fri, 18 Aug 2023 09:32:26 +0800
Yipeng Zou <zouyipeng@huawei.com> wrote:

> The func_traceonoff_triggers.tc sometimes goes to fail
> on my board, Kunpeng-920.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah, can you take this through your tree?

-- Steve

> 
> [root@localhost]# ./ftracetest ./test.d/ftrace/func_traceonoff_triggers.tc -l fail.log
> === Ftrace unit tests ===
> [1] ftrace - test for function traceon/off triggers     [FAIL]
> [2] (instance)  ftrace - test for function traceon/off triggers [UNSUPPORTED]
> 
> I look up the log, and it shows that the md5sum is different between csum1 and csum2.
> 
> ++ cnt=611
> ++ sleep .1
> +++ cnt_trace
> +++ grep -v '^#' trace
> +++ wc -l
> ++ cnt2=611
> ++ '[' 611 -ne 611 ']'
> +++ cat tracing_on
> ++ on=0
> ++ '[' 0 '!=' 0 ']'
> +++ md5sum trace
> ++ csum1='76896aa74362fff66a6a5f3cf8a8a500  trace'
> ++ sleep .1
> +++ md5sum trace
> ++ csum2='ee8625a21c058818fc26e45c1ed3f6de  trace'
> ++ '[' '76896aa74362fff66a6a5f3cf8a8a500  trace' '!=' 'ee8625a21c058818fc26e45c1ed3f6de  trace' ']'
> ++ fail 'Tracing file is still changing'
> ++ echo Tracing file is still changing
> Tracing file is still changing
> ++ exit_fail
> ++ exit 1
> 
> So I directly dump the trace file before md5sum, the diff shows that:
> 
> [root@localhost]# diff trace_1.log trace_2.log -y --suppress-common-lines
> dockerd-12285   [036] d.... 18385.510290: sched_stat | <...>-12285   [036] d.... 18385.510290: sched_stat
> dockerd-12285   [036] d.... 18385.510291: sched_swit | <...>-12285   [036] d.... 18385.510291: sched_swit
> <...>-740       [044] d.... 18385.602859: sched_stat | kworker/44:1-740 [044] d.... 18385.602859: sched_stat
> <...>-740       [044] d.... 18385.602860: sched_swit | kworker/44:1-740 [044] d.... 18385.602860: sched_swit
> 
> And we can see that <...> filed be filled with names.
> 
> We can strip off the names there to fix that.
> 
> After strip off the names:
> 
> kworker/u257:0-12 [019] d..2.  2528.758910: sched_stat | -12 [019] d..2.  2528.758910: sched_stat_runtime: comm=k
> kworker/u257:0-12 [019] d..2.  2528.758912: sched_swit | -12 [019] d..2.  2528.758912: sched_switch: prev_comm=kw
> <idle>-0          [000] d.s5.  2528.762318: sched_waki | -0  [000] d.s5.  2528.762318: sched_waking: comm=sshd pi
> <idle>-0          [037] dNh2.  2528.762326: sched_wake | -0  [037] dNh2.  2528.762326: sched_wakeup: comm=sshd pi
> <idle>-0          [037] d..2.  2528.762334: sched_swit | -0  [037] d..2.  2528.762334: sched_switch: prev_comm=sw
> 
> Fixes: d87b29179aa0 ("selftests: ftrace: Use md5sum to take less time of checking logs")
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/ftrace/func_traceonoff_triggers.tc         | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> index aee22289536b..1b57771dbfdf 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> @@ -90,9 +90,10 @@ if [ $on != "0" ]; then
>      fail "Tracing is not off"
>  fi
>  
> -csum1=`md5sum trace`
> +# Cannot rely on names being around as they are only cached, strip them
> +csum1=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
>  sleep $SLEEP_TIME
> -csum2=`md5sum trace`
> +csum2=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
>  
>  if [ "$csum1" != "$csum2" ]; then
>      fail "Tracing file is still changing"

