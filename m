Return-Path: <linux-kselftest+bounces-43854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415FC0003F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 10:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBABB1A08236
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49D304962;
	Thu, 23 Oct 2025 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvghfelA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAF2F6563;
	Thu, 23 Oct 2025 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209440; cv=none; b=VijbZo0kqI/vlb+Q6Z6ssbDaAxKuffgCcDGZau/YvCxpWQ16Bm8H5nsUcwItd85gs8XwFvB4GAauZu4jRg4GyoP9gtM699pVwDYzgMgujH621QbMcV5072pXQ/71d0WL8LBTyJntgoLLSjBfQluX2EBwT5vSR8EK44dqGMGtqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209440; c=relaxed/simple;
	bh=ExfaCFLyVyVDZzu1CiAtvR+UHLLo+5ptRTpAFKZdM18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bl9CMb8jz38xKh3Ci+1ncpeICkRDcYpHF3A6DW3H3Et8c1NDCFx5sq40wJxw7UoCZ86LDb71Ymx2cBI1pnYZdNidS5zNeZGZL+zGPN1bzm1bcBWETni46hdp46SKSLkO/1fCfgCGTw7CHM4p/40yYb42fBZg6HLYThJQTHxoCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvghfelA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5750CC4CEFB;
	Thu, 23 Oct 2025 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761209438;
	bh=ExfaCFLyVyVDZzu1CiAtvR+UHLLo+5ptRTpAFKZdM18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VvghfelAgG9Zms9ZGj8cfdgNcr0AKrxkZK9W4WfAGX4hMiwhQ/8+CT8R/aYxbNX4J
	 jDgbGv7L2Ut/r5LkzRnTchDBoDnCPloBa2gXCABMW6rAA1HjjFDwZhHxpUzx6RGVPy
	 fPKdZ8qzdcmUKRuKHLrlm4t4km3ql/3lzLI2oRnt9o/hr5DF8NTpiAo5/PLibneDhB
	 w9AKSTFkxgKo/rIt/IJqQ0uZRKEezXbO2GyzwNBWENbAy76HLc+tg0l9AAGg5kWr2/
	 d3BX5dpQP2FvDm8af+U9mwASTkCu/DRuEXxv2wZG9fdPpEs6RY3EBYqq+lXeLxmPFb
	 PF6vyUJW1yqDw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 23 Oct 2025 10:50:16 +0200
Subject: [PATCH nf-next v8 2/3] net: netfilter: Add IPIP flowtable tx sw
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-nf-flowtable-ipip-v8-2-5d5d8595c730@kernel.org>
References: <20251023-nf-flowtable-ipip-v8-0-5d5d8595c730@kernel.org>
In-Reply-To: <20251023-nf-flowtable-ipip-v8-0-5d5d8595c730@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Phil Sutter <phil@nwl.cc>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce sw acceleration for tx path of IPIP tunnels relying on the
netfilter flowtable infrastructure.
This patch introduces basic infrastructure to accelerate other tunnel
types (e.g. IP6IP6).
IPIP sw tx acceleration can be tested running the following scenario where
the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
tunnel is used to access a remote site (using eth1 as the underlay device):

ETH0 -- TUN0 <==> ETH1 -- [IP network] -- TUN1 (192.168.100.2)

$ip addr show
6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.2/24 scope global eth0
       valid_lft forever preferred_lft forever
7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.1/24 scope global eth1
       valid_lft forever preferred_lft forever
8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ipip 192.168.1.1 peer 192.168.1.2
    inet 192.168.100.1/24 scope global tun0
       valid_lft forever preferred_lft forever

$ip route show
default via 192.168.100.2 dev tun0
192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100.1

$nft list ruleset
table inet filter {
        flowtable ft {
                hook ingress priority filter
                devices = { eth0, eth1 }
        }

        chain forward {
                type filter hook forward priority filter; policy accept;
                meta l4proto { tcp, udp } flow add @ft
        }
}

Reproducing the scenario described above using veths I got the following
results:
- TCP stream trasmitted into the IPIP tunnel:
  - net-next: (baseline)                ~ 85Gbps
  - net-next + IPIP flowtbale support:  ~102Gbps

Co-developed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h             |  3 ++
 include/net/netfilter/nf_flow_table.h |  3 ++
 net/ipv4/ipip.c                       |  4 +++
 net/netfilter/nf_flow_table_ip.c      | 66 +++++++++++++++++++++++++++++++++--
 net/netfilter/nf_flow_table_path.c    | 48 +++++++++++++++++++++++--
 5 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0355461960ce3c0db49e00a6f77f48b031a635dc..eb8058fd7139a2b5457008146f979590f9f03c1d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -897,6 +897,9 @@ struct net_device_path {
 			};
 
 			u8	l3_proto;
