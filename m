Return-Path: <linux-kselftest+bounces-11376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09C900457
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894411F23A39
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C100F194098;
	Fri,  7 Jun 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQoZzbT0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652513F42E;
	Fri,  7 Jun 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717765945; cv=none; b=GG8YcddI8ptIAvZDUnel2pfMkfbST/WAMoI6+K+hn9eUWBrHoBEG4LXORpPEeFq0FEPpRUErR5rs8DWcQNjouzGQefxjYIG+MZYhPHfpyIbnwNxrL1030w+wmkiuvmndZkryyq+yT1pHd2o8ymPQdrCh4uM/mQGWu3mwawe0e5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717765945; c=relaxed/simple;
	bh=NLJDJqeei4H3x1qQRMaUa1qgNu65ZOEg2TMUdlzO8+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF7ka6QVwY8JeesbAbNGuM2wXY2rkHGCMK/I8gn2KByRq38Nf80UdeBp14K8W3Ba9qqfprERjFLFM+2Y2F+xgVRQdh08hGOM+uPEUGjyJXHs5iX38wo1dJUnsg3Ng0KFC6g3dzoCuKWpIMDZBvBkCa8HKhUWm58R7b2AjSnTVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQoZzbT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5F6C2BBFC;
	Fri,  7 Jun 2024 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717765945;
	bh=NLJDJqeei4H3x1qQRMaUa1qgNu65ZOEg2TMUdlzO8+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQoZzbT0Pz9KM8oFv+st+iDpHTfHJPIfc7aOYOq0PlWV0opXrNlUv2gCkKq+Y3qrA
	 O4+nMTkfFNea6bQRRKGlI9777nQdXUekBp7MNsR49XJ7RIkdPPUJXqrUygm7gMINMm
	 0yEguDK6KdbiclzTeSszYqi4eVcyP7lFc6hNVPkbj+Ov9QrohabLlXA/z5lW2n7XGD
	 zAbv205mlz03weHF4xODVvkbKjpqD0AJmaz82lPOQ/Vi3IxgpWKpuht/UWit2RFntJ
	 IqNzZb/lh5qPb1o/BDt2TTIyhI+Lar2X7ILORXDbjo7eh1F1VISCOottLrSf6fT43N
	 d6wQZUky5byPA==
Date: Fri, 7 Jun 2024 14:12:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
	tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
	suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: Add a test mangling with uc_sigmask
Message-ID: <ZmMHNZcYfNMW1Ft7@finisterre.sirena.org.uk>
References: <20240607122319.768640-1-dev.jain@arm.com>
 <20240607122319.768640-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cF6vW8T0ysx4GnzU"
Content-Disposition: inline
In-Reply-To: <20240607122319.768640-3-dev.jain@arm.com>
X-Cookie: Your love life will be... interesting.


--cF6vW8T0ysx4GnzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2024 at 05:53:19PM +0530, Dev Jain wrote:
> This test asserts the relation between blocked signal, delivered signal,
> and ucontext. The ucontext is mangled with, by adding a signal mask to
> it; on return from the handler, the thread must block the corresponding
> signal.

> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  sigaltstack
> +mangle_uc_sigmask

Please keep these build files sorted alphabetically, this reduces
spurioius conflicts between serieses.

> + * Author: Dev Jain <dev.jain@arm.com>
> + *
> + * Test describing a clear distinction between signal states - delivered and
> + * blocked, and their relation with ucontext.

This would be clearer if it said more positiviely what the relationship
between these things is actually expected to be and how they're tested.
Right now it's a bit hard to tell what the test is actually verifying.

> +void handler_verify_ucontext(int signo, siginfo_t *info, void *uc)
> +{
> +	int ret;
> +
> +	/* Kernel dumps ucontext with USR2 blocked */
> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR2);
> +	ksft_test_result(ret == 1, "USR2 in ucontext\n");

"USR2 blocked in ucontext".

> +
> +	raise(SIGUSR2);
> +}

A comment explaining that we're verifying that the signal is blocked
might be good (I think that's what this is doing?).  We're also not
checking the return value of raise() anywhere in the program, this would
be a useful diagnostic.

> +	/* SEGV blocked during handler execution, delivered on return */
> +	raise(SIGPIPE);
> +	ksft_print_msg("SEGV bypassed successfully\n");

SIGPIPE or SIGEGV?

> +	/* SIGPIPE has been blocked in sa_mask, but ucontext is invariant */
> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGPIPE);
> +	ksft_test_result(ret == 0, "USR1 not in ucontext\n");

The relationship between the comment and test are not clear here, nor is
that between the sigismembber() call and the test name we print?

> +	/* SIGUSR1 has been blocked, but ucontext is invariant */
> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR1);
> +	ksft_test_result(ret == 0, "SEGV not in ucontext\n");

Similarly here.

> +	/* add SEGV to blocked mask */
> +	if (sigemptyset(&act.sa_mask) || sigaddset(&act.sa_mask, SIGPIPE)
> +	    || (sigismember(&act.sa_mask, SIGPIPE) != 1))
> +		ksft_exit_fail_msg("Cannot add SEGV to blocked mask\n");

SIGPIPE vs SIGSEGV.

--cF6vW8T0ysx4GnzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjBzIACgkQJNaLcl1U
h9BGwAf+NAq/bq240V4/kOR1sft3cqiATc7NHxEpjjk0MCkAsSzcxKDaMbPujgVx
i8iNT1QYF43Rip16x/x0NKxttjm1X/EWoytGmOjXHSN8J4xl68LZX97wCfqwlTUB
gW+L4K8T8i68m/bAnr31VkTAP/tBoX60r2KsuV8YgPA1+yHsUkA75KS9GmDfT5Bi
R/Rwe7gVzCezAQF7A1pX5O3RoFq4dBpDxiAc/rSuTR9pqlWdn4VY1VCdWGRZse5B
YAXYthSgs7DnYHHLT8uyLq/qtYLrsWZJlWWtvTGgegM3aQoGklL/0XmiX2OfVNJG
DxntSU9FL/FD5tKdhHGqL13yXE3GCQ==
=ZvFX
-----END PGP SIGNATURE-----

--cF6vW8T0ysx4GnzU--

