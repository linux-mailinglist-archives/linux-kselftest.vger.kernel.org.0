Return-Path: <linux-kselftest+bounces-23036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0BA9E968D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25EB1624BC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20B35955;
	Mon,  9 Dec 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJl7WhjD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CBF35943;
	Mon,  9 Dec 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749978; cv=none; b=ChOL6NCI/pSiGiyEQFFJON4lo87dtEjJ2to2zBYeBxkT3neVG1NohlwQefk/FNw7Lrt6QKt00HZULczDYepalCIr+4xZJ/DRK1mLGoHotpS9NQBSSk9i34EhW3FoqqSqkyABcmdCzSy5I22EUVwnydhwPJ8B6IqTkDcH+y/GCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749978; c=relaxed/simple;
	bh=wtt4YzjAc8RnxByK3Ro2ZvCNJOBCvnHq9hYtTBhLeOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbmFc0MlG3CWQjLmgGG6ik91OkSmvfeePXA7yLwr7ELYC0vUu5rhtU6qvxhwhngaqU2YjKXIEtTGKZNJEgWWyMc16u7zRxy4WMSX2uXwGtzN+Ad7irnAF6+Br5nEwhyRMsPc31a7XEELULN2tgc67ySk3RPfDp7xezRVTSwocpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJl7WhjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCCBC4CEE0;
	Mon,  9 Dec 2024 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733749977;
	bh=wtt4YzjAc8RnxByK3Ro2ZvCNJOBCvnHq9hYtTBhLeOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJl7WhjDi/BWxqxPsHlk4v4npIJnpP1x4xwpteoef21w+K7CnesovMMWnbdTyIEho
	 AfJTx8b78PjN/6tvL6nu+NrTUONSTznf841w5fTNAisJAZav0u+zlKrUTtv2nwKUIF
	 ArSJyIFziJT7mJEg7hUprwIp8X9JTX3OiQ9LM08kbJxLF0jObClNE2gyxDEQyoAAAY
	 gut6DotkQq5Ee57xa/+LUHv6l3onXN1p1BcOSgNT+z7nUI5G1bSOS/W9vQAAFeu50j
	 FBK2VWjyekwx4VtnyKXWLTLOEFPKQlw1aOMlqKU8hgZMXt0h+o9s4VvqH8xOjZvakU
	 ZFxSkDGeRN0qQ==
Date: Mon, 9 Dec 2024 13:12:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: abi: fix SVCR detection
Message-ID: <c05f6ad8-2dc1-4ddb-b9c1-b2cddfe78819@sirena.org.uk>
References: <20241209105237.10498-1-o451686892@gmail.com>
 <3279e669-1ee2-4792-9e10-8b40928de6b4@sirena.org.uk>
 <CAHk0Hov5k37=MtTBLWTj+Dwm4EXE0xGJS1Uc8xgyLtJxusqsww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vxzs0bX2niMoeW8l"
Content-Disposition: inline
In-Reply-To: <CAHk0Hov5k37=MtTBLWTj+Dwm4EXE0xGJS1Uc8xgyLtJxusqsww@mail.gmail.com>
X-Cookie: Lensmen eat Jedi for breakfast.


--vxzs0bX2niMoeW8l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 08:51:28PM +0800, Weizhao Ouyang wrote:
> On Mon, Dec 9, 2024 at 8:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > >       // Set SVCR if we're doing SME
> > > -     cbz     x1, 1f
> > >       adrp    x2, svcr_in
> > >       ldr     x2, [x2, :lo12:svcr_in]
> > > +     cbz     x1, 1f
> > >       msr     S3_3_C4_C2_2, x2

> > This is against an older verison of the code so wouldn't apply now.
> > It's not also checking the value of SVCR, this is checking the SME flag
> > the check is against x1.

> This patch aims to fix the second check (SVCR_ZA_SHIFT) instead of
> the first one (the x1 SME flag you're referring to):

If we don't have SME we should be skipping over all the SME code and
never even looking at the value of SVCR.  Looking at the current version
of the code it does that, it branches to check_sve_in if SME is not
enabled.

--vxzs0bX2niMoeW8l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdW7NQACgkQJNaLcl1U
h9Aq4Qf/Qg9p9l/NYKL8pF+MdwSLjxV0TtHVO294pRrIAlItPtbqpVocz9DV28ye
+vJfxK0cNGHLqaL1gnR/uBSmfhx37MFt8JYwuBl7+bI7THOI5B5jvM4aYQX7Ohpa
0RcrJak6NhWjaa7+Ro4GNl0Th9f6DrskXSrIkEWvuruiUfKzahUmed4WFVZM9mZK
+UnQxxZ2U7Cp+vx+ZTPGB0WcKT4W3ojoctJ0rBOmZP7/DDyX3Mz/f3R+JYyFpJNw
KaYtD6qeNsU2sRtOFDOytZ0534PeN2+rZOPJvfp7/wbW9V4C9Pz29YfbP47bUks7
2nyIY1pfoOUmkB0MwY7sb1PTnWwBnw==
=odYv
-----END PGP SIGNATURE-----

--vxzs0bX2niMoeW8l--

