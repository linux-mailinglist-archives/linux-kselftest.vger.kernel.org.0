Return-Path: <linux-kselftest+bounces-38024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D0B12CB6
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 23:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B197A4791
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 21:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4EE22129B;
	Sat, 26 Jul 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSmXsEkU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922521C160;
	Sat, 26 Jul 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753566274; cv=none; b=gIrudvQsUK3j2CieVfJ2/njw7q5XJJu8vW0B+Ap8TDXHcKoriUEliwD9sGFj82VINVFx6vpIR+E9bDJYMBbHSDVvcNkj/QA+Ke1JM1DRi4WJcD2BPMHaMHIVJ6997yP9UT3TTIHQ5Z4Qe2UShEssVNZNkpGUpvQWx6EOKMpFrgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753566274; c=relaxed/simple;
	bh=5HWLFwqXBTQ60dZq3V7io5uEommZHIlp3IPinC8aaCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSA3Mex+qQk5snlpphPtSo1eBFtxuAaaXgfsdtvRLqjECzYLKIdViN1HvtA64d0H2UxXtiS1LXv2ksz6w/BC4fUg5yRB7dtWFHmU6xqRCh0kUHwr6K7WL1XW6PFndfbxlz1l0luDcMNYbm/ClyYdV9j+T7wXSI4dhpI0aRGtvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSmXsEkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AE9C4CEED;
	Sat, 26 Jul 2025 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753566274;
	bh=5HWLFwqXBTQ60dZq3V7io5uEommZHIlp3IPinC8aaCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSmXsEkUDjluym09uhQZWivmOAMaeX2l5LHEx4RjucbdtXPuzLm26z8xa69Hryxxb
	 +sHEahu9hQ7jpC52V6FVNhGLetHi1Pl7BmO0sB+24Armm8q+OTq25WCNmVvmAMV9Cp
	 vgSMuwiJQxutTwtlApJCaqAshM7N+arEns04PQ/O4crJC64qVfj1U6Rfvgsp4vON6C
	 iQbMOQ9xyiU+Dl15afnunJ5vOH3LkDBWGRhpwgs0ldoXLPnt2//EoZKmK0bE6DGl2D
	 W0op7rfykPOES6E9NZb05YLE821VOemA2jGmQOZ6bTEGKRshPSu3jIpeUTYvfC5gXh
	 WIC/i2h5Dv1wA==
Date: Sat, 26 Jul 2025 22:44:29 +0100
From: Mark Brown <broonie@kernel.org>
To: dan.j.williams@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Donald Zickus <dzickus@redhat.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>
Subject: Re: Crediting test authors
Message-ID: <aIVMPbZcmAvG9z2o@finisterre.sirena.org.uk>
References: <20250725080023.6425488c@kernel.org>
 <6883b3046b640_134cc7100ad@dwillia2-xfh.jf.intel.com.notmuch>
 <20250725102019.7add0be0@kernel.org>
 <6883ced97d944_134cc7100fa@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lSJ5+sUpAZPI4LqF"
Content-Disposition: inline
In-Reply-To: <6883ced97d944_134cc7100fa@dwillia2-xfh.jf.intel.com.notmuch>
X-Cookie: Do not cut switchbacks.


--lSJ5+sUpAZPI4LqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:37:13AM -0700, dan.j.williams@intel.com wrote:
> Jakub Kicinski wrote:

> > So a tag would be ideal. But it's a hard nut to crack. Best I can come
> > up with would be:

> > Reproducer: test.case.path # 001122aabb (optimal) commit of the test ca=
se

> That's true, more than a few times I have had distro folks reach out to
> ask "how do I verify this backport" and end up manually pointing to the
> new unit test that backstops a fix.

> Although, from that tag I would not know where to get the commit. Maybe:
>=20
> Test: <git url>
>=20
> ...as a new Link: type?

It seems like there's some overlap here with the work that people have
been intermittently trying to do on test cataloging, eg:

   https://lore.kernel.org/workflows/CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv=
9fj=3DuS90WSnxA@mail.gmail.com/

That's been approached more from the "what tests should I run?" end of
things since it's been driven by people interested in testing and CI,
but it feels like there's a lot of overlap with the describing the
suites part of things.  It'd be a lot easier to write and read tags like
the above if we could define some more compact names than git URLs for
suites/tests.

--lSJ5+sUpAZPI4LqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiFTDwACgkQJNaLcl1U
h9BTBAf/Wg40Hu3hkEcBN+rbAsYasDqcG+2s/6NTIlhao2RdgdjqnaU6ygN0EdPN
fClkSm+JP+uOdVzcbirTiqTY5c/MulfjamZQmEphMVcFGIployqsSZhvsMsaD4xV
MBbGlEMVWgj07jiWJBWK0A2UIL2UpdbyCn3jHiNUgrbjIeYJK5R4Ni/SExj21uqW
PpDNv+0ZCfj5tTDrwHKWnK1KbB/sO393r9IdaNPLXOY6c5dXaeaYYi1aGX7M0/DG
BW8SCXsDSBZioRN16chRGav+JfiC2xec/vwrLtfhr0pHZAEWN2tz8o6iDIYj+YVH
bKTMxCMcSCqkejJLhV7H35mwFy10lQ==
=HB/M
-----END PGP SIGNATURE-----

--lSJ5+sUpAZPI4LqF--

