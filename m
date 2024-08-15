Return-Path: <linux-kselftest+bounces-15393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B38E952C58
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 12:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96601F22508
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C481AD9D6;
	Thu, 15 Aug 2024 09:52:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002417BEAA;
	Thu, 15 Aug 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715536; cv=none; b=SlGyiDdrMB71gJFLSrlnfKF4mUprYrTPDfmnk5TQFqz8wVgEM/bh097fq1BOthUxaa4OgW4PlFEPebhaiLqlyxce0OLn/NIQiBF/swkHgtql4s+AYBfg3D1eG6jnu8GKhAXU5Ha7xjxWw/2bdZGQhiGqwDzRFdGYkP8Q49gVpus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715536; c=relaxed/simple;
	bh=QWWp3oN/6l4uweB3ou70Kb3cCnsXs6mWdhtriOJv7pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tz4QHes4PWPGmev7Q1qM2rxK8ZqYT2/lYg/VfsS+JL7mhgvYu+clmilmsaKcLxcP0OQOwIUFVaVkj/76Q7vrjJaSm50UTvKgI2Papw0vNtSaMq0U8Eo5wYTv+KAeodelJ74jt5wqy5uCx98ZS4m7YFN1DhN6F4hC+J/a4T4sExY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8385f38fcdso34706866b.3;
        Thu, 15 Aug 2024 02:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723715532; x=1724320332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PitIhZbqrZEQzU7Nc194kKQRWIEgsiNBZXgM9lF+/I=;
        b=RGWGEfRnNGp5qfAvDmllKBCo+9GIznhMKZxQl6UIfe7zBj3BH9gD6sqIZXsQu12pDp
         Kce4PATQEFPuTBOa+rbwSFBpEMcyEcAXSJZnhfJTX1O2HgVXYdzlR4xDgU5IOkj9kcwS
         kIb3IDs4DweVUn57mC/sCVEaaC1nKGfcAHYjvyjK9xPhoY8yMTvUsui+TUxePKtncMMk
         JS9KSnXcCbD/b+ta6a/QS7mXsjbIheo/3C36Z7aa1HpI/qHmoSxQgurqf47ReO3zvgBh
         S+THxsL40OQuilEueP7z5dAa5vSwMyHzEjYW+4FI7RHjkP3y28u+iI4WhkBxyQAWmfCs
         xWSg==
X-Forwarded-Encrypted: i=1; AJvYcCUPOxX+7GoqN+JK91tAaA9KxFYL7QfhCSarbB2C64hhFdg+AFoehvZdH9Gsp1UHsrv8iDcHWNmXe5pr0jI=@vger.kernel.org, AJvYcCXIO91rHiULPsumk55KlZ43N22ZCIXIwm2mPAoakGQpihe+Bk+TunBqOYehbgAZaRoNmz9sfcvlOrMNspQf+Ck/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3leLnf9uy7r+YVaG/B26sulmUWmJFZ8W8EQU6X5CM70B+Ftf
	su068lpXTpGsoy6LNjM7WaPdUIJ6e7/IGYFTGgFBJv0mxtw1nmBj
X-Google-Smtp-Source: AGHT+IH8T31IKypooK/8K40dVjwxcmrvxjfY0Ynspjos4ZlKxQkKf0K8vMiiCylGFWecd3PO4rz7vQ==
X-Received: by 2002:a17:907:84b:b0:a7c:f6f5:390e with SMTP id a640c23a62f3a-a8367048c43mr424124966b.58.1723715531812;
        Thu, 15 Aug 2024 02:52:11 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6a42sm75038366b.44.2024.08.15.02.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:52:11 -0700 (PDT)
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
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net-next v3] net: netconsole: selftests: Create a new netconsole selftest
Date: Thu, 15 Aug 2024 02:51:44 -0700
Message-ID: <20240815095157.3064722-1-leitao@debian.org>
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

v3:
 * Defined CONFIGs in config file (Jakub)
 * Identention fixes (Petr Machata)
 * Use setup_ns in a better way (Matthieu Baerts)
 * Add dependencies in TEST_INCLUDES (Hangbin Liu)

v2:
 * Change the location of the path (Jakub)
 * Move from veth to netdevsim
 * Other small changes in dependency checks and cleanup
 * https://lore.kernel.org/all/20240813183825.837091-1-leitao@debian.org/

v1:
 * https://lore.kernel.org/all/ZqyUHN770pjSofTC@gmail.com/

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/drivers/net/Makefile  |   4 +-
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/drivers/net/netcons_basic.sh    | 226 ++++++++++++++++++
 4 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/netcons_basic.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b291c3a9aa4..9f0be36939f9 100644
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
index f6a58ce8a230..8f46112263f0 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -1,2 +1,4 @@
 CONFIG_IPV6=y
 CONFIG_NETDEVSIM=m
+CONFIG_NETCONSOLE=m
+CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
new file mode 100755
index 000000000000..929f27a0fd9c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -0,0 +1,226 @@
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
+# This will have some tmp values appended to it in set_network()
+NAMESPACE="netconsns_dst"
+
+# IDs for netdevsim
+NSIM_DEV_1_ID=$((256 + RANDOM % 256))
+NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+
+# Used to create and delete namespaces
+source "${SCRIPTDIR}"/../../net/lib.sh
+
+# Create netdevsim interfaces
+create_ifaces() {
+	local NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
+
+	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
+	udevadm settle || true
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
+	echo "${INITNS_FD}:$SRCIF_IFIDX $NAMESPACE_FD:$DSTIF_IFIDX" \
+		> $NSIM_DEV_SYS_LINK
+	if [ $? -ne 0 ]; then
+		echo "linking netdevsim1 with netdevsim2 should succeed"
+		cleanup
+		exit ${ksft_skip}
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
+	# This is coming from lib.sh
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
+		return ${ksft_fail}
+	fi
+
+	if ! grep -q "${MSG}" "${TMPFILENAME}"; then
+		echo "FAIL: ${MSG} not found in ${TMPFILENAME}" >&2
+		cat "${TMPFILENAME}" >&2
+	return ${ksft_fail}
+	fi
+
+	# Delete the file once it is validated, otherwise keep it
+	# for debugging purposes
+	rm "${TMPFILENAME}"
+	return ${ksft_pass}
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
+# ========== #
+# Start here #
+# ========== #
+modprobe netdevsim || true
+modprobe netconsole || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup EXIT
+# Create one namespace and two interfaces
+set_network
+# Create a dynamic target for netconsole
+create_dynamic_target
+# Listed for netconsole port inside the namespace and destination interface
+listen_port_and_save_to "${OUTPUT_FILE}" &
+
+# Wait for socat to start and listen to the port.
+sleep 1
+# Send the message
+echo "${MSG}: ${TARGET}" > /dev/kmsg
+# Wait until socat saves the file to disk
+sleep 1
+
+# Make sure the message was received in the dst part
+validate_result "${OUTPUT_FILE}"
+ret=$?
+
+exit ${ret}
-- 
2.43.5


