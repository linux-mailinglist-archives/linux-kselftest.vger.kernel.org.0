Return-Path: <linux-kselftest+bounces-49066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9ED29253
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 739773039AC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 23:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654403126A9;
	Thu, 15 Jan 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmil3sD+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38996215055;
	Thu, 15 Jan 2026 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518052; cv=none; b=lGRLNFZ/5bIUMkkUIjjnEOxAbf4utSFLJIJDQ5/rD0l/xDPLYEMmrTimhKGbhnKz9757V28f7HGAiCswF8LtfmRj8Kz4VR0iRyLMmjNfLoYd4q4E/rrncu+WGh0XMHnrnC3KzVKfmGwKBETuHLKT3lagtYkc/dJ/scd0qUE18+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518052; c=relaxed/simple;
	bh=7HLiX70XuZSU1lfO0HzGS+Cnre2kiMwHnhYa+cUOxqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq+OavumAwe+5geWXlCcVyG7oq55DbHCHBwUSg2AWOYhgbjLVQO0ZBXZR7fb83iqCJuMwus+CvnTVOniwbDlhHaZvquWSXfdrqESTKcem+PK18flQRWqljOYOfCbuWfUaXS4IJ4Nlu7v32qv9nSAz+vLdYwP3ZxiYUD1bjoeRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmil3sD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C14BC116D0;
	Thu, 15 Jan 2026 23:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768518051;
	bh=7HLiX70XuZSU1lfO0HzGS+Cnre2kiMwHnhYa+cUOxqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmil3sD+wFBAhT7I8Ni5NJqA7ssOU3IEl/KTb4VCPbhVXbrbpzmy/dJ9ZH3nRCE1b
	 qBmCp2I+FhD6WFlUmsQTGnsrLkbHXjFkE65is32OFR8ReK980eS/BykATIZBx84Q4q
	 WqsHj0jPw1Rbm83a4iDDLv879Gvek+weeLoEsjwr1XcZEkQtBZEIu1wOGjovKyKJr8
	 LS1K08tXsSpPg2nTaJEZkvcArHks6seJTJD+EkKar5tgpJNj5AoaVBslPrm4u7bzRJ
	 D1k9vWvesAMWfgp+NrN2Z8Uf/Ce1EzyF0On3HLZzPGXEfWLe9W4aCfSisbHRXKZtbo
	 qpH6+oMOYSwGA==
Date: Fri, 16 Jan 2026 00:00:49 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v2 1/4] netfilter: Introduce tunnel metadata info
 in nf_flowtable_ctx struct
Message-ID: <aWlxoaPA4D4-sMa1@lore-desk>
References: <20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org>
 <20251209-b4-flowtable-offload-ip6ip6-v2-1-44817f1be5c6@kernel.org>
 <aWZgos3epThP36en@strlen.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LPGBBWg64eFeJnrl"
Content-Disposition: inline
In-Reply-To: <aWZgos3epThP36en@strlen.de>


--LPGBBWg64eFeJnrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > This is a preliminary patch to introduce IP6IP6 flowtable acceleration.
>=20
> Would you mind extending this a little bit?
> AFAICS this prepares for IP6IP6 by removing the 'its ipv4'
> assumptions resp. adding needed 'its ipv4' checks:
> no ipv6 support is added here.

ack, I will expand the commit log.

>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  net/netfilter/nf_flow_table_ip.c | 80 ++++++++++++++++++++++----------=
--------
> >  1 file changed, 44 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_t=
able_ip.c
> > index e128b0fe9a7bf50b458df9940d629ea08c521871..14c01b59f76569170057d24=
65ee5953efb557bcc 100644
> > --- a/net/netfilter/nf_flow_table_ip.c
> > +++ b/net/netfilter/nf_flow_table_ip.c
> > @@ -142,7 +142,18 @@ static bool ip_has_options(unsigned int thoff)
> >  	return thoff !=3D sizeof(struct iphdr);
> >  }
> > =20
> > -static void nf_flow_tuple_encap(struct sk_buff *skb,
> > +struct nf_flowtable_ctx {
> > +	const struct net_device	*in;
> > +	u32			offset;
> > +	u32			hdrsize;
> > +	struct {
> > +		u32 offset;
> > +		u8 proto;
> > +	} tun;
> > +};
>=20
> Could you add comments for the members here?

ack, I will do.

>=20
> In particular, we now have @offset and @tun.offset.
>=20
> I can guess that the offset is the start of the inner
> ip header and tun.offset is the start of the header
> following the inner ip header.

ack, right.

>=20
> This patch would perhaps be easier to review if the
> pure move of the ctx structure and passing the extra
> 'ctx' arg would be in a separate patch.

Ack I will do in v3.

Regards,
Lorenzo

--LPGBBWg64eFeJnrl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWlxoQAKCRA6cBh0uS2t
rLgIAP9ThRmGwKeScQVGlqadLXTE4TOKjOwZenv5vf5sN5KjTQEA92MDInCHApvN
UuH64gSGEEykL4272KqOVGBR2i65LQY=
=ZZrD
-----END PGP SIGNATURE-----

--LPGBBWg64eFeJnrl--

