Return-Path: <linux-kselftest+bounces-46804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E053EC97B2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74C744E28AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DBF319847;
	Mon,  1 Dec 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlCLQzHY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD08314D0B;
	Mon,  1 Dec 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596739; cv=none; b=TZ5ZkETE0IpTUpRzEHM2mUd+LXwxFlthHz7d9euP3uFcZ+hY5cZ+U6GRHXdggXd+GHJaVh9KKQgz0ArO9uAdlvqOWPjPj9CXG2lKRNDB4D1h8tUKkWi+uz0LPI/j2EsAsSBSs/eeoc4WDInb4CN+LvX1Ki/Hi64XxomZRBi1h7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596739; c=relaxed/simple;
	bh=x/QxMFeIr+c4wkT0b+4yMPx5k0Plqa/qd3dvxGSc00Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6yal2BWkzIKi0M0v70fBT35W7I1C/P3VKXEDZm9CY+DsGts9GUyni6x+xeu5HIZaHlK2H2I014fj9ER7mokSsWt5fU1hq+SwIxStuGUW599CxhhULgiWu9q3xQlqM4/NHL29SJhBsvg8ToXEtrUeaNvs6i1v/OKQ0QlMaYTu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlCLQzHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6873C4CEF1;
	Mon,  1 Dec 2025 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764596739;
	bh=x/QxMFeIr+c4wkT0b+4yMPx5k0Plqa/qd3dvxGSc00Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nlCLQzHYdbGgAAcWhtcmr3UQY3AYX311/SObsV98fyVjZ16Bx6jmItWKKRJGcYWxk
	 5eVsAmvCrSAXCq9VBl29rlb/lTR4xHhRIQ+c+DbI/7EZz1hGJp9Rdn1MLcMVR96/wR
	 Il6e8bQQg/L6e3tO/r8pY/9Zu/BjWCEK6fhcEy4gxVf2Svxav3w/uuZl9Rt8zFm+VB
	 B84zfmrMCxzcfLIFH7CXytWipp9EPkkBS0BlLWCjLdzEkkoafiqyd3CUodDt1vCRlj
	 R/vjtwg4F3a862z39g8eRvgIcrqynUxYwZOkHTUmxrHbhAHT5/Ygsz1CbOsSIngk8Y
	 wBNhx80MLrZ7Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 01 Dec 2025 14:45:13 +0100
Subject: [PATCH RFC nf-next 1/4] netfilter: Introduce tunnel metadata info
 in nf_flowtable_ctx struct
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-flowtable-offload-ip6ip6-v1-1-1dabf534c074@kernel.org>
References: <20251201-flowtable-offload-ip6ip6-v1-0-1dabf534c074@kernel.org>
In-Reply-To: <20251201-flowtable-offload-ip6ip6-v1-0-1dabf534c074@kernel.org>
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

This is a preliminary patch to introduce IP6IP6 flowtable acceleration.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/netfilter/nf_flow_table_ip.c | 80 ++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 78883343e5d686014752ec4fe1a28319cbf08845..d28c256d33dc5a8d07490b765747b5c6c48aa67d 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -142,7 +142,18 @@ static bool ip_has_options(unsigned int thoff)
 	return thoff != sizeof(struct iphdr);
 }
 
-static void nf_flow_tuple_encap(struct sk_buff *skb,
+struct nf_flowtable_ctx {
+	const struct net_device	*in;
+	u32			offset;
+	u32			hdrsize;
+	struct {
+		u32 offset;
+		u8 proto;
+	} tun;
+};
+
+static void nf_flow_tuple_encap(struct nf_flowtable_ctx *ctx,
+				struct sk_buff *skb,
 				struct flow_offload_tuple *tuple)
 {
 	__be16 inner_proto = skb->protocol;
@@ -174,22 +185,15 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
 		break;
 	}
 
-	if (inner_proto == htons(ETH_P_IP)) {
+	if (inner_proto == htons(ETH_P_IP) &&
+	    ctx->tun.proto == IPPROTO_IPIP) {
 		iph = (struct iphdr *)(skb_network_header(skb) + offset);
-		if (iph->protocol == IPPROTO_IPIP) {
-			tuple->tun.dst_v4.s_addr = iph->daddr;
-			tuple->tun.src_v4.s_addr = iph->saddr;
-			tuple->tun.l3_proto = IPPROTO_IPIP;
-		}
+		tuple->tun.dst_v4.s_addr = iph->daddr;
+		tuple->tun.src_v4.s_addr = iph->saddr;
+		tuple->tun.l3_proto = IPPROTO_IPIP;
 	}
 }
 
-struct nf_flowtable_ctx {
-	const struct net_device	*in;
-	u32			offset;
-	u32			hdrsize;
-};
-
 static int nf_flow_tuple_ip(struct nf_flowtable_ctx *ctx, struct sk_buff *skb,
 			    struct flow_offload_tuple *tuple)
 {
@@ -257,7 +261,7 @@ static int nf_flow_tuple_ip(struct nf_flowtable_ctx *ctx, struct sk_buff *skb,
 	tuple->l3proto		= AF_INET;
 	tuple->l4proto		= ipproto;
 	tuple->iifidx		= ctx->in->ifindex;
-	nf_flow_tuple_encap(skb, tuple);
+	nf_flow_tuple_encap(ctx, skb, tuple);
 
 	return 0;
 }
@@ -293,15 +297,16 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 	return NF_STOLEN;
 }
 
-static bool nf_flow_ip4_tunnel_proto(struct sk_buff *skb, u32 *psize)
+static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
+				     struct sk_buff *skb)
 {
 	struct iphdr *iph;
 	u16 size;
 
-	if (!pskb_may_pull(skb, sizeof(*iph) + *psize))
+	if (!pskb_may_pull(skb, sizeof(*iph) + ctx->offset))
 		return false;
 
-	iph = (struct iphdr *)(skb_network_header(skb) + *psize);
+	iph = (struct iphdr *)(skb_network_header(skb) + ctx->offset);
 	size = iph->ihl << 2;
 
 	if (ip_is_fragment(iph) || unlikely(ip_has_options(size)))
@@ -310,25 +315,27 @@ static bool nf_flow_ip4_tunnel_proto(struct sk_buff *skb, u32 *psize)
 	if (iph->ttl <= 1)
 		return false;
 
-	if (iph->protocol == IPPROTO_IPIP)
-		*psize += size;
+	if (iph->protocol == IPPROTO_IPIP) {
+		ctx->tun.proto = IPPROTO_IPIP;
+		ctx->tun.offset = size;
+		ctx->offset += size;
+	}
 
 	return true;
 }
 
