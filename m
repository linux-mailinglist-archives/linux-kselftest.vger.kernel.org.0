Return-Path: <linux-kselftest+bounces-26026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4BAA2CBF2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEE7162562
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7E188596;
	Fri,  7 Feb 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVJQKsBC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8C10E5;
	Fri,  7 Feb 2025 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954319; cv=none; b=ZR3Tx+fI40W+Z5l8eJeGDob1dR2WpEki4B+4asoztEvZYsOCg/d73GSBOnaF8Gaht60VamUG7x6ATgbvWCDwU74Euch9Yz6WTN+FVa++MDVpwDkmMzHyb47nEJy9PJ2MKRUMzV68I1KhPV/2O6PCQalWqoCjdKATku2ZHyzBi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954319; c=relaxed/simple;
	bh=7onJfjbDtWHDRExNm8cu9hpXQKqGW01LciP/zaYYx9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maPoKl7+de24IJKJHJEosO+3uNPua+s2AtF6jew9RuNBigIK/TXP0uf5F0OrW/HeHW3rKobYEZ5qIhDQsgs7GbzAE4X6mqCZyCYrKh8gLqh12iCOR8hZM5FHMO/HXDsqAAvGbklCKslLJFDLQwJr+N8Kjjdz+UFBR58WRgfi688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVJQKsBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5328C4CED1;
	Fri,  7 Feb 2025 18:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738954318;
	bh=7onJfjbDtWHDRExNm8cu9hpXQKqGW01LciP/zaYYx9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVJQKsBC7RMwQFymvjSHHCR2p0vwZLBFjHQLvvTRv/5cCZgPnMIV/DqIrN7B8ytIU
	 M69yzNOlrbcpvlh/p+1eU1orKpp3MwCp3WiyvdqkTnteIRb76e1l/mmTkJmaFDU8yY
	 LRBCZ6HNLoE9swbRVntg/VN2Kz4kkmunpQcnOLVTBeF37OfstugVNAl6GF2QBlzAJy
	 xKb7IfTVpN4YeJ6MEHz97vd5bjTvAOXP3C8wgNBiUmKk59Q0HNeD+6c2rGsq83nQNf
	 VnA1ep+dazqnA+VZYyLdJoCGKVNM5Dcbe4iUjkOtKttmaAR7Gs/yKW/MX1smWB6gEz
	 2F+t1Mqsjvirg==
Date: Fri, 7 Feb 2025 18:51:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/5] arm64/hwcap: Describe 2024 dpISA extensions to
 userspace
Message-ID: <0b3777cc-b73b-4843-97cb-5fe3cb1b9774@sirena.org.uk>
References: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
 <20250107-arm64-2024-dpisa-v5-3-7578da51fc3d@kernel.org>
 <Z6ZS51BLkfFLl-5Y@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DJF/VSDq3N4d5oeh"
Content-Disposition: inline
In-Reply-To: <Z6ZS51BLkfFLl-5Y@J2N7QTR9R3>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--DJF/VSDq3N4d5oeh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 06:37:27PM +0000, Mark Rutland wrote:
> On Tue, Jan 07, 2025 at 10:59:43PM +0000, Mark Brown wrote:
> > The 2024 dpISA introduces a number of architecture features all of which
> > only add new instructions so only require the addition of hwcaps and ID
> > register visibility.

> While working on SME fixes atop v6.14-rc1, I found this patch breaks the
> build spectacularly with CONFIG_ARM64_SME is enabled (splat at the end
> of this mail), due to some missing definitions.

Yes, I already sent a fix for that which Will has merged:

   https://lore.kernel.org/r/20250203-arm64-remove-sf8mmx-v1-1-6f1da3dbff82=
@kernel.org
=20
> From a quick scan, there are some other missing bits too. For example
> these two caps are defined in terms of ID_AA64FPFR0_EL1 fields:

> > +HWCAP_F8MM8
> > +    Functionality implied by ID_AA64FPFR0_EL1.F8MM8 =3D=3D 0b0001.
> > +
> > +HWCAP_F8MM4
> > +    Functionality implied by ID_AA64FPFR0_EL1.F8MM4 =3D=3D 0b0001.

> > +#define KERNEL_HWCAP_F8MM8		__khwcap_feature(F8MM8)
> > +#define KERNEL_HWCAP_F8MM4		__khwcap_feature(F8MM4)

> > +#define HWCAP_F8MM8		(1UL << 35)
> > +#define HWCAP_F8MM4		(1UL << 36)

> ... and we expose the ID register bits to userspace:

> ... but there's no corresponding arm64_elf_hwcaps additions to actually
> expose the hwcaps.

Right, indeed.  I'll send a fix for that.

> There are *SME* variants in arm64_elf_hwcaps:

=2E..

> ... but those KERNEL_HWCAP_SME_* values are never defined, and neither
> are the UAPI equivalents.

> We need to fix that quick, in case we need to shuffle values.

These were removed in the patch above, the relevant features were
removed from the architecture between the 2024-09 and 2024-12 XML
releases so were removed from the patch series by the time it got
applied but with CONFIG_SME being disabled the stray reference wasn't
caught by testing.

--DJF/VSDq3N4d5oeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemVkcACgkQJNaLcl1U
h9ClRwf/WB2OvIr7lgQx020+QFzQCtNHusxsthqvrkbyHfN9xFDo0WGBzEhXht2t
SxrHeNhPqeSa1twGITVG+lAlOresDhJwX8aCNVw43dWkKCvOF8wh5eiDc7PZOLXj
Yj9HfFBUXWDVkQQ7gUSXRYBnRgvN2PoZlXgo2B2rEmsP7KU4UjkIPEN7kLKNBYK9
ZznUGbYZBHOF6MbJeS5IbogE25jjEfterOxJq+J71TfLys/uQO4tDPYZ444A0K00
ZnA8s2L/xJw0G6G1nH6ExTpbO6YcTy0j5E/OlTIjvQCZRNMWWDQF6P6kXyR9buh4
Jz2fUFFsDgRIozNSVv2icyfgc+3isQ==
=1zDI
-----END PGP SIGNATURE-----

--DJF/VSDq3N4d5oeh--

