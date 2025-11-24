Return-Path: <linux-kselftest+bounces-46402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC87FC8263C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 21:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CC53ADD0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE23832E13F;
	Mon, 24 Nov 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2QHujrF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407532D42F;
	Mon, 24 Nov 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764015183; cv=none; b=sZ1PKN6VMA863oyqK7w3A23PWGfzkswgltH9Ak141RZRn3eHAyA3FwfORUt9BxS/pF8mELfaw3HTWbZ6P15F6Z317kDkFXMhbiV4uaKw8E5kxWrY025sjiCyjANIL8Ct9tO5CrN9f2e0v38Qvt/JdwdjCeDtDF2hDlyDuJl0SQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764015183; c=relaxed/simple;
	bh=59SAY8rSRQdKkmSqsZ8fxhNqn4eJOSo2jhDbTdmHHMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhOLS+8hGZKbiMj5qDnOSr3d/KfAbmM8CT9IvbpgGIQ2zp6OnVh5QEiN3mBQrLuCST4sA/afTUjoD8AgolsNRywcigXYuv7Nt3eznqE/QHmbKYBV51IbM6+XG/dD3jeMPB1TBsdPa8LufFOOAEshl7nFhtrZtwJ9aouaI1p3kNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2QHujrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716C5C16AAE;
	Mon, 24 Nov 2025 20:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764015183;
	bh=59SAY8rSRQdKkmSqsZ8fxhNqn4eJOSo2jhDbTdmHHMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2QHujrFXR0jsKPScMcDVOwzUAxawOasc77PuB08gEwfLV++tpH7HWheW9+C1zFFG
	 OL5X0V+s5ngLMaYNV3qq270C0fQMPWGM0hSbubzLl2THDPpx9JCvI2SE5qxne8YWbV
	 t+HvdFePKS1dOTcJQoKAzp9YaNoVYqJnreIUQLcXklYgVLf3EHSaH1xGy6hReEzNF1
	 CO07v54YkkSDOKdee7NZ1OrxjqcqUb+EQCs8KhOiQwP1UC11xQKlK/6fi83Dc2tpfa
	 AIRRzfsBin/uqF6CXCyEzdZVw/KvHMUsh20kllg/foXagaMDlvyXPjYCKwThfQlPae
	 PdRi6vuXPZV9Q==
Date: Mon, 24 Nov 2025 20:12:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 11/29] KVM: arm64: Document the KVM ABI for SME
Message-ID: <df712591-397e-422b-b9c9-fbf080cad9aa@sirena.org.uk>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
 <20250902-kvm-arm64-sme-v8-11-2cb2199c656c@kernel.org>
 <CAFEAcA_GJ7gzn7aMCZYxHnJWvx4tHSHBKsOxtQ7NTb4gPjkMJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EW4pgm0dnCxmWii4"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_GJ7gzn7aMCZYxHnJWvx4tHSHBKsOxtQ7NTb4gPjkMJQ@mail.gmail.com>
X-Cookie: Single tasking: Just Say No.


--EW4pgm0dnCxmWii4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2025 at 03:48:06PM +0000, Peter Maydell wrote:
> On Tue, 2 Sept 2025 at 12:45, Mark Brown <broonie@kernel.org> wrote:

> > SME, the Scalable Matrix Extension, is an arm64 extension which adds
> > support for matrix operations, with core concepts patterned after SVE.

