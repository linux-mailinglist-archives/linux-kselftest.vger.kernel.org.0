Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344886AC5DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 16:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCFPtB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 10:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCFPtA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 10:49:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75525EFB1;
        Mon,  6 Mar 2023 07:48:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BADA3B80EB6;
        Mon,  6 Mar 2023 15:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72E5C4339C;
        Mon,  6 Mar 2023 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678116918;
        bh=E1zhjZsDqXu7ZcjyxWAVSvVSVDz46CeGhHGsz7thqLI=;
        h=From:Date:Subject:To:Cc:From;
        b=hlTmLm7y8VUxMPt3pQ2B4PM7gP7qLLiK9VgfvLrfs+ib0At9J6chvKhAmk1T0wAxZ
         PHoJ0lwvKIKmsudt7jZ4cDJjbswtbWw57Ld7iucs5xLEvESdR7pvXthDkbKE5SLYLN
         +d/QwXrLMXv9xhioXq++cH2TN8dyUeUSA900ERAtH3TM8ZkiDSQZ0ofRM5GKDh8pDI
         XqrIa8P09N029Xuk1owE5NEpN6Baa1eCsH9wP5g8KSvFav02x34W1BRl2+IHGF/12k
         op6FM4S7lkrfdKf/oSYieLhMt98Y8a3BjJj7YZ6BeYhzHqFwtNNKROaaaxRQJbD0MM
         M0HRZCQz+aKXg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 06 Mar 2023 15:35:10 +0000
Subject: [PATCH] selftests/ftrace: Improve integration with kselftest
 runner
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230302-ftrace-kselftest-ktap-v1-1-a84a0765b7ad@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC0IBmQC/x2NQQqDMBAAvyJ77kKM2Gi/UjyscVMX2zRkQymIf
 2/scQaG2UE5Cyvcmh0yf0TlHSu0lwb8SvHBKEtlsMZ2pjMWQ8nkGTflZyisBbdCCcfFDW64jm3
 fO6jtTMo4Z4p+PevySqdNmYN8/7f7dBw/2Gm7Qn0AAAA=
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=7335; i=broonie@kernel.org;
 h=from:subject:message-id; bh=E1zhjZsDqXu7ZcjyxWAVSvVSVDz46CeGhHGsz7thqLI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBggzd4EQZ3hP+Sh8BpOa6YTt+Rb3/1RhhG8bpdMl
 397Zj6yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAYIMwAKCRAk1otyXVSH0F1xB/
 4woKElb4OOUeLfozI9QUnS1XAcTVHMM9KWK1/dAN51t7DpXa+ke2Uv2Kf/7PCz/fa0Fjb1rAWNG6x4
 6OyO5U7kW/l2WjWk8DTTg/xxRhuIlQlEdU2fEouwR6qR5ZbzmiAnTEgh2O0KdwOIR58idPTWjqplKM
 Z/s80rUU0J1HB6EqgHybxnnbIZtBF87DcjAYkxYfMT9JbzoUwyr18QfRVxQtZDMJQAXjY6opok4+4d
 feevuhJWMpOCyYV5GsRyGZHn5Xspa8DhjfBjm26DMzDpPPTtflKyCgx5hGst3PXFFnbJAU4NyeYTLW
 b4Iyk4xhdssW4aTpIvu6xIEjuvNE4u
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The ftrace selftests do not currently produce KTAP output, they produce a
custom format much nicer for human consumption. This means that when run in
automated test systems we just get a single result for the suite as a whole
rather than recording results for individual test cases, making it harder
to look at the test data and masking things like inappropriate skips.

Address this by adding support for KTAP output to the ftracetest script and
providing a trivial wrapper which will be invoked by the kselftest runner
to generate output in this format by default, users using ftracetest
directly will continue to get the existing output.

This is not the most elegant solution but it is simple and effective. I
did consider implementing this by post processing the existing output
format but that felt more complex and likely to result in all output being
lost if something goes seriously wrong during the run which would not be
helpful. I did also consider just writing a separate runner script but
there's enough going on with things like the signal handling for that to
seem like it would be duplicating too much.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/ftrace/Makefile        |  3 +-
 tools/testing/selftests/ftrace/ftracetest      | 63 ++++++++++++++++++++++++--
 tools/testing/selftests/ftrace/ftracetest-ktap |  8 ++++
 3 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index d6e106fbce11..a1e955d2de4c 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 all:
 
-TEST_PROGS := ftracetest
+TEST_PROGS_EXTENDED := ftracetest
+TEST_PROGS := ftracetest-ktap
 TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index c3311c8c4089..539c8d6d5d71 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -13,6 +13,7 @@ echo "Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]"
 echo " Options:"
 echo "		-h|--help  Show help message"
 echo "		-k|--keep  Keep passed test logs"
+echo "		-K|--KTAP  Output in KTAP format"
 echo "		-v|--verbose Increase verbosity of test messages"
 echo "		-vv        Alias of -v -v (Show all results in stdout)"
 echo "		-vvv       Alias of -v -v -v (Show all commands immediately)"
@@ -85,6 +86,10 @@ parse_opts() { # opts
       KEEP_LOG=1
       shift 1
     ;;
+    --ktap|-K)
+      KTAP=1
+      shift 1
+    ;;
     --verbose|-v|-vv|-vvv)
       if [ $VERBOSE -eq -1 ]; then
 	usage "--console can not use with --verbose"
@@ -178,6 +183,7 @@ TEST_DIR=$TOP_DIR/test.d
 TEST_CASES=`find_testcases $TEST_DIR`
 LOG_DIR=$TOP_DIR/logs/`date +%Y%m%d-%H%M%S`/
 KEEP_LOG=0
