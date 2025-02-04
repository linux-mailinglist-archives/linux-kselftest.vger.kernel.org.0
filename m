Return-Path: <linux-kselftest+bounces-25668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B1A2706B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B319C16806E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231F7211A20;
	Tue,  4 Feb 2025 11:35:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA512116E6;
	Tue,  4 Feb 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668944; cv=none; b=OggXWqpB3sRJX4tZtvhCUNealpe6JwEg1LRtKXABJuEHgMBE+bBsJYNNI3+rhIZGzzLV3gQKpGgP33EBobu3+ZdmpFY8dgQynePg7UGB6dynpLAmwQOSjZGvYtkoN/QOhap/Oa4ghcNeZBcO83qUaR1bIqdb6ftP0Fw/qPr0Ei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668944; c=relaxed/simple;
	bh=EWk2ay0albPWO0VUzwfvd3FuxFeaTYfwca4yspDY4GM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chaB9axV5lKc+kQVQXY8RayviNYdWZRCyIyqfM4Gb5UzGNPSJMyc3D8fuBIEMYz3ofTI5TV+x0CLXHcdOq/LOk+pA2uIrIfYDgDSdbrrIT6Hy4GLLTmK7Bna/fM9JL8WncRnO7/Y/H7yZyj+4WTY/K+HNfdgbxCCb+kXig/q12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab68a4ab074so674149466b.0;
        Tue, 04 Feb 2025 03:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668940; x=1739273740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4lbmitZAUWzZsnieUUQwDFzsIag16/ARHCo65YqC7k=;
        b=rPbOHSfTAHpzCG/QCDgBl7AJTnT2FBMlQ0jVBz+DjsLGy+RGbeYtv/JWpHFaTtVMPf
         dVEeqjaCRFrqznC98o6ehdS0pBMmzCXBDMKSZLe9bG3MO4b60qG3QbXKDQh/+I9jm1t8
         LpFBspUCtRCxWACqUvaHH5VCaUaaGi2BD3scVBhMxgZD0T1TwHD6xkmzgO2oaaUFcv9b
         Fj8XK6covQLUYjyBsbcyQph2GZc1/3HhiqYaKWBMsZMxgnlmFgsTAcOVZAe8TE3b0UNV
         RGSGBuPzfp3WA7892Q/gOHX/u1DmH1en7RiynU8Z5znkT5ao/J4eB9FRyJ1BmQOKqiSw
         FSTg==
X-Forwarded-Encrypted: i=1; AJvYcCVRqELExogmYSNk2RKWIZ3q+ryATjCMnfyYFrWX2FB8GNPempVzOf1vtdYP5WWqqwEdXtbLEb0fRoWS2U/rbFil@vger.kernel.org, AJvYcCVtHgK1ZNCbC7/VnqO8qkIYQy8MKlClNLXrqo6nYvyrgGF+J/uP/K7RKE9f76wty+4omFfNTaYGzlM=@vger.kernel.org, AJvYcCW33LCbsnjqMbpcepOuHB3Lj2xRtMWkSDxa7svlsrwQO0WTIrv/eCcMsNfs5t/rb7aSgk5UzC1tfoX6pbE5@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvln51nv6WEJkHCh460GyD8bglzcnZG3yu+Y0R73SdO+LJUmh
	swVp9e624rHZoENOxpQycsyD6goqQjM3BnWalnmQ7TZn5NPvuzoWpEPIgg==
X-Gm-Gg: ASbGncvsBCR/FI16yCl/PdfSUk1o6Ku8IpLlxmA16epxMT1qzs2c2Z915WxIP0lQu0j
	5oeQa/3wKQugkct2lz+X5jAjgZm9Q3YGUW23MbkyoCNoe4Ao8B/aRzZm3wdd+4wczG4vQ8jo4Pd
	nPrfKfUsZZYFeIPRsrfRiamo9O8ME5Bd73fSAox1uRseX0w/bnoOMiSN6pj2jsL3AHDbIcbjbOE
	RSI1XFKuUchatAd9Jn0T2n9eE+CfJ9yeUfjzSbwNxD3mkgVTAwX+B0EzE9YDQqeKUBax5J9BmUe
	o6odI20=
X-Google-Smtp-Source: AGHT+IHDbQ1+cLNBPQxoOFBV+3VXprx5YVL2fhuMmRdRdGknXrBharEkYL7xW71lznoSIMEG3h/FIg==
X-Received: by 2002:a05:6402:5285:b0:5dc:a463:ab96 with SMTP id 4fb4d7f45d1cf-5dca463abf6mr23965091a12.19.1738668939633;
        Tue, 04 Feb 2025 03:35:39 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724a9c76sm9357917a12.53.2025.02.04.03.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:35:39 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Feb 2025 03:35:15 -0800
