Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7287CCA92
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2019 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfJEOiY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Oct 2019 10:38:24 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2129 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfJEOiX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Oct 2019 10:38:23 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45d98aac5468-c3305; Sat, 05 Oct 2019 22:37:58 +0800 (CST)
X-RM-TRANSID: 2ee45d98aac5468-c3305
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5d98aac5b3a-fda55;
        Sat, 05 Oct 2019 22:37:58 +0800 (CST)
X-RM-TRANSID: 2eea5d98aac5b3a-fda55
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v4 1/3] selftests: netfilter: add ipvs test script
Date:   Sat,  5 Oct 2019 22:37:43 +0800
Message-Id: <1570286265-15855-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570286265-15855-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1570286265-15855-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test virutal server via directing routing for IPv4.

Tested:

# selftests: netfilter: ipvs.sh
# Testing DR mode...
# ipvs.sh: PASS
ok 6 selftests: netfilter: ipvs.sh

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
v4: use #!/bin/bash -p suggested by Duncan Roe
v3: use bash style
v2: optimize test script
---
 tools/testing/selftests/netfilter/Makefile |   2 +-
 tools/testing/selftests/netfilter/ipvs.sh  | 184 +++++++++++++++++++++++++++++
 2 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/netfilter/ipvs.sh

diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index 4144984..de1032b 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -2,6 +2,6 @@
 # Makefile for netfilter selftests
 
 TEST_PROGS := nft_trans_stress.sh nft_nat.sh bridge_brouter.sh \
