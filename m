Return-Path: <linux-kselftest+bounces-11676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E099039FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 13:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20491F21ECD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2793917B417;
	Tue, 11 Jun 2024 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0aRx+U8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018B3F8C7;
	Tue, 11 Jun 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105118; cv=none; b=D+dx7cP/oCeEsVRU6er4Wt3+hv4TOY7141LuJ2Gct++N/H1XzOlwYsN0Q79YWdqvILbhMEhDwIQGyKqBF9Vf1TtJ9LLTqX2QOZTq7lyxDyXhgs7M71IVP8U1MoHVkt6HimriS7ziOG4t2xHRkl8p87Z/SDuJp3uR1XPewUpw/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105118; c=relaxed/simple;
	bh=BB4/Mq5HYdHy8VoLpfc6Vh32CzpFgIB+PwO07ji7t6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN8vGGMWdItXr1hHxEiCg82Zp2k9jMkD0cTXxJ7xCt/Q1Fc0ta8juribz3OhntQlIh3bWggGmihDcCfBQeLDPxSsN5SQ3m2jjbT3IThADSofopZHSRkyVmHASCIpbSQLhLqE2/Tt+DYLUAnDqro+VV0CRj4g0wKq/ZZ9TwY5gug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0aRx+U8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CD0C2BD10;
	Tue, 11 Jun 2024 11:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718105117;
	bh=BB4/Mq5HYdHy8VoLpfc6Vh32CzpFgIB+PwO07ji7t6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0aRx+U8vMBKW82C2FRAZISfBa0LMWzbKfzc1LJj6RFcOUkstbor++ALIY/JtGCvj
	 9soHVBz1M7NJY+UWisWaAKjXYvAUEWaxD8++vOtGIOXd8kGvu9RVhAj42lJBnfanqA
	 S7/L6jDsPSbYgAtFZeiJkO46FxUmxJCo3nkhbvnjW4ZMpyKXjGvPPbhzq6xwuXE6zd
	 qXsmQQo/nsWEQwufjYB5RwzV84KJ6qHLe6riHqNi8noyuQOBP4U3eLtf+G5xRxHGMg
	 lZ+70E0D3qNIkskB0O6UET0pXfDLPo/6CmnbDSUiQy4SHl1mp9uiFme138gRPXQPY4
	 TTcanXiWBiKxQ==
Date: Tue, 11 Jun 2024 12:25:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
	tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
	suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: Add a test mangling with uc_sigmask
Message-ID: <Zmg0GoGnJFbPysfK@finisterre.sirena.org.uk>
References: <20240611075650.814397-1-dev.jain@arm.com>
 <20240611075650.814397-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A2hm2y1BJ1qa3PqU"
Content-Disposition: inline
In-Reply-To: <20240611075650.814397-3-dev.jain@arm.com>
X-Cookie: Your love life will be... interesting.


--A2hm2y1BJ1qa3PqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 01:26:50PM +0530, Dev Jain wrote:

> + * A signal is said to be delivered, when the program takes action on the
> + * signal: such action may involve termination of the process, ignoring the
> + * signal, terminating with core dump, stopping the process, or continuing the
> + * process if it was currently stopped. A signal is said to be blocked when the
> + * program refuses to take any of the above actions; note that, this is not the
> + * same as ignoring the signal. At a later time, the program may unblock the
> + * signal and then it will have to take one of the five actions
> + * described above.

I'm not sure that's what my understanding of a blocked signal is, I
would interpret "blocked" as a signal being masked (this usage can be
seen in for example sigaction(2)).  I'd also interpret delivery of the
signal as happening when the signal handler is invoked rather than
something that the handler has control over (the comment later on says
that so I think it's just an issue here).  Perhaps I'm confused about
terminology though, this is just usage I've picked up and ICBW.

> + * For standard signals (also see real-time signals in the man page), multiple
> + * blocked instances of the same signal are not queued; such a signal will
> + * be delivered just once.

See also SA_NODEFER.

> +	/* SEGV has been blocked in sa_mask, but ucontext is invariant */
> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGSEGV);
> +	ksft_test_result(ret == 0, "SEGV not blocked in ucontext\n");
> +
> +	/* USR1 has been blocked, but ucontext is invariant */
> +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR1);
> +	ksft_test_result(ret == 0, "USR1 not blocked in ucontext\n");

We're not manipulating the masks outside of main() so it's a bit unclear
what the mention of ucontext being invariant is all about here?

> +	/* Mangled ucontext implies USR2 is blocked for current thread */
> +	if (raise(SIGUSR2))
> +		ksft_exit_fail_perror("raise");
> +
> +	ksft_print_msg("USR2 bypassed successfully\n");
> +
> +	act.sa_sigaction = &handler_verify_ucontext;
> +	if (sigaction(SIGUSR1, &act, NULL))
> +		ksft_exit_fail_perror("Cannot install handler");
> +
> +	if (raise(SIGUSR1))
> +		ksft_exit_fail_perror("raise");
> +
> +	ksft_print_msg("USR2 still blocked on return from handler\n");

But we just raised SIGUSR1 rather than SIGUSR2?  If nothing else this
bit is a little unclear.

--A2hm2y1BJ1qa3PqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoNBkACgkQJNaLcl1U
h9B9qQf+Iaz95T4ZrcXyk/EoddifPmCyDYbb1mz4TrQEknVIMBwwWCvczzuST0K1
v/cTJQLIYlfs+0Re2vg2R9W3dsyuVO7TGpuvG6ovnEUys98RS+2vhtCl367VUR5E
2bkmSvuedTSCkKlw+HoXF4nPnFuD2+KJqrvXRRNhV343J57uiDYi+Co8sI78+tH9
gR4bijyAAtKGDze2UwhHvtGVn3zAdov4o/rzlDGzpyjMO4W6dbB5d19kZ7rhgY0m
lZ2kTGYMxC6C+7MqgKK44iJolIJVDMmUhekN+zvJHxFgJN42FjgXnJgN8K8pmK/Q
M/j144QaRMb7d6QBDM5xmaxzH+pPqQ==
=+KZa
-----END PGP SIGNATURE-----

--A2hm2y1BJ1qa3PqU--

