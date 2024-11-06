Return-Path: <linux-kselftest+bounces-21535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5196E9BEF0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 14:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A961C23E05
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720341E1C0A;
	Wed,  6 Nov 2024 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="Coc8RrTr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from qs51p00im-qukt01072101.me.com (qs51p00im-qukt01072101.me.com [17.57.155.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A71E0B7A
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899775; cv=none; b=geaWTsboy7dK/iBZUJ+hbYKvg0M1L6UTKwmgJrw323/LxFrEmqL+AdzqeDncHMpMjIsh3mNKfWu5shbCpYqoG/OyTgrR/dx8Z/cixHh3axpMdmoPmEJ0kba8S4Qcz6lrweCG7kb60qgFiA+eSS5AS74GVx0nBMeHpiCn2LPXUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899775; c=relaxed/simple;
	bh=T+lUVe/eI0A/faFpF/5XVxIE74XZ633rTYTqvV9EHVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=IpecEEGY6d4N7Gs+3/zfAa53WZk7imiRvnvK3LeDKrugq+/FOU9ILB0E3x3cMg/us/kTC8ht4lN34bMHnZvU2h8WAa3ZWSzpLHyGq29tIJDB9GXY9ecifsf5s55PbrFYejIwn8L3gKVcCn6o63EDSBij3G14+GTO8KlJTuPlT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=Coc8RrTr; arc=none smtp.client-ip=17.57.155.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730899770; bh=nr3/YS3Py3MrrKnD6Hdl8Ca6gvfpive4hM5oqIP/Zr8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 x-icloud-hme;
	b=Coc8RrTrJnAD5c43qqCBUK43DD73Nz76sbd4x44MwbCAedIklwCoZKHlfZ7BDK5Re
	 v7af1rUExPj03uKJyIoGKvFHV5qRfpritVSnSQzEo7Q/4SOAWeP59v8w1uFssRcZnA
	 S0c54BM1IA0lKgpKJ9pG3a3DVbBbDYGPbQeTLgisbQgI0S7fy929XgYPpChaCbq2RT
	 7oZEVg8hx8zYqh+f5wVZbPep2KMU7AFAcNORzwjXQRWn2Akfsmp+0qzPCjCW4jy+DU
	 uPqH9IBilqDtCgicUFFapHNXMHcWe8JGCsK0N81V+M0hiAx7PrRfy4dIcnTKm/oceS
	 Lzy2vJ8szgvbQ==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072101.me.com (Postfix) with ESMTPSA id 81E66403CE;
	Wed,  6 Nov 2024 13:29:26 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Nov 2024 16:29:23 +0300
Message-Id: <D5F4RA6KPUIW.2UOHDT1G4Z6F@verdict.gg>
To: "Ido Schimmel" <idosch@idosch.org>, <gnault@redhat.com>
Cc: <netdev@vger.kernel.org>, <dsahern@kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <linux-kselftest@vger.kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
 <horms@kernel.org>
Subject: Re: [PATCH net-next v7] net: ipv4: Cache pmtu for all packet paths
 if multipath enabled
From: "Vladimir Vdovin" <deliran@verdict.gg>
X-Mailer: aerc 0.18.2
References: <20241104072753.77042-1-deliran@verdict.gg>
 <ZykH_fdcMBdFgXix@shredder>
In-Reply-To: <ZykH_fdcMBdFgXix@shredder>
X-Proofpoint-GUID: pJ7eIthWh3rnfSLCCFQOOV5nak118080
X-Proofpoint-ORIG-GUID: pJ7eIthWh3rnfSLCCFQOOV5nak118080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_07,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1030 mlxscore=0 bulkscore=0
 mlxlogscore=722 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411060109

Thanks for your detailed review, sending v8 patch to summerize all changes

