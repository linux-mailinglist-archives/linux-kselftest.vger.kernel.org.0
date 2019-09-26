Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9ABF73D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfIZQ7B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 12:59:01 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2540 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfIZQ7B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 12:59:01 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95d8cec2520e-2ef84; Fri, 27 Sep 2019 00:49:43 +0800 (CST)
X-RM-TRANSID: 2ee95d8cec2520e-2ef84
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45d8cec1a45d-8276d;
        Fri, 27 Sep 2019 00:49:31 +0800 (CST)
X-RM-TRANSID: 2ee45d8cec1a45d-8276d
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH 2/3] selftests: netfilter: add ipvs nat test case
Date:   Fri, 27 Sep 2019 00:48:51 +0800
Message-Id: <1569516532-708-3-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569516532-708-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1569516532-708-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test virtual server via NAT.

Tested:
# selftests: netfilter: ipvs.sh
# Testing DR mode...
# Testing NAT mode...
# ipvs.sh: PASS

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 tools/testing/selftests/netfilter/ipvs.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/netfilter/ipvs.sh b/tools/testing/selftests/netfilter/ipvs.sh
index 15c386b..40058f9 100755
--- a/tools/testing/selftests/netfilter/ipvs.sh
+++ b/tools/testing/selftests/netfilter/ipvs.sh
@@ -153,20 +153,40 @@ test_dr() {
     test_service
 }
 
+test_nat() {
+    ip netns exec ns0 ip route add ${vip_v4} via ${gip_v4} dev br0
+
+    ip netns exec ns1 sysctl -qw net.ipv4.ip_forward=1
+    ip netns exec ns1 ipvsadm -A -t ${vip_v4}:${port} -s rr
+    ip netns exec ns1 ipvsadm -a -m -t ${vip_v4}:${port} -r ${rip_v4}:${port}
+    ip netns exec ns1 ip addr add ${vip_v4}/32 dev lo:1
+
+    ip netns exec ns2 ip link del veth20
+    ip netns exec ns2 ip route add default via ${dip_v4} dev veth21
+
+    test_service
+}
+
 run_tests() {
 	local errors=
 
 	echo "Testing DR mode..."
+	cleanup
 	setup
 	test_dr
 	errors=$(( $errors + $? ))
 
+	echo "Testing NAT mode..."
+	cleanup
+	setup
+	test_nat
+	errors=$(( $errors + $? ))
+
 	return $errors
 }
 
 trap cleanup EXIT
 
-cleanup
 run_tests
 
 if [ $? -ne 0 ]; then
-- 
1.8.3.1



