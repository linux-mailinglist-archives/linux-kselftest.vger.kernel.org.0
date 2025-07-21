Return-Path: <linux-kselftest+bounces-37743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56284B0C0A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 11:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE9C4E00A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D19F21CC63;
	Mon, 21 Jul 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGXcE6RL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E25579E;
	Mon, 21 Jul 2025 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091386; cv=none; b=sqlaAKNV9k8Q9P1uLQdx1JMDbzVUP2PTZ655r7xztnpkBT9Nie/djg2sRuqkdF/91WH0YrSsTsBzlro1AtS3lu5ofrfMAAyiHgOi2GFRQ8am7ybP9LTcWfACJepBO6b9BCXMWPHry51J2JpOo3Z/uAIGazOOuT7FiRD/v1r4G40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091386; c=relaxed/simple;
	bh=sYLQ9+Vfi2eP5Tk+4MHP1IbEq7DGbVwCpahZ3n/evGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC2L54rlQrC93vBQ0fQrngPAZypP9KdTHEHA3qq16unuXzCRa69Oo50VMNl54EajCdiivRJPWVDKqrMQwcXhSTOiC0dgmJppz8/USxlNqcR+6iHP1/PxdH+9QMS8DA3oqUAmJsUjOSXvxjFy8hj0z38LPQ4r5Oiyv7XEFCyOg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGXcE6RL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324B0C4CEED;
	Mon, 21 Jul 2025 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753091385;
	bh=sYLQ9+Vfi2eP5Tk+4MHP1IbEq7DGbVwCpahZ3n/evGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGXcE6RLu4M9PEbkn1REsO03zRKE/TeYMsJcEMsp+2dQ+UZPxYCp24HJIs+AZ2awV
	 XfuKMkWjiyeOVo7u+p8Em2n9bgUdyGTynzx5iGOS1LELS/MPGadIAeq2o00ZrdmXXv
	 5eRipemlDMCPZpjj8YKBWKCPyCKIuqITQU/uO65ZNJVkcAWQkTM57skyz1t609eZnN
	 W3UyaH5nGsWvBkuF5Knbwz5efhdoSzkaebRbIGNEWRiei/lQ4WjYwhKzSVQ2Z/3S8v
	 x6yp3lU7cbuqX1hQBUicuUDT2Ni8D8/4Pw9J+9XRZniBfIuvuLx4ds0cuwKZ8roCzv
	 IKM5ThKup+1XA==
Date: Mon, 21 Jul 2025 11:49:42 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v4 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Message-ID: <aH4NNppbRppZojYO@lore-desk>
References: <20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org>
 <20250718-nf-flowtable-ipip-v4-1-f8bb1c18b986@kernel.org>
 <aHpIuOiEaoewEQxm@strlen.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="51L34DFY6zSZ5n+A"
Content-Disposition: inline
In-Reply-To: <aHpIuOiEaoewEQxm@strlen.de>


--51L34DFY6zSZ5n+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > +	path->type =3D DEV_PATH_IPENCAP;
> > +	path->dev =3D ctx->dev;
> > +	path->encap.proto =3D htons(ETH_P_IP);
> > +	path->encap.id =3D jhash_3words(ntohl(tiph->saddr), ntohl(tiph->daddr=
),
> > +				      IPPROTO_IPIP, 0);
>=20
> I think it would be better to have a helper.  Else I think this needs a
> comment that explains it must be kept in sync with nf_flow_tuple_encap().
>=20
> Or use __ipv4_addr_hash(tiph->saddr, (__force __u32)tiph->daddr).
> (loses IPPROTO_IPIP though).

ack, I will fix it in v5.

>=20
> > @@ -165,6 +166,19 @@ static void nf_flow_tuple_encap(struct sk_buff *sk=
b,
> >  		tuple->encap[i].id =3D ntohs(phdr->sid);
> >  		tuple->encap[i].proto =3D skb->protocol;
> >  		break;
> > +	case htons(ETH_P_IP):
> > +		if (!pskb_may_pull(skb, sizeof(*iph)))
> > +			break;
>=20
> Is this needed?  Caller does:
>=20
>         if (!pskb_may_pull(skb, thoff + ctx->hdrsize))
>                 return -1;
>=20
> and then populates the inner header:
>         iph =3D (struct iphdr *)(skb_network_header(skb) + ctx->offset);
> 	tuple->src_v4.s_addr    =3D iph->saddr;
>=20
>=20
> .... so I think this can rely on the outer header being available
> via skb_network_header().

I agree, I will fix it in v5.

>=20
> > +		tuple->encap[i].proto =3D htons(ETH_P_IP);
> > +		tuple->encap[i].id =3D jhash_3words(ntohl(iph->daddr),
> > +						  ntohl(iph->saddr),
> > +						  IPPROTO_IPIP, 0);
>=20
> See above, I think this desevers a helper or a comment, or both.
>=20
> > +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
> > +{
> > +	struct iphdr *iph;
> > +
> > +	if (!pskb_may_pull(skb, sizeof(*iph)))
> > +		return false;
>=20
> Nit: I think this could be 2 * sizeof() and a comment that we will
> also need the inner ip header later, might save one reallocation.

nf_flow_ip4_encap_proto() is used even for plain IP traffic but I guess we =
can
assume the IP payload is at least 20B, right?

>=20
> > +	iph =3D (struct iphdr *)skb_network_header(skb);
> > +	*size =3D iph->ihl << 2;
>=20
> I think this should be sanity tested vs. sizeof(iph).

I guess this is already done in ip_has_options(), agree?

>=20
> > +
> >  static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 pro=
to,
> >  				       u32 *offset)
> >  {
> >  	struct vlan_ethhdr *veth;
> >  	__be16 inner_proto;
> > +	u16 size;
> > =20
> >  	switch (skb->protocol) {
> > +	case htons(ETH_P_IP):
> > +		if (nf_flow_ip4_encap_proto(skb, &size))
> > +			*offset +=3D size;
>=20
> Nit: return nf_flow_ip4_encap_proto(skb, &offset) ?

ack, I will fix it in v5.

Regards,
Lorenzo


--51L34DFY6zSZ5n+A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaH4NNgAKCRA6cBh0uS2t
rOJZAQCSLEL8+gXt+rDE9RwGkpGMMWjdosaf3bsYn9qpJQvDZwEAkxu2W+2jvHe/
6kkXgVB1pPH5JGgdh5OrojV1WiY5dwE=
=oOEO
-----END PGP SIGNATURE-----

--51L34DFY6zSZ5n+A--

