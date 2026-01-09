Return-Path: <linux-kselftest+bounces-48616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89458D0B183
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 17:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91283300E146
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470F363C52;
	Fri,  9 Jan 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bc40ye1x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394EF31A06C
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974177; cv=pass; b=TMvk//SPtZUZjH0RxRPsuRd7SnJ5X0euNScIuMcpTI/nR3uIFXL8QKaQxeSF9MCWw696vs90e1EwcKb8wnHJs6PZCXiVmZGyHQN8GOy4FiXowJdoAGHb0+X5ku6RpbX+S/24z8qvXamwLugH6O4+x6k8Kvzz7n7Zz+JMGcKFFLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974177; c=relaxed/simple;
	bh=iK5AUYKKnG1GCt/80DpdeQQfwbtmqro71Xoh6GzOc/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoBl+xubNtZ0qf4OtyveZnWPdVgfCEr4Nx8XD+zYkAzt1b4TT/FmalvwIHw0fEdtLZyzRUpnDLuGRPAMl6M2EE1AYGPJxch3eHhUL5gketNBNkwfS7pQPRngEjRPSY0BXUe0iiX1Pn7dPUDy59DlQ6OZr2XCJoVz3fvkXKUAWYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bc40ye1x; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4edb8d6e98aso578251cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 07:56:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767974174; cv=none;
        d=google.com; s=arc-20240605;
        b=CC+BVwns+fAIiZRx+hhx5chziwH0UhwbmzOgjQDjMxvf+CtGeCCHCualjtmyd2vW5i
         56+LVnm/A/EPelf7IqMBNItIjCMhn3hgvKrL+VqEZTSVfYNTBEPehF2vJyDbKd4xYCpB
         aH60fJ29ILuZ2eGj0lDK1u6KhZM3iB2Fj41kziN2pLef8iGRkeriBNroq+BstFR72Fwb
         Ds0FT5P8EsN2E2v6kPLbVP6ERYp/WdSxzE6I1LgdkNZdMcO/fabrx7ps9C3OduXrbkv7
         QHeAuQX5nl7kQ7LCKi1FgEgZsmAnyHOEbmcPgPnCkIRXC7ecoFqs+X6X+Q0vbJltmmTh
         rL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U8I+9Z/SzReDIbFo3xnWDAd13nvsAbuR5scsRwJQ9D4=;
        fh=j2CZgRatIUSqZ6nOFR5nLJjEVG+sB8csaquEINcG/Mg=;
        b=RfbEJujEVE6fBBgZY1XzDb7yr22moTqoPP3RPxdRq3ATusA736tW63m88kfFS4dOoH
         XlhUeJXIild8AQIGAFRXwGVu/V9hlqb2fEGorITJXOZu5TNtxA71WJlZotMlPfiNl6MX
         Qgj8++H8o2aZgiDYcfXiwY8SsJLWdomcDuqAk2Ll1Mx4R6yZeMGQNI5PQ1Mpz6W9kQqM
         1oHksJADASQz1AbC13fx3CJi2VZv94HiaQDXeDP5pMCD0EP3zftDxIYRUiq+BkVEXsr9
         McidlaUPDahIUxYOzRvuu9mUEEtFnQIs/nTlRHBkdt2aVgMZB9TdlZzuE3N6AKSnjY3C
         ffag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767974174; x=1768578974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U8I+9Z/SzReDIbFo3xnWDAd13nvsAbuR5scsRwJQ9D4=;
        b=bc40ye1xcX2mE+ZkSnFA8u+EZ1OrY+ZQImu6xQ9OAG6AFN4lOG3lexGowS+tL9XfJz
         B690N/tCOz5nweQgH7lePbyGUMN4Iy14FXXqjfxdM2kj+wxWJKJedAtAqzVAfUXvqWLr
         dsSk6AZGJcEqbIS/6P8I5nGRo3J5uWYLxlCNINU7izUrD3y45aYx97DQJ5nNXfTf48/c
         rMxuoqVhOD8xd6+WYHiPZyt5EdIA6iUX0EzTbnL17LMCE1lHTR6GjIbm/86ImShWvjya
         qvOBUG6r9CVbcdus+VGbH0s8ZGRvqq2B0brYJZbyvMRnI6EGjo4Vp3mKk2G7eYpd3wte
         HkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767974174; x=1768578974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8I+9Z/SzReDIbFo3xnWDAd13nvsAbuR5scsRwJQ9D4=;
        b=MxDunSeYaqnsxSTfhzyali/TCPVvKFEvnAQHnTf9wX1NSpNe5tPHW2bL4/CnNr0X2l
         LAibgHcQtSU4OlP0z0HwdU1WDn7xsd8YbNrUlCqGBim3uxAn22WY/RFtSDtUnBr7eXQd
         BC0Rr9/J3Xz2wfuauGWxOy4r6aPsUNbx9SZzPMpJkznT4rvaa5fcIn/AStu411765eb3
         FUQzIfSzK6nS/ZXaE61lYkRZSxjuvmtRhS9Fh6Sli9wC2jgS5z7Kl8SFiIPUVvC8v7DV
         M0PMkyScAj0ezJ4rHbOqlQaNpV5BzJGCpXX8L1QhVWDd8LgGOr8gjJlCWSSdHw1+i0VI
         scAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUztmdoR97IspqPGeFJxcLriElCVjHPZKhKimqVtkfKetqDy+yJSdfA27TxYOid1HArt+fXmTqME+7p2YizMKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26kcXfXs6II2sE/GOt95OOUeXbor1Jnl4CBYZ6fh06XzPaBjn
	J8NR0RpHJ3ieJHcngDPWq+gb858dvEv+EuW9rLpm7cmoN6WGM+4DupuPa6pD9xDpCQKGamxq9fR
	DB7ENk2+98c+WZcKI9UHvnh+Hy0ibYLcm1ZhsOfp1
