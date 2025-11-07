Return-Path: <linux-kselftest+bounces-45082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C3C3FAE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 12:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2291F4E70DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4238322559;
	Fri,  7 Nov 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxDQCdEk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91DE307AC5;
	Fri,  7 Nov 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514117; cv=none; b=VAlvvMy7GxOwDj/wXd5neyUsYVvHZD1uOcVmFhCSwaYz+DeBgDWrcJkqbHNIBZYuT39/pmrYv65Y1IizBO6XWmGjgzyFVRsL4yi5RapPjpi1f+0hMH4oCYzfBY25fDBz+xopt0LjXQ1f36MmODksrnFXzkUsBmBu5wNRvWHPtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514117; c=relaxed/simple;
	bh=y5Apbc3eRT4q7UHVdSIlpczJMEZmXfLz2nHx1ZejUTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYjVd+QiaC+tCairaTArLMVgizFmRQzZl9SZiS/qj2UhAf/bpZQUAUOp+WYrsHsaXx6WbHdWzuplKaNUDQJjrCg1cuulFJrCbdy235CIlbkhaPLGM7YyLiVRI9qtJSzaqeTKkWbbAxmE2scpKAq0KAnYiaD2zMQ3/PBedAtiRpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxDQCdEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73DEC116B1;
	Fri,  7 Nov 2025 11:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762514117;
	bh=y5Apbc3eRT4q7UHVdSIlpczJMEZmXfLz2nHx1ZejUTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qxDQCdEk8E6TeFu2sbHtCSCULbP2DrvxFsObLGZpTz0Ejqo+iKM/I0jZgQR6kyUnq
	 y9u/W53apy1JHI2RuvutPeETS8Jj2fqTbFw6JSGdTW4509A8kLav/GN0Q2Fb71ur8f
	 iTTRJ0SqikhC9oy6hnscb9cm9NjDDic7PxVafLgytqW4+ydn/mgNiBKMNph/I3n9P0
	 wd8jSG/6L7wAVZRZK6jH3E3z9cp36a32yRhvlmBoGxd3uaPq0mf7tpjbV4Tfafnu1e
	 wfVk4b11btt2pfFgbNjEedtIbdtS7fKaJrhAZnp2ef5LCi2HWZH2CJH41NlMzhI6rw
	 6pF+nxZPgIdkw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 07 Nov 2025 12:14:47 +0100
Subject: [PATCH nf-next v9 2/3] net: netfilter: Add IPIP flowtable tx sw
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-nf-flowtable-ipip-v9-2-7cbc4090dfcb@kernel.org>
References: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
In-Reply-To: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
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
 net/netfilter/nf_flow_table_ip.c   | 66 ++++++++++++++++++++++++++++++++++++--
 net/netfilter/nf_flow_table_path.c | 48 ++++++++++++++++++++++++---
 2 files changed, 107 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index b40080b0d71cc011e18b68201af33e9c84987d78..9e6e26f49826e749c168b4f96ab53d24ddb88fe3 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -437,6 +437,9 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
 	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
+	if (flow->tuplehash[!dir].tuple.tun_num)
+		mtu -= sizeof(*iph);
+
 	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
 		return 0;
 
@@ -508,10 +511,62 @@ static int nf_flow_pppoe_push(struct sk_buff *skb, u16 id)
 	return 0;
 }
 
