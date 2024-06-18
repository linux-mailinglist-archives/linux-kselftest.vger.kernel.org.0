Return-Path: <linux-kselftest+bounces-12157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC1490D80E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 18:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E28E1C23BAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FCF4D135;
	Tue, 18 Jun 2024 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdRFnhR7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376047A76
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726592; cv=none; b=Lsucm9qj8WaSUg3Q0TULn9jpkI42rPjeZLgOmi6BhXo7ZTnayBUaLh4mBOM4cqGwEgsnQYG+d6ADyHmfEsIZz9Ax4bGapSuTiYsLTaxSaOXeI1oI2uMlogFem9vGFZwSdk3bDpYCGA711iy79EKZZB7U1JCt9yMj3KNFB3SI+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726592; c=relaxed/simple;
	bh=FjBcsfdHGZXvF4/KpxssT5Lc9S9KZdX9F4QOnQy0kjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XUCi1IY52GSuoSKnLtliAr9f5JCBhy6XTkv+RFe7Vj09Se3qwWQlIZjPTS6nejiABVRD1ThwNLjwHZE8OKLsKYz0IrgrpYpL2eE0LPrDfMZts6CnUOaiXAtYwGDq50RtIYwP+e0dcL1ymSehoavw6JOo7hmWGQouA4m4wHOW+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdRFnhR7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XitgP1kzStul1y7vs+mWWL5nkNE4bgRz6s5pl8bogs0=;
	b=ZdRFnhR7NFvARICiEN4aO9s+gN2vZkNAt++kngA2T0qOiUnQRnSh0N0sTG6a9QLYlJl+EI
	KRIyyxeZArnMBR48QeCFAumiNCBd0aXlaf5D5ta1G9xZnQOOqkXB+uplPdd2aTsoc7z9vc
	zhKE4WgNNhR8uM3N4eUliaOXBAj8R7U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-N1OfJr65Pui9voTXnXCwkA-1; Tue,
 18 Jun 2024 12:03:06 -0400
X-MC-Unique: N1OfJr65Pui9voTXnXCwkA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E37119560BE;
	Tue, 18 Jun 2024 16:03:03 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C84919560AE;
	Tue, 18 Jun 2024 16:03:00 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,  Simon Horman <horms@kernel.org>,
  linux-kernel@vger.kernel.org,  Stefano Brivio <sbrivio@redhat.com>,  Eric
 Dumazet <edumazet@google.com>,  linux-kselftest@vger.kernel.org,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 6/7] selftests: net: Use the provided
 dpctl rather than the vswitchd for tests.
In-Reply-To: <20240617180218.1154326-7-aconole@redhat.com> (Aaron Conole's
	message of "Mon, 17 Jun 2024 14:02:17 -0400")
References: <20240617180218.1154326-1-aconole@redhat.com>
	<20240617180218.1154326-7-aconole@redhat.com>
Date: Tue, 18 Jun 2024 12:02:59 -0400
Message-ID: <f7tv826jl1o.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Aaron Conole <aconole@redhat.com> writes:

