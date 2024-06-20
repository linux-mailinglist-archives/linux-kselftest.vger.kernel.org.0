Return-Path: <linux-kselftest+bounces-12322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C558C910521
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 15:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AF01C23490
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9881B4C30;
	Thu, 20 Jun 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7BtzZP6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FA1B47C9
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888193; cv=none; b=mKblS3XdPOQ83OYpVguBu3fKfmrm0MRr9fHKAPfSim6C/Uyyg3if0CVRUmWooUz3xQXJCepsPjaqGUK/4X9TscUfouD24MF/SOghPfHoUo7wYLnZ5k7QvZfq03aYwXT/wa7xyG2p9gg+wXDtR2w4Ku6exqpzyuXhWrCAqKKGtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888193; c=relaxed/simple;
	bh=ifbXi0vWclSOcaXXTXzonUcMqrXw9l1luGZEeyrYYtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1bd6EocUAvhvXe2YU8+xtjm3t9nMWEaGq4XHVOEIvY2GjH9SiFf/SOpyrBmL15dftur1yXFOT9WgLbUNkAHiDFFpM4BOCWAiTugHxLtcKeQwJaBNtlc6oPEkPw6tg0QjSvMV5Trz0yYWQUy/OmfohyxArsOUxJw+9zAlgKT5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7BtzZP6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718888190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3mljIvHUBdg/jnYlVUNYoLL5kGgn67rnJeRuV2tRR4=;
	b=b7BtzZP6yEmGMqBRt2AhqtXT1EP8YijzNcOd7rfCn0uO2WcdAuzXngnlhMCDcXsmekfbSh
	Yg/AHzifuBov8OXZ4wcMYTCwNYDB5/PyTSbeWFByUdzXXND9UynNc9WEMjvAdVz/XbMYh7
	GJblkgYoSOZ2ro/BnKRqw7OtSKUYyeE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-cJlVb_5IPa6vClXvd9-xRg-1; Thu,
 20 Jun 2024 08:56:28 -0400
X-MC-Unique: cJlVb_5IPa6vClXvd9-xRg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3782419560B7;
	Thu, 20 Jun 2024 12:56:26 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.9.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DB4B1956087;
	Thu, 20 Jun 2024 12:56:22 +0000 (UTC)
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
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 6/7] selftests: net: Use the provided dpctl rather than the vswitchd for tests.
Date: Thu, 20 Jun 2024 08:56:00 -0400
Message-ID: <20240620125601.15755-7-aconole@redhat.com>
In-Reply-To: <20240620125601.15755-1-aconole@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

Enhance the pmtu testing to try testing using the internal utility, first.
As a fallback, if the internal utility isn't running, then try with the
ovs-vswitchd userspace tools.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
v2: Fix a nit in the whitespace

 tools/testing/selftests/net/pmtu.sh | 145 +++++++++++++++++++++++-----
 1 file changed, 123 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index cfc84958025a..5175c0c83a23 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -842,25 +842,97 @@ setup_bridge() {
 	run_cmd ${ns_a} ip link set veth_A-C master br0
 }
 
+setup_ovs_via_internal_utility() {
+	type="${1}"
+	a_addr="${2}"
+	b_addr="${3}"
+	dport="${4}"
+
+	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 ${type}_a -t ${type} || return 1
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
+	if [ "${v4_a_tun}" = "${a_addr}" ]; then
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
+}
+
+setup_ovs_via_vswitchd() {
+	type="${1}"
+	b_addr="${2}"
+
+	run_cmd ovs-vsctl add-port ovs_br0 ${type}_a -- \
+		set interface ${type}_a type=${type} \
+		options:remote_ip=${b_addr} options:key=1 options:csum=true || return 1
+}
+
 setup_ovs_vxlan_or_geneve() {
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
+	setup_ovs_via_internal_utility "${type}" "${a_addr}" "${b_addr}" \
+				       "${dport}" || \
+	    setup_ovs_via_vswitchd "${type}" "${b_addr}" || return 1
 
 	run_cmd ${ns_b} ip link add ${type}_b type ${type} id 1 ${opts_b} remote ${a_addr} ${opts} || return 1
 
 	run_cmd ${ns_b} ip addr add ${tunnel4_b_addr}/${tunnel4_mask} dev ${type}_b
 	run_cmd ${ns_b} ip addr add ${tunnel6_b_addr}/${tunnel6_mask} dev ${type}_b
 
+	run_cmd ip link set ${type}_a up
 	run_cmd ${ns_b} ip link set ${type}_b up
 }
 
@@ -880,8 +952,24 @@ setup_ovs_vxlan6() {
 	setup_ovs_vxlan_or_geneve vxlan  ${prefix6}:${a_r1}::1 ${prefix6}:${b_r1}::1
 }
 
