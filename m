Return-Path: <linux-kselftest+bounces-46135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A374BC75D18
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 154732B9BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 17:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1112D368DF3;
	Thu, 20 Nov 2025 17:51:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6DA34C830;
	Thu, 20 Nov 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661074; cv=none; b=GD03+CaeCRFxNCTo0hYFhG1Hq+z3RV52tPFqpxSuZNu9I8lMonJhmAmKe1I2GXd1YFOQnAlL1P3AQ4DdC5++AdEqbfcMFNWelMndpBfgAvYqeQrRp979pygsNomGNNREIuyzwrvXG4hEO/4a9Rddp/gwCDYji69GhQpxBL38ndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661074; c=relaxed/simple;
	bh=IS4DwUTshEojQGj9lFhpaXs38iiJg3QzsW2FEaMMwMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWhcxqOJ8TapM/c+5536CDJpk+9sG+gPC9I4KGKW3ICV23gzWOpQ0x6dUL9WBEA8D7QmJFdXU96PvQbuSKsyKHS5YDEqREpXtDRTTnPGqgGCV0u7Tos8Z5D/DMvJ/Byo7+bgyf3jyRlfJHtnfnqu5FCqmrSFbUc9DKDPSNBpoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5VB3xW7zHnGf1;
	Fri, 21 Nov 2025 01:50:26 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id AE85E1402EF;
	Fri, 21 Nov 2025 01:51:01 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:51:01 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>
Subject: [PATCH net-next 12/12] selftests: net: selftest for ipvlan-macnat mode
Date: Thu, 20 Nov 2025 20:49:49 +0300
Message-ID: <20251120174949.3827500-13-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Implemented a self-test for ipvlan in l2macnat mode.

The test verifies:
1) It's not possible to configure an ip in l2macnat mode on ipvtap

2) It creates several net namespaces
- Default namespace emulates host,
- ipvlan-tst-phy emulates some host in remote network
- ipvlan-tst-0/1 emulate VMs on host.

Test verifies, that MAC addresses are as expected in ARP/NEIGH tables:
all MACs in 'tst-phy' points to "host" mac-address
all MACs in Default and tst are real ones

3) The l2macnat mode has limited number of addresses remembered on port.
Test verifies, that this limit really works.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 tools/testing/selftests/net/Makefile          |   2 +
 .../selftests/net/ipvtap_macnat_bridge.py     | 168 +++++++++
 .../selftests/net/ipvtap_macnat_test.sh       | 333 ++++++++++++++++++
 3 files changed, 503 insertions(+)
 create mode 100755 tools/testing/selftests/net/ipvtap_macnat_bridge.py
 create mode 100755 tools/testing/selftests/net/ipvtap_macnat_test.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b5127e968108..050d864f0bd9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -49,6 +49,7 @@ TEST_PROGS := \
 	ipv6_flowlabel.sh \
 	ipv6_force_forwarding.sh \
 	ipv6_route_update_soft_lockup.sh \
+	ipvtap_macnat_test.sh \
 	l2_tos_ttl_inherit.sh \
 	l2tp.sh \
 	link_netns.py \
@@ -191,6 +192,7 @@ TEST_GEN_PROGS := \
 TEST_FILES := \
 	fcnal-test.sh \
 	in_netns.sh \
+	ipvtap_macnat_bridge.py \
 	lib.sh \
 	settings \
 	setup_loopback.sh \
