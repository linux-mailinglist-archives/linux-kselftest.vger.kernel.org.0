Return-Path: <linux-kselftest+bounces-8344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79C8A9E75
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886D81F23226
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAA016D327;
	Thu, 18 Apr 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2YttR71l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8241D16C84A;
	Thu, 18 Apr 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454283; cv=none; b=cv8bw77iSkn9Pn7owAT1JB0JWeYUhLeCcEYOjS5OAHHsU9k9TgSUG5uSTcDqTMvv0cG0txpM9e/wtfTZJS/cmOjT1+uaXVTS7CGpQ43ZFbYT06fRjxG+AOo9dzJ3yXityuBAqy7maoI4xJyae8FMODMVK8ciWXgo9XjpLQI7Eec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454283; c=relaxed/simple;
	bh=JuSoF/w8806XRpwQQcO6JP05+Jq2I3SdVOtm2SB0vRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oWYS6Def1z9+je0A+I9aVuCwkZY2T5dUwStYgX56YcB2HJhEUcsC/oJr1nGTZOhx6pgRuw+uPoHpsbX5sWUtkAdcVsoBk7EI/dH2F/wXf3MIcPgfgURRX7fwTwcrg4kiyqQAJXmiJgI2JHAI05jgVvF83rXttY4LZezU0yFX4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2YttR71l; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713454279;
	bh=JuSoF/w8806XRpwQQcO6JP05+Jq2I3SdVOtm2SB0vRQ=;
	h=From:To:Cc:Subject:Date:From;
	b=2YttR71lcYfTYNxL1JnRrfB3PGpymI0znps3FXAoT2lCUuN5gNDijebmmMWg9PjHe
	 z1Jd95s8lOMNLWz3msoGwSD2F94M96lxQlquM8h724515gYwfeHZ3l4mrIyD+ggj7p
	 pochh//OUkslB7q1kWK9UiMOO6dat8iqNqZtBH/qHHgBWVSgQsG7476kT8/jWxbv5c
	 YyYxFoE7X73RlU1+fWlHXelL52kOXinBNXJqYOA0YDuDvAXjWya6T17vgG2GcvbdET
	 NlduIQaoKnJuvKKMTR30V3Thb77IwV+vXDVww3yMzWm/kZnkWCFGJ5TXGnSEGlaV9Z
	 Xo5G5QL4y9LIQ==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 48EDE3782117;
	Thu, 18 Apr 2024 15:31:17 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: cpufreq: conform test to TAP
Date: Thu, 18 Apr 2024 20:31:45 +0500
Message-Id: <20240418153146.2095230-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test outputs lots of information. Let's conform the core part of
the test to TAP and leave the information printing messages for now.
Include ktap_helpers.sh to print conformed logs. Use KSFT_* macros to
return the correct exit code for the kselftest framework and CIs to
understand the exit status.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/cpufreq/cpufreq.sh |  3 +-
 tools/testing/selftests/cpufreq/main.sh    | 47 +++++++++++++---------
 tools/testing/selftests/cpufreq/module.sh  |  6 +--
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
index b583a2fb45042..a8b1dbc0a3a5b 100755
--- a/tools/testing/selftests/cpufreq/cpufreq.sh
+++ b/tools/testing/selftests/cpufreq/cpufreq.sh
@@ -178,8 +178,7 @@ cpufreq_basic_tests()
 
 	count=$(count_cpufreq_managed_cpus)
 	if [ $count = 0 ]; then
-		printf "No cpu is managed by cpufreq core, exiting\n"
-		exit;
+		ktap_exit_fail_msg "No cpu is managed by cpufreq core, exiting\n"
 	else
 		printf "CPUFreq manages: $count CPUs\n\n"
 	fi
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index 60ce18ed06660..a0eb84cf7167f 100755
--- a/tools/testing/selftests/cpufreq/main.sh
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -7,15 +7,15 @@ source governor.sh
 source module.sh
 source special-tests.sh
 
