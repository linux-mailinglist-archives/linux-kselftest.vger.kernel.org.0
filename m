Return-Path: <linux-kselftest+bounces-12870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA4991AC75
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 18:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93E72818DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25D2199234;
	Thu, 27 Jun 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svF3Df6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7D15278F;
	Thu, 27 Jun 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505247; cv=none; b=i92SNB1hKyPmCmmssFxRdVfh1VKQg6KMr4EFMVbUR00JN4JICAMBSKg5ULmYppG6JexnSafQkfSvUFgrSezkIWnoAqzWpVqaV1/+X7rg2J4oeOxphBJyNvIUgdLc/kXXu/PTz8EDs0uBQbU0zkEz1GMopyZ+CPSZX1jqLBqBlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505247; c=relaxed/simple;
	bh=+UzFQcsqPwej9OyhtN9+EQUIjdFKWYkczGKK/2remxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxAiCw3g9k6Nxv+dEDnw6g1iQpx9FszHuzpZbT4nOmW23h6eTTV4lrr+NAzdvHIW61oNfhvmpajCVDzSf4gwkZE897R1EHAvxy0T0XYxrfbDMMFaG5aYSBMGR4fomnpTYS8s+FepsLoaXwGrNAjNprCqLZ6g818kkH8DkrvCorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svF3Df6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B703C2BD10;
	Thu, 27 Jun 2024 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719505246;
	bh=+UzFQcsqPwej9OyhtN9+EQUIjdFKWYkczGKK/2remxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svF3Df6p4Q5HnY23cPs9krYUtxqK+/Pcde1tkSw8iPrFzjPLnMtkrPlkT2ZYr7Y63
	 CMwQ/zbReElBx/5KDmsRTZUKBeuEW4AtHcN4mjfor24aSHYxBks5UUCe6MvRfSHLsq
	 7TPm9sM0tzkKCnaUEqC4lvc6HD3JnhTyPUOkBs9kphnESxEZIARsFAVbrZQENggN+2
	 K2xvDPZYfIgCEae+6M02a5bl8OxnoPUSReAwkQB20wlp69Xp/SkpajwMMGwXd+e4P2
	 wj447dg/lhEzTLpppQ3PBiXNISQ6yWSODMPnECFVWLkflrD21zwuyZ+tbY4MUja5QZ
	 /RhIZoP0lJayg==
Date: Thu, 27 Jun 2024 17:20:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, oleg@redhat.com, mingo@kernel.org, tglx@linutronix.de,
	mark.rutland@arm.com, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] selftests: Add a test mangling with uc_sigmask
Message-ID: <abf04162-0518-4582-be40-59aa79ea6ce0@sirena.org.uk>
References: <20240627035215.1527279-1-dev.jain@arm.com>
 <20240627035215.1527279-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S7H7r2NFo9x0k4c9"
Content-Disposition: inline
In-Reply-To: <20240627035215.1527279-3-dev.jain@arm.com>
X-Cookie: I just had a NOSE JOB!!


--S7H7r2NFo9x0k4c9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2024 at 09:22:15AM +0530, Dev Jain wrote:
> This test asserts the relation between blocked signal, delivered signal,
> and ucontext. The ucontext is mangled with, by adding a signal mask to
> it; on return from the handler, the thread must block the corresponding
> signal.

Reviewed-by: Mark Brown <broonie@kernel.org>

--S7H7r2NFo9x0k4c9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ9kVcACgkQJNaLcl1U
h9AIuggAghJzyx0Cu8MOXzuXnZS8SRoBLCFv0yU+iQxhbowKEnZq4mLEq9JlluoH
dQZTHobTCb06yy8sFXgcrwnVjfAg8UXmasCjUYnNMYfVti1KfjnSB43PEK2L40oQ
F9Wq7wDwKzXKBKIlXp9G2jZgy3ekZ9PT1umU5XJ5QRp17HOmBvha2paUmSLD9DkC
FuOEP+ge6pey3D1cWMMiu5MPv0R87VFBHYS1ybUxEKO1qNwMFf80o5gN5pzgXozy
PnhVz/u/FmiQZqveiAargX+XiWi0Ze7rQ6gNTKUBIA2LvLlww71QChzczra9eMEm
9hOyUlwP4KQFZOECJO9uYP8ngRlVqQ==
=fUDU
-----END PGP SIGNATURE-----

--S7H7r2NFo9x0k4c9--