+KTAP=0
 DEBUG=0
 VERBOSE=0
 UNSUPPORTED_RESULT=0
@@ -229,7 +235,7 @@ prlog() { # messages
     newline=
     shift
   fi
-  printf "$*$newline"
+  [ "$KTAP" != "1" ] && printf "$*$newline"
   [ "$LOG_FILE" ] && printf "$*$newline" | strip_esc >> $LOG_FILE
 }
 catlog() { #file
@@ -260,11 +266,11 @@ TOTAL_RESULT=0
 
 INSTANCE=
 CASENO=0
+CASENAME=
 
 testcase() { # testfile
   CASENO=$((CASENO+1))
-  desc=`grep "^#[ \t]*description:" $1 | cut -f2- -d:`
-  prlog -n "[$CASENO]$INSTANCE$desc"
+  CASENAME=`grep "^#[ \t]*description:" $1 | cut -f2- -d:`
 }
 
 checkreq() { # testfile
@@ -277,40 +283,68 @@ test_on_instance() { # testfile
   grep -q "^#[ \t]*flags:.*instance" $1
 }
 
+ktaptest() { # result comment
+  if [ "$KTAP" != "1" ]; then
+    return
+  fi
+
+  local result=
+  if [ "$1" = "1" ]; then
+    result="ok"
+  else
+    result="not ok"
+  fi
+  shift
+
+  local comment=$*
+  if [ "$comment" != "" ]; then
+    comment="# $comment"
+  fi
+
+  echo $CASENO $result $INSTANCE$CASENAME $comment
+}
+
 eval_result() { # sigval
   case $1 in
     $PASS)
       prlog "	[${color_green}PASS${color_reset}]"
+      ktaptest 1
       PASSED_CASES="$PASSED_CASES $CASENO"
       return 0
     ;;
     $FAIL)
       prlog "	[${color_red}FAIL${color_reset}]"
+      ktaptest 0
       FAILED_CASES="$FAILED_CASES $CASENO"
       return 1 # this is a bug.
     ;;
     $UNRESOLVED)
       prlog "	[${color_blue}UNRESOLVED${color_reset}]"
+      ktaptest 0 UNRESOLVED
       UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
       return $UNRESOLVED_RESULT # depends on use case
     ;;
     $UNTESTED)
       prlog "	[${color_blue}UNTESTED${color_reset}]"
+      ktaptest 1 SKIP
       UNTESTED_CASES="$UNTESTED_CASES $CASENO"
       return 0
     ;;
     $UNSUPPORTED)
       prlog "	[${color_blue}UNSUPPORTED${color_reset}]"
+      ktaptest 1 SKIP
       UNSUPPORTED_CASES="$UNSUPPORTED_CASES $CASENO"
       return $UNSUPPORTED_RESULT # depends on use case
     ;;
     $XFAIL)
       prlog "	[${color_green}XFAIL${color_reset}]"
+      ktaptest 1 XFAIL
       XFAILED_CASES="$XFAILED_CASES $CASENO"
       return 0
     ;;
     *)
       prlog "	[${color_blue}UNDEFINED${color_reset}]"
+      ktaptest 0 error
       UNDEFINED_CASES="$UNDEFINED_CASES $CASENO"
       return 1 # this must be a test bug
     ;;
@@ -371,6 +405,7 @@ __run_test() { # testfile
 run_test() { # testfile
   local testname=`basename $1`
   testcase $1
+  prlog -n "[$CASENO]$INSTANCE$CASENAME"
   if [ ! -z "$LOG_FILE" ] ; then
     local testlog=`mktemp $LOG_DIR/${CASENO}-${testname}-log.XXXXXX`
   else
@@ -405,6 +440,17 @@ run_test() { # testfile
 # load in the helper functions
 . $TEST_DIR/functions
 
+if [ "$KTAP" = "1" ]; then
+  echo "TAP version 13"
+
+  casecount=`echo $TEST_CASES | wc -w`
+  for t in $TEST_CASES; do
+    test_on_instance $t || continue
+    casecount=$((casecount+1))
+  done
+  echo "1..${casecount}"
+fi
+
 # Main loop
 for t in $TEST_CASES; do
   run_test $t
@@ -439,6 +485,17 @@ prlog "# of unsupported: " `echo $UNSUPPORTED_CASES | wc -w`
 prlog "# of xfailed: " `echo $XFAILED_CASES | wc -w`
 prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
 
+if [ "$KTAP" = "1" ]; then
+  echo -n "# Totals:"
+  echo -n " pass:"`echo $PASSED_CASES | wc -w`
+  echo -n " faii:"`echo $FAILED_CASES | wc -w`
+  echo -n " xfail:"`echo $XFAILED_CASES | wc -w`
+  echo -n " xpass:0"
+  echo -n " skip:"`echo $UNTESTED_CASES $UNSUPPORTED_CASES | wc -w`
+  echo -n " error:"`echo $UNRESOLVED_CASES $UNDEFINED_CASES | wc -w`
+  echo
+fi
+
 cleanup
 
 # if no error, return 0
diff --git a/tools/testing/selftests/ftrace/ftracetest-ktap b/tools/testing/selftests/ftrace/ftracetest-ktap
new file mode 100755
index 000000000000..b3284679ef3a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/ftracetest-ktap
@@ -0,0 +1,8 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ftracetest-ktap: Wrapper to integrate ftracetest with the kselftest runner
+#
+# Copyright (C) Arm Ltd., 2023
+
+./ftracetest -K

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230302-ftrace-kselftest-ktap-9d7878691557

Best regards,
-- 
Mark Brown <broonie@kernel.org>

