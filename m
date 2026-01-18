Return-Path: <linux-kselftest+bounces-49260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2CD3946C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 12:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D7B6306327E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B80632B99E;
	Sun, 18 Jan 2026 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbzHdWjc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2B32AAB4
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734049; cv=none; b=BSob2Cqg3xO2WE7+O38U/IFVBde9uBjgjcFSc79avFOlylZHpbtgLf9KOzn8RLayOkrFBXlIoy4QEJeNvIzB197VDxmMzDm+Z0pavVNUmvBOTUf3NuQaJNS8eSjxOnN47SkyhDA03s2mRJjkBBh1v3G+XIDQLcKyRR8r74CvsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734049; c=relaxed/simple;
	bh=e+w0DAW9oXvqNZy9JiObhL7asMTKcY24W84QkRdGT9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZCtIhmND8qihiRfbnLUt9Ete3SpjDQmosrbR324ufYAEzxRaDGtxmTI/99cI000aT2NuXgZbsuaIbFZufZ5SCS5HedBaYjv40xxJ10cTq+/WRRQgOYJWmHlrlrfeiNhbSOxYA1cfb1BjuF9zpAicNq76S+MsZ3+ZRxUrJa4BI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbzHdWjc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4327778df7fso2029382f8f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 03:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734036; x=1769338836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0hfwQRUIahRpuglzDE/ef/thxNWT6Y5iS8nFpch8gc=;
        b=TbzHdWjc9ICyxcUzFeNcITNE8FqMOlXkUzbzMSKnntIs4sKF5FEqZ5uSnQ39cnJZZ2
         kSnJm0Og7A3Vbc+U0Xq3hGqYWDrbYZa/75QMCgsairb2wrbO0WbIuPGlXbLoQYjgFPRQ
         wrwQ7T95kP+ehtcjk4eqEW+kTletjdLL2ElEQNPHwb/M6nO3j8wXrYZkxqdt+ooyn3PI
         dDpdASxXw81xc9Mh7CO353BSyWcvcP7Q+3wq0kCtmoxhV9AFHGKdQ/IGszjLjUGjB/CL
         r0hB1x8OJHmOAWY2mYwkNr2DhfWYtQh36Ckx3jvvwCn+zgdQ+KAv827WMg8dVvG94mjL
         Jd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734036; x=1769338836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0hfwQRUIahRpuglzDE/ef/thxNWT6Y5iS8nFpch8gc=;
        b=X/okp7P85YY2B1M7cIau7Zuj6fu+Vdc1QVMa9+EcQJIpSXdG6hgjHTPsonSnOX9nXa
         lfzfLiU2c4wNaDwlhXMR4OplhC9bV+VP2iIvWwxjqrUSoEVeI0vaKdjKXcIWhvVrF5rv
         40lGX+FwdkXzffmQCgeqqo5EMD3j5QK1haTluOUzoXE9PMS0ZzNJ8quCCE69Nsir0dXc
         nS+2GWjILNP2+06OV4fmPDPZz3FUgQTtFHmC7qDrP4uChmzz2YaGaDumIgc5Pk7NQwsx
         zjxyfLVFMb0wes1eMiOd0iXsgvv/6kRa2elZSKfJ3KcNxCqyfLLR3XDttHpEM10qgMYV
         KdaA==
X-Forwarded-Encrypted: i=1; AJvYcCXLR9gH6UNf2Wk1rEHtMLDw/r9vdAp5AJF0WOJoTDCG/fg4w4BQilw9GdVMxvJwHVjYSYuDEGe5EzaCn1UqFOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSjPp7kPTs3ewT+OZzum0lRZ7EM4CtvZAvu+PpwtRVPmgUuEZ
	ZGg30e2ILfn3+DkiWl0mVNrO6ToWSMreQfDcJvSa0n3br1846f7diQLy
X-Gm-Gg: AY/fxX6xhcZahCK6EBDyo0jxH/lkr5YbqeepjuD7SUt5Mc+Fs4WPZMC1cNCBpGFr6cB
	4ipFhyT9umcKmMvyIMFzvxnu+xqg8I7GGgK/Z/wP/RrmNeAxN12otBLO/nTWC0Tk79YlJR1+ZhQ
	42EFaQHBfFxzT5TkIfJvHJwDeqb9KpBvuhQU65rlbw+J1+MZS7G9+T9SoX3NdwsWo+4++geP9Tn
	DjkFarVt8tbr1K606pyMmUiLFMhxuN4XpLjfcDb0D2ghz2bF/4pgjekUsvfs8m/C9NQzWD0arTr
	X8ojgus5OSqI+5CIMEwgwoWhLuO6KKVIzH0hb20tWxRSk8/p4945ZlNjkGn6gZkq+qslLGcECri
	aosuO5xnSITURNJpnuFy67qN/CqD/C62fzc5XWoGT9RiJyr8L0S1kn3yZHtgE+XUD5z7Gbl8NQS
	v0RurXpE8f2tVOyA==
X-Received: by 2002:a05:6000:1847:b0:42b:5592:ebe6 with SMTP id ffacd0b85a97d-43569df48d2mr7889842f8f.0.1768734035801;
        Sun, 18 Jan 2026 03:00:35 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:34 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 18 Jan 2026 11:00:27 +0000
Subject: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=7540;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=e+w0DAW9oXvqNZy9JiObhL7asMTKcY24W84QkRdGT9w=;
 b=0mH19GhErzAi1HimK1aBDCmL/tFdWqtd24AQ//SxdqMJYyv7XsN/yIF3OeKiKm5yvv4m6WAfw
 sNIKnCD9eK6As+DnEEGjNces9E3u968aPRhvsbJ6V58cbkHTlj4zvRg
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
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 +++++-
 .../selftests/drivers/net/netcons_resume.sh        | 124 +++++++++++++++++++++
 3 files changed, 155 insertions(+), 5 deletions(-)

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
index ae8abff4be40..b6093bcf2b06 100644
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
index 000000000000..fc5e5e3ad3d4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
@@ -0,0 +1,124 @@
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
+SAVED_SRCMAC="" # to be populated later
+SAVED_DSTMAC="" # to be populated later
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
+function trigger_reactivation() {
+	# Add back low level module
+	modprobe netdevsim
+	# Recreate namespace and two interfaces
+	set_network
+	# Restore MACs
+	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" \
+		address "${SAVED_DSTMAC}"
+	if [ "${BINDMODE}" == "mac" ]; then
+		ip link set dev "${SRCIF}" down
+		ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
+		# Rename device in order to trigger target resume, as initial
+		# when device was recreated it didn't have correct mac address.
+		ip link set dev "${SRCIF}" name "${TARGET}"
+	fi
+}
+
+function trigger_deactivation() {
+	# Start by storing mac addresses so we can be restored in reactivate
+	SAVED_DSTMAC=$(ip netns exec "${NAMESPACE}" \
+		cat /sys/class/net/"$DSTIF"/address)
+	SAVED_SRCMAC=$(mac_get "${SRCIF}")
+	# Remove low level module
+	rmmod netdevsim
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
+	# Trigger deactivation by unloading netdevsim module. Target should be
+	# disabled.
+	trigger_deactivation
+	wait_target_state "cmdline0" "disabled"
+
+	# Trigger reactivation by loading netdevsim, recreating the network and
+	# restoring mac addresses. Target should be re-enabled.
+	trigger_reactivation
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


