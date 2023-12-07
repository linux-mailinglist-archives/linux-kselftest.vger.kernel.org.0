Return-Path: <linux-kselftest+bounces-1368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12952808C29
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 16:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB08A1F21242
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBBA4596C;
	Thu,  7 Dec 2023 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq4DrIcI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B491D54E;
	Thu,  7 Dec 2023 15:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D21C433C8;
	Thu,  7 Dec 2023 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701964085;
	bh=FWZVFHlYxQKIYNgeLHM8IbfXKEZFHFTZmqvJflUZeDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yq4DrIcI/Ue7Q7skm8ocH4ItscoEQd/Bsn2tge4pepn7rZy98XrnqnRCeLpXYiapA
	 bjrdTXXGRnvF9Ga65TmwRGrSan3IoSOmF7fyvbv7dV8tlpkM2EX+3Abuf5tNnXsQ+E
	 Y1KHXwVTgiP82BntCBjhKg3QOc+wUlU0cLLOdHCBChiKyQdL39+BJNcbUC0y6l6QNo
	 en+XEoiSX9ypcqDpCGn+1J4hBTsYx6+wYnXpSseUDgct+DjN15tEWg5KhPMx356fHL
	 gu6E6bbPeWksQgUle8BqHAxbImDcqAd1msYdbxHMK8y4r6fR/HFx9oXTsEtmBfHxsX
	 x0LsoVw+6E6yA==
Date: Thu, 7 Dec 2023 15:47:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 15/21] KVM: arm64: Support FEAT_FPMR for guests
Message-ID: <20074a3e-c735-4f30-b9b6-42ab15d94d5c@sirena.org.uk>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
 <20231205-arm64-2023-dpisa-v3-15-dbcbcd867a7f@kernel.org>
 <87cyvi8kz1.wl-maz@kernel.org>
 <08ae06c7-1654-4dfd-a789-b8e13c87d705@sirena.org.uk>
 <87bkb285ud.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="58ab5MdJriGbSay2"
Content-Disposition: inline
In-Reply-To: <87bkb285ud.wl-maz@kernel.org>
X-Cookie: Two is company, three is an orgy.


--58ab5MdJriGbSay2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 02:06:34PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > > > @@ -517,7 +519,6 @@ struct kvm_vcpu_arch {
> > > >  	enum fp_type fp_type;
> > > >  	unsigned int sve_max_vl;
> > > >  	u64 svcr;
> > > > -	u64 fpmr;

> > > Why do this change here? Why isn't done like that the first place?

> > It didn't seem right to add the register to struct vcpu_sysreg before it
> > was handled by KVM.  As referenced in the cover letter normally this
> > wouldn't come up because KVM doesn't rely on the host kernel for
> > managing register state so we add KVM support then enable the host
> > kernel but for FPSIMD we're reusing fpsimd_save() so we need the host
> > kernel support to be in place when we enable KVM.

> That doesn't explain why you can't be upfront with it and populate the
> FPMR entry. In either case, you are wasting a u64.

So you'd rather just have the register listed in there as part of the
host support rather than initially excluding it?  Note that the current
series has the same approach as is currently used for SVCR which is in a
similar situation.

> > I agree that it's not great, the main issue was that fpsimd_state is
> > both already embedded in uw for hardened usercopy and very widely
> > referenced by exactly which struct it's in so I was taking a guess as to
> > what would get the least objections.  The obvious thing would be to add
> > FPMR to uw and share the whole thing with the hypervisor, if people
> > don't mind adding another field to uw I could do that?

> Either that, or you create a KVM-specific structure that contains
> these fields. If that results in KVM changes, so be it. But I won't
> take this sort of pointer arithmetic that assumes some pre-defined
> layout.

Moving fpsimd_state would have a big textual impact on the host code and
consequent issues with creating conflicts too so I'd rather avoid that.

> > > We really need to stop piling the save/restore of stuff that isn't
> > > advertised to the guest.

> > I'm not clear what you're referencing here?  The feature is advertised
> > to the guest via the ID registers and in the past you've pushed back on
> > making things where the state is just a single register like this
> > optional.  Do you mean that we should be making this conditional on the
> > guest ID registers?  If that is the case is there a plan for how that's
> > supposed to work, set flags when kvm_vcpu_run_pid_change() happens for
> > example?

> See the beginning of this email. It is high time that we stop enabling
> everything by default, because this totally breaks VM migration. We
> already have a huge backlog of these things, and I don't want to add
> more of it.

> Which means that at the very least, enabling *any* feature also comes
> with sanitising the state one way or another when this feature is
> disabled by userspace.

> How this is being done is still a work in progress: my current plan is
> based on a set of trap bits that are computed on a per-VM basis, and
> some side state that indicates whether the trap handling is for
> emulation or feature disabling purpose. This will probably reuse the
> NV infrastructure which has an exhaustive list of the sysregs that can
> be trapped from EL0/EL1.

> At the very least, userspace shouldn't be able to observe the state
> that a guest isn't supposed to generate, and we should be mindful of
> not creating covert channels.

OK, that does seem much more like what I'd have expected the enablement
of these extra features to look like (and may well simplify a bunch of
the existing trap management) though it is a big change in approach.  It
does greatly expand the scope of what's needed to virtualise the feature
though, and there's a bunch of other in flight serieses that'd be
impacted (eg, POR and GCS) and I'm expecting a bunch of overlap until
the general mechanism gets landed.

Based on that I think it might make sense to push the KVM guest support
for these features out and deal with them separately as part of the new
approach to trap/feature management.  Probably through pulling the KVM
bits to the end of the serieses so they're there for people to see.
Does that sound reasonable to you?

--58ab5MdJriGbSay2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVx6S4ACgkQJNaLcl1U
h9CR4Af+O4MzssULY33iRz6zO7cFJSjHaOxMygdFMyXdgxFK0rHMqPGmPw6qlM6q
+Hf8ZAHcIpTSyXX58BORU8FZvwmvPtWnLpmBiNfIwxIGdV6SKfm86ShyT9A3f90x
GKaiNHqz/Yya8abt0fqHGGiMiXy8LJ14+D0x8QteqFeb9Zdq6IWdSyEGV7kJx1pw
VZ03L7wab3AonUsZQII+0tuVcv+blzO2oLenzYlq0GMZgUKX8MfDQthsUBy/bRiO
VBlmDT+kegDD9MlEMsFo5yiVs32teyIU1OHRpV1YaqOZtWPB6rOdKDEPkkxSourz
Q92uzr8z9r9oTqyWk0MkVCe4jotIiQ==
=jKm6
-----END PGP SIGNATURE-----

--58ab5MdJriGbSay2--

