Return-Path: <linux-kselftest+bounces-36435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFAAF7707
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B080B165576
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D842E9756;
	Thu,  3 Jul 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfUTInjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8B1AAA1C;
	Thu,  3 Jul 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552213; cv=none; b=gjYPALXvzbBIITqls0soZQQuiSorq8QDTcISER0I2I3n+vmFGRaSrXRj2wohgjkdN47e5F8hN7XUdENj4HgA5RsSJJjg6m0oD2zAlLfnXaZh1I76kWJPX5MtA4LHvbYjl9dRHVkvcd6zHq8IhmJZX4l6VIHAEluTVdmskiIEUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552213; c=relaxed/simple;
	bh=lpHAc4mfs7T76J0e5F+OPBHeFEvENi2OjFWd80qqvkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaFwBi9geN6bXxK0YW71SawvEG8ViTRMP6sBtbfo9zakrR80EsTM+kvgMdmncxDgeLAB8G0FCYN8z4RVhkq6qVipAbJbfY1D1Vj4yW7yU5Ma/xQORxoJ5ZZzXQUV5lk+u73kPIo22GAdpBgldYkFSQSKdQEIaTH9WV20JAacEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfUTInjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89939C4CEE3;
	Thu,  3 Jul 2025 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751552212;
	bh=lpHAc4mfs7T76J0e5F+OPBHeFEvENi2OjFWd80qqvkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LfUTInjpxTxuU+W0H2cPLJ+GimpCYapM0+OA+hmmgXW6haGm7x36SdxGqOE7fbrEX
	 J5J0w+oYchKyOkt0WF12P3AfUj3fV8iG/Qqyghzrrf1vFaUTMH6e0987mH9goz/osR
	 LvxWlJrxAOi/dveH5ieArqtknmw7kutK2X3+5mY6Nm1uKEfNIo7fn2uYEGpXTNGrBa
	 zh+BDauu0kbK1DwglGsUncWdu4u2l3f+/5yOTiRoSsBS40Dgc6sswUcRMSnV7z60Ax
	 e6+Fv8o3zgI4ovA3M98ocRnuyi8c+0PIOqiPdP9GuUtUbsVRJQpLS8Vk4J7Hm/jHxO
	 M8kDeShfexvxw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 03 Jul 2025 16:16:02 +0200
Subject: [PATCH nf-next v3 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-nf-flowtable-ipip-v3-1-880afd319b9f@kernel.org>
References: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
In-Reply-To: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
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
 net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
 net/netfilter/nf_flow_table_ip.c | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

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
index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..6b55e00b1022f0a2b02d9bfd1bd34bb55c1b83f7 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -277,13 +277,37 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
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
+	if (ip_is_fragment(iph) || unlikely(ip_has_options(*size)))
+		return false;
+
+	if (iph->ttl <= 1)
+		return false;
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
@@ -310,6 +334,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 			      struct flow_offload_tuple_rhash *tuplehash)
 {
 	struct vlan_hdr *vlan_hdr;
+	u16 size;
 	int i;
 
 	for (i = 0; i < tuplehash->tuple.encap_num; i++) {
@@ -331,6 +356,12 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
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
@@ -357,8 +388,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (skb->protocol != htons(ETH_P_IP) &&
-	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
+	if (!nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
 		return NULL;
 
 	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)

-- 
2.50.0


