Return-Path: <linux-kselftest+bounces-46229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A81CDC79122
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 13:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CAB2364792
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031FE345CC4;
	Fri, 21 Nov 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwPoXU4T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D917346A0E
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729391; cv=none; b=tk0/bKFt8Mb9mPKFeMhxKAF9hazBFEAWzVrY5S2yayHn4NJy9SmWKf/0zapitcNyp4tW9vXazoNg2YFDOLp1qoK8zBmIGLGbQGYWBSXYOM4K2tB5h3D6pa+FmTZ0IEnAOkkoY7uHPy3lpe5jd64Dn5BGPrrZfC/yvG11VN2c+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729391; c=relaxed/simple;
	bh=kqZWWvJE2+BeMA1UYo5eXs9VYYbgCijUdgI80CmasXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXPSLZ3qGegie3RLTFy3owHDypcEcFABpNtDuTn3Ek19w9gaJUEEGGyJQCajaf0emOBF37qg6teMbi8apIW4c9LRPMZh0xK1JdJsCAbki7KfQMoDKSe8tW2rYw3i/J7QchYfUOybDtSYj9JlOe4zZRY2qMm++B6oos9TuRG7QXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwPoXU4T; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2953e415b27so23509665ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 04:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763729387; x=1764334187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF9C7FxbCivSMf9nGQZ0aSleELaDVv0y36UrYer9UB0=;
        b=GwPoXU4T9XVozuqYfOoNXmHThFlsU3ozSNNX3pRVj9KFhDP6gHBhBFsChZ2inWODUj
         t6LWCF2PsosAm1YAn/Py23gGH4wsnl9BvDhvIZWBxZWvs0LSHhQ/m+kS5Ye2TeM+fgU9
         /pUJ7iF7XaRyxi8GX2QGBeP6HVi57isoHlIbBI29JHwqNBuTBtQeIFFtOPptBQvV0cQA
         7TgNOxvJdsFqrGV+gnSiug7mSZI1Z0SmW7HbWsx19QAOQ15QBDEJ9byW8rqAUEgwh5qT
         Lo93Gj2jRj+m94o+yK3OP/ejlzpuYUOuLbL2+F61MSNbIs42ZM9+3vWzur6v0y7bIx/K
         2jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729387; x=1764334187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gF9C7FxbCivSMf9nGQZ0aSleELaDVv0y36UrYer9UB0=;
        b=HT8yQX5WUG5AYfOkQVHQZIz1JISisYGQf0XfqONmyqcDc/7GoC5L5IUfvLXEqCwVgU
         WMNKV8z619df60DWhfadEsoa0dkvo+qG8mPa/pSSk/2oXS1ni/mR7bAE1SeHS/OZcuAC
         vTRKOM3MIHNnCDokFh+sHl9Uco+/VHt+X2t2aJvq2b3s5Uat9Edd8Im6iNDjoCYmSHmc
         tuZH3qOrQTJ5wK1zVq31BGRGbx4EOT+kpdpYElu1bP4HOfdluqENI8wcbY9Z5xm8bIkM
         8KTM1ogFgzr8ZLqAg0ufEvb3DsJBK7JE9nuW3V42w4o0Tg7qWKFIN3A82m+Ulqm0Iyff
         t7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLfFRz21q5Gy9Ar4DfZt2lkOsO8dGDdRjomx74pvDtj5PeDX49J9w1OvnF0rmsu84sjy5wxfdZCMIqz2lTWKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIB3X9GovSKBdplpyU7Bi7tAgKjVhU3hHqBSpnc4QNVRfFbVN
	EYkF76OKJJ4BdPb3jaSfrQnbhtoe7Pobbcn8uDwrURmYpbvqJy4pHTCf
X-Gm-Gg: ASbGncv290cu++bRA2tE3tUKZ2eiUya3uNj8L9ufwaZuc1+wY636Tz2mXldKx3niCa3
	2W6kLEzY5qmOLh0JWXF2qAR7QsO0YvGX0mElXjiCkY5Ae2NAA7ew09jCTanhLrRffQK23+ZUBdQ
	Ee46mFhr4tnkLKE+nyzSE6+cRgZoi4hF4fGojM4PdhD9OpiHzm09C0co83rcWYEHtuAmsWeI54Q
	zKcxUsM/cBB5+fvACpyUzhkx2+bSCT33T1rsw/r/R/DaI3rbr+nJUOrjdG3jHEqW7HkPIpI5Pwg
	o7duWc1WzgOGVAUGMqtjWch7BcbWHUWyf4EXVPWWg2w816ZILum1gDRuK0isoJYj/M3L6J1fdgx
	B52cMyYXOPAq7e0VL8R2/B0ywYGkyOs830+OUoL0BlA+vqV8fLBP12FBudM5/WeibNARlW8sHt5
	BYdFJstvUg5t2NZcnj
X-Google-Smtp-Source: AGHT+IHC1JKCnOMw2/59gVa3PzETifZLbtyEkz7OvXPEbgtliFAPF8mvCgwW3K4qg9F31SlZY/UqKQ==
X-Received: by 2002:a17:903:3a8b:b0:297:d6c0:90b3 with SMTP id d9443c01a7336-29b6beadf83mr27153795ad.23.1763729387458;
        Fri, 21 Nov 2025 04:49:47 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm56644045ad.75.2025.11.21.04.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:49:45 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 21 Nov 2025 12:49:04 +0000
Subject: [PATCH net-next v6 5/5] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-netcons-retrigger-v6-5-9c03f5a2bd6f@gmail.com>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
In-Reply-To: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763729347; l=6488;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=kqZWWvJE2+BeMA1UYo5eXs9VYYbgCijUdgI80CmasXY=;
 b=F4eRXdV9/TNvUYcbyjJRYBp0LlIie9BlHhDWtIquDYSOMzHak1y/VOOp2UcEPqH9t3KyguWXd
 sKugMmTzSGHA7IcythsNF+g+JrllWZ6M9+uiM/oO17AwX3gcz7RklCE
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


