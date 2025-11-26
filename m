Return-Path: <linux-kselftest+bounces-46573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1376C8BD68
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 21:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21BDB4E7F68
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF9343203;
	Wed, 26 Nov 2025 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKFzQj2D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E1345732
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188621; cv=none; b=G6gz0stgHUuBZkywzOmpBGB02rv01hLMxveYb5zJ2QD87x/bLc1b101mFSVREYmC2B6QrpIcycwnEDikRu/ch15Ttg5afTZ3G+ePsOtDT1kRGol1HWz2agP7rOLn90UYeED5RU15MljqyJRCzj5PxvQeWlu+UEmWJmQw07F2PhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188621; c=relaxed/simple;
	bh=hn/kxg8v9iI6fPhbZcD8Tj+G//s0QmgoWLVA/hu8hV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgG8G4s7W5fDb2M3oatYgpF2xEjsdoPXfTmhmB38PcpWvv3uzkCgkWU8MHWScgUSsEUNtQRRHWHudrabtHJ4YYUiOark1y5BTvyC0Lm3a4AFQGiTeFGMxmwmnR8HH23KvxeOMWcGwfC8zdKgSeL7nBok3Z5m2zqKI3Ale/zXHXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKFzQj2D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29558061c68so2467435ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764188619; x=1764793419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/fAPe5zn1MJUzjr0NdBaLTd5ohKsQq+JKoQHPiFo9E=;
        b=ZKFzQj2Digx3P0D2Z7pBMXWp/dNP2V2Z6OTlQrNWtxCu/Z/KXT+f/Ak11S/DyxRFti
         Mkyf7wlbwXBZThFRG43mcDnvqWbcAIWguMqRtYaaaf0qdSSAZLnthzscgwkVFwTWfSW0
         bME+nvfw8KAJQ6N6Qw+VBQ4bsAiXFZWpHL2f+0x+5UBsPEyOY1QRkiBM7t3R6teRwmN9
         kSgoIK41KzfFSl2HKt287WF64O+uGWU1JcrmI2mpM/MuKdnHAb0ZmSaTgOLHRZM2Rq8k
         B8ej8g42RUfWvShHNhTDIgKcERsYU/fZEW47xf/AawM2B/Od/KimisAW1QY9zTyFzepf
         +KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188619; x=1764793419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3/fAPe5zn1MJUzjr0NdBaLTd5ohKsQq+JKoQHPiFo9E=;
        b=ZEX3uN8/tTv0TR1ZyQyejvU3XKQgUz8FEG9vRtmkcWZ8MN6RHJaUUpFnbo7EH1kEPM
         B9VSJqV1o4mK+jeirPXFooUcwT27Dt6xtLNV+6Xi3PE0y5lJxD6GmAF128jjY5WTFmb7
         oLBRUpF70uvroJWeVGfwRS3WK8L7i8ghk73hMIc1/x/y1v9zwmBITSgq2Qdr/gfJqy+8
         wBVv9mgAbSp17KeJeAuoIaF7FfD+zi8Tt3MdaAUfucFcwPj0WrmGOsdKS3q0ILjrrEAF
         t8lPQ+Vd5K0vw+2vUKIloli8db6M4rS+lmIjhBcYexDWhUPr8i983AZfuwA+XshumqLO
         Ttaw==
X-Forwarded-Encrypted: i=1; AJvYcCXF8pcOc9CVLdJPP7N1SGS5BIjbvl08wnSe6HjdWXNM21mOiB0Vhew7yQY0XxeSDq+H5z30HjT3Nt14eewgANU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKrzCXHI71VXqMzLat2TVt8YXtrIcHfQe01cIFiAAEkPIJY77
	I0giPQyu88VaeGgzKlrgWbkvIIjAy4qxpOowBOopPmL4Dz325SE9oVAw
X-Gm-Gg: ASbGnct3gWvDE4jdf8On/s2HxV0Se9FrdYTV2Mljmmg5nIps6Km9QXhq+iqlTlfQDLZ
	sdhGwX+Tc8mXETIjEBNZ6B5rXeJpoO/yK0RSAF46jrchVubrfvG/E3LVyxJNCqEjEnwFmgfddpC
	/JVEaTbnFAUX7abmy8HGrR34YXGD7sEngyMhlcDe3ww0oGnak3mVFyIErKD2h8F8tY/S3hOWRMV
	mRi0U2zJtB+l0d9fq2mGNLXuk0aXUxdE2cZxckWsMiC600pOS0ZzdJncqKN/+/Cmh2CK5R5o4Yb
	3FOQzkTZ+rAGPBL7rx6RMACshiKrHGNfxtJP+i+zgNW7Kb84Nb8WrLtA86iHav/w8n9m1D0r3hJ
	CcMNbbe3iL0WPdGPN4gafInC4gmaCobc44ipmETKFguHeresTSWjUhisBXyGuuztTDqCLcEuXn5
	bymF9Oo62DiREQdapoRQ==
X-Google-Smtp-Source: AGHT+IFlWVMX3M1sh8LmYCCM96cdfdCDdGHZ43sVYm0HSHzwk5bsC7hG9uCm6tFdUOBtcUGMxFtFNA==
X-Received: by 2002:a17:902:ccc9:b0:295:596f:84ef with SMTP id d9443c01a7336-29b6bf3b5dfmr273525865ad.31.1764188618591;
        Wed, 26 Nov 2025 12:23:38 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a80csm207100475ad.35.2025.11.26.12.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:23:37 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 26 Nov 2025 20:22:57 +0000
Subject: [PATCH net-next v7 5/5] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-netcons-retrigger-v7-5-1d86dba83b1c@gmail.com>
References: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
In-Reply-To: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764188576; l=6537;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=hn/kxg8v9iI6fPhbZcD8Tj+G//s0QmgoWLVA/hu8hV4=;
 b=Gc3qQzJVfojty4M0sdLaLerlkNhNULg2fnhRj1y77ELw6y2fb0ILQ+09aIEBjf8I7ZIWElEQx
 5eOQj2mprGFBHxjLaoA+n/SVCCKN3YRHvhFzWwqac6aJMa6RVdlusEM
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce a new netconsole selftest to validate that netconsole is able
to resume a deactivated target when the low level interface comes back.

The test setups the network using netdevsim, creates a netconsole target
and then remove/add netdevsim in order to bring the same interfaces
back. Afterwards, the test validates that the target works as expected.

Targets are created via cmdline parameters to the module to ensure that
we are able to resume targets that were bound by mac and interface name.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 35 ++++++--
 .../selftests/drivers/net/netcons_resume.sh        | 97 ++++++++++++++++++++++
 3 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index f5c71d993750..3eba569b3366 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS := \
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
index 000000000000..383ad1149271
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
+exit "${EXIT_STATUS}"

-- 
2.52.0


