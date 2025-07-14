Return-Path: <linux-kselftest+bounces-37282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3130B047BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 21:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33973B07E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512A27701E;
	Mon, 14 Jul 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVxaT53g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDC204098;
	Mon, 14 Jul 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520015; cv=none; b=dH80Vc+bZ85DclrgGZiWEZgGmx2PAtmWpltFRklsvLYoKsGzSNgqlGp/ui8ycallsYQvJTIcmGRpZ45Zw+u8VIls68LDmXO9ATZRxPUhB7xeFvZhR5hbgAWQ7LgzZ6n2rq6xWb/ypgZat1ZBsW4KjyMkCeMjvHRuc9YdB0b30JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520015; c=relaxed/simple;
	bh=bXi7xFaFhppvbglAowkQSJ3ZXqcZp2byV6iBG4JAZ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnRL70y1N0NYh4MJ3UWjJYUh1MCSi5ndUhsk6sw34AK7bgqlnXfMTNZeGQXaCCbbK6AVaujYe5hqq97bihijjvc8pqPtm8ppvEJ6u2w3QwIqBtkGd3dMBjpEZ1T+yHlWPBaJ1KpjySKTkcOcqtWePewRIZPrVX5YM5qng01lm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVxaT53g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5693FC4CEED;
	Mon, 14 Jul 2025 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752520014;
	bh=bXi7xFaFhppvbglAowkQSJ3ZXqcZp2byV6iBG4JAZ+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVxaT53gtwibGmn4+2BUMuECpmIcX2u7iAxNms7G+9q9pt+ciGIVQGUD1csabRSSp
	 Booozpv0p25DFuWMzZp5gNJBPxzmGoNMfH36P48J2kvyB3G4sZ66fCYxHPOC52CUe3
	 wSg81oO+NNuhh1OQHP/haYEypBtcSDeOdeOOCUNHc0d/FTk6uWm1e3NJwtITVPA7rn
	 +mMvk16BeMSRApSqAUR1Vp2ysl7SzapJiHJWv6jbUsM1YSswPHEl4HxuycFIlyrBZN
	 D03/F4fgz6iJ4ZkqfAZHeMazvRpmCaiEJxG9ApZeM86vcybhQAwINHx7wKYrE5nJ4u
	 2IOnJmKxEilJQ==
Date: Mon, 14 Jul 2025 21:06:52 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v3 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Message-ID: <aHVVTHLh-3uKZG9o@lore-desk>
References: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
 <20250703-nf-flowtable-ipip-v3-1-880afd319b9f@kernel.org>
 <aGaVKWKOKj1a-eG1@calendula>
 <aGfQeF_6c2W1ecrX@lore-desk>
 <aGwm7XrM4YaJREru@calendula>
 <aGzPoAKjq8mZGOn2@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xy3PuCG39z8GcYvn"
Content-Disposition: inline
In-Reply-To: <aGzPoAKjq8mZGOn2@lore-desk>


--xy3PuCG39z8GcYvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Jul 07, Pablo Neira Ayuso wrote:
> > On Fri, Jul 04, 2025 at 03:00:40PM +0200, Lorenzo Bianconi wrote:
> > > > On Thu, Jul 03, 2025 at 04:16:02PM +0200, Lorenzo Bianconi wrote:
> > > > > Introduce SW acceleration for IPIP tunnels in the netfilter flowt=
able
> > > > > infrastructure.
> > > > > IPIP SW acceleration can be tested running the following scenario=
 where
> > > > > the traffic is forwarded between two NICs (eth0 and eth1) and an =
IPIP
> > > > > tunnel is used to access a remote site (using eth1 as the underla=
y device):
> > > >=20
> > > > Question below.
> > > >=20
> > > > > ETH0 -- TUN0 <=3D=3D> ETH1 -- [IP network] -- TUN1 (192.168.100.2)
> > > > >=20
> > > > > $ip addr show
> > > > > 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue=
 state UP group default qlen 1000
> > > > >     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> > > > >     inet 192.168.0.2/24 scope global eth0
> > > > >        valid_lft forever preferred_lft forever
> > > > > 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue=
 state UP group default qlen 1000
> > > > >     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> > > > >     inet 192.168.1.1/24 scope global eth1
> > > > >        valid_lft forever preferred_lft forever
> > > > > 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqu=
eue state UNKNOWN group default qlen 1000
> > > > >     link/ipip 192.168.1.1 peer 192.168.1.2
> > > > >     inet 192.168.100.1/24 scope global tun0
> > > > >        valid_lft forever preferred_lft forever
> > > > >=20
> > > > > $ip route show
> > > > > default via 192.168.100.2 dev tun0
> > > > > 192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
> > > > > 192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
> > > > > 192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100=
=2E1
> > > > >=20
> > > > > $nft list ruleset
> > > > > table inet filter {
> > > > >         flowtable ft {
> > > > >                 hook ingress priority filter
> > > > >                 devices =3D { eth0, eth1 }
> > > > >         }
> > > > >=20
> > > > >         chain forward {
> > > > >                 type filter hook forward priority filter; policy =
accept;
> > > > >                 meta l4proto { tcp, udp } flow add @ft
> > > > >         }
> > > > > }
> > > > >=20
> > > > > Reproducing the scenario described above using veths I got the fo=
llowing
> > > > > results:
> > > > > - TCP stream transmitted into the IPIP tunnel:
> > > > >   - net-next:				~41Gbps
> > > > >   - net-next + IPIP flowtbale support:	~40Gbps
> > > >                       ^^^^^^^^^
> > > > no gain on tx side.
> > >=20
> > > In this case the IPIP flowtable acceleration is effective just on the=
 ACKs
