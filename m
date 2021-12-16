Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400A64771A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 13:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhLPMZu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 07:25:50 -0500
Received: from foss.arm.com ([217.140.110.172]:42920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236461AbhLPMZt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 07:25:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9201F1435;
        Thu, 16 Dec 2021 04:25:48 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3CD3F73B;
        Thu, 16 Dec 2021 04:25:47 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sjpark@amazon.de, keescook@chromium.org, shuah@kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3] selftests/kselftest/runner.sh: Pass optional command parameters in environment
Date:   Thu, 16 Dec 2021 12:25:32 +0000
Message-Id: <20211216122532.40744-1-cristian.marussi@arm.com>
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

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- improved varname sanitation
v1 --> v2
- using env vars instead of settings file
- added missing varname sanitation

Used to configure tests as in:

	rtctest --> KSELFTEST_RTCTEST_ARGS="/dev/rtc1"

	cpu-on-off-test.sh --> KSELFTEST_CPU_ON_OFF_TEST_SH_ARGS="-a -p 10"
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

