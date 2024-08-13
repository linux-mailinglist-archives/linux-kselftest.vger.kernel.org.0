Return-Path: <linux-kselftest+bounces-15261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3610C950C64
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 20:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46E61F23639
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7AD1A38F7;
	Tue, 13 Aug 2024 18:38:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F65282E5;
	Tue, 13 Aug 2024 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574323; cv=none; b=AAJP/fK261EfbwrVDGUdkIKYZdQmdzbY6JOocJDx1YayMrdNPGP0iLZ6B65qc6slmV43c2hrCRdSQErd3OgMrLmMyVFO9bH5u3bUrvRtCDDFFR9+7QCHQd4ty84EgLdV6QiKDazo4738GnIyJA9a5JaXXRjWJt/52h6AvtiVsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574323; c=relaxed/simple;
	bh=lkB/Td/ESvdVIPNje+6+o8L/rGnI2xHD58br61EyhVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MozgCn6QiZelj5jppbp3zJz6oWNubDCSr2zrBLTgF3xx1sTvIvyxZuLDyvyKMbC3dRJZafCl7SkYYE3Rp26fw4bgQNm5A5EjRPJSMOhwP7TjWuFc1AzZgHi1PrPeVinVRgI3SVMPaO6ylzbVJ5lQcX9Auhocm1L4xSV9rZuLkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a80eab3945eso197599766b.1;
        Tue, 13 Aug 2024 11:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723574320; x=1724179120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg6zj1HxL5CAhxFObRSjDTNxVLNvkJmQr9l7c/eipSY=;
        b=wepdkkcjFClWjolCKJd8RZJE2nOI5OT64nUaU1UYneqsfBWKi/BjjJvCEDDdP4CwPv
         mQ0yn99BviQHNAIh0DkaIaHtp0CBRKV+fvzJEUSQ5kD745t3q97hYqj+AFVhO3Oah4KL
         wPDhnOq8s/7vxLHIY7nnQqLQuQYPubCdKGC8ECNqHciANFYvFj8WNizw1/+PXOw8j4IP
         WpeinQYSuRHY7F0nRGExH0zrjNgJFh5byy+Xa0VjAv8SQsK5HG+44+qfcB3jbmvIi1M9
         wc0cOx9myciC9YqJYnU9Oq08OV7X32Zf9tu8qY/tYU01jf41ZOBSPyegfdbk47P377DE
         JObA==
X-Forwarded-Encrypted: i=1; AJvYcCUAZ8WzJRT29+4FiuTUERtNrMpITYSkey30WMDazPMypL+juZkDUx888niqqhKpLwzYazyunKSBkj5ZVuZOYEUJADfCood8/iFagVoc+UnyILQ3wLaFwVjonINDEPWadnyQsIrHC2QcDEYg09cG
X-Gm-Message-State: AOJu0YwYqC7oYe36kbMBVqpDDfdX7YH23quS8sAUVRhxB7vuwbgc+VCx
	yyXaa1S5VNyYfgexOY7oS7TXJC2T+x4/2horCT7BTh8hO72/VrFWmKu0sQ==
X-Google-Smtp-Source: AGHT+IFTtTCFnfdun7eCzQaccz5bOto0deF//1mDNbtvc/yYdh17rYag3S+P74p69xMcY0KgaYainw==
X-Received: by 2002:a17:907:6d19:b0:a7a:d093:f843 with SMTP id a640c23a62f3a-a8367089773mr15496866b.63.1723574319620;
        Tue, 13 Aug 2024 11:38:39 -0700 (PDT)
Received: from localhost (fwdproxy-lla-011.fbsv.net. [2a03:2880:30ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f47b80sm89564166b.8.2024.08.13.11.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:38:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net-next v2] net: netconsole: selftests: Create a new netconsole selftest
Date: Tue, 13 Aug 2024 11:38:16 -0700
Message-ID: <20240813183825.837091-1-leitao@debian.org>
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

v2:
 * Change the location of the path (Jakub)
 * Move from veth to netdevsim
 * Other small changes in dependency checks and cleanup

v1:
 * https://lore.kernel.org/all/ZqyUHN770pjSofTC@gmail.com/

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/netcons_basic.sh    | 223 ++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netcons_basic.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index a9dace908305..ded45f1dff7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15770,6 +15770,7 @@ M:	Breno Leitao <leitao@debian.org>
 S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c
+F:	tools/testing/selftests/drivers/net/netcons_basic.sh
 
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index e54f382bcb02..928530b26abc 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -3,6 +3,7 @@
 TEST_INCLUDES := $(wildcard lib/py/*.py)
 
 TEST_PROGS := \
+	netcons_basic.sh \
 	ping.py \
 	queues.py \
 	stats.py \
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
new file mode 100755
index 000000000000..e0e58fc7e89f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -0,0 +1,223 @@
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
+	local NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_1_ID"
+	local NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_2_ID"
+
+	# These are global variables
+	SRCIF=$(find "$NSIM_DEV_1_SYS"/net -maxdepth 1 -type d ! \
+		-path "$NSIM_DEV_1_SYS"/net -exec basename {} \;)
+	DSTIF=$(find "$NSIM_DEV_2_SYS"/net -maxdepth 1 -type d ! \
+		-path "$NSIM_DEV_2_SYS"/net -exec basename {} \;)
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
+	echo "${INITNS_FD}:$SRCIF_IFIDX $NAMESPACE_FD:$DSTIF_IFIDX" > $NSIM_DEV_SYS_LINK
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
+	# This is coming from lib.sh. And it does unbound variable access
+	set +u
+	setup_ns "${NAMESPACE}"
+	set -u
+	NAMESPACE=${NS_LIST[0]}
+
+	# Create both interfaces, and assign the destination to a different namespace
+	create_ifaces
+
+	# Link both interfaces back to back
+	link_ifaces
+
+	configure_ip
+}
+
+function create_dynamic_target() {
+	DSTMAC=$(ip netns exec "${NAMESPACE}" ip link show "${DSTIF}" | awk '/ether/ {print $2}')
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
+	OUTPUT=${1}
+	# Just wait for 2 seconds
+	timeout 2 ip netns exec "${NAMESPACE}" socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
+}
+
+function validate_result() {
+	TMPFILENAME="$1"
+
+	# Check if the file exists
+	if [ ! -f "$TMPFILENAME" ]; then
+	    echo "FAIL: File was not generated." >&2
+	    return ${ksft_fail}
+	fi
+
+	if ! grep -q "${MSG}" "${TMPFILENAME}"; then
+	    echo "FAIL: ${MSG} not found in ${TMPFILENAME}" >&2
+	    cat "${TMPFILENAME}" >&2
+	    return ${ksft_fail}
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
+		echo "SKIP: interface ${DSTIF} exists in the system. Not overwriting it."
+		exit "${ksft_skip}"
+	fi
+}
+
+# ========== #
+# Start here #
+# ========== #
+modprobe netdevsim || true
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


