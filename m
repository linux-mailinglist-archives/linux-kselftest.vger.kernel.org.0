Return-Path: <linux-kselftest+bounces-43759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3052DBFC7F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 16:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A30623CC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6CC34A790;
	Wed, 22 Oct 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZasiNxpA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBF53451C8;
	Wed, 22 Oct 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142477; cv=none; b=KywK8w0N1qsbfeWOUqJjk+xkU0chLNzyYG8lII2FD31CwBEQO+YGUz60O4QveOq6ikgI/rK7ZDKa8MshNoeDUjDFfBeJ9XN+Mz/TPac64vJig28KcF4HYWHlKVWvssxsFhGGUM4QOnk8mnnpFAEyz09Xa1arpZCIAbNuX99QRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142477; c=relaxed/simple;
	bh=rlBN7u0Rjc2CZ97e+3oJTh3YOUqtZbkx5FlApV3Xm+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChuTxwH8STgFM3N+h3MMJ0gv2mrBUXJ5Vony56b/1b3f6/mLLvVRRTtDBQUSV5oN8F0rntLH+ubovWz1KiO1GzBz/KPY/TnxrxGbERI7H8nKf/42Lsxs21htQYME+aWnY8G24YcTOieNsL5I48wR405iSpP1jCRYf/OH+rvrDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZasiNxpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D9EC4CEE7;
	Wed, 22 Oct 2025 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761142476;
	bh=rlBN7u0Rjc2CZ97e+3oJTh3YOUqtZbkx5FlApV3Xm+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZasiNxpAVRgliLzm7hFEJsLMzX0qFJIx1ktc8R9a0e/ozT5li8Uw2VmYaqVFC5cAz
	 leWwN8XCblt96jrkeSFpdkMVBn+/DpWP3y2wQOXcUgV8xw3n+2QA6ssnQ54eDHspfs
	 MCz2XLJDtmstcJMYSrt2tw2VEDdlmAaVmbNwMOfleDADA5ilImGcZHVZ1c5pijwh8p
	 UVVWvJRqv/+pDjOBEgwYV2d9Tyw7ZxF9hxztek5VgVUXgXNp61XyADdxhBsW635Zau
	 bt3tFf23fJWkJc+ZX8+OiAUxSmOSkFNqZ/12XquwMuoxapDT7tuplSOlVIYykn1lXc
	 HMkwnEV4lArww==
Date: Wed, 22 Oct 2025 16:14:34 +0200
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
Subject: Re: [PATCH nf-next v7 0/3] Add IPIP flowtable SW acceleration
Message-ID: <aPjmyptnBpfS4RSy@lore-desk>
References: <20251021-nf-flowtable-ipip-v7-0-a45214896106@kernel.org>
 <aPi7haYp3pWqM0oW@calendula>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TK1zm52MDJiEAg5j"
Content-Disposition: inline
In-Reply-To: <aPi7haYp3pWqM0oW@calendula>


--TK1zm52MDJiEAg5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,

Hi Pablo,

>=20
> On Tue, Oct 21, 2025 at 07:48:17PM +0200, Lorenzo Bianconi wrote:
> > Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> > infrastructure. This series introduces basic infrastructure to
> > accelerate other tunnel types (e.g. IP6IP6).
>=20
> Would you be so kind to rebase this series on top of:
>=20
> https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=3D477081
>=20
> That series should simplify the integration of your IPIP support.

ack, sure. I will do in v8.

Regards,
Lorenzo

>=20
> Thanks.
>=20
> > ---
> > Changes in v7:
> > - Introduce sw acceleration for tx path of IPIP tunnels
> > - Rely on exact match during flowtable entry lookup
> > - Fix typos
> > - Link to v6: https://lore.kernel.org/r/20250818-nf-flowtable-ipip-v6-0=
-eda90442739c@kernel.org
> >=20
> > Changes in v6:
> > - Rebase on top of nf-next main branch
> > - Link to v5: https://lore.kernel.org/r/20250721-nf-flowtable-ipip-v5-0=
-0865af9e58c6@kernel.org
> >=20
> > Changes in v5:
> > - Rely on __ipv4_addr_hash() to compute the hash used as encap ID
> > - Remove unnecessary pskb_may_pull() in nf_flow_tuple_encap()
> > - Add nf_flow_ip4_ecanp_pop utility routine
> > - Link to v4: https://lore.kernel.org/r/20250718-nf-flowtable-ipip-v4-0=
-f8bb1c18b986@kernel.org
> >=20
> > Changes in v4:
> > - Use the hash value of the saddr, daddr and protocol of outer IP heade=
r as
> >   encapsulation id.
> > - Link to v3: https://lore.kernel.org/r/20250703-nf-flowtable-ipip-v3-0=
-880afd319b9f@kernel.org
> >=20
> > Changes in v3:
> > - Add outer IP header sanity checks
> > - target nf-next tree instead of net-next
> > - Link to v2: https://lore.kernel.org/r/20250627-nf-flowtable-ipip-v2-0=
-c713003ce75b@kernel.org
> >=20
> > Changes in v2:
> > - Introduce IPIP flowtable selftest
> > - Link to v1: https://lore.kernel.org/r/20250623-nf-flowtable-ipip-v1-1=
-2853596e3941@kernel.org
> >=20
> > ---
> > Lorenzo Bianconi (3):
> >       net: netfilter: Add IPIP flowtable rx sw acceleration
> >       net: netfilter: Add IPIP flowtable tx sw acceleration
> >       selftests: netfilter: nft_flowtable.sh: Add IPIP flowtable selfte=
st
> >=20
> >  include/linux/netdevice.h                          |  16 +++
> >  include/net/netfilter/nf_flow_table.h              |  26 +++++
> >  net/ipv4/ipip.c                                    |  29 +++++
> >  net/netfilter/nf_flow_table_core.c                 |  10 ++
> >  net/netfilter/nf_flow_table_ip.c                   | 118 +++++++++++++=
+++++++-
> >  net/netfilter/nft_flow_offload.c                   |  79 ++++++++++++--
> >  .../selftests/net/netfilter/nft_flowtable.sh       |  40 +++++++
> >  7 files changed, 307 insertions(+), 11 deletions(-)
> > ---
> > base-commit: d1d7998df9d7d3ee20bcfc876065fa897b11506d
> > change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067
> >=20
> > Best regards,
> > --=20
> > Lorenzo Bianconi <lorenzo@kernel.org>
> >=20

--TK1zm52MDJiEAg5j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPjmygAKCRA6cBh0uS2t
rNFcAQCdgI4MlWAg+3oclx9ED2h5hMqHYU7XgBaA1IpIt9rMtAD/b1VjAEyGyu+E
lj1wKSWfJVJHVKuAoAAlR3yoltsHBw8=
=4tUQ
-----END PGP SIGNATURE-----

--TK1zm52MDJiEAg5j--

