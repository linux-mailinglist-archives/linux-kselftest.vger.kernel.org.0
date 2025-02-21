Return-Path: <linux-kselftest+bounces-27171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A33A3F681
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128C97A7E97
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C82139B0;
	Fri, 21 Feb 2025 13:52:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD26211A2F;
	Fri, 21 Feb 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145950; cv=none; b=iJOzuHc0ZktbpG0+RmVGrmSN68T6dKDYqYQE0unH8SHI0B8cg/z2CDW8bG6XUBPwI8WfRqG65T4RxgqobotwiVPVADH+Ary42uS6YXtr9UbiMxryICe18GnOY/K/BEmX0W/6bCmBCitZiu11gLyZLxVwxwdhcp8nA3t4b5JSCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145950; c=relaxed/simple;
	bh=UAMiYSp0KHUcRLeGDdf4eEUuv3guyClaUcJy9nLPA7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RqS9PgFxpaLoXyxve8KQMwfg5YJAiVhTTopeVY3x4+TuBpaPaKv26J4T1PHnY1I43FTLRnMwfvyQk74jNBj34Iz1Oh6+vvy1sCCPeqQhwML1bJZI527tv2M8b852DLtWcTmRKP+aS6lKkx6lEPkCsuCogPIyM63s1BVL725Me2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso5648348a12.0;
        Fri, 21 Feb 2025 05:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145946; x=1740750746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUXvrwelqbD1V75CQwnY7FgY79R0MbcECGMShqCA46U=;
        b=ju7CPHthny4esZN31/cJHUrahdxHpAAj8L8ZJqZmyk9eL8ILRFAQCWgf93DJRr3tgM
         L6pgtkzuVm/zfz3ohNhUOjZJYx8oMLCGgbWhXCRZr2WTRZyTHiqNWmMJeQsq1fILgkSN
         Q9kAZVAAubzoAqOfnyn44cT7JZAd3JL2rVdrxv7dCGI8xVngfARn8wXhofXbMc0843qb
         fC+Ojtxn4H912vOeaHEk2vs76SXL+zVbcclpySgj9gnAz610dEfstNi58gO4nYTDR2XA
         mXswC8THfC7HJuFe3uQ4Ml8k+dGokkLhl0jLeFQKawWPBhFWX7LmEzjt+YCJhKX5Sb5U
         Nz+g==
X-Forwarded-Encrypted: i=1; AJvYcCWVyqEydfh9ynrXcfKDiMjT3BNKYQzmNe2zRYSMqJAn2Dh1H3DFjqboOlyfIwHKoQgrU5bagZYrGg4=@vger.kernel.org, AJvYcCWk76RweSnX35W5/H64oMs+ZKOcL6HGhcewwlYHcQeH6dDnwQFS9xNzLtD3WDv145Ete2NYDfKs6iBP+i5k@vger.kernel.org, AJvYcCX8toQTbO8sMcZrqnSKl//ucZ+7rJDBGhyI5yuEJaAMK0+tBMIOky/0VFDi/5Il46jgFC3UUK687r6EpwWbNNkp@vger.kernel.org
X-Gm-Message-State: AOJu0YyYf+w/LFFX7dFdLlvirXdUQnwSUsrgt71kvmiAu8hnNMkH1qha
	AFaUmMho4vHW8bHIwCxUeBEhbfltmXrG14LnyAeO3dYvolGeATyGCodklA==
X-Gm-Gg: ASbGncuwlGsa7pAXGOEGxl/u/FoQQXSloO2aBDsemYhfLTChEKrqS0NwvP0UOh2sqv9
	urfsuu6CgfoEdL8oHe9MlbMdzKEAsDjjBX0pEco6SFO+bZ7fQtcLFddRoARuOYFIKrGGcMwLPII
	fX+4cOWsezMAVXAWcekqJCFYfFAws2TKHULFOBk6GnCOI6pBM13BRTta7zxYFV2vbC8rwlms1OX
	QcNr5I9uJWM1vQXex7zrnu14K0Y+3ycVkyuRbOLKxSCxzTXBt9YthmeQlhyNgVSV+Nvc92s/Oxy
	NshwDeUPqHZ5Alec
