Return-Path: <linux-kselftest+bounces-48872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB44D19DD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B35E13007184
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF07392832;
	Tue, 13 Jan 2026 15:23:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06307298CAB;
	Tue, 13 Jan 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317813; cv=none; b=sU5wXiGGnerZhL+Dy9JPXYFAVpbTblSfYPSZuvQKbI6axqEM6fa/DHLspTSMdfMC7KBOenBz8Ksyinygzs6dN7ZjgzC5EMVXe+ON5s2dqpaUXeSPsPigE4/G3d++c8zp7ZaemE2uBxkHvH4sDrSlqhTn+pc6A8rKy43d76Fb+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317813; c=relaxed/simple;
	bh=ok39/LCD3J3XyLIXbOfm7xCF3W8xm/1uIZg4IfihNb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ra51Fg+96iNy/1EUpjK/BLjzsIf5nzxuLA9Dlq4XNvmrHRyDDnVZw7bXwq3BUzzydf+vdhUo4W7H5qlK2AKX/RGZ/iC+Sas4YZ3+UJZ2ofoFbPwmUyOwjRcy0+MGV5R4fephmTo/QHhPSpovM5rBF6Vc6rsB+OPRw0ozlfOozFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EB5BA6061E; Tue, 13 Jan 2026 16:23:25 +0100 (CET)
Date: Tue, 13 Jan 2026 16:23:25 +0100
From: Florian Westphal <fw@strlen.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v2 2/4] netfilter: flowtable: Add IP6IP6 rx sw
 acceleration
