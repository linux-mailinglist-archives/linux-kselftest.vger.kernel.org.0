Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE258BFF0D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfI0GWR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 02:22:17 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2747 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfI0GWR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 02:22:17 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75d8daa7e602-3c291; Fri, 27 Sep 2019 14:21:51 +0800 (CST)
X-RM-TRANSID: 2ee75d8daa7e602-3c291
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15d8daa7ddd2-9c951;
        Fri, 27 Sep 2019 14:21:51 +0800 (CST)
X-RM-TRANSID: 2ee15d8daa7ddd2-9c951
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v2 3/3] selftests: netfilter: add ipvs tunnel test case
Date:   Fri, 27 Sep 2019 14:21:06 +0800
Message-Id: <1569565266-31566-4-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569565266-31566-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1569565266-31566-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test virtual server via ipip tunnel.

Tested:
# selftests: netfilter: ipvs.sh
# Testing DR mode...
# Testing NAT mode...
# Testing Tunnel mode...
# ipvs.sh: PASS
ok 6 selftests: netfilter: ipvs.sh

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
v2: optimize test script
---
 tools/testing/selftests/netfilter/ipvs.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/netfilter/ipvs.sh b/tools/testing/selftests/netfilter/ipvs.sh
index e95453b..b09994e 100755
--- a/tools/testing/selftests/netfilter/ipvs.sh
+++ b/tools/testing/selftests/netfilter/ipvs.sh
@@ -174,6 +174,30 @@ test_nat() {
     test_service
 }
 
+test_tun() {
+    ip netns exec ns0 ip route add ${vip_v4} via ${gip_v4} dev br0
+
+    ip netns exec ns1 modprobe ipip
+    ip netns exec ns1 ip link set tunl0 up
+    ip netns exec ns1 sysctl -qw net.ipv4.ip_forward=0
+    ip netns exec ns1 sysctl -qw net.ipv4.conf.all.send_redirects=0
+    ip netns exec ns1 sysctl -qw net.ipv4.conf.default.send_redirects=0
+    ip netns exec ns1 ipvsadm -A -t ${vip_v4}:${port} -s rr
+    ip netns exec ns1 ipvsadm -a -i -t ${vip_v4}:${port} -r ${rip_v4}:${port}
+    ip netns exec ns1 ip addr add ${vip_v4}/32 dev lo:1
+
+    ip netns exec ns2 modprobe ipip
+    ip netns exec ns2 ip link set tunl0 up
+    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_ignore=1
+    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_announce=2
+    ip netns exec ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0
+    ip netns exec ns2 sysctl -qw net.ipv4.conf.tunl0.rp_filter=0
+    ip netns exec ns2 sysctl -qw net.ipv4.conf.veth21.rp_filter=0
+    ip netns exec ns2 ip addr add ${vip_v4}/32 dev lo:1
+
+    test_service
+}
+
 run_tests() {
 	local errors=
 
@@ -189,6 +213,12 @@ run_tests() {
 	test_nat
 	errors=$(( $errors + $? ))
 
+	echo "Testing Tunnel mode..."
+	cleanup
+	setup
+	test_tun
+	errors=$(( $errors + $? ))
+
 	return $errors
 }
 
-- 
1.8.3.1



