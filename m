Return-Path: <linux-kselftest+bounces-41825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC389B84319
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 12:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15CD67AE3D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8C30170A;
	Thu, 18 Sep 2025 10:42:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C82FFF83
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192146; cv=none; b=tH3Pw4s6Y4JnN41ERWSx9zgc+ogQ4zcAa37PoUtrHvXlcf7XqILxaPRxo1n9cKzyjbWloT9s6AhReajmpfWkPjlXrri2xDTEzGfBfqsXqHR0EFqLihs4QkAos30EinNfdaJZYBqg65T04D2eGSlzVWgBlBtwIpOsORze6dT/qGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192146; c=relaxed/simple;
	bh=UPOeRaoIL7DJ+4Ij9UByVGp65lQeUNBpRGIjUXmOtj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gn32+CB6zhM6NmtpqUsWR6p5ql6Mdwd8+kWQYQiSTYZuEOlvGZ0+DZzng3Gp85OEPeYwuYQvgKJI9xxrOdrE7d4A1wpzmw7L/2wRG0gbTVZNBzjRF+TjpnlS9n4IfMY+bW+qoCpuzL++hX5RzD1al9fR727qb0o3NZv5KLhM3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0428b537e5so103141666b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 03:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192140; x=1758796940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ttz6uN58LRlh8ViQ+ffTzJzOrsWeWDC1M2e/yz7D5SU=;
        b=K2qre98Q/Le2y5vtvVaHkEHsktl4f8unkLZHuUqKDrL2sFO31x6eRqFz7gfl9L1Hx3
         6q3Yvo81niBrQ06YAp39jVmn4fv1coDdz0825p3kg2Lj5vyfKDBNWg6pdY/AdVMEOs5q
         3hp1ac9t5yA5C9798qtJR0MllSo1OE3TVIa+cPLDGQHMJ5K6i2rzxouKX3ld0t33Nf4t
         PACsqp/Q49Nwh21a8dBDQ2XG6gU7ZbI8/PGDSPnrn5oOojkANDRb7zVcooca9YBxpMoi
         SoEcbfFFg9jgQz9VRYkDX5f+8FL9yHzB7NwVCrQDy5FHSFi3HRUvLVU6BbBjo8aDeiVV
         q/tg==
X-Forwarded-Encrypted: i=1; AJvYcCWDSKAqY0xkvPOciJDONhxlnnMepmlEYfm3QoC32RY/4gFBqFa7gwkXPXPI2k6B/RBqYr0jt2BHQv4UDGv1Mkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJm2jqFnoxs+dFxqS+NF6c5hJg9KE9wTRkBOe72zGcU43sjfrj
	PxVnhVkYm6YoRddAncQFktpX8hEFhEF6YbsIFLXnyGgWRlk4RCWHD237
X-Gm-Gg: ASbGnct3HiS4plffXI3zrPMYwjnXHbjepKVGyn/ADCw6iIsMZkkd67Gnyx0vmhkitoJ
	7sY2jb5GY1L5hqxljvvCVOADyBSqlba89TO6R0w705PboWDc4BbboIQeIY2+J9FC3Ix95FA829U
	VWCruqx62rMsKT2jRO0+ZrNeRwJteZFCqFHN67wxTqC+ts7HS+PWSp5sMaUlAdsjwC2JihikHro
	rEWdFcNW7Y1xEJIrUwF4Ha/9aYjpPXeX2B0OVV1ZWBp7PVS+Y3sqcvS63FZ17xwFO0ehXvW71m8
	eGNFnSJGlg6oUrcfU0FPpgFywf7hxTbBs5w/gZ+MxldWJTFDu1+dJedA7B8qwI21HCj1eb34klw
	jmXc7WNWxUIUJmAutG5K1BtHz8gANYuRpx456U5SgoEQ=
X-Google-Smtp-Source: AGHT+IG0HhmnyhYS1NNbtaqgrfBIVw6kopyMhg4xbnlgguj5Ju/znaodoDimA2TlTKgeLAva//um+g==
X-Received: by 2002:a17:907:869e:b0:b0f:8f4b:f03a with SMTP id a640c23a62f3a-b1bbdc440d6mr656926166b.61.1758192139676;
        Thu, 18 Sep 2025 03:42:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc73ba1e8sm166719066b.31.2025.09.18.03.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:42:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 03:42:08 -0700
Subject: [PATCH net v5 4/4] selftest: netcons: add test for netconsole over
 bonded interfaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netconsole_torture-v5-4-77e25e0a4eb6@debian.org>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
