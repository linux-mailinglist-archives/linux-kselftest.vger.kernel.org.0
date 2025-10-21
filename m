Return-Path: <linux-kselftest+bounces-43678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDCBF7F5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 19:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B9CC4FBA4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2434E741;
	Tue, 21 Oct 2025 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI4e5/Jj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6859257859;
	Tue, 21 Oct 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068928; cv=none; b=U7J6kqwCAnieqnb2MqzVnzIPs7Rw4ZIrjuUJ+ejI2Oe1bURusbOY19w3p2Wnri+4dJFogdvSIgSDMU7qsJKho2PqYT7Sh5QUyLYZSJyuYW6G9ITfganSDMolKsqTPD+Of59hhEjq4wgQsE8vaZVl8yzSw7kISyPoYGRvlm2BfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068928; c=relaxed/simple;
	bh=/YFEun8W68XfimRg8cMrjqeY9I4y84O2GAXdEHfmkeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oajIFvrlOY1muEzSqoR8UyFPa3szoWdejbTe1qMiRUC5ZCz8ettriaBPFd/2K43a8Ip1hMBvw97PV/TUATvmzAVlD6LXP7RpIP8AGfBya0kgX0wYRrxrYZx0ckI57ji4BZvOCaU3NtM8Q1Z9i+kJ5j8bspbyMuR70gHZzoSE5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI4e5/Jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55213C4CEF1;
	Tue, 21 Oct 2025 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068928;
	bh=/YFEun8W68XfimRg8cMrjqeY9I4y84O2GAXdEHfmkeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oI4e5/JjzuU0GD6hx6l8iRslAGDRWryUuw7ip7F53dQzfNlhgi1IaXZHFkFfvyj78
	 uMLeZ1IXG7YYInrgUTGVdcfzydNHtu7n7h+tcS5Sk+FpEhqBFWxwj9zPuw/k0ru1J8
	 mhkH+p26mnCfMNONHkXE2UX6yV7GkGgdU79YePTLZixCHAmDL8yOtJyAMzP2F1I2AV
	 BH3bm8qfUGED5cF8fo2p5IOf5PKDtyMZIjxucolGyE9JZXKEdNuWojIOmJF18uMQGY
	 revbfcm136k9LQnGncq5/f23acRSddL/9rDR0+ZYWXXmVuBi0P65oKxEl71g3UIRJ8
	 xonHDXlyZqVnQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 21 Oct 2025 19:48:18 +0200
Subject: [PATCH nf-next v7 1/3] net: netfilter: Add IPIP flowtable rx sw
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-nf-flowtable-ipip-v7-1-a45214896106@kernel.org>
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
 include/net/netfilter/nf_flow_table.h | 18 +++++++++++++
 net/ipv4/ipip.c                       | 25 +++++++++++++++++
 net/netfilter/nf_flow_table_core.c    |  8 ++++++
 net/netfilter/nf_flow_table_ip.c      | 51 +++++++++++++++++++++++++++++++++--
 net/netfilter/nft_flow_offload.c      | 29 +++++++++++++++++---
 6 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b275d45d105e336d2ede264fd310f1b..183e2b8b0111da86c3c3e4eb1bfe8fdba433dad5 100644
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
index c003cd194fa2ae40545a196fcc74e83c2868b113..bf712ac3fd970012d5360ff11c17315338527438 100644
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
@@ -129,6 +143,7 @@ struct flow_offload_tuple {
 		u16			id;
 		__be16			proto;
 	} encap[NF_FLOW_TABLE_ENCAP_MAX];
+	struct flow_offload_tunnel tun[NF_FLOW_TABLE_TUN_MAX];
 
 	/* All members above are keys for lookups, see flow_offload_hash(). */
 	struct { }			__hash;
