Return-Path: <linux-kselftest+bounces-16675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08121964280
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 13:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF771F27C91
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1D190471;
	Thu, 29 Aug 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/vzyJ+0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F718A6D1;
	Thu, 29 Aug 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929346; cv=none; b=M4yNHsApfN3ihvC512F/yhTgyUrHwoG3+LsH9t5/JHcSEY6SAGq89P27rMbnefHpTFoiO3YmpgWc7bOGfsTmhHIvm38vLn1NV/LChWBS320mngkZGXJ9GsPrG3A285PIgFGsGGHGax0ZoiJPl7xgEIefG+TKPPeftLIo/tr8F4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929346; c=relaxed/simple;
	bh=u+LH04eT4qocxpQHoAB733TwPibGYYZSu7w3tJjRL9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9RqFjL+u53bIVXJZlhau8r0/5rWZ0kqpFtalRsXAt9xcCa2J+nbJH5S2LwukurepeMxJ/cwGQ99A4DOIaji+eNzHEZ9a0wxW4N85oFEpT4rwaVXMWZyRBg+PVz2sxTgAlO8cHv+xLcYTKPnG9bTkm83S2MEVHKKY/uR0YwA77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/vzyJ+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5AAC4CEC1;
	Thu, 29 Aug 2024 11:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724929346;
	bh=u+LH04eT4qocxpQHoAB733TwPibGYYZSu7w3tJjRL9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/vzyJ+0vfSOtFN7JvSOXt/w3m6hz/Zc4Hn+UXN1HajC0sev+5Kn+EzZLVb3+W9Cd
	 MzBL6PbpoOxZYWW0L/ufw2rdIP8h6rD79pxue2D257zFUsyNf+RV5LvFXKYDLlLpL8
	 idgyqxbosUWkYDwhWNogHsNbyUoBvApSSZLlIwRjO+ToYbk+6rZMhz4IRAoZLSkwrD
	 WPhciWjihwtg4t+z082d5NnzdlgaBfp+/w1C+n3x2TtPPEDDF0YuqRy2ZYb/CDDbkR
	 Wgzcmc7Rl4Rtur0A/xRyTY5AhH+rHqjd7hEcf3ThVvFzs0ZHCIuXxTVkE5+qcnNr3u
	 ZaaA4sl9fq+5A==
Date: Thu, 29 Aug 2024 12:02:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	will@kernel.org, ryan.roberts@arm.com, Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/arm64: Fix build warnings for abi
Message-ID: <3699c056-693b-4313-a750-2e777b48ed46@sirena.org.uk>
References: <20240827051851.3738533-1-dev.jain@arm.com>
 <6e5588d9-c22c-4a94-afce-1274c888403e@sirena.org.uk>
 <5241c418-d5af-46ca-8188-7b67e1640f88@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X1ArkKO1t1w+4Ebb"
Content-Disposition: inline
In-Reply-To: <5241c418-d5af-46ca-8188-7b67e1640f88@arm.com>
X-Cookie: Go 'way!  You're bothering me!


--X1ArkKO1t1w+4Ebb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2024 at 11:55:33AM +0530, Dev Jain wrote:
> On 8/28/24 16:10, Mark Brown wrote:

> > > -		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
> > > +		ksft_exit_fail_perror("raise(SIGSTOP)");

> > The idea with these is to include the error code as well so adding the
> > %s would be better.

> ksft_exit_fail_perror() can do that thing for us.

Oh, sorry - I missed that it was changing to _perror() as well as
removing the argument.  Yes, that's fine.

--X1ArkKO1t1w+4Ebb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbQVTwACgkQJNaLcl1U
h9BrlQf5AUdYWbXTssiOT5pOTsakKSPbq3tQm+3ChArNFJqdk785whqJi24zKtNo
mXh8gCiYf+OkPd07Pako3zPfc8AJFILorStbgnukS/2tElGWr42kGdpqvGXGHBlD
gt4JxM/cZLZA2pSpCpcMHZez9dXtk6Ozz4jeRCyiu7mS2oi5TjrCd5S3ndkwCjKn
E7SF6yey+AofPWk44dlnEx2Dii8pe6JIhVLtKTZEJ5LzNK0I7RAu9asYGvuKb1Rc
VOG0M1WtCHFrakOJE5w9eEzpOj5NoMLXe6WRxyLqgYlbhtSt5QWUbFzmk/KrFh9o
bVk9V5yK7bcPqShuqyK36PHqbgDppw==
=MjqY
-----END PGP SIGNATURE-----

--X1ArkKO1t1w+4Ebb--

