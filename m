Return-Path: <linux-kselftest+bounces-21349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0189BA589
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 14:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389372810D9
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA416E86F;
	Sun,  3 Nov 2024 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZJyu6/s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BF16DEB3;
	Sun,  3 Nov 2024 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730639109; cv=none; b=cUZxeMtVi39LHh/ld9xNWrHt+y6ksWJ3KKEs/WNr2aZ+OOofmw0J9wQAUR/jbqgl/xto29Oa3/FgUbBlaWHSNpFRcoQJzkGBRuF0odeiEJ8DpWfHhSoIN8onw85nkk97hXgB3qwmacEEPD45Z+HNWjR1GRRNKHTWA5iGuu/UaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730639109; c=relaxed/simple;
	bh=D3Hs5IAa1FpSFeDZAanNwQRpc4G1vnuj3taUICEpH8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfxxBpVFQxm5pc5jjDxaj91aDEi4M/Xe47PEcnyTHXaebjxlEGWS5IGBDvHg8PLKo9Mbc0Ic1ltKl+ggVTb0sygAcchTMJKaa3hCcyqM1ExJplhOhl02/WVy7zdmaeou7cg9M3vbZWInWLZmpvbypwczf7TlUsTzmvmFIOr46aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZJyu6/s; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 27FA6114011B;
	Sun,  3 Nov 2024 08:05:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 03 Nov 2024 08:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730639105; x=1730725505; bh=Gpqs4QxtvCpOauqPamp0nQOEYYy8ce8ivvN
	plUDhGxM=; b=eZJyu6/sn5xPNOn4yNKIYA8aTabWjXYxr9EgcyTKfIqohuVQZ7N
	x4Q5uoLkfqI0ywNTDSwrJW4xyoR6J769E/z8EL3PzoWcsHgCqort9gwe6ndxDm+h
	q/HBqgRunNR+yRvORd4VB1+yda90nlpugw9sp2crK5xYP0ced5IAZ8bKIgEljuSJ
	75ykqScfXa/59W+MSb1ktLkNdRX34dSMHo3RpRcQXXBcjTihN5+4ga1Vgrlw/JR+
	jWYIYxuGIzK+aN7kzlxlns9RJOVE2rqs/sMCc/OaCvJs4GRU4dok+YxP9tlWvl+Y
	a8L/htUZeou7qqQQt5i81Zo3jakzBXghsWQ==
X-ME-Sender: <xms:AHUnZ7nZoL79yXaZznCnDL-WPO5M5CYcs2iEzO9QD5ZCZrzGsBgwvA>
    <xme:AHUnZ-0FmxraYgqlEJMgSZJ6HOuutD474moLOMRuS9bHZawLEjNeFLi5QLWjPQepI
    -Dan-bk-tr-ha4>
X-ME-Received: <xmr:AHUnZxrMMI8OLiQG4vp1YDmvEDc33OHtHz5cGs2ByDJ-Pb1Mg1gfQFuIASwh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcu
    oehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefve
    ekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguoh
    hstghhrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepuggvlhhirhgrnhesvhgvrhguihgtthdrghhgpdhrtghpthhtohepnhgvth
    guvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughsrghhvghrnhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhi
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AHUnZzmvAcjedSfHCOMh-UhyR_Aj9aik468pX9Wnp175URUA2Z55cA>
    <xmx:AHUnZ52V9N6eQAFgFEjI2mNbklQe3cYq9BDRUAMWNtJcDnXuY4Py7g>
    <xmx:AHUnZyteMUAqh3l18EOjF6ou8bUz7TLuF4tUvuTXA2hyqm8t0eqNdA>
    <xmx:AHUnZ9VL4TvcGNFOMPH24AYgfJIF1_n799YI67kcPAsbnsJCpNyItA>
    <xmx:AHUnZzwQta7kotTmSiU66zc_gy_NSuzzuZOeherC0Fj-XaKI6wA3jWxK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Nov 2024 08:05:03 -0500 (EST)
Date: Sun, 3 Nov 2024 15:05:00 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, linux-kselftest@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	horms@kernel.org
Subject: Re: [PATCH v6] net: ipv4: Cache pmtu for all packet paths if
 multipath enabled
Message-ID: <Zyd0_CaVTUKCkfqH@shredder>
References: <20241102163000.2392-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102163000.2392-1-deliran@verdict.gg>

Subject prefix should be "[PATCH net-next v6]" (v7 for next version,
obviously)

