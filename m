Return-Path: <linux-kselftest+bounces-7606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B07A8A0253
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 23:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD5828B8D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DB6184106;
	Wed, 10 Apr 2024 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n00cFHjd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47C181CFB;
	Wed, 10 Apr 2024 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785424; cv=none; b=F9W+t2HMlvsjDJnDWv5zSXz5aADOd8dCEUZ5XrR7FEeMMrsGAHeqv20BYQbWGEJaIhBVNsFKcM5urF03nDrSdAP+j4uUDsdq18m4muOAmlYR8N+LOcEoqpnTqSCnR07X7CWrn+7yh06gJlCkUJxu6JDedOd4S9BZPqX46fnP2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785424; c=relaxed/simple;
	bh=iIoQ5NNv3YGMQuamEjOD70XxpAuovZ0od2BIIacIfbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU1ONtn3QqkYhz3Lgg+JLKkgjlX4NBn4t1ild+HAy4KVCJNHdYDHu508s0TJDKzGkGbNXW3LFhohPCUgfDSsOITrE1o5KXz/ieemNsVSmeZF9hOIg08jl/l/ddKV+4c7WtFRvrFwKuPVvmralL8urehII8u8JTIDyn8bzrfLQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n00cFHjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82406C43390;
	Wed, 10 Apr 2024 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712785423;
	bh=iIoQ5NNv3YGMQuamEjOD70XxpAuovZ0od2BIIacIfbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n00cFHjdzEqV2GBqw8OEeYntCBUOH+GppK26HcE+4N4M0LbQGQC3YnYxwgk+JCGQG
	 0HaW4M/qUMeoYwFAf+Q0cdr+5ySUYXsbP4HNl4e5X1C31EO2bnov/G2Bb+3dHBpHfE
	 9wdIBw8ggd1cq3tz9AISLo13BuB4bbyvIbiOe7wW0cjPgkkba7Nh5nullg6GXrNPjN
	 ldKDGcs/lSzX1Awc5FjeuWIITjXwbU3gx3mIUvTMsV6eIH9pYAZ6b7tUU8havTeBhE
	 +9OEZ6exm176bek1ONjFW2FPchdpb2XeHoi3NkJbSWiwDT97805vqmFlPftFMFg461
	 +Y3ktd5F+7agA==
Date: Wed, 10 Apr 2024 22:43:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/5] KVM: arm64: Share all userspace hardened thread
 data with the hypervisor
Message-ID: <df6eddc8-8d47-4feb-aa9f-50d16835860b@sirena.org.uk>
References: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
 <20240329-arm64-2023-dpisa-v6-1-ba42db6c27f3@kernel.org>
 <87msqesoty.wl-maz@kernel.org>
 <fb54d7b0-9c83-4a0c-a08b-b722c9381ca7@sirena.org.uk>
 <86h6gju87m.wl-maz@kernel.org>
 <562e1ddb-75e5-4c02-83ea-b946b88d35c8@sirena.org.uk>
 <87a5m1smno.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RTzog95tG9MZIxEK"
Content-Disposition: inline
In-Reply-To: <87a5m1smno.wl-maz@kernel.org>
X-Cookie: A bachelor is an unaltared male.


--RTzog95tG9MZIxEK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 08:27:07AM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Apr 02, 2024 at 03:53:33PM +0100, Marc Zyngier wrote:
> > > Mark Brown <broonie@kernel.org> wrote:

> > > Because it means this series assumes a different data life cycle, and
> > > the review effort spent on it will be invalidated once you move to the
> > > per-CPU state.

> > I don't have any visibility on when those patches are likely to get
> > merged or the general practices with in flight serieses here, last time
> > around with some of the serieses that were in flight it was quite late
> > which did make it unclear if things would go in during that release
> > cycle at all.

> Here's a trick: you could ask. Other people do.

I do ask questions from time to time, and you do respond to some of
them, but in particular with "what's the status" type questions you have
given the impression that they're not super welcome.  TBH my thinking
was just the standard submit against whatever is merged, rebase as
needed approach - I was of course aware of your series but also aware
that it was still in review.

