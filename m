Return-Path: <linux-kselftest+bounces-44705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB7C30AA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B1118962A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896712E173E;
	Tue,  4 Nov 2025 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITX4mipP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A085191F92;
	Tue,  4 Nov 2025 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254491; cv=none; b=ZFoM6cEw2HEuAs8D0m9o5lNSqrkSpK0Cgvn1eM3JIOai52WTaxIenwi2rEAUXwvaNRkioeoXjn51+auP+kmu2I271Bg2nRyONr8l26/wA6SiJosc+iJ8gMEytgJuvIvmAzC/AkDAHZwALZYg16nUYGMYOQREm7w6Dam6YTST0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254491; c=relaxed/simple;
	bh=LmdhoSAI9lnKK3Lr3krP6aCJTZmvPTtd9486Cgqqibo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCgwvhaP3FV/8zs3eHTbLTiWOWuNde/mBgyyLDUCM56XcNWm+79u4h9TfT+ouHllhgrMcEluRCiZzu+HZNmaCh9fjCUCATN+FkQE8NwcF9f9a6+E1ku+nd3d9mIo9H4nCqmygY9iOE/XIsWbQGfK0pZOKuTUm0Fk/tUViEBqBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITX4mipP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445D3C4CEF7;
	Tue,  4 Nov 2025 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762254488;
	bh=LmdhoSAI9lnKK3Lr3krP6aCJTZmvPTtd9486Cgqqibo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITX4mipPZ76lcXAIaPNSaOq9l2dzLMiMzCY8jKUcy9ESdyLzreK17nB4zrZWFRJMA
	 YZZL5zXT42ySFcYEnfq2/A3RTh+yCJrB2LI+LgIltjv84P10U7qfvgwF2iuptZIqyQ
	 Co8N1BMYuGHpTpvzVQc8tdEJ8BV3T1+GKCtRAI2ABxOOrhI2Eo/2WAQmI1X/Q/M2a+
	 5C0y6sYZ/AuE9zLTArKxMLaUHZdK8lqO1yXWcZrib2xRqtC8WifJvubLxKqWEsZsnF
	 d1wasDV1Od59Pmz2P+TpcJhVZDOMRBR6q4/At1uipBWJf822q/+dW8OfIlNPDhtN5P
	 nCz3XJEagyDTQ==
Date: Tue, 4 Nov 2025 12:08:06 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Phil Sutter <phil@nwl.cc>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v8 0/3] Add IPIP flowtable SW acceleration
Message-ID: <aQnelp8RNlMfw4nr@lore-desk>
References: <20251023-nf-flowtable-ipip-v8-0-5d5d8595c730@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/hmIC4VKqnIfckr9"
Content-Disposition: inline
In-Reply-To: <20251023-nf-flowtable-ipip-v8-0-5d5d8595c730@kernel.org>


--/hmIC4VKqnIfckr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> infrastructure. This series introduces basic infrastructure to
> accelerate other tunnel types (e.g. IP6IP6).

Hi Pablo and Florian,

Do you have any updates/comments about this series? Thanks in advance.

Regards,
Lorenzo

>=20
> ---
> Changes in v8:
> - Rebase on top of the following series (not yet applied)
>   https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=3D477=
081
> - Link to v7: https://lore.kernel.org/r/20251021-nf-flowtable-ipip-v7-0-a=
45214896106@kernel.org
>=20
> Changes in v7:
> - Introduce sw acceleration for tx path of IPIP tunnels
> - Rely on exact match during flowtable entry lookup
> - Fix typos
> - Link to v6: https://lore.kernel.org/r/20250818-nf-flowtable-ipip-v6-0-e=
da90442739c@kernel.org
>=20
> Changes in v6:
> - Rebase on top of nf-next main branch
> - Link to v5: https://lore.kernel.org/r/20250721-nf-flowtable-ipip-v5-0-0=
865af9e58c6@kernel.org
>=20
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
> Lorenzo Bianconi (3):
>       net: netfilter: Add IPIP flowtable rx sw acceleration
>       net: netfilter: Add IPIP flowtable tx sw acceleration
>       selftests: netfilter: nft_flowtable.sh: Add IPIP flowtable selftest
>=20
>  include/linux/netdevice.h                          |  16 +++
>  include/net/netfilter/nf_flow_table.h              |  22 ++++
>  net/ipv4/ipip.c                                    |  29 +++++
>  net/netfilter/nf_flow_table_core.c                 |   3 +
>  net/netfilter/nf_flow_table_ip.c                   | 117 +++++++++++++++=
+++++-
>  net/netfilter/nf_flow_table_path.c                 |  86 +++++++++++++--
>  .../selftests/net/netfilter/nft_flowtable.sh       |  40 +++++++
>  7 files changed, 298 insertions(+), 15 deletions(-)
> ---
> base-commit: 32e4b1bf1bbfe63e52e2fff7ade0aaeb805defe3
> change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--/hmIC4VKqnIfckr9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQnelgAKCRA6cBh0uS2t
rIKNAQCBqiEOogDSti97oqbOzgwdepURLlyGeQ1wlZfifilu1AEAy6H4XEWEKEi5
IO1DZWBhH6l1a6afqaXiTr7LF7k8nQs=
=Mk5f
-----END PGP SIGNATURE-----

--/hmIC4VKqnIfckr9--