On Sat, Nov 02, 2024 at 04:29:35PM +0000, Vladimir Vdovin wrote:
> Check number of paths by fib_info_num_path(),
> and update_or_create_fnhe() for every path.
> Problem is that pmtu is cached only for the oif
> that has received icmp message "need to frag",
> other oifs will still try to use "default" iface mtu.
> 
> An example topology showing the problem:
> 
>                     |  host1
>                 +---------+
>                 |  dummy0 | 10.179.20.18/32  mtu9000
>                 +---------+
>         +-----------+----------------+
>     +---------+                     +---------+
>     | ens17f0 |  10.179.2.141/31    | ens17f1 |  10.179.2.13/31
>     +---------+                     +---------+
>         |    (all here have mtu 9000)    |
>     +------+                         +------+
>     | ro1  |  10.179.2.140/31        | ro2  |  10.179.2.12/31
>     +------+                         +------+
>         |                                |
> ---------+------------+-------------------+------
>                         |
>                     +-----+
>                     | ro3 | 10.10.10.10  mtu1500
>                     +-----+
>                         |
>     ========================================
>                 some networks
>     ========================================
>                         |
>                     +-----+
>                     | eth0| 10.10.30.30  mtu9000
>                     +-----+
>                         |  host2
> 
> host1 have enabled multipath and
> sysctl net.ipv4.fib_multipath_hash_policy = 1:
> 
> default proto static src 10.179.20.18
>         nexthop via 10.179.2.12 dev ens17f1 weight 1
>         nexthop via 10.179.2.140 dev ens17f0 weight 1
> 
> When host1 tries to do pmtud from 10.179.20.18/32 to host2,
> host1 receives at ens17f1 iface an icmp packet from ro3 that ro3 mtu=1500.
> And host1 caches it in nexthop exceptions cache.
> 
> Problem is that it is cached only for the iface that has received icmp,
> and there is no way that ro3 will send icmp msg to host1 via another path.
> 
> Host1 now have this routes to host2:
> 
> ip r g 10.10.30.30 sport 30000 dport 443
> 10.10.30.30 via 10.179.2.12 dev ens17f1 src 10.179.20.18 uid 0
>     cache expires 521sec mtu 1500
> 
> ip r g 10.10.30.30 sport 30033 dport 443
> 10.10.30.30 via 10.179.2.140 dev ens17f0 src 10.179.20.18 uid 0
>     cache
> 
> So when host1 tries again to reach host2 with mtu>1500,
> if packet flow is lucky enough to be hashed with oif=ens17f1 its ok,
> if oif=ens17f0 it blackholes and still gets icmp msgs from ro3 to ens17f1,
> until lucky day when ro3 will send it through another flow to ens17f0.
> 
> Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> ---
> 
> V6:
>   - make commit message cleaner
> 
> V5:
>   - make self test cleaner
> 
> V4:
>   - fix selftest, do route lookup before checking cached exceptions
> 
> V3:
>   - added selftest
>   - fixed compile error
> 
> V2:
>   - fix fib_info_num_path parameter pass
> ---
>  net/ipv4/route.c                    | 13 +++++
>  tools/testing/selftests/net/pmtu.sh | 78 ++++++++++++++++++++++++++++-
>  2 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 723ac9181558..41162b5cc4cb 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1027,6 +1027,19 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
>  		struct fib_nh_common *nhc;
>  
>  		fib_select_path(net, &res, fl4, NULL);
> +#ifdef CONFIG_IP_ROUTE_MULTIPATH
> +		if (fib_info_num_path(res.fi) > 1) {
> +			int nhsel;
> +
> +			for (nhsel = 0; nhsel < fib_info_num_path(res.fi); nhsel++) {
> +				nhc = fib_info_nhc(res.fi, nhsel);
> +				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
> +							  jiffies + net->ipv4.ip_rt_mtu_expires);
> +			}
> +			rcu_read_unlock();
> +			return;
> +		}
> +#endif /* CONFIG_IP_ROUTE_MULTIPATH */
>  		nhc = FIB_RES_NHC(res);
>  		update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
>  				      jiffies + net->ipv4.ip_rt_mtu_expires);
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> index 569bce8b6383..a0159340fe84 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -266,7 +266,8 @@ tests="
>  	list_flush_ipv4_exception	ipv4: list and flush cached exceptions	1
>  	list_flush_ipv6_exception	ipv6: list and flush cached exceptions	1
>  	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
> -	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
> +	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1
> +	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions		0"

There is misalignment in the last field ("re-run with nh") and I think
it should be "1" in order to exercise this path with both legacy
nexthops and nexthop objects. See more below.

In addition, this test case is missing documentation at the beginning of
the file.

I also believe we have a problem with IPv6, but I will look into it when
I have time and add a test case.

