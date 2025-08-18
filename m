Return-Path: <linux-kselftest+bounces-39215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F36CB29D44
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13274188E283
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61730DEB3;
	Mon, 18 Aug 2025 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TstHcKWU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58E530DD0E;
	Mon, 18 Aug 2025 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508104; cv=none; b=BaGFrI8mRs7ldvZgeoL6lHZzzLsL+9jXgUm3rg2NOXh2WF5eecHxmh90HDhdWVr2O9FQqrWDIWiWrZI804sI7i4tj3nKyJ3kL9aNHANHHWeUUCL8RiyOZNczydBcno58JtkGiRZUFGU8ijlupXjXs05NRADP04SChMZo32EbBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508104; c=relaxed/simple;
	bh=ApwpCUYs3fzJ2+Dn80RviNz/qn2l3oKHvPqUEmZjpMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c59KVq9w5es3NU3gwToWxR2YoHKUy4l53cwZ0bztj55kXB4pYO5f373ByOcxWyLDSeSXHKlxE11JJHYfIDaAdK0+c7YtbdyRUFcRD/ivAVxokgkXIkWOe7+xE7EvDuTfv+m8/usFZC0KgIXxjc67lY7mr5sWL4ossnfpGL9j85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TstHcKWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7184C4CEEB;
	Mon, 18 Aug 2025 09:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755508104;
	bh=ApwpCUYs3fzJ2+Dn80RviNz/qn2l3oKHvPqUEmZjpMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TstHcKWUs/dSGDK7L/ewvZd478H+N3HTpETejZVskH53Bpg7YBGPgmG1Yi3L8NJp7
	 1ZAFmEL6p9/raJTOsE5z7Yctiip1gtFVQ668ohA/uhFQOzHqw3GPGG9vRYs/5EAO9g
	 U/3o4aW4IMnx+UctGXVtMD4Ywlw7DKA0s8BGml8vDLWQsIPWHJZWXSCHBsp3Xr7K/f
	 wjM92Qy5LXJBvxCMUONGsoXv8eQBeJOsh+Nz0sKm/fIP7334tmU0QpUIPjudRJ38Si
	 vqjyY5Z/1t6GsaWYK+STeIudZ5qva1kenU75GjbzEu32b3T/Nw62pjrAn/QgMMW2PH
	 pXu1+QnrBbocA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 18 Aug 2025 11:07:33 +0200
Subject: [PATCH nf-next v6 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-nf-flowtable-ipip-v6-1-eda90442739c@kernel.org>
References: <20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org>
In-Reply-To: <20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
infrastructure.
IPIP SW acceleration can be tested running the following scenario where
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
- TCP stream transmitted into the IPIP tunnel:
  - net-next:				~41Gbps
  - net-next + IPIP flowtbale support:	~40Gbps
- TCP stream received from the IPIP tunnel:
  - net-next:				~35Gbps
  - net-next + IPIP flowtbale support:	~49Gbps

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h        |  1 +
 net/ipv4/ipip.c                  | 28 ++++++++++++++++++++
 net/netfilter/nf_flow_table_ip.c | 56 ++++++++++++++++++++++++++++++++++++++--
 net/netfilter/nft_flow_offload.c |  1 +
 4 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3a3b761abfb1b883a970b04634c1ef3e7ee5407..0527a4e3d1fd512b564e47311f6ce3957b66298f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -874,6 +874,7 @@ enum net_device_path_type {
 	DEV_PATH_PPPOE,
 	DEV_PATH_DSA,
 	DEV_PATH_MTK_WDMA,
+	DEV_PATH_IPENCAP,
 };
 
 struct net_device_path {
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..b7a3311bd061c341987380b5872caa8990d02e63 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -353,6 +353,33 @@ ipip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p, int cmd)
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
+	path->type = DEV_PATH_IPENCAP;
+	path->dev = ctx->dev;
+	path->encap.proto = htons(ETH_P_IP);
+	/* Use the hash of outer header IP src and dst addresses as
+	 * encapsulation ID. This must be kept in sync with
+	 * nf_flow_tuple_encap().
+	 */
+	path->encap.id = __ipv4_addr_hash(tiph->saddr, ntohl(tiph->daddr));
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
@@ -362,6 +389,7 @@ static const struct net_device_ops ipip_netdev_ops = {
 	.ndo_get_stats64 = dev_get_tstats64,
 	.ndo_get_iflink = ip_tunnel_get_iflink,
 	.ndo_tunnel_ctl	= ipip_tunnel_ctl,
+	.ndo_fill_forward_path = ipip_fill_forward_path,
 };
 
 #define IPIP_FEATURES (NETIF_F_SG |		\
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..454a2be3feafd181596374478a4ccd244f81d53b 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -147,6 +147,7 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
 {
 	struct vlan_ethhdr *veth;
 	struct pppoe_hdr *phdr;
+	struct iphdr *iph;
 	int i = 0;
 
 	if (skb_vlan_tag_present(skb)) {
@@ -165,6 +166,19 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
 		tuple->encap[i].id = ntohs(phdr->sid);
 		tuple->encap[i].proto = skb->protocol;
 		break;
+	case htons(ETH_P_IP):
+		iph = (struct iphdr *)skb_network_header(skb);
+		if (iph->protocol != IPPROTO_IPIP)
+			break;
+
+		tuple->encap[i].proto = htons(ETH_P_IP);
+		/* For IP tunnels the hash of outer header IP src and dst
+		 * addresses is used as encapsulation ID so it must be kept in
+		 * sync with IP tunnel ndo_fill_forward_path callbacks.
+		 */
+		tuple->encap[i].id = __ipv4_addr_hash(iph->daddr,
+						      ntohl(iph->saddr));
+		break;
 	}
 }
 
@@ -277,6 +291,40 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
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
+static void nf_flow_ip4_ecanp_pop(struct sk_buff *skb)
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
@@ -284,6 +332,8 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 	__be16 inner_proto;
 
 	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		return nf_flow_ip4_encap_proto(skb, offset);
 	case htons(ETH_P_8021Q):
 		if (!pskb_may_pull(skb, skb_mac_offset(skb) + sizeof(*veth)))
 			return false;
@@ -331,6 +381,9 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 			break;
 		}
 	}
+
+	if (skb->protocol == htons(ETH_P_IP))
+		nf_flow_ip4_ecanp_pop(skb);
 }
 
 static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
@@ -357,8 +410,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (skb->protocol != htons(ETH_P_IP) &&
-	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
+	if (!nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
 		return NULL;
 
 	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 225ff293cd50081a30fc82feeed5bb054f6387f0..4fe9a5e5dab839b17fc2acea835b72efccf7e1d9 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -108,6 +108,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		case DEV_PATH_DSA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
+		case DEV_PATH_IPENCAP:
 			info->indev = path->dev;
 			if (is_zero_ether_addr(info->h_source))
 				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);

-- 
2.50.1


