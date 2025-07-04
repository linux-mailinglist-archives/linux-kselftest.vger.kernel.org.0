Return-Path: <linux-kselftest+bounces-36559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3394DAF9389
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E901CC00F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F78303DE0;
	Fri,  4 Jul 2025 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzdsvMG0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC622FCE00
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634051; cv=none; b=F4ikjeSxpKYVapt1CqB5UHojg6WOf36Sh1tp11O2tR8wRx3ODGK6g6389t369eglgU/ECjrETd1XdNYO0TwiMxdQKn6ZnsptALQFNVCy1T16uvcKQRFfbwiZNpLQSkNksZYyyYb/GU9KCuHKM5+H3sRUfm9MXGugNAg5iqULSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634051; c=relaxed/simple;
	bh=NdhINJYDzJpYgHW5Fj1UH7L/8JMERHyNTyr2NaoYoyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPj4RCIR+rV8ddivaPhaW9tqyh55fUuYy8yYr4c3/M4b48xg7PzrgSZ1AIRADbJWMGAfOXKX9BTxuhEUDENQQ0/dAnEKp+BycA+ULc/pOvMiCcgNRrq6qqWdLTJsmfwBcLlGkLfUxycXRXyKOp+5qRnG4DpHXjreQJQvwIBDL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzdsvMG0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751634048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXQCVREPP6j1xMSTefP6W64EZBhJxFWqjEZUcvvKuzE=;
	b=VzdsvMG0XdYOXjrRIig3NDLB0plR3jqEHDEfrBUrutYcD+B6oW2CZw2rFeF49Jje9D8ve6
	hk2Ov9/LmHkmCiDtgPHwYcc8d5dgo0eLAVyrMsrILVYIpeCOn9vXSJ61ixtKOfG0po6fLu
	5dmVgRW7C5yznxGIjo94B1vEgC17EVg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-HFdvkA4QOda5U0pZwXRySQ-1; Fri, 04 Jul 2025 09:00:45 -0400
X-MC-Unique: HFdvkA4QOda5U0pZwXRySQ-1
X-Mimecast-MFC-AGG-ID: HFdvkA4QOda5U0pZwXRySQ_1751634044
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so595509f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jul 2025 06:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634044; x=1752238844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXQCVREPP6j1xMSTefP6W64EZBhJxFWqjEZUcvvKuzE=;
        b=Kx0Qx61tUiAA0kki+2F7I/Z7SxxQQ6UoKex029tVHm4sp2C3Y7toNCoQeRo7VhcxeY
         pYf1rZSg64xhGzIUKOxNtf7CdLRftK9FA/gASphyyBsakDjGeYA5cP0ex1AO5nL5k7fA
         zCTXzvtwH02sE50YNjGsP0IDD7dIw3PRkeeF+QMQnxnKU5A0c9airhRWKCkzlukFae89
         a0sWH7BqFibu/d7fYZx/56m3hxfBqLCC/K3Pu9naR6iHR/IiB0508urdT31WhnRTOr1o
         +FaCToTZWEMIjqWMkKqx5vIAQ1Vf+TbN/3SxLRXT6NsqjFT27HsCA7P2erSJcugBcGm/
         WJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXxQAy66Qcn+F8zna+71sb/vIG5Tr2FMOVzQXEcGRI7DFWUv0UcnNLL7F0AJ3MT63fY9G2FQNy85o9qmNPE+So=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5BbQBG6fveA2vUdmj1JJ1pj/m8Gm891XMsmV8pY5eqhSVrVy
	07DsDMKcMrylt5xNu4ZD0T1vchAOMjJrIoqxJxH2GdSBCbUZ9pJI7F3DuvIhCjiH2CTBIayk8Vi
	QdfS19DbKRq09F0ANMdZl7ZdVBAaDmb8M1w7MdD7O+6ajjolVtALhjgV1Fl+Uhg49Nu3zbA==