diff --git a/tools/testing/selftests/net/ipvtap_macnat_bridge.py b/tools/testing/selftests/net/ipvtap_macnat_bridge.py
new file mode 100755
index 000000000000..7dc4a626e5bb
--- /dev/null
+++ b/tools/testing/selftests/net/ipvtap_macnat_bridge.py
@@ -0,0 +1,168 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Script to bridge ipvtap and tap,
+needed to simulate behaviour of virtual machine using ipvtap.
+
+ipvtap in macnat mode cannot have IP address.
+Due to limitations of ipvtap, it also cannot be plugged
+into bridge.
+Use this script to connect ipvtap and tap and assing IP to tap.
+"""
+
+import socket
+import os
+import select
+import sys
+import signal
+import fcntl
+import struct
+import subprocess
+
+# Linux TUN/TAP constants
+TUNSETIFF = 0x400454ca
+IFF_TUN = 0x0001
+IFF_TAP = 0x0002
+IFF_NO_PI = 0x1000
+
+ns_name = "non-initialized"
+
+class TapBridge:
+    """Simple class to bridge ipvtap and tap interfaces"""
+    def __init__(self, tap, ipvtap, buffer_size=65536):
+        self.tap_name = tap
+        self.ipvtap_name = ipvtap
+        self.buffer_size = buffer_size
+        self.running = False
+
+    def open_ipvtap_sock(self, tap_name):
+        """Open a IPVTAP interface using raw socket"""
+        try:
+            sock = socket.socket(socket.AF_PACKET,
+                                 socket.SOCK_RAW,
+                                 socket.ntohs(0x0003))
+            sock.bind((tap_name, 0))
+            sock.setblocking(False)
+            print(f"Connected to IPVTAP interface: {tap_name}")
+            return sock
+
+        except (OSError, IOError) as e:
+            print(f"Error opening IPVTAP interface {tap_name}: {e}")
+            return None
+
+    def create_tap_interface(self, tap_name):
+        """Create and configure a TAP interface using /dev/net/tun"""
+        try:
+            # Open the tun device
+            tun_fd = os.open('/dev/net/tun', os.O_RDWR)
+            if tun_fd < 0:
+                raise OSError("Failed to open /dev/net/tun (err: {os.errno})")
+
+            # Prepare the ifr structure
+            tap_name_bytes = tap_name.encode('utf-8')
+            ifr = struct.pack('16sH', tap_name_bytes, IFF_TAP | IFF_NO_PI)
+
+            # Set the interface name and flags
+            result = fcntl.ioctl(tun_fd, TUNSETIFF, ifr)
+
+            # Get the actual interface name that was set
+            unpacked = struct.unpack('16sH', result)
+            actual_name = unpacked[0].split(b'\x00')[0].decode()
+            print(f"Created TAP interface: {actual_name}")
+
+            return tun_fd
+
+        except (OSError, IOError) as e:
+            print(f"Error creating TAP interface {tap_name}: {e}")
+            return None
+
+    def forward_data(self, from_fd, to_fd, description):
+        """Forward data from one file descriptor to another"""
+        try:
+            data = os.read(from_fd, self.buffer_size)
+            if data:
+                os.write(to_fd, data)
+                return True
+            return False
+
+        except BlockingIOError:
+            return True
+        except (OSError, IOError) as e:
+            print(f"Error forwarding data {description}: {e}")
+            return False
+
+    def run(self):
+        """Main bridge loop"""
+        # Create TAP interfaces
+        tap1_fd = self.create_tap_interface(self.tap_name)
+
+        sock = self.open_ipvtap_sock(self.ipvtap_name)
+        tap2_fd = sock.fileno()
+
+        if tap1_fd is None or tap2_fd is None:
+            print("Failed to create TAP interfaces")
+            return
+
+        print("Press Ctrl+C to stop\n")
+
+        self.running = True
+        stats = {'tap1_to_tap2': 0, 'tap2_to_tap1': 0}
+        while self.running:
+            try:
+                # Use select to monitor both file descriptors
+                readable, _, _ = select.select([tap1_fd, tap2_fd], [], [], 1.0)
+
+                for fd in readable:
+                    if fd == tap1_fd:
+                        descr = f"from {self.tap_name} to {self.ipvtap_name}"
+                        if self.forward_data(tap1_fd, tap2_fd, descr):
+                            stats['tap1_to_tap2'] += 1
+                        else:
+                            self.running = False
+                    elif fd == tap2_fd:
+                        descr = f"from {self.ipvtap_name} to {self.tap_name}"
+                        if self.forward_data(tap2_fd, tap1_fd, descr):
+                            stats['tap2_to_tap1'] += 1
+                        else:
+                            self.running = False
+
+            except KeyboardInterrupt:
+                print("\nShutting down...")
+                self.running = False
+            except (OSError, IOError) as e:
+                print(f"Error in main loop: {e}")
+                self.running = False
+
+        # Cleanup
+        os.close(tap1_fd)
+        os.close(tap2_fd)
+        print(f"Bridge stopped in {ns_name}. Stats: {stats}")
+
+
+def signal_handler(_sig, _frame):
+    """SIGINT handler for macnat bridge"""
+    print(f'\nReceived interrupt signal, shutting down bridge in {ns_name}')
+    sys.exit(0)
+
+
+if __name__ == "__main__":
+    ns_name = subprocess.getoutput("ip netns identify") or "default"
+
+    signal.signal(signal.SIGINT, signal_handler)
+
+    # Check if running as root
+    if os.geteuid() != 0:
+        print("ERROR: This script must be run as root!")
+        sys.exit(1)
+
+    if len(sys.argv) != 3:
+        print("Usage: tap_bridge.py tap_name ipvtap_name")
+        sys.exit(1)
+
+    TAP = sys.argv[1]
+    IPVTAP = sys.argv[2]
+
+    print(f"Starting TAP bridge between {TAP} and {IPVTAP} in {ns_name}")
+    bridge = TapBridge(TAP, IPVTAP)
+    bridge.run()
diff --git a/tools/testing/selftests/net/ipvtap_macnat_test.sh b/tools/testing/selftests/net/ipvtap_macnat_test.sh
new file mode 100755
index 000000000000..927d75af776b
--- /dev/null
+++ b/tools/testing/selftests/net/ipvtap_macnat_test.sh
@@ -0,0 +1,333 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Tests for ipvtap in macnat mode
+
+NS_TST0=ipvlan-tst-0
+NS_TST1=ipvlan-tst-1
+NS_PHY=ipvlan-tst-phy
+
+IP_HOST=172.25.0.1
+IP_PHY=172.25.0.2
+IP_TST0=172.25.0.10
+IP_TST1=172.25.0.30
+
+IP_OK0=("172.25.0.10" "172.25.0.11" "172.25.0.12" "172.25.0.13")
+IP6_OK0=("fc00::10" "fc00::11" "fc00::12" "fc00::13" )
+
+IP_OVFL0="172.25.0.14"
+IP6_OVFL0="fc00::14"
+
+IP6_HOST=fc00::1
+IP6_PHY=fc00::2
+IP6_TST0=fc00::10
+IP6_TST1=fc00::30
+
+MAC_HOST="92:3a:00:00:00:01"
+MAC_PHY="92:3a:00:00:00:02"
+MAC_TST0="92:3a:00:00:00:10"
+MAC_TST1="92:3a:00:00:00:30"
+
+VETH_HOST=vethtst
+VETH_PHY=vethtst.p
+
+#
+# The testing environment looks this way:
+#
+# |------HOST------|     |------PHY-------|
+# |      veth<----------------->veth      |
+# |------|--|------|     |----------------|
+#        |  |
+#        |  |            |-----TST0-------|
+#        |  |------------|----ipvtap      |
+#        |               |----------------|
+#        |
+#        |               |-----TST1-------|
+#        |---------------|----ivtap       |
+#                        |----------------|
+#
+# The macnat mode is for virtual machines, so ipvtap-interface is supposed
+# to be used only for traffic monitoring and doesn't have ip-address.
+#
+# To simulate a virtual machine on ipvtap, we create TAP-interfaces
+# in TST environments and assing IP-addresses to them.
+# TAP and IPVTAP are connected with simple python script.
+#
+
+ns_run() {
+	ns=$1
+	shift
+	if [[ "$ns" == "default" ]]; then
+		"$@" >/dev/null
+	else
+		ip netns exec "$ns" "$@" >/dev/null
+	fi
+}
+
+configure_ns() {
+	local ns=$1
+	local n=$2
+	local ip=$3
+	local ip6=$4
+	local mac=$5
+
+	ns_run "$ns" ip link set lo up
+
+	if ! ip link add netns "$ns" name "ipvtap0.$n" link $VETH_HOST \
+	    type ipvtap mode l2macnat bridge; then
+		exit_error "FAIL: Failed to configure ipvtap link."
+	fi
+	ns_run "$ns" ip link set "ipvtap0.$n" up
+
+	ns_run "$ns" ip tuntap add mode tap "tap0.$n"
+	ns_run "$ns" ip link set dev "tap0.$n" address "$mac"
+	# disable dad
+	ns_run "$ns" sysctl -w "net/ipv6/conf/tap0.$n/accept_dad"=0
+	ns_run "$ns" ip link set "tap0.$n" up
+	ns_run "$ns" ip a a "$ip/24" dev "tap0.$n"
+	ns_run "$ns" ip a a "$ip6/64" dev "tap0.$n"
+}
+
+start_macnat_bridge() {
+	local ns=$1
+	local n=$2
+	ip netns exec "$ns" python3 ipvtap_macnat_bridge.py \
+		"tap0.$n" "ipvtap0.$n" &
+}
+
+configure_veth() {
+	local ns=$1
+	local veth=$2
+	local ip=$3
+	local ip6=$4
+	local mac=$5
+
+	ns_run "$ns" ip link set lo up
+	ns_run "$ns" ethtool -K "$veth" tx off rx off
+	ns_run "$ns" ip link set dev "$veth" address "$mac"
+	ns_run "$ns" ip link set "$veth" up
+	ns_run "$ns" ip a a "$ip/24" dev "$veth"
+	ns_run "$ns" ip a a "$ip6/64" dev "$veth"
+}
+
+setup_env() {
+	ip netns add $NS_TST0
+	ip netns add $NS_TST1
+	ip netns add $NS_PHY
+
+	# setup simulated other-host (phy) and host itself
+	ip link add $VETH_HOST type veth peer name $VETH_PHY \
+	    netns $NS_PHY >/dev/null
+
+	# host config
+	configure_veth default $VETH_HOST $IP_HOST $IP6_HOST $MAC_HOST
+	configure_veth $NS_PHY $VETH_PHY $IP_PHY $IP6_PHY $MAC_PHY
+
+	# TST namespaces config
+	configure_ns $NS_TST0 0 $IP_TST0 $IP6_TST0 $MAC_TST0
+	configure_ns $NS_TST1 1 $IP_TST1 $IP6_TST1 $MAC_TST1
+}
+
+ping_all() {
+	# This will learn MAC/IP addresses on ipvtap
+	local ns=$1
+
+	ns_run "$ns" ping -c 1 $IP_TST0
+	ns_run "$ns" ping -c 1 $IP6_TST0
+
+	ns_run "$ns" ping -c 1 $IP_TST1
+	ns_run "$ns" ping -c 1 $IP6_TST1
+
+	ns_run "$ns" ping -c 1 $IP_HOST
+	ns_run "$ns" ping -c 1 $IP6_HOST
+
+	ns_run "$ns" ping -c 1 $IP_PHY
+	ns_run "$ns" ping -c 1 $IP6_PHY
+}
+
+check_mac_eq() {
+	# Ensure IP corresponds to MAC.
+	local ns=$1
+	local ip=$2
+	local mac=$3
+	local dev=$4
+
+	if [[ "$ns" == "default" ]]; then
+		out=$(
+			ip neigh show "$ip" dev "$dev" \
+			| grep "$ip" \
+			| grep "$mac"
+		)
+	else
+		out=$(
+			ip netns exec "$ns" \
+			ip neigh show "$ip" dev "$dev" \
+			| grep "$ip" \
+			| grep "$mac"
+		)
+	fi
+
+	if [[ $out'X' == "X" ]]; then
+		exit_error "FAIL: '$ip' is not '$mac'"
+	fi
+}
+
+cleanup_env() {
+	ip link del $VETH_HOST
+	ip netns del $NS_TST0
+	ip netns del $NS_TST1
+	ip netns del $NS_PHY
+}
+
+exit_error() {
+	echo "$1"
+	exit 1
+}
+
+test_check_mac() {
+	# All IPs in NS_PHY should have MAC of the host
+	check_mac_eq $NS_PHY $IP_TST0 $MAC_HOST $VETH_PHY
+	check_mac_eq $NS_PHY $IP6_TST0 $MAC_HOST $VETH_PHY
+	check_mac_eq $NS_PHY $IP_TST1 $MAC_HOST $VETH_PHY
+	check_mac_eq $NS_PHY $IP6_TST1 $MAC_HOST $VETH_PHY
+	check_mac_eq $NS_PHY $IP_HOST $MAC_HOST $VETH_PHY
+	check_mac_eq $NS_PHY $IP6_HOST $MAC_HOST $VETH_PHY
+
+	# All IPs in TST0 should have corresponding MAC
+	check_mac_eq $NS_TST0 $IP_HOST $MAC_HOST tap0.0
+	check_mac_eq $NS_TST0 $IP6_HOST $MAC_HOST tap0.0
+	check_mac_eq $NS_TST0 $IP_TST1 $MAC_TST1 tap0.0
+	check_mac_eq $NS_TST0 $IP6_TST1 $MAC_TST1 tap0.0
+	check_mac_eq $NS_TST0 $IP_PHY $MAC_PHY tap0.0
+	check_mac_eq $NS_TST0 $IP6_PHY $MAC_PHY tap0.0
+
+	# All IPs in host should have corresponding MAC
+	check_mac_eq default $IP_TST0 $MAC_TST0 $VETH_HOST
+	check_mac_eq default $IP6_TST0 $MAC_TST0 $VETH_HOST
+	check_mac_eq default $IP_TST1 $MAC_TST1 $VETH_HOST
+	check_mac_eq default $IP6_TST1 $MAC_TST1 $VETH_HOST
+	check_mac_eq default $IP_PHY $MAC_PHY $VETH_HOST
+	check_mac_eq default $IP6_PHY $MAC_PHY $VETH_HOST
+}
+
+test_ip_add() {
+	# adding IPs to ipvtap should be forbidden and should fail
+	if ns_run $NS_TST0 ip a a 172.26.0.1/24 dev ipvtap0.0; then
+		exit_error "FAIL: Module allowed to add ip to ipvtap."
+	fi
+
+	if ns_run $NS_TST0 ip a a fc01::1/64 dev ipvtap0.0; then
+		exit_error "FAIL: Module allowed to add ip6 to ipvtap."
+	fi
+}
+
+test_ip_overflow() {
+	# The ipvtap remembers limited number of addresses on interface.
+	# Let's overflow it and check that oldest one doesn't work.
+
+	ns_run $NS_TST0 ip addr flush dev tap0.0
+
+	# Add exactly 4 ip addresses
+	for ip in "${IP_OK0[@]}"; do
+		ns_run $NS_TST0 ip a a "$ip/24" dev tap0.0
+		ns_run $NS_TST0 ping -c 1 $IP_HOST -I "$ip"
+	done
+
+	# Initial check that ping works
+	if ! ping -c 2 $IP_TST0; then
+		exit_error "FAIL: Failed to ping tst0"
+	fi
+
+	# Add 1 more ip addresses
+	ns_run "$NS_TST0" ip a a $IP_OVFL0/24 dev tap0.0
+	ns_run $NS_TST0 ping -c 1 $IP_HOST -I $IP_OVFL0
+	# check that ping to oldest one from host fails.
+	echo "the next ping should fail:"
+	if ping -c 2 $IP_TST0; then
+		exit_error "FAIL: IP-0 still exists on interface"
+	fi
+
+	# ping host using address-0 and force relearn of IP0.
+	# Host should be able ping after that
+	ns_run $NS_TST0 ping -c 1 $IP_HOST -I $IP_TST0
+
+	if ! ping -c 2 $IP_TST0; then
+		exit_error "FAIL: Failed to ping tst0 at stage 3"
+	fi
+}
+
+test_ip6_overflow() {
+	# The ipvtap stores limited number of addresses on interface.
+	# Let's overflow it and check that oldest one doesn't work.
+
+	ns_run $NS_TST0 ip addr flush dev tap0.0
+
+	# Add exactly 4 ip addresses
+	for ip6 in "${IP6_OK0[@]}"; do
+		ns_run $NS_TST0 ip a a "$ip6/64" dev tap0.0
+		ns_run $NS_TST0 ping -c 1 $IP6_HOST -I "$ip6"
+	done
+
+	# Initial check that ping6 works
+	if ! ping -c 2 $IP6_TST0; then
+		exit_error "FAIL: Failed to ping6 tst0"
+	fi
+
+	# Add 1 more ip6 addresses
+	ns_run $NS_TST0 ip a a $IP6_OVFL0/64 dev tap0.0
+	ns_run $NS_TST0 ping -c 1 $IP6_HOST -I $IP6_OVFL0
+	# check that ping to oldest one from host fails.
+	echo "the next ping should fail:"
+	if ping -c 2 $IP6_TST0; then
+		exit_error "FAIL: IP6-0 still exists on interface"
+	fi
+
+	# ping host using address-0 and force relearn of IP0.
+	# Host should be able ping after that
+	ns_run $NS_TST0 ping -c 1 $IP6_HOST -I $IP6_TST0
+	if ! ping -c 2 $IP6_TST0; then
+		exit_error "FAIL: Failed to ping6 tst0 at stage 3"
+	fi
+}
+
+exec_test() {
+	echo "TEST: $2"
+	$1
+	echo "PASSED: $2"
+}
+
+trap cleanup_env EXIT
+
+echo "ipvlan macnat tests"
+echo "==================="
+
+modprobe -q tap
+modprobe -q ipvlan
+modprobe -q ipvtap
+
+setup_env
+
+exec_test test_ip_add "ip add not allowed"
+
+start_macnat_bridge $NS_TST0 0
+mb_pid1=$!
+start_macnat_bridge $NS_TST1 1
+mb_pid2=$!
+
+echo "<<< Preparation: pinging all...."
+ping_all default
+ping_all $NS_TST0
+ping_all $NS_TST1
+ping_all $NS_PHY
+echo "Finished preparational pinging all. >>>"
+
+exec_test test_check_mac "mac correctness"
+exec_test test_ip_overflow "ip learn capacity overflow"
+exec_test test_ip6_overflow "ip6 learn capacity overflow"
+
+kill -INT $mb_pid1
+kill -INT $mb_pid2
+wait $mb_pid1
+wait $mb_pid2
+
+echo "All tests passed"
-- 
2.25.1


