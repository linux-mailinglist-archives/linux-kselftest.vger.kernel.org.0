Return-Path: <linux-kselftest+bounces-39534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40791B300BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 19:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080381C23DCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F12FB627;
	Thu, 21 Aug 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx7KcmwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055B2FAC12;
	Thu, 21 Aug 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796098; cv=none; b=d1virllfsxIO88lAQbP5or+Z6xiSx94OK6IgYBon3j9kPwmVP2gh16wlNJcAwyiY5EBMH424YlbCinNIYRgycgezXrlYOHd+6ARJ/2JXsSwI34ppZhIa3AkeJCsVc33FDFhw1f8PkPNbGH1HqCX6yyJNCF6bUTII3a5WxR2dCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796098; c=relaxed/simple;
	bh=31gOTHz/ebGa3W3r+33yR1DrojtjP2REs9LRBXLJK8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My24CyOI+ULmyLYgO6Yeyobl5CYZk82aQzuW3c61MZe5nM5lKchsh1luin+YC2L3Fqck+3KgaNvhraTkxETvYrZJNl1s5L+weHrSbDi3J8b8ChTY8uhV0vp8ux2rvCPnG6wEbbBcgvj/Q9yqcQDnn5fnZqVlvaWLcyUFDGUt8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx7KcmwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C03C4CEEB;
	Thu, 21 Aug 2025 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796098;
	bh=31gOTHz/ebGa3W3r+33yR1DrojtjP2REs9LRBXLJK8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zx7KcmwHGYzBB8Wz7/IqA9JoUmOMKz9o4IlC+Nr+VFleqUDYHw3uR8Aoz6xwmCPr6
	 MWSfdqeoXvoR2UgCXiW633WgJQF+Bc7Wfc0EkBTEqigegYs2sdLncthO3zpl5fTxnR
	 JQcf3jma81dBP3NG3WSSvN+QZBJPAEsB/DE7eOmFFhuUdyIJxOTUBfnc8FeZ/BYGh0
	 U9BnNfrcR32om/UNtBADGLtDYbdEQ7DUzthFyuSgcz4G2Jp/ogX6lDOS1NfPrLVFFw
	 KYKfQwFwv/fo9hzyq73OfCkXgwApXs2leHC5MqosKILQ/AuuyJd46OGQ3hlLw0++3G
	 jJ72zB0iC90ow==
Date: Thu, 21 Aug 2025 18:08:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kselftest/arm64/gcs: Correctly check return value
 when disabling GCS
Message-ID: <24a68b5d-2c24-46ec-aee2-74b45b45deea@sirena.org.uk>
References: <20250821-nolibc-gcs-fixes-v1-0-88519836c915@weissschuh.net>
 <20250821-nolibc-gcs-fixes-v1-1-88519836c915@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DVFZaVUj4cP8FPoR"
Content-Disposition: inline
In-Reply-To: <20250821-nolibc-gcs-fixes-v1-1-88519836c915@weissschuh.net>
X-Cookie: Warp 7 -- It's a law we can live with.


--DVFZaVUj4cP8FPoR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 05:13:02PM +0200, Thomas Wei=DFschuh wrote:
> The return value was not assigned to 'ret', so the check afterwards
> does not do anything.

Reviewed-by: Mark Brown <broonie@kernel.org>

--DVFZaVUj4cP8FPoR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAminUnwACgkQJNaLcl1U
h9AaNwf/dx/DkunGpnhn2H/7SWaWs67mqHdnj5v38faOVHnQsUi5f48labTyAYNQ
kB8icvE9A8Z/KCxsc92S2lwv5bshWE8ZvbWyFyytJbFEXGpI5XGlPRagdL6UzJr+
BmZIcMpbVd+DG2g4DY4yqiqBOpaCVEPneOOi3mC1ZC5BGNMExvhGCQ2XPhpFDpKL
cydo41hLLhbq3OcuPnuhwc2vqAX3dzDVU/QsYacFYA7rN5ZjsJk7GQLrtmZecXiq
IU1bx1FOwi+5oHHG9b7QS0OLSbftM+gO16Q3yeXxfU3BxR8iHsF4Jv11Fn/Qt7e9
aNZxz1s6oz8GKK2Oh8DqAvZuOtqxCw==
=Auzd
-----END PGP SIGNATURE-----

--DVFZaVUj4cP8FPoR--

