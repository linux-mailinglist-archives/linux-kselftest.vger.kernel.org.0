Return-Path: <linux-kselftest+bounces-48960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0D7D208A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B18213044C35
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C419301001;
	Wed, 14 Jan 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPNzAUNV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00B2BFC85;
	Wed, 14 Jan 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411680; cv=none; b=nPmcsqw0LC8ljFbzHZiRbLAZnCnfvVGZyH84SgXNLTYnSaXUJYiKe/ADVA9gGTcEXI5kLeFI7PCnEzSTOcXRRaODJE5qSfIPFZDkjPm+D4EdE1NtY2Azj51wcxhjc03m162XEeWhtZlr73lMFtlGBlfQW8f/AsSObWFABbnlw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411680; c=relaxed/simple;
	bh=MKErPubq+4dytiNTQQKxbBYuZq0PRZbULHtHlGPOA9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE03Gu4TIeg1HIhNGtm7484AyBfZ+R6RAx8x94KaEp6hWnIWjFGUKk4qfM+KJlKH8gKbKHs2OYBM5ijdtmrCJJpyvzJUAlq0UnnSSecK08aPoKbz4f8cyUT7Z0/hDhXFPPL3OuT7HczqoEOGmjnoXJaf8tuFbBqCRgn1edN2/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPNzAUNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D171AC4CEF7;
	Wed, 14 Jan 2026 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768411679;
	bh=MKErPubq+4dytiNTQQKxbBYuZq0PRZbULHtHlGPOA9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPNzAUNVJjw7ci4jNIO2uMrDaRZ+xEVkHOjM5IQaB+UAc/c442sRxq+JFqShLlNHu
	 XfqXYF3w43bN21mG+uwwl5Iy8UmeqdAF6OK+8BA3dJRHuc3qxpeZ7sISIDpad07B+b
	 jv0O9lGX3cAw6lWQMYieUSLvbvMcZ62jwgH84qc3c3mRz2fGAgBep8rPfPeqZAy0jo
	 2dfXmVozyUzfknjXc8Ivt7BoXalm2KIXNSEnqIHuiqB0zUpwqgkgpaDN17ovsedGUq
	 yYEBZ8Lc+y9wmjLpRmdkKVnH4HYJqOsm4rroiYmT2UWZVGLhiIVe2pKwFyE4zUS7iv
	 BdEdk1L1lKyHw==
Date: Wed, 14 Jan 2026 17:27:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v9 23/30] KVM: arm64: Context switch SME state for guests
Message-ID: <5a053bb6-5052-4664-b0cb-f05d56d4679d@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-23-8be3867cb883@kernel.org>
 <CA+EHjTyYcrWwBR0AwwdWFfOSwbmTMOhSee7y_-vrMfOxphrvqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5VzuVXkE42Zf47rW"
Content-Disposition: inline
In-Reply-To: <CA+EHjTyYcrWwBR0AwwdWFfOSwbmTMOhSee7y_-vrMfOxphrvqw@mail.gmail.com>
X-Cookie: Absence makes the heart grow frantic.


--5VzuVXkE42Zf47rW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 02:24:56PM +0000, Fuad Tabba wrote:
> On Tue, 23 Dec 2025 at 01:23, Mark Brown <broonie@kernel.org> wrote:

> > +#define sme_cond_update_smcr_vq(val, reg)                      \
> > +       do {                                                    \
> > +               u64 __smcr = read_sysreg_s((reg));              \
> > +               u64 __new = __smcr & ~SMCR_ELx_LEN_MASK;        \
> > +               __new |= (val) & SMCR_ELx_LEN_MASK;             \

> Similar to what I pointed out in patch 15 [1], I think you need to
> preserve the other bits, since SMCR isn't just about the length.

This does preserve the existing bits?  It reads SMCR, masks out and then
replaces the length.

--5VzuVXkE42Zf47rW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmln0hgACgkQJNaLcl1U
h9BMEAf/RF9rOJl8ekbOzDRQR11JDX39xOnp1XjKNL/LwADVFknoshEFGbwNHbg7
57daW1rnmcC+bbYUI884dlgzpo1QO8eu4Ln3iZDbBO3RiskXsxPq0/Aw9YPMpukh
389uJu/fYy9Ag03Cgwp1Gcp7bMqs3eDrjnW6q4Rdaqc6tzECGGKLYT25uZjD9qdu
n5jJy4QwQfmTpm1eH93FgHCkiW5PHP8wUv+dYDQ02i/Bg1ZOuiOeiof+YcAfZoxn
okZ9Seieeb/x/OD9CYTtepifFAelR40y3pF8VLhESbkMzGiy7v6SmiCWhPvFhNkF
uyOxnmGui2Xy46sOprB2XcG91p5l5g==
=e2HB
-----END PGP SIGNATURE-----

--5VzuVXkE42Zf47rW--

