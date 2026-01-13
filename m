Return-Path: <linux-kselftest+bounces-48864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B3CD197AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40AD7306707D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C5E283FEF;
	Tue, 13 Jan 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+wyn6gB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603C2BE644
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314612; cv=pass; b=LkCPvotNVKINIUcrYB3005VAPSa1E73QdMMW7gDLtHvCgyHyLIl8M1ft16hKe6Hm6+ds9UnHcPDC1Iy7DJ3k/hWWRb1urDWhPEBzK15T9jlZjCD6d6+CJEXPwuNgVBACs6wXt/j8FecjEnRhYTs4tgxbDFVmo+FaHTxrOiH+fi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314612; c=relaxed/simple;
	bh=G5FodbqLvXK9tpyH66xlaj/l47vKj19iBm8mD+95DeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9JVhmEp1qOijH/05+lofXDyAr6tL+kmAzigRWMw5kOxwGN/KjMtk4SHhu037M1fd5yKRtaLxNgPCDODURuSkLqXzpcvfL6A34zZZc0RQtDxueNJDo6SrNPAXdmQHQ/kNffmQ2n8nwWXm6lQ3JVbsaT5l1uRYhvFNK7h8PQhcR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+wyn6gB; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4edb8d6e98aso424951cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 06:30:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768314607; cv=none;
        d=google.com; s=arc-20240605;
        b=eoRcP/dwuHzjo9MepTbeWIKz/Dy840o/aeQawPUErcA8ZRgWaD/EyJymKE8WSlMlQc
         N3bF8D6E2aGpEkt7z0J1qN4TnjoqLE2PH//LO4SeKl1jIDxOpGSNvQsB3hS69LDcskGK
         kU1jTLDs3+h/ys5xkxKY8TZ126z0DQYKfi40OCDkwGEz8VGfCWEtcrGLVdIFDiMi+Mpy
         PQDN2cGUzbewghTv6P3H7nzZ1jWteUeMksxj53Nxu4eJc/R81zgIuy29QoLpM5G8OYOS
         gT0dqvN8lji0IelFx51VO9mWtkEqcyXYV5A5Q0Ww/LqHsz1+u1uRC8rJ3S3ipWpzQ/7A
         ROrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b091E81/2unB3PJIE3JLMImmryguifLfk5JsrT4l5/A=;
        fh=umZhgExoLnwbPhXcncydQiOpqVo2OBu9ktI8QhCnTdE=;
        b=DCijIpDLQl80cDRCorLLHYCrkX9k/tOwmQ0vSZFA7qi9kkWdJVBIGJWy1dvhDS4Owx
         M/s6iOjDPSUwwod02fHMD7KF2k1YJNYVZaAmTZFXXTuRv5OQAoieKcRWfEEvnrhBzt+3
         C2ydu3oJB/HE2g8PrSkuoznekBWRmkvNMDl1wPpHxkoEEBtlN03LXgCs2S/+ZosurRJZ
         5GVU20GVkWtPLzMeKDjn1rHoRrcYoiCzZKlPsh2/KhPSR8f52f8AqWQidnxtJxNLt5To
         dEtN08DJ20YNFyi/5WkWnZ6DcgsxuuWQeqm9L549amKm4uJs/s4HSxHrf505ITp4TUEe
         41xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768314607; x=1768919407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b091E81/2unB3PJIE3JLMImmryguifLfk5JsrT4l5/A=;
        b=B+wyn6gBeRVxtZ/U6WcHc9YOm2TCL+0bcnT/ZIa0YIUM6Ce/cG4R0gIuofmBsVwzfq
         mjKU5Vk3WK7lFJlUQ6pJJATqiXTeienDpdkviDulL25OjuyFu9WhpJw/ynaE11ekXc1y
         oYefzbYHfpwoP82mOQ/pmDHtwqZ8CgRmYeQeSUOimfOWQ+iV21cHE9iSXmckvv6Hf5Y0
         l23XQ+uQidUY3cfGHQGe68NE2QFAuT5GQXxrrmKMig5gTJeoivKRSkaYMyIJDbEvR8Cd
         gtC+2Qt2PoaJjwDY/oq0n+lgC/BlsEc+WfHq82GYlo+FPRXNSNdR/EaIIpBklTmeBiUR
         DSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314607; x=1768919407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b091E81/2unB3PJIE3JLMImmryguifLfk5JsrT4l5/A=;
        b=jbJc6Kwe2si6+atiR1KBy33vh9IAJx8K4YEiliZyxesdFm6UmVpgTXR0ChnEZsEgZ+
         l0zRpD5AKZgiUnQGKFr5go25bmHpEP5TNZT1rqLPl+TrjpwWu6XoytjCG6cMs3byYJZ7
         QfvJ4V+AzqXSQ6ay3k1JJovy8Q4Gy7op6/ZfedmlBAMPosCv2vysyRjBsg6dVIfRspK3
         u20CpLfbWFoqTq4KkexNpm4q5U+QKg4jyUYzKldN2QzFBApUY/GQeHE0vYCTlHl3oO1P
         2cnCIuHpnNKdOesleTtBOaxNy9WFmLZSAMJAK4YEq1GX5uLRtV55JC7LUIcO5VWL6iuJ
         pvZg==
