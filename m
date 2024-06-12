Return-Path: <linux-kselftest+bounces-11761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CC8905370
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 15:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683A3286B84
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3538A16E899;
	Wed, 12 Jun 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFtm7nOi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDE155726;
	Wed, 12 Jun 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198165; cv=none; b=p0EzvkCJZAkenWta3WHw0Go5HH7Oy+/dhuMoEPIAWlKUh2n8Xz5Sa4P8w7fYDjr3dcLiNe5KW9z+B6oKaA5v//q/7eQp9gtkdkJ1D+DhPrwOZoBdTH9GYX05yQED9jBuCNkkKkBVYUESy/QGLNf9YXr6bV44SsKDQJJNO8GScE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198165; c=relaxed/simple;
	bh=BJDm8/kxmaUW7OscjHY9k79OaVEvE2PZ5fA8kE0u2Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmRZ4/I40jDHKR0SFDavebpOEA2vF7GR9IcStMns3aJSCLFZS2eD51A4fAk9eQ1ZqdmdTExbzQ2nqALANj5IKtY8cfWYSA7ITnuQ096lovvjQTr56tkQFTJgXNLgPwx4XBz6E8dc4czmf69lAI8SsfStublzGBEIcuuxLes540k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFtm7nOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151B0C3277B;
	Wed, 12 Jun 2024 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718198164;
	bh=BJDm8/kxmaUW7OscjHY9k79OaVEvE2PZ5fA8kE0u2Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFtm7nOiJ8FJrWFWOAt2MBjut3gdR2J2BI6LwMoMiLD3E5fl1QTQlawVp5WtCThY/
	 5q2ZH6PCBVhojtG+PCiBNEisDzpOqVe4OlgYKWBIxwoD19NjLf1gg2kEMnvpAoFefr
	 WxrBm2cU+3zSVOUSvtouwl/06WQTwEgeHkvlY1QYuHPxZ7g9K5wH+K276RQhixsTwP
	 JWJJZWDnhoDw0YPZLuvTwz9PZxD9SNyvZF951T5NW+wMHi5BGawcvoZhEfHKZ1YLuk
	 tvnUXT5wrYCrvrhIzinm8R1o+mkjYkomwRv6LiZ1AqUhH2x7f6zWSR83DgCtnSMBUp
	 QpEzB6LVsgSgQ==
Date: Wed, 12 Jun 2024 14:16:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
	tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
	suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: Add a test mangling with uc_sigmask
Message-ID: <ZmmfkbuCl61rEPs-@finisterre.sirena.org.uk>
References: <20240611075650.814397-1-dev.jain@arm.com>
 <20240611075650.814397-3-dev.jain@arm.com>
 <Zmg0GoGnJFbPysfK@finisterre.sirena.org.uk>
 <ec1973ee-909d-41a2-8b32-256302d190b4@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6RcPqAjXRRG9Q+kN"
Content-Disposition: inline
In-Reply-To: <ec1973ee-909d-41a2-8b32-256302d190b4@arm.com>
X-Cookie: Your love life will be... interesting.


--6RcPqAjXRRG9Q+kN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 10:14:01AM +0530, Dev Jain wrote:
> On 6/11/24 16:55, Mark Brown wrote:
> > On Tue, Jun 11, 2024 at 01:26:50PM +0530, Dev Jain wrote:

> > > + * A signal is said to be delivered, when the program takes action on the
> > > + * signal: such action may involve termination of the process, ignoring the
> > > + * signal, terminating with core dump, stopping the process, or continuing the
> > > + * process if it was currently stopped. A signal is said to be blocked when the
> > > + * program refuses to take any of the above actions; note that, this is not the
> > > + * same as ignoring the signal. At a later time, the program may unblock the
> > > + * signal and then it will have to take one of the five actions
> > > + * described above.

