Return-Path: <linux-kselftest+bounces-38466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC034B1D733
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 14:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2A47A6B7E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2923507F;
	Thu,  7 Aug 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOe2YOed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D3221275;
	Thu,  7 Aug 2025 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568255; cv=none; b=XoG8qb+2g0Gn8CYAB8ULOrn0RCKf+coZttkrklAswzm1z90GFmF4Wqqk5q8zGy7mt7bNx6FMxpFFJqSN3vrqIz7KZ731Gfb8TeHG9bsCSaMKVaMHk5muPQbELuEdYGSvJuPOeBrx/7EID1JBKrRzIdUUJXtGqZXR+hBEI2EM9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568255; c=relaxed/simple;
	bh=3Nv2ReQcE0cjcXzp8V/iD0MVf79EuAx+RGJtUPfvBhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug5gYRrS3zm6Jm0qW3lNFM8bdg5J+TijlPdPYkj1mKp+jiuLKhTHW4Vo864M4jCtmGKzcY9vR3N6/nN27JyI/CgRaxv3dOQ4NxqTDhxNQI2Qcj3jQ4Fz1mhI8opx9I2C5WtZrwaNxyQY5zrnvBf0uUGsxOXNe30qXsH1jnQXwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOe2YOed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25353C4CEF4;
	Thu,  7 Aug 2025 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754568253;
	bh=3Nv2ReQcE0cjcXzp8V/iD0MVf79EuAx+RGJtUPfvBhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOe2YOedP5W9OCUYaMyEDQku/5/0CBpPf2CyvFu262QH3zEPlN3LliEOkx5EIKZw+
	 ZItKzr3pY/oQ3W79PbpB+p2POKF8JihPZeNijIBKDXcJiCqpmahqQHWNW5vP8N1wnS
	 a4gsDYgJJzUd7fqVcJZhg2HNUhbhHFXFD8Q8Gb1KRH8bR+pdOQUrdCP2n3zBG53q3y
	 E5gfF/uA1RDj2WoSX1qKXDgmUg0+9w6TN3mbVfUkrWTXHwv0rX0e8wIQNkKX02F8ov
	 i/KptSdo0++nXrI/dFjY6rsrFDThpUDhpY/vtlbUX2bc7fBm0WEwWnA95l+nMNmXFn
	 If1PAU8dtbjig==
Date: Thu, 7 Aug 2025 13:04:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH] selftests: arm64: Fix -Waddress warning in tpidr2 test
Message-ID: <a2456da6-2c73-4b0b-9d00-50ab88bff4af@sirena.org.uk>
References: <20250806203928.168365-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Aez3VvGl60kO4LiE"
Content-Disposition: inline
In-Reply-To: <20250806203928.168365-1-reddybalavignesh9979@gmail.com>
X-Cookie: Real Users hate Real Programmers.


--Aez3VvGl60kO4LiE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 02:09:26AM +0530, Bala-Vignesh-Reddy wrote:
> Resolve compiler warning about always true condition in ksft_test_result
> in tpidr2, passing actual function.
>=20
> This silences -Waddress warning while maintaining test functionality.

Ouch, good spot.  Annoyingly the compiler I was using didn't complain
about this at all.  Like Anshuman said it's good practice to include the
warning, and also often the compiler details unless it's a super common
warning.

Reviewed-by: Mark Brown <broonie@kernel.org>

--Aez3VvGl60kO4LiE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiUljgACgkQJNaLcl1U
h9Bs5Af/QyzJEIAygC1BnUR4SlU1p0hHnudoWz87QJl8gRYWIGA3nHhJDdJw0eAf
Af3TyiNhstsRNlwBIVeHu1ny2/udd97DtFYu9ErK7EmBTbBnWiyKRtGVQpkdtAJn
GcyBuCFWhZCDT+ek33WMFY+eXCUtMZt24Om0eI846jET6f6LYRLG6977mqAvlSpf
9NQtO6Q+/cV4AP2r5+ta2oF92L+NCaD0l2L34DHKPimA4ytf+x3N7xyIEw7eb9bd
w5sowauXzmgXouRQPvRxFjVQWAGwrskVFIhgCyezaj5FRNONkPqBFRQrP7EvsEGC
PH49pDmFLUMSSFlxWHkmtp6pJ57UQw==
=EB21
-----END PGP SIGNATURE-----

--Aez3VvGl60kO4LiE--

