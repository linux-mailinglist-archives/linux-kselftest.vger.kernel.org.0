Return-Path: <linux-kselftest+bounces-34723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E318AD5881
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443A37AB516
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EDF2C3249;
	Wed, 11 Jun 2025 14:19:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8A02BD5B4;
	Wed, 11 Jun 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651561; cv=none; b=dfgI9rwif/Gt7BoUnGMVYTk4fIhILp36KhPPFblJAPL2/yMzmkT0nV70ILys2VRxeX84wXUsMJSS8GI1sy4ivHMMeuW9BmjZE+KUfJCxrJI/3sC7L1EkP5BdAdP0lVn3SxuQEFPpCK7Zwge1SygSaDsxMFG1X6uwLDk1uGvitTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651561; c=relaxed/simple;
	bh=90WOkJyHZWryshNeI2TppKcZTUgW1razEou2DXt0DvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBSOXPoYBxtBL/VTnOT1QSXNXRyn7FmGNd+49nEumdDVBvzrDq4zNP6AAknWRsXPXk+zEIgSqI9T5slZ6aLURxhyvHgoMgAGVLG/3lSLFz+h/6fcEGKvoK++YbDLi/4SxMNluk6JPLAwwRCdjw0Pe3XVuHCQTQURrNnoNH4W94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so10338648a12.1;
        Wed, 11 Jun 2025 07:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651557; x=1750256357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A7oozekEJYmGg//Ai1+WY03klz1mRrkPiqnVnqyjj8=;
        b=pLjtztqJaF2rOZsjVRV7/Ea5ANLvO2QnBSi3JE5BVfujSFLE+NNNfOBDdV+N/eM2Pv
         JvJeO8nMJojQp5tybxQU/T8It3jPeq/njQrxE8w+c2r3lsWcqzLofcUtI/oKjB7jzf/Q
         PKwgOXLjnyjGydPs7HoM0DBcjQ57y38wAx4CNTp7OuEl6CyQfDBUYdthhxjmyFdI/UTv
         xSbS7agmH2bqMEpHzJbT0bu+JOu0IbQMkXR/3txz8NM9j3Vqijzrd/CUPKooRwu2GmCX
         MwK+gAIPqI0PJaO3yA5sLpw3B8zEJTpLwVdeDsJgog1nzHCjsWDXEMiAMCicKyqiak2s
         G12A==
X-Forwarded-Encrypted: i=1; AJvYcCU1IT9zD7cHs43dAT+Be4JarZ2WSlU6XHQUsrXBV+o8IS7FQyaafBmw52kPiBDNTxmPOP6EU6lo9qPwKPKbsl7R@vger.kernel.org, AJvYcCWoDQSrHkNk3/oHUd6uv4RSw/8OrqMAsVpoqY1fqrvqqvGxBwvrj1MgwsiV0U/s5kJFLF8jcPBB+LzKQ7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdw5W20qm96Z/Yu6maEgXJW6QH1BfzaBPKZ5b7/fksWQbyyGHq
	hyPL5XCTqdHLqslXYeQAyGlWouTq/qjQ58xLz8B3rXnurBGcB7/1aPhn
X-Gm-Gg: ASbGncubNCcSVR7BtLZk3/ZqWKJMp0WnKm7MjP0vAjLw3lLtKn3pGprXJJCEr0/Ty27
	GhfRdkw79oT1lrJ2zR63SMAcZA2ycblW65Wcjt6b7D+XI4Dzx2QyQ9b36JUeK/nwOh4H5bagwDh
	MQAaufFPw1cb6ah77zoVu7S0LSk4TTaxRiSfjUg9TCa6EozrctVNRJ4BG9h3nX7Hxmcju0ZHr96
	DseKAP/P3qYxSXp+veRJ0jVEQP9XkNIufv5ACohgVkRlWBrJrsCOJJ5KZgCm5UlXNGDecz3hRB9
	z4Z7H5xTwphsVtzFvJWx48/c/x5A/5gBW2kp22VjxWOWdpUuEPWaS68mQedFFxRf