X-Gm-Gg: ASbGnct9CnltnpGWTeye2FWIrlq6CPDcRuL1wq9U8haP8/fmdINmZp20JjcULxdhL/n
	Z/BbsnGNVM7A7q7yECRTkMwnjbvvBEefgQLECFSDTwntBzkWtj2NLn8RRRqMUGNaQ42yEqbNQs0
	q8URs70YQxufDjoKU/WQvwW9Oq7dzL/rpEj8pgrs6cKodbuuWkMI1P6KYDG6PR5NCjY2HgalNj5
	0Ufs8DAXYrwz5oE4e9Yqi69Mt1SqQVEy94qZAwRVeXF8ln9W8ojbtO1ACNlcZUoCQDzFjKcluQ9
	1PwKei4tYdhSvY911h8zxF7G0hGKwZgAKUKAQwHbvWws8KsmcwhH8Knvpn+osZQiG4Uv+w==
X-Received: by 2002:a05:6000:481c:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3b49700c535mr1725431f8f.3.1751634043564;
        Fri, 04 Jul 2025 06:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa4HKUZ3teX9TCdSk8wN5/izAQSZCR696BxsmgiXVbd0G0YsfWUUcQQ09jyylhGB7fr56W2A==
X-Received: by 2002:a05:6000:481c:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3b49700c535mr1725369f8f.3.1751634042943;
        Fri, 04 Jul 2025 06:00:42 -0700 (PDT)
