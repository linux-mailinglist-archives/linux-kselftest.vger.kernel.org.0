Return-Path: <linux-kselftest+bounces-43679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79FBF7F68
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 19:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8114505B71
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B740A34E758;
	Tue, 21 Oct 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKeuA8KR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2C257859;
	Tue, 21 Oct 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068931; cv=none; b=rS6m3tPpBqH4Nopcr8b1sBMaj1KeeUp5jmWo0eTI4uxWSUgpm+INaJ3QeQxuw1svuG13uq4Sl4HSRNm1Wv/58LBsE8qPoL6RCZnG62aFt7ABJ4X+TlSgK0ptCV4z0ayDe8dYLXQAx9GuPUn7ZjPCikw2oEB6+RwdVF9k8UIvy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068931; c=relaxed/simple;
	bh=sBjMPYyoML1wmT6IaT8faWhCRQTVZZO3pYvpxZmQwBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LzHgnzC2dXqgEFmA8fiCqiN/potf/kcGVmzJqZnD7GdAXTt2RIzPRzniugatwo/l85jYfOFD6IE54F1CGO+W/yCCS6A5g2QPxHAUUy/FEHdONn2hqDtxakIx/o63LtNNK5wcmkhJ7LsvgMNkAMN592Jz5LngPiSR40jMRFWpJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKeuA8KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1A9C4CEF1;
	Tue, 21 Oct 2025 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068931;
	bh=sBjMPYyoML1wmT6IaT8faWhCRQTVZZO3pYvpxZmQwBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VKeuA8KRjc8W58g4gicoeVKar2MUhe9EnNQIRuPhg9An0mmTA2AMIfvoLOt1r+SK2
	 zymRegg8Af6/sa4KGtadlu5ee/4eLIsGF7fzdGNuYEkzkMk+WNc9S2TWtjU0YUsrcg
	 NcFJXRDUK+RWAMEivi1cQ4PLPLTbwly72WDBkzk99o9K3fMyYekwM6Y/fhCMYX2m0D
	 F3u8/0Rnk14oJSybGOKs0HzevFDRxlfFBLSUItgG+MEyagAmM7vOALGRFG3bjKHdF8
	 7K1290FdnOP/1zCKptR9QE54f+OyQK7XzUFN14oc+a3OIVu2lRiuwTNfqZMCBYaHQY
	 IBcDTnVIpQ3QA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 21 Oct 2025 19:48:19 +0200
Subject: [PATCH nf-next v7 2/3] net: netfilter: Add IPIP flowtable tx sw
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-nf-flowtable-ipip-v7-2-a45214896106@kernel.org>
References: <20251021-nf-flowtable-ipip-v7-0-a45214896106@kernel.org>
In-Reply-To: <20251021-nf-flowtable-ipip-v7-0-a45214896106@kernel.org>
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
  - net-next + IPIP flowtbale support:  ~100Gbps

Co-developed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h             |  3 ++
 include/net/netfilter/nf_flow_table.h |  8 +++++
 net/ipv4/ipip.c                       |  4 +++
 net/netfilter/nf_flow_table_core.c    |  2 ++
 net/netfilter/nf_flow_table_ip.c      | 67 +++++++++++++++++++++++++++++++++--
 net/netfilter/nft_flow_offload.c      | 50 ++++++++++++++++++++++++--
 6 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 183e2b8b0111da86c3c3e4eb1bfe8fdba433dad5..cac81dc481dc31cc6c0203895891d742e4bb5333 100644
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
index bf712ac3fd970012d5360ff11c17315338527438..61812033c95fd78b2fc234b35ef20d2e33c08189 100644
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
@@ -158,6 +161,8 @@ struct flow_offload_tuple {
 		struct {
 			struct dst_entry *dst_cache;
 			u32		dst_cookie;
+			u8		tunnel_num;
+			struct flow_offload_tunnel tunnel;
 		};
 		struct {
 			u32		ifidx;
@@ -232,6 +237,9 @@ struct nf_flow_route {
 			u32			hw_ifindex;
 			u8			h_source[ETH_ALEN];
 			u8			h_dest[ETH_ALEN];
+
+			u8			num_tuns;
+			struct flow_offload_tunnel tun;
 		} out;
 		enum flow_offload_xmit_type	xmit_type;
 	} tuple[FLOW_OFFLOAD_DIR_MAX];
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
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 4e08abc9bca705db36cbe26cf176e8f946722e32..90ef99ab5bba6125cdfd49de437766f76674e21a 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -124,9 +124,11 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		flow_tuple->tun[j] = route->tuple[dir].in.tun[i];
 		j++;
 	}
