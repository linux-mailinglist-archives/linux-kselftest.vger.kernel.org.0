Return-Path: <linux-kselftest+bounces-34236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37558ACCCE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C93173BCF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E5288C20;
	Tue,  3 Jun 2025 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJApOzfh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B7A23BCF0;
	Tue,  3 Jun 2025 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975246; cv=none; b=P5uB2/HB/1/8cUJg6Kfx4Gvx/4Ff3ZBEhM1UJrgzUUi5U4I4XRk8HhJpdqXNZ8gpVVfJjZywZiWtYlQJ9QRk7uO6SUjLk5HQ0+4dbDYJBUmsv26BUUzxz6sqh4i2jQB99Xw4WPpoJzhqqO/TnG7JUh1ARg8knxvh2Y7HV8cRr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975246; c=relaxed/simple;
	bh=ckhw827S1BHIzOOsklyV4f5zZYq6GzhskiPmH9tlxgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmOFF+DxRH9XJS47k8wiwJ8rSvAsgEIxM9ALBNITMX4N2ZKE++dQMvnDI5k8N0moxbHmYpi6HpENTUoLlYTm425dUNaWH641SbQFihliQA7su02SHofI+ULwBajRj4eB7UNytUrJQ3UMtUMqPnU2JyDjdq5XJhHch77ASIpYw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJApOzfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C77AC4CEED;
	Tue,  3 Jun 2025 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975246;
	bh=ckhw827S1BHIzOOsklyV4f5zZYq6GzhskiPmH9tlxgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJApOzfhV9fbEzynGEdok9VjWoCb7Zo0WIq1Yo4MAW8HsrK5lfqLh3IgF33b0Oyo5
	 UQn885AEGJZfooJizhCV84rKMjABAFcv1NuxQ2W9gACRBxXg184Hyo2Hr9luVRFk41
	 dcdPfQYGPjbn2tLoeZGofz7MauWnlJ/pajRWdMKX4gue+RSHF3CS/rZwmsT6fryRiz
	 D9W/83FRVkjQSd462IuobALHZE8IPZR86PEZjaQ7tqsF6NkycgvoHM7hMqIDhRSxnB
	 NYabQVJDdJSLO0Qskpz8l+ETWZlY3RgCBP3Kxq/Aswh/sXqx9bqwwnFTypxx6yZn7f
	 i8NPPUHDYBakQ==
Date: Tue, 3 Jun 2025 19:27:20 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftests/mm: Add helper for logging test start
 and results
Message-ID: <5e00c276-2d3b-4004-9f98-4703e2d642f9@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-2-ff198df8e38e@kernel.org>
 <63e00cf8-8592-4117-bb27-42bc8c1f8921@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U87MoMgTYp3o0nhz"
Content-Disposition: inline
In-Reply-To: <63e00cf8-8592-4117-bb27-42bc8c1f8921@redhat.com>
X-Cookie: Avec!


--U87MoMgTYp3o0nhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 02:37:41PM +0200, David Hildenbrand wrote:
> On 27.05.25 18:04, Mark Brown wrote:

> > +static char test_name[1024];
> > +
> > +static inline void log_test_start(const char *name, ...)
> > +{
> > +	va_list args;
> > +	va_start(args, name);
> > +
> > +	vsnprintf(test_name, sizeof(test_name), name, args);
> > +	ksft_print_msg("[RUN] %s\n", test_name);

> We could allocate the array in log_test_start() and free it in
> log_test_result(). Then, we could assert more easily that we always have a
> log_test_result() follow exactly one log_test_start() etc.

We could, however we don't have vasprintf() in nolibc and people have
been doing work towards making nolibc more generally useful as a libc
for the selftests (and/or the selftest interfaces more friendly to
nolibc).  I don't really know what the end goal with that is but given
the fairly small gain and the hope that this won't be a long term
framework for anything I'd rather not add something that gets in the way
of whatever's going on there.

Ideally the test programs would be refactored and these helpers deleted,
but as we said previously that's a bigger job that neither of us is
likely to get to in the short term :(

--U87MoMgTYp3o0nhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg/PogACgkQJNaLcl1U
h9B5Kgf5AUmj3DzX7FVW0uxuQnTuNoG9OfKh4yzJffzPIA7Z+MnjQgY9tahrBn81
wgz4LO7oLOyIy7fKV4YJqDKzxa5HluHG2uNQ7eHxMpgjD4vVD3/BjM4yWlWPMA0h
KYXvf60i08dIoKyK67/XnWO8Vu1l8oz7ecj91UGMD962hzRDU6ZkTpq/eOAww5vC
zA4eSj1fHA+HBINxxrOfd1FWvTUEOF2pemHv5W96eZXVukmCYb1C4uPCProQ2nqy
jNIrIkZdII3SwcurjSZWn2FEpwMgeTJR3iDo/XSfYN9gfx4np+HATvvCbmx4nkd+
GDPOC/WHvte6MK6g4NopNT+ZUkTZ4Q==
=VuyZ
-----END PGP SIGNATURE-----

--U87MoMgTYp3o0nhz--

