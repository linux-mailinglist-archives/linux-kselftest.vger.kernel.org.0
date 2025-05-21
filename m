Return-Path: <linux-kselftest+bounces-33465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24CABF6DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B733AFB92
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF5A1537C6;
	Wed, 21 May 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMxNZFK/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFF86331;
	Wed, 21 May 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835901; cv=none; b=Q/psWx86sRo2EvVI6rYDnzakElR/60zfuyCeCsjuyPZqTbCD49qKia9/dAHb1VSF1kgp6tAZ1ITB2lOkwHjNkeydA7gMRH3sNcH2Nbudzu8M1WLarQijAzLEPhN9PUc5dX6//Wsc+bcPiXm5GWQ2Ylr2rmRj9V6tpEkEph5/alw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835901; c=relaxed/simple;
	bh=TV5Um3wEwSm9Yw2CbWgV1hqPi3iVOdmeNBmDMsMJJus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSeF2URdAEdWQANI1vNMYdFu1meSiKS1GDL+3Gwvm9mSFqUbjLv75pAI+Hh5p+TS5q7NtTCC/T34a+m5/gOm/xv4AiCBOjjFwrf0JF9lWSGbQ2rOOKTnh/5Kds+vtMjI3eXwsP/aPFxr1GaQH95NL9u56Gz2PayUMtF6VsnVM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMxNZFK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E2EC4CEE4;
	Wed, 21 May 2025 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747835900;
	bh=TV5Um3wEwSm9Yw2CbWgV1hqPi3iVOdmeNBmDMsMJJus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMxNZFK/lgC4ZaEQYoSnJ5VGx6lIKQCL0sODzOUx5mwG4ZPRe5i/T8aw8Nq06ZHQb
	 9b4Xdw3EV2a2gE0zwB9Xmgqv+lIIEf4Qi46mntSlWQTNNIxqPzhp9djxkXftPNE9Vm
	 J6k2ZqM+dofAr3L6hoBk5tJk8zt5+f/Fom/HogY3ngdlxV1PAXLXS5JCre12D9p+Hu
	 vNGSYqzy/hMa6Uz7O3TW36/H/OSFr5C3MZYYAK7r8aKY1gl8i2U8fEqvQ6gM7SALhM
	 YQNL3z8rlMgv0E5rd7f+Hw+ZLVAVGWb4S5E6RN6LyysgrWxA0o6onC6W8swidmOaov
	 xSwn+Ig7M1T9g==
Date: Wed, 21 May 2025 14:58:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/9] tools/nolibc: move ioctl() to sys/ioctl.h
Message-ID: <5ca9d57f-b711-4929-89ca-79e6966bf3be@sirena.org.uk>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
 <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
 <eda3af4a-8dfe-4f82-a934-2d0256b754e2@sirena.org.uk>
 <89bb5a3e-dd6c-475d-9c5d-0bd1595be735@t-8ch.de>
 <744a1aa8-1efc-4c20-b45e-070fc038f6e8@sirena.org.uk>
 <198bf1a8-98d0-4693-a4cf-234cad728c9b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o1EjMuOZVPaPj0Gi"
Content-Disposition: inline
In-Reply-To: <198bf1a8-98d0-4693-a4cf-234cad728c9b@t-8ch.de>
X-Cookie: 42


--o1EjMuOZVPaPj0Gi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 03:45:42PM +0200, Thomas Wei=DFschuh wrote:
> On 2025-05-21 14:22:30+0100, Mark Brown wrote:

> > Ah, you expect what's currently there to work - good.  I noticed that
> > the vDSO tests had a -I for the nolibc directory which made me think it
> > was expected that it be there, it's the only user on most arches.

> The -I is useful to compile applications without guarding the system
> includes with #ifndef NOLIBC.

These tests are all nolibc specific and so don't reference the system
headers, the whole point is to not use a real libc.

> What do I have to do to cross-compile these selftests?
> I get various compiler errors.

Any specific errors?  It's just a standard selftest build, eg:

   make -C tools/testing/selftests LLVM=3D1 ARCH=3Darm64 TARGETS=3Darm64

Unless you've got very current userspace headers you'll probably need
a headers_install too (that's generally needed for the selftests).

--o1EjMuOZVPaPj0Gi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgt2/cACgkQJNaLcl1U
h9ARDwf7BozdrB4Bcr6jM/YF1p6VqVRrJ0CeeWvtqJRfjrYx1kAx8w2sVJXMrHhb
yq0/tQ5Nbms6IAM4evFvplCaqGsxSkjc3rsruqHstlyzQKzGRqEjrqAa9gnuWdHF
ubgamRun3Ff0/xjVppOSdU8oxMPECjlLfQWgc4MDYNzyg0/B9ALeIOAsb3mjYk1U
LirAWbSvbWzMqi8lL9gOwFtUyQn0j2+xhYN0pMuAt+g09tFc1+B6j8aPJq/pGbkk
eko4YyzFx9eB18yUl4NWuv48oUZ46dMokY5K/lBFVo774BYHjFf4SRgATZ+mPkPw
/BiHFCRIYPs+abzjfSbP6VZpw04SxA==
=zzfQ
-----END PGP SIGNATURE-----

--o1EjMuOZVPaPj0Gi--

