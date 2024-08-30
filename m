Return-Path: <linux-kselftest+bounces-16811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE39665E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4AE1F21ED6
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA6A199FB1;
	Fri, 30 Aug 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkmA583+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7C1C687;
	Fri, 30 Aug 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032542; cv=none; b=KjPFrsiMYImASA7d16088ovN4iE8eBn+9ed1p5gvYIOaMQ1MyOfcwlFyhZyHEm6eFnBQz208nh8Mgoh/AVUwDfkgIM4UpMTdYA6+VIl8O3sCg4jNHqhahhzNWm+B9ziDK1MUpKVfLHaP784Rq3tyjM5jy5ufs4dJvLYjciRSUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032542; c=relaxed/simple;
	bh=B+JC3Wa/3NXOo2avTnpkyyOiXQZf9EB16IuzdnQVH9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh77RaRehbuOTYtKeR/v0EC3oVlApquEk8RYj9M5zEzZCzY8m8OmcBxMTNeWHEx8BStMX691fUuBZn38ve3gip+DnKHyrN0cO8O0UTiAuiufEoyyVnptpghEUmM5IXiml3oO0Wm7awyyiNBvGB8E3LJrvuASMzaihG6KMcXcWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkmA583+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EACC4CEC2;
	Fri, 30 Aug 2024 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725032541;
	bh=B+JC3Wa/3NXOo2avTnpkyyOiXQZf9EB16IuzdnQVH9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lkmA583+DfYwcV+Gsw+C3ldKhvpaPG2aQJf6clGH89Q/mQ4cwYkr6WR4H1G0NIXpO
	 LYAOyK9ASQ2iK6vIZRZN6I7z2oXQTWN4ALpAHqqGS+/RDJR74dWEssta//FZ5sSxXp
	 3OTpL7LgdlAY+rQ/zACdrGnkuZjB2WA8Wp65JR5ckcY+ChRfSl1ZMoegdSxGvnbCjz
	 BLeS6Bbk6VEItZviUQuQOjTqC+91iMoinqcghB/HOU3p+2oxkwn4FqEgeom8W26W+j
	 6JI6iwLjwqB3x036HW2FvR5cM9RiySXXFfQ+msPoUV38X+qnyTHsrzeVrh7eNMPSxp
	 j4RhIT0rk7weA==
Date: Fri, 30 Aug 2024 16:42:17 +0100
From: Mark Brown <broonie@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/vDSO: Fix cross build for the random tests
Message-ID: <caca9716-9429-47c2-ab9c-38eda4459c79@sirena.org.uk>
References: <20240830-vdso-chacha-build-v1-1-78f93d2a142f@kernel.org>
 <ZtHlf1qaXTPwJQkJ@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KNaMRjgsUK/AAKeY"
Content-Disposition: inline
In-Reply-To: <ZtHlf1qaXTPwJQkJ@zx2c4.com>
X-Cookie: for ARTIFICIAL FLAVORING!!


--KNaMRjgsUK/AAKeY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2024 at 05:30:07PM +0200, Jason A. Donenfeld wrote:
> On Fri, Aug 30, 2024 at 03:06:35PM +0100, Mark Brown wrote:

> > The x86_64 build is still broken for me because nothing installs
> > tools/arch/x86_64/vdso/vgetrandom-chacha.S (I beleive it's supposed to
> > be copied from ./arch/x86/entry/vdso/vgetrandom-chacha.S but I don't see
> > how?) but this at least fixes all the other architectures.

> There should be a symlink installed for that. Are you using this tree?

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git

> That's where all these fixups are going for 6.12. (And yea, there are a
> lot.)

I was using -next, hopefully it's getting merged in there (I see the
master branch is included).  This is also breaking in for example
kernelci:

https://storage.kernelci.org/next/master/next-20240830/x86_64/x86_64_defconfig/gcc-12/logs/kselftest.log

in the same way.

--KNaMRjgsUK/AAKeY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbR6FgACgkQJNaLcl1U
h9BebAf/SmkSCIhbKnTdlKMkVARVk0PXl74ajZ+95ZyM4fIEAx61p+1Q1yzJPflP
XCu0bs8VNOVLN/AtjRotIJkdG2xKSuRE1B7F7j2dA4vWWB7Cf0GV4f+0MDozr7NS
mEA2FxuLaqsZUQsrI8yOtX7Y85a61ZJWCVvHGaDtXr+Wt5E1Aap5omtAz0KARPU8
uA/b0mnvuF0CvehpGuOsbTDpvcFFZ03jseQI3+8ubcVk80nc18NxGbU+W2fUGuRG
12JegAVffLnbBIwOSxKY8pWRRfaVWGeC/r3iGCdWP639IrpJZ6tQ35PwHkibFi1t
3HNENIxZTpl503ErBt2g3DYDeQBp8g==
=eNJ9
-----END PGP SIGNATURE-----

--KNaMRjgsUK/AAKeY--

