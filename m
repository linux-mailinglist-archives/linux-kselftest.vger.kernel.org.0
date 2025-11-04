Return-Path: <linux-kselftest+bounces-44771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B05C334E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 604394E9984
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26030CDB5;
	Tue,  4 Nov 2025 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="t1cWoTcu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7017BB35;
	Tue,  4 Nov 2025 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296749; cv=none; b=DcKNGeJYQ+lM6IDbuJFweLu2r65t3d9IZfZjcxwQcGC+7Tilo9EHF8HyGzG+GY+9ysj0oz6XeuKP1a0T6GDp92yW8M9kGlzQFDZPJB9WE/11nhU+x3JeS2iec2YdmFBiRZkK9LzrnNoIIkRobEAhsCqgS60+F+Y1GvdVmFIt5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296749; c=relaxed/simple;
	bh=6C7UVu2wYWw2gjQDTGOYBYbH7gx1G3jq1wzJxeaQXKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuA3Bj/grTR318oO+FXj0AhqW5jeifOtuP+vSNtwNiAmFcXyaNQU6UMiwkalWjffk9OZEgUvMtSUf7CvtBOcnndEYizhK0PsWk9ci3vyDPWD+2GtjySyJc40o3l8HBr3rIvWTO5zOf6oiRnwFHOIxn9qVaU0BdZSvaiCCKI6hoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=t1cWoTcu; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E2A4D60297;
	Tue,  4 Nov 2025 23:52:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1762296737;
	bh=zABZCtKirFzP6Bt+nctVvuxbMQ2CJPzadArlnhVNUa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1cWoTcuG6R/N9Uy8fjWChgpEuOUqnCwi4xVngqwRDDr3I1+aXvKoyVODtOq4r8HB
	 M5ftiHtxIZdtUo8Y2RQzsx1K24K4YKBd30uTF8713JrKC64Of8Z5B7HfM/KqTSieBU
	 dAKQqOdRZ6WrpOCpeOrOgUdMMb2npB6c0CPBoK/i20+86x9KS3UoympvhqQVVghU7e
	 /hKqK9pWlm9AgeS23KSmTtFgB2qcnPl4nL/WX8SgL9dNm3oq6vSRtpSChDTDfd2Lek
	 yuPJAvtx3E968avTRyeSzzBW0//H9fHLF80iBVjUEkWjSsGAfxF3/UrIUwyIy3t9lD
	 BY7723jxy22Ig==
Date: Tue, 4 Nov 2025 23:52:14 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v8 2/3] net: netfilter: Add IPIP flowtable tx sw
 acceleration
Message-ID: <aQqDnjv8KLtQJaOW@calendula>
References: <20251023-nf-flowtable-ipip-v8-0-5d5d8595c730@kernel.org>
 <20251023-nf-flowtable-ipip-v8-2-5d5d8595c730@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023-nf-flowtable-ipip-v8-2-5d5d8595c730@kernel.org>

