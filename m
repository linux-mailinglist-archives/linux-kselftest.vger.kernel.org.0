Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B1D77F02C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 07:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347972AbjHQFQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 01:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347999AbjHQFQK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 01:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9BE2705;
        Wed, 16 Aug 2023 22:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9973C61015;
        Thu, 17 Aug 2023 05:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E95C433C8;
        Thu, 17 Aug 2023 05:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692249368;
        bh=a2iRAas6aW2fTEoNcwlIES30xEK+G7ikVk9QkXpcco0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O6VfRCpHPEZfDU5qwLAxev8EwaSMJ3Mk2VPaIyuQZOHGxj1fbtIMvVICWuEzC31Z1
         tkQtQV38s0KKJyqkyoN5CisI7WI5bPFXaqOsHL4uE4FrVEqlWM5gSpno1hT2zw0EBu
         92MRn8L8KSKBAJRS3lx0sRnTerRYOO1tJIpmpOsDU3aXx22mbDfaOYeaJBG8xnJ4qO
         IlwqraYW5KijVBOlnnNOL5ri3b1qGz5wACyIBFqGDnVdjmxaL4VAjxWK2r1q5V008+
         nwDm9LJbflD1+rLUtYc16UM37r6e/qfE9XaEUL8y7HoD9l+8v8otOlio21fD38bEdU
         yVbG4UKfomzxQ==
Date:   Thu, 17 Aug 2023 14:16:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     <rostedt@goodmis.org>, <shuah@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] selftests/ftrace: traceonoff_triggers: strip off
 names
Message-Id: <20230817141603.7815300ef7a15df1872bb603@kernel.org>
In-Reply-To: <20230817025028.3953490-1-zouyipeng@huawei.com>
References: <20230817025028.3953490-1-zouyipeng@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 17 Aug 2023 10:50:28 +0800
Yipeng Zou <zouyipeng@huawei.com> wrote:

> The func_traceonoff_triggers.tc sometimes goes to fail
> on my board, Kunpeng-920.
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

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Fixes: d87b29179aa0 ("selftests: ftrace: Use md5sum to take less time of checking logs")
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> ---
>  .../ftrace/test.d/ftrace/func_traceonoff_triggers.tc          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> index aee22289536b..c5783999582d 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> @@ -90,9 +90,9 @@ if [ $on != "0" ]; then
>      fail "Tracing is not off"
>  fi
>  
> -csum1=`md5sum trace`
> +csum1=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
>  sleep $SLEEP_TIME
> -csum2=`md5sum trace`
> +csum2=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
>  
>  if [ "$csum1" != "$csum2" ]; then
>      fail "Tracing file is still changing"
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