X-Forwarded-Encrypted: i=1; AJvYcCWDbmY6GC2CF1pUbqGhHfABbiIbIrQScouwhHWlieIauZKFSsxy2lwdywVHmCo6tapZnmlOECzJH63IqWo5SUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbw4FApX+q/at4GXEtXn+tkbktUqSRsQGFyLP3dxni2pKg2lbC
	v2E5MeGiyPZu72rlQ3EMBQdUCEXYNEUmGRCWP+KbEpBQFo/eJ7evmrkFbj6MeCllTfqwAPIlMPF
	FOQnpehsNB0tdgqfpW3PCjyl0vNBUJUbqMynVEP7T
X-Gm-Gg: AY/fxX7RZ1dqAEScDHmhWxmWcaLzdXjpwY0g+31NR2+TXzN3qr6Yhr5Rpqz5YU3ulsh
	hUuolUNET2njsg14BvJzoLvaB9afE0NR3a4rL0J3FtilVxPkZ/lG3LPOzF0N49zn97WFP4vq118
	pI0WUe5/P70cQoEVFLlnc9HmrIL0CqFP5D7c14unizdNJ2ySimWGd9Hju7BwLd6uTVRRJrzLDlm
	uyL9/JqgIqLnb8ULNQ3WBQlQ1mp2b4o5BmSUDcN7vPr2r5gduEpEMVAv4+WQPKz1GNv42IRmC0r
	RmihDWx946+BOdeI4IR+7dj5ow==
X-Received: by 2002:ac8:5ad4:0:b0:4f1:83e4:73be with SMTP id
 d75a77b69052e-5013b23e77amr10218591cf.15.1768314606872; Tue, 13 Jan 2026
 06:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-24-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-24-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 13 Jan 2026 14:29:30 +0000
X-Gm-Features: AZwV_Qi1BQ7vCKiwPSasBf7ZnHIRAUGyzNDOshXruUEpESYhIak7mxGtl8xsYqo
Message-ID: <CA+EHjTyL5gFQ8osKHaXQHa6327-HBJ4wvn6G2isDY3og4tCBKw@mail.gmail.com>
Subject: Re: [PATCH v9 24/30] KVM: arm64: Handle SME exceptions
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

On Tue, 23 Dec 2025 at 01:23, Mark Brown <broonie@kernel.org> wrote:
>
> The access control for SME follows the same structure as for the base FP
> and SVE extensions, with control being via CPACR_ELx.SMEN and CPTR_EL2.TSM
> mirroring the equivalent FPSIMD and SVE controls in those registers. Add
> handling for these controls and exceptions mirroring the existing handling
> for FPSIMD and SVE.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad



