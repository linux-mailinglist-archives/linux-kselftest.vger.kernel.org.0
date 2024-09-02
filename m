Return-Path: <linux-kselftest+bounces-16969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B11996879F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0102834A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46630185929;
	Mon,  2 Sep 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiR084Gq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49E19E98E;
	Mon,  2 Sep 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280642; cv=none; b=fAPk4gP8j9w4FT/cDzc11WD8wLo1EckCKIIciYO5oMFSd3aMM8Bda1oP74TbEsKWMpn7n1hECnjZNtzNADpA1+DlXW2myZXicbRFLsu5+kVWbeRF1F5L6Qh2hS1YLcWoNsSLdrQNqH6OCsU8bh4PoKwqNX/nKA87zktMwArXB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280642; c=relaxed/simple;
	bh=D8VtvsQuvIpOqRNcsehv1Db0iQ7Qrya2A4PT1Nyu1h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meNQnYfgZthqRsZWRudvrJFq6ILVfTlL8h9eKySHYrFQQo/xKQpeyVFLsUBTwgOb8ggU4g+zehSuxGf17STiQ6J9sUQUEqTdXb8q/liEeIq9Ps2JyCS0shj9YhZQ40o13O4GBckenYau07YpO1DV0pTJHwdbfWbfwbkjHe10Qf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiR084Gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32170C4CEC2;
	Mon,  2 Sep 2024 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725280641;
	bh=D8VtvsQuvIpOqRNcsehv1Db0iQ7Qrya2A4PT1Nyu1h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiR084GqIYL/Bc9QK69ACAqVoLNsVyurvC0SfiwuPdvDbm85m70yINX1dvnptFjdc
	 NyJ+84qOcyVEbSz+V+itIk0L5g41osX19zD7mioS6ooKBw8aQnftv6t7z65PIU9f/u
	 BjWw9/cZeLqZJt2G92pZX2hdnTGeHPKK0MHK4Z/Ug6fKIL07PYeJJa6InbInJQxAg/
	 bKWZVjuaMcSiYrcsHg3brAiwp85aN6qVSo2Fzdgij/H1FPT7DzJfOERYfW4Gf4Rqa4
	 zRrHOWQ5AfR2ep7RiCOMa095cXTW2sLgwqy7YM9XHLe5pN/6QjTic/74Gb8Q9/e3dB
	 zMf60wyw70GtA==
Date: Mon, 2 Sep 2024 13:37:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
Message-ID: <ec7bfeb4-30aa-4874-98b7-7877a12cb98f@sirena.org.uk>
References: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
 <ZtRqp-uZe5C07qOF@zx2c4.com>
 <fe8ea6a6-71d7-4cfc-b20b-fa0a7f39a4be@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+hvW1VMoMitmE2LX"
Content-Disposition: inline
In-Reply-To: <fe8ea6a6-71d7-4cfc-b20b-fa0a7f39a4be@csgroup.eu>
X-Cookie: You are fairminded, just and loving.


--+hvW1VMoMitmE2LX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 02, 2024 at 02:22:38PM +0200, Christophe Leroy wrote:

> When vdso_test_getcpu doesn't find the vDSO entry point, it prints an error
> text and returns KSFT_SKIP

> I thought it would be more correct to have the same behaviour on
> vdso_test_getrandom instead of trying to build it only when the underlying
> kernel supports it.

The problem is that the test incorporates assembler code so it simply
won't build for architectures without explicit porting, the issue isn't
if the target kernel supports it but rather that the test won't compile
in the first place.

--+hvW1VMoMitmE2LX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbVsXcACgkQJNaLcl1U
h9D3mAf/dS+qv6Qt8ulv2/CzOosH2KqxoDIi27uUhzq4itbQbnGjNTDMo7SoHwWP
9luA5xoKVqI1r32V7f2VUZJ1IlZdc9h77diqQdSpOxlMfDlFfECIQcWnaPB2HBSq
WOB3RuxIY8ovwPYyBYC+QQENn3H5UKkPLaWkko912mwb3a6ZXC/afnIkFrPPw0fi
FkRQL45KnnHsH3hVi+ur4OsiuEnU8zwadlOrQWkh77EdTCMnj4TBfqVxleRrvgn1
kqASZgnCzoYCEwX6unHXgEqPSUHlvjwhccdwCyYKyCVsZVmyn+gc0uWv6i3BoVD9
7YSyJmNLntPUIc+pOcJCGB2hbf6QVg==
=CY43
-----END PGP SIGNATURE-----

--+hvW1VMoMitmE2LX--