+			u8	tos;
+			u8	ttl;
+			__be16	df;
 		} tun;
 		struct {
 			enum {
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 6d00a8aa52584ad96d200683297c1b02bf1f6d4f..fe792f5a8f0528de021c27382b235688532614e4 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -119,6 +119,9 @@ struct flow_offload_tunnel {
 	};
 
 	u8	l3_proto;
+	u8	tos;
+	u8	ttl;
+	__be16	df;
 };
 
 struct flow_offload_tuple {
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ff95b1b9908e9f4ba4bff207a5bd2c5d5670215a..cfd73342fd40916ca508734060a9e4ddc76cd245 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -369,6 +369,10 @@ static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
 	path->tun.src_v4.s_addr = tiph->saddr;
 	path->tun.dst_v4.s_addr = tiph->daddr;
 	path->tun.l3_proto = IPPROTO_IPIP;
+	path->tun.tos = tiph->tos;
+	path->tun.ttl = tiph->ttl;
+	path->tun.df = tiph->frag_off;
+
 	path->dev = ctx->dev;
 
 	ctx->dev = rt->dst.dev;
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 76081d5d2f71c10e0c65e906b3fb2769e3ab1466..a66ffa0c7fbe780a9f9a545e42d44dfe408e7cb2 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -427,6 +427,9 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
 	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
+	if (flow->tuplehash[!dir].tuple.tun_num)
+		mtu -= sizeof(*iph);
+
 	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
 		return 0;
 
@@ -498,7 +501,56 @@ static int nf_flow_pppoe_push(struct sk_buff *skb, u16 id)
 	return 0;
 }
 
-static int nf_flow_encap_push(struct sk_buff *skb, struct flow_offload_tuple *tuple)
+static int nf_flow_tunnel_v4_push(struct net *net, struct sk_buff *skb,
+				  struct flow_offload_tuple *tuple)
+{
+	struct iphdr *iph = (struct iphdr *)skb_network_header(skb);
+	struct rtable *rt = dst_rtable(tuple->dst_cache);
+	u32 headroom = sizeof(*iph);
+	u8 tos, ttl;
+	int err;
+
+	err = iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4);
+	if (err)
+		return err;
+
+	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
+	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
+	err = skb_cow_head(skb, headroom);
+	if (err)
+		return err;
+
+	skb_scrub_packet(skb, true);
+	skb_clear_hash_if_not_l4(skb);
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
+	/* Push down and install the IP header. */
+	skb_push(skb, sizeof(*iph));
+	skb_reset_network_header(skb);
+
+	tos = ip_tunnel_ecn_encap(tuple->tun.tos, iph, skb);
+	ttl = tuple->tun.ttl;
+	if (!ttl)
+		ttl = iph->ttl;
+
+	iph = ip_hdr(skb);
+	iph->version	= 4;
+	iph->ihl	= sizeof(*iph) >> 2;
+	iph->frag_off	= ip_mtu_locked(&rt->dst) ? 0 : tuple->tun.df;
+	iph->protocol	= tuple->tun.l3_proto;
+	iph->tos	= tos;
+	iph->daddr	= tuple->tun.src_v4.s_addr;
+	iph->saddr	= tuple->tun.dst_v4.s_addr;
+	iph->ttl	= ttl;
+	iph->tot_len	= htons(skb->len);
+	__ip_select_ident(net, iph, skb_shinfo(skb)->gso_segs ?: 1);
+	ip_send_check(iph);
+
+	return 0;
+}
+
+static int nf_flow_encap_push(struct net *net, struct sk_buff *skb,
+			      struct flow_offload_tuple *tuple)
 {
 	int i;
 
@@ -516,6 +568,9 @@ static int nf_flow_encap_push(struct sk_buff *skb, struct flow_offload_tuple *tu
 		}
 	}
 
+	if (tuple->tun_num)
+		return nf_flow_tunnel_v4_push(net, skb, tuple);
+
 	return 0;
 }
 
