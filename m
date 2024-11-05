Return-Path: <linux-kselftest+bounces-21499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A439BD7BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 22:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A8B21E35
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1A215C6A;
	Tue,  5 Nov 2024 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecXUWDHP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE821383;
	Tue,  5 Nov 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842818; cv=none; b=JPC4TjNKz+Yz/fq8MnrgaGdzk/nHQCZ033AnXQteIBeOZUqTbFFrtKAxmaxTASYqBVZgyEXIWitC3BonouXwIaRYNk344oCp2wpICd4nUSy14oTok3p0gI4DHhjLJemtCH5oF6LeFwi7EJvrebxv/j+paLRtFrSepVE+Vac7Dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842818; c=relaxed/simple;
	bh=UP801SCt6TwweUNVnTRvtmrXTNs5rIrSYTvgfWg3Vbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/q/5wywAjkTQCUuIJ1vfa9kVRrNdzVdt85TR/38Exqn61LXlLhASMZVwgo5Aoxv4qnpaySEGu1ByUkgG6MeeB44LaND+mCsAWZpzoNZFWPvsv5ZyiHeirrxSAr1RdSMk2TL2fPlGBEIuRWJnU9Ea0lcuNENkGykWhHOXPGGdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecXUWDHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F30AC4CECF;
	Tue,  5 Nov 2024 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730842817;
	bh=UP801SCt6TwweUNVnTRvtmrXTNs5rIrSYTvgfWg3Vbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ecXUWDHPRgGCL4vnGUFQFx71O2gPVApWkhc2slPSzqNuPFhgT6Po39ORoD3vyqoY/
	 R4g5A/kfpwPwNqKrsL8jOCZKwQ3TgNrckTlJWJLIdYdBXNX+Os8MWFS7VkdAt/pe9D
	 NLsQinA+muWXpuJpsZRuw1s9lgsvLlJQ5SnT4EvN2mFVbXr7dvKfhqzjjstW1/KDyC
	 I5J4I13Qfb9eMRhdPHtrGCW49fV9+ywiVleGqQ3cK2rPtmb/1W0roVOpThItvNdBZ4
	 XMvHV++UYXAEYcNC6h0YruR8cp0GyZWNWX9X1mdF3w2oCUvgyxGkiyzyeqkJhbuMqe
	 1VMmKTNTB9++w==
Message-ID: <b5000fd7-c613-4d04-b8d7-53c193d36236@kernel.org>
Date: Tue, 5 Nov 2024 14:40:16 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/2] ipv6: release nexthop on device removal
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <cover.1730828007.git.pabeni@redhat.com>
 <604c45c188c609b732286b47ac2a451a40f6cf6d.1730828007.git.pabeni@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <604c45c188c609b732286b47ac2a451a40f6cf6d.1730828007.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 11:23 AM, Paolo Abeni wrote:
> The CI is hitting some aperiodic hangup at device removal time in the
> pmtu.sh self-test:
> 
> unregister_netdevice: waiting for veth_A-R1 to become free. Usage count = 6
> ref_tracker: veth_A-R1@ffff888013df15d8 has 1/5 users at
> 	dst_init+0x84/0x4a0
> 	dst_alloc+0x97/0x150
> 	ip6_dst_alloc+0x23/0x90
> 	ip6_rt_pcpu_alloc+0x1e6/0x520
> 	ip6_pol_route+0x56f/0x840
> 	fib6_rule_lookup+0x334/0x630
> 	ip6_route_output_flags+0x259/0x480
> 	ip6_dst_lookup_tail.constprop.0+0x5c2/0x940
> 	ip6_dst_lookup_flow+0x88/0x190
> 	udp_tunnel6_dst_lookup+0x2a7/0x4c0
> 	vxlan_xmit_one+0xbde/0x4a50 [vxlan]
> 	vxlan_xmit+0x9ad/0xf20 [vxlan]
> 	dev_hard_start_xmit+0x10e/0x360
> 	__dev_queue_xmit+0xf95/0x18c0
> 	arp_solicit+0x4a2/0xe00
> 	neigh_probe+0xaa/0xf0
> 
> While the first suspect is the dst_cache, explicitly tracking the dst
> owing the last device reference via probes proved such dst is held by
> the nexthop in the originating fib6_info.
> 
> Similar to commit f5b51fe804ec ("ipv6: route: purge exception on
> removal"), we need to explicitly release the originating fib info when
> disconnecting a to-be-removed device from a live ipv6 dst: move the
> fib6_info cleanup into ip6_dst_ifdown().
> 
> Tested running:
> 
> ./pmtu.sh cleanup_ipv6_exception
> 
> in a tight loop for more than 400 iterations with no spat, running an
> unpatched kernel  I observed a splat every ~10 iterations.
> 
> Fixes: f88d8ea67fbd ("ipv6: Plumb support for nexthop object in a fib6_info")

are you sure that is the correct Fixes? That commit is June 2019 and
there have been stable periods since then without netdev release problems.

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - dropped unintended whitespace change
> ---
>  net/ipv6/route.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