+DIR="$(dirname $(readlink -f "$0"))"
+source "${DIR}"/../kselftest/ktap_helpers.sh
+
 FUNC=basic	# do basic tests by default
 OUTFILE=cpufreq_selftest
 SYSFS=
 CPUROOT=
 CPUFREQROOT=
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
 helpme()
 {
 	printf "Usage: $0 [-h] [-todg args]
@@ -32,7 +32,7 @@ helpme()
 	[-d <driver's module name: only with \"-t modtest>\"]
 	[-g <governor's module name: only with \"-t modtest>\"]
 	\n"
-	exit 2
+	exit "${KSFT_FAIL}"
 }
 
 prerequisite()
@@ -40,8 +40,8 @@ prerequisite()
 	msg="skip all tests:"
 
 	if [ $UID != 0 ]; then
-		echo $msg must be run as root >&2
-		exit $ksft_skip
+		ktap_skip_all "$msg must be run as root"
+		exit "${KSFT_SKIP}"
 	fi
 
 	taskset -p 01 $$
@@ -49,21 +49,21 @@ prerequisite()
 	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
 
 	if [ ! -d "$SYSFS" ]; then
-		echo $msg sysfs is not mounted >&2
-		exit 2
+		ktap_skip_all "$msg sysfs is not mounted"
+		exit "${KSFT_SKIP}"
 	fi
 
 	CPUROOT=$SYSFS/devices/system/cpu
 	CPUFREQROOT="$CPUROOT/cpufreq"
 
 	if ! ls $CPUROOT/cpu* > /dev/null 2>&1; then
-		echo $msg cpus not available in sysfs >&2
-		exit 2
+		ktap_skip_all "$msg cpus not available in sysfs"
+		exit "${KSFT_SKIP}"
 	fi
 
 	if ! ls $CPUROOT/cpufreq > /dev/null 2>&1; then
-		echo $msg cpufreq directory not available in sysfs >&2
-		exit 2
+		ktap_skip_all "$msg cpufreq directory not available in sysfs"
+		exit "${KSFT_SKIP}"
 	fi
 }
 
@@ -105,8 +105,7 @@ do_test()
 	count=$(count_cpufreq_managed_cpus)
 
 	if [ $count = 0 -a $FUNC != "modtest" ]; then
-		echo "No cpu is managed by cpufreq core, exiting"
-		exit 2;
+		ktap_exit_fail_msg "No cpu is managed by cpufreq core, exiting"
 	fi
 
 	case "$FUNC" in
@@ -125,8 +124,7 @@ do_test()
 		"modtest")
 		# Do we have modules in place?
 		if [ -z $DRIVER_MOD ] && [ -z $GOVERNOR_MOD ]; then
-			echo "No driver or governor module passed with -d or -g"
-			exit 2;
+			ktap_exit_fail_msg "No driver or governor module passed with -d or -g"
 		fi
 
 		if [ $DRIVER_MOD ]; then
@@ -137,8 +135,7 @@ do_test()
 			fi
 		else
 			if [ $count = 0 ]; then
-				echo "No cpu is managed by cpufreq core, exiting"
-				exit 2;
+				ktap_exit_fail_msg "No cpu is managed by cpufreq core, exiting"
 			fi
 
 			module_governor_test $GOVERNOR_MOD
@@ -162,7 +159,7 @@ do_test()
 		;;
 
 		*)
-		echo "Invalid [-f] function type"
+		ktap_print_msg "Invalid [-f] function type"
 		helpme
 		;;
 	esac
@@ -186,13 +183,25 @@ dmesg_dumps()
 	dmesg >> $1.dmesg_full.txt
 }
 
+ktap_print_header
+
 # Parse arguments
 parse_arguments $@
 
+ktap_set_plan 1
+
 # Make sure all requirements are met
 prerequisite
 
 # Run requested functions
 clear_dumps $OUTFILE
 do_test | tee -a $OUTFILE.txt
+if [ "${PIPESTATUS[0]}" -ne 0 ]; then
+    exit ${PIPESTATUS[0]};
+fi
 dmesg_dumps $OUTFILE
+
+ktap_test_pass "Completed successfully"
+
+ktap_print_totals
+exit "${KSFT_PASS}"
diff --git a/tools/testing/selftests/cpufreq/module.sh b/tools/testing/selftests/cpufreq/module.sh
index 22563cd122e7d..7f2667e0ae2da 100755
--- a/tools/testing/selftests/cpufreq/module.sh
+++ b/tools/testing/selftests/cpufreq/module.sh
@@ -24,16 +24,14 @@ test_basic_insmod_rmmod()
 	# insert module
 	insmod $1
 	if [ $? != 0 ]; then
-		printf "Insmod $1 failed\n"
-		exit;
+		ktap_exit_fail_msg "Insmod $1 failed\n"
 	fi
 
 	printf "Removing $1 module\n"
 	# remove module
 	rmmod $1
 	if [ $? != 0 ]; then
-		printf "rmmod $1 failed\n"
-		exit;
+		ktap_exit_fail_msg "rmmod $1 failed\n"
 	fi
 
 	printf "\n"
-- 
2.39.2


