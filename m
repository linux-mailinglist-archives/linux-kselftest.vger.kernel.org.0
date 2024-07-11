Return-Path: <linux-kselftest+bounces-13581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF81E92E7FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D550282AE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6979615B11D;
	Thu, 11 Jul 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fHTEuUOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11E1459E3;
	Thu, 11 Jul 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699851; cv=none; b=jYvrtRA5vN0Kc0pgnuqZltdsWjE/GTxeKdIAMqZCXXiAbYiXnXVRK61Sp+15wMKp9HEoTIJTDS2lGvoYb1yEiJ3Hzf9JYDh0OzzQgc4BLsih18IfesN7aXDHjjAnolp8flLJO7RlOBMUaXURIEuZ0yNgI8zo2MPyRpcIvianm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699851; c=relaxed/simple;
	bh=XJwBrfIcWqjEPYahjyYBt4DTy6v62wPnyh8cd2LRczw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WpEIM/IVO0lveeR1Vh7cVO7eCOR/zkihJ7L1g0AZbKVXv5ycSSmLs1qOcvwUY2bHEGzp8BM6WLP6nthZzQXo9PCadZkEUHCUZoObJxRRmk83daQn6AqOd/LjRbuA8c4jhzfNSr+O24+AtHfjy3Di7eJhjbbK6bhwPHxEELVsSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fHTEuUOv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720699848;
	bh=XJwBrfIcWqjEPYahjyYBt4DTy6v62wPnyh8cd2LRczw=;
	h=From:To:Cc:Subject:Date:From;
	b=fHTEuUOvUidwBEshRx8+oT12TKqyvganJ1dmVNZ5X63+aNrAQ0ENfIdsD48KEsLq1
	 vqIASHgM7OmxMsEdS64bEDov74nHX6F7GtLaEG5n7ryS50TAe/Ud5q39U4ZgIFeqh9
	 ulkoKhDaOV+cjKBFBZoIDE5ZJqipa4m1qC818o8ky4MBU8DskODNN+C8Pw1limtHts
	 +mQ1m4G7mHQk7JmnbkhGSt67+jAB3Arkzbz2xr/GPlPt7Dx5g4xYKNGLXCxz8Pra5z
	 wivHG1QdoCaVWgr6BzRiLHuQI73N7layJ3JwhHsOgUFjW6yXp9PrIXZUSsmNf45m9C
	 10+hYQDVgQQiA==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D103237812FA;
	Thu, 11 Jul 2024 12:10:45 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] kselftest: cpufreq: Add RTC wakeup alarm
Date: Thu, 11 Jul 2024 17:40:33 +0530
Message-Id: <20240711121033.3569948-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RTC wakeup alarm for devices to resume after specific time interval.
This improvement in the test will help in enabling this test
in the CI systems and will eliminate the need of manual intervention
for resuming back the devices after suspend/hibernation.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 tools/testing/selftests/cpufreq/cpufreq.sh | 24 ++++++++++++++++++++++
 tools/testing/selftests/cpufreq/main.sh    | 13 +++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
index a8b1dbc0a3a5..a0f5b944a8fe 100755
--- a/tools/testing/selftests/cpufreq/cpufreq.sh
+++ b/tools/testing/selftests/cpufreq/cpufreq.sh
@@ -231,6 +231,30 @@ do_suspend()
 
 		for i in `seq 1 $2`; do
 			printf "Starting $1\n"
+
+			if [ "$3" = "rtc" ]; then
+				now=$(date +%s)
+				wakeup_time=$((now + 15)) # Wake up after 15 seconds
+
+				echo $wakeup_time > /sys/class/rtc/rtc0/wakealarm
+
+				if [ $? -ne 0 ]; then
+					printf "Failed to set RTC wake alarm\n"
+					return 1
+				fi
+
+				# Enable the RTC as a wakeup source
+				echo enabled > /sys/class/rtc/rtc0/device/power/wakeup
+
+				if [ $? -ne 0 ]; then
+					printf "Failed to set RTC wake alarm\n"
+					return 1
+				fi
+
+				# Reset the wakeup alarm
+				echo 0 > /sys/class/rtc/rtc0/wakealarm
+			fi
+
 			echo $filename > $SYSFS/power/state
 			printf "Came out of $1\n"
 
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index a0eb84cf7167..f12ff7416e41 100755
--- a/tools/testing/selftests/cpufreq/main.sh
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -24,6 +24,8 @@ helpme()
 	[-t <basic: Basic cpufreq testing
 	     suspend: suspend/resume,
 	     hibernate: hibernate/resume,
+	     suspend_rtc: suspend/resume back using the RTC wakeup alarm,
+	     hibernate_rtc: hibernate/resume back using the RTC wakeup alarm,
 	     modtest: test driver or governor modules. Only to be used with -d or -g options,
 	     sptest1: Simple governor switch to produce lockdep.
 	     sptest2: Concurrent governor switch to produce lockdep.
@@ -76,7 +78,8 @@ parse_arguments()
 				helpme
 				;;
 
-			t) # --func_type (Function to perform: basic, suspend, hibernate, modtest, sptest1/2/3/4 (default: basic))
+			t) # --func_type (Function to perform: basic, suspend, hibernate,
+			   # suspend_rtc, hibernate_rtc, modtest, sptest1/2/3/4 (default: basic))
 				FUNC=$OPTARG
 				;;
 
@@ -121,6 +124,14 @@ do_test()
 		do_suspend "hibernate" 1
 		;;
 
+		"suspend_rtc")
+                do_suspend "suspend" 1 rtc
+                ;;
+
+                "hibernate_rtc")
+                do_suspend "hibernate" 1 rtc
+                ;;
+
 		"modtest")
 		# Do we have modules in place?
 		if [ -z $DRIVER_MOD ] && [ -z $GOVERNOR_MOD ]; then
-- 
2.39.2


