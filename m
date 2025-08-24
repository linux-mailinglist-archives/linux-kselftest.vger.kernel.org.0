Return-Path: <linux-kselftest+bounces-39806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC5DB32F76
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9B117AED3
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 11:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44652D59FA;
	Sun, 24 Aug 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kozhhYJw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E744C63;
	Sun, 24 Aug 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756035097; cv=none; b=RjMPD0qEEP41wrr669EFhjWvv9gaAvTPesvf4H2YhloRtUL0NJvuIzM32ih4vWyP+n0gxGvLzk4wJOqL1odQnJMFc8s6PWPBlNm076c/BSw/hwXxvhr9quvf4BLWAr/isTQqRXSB1sHmDY9ENOXK9MZ7V2BqyvS49rzOthZwZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756035097; c=relaxed/simple;
	bh=rmVs7GttlTeKD1AslGtsCGPaqB3oSaPJjE9tqpKqNiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lod3IvG7a94vU5TTqckZoYWXTImqwiyKMSGc8P4ek2Tl0Z1tyEzc4nMh+Edo/tr8BZY83oHYuA/Qk/0xSMCgp+t4d+PMzNHKl5iPABS97h2H6AdeLN50Ifz5FMbCBj20D5uwgDy84l8USJG0WoFg2lc24JlgbQuLh0E7CYU2b9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kozhhYJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209C5C4CEEB;
	Sun, 24 Aug 2025 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756035097;
	bh=rmVs7GttlTeKD1AslGtsCGPaqB3oSaPJjE9tqpKqNiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kozhhYJwtxpddfD1xCRTLVEpTXQdSKXGBiNvRA7uT2z9H6oWJL2+o6JTDE/ax5+P1
	 HLR3KGp+i2pzjuMCyKFoppluz0OSfRzGUNCb9tAhggo35VA3U1tNq+gaTfE3bkaSXw
	 5EZBlNJHg/XYoLEscs8hYiXom+XWFIDkVIOGTfrRIkZFsLP9IakBrzxc5NHfKnBfwA
	 Rs23V+FjzGT7JDEhkHwmJvTA8awEBWPHS8ZAeoO5mVX7AyrCo36YeWtwol+/GByBYN
	 MwQIsVMbwjhxxDQhJwThZNJcgBLCo9mspkCnih5xeyttAp6nuyZuME51kIg5uNX5UR
	 EkW4s+hM1l4MA==
Date: Sun, 24 Aug 2025 12:31:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Vivek Alurkar <primalkenja@gmail.com>
Cc: skhan@linuxfoundation.org, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests: alsa: Fix typo in mixer-test.c
Message-ID: <aKr4FirG0-h5pwH-@finisterre.sirena.org.uk>
References: <20250823095439.476797-2-primalkenja@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fhHtqqeAZdtPkYZm"
Content-Disposition: inline
In-Reply-To: <20250823095439.476797-2-primalkenja@gmail.com>
X-Cookie: Filmed before a live audience.


--fhHtqqeAZdtPkYZm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 23, 2025 at 02:54:38AM -0700, Vivek Alurkar wrote:
> Change "libray" to "library".

Reviewed-by: Mark Brown <broonie@kernel.org>

--fhHtqqeAZdtPkYZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiq+A0ACgkQJNaLcl1U
h9AZCQf/WLTJCMD3tlrBa5k1zirrXCCBa9EchXlv9voWEME1eZ2mLBOTWJrBmhjM
4FxRKmXJQzwC/I0ITzYLgO1lbg3XavWCxuuE9GbIuBi8VQBLCqFTAo8nwd/AyA6m
5lSwxMShMolJ3x7Izcja/8s99dKI3pQii7QRK/8gJBSrhYyDys4a21jTIi5ojAoS
K3AcpS2gq2VrqE8+jff92XnnH/qLaIUyc0OWzDANpODJRW9PXh3ucPBCvbj2+du8
7jLo3v6EaAIMUUwz53yHfIHvpcxJaSGwnmcnMjE5JpnipyEjAA5XgS0Alir+hsm8
Fk2hjlcWRDjPeDXCpZTPmQL4gDlC5A==
=Vbgt
-----END PGP SIGNATURE-----

--fhHtqqeAZdtPkYZm--

