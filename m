Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D317874165B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 18:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjF1Q26 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 12:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbjF1Q2l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 12:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687969671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZ/EweoM4BMbaaviPEa6XCOkDxjigJ8DuRylA3guHPE=;
        b=CGfoHBBs4RdPgJcP1uskhHcnWSTHv3UwG3dSLbRQ8/znj0JkU1WjdAn6tY4/zAkyzVE3Y+
        oFgcFZbNtPr1F4WO01NyzzIqpSJ86H1SFLjSlBRz4iSZ00L0EDk5PXneYdTDPSe6sX45TE
        xIn5IVavAdrCk/+g9t2M5lgN8vbBwNI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-2YzUppjxMIeE9ciaiXwzFw-1; Wed, 28 Jun 2023 12:27:48 -0400
X-MC-Unique: 2YzUppjxMIeE9ciaiXwzFw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 889BB185A7AA;
        Wed, 28 Jun 2023 16:27:17 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.32.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B98D40D1A4;
        Wed, 28 Jun 2023 16:27:17 +0000 (UTC)
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
Subject: [PATCH net-next 3/4] selftests: openvswitch: add basic ct test case parsing
Date:   Wed, 28 Jun 2023 12:27:13 -0400
Message-Id: <20230628162714.392047-4-aconole@redhat.com>
In-Reply-To: <20230628162714.392047-1-aconole@redhat.com>
References: <20230628162714.392047-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Forwarding via ct() action is an important use case for openvswitch, but
generally would require using a full ovs-vswitchd to get working. Add a
ct action parser for basic ct test case.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
NOTE: 3 lines flag the line-length checkpatch warning, but there didnt
      seem to be a really good way of breaking the lines smaller.

 .../selftests/net/openvswitch/openvswitch.sh  | 68 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 39 +++++++++++
 2 files changed, 107 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 5d60a9466dab3..40a66c72af0f0 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -12,6 +12,7 @@ TRACING=0
 
 tests="
 	arp_ping				eth-arp: Basic arp ping between two NS
+	ct_connect_v4				ip4-ct-xon: Basic ipv4 tcp connection using ct
 	connect_v4				ip4-xon: Basic ipv4 ping between two NS
 	netlink_checks				ovsnl: validate netlink attrs and settings
 	upcall_interfaces			ovs: test the upcall interfaces"
@@ -193,6 +194,73 @@ test_arp_ping () {
 	return 0
 }
 
+# ct_connect_v4 test
+#  - client has 1500 byte MTU
+#  - server has 1500 byte MTU
+#  - use ICMP to ping in each direction
+#  - only allow CT state stuff to pass through new in c -> s
+test_ct_connect_v4 () {
+
+	which nc >/dev/null 2>/dev/null || return $ksft_skip
+
+	sbx_add "test_ct_connect_v4" || return $?
+
+	ovs_add_dp "test_ct_connect_v4" ct4 || return 1
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_ct_connect_v4" "ct4" "$ns" \
+		    "${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 172.31.110.10/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 172.31.110.20/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	# Add forwarding for ARP and ip packets - completely wildcarded
+	ovs_add_flow "test_ct_connect_v4" ct4 \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_ct_connect_v4" ct4 \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "test_ct_connect_v4" ct4 \
+		     'ct_state(-trk),eth(),eth_type(0x0800),ipv4()' \
+		     'ct(commit),recirc(0x1)' || return 1
+	ovs_add_flow "test_ct_connect_v4" ct4 \
+		     'recirc_id(0x1),ct_state(+trk+new),in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10)' \
+		     '2' || return 1
+	ovs_add_flow "test_ct_connect_v4" ct4 \
+		     'recirc_id(0x1),ct_state(+trk+est),in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10)' \
+		     '2' || return 1
+	ovs_add_flow "test_ct_connect_v4" ct4 \
+		     'recirc_id(0x1),ct_state(+trk+est),in_port(2),eth(),eth_type(0x0800),ipv4(dst=172.31.110.10)' \
+		     '1' || return 1
+	ovs_add_flow "test_ct_connect_v4" ct4 \
+		     'recirc_id(0x1),ct_state(+trk+inv),eth(),eth_type(0x0800),ipv4()' 'drop' || \
+		     return 1
+
+	# do a ping
+	ovs_sbx "test_ct_connect_v4" ip netns exec client ping 172.31.110.20 -c 3 || return 1
+
+	# create an echo server in 'server'
+	echo "server" | \
+		ovs_netns_spawn_daemon "test_ct_connect_v4" "server" \
+				nc -lvnp 4443
+	ovs_sbx "test_ct_connect_v4" ip netns exec client nc -i 1 -zv 172.31.110.20 4443 || return 1
+
+	# Now test in the other direction (should fail)
+	echo "client" | \
+		ovs_netns_spawn_daemon "test_ct_connect_v4" "client" \
+				nc -lvnp 4443
+	ovs_sbx "test_ct_connect_v4" ip netns exec client nc -i 1 -zv 172.31.110.10 4443
+	if [ $? == 0 ]; then
+	   info "ct connect to client was successful"
+	   return 1
+	fi
+
+	info "done..."
+	return 0
+}
+
 # connect_v4 test
 #  - client has 1500 byte MTU
 #  - server has 1500 byte MTU
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 799bfb3064b90..704cb4adf79a9 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -62,6 +62,15 @@ def macstr(mac):
     return outstr
 
 
+def strcspn(str1, str2):
+    tot = 0
+    for char in str1:
+        if str2.find(char) != -1:
+            return tot
+        tot += 1
+    return tot
+
+
 def strspn(str1, str2):
     tot = 0
     for char in str1:
@@ -477,6 +486,36 @@ class ovsactions(nla):
                     actstr = actstr[strspn(actstr, ", ") :]
                     parsed = True
 
+            if parse_starts_block(actstr, "ct(", False):
+                actstr = actstr[len("ct(") :]
+                ctact = ovsactions.ctact()
+
+                for scan in (
+                    ("commit", "OVS_CT_ATTR_COMMIT", None),
+                    ("force_commit", "OVS_CT_ATTR_FORCE_COMMIT", None),
+                    ("zone", "OVS_CT_ATTR_ZONE", int),
+                    ("mark", "OVS_CT_ATTR_MARK", int),
+                    ("helper", "OVS_CT_ATTR_HELPER", lambda x, y: str(x)),
+                    ("timeout", "OVS_CT_ATTR_TIMEOUT", lambda x, y: str(x)),
+                ):
+                    if actstr.startswith(scan[0]):
+                        actstr = actstr[len(scan[0]) :]
+                        if scan[2] is not None:
+                            if actstr[0] != "=":
+                                raise ValueError("Invalid ct attr")
+                            actstr = actstr[1:]
+                            pos = strcspn(actstr, ",)")
+                            datum = scan[2](actstr[:pos], 0)
+                            ctact["attrs"].append([scan[1], datum])
+                            actstr = actstr[len(datum) :]
+                        else:
+                            ctact["attrs"].append([scan[1], None])
+                        actstr = actstr[strspn(actstr, ", ") :]
+
+                self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
+                actstr = actstr[strspn(actstr, "), ") :]
+                parsed = True
+
             if not parsed:
                 raise ValueError("Action str: '%s' not supported" % actstr)
 
-- 
2.40.1

