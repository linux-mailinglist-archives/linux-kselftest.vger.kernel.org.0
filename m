Return-Path: <linux-kselftest+bounces-4525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31452851DB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25D71F2161F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7249946420;
	Mon, 12 Feb 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVJxBcyW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31A47A5D;
	Mon, 12 Feb 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765206; cv=none; b=qVgUoSkGoa7QAQ08JwuZ021N8FthEIBPGE+0c2+9jvaztyjVwsSDMEq0IeRKXtBRQYqbFk3La89NNGjbBDI9z+XYTiaulZhe5zDS3PvgNnd8LrECwm7JN7RtQdWpCN10Qt2piSXTukiyntXc9Nb9z+X6RpTo8sUlsu33k0CMFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765206; c=relaxed/simple;
	bh=lVcxz1blE5LkyB5fmTf0yVlJWy7lRWV3QJg/2l55jq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AITymmRmAb+huiUGETSzc5FROA4JT8OVbOrTaP2Jdv59N1cG9VXwx2XQj2MmF2MOk3leLPgH4IVqOzXLL8N7tvealpQ7q6QAthsy4J79VXSh4Sm9KwFonQN4DM5fQ9yUpYn/CDzpk0HtZQ4t2ku5UFTlAItEDOxLEIb89nloFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVJxBcyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720D6C433C7;
	Mon, 12 Feb 2024 19:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707765205;
	bh=lVcxz1blE5LkyB5fmTf0yVlJWy7lRWV3QJg/2l55jq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVJxBcyWkPzcN+qZv3RfniWWGIxIMuPq7cihILT1zdcW3PpqQpuzEdZHJken6yMyf
	 WAvjW6AvzVC/Co6VuJc360H0F+jOU4dobxIDBhHHRdK8myIQH0o+Noh6jug8t6imf2
	 wzUqv2t02CDOVpFwfoKz/h+43IHzgh+ccr7S2Yw4lV13r4imNb4G6OvsMjGX10Yl6W
	 RcJB2U4ED2FReuYFniuGnBBtdlP9YtKLEuasCecdh7rChvqi+bwPZ6R5wT6j6aOobN
	 /Gva6vrnLumFDO0SGBhGNz8ANC4jplUx/cK2rMkXBVVP73Zku488B0NWM0o9oTiUFZ
	 GhsLHp6DrGmTg==
Date: Mon, 12 Feb 2024 19:13:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Don't needlessly use sudo to obtain root
 in run_vmtests.sh
Message-ID: <75fa3e12-8b0d-407b-b11f-333be70d157e@sirena.org.uk>
References: <20240209-kselftest-mm-check-deps-v1-1-19b09b151522@kernel.org>
 <17c0b7a1-6ec2-4504-8287-f0fa111b9748@arm.com>
 <ZcdthfAvzLQ9lzvd@finisterre.sirena.org.uk>
 <9ff817f4-e999-4a95-b00d-6984a7ea6181@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uZViTPliezr/CpYc"
Content-Disposition: inline
In-Reply-To: <9ff817f4-e999-4a95-b00d-6984a7ea6181@arm.com>
X-Cookie: I'm not available for comment..


--uZViTPliezr/CpYc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 08:32:58AM +0000, Ryan Roberts wrote:
> On 10/02/2024 12:35, Mark Brown wrote:

> > Ah, I was assuming that some of the suite ran usefully as non-root given
> > that the only point of that sudo was to acquire root.  If the whole
> > thing needs to be root then we should instead have a check for root at
> > the top of run_vmtests.sh and just skip the whole thing if we aren't
> > root, but then I'm unclear why it's invoking sudo in the first place.

> I can't speak for how others use the suite, but there are a bunch of setup
> operations in the script itself that require root (e.g. reserving huge pages).
> Some of the tests will work without root, I'm sure, but I'm not sure its hugely
> valuable. Personally, I'd vote for just doing a test for root at the top, as you
> suggest.

The hugetlb tests appear to be checking for root while running...  I'm
not super fussed either way myself, I don't really use these tests
myself except in a general "keeping an eye on CI" kind of way so I'd not
object if people wanted to just go for just requiring root for the whole
thing.

--uZViTPliezr/CpYc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXKbdAACgkQJNaLcl1U
h9C6wgf/RJIOLX4PFd2MsE1xuGjw2/lCoxf8qoDdaoqGpAAVWq86BvYjlgCaB9H4
g6HK0IaPAvY0XWfuPV4ouY6OsbBE9DuvB7mwNbqG7pg7hKIdpod/fuev95pfWZbo
SnYocqjGxxYZQwPE+YqWcnbMIvkcboD+8gcIy3yle013yXOkn3dHdndPDpnNzAK0
+Sa8Y8E+pUt4pBJjLIuklEmf9tOfHakk2zMZk0JbF55KQVxcI6hPcENxZ7AGCEOx
cG8h/N3e/2luVdi7FqAKo7McRek9EQpIpg96YKBA+QX8xgjzEZ2komh6G9hBdvvL
Xd2XSTk7BozvqzbobHD0PGrBro40CQ==
=wlBc
-----END PGP SIGNATURE-----

--uZViTPliezr/CpYc--