Subject: [PATCH net-next v4 7/8] netconsole: selftest: test for sysdata CPU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netcon_cpu-v4-7-9480266ef556@debian.org>
References: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
In-Reply-To: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 rdunlap@infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7712; i=leitao@debian.org;
 h=from:subject:message-id; bh=EWk2ay0albPWO0VUzwfvd3FuxFeaTYfwca4yspDY4GM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoft+jBqVcviLLuFniqVgH0ydldvphC8ymZkQf
 kEj8f4wAPaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6H7fgAKCRA1o5Of/Hh3
 bbU/D/9kiqFvmq3sVhypIhxv22X21ABBavGODyL5+5dgDYzrbbvt10XDPxjxayWScPsFzgayh0e
 kW5JSgVfoyAJ0gBFClzHRZR/yUSs+IoZHDpQpF6IEhSepI55YCpJzIgkZsKTQXW3AA98gcYJxPg
 G+NOk6eNNmSo5oGh1uY7TWMhoHdDO4rDO11ymjVU84+eB8IEPboTNYMqganY5o94tZDH+of5wwQ
 EX9aPtVLAZcB1BaxzOVIm+Q9J+E4IWPUmmKAwsLTEyHiXOcffdQm6oaz/jdhDOUFLAcxC4Fx4jI
 ICAUm4JW0ozRK25g3lNgFDfYmnxammbVqJj/8B0YGVkdrxHCirIdlksgD8ocCmQb+RdQS4UJciQ
 MwfiPwe7Cxn8DrokW5sfS56bL+IFVcDb76VNwPTikKEtHEpAfDjT4uWm95yDfat2KDNmfhf1FXb
 4ATsBGGyCDhEl5m5JBH7/uvL4AsDd0PiKGDzLvp764j8WWcRmD/prTCs/6wrVJPM2XRuAB+3XxX
 LKrvm81YLZHGbUN+Ra/9PYqh3j/4fHSjGtcukqnuSav3UQVtyoMmXHwQLHsU+ADQphAOMHFqCzQ
 VVZ63PPsmnmJZ9K+z6/hhYbl3m2rqXMljb1WrG+t6TS9ey2Ts18qZ+p0Hy6de6TaZM9ZsaCeqbR
 7lMhTTfNm3PMYvw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new selftest to verify that the netconsole module correctly
handles CPU runtime data in sysdata. The test validates three scenarios:

1. Basic CPU sysdata functionality - verifies that cpu=X is appended to
   messages
2. CPU sysdata with userdata - ensures CPU data works alongside userdata
3. Disabled CPU sysdata - confirms no CPU data is included when disabled

The test uses taskset to control which CPU sends messages and verifies
the reported CPU matches the one used. This helps ensure that netconsole
accurately tracks and reports the originating CPU of messages.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  17 +++
 .../selftests/drivers/net/netcons_sysdata.sh       | 167 +++++++++++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index c7f1c443f2af091aa13f67dd1df9ae05d7a43f40..28b6d47f812dd23dfed89599b6edb020671f8242 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -9,6 +9,7 @@ TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
+	netcons_sysdata.sh \
 	ping.py \
 	queues.py \
 	stats.py \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 0c262b123fdd3082c40b2bd899ec626d223226ed..3c96b022954db9e21216950b1c13431c313ed4b5 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -230,3 +230,20 @@ function check_for_dependencies() {
 		exit "${ksft_skip}"
 	fi
 }
