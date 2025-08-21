Return-Path: <linux-kselftest+bounces-39540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54F5B30151
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5FA166B4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26736338F4D;
	Thu, 21 Aug 2025 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSbKPInA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE42E3391;
	Thu, 21 Aug 2025 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798080; cv=none; b=jK8w0PqHY2QIWRnL2PkcB7xFGFH69+xqRekOM+QPX9hl0gBMdLyGjKet1um3G2Tdsmme4I2shnIxda7VY4WPYRWRtjhYuUanwOdIr8McaJCmHG2yNqlYVdAmyqY87/5xP9SuGGvnWKcrnnFTM8Rm4GLFP0C26WoxDVGggN2A5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798080; c=relaxed/simple;
	bh=CAWXuYCd4Mxit3stO2UaprvTXEITxr/acXPbIVjvyX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8POpBz834NhaD4MAIqOFGBvJ3w6ivVgl74sUy/D/OKiiMsoajyI52m8iGIDtiXhPtEZOtkccUBP0Qm7GIkFDjRx2rY/GO1aNMxfdPgG0nzWQ7YfjbfSDDAtkDNe923TItmfcDKAJm1fe4kt8//JArExZ5F06CtZfE5Cu3s0ifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSbKPInA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BB3C4CEEB;
	Thu, 21 Aug 2025 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755798077;
	bh=CAWXuYCd4Mxit3stO2UaprvTXEITxr/acXPbIVjvyX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSbKPInArKsR9+zoj4UVdZ1fiuC8qoawUivQ7VUo914bHpR6dD8zrXdynLRIBeBtx
	 fA52iZLeub51h9F9/xcAi8cObAX6dOJvr3KKR59D0dO/tG33Uhpe7WrbwL9gXlsMLf
	 wXfTYZH4VUbm99nmkl38U9XLgKR70fjSxGgWOPcPp4QQiTwciEC26zP6QmhFiT3ZZy
	 x101BoKJm6t3jkSwRywQbq8PhoUgWvbgfvdn7Ti0ElZr7H3YpQbz4VFQfCOMLMo83S
	 yB//WekiXgSGszYsHzpPMVkf8LDcBdKCUwgk9zfLtAIrGswIseK3Yzy0FL/6iBvnB7
	 S/TzldLgtuhAQ==
Date: Thu, 21 Aug 2025 18:41:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 6/7] kselftest/arm64: tpidr2: Switch to waitpid() over
 wait4()
Message-ID: <faa9a64e-0324-4021-8cc3-ee7e88ae5888@sirena.org.uk>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
 <20250821-nolibc-enosys-v1-6-4b63f2caaa89@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6VFHNtdRTkHby4tZ"
Content-Disposition: inline
In-Reply-To: <20250821-nolibc-enosys-v1-6-4b63f2caaa89@weissschuh.net>
X-Cookie: Warp 7 -- It's a law we can live with.


--6VFHNtdRTkHby4tZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 05:40:37PM +0200, Thomas Wei=DFschuh wrote:
> wait4() is deprecated, non-standard and about to be removed from nolibc.
>=20
> Switch to the equivalent waitpid() call.

Reviewed-by: Mark Brown <broonie@kernel.org>

--6VFHNtdRTkHby4tZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAminWjgACgkQJNaLcl1U
h9AkxAf8DNXB1lNBp13/JD1lfTcxFMkTYH2jPiYINWmsx/3T8WKpgUKg/9EoTKwb
XHVd4bt+u5gN5OhBE1qKj8//1dBG7eWSvQ/WB9DltiVdLXP+6XxEg47j900N9Ie6
f0m0NiPISvpfWZkB/HorljMZeCd+sBqFs/aMBNJLbMLaHx2mqG289r+6W0tZV5AL
jLsvk9Ia+u4FVeQe3a4jrlRuoEzZzP6IvVsdcMtldsmxTe6vK/ZdLfRhVEOPXAlB
A9tPn6sAr8waVqRIPC14/KdIZkiB8P+Q2RJYZod5ax7pZZ+61nPLITRarj8ACiyL
+dVHJg5EOkBUAxetRbtgWyt4nFVN4w==
=wYJg
-----END PGP SIGNATURE-----

--6VFHNtdRTkHby4tZ--

