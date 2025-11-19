Return-Path: <linux-kselftest+bounces-45954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA28C6D3FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 08:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11FED366FB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BBE32AAA8;
	Wed, 19 Nov 2025 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsqSWJYs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524632937F
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538578; cv=none; b=T4WIPu83RejBmmWsw+frXboUJ45oud6gwnLMq8AgZPiZr9iJ9grEf5xAFLNT7UzhV/330DJ1LZ3XCsk9e5QQ0mKlCP8ZhW7VLP62AVRRKsp54G0teDGXtskzQUkMuiCQAUcUFB9tzCPsuRdlY7381B/Ofilpex25BCYtj6uIk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538578; c=relaxed/simple;
	bh=PJbVIE+FjlqZXAqh81T+nKN+VWQTjy5oRGltePRw6wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxtRNJ9n/5ODve67sqe5Y4LeJwcEqDxLbWhaBf/5SaDIJeE6fzUzmGmARTzuv18Asu9RKbdiJZesvESVaHualInmEiiYxRo8Pi8EiCK72i4GkWLEHuWY8S6yTmfPsw9tBbKNwPAPGPLGW4mSnlxuvME4+NCYnO30DIHYYxvggqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsqSWJYs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso4090424f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 23:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763538574; x=1764143374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YO8hwlO2C7MvqjPC6EcWcIdUphHn/vVfWOEg+rLhE4=;
        b=MsqSWJYskP0psn59XxmZ7fbHIW18kVKs1jBUIh+Wglqztw0m9QzkjtBpd8N93QsYgx
         BCXkaoLOhjF9juCJIxnd515DCycvvSBitnDk6Ns2jhk5MwxjGDxQjmhQ4xWRHB82iNvf
         DdFtcfIOSfch8bTCNigj314SR/XuUXV4i7HA3cT25uiFWa92f/nqG7mpyXRtrBRQKlhO
         3tA7QQRee04pfm38e4LseCuEZL7Dl24HR0b9yMZ05g6caqOEUnSBjySdlvaKUUhsf+C9
         Ob6R1PZNK3eS+k5TptdZ+x5djKteG6tPnJVg/F+Gwq4lH7z+OUlheo6KCmW/1eOAa0d4
         DtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538574; x=1764143374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3YO8hwlO2C7MvqjPC6EcWcIdUphHn/vVfWOEg+rLhE4=;
        b=XvucDksLXfpym+XNGGrz7tt4PTLEIz3/uoKk/7NuOtz5MyozHJg3DHRsEs5uRxpIdZ
         2cjTqFchn7jyraEcHrX2/jw17EjgKlW5e1XDAvcGN0HteS7pkk4gei+GPWTvXkLSqYHc
         bTJQvrsSuH38TKKQO+oy0CSDcbm+oAUYJIX79vFBcoYx0IHRjSa8SQQCTflXLvMrZj7x
         3l2zv8nH9zdVyWxNoOezMTRotTlXuO7/0ZkCO6xLvn8+/8f/3D+D3vxdVakUntdtW8Cg
         Mkk2RDOCx4hgBaj5nNt+T6WAvhpp5yOnEqXvKhwkcErhBmffJ8qv9JZBMa26TZl89QH+
         c78g==
X-Forwarded-Encrypted: i=1; AJvYcCUhq0V3/hVY2tivWvCKd+6pEeyKZ4wkO22nYqFj1427mA9/+INP+qHLLkOrpTnwTYnNocKHAC/qIvO7HrMOxKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRh5GFLlBhL/5nZzSkCxpE/Y/zDN04+vMOYYu2decY5ANvrrB
	W/SSpQs+QAMA1QxFY3A/S6GJ/W89QACSR7n62lD31+HUPfk77GS7B4bsWTqXGgTGNUM=
