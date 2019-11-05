Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F41CF09CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2019 23:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfKEWsj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Nov 2019 17:48:39 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:41617 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfKEWsj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Nov 2019 17:48:39 -0500
Received: from us180.sjc.aristanetworks.com (us180.sjc.aristanetworks.com [172.25.230.4])
        by smtp.aristanetworks.com (Postfix) with ESMTP id E8F861E742;
        Tue,  5 Nov 2019 14:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1572994115;
        bh=ZmXdS/0E5DdRcvuILjROV///j083rRu2nYDsZL6zL0k=;
        h=Date:To:Subject:From:From;
        b=VfcsFzNhAj6hm9r7kjLNrepFM/E3rflLRG9ARRc8NMXSWThwMFGSpEoJ0wBIa3PvM
         AdrNX/JlplHuazC6OmxblmQJde5q/CdHMBHQmEKIoAQZooSo+Wa95Fzlk8ghXYzIzR
         eRmUsJyJSo4DQBKP4MIIcsi6xRRTCJXlhMdApRh6VQLmGgTChroVQLtGYOJu7CS+Fu
         a4RFANv1sZ0vlUdcuJkY5P+5Vpc/hfigOlemwE+SbfYB4Opfi+qB0RcPBuRTn+2Abp
         KQMRv8CHQMSbV2p5Bqev4DdP2vB5qEcuKyLkwAddT2WJ1Jv/jrgE+qI11T7QQMMZF0
         XjljCPZSW553w==
Received: by us180.sjc.aristanetworks.com (Postfix, from userid 10189)
        id D134F95C0C6F; Tue,  5 Nov 2019 14:48:35 -0800 (PST)
Date:   Tue, 05 Nov 2019 14:48:35 -0800
To:     dsahern@gmail.com, davem@davemloft.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        fruggeri@arista.com
Subject: [PATCH net-next v2] selftest: net: add some traceroute tests
User-Agent: Heirloom mailx 12.5 7/5/10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20191105224835.D134F95C0C6F@us180.sjc.aristanetworks.com>
From:   fruggeri@arista.com (Francesco Ruggeri)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Added the following traceroute tests.

IPV6:
Verify that in this scenario

       ------------------------ N2
        |                    |
      ------              ------  N3  ----
      | R1 |              | R2 |------|H2|
      ------              ------      ----
        |                    |
       ------------------------ N1
                 |
                ----
                |H1|
                ----

where H1's default route goes through R1 and R1's default route goes
through R2 over N2, traceroute6 from H1 to H2 reports R2's address
on N2 and not N1.

IPV4:
Verify that traceroute from H1 to H2 shows 1.0.1.1 in this scenario

                   1.0.3.1/24
---- 1.0.1.3/24    1.0.1.1/24 ---- 1.0.2.1/24    1.0.2.4/24 ----
|H1|--------------------------|R1|--------------------------|H2|
----            N1            ----            N2            ----

where net.ipv4.icmp_errors_use_inbound_ifaddr is set on R1 and
1.0.3.1/24 and 1.0.1.1/24 are respectively R1's primary and secondary
address on N1.

v2: fixed some typos, and have bridge in R1 instead of R2 in IPV6 test.

Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
---
 tools/testing/selftests/net/Makefile      |   2 +-
 tools/testing/selftests/net/traceroute.sh | 322 ++++++++++++++++++++++
 2 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/traceroute.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 0bd6b23c97ef..a8e04d665b69 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -10,7 +10,7 @@ TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_defrag.sh
 TEST_PROGS += udpgso_bench.sh fib_rule_tests.sh msg_zerocopy.sh psock_snd.sh
 TEST_PROGS += udpgro_bench.sh udpgro.sh test_vxlan_under_vrf.sh reuseport_addr_any.sh
 TEST_PROGS += test_vxlan_fdb_changelink.sh so_txtime.sh ipv6_flowlabel.sh
-TEST_PROGS += tcp_fastopen_backup_key.sh fcnal-test.sh l2tp.sh
+TEST_PROGS += tcp_fastopen_backup_key.sh fcnal-test.sh l2tp.sh traceroute.sh
 TEST_PROGS_EXTENDED := in_netns.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
