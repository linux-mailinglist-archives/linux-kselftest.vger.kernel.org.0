Return-Path: <linux-kselftest+bounces-24576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3EAA124E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 14:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A863A6415
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595DC2442E9;
	Wed, 15 Jan 2025 13:35:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43178243873;
	Wed, 15 Jan 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948145; cv=none; b=GI7YD2SfRpoSKq2L8fAanCZzYVzhAJwbg/s1nMwI7QsrZnXfoHs3TKmn0bg3GGkb979ksE22qlI9CFQzm7X+QlUsf3qn8FOKmHXsYKi4f6fAzTrUBHviYbV8uDLkJnL/3G/fOOva12dLGm7sRoNnENiocZqTyOfL1j3yxtjmp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948145; c=relaxed/simple;
	bh=b+K5dYQ+pmuYTcPApzLrUA47uxeMEoTKA+hWTz6q5n8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOzdw22Ep3nBwkkyhqLelIPqIjrKo+hqO/03HKHRqyQicblsKvvZclg1irYFWehrF/sZzbIZrhxSEd7kfApfhDEwfagtIV5kpcy4RZXqd8M4WMHNOJrbcZXFkhfPpxiV1WJ1s7vKMqCz+QMg0Ej8SDE1s8QaxdVm1WG9yFE0TqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so1191266966b.2;
        Wed, 15 Jan 2025 05:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948141; x=1737552941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIJ/Ae1RdlG6JrQhyaZytF06+/sw79PkUaiZw46sYlk=;
        b=sVlJZvE5a4R02Tese0hpQ3Rv23siz/pT/uX/coczVaz++4aoYQMaS2WkYtsT8/DAVJ
         UUrifSPxwnBTBOdNpijH08Z0LuNa6KhTaXmobYl6sfv7uvP2f/etHrN340Us7zP8cb0K
         7oc/2TnsOyNFFElt2OlrIK04I6ZsAiSZAkL/yCz41Pz9fxNZWmN+S08dYp0+Wb2n19Uv
         xvq5wizdE07216pIeEQXW3l/6Bb11A/ehBAoTM96tYEy5kvzBfp/JwERJlSG4F04usI3
         j9BV21jlrkD7oE1oszCnzqnj1M6gsgxMZ7R7WbvtdnMgnIuWk5hVOG8zgSHEV2RqJ5Bj
         siwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVccA7dvWmjQo/WvuuSAbnDOB/UqufL1DgPUcDWWBP98Y71geNRENQnF9GqUL+DeCbjTWMRkmypkpU=@vger.kernel.org, AJvYcCXKCtqDNcDREvHGhHO+EmpqqotD7jaTMQtmrjS4fdkh1Aar45xmDnbR0gLwXlbdYGGb3q9s7/+zymtGWsIJE2vV@vger.kernel.org, AJvYcCXL6DMsnEkn9izPAKKVfcNxyF/JQsm7KuumEa8FY3i8sqM5PIRg6CItGwMHQ7iK+9fX8azuBQW2j3VZ0gvV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/je0JWaVr/lG5F+r15JYONecd/4QFzb1b5p7+uxZL4E655Ho1
	EiRZFOG/1kbRTF/rXaRKzV3wm5hl5RSfrmHqc2vHnrGttXzQRhuC
X-Gm-Gg: ASbGncuQaQ0m9k25QlMm21TCEtkZtcQ6qGDLX7bfYQ0lrITe7yVISSsyLwXggE3KFFf
	tXvChk2QJgQ/dMOJ9kkWCkdthDNrUIlH8ocBlR+mzGkNclRJxGYZlsQCZ3BhfWx4REExMXSfPfY
	if4s6lxzmSrd6cf1L6y6yEW4+Mh7mOccy4QY2SqabqgmMkEIkqfvGztkvxgWEX42MhSB7OrLS5D
	eQKKr7ZU9K+R8vivTw0MxPBT2MmnuwIHq8kGhpjNLES/ag=
X-Google-Smtp-Source: AGHT+IHWmX149OPZFUzxJH6FjINlXXn+Ovct4wtUyrUWJzuv/vvc+rFWkA/j1NMhQhUZC43NJjmX8w==
X-Received: by 2002:a17:907:36c8:b0:aa6:9fad:3c1d with SMTP id a640c23a62f3a-ab2abc6f5b9mr3058244766b.39.1736948140456;
        Wed, 15 Jan 2025 05:35:40 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90dace5sm768149366b.60.2025.01.15.05.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:35:39 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 15 Jan 2025 05:35:21 -0800
Subject: [PATCH net-next v2 4/5] netconsole: selftest: test for sysdata CPU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-netcon_cpu-v2-4-95971b44dc56@debian.org>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
In-Reply-To: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, max@kutsevol.com, 
 thepacketgeek@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7643; i=leitao@debian.org;
 h=from:subject:message-id; bh=b+K5dYQ+pmuYTcPApzLrUA47uxeMEoTKA+hWTz6q5n8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnh7mj1jUj3LrDhaMO/QWuT2Ms/91J4Z0Yo0oe8
 HLuqWvWbhKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ4e5owAKCRA1o5Of/Hh3
 bejTD/4vRK7FTsBBocrdm/L09gZ+qFHED4+cR6MxsO5oCHk7ygYhCrNJv/DRlgDOWn0SMdhBJSV
 3PaR8CWMSs1TqHmVsk6OI63cb1vNUKO4aJ2PMBkVfhCtFnv/MrgaU6DiFMSY1EN/y1bewJEuAuM
 V/pR5pymc73CxynpsovXpC5/ZI/Oj8sbokScdN1kzWaAB3yT8peo+O30EoBSYTHsIsqa9IQmPYg
 BYUQijAruRsUZSEryhZ6fzkORSCgLwOybPHyDnH2R9/X3D6kPKbWy6pmykIgBmhT3naAmST8OCI
 NImX01TPKexKmvPOdH7CPhsVlePdNxGSTrNTQyb+r5Q54fJhHkbtUj8YVld+gWAl+9nPiM1p9n0
 Yu62rS2wnGnUFsmqi8JCYFBPgf0CIOeR1AvP7UXQQAHmWuQnpsitW63xY6wQFdokQeRgBN2Os7P
 1nTgADOfGsTiEW3gSMVpCsdCAWZ2trEgG97psefL0rVStuP+u57Y5BbocX51Td1UBy/t10oa37D
 sOgtvz5VhgPgL906ihmIeOQuytLnrwaHY5HFoV0a1Kq4RZzxnsxulT2gPpQK637zBnms2K+peAO
 rJRN7pdFSYS9Ivl2WwkwBAAq4AA4LLMEYu07EjvR62Qn1tYgQsaijHeFrWoEoqze8Awa66tXqUa
 VgwdA5aLpP0UFNg==
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
 .../selftests/drivers/net/netcons_sysdata.sh       | 166 +++++++++++++++++++++
 3 files changed, 184 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 469179c18935ffcc12b979ccdc9f84e9d4082b90..1ff5dd076340433ce29bb175b95ba4c6683c2846 100644
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
index 0000000000000000000000000000000000000000..b569efc07361780c85d64c7ca89c1b4b188945bc
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_sysdata.sh
@@ -0,0 +1,166 @@
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
+	# Listen for netconsole port inside the namespace and destination interface
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


