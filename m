Return-Path: <linux-kselftest+bounces-47292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7D4CAF25C
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 08:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29A40300F70D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF24228C860;
	Tue,  9 Dec 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOLEOxmp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83880231827;
	Tue,  9 Dec 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265762; cv=none; b=EJYQnxBoyQRqcmk4UwOd9ZPpV0gCPmYxEnMwgpEBT55St34WtyXG2mudDwqBpMPTtc1KlqVj6zunsz8xLitCUd59i0/nZJT2H8xNeSc2fVHig6Zhdcz8i4Qj+olp6vC3VMYgzOWtOBdbWG13FfllqENEUJM+z9P/aFbaqe3QKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265762; c=relaxed/simple;
	bh=kPCS9EHzPpK8jeqWbMYwKcEID/4BecllDSSVyYGm2Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TjWoE1USRltsEOAifk23VVk0PM1xVzGiZursMSbH064cxWkhf1n/yunFwYKn4LLg1fLxbZSg//klAXxtCLTDA6wNcdrUqeZ/Zdy6IcGoLn0JcAGpUOejrmxExtLbc8TJ8IqomTF2kxbyfuQX388Lsdd/r3xcwzGcKsWZrlnliew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOLEOxmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37C6C4CEF5;
	Tue,  9 Dec 2025 07:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765265762;
	bh=kPCS9EHzPpK8jeqWbMYwKcEID/4BecllDSSVyYGm2Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bOLEOxmpPc1/MDbX5gEdXd04Ambq+cJvokkagjYMvt+aY3Ezzi/uYC+cmxzFWOBT4
	 4MCPCGKNbowYxnkr8jit94HggDH6wvIWcptL/9K9uej5UOPvi1uGgxGCEt6gngUXTN
	 ns4nwNo+FHTk5GEK3G8kUCz+0x02Eck5ee4YYYuKGY0b9GGTVMzhogThxzH7+tGsTs
	 ipZt5Fs6+ZRS1zDM2f77LvsNZky6uKk9Sv8ujROtw9BynqXrNBhgbZOA6rJonZulXq
	 ugYzwu7x+T9zqXZE8TRatDBNP0352ca6TUa7NnP47tEX4JuYdDxZe5SsW0eqopghbO
	 Jo9aEIuqBII5w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Dec 2025 08:35:31 +0100
Subject: [PATCH nf-next v2 1/4] netfilter: Introduce tunnel metadata info
 in nf_flowtable_ctx struct
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-b4-flowtable-offload-ip6ip6-v2-1-44817f1be5c6@kernel.org>
References: <20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org>
In-Reply-To: <20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org>
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
index e128b0fe9a7bf50b458df9940d629ea08c521871..14c01b59f76569170057d2465ee5953efb557bcc 100644
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


