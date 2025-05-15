Return-Path: <linux-kselftest+bounces-33075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515F9AB8313
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 11:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3494163DFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124B1296FC5;
	Thu, 15 May 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIBOxKPU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84E22577C;
	Thu, 15 May 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302100; cv=none; b=IKKEvXY8Jz8HVRzk+LSfh0DZP63HKiwcE74g9g7DCT1OjUiA42A9Z3idik2QUezO8TVKhtLJSrQ20erJbw3ZLTzpKc3ON5bnzL45jMi1DSFNnDlTIHY4OmZfDakCy+KK0xh6kLoRA0hG1RAApecxUaA2FJIO1o31Th579XkpRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302100; c=relaxed/simple;
	bh=PIH1LGWKL6DuoGRpzEA9ADgg6CsrjMR1p7WJhzMXFog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR5YQOnqdMq0YaecyzOxEdk30BmtXb2EMX4sjdTtJUez2KPRFYNrsVnUP16UDngL9ds2PAuxS+evTRb/ip9rnE80tLpFxa5lh6fRI6lCC1Hbn58xImcVTQKMY+lH8SeD+iuvImwiDKLTdnlebkkJSkZwq6TidhK73KbFpoQToX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIBOxKPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12223C4CEE7;
	Thu, 15 May 2025 09:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747302099;
	bh=PIH1LGWKL6DuoGRpzEA9ADgg6CsrjMR1p7WJhzMXFog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIBOxKPUosvxTGo7zvwAYrVpak/WWZcEtSSgpVZKI+6fdjyDVrkPsnJWV+lS0FIuJ
	 NJZBOheaWjg/f9RuifkwjQmOTcCUi/w67Tbnxuh/4bylf87PeW5smQfFRuGJ02dXac
	 qyfNrnuZ5VNgmovGP2SIDeJBOAdEB3J3Qce9/w37HtCgDfXs6PLSLlOM0JOBm9AizQ
	 Qi5fWPDjL2DkVKsZnL7ogWHvBoFCj0NTR+YjvWHejtOy+43hz9wZu43TXGGUq65idi
	 92/dGlG+ot6g6sLN9/ak7Vz4rNAsht1Rci5Uh9XQUWoW6mG4fSUIX8qb65KowLr9LU
	 pBV4r3EX7Iq5w==
Date: Thu, 15 May 2025 11:41:35 +0200
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
Message-ID: <aCW2z7xlQk2iyEP9@finisterre.sirena.org.uk>
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <7c2f66f9-a928-4fda-bf3e-4180c7525fef@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8DHGkHaHDjdXa2H3"
Content-Disposition: inline
In-Reply-To: <7c2f66f9-a928-4fda-bf3e-4180c7525fef@arm.com>
X-Cookie: Well begun is half done.


--8DHGkHaHDjdXa2H3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 15, 2025 at 03:05:07PM +0530, Dev Jain wrote:
> On 15/05/25 2:27 pm, Mark Brown wrote:

> > @@ -189,7 +214,10 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
> >   		 * some previously unsupported filesystems, we might want to
> >   		 * perform some additional tests for possible data corruptions.
> >   		 */
> > -		ksft_test_result(should_work, "Should have worked\n");
> > +		if (should_work)
> > +			result = KSFT_PASS;

> Missed printing "Should have worked" here.

I didn't think that output was particularly useful separate to the
overall test result (which is logged on exit from the function), it's
just the test result more than diagnostic information.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--8DHGkHaHDjdXa2H3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmglts8ACgkQJNaLcl1U
h9CmZgf/XQ9gLqG3rTeITwi7S9ASTdrZXNQxRJm5U+NDtqflavxs4pMGP7dqZAFA
QVHwi6RFrDVXvEP9vpHKnpWRLe2H2PMnCKjKFaXqt/ozLE7fK3Hp55NoFqpIoBsZ
XIbQdS/Ii31ZSH5LMvucIWOYj8asDPzaznzeQpwbyGuoalEHChxE4ZwjQhuXGU2Y
B1FCREt6aVrtBVo0U8jHG6HHxTseVCTEHS3D5EAt3CEzszxq+lqSsjCU8olUnIhh
N4GKGeuOmrEGe38BqWm6DOu5tDkGBaZaYUT82mASYvru9bpW+lJb+XzdYBGi3rjE
ZovQGpYdh1AfeWIjpIRHFivijv4wIw==
=K6Ke
-----END PGP SIGNATURE-----

--8DHGkHaHDjdXa2H3--

