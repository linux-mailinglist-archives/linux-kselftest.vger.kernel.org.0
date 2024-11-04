Return-Path: <linux-kselftest+bounces-21363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524D79BAE6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 09:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85DB1F235E7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C545519F42F;
	Mon,  4 Nov 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="KHTS1x6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from qs51p00im-qukt01071702.me.com (qs51p00im-qukt01071702.me.com [17.57.155.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39490187877
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709919; cv=none; b=bWdQeHdDQ1YmmP4sSd55WhdGea0xKH3JCJCl0DXUhTcxW5fjiNlXvd8AVUcdN0Xyx0LsZaqOsT2z/2fkvpFNrqS6SymAS0cQg+HwTUzKqcyLD/KN/pORIS8nb7nmkpIzcObTZgYFG9Qu2u5hrp4HA4CbVj0BPDBdgYxtjidAIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709919; c=relaxed/simple;
	bh=2R+kY0rY0WLGuu2XOqWf/QZNUo8aa25+L2FrjnuNe0E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TEQKX9e261CPkheoaGgpWQYYTKTaGashpPP/cnMqA79e4Z66LcKeThiOyJh87ZlIiWf5/WX7jVsAIqYcVRzRLSFU271fJ98JXLPGNmYtDSTpK07u0EoY+P/pTpNx+7LMWC48TYohVOH6QCutoZNxPcTJiaYkITwWLJDmM8fRUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=KHTS1x6o; arc=none smtp.client-ip=17.57.155.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730709915; bh=om/MxJvr+wJPPyUDuhFJvdOBcJWldF4A49saCa4xmzM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 x-icloud-hme;
	b=KHTS1x6ovgT5T0O3+kD6fZUu4Sd+VSjJ4TCytUAtuLtAjp0Y82QZrjy2d4SZE7X9M
	 CmVAttAKy1jULiXzmagrFvlcwMATSpVgbpNCG5ZunkjFlc4sM1O0B1drWACKcj6chm
	 tWuOQz+uGsvVySn38j9FZInzTcbdP/x6c92IdnrHpLg72vqyIyZjsLBXC5VrCl4Lgv
	 gpf3EniKgXfT9u/mQTrvFP265rvQBTITukvBo3HCXKVXztiWypRCrPxKEFolIXM0/2
	 7WoYiJ8QufLzWoev1JFpOZRt4tyu8peUg8S62KDUFn80re9WdBR6iejfrPOp7OacBa
	 ZkMJhC7NhfKJg==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071702.me.com (Postfix) with ESMTPSA id 3725D35002BA;
	Mon,  4 Nov 2024 08:45:11 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 11:45:07 +0300
Message-Id: <D5D9GJ58J6O8.2ELHVRYC8BH4J@verdict.gg>
Cc: <netdev@vger.kernel.org>, <dsahern@kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <linux-kselftest@vger.kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
 <horms@kernel.org>
Subject: Re: [PATCH v6] net: ipv4: Cache pmtu for all packet paths if
 multipath enabled
From: "Vladimir Vdovin" <deliran@verdict.gg>
To: "Ido Schimmel" <idosch@idosch.org>
X-Mailer: aerc 0.18.2
References: <20241102163000.2392-1-deliran@verdict.gg>
 <Zyd0_CaVTUKCkfqH@shredder>
In-Reply-To: <Zyd0_CaVTUKCkfqH@shredder>
X-Proofpoint-GUID: X1h3kZUvJ_d1oh2YboJo9bn269zVOvzZ
X-Proofpoint-ORIG-GUID: X1h3kZUvJ_d1oh2YboJo9bn269zVOvzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_03,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 mlxlogscore=999
 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411040050

