Return-Path: <linux-kselftest+bounces-29391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B99FAA68072
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 00:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B315C19C06DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD320897A;
	Tue, 18 Mar 2025 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Gwb7Vcps";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="VmOi1ol5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06D2066D6;
	Tue, 18 Mar 2025 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339250; cv=none; b=q+hEtpixdJEYdr4zDcVNhHm3RHV7jLxgQPY8pDJxh89lkpU8a99WfXOu4yVRYpNCVVrr9vyxJyu5xd6+cw5fBUr9V724WKVmsqyhsOTbsz1/XHAkUKl5DZZP8hut13TKE/20Tm1lOIuYCjk55LHrq1qgLcmvlld65bpMx8reh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339250; c=relaxed/simple;
	bh=9kP2VUa1B6ZrmUIz57sX1FjbwUSsKOgNiqvAqqRtzT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaIHYWLldiGaPM6NaU52nrYJStOrn0S8vwONaZNNxyin4MYz1qZIXnerQM/pC4uyd6yIW7gaweN8ozW2ulWH+spL4bdNBqcXjj55PHu4MujGTo1IP75JVvzOGTORMLmLixJKXSQWCDO4wjQv/k2oQm4YtAofRtMWG2miomn/KOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Gwb7Vcps; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=VmOi1ol5; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 32B05605D0; Wed, 19 Mar 2025 00:07:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742339247;
	bh=N3Cr+riLTVFzQOy+96h/MCkRT4+P0yY2oEt6mJomR6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gwb7Vcpsrc3efEFOVIl7NrgyUoHU6kWdZfQx3z+TczqM1lK6E05XFd4olKoWVaKtw
	 Y2jQE6dWKjrkyFaFMKv5Ys9Iq26naSGuWoU+Aw9ZAYqqsF/nmxi8kTQNxOXMdV6SSx
	 Usgwg/8g4YRwh78nl/HcZ/QW5SLWfvUnCl2cS2uzuf8Om/gDYbTwAhuuI9JZsXCvJD
	 xIMHJ05uuwdb/zvmygOYR5W0lravn7N0HT88eT8wcgyA1GvTjGlJgeze9cH3qTkppS
	 EatUzv98HuYpypycbc3bLFZdSUmI538Afgt/NmE2uoiIf1L9dEMyV4Igj+LoppF+kv
	 FWIP1wHcHOzNw==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id B37B5605BD;
	Wed, 19 Mar 2025 00:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742339242;
	bh=N3Cr+riLTVFzQOy+96h/MCkRT4+P0yY2oEt6mJomR6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmOi1ol5l75GrD0dsZBl4s1wI30DbqYr//16bJ9sLBCBFt1NVSQGhS2fvT3QfrUE3
	 wwqs1n/PVsTpm8LjCkldQUiI/FfIC65r9BFa91nLFQ289DOLzfDAX4tHkIb1jVWvgl
	 o3nGs4q4j2v6tDrgyp4VaNfbfXgP3yDX7Xe3hMt1O6SKzWISxfB0zSA8ztbsBtXGiN
	 XB8gx7ZmIyFYMj6YQkWkN06SU5uE7XEJp+rzs+dntWZ+X9wjMBYSsLWVna6sWj1kBs
	 MTGCjAiLqJZg7QsLYDbb+fla0SP0StFWSFQj0Y8jl7U6POAGHIN8QxuDd43UfxacIh
	 2evPct8GiNpUQ==
Date: Wed, 19 Mar 2025 00:07:20 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 nf-next 3/3] selftests: netfilter: Add
 conntrack_bridge.sh
Message-ID: <Z9n8qBrt-TK4XlRq@calendula>
References: <20250315200033.17820-1-ericwouds@gmail.com>
 <20250315200033.17820-4-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250315200033.17820-4-ericwouds@gmail.com>