+
+function check_for_taskset() {
+	if ! which taskset > /dev/null ; then
+		echo "SKIP: taskset(1) is not available" >&2
+		exit "${ksft_skip}"
+	fi
+}
+
+# This is necessary if running multiple tests in a row
+function pkill_socat() {
+	PROCESS_NAME="socat UDP-LISTEN:6666,fork ${OUTPUT_FILE}"
+	# socat runs under timeout(1), kill it if it is still alive
+	# do not fail if socat doesn't exist anymore
+	set +e
+	pkill -f "${PROCESS_NAME}"
+	set -e
+}
diff --git a/tools/testing/selftests/drivers/net/netcons_sysdata.sh b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
new file mode 100755
index 0000000000000000000000000000000000000000..2b78fd1f5982fee81b379bf9ac6f64a38d915974
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
@@ -0,0 +1,167 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# A test that makes sure that sysdata runtime CPU data is properly set
+# when a message is sent.
+#
+# There are 3 different tests, every time sent using a random CPU.
+#  - Test #1
+#    * Only enable cpu_nr sysdata feature.
+#  - Test #2
+#    * Keep cpu_nr sysdata feature enable and enable userdata.
+#  - Test #3
+#    * keep userdata enabled, and disable sysdata cpu_nr feature.
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+# Enable the sysdata cpu_nr feature
+function set_cpu_nr() {
+	if [[ ! -f "${NETCONS_PATH}/userdata/cpu_nr_enabled" ]]
+	then
+		echo "Populate CPU configfs path not available in ${NETCONS_PATH}/userdata/cpu_nr_enabled" >&2
+		exit "${ksft_skip}"
+	fi
+
+	echo 1 > "${NETCONS_PATH}/userdata/cpu_nr_enabled"
+}
+
+# Disable the sysdata cpu_nr feature
+function unset_cpu_nr() {
+	echo 0 > "${NETCONS_PATH}/userdata/cpu_nr_enabled"
+}
+
+# Test if MSG content and `cpu=${CPU}` exists in OUTPUT_FILE
+function validate_sysdata_cpu_exists() {
+	# OUTPUT_FILE will contain something like:
+	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
+	#  userdatakey=userdatavalue
+	#  cpu=X
+
+	if [ ! -f "$OUTPUT_FILE" ]; then
+		echo "FAIL: File was not generated." >&2
+		exit "${ksft_fail}"
+	fi
+
+	if ! grep -q "${MSG}" "${OUTPUT_FILE}"; then
+		echo "FAIL: ${MSG} not found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+
+	# Check if cpu=XX exists in the file and matches the one used
+	# in taskset(1)
+	if ! grep -q "cpu=${CPU}\+" "${OUTPUT_FILE}"; then
+		echo "FAIL: 'cpu=${CPU}' not found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+
+	rm "${OUTPUT_FILE}"
+	pkill_socat
+}
+
+# Test if MSG content exists in OUTPUT_FILE but no `cpu=` string
+function validate_sysdata_no_cpu() {
+	if [ ! -f "$OUTPUT_FILE" ]; then
+		echo "FAIL: File was not generated." >&2
+		exit "${ksft_fail}"
+	fi
+
+	if ! grep -q "${MSG}" "${OUTPUT_FILE}"; then
+		echo "FAIL: ${MSG} not found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+
+	if grep -q "cpu=" "${OUTPUT_FILE}"; then
+		echo "FAIL: 'cpu=  found in ${OUTPUT_FILE}" >&2
+		cat "${OUTPUT_FILE}" >&2
+		exit "${ksft_fail}"
+	fi
+
+	rm "${OUTPUT_FILE}"
+}
+
+# Start socat, send the message and wait for the file to show up in the file
+# system
+function runtest {
+	# Listen for netconsole port inside the namespace and destination
+	# interface
+	listen_port_and_save_to "${OUTPUT_FILE}" &
+	# Wait for socat to start and listen to the port.
+	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+	# Send the message
+	taskset -c "${CPU}" echo "${MSG}: ${TARGET}" > /dev/kmsg
+	# Wait until socat saves the file to disk
+	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+}
+
+# ========== #
+# Start here #
+# ========== #
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# This test also depends on taskset(1). Check for it before starting the test
+check_for_taskset
+
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup EXIT
+# Create one namespace and two interfaces
+set_network
+# Create a dynamic target for netconsole
+create_dynamic_target
+
+#====================================================
+# TEST #1
+# Send message from a random CPU
+#====================================================
+# Random CPU in the system
+CPU=$((RANDOM % $(nproc)))
+OUTPUT_FILE="/tmp/${TARGET}_1"
+MSG="Test #1 from CPU${CPU}"
+# Enable the auto population of cpu_nr
+set_cpu_nr
+runtest
+# Make sure the message was received in the dst part
+# and exit
+validate_sysdata_cpu_exists
+
+#====================================================
+# TEST #2
+# This test now adds userdata together with sysdata
+# ===================================================
+# Get a new random CPU
+CPU=$((RANDOM % $(nproc)))
+OUTPUT_FILE="/tmp/${TARGET}_2"
+MSG="Test #2 from CPU${CPU}"
+set_user_data
+runtest
+validate_sysdata_cpu_exists
+
+# ===================================================
+# TEST #3
+# Unset cpu_nr, so, no CPU should be appended.
+# userdata is still set
+# ===================================================
+CPU=$((RANDOM % $(nproc)))
+OUTPUT_FILE="/tmp/${TARGET}_3"
+MSG="Test #3 from CPU${CPU}"
+# Enable the auto population of cpu_nr
+unset_cpu_nr
+runtest
+# At this time, cpu= shouldn't be present in the msg
+validate_sysdata_no_cpu
+
+exit "${ksft_pass}"

-- 
2.43.5


