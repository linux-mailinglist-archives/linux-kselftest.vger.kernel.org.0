Return-Path: <linux-kselftest+bounces-45807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A4C667D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 23:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E42DE296BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E8E2F39A0;
	Mon, 17 Nov 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="WzMw0lo9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704C20C00A;
	Mon, 17 Nov 2025 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763420053; cv=none; b=qihj3sOnptnfJ5AqyweReCSo3sABaRcbfnaAJ4LXFXgGrCm2WehnWcbP6aIW8pdZ/kOR5MRCknMu3CFMZ2oNZWIp3Nh1mpRQeZjvzd8oyYx6oOJEzTV15ZWF4bECwBt0mt7OV9IcGwtwJPCItf4bvI8kBxN+j/UpgdCCyqBUKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763420053; c=relaxed/simple;
	bh=0S68mBFo0/+NMGUTH2TkhLCmN+/oGNwJ+9nb4jlgcq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr2lYTq2ZjWlbSjCEZpfYy8bYxOwMFxn5I8UE04pBUx8a2AniripMdh0hqt93X8SU4AbkV+eLYZnqL1Xyd8DpgnaJdRJ3lRLZhQDpWk8Tv2MedibnieK9Nemdz5rYKpQkCbrMZ1MQo4VHR4ajAJpHEvUHlCfCunDH9BgLbiecUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WzMw0lo9; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C9992600B9;
	Mon, 17 Nov 2025 23:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1763420047;
	bh=0u1F8K9fQWJvfpvpAfhW2Nw4oXYEC5pO97ryoVTBlIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzMw0lo9KOJ13oSTo6tjN+PD0qLLW5uwSp5qdIyNW28nVkMuMVohosYWfltISN7p/
	 cEwrGW/V/E/+OmCWFjG2z/Z4k/rVLoIsSpljrdLC3FxJrUvkRzBNNhtf7uV7Fx7H2+
	 1JchGf0ki4PW0lyDADD8FHp9qLgl0UOWr7I7jQ5qV8BFojGQ2cllqMBnQi44DHt/SF
	 4446Kl4pi3HJbKkwaRDvVYVN1LMeeLZTf3Ed0KOutfi2wAXTVFgOlrwu6d9ryfMmbS
	 lPHVnpq2KNUFlZlPFYx2iBun8zDPhW+lzTFeEJ484Oubi6snOPc59iw17XZuKWMTMs
	 mYBo4cpbapKdw==
Date: Mon, 17 Nov 2025 23:54:05 +0100
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
Message-ID: <aRunjT-HYQ-UeR_-@calendula>
References: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
 <20251107-nf-flowtable-ipip-v9-2-7cbc4090dfcb@kernel.org>
 <aRSDjkzMx4Ba7IW8@calendula>
 <aRSvnfdhO2G1DXJI@lore-desk>
 <aRUT-tFXYbwfZYUk@calendula>
 <aRWLhLobB4Rz0dA_@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRWLhLobB4Rz0dA_@lore-desk>

On Thu, Nov 13, 2025 at 08:40:52AM +0100, Lorenzo Bianconi wrote:
> > Hi Lorenzo,
> 
> Hi Pablo,
> 
> > 
> > On Wed, Nov 12, 2025 at 05:02:37PM +0100, Lorenzo Bianconi wrote:
> > [...]
> > > > On Fri, Nov 07, 2025 at 12:14:47PM +0100, Lorenzo Bianconi wrote:
> > > > [...]
> > > > > @@ -565,8 +622,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
> > > > >  
> > > > >  	dir = tuplehash->tuple.dir;
> > > > >  	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> > > > > +	other_tuple = &flow->tuplehash[!dir].tuple;
> > > > >  
> > > > > -	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> > > > > +	if (nf_flow_encap_push(state->net, skb, other_tuple))
> > > > >  		return NF_DROP;
> > > > >  
> > > > >  	switch (tuplehash->tuple.xmit_type) {
> > > > > @@ -577,7 +635,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
> > > > >  			flow_offload_teardown(flow);
> > > > >  			return NF_DROP;
> > > > >  		}
> > > > > -		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr));
> > > > > +		dest = other_tuple->tun_num ? other_tuple->tun.src_v4.s_addr
> > > > > +					    : other_tuple->src_v4.s_addr;
> > > > 
> > > > I think this can be simplified if my series use the ip_hdr(skb)->daddr
> > > > for rt_nexthop(), see attached patch. This would be fetched _before_
> > > > pushing the tunnel and layer 2 encapsulation headers. Then, there is
> > > > no need to fetch other_tuple and check if tun_num is greater than
> > > > zero.
> > > > 
> > > > See my sketch patch, I am going to give this a try, if this is
> > > > correct, I would need one more iteration from you.
> > > >
> > > > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> > > > index 8b74fb34998e..ff2b6c16c715 100644
> > > > --- a/net/netfilter/nf_flow_table_ip.c
> > > > +++ b/net/netfilter/nf_flow_table_ip.c
> > > > @@ -427,6 +427,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
> > > >  	struct flow_offload *flow;
> > > >  	struct neighbour *neigh;
> > > >  	struct rtable *rt;
> > > > +	__be32 ip_dst;
> > > >  	int ret;
> > > >  
> > > >  	tuplehash = nf_flow_offload_lookup(&ctx, flow_table, skb);
> > > > @@ -449,6 +450,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
> > > >  
> > > >  	dir = tuplehash->tuple.dir;
> > > >  	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> > > > +	ip_dst = ip_hdr(skb)->daddr;
> > > 
> > > I agree this patch will simplify my series (thx :)) but I guess we should move
> > > ip_dst initialization after nf_flow_encap_push() since we need to route the
> > > traffic according to the tunnel dst IP address, right?
> > 
> > Right, I made a quick edit, it looks like this:
> > 
> > @@ -566,9 +624,14 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
> >  
> >         dir = tuplehash->tuple.dir;
> >         flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> > +       other_tuple = &flow->tuplehash[!dir].tuple;
> > +
> > +       if (nf_flow_tunnel_push(skb, other_tuple) < 0)
> > +               return NF_DROP;
> > +
> >         ip_daddr = ip_hdr(skb)->daddr;
> >  
> > -       if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> > +       if (nf_flow_encap_push(skb, other_tuple) < 0)
> >                 return NF_DROP;
> >  
> >         switch (tuplehash->tuple.xmit_type) {
> > 
> > That is, after tunnel header push but before pushing l2 encap (that
> > could possibly modify skb_network_header pointer), fetch the
> > destination address.
> > 
> > I made a few more comestic edits on your series and I pushed them out
> > to this branch:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/log/?h=flowtable-consolidate-xmit%2bipip
> [
> 
> ack, I tested this branch and it works fine running my local tests. Thanks for
> fixing pending bits.

I need this one more little change below.

> > I just noticed, in nf_flow_tunnel_ipip_push(), that this can be removed:
> > 
> >         memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
> > 
> > because this packet never entered the IP layer, the flowtable takes it
> > before it can get there.

I have removed this memset and pushed out a new branch:

flowtable-consolidate-xmit+ipip2

This should be good to go.

Thanks.

