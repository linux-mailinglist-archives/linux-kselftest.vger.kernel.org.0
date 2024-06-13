Return-Path: <linux-kselftest+bounces-11899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C00907D81
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 22:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D381F23F63
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB7A13B584;
	Thu, 13 Jun 2024 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArXHWozP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602013A25D
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311100; cv=none; b=NT7m1gSUdCArdPQrZz1XOYTEblFS4soo9CLZTGPoWG6XKLP5ZkwaNW5/3QV+E/NxdnmpLsqLs4QopgqKoSPHEnc/G1VIspvpe1NUl7RjO9L077vycJLSaYq707rA1goop7nSqrJI/n6K85+Eu7cHmoUeB8eRIId7ktxb9iUlNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311100; c=relaxed/simple;
	bh=WSd1d7DffFSrkxa5KT+aYXD0eQQSAWOPzWO6NnEqpeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nY2tlEE7HJCBpxclxJIkIiFIOQ5qc+ChUmw6Z/i6qEcObxGBsayfQweaaTximdtZfUOfxPegc4RGCbeZFVV5JK+7bctn8fU58UhsX5HDUQ7+vGlJdv1ZnejhQ8JTxJCPgAuez2n54oEvPAfoa/uCIyG/LYBkFsWf3NLuGxW4ROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArXHWozP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718311097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2ih6wgTeeTdUw+I9BZrmiKxVOGbI/igMq6wiMNrZ34=;
	b=ArXHWozPN/QIhv9yPpwoew9aJQs9VUTUDtwByikYR847W4Kq3wm3uvMAsdtnRultcKJQwi
	FBPK3NSKyhxTgM+UiMGY4/ooeZcPN8iMx83z+jAUvOUrtFMUw/FlmdHKELN1aV0GfLAThJ
	yGS89mb5Q7yx2AgE5RKxCb8+uWeMsko=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-WSp1zHFFPkim1Hm4SwsELQ-1; Thu, 13 Jun 2024 16:38:15 -0400
X-MC-Unique: WSp1zHFFPkim1Hm4SwsELQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b07983a8adso46013486d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 13:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718311095; x=1718915895;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2ih6wgTeeTdUw+I9BZrmiKxVOGbI/igMq6wiMNrZ34=;
        b=hA5oXT/csPV5gz+cw45B05QTk2heCSRp43YJ+zHaIVyjR8eUMgI80SM9ccrgAyQTg4
         /wHwogOQi3UYsc0enfiZhu9vGN4qElMyWqCU8spv3NB7PbMUPzOZ7bN59NL1MHfDYQj6
         FykyB25SID50L/OF2NkmooVWHYn8zPxy2o7qzMoXnGJnFec4AjYoyjthoCX5oKMGk82J
         AF7zGbZ2t2t2C5oMFYAzH5znHhEdR4XPU3v3EJsuU0/BjQYnCr5PJwUbnma4WHp9f0ZF
         +n5DLEMiUBYKVm1IzUThzmDbVsQutbYlPJRWyWQoe0HkSZ+20KonNTQw1WN/zUKF3X/+
         OKEg==
X-Forwarded-Encrypted: i=1; AJvYcCV0DWv5xfOn2MHINB1KdtCK4xNBziDoAonaI7JYT6g02n9RR6lgtzkeMHJN2Os6U9PeRzlMzKQ/WUNhpSvg7U0C2MpunLPG2UayNGrFjk2N
X-Gm-Message-State: AOJu0YyDOoUZATwYxHqW8/LiJbcraPAg9RLyIfdXbxlg1Ff8raFHAUIo
	I2RoSP9O1lEMe2ikU+gscJfd8hlY48dXiOS8q0v1cD81sQGGZSJrAxXxxtJ7Z0FbHoVmhTtC4xZ
	7BtdbGeuETBuuYR0hbeUngTx+YnkG5W3OT1ukNk2OIEGi4qxHF1Bof4028HhPg2kSZA==
X-Received: by 2002:a0c:f842:0:b0:6b0:4cc0:2168 with SMTP id 6a1803df08f44-6b2af2ff426mr16437126d6.30.1718311095000;
        Thu, 13 Jun 2024 13:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu8a4fdhnpNgdM2gticJkdjVruJDQDkRnFfoLr9AqrMxOrjCQznv6qdckUc1Nq7Kl5S2B65Q==
X-Received: by 2002:a0c:f842:0:b0:6b0:4cc0:2168 with SMTP id 6a1803df08f44-6b2af2ff426mr16436576d6.30.1718311094473;
        Thu, 13 Jun 2024 13:38:14 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee04fdsm10389506d6.117.2024.06.13.13.38.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2024 13:38:13 -0700 (PDT)
Date: Thu, 13 Jun 2024 22:37:37 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Adrian Moreno
 <amorenoz@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [RFC net-next 6/7] selftests: net: Use the provided dpctl
 rather than the vswitchd for tests.
Message-ID: <20240613223737.28761cf3@elisabeth>
In-Reply-To: <20240613181333.984810-7-aconole@redhat.com>
References: <20240613181333.984810-1-aconole@redhat.com>
	<20240613181333.984810-7-aconole@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 14:13:32 -0400
Aaron Conole <aconole@redhat.com> wrote:

> The current pmtu test infrastucture requires an installed copy of the
> ovs-vswitchd userspace.  This means that any automated or constrained
> environments may not have the requisite tools to run the tests.  However,
> the pmtu tests don't require any special classifier processing.  Indeed
> they are only using the vswitchd in the most basic mode - as a NORMAL
> switch.
> 
> However, the ovs-dpctl kernel utility can now program all the needed basic
> flows to allow traffic to traverse the tunnels and provide support for at
> least testing some basic pmtu scenarios.