> > The amount of churn in KVM recently and long periods where the relevant
> > patches are apparently pre accepted but for various not always clear

> Nothing is "pre accepted". Everything gets discussed and reviewed.

Sure, but then there's some things like your cleanup series which are
still in the discussion and review phase (or at least not applied) but
where you are saying you've got a strong expectation that other work
should be based on them.  Most if not all of those are clearly going to
go in (as you indicate below with this one) but for whatever reason
haven't actually done so yet, it's them that I'm referring to here.

> Specially when it comes to what you call "churn", which I call "crap
> removal".

Indeed, a lot of things get churned for good reasons - the point here is
not that there aren't valuable improvements being made (there definitely
are here) but rather that it does make for a bit of a moving target.

> > obviously going to be a lot more in the loop so this is doubtless
> > clearer to you than to me.  It's also been a little unclear what the
> > expectations are for basing things on - some people do prefer to do
> > their own merging for example, and while you have mentioned your in

> This isn't about resolving a simple conflict. This is a fundamental
> change in the way the state is tracked. We have argued about this for

I was on balance expecting to need to do the rebase at some point but
unclear what approach you and your comaintainers would want.  TBH I
don't really see it as a huge update, refactoring with the current
approach in this series should be a *broadly* mechanical operation. =20

> months now, you were Cc'd on the patches addressing this problem, and
> you even reviewed them. What other hint do you need?

Honestly, them actually landing in git or a positive statement to the
effect of "these will go in after whatever, please base your work on
it" or whatever.  It's not that I can't tell they're likely to go in at
some point, it's just that I'm targetting the current tree.  This is a
fairly standard approach which many maintainers prefer.

> > flight serieses your communication style means that it's not been
> > entirely clear if you're just noting the overlap.

> Not clear? That's a first. I'm usually seen as "blunt and assertive".
> But I'll keep that in mind and aspire to greater clarity in the future.

Those aren't quite the words I would use though I do understand the
sentiment.  One consequence of this style is that while it's obvious
that you don't like something it's not always quite so obvious what the
practical suggestion is, and since the general affect is so strong any
emphasis is not really visible.

More generally to this particular issue with rebasing on your series you
will have noticed that I have submitted a number of serieses which aimed
to address some of your review comments which you've rejected as not in
fact being things you were looking for.

> > Is it just that
> > refactoring series you want taking into account here or are there other
> > in flight serieses that should be rolled into a base?

> That, and the already merged feature enforcement framework which you
> keep ignoring. I'll push out a rc3-based branch in to -next shortly so
> that it is crystal clear what you need to base things on.

I really thought when I submitted this that I'd updated everything for
the feature enforcement framework now that it has actually landed, and
as I said in reply to the other patch apart from the nested idregs
(which I had missed) and the exposure of CPA (which did actually
introduce traps that I'd missed so I've updated to not expose CPA) I'm
still unclear what exactly it is that I have missed there.

Prior to that work landing this was all the same thing as I was
mentioning above with submitting against what's actually applied,
especially for serieses that aren't KVM specific where there's a higher
cost for pulling in extra dependencies early.  I was aware that there
were changes coming but also aware that they were still not there yet.

--RTzog95tG9MZIxEK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYXCAgACgkQJNaLcl1U
h9Bqdwf+PT81SEXK87zZW6lAoN2diWRo7Xk5B9INHyKXFF591mKuJnOyNAhvh2bY
7r9gcu29h9/f41YVMjhPR4sWylkc6aGMXv3TlyaohjX0kKSx1tiZ9hRItuRtTWL9
w2RuUuvdqqJL5I44d+KLqpiq4/JlfbwzmZ8b3xbMn14Yl0gjMzXU0WTA76Wr9mo+
93Ce0hT5ycozjn5j1XQvic58hKXi0EmYm6NrxaVzgF0rnvKR1xgKbZPLnaNhyjfo
qEapaBn4YH5IcQykh8oLat//5Tig2V7tqqQTO6V+8FwF7JrbwfTOzLSUbFcgOU5l
cFLASqoEIyzhypT3Nl9GjeptYpxbrA==
=er9f
-----END PGP SIGNATURE-----

--RTzog95tG9MZIxEK--

