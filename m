Return-Path: <linux-kselftest+bounces-11755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C520990509A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 12:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECE5284645
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480C16EC04;
	Wed, 12 Jun 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oktXjwWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42416E881;
	Wed, 12 Jun 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189008; cv=none; b=sPPBLByf++gj99MU1xLsFTL37W9NYhxi+sYdIQwHLyyGon962A88MZJRYrAZNdqQ+wNEc6q/Ys7lEJBxQhXKSSyLhwWL74LWnIneejtcqxdGpBAMuEmPjdKJoWi9ZvaP97zil2bJSXqkixXIu0oG7sxLTMcCKilsdEs9hgkpw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189008; c=relaxed/simple;
	bh=i0AkVG96HZP+xZlgakshFx4WYDgJ6NHv2HEdMjfHNzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj/YibfbEiEl47f41N+t+jnhxm2KWcLg33AVj/p9qYtkhL2SuxnrNjX0f3DHX56mxVeV9DRYL0BUiXMNWpr3GYPZIOfo8L0k6KO0Gd3tpQLJc4IpISahs+JjM4ZmHJQkrtksBTx0by0H5cYh0UMSkIlvHiMAdH38A9DM5YC5F9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oktXjwWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DE0C3277B;
	Wed, 12 Jun 2024 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718189007;
	bh=i0AkVG96HZP+xZlgakshFx4WYDgJ6NHv2HEdMjfHNzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oktXjwWY0SjBMdlI1iZB4rWkwiB5T05GruABT09QkcllcPLknmNITngDkJ7UMNaVV
	 7Fdv2sgReaQFCD3tdrl+PQWXYifjYJ4Dsyu/D0h8ZZtxyCNx8tErP0cfR9Naw+Enng
	 GPYw0bbfHVB0ppCEf09EdsHw84edZ2TvDOlkyLjKvx0P5Ib9CTIJOUHsjyrq1jdnnb
	 YhpATUXX70LETG2uNLsk5gafHeLU1rcxvHvBx0p54u3Dc/gTG82bVYjiOv+5hjpcQL
	 g8YAI2sdNPrGmcGDYJD8lbWIOgr1cRe4XJpdcBR+1HlfgMfZZFdOBxDWsM9gzaV21H
	 Yu/8O4vQJkbDw==
Date: Wed, 12 Jun 2024 11:43:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: mm: Make map_fixed_noreplace test names stable
Message-ID: <Zml7zMzgBLEpMm8J@finisterre.sirena.org.uk>
References: <20240605-kselftest-mm-fixed-noreplace-v1-1-a235db8b9be9@kernel.org>
 <20240611152317.8e72edb3a545a685a2a0b395@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="taj9yIMJlp9FRGvc"
Content-Disposition: inline
In-Reply-To: <20240611152317.8e72edb3a545a685a2a0b395@linux-foundation.org>
X-Cookie: Your love life will be... interesting.


--taj9yIMJlp9FRGvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 03:23:17PM -0700, Andrew Morton wrote:
> On Wed, 05 Jun 2024 23:36:12 +0100 Mark Brown <broonie@kernel.org> wrote:

> > KTAP parsers interpret the output of ksft_test_result_*() as being the
> > name of the test.  The map_fixed_noreplace test uses a dynamically
> > allocated base address for the mmap()s that it tests and currently
> > includes this in the test names that it logs so the test names that are
> > logged are not stable between runs.  It also uses multiples of PAGE_SIZE
> > which mean that runs for kernels with different PAGE_SIZE configurations
> > can't be directly compared.  Both these factors cause issues for CI
> > systems when interpreting and displaying results.

> > Fix this by replacing the current test names with fixed strings
> > describing the intent of the mappings that are logged, the existing
> > messages with the actual addresses and sizes are retained as diagnostic
> > prints to aid in debugging.

> This sounds fairly annoying and I'm inclined to backport the fix into
> -stable kernels(?).

It's annoying but more of a UI issue than anything too serious - for my
setup it just translates into not validating those individual tests and
instead only paying attention to the overall result of the program.
Personally I'd say that it reaches the severity where it might be worth
sending for v6.10 but not to stable.

--taj9yIMJlp9FRGvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpe8sACgkQJNaLcl1U
h9A3rQf/X65fpQaBQdsPSyX4tv50iov2KxXIBmL++mft/PrqcYvGNIQAtxXjeXQZ
Q5f7YQ4YcCHlUCjw3ic7zLPox1YNobi7ZBSCU/QvZ9YeWhA3/Ud8Q9CdYPKwx3ZS
xhK9NZpQ5WO2QOmtRfSLkdMCTnYV36oM4K4gb9duQOJtEZfh769/AmbVzLLnCoab
WIlqmwoMrkfMieNk+H8z/1i2jFWVTxHRiM73dMv6SiWCIjQbMixCXlOMvsf9bCYc
6Eol5gIsfEHmL7qbVi+d+MLC4uypLuA35Mtqvez3EGl1spWKsjV9NsxA2kD7hyVm
CE/qEsbVD4KHawxWtsoSbAT4PyHPfw==
=/+tZ
-----END PGP SIGNATURE-----

--taj9yIMJlp9FRGvc--

