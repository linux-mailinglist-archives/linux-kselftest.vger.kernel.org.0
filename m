Return-Path: <linux-kselftest+bounces-49130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC889D2DCCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 917003017C6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DDD2F49F8;
	Fri, 16 Jan 2026 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPWneDrX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAFB281520;
	Fri, 16 Jan 2026 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551236; cv=none; b=rf/4nlaD2kC9jETCCzNmy1JCtrLfAfrvdcZlbzYYKK7Df1XBzFPl/JEn00nq6+z3LdPKhnznqKa57RHi76OR1HgSW/pLCMPcHW2rF2Vsd5cw+xq+vlq96LdZwwSa/NdaX9kREJzGc7E7Vbo+pleRK/AnKwfqV4ajRqdVCYSxoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551236; c=relaxed/simple;
	bh=EmL6JvAhueJYF4kz9kLX+aW0h/brSDVHJjPYOXFPjhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwQeLNer7RdXFeML32zLdBue2PQk1NikryuBQXYNQO0naMCutxtpYTsWu5goWft7TA4vy8miIh1K2Tjt7NF9mzMJuXmziUbkIryZ3UqyNpZF6NgZFUYHtZ5IjssTQfWK45nK7jLZVoZ68Qw7GpHxkbQc5N5eCbSy4HDt6WxEisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPWneDrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40DFC116C6;
	Fri, 16 Jan 2026 08:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551236;
	bh=EmL6JvAhueJYF4kz9kLX+aW0h/brSDVHJjPYOXFPjhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kPWneDrXsFXnuaQN8X9b0UaASVvLsO9VILmf9jMol6UN/rB9F56VldaSWr3+Ild1a
	 cOWFFC2FMTY54YLzHydZkl9+NptMRv/dSU2xOisng8S4hi7Tdp+6NKitfnXH/kKhEx
	 6wHHle1e13j3kzEvuqZwrDDblDZMgIVSRd0aIZHhbIy1EZI/OE4lWishtJ3XoU95F8
	 c0x9f1avH7Q8hMqwTzVmTHKQMaMj6Yf1loauGTfFYK9MvjyPoJxhUXlrP76cAOOLGA
	 5GmnejWHUrokueFct6kEZppH1E5vvo8V44veCxsL62GahHoLNwPRdhDCi9sW6oufI5
	 yWDrQdaiKa9xw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 16 Jan 2026 09:13:19 +0100
Subject: [PATCH nf-next v3 2/5] netfilter: Introduce tunnel metadata info
 in nf_flowtable_ctx struct
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-b4-flowtable-offload-ip6ip6-v3-2-c1fcad85a905@kernel.org>
References: <20260116-b4-flowtable-offload-ip6ip6-v3-0-c1fcad85a905@kernel.org>
In-Reply-To: <20260116-b4-flowtable-offload-ip6ip6-v3-0-c1fcad85a905@kernel.org>
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

Add tunnel hdr_size and tunnel proto fields in nf_flowtable_ctx struct
in order to store IP tunnel header size and protocol used during IPIP
and IP6IP6 tunnel sw offloading decapsulation and avoid recomputing them
during tunnel header pop since this is constant for IPv6.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/netfilter/nf_flow_table_ip.c | 41 ++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 8d3fbeaca2df110180414d44b28475adce8724ae..7d86653478c39cce2e321f3df73dbfde6f7c3e33 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -142,6 +142,18 @@ static bool ip_has_options(unsigned int thoff)
 	return thoff != sizeof(struct iphdr);
 }
 
+struct nf_flowtable_ctx {
+	const struct net_device	*in;
+	u32			offset;
+	u32			hdrsize;
+	struct {
+		/* Tunnel IP header size */
+		u32 hdr_size;
+		/* IP tunnel protocol */
+		u8 proto;
+	} tun;
+};
+
 static void nf_flow_tuple_encap(struct sk_buff *skb,
 				struct flow_offload_tuple *tuple)
 {
@@ -184,12 +196,6 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
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
@@ -311,20 +317,22 @@ static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
 	if (iph->ttl <= 1)
 		return false;
 
-	if (iph->protocol == IPPROTO_IPIP)
+	if (iph->protocol == IPPROTO_IPIP) {
+		ctx->tun.proto = IPPROTO_IPIP;
+		ctx->tun.hdr_size = size;
 		ctx->offset += size;
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
+	skb_pull(skb, ctx->tun.hdr_size);
 	skb_reset_network_header(skb);
 }
 
@@ -362,7 +370,8 @@ static bool nf_flow_skb_encap_protocol(struct nf_flowtable_ctx *ctx,
 	return ret;
 }
 
-static void nf_flow_encap_pop(struct sk_buff *skb,
+static void nf_flow_encap_pop(struct nf_flowtable_ctx *ctx,
+			      struct sk_buff *skb,
 			      struct flow_offload_tuple_rhash *tuplehash)
 {
 	struct vlan_hdr *vlan_hdr;
@@ -389,7 +398,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 	}
 
 	if (skb->protocol == htons(ETH_P_IP))
-		nf_flow_ip4_tunnel_pop(skb);
+		nf_flow_ip4_tunnel_pop(ctx, skb);
 }
 
 struct nf_flow_xmit {
@@ -459,7 +468,7 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 
 	flow_offload_refresh(flow_table, flow, false);
 
-	nf_flow_encap_pop(skb, tuplehash);
+	nf_flow_encap_pop(ctx, skb, tuplehash);
 	thoff -= ctx->offset;
 
 	iph = ip_hdr(skb);
@@ -874,7 +883,7 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
 
 	flow_offload_refresh(flow_table, flow, false);
 
-	nf_flow_encap_pop(skb, tuplehash);
+	nf_flow_encap_pop(ctx, skb, tuplehash);
 
 	ip6h = ipv6_hdr(skb);
 	nf_flow_nat_ipv6(flow, skb, dir, ip6h);

-- 
2.52.0


