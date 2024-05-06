Return-Path: <linux-kselftest+bounces-9521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1083F8BD08F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20CE283642
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26960153569;
	Mon,  6 May 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2gQ737D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE12153512;
	Mon,  6 May 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006669; cv=none; b=o6UsoqFOsgf7QHkMe3sfGLs887SxskvXrKqJ0/KqLlGdCrHK+E+xYgfZQZsBtWDuSc5yX1+wpWk9w4LwsI9Yh+yk7RlYIryTyz01YhuIgGy3tZTFXDGw5krFqubYk229MWfFUkmYzulSvTtqXzoXSHxqGrqetF32Ym0OMqToeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006669; c=relaxed/simple;
	bh=uq6oZxeBr7WCufTCHeNPAoz1p+qOGlvaP1M3ucdx7Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnMQfY4zpy2R81vYT9hL0awhE5bq2VPMXLmWZibQD7rvkNEkTuskLnVw9X/EhpyFBD/yeSfAukT5CdIvO4D+9CLTjXzLQYic3dXwPUIpJBfedi4tz2N6qCpHp+W1utp61dO3i6+P/QqTdCEfAaNj0KzUyHE6ppQ2QU97dxvNmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2gQ737D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F52C116B1;
	Mon,  6 May 2024 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715006668;
	bh=uq6oZxeBr7WCufTCHeNPAoz1p+qOGlvaP1M3ucdx7Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2gQ737D9gG4vUqBYrskOUvA1/bDrCFQRMFYyq2EzdrAtAes5SS1C4TG7BvgZr74L
	 oalrop/fxRAnzVjQQyg27IzRO7bqt6jvjdVKbgB/sL8GTRS4VUMmWmEd4IlFFd6HyR
	 UhO6sS5QiKRru1qShuj1fjd7yxCEE8qEwMVKozwoKorON93quWPjxfgNLjUcgVkST7
	 nvQL7cQi1aMnMjHQzLd2i0wAmuU0wgdiess/XRgexR8voWEpWh2gyiV9yozyNCvdiz
	 TMCSRP2gekL/1LunQHsdLAfkrmDBvOPKEgArR9aelW8s7UFGe1nIEjMnNAerMjEoNa
	 Qs+rabREHT6Yg==
Date: Mon, 6 May 2024 23:44:25 +0900
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, John Hubbard <jhubbard@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, linux-sound@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/alsa: missing a return value in unused
 dump_config_tree()
Message-ID: <ZjjsybLA3VyY0r_N@finisterre.sirena.org.uk>
References: <20240505210824.55392-1-jhubbard@nvidia.com>
 <875xvrif0c.wl-tiwai@suse.de>
 <a80cb2a2-735d-4539-a758-a536296975cd@perex.cz>
 <87zft3gz8u.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WzfPT8Mcv1MPlK5X"
Content-Disposition: inline
In-Reply-To: <87zft3gz8u.wl-tiwai@suse.de>
X-Cookie: lisp, v.:


--WzfPT8Mcv1MPlK5X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2024 at 09:45:21AM +0200, Takashi Iwai wrote:
> Jaroslav Kysela wrote:

> > This function is nice for debugging. I'd prefer to keep it with the fix.

> I'm find in either way; just submit a fix patch, then.

The fix was already submitted as v1, I noticed that the function was
unused in review.

--WzfPT8Mcv1MPlK5X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY47MYACgkQJNaLcl1U
h9C8bAf+LC3W5csuXsXkW345oPaJXG/mlVRt0y6r3fozBgx8Cq5DdPfTJaUQiYRW
iZ2f4WDQs5odkSrZ63+uzCuEYl4Go47zHwHiqygtP5Yrk5Yq45VJ2T7lq05mQO8e
GMaGefQf1Lg3xNK1+bl996iAQxbipI+Z0cWnyylNKujLsCI9Z04AQzCVGdk85qfO
MxtEj1XlncY8uvocr9zl//g0D2LZ0+FBdoFAf8QFa1xQOXTIcHkCGZpLRmQ0TeFQ
juk/8jfnhQUYGjw0ihnojiAlSmHfYG0Sq7EnJBMu2Ap3hcJ+uUk356gaHDhz8OfT
FiaklaOKMNV9+a47NG7ma+lvHF5wHg==
=P5PN
-----END PGP SIGNATURE-----

--WzfPT8Mcv1MPlK5X--

