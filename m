Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B276466529
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 15:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbhLBOYs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 09:24:48 -0500
Received: from foss.arm.com ([217.140.110.172]:35902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240661AbhLBOYs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 09:24:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4841213D5;
        Thu,  2 Dec 2021 06:21:25 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56EC93F766;
        Thu,  2 Dec 2021 06:21:24 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sjpark@amazon.de, keescook@chromium.org, shuah@kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] selftests/kselftest/runner.sh: Add optional command parameters in settings
Date:   Thu,  2 Dec 2021 14:20:56 +0000
Message-Id: <20211202142056.17386-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some testcases allow for optional commandline parameters but as of now
there is now way to provide such arguments to the runner script.

Add support to the per-test-directory "settings" file to provide such
optional arguments; two new optional fields can now be defined in
"settings":

 - args="<options>": general arguments common to all testcase commands in
   the test directory

 - <BASENAME_TEST>_args="<options>": custom arguments specific to only one
   specific testcase command

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Used to configure the use of a specific rtc device on CI systems with:
 tools/testing/selftests/rtc/settings:
   timeout=90
   rtctest_args="/dev/rtc1"
---
 tools/testing/selftests/kselftest/runner.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index a9ba782d8ca0..f877a8571927 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -49,6 +49,15 @@ run_one()
 
 	# Reset any "settings"-file variables.
 	export kselftest_timeout="$kselftest_default_timeout"
+
+	# Optional arguments for any command, possibly defined in settings
+	# as args="<options>"
+	kselftest_args=""
+
+	# Optional arguments for this command, possibly defined in settings
+	# as <$BASENAME_TEST>_args="<options>"
+	kselftest_cmd_args_ref="kselftest_${BASENAME_TEST}_args"
+
 	# Load per-test-directory kselftest "settings" file.
 	settings="$BASE_DIR/$DIR/settings"
 	if [ -r "$settings" ] ; then
@@ -69,7 +78,8 @@ run_one()
 		echo "# Warning: file $TEST is missing!"
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
-		cmd="./$BASENAME_TEST"
+		eval kselftest_cmd_args="\$$kselftest_cmd_args_ref"
+		cmd="./$BASENAME_TEST $kselftest_cmd_args $kselftest_args"
 		if [ ! -x "$TEST" ]; then
 			echo "# Warning: file $TEST is not executable"
 
-- 
2.17.1

