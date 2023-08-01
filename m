Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE176BF33
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 23:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjHAVYF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 17:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjHAVYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA481708
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690924956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2MipbMCgk4cXwNV1pd16nwdM4D9K+vNpQadjGJHJa8=;
        b=C3HRrh/FpIPncI3qtzaC06+ZJz+MyZBv++F0m6CSxV0e9U8YedMCNC/JTTngKp/DaQDSkX
        TPiSsXKAzBM3dL0xXKIXBr5pgh25ilFRlC5rZwyCFG+zfdLCMBU+gbp8qb0ZDl8kwoRxzC
        t3B+L2fkeKq9qyA/YuQfz7BcIszlBVw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-p85ujpLeNbqSiTAejVXtdQ-1; Tue, 01 Aug 2023 17:22:33 -0400
X-MC-Unique: p85ujpLeNbqSiTAejVXtdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51C2E380673A;
        Tue,  1 Aug 2023 21:22:32 +0000 (UTC)
Received: from RHTPC1VM0NT.redhat.com (unknown [10.22.8.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49AF4F7855;
        Tue,  1 Aug 2023 21:22:31 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Pravin B Shelar <pshelar@ovn.org>,
        Adrian Moreno <amorenoz@redhat.com>,
        Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v3 net-next 3/5] selftests: openvswitch: add a test for ipv4 forwarding
Date:   Tue,  1 Aug 2023 17:22:24 -0400
Message-Id: <20230801212226.909249-4-aconole@redhat.com>
In-Reply-To: <20230801212226.909249-1-aconole@redhat.com>
References: <20230801212226.909249-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a simple ipv4 bidirectional connectivity test.

Signed-off-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Adrian Moreno <amorenoz@redhat.com>
---
NOTE: 4 lines flag the line-length checkpatch warning, but there didn't
      seem to be a good way of breaking the lines smaller.

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

