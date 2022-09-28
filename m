Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C855EE426
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiI1SPw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 14:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiI1SPu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 14:15:50 -0400
Received: from mailout-taastrup.gigahost.dk (mailout-taastrup.gigahost.dk [46.183.139.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A67DCE91;
        Wed, 28 Sep 2022 11:15:43 -0700 (PDT)
Received: from mailout.gigahost.dk (mailout.gigahost.dk [89.186.169.112])
        by mailout-taastrup.gigahost.dk (Postfix) with ESMTP id 298421884BE3;
        Wed, 28 Sep 2022 18:15:41 +0000 (UTC)
Received: from smtp.gigahost.dk (smtp.gigahost.dk [89.186.169.109])
        by mailout.gigahost.dk (Postfix) with ESMTP id 20CFB25005A8;
        Wed, 28 Sep 2022 18:15:41 +0000 (UTC)
Received: by smtp.gigahost.dk (Postfix, from userid 0)
        id 16EF29120FED; Wed, 28 Sep 2022 18:15:41 +0000 (UTC)
X-Screener-Id: 413d8c6ce5bf6eab4824d0abaab02863e8e3f662
Received: from fujitsu.vestervang (2-104-116-184-cable.dk.customer.tdc.net [2.104.116.184])
        by smtp.gigahost.dk (Postfix) with ESMTPSA id 6177A9120FED;
        Wed, 28 Sep 2022 15:06:32 +0000 (UTC)
From:   Hans Schultz <netdev@kapio-technology.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org,
        "Hans J. Schultz" <netdev@kapio-technology.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Shuah Khan <shuah@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yuwei Wang <wangyuweihx@gmail.com>,
        Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Florent Fourcot <florent.fourcot@wifirst.fr>,
        Hans Schultz <schultz.hans@gmail.com>,
        Joachim Wiberg <troglobit@gmail.com>,
        Amit Cohen <amcohen@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        bridge@lists.linux-foundation.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v6 net-next 9/9] selftests: forwarding: add test of MAC-Auth Bypass to locked port tests
Date:   Wed, 28 Sep 2022 17:02:56 +0200
Message-Id: <20220928150256.115248-10-netdev@kapio-technology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928150256.115248-1-netdev@kapio-technology.com>
References: <20220928150256.115248-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Hans J. Schultz" <netdev@kapio-technology.com>

Verify that the MAC-Auth mechanism works by adding a FDB entry with the
locked flag set, denying access until the FDB entry is replaced with a
FDB entry without the locked flag set.

Add test of blackhole fdb entries, verifying that there is no forwarding
to a blackhole entry from any port, and that the blackhole entry can be
replaced.

Also add a test that verifies that sticky FDB entries cannot roam (this
is not needed for now, but should in general be present anyhow for future
applications).

Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
---
 .../net/forwarding/bridge_blackhole_fdb.sh    | 102 +++++++++++++++++
 .../net/forwarding/bridge_locked_port.sh      | 106 +++++++++++++++++-
 .../net/forwarding/bridge_sticky_fdb.sh       |  21 +++-
 tools/testing/selftests/net/forwarding/lib.sh |  18 +++
 4 files changed, 245 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh

diff --git a/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh b/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh
new file mode 100755
index 000000000000..54b1a51e1ed6
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_blackhole_fdb.sh
@@ -0,0 +1,102 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ALL_TESTS="blackhole_fdb"
+NUM_NETIFS=4
+source lib.sh
+
+switch_create()
+{
+        ip link add dev br0 type bridge
+
+        ip link set dev $swp1 master br0
+        ip link set dev $swp2 master br0
+
+        ip link set dev br0 up
+        ip link set dev $h1 up
+        ip link set dev $swp1 up
+        ip link set dev $h2 up
+        ip link set dev $swp2 up
+
+	tc qdisc add dev $swp2 clsact
+}
+
+switch_destroy()
+{
+	tc qdisc del dev $swp2 clsact
+
+        ip link set dev $swp2 down
+        ip link set dev $h2 down
+        ip link set dev $swp1 down
+        ip link set dev $h1 down
+
+        ip link del dev br0
+}
+
+setup_prepare()
+{
+        h1=${NETIFS[p1]}
+        swp1=${NETIFS[p2]}
+        h2=${NETIFS[p3]}
+        swp2=${NETIFS[p4]}
+
+        switch_create
+}
+
+cleanup()
+{
+        pre_cleanup
+        switch_destroy
+}
+
+# Check that there is no egress with blackhole entry and that blackhole entries can be replaced
+blackhole_fdb()
+{
+        RET=0
+
+	check_blackhole_fdb_support || return 0
+
+	tc filter add dev $swp2 egress protocol ip pref 1 handle 1 flower \
+		dst_ip 192.0.2.2 ip_proto udp dst_port 12345 action pass
+
+	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
+		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
+
+	tc_check_packets "dev $swp2 egress" 1 1
+	check_err $? "Packet not seen on egress before adding blackhole entry"
+
+	bridge fdb add `mac_get $h2` dev br0 blackhole
+	bridge fdb get `mac_get $h2` br br0 | grep -q blackhole
+	check_err $? "Blackhole entry not found"
+
+	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
+		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
+
+	tc_check_packets "dev $swp2 egress" 1 1
+	check_err $? "Packet seen on egress after adding blackhole entry"
+
+	# Check blackhole entries can be replaced.
+	bridge fdb replace `mac_get $h2` dev $swp2 master static
+	bridge fdb get `mac_get $h2` br br0 | grep -q blackhole
+	check_fail $? "Blackhole entry found after replacement"
+
+	$MZ $h1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
+		-a own -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
+
+	tc_check_packets "dev $swp2 egress" 1 2
+	check_err $? "Packet not seen on egress after replacing blackhole entry"
+
+	bridge fdb del `mac_get $h2` dev $swp2 master static
+	tc filter del dev $swp2 egress protocol ip pref 1 handle 1 flower
+
+        log_test "Blackhole FDB entry"
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index 5b02b6b60ce7..59b8b7666eab 100755
--- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
@@ -1,7 +1,15 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan"
+ALL_TESTS="
+	locked_port_ipv4
+	locked_port_ipv6
+	locked_port_vlan
+	locked_port_mab
+	locked_port_station_move
+	locked_port_mab_station_move
+"
+
 NUM_NETIFS=4
 CHECK_TC="no"
 source lib.sh
@@ -166,6 +174,102 @@ locked_port_ipv6()
 	log_test "Locked port ipv6"
 }
 
+locked_port_mab()
+{
+	RET=0
+	check_locked_port_support || return 0
+
+	ping_do $h1 192.0.2.2
+	check_err $? "MAB: Ping did not work before locking port"
+
+	bridge link set dev $swp1 locked on
+	check_port_mab_support $swp1 || return 0
+
+	ping_do $h1 192.0.2.2
+	check_fail $? "MAB: Ping worked on locked port without FDB entry"
+
+	bridge fdb show | grep `mac_get $h1` | grep -q "locked"
+	check_err $? "MAB: No locked fdb entry after ping on locked port"
+
+	bridge fdb replace `mac_get $h1` dev $swp1 master static
+
+	ping_do $h1 192.0.2.2
+	check_err $? "MAB: Ping did not work with fdb entry without locked flag"
+
+	bridge fdb del `mac_get $h1` dev $swp1 master
+	bridge link set dev $swp1 locked off mab off
+
+	log_test "Locked port MAB"
+}
+
+# No roaming allowed to a simple locked port
+locked_port_station_move()
+{
+	local mac=a0:b0:c0:c0:b0:a0
+
+	RET=0
+	check_locked_port_support || return 0
+
+	bridge link set dev $swp1 locked on
+
+	$MZ $h1 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "master br0"
+	check_fail $? "Locked port station move: FDB entry on first injection"
+
+	$MZ $h2 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp2 | grep "$mac vlan 1" | grep -q "master br0"
+	check_err $? "Locked port station move: Entry not found on unlocked port"
+
+	$MZ $h1 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "master br0"
+	check_fail $? "Locked port station move: entry roamed to locked port"
+
+	bridge link set dev $swp1 locked off
+
+	log_test "Locked port station move"
+}
+
+# Roaming to and from a MAB enabled port should work if sticky flag is not set
+locked_port_mab_station_move()
+{
+	local mac=10:20:30:30:20:10
+
+	RET=0
+	check_locked_port_support || return 0
+
+	bridge link set dev $swp1 locked on
+
+	check_port_mab_support $swp1 || return 0
+
+	$MZ $h1 -q -t udp -a $mac -b rand
+	if bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "permanent"; then
+		echo "SKIP: Roaming not possible with local flag, skipping test..."
+		bridge link set dev $swp1 locked off mab off
+		return $ksft_skip
+	fi
+
+	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "locked"
+	check_err $? "MAB station move: no locked entry on first injection"
+
+	$MZ $h2 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "locked"
+	check_fail $? "MAB station move: locked entry did not move"
+
+	bridge fdb show dev $swp2 | grep "$mac vlan 1" | grep -q "locked"
+	check_fail $? "MAB station move: roamed entry to unlocked port had locked flag on"
+
+	bridge fdb show dev $swp2 | grep "$mac vlan 1" | grep -q "master br0"
+	check_err $? "MAB station move: roamed entry not found"
+
+	$MZ $h1 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep "master br0" | grep -q "locked"
+	check_fail $? "MAB station move: entry roamed back to locked port"
+
+	bridge link set dev $swp1 locked off mab off
+
+	log_test "Locked port MAB station move"
+}
+
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh b/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
index 1f8ef0eff862..bca77bc3fe09 100755
--- a/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="sticky"
+ALL_TESTS="sticky sticky_no_roaming"
 NUM_NETIFS=4
 TEST_MAC=de:ad:be:ef:13:37
 source lib.sh
@@ -59,6 +59,25 @@ sticky()
 	log_test "Sticky fdb entry"
 }
 