X-Gm-Gg: ASbGncvez8AHhYlnu4KfXdcb4696baMbJKNf2uDycrHcIv7s+2J4XGXWnuwk8amUPFc
	i2jAwadi2fYjJVgkxC5rDyMJnQArVO2TNOufrKMSSkuKGxB9y/cwE3g3eR4Z7Q7SIF8zWD41HE0
	l5MbvBN3VHwbhQa6aI/XODBVbXF+5EBWpCyL7UQ2F2wECFQURybbXXkf7qUoCdAmEUQjyuDuYF2
	f3bapJS/zAUa0kx9LAmbbfMTQ1jXgfURfJDQHCsspXdvAesN87bKeOhYNIzlcG9W7fubLLG5lTC
	5KbfUfYdQ7FdeExg5YHJ+V3BvI/f1/DovjVW55gp+/Qof5jyrh8uREUvwoVG4wMONrV5SniQkue
	wnojTf56XraKQhFwmD3o6oxfccXF06zwhiPFC9X8uiVYuDA/uTxXNkluXEB63wQyyE5XyMiBoMQ
	MONTBVfcmsthV4e9wmocyZ80auh++3PmPwNpJX
X-Google-Smtp-Source: AGHT+IGPDf3n7yw9tmvx3mRMsXmrPnlbEY7oesz8TUWhArbu2lVE770zOvsQLkEdWQLuDspCZ91xzQ==
X-Received: by 2002:a5d:64e3:0:b0:42b:3592:1b92 with SMTP id ffacd0b85a97d-42b59398992mr19426502f8f.47.1763538574344;
        Tue, 18 Nov 2025 23:49:34 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37461146f8f.19.2025.11.18.23.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:49:33 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 19 Nov 2025 07:49:23 +0000
Subject: [PATCH net-next v5 5/5] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netcons-retrigger-v5-5-2c7dda6055d6@gmail.com>
References: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
In-Reply-To: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763538567; l=6488;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=PJbVIE+FjlqZXAqh81T+nKN+VWQTjy5oRGltePRw6wo=;
 b=3e3WCZ8bN9e7l+IkkBwVS0veQgRbSFvgvYDsAXZseHDhoWoDryCb6ea8Xq+nxulgDN1iEOtph
 8lttF8bxPr8AEN3OkDmGiY36oKaAFTA97/R4KcvPMGszKou6zzbKryw
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce a new netconsole selftest to validate that netconsole is able
to resume a deactivated target when the low level interface comes back.

The test setups the network using netdevsim, creates a netconsole target
and then remove/add netdevsim in order to bring the same interfaces
back. Afterwards, the test validates that the target works as expected.

Targets are created via cmdline parameters to the module to ensure that
we are able to resume targets that were bound by mac and interface name.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 35 ++++++--
 .../selftests/drivers/net/netcons_resume.sh        | 97 ++++++++++++++++++++++
 3 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 33f4816216ec..7dc9e5b23d5b 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
