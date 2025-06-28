Return-Path: <linux-kselftest+bounces-36035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A91AEC66F
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBFD189CFCA
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589D02153C6;
	Sat, 28 Jun 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaA5XHEE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C48BEC
	for <linux-kselftest@vger.kernel.org>; Sat, 28 Jun 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751104062; cv=none; b=NHS6q5kyJqliA+v36OLHKp05RzU+BjIeMYF90CuUBulqVzKlt3gUFqBvQMT2Pca4X8bu9dYCKc0YQUOFpPhVJXjETndUvTF+Hpysj7cvSwWJew05HQ9SO1DMa1br+rEo3SorCoRPBNEjhJlBtW3L8r+fsmOfAz0IfXk14JOhfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751104062; c=relaxed/simple;
	bh=FvNANRgAUQCZOaligUivTNMC/C09uHbzbtj8UE09jRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8y2FinvuquU/aB8TqvYVSc1OG09GqUevsJFkvyVcYx9dOyAuSLmjpaVHvaM1RqwYwWneHdzFSC7QJZSbpVBcxuEbW23StMzsLeskLa+VcCyE/cBb3w3/t04Stl2SNMRj8+vFdDPZoMQB2lMQ+tDp/BXdxZHweDQE3umQAVaD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaA5XHEE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751104057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Newn7o3dJEXSCt9x7hxL+sCIMSg/cs7zXE+Q+oYj0hQ=;
	b=GaA5XHEEhYDLuVu/HNjBwR9K+0VobA7PC/5I/nah1NTAnbW636mERxrY5lUP4o3t+f5CGz
	6pdfxFxMidolnKYRtuOEFD8w8nQrsv7DIQ/Ju7ORaNhbbyqKfjiaQeKbvQJcv58g59PQjv
	SCuReSI9gNha5W4JwXwBEmd+BlQA+SI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-ZJX4qqzXOxmIfU45-FMs-A-1; Sat, 28 Jun 2025 05:47:35 -0400
X-MC-Unique: ZJX4qqzXOxmIfU45-FMs-A-1
X-Mimecast-MFC-AGG-ID: ZJX4qqzXOxmIfU45-FMs-A_1751104054
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so1822148f8f.3
        for <linux-kselftest@vger.kernel.org>; Sat, 28 Jun 2025 02:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751104054; x=1751708854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Newn7o3dJEXSCt9x7hxL+sCIMSg/cs7zXE+Q+oYj0hQ=;
        b=ED6LiIM/VSVnbmJ4j3oSu8DCqi5E/IqmhL5vjqTAjoIkd2lt+5UHNSPyUbI6eqNEW6
         LAKB+5bk6d/gfuFOsOjXjBZcDnOeXQ7s8D98XqaSNRLHsxH5tW8EgXeg3k3mxoykVLFH
         26V4J1UiUczdn9zZXYmI+Y2lDPKaeTeneS27kzqTa33tom4YVxSAZUu+CE275AUvkAjP
         CUVzZ3ycudiyf6PF6kiq5gHn30pXnr4eZc68zF5OXXL7vT1crcDCyftjfVy1V6y6r5EZ
         8tUOYaaxFvxGoAK2KeM/rsc3MTBVNK4gg0OqLJhYGIUjweU1JI+urmBb0TRuNIpdFF8O
         eTUA==
X-Forwarded-Encrypted: i=1; AJvYcCVQfDFo8XROiA1rWAAMIzK7zo+OwBWKe3UyQxzDygVSMmQpI0v100HFv1cnuGRQ7SnX5ipbO4vc4bHVsqbznz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8KL6bD47IiZ6pVV7DCit0YtJ5pMjYvvGbY5/qtTAGW4WD2tD
	/C4jCGwfvRnucYHNaycbB2/cjbnD049f5BF4KPmq3B2frkduLy9YcXhXUB50EcRtiy42ZoSyxWx
	HcFs8ue24dqv20VY4UU7U5JDTSaNox0ij2fSNbh/1Uu3xjJ+9hon4IVwvnWxt/61elx3Jpw==
X-Gm-Gg: ASbGncsiYSBafDm7A1zaxCLxVCUwrwC5srIqjoxUFuZcSto0pg6uD3JoU8XmjI3fZPr
	q070Mj8nLTjW0w5rQRKF4V0YhgL2DbWW2PnM4I/VnVPsuRiDP6yAIervEQ4ITN8UO4LTsheKSWY
	CfFwYK6XwNLaBm8itKYsk2tyTuv3iBpsrIgDcd/a8vzd9Y3XIZLgBENdSqo0FH77SSoz2lnq1uD
	0eTTdnySEfZ8fba8SpkGstfUH50OmAPDAOguvGnx++Yv7IFPwUp9akCkBYynw2NlDUMniJ92WGv
	eJWoGLEkaOeiobQS6Ca3uduBRIJqzgovkzGYQUWTtJKIF11j51vLY71pQ1PeBqGpSc92sw==