> The current pmtu test infrastucture requires an installed copy of the
> ovs-vswitchd userspace.  This means that any automated or constrained
> environments may not have the requisite tools to run the tests.  However,
> the pmtu tests don't require any special classifier processing.  Indeed
> they are only using the vswitchd in the most basic mode - as a NORMAL
> switch.
>
> However, the ovs-dpctl kernel utility can now program all the needed basic
> flows to allow traffic to traverse the tunnels and provide support for at
> least testing some basic pmtu scenarios.  More complicated flow pipelines
> can be added to the internal ovs test infrastructure, but that is work for
> the future.  For now, enable the most common cases - wide mega flows with
> no other prerequisites.
>
> Enhance the pmtu testing to try testing using the internal utility, first.
> As a fallback, if the internal utility isn't running, then try with the
> ovs-vswitchd userspace tools.
>
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  tools/testing/selftests/net/pmtu.sh | 145 +++++++++++++++++++++++-----
>  1 file changed, 123 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> index cfc84958025a..51ccb9bed069 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -842,25 +842,97 @@ setup_bridge() {
>  	run_cmd ${ns_a} ip link set veth_A-C master br0
>  }
>  
> +setup_ovs_via_internal_utility() {
> +	type="${1}"
> +	a_addr="${2}"
> +	b_addr="${3}"
> +	dport="${4}"
> +
> +	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 ${type}_a -t ${type} || return 1
> +
> +	ports=$(python3 ./openvswitch/ovs-dpctl.py show)
> +	br0_port=$(echo "$ports" | grep -E "\sovs_br0" | sed -e 's@port @@' | cut -d: -f1 | xargs)
> +	type_a_port=$(echo "$ports" | grep ${type}_a | sed -e 's@port @@' | cut -d: -f1 | xargs)
> +	veth_a_port=$(echo "$ports" | grep veth_A | sed -e 's@port @@' | cut -d: -f1 | xargs)
> +
> +	v4_a_tun="${prefix4}.${a_r1}.1"
> +	v4_b_tun="${prefix4}.${b_r1}.1"
> +
> +	v6_a_tun="${prefix6}:${a_r1}::1"
> +	v6_b_tun="${prefix6}:${b_r1}::1"
> +
> +	if [ "${v4_a_tun}" = "${a_addr}" ]; then
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0800),ipv4()" \
> +		    "set(tunnel(tun_id=1,dst=${v4_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x86dd),ipv6()" \
> +		    "set(tunnel(tun_id=1,dst=${v4_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),tunnel(tun_id=1,src=${v4_b_tun},dst=${v4_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0800),ipv4()" \
> +		    "${veth_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),tunnel(tun_id=1,src=${v4_b_tun},dst=${v4_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x86dd),ipv6()" \
> +		    "${veth_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),tunnel(tun_id=1,src=${v4_b_tun},dst=${v4_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0806),arp()" \
> +		    "${veth_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0806),arp(sip=${veth4_c_addr},tip=${tunnel4_b_addr})" \
> +		    "set(tunnel(tun_id=1,dst=${v4_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
> +	else
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0800),ipv4()" \
> +		    "set(tunnel(tun_id=1,ipv6_dst=${v6_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x86dd),ipv6()" \
> +		    "set(tunnel(tun_id=1,ipv6_dst=${v6_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),tunnel(tun_id=1,ipv6_src=${v6_b_tun},ipv6_dst=${v6_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0800),ipv4()" \
> +		    "${veth_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),tunnel(tun_id=1,ipv6_src=${v6_b_tun},ipv6_dst=${v6_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x86dd),ipv6()" \
> +		    "${veth_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),tunnel(tun_id=1,ipv6_src=${v6_b_tun},ipv6_dst=${v6_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0806),arp()" \
> +		    "${veth_a_port}"
> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0806),arp(sip=${veth4_c_addr},tip=${tunnel4_b_addr})" \
> +		    "set(tunnel(tun_id=1,ipv6_dst=${v6_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
> +	fi
> +}
> +
> +setup_ovs_via_vswitchd() {
> +	type="${1}"
> +	b_addr="${2}"
> +
> +	run_cmd ovs-vsctl add-port ovs_br0 ${type}_a -- \
> +		set interface ${type}_a type=${type} \
> +		options:remote_ip=${b_addr} options:key=1 options:csum=true || return 1
> +}
> +
>  setup_ovs_vxlan_or_geneve() {
>  	type="${1}"
>  	a_addr="${2}"
>  	b_addr="${3}"
> +	dport="6081"
>  
>  	if [ "${type}" = "vxlan" ]; then
> +		dport="4789"
>  		opts="${opts} ttl 64 dstport 4789"
>  		opts_b="local ${b_addr}"
>  	fi
>  
> -	run_cmd ovs-vsctl add-port ovs_br0 ${type}_a -- \
> -		set interface ${type}_a type=${type} \
> -		options:remote_ip=${b_addr} options:key=1 options:csum=true || return 1
> +	setup_ovs_via_internal_utility "${type}" "${a_addr}" "${b_addr}" \
> +				       "${dport}" || \
> +	    setup_ovs_via_vswitchd "${type}" "${b_addr}" || return 1
>  
>  	run_cmd ${ns_b} ip link add ${type}_b type ${type} id 1 ${opts_b} remote ${a_addr} ${opts} || return 1
>  
>  	run_cmd ${ns_b} ip addr add ${tunnel4_b_addr}/${tunnel4_mask} dev ${type}_b
>  	run_cmd ${ns_b} ip addr add ${tunnel6_b_addr}/${tunnel6_mask} dev ${type}_b
>  
> +	run_cmd ip link set ${type}_a up
>  	run_cmd ${ns_b} ip link set ${type}_b up
>  }
>  
> @@ -880,8 +952,24 @@ setup_ovs_vxlan6() {
>  	setup_ovs_vxlan_or_geneve vxlan  ${prefix6}:${a_r1}::1 ${prefix6}:${b_r1}::1
>  }
>  
> +setup_ovs_br_internal() {
> +	run_cmd python3 ./openvswitch/ovs-dpctl.py add-dp ovs_br0 || \
> +		return 1
> +}
> +
> +setup_ovs_br_vswitchd() {
> +	run_cmd ovs-vsctl add-br ovs_br0 || return 1
> +}
> +
> +setup_ovs_add_if() {
> +	ifname="${1}"
> +	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 \
> +		"${ifname}" || \
> +		run_cmd ovs-vsctl add-port ovs_br0 "${ifname}"
> +}
> +
>  setup_ovs_bridge() {
> -	run_cmd ovs-vsctl add-br ovs_br0 || return $ksft_skip
> +	setup_ovs_br_internal || setup_ovs_br_vswitchd || return $ksft_skip
>  	run_cmd ip link set ovs_br0 up
>  
>  	run_cmd ${ns_c} ip link add veth_C-A type veth peer name veth_A-C
> @@ -891,7 +979,7 @@ setup_ovs_bridge() {
>  	run_cmd ${ns_c} ip link set veth_C-A up
>  	run_cmd ${ns_c} ip addr add ${veth4_c_addr}/${veth4_mask} dev veth_C-A
>  	run_cmd ${ns_c} ip addr add ${veth6_c_addr}/${veth6_mask} dev veth_C-A
> -	run_cmd ovs-vsctl add-port ovs_br0 veth_A-C
> +        setup_ovs_add_if veth_A-C

NIT: This should have been tab instead of space.  I will correct with v2.

>  	# Move veth_A-R1 to init
>  	run_cmd ${ns_a} ip link set veth_A-R1 netns 1
> @@ -922,6 +1010,18 @@ trace() {
>  	sleep 1
>  }
>  
> +cleanup_del_ovs_internal() {
> +	# squelch the output of the del-if commands since it can be wordy
> +	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true vxlan_a	>/dev/null	2>&1
> +	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true geneve_a	>/dev/null	2>&1
> +	python3 ./openvswitch/ovs-dpctl.py del-dp ovs_br0			>/dev/null	2>&1
> +}
> +
> +cleanup_del_ovs_vswitchd() {
> +	ovs-vsctl --if-exists del-port vxlan_a	2>/dev/null
> +	ovs-vsctl --if-exists del-br ovs_br0	2>/dev/null
> +}
> +
>  cleanup() {
>  	for pid in ${tcpdump_pids}; do
>  		kill ${pid}
> @@ -940,10 +1040,10 @@ cleanup() {
>  
>  	cleanup_all_ns
>  
> -	ip link del veth_A-C			2>/dev/null
> -	ip link del veth_A-R1			2>/dev/null
> -	ovs-vsctl --if-exists del-port vxlan_a	2>/dev/null
> -	ovs-vsctl --if-exists del-br ovs_br0	2>/dev/null
> +	ip link del veth_A-C		2>/dev/null
> +	ip link del veth_A-R1		2>/dev/null
> +	cleanup_del_ovs_internal
> +	cleanup_del_ovs_vswitchd
>  	rm -f "$tmpoutfile"
>  }
>  
> @@ -1397,6 +1497,12 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
>  	outer_family=${3}
>  	ll_mtu=4000
>  
> +	if [ "${type}" = "vxlan" ]; then
> +		tun_a="vxlan_sys_4789"
> +	elif [ "${type}" = "geneve" ]; then
> +		tun_a="genev_sys_6081"
> +	fi
> +
>  	if [ ${outer_family} -eq 4 ]; then
>  		setup namespaces routing ovs_bridge ovs_${type}4 || return $ksft_skip
>  		#                      IPv4 header   UDP header   VXLAN/GENEVE header   Ethernet header
> @@ -1407,17 +1513,11 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
>  		exp_mtu=$((${ll_mtu} - 40          - 8          - 8                   - 14))
>  	fi
>  
> -	if [ "${type}" = "vxlan" ]; then
> -		tun_a="vxlan_sys_4789"
> -	elif [ "${type}" = "geneve" ]; then
> -		tun_a="genev_sys_6081"
> -	fi
> -
> -	trace ""        "${tun_a}"  "${ns_b}"  ${type}_b \
> -	      ""        veth_A-R1   "${ns_r1}" veth_R1-A \
> -	      "${ns_b}" veth_B-R1   "${ns_r1}" veth_R1-B \
> -	      ""        ovs_br0     ""         veth-A-C  \
> -	      "${ns_c}" veth_C-A
> +	trace ""        ${type}_a    "${ns_b}"  ${type}_b \
> +	      ""        veth_A-R1    "${ns_r1}" veth_R1-A \
> +	      "${ns_b}" veth_B-R1    "${ns_r1}" veth_R1-B \
> +	      ""        ovs_br0      ""         veth-A_C  \
> +	      "${ns_c}" veth_C-A     ""         "${tun_a}"
>  
>  	if [ ${family} -eq 4 ]; then
>  		ping=ping
> @@ -1436,8 +1536,9 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
>  	mtu "${ns_b}"  veth_B-R1 ${ll_mtu}
>  	mtu "${ns_r1}" veth_R1-B ${ll_mtu}
>  
> -	mtu ""        ${tun_a}  $((${ll_mtu} + 1000))
> -	mtu "${ns_b}" ${type}_b $((${ll_mtu} + 1000))
> +	mtu ""        ${tun_a}  $((${ll_mtu} + 1000)) 2>/dev/null || \
> +		mtu ""        ${type}_a  $((${ll_mtu} + 1000)) 2>/dev/null
> +	mtu "${ns_b}" ${type}_b  $((${ll_mtu} + 1000))
>  
>  	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -c 20 -s $((${ll_mtu} + 500)) ${dst} || return 1


