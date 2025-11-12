Return-Path: <linux-kselftest+bounces-45469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189EC54C7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 00:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98BC64E02B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 23:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB9C2E718B;
	Wed, 12 Nov 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="vR41GOMo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD32550AF;
	Wed, 12 Nov 2025 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762989061; cv=none; b=KF8L4/TMl783qXidzsGdFOdB7EnjmDL8FZhYzX4aMGouIWjWr3j2SU4vnQp72LEyG8bIznDTnJDPC660PTbSoSBxXTWsrNxxEpyKq6P94M6tB1NU3/vWAB9vFeyc1fWQcPs5wpftKXQRX8J7Z3NtxSVLRJaKZ/sBa85DV3FfQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762989061; c=relaxed/simple;
	bh=g8HQwyvosRqrj/H5ZyB6qV1fxoG9t+H6fK+shkMMQMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSWV6/SFiDI9ZZn6n03EXV+4EDZAj05zWailyXPFY6m+PgUHaZEwmL7jomwbZzZqDpEQcMLe1aQnHAa9YfLBv/GtU0QxyEmPzIztvzJJiLnIke4Lips/8CYTsN3WSK8lEr4hLmB09dkkrW0A9FY3CJ9bBDvg4DDZuE6/EX9YlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=vR41GOMo; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id D61D660279;
	Thu, 13 Nov 2025 00:10:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1762989054;
	bh=lhBJqy6zMtIHmZv4N86dc6RbKyZHbbHAvF6rboVN0/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vR41GOMoghr4+WpMVNC79Tgs9adVJXTC7MiVSbI1MsYwFPGkMA0/G7VyciUBy+TSc
	 rV0XXcGZqg6yR3CeUXUGWPKay+TEKHmjuBfzkRDCi/xk4oSMyRQJBVeRjVmyveAwXa
	 64uYjyOHV7p7Z6c4Ql5jQm+P9/WhH+m6JSTOrnjq3Pdraes7nLpCHe+y0JUe+pDNhb
	 OiQCIQl9N0fSSzP3PzMg/bJhshi1SvQ5XoA/zYgA02pDS14SECX3IMPFGs7iu0CbRM
	 94wLf++lBqa3uxR7VaUMX1hJl549O7a2NXGCsoBYrtTIGijfmhdsZWWLkh/GEGEfII
	 2Unzs70yGSZhA==
Date: Thu, 13 Nov 2025 00:10:50 +0100
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
Message-ID: <aRUT-tFXYbwfZYUk@calendula>
References: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
 <20251107-nf-flowtable-ipip-v9-2-7cbc4090dfcb@kernel.org>
 <aRSDjkzMx4Ba7IW8@calendula>
 <aRSvnfdhO2G1DXJI@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRSvnfdhO2G1DXJI@lore-desk>

Hi Lorenzo,

On Wed, Nov 12, 2025 at 05:02:37PM +0100, Lorenzo Bianconi wrote:
[...]
> > On Fri, Nov 07, 2025 at 12:14:47PM +0100, Lorenzo Bianconi wrote:
> > [...]
> > > @@ -565,8 +622,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
> > >  
> > >  	dir = tuplehash->tuple.dir;
> > >  	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> > > +	other_tuple = &flow->tuplehash[!dir].tuple;
> > >  
> > > -	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> > > +	if (nf_flow_encap_push(state->net, skb, other_tuple))
> > >  		return NF_DROP;
> > >  
> > >  	switch (tuplehash->tuple.xmit_type) {
> > > @@ -577,7 +635,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
> > >  			flow_offload_teardown(flow);
> > >  			return NF_DROP;
> > >  		}
> > > -		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr));
> > > +		dest = other_tuple->tun_num ? other_tuple->tun.src_v4.s_addr
> > > +					    : other_tuple->src_v4.s_addr;
> > 
> > I think this can be simplified if my series use the ip_hdr(skb)->daddr
> > for rt_nexthop(), see attached patch. This would be fetched _before_
> > pushing the tunnel and layer 2 encapsulation headers. Then, there is
> > no need to fetch other_tuple and check if tun_num is greater than
> > zero.
> > 
> > See my sketch patch, I am going to give this a try, if this is
> > correct, I would need one more iteration from you.
> >
> > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> > index 8b74fb34998e..ff2b6c16c715 100644
> > --- a/net/netfilter/nf_flow_table_ip.c
> > +++ b/net/netfilter/nf_flow_table_ip.c
> > @@ -427,6 +427,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
> >  	struct flow_offload *flow;
> >  	struct neighbour *neigh;
> >  	struct rtable *rt;
> > +	__be32 ip_dst;
> >  	int ret;
> >  
> >  	tuplehash = nf_flow_offload_lookup(&ctx, flow_table, skb);
> > @@ -449,6 +450,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
> >  
> >  	dir = tuplehash->tuple.dir;
> >  	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> > +	ip_dst = ip_hdr(skb)->daddr;
> 
> I agree this patch will simplify my series (thx :)) but I guess we should move
> ip_dst initialization after nf_flow_encap_push() since we need to route the
> traffic according to the tunnel dst IP address, right?

Right, I made a quick edit, it looks like this:

@@ -566,9 +624,14 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 
        dir = tuplehash->tuple.dir;
        flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
+       other_tuple = &flow->tuplehash[!dir].tuple;
+
+       if (nf_flow_tunnel_push(skb, other_tuple) < 0)
+               return NF_DROP;
+
        ip_daddr = ip_hdr(skb)->daddr;
 
-       if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
+       if (nf_flow_encap_push(skb, other_tuple) < 0)
                return NF_DROP;
 
        switch (tuplehash->tuple.xmit_type) {

That is, after tunnel header push but before pushing l2 encap (that
could possibly modify skb_network_header pointer), fetch the
destination address.

I made a few more comestic edits on your series and I pushed them out
to this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/log/?h=flowtable-consolidate-xmit%2bipip

I just noticed, in nf_flow_tunnel_ipip_push(), that this can be removed:

        memset(IPCB(skb), 0, sizeof(*IPCB(skb)));

because this packet never entered the IP layer, the flowtable takes it
before it can get there.

