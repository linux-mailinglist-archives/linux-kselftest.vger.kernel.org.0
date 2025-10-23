Return-Path: <linux-kselftest+bounces-43853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A44AFC00042
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 10:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70A574FA021
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57463043C7;
	Thu, 23 Oct 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r98zRFTk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993532F6563;
	Thu, 23 Oct 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209436; cv=none; b=A/JhCvJChrHc9By/CutHSe+TtGTo5FlDUJ2KLKjAI42wqA3fIXy6BTnEOJxW2/kJjnpQAlO20C+r4l0GceJ3vqHX4WGwgeYLkoBHA+h6oCSUEIlW8FMSzdbmpSSUka9RLQeYmZga+hBs4R1rrMLhCbiuRP3caY/jBJH/XAl0gaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209436; c=relaxed/simple;
	bh=14WJruSdJrtoumOAdZSDh0zgGCqe6PaiZ8Vdh0PssV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rleYxgWlOrs/6hRu5Ki0rcA/XCZvu9uCBgFW6hPaaEZu6u/NE+PhZTHce1LlAFMbDhRbv/JGga+/ktaFTtHlQgSrWLSQXFIV0iimRmIz/azjXK4Ny5U0mzW6SPE2++wiJ1U9xasyraBBm+iYX125k2SxsbyYMZzo1NFrfMrzfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r98zRFTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97D1C4CEE7;
	Thu, 23 Oct 2025 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761209436;
	bh=14WJruSdJrtoumOAdZSDh0zgGCqe6PaiZ8Vdh0PssV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r98zRFTkDEcaaIuIZNV2fSbuzsf5hOsl6VLWXaA3IFWYoZTeQip9Y9ZUIzaUMMNqv
	 py4YH8e4ZIaOwZb/SB26l78fg74adNWcVYas71DAgGsZ8gzGCZ6maCpMkcSltG/YNl
	 xcU0YeOk0P5dxHXsL008GWYkXE5pcK2C/1wcOxitAsQ5dKI+tzbYUZJUzsS5eyRnuH
	 aHLq3r/ZTKwl4nSrFBA8bsZPqxDHAYkSop88AQEqs+wWi6k+9hvnDJlVZ7kPciVl4u
	 GmnClZ1CR/xO3Ew/5HE3VjLTZrxYrZ5LC+bQ9wlSAokk+Xv1WVPzhfeIorSzRT4Ivr
	 BJ6OQIIMKfC2A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 23 Oct 2025 10:50:15 +0200
Subject: [PATCH nf-next v8 1/3] net: netfilter: Add IPIP flowtable rx sw
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-nf-flowtable-ipip-v8-1-5d5d8595c730@kernel.org>
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