On Mon Nov 4, 2024 at 8:44 PM MSK, Ido Schimmel wrote:
> + Guillaume:
> please see comment below about route_get_dst_pmtu_from_exception())
> Original patch:
> https://lore.kernel.org/netdev/20241104072753.77042-1-deliran@verdict.gg/
>
> On Mon, Nov 04, 2024 at 07:27:50AM +0000, Vladimir Vdovin wrote:
> > diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selfte=
sts/net/pmtu.sh
> > index 569bce8b6383..f24c84184c61 100755
> > --- a/tools/testing/selftests/net/pmtu.sh
> > +++ b/tools/testing/selftests/net/pmtu.sh
> > @@ -197,6 +197,12 @@
> >  #
> >  # - pmtu_ipv6_route_change
> >  #	Same as above but with IPv6
> > +#
> > +# - pmtu_ipv4_mp_exceptions
> > +#	Use the same topology as in pmtu_ipv4, but add routeable "dummy"
>
> No need for "dummy" as these are regular addresses on the loopback
> device
>
> > +#	addresses on host A and B on lo0 reachable via both routers.
>
> There is no "lo0" device. Only "lo". Run with "-v" and you will see a
> lot of errors
>
> > +#	Host A and B "dummy" addresses have multipath routes to each other.
> > +#	Check that PMTU exceptions are created for both paths.
> > =20
> >  source lib.sh
> >  source net_helper.sh
> > @@ -266,7 +272,8 @@ tests=3D"
> >  	list_flush_ipv4_exception	ipv4: list and flush cached exceptions	1
> >  	list_flush_ipv6_exception	ipv6: list and flush cached exceptions	1
> >  	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
> > -	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
> > +	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1
> > +	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions	1"
> > =20
> >  # Addressing and routing for tests with routers: four network segments=
, with
> >  # index SEGMENT between 1 and 4, a common prefix (PREFIX4 or PREFIX6) =
and an
> > @@ -343,6 +350,9 @@ tunnel6_a_addr=3D"fd00:2::a"
> >  tunnel6_b_addr=3D"fd00:2::b"
> >  tunnel6_mask=3D"64"
> > =20
> > +dummy4_a_addr=3D"192.168.99.99"
> > +dummy4_b_addr=3D"192.168.88.88"
>
> Let's change to "host4_a_addr" and "host4_b_addr" (or similar) as we are
> no longer using a dummy device
>
> > +
> >  dummy6_0_prefix=3D"fc00:1000::"
> >  dummy6_1_prefix=3D"fc00:1001::"
> >  dummy6_mask=3D"64"
> > @@ -984,6 +994,50 @@ setup_ovs_bridge() {
> >  	run_cmd ip route add ${prefix6}:${b_r1}::1 via ${prefix6}:${a_r1}::2
> >  }
> > =20
> > +setup_multipath() {
> > +	if [ "$USE_NH" =3D "yes" ]; then
> > +		setup_multipath_new
> > +	else
> > +		setup_multipath_old
> > +	fi
>
> Please move setup_multipath_{new,old}() before setup_multipath() like
> setup_routing() and related functions
>
> > +
> > +	# Set up routers with routes to dummies
> > +	run_cmd ${ns_r1} ip route add ${dummy4_a_addr} via ${prefix4}.${a_r1}=
.1
> > +	run_cmd ${ns_r2} ip route add ${dummy4_a_addr} via ${prefix4}.${a_r2}=
.1
> > +	run_cmd ${ns_r1} ip route add ${dummy4_b_addr} via ${prefix4}.${b_r1}=
.1
> > +	run_cmd ${ns_r2} ip route add ${dummy4_b_addr} via ${prefix4}.${b_r2}=
.1
> > +}
> > +
> > +setup_multipath_new() {
> > +	# Set up host A with multipath routes to host B dummy4_b_addr
> > +	run_cmd ${ns_a} ip addr add ${dummy4_a_addr} dev lo0
>
> s/lo0/lo/ same in other places
>
> > +	run_cmd ${ns_a} ip nexthop add id 201 via ${prefix4}.${a_r1}.2 dev ve=
th_A-R1
> > +	run_cmd ${ns_a} ip nexthop add id 202 via ${prefix4}.${a_r2}.2 dev ve=
th_A-R2
> > +	run_cmd ${ns_a} ip nexthop add id 203 group 201/202
> > +	run_cmd ${ns_a} ip route add ${dummy4_b_addr} nhid 203
>
> Maybe number the nexthops 401..403 so that we can later use 601..603 for
> IPv6 like $routes_nh is doing
>
> > +
> > +	# Set up host B with multipath routes to host A dummy4_a_addr
> > +	run_cmd ${ns_b} ip addr add ${dummy4_b_addr} dev lo0
> > +	run_cmd ${ns_b} ip nexthop add id 201 via ${prefix4}.${b_r1}.2 dev ve=
th_A-R1
>
> s/veth_A-R1/veth_B-R1/
>
> > +	run_cmd ${ns_b} ip nexthop add id 202 via ${prefix4}.${b_r2}.2 dev ve=
th_A-R2
>
> s/veth_A-R2/veth_B-R2/
>
> > +	run_cmd ${ns_b} ip nexthop add id 203 group 201/202
> > +	run_cmd ${ns_b} ip route add ${dummy4_a_addr} nhid 203
> > +}
> > +
> > +setup_multipath_old() {
> > +	# Set up host A with multipath routes to host B dummy4_b_addr
> > +	run_cmd ${ns_a} ip addr add ${dummy4_a_addr} dev lo0
> > +	run_cmd ${ns_a} ip route add ${dummy4_b_addr} \
> > +			nexthop via ${prefix4}.${a_r1}.2 weight 1 \
> > +			nexthop via ${prefix4}.${a_r2}.2 weight 1
> > +
> > +	# Set up host B with multipath routes to host A dummy4_a_addr
> > +	run_cmd ${ns_b} ip addr add ${dummy4_b_addr} dev lo0
> > +	run_cmd ${ns_a} ip route add ${dummy4_a_addr} \
>
> s/ns_a/ns_b/
>
> > +			nexthop via ${prefix4}.${a_b1}.2 weight 1 \
>
> s/a_b1/b_r1/
>
> > +			nexthop via ${prefix4}.${a_b2}.2 weight 1
>
> s/a_b2/b_r2/
>
> > +}
> > +
> >  setup() {
> >  	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_=
skip
> > =20
> > @@ -2329,6 +2383,45 @@ test_pmtu_ipv6_route_change() {
> >  	test_pmtu_ipvX_route_change 6
> >  }
> > =20
> > +test_pmtu_ipv4_mp_exceptions() {
> > +	setup namespaces routing multipath || return $ksft_skip
> > +
> > +	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
> > +	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
> > +	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
> > +	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
> > +
> > +	# Set up initial MTU values
> > +	mtu "${ns_a}"  veth_A-R1 2000
> > +	mtu "${ns_r1}" veth_R1-A 2000
> > +	mtu "${ns_r1}" veth_R1-B 1400
> > +	mtu "${ns_b}"  veth_B-R1 1400
> > +
> > +	mtu "${ns_a}"  veth_A-R2 2000
> > +	mtu "${ns_r2}" veth_R2-A 2000
> > +	mtu "${ns_r2}" veth_R2-B 1500
> > +	mtu "${ns_b}"  veth_B-R2 1500
> > +
> > +	fail=3D0
> > +
> > +	# Ping and expect two nexthop exceptions for two routes in nh group
> > +	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${dummy4_b_addr}=
"
> > +
>
> I looked more into pmtu.sh and this hunk from here ...
>
> > +	# Do route lookup before checking cached exceptions.
> > +	# The following commands are needed for dst entries to be cached
> > +	# in both paths exceptions and therefore dumped to user space
> > +	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R1
> > +	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R2
> > +
> > +	# Check cached exceptions
> > +	if [ "$(${ns_a} ip -oneline route list cache | grep mtu | wc -l)" -ne=
 2 ]; then
> > +		err "  there are not enough cached exceptions"
> > +		fail=3D1
> > +	fi
>
> ... until here can be replaced by route_get_dst_pmtu_from_exception() and
> check_pmtu_value() like in other test cases. There are two
> prerequisites:
>
> 1. We should set the same MTU in both paths as otherwise we don't know
> which MTU will be cached and what to pass to check_pmtu_value() as the
> expected value. I did see that check_pmtu_value() accepts "any", but I
> think it's better to check for a specific value.
>
> 2. route_get_dst_pmtu_from_exception() is not very flexible in the
> keywords it accepts for "ip route get" and we need to pass "oif". It can
> be solved by [1] (please test), but Guillaume might have a better idea.
> Then, the above hunk can be replaced by [2].
>
> [1]
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftest=
s/net/pmtu.sh
> index 569bce8b6383..6e790d38e5d9 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -1076,23 +1076,15 @@ link_get_mtu() {
>  }
> =20
>  route_get_dst_exception() {
> -	ns_cmd=3D"${1}"
> -	dst=3D"${2}"
> -	dsfield=3D"${3}"
> -
> -	if [ -z "${dsfield}" ]; then
> -		dsfield=3D0
> -	fi
> +	ns_cmd=3D"${1}"; shift
> =20
> -	${ns_cmd} ip route get "${dst}" dsfield "${dsfield}"
> +	${ns_cmd} ip route get "$@"
>  }
> =20
>  route_get_dst_pmtu_from_exception() {
> -	ns_cmd=3D"${1}"
> -	dst=3D"${2}"
> -	dsfield=3D"${3}"
> +	ns_cmd=3D"${1}"; shift
> =20
> -	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "${dst}" "${dsfield}")=
"
> +	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "$@")"
>  }
> =20
>  check_pmtu_value() {
> @@ -1235,10 +1227,10 @@ test_pmtu_ipv4_dscp_icmp_exception() {
>  	run_cmd "${ns_a}" ping -q -M want -Q "${dsfield}" -c 1 -w 1 -s "${len}"=
 "${dst2}"
> =20
>  	# Check that exceptions have been created with the correct PMTU
> -	pmtu_1=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${po=
licy_mark}")"
> +	pmtu_1=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst1} dsfield=
 ${policy_mark})"
