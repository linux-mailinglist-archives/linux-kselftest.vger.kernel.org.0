Return-Path: <linux-kselftest+bounces-8742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D5A8AFE1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEEC1C221E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B8C8E1;
	Wed, 24 Apr 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmawfEz2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C06139;
	Wed, 24 Apr 2024 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924308; cv=none; b=t7zu84x3bhVsO3DdoVAriXTqEa8gzsX16F0LfibDKaQjCU3rfcX4CLOh2EAIVhxyz3fhIQ7PYGe8mxVRcpH2JqEprnaZ5QkoZl7lbu5ry33nMr3/VetJjrU1cRonh8AA+iKMMRAJilScRchH88Q10P4cuUuGb5LEgmeVWKZsWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924308; c=relaxed/simple;
	bh=yubjtWjSKmJg0b2uSq5uBsVmaywEbiCVp6rc7+TLKHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMkr5/PapdmFsczsMWGlMCDE+f8ZEQRXQS5KST92aAxaUSTiFbM5vWzkptwcQqUeV1SwXBw3EM7HV1EBGlZT7Dl1G7r/yEW5gSkDYphfd8advVpafAoOS+eXvQFQL+GmrR9rY9QsceuIE+IJS4Th46ez2QtRY3vDEpRagxZlqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmawfEz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3FEC116B1;
	Wed, 24 Apr 2024 02:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713924307;
	bh=yubjtWjSKmJg0b2uSq5uBsVmaywEbiCVp6rc7+TLKHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmawfEz2zcQYD+0dz38EWnyArXlF/Kl6HT3rlDRLX8D+UCAiPuTHYsxxIR5mpHw/e
	 xUBfhAce8vsuxP43gMDCH4AwcLWWkymD/BclL42SDg4KFv0Ab4aGiN7EwLethyytoS
	 xqCmj2pfojZyH/W9RDLnjK2ZRaO0MougOAWMzwzSO069wjJl8IWB2O4A3LwIDr38Q4
	 aV5raghiE/ba1Oiur3HB79IJwXWJqiisUwT1sCcD5tWOw3gFOKADF3GV+AuHeOLQov
	 vMR4/XVCnF3JQpwUTE117+bE0uY01NulGy9RHCmRSBtcW3RDEiZJ/jUbe6SMHeS1gy
	 bfp90sqQdmd1g==
Date: Wed, 24 Apr 2024 11:05:04 +0900
From: Mark Brown <broonie@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>,
	shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com, suzuki.poulose@arm.com,
	ryan.roberts@arm.com, rob.herring@arm.com, Catalin.Marinas@arm.com,
	mark.rutland@arm.com, linux@armlinux.org.uk
Subject: Re: [PATCH v2 0/4] A new selftests/ directory for arm compatibility
 testing
Message-ID: <Ziho0Pl7JQ8m4Uh4@finisterre.sirena.org.uk>
References: <20240422070717.2194201-1-dev.jain@arm.com>
 <20240422172108.GD6223@willie-the-truck>
 <78f5ee9a-084f-4a8a-9a22-be031f9baafa@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xtww4yWy7m7bLqWW"
Content-Disposition: inline
In-Reply-To: <78f5ee9a-084f-4a8a-9a22-be031f9baafa@collabora.com>
X-Cookie: TANSTAAFL


--Xtww4yWy7m7bLqWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2024 at 01:55:07PM +0500, Muhammad Usama Anjum wrote:
> On 4/22/24 10:21 PM, Will Deacon wrote:

> > Isn't this going to be difficult to maintain if we have two divergent copies
> > of the same stuff? From a very quick skim, a bunch of the signals stuff is
> > idential to what we have on arm64...

> Agreed.

> Why don't we follow what x86 suite has been doing? Compile tests for both
> arm and arm64, and add conditionals in the tests based on architecture.

> If someone has objection that the suite name is arm64, just rename it to
> arm which would be a generic name.

Given that we haven't done that for any other arm/arm64 stuff I suspect
that specific approach would lead to some combination of confusion and
people just plain missing the fact that the 32 bit tests are there.
It's just not the idiom that's been used for handling things elsewhere
so it feels like asking for people to make mistakes.  With the signal
tests (which seem like the only bit that's really shared here) it's
mostly just some of the library code that we want to duplicate, the
actual test set for 32 bit will be different.

What some of the other testsuites do to pull in other tests as libraries
is to just reference the source files (KVM does this with rseq IIRC).
We could do that here and try to refactor the framework code for the
signal tests so that it can be built for both 64 and 32 bit, then have
the 32 bit Makefile pull in the shared code from the 64 bit directory.
I'm not sure if it's worth the effort or not - there is some obvious
duplication but a good chunk of the arm64 code is feature detection and
handling of the extensible signal context neither of which apply for 32
bit.

If we are pulling stuff out it might even make sense to have something
that other non-arm architectures can use since I'm not sure how much of
the framework code that can be shared is even arm specific.

--Xtww4yWy7m7bLqWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYoaM8ACgkQJNaLcl1U
h9DNPgf+JHcT98VNHTQh+6w+hb8SVxujf+3QfQfbWEjG6JxRxsmXu5FpJkOSCpyJ
M0NxAkasbfWvlMBCaDoAb2raAGzAq5cUgAJplZJkgF5ysMsLrFFlb2ksKEGkVC+h
YXPDLkpG4BVzFwbmyGYwZL5OYHBeGgIMBavGk6fd+4F0aVG0wCaKwlCCSp+X0fFb
nEBRiroGfywN1C4uiySIWRI/1TpDicYBFXJLsY4WRR7e5oFRQbUjLN/6TaFrnY6n
JiKwUKkzksTJMWNGSmUBprrJDfyI2ixzgKzXvGhRW8NPOHap3tqDvTvJVzKGSoZY
xqIjpHpBfOH3JFbuUXkugRx5gwwxMw==
=cdBr
-----END PGP SIGNATURE-----

--Xtww4yWy7m7bLqWW--

