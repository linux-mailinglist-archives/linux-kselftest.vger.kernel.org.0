Return-Path: <linux-kselftest+bounces-47236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80885CAB777
	for <lists+linux-kselftest@lfdr.de>; Sun, 07 Dec 2025 17:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9084C301FC3E
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 16:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAEF2EBDC8;
	Sun,  7 Dec 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/NPyWsP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F126E6F0;
	Sun,  7 Dec 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123640; cv=none; b=nMzwR2YnhZbaTPKXtH0iPJSHcDLOzQ3nDAPelOpWsSVpUp7o5v7kdBYWaFFjZ2+yhlgviwjISq8u1fIG5/aj0oI+FujQIb1zlYtkLL6DUljKG0lgPXeVWENytYHlcGHliPOSKq3DLC8p6tfmUQc30T7cbk/3gLZRkEWYGBl1P6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123640; c=relaxed/simple;
	bh=rprgspups4r320QvJcGJXyUn5+r9aqTobC7A/YFP8G0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LL/28KDU0pJoTgnxl55eVRefshvnk/9hqdPdGK4DRGgzs8+BAObSaOkI+Enfdrj7Y6ubPy+X9+yG87Z118Hq+JnH+U/MI2EuwMUpbqrWv1VRiuEL29jB4f28v2cbyJArHDlyanf+Vw1R+RcvZeY+OYwhdJF8D38w91t6l5t32r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/NPyWsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22A8C4CEFB;
	Sun,  7 Dec 2025 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765123640;
	bh=rprgspups4r320QvJcGJXyUn5+r9aqTobC7A/YFP8G0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q/NPyWsPAhvvYTTZ++lP+gI5jIOhkvTWofK87aQrAzWNHgz0kx74h2KpvdTgHLQ1X
	 zOLvqZZK4MnmTEhc8twt8entZZ6Rjb8cGNuoU/I7Gr0u0BxFUPAjum0RSHc1mN/H3b
	 eyN3SKLZWOJ5RbryqkQjPIahfG8w2isaIbpG9tK8WsEtcUhfOxcBfMr/O73452yhQ7
	 eUD4LOjJTE0SvvmaX6EL6esWgx5y9Fz40M4pf+4UKHOgyaHV05eLcUrk0MSrrrWLHE
	 WWyYXC15AWimMPkSgCzMgRQ/b/mf072g+deS0dhcAaD4DP17rGxgJVzaKpRZffEq5O
	 JG7z1218W/MNg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 07 Dec 2025 17:06:43 +0100
Subject: [PATCH nf-next 3/5] netfilter: flowtable: Add IP6IP6 rx sw
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251207-b4-flowtable-offload-ip6ip6-v1-3-18e3ab7f748c@kernel.org>
References: <20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org>
In-Reply-To: <20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce sw acceleration for rx path of IP6IP6 tunnels relying on the
netfilter flowtable infrastructure. Subsequent patches will add sw
acceleration for IP6IP6 tunnels tx path.
IP6IP6 rx sw acceleration can be tested running the following scenario
where the traffic is forwarded between two NICs (eth0 and eth1) and an
IP6IP6 tunnel is used to access a remote site (using eth1 as the underlay
device):

ETH0 -- TUN0 <==> ETH1 -- [IP network] -- TUN1 (2001:db8:3::2)

$ip addr show
6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
    inet6 2001:db8:1::2/64 scope global nodad
       valid_lft forever preferred_lft forever
7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
    inet6 2001:db8:2::1/64 scope global nodad
       valid_lft forever preferred_lft forever
8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state UNKNOWN group default qlen 1000
    link/tunnel6 2001:db8:2::1 peer 2001:db8:2::2 permaddr ce9c:2940:7dcc::
    inet6 2002:db8:1::1/64 scope global nodad
       valid_lft forever preferred_lft forever

$ip -6 route show
2001:db8:1::/64 dev eth0 proto kernel metric 256 pref medium
2001:db8:2::/64 dev eth1 proto kernel metric 256 pref medium
2002:db8:1::/64 dev tun0 proto kernel metric 256 pref medium
default via 2002:db8:1::2 dev tun0 metric 1024 pref medium

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
- TCP stream received from the IPIP tunnel:
  - net-next: (baseline)                  ~ 79Gbps
  - net-next + IP6IP6 flowtbale support:  ~106Gbps

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/ipv6/ip6_tunnel.c            |  27 ++++++++++
 net/netfilter/nf_flow_table_ip.c | 109 +++++++++++++++++++++++++++++++++------
 2 files changed, 120 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 6405072050e0ef7521ca1fdddc4a0252e2159d2a..10341bfc16bd16a43290015952bd9a57658e6ae1 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1828,6 +1828,32 @@ int ip6_tnl_encap_setup(struct ip6_tnl *t,
 }
 EXPORT_SYMBOL_GPL(ip6_tnl_encap_setup);
 