X-Received: by 2002:a05:6000:ce:b0:3a3:7115:5e7a with SMTP id ffacd0b85a97d-3a917bc7ab8mr4198330f8f.42.1751104053751;
        Sat, 28 Jun 2025 02:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPCiFHgAK5wt7p4Rs7GA4RpWRlbpxaRtGvpYL7+8IH+T0T+ExhA+LWl94toLj7uMxCJICU3A==
X-Received: by 2002:a05:6000:ce:b0:3a3:7115:5e7a with SMTP id ffacd0b85a97d-3a917bc7ab8mr4198301f8f.42.1751104053264;
        Sat, 28 Jun 2025 02:47:33 -0700 (PDT)
Received: from localhost (net-130-25-105-15.cust.vodafonedsl.it. [130.25.105.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e61f48sm4943473f8f.93.2025.06.28.02.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 02:47:32 -0700 (PDT)
Date: Sat, 28 Jun 2025 11:47:31 +0200
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
Subject: Re: [PATCH net-next v2 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Message-ID: <aF-6M-4SjQgRQw1j@lore-desk>
References: <20250627-nf-flowtable-ipip-v2-0-c713003ce75b@kernel.org>
 <20250627-nf-flowtable-ipip-v2-1-c713003ce75b@kernel.org>
 <aF6ygRse7xSy949F@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvp15xVDHhMV55GV"
Content-Disposition: inline
In-Reply-To: <aF6ygRse7xSy949F@calendula>


--hvp15xVDHhMV55GV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jun 27, 2025 at 02:45:28PM +0200, Lorenzo Bianconi wrote:
> > Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> > infrastructure.
> > IPIP SW acceleration can be tested running the following scenario where
> > the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
> > tunnel is used to access a remote site (using eth1 as the underlay devi=
ce):
> >=20
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
>=20
> Is there a proof that this accelerates forwarding?

I reproduced the scenario described above using veths (something similar to
what is done in nft_flowtable.sh) and I got the following results:

- flowtable configured as above between the two router interfaces
- TCP stream between client and server going via the IPIP tunnel
- TCP stream transmitted into the IPIP tunnel:
  - net-next:				~41Gbps
  - net-next + IPIP flowtbale support:	~40Gbps
- TCP stream received from the IPIP tunnel:
  - net-next:				~35Gbps
  - net-next + IPIP flowtbale support:	~49Gbps

>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
> >  net/netfilter/nf_flow_table_ip.c | 28 ++++++++++++++++++++++++++--
> >  2 files changed, 47 insertions(+), 2 deletions(-)
> >=20

[...]

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
> This is blindly skipping the outer IP header.

Do you mean we are supposed to validate the outer IP header performing the
sanity checks done in nf_flow_tuple_ip()?

Regards,
Lorenzo

>=20
> > +		return true;
> >  	case htons(ETH_P_8021Q):
> >  		if (!pskb_may_pull(skb, skb_mac_offset(skb) + sizeof(*veth)))
> >  			return false;
> > @@ -310,6 +328,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
> >  			      struct flow_offload_tuple_rhash *tuplehash)
> >  {
> >  	struct vlan_hdr *vlan_hdr;
> > +	u16 size;
> >  	int i;
> > =20
> >  	for (i =3D 0; i < tuplehash->tuple.encap_num; i++) {
> > @@ -331,6 +350,12 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
> >  			break;
> >  		}
> >  	}
> > +
> > +	if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> > +	    nf_flow_ip4_encap_proto(skb, &size)) {
> > +		skb_pull(skb, size);
> > +		skb_reset_network_header(skb);
> > +	}
>=20
> I have a similar patch from 2023, I think I keep somewhere in my trees.
>=20
> >  }
> > =20
> >  static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff=
 *skb,
> > @@ -357,8 +382,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
> >  {
> >  	struct flow_offload_tuple tuple =3D {};
> > =20
> > -	if (skb->protocol !=3D htons(ETH_P_IP) &&
> > -	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
> > +	if (!nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
> >  		return NULL;
> > =20
> >  	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)
> >=20
> > --=20
> > 2.50.0
> >=20
>=20

--hvp15xVDHhMV55GV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaF+6MwAKCRA6cBh0uS2t
rMAKAQDdLVBCjzjGwTELy9gE6FJi7/rBBB3yteHjlxdsqx575AEA7P4CVJ+rtMwc
A14JuSb+7zq7U1Bzl0zOAbgz7oglngU=
=Tb0o
-----END PGP SIGNATURE-----

--hvp15xVDHhMV55GV--


