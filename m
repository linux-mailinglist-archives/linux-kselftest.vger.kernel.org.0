Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6926BFC67
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Mar 2023 20:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCRT2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Mar 2023 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRT2G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Mar 2023 15:28:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F56A58;
        Sat, 18 Mar 2023 12:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00EED60AE2;
        Sat, 18 Mar 2023 19:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1FAC4339C;
        Sat, 18 Mar 2023 19:27:58 +0000 (UTC)
Date:   Sat, 18 Mar 2023 15:27:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Improve integration with kselftest
 runner
Message-ID: <20230318152756.13600e98@rorschach.local.home>
In-Reply-To: <20230302-ftrace-kselftest-ktap-v1-1-a84a0765b7ad@kernel.org>
References: <20230302-ftrace-kselftest-ktap-v1-1-a84a0765b7ad@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 06 Mar 2023 15:35:10 +0000
Mark Brown <broonie@kernel.org> wrote:

> The ftrace selftests do not currently produce KTAP output, they produce a
> custom format much nicer for human consumption. This means that when run in
> automated test systems we just get a single result for the suite as a whole
> rather than recording results for individual test cases, making it harder
> to look at the test data and masking things like inappropriate skips.
> 
> Address this by adding support for KTAP output to the ftracetest script and
> providing a trivial wrapper which will be invoked by the kselftest runner
> to generate output in this format by default, users using ftracetest
> directly will continue to get the existing output.
> 
> This is not the most elegant solution but it is simple and effective. I
> did consider implementing this by post processing the existing output
> format but that felt more complex and likely to result in all output being
> lost if something goes seriously wrong during the run which would not be
> helpful. I did also consider just writing a separate runner script but
> there's enough going on with things like the signal handling for that to
> seem like it would be duplicating too much.
> 

This looks all OK to me, but I would feel more comfortable if Masami
acks it, as he's written most of the selftests.

