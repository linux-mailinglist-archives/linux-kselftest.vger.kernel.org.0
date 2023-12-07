Return-Path: <linux-kselftest+bounces-1348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9717E8087BD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 13:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346F0B21AFA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 12:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AD936AE8;
	Thu,  7 Dec 2023 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm3jAV4V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9A3D0AE;
	Thu,  7 Dec 2023 12:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F9FC433C8;
	Thu,  7 Dec 2023 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701952251;
	bh=uBGsvNf3/15p47wC7lzZSGRCb92G+RXjfng5yK2Bh9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dm3jAV4VvxsO77I5J9QfvFYsM0pigSUkWL4PSeyx8xawRiX77iFtMo/vMMlaWjJV5
	 nuMZhHz+Qfm/Y7CkFSHAUvTbkFD/icwm9+MS/f023XIZZRXI9jHMGV0FjbMb8pdjAq
	 X7uQec7eEBa52Np9p50Bwx7UazlM8rH4/WfEXdaFuO46lzlwggbiD7isusHfECzYdf
	 c2+bdiocXB0HJzLzAQ7cC3UyDt/H2K98dhlNq17g6TXCBJz6UAoTtzyHwEjZ5ZkgSq
	 rkmiP37+0tqEiP3DQTxLrvdC4gJjrI3VAMXifgT/kgFGTeIFl3aTKuulJsxtfq3qYT
	 vW2K+74xR1Jkg==
Date: Thu, 7 Dec 2023 12:30:45 +0000
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
Message-ID: <08ae06c7-1654-4dfd-a789-b8e13c87d705@sirena.org.uk>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
 <20231205-arm64-2023-dpisa-v3-15-dbcbcd867a7f@kernel.org>
 <87cyvi8kz1.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FPF7dtAOG+ogzzSV"
Content-Disposition: inline
In-Reply-To: <87cyvi8kz1.wl-maz@kernel.org>
X-Cookie: Two is company, three is an orgy.


--FPF7dtAOG+ogzzSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 08:39:46AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> >  #define HCRX_GUEST_FLAGS \
> > -	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
> > +	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM | \

> We really should start making all of these things conditional. See
> below.

Is there an overarching theory behind how these things are intended to
work?  I agree with you that I'd have expected more conditionality here,
I was trying to fit in with the existing pattern.  It's kind of hard to
follow what the intention is, I think to some extent due to things
having evolved over time.

> > @@ -517,7 +519,6 @@ struct kvm_vcpu_arch {
> >  	enum fp_type fp_type;
> >  	unsigned int sve_max_vl;
> >  	u64 svcr;
> > -	u64 fpmr;

> Why do this change here? Why isn't done like that the first place?

It didn't seem right to add the register to struct vcpu_sysreg before it
was handled by KVM.  As referenced in the cover letter normally this
wouldn't come up because KVM doesn't rely on the host kernel for
managing register state so we add KVM support then enable the host
kernel but for FPSIMD we're reusing fpsimd_save() so we need the host
kernel support to be in place when we enable KVM.

> >  	CGT_MDCR_TDE,
> > @@ -279,6 +281,12 @@ static const struct trap_bits coarse_trap_bits[] = {
> >  		.mask		= HCR_TTLBOS,
> >  		.behaviour	= BEHAVE_FORWARD_ANY,
> >  	},
> > +	[CGT_HCRX_EnFPM] = {
> > +		.index		= HCRX_EL2,
> > +		.value		= HCRX_EL2_EnFPM,
> > +		.mask		= HCRX_EL2_EnFPM,
> > +		.behaviour	= BEHAVE_FORWARD_ANY,

> This looks wrong. HCRX_EL2.EnFPM is an enable bit.

Right, it's the wrong way round.

> > +static void *fpsimd_share_end(struct user_fpsimd_state *fpsimd)
> > +{
> > +	void *share_end = fpsimd + 1;
> > +
> > +	if (cpus_have_final_cap(ARM64_HAS_FPMR))
> > +		share_end += sizeof(u64);
> > +
> > +	return share_end;
> > +}

> This is horrible. Why can't you just have a new structure wrapping
> both user_fpsimd_state and fpmr? This is going to break in subtle
> ways, just like the SVE/SME stuff.

I agree that it's not great, the main issue was that fpsimd_state is
both already embedded in uw for hardened usercopy and very widely
referenced by exactly which struct it's in so I was taking a guess as to
what would get the least objections.  The obvious thing would be to add
FPMR to uw and share the whole thing with the hypervisor, if people
don't mind adding another field to uw I could do that?

> >  	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
> > +	if (cpus_have_final_cap(ARM64_HAS_FPMR)) {
> > +		WARN_ON_ONCE(&current->thread.fpmr + 1 != fpsimd_share_end(fpsimd));

> How can this happen?

It shouldn't, but it'd be bad if it did so I put a check in to make sure
we haven't messed up.

> > +		vcpu->arch.host_fpmr = kern_hyp_va(&current->thread.fpmr);
> > +	}

> We really need to stop piling the save/restore of stuff that isn't
> advertised to the guest.

I'm not clear what you're referencing here?  The feature is advertised
to the guest via the ID registers and in the past you've pushed back on
making things where the state is just a single register like this
optional.  Do you mean that we should be making this conditional on the
guest ID registers?  If that is the case is there a plan for how that's
supposed to work, set flags when kvm_vcpu_run_pid_change() happens for
example?

--FPF7dtAOG+ogzzSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVxuvUACgkQJNaLcl1U
h9DsZwf/dMO5funercMGolm8oxu/rwH8RhndodNpMcUaWBpR0dwxASiyO2p9IMUH
Po/pRzhdyqIi2EI21TfSynfq0OU0YKFsDNc0ZTGZPjZkBvgeBCLw7dSwWsLw865C
oIboqH/96ZHXVmdGMtaU/dPUCNlnmn85XMRfRRIzYV1Nl9pjokOwsJ3qyQ+YxuXu
dTuX5qZXeU2UYiuRhdKXYvqy332vAmEY9E8zjCr2GBhJCyi8NIIUVTKgx2+Q8/ZF
nqpGNxpQKVfFGpQzrbQXR5TL5/92Ody9tt9n9j2vG1M8hSqrYXM0RaEFW0KG/+4a
vm0qMhLuef6WzUqjhfrEaIdaG+9Lig==
=vTs7
-----END PGP SIGNATURE-----

--FPF7dtAOG+ogzzSV--