>  	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
> =20
> -	pmtu_2=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${po=
licy_mark}")"
> +	pmtu_2=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst2} dsfield=
 ${policy_mark})"
>  	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
>  }
> =20
> @@ -1285,9 +1277,9 @@ test_pmtu_ipv4_dscp_udp_exception() {
>  		UDP:"${dst2}":50000,tos=3D"${dsfield}"
> =20
>  	# Check that exceptions have been created with the correct PMTU
> -	pmtu_1=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${po=
licy_mark}")"
> +	pmtu_1=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst1} dsfield=
 ${policy_mark})"
>  	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
> -	pmtu_2=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${po=
licy_mark}")"
> +	pmtu_2=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst2} dsfield=
 ${policy_mark})"
>  	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
>  }
>
> [2]
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftest=
s/net/pmtu.sh
> index a3c3f7f99e5b..10b8ac2d7f47 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -2399,19 +2399,11 @@ test_pmtu_ipv4_mp_exceptions() {
>  	# Ping and expect two nexthop exceptions for two routes in nh group
>  	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${dummy4_b_addr}"
> =20
> -	# Do route lookup before checking cached exceptions.
> -	# The following commands are needed for dst entries to be cached
> -	# in both paths exceptions and therefore dumped to user space
> -	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R1
> -	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R2
> -
> -	# Check cached exceptions
> -	if [ "$(${ns_a} ip -oneline route list cache | grep mtu | wc -l)" -ne 2=
 ]; then
> -		err "  there are not enough cached exceptions"
> -		fail=3D1
> -	fi
> -
> -	return ${fail}
> +	# Check that exceptions have been created with the correct PMTU
> +	pmtu=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" ${dummy4_b_addr} =
oif veth_A-R1)"
> +	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R1)" || return=
 1
> +	pmtu=3D"$(route_get_dst_pmtu_from_exception "${ns_a}" ${dummy4_b_addr} =
oif veth_A-R2)"
> +	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R2)" || return=
 1
>  }
> =20
>  usage() {


