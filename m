Return-Path: <linux-kselftest+bounces-48518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B5D03736
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F2D32D9B84
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE7A4CBA92;
	Thu,  8 Jan 2026 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDqDLARD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B5F4CBA90
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881443; cv=pass; b=ssHl7Qdw8Q2VsGkbQ+3xzWLXLBy7JEVp607uoKOixvXwrbUhafibm4zYLlAdK6ops/b0uDeL5CCvoeEnR+Y4tPAbn4J7rfJ3eDDyS6NqG0H8kYP1KeLhf/woP5cJiKrnA/eEEm14neu8FQy2wLrt6F6VrVBkPOEdiGiMvyX7E2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881443; c=relaxed/simple;
	bh=X5JZrydhnRwszi4Nh/fSncQIUleu8YN39EB5ilvIOy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bz4gIctIJwkhAqcMVgFZRlAx/Jkagawj5C4v8yNxnEmLdjzQ6MrURGFmxwQXH2y/ec4xLVp4/PepYlJxo4U4kvVSUfudA02D9TgSJ5o5DO3s5X+e93RYaaMyViOr8qi7LSFHziVt8DbHSljSX2EoJNbucKOaVTy/D7FnnEpFsVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gDqDLARD; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee243b98caso846121cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 06:10:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767881440; cv=none;
        d=google.com; s=arc-20240605;
        b=PR5BJ7cfEqW8lstadT0q6gekbOYEbGd8FqZ5Sy596ud2JcDs6MVWZJmNpk8zICZutX
         dd/mpzmOpJZIr6SizEYLP7YTP/L6mdnuB1JmHWrdpDbAezyz+9Pz4wFbIFjOsngZrXUr
         dM5Y6xd9XY/Fb8D0CXmisTFhnWIwF1PfOCew7wSd41KWK2CSDdogSbKw0pQhH4Iz1xRl
         qTIw4wUJXv0p+iScomamlShIGEzytCJZs0rdJ2azUPCznd6R5zCuYSOuEuXN+/B8qts3
         UhoeTbSBFXJXGTNz5uGa5/eh5MY9MtpNJZFUd7xDM4vsStcz+AKFrp1jrXGp2ipHFReL
         5ATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bYto/95PAr5gdcAcFK+iKyUSkfGbLtjfHkyX3NOOQHk=;
        fh=tLV2tseiurGIKEQ3pjNvAqgEDSZciEj9yqaQdrbJA/E=;
        b=dgzjSQC3bGDU/9tRP8WofpVnqP0lhtzP5BpEuwqiFwi2rQDs0Z1pk1955Rm/OVaErD
         OFbphL4UaZvs2UW9Z1wHEEYGwNyfZ3HYVx3eu1mM1qbk06aXxICyDFfrWCKqR2j3SwLp
         Nj1nujx8yduU4dwrcyhNBCv7k8Z0HI2cuNZNWSPoppq8dgJ28BRP7QkgoAcMNYikb8I2
         Zw2+9bHqlwLbS/QXl6PB050ScLw/Lba2Dyk3R+ZMQ2KiGZhyQHDo1rLBQzazYo9TN5dT
         415aeqZBuB8l2XEuPUiU0ERcGrCwscCAMXxh1bfOuNMaz2y84ydvWKCMGYQGLdDFD5Xl
         LzOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767881440; x=1768486240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bYto/95PAr5gdcAcFK+iKyUSkfGbLtjfHkyX3NOOQHk=;
        b=gDqDLARDrRO3pM3Pb1pvk8wSHszVDVxPODH0ZDi4a5yiSB6i3SfKcpHxw0BBJPGA6E
         6j/NWdk+WgaG/mk/H5KjvBYqSv0sU7o4p6Wll1s4ei1FaoH73pJA6f8+Ga6/0xAmXdC9
         CHhk/F7ZJT7GCQl2q9vhkVNImTzAUhm1S5JEm8BPw9BsWQD5xGQ2mfaXRaHwAUNYtBi3
         UXzDAXuYcZ+ApK8IM/04tT87OSqC6KlgrFKALiNT7/vk1amudoLTD0WJDWjA3jRfyAqe
         GxLDje0yDPV2Phb69YoSU1pHbfB9N7KTZYMtlk85KSaqwovz4OnCq3g00lMp3Z2OwPI9
         uOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881440; x=1768486240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYto/95PAr5gdcAcFK+iKyUSkfGbLtjfHkyX3NOOQHk=;
        b=gBkc5Hmoa5ZhysTzQ5MwsdxIKBfq3RjsfBkNz0otvBm3SGlutPKUyVd3e4sA1q5tiv
         MhS6HWx/gdnPHEvrbjh2KSft48LzGSpBXuUcyCU9kCNsqrMNAVH7DyFl8Gsi5R4Pq+fU
         Kp9xLDs6PcbxnqQFLQ8QcM8tKaymvJiMez90RrXu6IAfSzFdKwMg8el/3PLgD/WPe7Nz
         kJ9V6tVeluYZ9CeFZmv43HkMtwi6mVIEDf9N0MxDiitvM4TQ/q7R3hdBxXXniyLEHVS5
         07NKd0jMZSDN+YnfHMC5OzlmClOizvRVgaVUwUF8DXuGEjrgyrZgeDo8hkPU3ri9KagQ
         xA0g==