@@ -525,6 +580,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 {
 	struct flow_offload_tuple_rhash *tuplehash;
 	struct nf_flowtable *flow_table = priv;
+	struct flow_offload_tuple *reply_tuple;
 	enum flow_offload_tuple_dir dir;
 	struct nf_flowtable_ctx ctx = {
 		.in	= state->in,
@@ -533,6 +589,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	struct flow_offload *flow;
 	struct neighbour *neigh;
 	struct rtable *rt;
+	__be32 dest;
 	int ret;
 
 	tuplehash = nf_flow_offload_lookup(&ctx, flow_table, skb);
@@ -555,8 +612,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
+	reply_tuple = &flow->tuplehash[!dir].tuple;
 
-	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
+	if (nf_flow_encap_push(state->net, skb, reply_tuple))
 		return NF_DROP;
 
 	switch (tuplehash->tuple.xmit_type) {
@@ -567,7 +625,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 			flow_offload_teardown(flow);
 			return NF_DROP;
 		}
-		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr));
+		dest = reply_tuple->tun_num ? reply_tuple->tun.src_v4.s_addr
+					    : reply_tuple->src_v4.s_addr;
+		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, dest));
 		if (IS_ERR(neigh)) {
 			flow_offload_teardown(flow);
 			return NF_DROP;
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index bd5e9bf1ca393ab793976ba98a027b60f84882ba..cd0be2efe97596d0947621a5ea604373d5b61da8 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -190,7 +190,43 @@ static bool nft_flowtable_find_dev(const struct net_device *dev,
 	return found;
 }
 
-static void nft_dev_forward_path(struct nf_flow_route *route,
+static int nft_flow_tunnel_update_route(const struct nft_pktinfo *pkt,
+					struct nf_flow_route *route,
+					enum ip_conntrack_dir dir)
+{
+	struct dst_entry *tun_dst = NULL;
+	struct flowi fl = {};
+
+	switch (nft_pf(pkt)) {
+	case NFPROTO_IPV4:
+		fl.u.ip4.daddr = route->tuple[!dir].in.tun.src_v4.s_addr;
+		fl.u.ip4.saddr = route->tuple[!dir].in.tun.dst_v4.s_addr;
+		fl.u.ip4.flowi4_iif = nft_in(pkt)->ifindex;
+		fl.u.ip4.flowi4_dscp = ip4h_dscp(ip_hdr(pkt->skb));
+		fl.u.ip4.flowi4_mark = pkt->skb->mark;
+		fl.u.ip4.flowi4_flags = FLOWI_FLAG_ANYSRC;
+		break;
+	case NFPROTO_IPV6:
+		fl.u.ip6.daddr = route->tuple[!dir].in.tun.src_v6;
+		fl.u.ip6.saddr = route->tuple[!dir].in.tun.dst_v6;
+		fl.u.ip6.flowi6_iif = nft_in(pkt)->ifindex;
+		fl.u.ip6.flowlabel = ip6_flowinfo(ipv6_hdr(pkt->skb));
+		fl.u.ip6.flowi6_mark = pkt->skb->mark;
+		fl.u.ip6.flowi6_flags = FLOWI_FLAG_ANYSRC;
+		break;
+	}
+
+	nf_route(nft_net(pkt), &tun_dst, &fl, false, nft_pf(pkt));
+	if (!tun_dst)
+		return -ENOENT;
+
+	nft_default_forward_path(route, tun_dst, dir);
+
+	return 0;
+}
+
+static void nft_dev_forward_path(const struct nft_pktinfo *pkt,
+				 struct nf_flow_route *route,
 				 const struct nf_conn *ct,
 				 enum ip_conntrack_dir dir,
 				 struct nft_flowtable *ft)
@@ -218,6 +254,12 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
 		route->tuple[!dir].in.tun.src_v6 = info.tun.dst_v6;
 		route->tuple[!dir].in.tun.dst_v6 = info.tun.src_v6;
 		route->tuple[!dir].in.tun.l3_proto = info.tun.l3_proto;
+		route->tuple[!dir].in.tun.tos = info.tun.tos;
+		route->tuple[!dir].in.tun.ttl = info.tun.ttl;
+		route->tuple[!dir].in.tun.df = info.tun.df;
+
+		if (nft_flow_tunnel_update_route(pkt, route, dir))
+			return;
 	}
 
 	route->tuple[!dir].in.num_encaps = info.num_encaps;
@@ -274,9 +316,9 @@ int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
 	nft_default_forward_path(route, other_dst, !dir);
 
 	if (route->tuple[dir].xmit_type	== FLOW_OFFLOAD_XMIT_NEIGH)
-		nft_dev_forward_path(route, ct, dir, ft);
+		nft_dev_forward_path(pkt, route, ct, dir, ft);
 	if (route->tuple[!dir].xmit_type == FLOW_OFFLOAD_XMIT_NEIGH)
-		nft_dev_forward_path(route, ct, !dir, ft);
+		nft_dev_forward_path(pkt, route, ct, !dir, ft);
 
 	return 0;
 }

-- 
2.51.0


