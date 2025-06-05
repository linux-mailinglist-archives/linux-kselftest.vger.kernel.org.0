Return-Path: <linux-kselftest+bounces-34383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5CBACF492
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2FB3AAA8D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501527465B;
	Thu,  5 Jun 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDizo1rU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592371F03D6;
	Thu,  5 Jun 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141781; cv=none; b=fd4WbBWvQ2WL13dgPO6UGgOdxw+Sv8yfzArLxkXx0oZbv4Gj4E28/EqPR2+2o5385LnYKjToVPtPFu1dPkVCqt0vp41Q5CHRzn75axB5My0EBCMlu51E7/wGzAhID+wvKkvGk2/a+MQcoGaGBvg6WQ4zDfOTLcOMyergYpr4N44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141781; c=relaxed/simple;
	bh=0r+aNnLmFMS7mdz7HvIsS99vO/nRpRQLOXs1kYWCUKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdguQd3qhRICrY8ExrJnCyzeF8SbioDMgt4u1zmTD390N+2qm7oLbG7ioMmTb9YLICghMfipd0BNQzfvE9SKB46ZE7aRCPBQuJYPMg44A9vCHFFQzviKqKdJILMSJ2RydDGOTuN8mitygor7xI9rdPtbsqWEOgpeBfMWclkKrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDizo1rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD65C4CEEB;
	Thu,  5 Jun 2025 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749141779;
	bh=0r+aNnLmFMS7mdz7HvIsS99vO/nRpRQLOXs1kYWCUKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDizo1rUZ9KLPEX+dPsq23BvqaU8uk/lkHpdNMqJByU5gntxauyNzO/QKk4H2RCbc
	 JqfucZjpD5dMBCz6ucakaWsjwIk6moVA1w+s7wlFuTXAxqpSSwcWm1U9i3J37wNqXL
	 tFAe5yBup5MT5KIb6OEMmy/+zW2vrxjo4dkl0Kn4D242A77sf3Z4QYMj4iooh4D2mv
	 6ZSrij3YjQdz4J63xsBF4i8B/8HlFl1MShRn3pXRVqnh/LiMPOD7uV+Fox4I6zjfdQ
	 WrXJWwT+6sk8AvJ+M+EesADr/ogdBM9vxLTMb3wxeiRmqtbsfH9yi+jcALajjEBfzm
	 Ri1/SVs5xPOGw==
Date: Thu, 5 Jun 2025 17:42:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
 <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1KSTMtpuZmSO6oKM"
Content-Disposition: inline
In-Reply-To: <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
X-Cookie: That's no moon...


--1KSTMtpuZmSO6oKM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2025 at 05:26:05PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jun 05, 2025 at 05:15:51PM +0100, Mark Brown wrote:

> > That's the thing with memfd being special and skipping on setup failure
> > that David mentioned, I've got a patch as part of the formatting series
> > I was going to send after the merge window.

> where did he mention this?

I can't remember off hand, sorry.

> I mean I'd argue that making a test that previously worked now fail due to how
> somebody's set up their system is a reason not to merge that patch.

Well, it's a bit late now given that this is in Linus' tree and actually
it turns out this was the only update for gup_longterm so I just rebased
it onto Linus' tree and kicked off my tests.

> Better to do all of these formating fixes and maintain the _same behaviour_ then
> separately tackle whether or not we should skip.

I'm confused, that's generally the opposite of the standard advice for
the kernel - usually it's fixes first, then deal with anything cosmetic
or new?

> Obviously the better option would be to somehow determine if hugetlb is
> available in advance (of course, theoretically somebody could come in and
> reserve pages but that's not veyr likely).

The tests do enumerate the set of available hugepage sizes at runtime
(see the loop in run_test_case()) but detect_hugetlb_page_sizes() just
looks in /sys/kernel/mm/hugepages/ for subdirectories and doesn't look
inside those directories to see if there are actually any huge pages
available for the huge page sizes advertised.  There's probably utility
in at least a version of that function that checks.

--1KSTMtpuZmSO6oKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhByQ8ACgkQJNaLcl1U
h9BaaQf9Hw7ugDXjeBvmEjND8ygIlFU2ID3I+VGXxWjM46ulNGznstKqLR52VpTF
GyHa6iyZko7UJM+m7zi8vKjKJFHcqXMwfCOmR/Tmh/sHl0f1Q6jYGALQcW8YnbHL
LE8EluuAiV4x0UkVomonbTFIkQhDkGYQ79Qbv3RA+24r3CVaSy1qJ7CW2HxnEUlK
FP6PeVrQN+8/qNM+716nC3wIHLrBPKfaw7yyLADeTsww3I/eCYOa2YZ94/0FSqQl
L0k/L8EG1WE1Hid187NCuYfGTVw/EmYA6cRAu4MYrbGjxV17Hj3n41owD8YEgCa0
ZhzMYim72uAG2J7a2SAfx0Pa+z446w==
=amh2
-----END PGP SIGNATURE-----

--1KSTMtpuZmSO6oKM--

