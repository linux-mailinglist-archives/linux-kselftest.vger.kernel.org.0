Return-Path: <linux-kselftest+bounces-13753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C6931AF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B373D28195D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD9131E38;
	Mon, 15 Jul 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fag9qzlm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD88120A;
	Mon, 15 Jul 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071613; cv=none; b=YfVj71FjK7mmO2yxz5sUb5YMdOQty+rvsSk13z1AdlyRhwcQh7o5BzeQn0xnaGnZy/e9J+OKUVfNNdqLZ2kr76KO6myJ43CcumZGZrt7FF/KgFejsgIm7y246BqxUHpJYz6Pypy5M+3mBIWBtZMe+rAcvZ2+l06kxWWlZqQC9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071613; c=relaxed/simple;
	bh=AquTpmNI8+puJUmowTTXFIpoKd+gUu82yvOdOBhT4d8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mpLVI5NWNlPtlnDND208dCEeCTWeaH7bMfzv4kMtswajGGOKTQn7YcLD3WvfAFrVt+pwjFQydNDAWb5ni83QbfZyUEL5j6saLE7nSKX8QZOvpwZe5f9omMa6+/fZVbFugzuo/jiZsLTGBELu9zAi9tH9F+F94QuH3vPTMr0bgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fag9qzlm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721071609;
	bh=AquTpmNI8+puJUmowTTXFIpoKd+gUu82yvOdOBhT4d8=;
	h=From:To:Cc:Subject:Date:From;
	b=Fag9qzlmoEQunH8oVsPYPkrluS6owJOZysQRuljdnu7pw3GF/e80louYXky2VbSpG
	 sIEQo2UnG1vecL5Q8wJdSeMQDiv80u8cle4xKSK/zO3MS/d+ovvOw2kzlJOpWaaoqC
	 Yd1RcC9djhb4f453IQdF1NOc5qSdVxKIVCt0P1TujMPwiI+dzJA5u2D48cj+79Tuxh
	 uDurCeB7zK4bRlvT6CN56MfmE/AlGgpzRL8t/2F40xbNDjJEWe/g5WETsXRnT9fqFT
	 SHqtGQ6vE+ulCoMU0YoOVoTiVDJgG2cNjixv1AiUyx39JWT+JQIWVG34dnISC4A8ir
	 LeR0nbXu38+pQ==
Received: from shreeya.shreeya (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B111A378143B;
	Mon, 15 Jul 2024 19:26:47 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2] kselftest: cpufreq: Add RTC wakeup alarm
Date: Tue, 16 Jul 2024 00:56:34 +0530
Message-Id: <20240715192634.19272-1-shreeya.patel@collabora.com>
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

Changes in v2
  - Use rtcwake utility instead of sysfs for setting up
a RTC wakeup alarm

 tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++++++
 tools/testing/selftests/cpufreq/main.sh    | 13 ++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
index b583a2fb4504..a427de1f9e08 100755
--- a/tools/testing/selftests/cpufreq/cpufreq.sh
+++ b/tools/testing/selftests/cpufreq/cpufreq.sh
@@ -232,6 +232,21 @@ do_suspend()
 
 		for i in `seq 1 $2`; do
 			printf "Starting $1\n"
+
+			if [ "$3" = "rtc" ]; then
+				if ! command -v rtcwake &> /dev/null; then
+					printf "rtcwake could not be found, please install it.\n"
+					return 1
+				fi
+
+				rtcwake -m $filename -s 15
+
+				if [ $? -ne 0 ]; then
+					printf "Failed to suspend using RTC wake alarm\n"
+					return 1
+				fi
+			fi
+
 			echo $filename > $SYSFS/power/state
 			printf "Came out of $1\n"
 
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index 60ce18ed0666..b1ca4147a5e6 100755
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
 
@@ -122,6 +125,14 @@ do_test()
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