+	netcons_resume.sh \
 	netcons_sysdata.sh \
 	netcons_torture.sh \
 	netpoll_basic.py \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 87f89fd92f8c..239f44d4a45d 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -203,19 +203,21 @@ function do_cleanup() {
 function cleanup_netcons() {
 	# delete netconsole dynamic reconfiguration
 	# do not fail if the target is already disabled
-	if [[ ! -d "${NETCONS_PATH}" ]]
+	local TARGET_PATH=${1:-${NETCONS_PATH}}
+
+	if [[ ! -d "${TARGET_PATH}" ]]
 	then
 		# in some cases this is called before netcons path is created
 		return
 	fi
-	if [[ $(cat "${NETCONS_PATH}"/enabled) != 0 ]]
+	if [[ $(cat "${TARGET_PATH}"/enabled) != 0 ]]
 	then
-		echo 0 > "${NETCONS_PATH}"/enabled || true
+		echo 0 > "${TARGET_PATH}"/enabled || true
 	fi
 	# Remove all the keys that got created during the selftest
-	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
+	find "${TARGET_PATH}/userdata/" -mindepth 1 -type d -delete
 	# Remove the configfs entry
-	rmdir "${NETCONS_PATH}"
+	rmdir "${TARGET_PATH}"
 }
 
 function cleanup() {
@@ -377,6 +379,29 @@ function check_netconsole_module() {
 	fi
 }
 
+function wait_target_state() {
+	local TARGET=${1}
+	local STATE=${2}
+	local TARGET_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
+	local ENABLED=0
+
+	if [ "${STATE}" == "enabled" ]
+	then
+		ENABLED=1
+	fi
+
+	if [ ! -d "$TARGET_PATH" ]; then
+		echo "FAIL: Target does not exist." >&2
+		exit "${ksft_fail}"
+	fi
+
+	local CHECK_CMD="grep \"$ENABLED\" \"$TARGET_PATH/enabled\""
+	slowwait 2 sh -c "test -n \"\$($CHECK_CMD)\"" || {
+		echo "FAIL: ${TARGET} is not ${STATE}." >&2
+		exit "${ksft_fail}"
+	}
+}
+
 # A wrapper to translate protocol version to udp version
 function wait_for_port() {
 	local NAMESPACE=${1}
diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
new file mode 100755
index 000000000000..b9f2d5a7dc59
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
@@ -0,0 +1,97 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test validates that netconsole is able to resume a target that was
+# deactivated when its interface was removed when the interface is brought
+# back up.
+#
+# The test configures a netconsole target and then removes netdevsim module to
+# cause the interface to disappear. Targets are configured via cmdline to ensure
+# targets bound by interface name and mac address can be resumed.
+# The test verifies that the target moved to disabled state before adding
+# netdevsim and the interface back.
+#
+# Finally, the test verifies that the target is re-enabled automatically and
+# the message is received on the destination interface.
+#
+# Author: Andre Carvalho <asantostc@gmail.com>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+rmmod netconsole 2> /dev/null || true
+
+check_netconsole_module
+
+function cleanup() {
+	cleanup_netcons "${NETCONS_CONFIGFS}/cmdline0"
+	do_cleanup
+	rmmod netconsole
+}
+
+trap cleanup EXIT
+
+# Run the test twice, with different cmdline parameters
+for BINDMODE in "ifname" "mac"
+do
+	echo "Running with bind mode: ${BINDMODE}" >&2
+	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+	echo "6 5" > /proc/sys/kernel/printk
+
+	# Create one namespace and two interfaces
+	set_network
+
+	# Create the command line for netconsole, with the configuration from
+	# the function above
+	CMDLINE=$(create_cmdline_str "${BINDMODE}")
+
+	# The content of kmsg will be save to the following file
+	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
+
+	# Load the module, with the cmdline set
+	modprobe netconsole "${CMDLINE}"
+	# Expose cmdline target in configfs
+	mkdir "${NETCONS_CONFIGFS}/cmdline0"
+
+	# Target should be enabled
+	wait_target_state "cmdline0" "enabled"
+
+	# Remove low level module
+	rmmod netdevsim
+	# Target should be disabled
+	wait_target_state "cmdline0" "disabled"
+
+	# Add back low level module
+	modprobe netdevsim
+	# Recreate namespace and two interfaces
+	set_network
+	# Target should be enabled again
+	wait_target_state "cmdline0" "enabled"
+
+	# Listen for netconsole port inside the namespace and destination
+	# interface
+	listen_port_and_save_to "${OUTPUT_FILE}" &
+	# Wait for socat to start and listen to the port.
+	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+	# Send the message
+	echo "${MSG}: ${TARGET}" > /dev/kmsg
+	# Wait until socat saves the file to disk
+	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+	# Make sure the message was received in the dst part
+	# and exit
+	validate_msg "${OUTPUT_FILE}"
+
+	# kill socat in case it is still running
+	pkill_socat
+	# Cleanup & unload the module
+	cleanup
+
+	echo "${BINDMODE} : Test passed" >&2
+done
+
+trap - EXIT
+exit "${ksft_pass}"

-- 
2.52.0


