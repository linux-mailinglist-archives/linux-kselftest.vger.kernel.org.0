Return-Path: <linux-kselftest+bounces-46534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2371C8B2ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54DDD35856E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF9278165;
	Wed, 26 Nov 2025 17:23:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49A72773D3;
	Wed, 26 Nov 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177838; cv=none; b=ObWE5TBFJ/J26GSUelr8/EKaR7jrJT0q6CUJ0Qj2/9sKPPmZZmMPjuUbO5PrSq+8VKraIxB2yjE1Fw1a3v0jgXrLzj4YVUAjC5vX8JOUdwdsf3A87oYoY6+psGLeBxV81UUhSaOjn9lW9AtzSegNPqn84T8961jOgj8BTjhsVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177838; c=relaxed/simple;
	bh=Ns2uIjc6ylcF5DtOMpf79pYda6x1DtUCP+tyq6fOCvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnarA3iy/AwMjvwyp/RbzIB/3z27B1M9wOzGd/kPdfW3RrTtJgmvbC1CnN2ORg0Z4KNvlQ+dGEV29nhH4t5jVqbjIGK6h2tB7fhoFaZEBS0fyByhD9r2tk8REw2i0nenw3bzBVf+QTLBvzYDlGdUsiow7xRoEB2YwgrPNwMqW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4D80168F;
	Wed, 26 Nov 2025 09:23:48 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E853F66E;
	Wed, 26 Nov 2025 09:23:53 -0800 (PST)
Date: Wed, 26 Nov 2025 17:23:47 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Fuad Tabba <tabba@google.com>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 11/29] KVM: arm64: Document the KVM ABI for SME
Message-ID: <aScfSMZEKCeUq7Zn@e133380.arm.com>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
 <20250902-kvm-arm64-sme-v8-11-2cb2199c656c@kernel.org>
 <CAFEAcA_GJ7gzn7aMCZYxHnJWvx4tHSHBKsOxtQ7NTb4gPjkMJQ@mail.gmail.com>
 <df712591-397e-422b-b9c9-fbf080cad9aa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df712591-397e-422b-b9c9-fbf080cad9aa@sirena.org.uk>

Hi,

