Return-Path: <linux-kselftest+bounces-34605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C4AD3CE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93630189C82C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1FB2475C7;
	Tue, 10 Jun 2025 15:18:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BEB24728D;
	Tue, 10 Jun 2025 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568718; cv=none; b=PQmK8kTBiipNKAzAxz0PPUBxiUdWjlWy0xSVY1t7QDa/VsR7FuV85Y3CoQpX+j7tNgJQdYyCFYGNd5vxvZB32tjD8kBsch4jr964CshO3toI5v9wG3OP2jmrLT/TMUfDLxPbi5/J6kTH/v9TVXMLcxX6yNpkf4iad+4Ud4Sd8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568718; c=relaxed/simple;
	bh=hPZb8Nw1IuP4F5I5h55bS2jnLuizM8vNJnpbTBELM00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BVdZTLkxRWaOMUzQXox5b4sJcHbjk871Lr2RuQ0a361C0ZGNHDYDOCInQ0ZsPK02prxzTmEuQLWpAARlREkQgI767dpvuSVPwi8NBahNn9lwrg8UntqdX1r09XqtVxd93IH4gCqYVNtICYSphsq764BZGTB6p0ot8pSCQWDTARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade750971f2so161084766b.2;
        Tue, 10 Jun 2025 08:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568714; x=1750173514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4cUGNOuwVhN2a6Wgm+mSMUHrtnStHJlUP7RSdOBQSk=;
        b=JUHQTPU9AdWV9bll2T4hiBazUjnwsBWoQBM1FjNayF0zuWUGeRKfItRFEzstFpT9ZC
         EMvnDI5dfqLr7yy5mEkZGR7dsrXBP8NS42175IhcWjCNg/enZtoBOP/djABvbxbSwhIM
         UksMB2vqSpsJP/kF3jcA0Susxvy0h5P0n7Y54dzOrhWptcDmZQE6lOFGv8SVknLgZnBc
         M1HBEs55Hg/nBSNj1yqxUy4yhReEKRkDIdNsGEu5N9YEIZyd6qdrV2fSGDsFrKLbz0pR
         ObizNsjkFnFw6EG9O2Pbz+ZEfees5gmHDEFFG8P11hTLKMr6aV/WdGda6AYRCaJBHlYU
         pceg==
X-Forwarded-Encrypted: i=1; AJvYcCVkCtkD3WzJt8xZzEbNgtARx5ya63BYxhP/UAloDruuoQwOoaqfELS6alDGJNTuNGUakDVI+E8Pn0UyS9yVOUwn@vger.kernel.org, AJvYcCWK0gmJtZjgzxtpKCqlD4yg78j2bD6u/uXhsjTkNealQVvLRPOWTTCAXFlhAFiPnnrdVhzeZuNl1n3wygg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLAYrg2FOVFh2imSyblhenwkiqMRPRboBkCo6A0E1i84/BJmZ
	GbEIRkgz9FYi1ZQIuoPJ5tRP2SN83ktTewtmNyQ6eaELTWaXWlQYJRf4
X-Gm-Gg: ASbGncv9aV/0JtIEgxY9CtdLS5JYA3ElIYPume4GEho+KT5XWz/UWJZ1C/RdskF7cg7
	dVhup6fafY5BMurLwZ18muaZjLwB7hQhZc+PXmUok+2jK3UIFjz/hiMFRfa2LP0A/xB+DrOFwyb
	tiGp3vXBjNi0NcFlKwxYy04g3c24zM9I8PPgKbhBzFV83rcV8k4ZwxNZNvnTzmwKautHQosNWi7
	6R3VatndKgKRMyNSjTznSrMkf1S5QTd0n5OZ3zKG0SxmfMUkq7trB6Qv8N5Tx2MZzF5fmXESBe+
	vpuacJ0Lkno29PLs3VG+TG2aPNxia/IxaqoiK0LOF8GQd2wUAaCX
X-Google-Smtp-Source: AGHT+IGnGBT0yDRCGFnwgDaFrKXCuG0tFdl0+Y1Fdv0DP0GXVyOqqGUFOA4ckLxv5IDPmagvLUYiHA==
X-Received: by 2002:a17:906:dc8d:b0:adb:2a66:85bc with SMTP id a640c23a62f3a-ade1aab9e47mr1534646266b.34.1749568713962;
        Tue, 10 Jun 2025 08:18:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade343eeea1sm636189066b.74.2025.06.10.08.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:18:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Jun 2025 08:18:19 -0700
Subject: [PATCH net-next 7/7] selftest: netconsole: add test for cmdline
 configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rework-v1-7-7cfde283f246@debian.org>
References: <20250610-rework-v1-0-7cfde283f246@debian.org>
In-Reply-To: <20250610-rework-v1-0-7cfde283f246@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=6008; i=leitao@debian.org;
 h=from:subject:message-id; bh=hPZb8Nw1IuP4F5I5h55bS2jnLuizM8vNJnpbTBELM00=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSEy+3U7nbPd4IvWNtmUI4sfQZ5L151a93Wuxr
 tvLoIVsdAOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEhMvgAKCRA1o5Of/Hh3
 bfesD/42YmOcr2cmcrcIOZwSGJU74Sar6s2sMqctjxrP8QLrUX9be54e0Q1CUgjM34edM2Xp6ub
 B34nc3c3m2m3BlImfwI9Dun9t87Q6qvGQjW93bCSE+c84vba7wLSwFOAQxnx1gG27UWtKHjlQhk
 8g5v6KZVYBq242laRTWJfzFmiPl9Uo9jeIAjpluEwqVW0DUTM1eE2A1vu1zCIfHYFtV2u6VHfHC
 /ogoj4qd01IOKQLU1zlt/DoswSfgDToqzWmOI3yDPSbqmgK27gxiZsBAJEfUvM3WeewmTadLyem
 lqK+sSEzvAaf4/3Jy/S39DcQVsDaucDLiltNzoGhh7EyEvPGDk/4iqYOI019Skrk3NGjDsdAbHR
 vOSkgqiqDMHPYL4szbPYQeZO+CxsrANOn14W5gVph3Pti8+HVgcp1OL6wHaK2zdVn3a+F+diZYo
 Ss32/OGDHlJu40YRJczLaIRlRXcB44mOVIIMU36Kr9z6cmgxDnuPOjKisVIiboflgt+5wbQ9Grm
 nR0PXE9nhKtK1oasrcjOvuEUgLCXxy2VfrsbTv1G83I0L5216CabqGDVP+fJS2lkVa0kC8QIpzp
 2EaC/NVAaB6iiXJSO91+EKzlm3EUBr03+rydbd/3pmkukPh+PHrlF7/ZucK7968OT/051il/Vll
 CWyPsrR3TkCxNsQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new selftest to verify netconsole module loading with command
