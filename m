Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2046D0D79
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 13:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfJILRP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 07:17:15 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2362 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJILRM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 07:17:12 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5d9dc1a184f-0879a; Wed, 09 Oct 2019 19:16:50 +0800 (CST)
X-RM-TRANSID: 2eea5d9dc1a184f-0879a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95d9dc1a06c5-f78e7;
        Wed, 09 Oct 2019 19:16:49 +0800 (CST)
X-RM-TRANSID: 2ee95d9dc1a06c5-f78e7
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v5 2/3] selftests: netfilter: add ipvs nat test case
Date:   Wed,  9 Oct 2019 19:16:29 +0800
Message-Id: <1570619790-6086-3-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570619790-6086-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1570619790-6086-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
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
index f844c0a..60250f7 100755
--- a/tools/testing/selftests/netfilter/ipvs.sh
+++ b/tools/testing/selftests/netfilter/ipvs.sh
@@ -154,20 +154,40 @@ test_dr() {
 	test_service
 }
 
+test_nat() {
+	ip netns exec ns0 ip route add ${vip_v4} via ${gip_v4} dev br0
+
+	ip netns exec ns1 sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec ns1 ipvsadm -A -t ${vip_v4}:${port} -s rr
+	ip netns exec ns1 ipvsadm -a -m -t ${vip_v4}:${port} -r ${rip_v4}:${port}
+	ip netns exec ns1 ip addr add ${vip_v4}/32 dev lo:1
+
+	ip netns exec ns2 ip link del veth20
+	ip netns exec ns2 ip route add default via ${dip_v4} dev veth21
+
+	test_service
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



