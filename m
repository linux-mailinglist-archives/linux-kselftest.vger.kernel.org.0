Return-Path: <linux-kselftest+bounces-36425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF92AF742C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88BC1663E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90622E7BB8;
	Thu,  3 Jul 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPw1Tqy6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA97239086;
	Thu,  3 Jul 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545808; cv=none; b=c13gg5vQqu9Pp3M4xbIaq4HAsm5LzpbD6HX1jmjqcWT6nhIXVu0Sm0gIB7RhofvxVwM8fTXonq2Evk7D1wAWAFIDZ+9sALyLkG9WE0dOSvOSkpbS0sn2xedHxGJMCNqy2IIhsSMSZ571L/MgoMRD8R4xZ7PzzCgjtb0E+1NUbqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545808; c=relaxed/simple;
	bh=sncJuZPOjb+xUXw7bfjPXRm0fnaDZzKts8QIyan7TEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5YcBboE5i3um3hhHUg3h+Z3+l3ph4gH5UyLAayS8/I6ruzXudQNjkJ7NASoxQY1ZWPVyak6myT1C32UgK+FKe69Mwaqn6P2z57bfhcGYECUNqXnA9o5aKu8WltdNzFU6eQ56gyLeDGYG5hEmsMRTBCeAu1M7fcyyVu4PbH6G68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPw1Tqy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9257C4CEF0;
	Thu,  3 Jul 2025 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751545808;
	bh=sncJuZPOjb+xUXw7bfjPXRm0fnaDZzKts8QIyan7TEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPw1Tqy6pYpht+FSkHMWBDFfLWIYycidBhU2FbQXnwetC/SUYX+ig8oDaK3oEukdW
	 WBlReZUuM8N+HCumo+KG0sYUnJq7zkrdY7PVF0vKApASRjMrH2mXxS2SgNhuTALRUd
	 031uR9mYeAPrwODlxGI2QLHGiMghxfzCSyUykVYfUtXZytWFtUZDcJdwqZyav7u2Sa
	 HKhCrVxco7Q+S8dr/3CGw6RaVdKDQjkev42zfa+zmnwRDLyUzJqJW0K86BwuR8iwUS
	 oVse+FLaJpLcS5SSMmBQsseRLBOxLFW+l11LG3XAUTocNBIfbKsY8K/MwiTZ9w1IBV
	 +6yHtZ+Hj9sng==
Date: Thu, 3 Jul 2025 14:30:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Message-ID: <aGZ3zkDAvT3JV3QR@lore-desk>
References: <20250627-nf-flowtable-ipip-v2-0-c713003ce75b@kernel.org>
 <20250627-nf-flowtable-ipip-v2-1-c713003ce75b@kernel.org>
 <aF6ygRse7xSy949F@calendula>
 <aF-6M-4SjQgRQw1j@lore-desk>
 <807503bf-4213-4423-b38b-ffdc11aaaeee@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RDeHOGiG1l5V487k"
Content-Disposition: inline
In-Reply-To: <807503bf-4213-4423-b38b-ffdc11aaaeee@redhat.com>


--RDeHOGiG1l5V487k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 6/28/25 11:47 AM, Lorenzo Bianconi wrote:
> >> On Fri, Jun 27, 2025 at 02:45:28PM +0200, Lorenzo Bianconi wrote:
> >>> Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> >>> infrastructure.
> >>> IPIP SW acceleration can be tested running the following scenario whe=
re
> >>> the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
> >>> tunnel is used to access a remote site (using eth1 as the underlay de=
vice):
> >>>
> >>> ETH0 -- TUN0 <=3D=3D> ETH1 -- [IP network] -- TUN1 (192.168.100.2)
> >>>
> >>> $ip addr show
> >>> 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue sta=
te UP group default qlen 1000
> >>>     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> >>>     inet 192.168.0.2/24 scope global eth0
> >>>        valid_lft forever preferred_lft forever
> >>> 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue sta=
te UP group default qlen 1000
> >>>     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> >>>     inet 192.168.1.1/24 scope global eth1
> >>>        valid_lft forever preferred_lft forever
> >>> 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue =
state UNKNOWN group default qlen 1000
> >>>     link/ipip 192.168.1.1 peer 192.168.1.2
> >>>     inet 192.168.100.1/24 scope global tun0
> >>>        valid_lft forever preferred_lft forever
> >>>
> >>> $ip route show
> >>> default via 192.168.100.2 dev tun0
> >>> 192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
> >>> 192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
> >>> 192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100.1
> >>>
> >>> $nft list ruleset
> >>> table inet filter {
> >>>         flowtable ft {
> >>>                 hook ingress priority filter
> >>>                 devices =3D { eth0, eth1 }
> >>>         }
> >>>
> >>>         chain forward {
> >>>                 type filter hook forward priority filter; policy acce=
pt;
> >>>                 meta l4proto { tcp, udp } flow add @ft
> >>>         }
> >>> }
> >>
> >> Is there a proof that this accelerates forwarding?
> >=20
> > I reproduced the scenario described above using veths (something simila=
r to
> > what is done in nft_flowtable.sh) and I got the following results:
> >=20
> > - flowtable configured as above between the two router interfaces
> > - TCP stream between client and server going via the IPIP tunnel
> > - TCP stream transmitted into the IPIP tunnel:
> >   - net-next:				~41Gbps
> >   - net-next + IPIP flowtbale support:	~40Gbps
> > - TCP stream received from the IPIP tunnel:
> >   - net-next:				~35Gbps
> >   - net-next + IPIP flowtbale support:	~49Gbps
> >=20
> >>
> >>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>> ---
> >>>  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
> >>>  net/netfilter/nf_flow_table_ip.c | 28 ++++++++++++++++++++++++++--
> >>>  2 files changed, 47 insertions(+), 2 deletions(-)
> >>>
> >=20
> > [...]
> >=20
> >>>  static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 p=
roto,
> >>>  				       u32 *offset)
> >>>  {
> >>>  	struct vlan_ethhdr *veth;
> >>>  	__be16 inner_proto;
> >>> +	u16 size;
> >>> =20
> >>>  	switch (skb->protocol) {
> >>> +	case htons(ETH_P_IP):
> >>> +		if (nf_flow_ip4_encap_proto(skb, &size))
> >>> +			*offset +=3D size;
> >>
> >> This is blindly skipping the outer IP header.
> >=20
> > Do you mean we are supposed to validate the outer IP header performing =
the
> > sanity checks done in nf_flow_tuple_ip()?
>=20
> Yes.

ack

>=20
> Note that we could always obtain a possibly considerably tput
> improvement stripping required validation ;)

I have been proactive and I added the sanity checks done in nf_flow_tuple_i=
p()
and I got ~ the same results.

>=20
> I guess this should go via the netfilter tree, please adjust the patch
> prefix accordingly.

ack

>=20
> Also why IP over IP specifically? I guess other kind of encapsulations
> may benefit from similar path and are more ubiquitous.

this is just the first step, I want to add IPv6 counterpart too.

Regards,
Lorenzo

>=20
>=20
> /P
>=20

--RDeHOGiG1l5V487k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGZ3zQAKCRA6cBh0uS2t
rMV8AQD4VNErJEc0BSKlUXUwaXX4vTun3p2otUcxRbwhmexCmQEA7JILzmhD/dC/
DQ02baajIoSe6cQLMYZ2zEOQWffIEw0=
=gsb1
-----END PGP SIGNATURE-----

--RDeHOGiG1l5V487k--

