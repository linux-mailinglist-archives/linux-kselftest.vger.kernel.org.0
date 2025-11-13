Return-Path: <linux-kselftest+bounces-45521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E025C56188
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 08:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C795344DFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1032937D;
	Thu, 13 Nov 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxTRbfLa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD1329368;
	Thu, 13 Nov 2025 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019655; cv=none; b=bOi2COpalB0A1XQj6/zcpx9MICVVQgxVrivzglSdoCv8BkWrIDfRtANhbxeA3RojqLhMtHHQGa7vD++1xwzqnuLX/N4NSXfgLkldiBzjaLKoeXY7RsmmQ9Fh6F9Uf4H6LWiC9PKzy4QlfhVHXG0vTMha/VwQNOe/DRDxexNDLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019655; c=relaxed/simple;
	bh=s1s7Q8+rNlO8QATMY6kvX3m8Lb/6Xzhin/P4c/UYLM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee02NvB3TsoRv7KHpOKFQefRPM95/5a4jChD3/ILmv0tiPCgoSodBDQ732/UcaSzn+7MRK+Xc3nq9hL6tesimXOu6KWvbH0ZOYPzoOU88X3Va+XWyE+e1qZJru1gd6+yCXPJCaKNZs9kle02GhmoK92sERvhG7i7q8ui6EPiWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxTRbfLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E91C113D0;
	Thu, 13 Nov 2025 07:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763019655;
	bh=s1s7Q8+rNlO8QATMY6kvX3m8Lb/6Xzhin/P4c/UYLM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxTRbfLaxUaVTKO5F7MP9wZIx/9u4dJaIBmMmLNeon2PN3JkuDX0XRLtuTD8Z5XP9
	 O0EX2Tcn0gMT2dZKEM8Hzbis/M8ciwiZhsPGe4e/40qFti8THAkn6p6hQe5OL3hJji
	 QxdN9ZXa74FgRJfL8lvVDo/xdt7D29LEF2PHriZfeXaod2UOGWpJYtr3q7eO7yJyMc
	 bC6n9z7Avew+AU9q32resfln6xKfNCtLgkLrFRZC9Xg3STv5bZaKtRcG58gh3f+DPL
	 VIKZOaCSAkr1gec1t1rYZI0CPPR1KG+lE0rHzpQPc5pZ68XneUhkCmSbKMslG1EC6j
	 AuAR3g4Gqhd7g==
Date: Thu, 13 Nov 2025 08:40:52 +0100
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
Message-ID: <aRWLhLobB4Rz0dA_@lore-desk>
References: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
 <20251107-nf-flowtable-ipip-v9-2-7cbc4090dfcb@kernel.org>
 <aRSDjkzMx4Ba7IW8@calendula>
 <aRSvnfdhO2G1DXJI@lore-desk>
 <aRUT-tFXYbwfZYUk@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5gdp/tkNuL2145vX"
Content-Disposition: inline
In-Reply-To: <aRUT-tFXYbwfZYUk@calendula>


--5gdp/tkNuL2145vX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,

Hi Pablo,

