Return-Path: <linux-kselftest+bounces-49243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 557D4D3916F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 00:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1532D3015A9E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874682D238F;
	Sat, 17 Jan 2026 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmrl3Fk0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63553137932;
	Sat, 17 Jan 2026 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768691127; cv=none; b=MWBBwQDvxgbD+aMF3Kn40Bp3QlOd8BkZEsXje/OWstw119vIoV8s+4tVDcLqdP76wIpuaFfNuF3hYnX1QCG8g4vZWRUgXY1Vcqbd5lRqHJFPvtHofpAgRvIODTx3HUb3led+CwCHjLB6+mcQ/8+uBORhbCc889jFlDhxdAXI4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768691127; c=relaxed/simple;
	bh=1A8dFk0aQVRS9g0Xa6m7E/rKMvXo2/Q1LIy58aB437w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I++TBdB9M9iXQ80/Gum94+r7i0l1F8QemMe6lkMa1qjDiTNDBAGdabAZaMIVjqbHBP+/2hvx0f3PrIYGFPyXYxus88Zu0Aj0P3BCTMB/rGgTEcPx0ub/VZx4EcmRG3MtfshjJfaU3InDrPUiTZEDkX1vg0Dth2OKDyKRBYFBuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wmrl3Fk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6F7C4CEF7;
	Sat, 17 Jan 2026 23:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768691127;
	bh=1A8dFk0aQVRS9g0Xa6m7E/rKMvXo2/Q1LIy58aB437w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wmrl3Fk046VwoMSZ+LIGD+uSCPGX4C/O1hTzRqKyVcmpdYKZJxP1N/wJYm1gveC3n
	 Pb4W8ZnjotgpYZjT2DRprkaJo1A4UsN0/qq6LjLv23VBDRz+gTrCWa8qjpeCYaeLNE
	 LjGejFu52smvRiSmhTe/Wc0DxR7KXOCA4BImWCLEfD0KVZqHMlL+kD8UV6rQ/xUXZ6
	 ofPskswQ0cv8n9GZUEM8haWhf/+OS3VlOq/MbGvLLrKzQXiPRrsv52mK+dt4/4iexJ
	 5EQdqUyLKJN5TUyRgCibFydKU29FoD1gfvR3t8faIiCo5vw95eJHLuTCFRHD21ctjl
	 eeewd7bsg8CbA==
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
Subject: Re: [nf-next,v3,3/5] netfilter: flowtable: Add IP6IP6 rx sw acceleration
Date: Sat, 17 Jan 2026 15:05:21 -0800
Message-ID: <20260117230521.990884-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116-b4-flowtable-offload-ip6ip6-v3-3-c1fcad85a905@kernel.org>
References: <20260116-b4-flowtable-offload-ip6ip6-v3-3-c1fcad85a905@kernel.org>
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
netfilter: flowtable: Add IP6IP6 rx sw acceleration

This patch introduces software acceleration for the RX path of IP6IP6
tunnels using the netfilter flowtable infrastructure.

> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index 7ee6b2e597c1..73ec8cb88285 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c

[ ... ]

> @@ -326,10 +340,45 @@ static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
>  	return true;
>  }
>
> -static void nf_flow_ip4_tunnel_pop(struct nf_flowtable_ctx *ctx,
> -				   struct sk_buff *skb)
> +static bool nf_flow_ip6_tunnel_proto(struct nf_flowtable_ctx *ctx,
> +				     struct sk_buff *skb)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	struct ipv6hdr *ip6h, _ip6h;
> +	__be16 frag_off;
> +	u8 nexthdr;
> +	int hdrlen;
> +
> +	ip6h = skb_header_pointer(skb, ctx->offset, sizeof(*ip6h), &_ip6h);
> +	if (!ip6h)
> +		return false;
> +
> +	if (ip6h->hop_limit <= 1)
> +		return false;
> +
> +	nexthdr = ipv6_hdr(skb)->nexthdr;
                 ^^^^^^^^^^^^

When ctx->offset is non-zero (e.g., VLAN-encapsulated traffic where
nf_flow_skb_encap_protocol() sets ctx->offset += VLAN_HLEN), ip6h points
to the IPv6 header at ctx->offset, but ipv6_hdr(skb) returns
skb_network_header(skb) which is at offset 0.

Should this be ip6h->nexthdr instead of ipv6_hdr(skb)->nexthdr?

The IPv4 analog nf_flow_ip4_tunnel_proto() uses iph->protocol where iph
is calculated as (skb_network_header(skb) + ctx->offset), which correctly
accounts for the encapsulation offset.

> +	hdrlen = ipv6_skip_exthdr(skb, sizeof(*ip6h) + ctx->offset, &nexthdr,
> +				  &frag_off);
> +	if (hdrlen < 0)
> +		return false;
> +
> +	if (nexthdr == IPPROTO_IPV6) {
> +		ctx->tun.hdr_size = hdrlen;
> +		ctx->tun.proto = IPPROTO_IPV6;
> +	}
> +	ctx->offset += ctx->tun.hdr_size;
> +
> +	return true;
> +#else
> +	return false;
> +#endif /* IS_ENABLED(CONFIG_IPV6) */
> +}

[ ... ]

