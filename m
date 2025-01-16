Return-Path: <linux-kselftest+bounces-24653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B053A13CBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 15:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4AA1883FBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC2C22BAC1;
	Thu, 16 Jan 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPq0J5sS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3622BAAD;
	Thu, 16 Jan 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038907; cv=none; b=Jc6umv4lTmjZ8motg/aubJOsRh+J3LPTO9UGvFGGEayvvEMvg3I/jUKxuR15532YFODTb5eaeIPj/0q+RsZE7w0dmWuij9nvs97Yn33P5IL2uQNEmiLLN/pZ3eJilxF8abhUfesqkkSIX6Y/S04WUO0SnAbp1i4BXNhnSyrrPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038907; c=relaxed/simple;
	bh=4hMIJWoOuK4Lnv8RIEfuAquF3f1fyGo7d87DA83B4Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAouWZcsg0ji5dZgFFkGGZ1PXFItr/7798Ptf/melAf/HbliBZFzIxvmsuS24q+v+ZDyDPiMoP8Mt0ccd7pOHSli8GA6JDs5LyxQTM8pA6FzKVWRsVgl4HGjflnYVT4UF5QHyG0A2RANuaib67HJLg4TDV4V2lUekiFtamK3B3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPq0J5sS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD03C4CEE2;
	Thu, 16 Jan 2025 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038906;
	bh=4hMIJWoOuK4Lnv8RIEfuAquF3f1fyGo7d87DA83B4Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPq0J5sST3mb/cDch4Pj6SuIAWuBtlCQiay9fDj3ljIgfDFslW6s/nT8ZjjOcTS1t
	 UDHGaCf/UY3T9U/bcLQjyGpdlWo5fuz+z9iExBmclT+XV2ZYVZqy9ZVXkQI4JkBHkD
	 0YLZyHQ9vnxjGScqMFgsIcfMhw/qC5Nh0MlwqER2JplHNo3Uwecr3LeBnUdKlZJDc+
	 316cPa3zqC4gV6FqDAUuG26/4rL5w055tJ0sHKnOAR4TlagkYUUa0Y70HupXUdNuhE
	 c67yIHw2shMm+ZDYftrspa/TrKDLp9qeifYEBt0PmDiR6a6pZjzsaMrowm5Wn0WZLu
	 nEngm52TIaTfQ==
Date: Thu, 16 Jan 2025 14:48:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>,
	Boyan Karatotev <boyan.karatotev@arm.com>
Subject: Re: selftests: arm64: pac.c:237:pac_instructions_not_nop:Expected 0
 (0) != keyia (35747322042253312)
Message-ID: <27c34621-f206-44ac-a917-4c1a89d056b1@sirena.org.uk>
References: <CA+G9fYtDLPwpiH++b_RVnMrHX3trFt-fY06UnV1Q5oSE6Nrsrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1j09/7wkT0/4WniG"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtDLPwpiH++b_RVnMrHX3trFt-fY06UnV1Q5oSE6Nrsrg@mail.gmail.com>
X-Cookie: optimist, n:


--1j09/7wkT0/4WniG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 07:56:15PM +0530, Naresh Kamboju wrote:
> The selftests: arm64: pac getting failed on FVP, Graviton-vm and Qemu-arm=
64
> running Linux next-20250113..next-20250116.
>=20
> Started noticing from next-20250113.
> Bad: next-20250110
> Bad: next-20250113

I reported this the other day, it looka like it's a framework bug:

   https://lore.kernel.org/r/d9c290e2-f22d-41be-aa68-2aebd3eb1a67@sirena.or=
g.uk

If it's not sorted in the framework we should be able to bodge it in the
PAC test.

--1j09/7wkT0/4WniG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeJHDUACgkQJNaLcl1U
h9DPLwf/dPs+IKSklWUGx0NNHmmcYSRDsLXQztZe70mjWfTIQMkFM+H5zH6iLrjs
sqaDVwmg0VUygQIlM2Qi4QaPQlEU6IazQF+OzuuCz+NAaVp7KdJ8IgXwiAAibOAq
pFgGCkPGr8H20r8BY+lxhdSEsBB0pVcbPPfkq8By0jPh//hERhrDYfVXfT+BPeaV
FDKHWN3+ajYEse5W5hfbbIX28JtPEBkU08bSlbO7GaQVMr8U8Y+amKARt8UsqYRc
K9stczFWZugSG+aEuEXBrf7vusWGVK5eH6AW2+T7xtkgNBqH0WIghuLvx7EJJ+Hy
ZNLLk1/ZAA/PRvNvIpoj/lmEXxAIbQ==
=cqZg
-----END PGP SIGNATURE-----

--1j09/7wkT0/4WniG--

