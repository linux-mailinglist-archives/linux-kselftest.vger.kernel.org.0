Return-Path: <linux-kselftest+bounces-11946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B84908D56
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95FC28C564
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114959460;
	Fri, 14 Jun 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEWpT6qu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC19441;
	Fri, 14 Jun 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375138; cv=none; b=m2C8NKForAqJ1nXg7/vtoEvWkB0IVtzNPfrgXL/RHcD5xjixYDh3ku9tosS9ZpKQskFpDOdnJuZHUi24t6g+MlKxryceOBmovcgAkV6pUdt+0TPTNaht4jHL4wYY7o3UffujzHpxwC3YEGZy6EqUt+y/wzVv7l+/NIaj2y4dgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375138; c=relaxed/simple;
	bh=UNau3l7mBrgun1nLwDDBYj3AuSPwWTObX5XUI5aQVmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6ztEMGftuxm8WWF7rGEbyhej6N4UKNH2pkamVwauLs46XMxBcKDGFcrS95dPvowI6vC3sxdOh/uDEh4LvcxfnG34uBubaA+dCfAZfBST/s73bDsO8al2YeZ4RzyOAsvKj9Dj/YokmGOV6r5FYMdJyHkJ/9AIkhHYiSknfrS1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEWpT6qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA18C4AF1D;
	Fri, 14 Jun 2024 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718375137;
	bh=UNau3l7mBrgun1nLwDDBYj3AuSPwWTObX5XUI5aQVmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEWpT6quYdkYdNf0bCDl0adFF8Nl9VD8A1KU5N4sKbQl99/jV3vjJ4iZbeeVhTi8x
	 yzXpfdm1HFceeY6hG6TJa7lnOcxs5OlxyUzeL9Jbky21Gdv4Q7H9yKYKFLXUglt7XM
	 kFh+xJF0/+w/r3R2OWMEPk+8nHVQodfw4uOWqrVtZgxItoaGwwyIzc2NgKLtPL3SGA
	 xBnDwIxgk9P1oBLb8oEbWsI2z2q5UmQfFJVEhQHVtUhqk/zg8wLv19FGhxXnApJKrk
	 7Z18IJQp/M9Yn7ahO13yxghoNjK0SAjWSdpNZpN3zRixG+3yaiU0gCAHCV5s2MGKXR
	 m7i/EmWovu3kg==
Date: Fri, 14 Jun 2024 15:25:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/5] ALSA: control: Apply sanity check of input values
 for user elements
Message-ID: <ZmxS2vSL6LCd0q2A@finisterre.sirena.org.uk>
References: <20240614124728.27901-1-tiwai@suse.de>
 <20240614124728.27901-4-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A+cBSQidSaCypIJT"
Content-Disposition: inline
In-Reply-To: <20240614124728.27901-4-tiwai@suse.de>
X-Cookie: Your love life will be... interesting.


--A+cBSQidSaCypIJT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 02:47:25PM +0200, Takashi Iwai wrote:
> Although we have already a mechanism for sanity checks of input values
> for control writes, it's not applied unless the kconfig
> CONFIG_SND_CTL_INPUT_VALIDATION is set due to the performance reason.
> Nevertheless, it still makes sense to apply the check for user
> elements despite of its cost, as that's the only way to filter out the
> invalid values; the user controls are handled solely in ALSA core
> code, and there is no corresponding driver, after all.
>=20
> This patch enables the input value validation for user control
> elements no matter whether CONFIG_SND_CTL_INPUT_VALIDATION is set or
> not.  The kselftest will be happier with this change, as the incorrect
> values will be bailed out now with errors.

Reviewed-by: Mark Brown <broonie@kernel.org>

--A+cBSQidSaCypIJT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZsUtkACgkQJNaLcl1U
h9BGuwf/YIGJxVh2z/E7yzRRZz0g2+yDYfRBGRHLPKfwTFvz4w1xzz0f689gGR8y
BwqxDyxQTQdJB3U55OaEMvU2gIzK5TjBAJhIHQ8BwjajoLRLha+I91wpfgS5Pxjd
L6K48WF0lcze8Q+zOlUjnszZzQJEgSxMwdnGAcGq26flJTf03p7gdazkIcwQ4fJ9
NP8zlvt2cfZIW34XgWNigDQGJGdG+gOjBZgvyIuiafmbWqgf7cAWUA2o5F6T0IXt
scA2qofkITQ8Q3erD3k5L2A0/m1sQKIxrPvR6Hj2I6SjOUjEOSi0c22pA+bHKZav
gpssst7DhbTpx3tRdtaCjW52d8/HZg==
=m6qT
-----END PGP SIGNATURE-----

--A+cBSQidSaCypIJT--

