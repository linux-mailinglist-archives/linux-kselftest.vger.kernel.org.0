Return-Path: <linux-kselftest+bounces-13739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E283D93195A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BC41C2198F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5EB4317C;
	Mon, 15 Jul 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avYrIYQM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8EC200A0;
	Mon, 15 Jul 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064719; cv=none; b=HVG506FinwqSAUsk5Te1j6r2gAnhHUyho/KA0eNl1x7fQs9I/d4u6Ja5K6g6G2Tq8nqocfSWEAWqBiK+AP9zdm504ISDnsVrTL0c1I32j4cR7+Lr77mR22bX/pQPiTsgmOPWbvQVz91d+8+1dzp2hawRrMu5eh1XxUFtDiRlKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064719; c=relaxed/simple;
	bh=XG51VbTGnXobugGg42fOiPH80u+dQNhw+bmbq0lXs8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK3HPy7PnedCRhe3Qx+jxqD6SIXLTukb6oJUxqkDeIfczcGX8LOq7NH/7xGJanwgAMcq9p92ETlEJ8uJc6mtHCscxVRDORY5dqHsNpxZZTKxKYZ9woB3bTiqVZyPhZgSt/+2SlndTf3GVIkKfbuUs4K9w49og534aWzSHCKlCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avYrIYQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CACC32782;
	Mon, 15 Jul 2024 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064719;
	bh=XG51VbTGnXobugGg42fOiPH80u+dQNhw+bmbq0lXs8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avYrIYQM38xoD2zvibsQyafPiceelCz20ZZpCeA3H7XmRoKOrFaO7+lpx8kCaynRh
	 RSdKle0+CM+UvRtu5wv7NMGlzlcMfFi7ff0JFIaHPesEq1E6qdMq1+9Jq4HOoPyeoZ
	 JooTy0j/iVIHtX30ZCcZLsRijSmpnSjY6s2o+qsfx0h/vPHWrWoohqLpl+BHldKqgy
	 hX/VF6B1aA+39aq4nsSwhAqfNV452THwMCod5OS8RvCBbuhf3Zv2E7rjdniHt/oBs2
	 yyuXh5FPyewRCgO/EgeWoWHuFdAWaKqFGHL9UzPiK1uQHZ0/DzVenCBgBG5VBHO0fp
	 XbkuV9GaY4cXg==
Date: Mon, 15 Jul 2024 18:31:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Use card name rather than number in test
 names
Message-ID: <0e566b45-784c-48df-bddf-8293a17e814a@sirena.org.uk>
References: <7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
 <b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
 <877cdrt3zc.wl-tiwai@suse.de>
 <e4962ea0-3f03-43b5-b773-68abe1d73cc9@perex.cz>
 <bb42afb8-48a7-4daf-b28b-b82bd5c77d57@sirena.org.uk>
 <c1be6bec-90f5-4bb3-b6b0-8524095fc490@perex.cz>
 <31e73e81-e60f-4d0b-b0ac-118f1dc72610@sirena.org.uk>
 <87plrhssa4.wl-tiwai@suse.de>
 <652d6fef-9e63-4c3c-b61b-8a47d6eadaf1@sirena.org.uk>
 <87le2223hv.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3qxdjPKLh7T4RPzM"
Content-Disposition: inline
In-Reply-To: <87le2223hv.wl-tiwai@suse.de>
X-Cookie: You'll be sorry...


--3qxdjPKLh7T4RPzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2024 at 03:23:24PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Interesting - I was mainly developing on a system with multiple HDA
> > cards and was getting fairly clearly unique names.

> An AMD system usually has two HD-audio entries, and both are "HD-audio
> Generic".

Right, that won't do.  My legacy system here is getting the addresses in
there so deduplicates successfully.

--3qxdjPKLh7T4RPzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaVXQkACgkQJNaLcl1U
h9CxNgf/Y+BxDjPCZdghC10RUW2q+AFR/vUdAvfJQsu2BP3UDFrdUVv8N1HIuwlA
EeUpYI0ErLMmL9JxgTkMVdQ8h0STA1Qmd6oCGfOzznDe/cuuO8Nvjk1m0uFdW74D
VDluaVFTUtJlP/U9UGE+M/Rpl90gQ5RzsE7hhrj1s8hOezOExPwQcTsoSHaE+l2/
i0wxO6EC2FjlgqP4HhKJVjk+gSiHw58XGcwOikyfaGdKd6s3BLP8Svrleb0/z1U0
g2VOhIAE8mHJQqPUKb2B6vmuT8FlIZChJMpnkj6byrflnp0t7yfAPjr0eMVQMyuG
LvBzTAPYJCL31a9nl22n6G86HarLww==
=I1/c
-----END PGP SIGNATURE-----

--3qxdjPKLh7T4RPzM--