X-Gm-Gg: AY/fxX6+PWBDT/ctxDN6th0x/EKg0OXQnFykav6sLaR3SjpU8+sq6Tgim0/XfDofLIv
	wHtjiYbNGJBBQ/HOVNls3k7AbyHqvd19aRiuNCBwfaPrVp0anZb/fz9WvdxVDcVF9KVzxzW6305
	As7aSS4OIcMm3GvAkfcKV5EYYvjVEGLY7EaZnUuGuYFo5knOcF+oaUFIsi0zLo7D80jWBbOP4Do
	v/sMdXQtZAcMrtGpA9MIS5QRGWlgOA+9loR57aGQ/5WzNrvyr7/+tD/5VX9wvhq2uea79EH
X-Received: by 2002:a05:622a:206:b0:4ff:a96a:90fc with SMTP id
 d75a77b69052e-4ffca10c9e7mr11956941cf.0.1767974173794; Fri, 09 Jan 2026
 07:56:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-11-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-11-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 9 Jan 2026 15:55:36 +0000
X-Gm-Features: AZwV_Qjl7-V6jtqPJiWFE-pNSysqHN43mjzymjYZ55x2bRwN0FRgaHUdOP2UPAs
Message-ID: <CA+EHjTznZj94NFVQGG8Bi0=kkQUMYA0omdGS++83jwLj-CDRNQ@mail.gmail.com>
Subject: Re: [PATCH v9 11/30] KVM: arm64: Define internal features for SME
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

Hi Mark,

On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:
>
> In order to simplify interdependencies in the rest of the series define
> the feature detection for SME and it's subfeatures.  Due to the need for

nit: it's -> its

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad



> vector length configuration we define a flag for SME like for SVE.  We
> also have two subfeatures which add architectural state, FA64 and SME2,
> which are configured via the normal ID register scheme.
>
> Also provide helpers which check if the vCPU is in streaming mode or has
> ZA enabled.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>


