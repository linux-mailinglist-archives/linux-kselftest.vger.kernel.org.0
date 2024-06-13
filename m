Return-Path: <linux-kselftest+bounces-11891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD9A907ACD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F233C1C22315
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EADE156668;
	Thu, 13 Jun 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L86fav6z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C46153567
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302448; cv=none; b=AsWUM4ep3G6OQGkXvI11bJ7YvTsvjJtFfLCix6cy7H4lLfbfj9obRVPo9GTlpAV2EmFRziWvJqQ3JZ+KQxxWoKyVd5dwfVd5QgKmNy/+Rgc84I204PdZpmO51786zpnRlisTI/pdzQ7ME97BrOsxtOTHaHA1+4KN9NBptxtAwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302448; c=relaxed/simple;
	bh=QTgoe2rC6m5D2R0UdgXwABQVHVGYx5A7KnuDEd1sWng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeR+Qh5ym57DdnCSkMW1gEj6/HQToLM30+AyXUhfK7JBmS9ugQ71R2qgTJ1VpWjIvagog2emGzIa6j8sMitzofki9QJfS/g0EsUtIqNDXUYxvBuFaPDN8tcpDy+WLxz5LXLnWVEfWDLa6ZJzLQnKOihhwbRkD7RGvuwlRnlSXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L86fav6z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718302444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5BYQUYXcAbpmu8A+u1LM7QSYuiSoXQDDoRECveLdB8=;
	b=L86fav6zQU5lum75/IfjjAzZ6E7O+nRADCwIAy0D8NeGVUot6RNinK6vz5tiXB7lMrHakT
	6W8ilwoYZ5DS4WSWX01JV1sa+6JHs3v4b8X9G1DGWScVJQtpFWROa1cnHsjYjr0DyFyd48
	MfFUeWbU93F7pI6eCW0DUogZ0qGO4QQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-QC59XkfyNBeCZ5rpqGVHSw-1; Thu,
 13 Jun 2024 14:13:59 -0400
X-MC-Unique: QC59XkfyNBeCZ5rpqGVHSw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15F84195609E;
	Thu, 13 Jun 2024 18:13:58 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 850411955E74;
	Thu, 13 Jun 2024 18:13:54 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 6/7] selftests: net: Use the provided dpctl rather than the vswitchd for tests.
Date: Thu, 13 Jun 2024 14:13:32 -0400
Message-ID: <20240613181333.984810-7-aconole@redhat.com>
In-Reply-To: <20240613181333.984810-1-aconole@redhat.com>
References: <20240613181333.984810-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The current pmtu test infrastucture requires an installed copy of the
ovs-vswitchd userspace.  This means that any automated or constrained
environments may not have the requisite tools to run the tests.  However,
the pmtu tests don't require any special classifier processing.  Indeed
they are only using the vswitchd in the most basic mode - as a NORMAL
switch.

