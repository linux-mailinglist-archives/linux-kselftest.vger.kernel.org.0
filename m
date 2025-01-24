Return-Path: <linux-kselftest+bounces-25107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3204A1B8DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB816EF6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77493219E8C;
	Fri, 24 Jan 2025 15:17:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABE1D47AD;
	Fri, 24 Jan 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731839; cv=none; b=puLxY93d/onoPv46qHilC0jYVQikfxewxHZxqSekE4L90Jlc/DoBa9GkbK6NBD8d58Z4VCduWuL0wf3Gx8iCrShddGODfaUPU0bJ6oByYWBTWHo/PWb34WB6ouA7zO0qVfw1PexYTMt5iQP4zoKXbz6IgXPVPvrLMcZtG38EbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731839; c=relaxed/simple;
	bh=HH5Vd0/wTISa/RdkFDoACDqmczgi5UrCPOZJhomUhsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDpY/SyjpY+cNA+aBn7LE3HlO9x82JIYuEw2meWpuI1ViYLl14do9h7VWUqwnXAPErFPrhzTVeiVRAELvVkHuQlHlShdhR0cDy0MLKLtn/LVCkJA9+WqTnI4Iq1Lm250nFEuHZXxhJy9CfDzALXHDqOkKuwMU1Y+o1xqBOo4SEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso515604266b.2;
        Fri, 24 Jan 2025 07:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731835; x=1738336635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUUSxXMA9/ZzLm1CQhpRCwYqH4rW6urRrefck5UrJQA=;
        b=YYI1gnruIlP+QjKcxy3xf1DAju1RsDDWSklOeDFnfKrXiGwtm3uyoj+j2iAfgM155m
         Lu2rrEEJ7yPIx9LQ6uid6As1xwdgCU8COT8TzgrA7OaX8pNs4cqmiSLrjY7koj+1WYxX
         F7OJ0uSCqy2VXESNclrrjmlMFRsGftJv4u4eJk79eY61+Yow/U+mG7clBYyamd4oGacv
         ZU+PODXFd5Q7RQirzc/dvA/oSUNOaSGD1IGHP1QmKy7JwFvFypvzVaHO/UFuK0F89agf
         UQzlhLDo0I/aOCm26N/L3Y2+Ltyoup320JIYpun+EGuzh2kd69RehOIR8CJft6ofMuvc
         2Wlg==
X-Forwarded-Encrypted: i=1; AJvYcCU9ch6++QHcrpRxtw/CNXV0rkv5+jOVC5CNCG4cqvPh+kafR7zEUDzfAjOI5yJVJhbSHYA/64dxbKE=@vger.kernel.org, AJvYcCVyrdjd2xk8czDV+lurhzFbIY7ER9JtK9vMp6loBTRAgs/2guJnJz3W0NfKIgxqafnw7MIvdY1K/tTJONUR@vger.kernel.org, AJvYcCWl1DxCu6+8lL4aUPgTLun03iXwy+v2smaM/cUYdqqLOfBLbTDsdFHibC6jdtzV42GpWBAgoROv/ACIXsh8zzAA@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjqXaDqYo6s0evEZarrLR04Yl3Y3xR1EwnQ/9yp8as9e7k3jl
	4GyJETIyWnM/7VGNy1sp7KRcKnh68+GxVkfSUMWo6OVF3wILrvT0G/Ur0Q==
X-Gm-Gg: ASbGncsvOLWXYenfCZ2qUVcuVBWpdJK7oaGAUU42rJF7SmqXVDdLhK76AEZt5Ew2yV/
	SkiD5I8R8tTYM6iwJ/vLHaHWqs1ZvZWJAAU9LN3CIkttVFULKUsFlOM8WWt58LoRySAWApTzhol
	oFU6OU+szhZiMcVKQJYB+MFSkVtT16G35Hn1JxsJW99FeT9xkHWDPQRJtrZJ+oaRTYpv8whaw95
	1+QOLOkepXkZTEH7Ywxofns4errVzLoz0/86yDAEb0VXM5+OgBfsgj+Av4INXbjZBE1lkE=
