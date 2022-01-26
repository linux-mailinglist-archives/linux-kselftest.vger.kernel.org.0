Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A7949C7A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 11:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiAZKcw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 05:32:52 -0500
Received: from foss.arm.com ([217.140.110.172]:58250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240029AbiAZKco (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 05:32:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 251C91FB;
        Wed, 26 Jan 2022 02:32:44 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02A9D3F766;
        Wed, 26 Jan 2022 02:32:42 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Cristian Marussi <cristian.marussi@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v4] selftests/kselftest/runner.sh: Pass optional command parameters in environment
Date:   Wed, 26 Jan 2022 10:32:30 +0000
Message-Id: <20220126103230.35285-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some testcases allow for optional commandline parameters but as of now
there is now way to provide such arguments to the runner script.

Add support to retrieve such optional command parameters fron environment
variables named so as to include the all-uppercase test executable name,
sanitized substituting any non-acceptable varname characters with "_",
following the pattern:

	KSELFTEST_<UPPERCASE_SANITIZED_TEST_NAME>_ARGS="options"

Optional command parameters support is not available if 'tr' is not
installed on the test system.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- rebased on v5.17-rc1
v2 --> v3
- improved varname sanitation
v1 --> v2
- using env vars instead of settings file
- added missing varname sanitation

Usage examples:

	KSELFTEST_RTCTEST_ARGS="/dev/rtc1" /opt/ksft_fixes/run_kselftest.sh -c rtc

	KSELFTEST_CPU_ON_OFF_TEST_SH_ARGS="-a -p 10" /opt/ksft_fixes/run_kselftest.sh -c cpu-hotplug
---
 tools/testing/selftests/kselftest/runner.sh | 30 ++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index a9ba782d8ca0..294619ade49f 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -18,6 +18,8 @@ if [ -z "$BASE_DIR" ]; then
 	exit 1
 fi
 
+TR_CMD=$(command -v tr)
+
 # If Perl is unavailable, we must fall back to line-at-a-time prefixing
 # with sed instead of unbuffered output.
 tap_prefix()
@@ -49,6 +51,31 @@ run_one()
 
 	# Reset any "settings"-file variables.
 	export kselftest_timeout="$kselftest_default_timeout"
+
+	# Safe default if tr not available
+	kselftest_cmd_args_ref="KSELFTEST_ARGS"
+
+	# Optional arguments for this command, possibly defined as an
+	# environment variable built using the test executable in all
+	# uppercase and sanitized substituting non acceptable shell
+	# variable name characters with "_" as in:
+	#
+	# 	KSELFTEST_<UPPERCASE_SANITIZED_TESTNAME>_ARGS="<options>"
+	#
+	# e.g.
+	#
+	# 	rtctest --> KSELFTEST_RTCTEST_ARGS="/dev/rtc1"
+	#
+	# 	cpu-on-off-test.sh --> KSELFTEST_CPU_ON_OFF_TEST_SH_ARGS="-a -p 10"
+	#
+	if [ -n "$TR_CMD" ]; then
+		BASENAME_SANITIZED=$(echo "$BASENAME_TEST" | \
+					$TR_CMD -d "[:blank:][:cntrl:]" | \
+					$TR_CMD -c "[:alnum:]_" "_" | \
+					$TR_CMD [:lower:] [:upper:])
+		kselftest_cmd_args_ref="KSELFTEST_${BASENAME_SANITIZED}_ARGS"
+	fi
+
 	# Load per-test-directory kselftest "settings" file.
 	settings="$BASE_DIR/$DIR/settings"
 	if [ -r "$settings" ] ; then
@@ -69,7 +96,8 @@ run_one()
 		echo "# Warning: file $TEST is missing!"
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
-		cmd="./$BASENAME_TEST"
+		eval kselftest_cmd_args="\$${kselftest_cmd_args_ref:-}"
+		cmd="./$BASENAME_TEST $kselftest_cmd_args"
 		if [ ! -x "$TEST" ]; then
 			echo "# Warning: file $TEST is not executable"
 
-- 
2.17.1

