Return-Path: <linux-kselftest+bounces-40044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B43DB37FEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 12:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002A93B9142
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BA8281504;
	Wed, 27 Aug 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXVfo9ed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7021ADA4;
	Wed, 27 Aug 2025 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290755; cv=none; b=LxPlNqmYOrcCh5nPbmyns4tGhUHsEdcQeeJ+rxvjAWwm9dYWpV+oaUw0bALvGBKc858xHpNt3sxmCsW3cZXfIOFTIT6ta9BGXQuhKEE++Ns2WQ9mDgslkkTzFUZca1+KUNczP1sMydw8aRFu/LV/p68UfQkrhgyO9J4Dajm0HxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290755; c=relaxed/simple;
	bh=/smPvszByZaAF/Ideu82BSZu3Ndn1PjZSF6bQpSGf54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQEp5gK3JXBFXToYamN/hm4Ce8lCQfbPEokzlK59s5oPk0Fzm4nvHfqTvJ4V8lglVudqOu27xb1/0e/5ouSG4FphT5m202bVSCapSsToUBFa0DHL2B7r9Yphwj0xICuBJumfjDOl/U8Os1piXC+thZ+U2IgziMQFbpbOzXQNmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXVfo9ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EF5C4CEEB;
	Wed, 27 Aug 2025 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756290754;
	bh=/smPvszByZaAF/Ideu82BSZu3Ndn1PjZSF6bQpSGf54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXVfo9edvnfYDZY9oYOI1IjWhXElJtoKE/QXD0PNTUVuQ7jWQHsM6vpl8OWZxo97Y
	 5zK137hjg10dzubzqUD+AKjAgN1X3+M3o5ODhhLWrTy+b22LjYDTN+tvwGUuhaghBW
	 jBlFAeNQioSRejLwSAIgmX49dIlfTtx7vsp2uQzqffQHwK1KwIzJxeIezv1yqvfdH6
	 Y07U7w4H+LyMwfBI0hahRiuJmRwRMm52R6cZ4dLrZttolx64vbzoaou3/CRXC4dgvz
	 TIb6t8pPDFsfrBRQ9w7rbSRzeVGaTTaLytd3FaluUkdM73a4JKDNlmBLsNvHs1pg8y
	 rpESJfOoFihjw==
Date: Wed, 27 Aug 2025 11:32:29 +0100
From: Mark Brown <broonie@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: bagasdotme@gmail.com, Markus.Elfring@web.de, shuah@kernel.org,
	will@kernel.org, mark.rutland@arm.com, ebiggers@google.com,
	catalin.marinas@arm.com, martin.petersen@oracle.com,
	ardb@kernel.org, thiago.bauermann@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] selftests/arm64: Fix grammatical error in string
 literals
Message-ID: <d8bb28b7-7832-4c24-82bc-4663affcf57a@sirena.org.uk>
References: <20250826214913.866695-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OQXy7X9uIo8z3XU8"
Content-Disposition: inline
In-Reply-To: <20250826214913.866695-1-zlatistiv@gmail.com>
X-Cookie: Most people prefer certainty to truth.


--OQXy7X9uIo8z3XU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:49:13AM +0300, Nikola Z. Ivanov wrote:
> Fix grammatical error in <past tense verb> + <infinitive>
> construct related to memory allocation checks.
> In essence change "Failed to allocated" to "Failed to allocate".
>=20
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> ---
> Changes in v2:
> - More descriptive commit message

Repeating my previous tag:

Reviewed-by: Mark Brown <broonie@kernel.org>

Please don't drop tags, it causes people to have to spend time repeating
review.

--OQXy7X9uIo8z3XU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiu3rwACgkQJNaLcl1U
h9CGvwf/WeftVyVodR4qHALiv4Av0QxqR+iExFnfNIAqKJLensYxmI59/oGQNKSR
2FxNc52TMWU8J2MaXnuTpZGnJSbSb+YMVDHO/FSZAtmp3JthRxtNwVdV67Pm02RS
xGGvYzGLDQDMivz2dgiGirxZHfxevZrFLDeGA3h4a7mkM/aKJxLLjbL+cPOGlcri
Zc0p0kHdhtzgK81Z1TaKe7DW8ygkXobECaeL1dwUbFIRBk2oB9Q0R/oHXCTue5Yr
mILQcxhhO4Y4RZarEARwv00rfz0qWMUf6QaCkiTeMuspAvIR5SnjxoQcX8fFcsSn
lBmAYNNzBpxc1gUqnsaj9M3bf4nWUQ==
=AcWK
-----END PGP SIGNATURE-----

--OQXy7X9uIo8z3XU8--