Introduce sw acceleration for rx path of IPIP tunnels relying on the
netfilter flowtable infrastructure. Subsequent patches will add sw
acceleration for IPIP tunnels tx path.
This series introduces basic infrastructure to accelerate other tunnel
types (e.g. IP6IP6).
IPIP rx sw acceleration can be tested running the following scenario where
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
- TCP stream received from the IPIP tunnel:
  - net-next: (baseline)		~ 71Gbps
  - net-next + IPIP flowtbale support:	~101Gbps

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h             | 13 +++++++++
 include/net/netfilter/nf_flow_table.h | 19 +++++++++++++
 net/ipv4/ipip.c                       | 25 +++++++++++++++++
 net/netfilter/nf_flow_table_core.c    |  3 +++
 net/netfilter/nf_flow_table_ip.c      | 51 +++++++++++++++++++++++++++++++++--
 net/netfilter/nf_flow_table_path.c    | 38 +++++++++++++++++++++-----
 6 files changed, 140 insertions(+), 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7f5aad5cc9a1994f95ba9037d3a4af27eef9d5e3..0355461960ce3c0db49e00a6f77f48b031a635dc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -874,6 +874,7 @@ enum net_device_path_type {
 	DEV_PATH_PPPOE,
 	DEV_PATH_DSA,
 	DEV_PATH_MTK_WDMA,
+	DEV_PATH_TUN,
 };
 
 struct net_device_path {
@@ -885,6 +886,18 @@ struct net_device_path {
 			__be16		proto;
 			u8		h_dest[ETH_ALEN];
 		} encap;
+		struct {
+			union {
+				struct in_addr	src_v4;
+				struct in6_addr	src_v6;
+			};
+			union {
+				struct in_addr	dst_v4;
+				struct in6_addr	dst_v6;
+			};
+
+			u8	l3_proto;
+		} tun;
 		struct {
 			enum {
 				DEV_PATH_BR_VLAN_KEEP,
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 89cfe72283983ad651a943919ab2141ef082977a..6d00a8aa52584ad96d200683297c1b02bf1f6d4f 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -106,6 +106,20 @@ enum flow_offload_xmit_type {
 };
 
 #define NF_FLOW_TABLE_ENCAP_MAX		2
+#define NF_FLOW_TABLE_TUN_MAX		2
+
+struct flow_offload_tunnel {
+	union {
+		struct in_addr	src_v4;
+		struct in6_addr	src_v6;
+	};
+	union {
+		struct in_addr	dst_v4;
+		struct in6_addr	dst_v6;
+	};
+
+	u8	l3_proto;
+};
 
 struct flow_offload_tuple {
 	union {
@@ -130,12 +144,15 @@ struct flow_offload_tuple {
 		__be16			proto;
 	} encap[NF_FLOW_TABLE_ENCAP_MAX];
 
+	struct flow_offload_tunnel tun;
+
 	/* All members above are keys for lookups, see flow_offload_hash(). */
 	struct { }			__hash;
 
 	u8				dir:2,
 					xmit_type:3,
 					encap_num:2,
+					tun_num:2,
 					in_vlan_ingress:2;
 	u16				mtu;
 	union {
@@ -206,7 +223,9 @@ struct nf_flow_route {
 				u16		id;
 				__be16		proto;
 			} encap[NF_FLOW_TABLE_ENCAP_MAX];
+			struct flow_offload_tunnel tun;
 			u8			num_encaps:2,
+						num_tuns:2,
 						ingress_vlans:2;
 		} in;
 		struct {
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..ff95b1b9908e9f4ba4bff207a5bd2c5d5670215a 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -353,6 +353,30 @@ ipip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p, int cmd)
 	return ip_tunnel_ctl(dev, p, cmd);
 }
 
+static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
+				  struct net_device_path *path)
+{
+	struct ip_tunnel *tunnel = netdev_priv(ctx->dev);
+	const struct iphdr *tiph = &tunnel->parms.iph;
+	struct rtable *rt;
+
+	rt = ip_route_output(dev_net(ctx->dev), tiph->daddr, 0, 0, 0,
+			     RT_SCOPE_UNIVERSE);
+	if (IS_ERR(rt))
+		return PTR_ERR(rt);
+
+	path->type = DEV_PATH_TUN;
+	path->tun.src_v4.s_addr = tiph->saddr;
+	path->tun.dst_v4.s_addr = tiph->daddr;
+	path->tun.l3_proto = IPPROTO_IPIP;
+	path->dev = ctx->dev;
+
+	ctx->dev = rt->dst.dev;
+	ip_rt_put(rt);
+
+	return 0;
+}
+
 static const struct net_device_ops ipip_netdev_ops = {
 	.ndo_init       = ipip_tunnel_init,
 	.ndo_uninit     = ip_tunnel_uninit,
@@ -362,6 +386,7 @@ static const struct net_device_ops ipip_netdev_ops = {
 	.ndo_get_stats64 = dev_get_tstats64,
 	.ndo_get_iflink = ip_tunnel_get_iflink,
 	.ndo_tunnel_ctl	= ipip_tunnel_ctl,
+	.ndo_fill_forward_path = ipip_fill_forward_path,
 };
 
 #define IPIP_FEATURES (NETIF_F_SG |		\
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 6c6a5165f9933b130e772c096a01d3fcb1d61c94..06e8251a6644e2335117ae3720b9ebf159eb2264 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -118,7 +118,10 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 			flow_tuple->in_vlan_ingress |= BIT(j);
 		j++;
 	}
+
+	flow_tuple->tun = route->tuple[dir].in.tun;
 	flow_tuple->encap_num = route->tuple[dir].in.num_encaps;
+	flow_tuple->tun_num = route->tuple[dir].in.num_tuns;
 
 	switch (route->tuple[dir].xmit_type) {
 	case FLOW_OFFLOAD_XMIT_DIRECT:
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index be21600cff5390202f5451cd76c4e2afc6f8bc00..76081d5d2f71c10e0c65e906b3fb2769e3ab1466 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -147,6 +147,7 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
 {
 	struct vlan_ethhdr *veth;
 	struct pppoe_hdr *phdr;
+	struct iphdr *iph;
 	int i = 0;
 
 	if (skb_vlan_tag_present(skb)) {
@@ -165,6 +166,14 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
 		tuple->encap[i].id = ntohs(phdr->sid);
 		tuple->encap[i].proto = skb->protocol;
 		break;
+	case htons(ETH_P_IP):
+		iph = (struct iphdr *)skb_network_header(skb);
+		if (iph->protocol == IPPROTO_IPIP) {
+			tuple->tun.dst_v4.s_addr = iph->daddr;
+			tuple->tun.src_v4.s_addr = iph->saddr;
+			tuple->tun.l3_proto = IPPROTO_IPIP;
+		}
+		break;
 	}
 }
 
@@ -277,6 +286,40 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 	return NF_STOLEN;
 }
 
+static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u32 *psize)
+{
+	struct iphdr *iph;
+	u16 size;
+
+	if (!pskb_may_pull(skb, sizeof(*iph)))
+		return false;
+
+	iph = (struct iphdr *)skb_network_header(skb);
+	size = iph->ihl << 2;
+
+	if (ip_is_fragment(iph) || unlikely(ip_has_options(size)))
+		return false;
+
+	if (iph->ttl <= 1)
+		return false;
+
+	if (iph->protocol == IPPROTO_IPIP)
+		*psize += size;
+
+	return true;
+}
+
+static void nf_flow_ip4_encap_pop(struct sk_buff *skb)
+{
+	struct iphdr *iph = (struct iphdr *)skb_network_header(skb);
+
+	if (iph->protocol != IPPROTO_IPIP)
+		return;
+
+	skb_pull(skb, iph->ihl << 2);
+	skb_reset_network_header(skb);
+}
+
 static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 				       u32 *offset)
 {
@@ -284,6 +327,8 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 	__be16 inner_proto;
 
 	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		return nf_flow_ip4_encap_proto(skb, offset);
 	case htons(ETH_P_8021Q):
 		if (!pskb_may_pull(skb, skb_mac_offset(skb) + sizeof(*veth)))
 			return false;
@@ -331,6 +376,9 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 			break;
 		}
 	}