@@ -136,6 +151,7 @@ struct flow_offload_tuple {
 	u8				dir:2,
 					xmit_type:3,
 					encap_num:2,
+					tun_num:2,
 					in_vlan_ingress:2;
 	u16				mtu;
 	union {
@@ -206,7 +222,9 @@ struct nf_flow_route {
 				u16		id;
 				__be16		proto;
 			} encap[NF_FLOW_TABLE_ENCAP_MAX];
+			struct flow_offload_tunnel tun[NF_FLOW_TABLE_TUN_MAX];
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
index 9441ac3d8c1a2eac32142ac43151e3acebcd8cab..4e08abc9bca705db36cbe26cf176e8f946722e32 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -118,7 +118,15 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 			flow_tuple->in_vlan_ingress |= BIT(j);
 		j++;
 	}
+
+	j = 0;
+	for (i = route->tuple[dir].in.num_tuns - 1; i >= 0; i--) {
+		flow_tuple->tun[j] = route->tuple[dir].in.tun[i];
+		j++;
+	}
+
 	flow_tuple->encap_num = route->tuple[dir].in.num_encaps;
+	flow_tuple->tun_num = route->tuple[dir].in.num_tuns;
 
 	switch (route->tuple[dir].xmit_type) {
 	case FLOW_OFFLOAD_XMIT_DIRECT:
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..0309dbff6e6219843fa7ec16a523d288c8274b77 100644
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
+			tuple->tun[i].src_v4.s_addr = iph->daddr;
+			tuple->tun[i].dst_v4.s_addr = iph->saddr;
+			tuple->tun[i].l3_proto = IPPROTO_IPIP;
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
 
 static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
@@ -357,8 +405,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (skb->protocol != htons(ETH_P_IP) &&
-	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
+	if (!nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
 		return NULL;
 
 	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 14dd1c0698c3c9ec2241b358deb80976a8aa4a13..e30abe026dd2a37cae2eea56257033a48e71af7c 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -86,6 +86,8 @@ struct nft_forward_info {
 		__be16	proto;
 	} encap[NF_FLOW_TABLE_ENCAP_MAX];
 	u8 num_encaps;
+	struct flow_offload_tunnel tun[NF_FLOW_TABLE_TUN_MAX];
+	u8 num_tuns;
 	u8 ingress_vlans;
 	u8 h_source[ETH_ALEN];
 	u8 h_dest[ETH_ALEN];
@@ -108,6 +110,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		case DEV_PATH_DSA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
+		case DEV_PATH_TUN:
 			info->indev = path->dev;
 			if (is_zero_ether_addr(info->h_source))
 				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
@@ -120,15 +123,29 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 			}
 
 			/* DEV_PATH_VLAN and DEV_PATH_PPPOE */
-			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
+			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX ||
+			    info->num_tuns >= NF_FLOW_TABLE_TUN_MAX) {
 				info->indev = NULL;
 				break;
 			}
 			if (!info->outdev)
 				info->outdev = path->dev;
-			info->encap[info->num_encaps].id = path->encap.id;
-			info->encap[info->num_encaps].proto = path->encap.proto;
-			info->num_encaps++;
+
+			if (path->type == DEV_PATH_TUN) {
+				info->tun[info->num_encaps].src_v6 =
+					path->tun.src_v6;
+				info->tun[info->num_encaps].dst_v6 =
+					path->tun.dst_v6;
+				info->tun[info->num_encaps].l3_proto =
+					path->tun.l3_proto;
+				info->num_tuns++;
+			} else {
+				info->encap[info->num_encaps].id =
+					path->encap.id;
+				info->encap[info->num_encaps].proto =
+					path->encap.proto;
+				info->num_encaps++;
+			}
 			if (path->type == DEV_PATH_PPPOE)
 				memcpy(info->h_dest, path->encap.h_dest, ETH_ALEN);
 			break;
@@ -207,7 +224,11 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
 		route->tuple[!dir].in.encap[i].id = info.encap[i].id;
 		route->tuple[!dir].in.encap[i].proto = info.encap[i].proto;
 	}
+	for (i = 0; i < info.num_tuns; i++)
+		route->tuple[!dir].in.tun[i] = info.tun[i];
+
 	route->tuple[!dir].in.num_encaps = info.num_encaps;
+	route->tuple[!dir].in.num_tuns = info.num_tuns;
 	route->tuple[!dir].in.ingress_vlans = info.ingress_vlans;
 
 	if (info.xmit_type == FLOW_OFFLOAD_XMIT_DIRECT) {

-- 
2.51.0


