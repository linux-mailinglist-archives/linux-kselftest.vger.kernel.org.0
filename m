Return-Path: <linux-kselftest+bounces-20167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7876E9A45FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 20:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C391C212CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A12038C8;
	Fri, 18 Oct 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmF0Fi3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4120E312;
	Fri, 18 Oct 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276648; cv=none; b=cRZDcFTPjdQ5xws8AYL3i8ZVlMn4gG/bsJVp1UuJoLo+iffylxc/pDmHxEq6UtEObmhiY8LhPEMWNsyZCRcd66PKUM67XYuie378kCuZJ2aHypiZpdWRZ/iSB8yfLR3R3x6cjxLv1fbgZgjdQZtwQEdiMcP9SMnkhCMq22A1Bo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276648; c=relaxed/simple;
	bh=dSqi9IfAa5l3jYcAxFqh5y6voNSnsY/4yK4Ky+osyzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSMwehQuuKtg/pCUcD1S8FKio7mUomM4mVJmocj5ifnQ9D4ftk+iydByaM6QSY+b8vv8kycGpwI5dzQmMAosvhSYe9/pHX1OnwaNrVWe2smNQTl4TAn/Im10CSJIgkOyr3EWry0y5DSTXeX92CHNzvMAx5qkhGVat29lfTzlaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmF0Fi3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D6FC4CEC3;
	Fri, 18 Oct 2024 18:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729276648;
	bh=dSqi9IfAa5l3jYcAxFqh5y6voNSnsY/4yK4Ky+osyzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmF0Fi3mLpV6GjbQaCRA6EA3/hmTHOuYNb0OlV7FM0aKT1stkxnb+6quUky7+IjhV
	 L6o+NKUWoPLD0kfZrKO5Nb0eGG8/hecQqI500alUD6JS5TbiEX+cUIVFI690ETpBfr
	 aSuR3sl03MMg5zFMW1AVohkqFFSrBrTDvdxUq+P5TWeIaX4iXhjZI0rWojBZSlTWN0
	 D3tPgPmiXLxe7D8jCX6zsKKNtZg4G4AB6S+35NwFNVl4CNDHes91AISvxq1JAoQibD
	 QBJl6sB+AlhRRTSEt3HTSH9Ldg2wQPdCNiEi91k5J1rNQEX29k3ixX7+dbWr9Ty8Du
	 ijJKjWIrDr72A==
Date: Fri, 18 Oct 2024 19:37:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
	willy@infradead.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
	rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <a2652ed4-ea8b-4b56-bac6-6479b3df6c14@sirena.org.uk>
References: <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
 <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
 <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk>
 <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P9lxhlovMTxuF4jF"
Content-Disposition: inline
In-Reply-To: <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
X-Cookie: What is the sound of one hand clapping?


--P9lxhlovMTxuF4jF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:06:20AM -0700, Jeff Xu wrote:
> On Fri, Oct 18, 2024 at 6:04=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > The problem is that the macro name is confusing and not terribly
> > consistent with how the rest of the selftests work.  The standard
> > kselftest result reporting is

> >         ksft_test_result(bool result, char *name_format, ...);
> >
> > so the result of the test is a boolean flag which is passed in.  This
> > macro on the other hand sounds like a double negative so you have to
> > stop and think what the logic is, and it's not seen anywhere else so
> > nobody is going to be familiar with it.  The main thing this is doing is
> > burying a return statement in there, that's a bit surprising too.

> Thanks for explaining the problem, naming is hard. Do you have a
> suggestion on a better naming?

Honestly I'd probably deal with this by refactoring such that the macro
isn't needed and the tests follow a pattern more like:

	if (ret !=3D 0) {
		ksft_print_msg("$ACTION failed with %d\n", ret);
		return false;
	}

when they encouter a failure, the pattern I sketched in my earlier
message, or switch to kselftest_harness.h (like I say I don't know if
the fork()ing is an issue for these tests).  If I had to have a macro
it'd probably be something like mseal_assert().

> > I'll also note that these macros are resulting in broken kselftest
> > output, the name for a test has to be stable for automated systems to be
> > able to associate test results between runs but these print

=2E...

> > which includes the line number of the test in the name which is an
> > obvious problem, automated systems won't be able to tell that any two
> > failures are related to each other never mind the passing test.  We
> > should report why things failed but it's better to do that with a
> > ksft_print_msg(), ideally one that's directly readable rather than
> > requiring someone to go into the source code and look it up.

> I don't know what  the issue you described is ? Are you saying that we
> are missing line numbers ? it is not. here is the sample of output:

No, I'm saying that having the line numbers is a problem.

> Failure in the second test case from last:

> ok 105 test_munmap_free_multiple_ranges
> not ok 106 test_munmap_free_multiple_ranges_with_split: line:2573
> ok 107 test_munmap_free_multiple_ranges_with_split

Test 106 here is called "test_munmap_free_multiple_ranges_with_split:
line:2573" which automated systems aren't going to be able to associate
with the passing "test_munmap_free_multiple_ranges_with_split", nor with
any failures that occur on any other lines in the function.

> I would image the needs of something similar to FAIL_TEST_IF_FALSE is
> common in selftest writing:

> 1> lightweight enough so dev can pick up quickly and adapt to existing
> tests, instead of rewriting everything from scratch.
> 2> assert like syntax
> 3> fail the current test case, but continue running the next test case
> 4> take care of reporting test failures.

Honestly this just sounds and looks like kselftest_harness.h, it's
ASSERT_ and EXPECT_ macros sound exactly like what you're looking for
for asserts.  The main gotchas with it are that it's not particularly
elegant for test cases which need to enumerate system features (which I
don't think is the case for mseal()?) and that it runs each test case in
a fork()ed child which can be inconvenient for some tests.  The use of
fork() is because that make the overall test program much more robust
against breakage in individual tests and allows things like per test
timeouts.

--P9lxhlovMTxuF4jF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcSquEACgkQJNaLcl1U
h9Co7Qf+IFX02DfWKnGFQmrXx/BU2tcsHpr6ALzD+Pf5eVjuzGXP2trUWphjlykz
xQ1iS/lr0f+4xBGnAVbjryUNyIyPqPJ1an4APNVoEBIb0H4PY6i5vQglTj4qxvVL
8RUQx3bMWMrfok1duAFTMm/Kpl94uPCH5TYTdvdM2iwrQnOqCsKDnSUItG+n9jVh
GnArZl82biCNbQfGUdB01rMmMohltm7xfOiu2ZGzT3H+yPf3WXsP0epX12oLOP6j
13gOBbpJmARrQRdV14gUNl9WoRjblWTYGsjdVEL/m1eV+NC6Zq8QeSfs8MAiEU2v
dvqGHf0ov9NhgPPLYl3TcjEhGRl7xw==
=O77y
-----END PGP SIGNATURE-----

--P9lxhlovMTxuF4jF--

