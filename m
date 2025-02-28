Return-Path: <linux-kselftest+bounces-27902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08154A499F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5AC173795
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F4270EBD;
	Fri, 28 Feb 2025 12:50:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC32702CA;
	Fri, 28 Feb 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747058; cv=none; b=GKDujVPgjQ1mvF91Ps77ceQj8CvO3ZAuIyiAS/cJEEn0n5IOHMX0/1ZyPo9uun9mupLqGrfEoXo+ICl9Xr+lyua/zDUedyTcIqn9iWT+a6I6MwWSwHyHmskd+YQ9T9TQWZ3gAcFsmHjW2ev40EiKICDvjD4cUPpTb1RPEpFZUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747058; c=relaxed/simple;
	bh=bQuZdV89ViO+C8ea3V/SA2TtywKFo513J57gSGk0RZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIbgM5/n6IwmfK0Otf4DluCjot6CceKxwy7L7Ai4GQx88SVvcGUdP3mVM1nuNHhcFA6MEciKiew35LHJj8eykEk1fPp8fdSXb+wYwXmLwZa3wBZXYVeaL+dNeLn+hu1PpiJyFuO/ynyFEJRfeNWjDLfzRFz597dd+OxaYBSAnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so3442038a12.1;
        Fri, 28 Feb 2025 04:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747055; x=1741351855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RoRzffhAWFwu1880cu+JXgdjT1m36rkED8fGCNHUI4=;
        b=aiPDD2HXMJSnbnG/m/qGTXY0aC+dfiRmOnGSbK+IFwbTolxRYCZNceDZNdb9kHFznb
         LYHcFShCk0KJe9WhM6zZCaaRB9FWJqRpjVQCaaizCjFyePTF4YwZ3hrXj6kdUKKMf+n3
         AMLd8zhiDehfB9d2J4RYgGOPkH0x86+7P9taTxP08zEFMY4CSH9PcijuQaroNdUIpyyk
         TGphpLVNa6p6sAvrF31g9Is35HCkFP/7oGchlD6X6VyLjhJz0jUfHdBRgGq7QcF/v08m
         0ujXtnvG9n0wwv8YVR9SIF9aZ+dbS53xb8hBrpVLZAR9DnUs9qUFLbBlWBvsdjXm3irN
         d3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU06KbnkicGDmbMNTN/MbTpi6BbkX9ZDG2sdS5J4eIPO7bC3PnbvEkz3+Zno23VUJEE2K18zDszetDBGkcsxhAb@vger.kernel.org, AJvYcCUqLjXagfJtxgp8wA0nVQRTRW1DoLSIrqMIY0Pr9d5DVea+i1qnbCOE3C+AtZPcqWd8R0BbrmG2y4QGlyQT@vger.kernel.org, AJvYcCW4XBKeN98aLIrIRRfTB4FWpwenIwaAaZPGOCXrhD9Secvs7x46lrV3NAstp+C9jqSLNJUPbvrbuSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5XrSJsMi2J9FnLly5ChhWzNb3hPgon/6Q7GimwxTt6JZ+tmY
	sFUE5ZFoSxMuNRFQM8CASUQaptLfbEJgTj+STTfN2Y1N50eCU+3C
X-Gm-Gg: ASbGnctlQ+pk6s8PAP98uWY7zFNt2mH46ih+Xqp0ijtEnGNBohs0th9QNQOewMQKqiD
	dgEh+D5y2Xi9UbIumvo9NNzZRCJOq1KL2zP5MwH8M/IkkCbffKxhrdvW5dn/6w3hUFzGcJjgw4h
	mT+IDGQLHVdoyZUTEQVRqYVIXHOv5SVS7kmqGs/12baY0FNL/3cPrM5e0/fiSeL8tVs/89ItR12
	wpCZ1LduqVtPyF0/yHBmal5XCsWEigxmiXgK9oh0xFGC/ZG0h8AuNKME7SP1zOEb8Ms1mWn/xb+
	ijHkpfnVVN0ZkAVX+Q==
X-Google-Smtp-Source: AGHT+IFpcD4G0piaxn5eQhCYdsfhQ9AlB7Wf9C7Rk0yV7/3HEUfMAwI1lrGIckYABSHHB07CwJusEA==
X-Received: by 2002:a17:907:98b:b0:aa6:a87e:f2e1 with SMTP id a640c23a62f3a-abf26824d2bmr366979366b.56.1740747055099;
        Fri, 28 Feb 2025 04:50:55 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1f1d5b4csm194129566b.85.2025.02.28.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:50:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Feb 2025 04:50:24 -0800
Subject: [PATCH net-next v2 8/8] netconsole: selftest: add task name append
 testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-netcons_current-v2-8-f53ff79a0db2@debian.org>
References: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
In-Reply-To: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252; i=leitao@debian.org;
 h=from:subject:message-id; bh=bQuZdV89ViO+C8ea3V/SA2TtywKFo513J57gSGk0RZk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwbEeOlpLZz+jnYyR9K+wnsSZH4aDZZ19EMuR2
 yd/tIPKlICJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8GxHgAKCRA1o5Of/Hh3
 bfaWEACiJ9VntVXYjyI2qIax5VJSP6kSsBySEMH1ZKxbeKgyGhZ93Q8ygigvOiBWKKyVWp4cfaO
 oRuJvy6JFosQlkRNhwQoyCm1F4/RSsDO0z9TJvE/qVQK/vu39fxUYo+pFIPfJTj1plmhzMEMtOt
 VQ4+rCN4z3ouvh5bZOyNJPSbZ/zvxesii7/2wQ3AJaFNHskeMaQeOJnaVn9Fshv8QzkaepCBAp4
 JkzYe7KcVdkQujg0O7tjhpZ29f6LW23JWaHHa0VjqvATTnuOFDMTlGEJkDqsA1kn3PmQRfDb32n
 jsUnwcuDGi2xshZ4JUWp/ULtCRz9LDefmsx5n3ioJQ0vJ9mUnUlIFJJzy5DSySZaO4W7Nti9U59
 S4Aycxv3dqWcW5e/vHnc7HiMFa4xz5H4bujSK+1qC2DvVvCMu+CNk27Lij5P2wusHr5dZ6kef9b
 F/GUc73TAYww4dz85ZXjDkCOpaLRR8n1aYnkR2OwvcclIJHyw22RCCic0dp2TWqGvsAp+ZA9Lzf
 mPwDxOrOKF+brh1JfZK+2WfBEAkmqbWHnZdWZv8HozdIk8Y0886xRiLvUa67gE24t3aVYiljfVX
 hgPmCZ4YwWAF9845e8Bs6HXPNuYWlPr5w9f+ds05MjoVVBKmKy9IAPRk442270AqfLgOSsKAgZJ
 OjVeK/SZqu0mMUQ==
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../selftests/drivers/net/netcons_sysdata.sh       | 51 +++++++++++++++++++---
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netcons_sysdata.sh b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
index 2b78fd1f5982f..f351206ed1bda 100755
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


