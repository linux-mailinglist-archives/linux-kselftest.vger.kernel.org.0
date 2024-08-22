Return-Path: <linux-kselftest+bounces-16038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C695B276
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1181C20296
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D4178381;
	Thu, 22 Aug 2024 09:57:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB81CF8B;
	Thu, 22 Aug 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320626; cv=none; b=qcFSuuk7F9+MhNzcas4mfWHO7Em1zFo0i3Yh5w3nze44qzSxDSDGB8E+fSdQ/A452EAmLDma41M4JNxwDrf7FZyLdSpKO3fVr1yiY1mdixqAjI6vhZm+3I6Fbyyo6PseOgGJ3P5rFlEHNYbO36dnE8U+kwh4kK3VeC49Qf8TBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320626; c=relaxed/simple;
	bh=gMYvnozQM5vVHK/eHLFIldRLE3zy3lpmtmvcvuTCUI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNxnNyv0KmlUZ62hx8B6c7X2LHaIvbDyFSLfLzjp/DLkNm06M6+zLTEFZOJ4GYZlJC3kaiBAUXR+74QpOChTMAri2c/Lc7p/7iSa6hej8mk8jZ1mQPckiVjR7cCG3XRfQFxfQfAld7nWN6o76O412jbwLWiL6CCkNbwPUBppcT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a868831216cso84477066b.3;
        Thu, 22 Aug 2024 02:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320623; x=1724925423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9Hzm+F1jgbNfqptbTuv+Dkx8QEy1/v3zb7pzO0JQOQ=;
        b=kyypTZbM9T2bSb/4J+6IstJucSMverX23uLIQi2uDQ5z0arTVgix1bUuuflCWtPDsw
         +Vz9dukQ/5XJHi8m6HWSDeAfALjzmObMQESU3tgL/XgiESjzPSJphBKLpsKDjs1wB3aJ
         JYms+nPtwjwYrLJskq2QYkcaDjF4CZ5nPLBxYoq1dazdJ5XT5lls/ktknZKbKcq4EEk+
         ehNEDbXEHlnrjtJqBY5Qf2Wj6Q6LVCdO9fu9BhRDkfGOV7y8A/p0UtgqsUa7uQSJM0CD
         jRtBRDC60vUg+JQchLcLSviZNIcvnZyd5ApavBg/KYTYhJxWnOZcpbHOaC5z24Y94uea
         FwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUli5/IIatO5qzygIEPV2iXDRzc46K51RFVQ/ePKS33XglUvg5KljX9qz+J/+48Tcbibh+NJ9g+QGlFPFA=@vger.kernel.org, AJvYcCXVUKvkJkIAyA7fQ8/fgphuul3QDn1mDftEdsgQUG9R0hxVSBAHWmG8EqNe2DTDiP0kYb4IZPVQ2QySrGyLbUsR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq26h+7vpjyKpldf9pezOHsiho4WRQ4Q0TWrvrxDhyKgq5OSjp
	3e4EKytygUg9gJrKx/a779OvImZdFjgBaapzYuvmT6s2RhqqCA+p
X-Google-Smtp-Source: AGHT+IF9aDVSFGvS1drOxCeGiRfxscyrXP6oTRsaA4uaBhrB0av12+yAtPuR8Mnsmpj31HP3v26XfQ==
X-Received: by 2002:a17:907:1c29:b0:a86:9058:c01b with SMTP id a640c23a62f3a-a869058c14bmr116328266b.65.1724320622305;
        Thu, 22 Aug 2024 02:57:02 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f46a2sm94102166b.208.2024.08.22.02.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:57:01 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net-next v7] net: netconsole: selftests: Create a new netconsole selftest
Date: Thu, 22 Aug 2024 02:56:39 -0700
Message-ID: <20240822095652.3806208-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a selftest that creates two virtual interfaces, assigns one to a
new namespace, and assigns IP addresses to both.

It listens on the destination interface using socat and configures a
dynamic target on netconsole, pointing to the destination IP address.

The test then checks if the message was received properly on the
destination interface.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changelog:

v7:
 * Fixed a typo (s/Skippig/Skipping) (Matthieu Baerts)

v6:
 * Check for SRC and DST ip before starting the test (Jakub)
 * Revert the printk configuration at the end of the test (Jakub)
 * Fix the modprobe stderr redirection (Jakub)
 * https://lore.kernel.org/all/20240821080826.3753521-1-leitao@debian.org/