Message-ID: <aWZjba51DGI3EYG1@strlen.de>
References: <20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org>
 <20251209-b4-flowtable-offload-ip6ip6-v2-2-44817f1be5c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209-b4-flowtable-offload-ip6ip6-v2-2-44817f1be5c6@kernel.org>

Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> Introduce sw acceleration for rx path of IP6IP6 tunnels relying on the
> netfilter flowtable infrastructure. Subsequent patches will add sw
> acceleration for IP6IP6 tunnels tx path.
> IP6IP6 rx sw acceleration can be tested running the following scenario
> where the traffic is forwarded between two NICs (eth0 and eth1) and an
> IP6IP6 tunnel is used to access a remote site (using eth1 as the underlay
> device):
> 
> ETH0 -- TUN0 <==> ETH1 -- [IP network] -- TUN1 (2001:db8:3::2)
> 
> $ip addr show
> 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
>     inet6 2001:db8:1::2/64 scope global nodad
>        valid_lft forever preferred_lft forever
> 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
>     inet6 2001:db8:2::1/64 scope global nodad
>        valid_lft forever preferred_lft forever
> 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/tunnel6 2001:db8:2::1 peer 2001:db8:2::2 permaddr ce9c:2940:7dcc::
>     inet6 2002:db8:1::1/64 scope global nodad
>        valid_lft forever preferred_lft forever
> 
> $ip -6 route show
> 2001:db8:1::/64 dev eth0 proto kernel metric 256 pref medium
> 2001:db8:2::/64 dev eth1 proto kernel metric 256 pref medium
> 2002:db8:1::/64 dev tun0 proto kernel metric 256 pref medium
> default via 2002:db8:1::2 dev tun0 metric 1024 pref medium
> 
> $nft list ruleset
> table inet filter {
>         flowtable ft {
>                 hook ingress priority filter
>                 devices = { eth0, eth1 }
>         }
> 
>         chain forward {
>                 type filter hook forward priority filter; policy accept;
>                 meta l4proto { tcp, udp } flow add @ft
>         }
> }
> 
> Reproducing the scenario described above using veths I got the following
> results:
> - TCP stream received from the IPIP tunnel:
>   - net-next: (baseline)                  ~ 81Gbps
>   - net-next + IP6IP6 flowtbale support:  ~112Gbps
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/ipv6/ip6_tunnel.c            | 27 +++++++++++++
>  net/netfilter/nf_flow_table_ip.c | 83 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 97 insertions(+), 13 deletions(-)
> 
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 6405072050e0ef7521ca1fdddc4a0252e2159d2a..10341bfc16bd16a43290015952bd9a57658e6ae1 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1828,6 +1828,32 @@ int ip6_tnl_encap_setup(struct ip6_tnl *t,
>  }
>  EXPORT_SYMBOL_GPL(ip6_tnl_encap_setup);
>  
> +static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
> +				     struct net_device_path *path)
> +{
> +	struct ip6_tnl *t = netdev_priv(ctx->dev);
> +	struct flowi6 fl6 = {
> +		.daddr = t->parms.raddr,
> +	};
> +	struct dst_entry *dst;
> +	int err;
> +
> +	dst = ip6_route_output(dev_net(ctx->dev), NULL, &fl6);
> +	if (!dst->error) {
> +		path->type = DEV_PATH_TUN;
> +		path->tun.src_v6 = t->parms.laddr;
> +		path->tun.dst_v6 = t->parms.raddr;
> +		path->tun.l3_proto = IPPROTO_IPV6;
> +		path->dev = ctx->dev;
> +		ctx->dev = dst->dev;
> +	}
> +
> +	err = dst->error;
> +	dst_release(dst);
> +
> +	return err;
> +}
> +
>  static const struct net_device_ops ip6_tnl_netdev_ops = {
>  	.ndo_init	= ip6_tnl_dev_init,
>  	.ndo_uninit	= ip6_tnl_dev_uninit,
> @@ -1836,6 +1862,7 @@ static const struct net_device_ops ip6_tnl_netdev_ops = {
>  	.ndo_change_mtu = ip6_tnl_change_mtu,
>  	.ndo_get_stats64 = dev_get_tstats64,
>  	.ndo_get_iflink = ip6_tnl_get_iflink,
> +	.ndo_fill_forward_path = ip6_tnl_fill_forward_path,
>  };
>  
>  #define IPXIPX_FEATURES (NETIF_F_SG |		\
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index 14c01b59f76569170057d2465ee5953efb557bcc..8323f44a1ef172f16300a5c2c628464a99b2c47a 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -159,6 +159,7 @@ static void nf_flow_tuple_encap(struct nf_flowtable_ctx *ctx,
>  	__be16 inner_proto = skb->protocol;
>  	struct vlan_ethhdr *veth;
>  	struct pppoe_hdr *phdr;
> +	struct ipv6hdr *ip6h;
>  	struct iphdr *iph;
>  	u16 offset = 0;
>  	int i = 0;
> @@ -185,12 +186,25 @@ static void nf_flow_tuple_encap(struct nf_flowtable_ctx *ctx,
>  		break;
>  	}
>  
> -	if (inner_proto == htons(ETH_P_IP) &&
> -	    ctx->tun.proto == IPPROTO_IPIP) {

This change is done in the preceeding patch, then removed again?
Looks like the previous patch should leave the
code as-is?

> +	switch (inner_proto) {
> +	case htons(ETH_P_IP):
>  		iph = (struct iphdr *)(skb_network_header(skb) + offset);
> -		tuple->tun.dst_v4.s_addr = iph->daddr;
> -		tuple->tun.src_v4.s_addr = iph->saddr;
> -		tuple->tun.l3_proto = IPPROTO_IPIP;
> +		if (ctx->tun.proto == IPPROTO_IPIP) {
> +			tuple->tun.dst_v4.s_addr = iph->daddr;
> +			tuple->tun.src_v4.s_addr = iph->saddr;
> +			tuple->tun.l3_proto = IPPROTO_IPIP;
> +		}
> +		break;
> +	case htons(ETH_P_IPV6):
> +		ip6h = (struct ipv6hdr *)(skb_network_header(skb) + offset);
> +		if (ctx->tun.proto == IPPROTO_IPV6) {
> +			tuple->tun.dst_v6 = ip6h->daddr;
> +			tuple->tun.src_v6 = ip6h->saddr;
> +			tuple->tun.l3_proto = IPPROTO_IPV6;
> +		}
> +		break;
> +	default:
> +		break;
>  	}
>  }
>  
> @@ -324,10 +338,45 @@ static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
>  	return true;
>  }
>  
> -static void nf_flow_ip4_tunnel_pop(struct nf_flowtable_ctx *ctx,
> -				   struct sk_buff *skb)
> +static bool nf_flow_ip6_tunnel_proto(struct nf_flowtable_ctx *ctx,
> +				     struct sk_buff *skb)
>  {
> -	if (ctx->tun.proto != IPPROTO_IPIP)
> +#if IS_ENABLED(CONFIG_IPV6)
> +	struct ipv6hdr *ip6h;
> +	__be16 frag_off;
> +	u8 nexthdr;
> +	int hdrlen;
> +
> +	if (!pskb_may_pull(skb, sizeof(*ip6h) + ctx->offset))
> +		return false;
> +
> +	ip6h = (struct ipv6hdr *)(skb_network_header(skb) + ctx->offset);
> +	if (ip6h->hop_limit <= 1)
> +		return false;

There are multiple places where we do a pull on the skb, is this
needed?  Could this be replaced by skb_header_pointer() ?

doing skb->head realloc might be expensive and its more
error prone.

Or is there a requirement that the ctx->offsets can be
accessed via skb->head/data?

