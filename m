Return-Path: <linux-kselftest+bounces-48959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A042D20726
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 18:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C7733022A8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E86B2E0B5B;
	Wed, 14 Jan 2026 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEolMwCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788A2D73A6;
	Wed, 14 Jan 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410452; cv=none; b=jzIE4kkYt+TaxJ75LULMybvnQ3klyRUnCzFXXyd+3dWn5wL8TLBsj4vGZyKDJ3CKjhJqrOcJnTdJheUiLHoNQX+C4RhwfZR75/jvRAOZjYqbATnQhVVic/HEdkkyw8bGA+Q1O0dUg1qAOxcM8WI247er1bxVtfxM+R/AAmDKGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410452; c=relaxed/simple;
	bh=MGElqEXwoRbt8mMzLI9gWMm6tx51R4BHJkiacnjgofs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lICmki7wmFHah8wHSxJwY/mkGkTonIKvgZU5FovRuziF8YfwJk6MmYEm2fFaEYIsbrTPoA8om68ASfjLHpqMp8+EGe1zpOgoWvRkLgG0o2qIpmJuq85kqK0lc2k4JUAmPog7AKQf+L02qQ5Te4RA/NEcMHqumLEgFQhZ4s1b8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEolMwCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6DFC4CEF7;
	Wed, 14 Jan 2026 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768410451;
	bh=MGElqEXwoRbt8mMzLI9gWMm6tx51R4BHJkiacnjgofs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEolMwCHO3gyuvdGmOE3O9pKCM5M8SbSniKQidIWzOSx0PpTJ7Hj4ZwnGYFesCRZ3
	 nUL/jdfJLelH5D0whFKOjdwr35MISlOXKDOa6Lbi19ptoggFUpvSTGZlhxy8wcydSe
	 2ru/TkW9rbl9o0etsJta6Ukc466KaXjOjS0EZlRUsIFFI5uicpeVB9DXRy+PEASF5k
	 BFWehX7gdc0YEru5parDTnCckbHf4EXKG0ybaCo62t3jvZVfDovR7/4iu9t8FWPKOS
	 0BvNX/YWefxE1P6ozppwQ4KuBl43vg9R78UIaOZkuSwgv6K/q5DHyUyj8B/+g5oMax
	 iic2DLJRvz0ug==
Date: Wed, 14 Jan 2026 17:07:25 +0000
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
Subject: Re: [PATCH v9 22/30] KVM: arm64: Expose SME specific state to
 userspace
Message-ID: <1b5493ed-2d44-47e2-916b-3a5052e3b88f@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-22-8be3867cb883@kernel.org>
 <CA+EHjTwMy1crsZLqfy8_Y56NFPJZ7vGyN-egc433GhxB_n=7aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wWm1d/lEDlGXNOgF"
Content-Disposition: inline
In-Reply-To: <CA+EHjTwMy1crsZLqfy8_Y56NFPJZ7vGyN-egc433GhxB_n=7aA@mail.gmail.com>
X-Cookie: Absence makes the heart grow frantic.


--wWm1d/lEDlGXNOgF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 02:06:53PM +0000, Fuad Tabba wrote:
> On Tue, 23 Dec 2025 at 01:23, Mark Brown <broonie@kernel.org> wrote:

> > +static int sme_reg_to_region(struct vec_state_reg_region *region,
> > +                            struct kvm_vcpu *vcpu,
> > +                            const struct kvm_one_reg *reg)
> > +{

> > +       reg_num = (reg->id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;

> You use array_index_nospec() below for koffset, but it might be worth
> using it for intermediate values, such as this one.

This is following the existing pattern for the SVE registers, I'm
trusting the logic there.

> > +       sme_state_size = vcpu_sme_state_size(vcpu);

> Is it worth caching this value and storing it in arch, since the state
> size doesn't change after finalization?

It feels marginal, and we've not been caching it for SVE all this time.
Most of the time we use the value we're doing so as part of a fairly
expensive operation so it seems like a reasonable choice.

--wWm1d/lEDlGXNOgF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlnzUwACgkQJNaLcl1U
h9Cvrgf7BgTXha0CzEi5j4VgVBXcclvOZGymP1dBDz6D4Y8U/TMKH/bpOQcIjws/
lkQGHPmKpBCHKgkE9ZCJu5oOQqQdCjFh9pHQQZwJM1QMRg/P/cwzO+CoyMsIkb1A
4o2x/8WgiXF4LRsm4hmHRDR51VYSsH+Pg2dVgpSdiyIG1xi02AzthMF9vY0/fEiE
GHKptYCfpxgy14m/Ns0VKGfgNXAXH6reAeVqWVo5BQ0K9a5M1pFAIoLyaKFulRTR
0jgqosqFLXemYeGJ99w1TFrJRO3bltyiVULxBQBDupshqNvIwApsbjn92T0Qh8ir
VwMGpz89Lk6CAe/3AHGVTw/0GgAFBw==
=h+Uy
-----END PGP SIGNATURE-----

--wWm1d/lEDlGXNOgF--

