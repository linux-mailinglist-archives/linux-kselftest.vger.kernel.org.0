Return-Path: <linux-kselftest+bounces-34509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F76AD2452
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD9C7A2FAC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC1321931B;
	Mon,  9 Jun 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwmav3bT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDB1DDC18
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Jun 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749487371; cv=none; b=JulyhCAmBxlcTnV1cQGFKlcSvSL1+0gHxHQwdHFQot1D4lFqYeL51QD2E2IXMyiVBR01Z5FQNOg91mH+pgFqvbJZkqXuPRbLOI4YB7NdORFtrZLJeP1bUKSIgoCpYPX2noesLpu9sde0yKUZfqp+CbuQzORcswvL5UEZiE1HqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749487371; c=relaxed/simple;
	bh=xhFSjLyfFeNQtqHgn+HSWQXnAEfBHU4DDfw42wUoBbA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=obDHYLV/XmiSpfr/eCKgmlCSCJQk6vc3ETEQ/2nuiN1JcjiMqAR5nh+ceSa0CsLEaJgaSpidbdDTObkklihfMwkGmcssCqfnAjQ5YSSM9a+LR+CVidwSwhjofZoLVwktDT9secbn4CiYR0eK3/ZaZA4H1HT0szim/C3pbHLlro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwmav3bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC80C4CEEB;
	Mon,  9 Jun 2025 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749487370;
	bh=xhFSjLyfFeNQtqHgn+HSWQXnAEfBHU4DDfw42wUoBbA=;
	h=Date:From:To:Cc:Subject:From;
	b=Iwmav3bTmzLGO/Nihy/LSCLOjsfFaKJKX0J6Wo1M7fRycpi11Vn1fs21uD10ML/ri
	 eSb8rprA8vdorQIZGcQapd5t452lsL1GDR2trHkVEl10XitScIuCr11insyV8htELK
	 2cmlRkwCIINWrp19V7/h01BeW6v4uO5e89ZvMJ3t0XrsoqYpCif3DGa4poKIBgHbG8
	 IcO5AmkuMIMB+PvpHNJz+zhjOojlTYf6+MEeOxSZ7LZggIQtmUPSgBl3SyBXVhxpg/
	 sGBM3Vf6n4d3Axc0r59Jj458qhvCb6FR4gR0zNb8fjtKfdCymmWCJucbGUajQnDRHF
	 /q4QEuU7zz+nQ==
Date: Mon, 9 Jun 2025 17:42:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: nolibc test target overwites kernel config without asking
Message-ID: <3d5128b9-b4b6-4a8e-94ce-ea5ff4ea655b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AUjLqseHeDSi6uLy"
Content-Disposition: inline
X-Cookie: Restaurant package, not for resale.


--AUjLqseHeDSi6uLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

While running the nolibc tests I discovered that they build a kernel in
the current directory, including overwriting the existing .config.  This
is rather suprising for the selftests build system - it usually wouldn't
do a kernel build at all - and might be annoying for users.

KUnit deals with this by doing it's kernel build in a .kunit directory,
it'd probably be good to do something similar for nolibc.

Thanks,
Mark

--AUjLqseHeDSi6uLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhHDwYACgkQJNaLcl1U
h9CQQQf9HMYackkhH7zurUqjfKqojv1OrCFYhhU/3NVOhXxLEHO4fWwD9UC1VuGX
gyPr/DxObLP6J/KSyN3vGlJV6Wg2PZWc/jF5DUQNf+fwFmZE24CYCG6Irk/7WzED
f4y02T6HVmpn65ddaOTkokt3WGIB93FhlE2shqJsfuGLPGeYT/mFLlFwqRkmWsAg
7WjJOWthlqJwq2VEe/OJIzaCMqAmccs3qP5pSwXyUW0n0HEqAavk3vh8nOOTa3Ye
lxC2Q4zD89ZIKsjQ0I2+homdo9JfIObGnckzUsCu1zV2R91/MC0SHeeHQp5c4Yjk
4iMyhoTDXhPvp+3U5frwlm8sWQrXag==
=8Kl+
-----END PGP SIGNATURE-----

--AUjLqseHeDSi6uLy--