On Sun Nov 3, 2024 at 4:05 PM MSK, Ido Schimmel wrote:
> Subject prefix should be "[PATCH net-next v6]" (v7 for next version,
> obviously)
>
> On Sat, Nov 02, 2024 at 04:29:35PM +0000, Vladimir Vdovin wrote:
> > Check number of paths by fib_info_num_path(),
> > and update_or_create_fnhe() for every path.
> > Problem is that pmtu is cached only for the oif
> > that has received icmp message "need to frag",
> > other oifs will still try to use "default" iface mtu.
> >=20
> > An example topology showing the problem:
> >=20
> >                     |  host1
> >                 +---------+
> >                 |  dummy0 | 10.179.20.18/32  mtu9000
> >                 +---------+
> >         +-----------+----------------+
> >     +---------+                     +---------+
> >     | ens17f0 |  10.179.2.141/31    | ens17f1 |  10.179.2.13/31
> >     +---------+                     +---------+
> >         |    (all here have mtu 9000)    |
> >     +------+                         +------+
> >     | ro1  |  10.179.2.140/31        | ro2  |  10.179.2.12/31
> >     +------+                         +------+
> >         |                                |
> > ---------+------------+-------------------+------
> >                         |
> >                     +-----+
> >                     | ro3 | 10.10.10.10  mtu1500
> >                     +-----+
> >                         |
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >                 some networks
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >                         |
> >                     +-----+
> >                     | eth0| 10.10.30.30  mtu9000
> >                     +-----+
> >                         |  host2
> >=20
> > host1 have enabled multipath and
> > sysctl net.ipv4.fib_multipath_hash_policy =3D 1:
> >=20
> > default proto static src 10.179.20.18
> >         nexthop via 10.179.2.12 dev ens17f1 weight 1
> >         nexthop via 10.179.2.140 dev ens17f0 weight 1
> >=20
> > When host1 tries to do pmtud from 10.179.20.18/32 to host2,
> > host1 receives at ens17f1 iface an icmp packet from ro3 that ro3 mtu=3D=
1500.
> > And host1 caches it in nexthop exceptions cache.
> >=20
> > Problem is that it is cached only for the iface that has received icmp,
> > and there is no way that ro3 will send icmp msg to host1 via another pa=
th.
> >=20
> > Host1 now have this routes to host2:
> >=20
> > ip r g 10.10.30.30 sport 30000 dport 443
> > 10.10.30.30 via 10.179.2.12 dev ens17f1 src 10.179.20.18 uid 0
> >     cache expires 521sec mtu 1500
> >=20
> > ip r g 10.10.30.30 sport 30033 dport 443
> > 10.10.30.30 via 10.179.2.140 dev ens17f0 src 10.179.20.18 uid 0
> >     cache
> >=20
> > So when host1 tries again to reach host2 with mtu>1500,
> > if packet flow is lucky enough to be hashed with oif=3Dens17f1 its ok,
> > if oif=3Dens17f0 it blackholes and still gets icmp msgs from ro3 to ens=
17f1,
> > until lucky day when ro3 will send it through another flow to ens17f0.
> >=20
> > Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> > ---
> >=20
> > V6:
> >   - make commit message cleaner
> >=20
> > V5:
> >   - make self test cleaner
> >=20
> > V4:
> >   - fix selftest, do route lookup before checking cached exceptions
> >=20
> > V3:
> >   - added selftest
> >   - fixed compile error
> >=20
> > V2:
> >   - fix fib_info_num_path parameter pass
> > ---
> >  net/ipv4/route.c                    | 13 +++++
> >  tools/testing/selftests/net/pmtu.sh | 78 ++++++++++++++++++++++++++++-
> >  2 files changed, 90 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index 723ac9181558..41162b5cc4cb 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -1027,6 +1027,19 @@ static void __ip_rt_update_pmtu(struct rtable *r=
t, struct flowi4 *fl4, u32 mtu)
> >  		struct fib_nh_common *nhc;
> > =20
> >  		fib_select_path(net, &res, fl4, NULL);
> > +#ifdef CONFIG_IP_ROUTE_MULTIPATH
> > +		if (fib_info_num_path(res.fi) > 1) {
> > +			int nhsel;
> > +
> > +			for (nhsel =3D 0; nhsel < fib_info_num_path(res.fi); nhsel++) {
> > +				nhc =3D fib_info_nhc(res.fi, nhsel);
> > +				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
> > +							  jiffies + net->ipv4.ip_rt_mtu_expires);
> > +			}
> > +			rcu_read_unlock();
> > +			return;
> > +		}
> > +#endif /* CONFIG_IP_ROUTE_MULTIPATH */
> >  		nhc =3D FIB_RES_NHC(res);
> >  		update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
> >  				      jiffies + net->ipv4.ip_rt_mtu_expires);
> > diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selfte=
sts/net/pmtu.sh
> > index 569bce8b6383..a0159340fe84 100755
> > --- a/tools/testing/selftests/net/pmtu.sh
> > +++ b/tools/testing/selftests/net/pmtu.sh
> > @@ -266,7 +266,8 @@ tests=3D"
> >  	list_flush_ipv4_exception	ipv4: list and flush cached exceptions	1
> >  	list_flush_ipv6_exception	ipv6: list and flush cached exceptions	1
> >  	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
> > -	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
> > +	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1
> > +	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions		0"
>
> There is misalignment in the last field ("re-run with nh") and I think
> it should be "1" in order to exercise this path with both legacy
> nexthops and nexthop objects. See more below.
>
> In addition, this test case is missing documentation at the beginning of
> the file.
>
> I also believe we have a problem with IPv6, but I will look into it when
> I have time and add a test case.
Forgot to mention, its not hard for me to add IPv6 tests, but not sure
if it should be included in this patch in case some ipv6 fixes will be need=
ed.

