Return-Path: <linux-kselftest+bounces-36745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F8AFC4D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 09:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6917F480830
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8129C352;
	Tue,  8 Jul 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+8qDZLW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5E629B201;
	Tue,  8 Jul 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961508; cv=none; b=Nx8zhmywL/QstbF83QC6TEQMWY2yloqoJfewD3kQee+WRLWzYQ9VIV8+bxDtj52u/fcZG8Pk8bPXPtD+BCkrnbIHGEpt0z2+rcXLND7aikR/JGnKauzwQ7odITN5sgzSGIwfqBOKxF8CkmT9yJGIA5az2Qg7+vG42OaAJHSJuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961508; c=relaxed/simple;
	bh=uE5MlteM8/gqfvbo7CDXi1yeE6bRnNqClJpOH7U1InQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL4o5Oug1LXS5AYJc6Dp5JOCyyvEQcUxuSP9RocO6yrqXYPTbrHdRAqdz6ksWjGfqVMCus+ekWB6x88+WWtLebT+BRQEPuo+WPn9U/ncyxyZUrS85B0PuT1z9+a4GZGUE/PDh6fZwqL01FbyZ9tDZrNQVU+Gy0EuBLc8GU6xFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+8qDZLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8524C4CEED;
	Tue,  8 Jul 2025 07:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751961507;
	bh=uE5MlteM8/gqfvbo7CDXi1yeE6bRnNqClJpOH7U1InQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+8qDZLWpOt2R5ZFZROnfKpVPl84XQjA6c9sV990pr8e2RO6PDyC9DdBA8sKbtpo9
	 OGYQ5XhaTG+kMWgox9wqkzDkwpNK0Y6RnhCSAlHsWQQAWGsHErxA+mYIXIhfW9kG3y
	 8TL10jy5azbo4EUvviEdaFKcAY0o7j3Qv5dX5GLsjSDpMTF5zSG2AzhRj2OEaevovs
	 LYrXFypqSuk1zoFZ0LH6kUXXs13BVbNaMUWx4BeqgsaO760gKfAF2dRB9qs7chnQpe
	 a9kbJtmNzDGf8XVCZ3z9UcqKbiLesxHTf9A+U+83zJ3U7dgNXuoLMRV9agyjsAXogL
	 7tZSaTPWPptxg==
Date: Tue, 8 Jul 2025 09:58:24 +0200
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
Message-ID: <aGzPoAKjq8mZGOn2@lore-desk>
References: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
 <20250703-nf-flowtable-ipip-v3-1-880afd319b9f@kernel.org>
 <aGaVKWKOKj1a-eG1@calendula>
 <aGfQeF_6c2W1ecrX@lore-desk>
 <aGwm7XrM4YaJREru@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="heBi9EOYhaWjRcX5"
Content-Disposition: inline
In-Reply-To: <aGwm7XrM4YaJREru@calendula>


--heBi9EOYhaWjRcX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 07, Pablo Neira Ayuso wrote:
> On Fri, Jul 04, 2025 at 03:00:40PM +0200, Lorenzo Bianconi wrote:
> > > On Thu, Jul 03, 2025 at 04:16:02PM +0200, Lorenzo Bianconi wrote:
> > > > Introduce SW acceleration for IPIP tunnels in the netfilter flowtab=
le
> > > > infrastructure.
> > > > IPIP SW acceleration can be tested running the following scenario w=
here
> > > > the traffic is forwarded between two NICs (eth0 and eth1) and an IP=
IP
> > > > tunnel is used to access a remote site (using eth1 as the underlay =
device):
> > >=20
> > > Question below.
> > >=20
> > > > ETH0 -- TUN0 <=3D=3D> ETH1 -- [IP network] -- TUN1 (192.168.100.2)
> > > >=20
> > > > $ip addr show
> > > > 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue s=
tate UP group default qlen 1000
> > > >     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> > > >     inet 192.168.0.2/24 scope global eth0
> > > >        valid_lft forever preferred_lft forever
> > > > 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue s=
tate UP group default qlen 1000
> > > >     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> > > >     inet 192.168.1.1/24 scope global eth1
> > > >        valid_lft forever preferred_lft forever
> > > > 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueu=
e state UNKNOWN group default qlen 1000
> > > >     link/ipip 192.168.1.1 peer 192.168.1.2
> > > >     inet 192.168.100.1/24 scope global tun0
> > > >        valid_lft forever preferred_lft forever
> > > >=20
> > > > $ip route show
> > > > default via 192.168.100.2 dev tun0
> > > > 192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
> > > > 192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
> > > > 192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100.1
> > > >=20
> > > > $nft list ruleset
> > > > table inet filter {
> > > >         flowtable ft {
> > > >                 hook ingress priority filter
> > > >                 devices =3D { eth0, eth1 }
> > > >         }
> > > >=20
> > > >         chain forward {
> > > >                 type filter hook forward priority filter; policy ac=
cept;
> > > >                 meta l4proto { tcp, udp } flow add @ft
> > > >         }
> > > > }
> > > >=20
> > > > Reproducing the scenario described above using veths I got the foll=
owing
> > > > results:
> > > > - TCP stream transmitted into the IPIP tunnel:
> > > >   - net-next:				~41Gbps
> > > >   - net-next + IPIP flowtbale support:	~40Gbps
> > >                       ^^^^^^^^^
> > > no gain on tx side.
> >=20
> > In this case the IPIP flowtable acceleration is effective just on the A=
CKs
> > packets so I guess it is expected we have ~ the same results. The real =
gain is
> > when the TCP stream is from the tunnel net_device to the NIC one.
>=20
> That is, only rx side follows the flowtable datapath.
>=20
> > > > - TCP stream received from the IPIP tunnel:
> > > >   - net-next:				~35Gbps
> > > >   - net-next + IPIP flowtbale support:	~49Gbps
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
> > > >  net/netfilter/nf_flow_table_ip.c | 34 ++++++++++++++++++++++++++++=
++++--
> > > >  2 files changed, 53 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> > > > index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..05fb1c859170d74009d=
693bc8513183bdec3ff90 100644
> > > > --- a/net/ipv4/ipip.c
> > > > +++ b/net/ipv4/ipip.c
> > > > @@ -353,6 +353,26 @@ ipip_tunnel_ctl(struct net_device *dev, struct=
 ip_tunnel_parm_kern *p, int cmd)
