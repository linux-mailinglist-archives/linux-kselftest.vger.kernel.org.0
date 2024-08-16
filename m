Return-Path: <linux-kselftest+bounces-15503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C9954B14
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2E82819F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0F1BB69A;
	Fri, 16 Aug 2024 13:27:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237F31AE87B;
	Fri, 16 Aug 2024 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814878; cv=none; b=j9VQ4eBU5WjXp8ogywmjqA8fz2NXYi6KvCdEJ2XGzGIR1faEUJJk8EsXoKR0tVHLQ6g2jy+FU0qotHNwU4pdw8qI/py/09cF9xBXFkumV2RyOR/kr/yrpgmM4lAbUFOeo1iK6DDQ53wQilZGhLtUd9a7RsII1wHbu85tc1KlfdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814878; c=relaxed/simple;
	bh=OlH23t68qN8fD6IH8F8oCzq0FApVlmKsmFxSMxKuXK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIdNZbmENpv1afpdtyW3zhK1FsR3Qw3xjViLTXSwiNINZSXCmSUCrEKHLAPSaZTGKxRaO4uUYtFIf1mLZYU+DuSyhhlzvkK/6B2vu03K0tOxdy2nwr8B9wel0MkYle9Erm5iXydOsla6Cv+bVgij0Iz213z41lMPOjskj9zjXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so234669666b.2;
        Fri, 16 Aug 2024 06:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723814874; x=1724419674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vF/MQOH40sKBKTYjsbuneUIS0+A/mbsW502s2MOFLp0=;
        b=AK+Imf+qnluyY5Kcwjq75W+b6U/R/ysI2eHKp0mTqStkETryYRKW6KmlTAdr5dd6de
         ch2VTNJG/SQVvyJYZ3eBUzfvj9pd08Gi9A9WoEP+GeyTWWQthOz04kkFwgX1bcMJvpwG
         qtOnEQRkq+JhsxjKc1x82AWCzyLaFAI37BakHs4LE8E9JQQktawwniStMlLLymr7aaIk
         vj0NRu3GsFTQCLgDb4Qkoa7ngOY9BtMPOq/upfL+Vc/OVWaEwNyocwLuaATI3WwKltOD
         I3tdfdh+cweGEWym565evbrpMjI9rAYX5WriVdNwSu2O/IQwSkaR8c3UxVy4fz8V47YD
         DVBw==
X-Forwarded-Encrypted: i=1; AJvYcCW1en/woBY4JHf4mvsHZDggobTP0DXDqBjmRGStbkhFjPXH/VfF3V3ennZ36l+i2axOKjQUvxCV/Eg00rDof/JrhVdMacv+D0cTqEkCulvlmv/ps8QsldOs4DQ7kscFrg6eNLIhFJbr5llcG13d
X-Gm-Message-State: AOJu0Yzyc4aa/E9Q4M3rtTo0nm2Bay3LTLnp87w2cEQ7rGrEGALvFYJ8
	aifWbFy4eguuuwtlPb5l3K/qC3DCu4zR+bImQEoy2lVDISxlV15i
X-Google-Smtp-Source: AGHT+IH2goBZxY1fVnwcKnWDhNlUIW5IPOzKOwgd6nmoTz+KMfy7MvkLy7NMgvGRKR0ySvrnfykWbQ==
X-Received: by 2002:a17:907:e642:b0:a77:cca9:b21c with SMTP id a640c23a62f3a-a8392954492mr250314566b.34.1723814873427;
        Fri, 16 Aug 2024 06:27:53 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947b86sm256852866b.187.2024.08.16.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:27:52 -0700 (PDT)
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
Subject: [PATCH net-next v4] net: netconsole: selftests: Create a new netconsole selftest
Date: Fri, 16 Aug 2024 06:24:37 -0700
Message-ID: <20240816132450.346744-1-leitao@debian.org>
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
---
Changelog:

v4:
 * Avoid sleeping in waiting for sockets and files (Matthieu Baerts)
 * Some other improvements (Matthieu Baerts)
 * Add configfs as a dependency (Jakub)

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
 tools/testing/selftests/drivers/net/Makefile  |   4 +-
 tools/testing/selftests/drivers/net/config    |   4 +
 .../selftests/drivers/net/netcons_basic.sh    | 249 ++++++++++++++++++
 4 files changed, 257 insertions(+), 1 deletion(-)
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
index e54f382bcb02..8bee2e94049b 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -1,8 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_INCLUDES := $(wildcard lib/py/*.py)
+TEST_INCLUDES := $(wildcard lib/py/*.py) \
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
index 000000000000..5c3686af1fe8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -0,0 +1,249 @@
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
+		echo "This script must be run as root" >&2
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
+check_file_size() {
+	local file="$1"
+
+	if [[ ! -f "$file" ]]; then
+		# File might not exist yet
+		return 1
+	fi
+
+	# Get file size
+	local size=$(stat -c %s "$file" 2>/dev/null)
+	# Check if stat command succeeded
+	if [[ $? -ne 0 ]]; then
+		return 1
+	fi
+
+	# Check if size is greater than zero
+	if [[ "$size" -gt 0 ]]; then
+		return 0  # file size > 0
+	else
+		return 1  # file size == 0
+	fi
+}
+
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
+busywait "${BUSYWAIT_TIMEOUT}" check_file_size "${OUTPUT_FILE}"
+
+# Make sure the message was received in the dst part
+# and exit
+validate_result "${OUTPUT_FILE}"
-- 
2.43.5


