Return-Path: <linux-kselftest+bounces-45706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A81C6194D
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 18:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A13264EBFE0
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6873101B6;
	Sun, 16 Nov 2025 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqznU/vH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E430F95B
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313262; cv=none; b=WD7ASmmPbZvRPw4SwmjWm/i6Em1JrMZT0xsJpe5glJdkjs6N1aFkn3Cm2rIny7mzrpBxne3vhezhtQ7fPr/WNxr38sYUfG8AV1hPFibc549riDcurRol/EpCcTGG1BytFdYAozpR4hQLFj36Uwfo7qkljBoQA+GEcdMxmz+o1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313262; c=relaxed/simple;
	bh=cSkbpzOScZDOIzNwW1Ore/elvihVGtq9EEd1znjD/vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZehEahGcvPGrzfioGw5EoztAMeSgyccxdBWLEIT+EaHsKE1IOzUuAL3/XYKC34Jbg6iOVLnrRc4/49K4qMtfjAZ9mxOO/pmOpasn/6Pbl7AFxBNM4alcSmUlZ5J0CupctxuGh2syvMfaCbWe67TX0gNx01YR+uoE2xjsUlN0vNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqznU/vH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so23669565e9.1
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763313257; x=1763918057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JYJQBu9iv6dVjvkSHn+sjpe3Hje65AyykqNzlW6M0I=;
        b=FqznU/vHNNCzDCRMSjJd4kMvdv2+sV74Hx/l0x5CjAy/XixrbYcGakKendQyIvcSn/
         CHaKZ9oQebLueb2wnD/KOXeL+W84yoKwM2GEUWSmffAjsSf3YE14gucZ1yENCuWGYLbf
         5t4gseuIzXMvnO/JFtTzmJHu6nU7DEvHrnJ5wtOgHNY7pSNXnFpw68U7V0IbfA0JqtG2
         nCcSswOr9/tWmQ8M3lWZHhZ0DXReERTY+7vtySbdQP7BWjYJrCzdjE1MRjTuSQyP2REa
         EB0DBFqKoLlNJxGF3nPWZ1yjUN3UhSf/y11m81rh20KkK5vta/7l45BsA22SpxsPuKjX
         boPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763313257; x=1763918057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JYJQBu9iv6dVjvkSHn+sjpe3Hje65AyykqNzlW6M0I=;
        b=aYk5vY+nLb1HxhY4m+GNIsp7VBlyLLfrGhVjaPmTxPyWEnD09hN3L3Brq2ZWbwzQaV
         0N/upUcE2ZHB+L9XknGEdn1VdgmzUK5v/Dpd6fKXS1esDisrm2uliobsgCcyXrsrTqBE
         B7Avt9lTFJqQyB8DZ3wgissD9S2OPD0EZs+1VXDS0dCyT67xyVcSH3RV5nkGOo+yVWGm
         SO8PgpRm1JN9OvUQduSVXmtOJeUbec0qS7v9ldRgPXmrgqMErLH4Rk3gcedg5SnPMxq5
         ttL3dGLmxPDsfjxNRwVq/TeN8GLW89pPsGrtWkyRvL/rgC+n39MmzOHfWxtO2Og7sIW3
         +BHA==
X-Forwarded-Encrypted: i=1; AJvYcCU2RCt/Y+3gfXwZ/n2X24Q5/2JMnegeXPX9Ide41SX4RJiTtyRTobMZ7dBCv23gjZxcELEEjy1sJSTaOT/yc48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02QXOhky86bMjR8dMocviCSn706LU739wrz4hrMxPqaO55fdU
	CBWqvrJuFqp5l3dT261NtuxRS/ZInzsTSj1nxQ73ftAO4wJJSlrCMkXm
X-Gm-Gg: ASbGncupTm6DRtW90SOwEkSjKyif18UrdKtKm4EUn/SSMK6aHHbydd0S5srZb3zzOeY
	f7H/c0R50cRW8EKyAN28RTB0JSo9Z7mxWYvVcC9NaNAVwHWC2JUn5Dj9Tc3LZmmSFx016j/AJLl
	heJ3Idpv8sTUCdEUh2MQLQ21294GXFynL+5w9E1wKMBOpCZyQJkUCGZkC9in7ylbPjI08D55UXW
	Y+cLsquX2e108OKHK4Mkwag6XZ/pBXn8e9M34Tv/tj0jpHr0ZR+s4WHR373B32gTgM+n1lM9XLd
	eR0uTDKfPgGBhPT/AboKwNhZO+nz5rHyYtYj4rIia+Gn6GiuPVsIREaqsr3RcIynd6KyCX+jvp8
	do3TkRcKdfRSgfGS6C6EKSXZfmAC21NHW/R7NvQ/0yaATLuijZpn8UB+Ae7BKpjiZRe4Ky2bugS
	WELYvbCJi4Wp5yO7IHQFL5JwodMg==
X-Google-Smtp-Source: AGHT+IHCYuk5mG7mCpI3ofpnHFX152jLfPh0VKK8Yl+QsCayK9hrd3d7t05L3SHcQkISCGCM1B4z6w==
X-Received: by 2002:a05:600c:a406:b0:477:75b4:d2d1 with SMTP id 5b1f17b1804b1-4778bd13e4amr98405915e9.15.1763313257465;
        Sun, 16 Nov 2025 09:14:17 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779d722bc5sm70874245e9.2.2025.11.16.09.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:14:16 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 16 Nov 2025 17:14:05 +0000
Subject: [PATCH net-next v4 5/5] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-netcons-retrigger-v4-5-5290b5f140c2@gmail.com>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
In-Reply-To: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763313249; l=6495;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=cSkbpzOScZDOIzNwW1Ore/elvihVGtq9EEd1znjD/vg=;
 b=MlEjVU6NAqK/Eg10qo/ju+anbefWk7ZE96KoLgXDvkn8bCFTefxY4eVTNz3MymmW6l0qa86X5
 yNBUcMiIHpuAfZAdjpOXhBdWAEHBKoe7yMyrh2X3c/I3lQXFgwmLE/z
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
index 87f89fd92f8c..6157db660067 100644
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
+		local ENABLED=1
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
index 000000000000..8f7f07779c41
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
+	trap - EXIT
+
+	echo "${BINDMODE} : Test passed" >&2
+done
+
+exit "${ksft_pass}"

-- 
2.51.2


