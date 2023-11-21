Return-Path: <linux-kselftest+bounces-380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F857F2E49
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 14:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ADE1C218AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D4495D7;
	Tue, 21 Nov 2023 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/Cj1hs8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76207168CB;
	Tue, 21 Nov 2023 13:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09A7C433C8;
	Tue, 21 Nov 2023 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573271;
	bh=HsbZm4i+W0o1xTWC6fqvVGXLlSas3MdzUj56Sie1+dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/Cj1hs8TekOYMJY8u198suyeCM8gyvEOV+i5vEDjSCKFRfz67WAMTEGoxjgYZAax
	 WGa6CehOYC1MIpazeHmXZlRtUeoB2/rhy/rcVtU3XheSoDtiBlu5j4rVKQeo38mgo7
	 J80NmKCOxwXcNA0vVbs4xcuEs/EvONdLm/Pk3g5iyBfIGFZNswjJX+rpWRkmhgmRZ+
	 wEpygIBB/r90G0IJIFpAHiMZohh17d0OrYFWpWiLFTkNKRrDtm3k1JDcM0NDDo9zcQ
	 ewpxEGZYEN4V3oQPpnLRXmZZH264mqxHMmSq7to2PfN3COmxSn6cqjSpofukRlvruf
	 3m5EqiDnhgaWg==
Date: Tue, 21 Nov 2023 13:27:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>,
	Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	workflows@vger.kernel.org, joe@perches.com, apw@canonical.com,
	davidgow@google.com, rostedt@goodmis.org, skhan@linuxfoundation.org,
	djwong@kernel.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, vkabatov@redhat.com,
	cki-project@redhat.com, kernelci@lists.linux.dev
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <5d69e9ef-e60c-4eb9-b067-5b44488dd8c9@sirena.org.uk>
References: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <87sf50imba.fsf@collabora.com>
 <20231120205131.GA291888@mit.edu>
 <92c2f89d-f8a6-4260-b10d-671011cf1f70@sirena.org.uk>
 <20231121060450.GB335601@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ChVjL7ja6bjs4kb"
Content-Disposition: inline
In-Reply-To: <20231121060450.GB335601@mit.edu>
X-Cookie: Hindsight is an exact science.


--4ChVjL7ja6bjs4kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 01:04:50AM -0500, Theodore Ts'o wrote:
> On Mon, Nov 20, 2023 at 10:27:33PM +0000, Mark Brown wrote:

> > This is the sort of thing that kcidb (which Nikolai works on) is good at
> > ingesting, I actually do push all my CI's test results into there
> > already:

> >    https://github.com/kernelci/kcidb/

> > (the dashboard is down currently.)  A few other projects including the
> > current KernelCI and RedHat's CKI push their data in there too, I'm sure
> > Nikolai would be delighted to get more people pushing data in.  The goal
> > is to merge this with the main KernelCI infrastructure, it's currently
> > separate while people figure out the whole big data thing.

> Looking at the kernelci, it appears that it's using a JSON submission
> format.  Is there conversion scripts that take a KTAP test report, or
> a Junit XML test report?

Probably - I know I've got something for KUnit which is annoyingly
difficult to publish for non-technical reasons and is a little broken
(things weren't visible in the dashboard when it was up which might mean
some missing field or a date set wrong).  My KTAP stuff is all mediated
through LAVA, that can push results into a web hook directly so it's
really easy to just add a notifier to your job and stream the results in
directly (I intend to push that into kcidb in my copious free time so
other people can use my code there).  It's relatively straightforward to
write these things.

> > The KernelCI LF project is funding kcidb with precisely this goal for
> > the reasons you outline, the data collection part seems to be relatively
> > mature at this point but AIUI there's a bunch of open questions with the
> > analysis and usage side, partly due to needing to find people to work on
> > it.

> Indeed, this is the super hard part.  Having looked at the kernelci
> web site, its dashboard isn't particularly useful for what I'm trying
> to do with it.  For my part, when analyizing a single test run, the
> kernelci dashboard isn't particularly helpful.  What I need is
> something more like this:
>=20
> ext4/4k: 554 tests, 48 skipped, 4301 seconds
> ext4/1k: 550 tests, 3 failures, 51 skipped, 6739 seconds
>   Failures: generic/051 generic/475 generic/476

That should be achievable with the KernelCI stuff (which is different to
kcidb at present) - you're a lot of the way there with how kselftest is
currently reported modulo the list of failures which currently requires
you to drill down to a second level page.

> ... which summarizes 6,592 tests in 20 lines, and for any test that
> has failed, we rerun it four more times, so we can get an indication
> of whether a test is a hard failure, or a flaky failure.

> (I don't need to see all of the tests that passes; it's the test
> failures or the test flakes that are significant.)

The listing of tests does get a bit more complex when you mix in running
on different platforms.

> And then when comparing between multiple test runs, that's when I'm
> interesting in see which tests may have regressed, or which tests may
> have been fixed when going in between version A and version B.

Yup, that comparison stuff is useful.  The landing pages for individual
tests do have something there but not really anything higher level:

   https://linux.kernelci.org/test/case/id/655b0fa18dc4b7e0c47e4a88/

> And right now, kernelci doesn't have any of that.  So it might be hard
> to convinced overloaded maintainers to upload test runs to kernelci,
> when they don't see any immediate benefit of uploading the kernelci db.

Note that kcidb and KernelCI are currently different databases - with
the dashboard being done kcidb has no UI at all.  Personally I'm pushing
my data in on the basis that it costs me basically nothing to do so
given that I'm already running the tests.

> There is a bit of a chicken-and-egg problem, since without the test
> results getting uploaded, it's hard to get the analysis functionality
> implemented, and without the analysis features, it's hard to get
> developers to upload the data.

I think if we get tooling in place so that people can just run a script,
add a flag to their tools or whatever to ingest results from the
standard testsuites the barrier to reporting becomes sufficiently low
that it's more of a "why not?" type thing.

There's also other things we can do beyond big data analysis, some of
which are a lot easier - for example checking other people's CI results
for your branch before sending or accepting a pull request (if you've
got a one stop shop to pull data from that's a lot easier than if you
have to go round a bunch of places).

> That being said, a number of file system developers probably have
> several years worth of test results that we could probably give you.
> I have hundreds of junit.xml files, with information about how kernel
> version, what version of xfstesets, etc, that was used.  I'm happy to
> make samples of it available for anyone who is interested.

Right, I've likewise got a pile of results I can reprocess at will.

--4ChVjL7ja6bjs4kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVcsE8ACgkQJNaLcl1U
h9COYwf/fTMDLpXwvVNNxK+v5hlq41OYVt2sklCaJ/43xLnOUqxbRElV4yTxNnW6
i83EPXz5J9rw1kYcPjR7NFJWeZuLJz45r5G4M2++NfS/sJGI16DpM6Lo3gD0+Oky
sJt7j2HlvKDIxRtitaajVL4dsWKxlFkn5Xqhz6JrNONTxdbl/kEaKR6hf141NERB
OKq70z8drw82CZvAfesZk4gxkY0qOPg8SYrgc/N2pWuYAm2sQsISRBnb9xiauNbC
bucWk+Yx9o4n8siFE0gi2Cn5ZdKAzGbZOOr/20JrCP4Ukj1sULHTniLdORKwzYQ3
u0KziIdFTugVPPYsOw19YE8IZvhrcw==
=weIR
-----END PGP SIGNATURE-----

--4ChVjL7ja6bjs4kb--

