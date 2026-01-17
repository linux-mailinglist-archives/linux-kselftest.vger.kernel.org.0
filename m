Return-Path: <linux-kselftest+bounces-49244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522AD39174
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 00:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9AB23024E52
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F40E2EB860;
	Sat, 17 Jan 2026 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scVGzZoU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35E137932;
	Sat, 17 Jan 2026 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768691129; cv=none; b=Mbq5WD+cssqrIQzd6wNp1cBD7t13tNjlP8IOD9InM9B/MGTeuEAnOLaWQM0HxeQ+r/U4abO+lMDhVVQVbr/E2vrahEv91Xg+3mJsEr4aOBTvHEzh+rFcpfMjbq/K1NcX5AoMCsny0LiKZoyJ1/BRoj8NCCbFdoUgdC+GLLQeDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768691129; c=relaxed/simple;
	bh=ay3LjAdYKhje3V4RGCts0Tcl3j5EP806bnQBbZR/OPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfx1lL9mLSYYJr3bXpuC3YRmpP+hnTlv3X9n5L3t0ZEh583nGAAZkzwcc8fBVBZ3SCvtlqCYuEeU/ddaDj7ozMAPtOTPB2BzGg5Wmo6q99g/jdzTOYaluhn+h0LUjG8Pdtbk93/T1mt1Cq/sS/p60w7TZQ4u87pRxdFhKuKBw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scVGzZoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6DEC4CEF7;
	Sat, 17 Jan 2026 23:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768691129;
	bh=ay3LjAdYKhje3V4RGCts0Tcl3j5EP806bnQBbZR/OPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scVGzZoUg3aYjiF3DRBb3Houd5on7FYT8IlEi4IGgXPAYl+jZol5Jha3vrOgozXlK
	 WLYRvLB2iD487srh9yiWkRGODpeBCQIWSP6qqwJUoV5dcsAiC0V+zxinESLGOu9yN4
	 OeyC+ev4ZL49RRv5kK4QEh4Nhjew6kEUmMEAYljXEnE2/HBfC/M1fa0Fu5I9PHxGdq
	 bpZA5tKYu/ZKWLupAl3gHK79fqA3hRgY3VbnhxczHnaY7ITHDQp9BxT2L/aR+4vgy+
	 8Mq/Jgw1muJ5FV3ct2b+0sVhShknug2qw/rer8yTYFHtJ6RJivOBkiu721zzy5126Z
	 SwlS/rHkPNjOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	kadlec@netfilter.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	netfilter-devel@vger.kernel.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	phil@nwl.cc,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	pablo@netfilter.org,
	pabeni@redhat.com
Subject: Re: [nf-next,v3,4/5] netfilter: flowtable: Add IP6IP6 tx sw acceleration
Date: Sat, 17 Jan 2026 15:05:27 -0800
Message-ID: <20260117230527.992716-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116-b4-flowtable-offload-ip6ip6-v3-4-c1fcad85a905@kernel.org>
References: <20260116-b4-flowtable-offload-ip6ip6-v3-4-c1fcad85a905@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
netfilter: flowtable: Add IP6IP6 tx sw acceleration

This patch adds software acceleration for the TX path of IP6IP6 tunnels
using the netfilter flowtable infrastructure.

> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index 73ec8cb88285..f72fcb85c318 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c

[ ... ]

> +static int nf_flow_tunnel_ip6ip6_push(struct net *net, struct sk_buff *skb,
> +				      struct flow_offload_tuple *tuple,
> +				      struct in6_addr **ip6_daddr)
> +{
> +	struct ipv6hdr *ip6h = (struct ipv6hdr *)skb_network_header(skb);
> +	int err, mtu, encap_limit = IPV6_DEFAULT_TNL_ENCAP_LIMIT;

[ ... ]

> +	if (encap_limit > 0) {
> +		struct ipv6_tel_txoption opt = {

[ ... ]

> +		hopt = skb_push(skb, ipv6_optlen(opt.ops.dst1opt));

This pushes 8 bytes for the destination options header.

> +		memcpy(hopt, opt.ops.dst1opt, ipv6_optlen(opt.ops.dst1opt));
> +		hopt->nexthdr = IPPROTO_IPV6;
> +		proto = NEXTHDR_DEST;
> +	}
> +
> +	skb_push(skb, sizeof(*ip6h));

And this pushes another 40 bytes for the IPv6 header.

So total encapsulation overhead is 48 bytes when encap_limit is enabled
(which is the default, since IPV6_DEFAULT_TNL_ENCAP_LIMIT is non-zero).

[ ... ]

> @@ -923,6 +1012,9 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
>  	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
>
>  	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
> +	if (flow->tuplehash[!dir].tuple.tun_num)
> +		mtu -= sizeof(*ip6h);
                        ^^^^^^^^^^^^

Should this also subtract 8 bytes for the destination options header when
encap_limit is enabled? The MTU calculation here only accounts for the
40-byte IPv6 header, but nf_flow_tunnel_ip6ip6_push() adds 48 bytes total
(40 for the IPv6 header plus 8 for the encap_limit destination options).

The reference implementation in ip6_tnl_xmit() subtracts both:

    mtu = dst_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
    if (encap_limit >= 0) {
        max_headroom += 8;
        mtu -= 8;
    }

Without accounting for the extra 8 bytes here, packets in the size range
(mtu-48, mtu-40] could pass the MTU check but produce oversized packets
after encapsulation.

> +
>  	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
>  		return 0;

[ ... ]