> ---
>  arch/arm64/kvm/handle_exit.c            | 14 ++++++++++++++
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 11 ++++++-----
>  arch/arm64/kvm/hyp/nvhe/switch.c        |  4 +++-
>  arch/arm64/kvm/hyp/vhe/switch.c         | 17 ++++++++++++-----
>  4 files changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index cc7d5d1709cb..1e54d5d722e4 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -237,6 +237,19 @@ static int handle_sve(struct kvm_vcpu *vcpu)
>         return 1;
>  }
>
> +/*
> + * Guest access to SME registers should be routed to this handler only
> + * when the system doesn't support SME.
> + */
> +static int handle_sme(struct kvm_vcpu *vcpu)
> +{
> +       if (guest_hyp_sme_traps_enabled(vcpu))
> +               return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_esr(vcpu));
> +
> +       kvm_inject_undefined(vcpu);
> +       return 1;
> +}
> +
>  /*
>   * Two possibilities to handle a trapping ptrauth instruction:
>   *
> @@ -390,6 +403,7 @@ static exit_handle_fn arm_exit_handlers[] = {
>         [ESR_ELx_EC_SVC64]      = handle_svc,
>         [ESR_ELx_EC_SYS64]      = kvm_handle_sys_reg,
>         [ESR_ELx_EC_SVE]        = handle_sve,
> +       [ESR_ELx_EC_SME]        = handle_sme,
>         [ESR_ELx_EC_ERET]       = kvm_handle_eret,
>         [ESR_ELx_EC_IABT_LOW]   = kvm_handle_guest_abort,
>         [ESR_ELx_EC_DABT_LOW]   = kvm_handle_guest_abort,
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index 5bcc72ae48ff..ad88cc7bd5d3 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -69,11 +69,8 @@ static inline void __activate_cptr_traps_nvhe(struct kvm_vcpu *vcpu)
>  {
>         u64 val = CPTR_NVHE_EL2_RES1 | CPTR_EL2_TAM | CPTR_EL2_TTA;
>
> -       /*
> -        * Always trap SME since it's not supported in KVM.
> -        * TSM is RES1 if SME isn't implemented.
> -        */
> -       val |= CPTR_EL2_TSM;
> +       if (!vcpu_has_sme(vcpu) || !guest_owns_fp_regs())
> +               val |= CPTR_EL2_TSM;
>
>         if (!vcpu_has_sve(vcpu) || !guest_owns_fp_regs())
>                 val |= CPTR_EL2_TZ;
> @@ -101,6 +98,8 @@ static inline void __activate_cptr_traps_vhe(struct kvm_vcpu *vcpu)
>                 val |= CPACR_EL1_FPEN;
>                 if (vcpu_has_sve(vcpu))
>                         val |= CPACR_EL1_ZEN;
> +               if (vcpu_has_sme(vcpu))
> +                       val |= CPACR_EL1_SMEN;
>         }
>
>         if (!vcpu_has_nv(vcpu))
> @@ -142,6 +141,8 @@ static inline void __activate_cptr_traps_vhe(struct kvm_vcpu *vcpu)
>                 val &= ~CPACR_EL1_FPEN;
>         if (!(SYS_FIELD_GET(CPACR_EL1, ZEN, cptr) & BIT(0)))
>                 val &= ~CPACR_EL1_ZEN;
> +       if (!(SYS_FIELD_GET(CPACR_EL1, SMEN, cptr) & BIT(0)))
> +               val &= ~CPACR_EL1_SMEN;
>
>         if (kvm_has_feat(vcpu->kvm, ID_AA64MMFR3_EL1, S2POE, IMP))
>                 val |= cptr & CPACR_EL1_E0POE;
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index d3b9ec8a7c28..b2cba7c92b0f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -181,6 +181,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
>         [ESR_ELx_EC_CP15_32]            = kvm_hyp_handle_cp15_32,
>         [ESR_ELx_EC_SYS64]              = kvm_hyp_handle_sysreg,
>         [ESR_ELx_EC_SVE]                = kvm_hyp_handle_fpsimd,
> +       [ESR_ELx_EC_SME]                = kvm_hyp_handle_fpsimd,
>         [ESR_ELx_EC_FP_ASIMD]           = kvm_hyp_handle_fpsimd,
>         [ESR_ELx_EC_IABT_LOW]           = kvm_hyp_handle_iabt_low,
>         [ESR_ELx_EC_DABT_LOW]           = kvm_hyp_handle_dabt_low,
> @@ -192,7 +193,8 @@ static const exit_handler_fn pvm_exit_handlers[] = {
>         [0 ... ESR_ELx_EC_MAX]          = NULL,
>         [ESR_ELx_EC_SYS64]              = kvm_handle_pvm_sys64,
>         [ESR_ELx_EC_SVE]                = kvm_handle_pvm_restricted,
> -       [ESR_ELx_EC_FP_ASIMD]           = kvm_hyp_handle_fpsimd,
> +       [ESR_ELx_EC_SME]                = kvm_handle_pvm_restricted,
> +       [ESR_ELx_EC_FP_ASIMD]           = kvm_handle_pvm_restricted,
>         [ESR_ELx_EC_IABT_LOW]           = kvm_hyp_handle_iabt_low,
>         [ESR_ELx_EC_DABT_LOW]           = kvm_hyp_handle_dabt_low,
>         [ESR_ELx_EC_WATCHPT_LOW]        = kvm_hyp_handle_watchpt_low,
> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
> index 9984c492305a..8449004bc24e 100644
> --- a/arch/arm64/kvm/hyp/vhe/switch.c
> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
> @@ -458,22 +458,28 @@ static bool kvm_hyp_handle_cpacr_el1(struct kvm_vcpu *vcpu, u64 *exit_code)
>         return true;
>  }
>
> -static bool kvm_hyp_handle_zcr_el2(struct kvm_vcpu *vcpu, u64 *exit_code)
> +static bool kvm_hyp_handle_vec_cr_el2(struct kvm_vcpu *vcpu, u64 *exit_code)
>  {
>         u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
>
>         if (!vcpu_has_nv(vcpu))
>                 return false;
>
> -       if (sysreg != SYS_ZCR_EL2)
> +       switch (sysreg) {
> +       case SYS_ZCR_EL2:
> +       case SYS_SMCR_EL2:
> +               break;
> +       default:
>                 return false;
> +       }
>
>         if (guest_owns_fp_regs())
>                 return false;
>
>         /*
> -        * ZCR_EL2 traps are handled in the slow path, with the expectation
> -        * that the guest's FP context has already been loaded onto the CPU.
> +        * ZCR_EL2 and SMCR_EL2 traps are handled in the slow path,
> +        * with the expectation that the guest's FP context has
> +        * already been loaded onto the CPU.
>          *
>          * Load the guest's FP context and unconditionally forward to the
>          * slow path for handling (i.e. return false).
> @@ -493,7 +499,7 @@ static bool kvm_hyp_handle_sysreg_vhe(struct kvm_vcpu *vcpu, u64 *exit_code)
>         if (kvm_hyp_handle_cpacr_el1(vcpu, exit_code))
>                 return true;
>
> -       if (kvm_hyp_handle_zcr_el2(vcpu, exit_code))
> +       if (kvm_hyp_handle_vec_cr_el2(vcpu, exit_code))
>                 return true;
>
>         return kvm_hyp_handle_sysreg(vcpu, exit_code);
> @@ -522,6 +528,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
>         [0 ... ESR_ELx_EC_MAX]          = NULL,
>         [ESR_ELx_EC_CP15_32]            = kvm_hyp_handle_cp15_32,
>         [ESR_ELx_EC_SYS64]              = kvm_hyp_handle_sysreg_vhe,
> +       [ESR_ELx_EC_SME]                = kvm_hyp_handle_fpsimd,
>         [ESR_ELx_EC_SVE]                = kvm_hyp_handle_fpsimd,
>         [ESR_ELx_EC_FP_ASIMD]           = kvm_hyp_handle_fpsimd,
>         [ESR_ELx_EC_IABT_LOW]           = kvm_hyp_handle_iabt_low,
>
> --
> 2.47.3
>

