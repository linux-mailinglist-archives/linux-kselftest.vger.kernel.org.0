Return-Path: <linux-kselftest+bounces-340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897F7F2049
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 23:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81E81C2131A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B703A268;
	Mon, 20 Nov 2023 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA/gMsnu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E83987A;
	Mon, 20 Nov 2023 22:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70DDC433C7;
	Mon, 20 Nov 2023 22:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700519259;
	bh=0jOUHGCwKxgzLTwAREMVP/be39sK8VQWFmVkIgVKzRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tA/gMsnubJUZ5lprsnSOowJATircK+pIrE44RHnOwkBVvFb7/FHhyPiu7O3DFe2Ro
	 4sO5kc4XMVFFMQgvjuOaEfmdkNbPiOKztfdQrB51lN1yP3hryjCeU010gf7Cl3pIev
	 O/D1nGnsj51nBrXrNko5i0ta/cl+9Y50LwQH7j28qAyGBMzYLFwG7ztTnX0Vxq3wuT
	 2PAvuvjyJMj6B9UdI4LTIFOV6fe6NRsD2ThzVVIrVBjbFc8eJDRL+wRvqBIYg2I9qj
	 GFSA3Vg7q7ihmv41NZbZLEglIVyNW67g1eLr79iEEsLN79WU9lusXviwB96Fi6nSzN
	 7RcVgOewsH4vA==
Date: Mon, 20 Nov 2023 22:27:33 +0000
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
Message-ID: <92c2f89d-f8a6-4260-b10d-671011cf1f70@sirena.org.uk>
References: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <87sf50imba.fsf@collabora.com>
 <20231120205131.GA291888@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/tyPRnz8XNYyIuZ"
Content-Disposition: inline
In-Reply-To: <20231120205131.GA291888@mit.edu>
X-Cookie: <Manoj> I *like* the chicken


--W/tyPRnz8XNYyIuZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2023 at 03:51:31PM -0500, Theodore Ts'o wrote:

> What we have at work is a way to upload the test results summary
> (e.g., just KTAP result lines, or the xfstests junit XML) along with
> test run metadata (e.g., what was the kernel commit on which the test
> was run, and the test hardware), and this would be stored permanently.
> Test artifacts is also preserved but for a limited amount of time
> (e.g., some number of months or a year).

> The difference in storage lifetimes is because the junit XML file
> might be a few kilobytes to tens of kilobytes. but the test artifacts
> might be a few megabytes to tens of megabytes.

This is the sort of thing that kcidb (which Nikolai works on) is good at
ingesting, I actually do push all my CI's test results into there
already:

   https://github.com/kernelci/kcidb/

(the dashboard is down currently.)  A few other projects including the
current KernelCI and RedHat's CKI push their data in there too, I'm sure
Nikolai would be delighted to get more people pushing data in.  The goal
is to merge this with the main KernelCI infrastructure, it's currently
separate while people figure out the whole big data thing.

> Of course once you have this data, it becomes possible to detect when
> a test may have regressed, or to detect flaky tests, and perhaps to
> figure out if certain hardware configurations or kernel configurations
> are more likely to trigger a particular test to fail.  So having all
> of this data stored centrally would be really cool.  The only question
> is who might be able to create such an infrastructure, and be able to
> pay for the ongoing development and operational costs....

The KernelCI LF project is funding kcidb with precisely this goal for
the reasons you outline, the data collection part seems to be relatively
mature at this point but AIUI there's a bunch of open questions with the
analysis and usage side, partly due to needing to find people to work on
it.  My understanding is that ingesting large data sets into cloud
providers is pretty tractable, as with a lot of this stuff it gets more
interesting trying to pull the data out and comprehend it in a practical
fashion.  It'd be really cool to see more people working on that side of
things.

On the submission side it'd be interesting to start collecting more data
about the test systems used to run things, might be useful to add a new
schema for that which can be referenced from the test schema.

--W/tyPRnz8XNYyIuZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVb3VQACgkQJNaLcl1U
h9AAywf9H7Dzbu0aNpWDX4osAMlrLJ3HYs3A24OOVIskqWE6ACkvbL4NXD44DyHt
a/u5Rfsach/H5bRgNI+hWWiAVwlMx574dCZcmBOxw7osjVqPK4FiSVHQNGENh59F
8L2cFcoyxjA5UyUUKxczfmgQNhqt1LAr1bDW+y2wRaVONnwQu9eXXYirQUfVZrpT
JwhTmkVsCvBoeE8f/w4UbvCU6/QCVIhg8pm7wdiOK4VVDvzZSkKR1A80ALvZcw69
FRUA0FNF3qWdirU1juf4GENDtlpeiDTly1UECeOXgy6dbZ8uU0Jmr7ytWStXWJ6o
FOQroLJoHsHZwIwRlxCWgGE5ak1XeQ==
=0jNL
-----END PGP SIGNATURE-----

--W/tyPRnz8XNYyIuZ--