v5:
 * Replace check_file_size() by "test -s" (Matthieu)
 * https://lore.kernel.org/all/20240819090406.1441297-1-leitao@debian.org/#t

v4:
 * Avoid sleeping in waiting for sockets and files (Matthieu Baerts)
 * Some other improvements (Matthieu Baerts)
 * Add configfs as a dependency (Jakub)
 * https://lore.kernel.org/all/20240816132450.346744-1-leitao@debian.org/

v3:
 * Defined CONFIGs in config file (Jakub)
 * Identention fixes (Petr Machata)
 * Use setup_ns in a better way (Matthieu Baerts)
 * Add dependencies in TEST_INCLUDES (Hangbin Liu)
 * https://lore.kernel.org/all/20240815095157.3064722-1-leitao@debian.org/

v2:
 * Change the location of the path (Jakub)
 * Move from veth to netdevsim
 * Other small changes in dependency checks and cleanup
 * https://lore.kernel.org/all/20240813183825.837091-1-leitao@debian.org/

v1:
 * https://lore.kernel.org/all/ZqyUHN770pjSofTC@gmail.com/

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/drivers/net/Makefile  |   5 +-
 tools/testing/selftests/drivers/net/config    |   4 +
 .../selftests/drivers/net/netcons_basic.sh    | 234 ++++++++++++++++++
 4 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/netcons_basic.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dbf23cf11c8..9a371ddd8719 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15772,6 +15772,7 @@ M:	Breno Leitao <leitao@debian.org>
 S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c