On Thu, Oct 23, 2025 at 10:50:16AM +0200, Lorenzo Bianconi wrote:
[...]
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0355461960ce3c0db49e00a6f77f48b031a635dc..eb8058fd7139a2b5457008146f979590f9f03c1d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -897,6 +897,9 @@ struct net_device_path {
>  			};
>  
>  			u8	l3_proto;
> +			u8	tos;
> +			u8	ttl;
> +			__be16	df;
>  		} tun;
>  		struct {
>  			enum {
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
> index 6d00a8aa52584ad96d200683297c1b02bf1f6d4f..fe792f5a8f0528de021c27382b235688532614e4 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -119,6 +119,9 @@ struct flow_offload_tunnel {
>  	};
>  
>  	u8	l3_proto;
> +	u8	tos;
> +	u8	ttl;
> +	__be16	df;

This is now included in the hash that is used for the lookup, is it
intentional to include these fields here? For rx, we cannot know ttl
of the received packet?

Maybe this needs to be moved after the placeholder:

        struct { }                      __hash;

>  };
>  
>  struct flow_offload_tuple {
[...]
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index 76081d5d2f71c10e0c65e906b3fb2769e3ab1466..a66ffa0c7fbe780a9f9a545e42d44dfe408e7cb2 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
[...]
> @@ -533,6 +589,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
>  	struct flow_offload *flow;
>  	struct neighbour *neigh;
>  	struct rtable *rt;
> +	__be32 dest;
>  	int ret;
>  
>  	tuplehash = nf_flow_offload_lookup(&ctx, flow_table, skb);
> @@ -555,8 +612,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
>  
>  	dir = tuplehash->tuple.dir;
>  	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> +	reply_tuple = &flow->tuplehash[!dir].tuple;

Nit: I'd suggest 'other_tuple' instead 'reply_tuple' given this is not
strictly the reply tuple, just the tuple from the other direction.

> -	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> +	if (nf_flow_encap_push(state->net, skb, reply_tuple))
>  		return NF_DROP;
>  
>  	switch (tuplehash->tuple.xmit_type) {
> @@ -567,7 +625,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
>  			flow_offload_teardown(flow);
>  			return NF_DROP;
>  		}
> -		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr));
> +		dest = reply_tuple->tun_num ? reply_tuple->tun.src_v4.s_addr
> +					    : reply_tuple->src_v4.s_addr;
> +		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, dest));
>  		if (IS_ERR(neigh)) {
>  			flow_offload_teardown(flow);
>  			return NF_DROP;
> diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
> index bd5e9bf1ca393ab793976ba98a027b60f84882ba..cd0be2efe97596d0947621a5ea604373d5b61da8 100644
> --- a/net/netfilter/nf_flow_table_path.c
> +++ b/net/netfilter/nf_flow_table_path.c
> @@ -190,7 +190,43 @@ static bool nft_flowtable_find_dev(const struct net_device *dev,
>  	return found;
>  }
>  
> -static void nft_dev_forward_path(struct nf_flow_route *route,
> +static int nft_flow_tunnel_update_route(const struct nft_pktinfo *pkt,
> +					struct nf_flow_route *route,
> +					enum ip_conntrack_dir dir)
> +{
> +	struct dst_entry *tun_dst = NULL;
> +	struct flowi fl = {};
> +
> +	switch (nft_pf(pkt)) {
> +	case NFPROTO_IPV4:
> +		fl.u.ip4.daddr = route->tuple[!dir].in.tun.src_v4.s_addr;
> +		fl.u.ip4.saddr = route->tuple[!dir].in.tun.dst_v4.s_addr;
> +		fl.u.ip4.flowi4_iif = nft_in(pkt)->ifindex;
> +		fl.u.ip4.flowi4_dscp = ip4h_dscp(ip_hdr(pkt->skb));
> +		fl.u.ip4.flowi4_mark = pkt->skb->mark;
> +		fl.u.ip4.flowi4_flags = FLOWI_FLAG_ANYSRC;
> +		break;
> +	case NFPROTO_IPV6:
> +		fl.u.ip6.daddr = route->tuple[!dir].in.tun.src_v6;
> +		fl.u.ip6.saddr = route->tuple[!dir].in.tun.dst_v6;
> +		fl.u.ip6.flowi6_iif = nft_in(pkt)->ifindex;
> +		fl.u.ip6.flowlabel = ip6_flowinfo(ipv6_hdr(pkt->skb));
> +		fl.u.ip6.flowi6_mark = pkt->skb->mark;
> +		fl.u.ip6.flowi6_flags = FLOWI_FLAG_ANYSRC;
> +		break;
> +	}
> +
> +	nf_route(nft_net(pkt), &tun_dst, &fl, false, nft_pf(pkt));
> +	if (!tun_dst)
> +		return -ENOENT;
> +
> +	nft_default_forward_path(route, tun_dst, dir);

This overrides the previous dst that is set on here, is this leaking
such dst?

> +
> +	return 0;
> +}
> +
> +static void nft_dev_forward_path(const struct nft_pktinfo *pkt,
> +				 struct nf_flow_route *route,
>  				 const struct nf_conn *ct,
>  				 enum ip_conntrack_dir dir,
>  				 struct nft_flowtable *ft)
> @@ -218,6 +254,12 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
>  		route->tuple[!dir].in.tun.src_v6 = info.tun.dst_v6;
>  		route->tuple[!dir].in.tun.dst_v6 = info.tun.src_v6;
>  		route->tuple[!dir].in.tun.l3_proto = info.tun.l3_proto;
> +		route->tuple[!dir].in.tun.tos = info.tun.tos;
> +		route->tuple[!dir].in.tun.ttl = info.tun.ttl;
> +		route->tuple[!dir].in.tun.df = info.tun.df;
> +
> +		if (nft_flow_tunnel_update_route(pkt, route, dir))
> +			return;

If tunnel route is found...

>  	}
>
>  	route->tuple[!dir].in.num_encaps = info.num_encaps;

... num_encaps is never set?

Would you also extend the selftest to combine IPIP with vlan? Thanks.

> @@ -274,9 +316,9 @@ int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
>  	nft_default_forward_path(route, other_dst, !dir);
>  
>  	if (route->tuple[dir].xmit_type	== FLOW_OFFLOAD_XMIT_NEIGH)
> -		nft_dev_forward_path(route, ct, dir, ft);
> +		nft_dev_forward_path(pkt, route, ct, dir, ft);
>  	if (route->tuple[!dir].xmit_type == FLOW_OFFLOAD_XMIT_NEIGH)
> -		nft_dev_forward_path(route, ct, !dir, ft);
> +		nft_dev_forward_path(pkt, route, ct, !dir, ft);
>  
>  	return 0;
>  }
> 
> -- 
> 2.51.0
> 

