Return-Path: <linux-kselftest+bounces-21391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A379BBC3D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E785B28236D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0091C7299;
	Mon,  4 Nov 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RUIb+xha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B41C4A1F;
	Mon,  4 Nov 2024 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742277; cv=none; b=omWsK9DlcDN/xeomnJKuIDH5qlENAA6E598K7J06mu1oWkX3XRxQQealXC6AXHapxLoujNyBto1/B65QJRuS99FOS6DeTSQB5q76o6MgRScez/PQGhlHCzue1LUcAV7Y5eGXdm6GaFxBygb++svVCvxHSn8uHbZ847/5q41tdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742277; c=relaxed/simple;
	bh=nFwMZD35ZHDGSw9Mot+P8ViMcWQB0vVKQKFml7+83Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL4V8eUPaXc4y3PAvf6+UzMExOC6D5wuUkbuTYs6pECKfkvqJ6KhVG8GpU2zMIL+hMx7mCG2YI+xpyua37JKB8wI+8md5R6v+JJ/hEg22IdIJc/CiNaI+FcBmCeLcIxtl2EmNdKuZsmC6xXjTkb7B+kdn2+ICiWXMsPl57TqDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RUIb+xha; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2DEB2540161;
	Mon,  4 Nov 2024 12:44:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 04 Nov 2024 12:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730742273; x=1730828673; bh=h3Em+6aJA42FMwSayWFURujGkOQLVd60YfO
	be9BVCvA=; b=RUIb+xha10s50uVsKiOeLqFSKrt+87FvSLBcAg7VUQoyDm7bzSq
	IoFHsnkQQdRPsvMCETgPVG3NR4AuCcs6Q1CJCxDMDF3VR8T+mA7g9UnIhpSQZcEA
	0JB99tpPb2k7uYweoTcX+3Kjr99K7wwq7nGtIsidezG5XuHwIq9Ihbqhvh2l2Sxp
	UPM6MdV0lT5irP3acOCBYOug4mMiedhtjyZ5+VFkHTWy8gdOnKew4y58emiKKr2i
	BaES2nCCVsRyFDxM4Bx5nqqA781PG8O+HlhIWGfjQ/jPsBgpljchWbUej8C2FtnV
	49yWUt5ZyaTc1O4GBNKW8Ayd7w4rQu0+uOA==
X-ME-Sender: <xms:_wcpZ82s-AxX0GLL7YpbL8BYd106acs15kj975e_ib7e680stdoYhA>
    <xme:_wcpZ3HdE0zNrDI0FuxdaJhcyMjWVinoDu9_UEvdkSwEwsxonv6q_oI5p3lsMbLlU
    iZmabnF9-dLQ1E>
X-ME-Received: <xmr:_wcpZ04n9VbXH2q7EJ1cfu6zxH6fGEXv-ymQk5tKgbc_D4V919IQhqvpmwrH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghl
    uceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvghrnhephefhtd
    ejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfhjeeknecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvlhhirhgrnhesvh
    gvrhguihgtthdrghhgpdhrtghpthhtohepghhnrghulhhtsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegu
    rghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:_wcpZ108fWxhO70h8joEaO_vvoWUg-jKUa1aa4bLvxu22j3PX-qRjg>
    <xmx:AAgpZ_EFjj0u-aF7Bz7E3KihJMPezGOMdKkRwcqHilMjKghihySRWQ>
    <xmx:AAgpZ--p4cfu6ntE0jjOZhOc4aj4OfQvoobNeClTNLLA3h8YpBxUKQ>
    <xmx:AAgpZ0mmszZk2beHDEwMJOiZBzPgWBSgL7ulkMRUD5yfrNv-6OXAbQ>
    <xmx:AQgpZ3_2tV5pbhOUEh0bkw5PMro6-0VY0D4WtLVTN3CX-XPY1eV9Xa1H>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 12:44:31 -0500 (EST)
Date: Mon, 4 Nov 2024 19:44:29 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Vladimir Vdovin <deliran@verdict.gg>, gnault@redhat.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, linux-kselftest@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	horms@kernel.org
Subject: Re: [PATCH net-next v7] net: ipv4: Cache pmtu for all packet paths
 if multipath enabled
Message-ID: <ZykH_fdcMBdFgXix@shredder>
References: <20241104072753.77042-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104072753.77042-1-deliran@verdict.gg>

+ Guillaume:
please see comment below about route_get_dst_pmtu_from_exception())
Original patch:
https://lore.kernel.org/netdev/20241104072753.77042-1-deliran@verdict.gg/

On Mon, Nov 04, 2024 at 07:27:50AM +0000, Vladimir Vdovin wrote:
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> index 569bce8b6383..f24c84184c61 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -197,6 +197,12 @@
>  #
>  # - pmtu_ipv6_route_change
>  #	Same as above but with IPv6
> +#
> +# - pmtu_ipv4_mp_exceptions
> +#	Use the same topology as in pmtu_ipv4, but add routeable "dummy"

