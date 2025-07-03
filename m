Return-Path: <linux-kselftest+bounces-36477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE43AF7F82
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 20:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49C84A8482
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BB12F2347;
	Thu,  3 Jul 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDbd9qqu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B625A2C6;
	Thu,  3 Jul 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751565802; cv=none; b=WhESsL2mQipfxrIGXq8VEDt9/Mu/i6l2x7CJUHjpBhSvMza/GqCV0/LPTmRBz2TZkgcG6D0yXa1dtY/smtZXOBlp9Gjitg3SNWRxSW/Q2j1m8pgBIeixTfilfveOrVr/zXA3F8fzOtW6WmMoKmy5njaseejeAVDr+pzGEYSr9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751565802; c=relaxed/simple;
	bh=DAlQxIcteaDn8QOHRzwZvy79winbFs5xEUAf0FyF0aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRxQfJSQHpMW4VMPfeNfr2q6qe7u74qqBNAx4xUoZnOwkjghPCUeyFsrgNylt7Pef7mzPTWHJNmrHUDXuwwX+KXWRLfdkPeCPWQ1zHydwzqxgP2/skGI/+NA2l81XxTl+slpAs+Flo/RlqVbDsMm2AsWjgrDTR3kOqn2MQ/5ess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDbd9qqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95AAC4CEE3;
	Thu,  3 Jul 2025 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751565802;
	bh=DAlQxIcteaDn8QOHRzwZvy79winbFs5xEUAf0FyF0aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDbd9qquuPLQ/EAUpln2smNPbxdrJ3tuUba8ONxsrbhMpdG/wrPKE29RjfbT84y8W
	 wuQXP9hwff4X73xRuO6IWbzDVYI3hX/GTvsNJl5BXvlvPTMJwIppkiNib7uF8EdAgD
	 jyDBtCmfRFvLyQxgSl0t1Z0Ze5UQyQqpSLMZjn+eebnyZuVEKbeXjNqZAH/FQG5vGm
	 48aJVBD62eB0H8PxRK9DoGOXEPCOCUv36abG/uZwkawxyCR5IwFlOJzSwvn+n0t3Mh
	 VFU0RO4QYYAK0ajkKCt556ks2Yf6OUH3hnT2L+cFTTJikcJajjFcAVUiExcd+YMRj+
	 B9IeeM2LItFqw==
Date: Thu, 3 Jul 2025 19:03:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 18/28] KVM: arm64: Support SME priority registers
Message-ID: <3ada3079-6f01-41d5-927f-afbbd57d934b@sirena.org.uk>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
 <20250625-kvm-arm64-sme-v6-18-114cff4ffe04@kernel.org>
 <86o6u6c2qg.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjNON9hcckQNbems"
Content-Disposition: inline
In-Reply-To: <86o6u6c2qg.wl-maz@kernel.org>
X-Cookie: Uh-oh!!  I'm having TOO MUCH FUN!!


--pjNON9hcckQNbems
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 29, 2025 at 10:32:23AM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -495,6 +495,7 @@ enum vcpu_sysreg {
> >  	SVCR,
> >  	FPMR,
> >  	SMIDR_EL1,	/* Streaming Mode Identification Register */
> > +	SMPRI_EL1,	/* Streaming Mode Priority Register */

> What is the point of making the sysreg file larger for the sole
> purpose of returning a value that is firmly always 0? Can't that be
> synthesised on the fly whenever needed?

This was patterned of what you'd done with SVCR, I'd formed the
impression that the idea was that for registers that really exist like
this one it was more robust and less code to set them up in the sysreg
file and have everything look standard than do custom handling.  That
case was a bit different as the arch FP code needs a variable to point
at, I'll remove this and synthesise instead.

> > +	EL2_REG_FILTERED(SMPRIMAP_EL2, trap_raz_wi, reset_val, 0,
> > +			 sme_el2_visibility),

> Wut??? You clearly said it yourself: this register "has no specific
> traps available". If you end-up here from a guest access, this is a
> bug. So this "trap_raz_wi" makes no sense.

I see, so the callback should be NULL?  Access to the register will get
trapped as part of the general trapping of EL2 access by a NV hypervisor
so it wasn't clear to me that that we shouldn't have the handling.

> I also cannot see where this register is properly configured to be
> fully RES0, as it should.

Me either now that you point it out, thanks.

--pjNON9hcckQNbems
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhmxd8ACgkQJNaLcl1U
h9Cnigf9FOTIvLzH7nW4Ne5KezFk5Oy7PnPYWnqdug2uCPZ/c0vKArSLFLGgbaQC
LNFKKt/Ki9NPakD73zenb2iRfQHst2Z/XNgHqvDVczgNsuJx4BVX5hsObCeIKdrj
RCTmY9X9Jb4b6lHsM/BH6pEIysEYRA8zj5+KbHhi5vm9EgAoq6um6H1kW2kCEUXb
10We2nKb5cHNobBonc54HhAgxOpEM52E+dE9MdDa9SoUWwKBzzaJHTv6FRIHomJN
EhsF7DLO6ovjqOaXBLj9tGalSO4xXR+EPQdJSmhExqjSywYoQP0S6ncSlwwS0PdG
W7906Lv0olpdyCLF/Cav9KCU4YU9AA==
=/1vV
-----END PGP SIGNATURE-----

--pjNON9hcckQNbems--

