Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9754BC3718
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2019 16:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbfJAOWg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Oct 2019 10:22:36 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:25105 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389055AbfJAOWg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Oct 2019 10:22:36 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5d936119580-943cf; Tue, 01 Oct 2019 22:22:17 +0800 (CST)
X-RM-TRANSID: 2eeb5d936119580-943cf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35d936118070-0678c;
        Tue, 01 Oct 2019 22:22:16 +0800 (CST)
X-RM-TRANSID: 2ee35d936118070-0678c
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v3 3/3] selftests: netfilter: add ipvs tunnel test case
Date:   Tue,  1 Oct 2019 22:19:59 +0800
Message-Id: <1569939599-1872-4-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569939599-1872-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1569939599-1872-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
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
index 270b5da..a8f6e70 100755
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



