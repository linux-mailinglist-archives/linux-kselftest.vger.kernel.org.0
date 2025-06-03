Return-Path: <linux-kselftest+bounces-34231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3748DACCC6E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 19:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E044F3A2A73
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81931E5B65;
	Tue,  3 Jun 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZS9ofb0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9ACA937;
	Tue,  3 Jun 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972899; cv=none; b=fyJ1FKIMtSz6Uz5VlAsVCoCEAdnNZUcuQ0UM6IrMpTxIprJclN0Xwo0Hq2+jN6a3OfgnVAK9y22sFOCAF9BlwXO/wFCBLvL2I8jK4njnSouvCGU6K/2xHwBwDLBZCI/XDSk52EHlOa2AaJgVfYQj3ABbw06LY7vVvWYkc+OKuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972899; c=relaxed/simple;
	bh=/bJik437uCvG2J2xH49twy7gVaKeJgLVX8yKO4jtZdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaXw+9DHvYqivw5VfwjLg+v1qDjcvuQZF1Z5RRWCvegrHT89a0Zd0QMmKRJH+0h/Rw1RVJzMk5RhnnlwsAcGo7RQQTrTd0qnmq7Y1JHce7j9L8PWzch5++y0M5jOOq6NOp2a7265l7qnV8Rb4wz6p/J2UgNeMP4hi3dGJIcqbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZS9ofb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85648C4CEED;
	Tue,  3 Jun 2025 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748972899;
	bh=/bJik437uCvG2J2xH49twy7gVaKeJgLVX8yKO4jtZdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZS9ofb0NDaPjvezgv5QXCOt2mP/X2g1DEpaax2ccunqkgZnmUYy88EZfLl200LbJ
	 qIUBgvy097dB1hP+/t0qK7Ja58+QAbwa34N4neFBKUC2OT9Jhe9Nr1j0xXJoXb0LUw
	 I95vCMb6WkDNXBGB3i8TiQB25B9rsco/q6yJy68UEzabzB337gBeR1ZhBuyEDgFoXn
	 jl9xbI4LELCe238jjInxcsx81oVqluL/afJ+z4R3Kma8cJWE0ER5R5xHRfjUmtv9Hi
	 9yuo7+ZzBLm7XZ57NYsbVRpAnNA0tnRHHHKxD9q8PAvH2ctgLE1FzuIVVJRcvjQQCk
	 G1cNlJtk968qA==
Date: Tue, 3 Jun 2025 18:48:14 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] selftests/mm: Report unique test names for each
 cow test
Message-ID: <d35bdd4d-d210-434d-b259-97a4bb93c64e@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
 <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
 <9961082f-848d-43d3-b97d-3df675ca4415@sirena.org.uk>
 <4676a010-a977-4d5a-b42a-edbbea7d356d@redhat.com>
 <e3d584fe-6297-403d-84f3-397a0fe459c5@sirena.org.uk>
 <df85fba8-826f-41fb-8850-077a4e4dd240@redhat.com>
 <e1d20dbf-734f-4a2c-915a-86c9fbac998a@sirena.org.uk>
 <27f74a9c-8bf9-4877-ba14-82dcd79f6d0d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Um4wpX+2twulJPeY"
Content-Disposition: inline
In-Reply-To: <27f74a9c-8bf9-4877-ba14-82dcd79f6d0d@redhat.com>
X-Cookie: Avec!


--Um4wpX+2twulJPeY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 06:57:38PM +0200, David Hildenbrand wrote:
> On 03.06.25 17:22, Mark Brown wrote:

> > Like I've been saying this is just the final test result, in this case I
> > would expect that for the actual thing we're trying to test any
> > confusion would be addressed in the name of the test so that it's clear
> > what it was trying to test.  So adding "Leak from parent to child" to
> > the name of all the tests?
>=20
> I agree that printing something in case KSFT_PASS does not make sense
> indeed.
>=20
> But if something goes wrong (KSFT_FAIL/KSFT_SKIP) I would expect a reason=
 in
> all cases.
>=20
> IIRC kselftest_harness.h behaves that way:

That's mostly just it being chatty because it uses an assert based idiom
rather than explicit pass/fail reports, it's a lot less common for
things written directly to kselftest.h where it's for example fairly
common to see a result detected directly in a ksft_result() call.
That does tend to be quite helpful when looking at the results, you
don't need to dig out the logs so often.

--Um4wpX+2twulJPeY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg/NV0ACgkQJNaLcl1U
h9BEpwf6A29UZlTq8RsOX6S08/JBBgyWvxg5Nb4Q6Y18BqZ2o7rpodQ+A8CRQ337
VwySqLAvBK14tjny7z3LnB7KKZXcjLCGicuiCZuynUQMRx0O1to0eRSjdg58qMhx
jY5e623v9gjH1Pq4g9/LlzEL6jznOSVywEUhA7FzFb6Nl1t71i2zTFSmraKdflYU
GVXShtTmcs/nonWoglyLQJ5eWoftKee7zD+1DfgVNsbk+mlGV2USHK6sgbyjSFoQ
/yn2EwEoLW8TLj3Bn1GPKd3Dd1keYnUBZhKIhcNVmgwr64fk6WsQ1sLu75HDgfJk
bejoc6AuiGMtlinx2I2ckuxlCHywmg==
=mrN6
-----END PGP SIGNATURE-----

--Um4wpX+2twulJPeY--