+	flow_tuple->tunnel = route->tuple[dir].out.tun;
 
 	flow_tuple->encap_num = route->tuple[dir].in.num_encaps;
 	flow_tuple->tun_num = route->tuple[dir].in.num_tuns;
+	flow_tuple->tunnel_num = route->tuple[dir].out.num_tuns;
 
 	switch (route->tuple[dir].xmit_type) {
 	case FLOW_OFFLOAD_XMIT_DIRECT:
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 0309dbff6e6219843fa7ec16a523d288c8274b77..a695070ea9331a1c1e96d6a44609b62529ac356d 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -428,6 +428,9 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
 	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
+	if (tuplehash->tuple.tunnel_num)
+		mtu -= sizeof(*iph);
+
 	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
 		return 0;
 
@@ -461,6 +464,54 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 	return 1;
 }
 
+static unsigned int nf_flow_add_tunnel_v4(struct net *net, struct sk_buff *skb,
+					  struct flow_offload *flow, int dir,
+					  const struct rtable *rt)
+{
+	struct iphdr *iph = (struct iphdr *)skb_network_header(skb);
+	u32 headroom = sizeof(struct iphdr);
+	u8 tos, ttl;
+	__be16 df;
+
+	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
+		return -1;
+
+	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
+	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
+	if (skb_cow_head(skb, headroom))
+		return -1;
+
+	skb_scrub_packet(skb, true);
+	skb_clear_hash_if_not_l4(skb);
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
+	/* Push down and install the IP header. */
+	skb_push(skb, sizeof(struct iphdr));
+	skb_reset_network_header(skb);
+
+	df = flow->tuplehash[dir].tuple.tunnel.df;
+	tos = ip_tunnel_ecn_encap(flow->tuplehash[dir].tuple.tunnel.tos,
+				  iph, skb);
+	ttl = flow->tuplehash[dir].tuple.tunnel.ttl;
+	if (!ttl)
+		ttl = iph->ttl;
+
+	iph = ip_hdr(skb);
+	iph->version	= 4;
+	iph->ihl	= sizeof(struct iphdr) >> 2;
+	iph->frag_off	= ip_mtu_locked(&rt->dst) ? 0 : df;
+	iph->protocol	= flow->tuplehash[dir].tuple.tunnel.l3_proto;
+	iph->tos	= tos;
+	iph->daddr	= flow->tuplehash[dir].tuple.tunnel.dst_v4.s_addr;
+	iph->saddr	= flow->tuplehash[dir].tuple.tunnel.src_v4.s_addr;
+	iph->ttl	= ttl;
+	iph->tot_len	= htons(skb->len);
+	__ip_select_ident(net, iph, skb_shinfo(skb)->gso_segs ?: 1);
+	ip_send_check(iph);
+
+	return 0;
+}
+
 unsigned int
 nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 			const struct nf_hook_state *state)
@@ -473,8 +524,8 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	};
 	struct flow_offload *flow;
 	struct net_device *outdev;
+	__be32 nexthop, daddr;
 	struct rtable *rt;
-	__be32 nexthop;
 	int ret;
 
 	tuplehash = nf_flow_offload_lookup(&ctx, flow_table, skb);