new file mode 100755
index 000000000000..de9ca97abc30
--- /dev/null
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -0,0 +1,322 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Run traceroute/traceroute6 tests
+#
+
+VERBOSE=0
+PAUSE_ON_FAIL=no
+
+################################################################################
+#
+log_test()
+{
+	local rc=$1
+	local expected=$2
+	local msg="$3"
+
+	if [ ${rc} -eq ${expected} ]; then
+		printf "TEST: %-60s  [ OK ]\n" "${msg}"
+		nsuccess=$((nsuccess+1))
+	else
+		ret=1
+		nfail=$((nfail+1))
+		printf "TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+			echo
+			echo "hit enter to continue, 'q' to quit"
+			read a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+}
+
+run_cmd()
+{
+	local ns
+	local cmd
+	local out
+	local rc
+
+	ns="$1"
+	shift
+	cmd="$*"
+
+	if [ "$VERBOSE" = "1" ]; then
+		printf "    COMMAND: $cmd\n"
+	fi
+
+	out=$(eval ip netns exec ${ns} ${cmd} 2>&1)
+	rc=$?
+	if [ "$VERBOSE" = "1" -a -n "$out" ]; then
+		echo "    $out"
+	fi
+
+	[ "$VERBOSE" = "1" ] && echo
+
+	return $rc
+}
+
+################################################################################
+# create namespaces and interconnects
+
+create_ns()
+{
+	local ns=$1
+	local addr=$2
+	local addr6=$3
+
+	[ -z "${addr}" ] && addr="-"
+	[ -z "${addr6}" ] && addr6="-"
+
+	ip netns add ${ns}
+
+	ip netns exec ${ns} ip link set lo up
+	if [ "${addr}" != "-" ]; then
+		ip netns exec ${ns} ip addr add dev lo ${addr}
+	fi
+	if [ "${addr6}" != "-" ]; then
+		ip netns exec ${ns} ip -6 addr add dev lo ${addr6}
+	fi
+
+	ip netns exec ${ns} ip ro add unreachable default metric 8192
+	ip netns exec ${ns} ip -6 ro add unreachable default metric 8192
+
+	ip netns exec ${ns} sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
+	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.forwarding=1
+	ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.forwarding=1
+	ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.accept_dad=0
+}
+
+# create veth pair to connect namespaces and apply addresses.
+connect_ns()
+{
+	local ns1=$1
+	local ns1_dev=$2
+	local ns1_addr=$3
+	local ns1_addr6=$4
+	local ns2=$5
+	local ns2_dev=$6
+	local ns2_addr=$7
+	local ns2_addr6=$8
+
+	ip netns exec ${ns1} ip li add ${ns1_dev} type veth peer name tmp
+	ip netns exec ${ns1} ip li set ${ns1_dev} up
+	ip netns exec ${ns1} ip li set tmp netns ${ns2} name ${ns2_dev}
+	ip netns exec ${ns2} ip li set ${ns2_dev} up
+
+	if [ "${ns1_addr}" != "-" ]; then
+		ip netns exec ${ns1} ip addr add dev ${ns1_dev} ${ns1_addr}
+	fi
+
+	if [ "${ns2_addr}" != "-" ]; then
+		ip netns exec ${ns2} ip addr add dev ${ns2_dev} ${ns2_addr}
+	fi
+
+	if [ "${ns1_addr6}" != "-" ]; then
+		ip netns exec ${ns1} ip addr add dev ${ns1_dev} ${ns1_addr6}
+	fi
+
+	if [ "${ns2_addr6}" != "-" ]; then
+		ip netns exec ${ns2} ip addr add dev ${ns2_dev} ${ns2_addr6}
+	fi
+}
+
+################################################################################
+# traceroute6 test
+#
+# Verify that in this scenario
+#
+#        ------------------------ N2
+#         |                    |
+#       ------              ------  N3  ----
+#       | R1 |              | R2 |------|H2|
+#       ------              ------      ----
+#         |                    |
+#        ------------------------ N1
+#                  |
+#                 ----
+#                 |H1|
+#                 ----
+#
+# where H1's default route goes through R1 and R1's default route goes
+# through R2 over N2, traceroute6 from H1 to H2 reports R2's address
+# on N2 and not N1.
+#
+# Addresses are assigned as follows:
+#
+# N1: 2000:101::/64
+# N2: 2000:102::/64
+# N3: 2000:103::/64
+#
+# R1's host part of address: 1
+# R2's host part of address: 2
+# H1's host part of address: 3
+# H2's host part of address: 4
+#
+# For example:
+# the IPv6 address of R1's interface on N2 is 2000:102::1/64
+
+cleanup_traceroute6()
+{
+	local ns
+
+	for ns in host-1 host-2 router-1 router-2
+	do
+		ip netns del ${ns} 2>/dev/null
+	done
+}
+
+setup_traceroute6()
+{
+	brdev=br0
+
+	# start clean
+	cleanup_traceroute6
+
+	set -e
+	create_ns host-1
+	create_ns host-2
+	create_ns router-1
+	create_ns router-2
+
+	# Setup N3
+	connect_ns router-2 eth3 - 2000:103::2/64 host-2 eth3 - 2000:103::4/64
+	ip netns exec host-2 ip route add default via 2000:103::2
+
+	# Setup N2
+	connect_ns router-1 eth2 - 2000:102::1/64 router-2 eth2 - 2000:102::2/64
+	ip netns exec router-1 ip route add default via 2000:102::2
+
+	# Setup N1. host-1 and router-2 connect to a bridge in router-1.
+	ip netns exec router-1 ip link add name ${brdev} type bridge
+	ip netns exec router-1 ip link set ${brdev} up
+	ip netns exec router-1 ip addr add 2000:101::1/64 dev ${brdev}
+
+	connect_ns host-1 eth0 - 2000:101::3/64 router-1 eth0 - -
+	ip netns exec router-1 ip link set dev eth0 master ${brdev}
+	ip netns exec host-1 ip route add default via 2000:101::1
+
+	connect_ns router-2 eth1 - 2000:101::2/64 router-1 eth1 - -
+	ip netns exec router-1 ip link set dev eth1 master ${brdev}
+
+	# Prime the network
+	ip netns exec host-1 ping6 -c5 2000:103::4 >/dev/null 2>&1
+
+	set +e
+}
+
+run_traceroute6()
+{
+	if [ ! -x "$(command -v traceroute6)" ]; then
+		echo "SKIP: Could not run IPV6 test without traceroute6"
+		return
+	fi
+
+	setup_traceroute6
+
+	# traceroute6 host-2 from host-1 (expects 2000:102::2)
+	run_cmd host-1 "traceroute6 2000:103::4 | grep -q 2000:102::2"
+	log_test $? 0 "IPV6 traceroute"
+
+	cleanup_traceroute6
+}
+
+################################################################################
+# traceroute test
+#
+# Verify that traceroute from H1 to H2 shows 1.0.1.1 in this scenario
+#
+#                    1.0.3.1/24
+# ---- 1.0.1.3/24    1.0.1.1/24 ---- 1.0.2.1/24    1.0.2.4/24 ----
+# |H1|--------------------------|R1|--------------------------|H2|
+# ----            N1            ----            N2            ----
+#
+# where net.ipv4.icmp_errors_use_inbound_ifaddr is set on R1 and
+# 1.0.3.1/24 and 1.0.1.1/24 are respectively R1's primary and secondary
+# address on N1.
+#
+
+cleanup_traceroute()
+{
+	local ns
+
+	for ns in host-1 host-2 router
+	do
+		ip netns del ${ns} 2>/dev/null
+	done
+}
+
+setup_traceroute()
+{
+	# start clean
+	cleanup_traceroute
+
+	set -e
+	create_ns host-1
+	create_ns host-2
+	create_ns router
+
+	connect_ns host-1 eth0 1.0.1.3/24 - \
+	           router eth1 1.0.3.1/24 -
+	ip netns exec host-1 ip route add default via 1.0.1.1
+
+	ip netns exec router ip addr add 1.0.1.1/24 dev eth1
+	ip netns exec router sysctl -qw \
+				net.ipv4.icmp_errors_use_inbound_ifaddr=1
+
+	connect_ns host-2 eth0 1.0.2.4/24 - \
+	           router eth2 1.0.2.1/24 -
+	ip netns exec host-2 ip route add default via 1.0.2.1
+
+	# Prime the network
+	ip netns exec host-1 ping -c5 1.0.2.4 >/dev/null 2>&1
+
+	set +e
+}
+
+run_traceroute()
+{
+	if [ ! -x "$(command -v traceroute)" ]; then
+		echo "SKIP: Could not run IPV4 test without traceroute"
+		return
+	fi
+
+	setup_traceroute
+
+	# traceroute host-2 from host-1 (expects 1.0.1.1). Takes a while.
+	run_cmd host-1 "traceroute 1.0.2.4 | grep -q 1.0.1.1"
+	log_test $? 0 "IPV4 traceroute"
+
+	cleanup_traceroute
+}
+
+################################################################################
+# Run tests
+
+run_tests()
+{
+	run_traceroute6
+	run_traceroute
+}
+
+################################################################################
+# main
+
+declare -i nfail=0
+declare -i nsuccess=0
+
+while getopts :pv o
+do
+	case $o in
+		p) PAUSE_ON_FAIL=yes;;
+		v) VERBOSE=$(($VERBOSE + 1));;
+		*) exit 1;;
+	esac
+done
+
+run_tests
+
+printf "\nTests passed: %3d\n" ${nsuccess}
+printf "Tests failed: %3d\n"   ${nfail}
-- 
2.19.1