On Sat, Mar 15, 2025 at 09:00:33PM +0100, Eric Woudstra wrote:
> Check conntrack bridge is functional in various vlan setups.

Only conntrack bridge support is tested here, patch 2/3 does not seem
to be covered :(

> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  .../testing/selftests/net/netfilter/Makefile  |   1 +
>  .../net/netfilter/conntrack_bridge.sh         | 176 ++++++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100755 tools/testing/selftests/net/netfilter/conntrack_bridge.sh
> 
> diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
> index ffe161fac8b5..bee403d423f5 100644
> --- a/tools/testing/selftests/net/netfilter/Makefile
> +++ b/tools/testing/selftests/net/netfilter/Makefile
> @@ -8,6 +8,7 @@ MNL_LDLIBS := $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
>  
>  TEST_PROGS := br_netfilter.sh bridge_brouter.sh
>  TEST_PROGS += br_netfilter_queue.sh
> +TEST_PROGS += conntrack_bridge.sh
>  TEST_PROGS += conntrack_dump_flush.sh
>  TEST_PROGS += conntrack_icmp_related.sh
>  TEST_PROGS += conntrack_ipip_mtu.sh
> diff --git a/tools/testing/selftests/net/netfilter/conntrack_bridge.sh b/tools/testing/selftests/net/netfilter/conntrack_bridge.sh
> new file mode 100755
> index 000000000000..806551ef8cc2
> --- /dev/null
> +++ b/tools/testing/selftests/net/netfilter/conntrack_bridge.sh
> @@ -0,0 +1,176 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Check conntrack bridge is functional in various vlan setups.
> +#
> +# Setup is:
> +#
> +# nsclient1 -> nsbr -> nsclient2
> +# ping nsclient2 from nsclient1, checking that conntrack established
> +# packets are seen.
> +#
> +
> +source lib.sh
> +
> +if ! nft --version > /dev/null 2>&1;then
> +	echo "SKIP: Could not run test without nft tool"
> +	exit $ksft_skip
> +fi
> +
> +cleanup() {
> +	cleanup_all_ns
> +}
> +
> +trap cleanup EXIT
> +
> +setup_ns nsclient1 nsclient2 nsbr
> +
> +ret=0
> +
> +add_addr()
> +{
> +	ns=$1
> +	dev=$2
> +	i=$3
> +
> +	ip -net "$ns" link set "$dev" up
> +	ip -net "$ns" addr add "192.168.1.$i/24" dev "$dev"
> +	ip -net "$ns" addr add "dead:1::$i/64" dev "$dev" nodad
> +	ip -net "$ns" route add default dev "$dev"
> +}
> +
> +del_addr()
> +{
> +	ns=$1
> +	dev=$2
> +	i=$3
> +
> +	ip -net "$ns" route del default dev "$dev"
> +	ip -net "$ns" addr del "dead:1::$i/64" dev "$dev" nodad
> +	ip -net "$ns" addr del "192.168.1.$i/24" dev "$dev"
> +	ip -net "$ns" link set "$dev" down
> +}
> +
> +send_pings()
> +{
> +	for ad in "$@"; do
> +		if ! ip netns exec "$nsclient1" ping -c 1 -s 962 -q "$ad" >/dev/null; then
> +			echo "ERROR: netns routing/connectivity broken to $ad" 1>&2
> +			exit 1
> +		fi
> +	done
> +}
> +
> +check_counter()
> +{
> +	ns=$1
> +	name=$2
> +	expect=$3
> +	local lret=0
> +
> +	if ! ip netns exec "$ns" nft list counter bridge filter "$name" | grep -q "$expect"; then
> +		echo "ERROR: counter $name in $ns has unexpected value (expected $expect)" 1>&2
> +		ip netns exec "$ns" nft list counter bridge filter "$name" 1>&2
> +		lret=1
> +	fi
> +	ip netns exec "$ns" nft reset counters >/dev/null
> +
> +	return $lret
> +}
> +
> +BR=br0
> +if ! ip -net "$nsbr" link add $BR type bridge; then
> +	echo "SKIP: Can't create bridge $BR"
> +	exit $ksft_skip
> +fi
> +
> +DEV=veth0
> +ip link add "$DEV" netns "$nsclient1" type veth peer name eth1 netns "$nsbr"
> +ip link add "$DEV" netns "$nsclient2" type veth peer name eth2 netns "$nsbr"
> +
> +ip -net "$nsbr" link set eth1 master $BR up
> +ip -net "$nsbr" link set eth2 master $BR up
> +ip -net "$nsbr" link set $BR up
> +
> +ip netns exec "$nsbr" nft -f - <<EOF
> +table bridge filter {
> +	counter established { }
> +	chain forward {
> +		type filter hook forward priority 0; policy accept;
> +		ct state "established" counter name "established"
> +	}
> +}
> +EOF
> +
> +a=1;
> +for ns in "$nsclient1" "$nsclient2"; do
> +	add_addr "$ns" "$DEV" $a
> +	((a++))
> +done
> +
> +send_pings "192.168.1.2" "dead:1::2"
> +expect="packets 2 bytes 2000"
> +if ! check_counter "$nsbr" "established" "$expect"; then
> +	msg+="\nFAIL: without vlan, established packets not seen"
> +	ret=1
> +fi
> +
> +a=1;
> +for ns in "$nsclient1" "$nsclient2"; do
> +	del_addr "$ns" "$DEV" $a
> +	ip -net "$ns" link add link "$DEV" name "$DEV.10" type vlan id 10
> +	ip -net "$ns" link set "$DEV" up
> +	add_addr "$ns" "$DEV.10" $a
> +	((a++))
> +done
> +
> +send_pings "192.168.1.2" "dead:1::2"
> +expect="packets 2 bytes 2000"
> +if ! check_counter "$nsbr" "established" "$expect"; then
> +	msg+="\nFAIL: with single vlan, established packets not seen"
> +	ret=1
> +fi
> +
> +a=1;
> +for ns in "$nsclient1" "$nsclient2"; do
> +	del_addr "$ns" "$DEV.10" $a
> +	ip -net "$ns" link add link "$DEV.10" name "$DEV.10.20" type vlan id 20
> +	ip -net "$ns" link set "$DEV.10" up
> +	add_addr "$ns" "$DEV.10.20" $a
> +	((a++))
> +done
> +
> +send_pings "192.168.1.2" "dead:1::2"
> +expect="packets 2 bytes 2008"
> +if ! check_counter "$nsbr" "established" "$expect"; then
> +	msg+="\nFAIL: with double q vlan, established packets not seen"
> +	ret=1
> +fi
> +
> +a=1;
> +for ns in "$nsclient1" "$nsclient2"; do
> +	del_addr "$ns" "$DEV.10.20" $a
> +	ip -net "$ns" link del "$DEV.10.20"
> +	ip -net "$ns" link del "$DEV.10"
> +	ip -net "$ns" link add link "$DEV" name "$DEV.10" type vlan id 10 protocol 802.1ad
> +	ip -net "$ns" link add link "$DEV.10" name "$DEV.10.20" type vlan id 20
> +	ip -net "$ns" link set "$DEV.10" up
> +	add_addr "$ns" "$DEV.10.20" $a
> +	((a++))
> +done
> +
> +send_pings "192.168.1.2" "dead:1::2"
> +expect="packets 2 bytes 2008"
> +if ! check_counter "$nsbr" "established" "$expect"; then
> +	msg+="\nFAIL: with 802.1ad vlan, established packets not seen "
> +	ret=1
> +fi
> +
> +if [ $ret -eq 0 ];then
> +	echo "PASS: established packets seen in all cases"
> +else
> +	echo -e "$msg"
> +fi
> +
> +exit $ret
> +
> -- 
> 2.47.1
> 