-static void nf_flow_ip4_tunnel_pop(struct sk_buff *skb)
+static void nf_flow_ip4_tunnel_pop(struct nf_flowtable_ctx *ctx,
+				   struct sk_buff *skb)
 {
-	struct iphdr *iph = (struct iphdr *)skb_network_header(skb);
-
-	if (iph->protocol != IPPROTO_IPIP)
+	if (ctx->tun.proto != IPPROTO_IPIP)
 		return;
 
-	skb_pull(skb, iph->ihl << 2);
+	skb_pull(skb, ctx->tun.offset);
 	skb_reset_network_header(skb);
 }
 
-static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
-				       u32 *offset)
+static bool nf_flow_skb_encap_protocol(struct nf_flowtable_ctx *ctx,
+				       struct sk_buff *skb, __be16 proto)
 {
 	__be16 inner_proto = skb->protocol;
 	struct vlan_ethhdr *veth;
@@ -341,7 +348,7 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 
 		veth = (struct vlan_ethhdr *)skb_mac_header(skb);
 		if (veth->h_vlan_encapsulated_proto == proto) {
-			*offset += VLAN_HLEN;
+			ctx->offset += VLAN_HLEN;
 			inner_proto = proto;
 			ret = true;
 		}
@@ -349,19 +356,20 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 	case htons(ETH_P_PPP_SES):
 		if (nf_flow_pppoe_proto(skb, &inner_proto) &&
 		    inner_proto == proto) {
-			*offset += PPPOE_SES_HLEN;
+			ctx->offset += PPPOE_SES_HLEN;
 			ret = true;
 		}
 		break;
 	}
 
 	if (inner_proto == htons(ETH_P_IP))
-		ret = nf_flow_ip4_tunnel_proto(skb, offset);
+		ret = nf_flow_ip4_tunnel_proto(ctx, skb);
 
 	return ret;
 }
 
-static void nf_flow_encap_pop(struct sk_buff *skb,
+static void nf_flow_encap_pop(struct nf_flowtable_ctx *ctx,
+			      struct sk_buff *skb,
 			      struct flow_offload_tuple_rhash *tuplehash)
 {
 	struct vlan_hdr *vlan_hdr;
@@ -388,7 +396,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 	}
 
 	if (skb->protocol == htons(ETH_P_IP))
-		nf_flow_ip4_tunnel_pop(skb);
+		nf_flow_ip4_tunnel_pop(ctx, skb);
 }
 
 struct nf_flow_xmit {
@@ -414,7 +422,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (!nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
+	if (!nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IP)))
 		return NULL;
 
 	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)
@@ -458,7 +466,7 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 
 	flow_offload_refresh(flow_table, flow, false);
 
-	nf_flow_encap_pop(skb, tuplehash);
+	nf_flow_encap_pop(ctx, skb, tuplehash);
 	thoff -= ctx->offset;
 
 	iph = ip_hdr(skb);
@@ -836,7 +844,7 @@ static int nf_flow_tuple_ipv6(struct nf_flowtable_ctx *ctx, struct sk_buff *skb,
 	tuple->l3proto		= AF_INET6;
 	tuple->l4proto		= nexthdr;
 	tuple->iifidx		= ctx->in->ifindex;
-	nf_flow_tuple_encap(skb, tuple);
+	nf_flow_tuple_encap(ctx, skb, tuple);
 
 	return 0;
 }
@@ -873,7 +881,7 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
 
 	flow_offload_refresh(flow_table, flow, false);
 
-	nf_flow_encap_pop(skb, tuplehash);
+	nf_flow_encap_pop(ctx, skb, tuplehash);
 
 	ip6h = ipv6_hdr(skb);
 	nf_flow_nat_ipv6(flow, skb, dir, ip6h);
@@ -895,7 +903,7 @@ nf_flow_offload_ipv6_lookup(struct nf_flowtable_ctx *ctx,
 	struct flow_offload_tuple tuple = {};
 
 	if (skb->protocol != htons(ETH_P_IPV6) &&
-	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IPV6), &ctx->offset))
+	    !nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IPV6)))
 		return NULL;
 
 	if (nf_flow_tuple_ipv6(ctx, skb, &tuple) < 0)

-- 
2.52.0


