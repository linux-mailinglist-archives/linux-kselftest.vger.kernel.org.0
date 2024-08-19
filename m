Return-Path: <linux-kselftest+bounces-15622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C4956642
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0A71F22E59
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F915C146;
	Mon, 19 Aug 2024 09:04:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0115C123;
	Mon, 19 Aug 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058268; cv=none; b=uUrLXngZ1uzZ8hBYIh2Ewh6ubjeic3bNmyW2n6QRlyBniA+eQpJF/hEMCf2CiKy7JVL+WOtSH7GfoBQRCnc2/ghlfS60uOTyDSNwc6bwm9FLlNB66jQiG+X7RYFyyVr4gbb3G39CLZ5LgGfwwmgGUj9PFmOCDxCe7ES+Y/IkxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058268; c=relaxed/simple;
	bh=+UcLassjRBluQPTGIrIjg0Er/I51U3zFpt5pm0dIgqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjjuwqMHoR8iA3KOAfjHwlWGAY3J499TaLGWJj9EWNCkbF7/Q3oTrdgXgeMTS4Ls2OOk06FaBsHFeZ3DFrgrOYHri9RSGSLfHj4Z3NVbSMEkkv7avPb1oWGtihLtAkCo519cselz9YAmcfB4BJNn8KtTDPHdFqrrLayvnGNK7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a843bef98so436534366b.2;
        Mon, 19 Aug 2024 02:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058264; x=1724663064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWS/V+Ywzifgu/GyKD8QbUixNLvCG9vfNA7TfibtEIE=;
        b=UirT/tOK97H9ead759pZvHeRK9AYzT3OzCP40LzmYPO29ez2sTwKhNMwRbMkw1mYBZ
         H400b8RbDMJggw1jWWXjxAPmfEXW+Q/FUO2sAWu9mVgHk2WEVamR/rsHLFjnVgqFBPrj
         X+nwBZs+cz6Ef5B4i1wR1wy7Q+4dLh/HzfIjVlPfOMMhhtZZFfWvgBcb3STHyzb8CKyW
         X576bL0XCNe+G4Ouh9w0rVUhKSN2WqASv+zamZ7Qf0dQlnE2isArEjhJgrNDmMkYHLsX
         0RjpYs5U0J+YLLd+tdgxrWsqLo9oMaMJ/9I9euDkrGFC7vSSM+X61+7iuIwSzDp3X/x3
         hNbA==
X-Forwarded-Encrypted: i=1; AJvYcCWgu9brxVNSTHrasr/DX4YsszwH6/O8vrYl/D5QiJSiG8/SG3cyy+rFaG3nJ8RcV+qHg/coyjwvo3dITwxetEx2Qt6/6W1HrRjmHr+lD7S9r8nIrj7ZH+ZDcnjIGuxFshSqwOfy6B7GM6bUkcM4
X-Gm-Message-State: AOJu0YznQqpoysrRSHZ2fcTC/Oiq8CbceH4oEiAQiwCZ4kDGcV1QgPrU
	wOpkaZF9+SM6EaYCqo+0v1fxtjRnmK2/v8GfxKa1OBJyc6J3ozjW
X-Google-Smtp-Source: AGHT+IHFL9Q1mrNm6xFWpn4g2IVzm+xgsNT4kBEWk2bsIIpeOilITOlsG57C0G2inioYahveoZ8D8w==
X-Received: by 2002:a17:907:e6e6:b0:a7a:ae85:f245 with SMTP id a640c23a62f3a-a8392953cdfmr710386266b.38.1724058263737;
        Mon, 19 Aug 2024 02:04:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839464d1sm614144766b.173.2024.08.19.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 02:04:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net-next v5] net: netconsole: selftests: Create a new netconsole selftest
Date: Mon, 19 Aug 2024 02:03:53 -0700
Message-ID: <20240819090406.1441297-1-leitao@debian.org>
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

v5:
 * Replace check_file_size() by "test -s" (Matthieu)

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
 .../selftests/drivers/net/netcons_basic.sh    | 225 ++++++++++++++++++
 4 files changed, 234 insertions(+), 1 deletion(-)
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
index 000000000000..137875505663
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -0,0 +1,225 @@
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
+}
+
+# ========== #
+# Start here #
+# ========== #
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2 > /dev/null || true
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