Received: from localhost (net-130-25-105-15.cust.vodafonedsl.it. [130.25.105.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b472259842sm2432211f8f.72.2025.07.04.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:00:41 -0700 (PDT)
Date: Fri, 4 Jul 2025 15:00:40 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
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
Message-ID: <aGfQeF_6c2W1ecrX@lore-desk>
References: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
 <20250703-nf-flowtable-ipip-v3-1-880afd319b9f@kernel.org>
 <aGaVKWKOKj1a-eG1@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0jKr/ed/cH4ZgbY6"
Content-Disposition: inline
In-Reply-To: <aGaVKWKOKj1a-eG1@calendula>


--0jKr/ed/cH4ZgbY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jul 03, 2025 at 04:16:02PM +0200, Lorenzo Bianconi wrote:
> > Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> > infrastructure.
> > IPIP SW acceleration can be tested running the following scenario where
> > the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
> > tunnel is used to access a remote site (using eth1 as the underlay devi=
ce):
>=20
> Question below.
>=20
> > ETH0 -- TUN0 <=3D=3D> ETH1 -- [IP network] -- TUN1 (192.168.100.2)
> >=20
> > $ip addr show
> > 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state=
 UP group default qlen 1000
> >     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> >     inet 192.168.0.2/24 scope global eth0
> >        valid_lft forever preferred_lft forever
> > 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state=
 UP group default qlen 1000
> >     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> >     inet 192.168.1.1/24 scope global eth1
> >        valid_lft forever preferred_lft forever
> > 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue st=
ate UNKNOWN group default qlen 1000
> >     link/ipip 192.168.1.1 peer 192.168.1.2
> >     inet 192.168.100.1/24 scope global tun0
> >        valid_lft forever preferred_lft forever
> >=20
> > $ip route show
> > default via 192.168.100.2 dev tun0
> > 192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
> > 192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
> > 192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100.1
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
> > - TCP stream transmitted into the IPIP tunnel:
> >   - net-next:				~41Gbps
> >   - net-next + IPIP flowtbale support:	~40Gbps
>                       ^^^^^^^^^
> no gain on tx side.

In this case the IPIP flowtable acceleration is effective just on the ACKs
packets so I guess it is expected we have ~ the same results. The real gain=
 is
when the TCP stream is from the tunnel net_device to the NIC one.

>=20
> > - TCP stream received from the IPIP tunnel:
> >   - net-next:				~35Gbps
> >   - net-next + IPIP flowtbale support:	~49Gbps
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
> >  net/netfilter/nf_flow_table_ip.c | 34 ++++++++++++++++++++++++++++++++=
--
> >  2 files changed, 53 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> > index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..05fb1c859170d74009d693b=
c8513183bdec3ff90 100644
> > --- a/net/ipv4/ipip.c
> > +++ b/net/ipv4/ipip.c
> > @@ -353,6 +353,26 @@ ipip_tunnel_ctl(struct net_device *dev, struct ip_=
tunnel_parm_kern *p, int cmd)
> >  	return ip_tunnel_ctl(dev, p, cmd);
> >  }
> > =20
> > +static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
> > +				  struct net_device_path *path)
> > +{
> > +	struct ip_tunnel *tunnel =3D netdev_priv(ctx->dev);
> > +	const struct iphdr *tiph =3D &tunnel->parms.iph;
> > +	struct rtable *rt;
> > +
> > +	rt =3D ip_route_output(dev_net(ctx->dev), tiph->daddr, 0, 0, 0,
> > +			     RT_SCOPE_UNIVERSE);
> > +	if (IS_ERR(rt))
> > +		return PTR_ERR(rt);
> > +
> > +	path->type =3D DEV_PATH_ETHERNET;
> > +	path->dev =3D ctx->dev;
> > +	ctx->dev =3D rt->dst.dev;
> > +	ip_rt_put(rt);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct net_device_ops ipip_netdev_ops =3D {
> >  	.ndo_init       =3D ipip_tunnel_init,
> >  	.ndo_uninit     =3D ip_tunnel_uninit,
> > @@ -362,6 +382,7 @@ static const struct net_device_ops ipip_netdev_ops =
=3D {
> >  	.ndo_get_stats64 =3D dev_get_tstats64,
> >  	.ndo_get_iflink =3D ip_tunnel_get_iflink,
> >  	.ndo_tunnel_ctl	=3D ipip_tunnel_ctl,
> > +	.ndo_fill_forward_path =3D ipip_fill_forward_path,
> >  };
> > =20
> >  #define IPIP_FEATURES (NETIF_F_SG |		\
> > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_t=
able_ip.c
> > index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..6b55e00b1022f0a2b02d9bf=
d1bd34bb55c1b83f7 100644
> > --- a/net/netfilter/nf_flow_table_ip.c
> > +++ b/net/netfilter/nf_flow_table_ip.c
> > @@ -277,13 +277,37 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_b=
uff *skb,
> >  	return NF_STOLEN;
> >  }
> > =20
> > +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
> > +{
> > +	struct iphdr *iph;
> > +
> > +	if (!pskb_may_pull(skb, sizeof(*iph)))
> > +		return false;
> > +
> > +	iph =3D (struct iphdr *)skb_network_header(skb);
> > +	*size =3D iph->ihl << 2;
> > +
> > +	if (ip_is_fragment(iph) || unlikely(ip_has_options(*size)))
> > +		return false;
> > +
> > +	if (iph->ttl <=3D 1)
> > +		return false;
> > +
> > +	return iph->protocol =3D=3D IPPROTO_IPIP;
>=20

what kind of sanity checks are we supposed to perform? Something similar to
what we have in ip_rcv_core()?

> Once the flow is in the flowtable, it is possible to inject traffic
> with forged outer IP header, this is only looking at the inner IP
> header.

what is the difference with the plain IP/TCP use-case?

Regards,
Lorenzo

>=20

--0jKr/ed/cH4ZgbY6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGfQeAAKCRA6cBh0uS2t
rIKvAP9Fu06jDyIxlsBsoWVIdt9G7Rvr6Z2Dml7eL3PzdlyxFQD+JfVmkkqp6oHy
NNQLk722kxNMwtrugDl9o3+cPyd0uQY=
=pgpa
-----END PGP SIGNATURE-----

--0jKr/ed/cH4ZgbY6--