+F:	tools/testing/selftests/drivers/net/netcons_basic.sh
 
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index e54f382bcb02..39fb97a8c1df 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -1,8 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_INCLUDES := $(wildcard lib/py/*.py)
+TEST_INCLUDES := $(wildcard lib/py/*.py) \
+		 ../../net/net_helper.sh \
+		 ../../net/lib.sh \
 
 TEST_PROGS := \
+	netcons_basic.sh \
 	ping.py \
 	queues.py \
 	stats.py \
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index f6a58ce8a230..a2d8af60876d 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -1,2 +1,6 @@
 CONFIG_IPV6=y
 CONFIG_NETDEVSIM=m
+CONFIG_CONFIGFS_FS=y
+CONFIG_NETCONSOLE=m
+CONFIG_NETCONSOLE_DYNAMIC=y
+CONFIG_NETCONSOLE_EXTENDED_LOG=y
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
new file mode 100755
index 000000000000..06021b2059b7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -0,0 +1,234 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test creates two netdevsim virtual interfaces, assigns one of them (the
+# "destination interface") to a new namespace, and assigns IP addresses to both
+# interfaces.
+#
+# It listens on the destination interface using socat and configures a dynamic
+# target on netconsole, pointing to the destination IP address.
+#
+# Finally, it checks whether the message was received properly on the
+# destination interface.  Note that this test may pollute the kernel log buffer
+# (dmesg) and relies on dynamic configuration and namespaces being configured.
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+# Simple script to test dynamic targets in netconsole
+SRCIF="" # to be populated later
+SRCIP=192.168.1.1
+DSTIF="" # to be populated later
+DSTIP=192.168.1.2
+
+PORT="6666"
+MSG="netconsole selftest"
+TARGET=$(mktemp -u netcons_XXXXX)
+DEFAULT_PRINTK_VALUES=$(cat /proc/sys/kernel/printk)
+NETCONS_CONFIGFS="/sys/kernel/config/netconsole"
+NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
+# NAMESPACE will be populated by setup_ns with a random value
+NAMESPACE=""
+
+# IDs for netdevsim
+NSIM_DEV_1_ID=$((256 + RANDOM % 256))
+NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+
+# Used to create and delete namespaces
+source "${SCRIPTDIR}"/../../net/lib.sh
+source "${SCRIPTDIR}"/../../net/net_helper.sh
+
+# Create netdevsim interfaces
+create_ifaces() {
+	local NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
+
+	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
+	udevadm settle 2> /dev/null || true
+
+	local NSIM1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_1_ID"
+	local NSIM2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_2_ID"
+
+	# These are global variables
+	SRCIF=$(find "$NSIM1"/net -maxdepth 1 -type d ! \
+		-path "$NSIM1"/net -exec basename {} \;)
+	DSTIF=$(find "$NSIM2"/net -maxdepth 1 -type d ! \
+		-path "$NSIM2"/net -exec basename {} \;)
+}
+
+link_ifaces() {
+	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
+	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
+	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
+
+	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
+	exec {INITNS_FD}</proc/self/ns/net
+
+	# Bind the dst interface to namespace
+	ip link set "${DSTIF}" netns "${NAMESPACE}"
+
+	# Linking one device to the other one (on the other namespace}
+	if ! echo "${INITNS_FD}:$SRCIF_IFIDX $NAMESPACE_FD:$DSTIF_IFIDX"  > $NSIM_DEV_SYS_LINK
+	then
+		echo "linking netdevsim1 with netdevsim2 should succeed"
+		cleanup
+		exit "${ksft_skip}"
+	fi
+}
+
+function configure_ip() {
+	# Configure the IPs for both interfaces
+	ip netns exec "${NAMESPACE}" ip addr add "${DSTIP}"/24 dev "${DSTIF}"
+	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" up
+
+	ip addr add "${SRCIP}"/24 dev "${SRCIF}"
+	ip link set "${SRCIF}" up
+}
+
+function set_network() {
+	# setup_ns function is coming from lib.sh
+	setup_ns NAMESPACE
+
+	# Create both interfaces, and assign the destination to a different
+	# namespace
+	create_ifaces
+
+	# Link both interfaces back to back
+	link_ifaces
+
+	configure_ip
+}
+
+function create_dynamic_target() {
+	DSTMAC=$(ip netns exec "${NAMESPACE}" \
+		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
+
+	# Create a dynamic target
+	mkdir "${NETCONS_PATH}"
+
+	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
+	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
+	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
+	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
+
+	echo 1 > "${NETCONS_PATH}"/enabled
+}
+
+function cleanup() {
+	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
+
+	# delete netconsole dynamic reconfiguration
+	echo 0 > "${NETCONS_PATH}"/enabled
+	# Remove the configfs entry
+	rmdir "${NETCONS_PATH}"
+
+	# Delete netdevsim devices
+	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
+
+	# this is coming from lib.sh
+	cleanup_all_ns
+
+	# Restoring printk configurations
+	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
+}
+
+function listen_port_and_save_to() {
+	local OUTPUT=${1}
+	# Just wait for 2 seconds
+	timeout 2 ip netns exec "${NAMESPACE}" \
+		socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
+}
+
+function validate_result() {
+	local TMPFILENAME="$1"
+
+	# Check if the file exists
+	if [ ! -f "$TMPFILENAME" ]; then
+		echo "FAIL: File was not generated." >&2
+		exit "${ksft_fail}"
+	fi
+
+	if ! grep -q "${MSG}" "${TMPFILENAME}"; then
+		echo "FAIL: ${MSG} not found in ${TMPFILENAME}" >&2
+		cat "${TMPFILENAME}" >&2
+		exit "${ksft_fail}"
+	fi
+
+	# Delete the file once it is validated, otherwise keep it
+	# for debugging purposes
+	rm "${TMPFILENAME}"
+	exit "${ksft_pass}"
+}
+
+function check_for_dependencies() {
+	if [ "$(id -u)" -ne 0 ]; then
+		echo "This test must be run as root" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ! which socat > /dev/null ; then
+		echo "SKIP: socat(1) is not available" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ! which ip > /dev/null ; then
+		echo "SKIP: ip(1) is not available" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ! which udevadm > /dev/null ; then
+		echo "SKIP: udevadm(1) is not available" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if [ ! -d "${NETCONS_CONFIGFS}" ]; then
+		echo "SKIP: directory ${NETCONS_CONFIGFS} does not exist. Check if NETCONSOLE_DYNAMIC is enabled" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ip link show "${DSTIF}" 2> /dev/null; then
+		echo "SKIP: interface ${DSTIF} exists in the system. Not overwriting it." >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ip addr list | grep -E "inet.*(${SRCIP}|${DSTIP})" 2> /dev/null; then
+		echo "SKIP: IPs already in use. Skipping it" >&2
+		exit "${ksft_skip}"
+	fi
+}
+
+# ========== #
+# Start here #
+# ========== #
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup EXIT
+# Create one namespace and two interfaces
+set_network
+# Create a dynamic target for netconsole
+create_dynamic_target
+# Listed for netconsole port inside the namespace and destination interface
+listen_port_and_save_to "${OUTPUT_FILE}" &
+# Wait for socat to start and listen to the port.
+wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+# Send the message
+echo "${MSG}: ${TARGET}" > /dev/kmsg
+# Wait until socat saves the file to disk
+busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+
+# Make sure the message was received in the dst part
+# and exit
+validate_result "${OUTPUT_FILE}"
-- 
2.43.5


