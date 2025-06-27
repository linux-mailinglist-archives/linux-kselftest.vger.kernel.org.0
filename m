Return-Path: <linux-kselftest+bounces-35968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E5FAEB7FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 14:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F3B1748FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A290A2D8777;
	Fri, 27 Jun 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFPmhAHy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4F29C33C;
	Fri, 27 Jun 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028353; cv=none; b=oXsVMEAaOYg9XChZxNEX9KobUb6yONkRxpXy3ZQRk2k+kQwZBhF+9ETurNVGfyF1QM2LrWX/R1yE5XWbi9UAoAQpy+QirYHN6F/W6SXdh/4LShHgDmloEwQLOKimR2tIsDFcjfj3zn7Axg/L91WKwDumGxFqfps34DA3PN4qys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028353; c=relaxed/simple;
	bh=hsjLKQRfLDcNP/V9hSu3aZuQ23lgsYSJ2Jdh9hBBnJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WH0ObzOaQFikKygw3zj0R7dO6G3tQQdPesTZPOtaccPr+eYisax9FfOuAtIE8NrhcaNFZiKnJ/cefgoMNknhNjHvvFIbdK0IaMiUDpStLbJXmjU8qTiNtjFwRQGolSFBH0WKdwxRrU4bF+2u5kVHkIxAqdNbGiHMHa84Pv2plcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFPmhAHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930E3C4CEE3;
	Fri, 27 Jun 2025 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751028352;
	bh=hsjLKQRfLDcNP/V9hSu3aZuQ23lgsYSJ2Jdh9hBBnJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VFPmhAHyOL6RgnNtdB2dGk5xyXiXj5X3Mp1mV/+Ln2WrNtjWfADoTpsnpOKToyNGI
	 cGPw/c6TyqqjYHyF3AI48TZ/72vXslYKrPn57u3NktOdse3JLVii8HhwqrpM5/W6z6
	 EKSW3aR0NpbhpmmyNYTpZqWdaKq5cVHpdDSjtbraDaRu6khRZ5kb3t+EydcCdgwgRF
	 htN1DXqEIAGbZBDRrVu0JfDTCFoVkJ/hSexgKb6+1ykYpmG1phNlzgiIVtbbjC2v81
	 qLHuvYTYt93J0reGe9T67KG0VeD6KhmWvwcsIzZGxXg3zuWGkgilZQh6fso2WfrSdA
	 il+m3MDOpzYlQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 27 Jun 2025 14:45:28 +0200
Subject: [PATCH net-next v2 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-nf-flowtable-ipip-v2-1-c713003ce75b@kernel.org>
References: <20250627-nf-flowtable-ipip-v2-0-c713003ce75b@kernel.org>
In-Reply-To: <20250627-nf-flowtable-ipip-v2-0-c713003ce75b@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
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

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
 net/netfilter/nf_flow_table_ip.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..05fb1c859170d74009d693bc8513183bdec3ff90 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -353,6 +353,26 @@ ipip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p, int cmd)
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
+	path->type = DEV_PATH_ETHERNET;
+	path->dev = ctx->dev;
+	ctx->dev = rt->dst.dev;
+	ip_rt_put(rt);
+
+	return 0;
+}
+
 static const struct net_device_ops ipip_netdev_ops = {
 	.ndo_init       = ipip_tunnel_init,
 	.ndo_uninit     = ip_tunnel_uninit,
@@ -362,6 +382,7 @@ static const struct net_device_ops ipip_netdev_ops = {
 	.ndo_get_stats64 = dev_get_tstats64,
 	.ndo_get_iflink = ip_tunnel_get_iflink,
 	.ndo_tunnel_ctl	= ipip_tunnel_ctl,
+	.ndo_fill_forward_path = ipip_fill_forward_path,
 };
 
 #define IPIP_FEATURES (NETIF_F_SG |		\
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..255ed53c11c927549dc87ffc6c399385e3fb68ff 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -277,13 +277,31 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 	return NF_STOLEN;
 }
 
+static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
+{
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, sizeof(*iph)))
+		return false;
+
+	iph = (struct iphdr *)skb_network_header(skb);
+	*size = iph->ihl << 2;
+
+	return iph->protocol == IPPROTO_IPIP;
+}
+
 static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 				       u32 *offset)
 {
 	struct vlan_ethhdr *veth;
 	__be16 inner_proto;
+	u16 size;
 
 	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (nf_flow_ip4_encap_proto(skb, &size))
+			*offset += size;
+		return true;
 	case htons(ETH_P_8021Q):
 		if (!pskb_may_pull(skb, skb_mac_offset(skb) + sizeof(*veth)))
 			return false;
@@ -310,6 +328,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 			      struct flow_offload_tuple_rhash *tuplehash)
 {
 	struct vlan_hdr *vlan_hdr;
+	u16 size;
 	int i;
 
 	for (i = 0; i < tuplehash->tuple.encap_num; i++) {
@@ -331,6 +350,12 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 			break;
 		}
 	}
+
+	if (skb->protocol == htons(ETH_P_IP) &&
+	    nf_flow_ip4_encap_proto(skb, &size)) {
+		skb_pull(skb, size);
+		skb_reset_network_header(skb);
+	}
 }
 
 static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
@@ -357,8 +382,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (skb->protocol != htons(ETH_P_IP) &&
-	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
+	if (!nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
 		return NULL;
 
 	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)

-- 
2.50.0


