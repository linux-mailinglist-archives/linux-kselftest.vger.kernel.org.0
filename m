Return-Path: <linux-kselftest+bounces-20138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C26F9A3F1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 15:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7C3B21409
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F644375;
	Fri, 18 Oct 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy70iDxd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF84084C;
	Fri, 18 Oct 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256650; cv=none; b=TOqZwmoo0ZT33H0x7zseG/8n7tsazVzOLYeGlBn00jmC5XV6BTDU9det1/mrQwrl0GpTOcUNWxi/dwx3EEexXNGS0uXnlVkmyiBmmNRmXw93ogI27m5YFu1j3VmpM7F8hJihySsOK1u1sIOSCeCzP8PT/bIRENvPC8s9KazxN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256650; c=relaxed/simple;
	bh=g2CJxGpTFCOsw8YxyBZm5iz4MWqWWqjHA92Ubpkewfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWLq15S4Dp1QRcLmw+kkl0MRldkOig1z42dqdcUxdeUxr4z3Fymqr+zDnxs04ILVArdtVxiGqeHZMPSKrds9PMUSL2pdDQQqrpgZhLNcE6gbNi1nVJBn4bamXVU1ke+HKbUiSW7MFizMslaUeP3qf13hW8+ovL1K3IeTYRpv9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy70iDxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B843C4CEC3;
	Fri, 18 Oct 2024 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729256650;
	bh=g2CJxGpTFCOsw8YxyBZm5iz4MWqWWqjHA92Ubpkewfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sy70iDxdvegIxSpbXgc5l5sDisr1CZ4sC7k1lbpyMO3ps7QBlrYogssUkxA3itTq3
	 AQEoQL9PclRAphMwOGvXczd3YP5474UnFMyGtofrV7wewmUhWgb36+D/mxX0TSNS9T
	 f/lVPozmAReEZcHeTg1Kr5WVXMFXZYL56yvSNJocnM2MQT14uIf4KFaoaWuUmH2N9u
	 j6TTPE83B54c0FIDFMWZnWB6v9ey8dIJiiRCeaLi84cRr3FGSDOSn6r3l8GdREAatz
	 wjnSiM+Q3gG6VspsFgyIlOd22BZENkjey1+D1sWRaKBTI22bIf8/K8mo1mVq3sihH0
	 aeBFQqweIx1hw==
Date: Fri, 18 Oct 2024 14:04:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
	willy@infradead.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
	rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk>
References: <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
 <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
 <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
 <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YLYxAeMluy/4woDv"
Content-Disposition: inline
In-Reply-To: <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
X-Cookie: What is the sound of one hand clapping?


--YLYxAeMluy/4woDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2024 at 12:49:40PM -0700, Jeff Xu wrote:

> So it is not a problem with the MACRO, but where is it used ?

>         ret = sys_mseal(ptr, size);
>         FAIL_TEST_IF_FALSE(!ret);

> Take this example, it would be
> assert(!ret)

The problem is that the macro name is confusing and not terribly
consistent with how the rest of the selftests work.  The standard
kselftest result reporting is

	ksft_test_result(bool result, char *name_format, ...);

so the result of the test is a boolean flag which is passed in.  This
macro on the other hand sounds like a double negative so you have to
stop and think what the logic is, and it's not seen anywhere else so
nobody is going to be familiar with it.  The main thing this is doing is
burying a return statement in there, that's a bit surprising too.

I'll also note that these macros are resulting in broken kselftest
output, the name for a test has to be stable for automated systems to be
able to associate test results between runs but these print

                        ksft_test_result_fail("%s: line:%d\n",          \
                                                __func__, __LINE__);    \
                        return;                                         \

which includes the line number of the test in the name which is an
obvious problem, automated systems won't be able to tell that any two
failures are related to each other never mind the passing test.  We
should report why things failed but it's better to do that with a
ksft_print_msg(), ideally one that's directly readable rather than
requiring someone to go into the source code and look it up.

A more standard way to write what you've got here would be to have the
tests return a bool then have a runner loop which iterates over the
tests:

	struct {
		char *name;
		bool (*func)(void);
	} tests[];

	...

	for (i = 0; i < ARRAY_SIZE(tests); i++)
		ksft_test_result(tests[i].test(), tests[i].name);

then the tests can just have explicit return statements and don't need
to worry about logging anything other than diagnostics.

Depending on how much you need to share between tests you might also be
able to use kselftest_harness.h which fork()s each test into a separate
child and allows you to just fault to fail if that's easier.

> > We are writing unit tests in a test framework, let's use very well
> > established industry practices please.

Plus also the fact that we have a framework here...

> > Also note that you don't even need to reinvent the wheel, there is a
> > fully-featured test harness available in
> > tools/testing/selftests/kselftest_harness.h with both ASSERT_xxx() and
> > EXPECT_xxx() helpers.

> The EXPECT_xxx() doesn't take care of reporting though,  or maybe it

I rather think people would've noticed if the test harness was so broken
that it was unable to report failures.  If it is that broken we should
fix it rather than open coding something else.

--YLYxAeMluy/4woDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcSXMMACgkQJNaLcl1U
h9AmKAf/Tu4kW1hhmlXQ1Agr7BitWMDgVw9arn8ymLeyxIk/tu+VEoRY7AhaMvzd
3J00TJc8rCiabRtgebGDooegImXGlwOPo+OozAKDSoqY+XL5NQxnakmMrk0vSUfQ
jJzLnl2Bxo/43T6/xPQKzUdxMz8NY4uHDF3X0FPWWnvF4F/5XMZ44uDRMmFrL+aI
FsP7ZEB4W1A7wn5bpj83e58whRSO5G2Y/3Z5kl5oh49cTIXBM4nNIVtOcOWt5976
FWtpGPSQEHqtBj840j7dVwFCRAJ9aobcbBWt4lOhOVftuOf1fE0QeLgGaE9/tOHB
gYLIyF/x8ZauAuQattbuUL3nOp6iqw==
=r5Sq
-----END PGP SIGNATURE-----

--YLYxAeMluy/4woDv--

