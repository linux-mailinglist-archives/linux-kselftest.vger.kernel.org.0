Return-Path: <linux-kselftest+bounces-45933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C05EC6C1AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 01:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 510B24E55AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 00:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00E2AD25;
	Wed, 19 Nov 2025 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="O0Xk5MFs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78547191;
	Wed, 19 Nov 2025 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511211; cv=none; b=ux43AJ7+v9QJ9Alz0Y3eMtYIyOPDp4mYnRiiFAwYERCd0CjQQ9bFXLW2m61ilZiz0obsAsHl+9xx613KqYuQG1U68gG+Mm0HC4dW22U31v65l7sGMjHzBhzqgRkXIa2tIDozXAys3wsCGuZYPBwxxLKGfRyZVcn939HzHv6QFJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511211; c=relaxed/simple;
	bh=tNhrmH7gReZ4ZYPdSLTYqbBGC0mEIOspEpHU6EAAFjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTsAwStfYhiv2owSl4a4n+MYQBAYEUHLug2lSNYZ/D6FbLuRh0/txNIh2xw/R9jriYHpdp/ivFwtFk43Lv3idjuN++zJWY4+x9XJa+G7QtZHn2H8v/oRb/Etgj4M4c0eTou6XY36s0wIBP4o8wKsDRI7cAlVuP72ts0abUmrY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=O0Xk5MFs; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 022326026D;
	Wed, 19 Nov 2025 01:13:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1763511206;
	bh=5k+g15HZUscl+EXiVgMedFZkR9Qrlj8kdASp7Z7QWX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0Xk5MFsq3tbL/CuJx/6uklz4cKlxJdDYxin3nt2wIo7BY5ea5jiJEjLRqtIchoI+
	 djvu0I5JtD5DwlZ07ff3yG/6hyALHljcRDUKhYJs/eI2mOh9lzlnVNHIRxlC7goTCv
	 KpsaG7HL96VBJjJtVTdEtBzre+Q1hdUWawCWyiWZ+1yu2YT4e8+W/eCdDItltjE3ae
	 n4ROlzoFF+YcCTdltqL135GRxHOSakfMPaAGoQcG33/ycRp1qnDUjY075HRCEFLjUJ
	 7eyaPrQeecIesZ9VFbWOHZqJ+No39Zi14ug/8R8AE+VgXUMkmzEYhcpEsod0/ummiP
	 s6ksVYnkAglUw==
Date: Wed, 19 Nov 2025 01:13:23 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v9 2/3] net: netfilter: Add IPIP flowtable tx sw
 acceleration
Message-ID: <aR0Lj3ph0RYtpleX@calendula>
References: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
 <20251107-nf-flowtable-ipip-v9-2-7cbc4090dfcb@kernel.org>
 <aRSDjkzMx4Ba7IW8@calendula>
 <aRSvnfdhO2G1DXJI@lore-desk>
 <aRUT-tFXYbwfZYUk@calendula>
 <aRWLhLobB4Rz0dA_@lore-desk>
 <aRunjT-HYQ-UeR_-@calendula>
 <aRu1aFVwT_FPDeZ1@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FfFY3znOfUsFReA0"
Content-Disposition: inline
In-Reply-To: <aRu1aFVwT_FPDeZ1@lore-desk>


--FfFY3znOfUsFReA0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Lorenzo,

I found one more issue: caching the ip6 daddr does not work because
skb_cow_head() can reallocate the skb header, invalidating all
pointers.

I went back to use the other_tuple, it is safer, new branch:

        flowtable-consolidate-xmit+ipip3

Hopefully, this is the last iteration for this series.

I am attaching a diff that compares flowtable-consolidate-xmit+ipip2
vs. flowtable-consolidate-xmit+ipip3 branches.

I also made a few cosmetic edits.

--FfFY3znOfUsFReA0
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="diff-v2-v3.patch"

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index ee81ee3a5110..e128b0fe9a7b 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -512,13 +512,14 @@ static int nf_flow_pppoe_push(struct sk_buff *skb, u16 id)
 }
 
 static int nf_flow_tunnel_ipip_push(struct net *net, struct sk_buff *skb,
-				    struct flow_offload_tuple *tuple)
+				    struct flow_offload_tuple *tuple,
+				    __be32 *ip_daddr)
 {
 	struct iphdr *iph = (struct iphdr *)skb_network_header(skb);
 	struct rtable *rt = dst_rtable(tuple->dst_cache);
-	__be16	frag_off = iph->frag_off;
-	u32 headroom = sizeof(*iph);
 	u8 tos = iph->tos, ttl = iph->ttl;
+	__be16 frag_off = iph->frag_off;
+	u32 headroom = sizeof(*iph);
 	int err;
 
 	err = iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4);
@@ -551,14 +552,17 @@ static int nf_flow_tunnel_ipip_push(struct net *net, struct sk_buff *skb,
 	__ip_select_ident(net, iph, skb_shinfo(skb)->gso_segs ?: 1);
 	ip_send_check(iph);
 
+	*ip_daddr = tuple->tun.src_v4.s_addr;
+
 	return 0;
 }
 
 static int nf_flow_tunnel_v4_push(struct net *net, struct sk_buff *skb,
-				  struct flow_offload_tuple *tuple)
+				  struct flow_offload_tuple *tuple,
+				  __be32 *ip_daddr)
 {
 	if (tuple->tun_num)
-		return nf_flow_tunnel_ipip_push(net, skb, tuple);
+		return nf_flow_tunnel_ipip_push(net, skb, tuple, ip_daddr);
 
 	return 0;
 }
@@ -572,7 +576,8 @@ static int nf_flow_encap_push(struct sk_buff *skb,
 		switch (tuple->encap[i].proto) {
 		case htons(ETH_P_8021Q):
 		case htons(ETH_P_8021AD):
-			if (skb_vlan_push(skb, tuple->encap[i].proto, tuple->encap[i].id) < 0)
+			if (skb_vlan_push(skb, tuple->encap[i].proto,
+					  tuple->encap[i].id) < 0)
 				return -1;
 			break;
 		case htons(ETH_P_PPP_SES):
@@ -624,12 +629,11 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 	other_tuple = &flow->tuplehash[!dir].tuple;
+	ip_daddr = other_tuple->src_v4.s_addr;
 
-	if (nf_flow_tunnel_v4_push(state->net, skb, other_tuple) < 0)
+	if (nf_flow_tunnel_v4_push(state->net, skb, other_tuple, &ip_daddr) < 0)
 		return NF_DROP;
 
-	ip_daddr = ip_hdr(skb)->daddr;
-
 	if (nf_flow_encap_push(skb, other_tuple) < 0)
 		return NF_DROP;
 
@@ -906,6 +910,7 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 {
 	struct flow_offload_tuple_rhash *tuplehash;
 	struct nf_flowtable *flow_table = priv;
+	struct flow_offload_tuple *other_tuple;
 	enum flow_offload_tuple_dir dir;
 	struct nf_flowtable_ctx ctx = {
 		.in	= state->in,
@@ -937,9 +942,10 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
-	ip6_daddr = &ipv6_hdr(skb)->daddr;
+	other_tuple = &flow->tuplehash[!dir].tuple;
+	ip6_daddr = &other_tuple->src_v6;
 
-	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
+	if (nf_flow_encap_push(skb, other_tuple) < 0)
 		return NF_DROP;
 
 	switch (tuplehash->tuple.xmit_type) {

--FfFY3znOfUsFReA0--