However, the ovs-dpctl kernel utility can now program all the needed basic
flows to allow traffic to traverse the tunnels and provide support for at
least testing some basic pmtu scenarios.  More complicated flow pipelines
can be added to the internal ovs test infrastructure, but that is work for
the future.  For now, enable the most common cases - wide mega flows with
no other prerequisites.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 87 ++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index cfc84958025a..7f4f35d88dcc 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -846,22 +846,73 @@ setup_ovs_vxlan_or_geneve() {
 	type="${1}"
 	a_addr="${2}"
 	b_addr="${3}"
+	dport="6081"
 
 	if [ "${type}" = "vxlan" ]; then
+		dport="4789"
 		opts="${opts} ttl 64 dstport 4789"
 		opts_b="local ${b_addr}"
 	fi
 
-	run_cmd ovs-vsctl add-port ovs_br0 ${type}_a -- \
-		set interface ${type}_a type=${type} \
-		options:remote_ip=${b_addr} options:key=1 options:csum=true || return 1
-
+	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 ${type}_a -t ${type}
 	run_cmd ${ns_b} ip link add ${type}_b type ${type} id 1 ${opts_b} remote ${a_addr} ${opts} || return 1
 
 	run_cmd ${ns_b} ip addr add ${tunnel4_b_addr}/${tunnel4_mask} dev ${type}_b
 	run_cmd ${ns_b} ip addr add ${tunnel6_b_addr}/${tunnel6_mask} dev ${type}_b
 
+	run_cmd ip link set ${type}_a up
 	run_cmd ${ns_b} ip link set ${type}_b up
+
+	ports=$(python3 ./openvswitch/ovs-dpctl.py show)
+	br0_port=$(echo "$ports" | grep -E "\sovs_br0" | sed -e 's@port @@' | cut -d: -f1 | xargs)
+	type_a_port=$(echo "$ports" | grep ${type}_a | sed -e 's@port @@' | cut -d: -f1 | xargs)
+	veth_a_port=$(echo "$ports" | grep veth_A | sed -e 's@port @@' | cut -d: -f1 | xargs)
+
+	v4_a_tun="${prefix4}.${a_r1}.1"
+	v4_b_tun="${prefix4}.${b_r1}.1"
+
+	v6_a_tun="${prefix6}:${a_r1}::1"
+	v6_b_tun="${prefix6}:${b_r1}::1"
+
+	if [ "${v4_a_tun}" == "${a_addr}" ]; then
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0800),ipv4()" \
+		    "set(tunnel(tun_id=1,dst=${v4_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x86dd),ipv6()" \
+		    "set(tunnel(tun_id=1,dst=${v4_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),tunnel(tun_id=1,src=${v4_b_tun},dst=${v4_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0800),ipv4()" \
+		    "${veth_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),tunnel(tun_id=1,src=${v4_b_tun},dst=${v4_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x86dd),ipv6()" \
+		    "${veth_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),tunnel(tun_id=1,src=${v4_b_tun},dst=${v4_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0806),arp()" \
+		    "${veth_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0806),arp(sip=${veth4_c_addr},tip=${tunnel4_b_addr})" \
+		    "set(tunnel(tun_id=1,dst=${v4_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
+	else
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0800),ipv4()" \
+		    "set(tunnel(tun_id=1,ipv6_dst=${v6_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x86dd),ipv6()" \
+		    "set(tunnel(tun_id=1,ipv6_dst=${v6_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),tunnel(tun_id=1,ipv6_src=${v6_b_tun},ipv6_dst=${v6_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0800),ipv4()" \
+		    "${veth_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),tunnel(tun_id=1,ipv6_src=${v6_b_tun},ipv6_dst=${v6_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x86dd),ipv6()" \
+		    "${veth_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),tunnel(tun_id=1,ipv6_src=${v6_b_tun},ipv6_dst=${v6_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0806),arp()" \
+		    "${veth_a_port}"
+		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
+		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0806),arp(sip=${veth4_c_addr},tip=${tunnel4_b_addr})" \
+		    "set(tunnel(tun_id=1,ipv6_dst=${v6_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
+	fi
 }
 
 setup_ovs_geneve4() {
@@ -881,7 +932,7 @@ setup_ovs_vxlan6() {
 }
 
 setup_ovs_bridge() {
-	run_cmd ovs-vsctl add-br ovs_br0 || return $ksft_skip
+	run_cmd python3 ./openvswitch/ovs-dpctl.py add-dp ovs_br0 || return $ksft_skip
 	run_cmd ip link set ovs_br0 up
 
 	run_cmd ${ns_c} ip link add veth_C-A type veth peer name veth_A-C
@@ -891,7 +942,7 @@ setup_ovs_bridge() {
 	run_cmd ${ns_c} ip link set veth_C-A up
 	run_cmd ${ns_c} ip addr add ${veth4_c_addr}/${veth4_mask} dev veth_C-A
 	run_cmd ${ns_c} ip addr add ${veth6_c_addr}/${veth6_mask} dev veth_C-A
-	run_cmd ovs-vsctl add-port ovs_br0 veth_A-C
+	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 veth_A-C
 
 	# Move veth_A-R1 to init
 	run_cmd ${ns_a} ip link set veth_A-R1 netns 1
@@ -942,8 +993,10 @@ cleanup() {
 
 	ip link del veth_A-C			2>/dev/null
 	ip link del veth_A-R1			2>/dev/null
-	ovs-vsctl --if-exists del-port vxlan_a	2>/dev/null
-	ovs-vsctl --if-exists del-br ovs_br0	2>/dev/null
+	# squelch the output of the del-if commands since it can be wordy
+	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true vxlan_a	>/dev/null	2>&1
+	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true geneve_a	>/dev/null	2>&1
+	python3 ./openvswitch/ovs-dpctl.py del-dp ovs_br0 >/dev/null	2>&1
 	rm -f "$tmpoutfile"
 }
 
@@ -1407,16 +1460,10 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
 		exp_mtu=$((${ll_mtu} - 40          - 8          - 8                   - 14))
 	fi
 
-	if [ "${type}" = "vxlan" ]; then
-		tun_a="vxlan_sys_4789"
-	elif [ "${type}" = "geneve" ]; then
-		tun_a="genev_sys_6081"
-	fi
-
-	trace ""        "${tun_a}"  "${ns_b}"  ${type}_b \
-	      ""        veth_A-R1   "${ns_r1}" veth_R1-A \
-	      "${ns_b}" veth_B-R1   "${ns_r1}" veth_R1-B \
-	      ""        ovs_br0     ""         veth-A-C  \
+	trace ""        "${type}_a"  "${ns_b}"  ${type}_b \
+	      ""        veth_A-R1    "${ns_r1}" veth_R1-A \
+	      "${ns_b}" veth_B-R1    "${ns_r1}" veth_R1-B \
+	      ""        ovs_br0      ""         veth-A_C  \
 	      "${ns_c}" veth_C-A
 
 	if [ ${family} -eq 4 ]; then
@@ -1436,8 +1483,8 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
 	mtu "${ns_b}"  veth_B-R1 ${ll_mtu}
 	mtu "${ns_r1}" veth_R1-B ${ll_mtu}
 
-	mtu ""        ${tun_a}  $((${ll_mtu} + 1000))
-	mtu "${ns_b}" ${type}_b $((${ll_mtu} + 1000))
+	mtu ""        ${type}_a  $((${ll_mtu} + 1000))
+	mtu "${ns_b}" ${type}_b  $((${ll_mtu} + 1000))
 
 	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -c 20 -s $((${ll_mtu} + 500)) ${dst} || return 1
 
-- 
2.45.1