+setup_ovs_br_internal() {
+	run_cmd python3 ./openvswitch/ovs-dpctl.py add-dp ovs_br0 || \
+		return 1
+}
+
+setup_ovs_br_vswitchd() {
+	run_cmd ovs-vsctl add-br ovs_br0 || return 1
+}
+
+setup_ovs_add_if() {
+	ifname="${1}"
+	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 \
+		"${ifname}" || \
+		run_cmd ovs-vsctl add-port ovs_br0 "${ifname}"
+}
+
 setup_ovs_bridge() {
-	run_cmd ovs-vsctl add-br ovs_br0 || return $ksft_skip
+	setup_ovs_br_internal || setup_ovs_br_vswitchd || return $ksft_skip
 	run_cmd ip link set ovs_br0 up
 
 	run_cmd ${ns_c} ip link add veth_C-A type veth peer name veth_A-C
@@ -891,7 +979,7 @@ setup_ovs_bridge() {
 	run_cmd ${ns_c} ip link set veth_C-A up
 	run_cmd ${ns_c} ip addr add ${veth4_c_addr}/${veth4_mask} dev veth_C-A
 	run_cmd ${ns_c} ip addr add ${veth6_c_addr}/${veth6_mask} dev veth_C-A
-	run_cmd ovs-vsctl add-port ovs_br0 veth_A-C
+	setup_ovs_add_if veth_A-C
 
 	# Move veth_A-R1 to init
 	run_cmd ${ns_a} ip link set veth_A-R1 netns 1
@@ -922,6 +1010,18 @@ trace() {
 	sleep 1
 }
 
+cleanup_del_ovs_internal() {
+	# squelch the output of the del-if commands since it can be wordy
+	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true vxlan_a	>/dev/null	2>&1
+	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true geneve_a	>/dev/null	2>&1
+	python3 ./openvswitch/ovs-dpctl.py del-dp ovs_br0			>/dev/null	2>&1
+}
+
+cleanup_del_ovs_vswitchd() {
+	ovs-vsctl --if-exists del-port vxlan_a	2>/dev/null
+	ovs-vsctl --if-exists del-br ovs_br0	2>/dev/null
+}
+
 cleanup() {
 	for pid in ${tcpdump_pids}; do
 		kill ${pid}
@@ -940,10 +1040,10 @@ cleanup() {
 
 	cleanup_all_ns
 
-	ip link del veth_A-C			2>/dev/null
-	ip link del veth_A-R1			2>/dev/null
-	ovs-vsctl --if-exists del-port vxlan_a	2>/dev/null
-	ovs-vsctl --if-exists del-br ovs_br0	2>/dev/null
+	ip link del veth_A-C		2>/dev/null
+	ip link del veth_A-R1		2>/dev/null
+	cleanup_del_ovs_internal
+	cleanup_del_ovs_vswitchd
 	rm -f "$tmpoutfile"
 }
 
@@ -1397,6 +1497,12 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
 	outer_family=${3}
 	ll_mtu=4000
 
+	if [ "${type}" = "vxlan" ]; then
+		tun_a="vxlan_sys_4789"
+	elif [ "${type}" = "geneve" ]; then
+		tun_a="genev_sys_6081"
+	fi
+
 	if [ ${outer_family} -eq 4 ]; then
 		setup namespaces routing ovs_bridge ovs_${type}4 || return $ksft_skip
 		#                      IPv4 header   UDP header   VXLAN/GENEVE header   Ethernet header
@@ -1407,17 +1513,11 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
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
-	      "${ns_c}" veth_C-A
+	trace ""        ${type}_a    "${ns_b}"  ${type}_b \
+	      ""        veth_A-R1    "${ns_r1}" veth_R1-A \
+	      "${ns_b}" veth_B-R1    "${ns_r1}" veth_R1-B \
+	      ""        ovs_br0      ""         veth-A_C  \
+	      "${ns_c}" veth_C-A     ""         "${tun_a}"
 
 	if [ ${family} -eq 4 ]; then
 		ping=ping
@@ -1436,8 +1536,9 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
 	mtu "${ns_b}"  veth_B-R1 ${ll_mtu}
 	mtu "${ns_r1}" veth_R1-B ${ll_mtu}
 
-	mtu ""        ${tun_a}  $((${ll_mtu} + 1000))
-	mtu "${ns_b}" ${type}_b $((${ll_mtu} + 1000))
+	mtu ""        ${tun_a}  $((${ll_mtu} + 1000)) 2>/dev/null || \
+		mtu ""        ${type}_a  $((${ll_mtu} + 1000)) 2>/dev/null
+	mtu "${ns_b}" ${type}_b  $((${ll_mtu} + 1000))
 
 	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -c 20 -s $((${ll_mtu} + 500)) ${dst} || return 1
 
-- 
2.45.1


