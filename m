Return-Path: <linux-kselftest+bounces-37752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C8FB0C555
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787CB3BFF14
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C72D5C61;
	Mon, 21 Jul 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHiGI7kY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA401607A4;
	Mon, 21 Jul 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105088; cv=none; b=i9BAW+TeNbLxlRRNe9tTv76QIPaRyOdZq4E0a4lVGjUTSuniDSLq4cP9RzSCwpRWPP2hdFD8wF1lWHvaIRDcwhu23Re5mcnUjOvm+WHV3U4liQzydqeq1Hjo7PEC+V14qDi8d/3Fsar53J46rtJsC5nbRSwSSRVCcCQpyfkLEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105088; c=relaxed/simple;
	bh=rcj5L+JOX9LhhZi3k8Cw335DdHO9RmiLzdJEExPoIlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikcEvG2y/7Z78peCzNYdRwIKK/SB/nyVrz7zpTci52bamwq8YaH5dQjEJSr6jOt3N+JwLr92KDN88C35CL8OWgvsQGmNnyn5zMIfvwSG+xtvl9g9C40JDg0eSZHtSX77svTdIjsNFDyo943MKIxrWJI2ysicDkcBNHvXgL9k864=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHiGI7kY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11678C4CEED;
	Mon, 21 Jul 2025 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753105087;
	bh=rcj5L+JOX9LhhZi3k8Cw335DdHO9RmiLzdJEExPoIlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHiGI7kY0gq2lWYLDtqRlSi5t88RJmIabZRA1sFYnwf95BB7ptfgFQ/6H3VGNBOjy
	 E3cq374j9i3mGbiF/j1ayvdsQ2hZiW+VcecSc9ig3yh/9x2qpEIl9fe8D7/Jie+++o
	 ez07UNSWjXkZHvDBqszo06XvhPTn+kMrteSTEJTq2E7G0Cc8qW4Xk5hOSyvXQ0iN5H
	 zNIdfVElKaN7fZp2XOL163IF8tHqvc+u8c7ZdhKYPJRTkeHEDzNYHSqfp0nADyy/J5
	 WQhRs0BbspciNX2khQcu2clhYTsgsfkq+k56PcDx2l1ubjzzuesMJKbu+L+2qaGHOZ
	 DU4dpGq71nnfA==
Date: Mon, 21 Jul 2025 15:38:05 +0200
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
Message-ID: <aH5CvbR6zD7ENreo@lore-desk>
References: <20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org>
 <20250718-nf-flowtable-ipip-v4-1-f8bb1c18b986@kernel.org>
 <aHpIuOiEaoewEQxm@strlen.de>
 <aH4NNppbRppZojYO@lore-desk>
 <aH4pwa2PmzwRvMA5@strlen.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u7ZVJsSVBMYkPsYi"
Content-Disposition: inline
In-Reply-To: <aH4pwa2PmzwRvMA5@strlen.de>


--u7ZVJsSVBMYkPsYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > > +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
> > > > +{
> > > > +	struct iphdr *iph;
> > > > +
> > > > +	if (!pskb_may_pull(skb, sizeof(*iph)))
> > > > +		return false;
> > >=20
> > > Nit: I think this could be 2 * sizeof() and a comment that we will
> > > also need the inner ip header later, might save one reallocation.
> >=20
> > nf_flow_ip4_encap_proto() is used even for plain IP traffic but I guess=
 we can
> > assume the IP payload is at least 20B, right?
>=20
> Oh, right, I missed that.  But even if we have a.g. ip header with icmp
> header, then the postconditions are the same, no?
>=20
> as-is:
> pskb_may_pull -> ok, then iph->protocol =3D=3D IPPROTO_IPIP -> return fal=
se
>=20
> with 2*iph:
> pskb_may_pull -> return false
>=20
> ... but I'll leave it up to you, if you prefer pskb_may_pull(skb, sizeof(=
*iph)))
> for clarity then lets keep it as-is.

I guess the point is we run nf_flow_skb_encap_protocol() not only for IPIP
traffic but even for plain IP traffic (e.g. IP+UDP) in nf_flow_offload_look=
up().
In particular, we run the following check in nf_flow_tuple_ip() for IP+UDP
traffic:

pskb_may_pull(, 28)

That is less restrictive with respect to

pskb_may_pull(, 40)

I guess it is better to keep the original check in
nf_flow_skb_encap_protocol(). What do you think?

Regards,
Lorenzo

>=20
> > > > +	iph =3D (struct iphdr *)skb_network_header(skb);
> > > > +	*size =3D iph->ihl << 2;
> > >=20
> > > I think this should be sanity tested vs. sizeof(iph).
> >=20
> > I guess this is already done in ip_has_options(), agree?
>=20
> Indeed it is!  Nevermind then :-)

--u7ZVJsSVBMYkPsYi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaH5CvQAKCRA6cBh0uS2t
rGk+AP9ccp3MNTSPZldp/Ea10KqPGiH5uRehqgKEQ5diyNO97gEAoshN5uA0Upzo
Hk7t0Gc+U6uvhSDD6/ubd5r1L1sWowg=
=jfZR
-----END PGP SIGNATURE-----

--u7ZVJsSVBMYkPsYi--

