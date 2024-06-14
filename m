Return-Path: <linux-kselftest+bounces-11962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D5908F63
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0161F22D2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D4F16D31C;
	Fri, 14 Jun 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGUggFJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AC364A1
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380425; cv=none; b=Bw5tInI0LO2mNiuJLRI+aUwLiTzbuD8oJGG8+EDfZGRKTaCRX1W8TGke9n1XVBlWaha7MMZFV4U4GyMTO0NXpDTXlkfmIwvcGKKqoRwDNZhanIGzgnfO4+5x3i4e10E1R+m1PydsJu149V4gjcp1aNimM5iis2i7tUX0q7XZe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380425; c=relaxed/simple;
	bh=p+uS9AnX9IlW7iLsqwe8/uICO0mzf3w9Saj+OzNfAIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fjyCTcrmNPpO6m0G3p7Om1DFLfbO6BAoupibNbL48hnSMC+I1v579NxY+God9lXStO98dxpMgljjVapewq8BW1JNzTt/zYMaenl8gdXx2jiW32S8sSq8x+4SP2dUNAXXRW1m5L6PhKdNGOub4f2CEGqWeEtCeOIkjF7dKhdsQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGUggFJF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718380422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e29yJTW0Ie34L9PY/2yli5ohFO7CjSG8TA/RdpL/28U=;
	b=TGUggFJFboH9l7lcDqZ0Nor4YzDyigl8hgepOJMt6WIV9UmEojd/iyJ2oZCtjnuz369dtK
	TlCJhWgggKllp5RoYW6rSAF18RyAPII7+0E0Y7v2+qUWYHNdbm/MBXVJXj40i6TOfK8USn
	m6diILRW+WRbKyxpSczCdf06Knrk+JE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-UjRq48DrPa-MPtQXiRSfTA-1; Fri,
 14 Jun 2024 11:53:37 -0400
X-MC-Unique: UjRq48DrPa-MPtQXiRSfTA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C8B01956087;
	Fri, 14 Jun 2024 15:53:35 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 451921955E72;
	Fri, 14 Jun 2024 15:53:32 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Pravin B
 Shelar <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,  Adrian Moreno
 <amorenoz@redhat.com>,  Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [RFC net-next 6/7] selftests: net: Use the provided dpctl
 rather than the vswitchd for tests.
In-Reply-To: <20240613223737.28761cf3@elisabeth> (Stefano Brivio's message of
	"Thu, 13 Jun 2024 22:37:37 +0200")
References: <20240613181333.984810-1-aconole@redhat.com>
	<20240613181333.984810-7-aconole@redhat.com>
	<20240613223737.28761cf3@elisabeth>
Date: Fri, 14 Jun 2024 11:53:29 -0400
Message-ID: <f7tbk43pll2.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Stefano,

Thanks for the review!

Stefano Brivio <sbrivio@redhat.com> writes:

> On Thu, 13 Jun 2024 14:13:32 -0400
> Aaron Conole <aconole@redhat.com> wrote:
>
>> The current pmtu test infrastucture requires an installed copy of the
>> ovs-vswitchd userspace.  This means that any automated or constrained
>> environments may not have the requisite tools to run the tests.  However,
>> the pmtu tests don't require any special classifier processing.  Indeed
>> they are only using the vswitchd in the most basic mode - as a NORMAL
>> switch.
>> 
>> However, the ovs-dpctl kernel utility can now program all the needed basic
>> flows to allow traffic to traverse the tunnels and provide support for at
>> least testing some basic pmtu scenarios.
>
> I didn't know about that tool, that looks like a nice improvement. A
> few comments below (mostly nits):

It didn't at the time, so no worries :)

