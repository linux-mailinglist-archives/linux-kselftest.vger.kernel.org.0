Return-Path: <linux-kselftest+bounces-47235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84257CAB771
	for <lists+linux-kselftest@lfdr.de>; Sun, 07 Dec 2025 17:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C875A301A1D3
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CBE2BE05E;
	Sun,  7 Dec 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO3F/nSC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6826F29F;
	Sun,  7 Dec 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123638; cv=none; b=iy+bn8BelzSl+M/eTLHWSDdvmR8RASEFjeS2YIEUdOBQSZb5k8B4mX/SjcNE9MR01L98yoymUX2Q83H/jEs82QyQKDLORos68YFc9xAFKyrIaDYbR8c7suaE5zaM8wzyEgmyDNNdkJDAyjp+Oo0p6vyjp7k+U82Dt/KpZSOxsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123638; c=relaxed/simple;
	bh=w6He9R/Hlyw6jwU6nhRHXJegXeCypGoiTkklHlnX/k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGdeNovCUTilvfRd4nCLByQ4hP1PsHIOCFU1UBjg3g60EJXV30a2a7rYPfIYdbKHU4xEWDR/7b8JiunxV1uNrq1zrFIbAVPNlKRoLRugwhPrKOq3+1cUWBH74rnaW2US6Qrg7qYQXrYdGZV6LRjWfLVWV/RVMkZaEgep+X+ldsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO3F/nSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3419BC4CEFB;
	Sun,  7 Dec 2025 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765123637;
	bh=w6He9R/Hlyw6jwU6nhRHXJegXeCypGoiTkklHlnX/k4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MO3F/nSCVFWbBgoBq+INrhNIwstlLlNzxnrIzXN/dTazkeiSEbXIRa3g1WueEEXBl
	 wh77W94fVRbdlrCIUKBRQFw/lmA89ZKIES6rbLMQ8BoNZg7NH0Q+zd98cpUrIkkm/D
	 /BCroxAEazMlVdXKEM7XlfQ3fnuzSvL9pUbhlX4t3huhSgUbnOoLvoXlFFY/PAy4zv
	 bj0DY4HqtehD3Y5L2/FGuzooPhHldpcgkphAwcL/noB5f1Z1iConja5bFSHC6jVc2Z
	 T9cVRYSUeckW7KDBwf1jw4Tb5RVyA35ZpJx1BiCbmag+wGO9FLFqI95HhAnvU/6qSp
	 MelBxuBDl4Q2g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 07 Dec 2025 17:06:42 +0100
Subject: [PATCH nf-next 2/5] netfilter: Modify nf_flow_skb_encap_protocol()
 to return int intead of bool
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251207-b4-flowtable-offload-ip6ip6-v1-2-18e3ab7f748c@kernel.org>
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

Change nf_flow_skb_encap_protocol signature in order to return int error
code instead of a boolean value. This is a preliminary patch to introduce
IP6IP6 flowtable acceleration.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/netfilter/nf_flow_table_ip.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 14c01b59f76569170057d2465ee5953efb557bcc..9dbb4eed7724edbd68d386bb48bc237527ea7368 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -297,23 +297,23 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 	return NF_STOLEN;
 }
 
-static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
-				     struct sk_buff *skb)
+static int nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
+				    struct sk_buff *skb)
 {
 	struct iphdr *iph;
 	u16 size;
 
 	if (!pskb_may_pull(skb, sizeof(*iph) + ctx->offset))
-		return false;
+		return -1;
 
 	iph = (struct iphdr *)(skb_network_header(skb) + ctx->offset);
 	size = iph->ihl << 2;
 
 	if (ip_is_fragment(iph) || unlikely(ip_has_options(size)))
-		return false;
+		return -1;
 
 	if (iph->ttl <= 1)
-		return false;
+		return -1;
 
 	if (iph->protocol == IPPROTO_IPIP) {
 		ctx->tun.proto = IPPROTO_IPIP;
@@ -321,7 +321,7 @@ static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
 		ctx->offset += size;
 	}
 
-	return true;
+	return 0;
 }
 
 static void nf_flow_ip4_tunnel_pop(struct nf_flowtable_ctx *ctx,
@@ -334,30 +334,30 @@ static void nf_flow_ip4_tunnel_pop(struct nf_flowtable_ctx *ctx,
 	skb_reset_network_header(skb);
 }
 
-static bool nf_flow_skb_encap_protocol(struct nf_flowtable_ctx *ctx,
-				       struct sk_buff *skb, __be16 proto)
+static int nf_flow_skb_encap_protocol(struct nf_flowtable_ctx *ctx,
+				      struct sk_buff *skb, __be16 proto)
 {
 	__be16 inner_proto = skb->protocol;
 	struct vlan_ethhdr *veth;
-	bool ret = false;
+	int ret = -1;
 
 	switch (skb->protocol) {
 	case htons(ETH_P_8021Q):
 		if (!pskb_may_pull(skb, skb_mac_offset(skb) + sizeof(*veth)))
-			return false;
+			return -1;
 
 		veth = (struct vlan_ethhdr *)skb_mac_header(skb);
 		if (veth->h_vlan_encapsulated_proto == proto) {
 			ctx->offset += VLAN_HLEN;
 			inner_proto = proto;
-			ret = true;
+			ret = 0;
 		}
 		break;
 	case htons(ETH_P_PPP_SES):
 		if (nf_flow_pppoe_proto(skb, &inner_proto) &&
 		    inner_proto == proto) {
 			ctx->offset += PPPOE_SES_HLEN;
-			ret = true;
+			ret = 0;
 		}
 		break;
 	}
@@ -422,7 +422,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (!nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IP)))
+	if (nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IP)) < 0)
 		return NULL;
 
 	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)
@@ -903,7 +903,7 @@ nf_flow_offload_ipv6_lookup(struct nf_flowtable_ctx *ctx,
 	struct flow_offload_tuple tuple = {};
 
 	if (skb->protocol != htons(ETH_P_IPV6) &&
-	    !nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IPV6)))
+	    nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IPV6)) < 0)
 		return NULL;
 
 	if (nf_flow_tuple_ipv6(ctx, skb, &tuple) < 0)

-- 
2.52.0