>=20
> On Wed, Nov 12, 2025 at 05:02:37PM +0100, Lorenzo Bianconi wrote:
> [...]
> > > On Fri, Nov 07, 2025 at 12:14:47PM +0100, Lorenzo Bianconi wrote:
> > > [...]
> > > > @@ -565,8 +622,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_b=
uff *skb,
> > > > =20
> > > >  	dir =3D tuplehash->tuple.dir;
> > > >  	flow =3D container_of(tuplehash, struct flow_offload, tuplehash[d=
ir]);
> > > > +	other_tuple =3D &flow->tuplehash[!dir].tuple;
> > > > =20
> > > > -	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> > > > +	if (nf_flow_encap_push(state->net, skb, other_tuple))
> > > >  		return NF_DROP;
> > > > =20
> > > >  	switch (tuplehash->tuple.xmit_type) {
> > > > @@ -577,7 +635,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_b=
uff *skb,
> > > >  			flow_offload_teardown(flow);
> > > >  			return NF_DROP;
> > > >  		}
> > > > -		neigh =3D ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tupleha=
sh[!dir].tuple.src_v4.s_addr));
> > > > +		dest =3D other_tuple->tun_num ? other_tuple->tun.src_v4.s_addr
> > > > +					    : other_tuple->src_v4.s_addr;
> > >=20
> > > I think this can be simplified if my series use the ip_hdr(skb)->daddr
> > > for rt_nexthop(), see attached patch. This would be fetched _before_
> > > pushing the tunnel and layer 2 encapsulation headers. Then, there is
> > > no need to fetch other_tuple and check if tun_num is greater than
> > > zero.
> > >=20
> > > See my sketch patch, I am going to give this a try, if this is
> > > correct, I would need one more iteration from you.
> > >
> > > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow=
_table_ip.c
> > > index 8b74fb34998e..ff2b6c16c715 100644
> > > --- a/net/netfilter/nf_flow_table_ip.c
> > > +++ b/net/netfilter/nf_flow_table_ip.c
> > > @@ -427,6 +427,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buf=
f *skb,
> > >  	struct flow_offload *flow;
> > >  	struct neighbour *neigh;
> > >  	struct rtable *rt;
> > > +	__be32 ip_dst;
> > >  	int ret;
> > > =20
> > >  	tuplehash =3D nf_flow_offload_lookup(&ctx, flow_table, skb);
> > > @@ -449,6 +450,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buf=
f *skb,
> > > =20
> > >  	dir =3D tuplehash->tuple.dir;
> > >  	flow =3D container_of(tuplehash, struct flow_offload, tuplehash[dir=
]);
> > > +	ip_dst =3D ip_hdr(skb)->daddr;
> >=20
> > I agree this patch will simplify my series (thx :)) but I guess we shou=
ld move
> > ip_dst initialization after nf_flow_encap_push() since we need to route=
 the
> > traffic according to the tunnel dst IP address, right?
>=20
> Right, I made a quick edit, it looks like this:
>=20
> @@ -566,9 +624,14 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *=
skb,
> =20
>         dir =3D tuplehash->tuple.dir;
>         flow =3D container_of(tuplehash, struct flow_offload, tuplehash[d=
ir]);
> +       other_tuple =3D &flow->tuplehash[!dir].tuple;
> +
> +       if (nf_flow_tunnel_push(skb, other_tuple) < 0)
> +               return NF_DROP;
> +
>         ip_daddr =3D ip_hdr(skb)->daddr;
> =20
> -       if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> +       if (nf_flow_encap_push(skb, other_tuple) < 0)
>                 return NF_DROP;
> =20
>         switch (tuplehash->tuple.xmit_type) {
>=20
> That is, after tunnel header push but before pushing l2 encap (that
> could possibly modify skb_network_header pointer), fetch the
> destination address.
>=20
> I made a few more comestic edits on your series and I pushed them out
> to this branch:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/log=
/?h=3Dflowtable-consolidate-xmit%2bipip
[

ack, I tested this branch and it works fine running my local tests. Thanks =
for
fixing pending bits.

Regards,
Lorenzo

>=20
> I just noticed, in nf_flow_tunnel_ipip_push(), that this can be removed:
>=20
>         memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
>=20
> because this packet never entered the IP layer, the flowtable takes it
> before it can get there.

--5gdp/tkNuL2145vX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaRWLhAAKCRA6cBh0uS2t
rMv9AQC6xcba9zpJwQtXPC3Xv0ZWz+UeLQNX11CPHmQPmtpheAD8Dvd8xaGktBuv
saj8xfjPSXw/lIIqLbh70Pu5zLj+1A0=
=HTPF
-----END PGP SIGNATURE-----

--5gdp/tkNuL2145vX--

