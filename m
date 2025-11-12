Return-Path: <linux-kselftest+bounces-45429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEF8C5351E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 17:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131F44F3960
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC533B6C7;
	Wed, 12 Nov 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3fqrhjh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05D23B628;
	Wed, 12 Nov 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963360; cv=none; b=sxt3H8IYf0IfOf1C+egEINVJW/5Gaw4ZRwip2Aov9LRavnV12RSra5l68P/z1Yy5XaszVlH25npzqMmVoOZd48JMDkM5SIlK9CTqhX9dKW4lLqpOpb81DVot0t5/ZHCjcjHtE0j6hHzdjKjsj0Ms43nHtLNSH6oO6HUR1DdV48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963360; c=relaxed/simple;
	bh=9cDqhpoh2TaNYp3Sh641A7yKKpNFEMcajDyDQWAWX4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUMUCE7VB554j3GS+cdT9kTuwPNrM4Jt1ikdfUKWvRZ7FkoFSBfq1j/wWJSmDc93UeMzJtKVee5egoxShgyRAhy4VZXEryLEzN0ZxJrdik3I0g8AxPoPuRll3hagr8XuXVz4AV09COxWiz0Ok8MtYhOcN9yEU+QWHm/oClBSzjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3fqrhjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F51CC19421;
	Wed, 12 Nov 2025 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762963360;
	bh=9cDqhpoh2TaNYp3Sh641A7yKKpNFEMcajDyDQWAWX4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3fqrhjhmLH4/axpfuqlpns5UI3RTk421oEou5qosF86eJPrbWqoTQ2ZH7a47DaMY
	 eympqIhmMHvoX+JAfOykwiD51YzRz0wCpdyNj308zUMA7+rvWowBXn/z+XJptOjGeQ
	 ql4y131ZzB7tT1cKnMgpaCsdHKf/rnM1kMg/DZa3p7JLTNkJ0ySYYDvItRYTd0ZSaY
	 rETDdWOwGrSIC26ntYnZ9YbZYf+un4vZnOniFyktjfRbduVYfNtxC7+KdWmR1TXrRX
	 t03fXR2IbaSl50WT7DCqRd6fwkZxmCHZ+hMsr/V3bwe2Fbuk55ByVRDEYFHubhaSgc
	 3+XqU3hdosynQ==
Date: Wed, 12 Nov 2025 17:02:37 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
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
Message-ID: <aRSvnfdhO2G1DXJI@lore-desk>
References: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
 <20251107-nf-flowtable-ipip-v9-2-7cbc4090dfcb@kernel.org>
 <aRSDjkzMx4Ba7IW8@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6H8euPBYFgemF2H"
Content-Disposition: inline
In-Reply-To: <aRSDjkzMx4Ba7IW8@calendula>


--p6H8euPBYFgemF2H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,

Hi Pablo,

>=20
> On Fri, Nov 07, 2025 at 12:14:47PM +0100, Lorenzo Bianconi wrote:
> [...]
> > @@ -565,8 +622,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff =
*skb,
> > =20
> >  	dir =3D tuplehash->tuple.dir;
> >  	flow =3D container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> > +	other_tuple =3D &flow->tuplehash[!dir].tuple;
> > =20
> > -	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> > +	if (nf_flow_encap_push(state->net, skb, other_tuple))
> >  		return NF_DROP;
> > =20
> >  	switch (tuplehash->tuple.xmit_type) {
> > @@ -577,7 +635,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff =
*skb,
> >  			flow_offload_teardown(flow);
> >  			return NF_DROP;
> >  		}
> > -		neigh =3D ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!=
dir].tuple.src_v4.s_addr));
> > +		dest =3D other_tuple->tun_num ? other_tuple->tun.src_v4.s_addr
> > +					    : other_tuple->src_v4.s_addr;
>=20
> I think this can be simplified if my series use the ip_hdr(skb)->daddr
> for rt_nexthop(), see attached patch. This would be fetched _before_
> pushing the tunnel and layer 2 encapsulation headers. Then, there is
> no need to fetch other_tuple and check if tun_num is greater than
> zero.
>=20
> See my sketch patch, I am going to give this a try, if this is
> correct, I would need one more iteration from you.
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_tab=
le_ip.c
> index 8b74fb34998e..ff2b6c16c715 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -427,6 +427,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *s=
kb,
>  	struct flow_offload *flow;
>  	struct neighbour *neigh;
>  	struct rtable *rt;
> +	__be32 ip_dst;
>  	int ret;
> =20
>  	tuplehash =3D nf_flow_offload_lookup(&ctx, flow_table, skb);
> @@ -449,6 +450,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *s=
kb,
> =20
>  	dir =3D tuplehash->tuple.dir;
>  	flow =3D container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> +	ip_dst =3D ip_hdr(skb)->daddr;

I agree this patch will simplify my series (thx :)) but I guess we should m=
ove
ip_dst initialization after nf_flow_encap_push() since we need to route the
traffic according to the tunnel dst IP address, right?

Regards,
Lorenzo

> =20
>  	switch (tuplehash->tuple.xmit_type) {
>  	case FLOW_OFFLOAD_XMIT_NEIGH:
> @@ -458,7 +460,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *s=
kb,
>  			flow_offload_teardown(flow);
>  			return NF_DROP;
>  		}
> -		neigh =3D ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!di=
r].tuple.src_v4.s_addr));
> +		neigh =3D ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, ip_dst));
>  		if (IS_ERR(neigh)) {
>  			flow_offload_teardown(flow);
>  			return NF_DROP;


--p6H8euPBYFgemF2H
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaRSvnQAKCRA6cBh0uS2t
rHPxAQDzX1TgbfpgXD0BPeWv+KttxwukKd0c9trhj84geanZ9QEAxqr+u3nXUoTT
qkLlHrdRODNNLSULmhZBVBoUEjP/zQU=
=II//
-----END PGP SIGNATURE-----

--p6H8euPBYFgemF2H--