X-Google-Smtp-Source: AGHT+IFM2bCjUEEf+k8Bat7h8Tcg/3FtntblsSmSvoqqXX0anKjWVo6IaqCfPW2KnZT1GZBkNuPhmw==
X-Received: by 2002:a17:907:7a88:b0:ab6:fe30:f49e with SMTP id a640c23a62f3a-abc0b0e5fcdmr354463666b.28.1740145946307;
        Fri, 21 Feb 2025 05:52:26 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8a647c7dsm1112639866b.72.2025.02.21.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:52:25 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Feb 2025 05:52:12 -0800
Subject: [PATCH net-next 7/7] netconsole: selftest: add task name append
 testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-netcons_current-v1-7-21c86ae8fc0d@debian.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
In-Reply-To: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4260; i=leitao@debian.org;
 h=from:subject:message-id; bh=UAMiYSp0KHUcRLeGDdf4eEUuv3guyClaUcJy9nLPA7w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnuIUMJjAspGO8HO4uoPYIg3Zb0goymWI1KXVBp
 5X9ErcMswGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7iFDAAKCRA1o5Of/Hh3
 bcWaD/40iZKArz5bw2/fo5GELpRSNZJaC5y6BS2xxBnjo2saV3YWhbLi0pxmEL2onRCMCpodDcl
 UjD0CcjCH+uzzD0gWu+8Mt3d5cQhH0pKn0vMwlEs7WSYFxbOrGbyUdcuu5NzXp9RGiPbr3NhAK1
 cbIMapTpCf5hTxYHlEp2/+Oaqq0huFRQDunx7OGmSqwIWNZhfKjmm5YZ9hkcZ4vTLRuHm5LovFE
 B3W41m3OBO1Fmv3zdbNJUDsavQn9irAPh2OEzkUEymSY4Kel2DCJ74URKCexprXfwEC/2I2MbbL
 6PgJNcUCgUNc4KrovHLwjtiFEGfVMJkoXUaB6V1tqfS1UghFQV+JZ1xFTuOOxg8FUK7Pt6PpxFD
 WK7D2xTTpoYPJYEPQJPiKIwx3MNFULh/+QAHLmswgYSDZHTA5dsUZ2kpQgnRpBsN8HEGHb50quR
 q4rghn+WklsZ7jBOWW4LiAjiUTJXMt98pRZFGOC5qZHCX5X6xhybo9URTa9UxydjF+79MhHg+os
 su+nlBdiXBxveM/CwfDVnCk987m19xqkIIR7UTenqcJTXeVwSaAo3YH0rkVI+xdG1PleBWv4knd
 w2rGLwi4htMUVLGLIb2KbHbT41pCZfhe9TjmwwxlPN+syBIJ3NHwIZB87ABTxvG2U6Qk6Lirzqj
 q4YirEV3TMWRoAw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add test coverage for the netconsole task name feature to the existing
sysdata selftest script. This extends the test infrastructure to verify
that task names are correctly appended when enabled and absent when
disabled.

The test validates that:
  - Task names appear in the expected format "taskname=<name>"
  - Task names are included when the feature is enabled
  - Task names are excluded when the feature is disabled
  - The feature works correctly alongside other sysdata fields like CPU

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/drivers/net/netcons_sysdata.sh       | 51 +++++++++++++++++++---
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netcons_sysdata.sh b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
index 2b78fd1f5982fee81b379bf9ac6f64a38d915974..f351206ed1bda4d46269a521b27b9b8e56d524be 100755
--- a/tools/testing/selftests/drivers/net/netcons_sysdata.sh
+++ b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
@@ -31,17 +31,38 @@ function set_cpu_nr() {
 	echo 1 > "${NETCONS_PATH}/userdata/cpu_nr_enabled"
 }
 