+static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
+				     struct net_device_path *path)
+{
+	struct ip6_tnl *t = netdev_priv(ctx->dev);
+	struct flowi6 fl6 = {
+		.daddr = t->parms.raddr,
+	};
+	struct dst_entry *dst;
+	int err;
+
+	dst = ip6_route_output(dev_net(ctx->dev), NULL, &fl6);
+	if (!dst->error) {
+		path->type = DEV_PATH_TUN;
+		path->tun.src_v6 = t->parms.laddr;
+		path->tun.dst_v6 = t->parms.raddr;
+		path->tun.l3_proto = IPPROTO_IPV6;
+		path->dev = ctx->dev;
+		ctx->dev = dst->dev;
+	}
+
+	err = dst->error;
+	dst_release(dst);
+
+	return err;
+}
+
 static const struct net_device_ops ip6_tnl_netdev_ops = {
 	.ndo_init	= ip6_tnl_dev_init,
 	.ndo_uninit	= ip6_tnl_dev_uninit,
@@ -1836,6 +1862,7 @@ static const struct net_device_ops ip6_tnl_netdev_ops = {
 	.ndo_change_mtu = ip6_tnl_change_mtu,
 	.ndo_get_stats64 = dev_get_tstats64,
 	.ndo_get_iflink = ip6_tnl_get_iflink,
+	.ndo_fill_forward_path = ip6_tnl_fill_forward_path,
 };
 
 #define IPXIPX_FEATURES (NETIF_F_SG |		\
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 9dbb4eed7724edbd68d386bb48bc237527ea7368..f24e2c063ab8835d3e4a02439020ace79f70dd70 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -15,6 +15,7 @@
 #include <net/neighbour.h>
 #include <net/netfilter/nf_flow_table.h>
 #include <net/netfilter/nf_conntrack_acct.h>
+#include <net/protocol.h>
 /* For layer 4 checksum field offset. */
 #include <linux/tcp.h>
 #include <linux/udp.h>
@@ -159,6 +160,7 @@ static void nf_flow_tuple_encap(struct nf_flowtable_ctx *ctx,
 	__be16 inner_proto = skb->protocol;
 	struct vlan_ethhdr *veth;
 	struct pppoe_hdr *phdr;
+	struct ipv6hdr *ip6h;
 	struct iphdr *iph;
 	u16 offset = 0;
 	int i = 0;
@@ -185,12 +187,25 @@ static void nf_flow_tuple_encap(struct nf_flowtable_ctx *ctx,
 		break;
 	}
 
-	if (inner_proto == htons(ETH_P_IP) &&
-	    ctx->tun.proto == IPPROTO_IPIP) {
+	switch (inner_proto) {
+	case htons(ETH_P_IP):
 		iph = (struct iphdr *)(skb_network_header(skb) + offset);
-		tuple->tun.dst_v4.s_addr = iph->daddr;
-		tuple->tun.src_v4.s_addr = iph->saddr;
-		tuple->tun.l3_proto = IPPROTO_IPIP;
+		if (ctx->tun.proto == IPPROTO_IPIP) {
+			tuple->tun.dst_v4.s_addr = iph->daddr;
+			tuple->tun.src_v4.s_addr = iph->saddr;
+			tuple->tun.l3_proto = IPPROTO_IPIP;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		ip6h = (struct ipv6hdr *)(skb_network_header(skb) + offset);
+		if (ctx->tun.proto == IPPROTO_IPV6) {
+			tuple->tun.dst_v6 = ip6h->daddr;
+			tuple->tun.src_v6 = ip6h->saddr;
+			tuple->tun.l3_proto = IPPROTO_IPV6;
+		}
+		break;
+	default:
+		break;
 	}
 }
 
@@ -324,10 +339,62 @@ static int nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
 	return 0;
 }
 
-static void nf_flow_ip4_tunnel_pop(struct nf_flowtable_ctx *ctx,
-				   struct sk_buff *skb)
+static int nf_flow_ip6_tunnel_proto(struct nf_flowtable_ctx *ctx,
+				    struct sk_buff *skb)
+{
+	const struct inet6_protocol *ipprot;
+	struct ipv6hdr *ip6h;
+	int ret;
+
+	if (!pskb_may_pull(skb, sizeof(*ip6h) + ctx->offset))
+		return -1;
+
+	ip6h = (struct ipv6hdr *)(skb_network_header(skb) + ctx->offset);
+	if (ip6h->hop_limit <= 1)
+		return -1;
+
+	/* Initialize default values for extension headers parsing */
+	skb->transport_header = skb->network_header + sizeof(*ip6h) +
+				ctx->offset;
+	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr) + ctx->offset;
+
+	do {
+		unsigned int nhoff = IP6CB(skb)->nhoff;
+		u8 nexthdr;
+
+		if (!pskb_pull(skb, skb_transport_offset(skb)))
+			return -1;
+
+		nexthdr = skb_network_header(skb)[nhoff];
+		ipprot = rcu_dereference(inet6_protos[nexthdr]);
+		if (!ipprot)
+			break;
+
+		if (ipprot->flags & INET6_PROTO_FINAL) {
+			if (nexthdr == IPPROTO_IPV6) {
+				ctx->tun.offset = skb->transport_header -
+						  skb->network_header - ctx->offset;
+				ctx->tun.proto = IPPROTO_IPV6;
+			}
+			break;
+		}
+
+		ret = ipprot->handler(skb);
+		if (ret < 0)
+			return NF_STOLEN;
+	} while (ret > 0);
+
+	skb_push(skb, skb->transport_header - skb->network_header);
+	ctx->offset += ctx->tun.offset;
+
+	return 0;
+}
+
+static void nf_flow_ip_tunnel_pop(struct nf_flowtable_ctx *ctx,
+				  struct sk_buff *skb)
 {
-	if (ctx->tun.proto != IPPROTO_IPIP)
+	if (ctx->tun.proto != IPPROTO_IPIP &&
+	    ctx->tun.proto != IPPROTO_IPV6)
 		return;
 
 	skb_pull(skb, ctx->tun.offset);
@@ -362,8 +429,16 @@ static int nf_flow_skb_encap_protocol(struct nf_flowtable_ctx *ctx,
 		break;
 	}
 
-	if (inner_proto == htons(ETH_P_IP))
+	switch (inner_proto) {
+	case htons(ETH_P_IP):
 		ret = nf_flow_ip4_tunnel_proto(ctx, skb);
+		break;
+	case htons(ETH_P_IPV6):
+		ret = nf_flow_ip6_tunnel_proto(ctx, skb);
+		break;
+	default:
+		break;
+	}
 
 	return ret;
 }
@@ -395,8 +470,9 @@ static void nf_flow_encap_pop(struct nf_flowtable_ctx *ctx,
 		}
 	}
 
