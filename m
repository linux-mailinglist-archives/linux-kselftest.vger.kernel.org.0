Return-Path: <linux-kselftest+bounces-30106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B265A7BEA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 16:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34F0189DDB8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BBF1E9B06;
	Fri,  4 Apr 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APkxPqi3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54479DF49
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775416; cv=none; b=ca17B33PsKeQeEKjIUhHEg5/Ke7BzLYo6kMQORHR62WMS9srFBcUH7CjJpvq0HoLwKqEWEKAhn8LhR52pR2moEGayT7INxUdK8Wy+bj1ORvAQfIsfZjqnIMsDLW/qMlghCA0Gw6hUGiG6iPoLUQzq09CaojTTSOZpO9+Iha7YwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775416; c=relaxed/simple;
	bh=m2krrZwvINrK0pItnni/rmpPyqaHkbut36a8pvf95FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXIhZSGOiipHIDPH7V5wKiOMqFIVkozKWXYEgyv60/6y4KbVgDrrHAraje4WoWfJHdsAnwmNtNlEYnbqrsg6WCOAMNce5FsIN0P9H6FTq7l6BNIUa39+SEvUjDZRXuF9AKQFB/QKRvIypvypJuANckdlBMx1B3zUnyHzsuhHrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APkxPqi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558FCC4CEDD;
	Fri,  4 Apr 2025 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743775413;
	bh=m2krrZwvINrK0pItnni/rmpPyqaHkbut36a8pvf95FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APkxPqi35bC6LYHh/Qqbw/hEiqivQQ+4lbENzFLgVWlKyk6+1uJr3PebPNpfSYYhe
	 Bv3lmdDwf9aqKpC5dTouzheF1+hfzTE417B8IMbynDAdq7PTMtj/qbExExWgohQIW9
	 nOOjt0TTeopv0ufjS7uOCw973uiHEvjrVkXsTru9nKzf+aPnEbjRcxb3OBIb+OJkKC
	 1GRFxxHDRby3gycyghEr7hCCIcYTHPFQN9Mv4gG7F3FAL38g7vo0FuB3diBcgwC84Y
	 VWBNHuj9h7ufwbe6+5HnZk4kqgMT7VGl/+yZjk5NC1neAamJ8Um0wzWVGFewpMMFlY
	 5PMjzrQbX2UmA==
Date: Fri, 4 Apr 2025 15:03:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: David Gow <davidgow@google.com>, Jakub Kicinski <kuba@kernel.org>,
	patches@opensource.cirrus.com, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
Message-ID: <2d67a9ff-9ab0-4b06-ab7a-c8190fe00717@sirena.org.uk>
References: <20250402103655.3e0c62d7@kernel.org>
 <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
 <CABVgOSmSU=i9WvUHFERY--Pgqg3Hr_LxgA9HJ_5aG4F-FgKhzA@mail.gmail.com>
 <d9d9fa47-c926-4479-a0c9-fb6c0713b244@sirena.org.uk>
 <40aae10e-184a-446f-b4fa-09935e25ee21@opensource.cirrus.com>
 <8f2de668-0ee2-4c8f-a26a-1aa77f6a0108@sirena.org.uk>
 <CABVgOSmmU4gcRL=4XPp9+CuA8bhJonv=-CXY7gdQc45LDi7Qpg@mail.gmail.com>
 <04117788-bd0e-40f0-a72e-27d821302cad@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3h1CrB1g9h+Rl16"
Content-Disposition: inline
In-Reply-To: <04117788-bd0e-40f0-a72e-27d821302cad@opensource.cirrus.com>
X-Cookie: You will soon forget this.


--j3h1CrB1g9h+Rl16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2025 at 12:10:13PM +0100, Richard Fitzgerald wrote:
> On 4/4/25 07:53, David Gow wrote:

> > - Make sure these tests don't automatically enable themselves if no
> > driver which depends on the firmware loader is enabled. (e.g. make it
> > depend on the library, rather than selecting it. If there's an extra
> > "dummy" option which force-enables it, that's fine, but that shouldn't
> > be enabled if KUNIT_ALL_TESTS is)

> I thought someone had already patched that but apparently not.
> I'm not the only person who thought "ALL_TESTS" meant "all tests", not
> "some tests". Given that ALL_TESTS is badly named and really means
> "All tests for modules that are already selected" then it should only
> build if cs_dsp is specifically selected.

The change didn't enable the drivers in the config fragement for all
tests, and TBH I suspect it's a better idea to have a specific config
option for the tests that depends on KUnit or something since the
drivers will pull in subsystems which gets to be a mess and possibly
fragile.

> However the users of cs_dsp can have a lot of dependencies that are
> entirely irrelevant to cs_dsp and so cs_dsp *could* be tested without
> those. (This also applies to other Cirrus KUnit tests.) I started on
> some patches to make the Kconfig for the tested libraries visible if
> CONFIG_KUNIT is enabled so that they can be selected for testing without
> the need to enable a large bunch of other frameworks just to be able to
> enable a user of the library. They are somewhere in my to-do pile.

Yeah, I think that's the most sensible thing for coverage.

> Related to this I created a UM kunit.py config specifically to run all
> Cirrus KUnit tests with minimum other clutter. But does that mean nobody
> outside Cirrus will run it? Or is there a process somewhere that runs
> kunit.py on all configs in tools/testing/kunit/configs ?

I'm not aware of anything.  I'm running --alltests (on virtual hardware
rather than um due to the environment where things get run).

> > - As a result, make them more explicitly enabled with --alltests, and
> > probably disabled -- or only run a subset -- in the default. Currently
> > this is mostly decided by whether CONFIG_REGMAP is enabled, having a
> > specific item to use for these tests would be less surprising.
> > - If any of the individual tests are particularly slow (more than a
> > ~second or so on fast hardware), mark them as slow. Most people still
> > enable slow tests, so they'll still get run most of the time, but they
> > can be skipped on old m68k machines, or gated behind the quick tests
> > passing in CI systems, etc)

> I don't expect any individual test cases are slow (I'll check through).
> One of the advantages of parameterizing them was that it avoids one
> single test case taking a long time looping through a lot of testing.
> They should be a quick write-read-check-exit. "Slowness" is tricky to
> judge. The slowest hardware I have is an ARM7 clocked at a few hundred
> MHz, or use QEMU in full emulation.

On the scale of KUnit tests there's quite a few that are noticable, it's
just a second or two per test but even in qemu the tests are usually
ticking by faster than can be read.

--j3h1CrB1g9h+Rl16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfv5rAACgkQJNaLcl1U
h9Ag4gf+OXdTmYND0TG75cQobZU3IYjwb+U+hvUQmp0DuVU7flovo40V2VdYVRV7
yoxlzzG1JJOnZSkcGKwlbnQkfR4qxoRXX3AlwxsuvP2ysw/supIeUNuf0AegT2gT
pYpQD39IlKtVd4DLIftSOWm8NIll9OQKrGB6KRLFoiNXEgCudOl0puZL5uT1+5TA
+q9ZHpLfuUxcY1wPXuBmzpADHysEbWATmWW5sLR+tR4/ALAfnjOjTMzDYZaDZSkb
kxsooKTXqRlhU38N6XbpoEbpHh/l2iZpE33YuFqdoC9dKMON1BkBe0AIXKsDsq5J
fdijsaC7CamqNlKFlZz9B5KB/+N6Cg==
=dEiS
-----END PGP SIGNATURE-----

--j3h1CrB1g9h+Rl16--

