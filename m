Return-Path: <linux-kselftest+bounces-38051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F09B1502D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE64178490
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4229346F;
	Tue, 29 Jul 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhg8m2cc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0028A405;
	Tue, 29 Jul 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802968; cv=none; b=ZnV1VG7niVM32ZIvwTM+owDvixRWX4cpGr7zOeaq+mxVSb+NiQZKZCQxFjZeTPDa2EzjpGLR/QMKbxMFO+6of/L6tgo1ckqeA5H2uRX4LbLPBajpxS0gpu8eeCDxryhcwsZEQ93mL4a+Fz1Iut7e+/Z8vB0D/nt/dZB3c0NdzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802968; c=relaxed/simple;
	bh=xxJsnFkL43N4gvsKYxn3Jpm39ZvmFN4y4FXxHD0s1j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YULTZKcZ9iKzvpxMGZiMpu+NWDyOLRH9tIx3plxYJgi+rh+3/FA7AC7/gEnf35rWlACqGHtfwJkBIf+ZtRbPYaXi1+hUOi9QntuqMAPK8F+iJ4vbWdQ1mLs7ZxPitoRoGabLyvgYsm7so/NQeHbgatkf+eqeRRCPA2RqTtI/qU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhg8m2cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A60C4CEF4;
	Tue, 29 Jul 2025 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753802968;
	bh=xxJsnFkL43N4gvsKYxn3Jpm39ZvmFN4y4FXxHD0s1j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhg8m2ccRle5izyw+Pebyy8XLFm8J8y7MzXTOmHMTpbNpLrmZKHDbt3jGLyyL6hUy
	 qmNsOHPt/u4qhiIujQ3LGECqQ7eH/0kOEHYTWvDlwRDWAFQK1833LjaYpukr3a+eWk
	 pDS+AaiIOxaLayOLAuXu68C0kiutRA0cFJElYONEORcIMNijLuzuAMfsEsdC1uEhvq
	 sHvPvuMBkgUr9okjoBsWQtvRGNt6VT+IhMenhwvpqGZ6FM0RqcxUBL1nu0dbXtmcIz
	 ZMsXKprBidYA6V3LFDkt1AK9tNp+xYq97GeSWMgapP7GUlOIrP+4zlWdX8PLiufJyM
	 Oz8vNUX3Nj+bQ==
Date: Tue, 29 Jul 2025 17:29:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v5 0/2] Add IPIP flowtable SW acceleratio
Message-ID: <aIjo1azEuq2k3s2w@lore-desk>
References: <20250721-nf-flowtable-ipip-v5-0-0865af9e58c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wliClyFhrAlVdtZr"
Content-Disposition: inline
In-Reply-To: <20250721-nf-flowtable-ipip-v5-0-0865af9e58c6@kernel.org>


--wliClyFhrAlVdtZr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> infrastructure.

Hi Pablo,

do you have any update on v5?

Regards,
Lorenzo

>=20
> ---
> Changes in v5:
> - Rely on __ipv4_addr_hash() to compute the hash used as encap ID
> - Remove unnecessary pskb_may_pull() in nf_flow_tuple_encap()
> - Add nf_flow_ip4_ecanp_pop utility routine
> - Link to v4: https://lore.kernel.org/r/20250718-nf-flowtable-ipip-v4-0-f=
8bb1c18b986@kernel.org
>=20
> Changes in v4:
> - Use the hash value of the saddr, daddr and protocol of outer IP header =
as
>   encapsulation id.
> - Link to v3: https://lore.kernel.org/r/20250703-nf-flowtable-ipip-v3-0-8=
80afd319b9f@kernel.org
>=20
> Changes in v3:
> - Add outer IP header sanity checks
> - target nf-next tree instead of net-next
> - Link to v2: https://lore.kernel.org/r/20250627-nf-flowtable-ipip-v2-0-c=
713003ce75b@kernel.org
>=20
> Changes in v2:
> - Introduce IPIP flowtable selftest
> - Link to v1: https://lore.kernel.org/r/20250623-nf-flowtable-ipip-v1-1-2=
853596e3941@kernel.org
>=20
> ---
> Lorenzo Bianconi (2):
>       net: netfilter: Add IPIP flowtable SW acceleration
>       selftests: netfilter: nft_flowtable.sh: Add IPIP flowtable selftest
>=20
>  include/linux/netdevice.h                          |  1 +
>  net/ipv4/ipip.c                                    | 28 +++++++++++
>  net/netfilter/nf_flow_table_ip.c                   | 56 ++++++++++++++++=
+++++-
>  net/netfilter/nft_flow_offload.c                   |  1 +
>  .../selftests/net/netfilter/nft_flowtable.sh       | 40 ++++++++++++++++
>  5 files changed, 124 insertions(+), 2 deletions(-)
> ---
> base-commit: dd500e4aecf25e48e874ca7628697969df679493
> change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--wliClyFhrAlVdtZr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaIjo1QAKCRA6cBh0uS2t
rEZKAP9waCIeFskcd91V3BlMVy1kJ7IFq2HU3fTU2vt5OAiijAEAxd/13g03R/+K
s1Igt7AHCEne3kn+9rX1BBu4DHPfDw0=
=4M+O
-----END PGP SIGNATURE-----

--wliClyFhrAlVdtZr--

