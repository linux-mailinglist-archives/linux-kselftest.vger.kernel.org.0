Return-Path: <linux-kselftest+bounces-49103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3642CD2DB9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A93830049CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589FA2EAD1B;
	Fri, 16 Jan 2026 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYz0OHvZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5E281520;
	Fri, 16 Jan 2026 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551008; cv=none; b=st5lc1rZEA8Sy4BjObe2sBIHHJ1TE8i0JVG5/atslDfGp/gfbJiQWcmXLjHC0ZNYM4Inv6yhzobqC+Q6swSFV2dQtGpk26bAzkdeZsTpR7o1mEWRC5IoGeqwCEVOVfagLQdoJtSOMlJ75mteetkHPJ9dTCcY/whlEZ4lriLgPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551008; c=relaxed/simple;
	bh=d/cFImRTUy6wkXTzWiqD4MYVAJJ/M4ChRClZofMbHZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d55JERTTWx00bCffmxY1Vjcc9rr9NDPQLfcM0a07QckCpi8D9I5jy6hh5OI5n882zzOsfgqx8J+9CYOk9jZLVfxNBvk1hhJ5pBz4rhevzS6FiJLa+bo4JE2+23bCHYnVK2CpZsnSh+aiO1vpycxHd8yrngqAddhY/CuBfYYTdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYz0OHvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DDEC116C6;
	Fri, 16 Jan 2026 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551008;
	bh=d/cFImRTUy6wkXTzWiqD4MYVAJJ/M4ChRClZofMbHZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYz0OHvZPiboRdH6LGQwqLAzn2QLnXsI5K/NJplVybcmojInQHH059ucMS+QWX/qN
	 ORhyM1PUJPHqv9pBDCuPtSschCQv00vy7S9N5eR4uneYTrm4mgwCWZqZscWh1uMyiJ
	 e3hdZNpAY0OzecbCNK2yjB7zw4ymZtR1r71i/1386Q2SMgLC45jpxlWFwwyJdXXs5G
	 FiklerewkngO+OMKkt1E0Wytw8GePn1TQHGF+elA0AhV2i/sA2gN/FwgEZJ9o0/LT1
	 epi40D13z9k1jz9UfMWiBXdNNYefQqJZkPl4iWzNQ0GRRxAwvn3ubDUxxyv4aA8dOY
	 A7UU3yLqrY7NA==
Date: Fri, 16 Jan 2026 09:10:05 +0100
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
Subject: Re: [PATCH nf-next v2 2/4] netfilter: flowtable: Add IP6IP6 rx sw
 acceleration
Message-ID: <aWnyXbhwE8RvcDnO@lore-desk>
References: <20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org>
 <20251209-b4-flowtable-offload-ip6ip6-v2-2-44817f1be5c6@kernel.org>
 <aWZjba51DGI3EYG1@strlen.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T66ylR7dfTr86ZbQ"
Content-Disposition: inline
In-Reply-To: <aWZjba51DGI3EYG1@strlen.de>


--T66ylR7dfTr86ZbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > Introduce sw acceleration for rx path of IP6IP6 tunnels relying on the
> > netfilter flowtable infrastructure. Subsequent patches will add sw
> > acceleration for IP6IP6 tunnels tx path.
> > IP6IP6 rx sw acceleration can be tested running the following scenario
> > where the traffic is forwarded between two NICs (eth0 and eth1) and an
> > IP6IP6 tunnel is used to access a remote site (using eth1 as the underl=
ay
> > device):
> >=20
> > ETH0 -- TUN0 <=3D=3D> ETH1 -- [IP network] -- TUN1 (2001:db8:3::2)
> >=20
> > $ip addr show
> > 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state=
 UP group default qlen 1000
> >     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> >     inet6 2001:db8:1::2/64 scope global nodad
> >        valid_lft forever preferred_lft forever
> > 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state=
 UP group default qlen 1000
