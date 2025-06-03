Return-Path: <linux-kselftest+bounces-34235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6043EACCC90
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF503A38E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1081F237D;
	Tue,  3 Jun 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxai5nHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF71F0E32;
	Tue,  3 Jun 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973333; cv=none; b=Bt9wYqoe/ouliAjwErZwNLEdLD66alrOs8ckCxSJBpbxqbL/PQJ6uJASTfZb1WBoGXmBb+C75e2r7b84Z67hCr05ZNGTvIdj6FLjijPxaMmxKDxgOHMA2T34U0CcyEruOQEiv8N089i81Olk4ZCGr8uR8V2DKKX4OMaJnogpCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973333; c=relaxed/simple;
	bh=BqpJYvEEm44Wut0dEbEcSr4ol/Oxc8jp7Jp3kQ74+iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azCF35hUAPw3F6eaPOdqVUILZ1MljMNly8LMC3HpT//Eb8fIMu5ixWmV+SS5ntbqqeIC2cv4sCyFjse1GZo0+CRrK1m0O1T8cFLn2FbDWfWcRcqi55zDdYkvgmQpnTt6cJv/Q7ygFPUJIuynIhIWvbLN6VbyaDKDQbLELCKYM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxai5nHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51F2C4CEED;
	Tue,  3 Jun 2025 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748973333;
	bh=BqpJYvEEm44Wut0dEbEcSr4ol/Oxc8jp7Jp3kQ74+iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nxai5nHZqWlBY5TDc4svlBTtJT8OHagNBIDoJDmHFQWwn/Oi28apk2DwLrDknmu+k
	 xRVXoO5KkD1ytkkP3iBuZpA+HnfdfcHIiIlqSw2Nhc4hbvCfT5MSEeVKwlhK6klNbN
	 8F7ZjmnSdHUw/amg5AdQ3u/6yWmi6nLPjsWUUqij/iVoMXN9LPYFRPPMWSu6O0piN7
	 yvfQIz5qTbyuXyrmnkWHWhAcSwt1my5bsbOqrzUdn9EmgbhuALaOhKS8/7+aRsCru2
	 WsFKfUXe9TGyoh8ygrgrLbvYlcIMJqv+23kCOz6r1dGGQ8yMtmj770TDWRrIJ7fnuk
	 rYhC5TInUT1Lg==
Date: Tue, 3 Jun 2025 18:55:29 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] selftests/mm: Report unique test names for each
 cow test
Message-ID: <2117dfe4-befc-4fe4-9b5f-184433299494@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
 <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
 <9961082f-848d-43d3-b97d-3df675ca4415@sirena.org.uk>
 <4676a010-a977-4d5a-b42a-edbbea7d356d@redhat.com>
 <e3d584fe-6297-403d-84f3-397a0fe459c5@sirena.org.uk>
 <df85fba8-826f-41fb-8850-077a4e4dd240@redhat.com>
 <e1d20dbf-734f-4a2c-915a-86c9fbac998a@sirena.org.uk>
 <27f74a9c-8bf9-4877-ba14-82dcd79f6d0d@redhat.com>
 <d35bdd4d-d210-434d-b259-97a4bb93c64e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9K5Lxces5yzC9hI4"
Content-Disposition: inline
In-Reply-To: <d35bdd4d-d210-434d-b259-97a4bb93c64e@sirena.org.uk>
X-Cookie: Avec!


--9K5Lxces5yzC9hI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 06:48:19PM +0100, Mark Brown wrote:
> On Tue, Jun 03, 2025 at 06:57:38PM +0200, David Hildenbrand wrote:

> > I agree that printing something in case KSFT_PASS does not make sense
> > indeed.
> >=20
> > But if something goes wrong (KSFT_FAIL/KSFT_SKIP) I would expect a reas=
on in
> > all cases.
> >=20
> > IIRC kselftest_harness.h behaves that way:
>=20
> That's mostly just it being chatty because it uses an assert based idiom
> rather than explicit pass/fail reports, it's a lot less common for
> things written directly to kselftest.h where it's for example fairly
> common to see a result detected directly in a ksft_result() call.
> That does tend to be quite helpful when looking at the results, you
> don't need to dig out the logs so often.

As was the case with the prior:

        /* Finally, check if we read what we expected. */
-       ksft_test_result(!memcmp(mem, tmp, size),
-                        "Longterm R/W pin is reliable\n");
+       if (!memcmp(mem, tmp, size))
+               log_test_result(KSFT_PASS);
+       else
+               log_test_result(KSFT_FAIL);
=20


--9K5Lxces5yzC9hI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg/NxAACgkQJNaLcl1U
h9AYLgf+ISgFWBb0M/8bRo5cBiZ0eLhHKK91ccJp2NsN17X4/KsfEJDXpDoU5jmJ
VBfAHk3KYWoNUHEgISMveAvjx7VNrbiK2rwtKz0MWtoj/IeUUgnVINfng7+H+sZA
1Cr6IiChsu/NX4rBUyoChrgKcPyj3VwI6/MaItC9nCblcsJdqCCpDOq/pg2R3WVB
0ZZWo2cOyOW68Bn+TO5Y3PhX2T6VonJbH1NedXvqU0zQOILaUxkvgWqwIDqgIEpX
2Eii26c8nDis/YP/4aty3w7lRi32KSP+eY3WyUNaDFQQNYY1CrvLbnUcladl7fBb
Bo4eil1iXsv3RyDy0ryj+0J7YzTVfw==
=7hL4
-----END PGP SIGNATURE-----

--9K5Lxces5yzC9hI4--