> > > packets so I guess it is expected we have ~ the same results. The rea=
l gain is
> > > when the TCP stream is from the tunnel net_device to the NIC one.
> >=20
> > That is, only rx side follows the flowtable datapath.
> >=20
> > > > > - TCP stream received from the IPIP tunnel:
> > > > >   - net-next:				~35Gbps
> > > > >   - net-next + IPIP flowtbale support:	~49Gbps
> > > > >=20
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > ---
> > > > >  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
> > > > >  net/netfilter/nf_flow_table_ip.c | 34 ++++++++++++++++++++++++++=
++++++--
> > > > >  2 files changed, 53 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> > > > > index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..05fb1c859170d7400=
9d693bc8513183bdec3ff90 100644
> > > > > --- a/net/ipv4/ipip.c
> > > > > +++ b/net/ipv4/ipip.c
> > > > > @@ -353,6 +353,26 @@ ipip_tunnel_ctl(struct net_device *dev, stru=
ct ip_tunnel_parm_kern *p, int cmd)
> > > > >  	return ip_tunnel_ctl(dev, p, cmd);
> > > > >  }
> > > > > =20
> > > > > +static int ipip_fill_forward_path(struct net_device_path_ctx *ct=
x,
> > > > > +				  struct net_device_path *path)
> > > > > +{
> > > > > +	struct ip_tunnel *tunnel =3D netdev_priv(ctx->dev);
> > > > > +	const struct iphdr *tiph =3D &tunnel->parms.iph;
> > > > > +	struct rtable *rt;
> > > > > +
> > > > > +	rt =3D ip_route_output(dev_net(ctx->dev), tiph->daddr, 0, 0, 0,
> > > > > +			     RT_SCOPE_UNIVERSE);
> > > > > +	if (IS_ERR(rt))
> > > > > +		return PTR_ERR(rt);
> > > > > +
> > > > > +	path->type =3D DEV_PATH_ETHERNET;
> > > > > +	path->dev =3D ctx->dev;
> > > > > +	ctx->dev =3D rt->dst.dev;
> > > > > +	ip_rt_put(rt);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static const struct net_device_ops ipip_netdev_ops =3D {
> > > > >  	.ndo_init       =3D ipip_tunnel_init,
> > > > >  	.ndo_uninit     =3D ip_tunnel_uninit,
> > > > > @@ -362,6 +382,7 @@ static const struct net_device_ops ipip_netde=
v_ops =3D {
> > > > >  	.ndo_get_stats64 =3D dev_get_tstats64,
> > > > >  	.ndo_get_iflink =3D ip_tunnel_get_iflink,
> > > > >  	.ndo_tunnel_ctl	=3D ipip_tunnel_ctl,
> > > > > +	.ndo_fill_forward_path =3D ipip_fill_forward_path,
> > > > >  };
> > > > > =20
> > > > >  #define IPIP_FEATURES (NETIF_F_SG |		\
> > > > > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_=
flow_table_ip.c
> > > > > index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..6b55e00b1022f0a2b=
02d9bfd1bd34bb55c1b83f7 100644
> > > > > --- a/net/netfilter/nf_flow_table_ip.c
> > > > > +++ b/net/netfilter/nf_flow_table_ip.c
> > > > > @@ -277,13 +277,37 @@ static unsigned int nf_flow_xmit_xfrm(struc=
t sk_buff *skb,
> > > > >  	return NF_STOLEN;
> > > > >  }
> > > > > =20
> > > > > +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *si=
ze)
> > > > > +{
> > > > > +	struct iphdr *iph;
> > > > > +
> > > > > +	if (!pskb_may_pull(skb, sizeof(*iph)))
> > > > > +		return false;
> > > > > +
> > > > > +	iph =3D (struct iphdr *)skb_network_header(skb);
> > > > > +	*size =3D iph->ihl << 2;
> > > > > +
> > > > > +	if (ip_is_fragment(iph) || unlikely(ip_has_options(*size)))
> > > > > +		return false;
> > > > > +
> > > > > +	if (iph->ttl <=3D 1)
> > > > > +		return false;
> > > > > +
> > > > > +	return iph->protocol =3D=3D IPPROTO_IPIP;
> > > >=20
> > >=20
> > > what kind of sanity checks are we supposed to perform? Something simi=
lar to
> > > what we have in ip_rcv_core()?
> >=20
> > I am not referring to sanity checks.
> >=20
> > VLAN/PPP ID (layer 2 encapsulation) is part of the lookup in the
> > flowtable, why IPIP (layer 3 tunnel) does not get the same handling?
>=20
> ack, right. Do you have any suggestion about what field (or combination
> of fields) we can use from the outer IP header similar to the VLAN/PPP
> encapsulation?

What about a hash computed over some of the outer IP header fields? (e.g IP
saddr and daddr).

Regards,
Lorenzo

>=20
> >=20
> > > > Once the flow is in the flowtable, it is possible to inject traffic
> > > > with forged outer IP header, this is only looking at the inner IP
> > > > header.
> > >=20
> > > what is the difference with the plain IP/TCP use-case?
> >=20
> > Not referring to the generic packet forging scenario. I refer to the
> > scenario that would allow to forward packets for any IPIP outer header
> > given the inner header finds a matching in the flowtable. I think that
> > needs to be sorted out.
>=20
> ack.
>=20
> Regards,
> Lorenzo



--xy3PuCG39z8GcYvn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaHVVTAAKCRA6cBh0uS2t
rC98AQC7S+NaP6yVNKU/pR+A3WiTGmiGV9CxZRTM+geLl4u1twD/dzAgLlo9iDM9
b3FmkFWDCuc4xi2m08lf5RJZFwg9ZQY=
=q+lU
-----END PGP SIGNATURE-----

--xy3PuCG39z8GcYvn--