On Mon, Nov 24, 2025 at 08:12:56PM +0000, Mark Brown wrote:
> On Mon, Nov 24, 2025 at 03:48:06PM +0000, Peter Maydell wrote:
> > On Tue, 2 Sept 2025 at 12:45, Mark Brown <broonie@kernel.org> wrote:
> 
> > > SME, the Scalable Matrix Extension, is an arm64 extension which adds
> > > support for matrix operations, with core concepts patterned after SVE.
> 
> > I haven't actually tried writing any code that uses this proposed
> > ABI, but mostly it looks OK to me. I have a few nits below, but
> > my main concern is the bits of text that say (or seem to say --
> > maybe I'm misinterpreting them) that various parts of how userspace
> > accesses the guest state (e.g. the fp regs) depend on the current
> > state of the vcpu, rather than being only a function of how the
> > vcpu was configured. That seems to me like it's unnecessarily awkward.
> > (More detail below.)
> 
> That was deliberate and I agree it is awkward, it was introduced as a
> result of earlier review comments.  I had originally implemented an ABI
> where the VL for the vector registers was the maximum of the SVE and SME
> VLs but the feedback was that the ABI should instead follow what the
> architecture does with the vector length and potentially presence of the
> vector registers depending on the current streaming mode configuration.
> It sounds like you would prefer something more like what was there
> originally?
> 
> > > For SME unware VMMs on systems with both SVE and SME support the SVE
> > > registers may be larger than expected, this should be less disruptive
> > > than on a system without SVE as they will simply ignore the high bits of
> > > the registers.
> 
> > I think that since enabling SME is something the VMM has to actively
> > do, it isn't a big deal that they also need to do something in the
> > fp or sve register access codepaths to handle SME. You can't get
> > SME by surprise (same as you can't get SVE by surprise).
> 
> Yes, it's not going to affect anything without enabling it.  I can't
> remember what that was in reference to, it clearly needs an update.
> 
> > >  .. [1] These encodings are not accepted for SVE-enabled vcpus.  See
> > > -       :ref:`KVM_ARM_VCPU_INIT`.
> > > +       :ref:`KVM_ARM_VCPU_INIT`.  They are also not accepted when SME is
> > > +       enabled without SVE and the vcpu is in streaming mode.
> 
> > Does this mean that on an SME-no-SVE VM the VMM needs to know
> > if the vcpu is currently in streaming mode or not to determine
> > whether to read the FP registers as fp_regs or sve regs? That
> > seems unpleasant -- I was expecting this to be strictly a
> > matter of how the VM was configured (as it is with SVE).
> 
> Yes, it does.

Ditto from me about not having looked at this earlier...


Is the above condition right re streaming mode?  The original reason
for this restriction was that the SVE Z-regs and FPSIMD V-regs are
aliases when SVE is present.  To avoid having to worry about how to
order register accesses and/or paste parts of them together, we went
down the road of banishing encodings that alias a subset of the
register state accessed by some other encoding.

In line with this principle, with SME Vn and Zn are aliases when
*not* in streaming mode, so allowing access through the Vn view feels
problematic too?  (And when in streaming mode, the Vn regs don't exist
at all.)

Whether the proposed ABI is considered awkward for VMMs or not is a
separate matter...)

> 
> > > +arm64 SME registers have the following bit patterns:
> 
> > > +  0x6080 0000 0017 00 <n:5> <slice:5>   ZA.H[n] bits[2048*slice + 2047 : 2048*slice]
> > > +  0x60XX 0000 0017 0100                 ZT0
> 
> > What's the XX here ?
> 
> Sorry, will fill that in - thanks for spotting it.
> 
> > > +  0x6060 0000 0017 fffe                 KVM_REG_ARM64_SME_VLS pseudo-register
> > > +
> > > +Access to Z, P or ZA register IDs where 2048 * slice >= 128 * max_vq
> > > +will fail with ENOENT.  max_vq is the vcpu's maximum supported vector
> > > +length in 128-bit quadwords: see [2]_ below.
> 
> > What about FFR registers ? Is their ENOENT condition the same,
> > or different?
> 
> It should be the same, will update to clarify.
>
> > > +       max_vq.  This is the maximum vector length currently available to
> > > +       the guest on this vcpu, and determines which register slices are
> > > +       visible through this ioctl interface.
> 
> > > +       If SME is supported then the max_vq used for the Z and P registers
> > > +       while SVCR.SM is 1 this vector length will be the maximum SME
> > > +       vector length available for the guest, otherwise it will be the
> > > +       maximum SVE vector length available.

The max_vq name here is not ABI; it's just linking concepts together in
the documentation text.

So, can we give explicitly different names to these two max_vq values?

Splitting the affected register descriptions into "SVCR.SM == 0" and
"SVCR.SM == 1" cases also be helpful to make this special-casing clear.

> 
> > I can't figure out what this paragraph is trying to say, partly
> > because it seems like it might be missing some text between
> > "is 1" and "this vector length".
> 
> > In any case, the "while SVCR.SM is 1" part seems odd -- I
> > don't think this ABI should care about the runtime vcpu state,
> > only what the vcpu's max vector lengths were configured as.
> > My expectation would be that the max_vq for VMM register
> > access would be the maximum of the SVE and SME vector lengths
> > configured for the vcpu.
> 
> This is attempting to say that the VL for the Z and P registers (and
> FFR) will vary depending on if the vCPU is in streaming mode or not if
> the maximum VL for SVE and SME differs, similarly to how the Z, P and
> FFR registers disappear when we are not in streaming mode in a SME only
> system.

May flipping SVCR.SM through KVM_SET_ONE_REG have the architectural
effect of zeroing the vector regs?  That feels like something that
should be stated explicitly.


Also, in general:

I'd agree that this mutating interface feels odd, and does not follow
the original spirit of the design here.

But the SME architecture doesn't fit well with the spirit of the
original KVM ABI here either, so I guess there won't be a perfect
solution.


It seems that when SME is enabled in the vCPU features and the VMM is
planning to dump or set affected registers, there is a requirement to
dump / set SVCR.SM first, and then go down one of two code paths.  Can
this be called out explicitly?  This is a departure from the the
previous interaction model, so it probably deserves its own section,
which can then be cross-referenced from individual reg
descriptions.

SVCR.SM exhibits this modality w.r.t a specific set of affected
register encodings; it would be good to have that captured clearly in
one place.

(This may or may not make life easier for VMMs -- I'll leave it to
Peter to comment on that!)

Cheers
---Dave