No need for "dummy" as these are regular addresses on the loopback
device

> +#	addresses on host A and B on lo0 reachable via both routers.

There is no "lo0" device. Only "lo". Run with "-v" and you will see a
lot of errors

> +#	Host A and B "dummy" addresses have multipath routes to each other.
> +#	Check that PMTU exceptions are created for both paths.
>  
>  source lib.sh
>  source net_helper.sh
> @@ -266,7 +272,8 @@ tests="
>  	list_flush_ipv4_exception	ipv4: list and flush cached exceptions	1
>  	list_flush_ipv6_exception	ipv6: list and flush cached exceptions	1
>  	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
> -	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
> +	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1
> +	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions	1"
>  
>  # Addressing and routing for tests with routers: four network segments, with
>  # index SEGMENT between 1 and 4, a common prefix (PREFIX4 or PREFIX6) and an
> @@ -343,6 +350,9 @@ tunnel6_a_addr="fd00:2::a"
>  tunnel6_b_addr="fd00:2::b"
>  tunnel6_mask="64"
>  
> +dummy4_a_addr="192.168.99.99"
> +dummy4_b_addr="192.168.88.88"

Let's change to "host4_a_addr" and "host4_b_addr" (or similar) as we are
no longer using a dummy device

> +
>  dummy6_0_prefix="fc00:1000::"
>  dummy6_1_prefix="fc00:1001::"
>  dummy6_mask="64"
> @@ -984,6 +994,50 @@ setup_ovs_bridge() {
>  	run_cmd ip route add ${prefix6}:${b_r1}::1 via ${prefix6}:${a_r1}::2
>  }
>  
> +setup_multipath() {
> +	if [ "$USE_NH" = "yes" ]; then
> +		setup_multipath_new
> +	else
> +		setup_multipath_old
> +	fi

Please move setup_multipath_{new,old}() before setup_multipath() like
setup_routing() and related functions

> +
> +	# Set up routers with routes to dummies
> +	run_cmd ${ns_r1} ip route add ${dummy4_a_addr} via ${prefix4}.${a_r1}.1
> +	run_cmd ${ns_r2} ip route add ${dummy4_a_addr} via ${prefix4}.${a_r2}.1
> +	run_cmd ${ns_r1} ip route add ${dummy4_b_addr} via ${prefix4}.${b_r1}.1
> +	run_cmd ${ns_r2} ip route add ${dummy4_b_addr} via ${prefix4}.${b_r2}.1
> +}
> +
> +setup_multipath_new() {
> +	# Set up host A with multipath routes to host B dummy4_b_addr
> +	run_cmd ${ns_a} ip addr add ${dummy4_a_addr} dev lo0

s/lo0/lo/ same in other places

> +	run_cmd ${ns_a} ip nexthop add id 201 via ${prefix4}.${a_r1}.2 dev veth_A-R1
> +	run_cmd ${ns_a} ip nexthop add id 202 via ${prefix4}.${a_r2}.2 dev veth_A-R2
> +	run_cmd ${ns_a} ip nexthop add id 203 group 201/202
> +	run_cmd ${ns_a} ip route add ${dummy4_b_addr} nhid 203

Maybe number the nexthops 401..403 so that we can later use 601..603 for
IPv6 like $routes_nh is doing

> +
> +	# Set up host B with multipath routes to host A dummy4_a_addr
> +	run_cmd ${ns_b} ip addr add ${dummy4_b_addr} dev lo0
> +	run_cmd ${ns_b} ip nexthop add id 201 via ${prefix4}.${b_r1}.2 dev veth_A-R1

s/veth_A-R1/veth_B-R1/

> +	run_cmd ${ns_b} ip nexthop add id 202 via ${prefix4}.${b_r2}.2 dev veth_A-R2

s/veth_A-R2/veth_B-R2/

> +	run_cmd ${ns_b} ip nexthop add id 203 group 201/202
> +	run_cmd ${ns_b} ip route add ${dummy4_a_addr} nhid 203
> +}
> +
> +setup_multipath_old() {
> +	# Set up host A with multipath routes to host B dummy4_b_addr
> +	run_cmd ${ns_a} ip addr add ${dummy4_a_addr} dev lo0
> +	run_cmd ${ns_a} ip route add ${dummy4_b_addr} \
> +			nexthop via ${prefix4}.${a_r1}.2 weight 1 \
> +			nexthop via ${prefix4}.${a_r2}.2 weight 1
> +
> +	# Set up host B with multipath routes to host A dummy4_a_addr
> +	run_cmd ${ns_b} ip addr add ${dummy4_b_addr} dev lo0
> +	run_cmd ${ns_a} ip route add ${dummy4_a_addr} \

s/ns_a/ns_b/

> +			nexthop via ${prefix4}.${a_b1}.2 weight 1 \

s/a_b1/b_r1/

> +			nexthop via ${prefix4}.${a_b2}.2 weight 1

s/a_b2/b_r2/

> +}
> +
>  setup() {
>  	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_skip
>  
> @@ -2329,6 +2383,45 @@ test_pmtu_ipv6_route_change() {
>  	test_pmtu_ipvX_route_change 6
>  }
>  
> +test_pmtu_ipv4_mp_exceptions() {
> +	setup namespaces routing multipath || return $ksft_skip
> +
> +	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
> +	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
> +	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
> +	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
> +
> +	# Set up initial MTU values
> +	mtu "${ns_a}"  veth_A-R1 2000
> +	mtu "${ns_r1}" veth_R1-A 2000
> +	mtu "${ns_r1}" veth_R1-B 1400
> +	mtu "${ns_b}"  veth_B-R1 1400
> +
> +	mtu "${ns_a}"  veth_A-R2 2000
> +	mtu "${ns_r2}" veth_R2-A 2000
> +	mtu "${ns_r2}" veth_R2-B 1500
> +	mtu "${ns_b}"  veth_B-R2 1500
> +
> +	fail=0
> +
> +	# Ping and expect two nexthop exceptions for two routes in nh group
> +	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${dummy4_b_addr}"
> +

I looked more into pmtu.sh and this hunk from here ...

> +	# Do route lookup before checking cached exceptions.
> +	# The following commands are needed for dst entries to be cached
> +	# in both paths exceptions and therefore dumped to user space
> +	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R1
> +	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R2
> +
> +	# Check cached exceptions
> +	if [ "$(${ns_a} ip -oneline route list cache | grep mtu | wc -l)" -ne 2 ]; then
> +		err "  there are not enough cached exceptions"
> +		fail=1
> +	fi

... until here can be replaced by route_get_dst_pmtu_from_exception() and
check_pmtu_value() like in other test cases. There are two
prerequisites:

1. We should set the same MTU in both paths as otherwise we don't know
which MTU will be cached and what to pass to check_pmtu_value() as the
expected value. I did see that check_pmtu_value() accepts "any", but I
think it's better to check for a specific value.

2. route_get_dst_pmtu_from_exception() is not very flexible in the
keywords it accepts for "ip route get" and we need to pass "oif". It can
be solved by [1] (please test), but Guillaume might have a better idea.
Then, the above hunk can be replaced by [2].

[1]
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 569bce8b6383..6e790d38e5d9 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1076,23 +1076,15 @@ link_get_mtu() {
 }
 
 route_get_dst_exception() {
-	ns_cmd="${1}"
-	dst="${2}"
-	dsfield="${3}"
-
-	if [ -z "${dsfield}" ]; then
-		dsfield=0
-	fi
+	ns_cmd="${1}"; shift
 
-	${ns_cmd} ip route get "${dst}" dsfield "${dsfield}"
+	${ns_cmd} ip route get "$@"
 }
 
 route_get_dst_pmtu_from_exception() {
-	ns_cmd="${1}"
-	dst="${2}"
-	dsfield="${3}"
+	ns_cmd="${1}"; shift
 
-	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "${dst}" "${dsfield}")"
+	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "$@")"
 }
 
 check_pmtu_value() {
@@ -1235,10 +1227,10 @@ test_pmtu_ipv4_dscp_icmp_exception() {
 	run_cmd "${ns_a}" ping -q -M want -Q "${dsfield}" -c 1 -w 1 -s "${len}" "${dst2}"
 
 	# Check that exceptions have been created with the correct PMTU
-	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
+	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst1} dsfield ${policy_mark})"
 	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
 
