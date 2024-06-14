Return-Path: <linux-kselftest+bounces-11951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0169908E9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707E6288D37
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9583C16B754;
	Fri, 14 Jun 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHpA3rsH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A015EFDF;
	Fri, 14 Jun 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378618; cv=none; b=D9/mxI0VvFOxka9tDBDs9Zg/XStgKQjLzz2tRgKYy/xQe8+Rsk6vSC5xX8Mfm1AYJa11A9vS4gyd5q6HsDe+ic7WtwzJsoAbZGbrQ5q2GbmQZ+6YZfL82cUUMfbwt1fmH5ymXYaTHUCwrFex+WkffyH8Er2/Xhb8u8XlKkFkA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378618; c=relaxed/simple;
	bh=D8SdDyZNxqPcDlfI0tBoGYiGmsRowmEdQjGm0ySvkak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gih61EeyzpPTpTGolZy6AdY6oR3N13U0OUOvJDkdHGBPEiUUfhHJydo9EEqyGbbM1OoosqYL5OrVom7wg0J/matmY/mTmVE/JEHknRy57p3WiYRNtloH9sZyL/3PywKKNinytD7C39e3wePuSWemONcwXgeN966M4O/bn67T/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHpA3rsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFA3C2BD10;
	Fri, 14 Jun 2024 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718378618;
	bh=D8SdDyZNxqPcDlfI0tBoGYiGmsRowmEdQjGm0ySvkak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHpA3rsHkpa6n6ixnEQO/NMuV/ZkYgZKABpMdhSMNnw5sd8BMJIJmB0IeNM2bVWTV
	 8pt8diEECJ6RQLI+eaOzpI+0wzuHj1ZcD6cfZVsNNp3j0cIhdH0abpP1MzFw3YS192
	 Bn0/xMXehyj0xc0h+LCZsMLv/mEFrFFooNnOBORaKEdtGYxj13kFgplmulbDkBr/0T
	 mqdtEoxMQKPcwdS3fmdGN6hMMGvVw78VY0hxpjnzs3/cdoXFwOOvc9HQYK9k97Jz6i
	 F9/z3o3bMhh9hJFqjDkkAxwqTG18R57nHz6Y7Gj+mv8P9DdxZazw5cNLSu2e5BrhVv
	 vgNxLYRGfQFSw==
Date: Fri, 14 Jun 2024 16:23:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: selftests: arm64: fp-stress: KERNEL-1-0/3-0/4-0/6-0 - gcc-13 -
 Failed - clang-pass
Message-ID: <Zmxgds7Ms5K6wmkj@finisterre.sirena.org.uk>
References: <CA+G9fYtobhBTnH1=2oHxesLfyYd2VGK55nJn+iniWPj2vyNCOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HD+u2jxYKMXTxpY3"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtobhBTnH1=2oHxesLfyYd2VGK55nJn+iniWPj2vyNCOQ@mail.gmail.com>
X-Cookie: Your love life will be... interesting.


--HD+u2jxYKMXTxpY3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 07:21:15PM +0530, Naresh Kamboju wrote:
> The following selftests: arm64 tests failed on FVP-aemva test and kernel
> built with gcc-13 but pass with clang.
>=20
> arm64_fp-stress_KERNEL-1-0/3-0/4-0/6-0 - gcc-13 - Failed
> arm64_fp-stress_KERNEL-1-0/3-0/4-0/6-0 - clang-18 - Pass

This seems vanishingly unlikely to be compiler related without some
other information suggesting why it might compiler related.  It is more
likely that your GCC run suffered the very intermittent glitch which
we've been aware of for a while.

--HD+u2jxYKMXTxpY3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZsYHUACgkQJNaLcl1U
h9CAWwf/a0pSAw+DbWzM6Fe/PkhNmHLgbX+JX3F3jqYiNkqSry4njPH92PLX89Bx
1FAcozNEF+GBfOMVJMyv9dkcE+YD8zIOC34vW5VYcHHnSsMXNZT9RrWWs6dWG0LS
0FqH0mGjAJwk0ainYOBk/d+94Re0NP5vpHIOhqZ+vc+KM5t0bGRV/iIE6xiGlRqD
40abY7vf9rdtMi+2qMLgR98VHI/32g2W3sPOjQSNogZKkw70s7txIfhoqIyA0WNK
blLo5P4ehHnFwiq/JnjAtqKjc7Bgbs/l4E51jUDmomJ8LUcDU04MVVNd1WiGPSZW
7+zPuhIcdrDn/AxrovzeewO1wloBuA==
=i8mz
-----END PGP SIGNATURE-----

--HD+u2jxYKMXTxpY3--