> > I'm not sure that's what my understanding of a blocked signal is, I
> > would interpret "blocked" as a signal being masked (this usage can be
> > seen in for example sigaction(2)).  I'd also interpret delivery of the
> > signal as happening when the signal handler is invoked rather than
> > something that the handler has control over (the comment later on says
> > that so I think it's just an issue here).  Perhaps I'm confused about
> > terminology though, this is just usage I've picked up and ICBW.

> Isn't "signal being masked" equivalent to what I wrote...
> man signal(7): Under "Signal mask and pending signals":-
> "A signal may be blocked, which means that it will not be delivered
> until it is later unblocked."
> Under "Signal dispositions":-
> "Each signal has a current disposition, which determines how the
> process behaves when it is delivered the signal."

The point is that the delivery and blocking are done prior to the
process getting involved in the handling of the signal, the delivery
happens when the signal handler is invoked.  The program requests
delivery or blocking but it doesn't actually do the delivery or blocking
itself.

> "The comment later on says that", which comment and what does it say,
> sorry didn't get you.

That signals are blocked before the process sees them.

> > > + * For standard signals (also see real-time signals in the man page), multiple
> > > + * blocked instances of the same signal are not queued; such a signal will
> > > + * be delivered just once.

> > See also SA_NODEFER.

> Yes, thanks for the note, but do  need to include it in the
> comments? This is a specific setting...

TBH I'm not sure what you mean there by real time signals, I can't see
a reference to real time in the copies of signal(2), signal(7) or
sigaction(2) on my system.  I suspect SA_NODEFER is the actual thing
here.

> > > +	/* SEGV has been blocked in sa_mask, but ucontext is invariant */
> > > +	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGSEGV);
> > > +	ksft_test_result(ret == 0, "SEGV not blocked in ucontext\n");

> > We're not manipulating the masks outside of main() so it's a bit unclear
> > what the mention of ucontext being invariant is all about here?

> This is the point I raised in the cover letter and in this program:  the mask
> stores the set of blocked signals. What should happen when I block signals
> using sigaction()? According to the man pages, one could easily come to
> an erroneous conclusion that these signals will also be present as blocked
> in ucontext. I am making a point that, SEGV and USR1 have been blocked,
> but they have not been added into ucontext, i.e ucontext is invariant w.r.t
> to before and in the handler.

I still don't follow what the above means.  When you say "invariant" you
don't specify with respect to what, and it's not clear to me why the
saved context in ucontext would have changed without the handler writing
to it.  For clarity I think this needs to say what the ucontext is
expected to be the same as/different to.

The general flow with signals is that the context at the time the signal
is delivered is saved to the context structure, then the signal handler
context is set up and the signal handler invoked.  There are a number of
ways in which the signal handler context may differ from the context
that was interrupted, additional signals being masked is one of those.
On return from the signal handler the context is then restored from
memory and we restart from that context, potentially including
modifications made during handling.  This means that the state in the
signal handler may be different to the state in the context that was
preempted by it.

> > > +	act.sa_sigaction = &handler_verify_ucontext;
> > > +	if (sigaction(SIGUSR1, &act, NULL))
> > > +		ksft_exit_fail_perror("Cannot install handler");
> > > +
> > > +	if (raise(SIGUSR1))
> > > +		ksft_exit_fail_perror("raise");
> > > +
> > > +	ksft_print_msg("USR2 still blocked on return from handler\n");

> > But we just raised SIGUSR1 rather than SIGUSR2?  If nothing else this
> > bit is a little unclear.

> Before raise(SIGUSR1), we register a handler for it: handler_verify_ucontext.
> So, we jump there, we verify that USR2 is present in ucontext (since we mangled
> with ucontext before), then we raise(SIGUSR2): the program must not terminate
> since USR2 is blocked in &current->blocked. This is described by ksft_print_msg().

Like I say I think this needs a comment, it's not obvious from the
immediate code what the USR1 handler is doing and we're not doing
anything in this context to verify anything about USR2 so it looks like
a missed search/replace.

--6RcPqAjXRRG9Q+kN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpn4sACgkQJNaLcl1U
h9CY+Qf8Co2M5hyCEUmJ3UDhxkf27ZHRuSXR8m18RphdV3fDHHt5Ze5zsBXhXKzA
7ByjhRLWbSdfYqmrTZ6Cyn8fBb4Ot7RGUyHF01Xy9PEsHVyZ623XPvhCn9OlTISI
eUVR4u24iue8L6K7TodSV3mjxQ7PKvLRehp1HqJbB+ow//y6Vu2k2Gq+39hPfs+4
hbgmfEGtvqvtXW7O7D+J6soMDKWWf4WsY1etFa+g7eRDVqr/HoKJcrY6H183fjSf
UqpmPDEnVV5LE06TKtW9HRKdEZmBmlaMIBHeRjptKmrIzGqOsGnBQ3wj/ZjBbK3b
9QVlmurOKG3xH7E6Bn9roWK5FHt7jQ==
=zQCJ
-----END PGP SIGNATURE-----

--6RcPqAjXRRG9Q+kN--

