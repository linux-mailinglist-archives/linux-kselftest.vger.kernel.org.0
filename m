Return-Path: <linux-kselftest+bounces-23609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C859F80A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 17:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED261893DB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929F6171E7C;
	Thu, 19 Dec 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gReFUXPT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E013B59E;
	Thu, 19 Dec 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626951; cv=none; b=f+ngHL0t9YrfchctAxcInqypsIhyo8KaGw/reSl8Af/GFyXPe/BfiG9VoV5j/BCltaaNYEdGXEPIs5gSU2rafE+j40JpKZG9g7plKLZmfB5k9e8/O8E2XILQQ3uxKI7aNCFixV1kH2fupnpe3ni58Ib2zeflHlFPMgAaD+OEX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626951; c=relaxed/simple;
	bh=Xm84D3l3NpU5NKUTVyT8w/ufo2rcyj5nHyqMIUT7JTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpKyc0D+jKKSZ8sreVDZvz0xo1MStUzojxZb8sPEHAgNFQYUr1Ck/LIkCIYE8gh4SgM/Gco4ojFwwalaKC2DKeYVowRCat/hIxFvDrU9bzcREdZTDSHHb8whf/MgQzoCbqkTe9FD92F5KLMBvLCVOOvBgKEUUUhy0P2SboH+zKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gReFUXPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3D1C4CED7;
	Thu, 19 Dec 2024 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734626951;
	bh=Xm84D3l3NpU5NKUTVyT8w/ufo2rcyj5nHyqMIUT7JTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gReFUXPTQhLSY/INzkO5P1595KEEU3wS+8Jxztwm7clFveUxNhylRJPxjR+jv8TDJ
	 Lf4rHs1RE/DpdsKSYWr8/aYvtXFFl+KTOPjxFW3D0OIZlTP3KELzhr2aSvkhhAzMif
	 ClvvXbNS2jeUub0gidzktAKrb4Lu58CmJ8fXeSO7PnD4W6VjF/Mlj/7DyZxj+oIWjg
	 5qy7XMtTHfTNbWpEg3VE4qEVbLACsaGjJi9uHwGv7DxupfDX32+jyX8R1tib5/1XFx
	 PpOx1RUr6BBWGZfuC9p4Fq/nq6FducIfsW13WOqCfTC9GHdzm+KNUK8AqROVW8B7uR
	 u+pzIgoGQM7Kg==
Date: Thu, 19 Dec 2024 16:49:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Message-ID: <317e06e8-6e85-48cb-902b-4b3c7748bd8f@sirena.org.uk>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
 <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
 <20241210170953.GB16075@willie-the-truck>
 <b859bdcd-7343-4d53-9f3a-f374deca725a@sirena.org.uk>
 <20241211224015.GB17836@willie-the-truck>
 <248dea18-bfad-4ec9-9a7d-5c87c7f48c84@sirena.org.uk>
 <20241219155547.GC24724@willie-the-truck>
 <51632b4e-19a0-487f-878d-f03abeea2553@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NY5bhLdnipifDOsr"
Content-Disposition: inline
In-Reply-To: <51632b4e-19a0-487f-878d-f03abeea2553@sirena.org.uk>
X-Cookie: You have taken yourself too seriously.


--NY5bhLdnipifDOsr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2024 at 04:39:11PM +0000, Mark Brown wrote:
> On Thu, Dec 19, 2024 at 03:55:48PM +0000, Will Deacon wrote:
> > On Thu, Dec 12, 2024 at 11:33:05AM +0000, Mark Brown wrote:

> > > That'd be useful, yes - unfortunately I think that's still something I
> > > can't work on myself at the moment for the above mentioned non-technical
> > > reasons.

> > Is anybody able to work on it? Without insight into the "non-technical
> > reasons", I don't know what I'm supposed to do other than write the tool
> > myself (which means finding some spare cycles...) or refusing to take
> > wholesale sysreg definitions until it's been ironed out :/

> Similar issues will apply to anyone at Arm as things currently stand.

Oh, actually - shortly after I sent this mail I got a notification that
there's now an "Open Source Machine Readable Data" package at:

  https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads

as part of the 2024-12 which should unblock this, just in time for
Christmas.  There's just the small matter of free time to resolve!

--NY5bhLdnipifDOsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdkToEACgkQJNaLcl1U
h9C2Fgf+JZ+qKMeiKATn1vrhbEFer8uBWjfv5s3Mvjk3inPB8EqptcDPjvRi1iCV
jt2bnBCvCS+xxyIh9jBTA0haLLsU0NQAWx0Xo9cj7NzlSmwgTANMS2IoONiAPNkq
vMVr4w05tASvh1x1zdFnGlzrL5MVi7HdlzqQDy0OadoHgoaGyEczPEragmsHVk/c
o63AwA9mastQ96ekaYBPYKA+Atl1N4LuneAJpWUYS3CWyNL6M0XRmmUt27AfwzEx
AYN0eWKqDbU+hgXw88AMTJCyvzaV1UEfd2uYUGQJbnlgzWhfY3UKkN3M300ELC4X
YWjZSRImDrolSzFOQPADzXjyMd+3RQ==
=ywW0
-----END PGP SIGNATURE-----

--NY5bhLdnipifDOsr--