>> More complicated flow pipelines
>> can be added to the internal ovs test infrastructure, but that is work for
>> the future.  For now, enable the most common cases - wide mega flows with
>> no other prerequisites.
>> 
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>>  tools/testing/selftests/net/pmtu.sh | 87 ++++++++++++++++++++++-------
>>  1 file changed, 67 insertions(+), 20 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
>> index cfc84958025a..7f4f35d88dcc 100755
>> --- a/tools/testing/selftests/net/pmtu.sh
>> +++ b/tools/testing/selftests/net/pmtu.sh
>> @@ -846,22 +846,73 @@ setup_ovs_vxlan_or_geneve() {
>>  	type="${1}"
>>  	a_addr="${2}"
>>  	b_addr="${3}"
>> +	dport="6081"
>>  
>>  	if [ "${type}" = "vxlan" ]; then
>> +		dport="4789"
>>  		opts="${opts} ttl 64 dstport 4789"
>>  		opts_b="local ${b_addr}"
>>  	fi
>>  
>> -	run_cmd ovs-vsctl add-port ovs_br0 ${type}_a -- \
>> -		set interface ${type}_a type=${type} \
>> -		options:remote_ip=${b_addr} options:key=1 options:csum=true || return 1
>> -
>> +	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 ${type}_a -t ${type}
>
> In some restricted environments, it might actually be more convenient
> to carry around ovs-vsctl than Python with (Python) libraries.
>
> Nowadays I typically (albeit seldom) run kselftests in throw-away VM
> images made by mbuto (https://mbuto.sh/, see demo on the right), and
> while it copies python3 and dynamic libraries from the host, adding
> Python libraries such as pyroute2 gets quite complicated.
>
> So I'm wondering, if it's not too messy: could we have two functions
> starting from approximately here (say, setup_ovs_dpctl() and
> setup_ovs_vsctl()), try with ovs-dpctl first, and, if that fails,
> fall back to ovs-vsctl?

It didn't seem to be too bad - so I went ahead and made that change.  It
tested well, so I'll resubmit it with that.

>>  	run_cmd ${ns_b} ip link add ${type}_b type ${type} id 1
>> ${opts_b} remote ${a_addr} ${opts} || return 1
>>  
>>  	run_cmd ${ns_b} ip addr add ${tunnel4_b_addr}/${tunnel4_mask} dev ${type}_b
>>  	run_cmd ${ns_b} ip addr add ${tunnel6_b_addr}/${tunnel6_mask} dev ${type}_b
>>  
>> +	run_cmd ip link set ${type}_a up
>>  	run_cmd ${ns_b} ip link set ${type}_b up
>> +
>> +	ports=$(python3 ./openvswitch/ovs-dpctl.py show)
>> +	br0_port=$(echo "$ports" | grep -E "\sovs_br0" | sed -e 's@port @@' | cut -d: -f1 | xargs)
>> +	type_a_port=$(echo "$ports" | grep ${type}_a | sed -e 's@port @@' | cut -d: -f1 | xargs)
>> +	veth_a_port=$(echo "$ports" | grep veth_A | sed -e 's@port @@' | cut -d: -f1 | xargs)
>> +
>> +	v4_a_tun="${prefix4}.${a_r1}.1"
>> +	v4_b_tun="${prefix4}.${b_r1}.1"
>> +
>> +	v6_a_tun="${prefix6}:${a_r1}::1"
>> +	v6_b_tun="${prefix6}:${b_r1}::1"
>> +
>> +	if [ "${v4_a_tun}" == "${a_addr}" ]; then
>
> I see now that 05d92cb0e919 ("selftests/net: change shebang to bash to
> support "source"") turned this into a Bash script (for no real reason,
> lib.sh could have simply been sourced with '.' instead).
>
> Other than that, this happily runs with dash and possibly others, and:
>
>   $ checkbashisms -f pmtu.sh 
>   possible bashism in pmtu.sh line 201 (should be '.', not 'source'):
>   source lib.sh
>   possible bashism in pmtu.sh line 202 (should be '.', not 'source'):
>   source net_helper.sh
>
> Would it be possible to change this to POSIX shell:
>
> 	if [ "${v4_a_tun}" = "${a_addr}" ]; then
>
> even just for consistency with the rest of the file?

done.

>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0800),ipv4()" \
>> +		    "set(tunnel(tun_id=1,dst=${v4_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x86dd),ipv6()" \
>> +		    "set(tunnel(tun_id=1,dst=${v4_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),tunnel(tun_id=1,src=${v4_b_tun},dst=${v4_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0800),ipv4()" \
>> +		    "${veth_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),tunnel(tun_id=1,src=${v4_b_tun},dst=${v4_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x86dd),ipv6()" \
>> +		    "${veth_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),tunnel(tun_id=1,src=${v4_b_tun},dst=${v4_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0806),arp()" \
>> +		    "${veth_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0806),arp(sip=${veth4_c_addr},tip=${tunnel4_b_addr})" \
>> +		    "set(tunnel(tun_id=1,dst=${v4_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
>> +	else
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0800),ipv4()" \
>> +		    "set(tunnel(tun_id=1,ipv6_dst=${v6_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x86dd),ipv6()" \
>> +		    "set(tunnel(tun_id=1,ipv6_dst=${v6_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),tunnel(tun_id=1,ipv6_src=${v6_b_tun},ipv6_dst=${v6_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0800),ipv4()" \
>> +		    "${veth_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),tunnel(tun_id=1,ipv6_src=${v6_b_tun},ipv6_dst=${v6_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x86dd),ipv6()" \
>> +		    "${veth_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),tunnel(tun_id=1,ipv6_src=${v6_b_tun},ipv6_dst=${v6_a_tun}),in_port(${type_a_port}),eth(),eth_type(0x0806),arp()" \
>> +		    "${veth_a_port}"
>> +		run_cmd python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 \
>> +		    "recirc_id(0),in_port(${veth_a_port}),eth(),eth_type(0x0806),arp(sip=${veth4_c_addr},tip=${tunnel4_b_addr})" \
>> +		    "set(tunnel(tun_id=1,ipv6_dst=${v6_b_tun},ttl=64,tp_dst=${dport},flags(df|csum))),${type_a_port}"
>> +	fi
>>  }
>>  
>>  setup_ovs_geneve4() {
>> @@ -881,7 +932,7 @@ setup_ovs_vxlan6() {
>>  }
>>  
>>  setup_ovs_bridge() {
>> -	run_cmd ovs-vsctl add-br ovs_br0 || return $ksft_skip
>> +	run_cmd python3 ./openvswitch/ovs-dpctl.py add-dp ovs_br0 || return $ksft_skip
>>  	run_cmd ip link set ovs_br0 up
>>  
>>  	run_cmd ${ns_c} ip link add veth_C-A type veth peer name veth_A-C
>> @@ -891,7 +942,7 @@ setup_ovs_bridge() {
>>  	run_cmd ${ns_c} ip link set veth_C-A up
>>  	run_cmd ${ns_c} ip addr add ${veth4_c_addr}/${veth4_mask} dev veth_C-A
>>  	run_cmd ${ns_c} ip addr add ${veth6_c_addr}/${veth6_mask} dev veth_C-A
>> -	run_cmd ovs-vsctl add-port ovs_br0 veth_A-C
>> +	run_cmd python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 veth_A-C
>>  
>>  	# Move veth_A-R1 to init
>>  	run_cmd ${ns_a} ip link set veth_A-R1 netns 1
>> @@ -942,8 +993,10 @@ cleanup() {
>>  
>>  	ip link del veth_A-C			2>/dev/null
>>  	ip link del veth_A-R1			2>/dev/null
>> -	ovs-vsctl --if-exists del-port vxlan_a	2>/dev/null
>> -	ovs-vsctl --if-exists del-br ovs_br0	2>/dev/null
>> +	# squelch the output of the del-if commands since it can be wordy
>> +	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true vxlan_a	>/dev/null	2>&1
>> +	python3 ./openvswitch/ovs-dpctl.py del-if ovs_br0 -d true geneve_a	>/dev/null	2>&1
>> +	python3 ./openvswitch/ovs-dpctl.py del-dp ovs_br0 >/dev/null	2>&1
>
> The idea behind those tabs before 2>/dev/null was to keep them aligned
> and make those redirections a bit easier on the eyes.
>
> If you add more, you could keep those aligned as well -- or just decide
> that lines are too long and drop the tabs altogether.

Yeah, looks like I missed the /dev/null tabs but those were supposed to
be lined up.  Anyway, I rewrote this part so that it looks better (I
think).

>>  	rm -f "$tmpoutfile"
>>  }
>>  
>> @@ -1407,16 +1460,10 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
>>  		exp_mtu=$((${ll_mtu} - 40          - 8          - 8                   - 14))
>>  	fi
>>  
>> -	if [ "${type}" = "vxlan" ]; then
>> -		tun_a="vxlan_sys_4789"
>> -	elif [ "${type}" = "geneve" ]; then
>> -		tun_a="genev_sys_6081"
>> -	fi
>> -
>> -	trace ""        "${tun_a}"  "${ns_b}"  ${type}_b \
>> -	      ""        veth_A-R1   "${ns_r1}" veth_R1-A \
>> -	      "${ns_b}" veth_B-R1   "${ns_r1}" veth_R1-B \
>> -	      ""        ovs_br0     ""         veth-A-C  \
>> +	trace ""        "${type}_a"  "${ns_b}"  ${type}_b \
>> +	      ""        veth_A-R1    "${ns_r1}" veth_R1-A \
>> +	      "${ns_b}" veth_B-R1    "${ns_r1}" veth_R1-B \
>> +	      ""        ovs_br0      ""         veth-A_C  \
>>  	      "${ns_c}" veth_C-A
>>  
>>  	if [ ${family} -eq 4 ]; then
>> @@ -1436,8 +1483,8 @@ test_pmtu_ipvX_over_ovs_vxlanY_or_geneveY_exception() {
>>  	mtu "${ns_b}"  veth_B-R1 ${ll_mtu}
>>  	mtu "${ns_r1}" veth_R1-B ${ll_mtu}
>>  
>> -	mtu ""        ${tun_a}  $((${ll_mtu} + 1000))
>> -	mtu "${ns_b}" ${type}_b $((${ll_mtu} + 1000))
>> +	mtu ""        ${type}_a  $((${ll_mtu} + 1000))
>> +	mtu "${ns_b}" ${type}_b  $((${ll_mtu} + 1000))
>>  
>>  	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -c 20 -s $((${ll_mtu} + 500)) ${dst} || return 1
>>  


