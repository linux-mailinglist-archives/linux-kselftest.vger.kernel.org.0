Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B05E79A0BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Sep 2023 02:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjIKAVP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 10 Sep 2023 20:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjIKAVP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 10 Sep 2023 20:21:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FA1125;
        Sun, 10 Sep 2023 17:21:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75760C433C7;
        Mon, 11 Sep 2023 00:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694391670;
        bh=seGEeW6xHTnJ7ViTCB9/tGNmeW9Z+shSBEYPh4w8L/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s6HxJ2xM3WjNraa4MmqjSPe/EuOlwCo63mg4MzSy9sUoDI4Q9ih47dTBLf/v9wVIF
         ii1SqaY8wXhM7ykKqEoQt4yqHqBVu+s35FncjhKjft1GTGxBjistEedrxAxES7pXXf
         t6iaZb6O7IELCfcQBCgcuB5I61U+40bXPRP8QCYAp6bLxHLPbxz/5aghMgD8dEIU94
         +eWH3yiU3bB3/XgA2ICbU6Uof5u4Ii+Ywbijp97Cf9MucxuTA7uPBsweUajmJnRLFt
         wmDwnYSDTWSkcEeujSLdOHxpacVP0o/u0mLzu8ibRsqQrWp+/acFbCiEfWIZkgwBg0
         RraPH738J8tpg==
Date:   Mon, 11 Sep 2023 09:21:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ftrace/selftests: Add softlink to latest log directory
Message-Id: <20230911092105.95425e2d773f79c9b3b4b94f@kernel.org>
In-Reply-To: <20230908181721.00f7eb71@gandalf.local.home>
References: <20230908181721.00f7eb71@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 8 Sep 2023 18:17:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> When I'm debugging something with the ftrace selftests and need to look at
> the logs, it becomes tedious that I need to do the following:
> 
>  ls -ltr logs
>  [ copy the last directory ]
>  ls logs/<paste-last-dir>
> 
> to see where the logs are.
> 
> Instead, do the common practice of having a "latest" softlink to the last
> run selftest. This way after running the selftest I only need to do:
> 
>  ls logs/latest/
> 
> and it will always give me the directory of the last run selftest logs!
> 

Nice! I like this and this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index cb5f18c06593..7df8baa0f98f 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -124,6 +124,7 @@ parse_opts() { # opts
>      ;;
>      --logdir|-l)
>        LOG_DIR=$2
> +      LINK_PTR=
>        shift 2
>      ;;
>      *.tc)
> @@ -181,7 +182,10 @@ fi
>  TOP_DIR=`absdir $0`
>  TEST_DIR=$TOP_DIR/test.d
>  TEST_CASES=`find_testcases $TEST_DIR`
> -LOG_DIR=$TOP_DIR/logs/`date +%Y%m%d-%H%M%S`/
> +LOG_TOP_DIR=$TOP_DIR/logs
> +LOG_DATE=`date +%Y%m%d-%H%M%S`
> +LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
> +LINK_PTR=$LOG_TOP_DIR/latest
>  KEEP_LOG=0
>  KTAP=0
>  DEBUG=0
> @@ -207,6 +211,10 @@ else
>    LOG_FILE=$LOG_DIR/ftracetest.log
>    mkdir -p $LOG_DIR || errexit "Failed to make a log directory: $LOG_DIR"
>    date > $LOG_FILE
> +  if [ "x-$LINK_PTR" != "x-" ]; then
> +    unlink $LINK_PTR
> +    ln -fs $LOG_DATE $LINK_PTR
> +  fi
>  fi
>  
>  # Define text colors


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
