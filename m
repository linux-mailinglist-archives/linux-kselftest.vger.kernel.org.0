Return-Path: <linux-kselftest+bounces-11674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA02903959
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 12:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341D71C21BEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1E31791FC;
	Tue, 11 Jun 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViJLsjnz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A34178397;
	Tue, 11 Jun 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103302; cv=none; b=mUDAsIbAOpY7n0JXi5WloBvahY372p6eRVB3SvZaM3dbAmQp/CZWK0KoO7b81fwTJQASaXgFuruVQV476lcHlnTf3lY+MWnfb1qFxU3deuQaZFRjiHZncrA/vmJZflYDyysx9Qn3i+V4tV+VGQZ/vS9TQ5HUVRV0ts2Jucv0Dv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103302; c=relaxed/simple;
	bh=jlkrZlfi9ghdkUD3E+YQZLw8Uwi95sOx5QwBDSFwqik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fx9Ezr1Zknt40Z3bo7hIr2/WwPd8o5gFxgGzlTtQvRxFoojeMYItLTjocKXtfvYpAar4yrQ/R/aCPvTZEgfmubLn88II3R0Asknsr6r7OcfTBOCVsdK1p2eH0NPICuPtH0J1PGRougWs1jKaWyYJanwIMyecGElgvn8zz0TQoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViJLsjnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AB7C2BD10;
	Tue, 11 Jun 2024 10:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718103302;
	bh=jlkrZlfi9ghdkUD3E+YQZLw8Uwi95sOx5QwBDSFwqik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViJLsjnznSCAqntRUt+vVROX6ipD0i7CPY5CavHj1LwNYeL0Zn2bbgeBRw+N5VgJ6
	 Zxzd0KVrXnYAnIKAPJ0fU9BZktLfb6FOu+Kt/Jg6/773uB/zy+KGJZCgv7Es5wam7D
	 8C3g6bBWoeuUFwGeedS0VGUHMWGQkW7pMExb/cG8qA/T91TxbT3f3S1nkZNZOFBZL+
	 J3buyUDvYzYpOHYT9UzTZar0Q7pNDswTlvxcLYv/VXQS4vvQj2N+I+CnIfi1BcJMhD
	 zi9Q2a/A4GYbUuKuppzrS3eIRmCSnZqIsT/lAdtAiUmndK+qTKMz6NawlZPPotNl6p
	 /63AQwl8+pJ7w==
Date: Tue, 11 Jun 2024 11:54:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
	tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
	suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests: Rename sigaltstack to generic signal
Message-ID: <ZmgtA_GW_GPgPM1E@finisterre.sirena.org.uk>
References: <20240611075650.814397-1-dev.jain@arm.com>
 <20240611075650.814397-2-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M7ZRx99x+Njm+IQK"
Content-Disposition: inline
In-Reply-To: <20240611075650.814397-2-dev.jain@arm.com>
X-Cookie: Your love life will be... interesting.


--M7ZRx99x+Njm+IQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 01:26:49PM +0530, Dev Jain wrote:
> Rename sigaltstack to signal, and rename the existing test to
> sigaltstack.c.
>=20
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

If people review patches and give a tag for them you should carry the
tag forward to avoid having to duplicate the review.  From v1:

I think this is reasonable if we're going to add more generic signal
tests - sigaltstack is a fairly small bit of functionality and having it
covered as part of a broader signal suite and the overhead of setting up
the suite separately is probably not worth it.

Reviewed-by: Mark Brown <broonie@kernel.org>

--M7ZRx99x+Njm+IQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoLQIACgkQJNaLcl1U
h9D3Kgf/WuphRjuFoS2YT244+k2nuqqetLVxqWOMOV/vt1NxuYL7bbhpz0EqhBqv
I6nqG70xVWuTHeR+4Q38vg2kT0r1ruQIxISVMTnb8P44j8Bs+5aZqUJwz87y8cdo
h/IZdHwz2wR6sSz2kT6U2hJUiL89dy46I6u4IwAdRLOgezildFig095w/hf0pc4E
Yh1+9hznungjj85Gbn7mO5W5op0j0IakA/Uzx+5c9IJ2a3rG4CcDBqZ9Oeyi828t
U/WX73qatb4E6X0kKqG2qOQf+FmSa74lkbJ/84yqIyoJCXWt+VnDrYFQzwPq8os9
6VvejhYY7PQAILNcUTRYFWZVwPgJUQ==
=ydvO
-----END PGP SIGNATURE-----

--M7ZRx99x+Njm+IQK--

