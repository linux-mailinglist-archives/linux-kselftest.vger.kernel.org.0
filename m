Return-Path: <linux-kselftest+bounces-30057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B7A7A226
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 13:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBE83ADA12
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2124293D;
	Thu,  3 Apr 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0m3c5Q2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE114C5B0
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743680972; cv=none; b=Mt+O08zoXrykpMqvLD5ROAGuyNiFnu4W1caY4bxJxXJn3N5o16TwUT6jRb23yNqMshaymP2255Q9mL1fxJOzQsqjVs9h36TzKQc7m1un0nAZfA+FLU7FUC+GPyOrzmxu90rCTUDxcHCADjH/vm5VsFFuQf0fUNxLfvZR/Y/ha5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743680972; c=relaxed/simple;
	bh=/hr0Gpj9fiNlcXJIG5LJxg5hRVj4WPbA4PRO2gcmDh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLvcUStjd30au8hniP3fgBPQYMgw6R6f+vgLB3odmja6koOYsxLn0jNODnKcW+mh+5Yp5hUACNewokps28R4GJJgbzQZC8GAZMwI/3qtTffbEk6H+7Nzr1HSvNmZCLpDR7z4gWtCUbcWwENflXuFGKjX9iZ7eDkbqf9eYUG6kTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0m3c5Q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A18C4CEE3;
	Thu,  3 Apr 2025 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743680972;
	bh=/hr0Gpj9fiNlcXJIG5LJxg5hRVj4WPbA4PRO2gcmDh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0m3c5Q2lBkFKKy1vFdA+/ghfO2N+6BHwd1CX2Mrd33fgF2/A81Xyx7EqaIPUa4Uj
	 QhP2ryxk6mZDTyCzv4vzXDXL8w8dvpmhhIHP0n/B7IlzkZRvqArEJu314YznNN2dR/
	 X9J3RLrIs+G64zAs3QvfX9i4deJO5B3qqrPxNmmnSiQ6h6g83XDfBFaurfzWVrH4/C
	 Lo5CsfVX7l2YJ7EHbwJZLdoz8Nrlagxt5EpTKVIueKRKTVxCwSoxaMQStw6rIbGuyj
	 zBVARGn4qEgIqwm9KPqwrpWo5HYBhzhi7mm49pTFJVIpif2tIaUdaWrz5TdfPdoAix
	 j9LW6RColo4Bw==
Date: Thu, 3 Apr 2025 12:49:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
Message-ID: <a4bf28ec-b3f5-4d9f-a042-ada584d0f63c@sirena.org.uk>
References: <20250402103655.3e0c62d7@kernel.org>
 <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
 <20250402155644.67b2cb3c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fKSrcYGid2z0Iz17"
Content-Disposition: inline
In-Reply-To: <20250402155644.67b2cb3c@kernel.org>
X-Cookie: Logic is the chastity belt of the mind!


--fKSrcYGid2z0Iz17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 03:56:44PM -0700, Jakub Kicinski wrote:
> On Wed, 2 Apr 2025 18:55:29 +0100 Mark Brown wrote:

> > > It seems like new cases continue to appear and we have to keep adding
> > > them to the local ignored list. Is it possible to get these fixed or
> > > can we exclude the cirrus tests from KUNIT_ALL_TESTS? =20

> > This is the first report I've seen from you...

> More of a test balloon that a real report as you alluded to.
> I was wondering if it's just me, and from your response it seems=20
> to be just me.

There were some reports of things but not ongoing ones - that's where
the fix that was queued came from.

> And the problem reproduces on recent compilers, too. Which leads me
> to thinking that the tests are broken but stack init covers it up.. ?
> Strangely tho

> 	make W=3D1 LLVM=3D1 ...

> doesn't report any uninitialized variable warnings.

I think there's parameter passing by pointer which manages to confuse
matters.

--fKSrcYGid2z0Iz17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfudccACgkQJNaLcl1U
h9Achgf9FLSRqm4e4nKyunvWq++Wzi1oh4xXkPzIV2JmgtKgWm1TuigyuSTMx1nZ
uiNIoGT4f3sd/0Fr/OfC7GB4L/2kDcAAwi6EuW2pgSAnZlWh46TvsGocvg5rGaKA
wNPJiY1GYuC4kFc8y7OqYRkPIZHi9mO2E2uqlhWEikx+L0e0mWNAt6kUl+RH6yuI
7+P462MwaBKVEwkAHSRUndQMVKZzWf8CG4OcF5UQb8f4bZN/duWNTrUlEFxsiRYT
hbk4uBiYc1zJdIx22AGhOHdASWnoIi1TkJw5rnjKGEJkFxTOX2WzleQA4TDRmhtU
Pgw3wDardWQmmA/mme6TenYq74R19A==
=KLQ7
-----END PGP SIGNATURE-----

--fKSrcYGid2z0Iz17--

