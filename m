Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61FD7B8091
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391273AbfISSGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 14:06:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45444 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfISSGr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 14:06:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so2790432pfb.12
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2019 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Sobzv9mMmwyHTL/77CGxUAly3i0GF+w0SZx/OGK2OjM=;
        b=TkXEkbBrEowtEKwO3W3GnkBsOEWCzxbMzvOe2gqDUFbYaqWo/429ifbKFKQ0rTluiv
         4kCbj2hocco7PmhvTijy1Z/X+VIKnzxVPnIv45RsL9kaF9cDgRoEb5dfIne7hW41wNef
         xkQa864EQJaWCt1j2990j62oqA97/ncoeURIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Sobzv9mMmwyHTL/77CGxUAly3i0GF+w0SZx/OGK2OjM=;
        b=NgRmHxn3uT/+qRPFLik1JktclW9KXKaKCbpRNRrljv1sNIdowrVdhrbMf0ady4nbJi
         Fxk6X6CiKsews2t/w7D/Su5tx2bBS6TJeY8W3hpL6ky2aJ2crZehGULQq1AFDx34Pwm6
         W3kCTGiCFbGhWssEKBxv8e6Ov9TFCeajvRXrXQ4yLlAARBP06AJdoTaoaKAeoobHAZAg
         ylE7wIY0A68/9ee7pRsDC2YgcYLNVOmQqQwlOnPKsdiXlrZvJq2Ks81kSV1fy9Qdi+38
         eQAjHzwozYyPmkq9SZd0yznMFKoYip2NLfvZqs9bOeoYwq5xYK+ITkP92hQBo6mjUMAk
         F6oA==
X-Gm-Message-State: APjAAAWJKqeRcxxpbUQpGx50mJWwsy2CZ2637CTqoA3XakecRkLI4xe/
        7IOaF3MIt8XQTD9xzTIAMlenRA==
X-Google-Smtp-Source: APXvYqzPFbSiMV+6BfYIek+fSuv7Qfp4/5BwyPOkZ9DPR6Ube0lHZXKhnYPHjWcSEzGvdUAcPovmYg==
X-Received: by 2002:a17:90a:8c17:: with SMTP id a23mr4995014pjo.111.1568916406922;
        Thu, 19 Sep 2019 11:06:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u3sm11188753pfn.134.2019.09.19.11.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 11:06:46 -0700 (PDT)
Date:   Thu, 19 Sep 2019 11:06:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout per test
Message-ID: <201909191102.97FA56072@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
test") solves the problem of kselftest_harness.h-using binary tests
possibly hanging forever. However, scripts and other binaries can still
hang forever. This adds a global timeout to each test script run.

To make this configurable (e.g. as needed in the "rtc" test case),
include a new per-test-directory "settings" file (similar to "config")
that can contain kselftest-specific settings. The first recognized field
is "timeout".

Additionally, this splits the reporting for timeouts into a specific
"TIMEOUT" not-ok (and adds exit code reporting in the remaining case).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest/runner.sh | 36 +++++++++++++++++++--
 tools/testing/selftests/rtc/settings        |  1 +
 2 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/rtc/settings

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 00c9020bdda8..84de7bc74f2c 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -3,9 +3,14 @@
 #
 # Runs a set of tests in a given subdirectory.
 export skip_rc=4
+export timeout_rc=124
 export logfile=/dev/stdout
 export per_test_logging=
 
+# Defaults for "settings" file fields:
+# "timeout" how many seconds to let each test run before failing.
+export kselftest_default_timeout=45
+
 # There isn't a shell-agnostic way to find the path of a sourced file,
 # so we must rely on BASE_DIR being set to find other tools.
 if [ -z "$BASE_DIR" ]; then
@@ -24,6 +29,16 @@ tap_prefix()
 	fi
 }
 
+tap_timeout()
+{
+	# Make sure tests will time out if utility is available.
+	if [ -x /usr/bin/timeout ] ; then
+		/usr/bin/timeout "$kselftest_timeout" "$1"
+	else
+		"$1"
+	fi
+}
+
 run_one()
 {
 	DIR="$1"
@@ -32,6 +47,18 @@ run_one()
 
 	BASENAME_TEST=$(basename $TEST)
 
+	# Reset any "settings"-file variables.
+	export kselftest_timeout="$kselftest_default_timeout"
+	# Load per-test-directory kselftest "settings" file.
+	settings="$BASE_DIR/$DIR/settings"
+	if [ -r "$settings" ] ; then
+		while read line ; do
+			field=$(echo "$line" | cut -d= -f1)
+			value=$(echo "$line" | cut -d= -f2-)
+			eval "kselftest_$field"="$value"
+		done < "$settings"
+	fi
+
 	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "# $TEST_HDR_MSG"
 	if [ ! -x "$TEST" ]; then
@@ -44,14 +71,17 @@ run_one()
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
 		cd `dirname $TEST` > /dev/null
-		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
+		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
-		(if [ $? -eq $skip_rc ]; then	\
+		(rc=$?;	\
+		if [ $rc -eq $skip_rc ]; then	\
 			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
+		elif [ $rc -eq $timeout_rc ]; then \
+			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
 		else
-			echo "not ok $test_num $TEST_HDR_MSG"
+			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
 		fi)
 		cd - >/dev/null
 	fi
diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
new file mode 100644
index 000000000000..ba4d85f74cd6
--- /dev/null
+++ b/tools/testing/selftests/rtc/settings
@@ -0,0 +1 @@
+timeout=90
-- 
2.17.1


-- 
Kees Cook