> > > >  	return ip_tunnel_ctl(dev, p, cmd);
> > > >  }
> > > > =20
> > > > +static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
> > > > +				  struct net_device_path *path)
> > > > +{
> > > > +	struct ip_tunnel *tunnel =3D netdev_priv(ctx->dev);
> > > > +	const struct iphdr *tiph =3D &tunnel->parms.iph;
> > > > +	struct rtable *rt;
> > > > +
> > > > +	rt =3D ip_route_output(dev_net(ctx->dev), tiph->daddr, 0, 0, 0,
> > > > +			     RT_SCOPE_UNIVERSE);
> > > > +	if (IS_ERR(rt))
> > > > +		return PTR_ERR(rt);
> > > > +
> > > > +	path->type =3D DEV_PATH_ETHERNET;
> > > > +	path->dev =3D ctx->dev;
> > > > +	ctx->dev =3D rt->dst.dev;
> > > > +	ip_rt_put(rt);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static const struct net_device_ops ipip_netdev_ops =3D {
> > > >  	.ndo_init       =3D ipip_tunnel_init,
> > > >  	.ndo_uninit     =3D ip_tunnel_uninit,
> > > > @@ -362,6 +382,7 @@ static const struct net_device_ops ipip_netdev_=
ops =3D {
> > > >  	.ndo_get_stats64 =3D dev_get_tstats64,
> > > >  	.ndo_get_iflink =3D ip_tunnel_get_iflink,
> > > >  	.ndo_tunnel_ctl	=3D ipip_tunnel_ctl,
> > > > +	.ndo_fill_forward_path =3D ipip_fill_forward_path,
> > > >  };
> > > > =20
> > > >  #define IPIP_FEATURES (NETIF_F_SG |		\
> > > > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_fl=
ow_table_ip.c
> > > > index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..6b55e00b1022f0a2b02=
d9bfd1bd34bb55c1b83f7 100644
> > > > --- a/net/netfilter/nf_flow_table_ip.c
> > > > +++ b/net/netfilter/nf_flow_table_ip.c
> > > > @@ -277,13 +277,37 @@ static unsigned int nf_flow_xmit_xfrm(struct =
sk_buff *skb,
> > > >  	return NF_STOLEN;
> > > >  }
> > > > =20
> > > > +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
> > > > +{
> > > > +	struct iphdr *iph;
> > > > +
> > > > +	if (!pskb_may_pull(skb, sizeof(*iph)))
> > > > +		return false;
> > > > +
> > > > +	iph =3D (struct iphdr *)skb_network_header(skb);
> > > > +	*size =3D iph->ihl << 2;
> > > > +
> > > > +	if (ip_is_fragment(iph) || unlikely(ip_has_options(*size)))
> > > > +		return false;
> > > > +
> > > > +	if (iph->ttl <=3D 1)
> > > > +		return false;
> > > > +
> > > > +	return iph->protocol =3D=3D IPPROTO_IPIP;
> > >=20
> >=20
> > what kind of sanity checks are we supposed to perform? Something simila=
r to
> > what we have in ip_rcv_core()?
>=20
> I am not referring to sanity checks.
>=20
> VLAN/PPP ID (layer 2 encapsulation) is part of the lookup in the
> flowtable, why IPIP (layer 3 tunnel) does not get the same handling?

ack, right. Do you have any suggestion about what field (or combination
of fields) we can use from the outer IP header similar to the VLAN/PPP
encapsulation?

>=20
> > > Once the flow is in the flowtable, it is possible to inject traffic
> > > with forged outer IP header, this is only looking at the inner IP
> > > header.
> >=20
> > what is the difference with the plain IP/TCP use-case?
>=20
> Not referring to the generic packet forging scenario. I refer to the
> scenario that would allow to forward packets for any IPIP outer header
> given the inner header finds a matching in the flowtable. I think that
> needs to be sorted out.

ack.

Regards,
Lorenzo

--heBi9EOYhaWjRcX5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGzPoAAKCRA6cBh0uS2t
rI/WAQDzIxwDuAnYbFygdncqXI698TcePfJGEsoicgF9XLelPAD/SH7UGxjjnFss
s4b+TWT49Xp89aT2sRdVNG9IxOPWTwY=
=6tTR
-----END PGP SIGNATURE-----

--heBi9EOYhaWjRcX5--