X-Forwarded-Encrypted: i=1; AJvYcCUXP4S8eHqe/mQnJtAV0GiaX7+1qk7sN9hLi7hDuFC1O7anjPzBWJypADi4Oy3lq9x2KiDgnxqmw/fVnAzsrGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0TuWGoZ4lqaLoq20/X8nFPiFbpezbMUAIED440Ylo/auLO51
	+cNVuWjMowBcuW2BINqoVZbZmahbtGk0+FAH262tKz2Q0MfnUzsusN+IYz+0428a72Bes9AoPWQ
	/jg4TPxwO0MO4VZpRNi/O98+yju+fgNdqNjxEWpiL
X-Gm-Gg: AY/fxX6T3xAfLkKOvR6j5VL1DyTFg92XtRpcGMcrJaryiXcthKznTJ0jyotZfv8oKU+
	iwKyGxwQwcrMaWF0VliP9L3H7WoDpKf/WD5hQljW81vAnSSvB/3LuY2QJRFz3tgExi4pActV4Ve
	JfIPB0Wqctd6W5AfRC/7uZpYEIyl5o7dfcHP5g4LJj8fXNxHSj+NFZRW6cA6bOt3tpe35ijIPUg
	Ru0HUdijsp99Mok9qj/50gfGfffRtjmnA2OSvBr8tYBZioj9/edEygrBCC6qpAzIYXBdVR7
X-Received: by 2002:ac8:57cb:0:b0:4ff:a98b:7fd3 with SMTP id
 d75a77b69052e-4ffc091f255mr8431011cf.2.1767881439463; Thu, 08 Jan 2026
 06:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-10-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-10-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 8 Jan 2026 14:10:02 +0000
X-Gm-Features: AQt7F2qsebDUu0B_2G-HsVQbz5HiOT-Zx5BHQ2lphbkAHqCchx69wBlkCSdT4l4
Message-ID: <CA+EHjTyww-PoswXx4ufJozX=eP-Q+8OahiH7XO99HsKcjO1O9A@mail.gmail.com>
Subject: Re: [PATCH v9 10/30] KVM: arm64: Document the KVM ABI for SME
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, 
	Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:
>
> SME, the Scalable Matrix Extension, is an arm64 extension which adds
> support for matrix operations, with core concepts patterned after SVE.
>
> SVE introduced some complication in the ABI since it adds new vector
> floating point registers with runtime configurable size, the size being
> controlled by a parameter called the vector length (VL). To provide control
> of this to VMMs we offer two phase configuration of SVE, SVE must first be
> enabled for the vCPU with KVM_ARM_VCPU_INIT(KVM_ARM_VCPU_SVE), after which
> vector length may then be configured but the configurably sized floating
> point registers are inaccessible until finalized with a call to
> KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE) after which the configurably sized
> registers can be accessed.

s/configurably/configurable

