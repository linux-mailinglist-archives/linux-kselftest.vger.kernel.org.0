Return-Path: <linux-kselftest+bounces-34221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE72ACC9B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FA53A6C89
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302FF239E8B;
	Tue,  3 Jun 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTUlMTKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C83231A55;
	Tue,  3 Jun 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962705; cv=none; b=ap2+my1Rzq38bI95plvWHpScyfdrgsSFNNoMOVNzaPIgy5nReA4Z8TlPCvsOJzLJz1jTJJGwHLpT/xLVaB/+pi6vEMqUyB/HmgFGShlHDQwRU9wL5SFUnhERTKArOb0jZRIhsxWCTrhPIlv6moLkGSDygxaSqKX3ktisskpISMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962705; c=relaxed/simple;
	bh=TGSwb3f9VkAuQUVJZVwaW42OFUVNk/Z/EbK4iD38jJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+jvi2tJODeid3AOb1i9j0170yBS6ZbsLIQlJLS2jGhWZAAv+lFb4ci7/8BUlQHTFdxfx5GxQ6TVHtY3cpjLk9O2x/cEQbeEv8pgQFIACrM7sAo/DBhWrqFV6v9f1XrX0XOyh3BpqQBJ6Qvz7Y4CaIAcmjuJVXDYrUlqZ3XCBM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTUlMTKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38B8C4CEED;
	Tue,  3 Jun 2025 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748962704;
	bh=TGSwb3f9VkAuQUVJZVwaW42OFUVNk/Z/EbK4iD38jJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTUlMTKOt9Zsui0FCCint1TzbeUO9e5ZIt2YhaNLiokT2Peyf5UXPVkgI/XaQaF1t
	 tEFzrl6VXa5Ptw96/qfnOJI4BmysR0ngSC7d/nF9KSJek3Kg2DIw1Dr3OkDDSabRn9
	 g6RVpEEnY0o6Ho2DNsxF9eju7jl8I14Kww55ggkHsGpe0vy5Y/j/BKTnK3oGaydMug
	 FkYW+ftf9olb8mrjbMyiL1FI+wLuukbWyhM8O0G3CxkGz+4KFEJB3mvag+lU/JkXGU
	 5A9Zz0Ds0+nMIMqLjrqSyd81ATyFcoahJGWNh+djvS/UcxSgdNgvH6paUeoRwpE1n1
	 jmt5qkt0ZnUeQ==
Date: Tue, 3 Jun 2025 15:58:19 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] selftests/mm: Report unique test names for each
 cow test
Message-ID: <e3d584fe-6297-403d-84f3-397a0fe459c5@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
 <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
 <9961082f-848d-43d3-b97d-3df675ca4415@sirena.org.uk>
 <4676a010-a977-4d5a-b42a-edbbea7d356d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wGBcazC2iMDwWARG"
Content-Disposition: inline
In-Reply-To: <4676a010-a977-4d5a-b42a-edbbea7d356d@redhat.com>
X-Cookie: Avec!


--wGBcazC2iMDwWARG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 04:15:42PM +0200, David Hildenbrand wrote:
> On 03.06.25 15:21, Mark Brown wrote:

> > > >    	} else {
> > > > -		ksft_test_result_fail("Leak from parent into child\n");

> > > Same here and in other cases below (I probably didn't catch all).

> > > We should log that somehow to indicate what exactly is going wrong, likely
> > > using ksft_print_msg().

> > Can you send a patch with the logging that you think would be clear
> > please?
> > I dropped these because they just seemed to be reporting the> overall
> point of the test, unlike the cases where we ran into some error
> > during the setup and didn't actually manage to perform the test we were
> > trying to do.  Perhaps the tests should be renamed.

> ksft_print_msg("Leak from parent into child");

Can you send a patch showing when/where you want this printing please?
Like I said I suspect the test name is just unclear here...

--wGBcazC2iMDwWARG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg/DYsACgkQJNaLcl1U
h9BpSQgAgFpxD0Mdq+PItFzumotzCmYbtGYR/xoJWOSeJ8XI0ORcZjN7ykn0FC63
ZWCqxTN5cLYFmVJQScqkFqPs3FrCpf+g7wHLcFomkFBF7Ev1GHTyf6fTPKcUiLZb
kg6NfIW9SiH7jS2Vzf4q5EtURt+U+hWy5775NkBOLp+nIghWFLxoOVqEClVykTLV
w3DPBxt8WZGAeXY7buhlDMAqBwZd5K+LkP9oJnxJwATmtUpyWEJyfnFwriCDcGY9
CyheODCZxRsbd5kqkFmgqRTDDM1H/+SG18BxHGULOpMdbfIxIYhmu4NFyy2wg9ov
M14YSDvZv95CZVPSq81cUWoCuiseRg==
=DEII
-----END PGP SIGNATURE-----

--wGBcazC2iMDwWARG--