+# No roaming allowed with the sticky flag set
+sticky_no_roaming()
+{
+	local mac=a8:b4:c2:c2:b4:a8
+
+	RET=0
+
+	bridge link set dev $swp2 learning on
+	bridge fdb add $mac dev $swp1 master static sticky
+	bridge fdb show dev $swp1 | grep "$mac master br0" | grep -q sticky
+	check_err $? "Sticky no roaming: No sticky FDB entry found after adding"
+
+	$MZ $h2 -q -t udp -c 10 -d 100msec -a $mac -b rand
+	bridge fdb show dev $swp2 | grep "$mac master br0" | grep -q sticky
+	check_fail $? "Sticky no roaming: Sticky entry roamed"
+
+	log_test "Sticky no roaming"
+}
+
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 3ffb9d6c0950..642fbf217c20 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -137,6 +137,24 @@ check_locked_port_support()
 	fi
 }
 
+check_port_mab_support()
+{
+	local dev=$1;
+
+	if ! bridge link set dev $dev mab on 2>/dev/null; then
+		echo "SKIP: iproute2 too old; MacAuth feature not supported."
+		return $ksft_skip
+	fi
+}
+
+check_blackhole_fdb_support()
+{
+	if ! bridge fdb help | grep -q "blackhole"; then
+		echo "SKIP: Blackhole fdb feature not supported."
+		return $ksft_skip
+	fi
+}
+
 if [[ "$(id -u)" -ne 0 ]]; then
 	echo "SKIP: need root privileges"
 	exit $ksft_skip
-- 
2.34.1

