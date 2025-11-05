Return-Path: <linux-kselftest+bounces-44826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2E6C36D74
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 17:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEED64525A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DF32E722;
	Wed,  5 Nov 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXhlyXNl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247420B800;
	Wed,  5 Nov 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360571; cv=none; b=tyBvdNgeR7LFM7GN6vWKNr6jzFMoL5ldL7/N2OwVGn33/wVWVqJ/G0xxfmi7cR0j+gMMQfzZKSnogkBZUNKSEKae0FblC/a5vR7YgVoZ4m+s37mNKA4lB2espRYYD0R0UTWaQH7JNwey2msNWGJkhooBbhobK0IICZ/HpcJcu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360571; c=relaxed/simple;
	bh=9vbIsqFg63pp3OvaNkYbiCmQzjxoPHaONUKKneVmdNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqE7dbFT64esU6EetlLT1KoHKlitSFktUyBaFWJt2wr6Y414PKhknCeQ1FNSPeTdXvb3qCwUcELyO4XmeBW782vCv8scnHznd1pBCk/TNdZQpiiPRR9HKX5BRSRPHNitLENMzTXzFrYVtDJR2PN9FiMbQa7q2gySDhkptT1G7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXhlyXNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18354C116B1;
	Wed,  5 Nov 2025 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762360570;
	bh=9vbIsqFg63pp3OvaNkYbiCmQzjxoPHaONUKKneVmdNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXhlyXNl2qHtFph7OY3zRFXAz5ENfh99xMMIi1PtgRUHneUV5LPc0MuOGj4EK6VgL
	 5WBoOjuCf8YqmTQQy7N6taZazKBN9OVc4n0N6W+/u5tPo3zeBNB4z789rD2FLFrzpt
	 fujFTgz9qbkpa1+3EP2zfmWz3pvfqe8pIaxfGlrilf7cpfgO6svjsZ3bFcUr/BhZVQ
	 DzB1PYm6cAA5yvG9dwGc4UicHEcB2UTG5Aj7Pl/wnN36RT6XOvTvVGb+tBRS9E45Y8
	 ONctu0zdpm5Ce6Z/Vz1YwYyb7YXSjUnp4728aJg5WHpZdi0ViGxbniqBNxI2SFih1y
	 S0AVwANjF63xA==
Date: Wed, 5 Nov 2025 17:36:07 +0100
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
Subject: Re: [PATCH nf-next v8 2/3] net: netfilter: Add IPIP flowtable tx sw
 acceleration
Message-ID: <aQt89wl7jyJcxbMJ@lore-desk>
References: <20251023-nf-flowtable-ipip-v8-0-5d5d8595c730@kernel.org>
 <20251023-nf-flowtable-ipip-v8-2-5d5d8595c730@kernel.org>
 <aQqDnjv8KLtQJaOW@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XyXETZSSq+haRcmW"
Content-Disposition: inline
In-Reply-To: <aQqDnjv8KLtQJaOW@calendula>