-	if (skb->protocol == htons(ETH_P_IP))
-		nf_flow_ip4_tunnel_pop(ctx, skb);
+	if (skb->protocol == htons(ETH_P_IP) ||
+	    skb->protocol == htons(ETH_P_IPV6))
+		nf_flow_ip_tunnel_pop(ctx, skb);
 }
 
 struct nf_flow_xmit {
@@ -901,10 +977,11 @@ nf_flow_offload_ipv6_lookup(struct nf_flowtable_ctx *ctx,
 			    struct sk_buff *skb)
 {
 	struct flow_offload_tuple tuple = {};
+	int err;
 
-	if (skb->protocol != htons(ETH_P_IPV6) &&
-	    nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IPV6)) < 0)
-		return NULL;
+	err = nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IPV6));
+	if (err)
+		return ERR_PTR(err);
 
 	if (nf_flow_tuple_ipv6(ctx, skb, &tuple) < 0)
 		return NULL;
@@ -931,8 +1008,8 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 	int ret;
 
 	tuplehash = nf_flow_offload_ipv6_lookup(&ctx, flow_table, skb);
-	if (tuplehash == NULL)
-		return NF_ACCEPT;
+	if (IS_ERR_OR_NULL(tuplehash))
+		return tuplehash == ERR_PTR(NF_STOLEN) ? NF_STOLEN : NF_ACCEPT;
 
 	ret = nf_flow_offload_ipv6_forward(&ctx, flow_table, tuplehash, skb);
 	if (ret < 0)

-- 
2.52.0


