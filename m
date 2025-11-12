Return-Path: <linux-kselftest+bounces-45407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33666C525AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A53DC4E6B05
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EB5329E61;
	Wed, 12 Nov 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="D6Bcjm/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4333002D4;
	Wed, 12 Nov 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952110; cv=none; b=AWDJaTt/vI/eP13Ix3Q4vwSmStpCbuC/FVkfL6TKQeZaQ9hA0kS+zZEJw59ZN0sI62g3l0N1bHiDuUM1zjKHXOyUD9hdF/zMrjcuhYQuJqv1/93DwRoiAFU9XBNqv2EK2tbBBd7Hy/XkMdod1fGAOC/N3b2e1cNgA5wICw1IERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952110; c=relaxed/simple;
	bh=GK3S2B+V0tGij54CXCXdL03p1HBPSpt3WcU8s4IwIWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boe1WaMaq/qcabACLPdWoOscxwiWwvEs8XdLRt3W9dkF9Pu4TF9Xy5lX8QfuLNHDAvYm1jtBHL7j/UI7T6g3+yEtE9E7QYT0Oj39srWx7/ENF+9V9tZFWZhKgxVa2QSUEGhK7anvlFpRDlCvU5z4iFc5YPQmTtUjc4vWFMAccDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=D6Bcjm/9; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 35840602A5;
	Wed, 12 Nov 2025 13:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1762952103;
	bh=OdNeVeyuucE30sPTpY9njuCBycZpQtt+JjceqnPV0Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6Bcjm/9LmFjtZeCTxPN0DJvz6XRu9Sc37Yb468pSkOpuAsnIIoqNazJRAud1sHoO
	 mSxY5PM1z7yDgjRQl9NUgocoRUnggPcUSTm+qIXRQkNacOF9yv0AaC9HmSLeQhg7O7
	 K3Z0/LtLWLjU6+T0X2vO0qu2tfklmPLSEFASLrJhdgG8Z8/lCTEUnS4ApEJUloFdWv
	 WYudt8DCKioP7oXrFtXWT/e9wbbuAFLc+853qhVQqjTYbZMvUIe9qK8g1wHpYcAmeO
	 6Ek5GA/lrp4yoZ8pWYiAi7erBgWRy74MIwLvjmxyozW4mQAVOQbb0ri2aMk5XEKYtw
	 389qt0rQVqprA==
Date: Wed, 12 Nov 2025 13:55:00 +0100
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
Message-ID: <aRSDjkzMx4Ba7IW8@calendula>
References: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
 <20251107-nf-flowtable-ipip-v9-2-7cbc4090dfcb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qIJPGgiRR2AxazJq"
Content-Disposition: inline
In-Reply-To: <20251107-nf-flowtable-ipip-v9-2-7cbc4090dfcb@kernel.org>


--qIJPGgiRR2AxazJq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Lorenzo,

On Fri, Nov 07, 2025 at 12:14:47PM +0100, Lorenzo Bianconi wrote:
[...]
> @@ -565,8 +622,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
>  
>  	dir = tuplehash->tuple.dir;
>  	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> +	other_tuple = &flow->tuplehash[!dir].tuple;
>  
> -	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> +	if (nf_flow_encap_push(state->net, skb, other_tuple))
>  		return NF_DROP;
>  
>  	switch (tuplehash->tuple.xmit_type) {
> @@ -577,7 +635,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
>  			flow_offload_teardown(flow);
>  			return NF_DROP;
>  		}
> -		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr));
> +		dest = other_tuple->tun_num ? other_tuple->tun.src_v4.s_addr
> +					    : other_tuple->src_v4.s_addr;

I think this can be simplified if my series use the ip_hdr(skb)->daddr
for rt_nexthop(), see attached patch. This would be fetched _before_
pushing the tunnel and layer 2 encapsulation headers. Then, there is
no need to fetch other_tuple and check if tun_num is greater than
zero.

See my sketch patch, I am going to give this a try, if this is
correct, I would need one more iteration from you.

--qIJPGgiRR2AxazJq
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="update.patch"

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 8b74fb34998e..ff2b6c16c715 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -427,6 +427,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	struct flow_offload *flow;
 	struct neighbour *neigh;
 	struct rtable *rt;
+	__be32 ip_dst;
 	int ret;
 
 	tuplehash = nf_flow_offload_lookup(&ctx, flow_table, skb);
@@ -449,6 +450,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
+	ip_dst = ip_hdr(skb)->daddr;
 
 	switch (tuplehash->tuple.xmit_type) {
 	case FLOW_OFFLOAD_XMIT_NEIGH:
@@ -458,7 +460,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 			flow_offload_teardown(flow);
 			return NF_DROP;
 		}
-		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr));
+		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, ip_dst));
 		if (IS_ERR(neigh)) {
 			flow_offload_teardown(flow);
 			return NF_DROP;

--qIJPGgiRR2AxazJq--