> >     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> >     inet6 2001:db8:2::1/64 scope global nodad
> >        valid_lft forever preferred_lft forever
> > 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue st=
ate UNKNOWN group default qlen 1000
> >     link/tunnel6 2001:db8:2::1 peer 2001:db8:2::2 permaddr ce9c:2940:7d=
cc::
> >     inet6 2002:db8:1::1/64 scope global nodad
> >        valid_lft forever preferred_lft forever
> >=20
> > $ip -6 route show
> > 2001:db8:1::/64 dev eth0 proto kernel metric 256 pref medium
> > 2001:db8:2::/64 dev eth1 proto kernel metric 256 pref medium
> > 2002:db8:1::/64 dev tun0 proto kernel metric 256 pref medium
> > default via 2002:db8:1::2 dev tun0 metric 1024 pref medium
> >=20
> > $nft list ruleset
> > table inet filter {
> >         flowtable ft {
> >                 hook ingress priority filter
> >                 devices =3D { eth0, eth1 }
> >         }
> >=20
> >         chain forward {
> >                 type filter hook forward priority filter; policy accept;
> >                 meta l4proto { tcp, udp } flow add @ft
> >         }
> > }
> >=20
> > Reproducing the scenario described above using veths I got the following
> > results:
> > - TCP stream received from the IPIP tunnel:
> >   - net-next: (baseline)                  ~ 81Gbps
> >   - net-next + IP6IP6 flowtbale support:  ~112Gbps
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  net/ipv6/ip6_tunnel.c            | 27 +++++++++++++
> >  net/netfilter/nf_flow_table_ip.c | 83 ++++++++++++++++++++++++++++++++=
+-------
> >  2 files changed, 97 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> > index 6405072050e0ef7521ca1fdddc4a0252e2159d2a..10341bfc16bd16a43290015=
952bd9a57658e6ae1 100644
> > --- a/net/ipv6/ip6_tunnel.c
> > +++ b/net/ipv6/ip6_tunnel.c
> > @@ -1828,6 +1828,32 @@ int ip6_tnl_encap_setup(struct ip6_tnl *t,
> >  }
> >  EXPORT_SYMBOL_GPL(ip6_tnl_encap_setup);
> > =20
> > +static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
> > +				     struct net_device_path *path)
> > +{
> > +	struct ip6_tnl *t =3D netdev_priv(ctx->dev);
> > +	struct flowi6 fl6 =3D {
> > +		.daddr =3D t->parms.raddr,
> > +	};
> > +	struct dst_entry *dst;
> > +	int err;
> > +
> > +	dst =3D ip6_route_output(dev_net(ctx->dev), NULL, &fl6);
> > +	if (!dst->error) {
> > +		path->type =3D DEV_PATH_TUN;
> > +		path->tun.src_v6 =3D t->parms.laddr;
> > +		path->tun.dst_v6 =3D t->parms.raddr;
> > +		path->tun.l3_proto =3D IPPROTO_IPV6;
> > +		path->dev =3D ctx->dev;
> > +		ctx->dev =3D dst->dev;
> > +	}
> > +
> > +	err =3D dst->error;
> > +	dst_release(dst);
> > +
> > +	return err;
> > +}
> > +
> >  static const struct net_device_ops ip6_tnl_netdev_ops =3D {
> >  	.ndo_init	=3D ip6_tnl_dev_init,
> >  	.ndo_uninit	=3D ip6_tnl_dev_uninit,
> > @@ -1836,6 +1862,7 @@ static const struct net_device_ops ip6_tnl_netdev=
_ops =3D {
> >  	.ndo_change_mtu =3D ip6_tnl_change_mtu,
> >  	.ndo_get_stats64 =3D dev_get_tstats64,
> >  	.ndo_get_iflink =3D ip6_tnl_get_iflink,
> > +	.ndo_fill_forward_path =3D ip6_tnl_fill_forward_path,
> >  };
> > =20
> >  #define IPXIPX_FEATURES (NETIF_F_SG |		\
> > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_t=
able_ip.c
> > index 14c01b59f76569170057d2465ee5953efb557bcc..8323f44a1ef172f16300a5c=
2c628464a99b2c47a 100644
> > --- a/net/netfilter/nf_flow_table_ip.c
> > +++ b/net/netfilter/nf_flow_table_ip.c
> > @@ -159,6 +159,7 @@ static void nf_flow_tuple_encap(struct nf_flowtable=
_ctx *ctx,
> >  	__be16 inner_proto =3D skb->protocol;
> >  	struct vlan_ethhdr *veth;
> >  	struct pppoe_hdr *phdr;
> > +	struct ipv6hdr *ip6h;
> >  	struct iphdr *iph;
> >  	u16 offset =3D 0;
> >  	int i =3D 0;
> > @@ -185,12 +186,25 @@ static void nf_flow_tuple_encap(struct nf_flowtab=
le_ctx *ctx,
> >  		break;
> >  	}
> > =20
> > -	if (inner_proto =3D=3D htons(ETH_P_IP) &&
> > -	    ctx->tun.proto =3D=3D IPPROTO_IPIP) {
>=20
> This change is done in the preceeding patch, then removed again?
> Looks like the previous patch should leave the
> code as-is?

ack, right. I will fix it.

>=20
> > +	switch (inner_proto) {
> > +	case htons(ETH_P_IP):
> >  		iph =3D (struct iphdr *)(skb_network_header(skb) + offset);
> > -		tuple->tun.dst_v4.s_addr =3D iph->daddr;
> > -		tuple->tun.src_v4.s_addr =3D iph->saddr;
> > -		tuple->tun.l3_proto =3D IPPROTO_IPIP;
> > +		if (ctx->tun.proto =3D=3D IPPROTO_IPIP) {
> > +			tuple->tun.dst_v4.s_addr =3D iph->daddr;
> > +			tuple->tun.src_v4.s_addr =3D iph->saddr;
> > +			tuple->tun.l3_proto =3D IPPROTO_IPIP;
> > +		}
> > +		break;
> > +	case htons(ETH_P_IPV6):
> > +		ip6h =3D (struct ipv6hdr *)(skb_network_header(skb) + offset);
> > +		if (ctx->tun.proto =3D=3D IPPROTO_IPV6) {
> > +			tuple->tun.dst_v6 =3D ip6h->daddr;
> > +			tuple->tun.src_v6 =3D ip6h->saddr;
> > +			tuple->tun.l3_proto =3D IPPROTO_IPV6;
> > +		}
> > +		break;
> > +	default:
> > +		break;
> >  	}
> >  }
> > =20
> > @@ -324,10 +338,45 @@ static bool nf_flow_ip4_tunnel_proto(struct nf_fl=
owtable_ctx *ctx,
> >  	return true;
> >  }
> > =20
> > -static void nf_flow_ip4_tunnel_pop(struct nf_flowtable_ctx *ctx,
> > -				   struct sk_buff *skb)
> > +static bool nf_flow_ip6_tunnel_proto(struct nf_flowtable_ctx *ctx,
> > +				     struct sk_buff *skb)
> >  {
> > -	if (ctx->tun.proto !=3D IPPROTO_IPIP)
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	struct ipv6hdr *ip6h;
> > +	__be16 frag_off;
> > +	u8 nexthdr;
> > +	int hdrlen;
> > +
> > +	if (!pskb_may_pull(skb, sizeof(*ip6h) + ctx->offset))
> > +		return false;
> > +
> > +	ip6h =3D (struct ipv6hdr *)(skb_network_header(skb) + ctx->offset);
> > +	if (ip6h->hop_limit <=3D 1)
> > +		return false;
>=20
> There are multiple places where we do a pull on the skb, is this
> needed?  Could this be replaced by skb_header_pointer() ?

ack, I will fix it in v3.

Regards,
Lorenzo

>=20
> doing skb->head realloc might be expensive and its more
> error prone.
>=20
> Or is there a requirement that the ctx->offsets can be
> accessed via skb->head/data?

--T66ylR7dfTr86ZbQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWnyXQAKCRA6cBh0uS2t
rFRmAPwLvrBvXkp1bAFVBLeELTrkaYiwGY0zPRNeSOfm9agGOwEA/Tzo/x5bWng4
8i9opbB2bT362KNGZL9dhFk4vYPQyAA=
=jKux
-----END PGP SIGNATURE-----

--T66ylR7dfTr86ZbQ--