In-Reply-To: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=13252; i=leitao@debian.org;
 h=from:subject:message-id; bh=UPOeRaoIL7DJ+4Ij9UByVGp65lQeUNBpRGIjUXmOtj0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy+IEsEVWYECduRegaXJkCmtlUiJiY7u67V9g1
 o8unOlNLXOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMviBAAKCRA1o5Of/Hh3
 baB1D/4ih9cLXHDB7XM7Dc3P8aIvtWeTnOX3BEy8GEOOv+Fb7RGzIArFyncReBMnlfGYvdXlW2s
 7epPBsT0XFwAm/AwSrspu+tC9fDBkQXfTo0b0LHVr9s/n3VrlWfX8DE+HwgFo5dLsLcMQfSLc/M
 xQGPlmMqmCvn1jWFU4NBDwxwC312j6Ve1hJC34zNdAisZKgvffZI85+RU2T9k/Z5SAJ5XxHE9Sf
 cuGTPTmHhlaCD1LKwVuguBeuy29VC+iEmoIFl93OFrwndp2PTbwXCbhr/CvhF0ENJfIPUJgfIS1
 U6vZRMVGU3yr1l1DAEpz0QOw+xU8GuRXjKZ/vgJMDbhnEkKkr6noouDHSbsr1gWReSRjFmD8JUN
 WS52grz3izy2G6L4fGjvcdEbmYj0A9yJd3Un/jLum2Pfnp/sGOiOBmTXEKuOcxG1FkoOXsFSP/I
 PqgGmM+RABJqjiy+vtr5I6Lm2ha42NuNeh552UCLcyjx+QAQ2QLwzkbdn4z5lehXAfYvnXIPd7S
 t2tqIWMeqxG+WPEaZWWW+zPWnKf9X6zWerxQm8q/SdEqL66mMcyMNmurhunuA6BofVjGfRQ0oyf
 rcckMS4fqL0bijiGEIS2rC9Nka0GsGUjxy0sgPnjmMRoJeonkb/qQb3c70HcrY4ZtbCHerEGCdf
 WoILWbQO3zc5nPw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch adds a selftest that verifies netconsole functionality
over bonded network interfaces using netdevsim. It sets up two bonded
interfaces acting as transmit (TX) and receive (RX) ends, placed in
separate network namespaces. The test sends kernel log messages and
verifies that they are properly received on the bonded RX interfaces
with both IPv4 and IPv6, and using basic and extended netconsole
formats.

This patchset aims to test a long-standing netpoll are where netpoll has
multiple users. (in this case netconsole and bonding). A similar
selftest has been discussed in [1] and [2].

This depends on CONFIG_BONDING, set it, given it is not set in
kernel/configs/debug.config.
NIPA uses the following command:
 $ vng -v -b -f kernel/configs/debug.config -f tools/testing/selftests/drivers/net/config

Link: https://lore.kernel.org/all/20250905-netconsole_torture-v3-0-875c7febd316@debian.org/ [1]
Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [2]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 tools/testing/selftests/drivers/net/config         |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 167 +++++++++++++++++++--
 .../selftests/drivers/net/netcons_over_bonding.sh  |  76 ++++++++++
 4 files changed, 233 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 2b253b1ff4f38..b49730b393bdc 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
+	netcons_over_bonding.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
 	netcons_torture.sh \
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index f27172ddee0a1..dfa8d3291ce0e 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -1,6 +1,7 @@
 CONFIG_IPV6=y
 CONFIG_NETDEVSIM=m
 CONFIG_CONFIGFS_FS=y
+CONFIG_BONDING=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 9b5ef8074440c..b9436f29ddf29 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -28,17 +28,24 @@ NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
 # NAMESPACE will be populated by setup_ns with a random value
 NAMESPACE=""
 
-# IDs for netdevsim
+# IDs for netdevsim. We either use NSIM_DEV_{1,2}_ID for standard test
+# or NSIM_BOND_{T,R}X_{1,2} for the bonding tests. Not both at the
+# same time.
 NSIM_DEV_1_ID=$((256 + RANDOM % 256))
 NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+NSIM_BOND_TX_1=$((768 + RANDOM % 256))
+NSIM_BOND_TX_2=$((1024 + RANDOM % 256))
+NSIM_BOND_RX_1=$((1280 + RANDOM % 256))
+NSIM_BOND_RX_2=$((1536 + RANDOM % 256))
 NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
+NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
+NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
 
 # Used to create and delete namespaces
 source "${LIBDIR}"/../../../../net/lib.sh
 
 # Create netdevsim interfaces
 create_ifaces() {
-
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
 	udevadm settle 2> /dev/null || true
@@ -54,7 +61,6 @@ create_ifaces() {
 }
 
 link_ifaces() {
-	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
 	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
 	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
 
@@ -96,18 +102,60 @@ function select_ipv4_or_ipv6()
 	fi
 }
 
+# Create 4 netdevsim interfaces. Two of them will be bound to TX bonding iface
+# and the other two will be bond to the RX interface (on the other namespace)
+function create_ifaces_bond() {
+	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_NEW"
+	udevadm settle 2> /dev/null || true
+
+	local BOND_TX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_1"
+	local BOND_TX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_2"
+	local BOND_RX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_1"
+	local BOND_RX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_2"
+
+	# TX
+	BOND_TX1_IF=$(find "$BOND_TX1"/net -maxdepth 1 -type d ! \
+		-path "$BOND_TX1"/net -exec basename {} \; | grep -v net)
+	BOND_TX2_IF=$(find "$BOND_TX2"/net -maxdepth 1 -type d ! \
+		-path "$BOND_TX2"/net -exec basename {} \; | grep -v net)
+
+	# RX
+	BOND_RX1_IF=$(find "$BOND_RX1"/net -maxdepth 1 -type d ! \
+		-path "$BOND_RX1"/net -exec basename {} \; | grep -v net)
+	BOND_RX2_IF=$(find "$BOND_RX2"/net -maxdepth 1 -type d ! \
+		-path "$BOND_RX2"/net -exec basename {} \; | grep -v net)
+}
+
 function set_network() {
 	local IP_VERSION=${1:-"ipv4"}
+	local MODE=${2:-"standard"}
 
 	# setup_ns function is coming from lib.sh
 	setup_ns NAMESPACE
 
-	# Create both interfaces, and assign the destination to a different
-	# namespace
-	create_ifaces
+	if [[  "${MODE}" == "bonding" ]]
+	then
+		# Create two interfaces for RX and two for TX
+		create_ifaces_bond
+		# Link netlink ifaces
+		link_ifaces_bond
+		# Bind the TX ifaces into BONDTX_IF and the receive ifaces
+		# into BONDRX_IF
+		setup_bonding_ifaces
+	else
+		# Create both interfaces, and assign the destination to
+		# a different namespace
+		create_ifaces
 
-	# Link both interfaces back to back
-	link_ifaces
+		# Link both interfaces back to back
+		link_ifaces
+	fi
+	# Here after SRCIF and DSTIF are configured to either
+	# regular interfaces or bonding interfaces, and will be treated
+	# the same.
 
 	select_ipv4_or_ipv6 "${IP_VERSION}"
 	configure_ip
@@ -180,8 +228,6 @@ function disable_release_append() {
 }
 
 function do_cleanup() {
-	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
-
 	# Delete netdevsim devices
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
@@ -193,14 +239,18 @@ function do_cleanup() {
 	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
 }
 
-function cleanup() {
+function cleanup_netcons() {
 	# delete netconsole dynamic reconfiguration
-	echo 0 > "${NETCONS_PATH}"/enabled
+	# do not fail if the target is already disabled
+	echo 0 > "${NETCONS_PATH}"/enabled || true
 	# Remove all the keys that got created during the selftest
 	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
 	# Remove the configfs entry
 	rmdir "${NETCONS_PATH}"
+}
 
+function cleanup() {
+	cleanup_netcons
 	do_cleanup
 }
 
@@ -377,3 +427,96 @@ function wait_for_port() {
 	# more frequently on IPv6
 	sleep 1
 }
+
+# netdevsim link BOND_TX to BOND_RX interfaces
+function link_ifaces_bond() {
+	local BOND_TX1_IFIDX
+	local BOND_TX2_IFIDX
+	local BOND_RX1_IFIDX
+	local BOND_RX2_IFIDX
+
+	BOND_TX1_IFIDX=$(cat /sys/class/net/"$BOND_TX1_IF"/ifindex)
+	BOND_TX2_IFIDX=$(cat /sys/class/net/"$BOND_TX2_IF"/ifindex)
+	BOND_RX1_IFIDX=$(cat /sys/class/net/"$BOND_RX1_IF"/ifindex)
+	BOND_RX2_IFIDX=$(cat /sys/class/net/"$BOND_RX2_IF"/ifindex)
+
+	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
+	exec {INITNS_FD}</proc/self/ns/net
+
+	# Bind the dst interfaces to namespace
+	ip link set "${BOND_RX1_IF}" netns "${NAMESPACE}"
+	ip link set "${BOND_RX2_IF}" netns "${NAMESPACE}"
+
+	# Linking TX ifaces to the RX ones (on the other namespace}
+	echo "${INITNS_FD}:$BOND_TX1_IFIDX $NAMESPACE_FD:$BOND_RX1_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+	echo "${INITNS_FD}:$BOND_TX2_IFIDX $NAMESPACE_FD:$BOND_RX2_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+}
+
+# Create "bond_tx_XX" and "bond_rx_XX" interfaces, and set DSTIF and SRCIF with
+# the bonding interfaces
+function setup_bonding_ifaces() {
+	local RAND=$(( RANDOM % 100 ))
+	BONDTX_IF="bond_tx_$RAND"
+	BONDRX_IF="bond_rx_$RAND"
+
+	if ! ip link add "${BONDTX_IF}" type bond mode balance-rr
+	then
+		echo "Failed to create bond TX interface. Is CONFIG_BONDING set?" >&2
+		# only clean nsim ifaces and namespace. Nothing else has been
+		# initialized
+		cleanup_bond_nsim
+		trap - EXIT
+		exit "${ksft_skip}"
+	fi
+	ip link set "${BOND_TX1_IF}" master "${BONDTX_IF}"
+	ip link set "${BOND_TX2_IF}" master "${BONDTX_IF}"
+	ip link set "${BONDTX_IF}" up
+
+	# now create the RX bonding iface
+	ip netns exec "${NAMESPACE}" \
+		ip link add "${BONDRX_IF}" type bond mode balance-rr
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_IF}" master "${BONDRX_IF}"
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_IF}" master "${BONDRX_IF}"
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BONDRX_IF}" up
+
+	# from here after, SRCIF is bond interface
+	SRCIF="${BONDTX_IF}"
+	DSTIF="${BONDRX_IF}"
+}
+
+# Clean up netdevsim ifaces created for bonding test
+function cleanup_bond_nsim() {
+	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
+	cleanup_all_ns
+}
+
+# Full cleanup
+function cleanup_bond() {
+	cleanup_netcons
+
+	# Delete TX ifaces
+	ip link set "${BONDTX_IF}" down || true
+	ip link set "${BOND_TX1_IF}" down || true
+	ip link set "${BOND_TX2_IF}" down || true
+	ip link delete "${BONDTX_IF}" type bond  || true
+
+	# Delete RX ifaces
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BONDRX_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link delete "${BONDRX_IF}" type bond  || true
+
+	cleanup_bond_nsim
+}
diff --git a/tools/testing/selftests/drivers/net/netcons_over_bonding.sh b/tools/testing/selftests/drivers/net/netcons_over_bonding.sh
new file mode 100755
index 0000000000000..10f2183a16edb
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_over_bonding.sh
@@ -0,0 +1,76 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+# This test verifies netconsole functionality over a bonded network setup.
+#
+# Four interfaces are created using netdevsim; two of them are bonded to serve
+# as the netconsole's transmit interface. The remaining two interfaces are
+# similarly bonded and assigned to a separate network namespace, which acts as
+# the receive interface, where socat monitors for incoming messages.
+#
+# A netconsole message is then sent to ensure it is properly received across
+# this configuration.
+#
+# The test's objective is to exercise netpoll usage when managed simultaneously
+# by multiple subsystems (netconsole and bonding).
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+modprobe bonding 2> /dev/null || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup_bond EXIT
+
+# Run the test twice, with different format modes
+for FORMAT in "basic" "extended"
+do
+	for IP_VERSION in "ipv6" "ipv4"
+	do
+		# Run the test twice, with different format modes
+		echo "Running netcons over bonding ifaces: ${FORMAT} (${IP_VERSION})"
+
+		# Create one namespace and two interfaces
+		set_network "${IP_VERSION}" "bonding"
+		# Create a dynamic target for netconsole
+		create_dynamic_target "${FORMAT}"
+		# Only set userdata for extended format
+		if [ "$FORMAT" == "extended" ]
+		then
+			# Set userdata "key" with the "value" value
+			set_user_data
+		fi
+		# Listed for netconsole port inside the namespace and
+		# destination interface
+		listen_port_and_save_to "${OUTPUT_FILE}" "${IP_VERSION}" &
+		# Wait for socat to start and listen to the port.
+		wait_for_port "${NAMESPACE}" "${PORT}" "${IP_VERSION}"
+		# Send the message
+		echo "${MSG}: ${TARGET}" > /dev/kmsg
+		# Wait until socat saves the file to disk
+		busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+		# Make sure the message was received in the dst part
+		# and exit
+		validate_result "${OUTPUT_FILE}" "${FORMAT}"
+		# kill socat in case it is still running
+		pkill_socat
+		cleanup_bond
+		echo "bonding: ${FORMAT} : ${IP_VERSION} : Test passed" >&2
+	done
+done
+
+trap - EXIT
+exit "${EXIT_STATUS}"

-- 
2.47.3


