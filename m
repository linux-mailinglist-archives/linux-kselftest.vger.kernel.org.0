Return-Path: <linux-kselftest+bounces-15538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB1F954EBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A21428236D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA5B1BD51B;
	Fri, 16 Aug 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTdexK5g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB773817
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825597; cv=none; b=dFEFceZwqqvseCA/16BiGzOwaonPvF/s/pFxIT2Kv2tDgN7euvPzC2DXU6xfCZY796tb/XREKc29h/UiYVPFxTh9JszgBpzySbeFyoWzGj5kQ7y7qc4d1ZdYxyiFbWcR+5eu3/IcLlkcb0ai8rnd1wWBrN42lx62PkSAK9ak5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825597; c=relaxed/simple;
	bh=y2Ot1WNJgatEx2P7klekmEIAHIdMrnLmkEie2f4dxKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSnHodQKjEAg6L82Ef0QfgwtQ2A3H42jCNI9DgiNxKitD6JWVNcpvU0VR0Ntf2vLIi2WKuDA1gyEwepVnC4Dp2tHWoO5+rI1B7p6YP5AHKKixBkf1CY+iXmE3K60cVwCdcieh0BABtMpBFRC5jEFzwwhJYZcQxeu1/hN7qXXGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTdexK5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4AFC32782;
	Fri, 16 Aug 2024 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825597;
	bh=y2Ot1WNJgatEx2P7klekmEIAHIdMrnLmkEie2f4dxKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTdexK5gb3p8e0S3sSxLKGVq8iLHuo01jOvERLFA79qpRnGW6JmsS6Ur+mWtsDWfz
	 kW3+aoXMQhwdqXd2AotczQgNgBlzBgyak9vr7QwC8m9VI9iDy9qRlZrrUWi8/PUkXQ
	 KX+Z3spCNfRuitAGUUJW8rNhozqeIQA+GRDmSPddmZ4tonWdOGzMObEm4bf9UuX8bW
	 dO4GVn1pUChwc57A6ywV3hGPgV7MlD7XUkJL9vsQBj7gTEvYSu/nBtaUlUfO0HBdfX
	 5ji/5iMvTvj/ef/HtvVlZJcBJpYg/aQEDzpmsP8PqT3qUk+ohaskoNgbghdrZWabAH
	 Ji0rF0jmViQIg==
Date: Fri, 16 Aug 2024 17:26:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/8] kselftest/arm64: mte: use string literal for
 printf-style functions
Message-ID: <24adbebe-8434-4fb7-8ad2-22225ece73c9@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
 <20240816153251.2833702-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fV+w6qyRG+PWOBJP"
Content-Disposition: inline
In-Reply-To: <20240816153251.2833702-5-andre.przywara@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--fV+w6qyRG+PWOBJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 04:32:47PM +0100, Andre Przywara wrote:
> Using pointers for the format specifier strings in printf-style
> functions can create potential security problems, as the number of
> arguments to be parsed could vary from call to call. Most compilers
> consequently warn about those:
> "format not a string literal and no format arguments [-Wformat-security]"
>=20
> If we only want to print a constant string, we can just use a fixed "%s"
> format instead, and pass the string as an argument.
>=20
> Fixes: e9b60476bea0 ("kselftest/arm64: Add utilities and a test to valida=
te mte memory")

I'm not sure this qualifies as a fix given that all the strings we're
passing in here are trusted...  otheriwse this looks good.

Reviewed-by: Mark Brown <broonie@kernel.org>

--fV+w6qyRG+PWOBJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/fbgACgkQJNaLcl1U
h9A4SQf/ds4NeRmY2s5DADRI8jKLIchTvn+spvISWo9U1/fH/gH5w0xnUeGSMWcL
k/xUwqdjDMDyeRH5WEr3POWIu8bWLKkQJ762aHmrJXAU5jtZudCSWhvAPS1YR7K3
rOsbdlZEzm8dLakOhrrNa/xTXqJHSBa/BOEHfeISmZJmGywHhvMsWLF+sW5oCYuI
0LCHJWItpiNteXWEs1+F48uCnwkhMo5mqiYdkpiNKi4sHYMdDz1WgaCJYbkQGUAn
9sGge/eoubSLHTf3BW5ymroprfErj8kKjxGdvn8uNeLUitn9JOJh0oy2ZTBxCDtj
2s/CBuGkUB1fSlL5rJ7PL3Cbb2K2/w==
=7Hox
-----END PGP SIGNATURE-----

--fV+w6qyRG+PWOBJP--

