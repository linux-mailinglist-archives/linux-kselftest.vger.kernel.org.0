Return-Path: <linux-kselftest+bounces-3816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731D8434BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 05:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738E51C24730
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 04:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA8168A3;
	Wed, 31 Jan 2024 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="Tca/RNfa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98D179BA
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706674163; cv=none; b=EOJVzUuDpQ1zX9VQa0i8N+Yqy6F5P/SJzfrKhXYCM7cecGIot2XQGH2HIjRFDwkckp4MF3r680PCUHbiylX/boHFONd7qejUrfrMkIzL31TtXSzpS7DZDW+WtXuYtK0LsAhhaIlNOPUR0ErVnpIs1MtxY+Y5EqU1SX18PzAQdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706674163; c=relaxed/simple;
	bh=pnxDDAKEBMo7lWFcc3J2ntyngcKsl4r03QwlqkuSvNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GbGoTdpdYhTR+ZNpi48YzIP91mb/KgWHwvVbL+jnjj0yGDuGxO8q4FO2S/u6HI/QSdXRvbeEW9b5EtB2DcDRukMoweVqzSfGk2im+WOM7t7UMCBPnT2U7k934TYC/R2DUeBxbLcIA2vDqn2DS1F5XDjvsakJF5dg88PClIdvh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz; spf=pass smtp.mailfrom=fe-bounces.faucet.nz; dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b=Tca/RNfa; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-4ed8c67516; t=1706674143;
 bh=WelYVPflxMfIUF+8iQKKCRWtrOjz1iaIT0Kh8otsC8U=;
 b=Tca/RNfafOnsPZrJDhemomfilOp7ml97MkuVeqcs7Ol3RboyaaW6ppfYCN+XTz62wbG/8hLoM
 CwiSDuNbMsxvNKPkHO1RyJ4t4F/IC7JMHVxsEWmnSAhmKdZbG9UoLULV0FZpjqef4VRp/csUtXl
 hSU/whXiviNJZ84Gn7q82JQ=
From: Brad Cowie <brad@faucet.nz>
To: netdev@vger.kernel.org
Cc: pshelar@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Brad Cowie
 <brad@faucet.nz>, Aaron Conole <aconole@redhat.com>
Subject: [PATCH net-next] selftests: openvswitch: Test ICMP related matches work with SNAT
Date: Wed, 31 Jan 2024 17:08:22 +1300
Message-Id: <20240131040822.835867-1-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; brad@faucet.nz, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b9c7de887f9e7cfa92c933

Add a test case for regression in openvswitch nat that was fixed by
commit e6345d2824a3 ("netfilter: nf_nat: fix action not being set for
all ct states").

Link: https://lore.kernel.org/netdev/20231221224311.130319-1-brad@faucet.nz/
Link: https://mail.openvswitch.org/pipermail/ovs-dev/2024-January/410476.html
Suggested-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Brad Cowie <brad@faucet.nz>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index f8499d4c87f3..87b80bee6df4 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -17,6 +17,7 @@ tests="
 	ct_connect_v4				ip4-ct-xon: Basic ipv4 tcp connection using ct
 	connect_v4				ip4-xon: Basic ipv4 ping between two NS
 	nat_connect_v4				ip4-nat-xon: Basic ipv4 tcp connection via NAT
+	nat_related_v4				ip4-nat-related: ICMP related matches work with SNAT
 	netlink_checks				ovsnl: validate netlink attrs and settings
 	upcall_interfaces			ovs: test the upcall interfaces
 	drop_reason				drop: test drop reasons are emitted"
@@ -473,6 +474,67 @@ test_nat_connect_v4 () {
 	return 0
 }
 
+# nat_related_v4 test
+#  - client->server ip packets go via SNAT
+#  - client solicits ICMP destination unreachable packet from server
+#  - undo NAT for ICMP reply and test dst ip has been updated
+test_nat_related_v4 () {
+	which nc >/dev/null 2>/dev/null || return $ksft_skip
+
+	sbx_add "test_nat_related_v4" || return $?
+
+	ovs_add_dp "test_nat_related_v4" natrelated4 || return 1
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_nat_related_v4" "natrelated4" "$ns" \
+			"${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 172.31.110.10/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 172.31.110.20/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	ip netns exec server ip route add 192.168.0.20/32 via 172.31.110.10
+
+	# Allow ARP
+	ovs_add_flow "test_nat_related_v4" natrelated4 \
+		"in_port(1),eth(),eth_type(0x0806),arp()" "2" || return 1
+	ovs_add_flow "test_nat_related_v4" natrelated4 \
+		"in_port(2),eth(),eth_type(0x0806),arp()" "1" || return 1
+
+	# Allow IP traffic from client->server, rewrite source IP with SNAT to 192.168.0.20
+	ovs_add_flow "test_nat_related_v4" natrelated4 \
+		"ct_state(-trk),in_port(1),eth(),eth_type(0x0800),ipv4(dst=172.31.110.20)" \
+		"ct(commit,nat(src=192.168.0.20)),recirc(0x1)" || return 1
+	ovs_add_flow "test_nat_related_v4" natrelated4 \
+		"recirc_id(0x1),ct_state(+trk-inv),in_port(1),eth(),eth_type(0x0800),ipv4()" \
+		"2" || return 1
+
+	# Allow related ICMP responses back from server and undo NAT to restore original IP
+	# Drop any ICMP related packets where dst ip hasn't been restored back to original IP
+	ovs_add_flow "test_nat_related_v4" natrelated4 \
+		"ct_state(-trk),in_port(2),eth(),eth_type(0x0800),ipv4()" \
+		"ct(commit,nat),recirc(0x2)" || return 1
+	ovs_add_flow "test_nat_related_v4" natrelated4 \
+		"recirc_id(0x2),ct_state(+rel+trk),in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,dst=172.31.110.10,proto=1),icmp()" \
+		"1" || return 1
+	ovs_add_flow "test_nat_related_v4" natrelated4 \
+		"recirc_id(0x2),ct_state(+rel+trk),in_port(2),eth(),eth_type(0x0800),ipv4(dst=192.168.0.20,proto=1),icmp()" \
+		"drop" || return 1
+
+	# Solicit destination unreachable response from server
+	ovs_sbx "test_nat_related_v4" ip netns exec client \
+		bash -c "echo a | nc -u -w 1 172.31.110.20 10000"
+
+	# Check to make sure no packets matched the drop rule with incorrect dst ip
+	python3 "$ovs_base/ovs-dpctl.py" dump-flows natrelated4 \
+		| grep "drop" | grep "packets:0" >/dev/null || return 1
+
+	info "done..."
+	return 0
+}
+
 # netlink_validation
 # - Create a dp
 # - check no warning with "old version" simulation
-- 
2.34.1