Shuah, could you take this after Masami gives his ack?

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/ftrace/Makefile        |  3 +-
>  tools/testing/selftests/ftrace/ftracetest      | 63 ++++++++++++++++++++++++--
>  tools/testing/selftests/ftrace/ftracetest-ktap |  8 ++++
>  3 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
> index d6e106fbce11..a1e955d2de4c 100644
> --- a/tools/testing/selftests/ftrace/Makefile
> +++ b/tools/testing/selftests/ftrace/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  all:
>  
> -TEST_PROGS := ftracetest
> +TEST_PROGS_EXTENDED := ftracetest
> +TEST_PROGS := ftracetest-ktap
>  TEST_FILES := test.d settings
>  EXTRA_CLEAN := $(OUTPUT)/logs/*
>  
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index c3311c8c4089..539c8d6d5d71 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -13,6 +13,7 @@ echo "Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]"
>  echo " Options:"
>  echo "		-h|--help  Show help message"
>  echo "		-k|--keep  Keep passed test logs"
> +echo "		-K|--KTAP  Output in KTAP format"
>  echo "		-v|--verbose Increase verbosity of test messages"
>  echo "		-vv        Alias of -v -v (Show all results in stdout)"
>  echo "		-vvv       Alias of -v -v -v (Show all commands immediately)"
> @@ -85,6 +86,10 @@ parse_opts() { # opts
>        KEEP_LOG=1
>        shift 1
>      ;;
> +    --ktap|-K)
> +      KTAP=1
> +      shift 1
> +    ;;
>      --verbose|-v|-vv|-vvv)
>        if [ $VERBOSE -eq -1 ]; then
>  	usage "--console can not use with --verbose"
> @@ -178,6 +183,7 @@ TEST_DIR=$TOP_DIR/test.d
>  TEST_CASES=`find_testcases $TEST_DIR`
>  LOG_DIR=$TOP_DIR/logs/`date +%Y%m%d-%H%M%S`/
>  KEEP_LOG=0
> +KTAP=0
>  DEBUG=0
>  VERBOSE=0
>  UNSUPPORTED_RESULT=0
> @@ -229,7 +235,7 @@ prlog() { # messages
>      newline=
>      shift
>    fi
> -  printf "$*$newline"
> +  [ "$KTAP" != "1" ] && printf "$*$newline"
>    [ "$LOG_FILE" ] && printf "$*$newline" | strip_esc >> $LOG_FILE
>  }
>  catlog() { #file
> @@ -260,11 +266,11 @@ TOTAL_RESULT=0
>  
>  INSTANCE=
>  CASENO=0
> +CASENAME=
>  
>  testcase() { # testfile
>    CASENO=$((CASENO+1))
> -  desc=`grep "^#[ \t]*description:" $1 | cut -f2- -d:`
> -  prlog -n "[$CASENO]$INSTANCE$desc"
> +  CASENAME=`grep "^#[ \t]*description:" $1 | cut -f2- -d:`
>  }
>  
>  checkreq() { # testfile
> @@ -277,40 +283,68 @@ test_on_instance() { # testfile
>    grep -q "^#[ \t]*flags:.*instance" $1
>  }
>  
> +ktaptest() { # result comment
> +  if [ "$KTAP" != "1" ]; then
> +    return
> +  fi
> +
> +  local result=
> +  if [ "$1" = "1" ]; then
> +    result="ok"
> +  else
> +    result="not ok"
> +  fi
> +  shift
> +
> +  local comment=$*
> +  if [ "$comment" != "" ]; then
> +    comment="# $comment"
> +  fi
> +
> +  echo $CASENO $result $INSTANCE$CASENAME $comment
> +}
> +
>  eval_result() { # sigval
>    case $1 in
>      $PASS)
>        prlog "	[${color_green}PASS${color_reset}]"
> +      ktaptest 1
>        PASSED_CASES="$PASSED_CASES $CASENO"
>        return 0
>      ;;
>      $FAIL)
>        prlog "	[${color_red}FAIL${color_reset}]"
> +      ktaptest 0
>        FAILED_CASES="$FAILED_CASES $CASENO"
>        return 1 # this is a bug.
>      ;;
>      $UNRESOLVED)
>        prlog "	[${color_blue}UNRESOLVED${color_reset}]"
> +      ktaptest 0 UNRESOLVED
>        UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
>        return $UNRESOLVED_RESULT # depends on use case
>      ;;
>      $UNTESTED)
>        prlog "	[${color_blue}UNTESTED${color_reset}]"
> +      ktaptest 1 SKIP
>        UNTESTED_CASES="$UNTESTED_CASES $CASENO"
>        return 0
>      ;;
>      $UNSUPPORTED)
>        prlog "	[${color_blue}UNSUPPORTED${color_reset}]"
> +      ktaptest 1 SKIP
>        UNSUPPORTED_CASES="$UNSUPPORTED_CASES $CASENO"
>        return $UNSUPPORTED_RESULT # depends on use case
>      ;;
>      $XFAIL)
>        prlog "	[${color_green}XFAIL${color_reset}]"
> +      ktaptest 1 XFAIL
>        XFAILED_CASES="$XFAILED_CASES $CASENO"
>        return 0
>      ;;
>      *)
>        prlog "	[${color_blue}UNDEFINED${color_reset}]"
> +      ktaptest 0 error
>        UNDEFINED_CASES="$UNDEFINED_CASES $CASENO"
>        return 1 # this must be a test bug
>      ;;
> @@ -371,6 +405,7 @@ __run_test() { # testfile
>  run_test() { # testfile
>    local testname=`basename $1`
>    testcase $1
> +  prlog -n "[$CASENO]$INSTANCE$CASENAME"
>    if [ ! -z "$LOG_FILE" ] ; then
>      local testlog=`mktemp $LOG_DIR/${CASENO}-${testname}-log.XXXXXX`
>    else
> @@ -405,6 +440,17 @@ run_test() { # testfile
>  # load in the helper functions
>  . $TEST_DIR/functions
>  
> +if [ "$KTAP" = "1" ]; then
> +  echo "TAP version 13"
> +
> +  casecount=`echo $TEST_CASES | wc -w`
> +  for t in $TEST_CASES; do
> +    test_on_instance $t || continue
> +    casecount=$((casecount+1))
> +  done
> +  echo "1..${casecount}"
> +fi
> +
>  # Main loop
>  for t in $TEST_CASES; do
>    run_test $t
> @@ -439,6 +485,17 @@ prlog "# of unsupported: " `echo $UNSUPPORTED_CASES | wc -w`
>  prlog "# of xfailed: " `echo $XFAILED_CASES | wc -w`
>  prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
>  
> +if [ "$KTAP" = "1" ]; then
> +  echo -n "# Totals:"
> +  echo -n " pass:"`echo $PASSED_CASES | wc -w`
> +  echo -n " faii:"`echo $FAILED_CASES | wc -w`
> +  echo -n " xfail:"`echo $XFAILED_CASES | wc -w`
> +  echo -n " xpass:0"
> +  echo -n " skip:"`echo $UNTESTED_CASES $UNSUPPORTED_CASES | wc -w`
> +  echo -n " error:"`echo $UNRESOLVED_CASES $UNDEFINED_CASES | wc -w`
> +  echo
> +fi
> +
>  cleanup
>  
>  # if no error, return 0
> diff --git a/tools/testing/selftests/ftrace/ftracetest-ktap b/tools/testing/selftests/ftrace/ftracetest-ktap
> new file mode 100755
> index 000000000000..b3284679ef3a
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/ftracetest-ktap
> @@ -0,0 +1,8 @@
> +#!/bin/sh -e
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# ftracetest-ktap: Wrapper to integrate ftracetest with the kselftest runner
> +#
> +# Copyright (C) Arm Ltd., 2023
> +
> +./ftracetest -K
> 
> ---
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> change-id: 20230302-ftrace-kselftest-ktap-9d7878691557
> 
> Best regards,