+# Enable the taskname to be appended to sysdata
+function set_taskname() {
+	if [[ ! -f "${NETCONS_PATH}/userdata/taskname_enabled" ]]
+	then
+		echo "Not able to enable taskname sysdata append. Configfs not available in ${NETCONS_PATH}/userdata/taskname_enabled" >&2
+		exit "${ksft_skip}"
+	fi
+
+	echo 1 > "${NETCONS_PATH}/userdata/taskname_enabled"
+}
+
 # Disable the sysdata cpu_nr feature
 function unset_cpu_nr() {
 	echo 0 > "${NETCONS_PATH}/userdata/cpu_nr_enabled"
 }
 
-# Test if MSG content and `cpu=${CPU}` exists in OUTPUT_FILE
-function validate_sysdata_cpu_exists() {
+# Once called, taskname=<..> will not be appended anymore
+function unset_taskname() {
+	echo 0 > "${NETCONS_PATH}/userdata/taskname_enabled"
+}
+
+# Test if MSG contains sysdata
+function validate_sysdata() {
 	# OUTPUT_FILE will contain something like:
 	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
 	#  userdatakey=userdatavalue
 	#  cpu=X
+	#  taskname=<taskname>
+
+	# Echo is what this test uses to create the message. See runtest()
+	# function
+	SENDER="echo"
 
 	if [ ! -f "$OUTPUT_FILE" ]; then
 		echo "FAIL: File was not generated." >&2
@@ -62,12 +83,19 @@ function validate_sysdata_cpu_exists() {
 		exit "${ksft_fail}"
 	fi
 
+	if ! grep -q "taskname=${SENDER}" "${OUTPUT_FILE}"; then
+		echo "FAIL: 'taskname=echo' not found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+
 	rm "${OUTPUT_FILE}"
 	pkill_socat
 }
 
-# Test if MSG content exists in OUTPUT_FILE but no `cpu=` string
-function validate_sysdata_no_cpu() {
+# Test if MSG content exists in OUTPUT_FILE but no `cpu=` and `taskname=`
+# strings
+function validate_no_sysdata() {
 	if [ ! -f "$OUTPUT_FILE" ]; then
 		echo "FAIL: File was not generated." >&2
 		exit "${ksft_fail}"
@@ -85,6 +113,12 @@ function validate_sysdata_no_cpu() {
 		exit "${ksft_fail}"
 	fi
 
+	if grep -q "taskname=" "${OUTPUT_FILE}"; then
+		echo "FAIL: 'taskname=  found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+
 	rm "${OUTPUT_FILE}"
 }
 
@@ -133,10 +167,12 @@ OUTPUT_FILE="/tmp/${TARGET}_1"
 MSG="Test #1 from CPU${CPU}"
 # Enable the auto population of cpu_nr
 set_cpu_nr
+# Enable taskname to be appended to sysdata
+set_taskname
 runtest
 # Make sure the message was received in the dst part
 # and exit
-validate_sysdata_cpu_exists
+validate_sysdata
 
 #====================================================
 # TEST #2
@@ -148,7 +184,7 @@ OUTPUT_FILE="/tmp/${TARGET}_2"
 MSG="Test #2 from CPU${CPU}"
 set_user_data
 runtest
-validate_sysdata_cpu_exists
+validate_sysdata
 
 # ===================================================
 # TEST #3
@@ -160,8 +196,9 @@ OUTPUT_FILE="/tmp/${TARGET}_3"
 MSG="Test #3 from CPU${CPU}"
 # Enable the auto population of cpu_nr
 unset_cpu_nr
+unset_taskname
 runtest
 # At this time, cpu= shouldn't be present in the msg
-validate_sysdata_no_cpu
+validate_no_sysdata
 
 exit "${ksft_pass}"

-- 
2.43.5


