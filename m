Return-Path: <linux-kselftest+bounces-34379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D887EACF3E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504F13A7F1B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9D1C4A13;
	Thu,  5 Jun 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1C3ytCw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345C1624F7;
	Thu,  5 Jun 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140157; cv=none; b=b1rdiEp0jZtC25TOIybaY5AVdOQ/SP0sEDygMYWOsf6p9cauXyIJwGZuHuHqew9zYzSFYNPdsakBK7PimWu0PG2oCl2oonlkrCGgM5fSKL8gqKIzoLk0fSpPKtCdiV2NaePMSPffoyC3B589rjoqaVHZIzJcNLUh1bNVTciup44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140157; c=relaxed/simple;
	bh=5chTMrgQJS2vmZa5XplnJeYkwgfYEOhwNWxnlCNJXYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjkMS7AIpZEXCO/Oc23Wnc01H6eI8BdDGu2xJ8BfI8kESdZglP/8ZSoclJ938PYS+2wsxKi7Gbp/Act0XumuJF4apK4mOwzi8zh2kFnLEvtFjGO27DXWEBehCrt8bSjgrIlaQPQVoJQprf5QseI6MA8/Dp7YksRQHaxwUzGcBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1C3ytCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E121C4CEE7;
	Thu,  5 Jun 2025 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749140155;
	bh=5chTMrgQJS2vmZa5XplnJeYkwgfYEOhwNWxnlCNJXYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1C3ytCwGT18Y0qV/xxv2qNGYZHjS2yR3yFvxeeLYQlVyOq/+vXAAYBPJs1YqQCnP
	 889PwElOGACTCQKo+AvCCl7OBZ9u/NQ7v335m5+aytdAek5Imq9G/rkaQJO5Iod1e/
	 rt9KIx7u8zSAQPV6ydutJ5WhT3ipEzF2d2EyI7/i0Eq1YQV3k0ToMb5Kefb6kE/i3G
	 wtM94kOgQLc5wlDfNI/1SeVzcewZw7RMTHREhuJMmMOOzKxeW+sUprTTmLv7lVAe3X
	 XlzEuIO78m4dMsPOLp8OH2ljQZ0h1JuRMnQU1yRhSa3+t2HeX8U3W/MEyKYJe+SwLZ
	 26su1QQ4Y0d/g==
Date: Thu, 5 Jun 2025 17:15:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y5zP/ODICYjBWB2e"
Content-Disposition: inline
In-Reply-To: <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
X-Cookie: That's no moon...


--y5zP/ODICYjBWB2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 05:00:49PM +0100, Lorenzo Stoakes wrote:

> This seems to be causing tests to fail rather than be skipped if hugetlb
> isn't configured. I bisected the problem to this patch so it's definitely
> changed how things are handled (though of course it might just be
> _revealing_ some previously existing bug in this test...).

> Using a couple of tests as an example:

> Before this patch:

> # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with me=
mfd hugetlb (2048 kB)
> # memfd_create() failed (Cannot allocate memory)
> not ok 39 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (2048 kB)
> # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with me=
mfd hugetlb (1048576 kB)
> # memfd_create() failed (Cannot allocate memory)
> not ok 40 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with =
memfd hugetlb (1048576 kB)

That's the thing with memfd being special and skipping on setup failure
that David mentioned, I've got a patch as part of the formatting series
I was going to send after the merge window. =20

--y5zP/ODICYjBWB2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhBwrYACgkQJNaLcl1U
h9BZfgf/ZkJKx9DMIc/WRlEi/afFnFOqjI8V2apX7B3CuS7klARJ57l1fyMdKlRd
3MRc5VRV31VuwmfYdIFPwqHzOnn6PEy7PHvtCwSKO9uCs/po21b3wMlknaaloFwn
2sDENLSd39sWNBlnqqcOVK7A8p2rjTkidUo8Qhhy3NfaoOCwL2b9iiL5gr59cily
YkwCy4Un4qDCryspKDr90H1wZGOnt0GbILGTWd/hNIsnwqvXVCG7WAZf0CvIoXSE
e3LHCIoLXa7w/qhdakdrV+MHWf7MYmFbbG86hks1Kl0Q1yy+/9pNAgLtYm4vQmZz
il0Wv7YKAdwiLTWWn/o2cL6qDoufDw==
=Cxj0
-----END PGP SIGNATURE-----

--y5zP/ODICYjBWB2e--

