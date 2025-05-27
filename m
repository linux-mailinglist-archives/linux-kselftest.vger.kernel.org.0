Return-Path: <linux-kselftest+bounces-33855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F68AC4F4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB357188751A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4D8272E44;
	Tue, 27 May 2025 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAoARr4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A1270EAB;
	Tue, 27 May 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351187; cv=none; b=kes1J+4acKnN6SnC3kkv8JvoQaMPM3OcUa0NiTq8lZQ7IUOPBtKOYxBgbvK0Hft3/AaZWM9AuEwFH25BDvmryK1xNfQPn9xssesqpuIjvMjut8FgeqMBn99vijhcwEYHXRqlbQXVQlFPhCs8KDegAhDwj8c4FSLO6GVE24DtXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351187; c=relaxed/simple;
	bh=gojxfHrjWmS0e9hNZaNQ2ayB5aaFbe2vzQ0a9DpKHjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umu9azRCRGtACGMZHiHLzja6qsIhNSJzy250qxJG0HAxPqSOWz0ag44H38b6aXxqS5hC/kXf10rUlyrLxnJ9bE+UAmHHiKskl1/BlVHKWkWeJGtARcDFl9TTDy3phSwMx1grgS8hq3eKtgH2yEJQtfbSt/vfuscKSkLz7/lo6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAoARr4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F0FC4CEEB;
	Tue, 27 May 2025 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748351186;
	bh=gojxfHrjWmS0e9hNZaNQ2ayB5aaFbe2vzQ0a9DpKHjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAoARr4A9icD0AIxyWaEUIwljB5URMOSsdFWRVVlRKVqQyA0Sj1cms2FkfA2pDFBh
	 sf3qYeLY6D52jG7XDDe+OQvJ8HdyTzlOVBMdAN80XIDBr3BKr+XYXFsMajt4NsXCk6
	 ah9hpe4Dh8ZCBX4HlLOms4x6+yr163FMSUJD9LXn1drJJg2fFNxvA0uHi+DT13YMSn
	 eDkP1RSlBVwMIvJRb79alQNbvsaO4fuu/vC+OoJ2JjgphhKtfaLAhG54HKMIsu0YK2
	 lwFV3e8tkRAm3svzXBuy+D2vUgrilUWZHZHfc9gZM12kV3KQ07AAvx5UxlH/Vl55fS
	 a7RzFznorVpLA==
Date: Tue, 27 May 2025 14:06:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests/mm: Report unique test names for each cow
 test
Message-ID: <d09e1347-bf13-48f9-91df-2b90f6d15a16@sirena.org.uk>
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
 <20250522-selftests-mm-cow-dedupe-v1-3-713cee2fdd6d@kernel.org>
 <3745cced-199a-4c9f-a282-d9587f2edd41@lucifer.local>
 <3729c741-fd02-41f9-9668-7575871e7acb@sirena.org.uk>
 <675ce51b-a218-4fe9-a571-56387d72fffb@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4/1W5cdaGZgna//I"
Content-Disposition: inline
In-Reply-To: <675ce51b-a218-4fe9-a571-56387d72fffb@lucifer.local>
X-Cookie: New customers only.


--4/1W5cdaGZgna//I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2025 at 12:53:30PM +0100, Lorenzo Stoakes wrote:
> On Tue, May 27, 2025 at 12:49:57PM +0100, Mark Brown wrote:
> > On Tue, May 27, 2025 at 11:08:05AM +0100, Lorenzo Stoakes wrote:
> > > On Thu, May 22, 2025 at 06:38:52PM +0100, Mark Brown wrote:
> >
> > > >  	ret = setup_comm_pipes(&comm_pipes);
> > > >  	if (ret) {
> > > > -		ksft_test_result_fail("pipe() failed\n");
> > > > +		log_test_result(KAFT_FAIL);
> > >
> > > Looks like a typo here :) Should be KSFT not KAFT.

Somewhat impressively clang is managing to build this perfectly happily
locally which also isn't helping, I can't figure out why.  Can't see a
system include with it.

--4/1W5cdaGZgna//I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg1uM0ACgkQJNaLcl1U
h9CaVAf+JhWl++5YMVRG9vFo1ImCJZI5FYFQ7mJZ5LUojovZL3fv7CYCLupNXGmR
tCOTQ6FtIL/9a2jCABBUqzlvFTec7adrYq3pKPbsm7X1FjeAFG/VymJ47iUx299+
Wk25StVVUHt+nsouPYCvP2CNIyHHtq9W6mqMiwRzHViGS7zh+DZT9/v8g58+//9t
ePRYSCwChmsBG3/PLIyxD+ZAv9zeqyKYb75ByuwR3qPzL97t9kUIMB1/YjWw9X+I
88GoCkig69ASPINvlnAYmJ3cTGsDR7tliKVajf5mRZL0wiUyHeMrdSr6KdjsimNt
3AR+MJOFZrNpw44eodNmUopXcMdn9w==
=N4RT
-----END PGP SIGNATURE-----

--4/1W5cdaGZgna//I--