-	conntrack_icmp_related.sh nft_flowtable.sh
+	conntrack_icmp_related.sh nft_flowtable.sh ipvs.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/netfilter/ipvs.sh b/tools/testing/selftests/netfilter/ipvs.sh
new file mode 100755
index 0000000..f6da1bd
--- /dev/null
+++ b/tools/testing/selftests/netfilter/ipvs.sh
@@ -0,0 +1,184 @@
+#!/bin/bash -p
+# SPDX-License-Identifier: GPL-2.0
+#
+# End-to-end ipvs test suite
+# Topology:
+#--------------------------------------------------------------+
+#                      |                                       |
+#         ns0          |         ns1                           |
+#      -----------     |     -----------    -----------        |
+#      | veth01  | --------- | veth10  |    | veth12  |        |
+#      -----------    peer   -----------    -----------        |
+#           |          |                        |              |
+#      -----------     |                        |              |
+#      |  br0    |     |-----------------  peer |--------------|
+#      -----------     |                        |              |
+#           |          |                        |              |
+#      ----------     peer   ----------      -----------       |
+#      |  veth02 | --------- |  veth20 |     | veth21  |       |
+#      ----------      |     ----------      -----------       |
+#                      |         ns2                           |
+#                      |                                       |
+#--------------------------------------------------------------+
+#
+# We assume that all network driver are loaded
+#
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+ret=0
+GREEN='\033[0;92m'
+RED='\033[0;31m'
+NC='\033[0m' # No Color
+
+readonly port=8080
+
+readonly vip_v4=207.175.44.110
+readonly cip_v4=10.0.0.2
+readonly gip_v4=10.0.0.1
+readonly dip_v4=172.16.0.1
+readonly rip_v4=172.16.0.2
+readonly sip_v4=10.0.0.3
+
+readonly infile="$(mktemp)"
+readonly outfile="$(mktemp)"
+
+sysipvsnet=/proc/sys/net/ipv4/vs/
+if [ ! -d /proc/sys/net/ipv4/vs/ ]; then
+    modprobe -q ip_vs
+    if [ $? -ne 0 ]; then
+        echo "SKIP: Could not run test without ipvs module"
+    	exit $ksft_skip
+    fi
+fi
+
+ip -Version > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+ipvsadm -v > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+	echo "SKIP: Could not run test without ipvsadm"
+	exit $ksft_skip
+fi
+
+nc --version > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+	echo "SKIP: Could not run test without ncat"
+	exit $ksft_skip
+fi
+
+setup() {
+    ip netns add ns0
+    ip netns add ns1
+    ip netns add ns2
+
+    ip link add veth01 netns ns0 type veth peer name veth10 netns ns1
+    ip link add veth02 netns ns0 type veth peer name veth20 netns ns2
+    ip link add veth12 netns ns1 type veth peer name veth21 netns ns2
+
+    ip netns exec ns0 ip link set veth01 up
+    ip netns exec ns0 ip link set veth02 up
+    ip netns exec ns0 ip link add br0 type bridge
+    ip netns exec ns0 ip link set veth01 master br0
+    ip netns exec ns0 ip link set veth02 master br0
+    ip netns exec ns0 ip link set br0 up
+    ip netns exec ns0 ip addr add ${cip_v4}/24 dev br0
+
+    ip netns exec ns1 ip link set lo up
+    ip netns exec ns1 ip link set veth10 up
+    ip netns exec ns1 ip addr add ${gip_v4}/24 dev veth10
+    ip netns exec ns1 ip link set veth12 up
+    ip netns exec ns1 ip addr add ${dip_v4}/24 dev veth12
+
+    ip netns exec ns2 ip link set lo up
+    ip netns exec ns2 ip link set veth21 up
+    ip netns exec ns2 ip addr add ${rip_v4}/24 dev veth21
+    ip netns exec ns2 ip link set veth20 up
+    ip netns exec ns2 ip addr add ${sip_v4}/24 dev veth20
+}
+
+cleanup() {
+    for i in 0 1 2
+    do
+	ip netns del ns$i > /dev/null 2>&1
+    done
+    pkill nc
+}
+
+server_listen() {
+	ip netns exec ns2 nc -l -p 8080 > "${outfile}" &
+	server_pid=$!
+	sleep 0.2
+}
+
+client_connect() {
+	ip netns exec ns0 timeout 2 nc -w 1 ${vip_v4} ${port} < "${infile}"
+}
+
+verify_data() {
+	wait "${server_pid}"
+	# sha1sum returns two fields [sha1] [filepath]
+	# convert to bash array and access first elem
+	insum=($(sha1sum ${infile}))
+	outsum=($(sha1sum ${outfile}))
+	if [[ "${insum[0]}" != "${outsum[0]}" ]]; then
+		echo "data mismatch"
+		exit 1
+	fi
+}
+
+test_service() {
+    server_listen
+    client_connect
+    ret=$?
+    if [ $ret -ne 0 ]; then
+	return $ret
+    fi
+    verify_data
+}
+
+
+test_dr() {
+    ip netns exec ns0 ip route add ${vip_v4} via ${gip_v4} dev br0
+
+    ip netns exec ns1 sysctl -qw net.ipv4.ip_forward=1
+    ip netns exec ns1 ipvsadm -A -t ${vip_v4}:${port} -s rr
+    ip netns exec ns1 ipvsadm -a -t ${vip_v4}:${port} -r ${rip_v4}:${port}
+    ip netns exec ns1 ip addr add ${vip_v4}/32 dev lo:1
+
+    # avoid incorrect arp response
+    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_ignore=1
+    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_announce=2
+    # avoid reverse route lookup
+    ip netns exec ns2 sysctl -qw  net.ipv4.conf.all.rp_filter=0
+    ip netns exec ns2 sysctl -qw  net.ipv4.conf.veth21.rp_filter=0
+    ip netns exec ns2 ip addr add ${vip_v4}/32 dev lo:1
+
+    test_service
+}
+
+run_tests() {
+	local errors=
+
+	echo "Testing DR mode..."
+	setup
+	test_dr
+	errors=$(( $errors + $? ))
+
+	return $errors
+}
+
+trap cleanup EXIT
+
+cleanup
+run_tests
+
+if [ $? -ne 0 ]; then
+	echo -e "$(basename $0): ${RED}FAIL${NC}"
+	exit 1
+fi
+echo -e "$(basename $0): ${GREEN}PASS${NC}"
+exit 0
-- 
1.8.3.1



