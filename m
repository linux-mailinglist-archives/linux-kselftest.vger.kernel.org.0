Return-Path: <linux-kselftest+bounces-49380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B06FCD3AFB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 16:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6F0230635EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDACD38B9AC;
	Mon, 19 Jan 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UheyHquR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E553803C2;
	Mon, 19 Jan 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838060; cv=none; b=sSp156lldH5OH6IQcBwH0cld05ByNJ48QSec2WbwDZlYvhNW9SVXtF0PeDdbzfnpDW16Tc+fPW5EYh5QhFp9bJznqA8toK758CWt/8Lo5b2cWTjIjsAIyvMCA2GvZSgC9vGaV6R9IdO4edIBLJAuqc9ZTtDy2pdOBFxhq3N5jKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838060; c=relaxed/simple;
	bh=b3tsm3te6FsJWcVLThMS0NFHiYhNgSMaAVtqHh4CPRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUdSeY9/sUX9cfrMg26umZl8sBAam2QmAmKRqPwLKEiXtJoq74nTU0qYXEC+dZdsHjKtwWqMh9+HMx+hqD7Q/POACp0rF4sY/uJagcQHxU71D3Zm2lorEnci4exF34g+2bsZXv0yoCSPpvf+lzP8djECVDlE0bLRQ82n6ZPeByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UheyHquR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655C8C116C6;
	Mon, 19 Jan 2026 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768838060;
	bh=b3tsm3te6FsJWcVLThMS0NFHiYhNgSMaAVtqHh4CPRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UheyHquRoxxb8CuygWAhYv3SnIYWpXLSdD8M+JRy0FXmfWSt7UZJfDH+d7rEU240F
	 ByB431CkgUjD+s4QOrlxDU4a0nkBqUYS1Ug6hhkFXo+18+C2JEbj0ijNKkcbWap5HY
	 vRjXWgQ3quHA2LswdPgBfTlB6VTIXcdvbzGY8NisbO9X7wrSuHI8a9cdfJX+zHyQXx
	 pqRfMKJzPBsFNK5t73XIBXiZMa0UxNiZc4t9b7FF0DsZiuPPumphq1EH42s+cq+cqM
	 JgCS/OEmg6tTO4HEUKF8K5Fwf7s9gJuoI8HCkXp4L5My0FB11EACpsbiCPYYEzXv/K
	 nb8SoftkF/lhg==
Date: Mon, 19 Jan 2026 15:54:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, catalin.marinas@arm.com,
	maz@kernel.org, oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 4/9] arm64: Kconfig: Detect toolchain support
 for LSUI
Message-ID: <20a2e113-7d53-4857-9cbb-9e4ea910b7d0@sirena.org.uk>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-5-yeoreum.yun@arm.com>
 <aW5S04xS4FT0zvXv@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yKoaamXJOGUSy7RZ"
Content-Disposition: inline
In-Reply-To: <aW5S04xS4FT0zvXv@willie-the-truck>
X-Cookie: Does not include installation.


--yKoaamXJOGUSy7RZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2026 at 03:50:43PM +0000, Will Deacon wrote:
> On Sun, Dec 14, 2025 at 11:22:43AM +0000, Yeoreum Yun wrote:

> > +config AS_HAS_LSUI
> > +	def_bool $(as-instr,.arch_extension lsui)
> > +	help
> > +	  Supported by LLVM 20+ and binutils 2.45+.

> This is an internal Kconfig variable so please drop the help text.

It would be useful to keep the information about supported compilers as
a comment though (as is done for some of the other toolchain feature
tests).

--yKoaamXJOGUSy7RZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluU6QACgkQJNaLcl1U
h9CFIQf/UI2bGgmgdtdZff9n4ejTZp0Sz6LHgh3UnwQu584BoImowV63sXNhHUQ9
C2FgTQzemLQUnUzfOsv6iQzvgb6abr/ey9VkxNuLRBrHpvgAnTQSUo821S9Wf0gJ
Hy24oLrppu8+Oif2bQaDKZRMAyFLttJ3TOyOl0R00LdpLbrmzGtAM0F4YNJ+zfxk
3JNFSP5vF6WuMKqZZuxSA3Ng1pqmQofEWJDbV8++du2aFvwgMvPfSo20UNqrXi7b
NHc5kSArlFH57hkBuoqcp5ALJrqPWA0KWPys9D/2R7VK/bRrZzNvEt5i7O4Uop8h
gbdC+izp2I9ubs39ZnQUmHEcQpD97w==
=l07T
-----END PGP SIGNATURE-----

--yKoaamXJOGUSy7RZ--

