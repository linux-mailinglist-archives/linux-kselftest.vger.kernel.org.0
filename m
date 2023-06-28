Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8985741656
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjF1Q2S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 12:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231787AbjF1Q2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 12:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687969650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWVq+eL4aDWA5meL5f9Eal8ANp/OHe6J2oj4uPsoS3g=;
        b=AMR/VaYth3Za032ei4/4g7T5cQ5Ivs8oAd0cfohdYH43I8URB6jgjuafDWRDRgpBqa4Om2
        +X1MX0YICmGNgEhvSkfgh6sNTFiTop1slIdqZWGEEFpT3ibkfGGytaoIn2V6iRxinnIbm+
        w+lvSuB2dwWQGW2KP20ixs+6qloTnPo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-Tolsu0WwPn-e71IcD6NDRg-1; Wed, 28 Jun 2023 12:27:27 -0400
X-MC-Unique: Tolsu0WwPn-e71IcD6NDRg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 095E93C13F40;
        Wed, 28 Jun 2023 16:27:17 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.32.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84ED340BB4D;
        Wed, 28 Jun 2023 16:27:16 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dev@openvswitch.org, Pravin Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Ilya Maximets <i.maximets@ovn.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/4] selftests: openvswitch: add a test for ipv4 forwarding
Date:   Wed, 28 Jun 2023 12:27:12 -0400
Message-Id: <20230628162714.392047-3-aconole@redhat.com>
In-Reply-To: <20230628162714.392047-1-aconole@redhat.com>
References: <20230628162714.392047-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a simple ipv4 bidirectional connectivity test.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 5cdacb3c8c925..5d60a9466dab3 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -12,6 +12,7 @@ TRACING=0
 
 tests="
 	arp_ping				eth-arp: Basic arp ping between two NS
+	connect_v4				ip4-xon: Basic ipv4 ping between two NS
 	netlink_checks				ovsnl: validate netlink attrs and settings
 	upcall_interfaces			ovs: test the upcall interfaces"
 
@@ -192,6 +193,45 @@ test_arp_ping () {
 	return 0
 }
 
+# connect_v4 test
+#  - client has 1500 byte MTU
+#  - server has 1500 byte MTU
+#  - use ICMP to ping in each direction
+test_connect_v4 () {
+
+	sbx_add "test_connect_v4" || return $?
+
+	ovs_add_dp "test_connect_v4" cv4 || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_connect_v4" "cv4" "$ns" \
+		    "${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+
+	ip netns exec client ip addr add 172.31.110.10/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 172.31.110.20/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	# Add forwarding for ARP and ip packets - completely wildcarded
+	ovs_add_flow "test_connect_v4" cv4 \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_connect_v4" cv4 \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "test_connect_v4" cv4 \
+		'in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10)' '2' || return 1
+	ovs_add_flow "test_connect_v4" cv4 \
+		'in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20)' '1' || return 1
+
+	# do a ping
+	ovs_sbx "test_connect_v4" ip netns exec client ping 172.31.110.20 -c 3 || return 1
+
+	info "done..."
+	return 0
+}
+
 # netlink_validation
 # - Create a dp
 # - check no warning with "old version" simulation
-- 
2.40.1

