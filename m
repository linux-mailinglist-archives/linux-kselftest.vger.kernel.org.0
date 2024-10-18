Return-Path: <linux-kselftest+bounces-20178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F909A48AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 23:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F881C21CD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5918DF94;
	Fri, 18 Oct 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lESD7k/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA98113541B;
	Fri, 18 Oct 2024 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285547; cv=none; b=qgZz6v16sPzPiTOdrH9EDS0XhuvlHG9P2ZstbrwN0aOMg0qa1hvQWvwtADpqsD/fvAEf4U1MPI1cI7T8TIsKpmSTearHZeesYsA17AUxQXEjQ8cMZmwZ8nH4X2k5RK8n+132iATblunq8w4IsAYMk9nCTFHZsxz7e3QO6h7JDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285547; c=relaxed/simple;
	bh=6TEWzcQk/Ii5egWgylmELYefpSW63zGGTg/MZlxt0lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok9ov7Bv344k4TYB8aS14N6jS3a8s0pvGCCPNaJbGcYGQLj4tTa24EOyuNEkKBcCcYmsNBxbiEwgDB59CVgsRThB1t+/Q4oGkhOrDazuG8K3raZ91GuOy9LWmYJYPRTYfBUm0U6lsTmX37bND6HR6eb2HrFu50/TmY2pHuc5Qks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lESD7k/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98DBC4CEC3;
	Fri, 18 Oct 2024 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729285547;
	bh=6TEWzcQk/Ii5egWgylmELYefpSW63zGGTg/MZlxt0lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lESD7k/1n/H8rLy75a1X8n9tbQ71YyNXhtnUranFCepf+vZkmj/54oFFAz5bHsMG+
	 ZH5lIfO6G4TjsBoNHkZF6KUW8kaSybcfBBNruAG1yrjmL+UE202vPaq5WiVS7cXdoT
	 4B9dEmQdiWx2baCnS9Mg10ZbHl88cTRuF0yoyeHjYpBp6KGk5NRM0kU0NKad2hINBW
	 pzdo0D4+ec6+XTu0DDDNOr6H1YtGKO9J6OMslRGi86eAEwl9PGdoUrybx1lpU0syXk
	 6ASdMIKJZAoQcoqYzqEMtvIhV3SkElNZQeV7CUHCooWFRVns7suw2SidBfAkgp2alm
	 nciSrX9hGN+vQ==
Date: Fri, 18 Oct 2024 22:05:41 +0100
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
Message-ID: <6aefd38b-d758-4e7c-a910-254251c2a294@sirena.org.uk>
References: <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
 <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk>
 <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
 <a2652ed4-ea8b-4b56-bac6-6479b3df6c14@sirena.org.uk>
 <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BIKQqdtpthE9HG51"
Content-Disposition: inline
In-Reply-To: <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
X-Cookie: What is the sound of one hand clapping?


--BIKQqdtpthE9HG51
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 12:32:37PM -0700, Jeff Xu wrote:
> On Fri, Oct 18, 2024 at 11:37=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:
> > On Fri, Oct 18, 2024 at 11:06:20AM -0700, Jeff Xu wrote:

> > Test 106 here is called "test_munmap_free_multiple_ranges_with_split:
> > line:2573" which automated systems aren't going to be able to associate
> > with the passing "test_munmap_free_multiple_ranges_with_split", nor with
> > any failures that occur on any other lines in the function.

> I see. That will happen when those tests are modified and line number
> changes. I could see reasoning for this argument, especially when
> those tests are flaky and get updated often.

> In practice, I hope any of those kernel self-test failures should get
> fixed immediately, or even better, run before dev submitting the patch
> that affects the mm area.

That's not the entire issue - it is also a problem that the test name
is not the same between passes and failures so automated systems can't
associate the failures with the passes.  When a test starts failing they
will see the passing test disappear and a new test appear that has never
worked.  This will mean that for example if they have bisection support
or UI for showing when a test started regressing those won't work.  The
test name needs to be stable, diagnostics identifying why or where it
failed should be separate prints.