>
> SME introduces an additional independent configurable vector length
> which as well as controlling the size of the new ZA register also
> provides an alternative view of the configurably sized SVE registers
> (known as streaming mode) with the guest able to switch between the two
> modes as it pleases.  There is also a fixed sized register ZT0
> introduced in SME2. As well as streaming mode the guest may enable and
> disable ZA and (where SME2 is available) ZT0 dynamically independently
> of streaming mode. These modes are controlled via the system register
> SVCR.
>
> We handle the configuration of the vector length for SME in a similar
> manner to SVE, requiring initialization and finalization of the feature
> with a pseudo register controlling the available SME vector lengths as for
> SVE. Further, if the guest has both SVE and SME then finalizing one
> prevents further configuration of the vector length for the other.
>
> Where both SVE and SME are configured for the guest we always present
> the SVE registers to userspace as having the larger of the configured
> maximum SVE and SME vector lengths, discarding extra data at load time

Looking at the code with the whole patch series applied, I don't think
this is correct, rather, it depends on the active vector length. That
said, it's not what the documentation below says, so it's only an
issue in the commit message.

> and zero padding on read as required if the active vector length is
> lower. Note that this means that enabling or disabling streaming mode
> while the guest is stopped will not zero Zn or Pn as it will when the
> guest is running, but it does allow SVCR, Zn and Pn to be read and
> written in any order.
>
> Userspace access to ZA and (if configured) ZT0 is always available, they
> will be zeroed when the guest runs if disabled in SVCR and the value
> read will be zero if the guest stops with them disabled. This mirrors
> the behaviour of the architecture, enabling access causes ZA and ZT0 to
> be zeroed, while allowing access to SVCR, ZA and ZT0 to be performed in
> any order.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/virt/kvm/api.rst | 120 +++++++++++++++++++++++++++++------------
>  1 file changed, 86 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 01a3abef8abb..e024b9783932 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -406,7 +406,7 @@ Errors:
>               instructions from device memory (arm64)
>    ENOSYS     data abort outside memslots with no syndrome info and
>               KVM_CAP_ARM_NISV_TO_USER not enabled (arm64)
> -  EPERM      SVE feature set but not finalized (arm64)
> +  EPERM      SVE or SME feature set but not finalized (arm64)
>    =======    ==============================================================
>
>  This ioctl is used to run a guest virtual cpu.  While there are no
> @@ -2606,11 +2606,11 @@ Specifically:
>  ======================= ========= ===== =======================================
>
>  .. [1] These encodings are not accepted for SVE-enabled vcpus.  See
> -       :ref:`KVM_ARM_VCPU_INIT`.
> +       :ref:`KVM_ARM_VCPU_INIT`.  They are also not accepted when SME is
> +       enabled without SVE and the vcpu is in streaming mode.
>
>         The equivalent register content can be accessed via bits [127:0] of
> -       the corresponding SVE Zn registers instead for vcpus that have SVE
> -       enabled (see below).
> +       the corresponding SVE Zn registers in these cases (see below).
>
>  arm64 CCSIDR registers are demultiplexed by CSSELR value::
>
> @@ -2641,24 +2641,39 @@ arm64 SVE registers have the following bit patterns::
>    0x6050 0000 0015 060 <slice:5>        FFR bits[256*slice + 255 : 256*slice]
>    0x6060 0000 0015 ffff                 KVM_REG_ARM64_SVE_VLS pseudo-register
>
> -Access to register IDs where 2048 * slice >= 128 * max_vq will fail with
> -ENOENT.  max_vq is the vcpu's maximum supported vector length in 128-bit
> -quadwords: see [2]_ below.
> +arm64 SME registers have the following bit patterns:
> +
> +  0x6080 0000 0017 00 <n:5> <slice:5>   ZA.H[n] bits[2048*slice + 2047 : 2048*slice]
> +  0x6060 0000 0017 0100                 ZT0
> +  0x6060 0000 0017 fffe                 KVM_REG_ARM64_SME_VLS pseudo-register
> +
> +Access to Z, P, FFR or ZA register IDs where 2048 * slice >= 128 *
> +max_vq will fail with ENOENT.  max_vq is the vcpu's current maximum
> +supported vector length in 128-bit quadwords: see [2]_ below.
> +
> +Changing the value of SVCR.SM will result in the contents of
> +the Z, P and FFR registers being reset to 0.  When restoring the
> +values of these registers for a VM with SME support it is
> +important that SVCR.SM be configured first.
> +
> +Access to the ZA and ZT0 registers is only available if SVCR.ZA is set
> +to 1.
>
>  These registers are only accessible on vcpus for which SVE is enabled.
>  See KVM_ARM_VCPU_INIT for details.
>
> -In addition, except for KVM_REG_ARM64_SVE_VLS, these registers are not
> -accessible until the vcpu's SVE configuration has been finalized
> -using KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE).  See KVM_ARM_VCPU_INIT
> -and KVM_ARM_VCPU_FINALIZE for more information about this procedure.
> +In addition, except for KVM_REG_ARM64_SVE_VLS and
> +KVM_REG_ARM64_SME_VLS, these registers are not accessible until the
> +vcpu's SVE and SME configuration has been finalized using
> +KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC).  See KVM_ARM_VCPU_INIT and
> +KVM_ARM_VCPU_FINALIZE for more information about this procedure.
>
> -KVM_REG_ARM64_SVE_VLS is a pseudo-register that allows the set of vector
> -lengths supported by the vcpu to be discovered and configured by
> -userspace.  When transferred to or from user memory via KVM_GET_ONE_REG
> -or KVM_SET_ONE_REG, the value of this register is of type
> -__u64[KVM_ARM64_SVE_VLS_WORDS], and encodes the set of vector lengths as
> -follows::
> +KVM_REG_ARM64_SVE_VLS and KVM_ARM64_VCPU_SME_VLS are pseudo-registers