X-Google-Smtp-Source: AGHT+IFGFoPwj1Glit3wkHQ6H5kjHsv5c8LH2I8PtFlvsWCzeaqQat6JElK5Vy/QdrNnZBLS3qcXPQ==
X-Received: by 2002:a17:907:72c1:b0:ab3:61e8:aa16 with SMTP id a640c23a62f3a-ab38b38134amr3150937766b.43.1737731835017;
        Fri, 24 Jan 2025 07:17:15 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab676113267sm141210666b.161.2025.01.24.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:17:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jan 2025 07:16:46 -0800
Subject: [PATCH RFC net-next v3 7/8] netconsole: selftest: test for sysdata
 CPU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-netcon_cpu-v3-7-12a0d286ba1d@debian.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
In-Reply-To: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7648; i=leitao@debian.org;
 h=from:subject:message-id; bh=HH5Vd0/wTISa/RdkFDoACDqmczgi5UrCPOZJhomUhsM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnk67rYbAxwiKtY4ZSi/QPKuPp9o32dMfk81pwy
 5TwgoNbh7yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5Ou6wAKCRA1o5Of/Hh3
 bVDeD/43MFQZD+CnoUq6kLpIPZmWmDsCIG45p6kol3FaYoi3q8DosLP2kHpzg2YaZDuUQ/PqsZf
 b/9YzXkp8REAZ42zLIM6tO2xpEfj2oZxVosF/NlQMXfskFfqH5lyfZNW+TpGRdwroYcM9S48Yqd
 3Y79IPtN5XRsrj1/rIpc86BSF7GJmzWc8od7k2zPDjIurplICJ7VcmVCBcnrzRKH4CKmGcsSp0V
 klTRuKeqOjYJVelHZH9y8+zxFd43mD/hV4Xo5n63JtXIAL2kdRt95RnEpzfZcuegmPeTKgpvY9y
 wesD6F/bIqBygycUb8WHVNcS3nMARnKOzGUapG7LvM28USPapBDc9f6XUjSDfe4b5ted0YzB0Gx
 zFub3I3K8idggpqZa2+9ZHh3e9W2Wt5fmlMCemptw9qSmIDhwI28j/ua1vtmLnnHoEw6AtT680Y
 YPC2bqvAfEWB615ft6P3FMt6AszKmxRLJhekbRubceG3ToL+E0n2j9cBtYC9Syj8U/dwya4FU1V
 tz/vddtui1hRBWGH80ZdQG3sMsjElHmJlf1WSlvmPGSFjguppvz3/mLQ2YPjZ7omuzjCHE8VIwa
 k9sfsG7Zu8wTgPiulN/8TRQ2fJr5A0gB95L0MalmKnSNVid/8xgQSNOqJRKs4g34l5C+fyy7hFd
 wkONcIMS9K86atQ==
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
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  17 +++
 .../selftests/drivers/net/netcons_sysdata.sh       | 167 +++++++++++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 137470bdee0c7fd2517bd1baafc12d575de4b4ac..6c5e6159d8913e7bfd6bd835f0a9bd9e9d83518b 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -8,6 +8,7 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_overflow.sh \
+	netcons_sysdata.sh \
 	ping.py \
 	queues.py \
 	stats.py \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 3acaba41ac7b21aa2fd8457ed640a5ac8a41bc12..d319d177ce5ed7a1b196e68bffe549d57011fb15 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -223,3 +223,20 @@ function check_for_dependencies() {
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
index 0000000000000000000000000000000000000000..f50ccae6c0c090d6574defe5e02d7eda5f3d7188
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
+	if [[ ! -f "${NETCONS_PATH}/userdata/cpu_nr" ]]
+	then
+		echo "Populate CPU configfs path not available in ${NETCONS_PATH}/userdata/cpu_nr" >&2
+		exit "${ksft_skip}"
+	fi
+
+	echo 1 > "${NETCONS_PATH}/userdata/cpu_nr"
+}
+
+# Disable the sysdata cpu_nr feature
+function unset_cpu_nr() {
+	echo 0 > "${NETCONS_PATH}/userdata/cpu_nr"
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