I didn't know about that tool, that looks like a nice improvement. A
few comments below (mostly nits):

> More complicated flow pipelines
> can be added to the internal ovs test infrastructure, but that is work for
> the future.  For now, enable the most common cases - wide mega flows with
> no other prerequisites.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  tools/testing/selftests/net/pmtu.sh | 87 ++++++++++++++++++++++-------
>  1 file changed, 67 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> index cfc84958025a..7f4f35d88dcc 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -846,22 +846,73 @@ setup_ovs_vxlan_or_geneve() {
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
> -
> +	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 ${type}_a -t ${type}

In some restricted environments, it might actually be more convenient
to carry around ovs-vsctl than Python with (Python) libraries.

Nowadays I typically (albeit seldom) run kselftests in throw-away VM
images made by mbuto (https://mbuto.sh/, see demo on the right), and
while it copies python3 and dynamic libraries from the host, adding
Python libraries such as pyroute2 gets quite complicated.

So I'm wondering, if it's not too messy: could we have two functions
starting from approximately here (say, setup_ovs_dpctl() and
setup_ovs_vsctl()), try with ovs-dpctl first, and, if that fails,
fall back to ovs-vsctl?

>  	run_cmd ${ns_b} ip link add ${type}_b type ${type} id 1 ${opts_b} remote ${a_addr} ${opts} || return 1
>  
>  	run_cmd ${ns_b} ip addr add ${tunnel4_b_addr}/${tunnel4_mask} dev ${type}_b
>  	run_cmd ${ns_b} ip addr add ${tunnel6_b_addr}/${tunnel6_mask} dev ${type}_b
>  
> +	run_cmd ip link set ${type}_a up
>  	run_cmd ${ns_b} ip link set ${type}_b up
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
> +	if [ "${v4_a_tun}" == "${a_addr}" ]; then

I see now that 05d92cb0e919 ("selftests/net: change shebang to bash to
support "source"") turned this into a Bash script (for no real reason,
lib.sh could have simply been sourced with '.' instead).

Other than that, this happily runs with dash and possibly others, and:

  $ checkbashisms -f pmtu.sh 
  possible bashism in pmtu.sh line 201 (should be '.', not 'source'):
  source lib.sh
  possible bashism in pmtu.sh line 202 (should be '.', not 'source'):
  source net_helper.sh

Would it be possible to change this to POSIX shell:

	if [ "${v4_a_tun}" = "${a_addr}" ]; then

even just for consistency with the rest of the file?

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
>  }
>  
>  setup_ovs_geneve4() {
> @@ -881,7 +932,7 @@ setup_ovs_vxlan6() {
>  }
>  
>  setup_ovs_bridge() {
> -	run_cmd ovs-vsctl add-br ovs_br0 || return $ksft_skip
> +	run_cmd python3 ./openvswitch/ovs-dpctl.py add-dp ovs_br0 || return $ksft_skip
>  	run_cmd ip link set ovs_br0 up
>  
>  	run_cmd ${ns_c} ip link add veth_C-A type veth peer name veth_A-C
> @@ -891,7 +942,7 @@ setup_ovs_bridge() {
>  	run_cmd ${ns_c} ip link set veth_C-A up
>  	run_cmd ${ns_c} ip addr add ${veth4_c_addr}/${veth4_mask} dev veth_C-A
>  	run_cmd ${ns_c} ip addr add ${veth6_c_addr}/${veth6_mask} dev veth_C-A
> -	run_cmd ovs-vsctl add-port ovs_br0 veth_A-C
> +	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 veth_A-C
>  
>  	# Move veth_A-R1 to init
>  	run_cmd ${ns_a} ip link set veth_A-R1 netns 1
> @@ -942,8 +993,10 @@ cleanup() {
>  
>  	ip link del veth_A-C			2>/dev/null
>  	ip link del veth_A-R1			2>/dev/null
> -	ovs-vsctl --if-exists del-port vxlan_a	2>/dev/null
> -	ovs-vsctl --if-exists del-br ovs_br0	2>/dev/null
> +	# squelch the output of the del-if commands since it can be wordy
> +	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true vxlan_a	>/dev/null	2>&1
> +	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true geneve_a	>/dev/null	2>&1
> +	python3 ./openvswitch/ovs-dpctl.py del-dp ovs_br0 >/dev/null	2>&1

The idea behind those tabs before 2>/dev/null was to keep them aligned
and make those redirections a bit easier on the eyes.

If you add more, you could keep those aligned as well -- or just decide
that lines are too long and drop the tabs altogether.

>  	rm -f "$tmpoutfile"
>  }
>  
> @@ -1407,16 +1460,10 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
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
> +	trace ""        "${type}_a"  "${ns_b}"  ${type}_b \
> +	      ""        veth_A-R1    "${ns_r1}" veth_R1-A \
> +	      "${ns_b}" veth_B-R1    "${ns_r1}" veth_R1-B \
> +	      ""        ovs_br0      ""         veth-A_C  \
>  	      "${ns_c}" veth_C-A
>  
>  	if [ ${family} -eq 4 ]; then
> @@ -1436,8 +1483,8 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
>  	mtu "${ns_b}"  veth_B-R1 ${ll_mtu}
>  	mtu "${ns_r1}" veth_R1-B ${ll_mtu}
>  
> -	mtu ""        ${tun_a}  $((${ll_mtu} + 1000))
> -	mtu "${ns_b}" ${type}_b $((${ll_mtu} + 1000))
> +	mtu ""        ${type}_a  $((${ll_mtu} + 1000))
> +	mtu "${ns_b}" ${type}_b  $((${ll_mtu} + 1000))
>  
>  	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -c 20 -s $((${ll_mtu} + 500)) ${dst} || return 1
>  

-- 
Stefano