line arguments. This test exercises the init_netconsole() path and
validates proper parsing of the netconsole= parameter format.

The test:
- Loads netconsole module with cmdline configuration instead of
  dynamic reconfiguration
- Validates message transmission through the configured target
- Adds helper functions for cmdline string generation and module
  validation

This complements existing netconsole selftests by covering the
module initialization code path that processes boot-time parameters.
This test is useful to test issues like the one described in [1].

Link: https://lore.kernel.org/netdev/Z36TlACdNMwFD7wv@dev-ushankar.dev.purestorage.com/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 39 +++++++++++++---
 .../selftests/drivers/net/netcons_cmdline.sh       | 52 ++++++++++++++++++++++
 3 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index be780bcb73a3b..bd309b2d39095 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_FILES := \
 TEST_PROGS := \
 	napi_id.py \
 	netcons_basic.sh \
+	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 29b01b8e2215c..bacd98c7a9eb6 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -109,6 +109,17 @@ function create_dynamic_target() {
 	echo 1 > "${NETCONS_PATH}"/enabled
 }
 
+# Generate the command line argument for netconsole following:
+#  netconsole=[+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
+function create_cmdline_str() {
+	DSTMAC=$(ip netns exec "${NAMESPACE}" \
+		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
+	SRCPORT="1514"
+	TGTPORT="6666"
+
+	echo "netconsole=\"+${SRCPORT}@${SRCIP}/${SRCIF},${TGTPORT}@${DSTIP}/${DSTMAC}\""
+}
+
 # Do not append the release to the header of the message
 function disable_release_append() {
 	echo 0 > "${NETCONS_PATH}"/enabled
@@ -157,13 +168,9 @@ function listen_port_and_save_to() {
 		socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
 }
 
-function validate_result() {
+# Only validate that the message arrived properly
+function validate_msg() {
 	local TMPFILENAME="$1"
-
-	# TMPFILENAME will contain something like:
-	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
-	#  key=value
-
 	# Check if the file exists
 	if [ ! -f "$TMPFILENAME" ]; then
 		echo "FAIL: File was not generated." >&2
@@ -175,6 +182,17 @@ function validate_result() {
 		cat "${TMPFILENAME}" >&2
 		exit "${ksft_fail}"
 	fi
+}
+
+# Validate the message and userdata
+function validate_result() {
+	local TMPFILENAME="$1"
+
+	# TMPFILENAME will contain something like:
+	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
+	#  key=value
+
+	validate_msg "${TMPFILENAME}"
 
 	if ! grep -q "${USERDATA_KEY}=${USERDATA_VALUE}" "${TMPFILENAME}"; then
 		echo "FAIL: ${USERDATA_KEY}=${USERDATA_VALUE} not found in ${TMPFILENAME}" >&2
@@ -246,3 +264,12 @@ function pkill_socat() {
 	pkill -f "${PROCESS_NAME}"
 	set -e
 }
+
+# Check if netconsole was compiled as a module, otherwise exit
+function check_netconsole_module() {
+	if modinfo netconsole | grep filename: | grep -q builtin
+	then
+		echo "SKIP: netconsole should be compiled as a module" >&2
+		exit "${ksft_skip}"
+	fi
+}
diff --git a/tools/testing/selftests/drivers/net/netcons_cmdline.sh b/tools/testing/selftests/drivers/net/netcons_cmdline.sh
new file mode 100755
index 0000000000000..6d743b6e4922b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_cmdline.sh
@@ -0,0 +1,52 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This is a selftest to test cmdline arguments on netconsole.
+# It exercises loading of netconsole from cmdline instead of the dynamic
+# reconfiguration. This includes parsing the long netconsole= line and all the
+# flow through init_netconsole().
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+check_netconsole_module
+
+modprobe netdevsim 2> /dev/null || true
+rmmod netconsole 2> /dev/null || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# Check for basic system dependency and exit if not found
+# check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace and network interfaces
+trap cleanup_all_ns EXIT
+# Create one namespace and two interfaces
+set_network
+# Create the command line for netconsole, with the configuration from the
+# function above
+CMDLINE="$(create_cmdline_str)"
+
+# Load the module, with the cmdline set
+modprobe netconsole "${CMDLINE}"
+
+# Listed for netconsole port inside the namespace and destination interface
+listen_port_and_save_to "${OUTPUT_FILE}" &
+# Wait for socat to start and listen to the port.
+wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+# Send the message
+echo "${MSG}: ${TARGET}" > /dev/kmsg
+# Wait until socat saves the file to disk
+busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+# Make sure the message was received in the dst part
+# and exit
+validate_msg "${OUTPUT_FILE}"
+
+exit "${ksft_pass}"

-- 
2.47.1