> I haven't actually tried writing any code that uses this proposed
> ABI, but mostly it looks OK to me. I have a few nits below, but
> my main concern is the bits of text that say (or seem to say --
> maybe I'm misinterpreting them) that various parts of how userspace
> accesses the guest state (e.g. the fp regs) depend on the current
> state of the vcpu, rather than being only a function of how the
> vcpu was configured. That seems to me like it's unnecessarily awkward.
> (More detail below.)

That was deliberate and I agree it is awkward, it was introduced as a
result of earlier review comments.  I had originally implemented an ABI
where the VL for the vector registers was the maximum of the SVE and SME
VLs but the feedback was that the ABI should instead follow what the
architecture does with the vector length and potentially presence of the
vector registers depending on the current streaming mode configuration.
It sounds like you would prefer something more like what was there
originally?

> > For SME unware VMMs on systems with both SVE and SME support the SVE
> > registers may be larger than expected, this should be less disruptive
> > than on a system without SVE as they will simply ignore the high bits of
> > the registers.

> I think that since enabling SME is something the VMM has to actively
> do, it isn't a big deal that they also need to do something in the
> fp or sve register access codepaths to handle SME. You can't get
> SME by surprise (same as you can't get SVE by surprise).

Yes, it's not going to affect anything without enabling it.  I can't
remember what that was in reference to, it clearly needs an update.

> >  .. [1] These encodings are not accepted for SVE-enabled vcpus.  See
> > -       :ref:`KVM_ARM_VCPU_INIT`.
> > +       :ref:`KVM_ARM_VCPU_INIT`.  They are also not accepted when SME is
> > +       enabled without SVE and the vcpu is in streaming mode.

> Does this mean that on an SME-no-SVE VM the VMM needs to know
> if the vcpu is currently in streaming mode or not to determine
> whether to read the FP registers as fp_regs or sve regs? That
> seems unpleasant -- I was expecting this to be strictly a
> matter of how the VM was configured (as it is with SVE).

Yes, it does.

> > +arm64 SME registers have the following bit patterns:

> > +  0x6080 0000 0017 00 <n:5> <slice:5>   ZA.H[n] bits[2048*slice + 2047 : 2048*slice]
> > +  0x60XX 0000 0017 0100                 ZT0

> What's the XX here ?

Sorry, will fill that in - thanks for spotting it.

> > +  0x6060 0000 0017 fffe                 KVM_REG_ARM64_SME_VLS pseudo-register
> > +
> > +Access to Z, P or ZA register IDs where 2048 * slice >= 128 * max_vq
> > +will fail with ENOENT.  max_vq is the vcpu's maximum supported vector
> > +length in 128-bit quadwords: see [2]_ below.

> What about FFR registers ? Is their ENOENT condition the same,
> or different?

It should be the same, will update to clarify.

> > +       max_vq.  This is the maximum vector length currently available to
> > +       the guest on this vcpu, and determines which register slices are
> > +       visible through this ioctl interface.

> > +       If SME is supported then the max_vq used for the Z and P registers
> > +       while SVCR.SM is 1 this vector length will be the maximum SME
> > +       vector length available for the guest, otherwise it will be the
> > +       maximum SVE vector length available.

> I can't figure out what this paragraph is trying to say, partly
> because it seems like it might be missing some text between
> "is 1" and "this vector length".

> In any case, the "while SVCR.SM is 1" part seems odd -- I
> don't think this ABI should care about the runtime vcpu state,
> only what the vcpu's max vector lengths were configured as.
> My expectation would be that the max_vq for VMM register
> access would be the maximum of the SVE and SME vector lengths
> configured for the vcpu.

This is attempting to say that the VL for the Z and P registers (and
FFR) will vary depending on if the vCPU is in streaming mode or not if
the maximum VL for SVE and SME differs, similarly to how the Z, P and
FFR registers disappear when we are not in streaming mode in a SME only
system.

--EW4pgm0dnCxmWii4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkkvEgACgkQJNaLcl1U
h9Bszwf/TOe0ab3gn4vn1mCKo72tW/w2yyoCXjm7kHc+dxKFjFQtadGE6kDzG01F
bUz75fKCTu/MUQZAZ9v96NA8uaXueyAzHVr9mz3m6GKBnCcoTp8ipSDCJPfvta0+
vx1tFQqzG6Dbdmz4+JmfZXmC6BMqVKKunjMGnMRFlBmNUT/J/NgHIbV5NHHpzAK4
iOo0BplyddmzPT4fV/sRD/pftSNew4y0XcmOrCNKJgKj7+fH99pMEkESVi2xviLn
6uzaN/7XsQVr06e5p+uXjFmPbjJ8pm/R/VvJ5h2UfktCnPvwfrtSGdoHvJ9PFJtY
gXmZJ0OovxVpTYerBjInafx3x26q6Q==
=C2Mw
-----END PGP SIGNATURE-----

--EW4pgm0dnCxmWii4--