X-Google-Smtp-Source: AGHT+IETa4xhReJhKDmZM1e934PAkGpD5H8063zemDow5kIUu7EkO4GS5Ufvv7401dXPqPBsvlX6Yw==
X-Received: by 2002:a05:6402:3593:b0:607:ec18:940f with SMTP id 4fb4d7f45d1cf-60863820789mr4290a12.6.1749651557147;
        Wed, 11 Jun 2025 07:19:17 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783e66f1sm7555596a12.79.2025.06.11.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:19:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Jun 2025 07:18:56 -0700
Subject: [PATCH net-next v2 7/7] selftest: netconsole: add test for cmdline
 configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-rework-v2-7-ab1d92b458ca@debian.org>
References: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
In-Reply-To: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=5924; i=leitao@debian.org;
 h=from:subject:message-id; bh=90WOkJyHZWryshNeI2TppKcZTUgW1razEou2DXt0DvQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZBZyOhAItP32l3C4x9fWH/Ae8HGu8tNABH3R
 d0w+FkVW5CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmQWQAKCRA1o5Of/Hh3
 bfRCEACwVxEBb6gqTC/BcAMG8UTMlkNCRtpQvzBPd31Iw3Nsnzfg45JVhISoYs6qD0stdIFY00R
 PZbvHuGrX1lARMsqIjFGW5X7q6i0XxHMDmVQKgTVyfQ4PpZXR7pLZDKDseE1vhWKspsF57zGQsF
 8kVhvBG+0Q7j0MTAiz0AwmNIAjpriXf2EtTxXo7ZYurT37TmOnpykhEqw9Na/CFGcoBj7/83Z75
 FTt7telyEeHsiPfjZkxqjTzLX+USwGdgNgSvVehGEr9eJCnoR+0RmqevFYxYVmVZA6ckR2hLO9R
 coPV5IbMmgIKPhAn0XpF6IA+5xj9RH4/lG6h1BbcJJirEIR3DKXCO9jb1kIS/94BvEqdjdE15pQ
 X2unvUGCsO6h9KcJw4AuNuMkmW9H0zlEIhJfzezzBpC89e1qA1F+icx2AUWuzkH0N81C6pxvIjk
 PsF/BKxVeLAxdaPSnvJVL6HlwAyVU0JLcPHtjxUVrUqY6tcBJ/pqUCw9H4UDPUIR+3P9PVdfayi
 7NvFPne9qyXGoM1M28YPh19cJD/X0c6U4qMnabfKS+HFAIs67kJRsYDNAsyDRiu9HvzgXi/ApH3
 KrULEmxdZHVCaV+GwoJiokyPnJLN4eTHlX/FXgRMxxhcJ5rh6vt4sLm3ZaIAXbt659X8PY8t54c
 XfdQYT1NG39ohRw==
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
index 71a5a8b1712c0..42fd458be56c9 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -121,6 +121,17 @@ function create_dynamic_target() {
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
@@ -169,13 +180,9 @@ function listen_port_and_save_to() {
 		socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
 }
 
-function validate_result() {
+# Only validate that the message arrived properly
+function validate_msg() {
 	local TMPFILENAME="$1"
-	local FORMAT=${2:-"extended"}
-
-	# TMPFILENAME will contain something like:
-	# 6.11.1-0_fbk0_rc13_509_g30d75cea12f7,13,1822,115075213798,-;netconsole selftest: netcons_gtJHM
-	#  key=value
 
 	# Check if the file exists
 	if [ ! -f "$TMPFILENAME" ]; then
@@ -188,6 +195,17 @@ function validate_result() {
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
 
 	# userdata is not supported on basic format target,
 	# thus, do not validate it.
@@ -263,3 +281,12 @@ function pkill_socat() {
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


