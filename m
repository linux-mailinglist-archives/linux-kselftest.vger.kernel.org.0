Return-Path: <linux-kselftest+bounces-6987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBB18956EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6671C20F46
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1801339A2;
	Tue,  2 Apr 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PymLJU3p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469B133987;
	Tue,  2 Apr 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068475; cv=none; b=O1gCl8lKAKuMqiP6c55pZqcid+wvZTztnlZtYcV26dz2QbO+TASv5loi2BuDuTfNY5el3I9RFMFEyQj3mT2gxSvdnROciTJQGow0hyNg1+sMtBoxB3bxAPpBGy0WkoRlSLHFyHUfJ17i+flt2Nw521TJO6HSmC9dMiO5Z+yMIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068475; c=relaxed/simple;
	bh=88vG8m/Z1Is5v5cdweaMvnmV27K8I1EF8uwunhQOlnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGMa5onk2V2PRodUL72keeC71oAC5kvf81bKVMrHfbVkUd4tFZ6/Kh/oIyWXRfO3ILNfiUKGawWVs/WUosxIZn5RCCB5dlHGvEPZPjbx8XLHru5WCODWiONV2Cl5h2pUhzwYprN7JdTY8bI10L4cwf9433kSCPMalI9qLuzwe6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PymLJU3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA91C433F1;
	Tue,  2 Apr 2024 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712068475;
	bh=88vG8m/Z1Is5v5cdweaMvnmV27K8I1EF8uwunhQOlnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PymLJU3pyvC52D8w0piQ/VqTuwyF8N82wEbV1H9vuAONQav7v7XVivRH/j/Rb1Ti/
	 HwsrzbTJ3Q0mIMRx/+VxxWKv48GSLb+EEtHhfmw8rDRZCmdUO8f0BaUrLK16d1f0/h
	 9iKucjI1k5w8GS4ouqCy3gCJDPa0/k5sOMQ7pJV/YUaBrJLeqHGpDEAJpxoAruQaxR
	 7q/r8L1FzLKYVTZgtW582Pio3oBX477bDcDw6+0tGlOcdMoIeetgmUzVc/uSnHUnX6
	 iiq8kR7trXX4fKXqNpu3MtgQPPzgacbTYCissL9p58IrHthWJUnnCKRKiApVvmK0wM
	 Un8G0Koo3GqDg==
Date: Tue, 2 Apr 2024 15:34:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/5] KVM: arm64: Share all userspace hardened thread
 data with the hypervisor
Message-ID: <fb54d7b0-9c83-4a0c-a08b-b722c9381ca7@sirena.org.uk>
References: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
 <20240329-arm64-2023-dpisa-v6-1-ba42db6c27f3@kernel.org>
 <87msqesoty.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3LQNOITM1KKeWjCg"
Content-Disposition: inline
In-Reply-To: <87msqesoty.wl-maz@kernel.org>
X-Cookie: Knowledge is power.


--3LQNOITM1KKeWjCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 11:00:41AM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > As part of the lazy FPSIMD state transitioning done by the hypervisor we
> > currently share the userpsace FPSIMD state in thread->uw.fpsimd_state w=
ith
> > the host. Since this struct is non-extensible userspace ABI we have to =
keep

> Using the same representation is just pure convenience, and nothing
> requires us to use the it in the kernel/hypervisor.

Indeed, the additional data seemed contained enough that it was a
reasonable tradeoff.

> > the definition as is but the addition of FPMR in the 2023 dpISA means t=
hat
> > we will want to share more storage with the host. To facilitate this
> > refactor the current code to share the entire thread->uw rather than ju=
st
> > the one field.

> So this increase the required sharing with EL2 from 528 bytes to
> 560. Not a huge deal, but definitely moving in the wrong direction. Is
> there any plans to add more stuff to this structure that wouldn't be
> *directly* relevant to the hypervisor?

I'm not aware of any current plans to extend this.

> > @@ -640,7 +641,7 @@ struct kvm_vcpu_arch {
> >  	struct kvm_guest_debug_arch vcpu_debug_state;
> >  	struct kvm_guest_debug_arch external_debug_state;
> > =20
> > -	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
> > +	struct thread_struct_uw *host_uw;	/* hyp VA */
> >  	struct task_struct *parent_task;

> Well, this is going away, and you know it.

Sure, those patches are still in flight though.  It does seem reasonable
to target the current code.

--3LQNOITM1KKeWjCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMF3MACgkQJNaLcl1U
h9B5AwgAhpV1i1kBzNj1g27Or01g8HGoRjn1rDwbQhp9el4SuuJTTDy0hC7NoUu4
2yIpwVaql/hK/jq2O4qzjN/WaZpXEg1uQdt0UfSnyTa4LoDGwfnA5Bt7KNTCnCCK
7jnKGBvP1OEPSU/w7pQz029FV1hHySP73XNcXwpnE5YXuu5XVHZ/5x2mAYiP1XKG
SLRnMJ68l0yUMxbCbnJFAuWg04X3MxUmFZjOQtc1McnI5HJRmUN79OI9ifqrOEOU
e9XGatS9m3/Mfdr+z1sDK45sE+XSIHxMBHOFJDo1VY2DAXMoKYO244XiI4asC+y9
9uJmDNEyA7pg/yRI/cujvTKLtha6Gw==
=Gfx9
-----END PGP SIGNATURE-----

--3LQNOITM1KKeWjCg--