-	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
+	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst2} dsfield ${policy_mark})"
 	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
 }
 
@@ -1285,9 +1277,9 @@ test_pmtu_ipv4_dscp_udp_exception() {
 		UDP:"${dst2}":50000,tos="${dsfield}"
 
 	# Check that exceptions have been created with the correct PMTU
-	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
+	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst1} dsfield ${policy_mark})"
 	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
-	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
+	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst2} dsfield ${policy_mark})"
 	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
 }

[2]
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index a3c3f7f99e5b..10b8ac2d7f47 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -2399,19 +2399,11 @@ test_pmtu_ipv4_mp_exceptions() {
 	# Ping and expect two nexthop exceptions for two routes in nh group
 	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${dummy4_b_addr}"
 
-	# Do route lookup before checking cached exceptions.
-	# The following commands are needed for dst entries to be cached
-	# in both paths exceptions and therefore dumped to user space
-	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R1
-	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R2
-
-	# Check cached exceptions
-	if [ "$(${ns_a} ip -oneline route list cache | grep mtu | wc -l)" -ne 2 ]; then
-		err "  there are not enough cached exceptions"
-		fail=1
-	fi
-
-	return ${fail}
+	# Check that exceptions have been created with the correct PMTU
+	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dummy4_b_addr} oif veth_A-R1)"
+	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R1)" || return 1
+	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dummy4_b_addr} oif veth_A-R2)"
+	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R2)" || return 1
 }
 
 usage() {

