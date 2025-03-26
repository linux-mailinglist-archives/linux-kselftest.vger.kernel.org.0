Return-Path: <linux-kselftest+bounces-29815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42EA7170B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 14:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EBE173ACF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEA31DE3DE;
	Wed, 26 Mar 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA4zxPUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5331A0BDB;
	Wed, 26 Mar 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994178; cv=none; b=bOhIlYbcH0SJbDLoE/WgVXivuIpvwAioaj77lPTeyLtIWRoAwvTXzF0Cke9azwyN55IV6bjRE/m05DlrUOSTOgaOIbYxHx6zplAQQNnseizKulBbuFAiSvJCJNfMoD8NMEJwEuAfGZJQPfXvTsixHeMYvLnSmtaQp5R7kLGiF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994178; c=relaxed/simple;
	bh=rXIFR/R8SHfXktzrfprxQJFu2B4i2waRkFsCXkleVr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5cTZ3N00y7ZMrb6qfw/jzxjEj2tmd8ZxV1o+noM5KYIxYc2QHAVVoQEzWmaK5UR5EphusRaB8jcjogaQb2Gw9nclemZGyDApEVKvQQ1rSNcb0gM6ddjQsOL1KMjMnEb/eWFPy5KriuubK+hePVbzLaQvKTn9EIIx9IOyJ2nrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA4zxPUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298E9C4CEE2;
	Wed, 26 Mar 2025 13:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742994178;
	bh=rXIFR/R8SHfXktzrfprxQJFu2B4i2waRkFsCXkleVr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SA4zxPUOxJzl9g1Cmp/0+e2JUkdFRgNYywGxSkueu66VsIAbuB8K5Bnhmn+CEnWvz
	 WeAE2HPkmhwW2HRYhyR0+nlwxB1Zmez0MvJ67MRxA0P50WiimtWqld0eGstw2rtZJZ
	 GKSzc2cSg8h1nk/MejxVsuh15qlIngtvhIugUtrOB6c/kNpucIrGMThg5ngCFfF6dq
	 paBbr2nTLv8fT6z6jlmuNyFsaIpljulhdt/Zbx6I8Ro1MbcfmZ+LidjISgZVYotX50
	 jbypfa9kWmLphmoPZ8mXIk6zCc4QHQNb8K9XCKVP5hP5pJD1F1p4sfF1ms6ifqEXS1
	 ME6rqxgJomHgw==
Date: Wed, 26 Mar 2025 13:02:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 12/16] selftests: vDSO: parse_vdso: Use UAPI headers
 instead of libc headers
Message-ID: <c7bea938-ee3b-477e-9ed0-db29ca02a538@sirena.org.uk>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
 <af553c62-ca2f-4956-932c-dd6e3a126f58@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wNTtUR/e22jNGr//"
Content-Disposition: inline
In-Reply-To: <af553c62-ca2f-4956-932c-dd6e3a126f58@sirena.org.uk>
X-Cookie: Don't get mad, get interest.


--wNTtUR/e22jNGr//
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 01:23:47PM +0000, Mark Brown wrote:
> On Wed, Feb 26, 2025 at 12:44:51PM +0100, Thomas Wei=DFschuh wrote:
> > To allow the usage of parse_vdso.c together with a limited libc like
> > nolibc, use the kernels own elf.h and auxvec.h headers.

> The vDSO selftests currently fail build for at least arm64 in -next:

=2E..

> a bisect points at this patch, it looks like that's due to the switch to
> use TOOLS_INCLUDES but I didn't dig into the specifics.

This bug is now in mainline.  A fix was posted by Thomas the day after
the original report:

   https://lore.kernel.org/r/20250321-uapi-consistency-v1-1-439070118dc0@li=
nutronix.de

but it has apparently slipped through the cracks.

--wNTtUR/e22jNGr//
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfj+voACgkQJNaLcl1U
h9BSMwf+OsWYshguAPVfP5dQO8s2eY4aQLLauAOAK9BYf5penC9o9X79UTjc4YEL
/LYnie2aWsE4jrp8BhOvEY+OWAc80G8iwyuGi76TOEuPggmK06ql6Qb/7Giuh6Xx
MuwkE4/k4SvcGsLuQHDTvyf73Kyu4/Oagu8NSrsBLctlWOIMThNgDkF9AcF4W526
1Fe9pnkH1+xgexfieaJ0rr/FMQgHSp5+7ehXZ39lvySqknLvZi8SHZc7iX21Puj6
wJRb8qR0Qgfdh8Nnde+LYqE74V1wZrpFBT/HTY9CXCbcx8EsP55xLsgMO7RRLeFs
bCG7NmKf02mLDsa4mbDkpiRjuK4rbA==
=Dy6e
-----END PGP SIGNATURE-----

--wNTtUR/e22jNGr//--