+
+	if (skb->protocol == htons(ETH_P_IP))
+		nf_flow_ip4_encap_pop(skb);
 }
 
 struct nf_flow_xmit {
@@ -356,8 +404,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (skb->protocol != htons(ETH_P_IP) &&
-	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
+	if (!nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
 		return NULL;
 
 	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 50b2b7d0c579ec0855f5870d1e1f7d6f74db0e8f..bd5e9bf1ca393ab793976ba98a027b60f84882ba 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -80,6 +80,8 @@ struct nft_forward_info {
 		__be16	proto;
 	} encap[NF_FLOW_TABLE_ENCAP_MAX];
 	u8 num_encaps;
+	struct flow_offload_tunnel tun;
+	u8 num_tuns;
 	u8 ingress_vlans;
 	u8 h_source[ETH_ALEN];
 	u8 h_dest[ETH_ALEN];
@@ -102,6 +104,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		case DEV_PATH_DSA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
+		case DEV_PATH_TUN:
 			info->indev = path->dev;
 			if (is_zero_ether_addr(info->h_source))
 				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
@@ -113,14 +116,27 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				break;
 			}
 
-			/* DEV_PATH_VLAN and DEV_PATH_PPPOE */
-			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
-				info->indev = NULL;
-				break;
+			/* DEV_PATH_VLAN, DEV_PATH_PPPOE and DEV_PATH_TUN */
+			if (path->type == DEV_PATH_TUN) {
+				if (info->num_tuns) {
+					info->indev = NULL;
+					break;
+				}
+				info->tun.src_v6 = path->tun.src_v6;
+				info->tun.dst_v6 = path->tun.dst_v6;
+				info->tun.l3_proto = path->tun.l3_proto;
+				info->num_tuns++;
+			} else {
+				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
+					info->indev = NULL;
+					break;
+				}
+				info->encap[info->num_encaps].id =
+					path->encap.id;
+				info->encap[info->num_encaps].proto =
+					path->encap.proto;
+				info->num_encaps++;
 			}
-			info->encap[info->num_encaps].id = path->encap.id;
-			info->encap[info->num_encaps].proto = path->encap.proto;
-			info->num_encaps++;
 			if (path->type == DEV_PATH_PPPOE)
 				memcpy(info->h_dest, path->encap.h_dest, ETH_ALEN);
 			break;
@@ -196,6 +212,14 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
 		route->tuple[!dir].in.encap[i].id = info.encap[i].id;
 		route->tuple[!dir].in.encap[i].proto = info.encap[i].proto;
 	}
+
+	route->tuple[!dir].in.num_tuns = info.num_tuns;
+	if (route->tuple[!dir].in.num_tuns) {
+		route->tuple[!dir].in.tun.src_v6 = info.tun.dst_v6;
+		route->tuple[!dir].in.tun.dst_v6 = info.tun.src_v6;
+		route->tuple[!dir].in.tun.l3_proto = info.tun.l3_proto;
+	}
+
 	route->tuple[!dir].in.num_encaps = info.num_encaps;
 	route->tuple[!dir].in.ingress_vlans = info.ingress_vlans;
 	route->tuple[dir].out.ifindex = info.outdev->ifindex;

-- 
2.51.0