-static int nf_flow_encap_push(struct sk_buff *skb, struct flow_offload_tuple *tuple)
+static int nf_flow_tunnel_v4_push(struct net *net, struct sk_buff *skb,
+				  struct flow_offload_tuple *tuple)
+{
+	struct iphdr *iph = (struct iphdr *)skb_network_header(skb);
+	struct rtable *rt = dst_rtable(tuple->dst_cache);
+	__be16	frag_off = iph->frag_off;
+	u32 headroom = sizeof(*iph);
+	u8 tos = iph->tos, ttl = iph->ttl;
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
+	iph = ip_hdr(skb);
+	iph->version	= 4;
+	iph->ihl	= sizeof(*iph) >> 2;
+	iph->frag_off	= ip_mtu_locked(&rt->dst) ? 0 : frag_off;
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
 
+	if (tuple->tun_num) {
+		int err = nf_flow_tunnel_v4_push(net, skb, tuple);
+
+		if (err)
+			return err;
+	}
+
 	for (i = 0; i < tuple->encap_num; i++) {
 		switch (tuple->encap[i].proto) {
 		case htons(ETH_P_8021Q):
@@ -535,6 +590,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 {
 	struct flow_offload_tuple_rhash *tuplehash;
 	struct nf_flowtable *flow_table = priv;
+	struct flow_offload_tuple *other_tuple;
 	enum flow_offload_tuple_dir dir;
 	struct nf_flowtable_ctx ctx = {
 		.in	= state->in,
@@ -543,6 +599,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	struct flow_offload *flow;
 	struct neighbour *neigh;
 	struct rtable *rt;
+	__be32 dest;
 	int ret;
 
 	tuplehash = nf_flow_offload_lookup(&ctx, flow_table, skb);
@@ -565,8 +622,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
+	other_tuple = &flow->tuplehash[!dir].tuple;
 
-	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
+	if (nf_flow_encap_push(state->net, skb, other_tuple))
 		return NF_DROP;
 
 	switch (tuplehash->tuple.xmit_type) {
@@ -577,7 +635,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 			flow_offload_teardown(flow);
 			return NF_DROP;
 		}
-		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr));
+		dest = other_tuple->tun_num ? other_tuple->tun.src_v4.s_addr
+					    : other_tuple->src_v4.s_addr;
+		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, dest));
 		if (IS_ERR(neigh)) {
 			flow_offload_teardown(flow);
 			return NF_DROP;
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 64e2672a3c3383bae896c4fb68ff9ab7489fe791..7d6668e4d42456404df4db9f512625ba985a2772 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -190,7 +190,46 @@ static bool nft_flowtable_find_dev(const struct net_device *dev,
 	return found;
 }
 
-static void nft_dev_forward_path(struct nf_flow_route *route,
+static int nft_flow_tunnel_update_route(const struct nft_pktinfo *pkt,
+					struct flow_offload_tunnel *tun,
+					struct nf_flow_route *route,
+					enum ip_conntrack_dir dir)
+{
+	struct dst_entry *cur_dst = route->tuple[dir].dst;
+	struct dst_entry *tun_dst = NULL;
+	struct flowi fl = {};
+
+	switch (nft_pf(pkt)) {
+	case NFPROTO_IPV4:
+		fl.u.ip4.daddr = tun->dst_v4.s_addr;
+		fl.u.ip4.saddr = tun->src_v4.s_addr;
+		fl.u.ip4.flowi4_iif = nft_in(pkt)->ifindex;
+		fl.u.ip4.flowi4_dscp = ip4h_dscp(ip_hdr(pkt->skb));
+		fl.u.ip4.flowi4_mark = pkt->skb->mark;
+		fl.u.ip4.flowi4_flags = FLOWI_FLAG_ANYSRC;
+		break;
+	case NFPROTO_IPV6:
+		fl.u.ip6.daddr = tun->dst_v6;
+		fl.u.ip6.saddr = tun->src_v6;
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
+	route->tuple[dir].dst = tun_dst;
+	dst_release(cur_dst);
+
+	return 0;
+}
+
+static void nft_dev_forward_path(const struct nft_pktinfo *pkt,
+				 struct nf_flow_route *route,
 				 const struct nf_conn *ct,
 				 enum ip_conntrack_dir dir,
 				 struct nft_flowtable *ft)
@@ -213,7 +252,8 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
 		route->tuple[!dir].in.encap[i].proto = info.encap[i].proto;
 	}
 
-	if (info.num_tuns) {
+	if (info.num_tuns &&
+	    !nft_flow_tunnel_update_route(pkt, &info.tun, route, dir)) {
 		route->tuple[!dir].in.tun.src_v6 = info.tun.dst_v6;
 		route->tuple[!dir].in.tun.dst_v6 = info.tun.src_v6;
 		route->tuple[!dir].in.tun.l3_proto = info.tun.l3_proto;
@@ -274,9 +314,9 @@ int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
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
2.51.1


