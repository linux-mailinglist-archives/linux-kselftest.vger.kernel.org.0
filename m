Return-Path: <linux-kselftest+bounces-7312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2089A394
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058261C212E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8817166E;
	Fri,  5 Apr 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6N/FSEA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3971DFEB;
	Fri,  5 Apr 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338685; cv=none; b=p+vo3h9nhilGjSaGL8v2Zj7qYR/w8ibd3eYwuDtLaUPcSPhATdcTJ0pzd8+U2LB8rA/LiPxu9BB1iIRfl+Fh52mMUoREm1LcfmqDmYqXHOO0UqXgzvhTwG3sl1BaCy4PhhiQyoONsT6Cg8d2vuUewy8S6OKoFqTlllVXe9ufW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338685; c=relaxed/simple;
	bh=BtFNOGP9wi3ejmbHnY9IlajWZjGrS6wdrz8DT1QXGCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOmHjJjPiBuPPoCt3kuJZb6Lh9fJtx5quUPiaWdqZAtQi9OpZBBUgdpZdxoXcVMSGU/opOLq2LCJNJWNeR1MCS8rwVp6cWhBON99xS5f6GJXaosEpzN0aH6b8fm5ieDtMIWuKm4OtFPCcsqlNGUiRKbtp3daRxbX2qz8i6boxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6N/FSEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA2CC433F1;
	Fri,  5 Apr 2024 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338684;
	bh=BtFNOGP9wi3ejmbHnY9IlajWZjGrS6wdrz8DT1QXGCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6N/FSEAlFdmII6pv8u5tscDM2rRDa/T4VzSnW7oWHdSiK8h3J5YD75/VzszDDCBg
	 M2rrxoWleHQ8vNu0lfImacNCpN6SSaE9IGxElF+ynDWQhxFHlxfglhfu7swcJG6h8G
	 2/qNYakuGvXZQKL/muvAqQNTpMFEmMyWDPr1VuUCzoUua8RIMkmTzfPmV5BYyuAZbo
	 zvrGj2YqFrt5IdlRZFZO6VpJMikGNvnHemnpXQGfukC7IOiJdefW77DHfd8sNbMcYt
	 GWjAJIonKjP1da9mr1n885i0REaySl/0qY5w/Or7baxWTLKqPysVCc5YNRltS5zBOB
	 zXmw5tkWcBZyw==
Date: Fri, 5 Apr 2024 18:37:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com, suzuki.poulose@arm.com,
	ryan.roberts@arm.com, rob.herring@arm.com, Catalin.Marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/4] A new selftests/ directory for arm compatibility
 testing
Message-ID: <b891547d-d0cf-412f-bde5-621091127064@sirena.org.uk>
References: <20240405084410.256788-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RM+q+5dLtIDrxGi6"
Content-Disposition: inline
In-Reply-To: <20240405084410.256788-1-dev.jain@arm.com>
X-Cookie: Honk if you love peace and quiet.


--RM+q+5dLtIDrxGi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 05, 2024 at 02:14:06PM +0530, Dev Jain wrote:
> This series introduces the selftests/arm directory, which tests 32 and 64-bit
> kernel compatibility with 32-bit ELFs running on the Aarch platform.
> The need for this bucket of tests is that 32 bit applications built on legacy
> ARM architecture must not break on the new Aarch64 platforms and the 64-bit
> kernel. The kernel must emulate the data structures, system calls and the
> registers according to Aarch32, when running a 32-bit process; this directory
> fills that testing requirement.

You should copy Russell King, the 32 bit architeture maintainer, on this
- I've added him here.

FWIW it was me who suggested this work, like Dev says having some
coverage of the corners of the 32 bit ABI feels especially sensible for
arm64 since compat mode could relatively easily get accidentally broken
making changes for 64 bit.

--RM+q+5dLtIDrxGi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYQNvYACgkQJNaLcl1U
h9AY7Qf/fZmneiahXy3yC7SDYFvoJlp2py+ZSWp42RePm8K6LEQ33D58Xlffz/Dg
YrWrrLFiP7LLXYlVIO2lHzESh5gGKOB1vK2gBKuPdTgU6pCt7v89RTVlY/c8Peb4
SN7iIOTYDQvGvah4ypFZz0OIzeeluv3pvE7VpDLVzqSYNE7RRntyW6cYekip799X
Av/JFisiPRxUf2J9/DyiQvzX72izgGZwWwK0fdUENN3ZWs2ZYqpOX0T8bcMjf6RK
zPZD6BxGC98AbtiVksClXst1TfElV7+SO+ANBZg2UBd9wjYQBQEzK3gBUdqFPo4W
V44csdleGsGHRCGpewmxHX7GvOePzQ==
=vCT8
-----END PGP SIGNATURE-----

--RM+q+5dLtIDrxGi6--