>  
>  # Addressing and routing for tests with routers: four network segments, with
>  # index SEGMENT between 1 and 4, a common prefix (PREFIX4 or PREFIX6) and an
> @@ -2329,6 +2330,81 @@ test_pmtu_ipv6_route_change() {
>  	test_pmtu_ipvX_route_change 6
>  }
>  
> +test_pmtu_ipv4_mp_exceptions() {
> +	setup namespaces routing || return $ksft_skip
> +
> +	ip nexthop ls >/dev/null 2>&1
> +	if [ $? -ne 0 ]; then
> +		echo "Nexthop objects not supported; skipping tests"
> +		exit $ksft_skip
> +	fi

Whether nexthop objects are supported or not is stored in "HAVE_NH" and
there is no need for this check here if you add setup_mp() like I
suggest below.

> +
> +	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
> +	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
> +	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
> +	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
> +
> +	dummy0_a="192.168.99.99"
> +	dummy0_b="192.168.88.88"
> +
> +	# Set up initial MTU values
> +	mtu "${ns_a}"  veth_A-R1 2000
> +	mtu "${ns_r1}" veth_R1-A 2000
> +	mtu "${ns_r1}" veth_R1-B 1500
> +	mtu "${ns_b}"  veth_B-R1 1500

According to the documentation at the beginning of the file, the MTU
between B and R1 is 1400. See other test cases.

> +
> +	mtu "${ns_a}"  veth_A-R2 2000
> +	mtu "${ns_r2}" veth_R2-A 2000
> +	mtu "${ns_r2}" veth_R2-B 1500
> +	mtu "${ns_b}"  veth_B-R2 1500
> +
> +	fail=0
> +
> +	#Set up host A with multipath routes to host B dummy0_b
         ^ Missing space after '#'. Same in other places.

> +	run_cmd ${ns_a} sysctl -q net.ipv4.fib_multipath_hash_policy=1

The test only uses ICMP, so hash policy can be L3 (0). Same for B.

> +	run_cmd ${ns_a} sysctl -q net.ipv4.ip_forward=1

It's a host, so no need to enable forwarding.

> +	run_cmd ${ns_a} ip link add dummy0 mtu 2000 type dummy
> +	run_cmd ${ns_a} ip link set dummy0 up

Can't you simply add the address on the loopback device instead of
creating a dummy netdev?

> +	run_cmd ${ns_a} ip addr add ${dummy0_a} dev dummy0
> +	run_cmd ${ns_a} ip nexthop add id 201 via ${prefix4}.${a_r1}.2 dev veth_A-R1
> +	run_cmd ${ns_a} ip nexthop add id 202 via ${prefix4}.${a_r2}.2 dev veth_A-R2
> +	run_cmd ${ns_a} ip nexthop add id 203 group 201/202
> +	run_cmd ${ns_a} ip route add ${dummy0_b} nhid 203

It would be good to test this with legacy nexthops as well. I'm not that
familiar with pmtu.sh, but I think you can add a "setup_mp" function and
invoke it via "setup namespaces routing mp [...]" at the beginning of
the function.

Internally, setup_mp() will consult "USE_NH" and invoke setup_mp_old()
or setup_mp_new() accordingly, like setup_routing() does.

> +
> +	#Set up host B with multipath routes to host A dummy0_a
> +	run_cmd ${ns_b} sysctl -q net.ipv4.fib_multipath_hash_policy=1
> +	run_cmd ${ns_b} sysctl -q net.ipv4.ip_forward=1
> +	run_cmd ${ns_b} ip link add dummy0 mtu 2000 type dummy
> +	run_cmd ${ns_b} ip link set dummy0 up
> +	run_cmd ${ns_b} ip addr add ${dummy0_b} dev dummy0
> +	run_cmd ${ns_b} ip nexthop add id 201 via ${prefix4}.${b_r1}.2 dev veth_A-R1
> +	run_cmd ${ns_b} ip nexthop add id 202 via ${prefix4}.${b_r2}.2 dev veth_A-R2
> +	run_cmd ${ns_b} ip nexthop add id 203 group 201/202
> +	run_cmd ${ns_b} ip route add ${dummy0_a} nhid 203
> +
> +	#Set up routers with routes to dummies
> +	run_cmd ${ns_r1} ip route add ${dummy0_a} via ${prefix4}.${a_r1}.1
> +	run_cmd ${ns_r2} ip route add ${dummy0_a} via ${prefix4}.${a_r2}.1
> +	run_cmd ${ns_r1} ip route add ${dummy0_b} via ${prefix4}.${b_r1}.1
> +	run_cmd ${ns_r2} ip route add ${dummy0_b} via ${prefix4}.${b_r2}.1
> +
> +
> +	#Ping and expect two nexthop exceptions for two routes in nh group
> +	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 2 -s 1800 "${dummy0_b}"

'-c 1' should be enough

> +
> +	#Do route lookup before checking cached exceptions

IIUC, previous command created an exception in both nexthops. The
following commands are needed so that a dst entry will be cached in both
exceptions and therefore be dumped below to user space. If so, please
adjust the comment to reflect that.

> +	run_cmd ${ns_a} ip route get ${dummy0_b} oif veth_A-R1
> +	run_cmd ${ns_a} ip route get ${dummy0_b} oif veth_A-R2
> +
> +	#Check cached exceptions
> +	if [ "$(${ns_a} ip -oneline route list cache| grep mtu | wc -l)" -ne 2 ]; then
                                                   ^ Missing space before the pipe


> +		err "  there are not enough cached exceptions"
> +		fail=1
> +	fi
> +
> +	return ${fail}
> +}
> +
>  usage() {
>  	echo
>  	echo "$0 [OPTIONS] [TEST]..."
> 
> base-commit: 66600fac7a984dea4ae095411f644770b2561ede
> -- 
> 2.43.5
> 