In my opinion, it may be easier to add IPv6 test and(or not) ipv6 fixes,
when(if) this patch will be accepted
>
> > =20
> >  # Addressing and routing for tests with routers: four network segments=
, with
> >  # index SEGMENT between 1 and 4, a common prefix (PREFIX4 or PREFIX6) =
and an
> > @@ -2329,6 +2330,81 @@ test_pmtu_ipv6_route_change() {
> >  	test_pmtu_ipvX_route_change 6
> >  }
> > =20
> > +test_pmtu_ipv4_mp_exceptions() {
> > +	setup namespaces routing || return $ksft_skip
> > +
> > +	ip nexthop ls >/dev/null 2>&1
> > +	if [ $? -ne 0 ]; then
> > +		echo "Nexthop objects not supported; skipping tests"
> > +		exit $ksft_skip
> > +	fi
>
> Whether nexthop objects are supported or not is stored in "HAVE_NH" and
> there is no need for this check here if you add setup_mp() like I
> suggest below.
>
> > +
> > +	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
> > +	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
> > +	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
> > +	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
> > +
> > +	dummy0_a=3D"192.168.99.99"
> > +	dummy0_b=3D"192.168.88.88"
> > +
> > +	# Set up initial MTU values
> > +	mtu "${ns_a}"  veth_A-R1 2000
> > +	mtu "${ns_r1}" veth_R1-A 2000
> > +	mtu "${ns_r1}" veth_R1-B 1500
> > +	mtu "${ns_b}"  veth_B-R1 1500
>
> According to the documentation at the beginning of the file, the MTU
> between B and R1 is 1400. See other test cases.
>
> > +
> > +	mtu "${ns_a}"  veth_A-R2 2000
> > +	mtu "${ns_r2}" veth_R2-A 2000
> > +	mtu "${ns_r2}" veth_R2-B 1500
> > +	mtu "${ns_b}"  veth_B-R2 1500
> > +
> > +	fail=3D0
> > +
> > +	#Set up host A with multipath routes to host B dummy0_b
>          ^ Missing space after '#'. Same in other places.
>
> > +	run_cmd ${ns_a} sysctl -q net.ipv4.fib_multipath_hash_policy=3D1
>
> The test only uses ICMP, so hash policy can be L3 (0). Same for B.
>
> > +	run_cmd ${ns_a} sysctl -q net.ipv4.ip_forward=3D1
>
> It's a host, so no need to enable forwarding.
>
> > +	run_cmd ${ns_a} ip link add dummy0 mtu 2000 type dummy
> > +	run_cmd ${ns_a} ip link set dummy0 up
>
> Can't you simply add the address on the loopback device instead of
> creating a dummy netdev?
>
> > +	run_cmd ${ns_a} ip addr add ${dummy0_a} dev dummy0
> > +	run_cmd ${ns_a} ip nexthop add id 201 via ${prefix4}.${a_r1}.2 dev ve=
th_A-R1
> > +	run_cmd ${ns_a} ip nexthop add id 202 via ${prefix4}.${a_r2}.2 dev ve=
th_A-R2
> > +	run_cmd ${ns_a} ip nexthop add id 203 group 201/202
> > +	run_cmd ${ns_a} ip route add ${dummy0_b} nhid 203
>
> It would be good to test this with legacy nexthops as well. I'm not that
> familiar with pmtu.sh, but I think you can add a "setup_mp" function and
> invoke it via "setup namespaces routing mp [...]" at the beginning of
> the function.
>
> Internally, setup_mp() will consult "USE_NH" and invoke setup_mp_old()
> or setup_mp_new() accordingly, like setup_routing() does.
>
> > +
> > +	#Set up host B with multipath routes to host A dummy0_a
> > +	run_cmd ${ns_b} sysctl -q net.ipv4.fib_multipath_hash_policy=3D1
> > +	run_cmd ${ns_b} sysctl -q net.ipv4.ip_forward=3D1
> > +	run_cmd ${ns_b} ip link add dummy0 mtu 2000 type dummy
> > +	run_cmd ${ns_b} ip link set dummy0 up
> > +	run_cmd ${ns_b} ip addr add ${dummy0_b} dev dummy0
> > +	run_cmd ${ns_b} ip nexthop add id 201 via ${prefix4}.${b_r1}.2 dev ve=
th_A-R1
> > +	run_cmd ${ns_b} ip nexthop add id 202 via ${prefix4}.${b_r2}.2 dev ve=
th_A-R2
> > +	run_cmd ${ns_b} ip nexthop add id 203 group 201/202
> > +	run_cmd ${ns_b} ip route add ${dummy0_a} nhid 203
> > +
> > +	#Set up routers with routes to dummies
> > +	run_cmd ${ns_r1} ip route add ${dummy0_a} via ${prefix4}.${a_r1}.1
> > +	run_cmd ${ns_r2} ip route add ${dummy0_a} via ${prefix4}.${a_r2}.1
> > +	run_cmd ${ns_r1} ip route add ${dummy0_b} via ${prefix4}.${b_r1}.1
> > +	run_cmd ${ns_r2} ip route add ${dummy0_b} via ${prefix4}.${b_r2}.1
> > +
> > +
> > +	#Ping and expect two nexthop exceptions for two routes in nh group
> > +	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 2 -s 1800 "${dummy0_b}"
>
> '-c 1' should be enough
>
> > +
> > +	#Do route lookup before checking cached exceptions
>
> IIUC, previous command created an exception in both nexthops. The
> following commands are needed so that a dst entry will be cached in both
> exceptions and therefore be dumped below to user space. If so, please
> adjust the comment to reflect that.
>
> > +	run_cmd ${ns_a} ip route get ${dummy0_b} oif veth_A-R1
> > +	run_cmd ${ns_a} ip route get ${dummy0_b} oif veth_A-R2
> > +
> > +	#Check cached exceptions
> > +	if [ "$(${ns_a} ip -oneline route list cache| grep mtu | wc -l)" -ne =
2 ]; then
>                                                    ^ Missing space before=
 the pipe
>
>
> > +		err "  there are not enough cached exceptions"
> > +		fail=3D1
> > +	fi
> > +
> > +	return ${fail}
> > +}
> > +
> >  usage() {
> >  	echo
> >  	echo "$0 [OPTIONS] [TEST]..."
> >=20
> > base-commit: 66600fac7a984dea4ae095411f644770b2561ede
> > --=20
> > 2.43.5
> >=20


