Return-Path: <linux-kselftest+bounces-35740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD55AE7F21
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 12:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794BE3AD675
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5212BCF41;
	Wed, 25 Jun 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7kfdUAK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259D29E11B;
	Wed, 25 Jun 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847075; cv=none; b=FYdmLt3j7b5KkTP+kKYeuwG2VIqbIVVffmo8+mpfN05Xqflj80pWWkIvtdrXXE+Ch/T6DU3u7q56blx9+1PBlt8gOgP1L7Or7a/ZXPVQz9Z0N7/WEWzVDj4s/PVzM2NmA9cYLCZ+ucCuNbqtR3YwHmryXn2wprdJKSu2jFaNlGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847075; c=relaxed/simple;
	bh=jQKiZvyPyPPSuFSDfrH9+KNEHhw/SGeXba4D7QcIO88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNZvUwKaC5ciCwMjbNaEjon4DuFMvm4Gk9/CjN2uOwUv+9MSa8bSCK9FhhQFXIucddNmw49Xrt8lDOo0WpSgZuvCxuUUHmBVv4T6sIlU1Le0s2wirETNeiuUuj0I3DECVq7FI/VycykRJJDx8oNYLxJ/KSkOuHzuPg4RpUg8AZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7kfdUAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B991EC4CEEA;
	Wed, 25 Jun 2025 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847075;
	bh=jQKiZvyPyPPSuFSDfrH9+KNEHhw/SGeXba4D7QcIO88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7kfdUAKilCSEJO33iTRF0Hck5tE46oWeICVFdeY6HhZK7AvRWfxk/Rw0Cl6uq0xa
	 0qOMYkw/ERvrz62II+mdfKWdJwni0MYFmlw/WGBKOe5KxowTLiYbV+0eYPT1QCiuFJ
	 N5LVaOM5AjPiCjYJMvv0UJ+82xMperwZlaYojEZjyB/URlhNK3vtC6AtR5Ig0WSR7O
	 lpo3oS0q06uKDvaGJPcA0JZe4TC30uYtqxuDxgCxl+qGt3iWMxc7l4Bw9kTYO4/lhs
	 32YZwf0in6VpXfY5MavxnvauIzv0FtEV1NSqtvZNpUxibd0o4e0PMwjaYGLjsiepMw
	 YuKiIopgtpWFg==
Date: Wed, 25 Jun 2025 11:24:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/arm64: Prevent build warnings from
 -Wmaybe-uninitialized
Message-ID: <dd3dee5a-b030-4658-8cef-c777928368d4@sirena.org.uk>
References: <20250625020138.3777454-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uTSVuHLcUzAyoEkz"
Content-Disposition: inline
In-Reply-To: <20250625020138.3777454-1-anshuman.khandual@arm.com>
X-Cookie: He who hates vices hates mankind.


--uTSVuHLcUzAyoEkz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 03:01:38AM +0100, Anshuman Khandual wrote:

> @@ -96,7 +96,7 @@ static int write_sleep_read(void)
>  static int write_fork_read(void)
>  {
>  	pid_t newpid, waiting, oldpid;
> -	int status;
> +	int status =3D 0;
> =20
>  	set_tpidr2(getpid());
> =20

This will shut the warnings up, but it's a bit of a heavy hammer that
means that the warning can never trigger warnings for that variable
being unused.  Is it possible to fix this by updating the control flow
such that the compiler can tell that the initialisation follows the use?

--uTSVuHLcUzAyoEkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhbzl0ACgkQJNaLcl1U
h9Bc5Qf/W9ejrLs4QXMHndtRwtXhav2EyIBFrqlAGpdfTSQIyTff+wqdpaLDyMmR
ZmeGDrmoynYVNNalZNSICMSbUkLZFXSoO7J02n9wXXZTsHUaq+AOSatlg4cTRRQK
QavCYs4U6IrW3sz+31z8jLXv9RnGOCsZdLCLo7rpigfCgtVOEYdX4CyGDAkD5rus
x94lBlvq4OBAUw50U/UYZOaYMr25Ish02IHxQa1egeIS+mZE+ygBAB8mqcKa7hfs
z2Ub9sLvk/7JwfJy8wp8ADaMhpDHjbxVSx6kDOU3lsSVvL2drEQBUKee750BWDvj
2sX+mYH15Tg9qEnY64cdqqQ4WEPqhQ==
=lo/L
-----END PGP SIGNATURE-----

--uTSVuHLcUzAyoEkz--

