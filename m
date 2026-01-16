Return-Path: <linux-kselftest+bounces-49129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D952BD2DDD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F7EE3055D88
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF62F8BD3;
	Fri, 16 Jan 2026 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl7wcZB4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFA2F49F8;
	Fri, 16 Jan 2026 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551234; cv=none; b=djCPVwsC97u8HDYVZc/hLUo/m4619uzqgaUqlwf+Esw2APeNJ+bMrKpsgJY6SVmNpuA2B6wHNxoHX+CsTUXMpG97Cnttz1/7urUtccb6hK2tey5iKdtZ17mt/meAtm6/vkV6iBV+VaqRxNUH3F+NpAPhitNFbvKooDAOFyhPZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551234; c=relaxed/simple;
	bh=Vb0BDsIkdF+pAP1UDkQuPP/llPkZVJAR7tMLh1xpciI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qm0pImR9HxPXlaxpCzN+fdnVcVALhawbU5h1XhLvEZQi763T0VxlMx7dkUqt5u1r4w3qqR9nzMaNYYgOdwTrqm+vs/w4kBpR8zAWQY9eaASp4K7J24iKxMf0HG8rUqrwmb2WQFuFNIBSs3YkEPPdawcmYnbkjWg9vnUMvHuTncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl7wcZB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206FAC116C6;
	Fri, 16 Jan 2026 08:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551233;
	bh=Vb0BDsIkdF+pAP1UDkQuPP/llPkZVJAR7tMLh1xpciI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sl7wcZB4a4OQmMLcGU6zemV2FV65CE9alp8TEpuVXKeEtVsQwlv2IsSbDAsnV9FcZ
	 +20zbQuk18tEZEorLEpypLOtTQoNHbSqohkWP0xs/a597trjDbms0keWdZcJWYQsxg
	 pMngJHwpUoYk/CbksuFzXBzoNYg/p2vpj1q0OX8hqS6+/R89MgUcLLv+1D3ABXZirW
	 OZfJ02g22gJ6RnHeSNHNffDUuEjKzXKozQVVHLxLWAZuDcTtlgY14ZowCkZ4GmsD9G
	 BsPMuPw7AFD5aq52UjlszeWcwoy60lAuRWRCKMKuE8h5QJV2V7Jjs7RuREQlqL2R2o
	 C5bnmsR5kvuGg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 16 Jan 2026 09:13:18 +0100
Subject: [PATCH nf-next v3 1/5] netfilter: Add ctx pointer in
 nf_flow_skb_encap_protocol/nf_flow_ip4_tunnel_proto signature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-b4-flowtable-offload-ip6ip6-v3-1-c1fcad85a905@kernel.org>
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

Rely on nf_flowtable_ctx struct pointer in nf_flow_ip4_tunnel_proto and
nf_flow_skb_encap_protocol routine signature. This is a preliminary patch
to introduce IP6IP6 flowtable acceleration since nf_flowtable_ctx will
be used to store IP6IP6 tunnel info.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/netfilter/nf_flow_table_ip.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index e128b0fe9a7bf50b458df9940d629ea08c521871..8d3fbeaca2df110180414d44b28475adce8724ae 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -293,15 +293,16 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
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
@@ -311,7 +312,7 @@ static bool nf_flow_ip4_tunnel_proto(struct sk_buff *skb, u32 *psize)
 		return false;
 
 	if (iph->protocol == IPPROTO_IPIP)
-		*psize += size;
+		ctx->offset += size;
 
 	return true;
 }
@@ -327,8 +328,8 @@ static void nf_flow_ip4_tunnel_pop(struct sk_buff *skb)
 	skb_reset_network_header(skb);
 }
 
-static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
-				       u32 *offset)
+static bool nf_flow_skb_encap_protocol(struct nf_flowtable_ctx *ctx,
+				       struct sk_buff *skb, __be16 proto)
 {
 	__be16 inner_proto = skb->protocol;
 	struct vlan_ethhdr *veth;
@@ -341,7 +342,7 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 
 		veth = (struct vlan_ethhdr *)skb_mac_header(skb);
 		if (veth->h_vlan_encapsulated_proto == proto) {
-			*offset += VLAN_HLEN;
+			ctx->offset += VLAN_HLEN;
 			inner_proto = proto;
 			ret = true;
 		}
@@ -349,14 +350,14 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
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
@@ -414,7 +415,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (!nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
+	if (!nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IP)))
 		return NULL;
 
 	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)
@@ -895,7 +896,7 @@ nf_flow_offload_ipv6_lookup(struct nf_flowtable_ctx *ctx,
 	struct flow_offload_tuple tuple = {};
 
 	if (skb->protocol != htons(ETH_P_IPV6) &&
-	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IPV6), &ctx->offset))
+	    !nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IPV6)))
 		return NULL;
 
 	if (nf_flow_tuple_ipv6(ctx, skb, &tuple) < 0)

-- 
2.52.0


