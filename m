Return-Path: <linux-kselftest+bounces-48537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E723D043EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B47303416EDA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD22E092D;
	Thu,  8 Jan 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVqoIYbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3C2E0418;
	Thu,  8 Jan 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887856; cv=none; b=FLius49z4IQZVMM4wx8Evoxn3KKiPK1W9mHtyBB7l9ih2OnseajgM0D/Nk4z3dHpTTaabZ98smzPZYi15YU5dTzM53xs1JqqcEgoJiiHXNsNsSCXUebtrZbkff5TjALU1En1FUgvdJQqjUpMiUyh8Hj7qVKX4gd2dWpqZxau8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887856; c=relaxed/simple;
	bh=iQ8rrKAjkcgXBG7XLBNg/l9mT/9ufxiMSqzt1QWzGdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgvFqN/0zzM2HlHlAT8zY4HyPzAo/0hr9JdLkvGHLNFWbNnox+OfJiKusXYkZVi5RaXzslvJ0NvRES/UuTtVH6G8uO1n7ZSfqwb7KHxR6raAd2Kd6QK6eMnnLegPIMSX1tVrXB3odZPJ59UpohmFOoXbQXl2hnX9VWWWpn+Kgu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVqoIYbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3F9C116C6;
	Thu,  8 Jan 2026 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767887856;
	bh=iQ8rrKAjkcgXBG7XLBNg/l9mT/9ufxiMSqzt1QWzGdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVqoIYbJP02PJTKnx446NUd3M2a4Ep19Dg9tIX7oreQpKKsd0WMGyTFUJ1sDhiXWY
	 0KtS2dh6VfgyUiSD3OiTxpJZuxbKYxR/1hBRHWLrheX8ST7mB39HkyvpUsmPfrqN88
	 zi6iOhwIStpoif0an8L2fuMSf78ynLUxFwnTboH07mvxdH5xzvVP2Pa/PObcK+/jFt
	 5f0Go3ejIGh1XNrnasudUdmrt3GrXSY1SW6VzhXuIQObithqCt61PeKuSTMW7jw8O3
	 U/OdvxARLkNQXqgRv4AUcd1QcZtEXws/csV64jdEvNo1pOhtcobf51yh7jVdB467pq
	 wLj1opru/g8eg==
Date: Thu, 8 Jan 2026 15:57:24 +0000
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
Subject: Re: [PATCH v9 02/30] arm64/fpsimd: Update FA64 and ZT0 enables when
 loading SME state
Message-ID: <e50b4923-ee45-43de-9d4e-344546c635bb@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-2-8be3867cb883@kernel.org>
 <CA+EHjTxdSnpFHkm6o85EtjQjAWemBfcv9Oq6omWyrrMdkOuuVA@mail.gmail.com>
 <3c8b4a5e-89f4-47e0-9a5d-24399407db0c@sirena.org.uk>
 <CA+EHjTxLkLjPj=1vwDqROXOUXi2LhOQb90WP6dFaTiYG1nWovA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KOrZZL+m63ovft+Q"
Content-Disposition: inline
In-Reply-To: <CA+EHjTxLkLjPj=1vwDqROXOUXi2LhOQb90WP6dFaTiYG1nWovA@mail.gmail.com>
X-Cookie: If you suspect a man, don't employ him.


--KOrZZL+m63ovft+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2026 at 02:09:34PM +0000, Fuad Tabba wrote:
> On Thu, 8 Jan 2026 at 11:54, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jan 07, 2026 at 07:25:04PM +0000, Fuad Tabba wrote:
> > > On Tue, 23 Dec 2025 at 01:21, Mark Brown <broonie@kernel.org> wrote:

> > > Should we also preserve the remaining old bits from SMCR_EL1, i.e.,
> > > copy over the bits that aren't
> > > SMCR_ELx_LEN_MASK|SMCR_ELx_FA64|SMCR_ELx_EZT0? For now they are RES0,
> > > but that could change.

> > My thinking here is that any new bits are almost certainly going to need
> > explicit support (like with the addition of ZT0) and that copying them
> > forward without understanding is more likely to lead to a bug like
> > exposing state we didn't mean to than clearing them will.

> I understand the 'secure by default' intent for enable bits, but I'm
> concerned that this implementation changes the current behavior of the
> host kernel, which isn't mentioned in the commit message. Previously,
> both the feature enablement code (cpu_enable_fa64) and the vector
> length setting code (sme_set_vq/write_vl) performed a RMW, preserving
> existing bits in SMCR_EL1. This new macro zeroes out any bits not
> explicitly tracked here.

The behaviour is unchanged since we're always choosing the same value in
the end, it's just a question of rearranging when do it which is the
explicit goal of the change.  There won't be a change in behaviour until
later on in the series when we start potentially choosing other settings
for KVM guests.

> In terms of copying them over, if they were set from the beginning,
> doesn't that mean that that explicit support was already added?

That's a bit circular, with the new interface if someone updates the
kernel to set some new bits they're going to have to update this code as
part of that.  A part of the goal here is to make it harder to make a
mistake with remembering what needs to be updatd when.

--KOrZZL+m63ovft+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlf0+QACgkQJNaLcl1U
h9DQbgf/VzVntYNXV0km5HLDgB/SG9k64BqiNt0fbx3g83qjVtQuNw5OJfx/AI40
3CRrW3Hr1lIspMdVhwa+8lv5cpSyGzWnLWbmRJBVb6v++Hsslg9O824KM1LtRJqZ
herBG1MKR8P2+yGtEt2cxbABtHH3ONEEFdEIOiGDAH7jkRY36Gfwx6QwV8/QA+Ey
81r9gsksZDexFnwMz51S8jMdplvo3wMaDOQnytnH3YzQ9vC0B3Gfre+cAjqF2b99
xN9M8G1+jCOiBeLIDPIEXCC0RPPOJb+mEpy6yUcn7l3k4AaReGbGrqBPtboVRUFT
dB+n4q24DpQwRk1kIs62RHkorXoV/A==
=Ud9D
-----END PGP SIGNATURE-----

--KOrZZL+m63ovft+Q--

