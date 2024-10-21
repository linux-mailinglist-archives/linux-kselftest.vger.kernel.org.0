Return-Path: <linux-kselftest+bounces-20274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34AF9A6D74
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6531C222A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB22B1FA265;
	Mon, 21 Oct 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0Ii4OXY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964041F8936;
	Mon, 21 Oct 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522771; cv=none; b=CVGtYqmKzhvKarWAgJjDXsat0kNFFJl8gek/1fV8yEcR575HySReBBtoPwBfU7+InPe0lQJ++LkezcxjcfBaHzA5XgRL9AyfBe8u7Sd6jL1OtE6wAfTn8lL59QkNi03uYpFsAU1Ak+shKEjuALveTZUyxQ2LD091h+XDaO+Wjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522771; c=relaxed/simple;
	bh=albO36l24SFKiOm+yXAcpi7rfrjp7joQOfomUwb920c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQuo/hpgii05BMOKQ5dp/KaXJIpW0aiSIDerlsEnucRVSGbbiXQsSrRTbIb0soXI38nqHSKK9wlj+wao94nGS1vDtmtxHP7HKTxeAgaDCbKFm7mnbwqe7eOhvGaXrFU8kNgAMZVKrqw1LfPPclefrvC01pExdG28mTu1PRRqUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0Ii4OXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C477C4CEC3;
	Mon, 21 Oct 2024 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729522771;
	bh=albO36l24SFKiOm+yXAcpi7rfrjp7joQOfomUwb920c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0Ii4OXYK3I8yRGtboVVVGKd4BxaOPScyZm4KX4qupSOZnr+P2JZB8hZNEDc4nNI7
	 o5nH/bTrY0jxuNWE/J3FFUlQNEK90VBzMbmBTQRIbfv/QdqNZtVaVzMbCpmw6EOUep
	 kDGDUBSzKPgy3qFwVoqEUXWhqQowew3les07r5VJZ2t3gpBxtnZ4ZmCcMUxVS+3061
	 Qplyp9jHTIzNkdeLGJcRMP50OhEW09UBMelDCid0Xe7DpPu7x7ordT5W0xd5LXcBcD
	 PPdmLNgPN/peOctn3WZJeaUC889Sy7qu/V9zHL0bW+rYtw4LMT0vP30yjKbsB4Rp/S
	 V67SXlF4POitA==
Date: Mon, 21 Oct 2024 15:59:25 +0100
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
Message-ID: <a7b8f7a4-4202-489e-badf-6ef50463745e@sirena.org.uk>
References: <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
 <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk>
 <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
 <a2652ed4-ea8b-4b56-bac6-6479b3df6c14@sirena.org.uk>
 <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
 <6aefd38b-d758-4e7c-a910-254251c2a294@sirena.org.uk>
 <CABi2SkUG8bhKQeHd_pvLw4y3ZY+Z8CvxZ_iV4YhTc+JQqe9TxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vh7jJ4clxa55i2K"
Content-Disposition: inline
In-Reply-To: <CABi2SkUG8bhKQeHd_pvLw4y3ZY+Z8CvxZ_iV4YhTc+JQqe9TxA@mail.gmail.com>
X-Cookie: Most people prefer certainty to truth.


--2vh7jJ4clxa55i2K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 05:10:01PM -0700, Jeff Xu wrote:
> On Fri, Oct 18, 2024 at 2:05=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > That's not the entire issue - it is also a problem that the test name
> > is not the same between passes and failures so automated systems can't
> > associate the failures with the passes.

> I failed to understand this part.
> Maybe you meant the failing logging  is not the same across the
> multiple versions of test code, by testname you meant "failing
> logging"

Tests are identified by the string given in the line reporting their
result, that's not *really* a log message but rather a test name.  The
strings for a given test need to be the same between different runs of
the test program for tooling to be able to see that it's the same test.

> >When a test starts failing they
> > will see the passing test disappear and a new test appears that has nev=
er
> > worked.
>  > This will mean that for example if they have bisection support
> > or UI for showing when a test started regressing those won't work.  The
> > test name needs to be stable, diagnostics identifying why or where it
> > failed should be separate prints.

> If the test hasn't been changed for a while,  and start failing. Then

Well, you'd hope that the tests never start failing but yet we still
have tests and keep running them. =20

> it is quite easy to run the same test on recent code changes. I think
> you might agree with me on this. The only thing that bisec needs to
> check is if the entire tests are failing or not.

Unfortunately we're not in a position where people can reliably assume
that every test program will always work everywhere so people work on
individual tests, and it's certainly useful for UIs to be able to give
an overview of what specifically failed.  A bunch of that is tests that
just don't implement feature detection/skipping properly.

> I haven't used the biset functionality, so I'm not sure how it works
> exactly, e.g. when it runs on the old version of kernel, does it use
> the test binary from the old kernel ? or the test binary provided by
> dev ?

That's up to whoever is doing the testing, but I think most people run
the selftests from the version of the code they're testing.  Some of the
subsystems aren't very enthusiastic about supporting running on older
kernels.

> > > how do I pass the "seal" flag to it ?
> > > e.g. how do I run the same test twice, first seal =3D true, and secon=
d seal=3Dfalse.
> >
> > >         test_seal_mmap_shrink(false);
> > >         test_seal_mmap_shrink(true);

> > That looks like fixture variants to me, using those with
> > kselftest_harness.h will also fix the problem with duplicate test names
> > being used since it generates different names for each instance of the
> > test.  Something like:

> Thanks! This is really helpful, I think the existing mseal_test can be
> quickly converted using this example.

Great!

> (A side note: if selftest documentation is updated to include this
> example, it will be much easier to future dev to follow)

Possibly send a patch adding that wherever you were looking?  That was
just a quick hack down of the gcs-locking program verifying that it had
what I thought you needed.

--2vh7jJ4clxa55i2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcWbEwACgkQJNaLcl1U
h9D7kgf/Q8O65O7KSc2ZO90h5zDrTW5/re+yyLl6rrA33pKJ3+HBeThhcoovMeVD
UGIP6+ppSvCsERN01Havz3+k+ekJefqaaZFRnRn7PKoD4SyxguuojkO6hJMASnsK
QUSlPb7+jf+VjQA09AZO7Rt65pr3drmlPjZk7eVXh4Gi0y+oPsV/TZ3CZA74Tnc1
3mGmetqcL4LsStRWPrO25RoJqkZrayX9P/WnjF5duR7r82pIIt7e5FdwyZIsWeia
q3Reo7UQrCYnPWrZqJg64W1IKsVneN0FYMyUgtVBzlcQ2tR/Ncz5D/ySDxK6p+/r
KZawNXyH8jQfs2HcpHmhVShtAw+/cQ==
=ivod
-----END PGP SIGNATURE-----

--2vh7jJ4clxa55i2K--