KVM_ARM64_VCPU_SME_VLS -> KVM_REG_ARM64_SME_VLS

With this and the commit message fixed:
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> +that allows the set of vector lengths supported by the vcpu to be
> +discovered and configured by userspace.  When transferred to or from
> +user memory via KVM_GET_ONE_REG or KVM_SET_ONE_REG, the value of this
> +register is of type __u64[KVM_ARM64_SVE_VLS_WORDS], and encodes the
> +set of vector lengths as follows::
>
>    __u64 vector_lengths[KVM_ARM64_SVE_VLS_WORDS];
>
> @@ -2670,19 +2685,25 @@ follows::
>         /* Vector length vq * 16 bytes not supported */
>
>  .. [2] The maximum value vq for which the above condition is true is
> -       max_vq.  This is the maximum vector length available to the guest on
> -       this vcpu, and determines which register slices are visible through
> -       this ioctl interface.
> +       max_vq.  This is the maximum vector length currently available to
> +       the guest on this vcpu, and determines which register slices are
> +       visible through this ioctl interface.
> +
> +       If SME is supported then the max_vq used for the Z and P registers
> +       while SVCR.SM is 1 this vector length will be the maximum SME
> +       vector length max_vq_sme available for the guest, otherwise it
> +       will be the maximum SVE vector length max_vq_sve available.
>
>  (See Documentation/arch/arm64/sve.rst for an explanation of the "vq"
>  nomenclature.)
>
> -KVM_REG_ARM64_SVE_VLS is only accessible after KVM_ARM_VCPU_INIT.
> -KVM_ARM_VCPU_INIT initialises it to the best set of vector lengths that
> -the host supports.
> +KVM_REG_ARM64_SVE_VLS and KVM_REG_ARM_SME_VLS are only accessible
> +after KVM_ARM_VCPU_INIT.  KVM_ARM_VCPU_INIT initialises them to the
> +best set of vector lengths that the host supports.
>
> -Userspace may subsequently modify it if desired until the vcpu's SVE
> -configuration is finalized using KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE).
> +Userspace may subsequently modify these registers if desired until the
> +vcpu's SVE and SME configuration is finalized using
> +KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC).
>
>  Apart from simply removing all vector lengths from the host set that
>  exceed some value, support for arbitrarily chosen sets of vector lengths
> @@ -2690,8 +2711,8 @@ is hardware-dependent and may not be available.  Attempting to configure
>  an invalid set of vector lengths via KVM_SET_ONE_REG will fail with
>  EINVAL.
>
> -After the vcpu's SVE configuration is finalized, further attempts to
> -write this register will fail with EPERM.
> +After the vcpu's SVE or SME configuration is finalized, further
> +attempts to write these registers will fail with EPERM.
>
>  arm64 bitmap feature firmware pseudo-registers have the following bit pattern::
>
> @@ -3490,6 +3511,7 @@ The initial values are defined as:
>         - General Purpose registers, including PC and SP: set to 0
>         - FPSIMD/NEON registers: set to 0
>         - SVE registers: set to 0
> +       - SME registers: set to 0
>         - System registers: Reset to their architecturally defined
>           values as for a warm reset to EL1 (resp. SVC) or EL2 (in the
>           case of EL2 being enabled).
> @@ -3533,7 +3555,7 @@ Possible features:
>
>         - KVM_ARM_VCPU_SVE: Enables SVE for the CPU (arm64 only).
>           Depends on KVM_CAP_ARM_SVE.
> -         Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
> +         Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
>
>            * After KVM_ARM_VCPU_INIT:
>
> @@ -3541,7 +3563,7 @@ Possible features:
>                 initial value of this pseudo-register indicates the best set of
>                 vector lengths possible for a vcpu on this host.
>
> -          * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
> +          * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
>
>               - KVM_RUN and KVM_GET_REG_LIST are not available;
>
> @@ -3554,11 +3576,40 @@ Possible features:
>                 KVM_SET_ONE_REG, to modify the set of vector lengths available
>                 for the vcpu.
>
> -          * After KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
> +          * After KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
>
>               - the KVM_REG_ARM64_SVE_VLS pseudo-register is immutable, and can
>                 no longer be written using KVM_SET_ONE_REG.
>
> +       - KVM_ARM_VCPU_SME: Enables SME for the CPU (arm64 only).
> +         Depends on KVM_CAP_ARM_SME.
> +         Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
> +
> +          * After KVM_ARM_VCPU_INIT:
> +
> +             - KVM_REG_ARM64_SME_VLS may be read using KVM_GET_ONE_REG: the
> +               initial value of this pseudo-register indicates the best set of
> +               vector lengths possible for a vcpu on this host.
> +
> +          * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
> +
> +             - KVM_RUN and KVM_GET_REG_LIST are not available;
> +
> +             - KVM_GET_ONE_REG and KVM_SET_ONE_REG cannot be used to access
> +               the scalable architectural SVE registers
> +               KVM_REG_ARM64_SVE_ZREG(), KVM_REG_ARM64_SVE_PREG() or
> +               KVM_REG_ARM64_SVE_FFR, the matrix register
> +               KVM_REG_ARM64_SME_ZA() or the LUT register KVM_REG_ARM64_ZT();
> +
> +             - KVM_REG_ARM64_SME_VLS may optionally be written using
> +               KVM_SET_ONE_REG, to modify the set of vector lengths available
> +               for the vcpu.
> +
> +          * After KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
> +
> +             - the KVM_REG_ARM64_SME_VLS pseudo-register is immutable, and can
> +               no longer be written using KVM_SET_ONE_REG.
> +
>         - KVM_ARM_VCPU_HAS_EL2: Enable Nested Virtualisation support,
>           booting the guest from EL2 instead of EL1.
>           Depends on KVM_CAP_ARM_EL2.
> @@ -5143,11 +5194,12 @@ Errors:
>
>  Recognised values for feature:
>
> -  =====      ===========================================
> -  arm64      KVM_ARM_VCPU_SVE (requires KVM_CAP_ARM_SVE)
> -  =====      ===========================================
> +  =====      ==============================================================
> +  arm64      KVM_ARM_VCPU_VEC (requires KVM_CAP_ARM_SVE or KVM_CAP_ARM_SME)
> +  arm64      KVM_ARM_VCPU_SVE (alias for KVM_ARM_VCPU_VEC)
> +  =====      ==============================================================
>
> -Finalizes the configuration of the specified vcpu feature.
> +Finalizes the configuration of the specified vcpu features.
>
>  The vcpu must already have been initialised, enabling the affected feature, by
>  means of a successful :ref:`KVM_ARM_VCPU_INIT <KVM_ARM_VCPU_INIT>` call with the
>
> --
> 2.47.3
>