> ---
>  arch/arm64/include/asm/kvm_host.h | 35 ++++++++++++++++++++++++++++++++++-
>  arch/arm64/kvm/sys_regs.c         |  2 +-
>  2 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0f3d26467bf0..0816180dc551 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -353,6 +353,8 @@ struct kvm_arch {
>  #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS             10
>         /* Unhandled SEAs are taken to userspace */
>  #define KVM_ARCH_FLAG_EXIT_SEA                         11
> +       /* SME exposed to guest */
> +#define KVM_ARCH_FLAG_GUEST_HAS_SME                    12
>         unsigned long flags;
>
>         /* VM-wide vCPU feature set */
> @@ -1062,7 +1064,16 @@ struct kvm_vcpu_arch {
>  #define vcpu_has_sve(vcpu)     kvm_has_sve((vcpu)->kvm)
>  #endif
>
> -#define vcpu_has_vec(vcpu) vcpu_has_sve(vcpu)
> +#define kvm_has_sme(kvm)       (system_supports_sme() &&               \
> +                                test_bit(KVM_ARCH_FLAG_GUEST_HAS_SME, &(kvm)->arch.flags))
> +
> +#ifdef __KVM_NVHE_HYPERVISOR__
> +#define vcpu_has_sme(vcpu)     kvm_has_sme(kern_hyp_va((vcpu)->kvm))
> +#else
> +#define vcpu_has_sme(vcpu)     kvm_has_sme((vcpu)->kvm)
> +#endif
> +
> +#define vcpu_has_vec(vcpu) (vcpu_has_sve(vcpu) || vcpu_has_sme(vcpu))
>
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  #define vcpu_has_ptrauth(vcpu)                                         \
> @@ -1602,6 +1613,28 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
>  #define kvm_has_sctlr2(k)                              \
>         (kvm_has_feat((k), ID_AA64MMFR3_EL1, SCTLRX, IMP))
>
> +#define kvm_has_fa64(k)                                        \
> +       (system_supports_fa64() &&                      \
> +        kvm_has_feat((k), ID_AA64SMFR0_EL1, FA64, IMP))
> +
> +#define kvm_has_sme2(k)                                        \
> +       (system_supports_sme2() &&                      \
> +        kvm_has_feat((k), ID_AA64PFR1_EL1, SME, SME2))
> +
> +#ifdef __KVM_NVHE_HYPERVISOR__
> +#define vcpu_has_sme2(vcpu)    kvm_has_sme2(kern_hyp_va((vcpu)->kvm))
> +#define vcpu_has_fa64(vcpu)    kvm_has_fa64(kern_hyp_va((vcpu)->kvm))
> +#else
> +#define vcpu_has_sme2(vcpu)    kvm_has_sme2((vcpu)->kvm)
> +#define vcpu_has_fa64(vcpu)    kvm_has_fa64((vcpu)->kvm)
> +#endif
> +
> +#define vcpu_in_streaming_mode(vcpu) \
> +       (__vcpu_sys_reg(vcpu, SVCR) & SVCR_SM_MASK)
> +
> +#define vcpu_za_enabled(vcpu) \
> +       (__vcpu_sys_reg(vcpu, SVCR) & SVCR_ZA_MASK)
> +
>  static inline bool kvm_arch_has_irq_bypass(void)
>  {
>         return true;
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index c8fd7c6a12a1..3576e69468db 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1945,7 +1945,7 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
>  static unsigned int sme_visibility(const struct kvm_vcpu *vcpu,
>                                    const struct sys_reg_desc *rd)
>  {
> -       if (kvm_has_feat(vcpu->kvm, ID_AA64PFR1_EL1, SME, IMP))
> +       if (vcpu_has_sme(vcpu))
>                 return 0;
>
>         return REG_HIDDEN;
>
> --
> 2.47.3
>

