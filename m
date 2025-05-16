Return-Path: <linux-kselftest+bounces-33177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B632BAB9CF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D103AF73F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895B241690;
	Fri, 16 May 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO6DLC78"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02923C505;
	Fri, 16 May 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400982; cv=none; b=ZYyWjmBiazbcep4aniGgBgDYFjd0yrmD1DqMuCnoIeuiDwcRMotmdwb1M+AOWevVd/H8ioKJYqlgxZDRcDhkASs7pmJs+eO9kXG5UQ/Ktr/8aLGPFVYKPBQZmGBihcjVOlk1+GyZf9A6B0KiovfVY1RA9lMoxaTRGNtwh6CVyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400982; c=relaxed/simple;
	bh=eTlu4M+xbKe7S6ap+yHpZH/r7OM70xHL1rfiqO94rFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP3ovBnPRSfiNaeHWj3hQw9eAIkjElL/7jUVwyIaDYBU5uyshZBLrBIRGRUFDmHVAIZSGr7vE+Ds2EwPXH/9g5Za4VF1pxWSdw1Gk1tidDERqMOTbJn6S710+Xxmt0haYNBIRyy92XIGgCulC1jC526TAjGYlNPqGdk6Rfi8SBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO6DLC78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD240C4CEE4;
	Fri, 16 May 2025 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747400982;
	bh=eTlu4M+xbKe7S6ap+yHpZH/r7OM70xHL1rfiqO94rFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tO6DLC78WaCvA9TWV/6GhHmgol9yYAgAo+jD6bzHVZabXzg3nP6cHaGyh29M3J4n5
	 TgCcOKrDAscv3Iv6wJIuomZwAbxDCM+tQsYLyEgpdZcqd1ue+bpB0n33qRcXqQcfYo
	 dcz9N976+ynkHRqCKDX8lq9xVil0hJC5BAG/hDqoxCPX/Sua/JoUbK2mzsD+mKTeoC
	 o5L/fLh6nwcB0Hrr0hyA5O0Vwmj/e4nzW5ryJ9oiDBdFhrTzVROoNz06S7R6Od38Kr
	 JRdb9USomzZ2D8H/gUtODeuZkdJ0tQtqM/zFt3FuOeqcEG+M65tEVintEvYRoKkNai
	 0HD2iChLsPVQg==
Date: Fri, 16 May 2025 15:09:39 +0200
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
Message-ID: <aCc5E-wB4nBwrKEP@finisterre.sirena.org.uk>
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
 <aCcvxaFc6DE_Mhr1@finisterre.sirena.org.uk>
 <58dbef73-6e37-46de-9092-365456306b27@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6KOq/7pGm4K+LcT"
Content-Disposition: inline
In-Reply-To: <58dbef73-6e37-46de-9092-365456306b27@redhat.com>
X-Cookie: Well begun is half done.


--d6KOq/7pGm4K+LcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2025 at 02:55:24PM +0200, David Hildenbrand wrote:
> On 16.05.25 14:29, Mark Brown wrote:
> > On Fri, May 16, 2025 at 10:02:16AM +0200, David Hildenbrand wrote:

> > > reason), what exactly is the problem with that?

> > > We run tests. If all pass, we're happy, if one fails, we investigate.

> > None of the tooling is able to either distinguish between the multiple
> > tests that are being run in gup_longterm, nor compare the results of
> > multiple runs effectively.  If all the tests run they report themselves

> Okay, so this is purely to make tooling happy. Humans are smart enough to
> figure it out.

Not just the tools, humans interact with the selftests and their results
via tools (unless I'm actively working on something and running the
specific test for that thing I'm unlikely to ever directly look at
results...).

> What mechanism do we have in place to reliably prevent that from happening?
> And is this at least documented somewhere ("unique identifier for a test")>

It comes from TAP, I can't see a direct reference to anything in the
kernel documentation.  The main thing enforcing this is people running
tooling noticing bad output, unfortunately.

> I guess when using kselftest_harness, we get a single identifier per tests
> (and much less output) just automatically.

Nothing stops something using the harness from logging during the test,
the harness tests actually tend to be a little chattier than a lot of
the things written directly to kselftest.h as they log the start and end
of tests as well as the actual TAP result line as standard.

> > If a selftest is reporting multiple tests it should report them with
> > names that are stable and unique.

> I'm afraid we have other such tests that report duplicate conditions. cow.c
> is likely another candidate (written by me ;) ).

That one's not come up for me (this was one of four different patches
for mm selftests I sent the other day cleaning up duplicate test names).

> Probably, the affected tests should be converted to use kselftest_harness,
> where we just report the result for a single tests, and not the individual
> assertions.

> That would reduce the output of these tests drastically as well.

> So that is likely the way to clean this up properly and make tooling happy?

That'd certainly work, though doing that is more surgery on the test
than I personally have the time/enthusiasm for right now.

Having the tests being chatty isn't a terrible thing, so long as they're
not so chatty they cause execution time problems on serial console - it
can be useful if they do blow up and you're looking at a failure on a
machine you only have automated access to.

--d6KOq/7pGm4K+LcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgnORAACgkQJNaLcl1U
h9B+pwgAgQVI4RTsNN2lzXvLnrlwDdIqpmgNGC3XSHUJbPoJ2nAfwS/2l7Nawj1y
6V4ovdGnJ8pxwYHjz3kNcKK6+3ECE71vuP3EG3EcVjL4U/qQjZHqp1UgKKGflDjj
1ywYE3rpjVVXjJAkCjatqoOkmhoD+QHL98eHsdlGCeryC6+Pk3fBW8XthiSUHVL6
gjJrut71YcAa4hB2RDr5QHsYSFzfNQ1VGJCkBgPQ2KhBCMLIW5XbAKdgmTKcLppI
h2CEGFp44SVYVLVMKh7xDZHOnRC5Rn630a7Agm+DNX++otprAW3tJom/xUkWmrS7
o8Bd4y0MXgryLagMcd9fid7VAgtKMw==
=LiQi
-----END PGP SIGNATURE-----

--d6KOq/7pGm4K+LcT--