Actually, prompted by the comments below about test variants I've now
run the test and see that what's in -next is also broken in that it's
running a lot of the tests twice with sealing enabled or disabled but
not including this in the reported test name resulting in most of the
tests reporting like this:

   ok 11 test_seal_mprotect
   ok 12 test_seal_mprotect

which is also going to confuse automated systems, they have a hard time
working out which instance is which (generally the test numbers get
ignored between runs as they're not at all stable).  The test names need
to roll in the parameterisation:

   ok 11 test_seal_mprotect seal=3Dtrue
   ok 12 test_seal_mprotect seal=3Dfalse

(or something, the specific format doesn't matter so long as the names
are both stable and distinct).

> Having line number does help dev to go to error directly, and I'm not
> against filling in the "action" field, but you might also agree with
> me, finding unique text for each error would require some decent
> amount of time, especially for large tests such as mseal_test.

In these situations if it's a typical Unix API function setting errno
that failed I tend to end up writing diagnostics like:
=09
	ksft_perror("open()")

possibly with some of the arguments included as well, or something
equivalently basic for other kinds of error.  This is fairly mindless so
quick and easy to do and more robust against line number slips if you're
not looking at exactly the same version of the code, sometimes it's even
enough you don't even need to look at the test to understand why it's
upset.

> > Honestly this just sounds and looks like kselftest_harness.h, it's
> > ASSERT_ and EXPECT_ macros sound exactly like what you're looking for
> > for asserts.  The main gotchas with it are that it's not particularly

> OK, I didn't know that ASSERT_ and EXPECT_ were part of the test fixture.

> If I  switch to test_fixture, e,g, using TEST(test_name)

> how do I pass the "seal" flag to it ?
> e.g. how do I run the same test twice, first seal =3D true, and second se=
al=3Dfalse.

>         test_seal_mmap_shrink(false);
>         test_seal_mmap_shrink(true);

That looks like fixture variants to me, using those with
kselftest_harness.h will also fix the problem with duplicate test names
being used since it generates different names for each instance of the
test.  Something like:

FIXTURE(with_seal)
{
};

FIXTURE_VARIANT(with_seal)
{
	bool seal;
};

FIXTURE_VARIANT_ADD(with_seal, yes)
{
	.seal =3D true,
};

FIXTURE_VARIANT_ADD(with_seal, no)
{
	.seal =3D false,
};

FIXTURE_SETUP(with_seal)
{
}

FIXTURE_TEARDOWN(with_seal)
{
}

then a bunch of tests using that fixture:

TEST_F(with_seal, test_seal_mmap_shrink)
{
	if (variant->seal) {
		/* setup sealing */
	}

	...
}

TEST_F(with_seal, test_seal_mprotect)
{
	if (variant->seal) {
		/* setup sealing */
	}

	...
}

You don't need to actually set up anything in your fixture, but you do
need to have setup and teardown functions so the framework can emit
required boilerplate.  The gcs-locking.c test I recently added in -next=20
is an example of a similar thing where we just need the variants,
there's no actual fixture.

--BIKQqdtpthE9HG51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcSzaQACgkQJNaLcl1U
h9AB9wf/T8iHWb/5rF1+cR1qJwESbckaccw/2Uq7G5bAg8rSmYL4EfDwQ0gT2wiC
tgkchnn6bmLYnSsfESWOWDU0Eme/rSzdpFR4iz3nr5vT8kq6KE8DfQmrXihnzc5V
8B3NRbhQoU52gPREYVjWp7vsQKButoN3ipniO5E4fdtdf5R/wT0tEqqTU/ViwlSE
2Ls8L39I31D6/HDrCY1mHqXvJcyuXmOrHaEU5m+hTyb3gn7L+O/FMos0y4O4h915
RmISRBJDDKVyxGGiz4FPHCk4pv/mPiwC58ZT1WCX7fg76dzYUg+fIZ28NqCPb4rJ
VEKp0xTaZHZuIHbKr2uNLxfdwdkNLw==
=mikf
-----END PGP SIGNATURE-----

--BIKQqdtpthE9HG51--

