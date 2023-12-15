Return-Path: <linux-kselftest+bounces-2035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE17814A18
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C479D1F22D74
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E172F50D;
	Fri, 15 Dec 2023 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBTZBoq1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00F2FE38
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 14:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492EAC433C7;
	Fri, 15 Dec 2023 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702649319;
	bh=okSgGhXbA7jv7PYv3aOaGmkSnHJi/b4ZJ2QQUGo1hE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBTZBoq1+iQkGRVYX1YBosbG8NvpzXsCnTkexH22fiVEd0BZjn5hNX1xjLrS9ndOq
	 RdGlQstIEKr3MnORc5io9XKzJcpb52DJ91nHnPWrFAkD+C0vclx1fEH5XVISc3N9/P
	 hY3PwZ1T0wDFBCIQuAccua16NjIWpr61IxKzVjQ4Bom58e9IAhSge7S0aC1IJtpKBU
	 HTtLhcXCOB65ekGGTVDVl0+o4yhOOozYzwsCf2rYa9PGXklKHmwQrI91kHDDDRAuwc
	 Y/1fhjRGZxb0Xpe6jask0e8JDJkDP40s1Sq1Ma1pLYjOLg8LH7D/wZ/Kd7GAMKHbwR
	 WKvbSE4CekMKA==
Date: Fri, 15 Dec 2023 14:08:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] selftests/mm: Log run_vmtests.sh results in TAP format
Message-ID: <07193932-941d-46f6-b152-d6c5fe09b26b@sirena.org.uk>
References: <20231214162434.3580009-1-ryan.roberts@arm.com>
 <e2296501-e9c9-4bc6-88ba-1e43ea083d4a@sirena.org.uk>
 <71228821-cbd3-4a3c-9ed5-18f6d5ebcfc0@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f+2JQejhDS1Wuetd"
Content-Disposition: inline
In-Reply-To: <71228821-cbd3-4a3c-9ed5-18f6d5ebcfc0@arm.com>
X-Cookie: PARDON me, am I speaking ENGLISH?


--f+2JQejhDS1Wuetd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2023 at 01:58:45PM +0000, Ryan Roberts wrote:
> On 15/12/2023 13:54, Mark Brown wrote:

> > What I did for ftrace which had a similar situation was make a wrapper
> > script which invokes the test runner, make the test runner a
> > TEST_PROGS_EXTENDED so it's not run by the kselftest infrastructure
> > automatically and make the wrapper a normal TEST_PROGS.  Neither option
> > is especially lovely.

> Yeah that's a good idea... I'll wait and see if anyone shouts that this has
> broken something. If nothing is broken, I think it is better to just make TAP
> the default rather than adding yet another wrapper.

I think it depends a bit how ergonomic the non-TAP output is for
interactive use - TAP isn't amazing for humans so if there's something
that's nicer it probably makes sense to keep that as the default.  For
these tests I'm not sure it's particularly an issue.

--f+2JQejhDS1Wuetd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV8XeIACgkQJNaLcl1U
h9Ck6ggAhuC0QWySvod8Jg1qZk/6j+1docp1X6o3rKOOF5lwxkT6yFwzmSPHVc8l
LUhUHNfyZXwM9Snihy3eqhWAO5CdzqH0IBs4FHDAaA4jxue6KyplNQzLz3fQAuku
uxT3pLgNouEnlNuURodgTTC9oLudxi9Lq1wsTufKszQ6gt/DPW5pavVebavV6Etb
EzRhwUZKC0f3mYgxGXxmqdUSF9nb+B3cARBjJjwZNdCrPqqCwi3Lso82Oh1vXi9N
lHW6HeiLy5oLaA8PFGA9bfBjG2zf5DSyYZ5nW6Xeht3/HONlUhRJcKrBT4fvR70k
GjsmMx63yGCVm3EdYYN2OAh8wUqyxg==
=k5vr
-----END PGP SIGNATURE-----

--f+2JQejhDS1Wuetd--

