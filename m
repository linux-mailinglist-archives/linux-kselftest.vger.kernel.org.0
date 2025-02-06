Return-Path: <linux-kselftest+bounces-25909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5EA2A6EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DFF7A3FE9
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56B522FE13;
	Thu,  6 Feb 2025 11:06:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBD22FDFA;
	Thu,  6 Feb 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839981; cv=none; b=lwSs658WsDqVQxfoV33nmQZgBDKiP+XUl7W2nglStXg+5FPY7uhR9bGljm/xrHAZ5LutEg+jviUVIvCuI/oN8GCraP3Vmi7mliHsSSbgKL4SqW9XcJZ41RvLiY4geHVASzbOkId8JiBCVaqYhW9WSBOZoVBDHEexaX87fUr+9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839981; c=relaxed/simple;
	bh=EWk2ay0albPWO0VUzwfvd3FuxFeaTYfwca4yspDY4GM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uiWEqkx44Puh7K3pIHjCNIESeFyhuhc/sZIhMCSXJXPJm0D0ilAm1RYUlRKO2th6nf7y47K8gsTTYt+10oYkp0W68msrB8DdW/Eua7ZhiqShu2QcCk8nQp6qyyzh0DfcncNQ44GFQAxtuTL/U37A5KkrrdJymZvz4ls+JnJtZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab698eae2d9so144327066b.0;
        Thu, 06 Feb 2025 03:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839977; x=1739444777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4lbmitZAUWzZsnieUUQwDFzsIag16/ARHCo65YqC7k=;
        b=LTM16u84GPge0C6kT6Wb7iiPHqPknW0Kj1nXt2LgbZJddcVtrC1qXfJquN4RpNB6Un
         3IZv/k4sWNOrFDIOTB/s6kq5qRjyR6NDMUc0pLKO4W4yJyD/NmwtVeMglKZQi0Cbw6Yj
         vRyDV9Iwa1C6MX2ka5y0jrCc4mUmULkE63fW1/IxITQBVok2HQH5YRsXkojLdVVs0LQt
         ZtR7n1vBYgP+c7bkKBhWLoXfQCyHfZ5wAd/zPOAU9rMM2Zuim6acayZMY5uRkVzeqKGB
         Q/rSRUYDPV7hAAJIM7+3twfi3Qmo2DoLbV3ubpUn+LP6HZF79zFp81CAi9b9jVBjDmhc
         seDg==
X-Forwarded-Encrypted: i=1; AJvYcCV+3riChSyYlyPWtW/MadyP9aEG1DewWL0q9XGpKkiDSFwh4PqeQi1pIcG79kDyNY3a/188P94TbFQ=@vger.kernel.org, AJvYcCWqG+v3QZwbU0bmLzakQRV9Mixd9WpZ+/Ur3nGPfeNilg6VpOxC3TFDBpRam5IKvMHIFf35iZQ7DG0zJOGubHoW@vger.kernel.org, AJvYcCWxknod9n4sXgPrwnqXgwQX8Yl6oOhEn3cYS/UWlCVQ4ELQN7G+kJuZPs4spI48fauhWjWfL3uJbDxC8ouX@vger.kernel.org
X-Gm-Message-State: AOJu0YwESb/7Wd3SkclsUgPueGZJy6zIwZq2jISHsJTHmjr5koTRwfhX
	qk56Rx7l254BORxUjczXpYRiEsQ/IvHRR612AvIBxvOPca1ofAFq
X-Gm-Gg: ASbGncuzwlRm9RxP3FTYguKcaucQLlbs5AkmSI7nyjb0anUAiwGNCMJUgY5OJfqC6by
	XBYg84wdVQuWHfwoHEDqQwhIrRALCllqCqhk6QDj9LT/uNFbWpMA4CEPfk6kGpmrii6i4rSVggg
	S+BrjsF7mkkj6xgl0GuLJcDYDamlJetnIsvhhJhI8LjMbxuxIbPWzHjrsDTZjVQNwNLigNmw/fM
	1aipstIGbS9O3uFDzWmFpUYkEEbt4tKwPsKgUbALLDIUURe23BUaycmxZE2QfF8pA1opgnhGNrD
	kB3/3w==
X-Google-Smtp-Source: AGHT+IFGhsz5+7kgfIZDY99QjO8pdL+augGLexBcLQ0bQftg/Zc2Eo5bX11/Iw+zA69dXn7JBR+Ebg==
X-Received: by 2002:a17:906:3857:b0:ab7:6c4b:920a with SMTP id a640c23a62f3a-ab76c4b9227mr330324666b.6.1738839976563;
        Thu, 06 Feb 2025 03:06:16 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e61d1sm81399466b.119.2025.02.06.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Feb 2025 03:05:58 -0800
Subject: [PATCH net-next v5 7/8] netconsole: selftest: test for sysdata CPU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-netcon_cpu-v5-7-859b23cc3826@debian.org>
References: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
In-Reply-To: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpJeaUSAo4i+K7MhatfW97K0yNTXh5oPZtS0MU
 RSwHb1lY6uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6SXmgAKCRA1o5Of/Hh3
 bZWCD/983gGwIsnoH3FeBJ82Kf3H5RrV/Vj4ZFTw0pbRHhtq1tGPrtNZOLbYChWPEfuonUCSd96
 QjR3CkSwgq+ciyAgky5up8zgXpm4SunxPTvHIsZmZ2jkogV0YgVopca4UF0KGv42Epxaoaykdxg
 5GPLBs+J7oO/g97pymmU5tRDCyTplcLhCjTqw0WgsYmVe4IsXJcwfb0fbmd72zrZhdVlq66z5Qs
 n9MzdrUVs8Uy9vq5gkUQnf3t9Mem6GSc0GHnSnPnZAF5gS+hFQR0KCPsabIDwaayygjrS32NGKa
 FKBLVZc5xgqEVbLdWGuJk4QOxwkeM9Ntyc9X3k41+qheylVpEjyX0Tuqpvl4LJiXI3+lwppfFkJ
 eltLXf0brq2Jsr1TbskeyZ8M4tIU0bITHNBsx8XMAYW48OoR/cl1fhSvhY8wY2fnZfdpSTKEES8
 KGKZtSlYMf+MBYVIfwgdJI+lX0zEmrQAfGF0y2NssH+c00U+1a8IeRZXf6xZIOPbyDtYQiRnKho
 ziC7tKqKjn84WGU2fzkwnEP9PLwQoHe5hzbQCtTvz6vNN9RcKKlyzFxf5J2meq1F65gMv0ndksG
 bWOrjuJMnYRknnm0aFG1KUFBh0IXR3ay/9dAROjRoMedEiiEUpbMo5lZDdeaZD5a4lwJxJS/Dnx
 +w50GGEpvOCAnqQ==
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


