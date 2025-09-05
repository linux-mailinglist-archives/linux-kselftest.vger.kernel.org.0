Return-Path: <linux-kselftest+bounces-40866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D908CB46534
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 23:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B28AA4A1A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 21:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1C82ED149;
	Fri,  5 Sep 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG1Mk/hd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107527A452;
	Fri,  5 Sep 2025 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106557; cv=none; b=NvbXLZXVq1yCbBCXjcNCWz6XJfSCuk2Z2IL/0HzabWzm2/uhKZjxu5rFjdcWZXC1MSHSxXNd6VxIdjSzAMbNiRibm66DoiGVfboiVdRgT9YkKRFXs7cpNN/S182+17lPIcsPkCJiplQuyZZg7uYLKbXJ9LGcC0c9fRa3bsIzPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106557; c=relaxed/simple;
	bh=w6wYM3i88QyK525bdKFxsoedWmQ0byYhJAK4jQscByk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHY86vl/9L6zBIZK67qeEDHIJt/a7bt5JLLuAYtzOn/stbaiyK53gCxa05denRP2TA3XwtCHTr+FuF3Vs24dUY0lakmj2SeA7cLXq3gyFyZeGXHykMEUy3jcJmxUSDWg3g65J2FTvBzG2ukanhf+e0tXmzycNNUfGSgqG/v4YN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG1Mk/hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A94C4CEF5;
	Fri,  5 Sep 2025 21:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757106555;
	bh=w6wYM3i88QyK525bdKFxsoedWmQ0byYhJAK4jQscByk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aG1Mk/hdV/uWErY+vqsE92Uj8DamzA4hUrT/bQIJEXAhRRKUwXFwwOjDDWIaF8Jkr
	 lbczQ/CTEKQQvFG6fvrg5uQ8ZCNUzND2/rTzaSIIFH/mPu4YXAeKnQBZCaYxj3cPUy
	 u8IjoopN7sJIOMKjYWLPxb7E5YigMhmIsMpmVch5r4idK94+5+P3vKHra8vKzHJkFc
	 cXG+7EaOziPhyj7gzzEg/GcdJ0Legr1LZvUVVDmOEGgW2Te8kf+yZ/x4Ii80iCczzf
	 3MB4p1ncL6ZimpDHc2t9Rps/h5wZK9HvO4Q3u3W/O05AHPs+5NurqrCO7F+SKcJ2NJ
	 N5y4gacMMfb6A==
Date: Fri, 5 Sep 2025 23:09:12 +0200
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
	linux-kselftest@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH nf-next v6 0/2] Add IPIP flowtable SW acceleratio
Message-ID: <aLtReLinzTt2dvOr@lore-desk>
References: <20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MdHXNO2icgRfBlFj"
Content-Disposition: inline
In-Reply-To: <20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org>


--MdHXNO2icgRfBlFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> infrastructure.
>=20

Hi Pablo, Florian and Jozsef,

any update about this patch? What is the best way to proceed on this featur=
e?

Regards,
Lorenzo

> ---
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
> base-commit: bab3ce404553de56242d7b09ad7ea5b70441ea41
> change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--MdHXNO2icgRfBlFj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaLtReAAKCRA6cBh0uS2t
rP2QAQCOQ/EZlBTf8tqsgfOQ6tvN5FfI/2oiuSWghoBfgczZxwD/VO42dKJBqS3F
S0BqkGwozSiKLRP1Z7R88jX2KJFOfws=
=S9pd
-----END PGP SIGNATURE-----

--MdHXNO2icgRfBlFj--