@@ -501,9 +552,21 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	switch (tuplehash->tuple.xmit_type) {
 	case FLOW_OFFLOAD_XMIT_NEIGH:
 		rt = dst_rtable(tuplehash->tuple.dst_cache);
+		if (tuplehash->tuple.tunnel_num) {
+			ret = nf_flow_add_tunnel_v4(state->net, skb, flow, dir,
+						    rt);
+			if (ret < 0) {
+				ret = NF_DROP;
+				flow_offload_teardown(flow);
+				break;
+			}
+			daddr = tuplehash->tuple.tunnel.dst_v4.s_addr;
+		} else {
+			daddr = flow->tuplehash[!dir].tuple.src_v4.s_addr;
+		}
 		outdev = rt->dst.dev;
 		skb->dev = outdev;
-		nexthop = rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr);
+		nexthop = rt_nexthop(rt, daddr);
 		skb_dst_set_noref(skb, &rt->dst);
 		neigh_xmit(NEIGH_ARP_TABLE, outdev, &nexthop, skb);
 		ret = NF_STOLEN;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index e30abe026dd2a37cae2eea56257033a48e71af7c..137939573f0c3511cf3d7987a59fc269f1a31387 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -202,10 +202,46 @@ static bool nft_flowtable_find_dev(const struct net_device *dev,
 	return found;
 }
 
+static int nft_flow_tunnel_update_route(const struct nft_pktinfo *pkt,
+					struct nf_flow_route *route,
+					enum ip_conntrack_dir dir)
+{
+	struct dst_entry *tun_dst = NULL;
+	struct flowi fl = {};
+
+	switch (nft_pf(pkt)) {
+	case NFPROTO_IPV4:
+		fl.u.ip4.daddr = route->tuple[dir].out.tun.dst_v4.s_addr;
+		fl.u.ip4.saddr = route->tuple[dir].out.tun.src_v4.s_addr;
+		fl.u.ip4.flowi4_iif = nft_in(pkt)->ifindex;
+		fl.u.ip4.flowi4_dscp = ip4h_dscp(ip_hdr(pkt->skb));
+		fl.u.ip4.flowi4_mark = pkt->skb->mark;
+		fl.u.ip4.flowi4_flags = FLOWI_FLAG_ANYSRC;
+		break;
+	case NFPROTO_IPV6:
+		fl.u.ip6.daddr = route->tuple[dir].out.tun.dst_v6;
+		fl.u.ip6.saddr = route->tuple[dir].out.tun.src_v6;
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
 static void nft_dev_forward_path(struct nf_flow_route *route,
 				 const struct nf_conn *ct,
 				 enum ip_conntrack_dir dir,
-				 struct nft_flowtable *ft)
+				 struct nft_flowtable *ft,
+				 const struct nft_pktinfo *pkt)
 {
 	const struct dst_entry *dst = route->tuple[dir].dst;
 	struct net_device_path_stack stack;
@@ -227,6 +263,14 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
 	for (i = 0; i < info.num_tuns; i++)
 		route->tuple[!dir].in.tun[i] = info.tun[i];
 
+	/* Single encapsulation is supported for the moment. */
+	route->tuple[dir].out.num_tuns = info.num_tuns;
+	if (route->tuple[dir].out.num_tuns) {
+		route->tuple[dir].out.tun = info.tun[0];
+		if (nft_flow_tunnel_update_route(pkt, route, dir))
+			return;
+	}
+
 	route->tuple[!dir].in.num_encaps = info.num_encaps;
 	route->tuple[!dir].in.num_tuns = info.num_tuns;
 	route->tuple[!dir].in.ingress_vlans = info.ingress_vlans;
@@ -286,8 +330,8 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 
 	if (route->tuple[dir].xmit_type	== FLOW_OFFLOAD_XMIT_NEIGH &&
 	    route->tuple[!dir].xmit_type == FLOW_OFFLOAD_XMIT_NEIGH) {
-		nft_dev_forward_path(route, ct, dir, ft);
-		nft_dev_forward_path(route, ct, !dir, ft);
+		nft_dev_forward_path(route, ct, dir, ft, pkt);
+		nft_dev_forward_path(route, ct, !dir, ft, pkt);
 	}
 
 	return 0;

-- 
2.51.0