--XyXETZSSq+haRcmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Oct 23, 2025 at 10:50:16AM +0200, Lorenzo Bianconi wrote:
> [...]
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 0355461960ce3c0db49e00a6f77f48b031a635dc..eb8058fd7139a2b54570081=
46f979590f9f03c1d 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -897,6 +897,9 @@ struct net_device_path {
> >  			};
> > =20
> >  			u8	l3_proto;
> > +			u8	tos;
> > +			u8	ttl;
> > +			__be16	df;
> >  		} tun;
> >  		struct {
> >  			enum {
> > diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfil=
ter/nf_flow_table.h
> > index 6d00a8aa52584ad96d200683297c1b02bf1f6d4f..fe792f5a8f0528de021c273=
82b235688532614e4 100644
> > --- a/include/net/netfilter/nf_flow_table.h
> > +++ b/include/net/netfilter/nf_flow_table.h
> > @@ -119,6 +119,9 @@ struct flow_offload_tunnel {
> >  	};
> > =20
> >  	u8	l3_proto;
> > +	u8	tos;
> > +	u8	ttl;
> > +	__be16	df;
>=20
> This is now included in the hash that is used for the lookup, is it
> intentional to include these fields here? For rx, we cannot know ttl
> of the received packet?

it is my mistake, I will fix that in v9. Do we really need to add tos, ttl =
and
df in tuple for tx and rx acceleration? If so we can move the ttl field aft=
er
the __hash placeholder.

>=20
> Maybe this needs to be moved after the placeholder:
>=20
>         struct { }                      __hash;
>=20
> >  };
> > =20
> >  struct flow_offload_tuple {
> [...]
> > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_t=
able_ip.c
> > index 76081d5d2f71c10e0c65e906b3fb2769e3ab1466..a66ffa0c7fbe780a9f9a545=
e42d44dfe408e7cb2 100644
> > --- a/net/netfilter/nf_flow_table_ip.c
> > +++ b/net/netfilter/nf_flow_table_ip.c
> [...]
> > @@ -533,6 +589,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff =
*skb,
> >  	struct flow_offload *flow;
> >  	struct neighbour *neigh;
> >  	struct rtable *rt;
> > +	__be32 dest;
> >  	int ret;
> > =20
> >  	tuplehash =3D nf_flow_offload_lookup(&ctx, flow_table, skb);
> > @@ -555,8 +612,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff =
*skb,
> > =20
> >  	dir =3D tuplehash->tuple.dir;
> >  	flow =3D container_of(tuplehash, struct flow_offload, tuplehash[dir]);
> > +	reply_tuple =3D &flow->tuplehash[!dir].tuple;
>=20
> Nit: I'd suggest 'other_tuple' instead 'reply_tuple' given this is not
> strictly the reply tuple, just the tuple from the other direction.

ack, I will fix it in v9.

>=20
> > -	if (nf_flow_encap_push(skb, &flow->tuplehash[!dir].tuple) < 0)
> > +	if (nf_flow_encap_push(state->net, skb, reply_tuple))
> >  		return NF_DROP;
> > =20
> >  	switch (tuplehash->tuple.xmit_type) {
> > @@ -567,7 +625,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff =
*skb,
> >  			flow_offload_teardown(flow);
> >  			return NF_DROP;
> >  		}
> > -		neigh =3D ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, flow->tuplehash[!=
dir].tuple.src_v4.s_addr));
> > +		dest =3D reply_tuple->tun_num ? reply_tuple->tun.src_v4.s_addr
> > +					    : reply_tuple->src_v4.s_addr;
> > +		neigh =3D ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, dest));
> >  		if (IS_ERR(neigh)) {
> >  			flow_offload_teardown(flow);
> >  			return NF_DROP;
> > diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow=
_table_path.c
> > index bd5e9bf1ca393ab793976ba98a027b60f84882ba..cd0be2efe97596d0947621a=
5ea604373d5b61da8 100644
> > --- a/net/netfilter/nf_flow_table_path.c
> > +++ b/net/netfilter/nf_flow_table_path.c
> > @@ -190,7 +190,43 @@ static bool nft_flowtable_find_dev(const struct ne=
t_device *dev,
> >  	return found;
> >  }
> > =20
> > -static void nft_dev_forward_path(struct nf_flow_route *route,
> > +static int nft_flow_tunnel_update_route(const struct nft_pktinfo *pkt,
> > +					struct nf_flow_route *route,
> > +					enum ip_conntrack_dir dir)
> > +{
> > +	struct dst_entry *tun_dst =3D NULL;
> > +	struct flowi fl =3D {};
> > +
> > +	switch (nft_pf(pkt)) {
> > +	case NFPROTO_IPV4:
> > +		fl.u.ip4.daddr =3D route->tuple[!dir].in.tun.src_v4.s_addr;
> > +		fl.u.ip4.saddr =3D route->tuple[!dir].in.tun.dst_v4.s_addr;
> > +		fl.u.ip4.flowi4_iif =3D nft_in(pkt)->ifindex;
> > +		fl.u.ip4.flowi4_dscp =3D ip4h_dscp(ip_hdr(pkt->skb));
> > +		fl.u.ip4.flowi4_mark =3D pkt->skb->mark;
> > +		fl.u.ip4.flowi4_flags =3D FLOWI_FLAG_ANYSRC;
> > +		break;
> > +	case NFPROTO_IPV6:
> > +		fl.u.ip6.daddr =3D route->tuple[!dir].in.tun.src_v6;
> > +		fl.u.ip6.saddr =3D route->tuple[!dir].in.tun.dst_v6;
> > +		fl.u.ip6.flowi6_iif =3D nft_in(pkt)->ifindex;
> > +		fl.u.ip6.flowlabel =3D ip6_flowinfo(ipv6_hdr(pkt->skb));
> > +		fl.u.ip6.flowi6_mark =3D pkt->skb->mark;
> > +		fl.u.ip6.flowi6_flags =3D FLOWI_FLAG_ANYSRC;
> > +		break;
> > +	}
> > +
> > +	nf_route(nft_net(pkt), &tun_dst, &fl, false, nft_pf(pkt));
> > +	if (!tun_dst)
> > +		return -ENOENT;
> > +
> > +	nft_default_forward_path(route, tun_dst, dir);
>=20
> This overrides the previous dst that is set on here, is this leaking
> such dst?

ack, right. I will fix it in v9.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static void nft_dev_forward_path(const struct nft_pktinfo *pkt,
> > +				 struct nf_flow_route *route,
> >  				 const struct nf_conn *ct,
> >  				 enum ip_conntrack_dir dir,
> >  				 struct nft_flowtable *ft)
> > @@ -218,6 +254,12 @@ static void nft_dev_forward_path(struct nf_flow_ro=
ute *route,
> >  		route->tuple[!dir].in.tun.src_v6 =3D info.tun.dst_v6;
> >  		route->tuple[!dir].in.tun.dst_v6 =3D info.tun.src_v6;
> >  		route->tuple[!dir].in.tun.l3_proto =3D info.tun.l3_proto;
> > +		route->tuple[!dir].in.tun.tos =3D info.tun.tos;
> > +		route->tuple[!dir].in.tun.ttl =3D info.tun.ttl;
> > +		route->tuple[!dir].in.tun.df =3D info.tun.df;
> > +
> > +		if (nft_flow_tunnel_update_route(pkt, route, dir))
> > +			return;
>=20
> If tunnel route is found...
>=20
> >  	}
> >
> >  	route->tuple[!dir].in.num_encaps =3D info.num_encaps;
>=20
> ... num_encaps is never set?

ack, I will fix it in v9.

>=20
> Would you also extend the selftest to combine IPIP with vlan? Thanks.

sure, I will add it in v9.

Regards,
Lorenzo

>=20
> > @@ -274,9 +316,9 @@ int nft_flow_route(const struct nft_pktinfo *pkt, c=
onst struct nf_conn *ct,
> >  	nft_default_forward_path(route, other_dst, !dir);
> > =20
> >  	if (route->tuple[dir].xmit_type	=3D=3D FLOW_OFFLOAD_XMIT_NEIGH)
> > -		nft_dev_forward_path(route, ct, dir, ft);
> > +		nft_dev_forward_path(pkt, route, ct, dir, ft);
> >  	if (route->tuple[!dir].xmit_type =3D=3D FLOW_OFFLOAD_XMIT_NEIGH)
> > -		nft_dev_forward_path(route, ct, !dir, ft);
> > +		nft_dev_forward_path(pkt, route, ct, !dir, ft);
> > =20
> >  	return 0;
> >  }
> >=20
> > --=20
> > 2.51.0
> >=20

--XyXETZSSq+haRcmW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQt89wAKCRA6cBh0uS2t
rJnTAQD16itUuoysg/7XGBe4RN/cphM7W1SSAQsMGtVJD5IqEwD+NJQIiodh10EI
xRJQ4rg51TlHA+HpFUggzehVlbyBdAk=
=PJWq
-----END PGP SIGNATURE-----

--XyXETZSSq+haRcmW--

