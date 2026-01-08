Return-Path: <linux-kselftest+bounces-48515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB5D036EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED66532A6A84
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243644A8F74;
	Thu,  8 Jan 2026 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJehrLmG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F54963C1
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881427; cv=pass; b=nQMebocGK1Uu8GgG/A2dWaDpnJbl24LRGWikpqkjw1QZyuXjYMTbWg33TKfB/iGwZfAHvONXyZFGcVQyTx7mVRLcUq4qmp2939KggokhvLtJGaSCwr4D49HE1BO1q1IZdjvK9Ai0uWM4Imcp5p3CAgFpOwzBIijjuVqa8DLN9X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881427; c=relaxed/simple;
	bh=fqIKEGVdrdDwWR5GKD0/DnIsXWNq4kTzHRbVfGW+jJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jW+flRfwXaibhzLu8beBNWj0xLQzGBJhGXI5/KNF+tIq0TSvdGyOdD0Mi/rud0XTYEMP9Bq2AqZSO6HNIqNskzhGsjwJii6AyhJSXoY0b7CwJ+psc9IHJ+BrYWoa4LFjYwS+b23rCFxo5XDar3KRPfvc2IbJmrCIz065iH+Ck2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJehrLmG; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee147baf7bso973321cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 06:10:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767881423; cv=none;
        d=google.com; s=arc-20240605;
        b=do9ZBeP25ZQ1f1ewp5NNjTu5RFkpUNNHiOPA4XUDBJn2wgB6bXUCet5FQo+85iwCJ5
         ngOrdxChzqtaEApOat0NE50hq9laD8nhielCjoNbjV0X9UTC2XV0xYKPRImafx0AyJ+R
         tw/Q0GMImvaQIX04YP+Hzjsk33mAl61tNRUY0l/MmjcygZidU/lOjOy4T2w/IRkGgbfq
         TWyeRP9on5vGs9FN1fqhesce4X2J9FdhrEUDWZuQGkDYaDwY45iRq3nUmMFAT31cXPpZ
         +XUqcKXPeruD11CiPfTy/fkjpNll1kN2rrKkz1YcxZo3z38JEBxU/NAN0L9Vc37eOKJu
         IX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NaZEGS72KLSqcxT/8N5H1mx02StcfqZHeuPXe2e7POg=;
        fh=+Y6XPA2e2Pm8I5YEgSKxHQdihvu1B1RY6+cUL53w5qM=;
        b=FvkyErWils6WEPtvdz74YJXEsl3w2BzkTfkJKmVHRpJ4j1fNzl3yssGi/4LBQoRsfS
         apQYl6aQfOFhZfZaTxUvt9XX3PvfNuOoIz/nyexxSkdcQf+9x9Mlj7rdfssLB40sGXcA
         /fuKAd143tmc4hFXkz+xeb8dWuwaGxX/fIceA3J0URzfh6PPI3+DJhL9XvbQTUb4lmh7
         u7HaPbSA5RsHgWx+OTd/IWuUB3KNboSlbhYmereeYeTBTYWB9pcEpkOVWYXIUDCbdnbb
         07wYPl8j1r0fZ9lcEPsC3Nr2/IdZ+AYS3QwinvgIveTU3tWxEI0MLC6weLvCpFLsqvkL
         MsBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767881423; x=1768486223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NaZEGS72KLSqcxT/8N5H1mx02StcfqZHeuPXe2e7POg=;
        b=EJehrLmGVBdJ8xjO7wCBNPGGHCIDyqSfyF0nUdUeicZOzj4iIUUhfxqYt7RqrNWc1P
         UPLloSiW1ZSpb/O4ugOsDWC+0FllVmFUSxHZNHmcKEgYPLwoGQdUYHaydqyWHPDVTP9l
         J6Uu/D8sxBVp6JFHCq7ETy4GJ2xYEbaR39pF501c34iTfE3oSF1fYho3W1C6q0ZQGQga
         j5mioPq1wxSs+taAMifaYy6tSHT5quBNSpWE9fNw59LkysIwR1z0YCkzg0vPGrYusTTS
         CuzmgcE5OGX8Z6Vig5a8ovbiDJmjwTy0x3pxX3MHCdomtcME8TRLeYwfF2W9AWkNk1sD
         /Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881423; x=1768486223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaZEGS72KLSqcxT/8N5H1mx02StcfqZHeuPXe2e7POg=;
        b=VbROPthIV4T+6E0ytJ7JjivN+oxeV8RNEPBUU/mPR46H3Bxz0dGldzGw4tlkEP+wJH
         sd5mTUCh5rmSQBH69IeNnwnxGIMOjho0OaHQIadJzAqyMk4/xe4kuXS8CiMUma1IP03F
         MCjvS1Rj9gaIoeTri0Zha+7brPWEL/uu7p9Z9qV1yqXT3UGh8m6yPNzI2KokO7Bz/P2O
         LRtOCNG1XbZjAUp8LcR7XCwdOD09ZfvlAMf7YDiokY77cBACyjTTcsnyqMaXAvWTRmQQ
         I24lZ+1zRX4Y9YTTdNaUt0HXokAdT+OE7L+33Vc9OAW3diTpMbjS2rwmYY3MVAf+blvu
         pKow==
X-Forwarded-Encrypted: i=1; AJvYcCUpFH7+Is4gOEGUB8qzGwEaADYC8ogBDugfLfY0UfOk4YS2rMzvIMXUnrWrLjBpQQccrWE1WOlvmH5fK6iMtmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe6s0Szr6KPpc3kNUy4ifc91HY3IGfwVAle3t2hNCDCSRBLQuz
	mXafo8vvWznKHFT1JHQzAP8XNPdVi+HR4C1CQvcurjrFov87ufYNdn19MkHlrF8Q5IK1mWGtRZ9
	EnhM3/K6Mkxz76hndWBl54nEFUdN+qSapRc/tbh9m
X-Gm-Gg: AY/fxX73J2jztFzv5Pfj2FCnp+ksl3+pvk2VUfStiMThRatLsioELyK3d9JAULMrWg2
	SKHcVoThBJyb1OHlx/J1heHmO1PqCxSWSX8dU5QyLbXvuR1vunjZKs1jcgacLmkruWayhumLmkj
	MSIwtAenFA+TXBJhmUKyCml0RNSiBS7hLIzYs/ePIUT9MvV004jugz6pXTZhDMNEQJOmEzlIXCT
	+CAkgyKcQokltJEp4ZznyVdsfFHCpwKgCgUxTntj2rNg7fclrAG9+Tht2zEKDi/YqTDjYaw
X-Received: by 2002:ac8:574f:0:b0:4f1:9c6e:cf1c with SMTP id
 d75a77b69052e-4ffc0997e9emr8640981cf.17.1767881422911; Thu, 08 Jan 2026
 06:10:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-7-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-7-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 8 Jan 2026 14:09:46 +0000
X-Gm-Features: AQt7F2pJrrFIu8j-RnjtZsOw-SyaBAdPJA09Q8QxhF8SmvfGBU7bWTwW9oJJhUU
Message-ID: <CA+EHjTzTjaZoGQzivOSd97Z9VzySOAM=Qvye0p-R5rzUDwrSFw@mail.gmail.com>
Subject: Re: [PATCH v9 07/30] KVM: arm64: Pull ctxt_has_ helpers to start of sysreg-sr.h
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
> Rather than add earlier prototypes of specific ctxt_has_ helpers let's just
> pull all their definitions to the top of sysreg-sr.h so they're all
> available to all the individual save/restore functions.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 84 +++++++++++++++---------------
>  1 file changed, 41 insertions(+), 43 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index a17cbe7582de..5624fd705ae3 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -16,8 +16,6 @@
>  #include <asm/kvm_hyp.h>
>  #include <asm/kvm_mmu.h>
>
> -static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt);
> -
>  static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
>  {
>         struct kvm_vcpu *vcpu = ctxt->__hyp_running_vcpu;
> @@ -28,47 +26,6 @@ static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
>         return vcpu;
>  }
>
> -static inline bool ctxt_is_guest(struct kvm_cpu_context *ctxt)
> -{
> -       return host_data_ptr(host_ctxt) != ctxt;
> -}
> -
> -static inline u64 *ctxt_mdscr_el1(struct kvm_cpu_context *ctxt)
> -{
> -       struct kvm_vcpu *vcpu = ctxt_to_vcpu(ctxt);
> -
> -       if (ctxt_is_guest(ctxt) && kvm_host_owns_debug_regs(vcpu))
> -               return &vcpu->arch.external_mdscr_el1;
> -
> -       return &ctxt_sys_reg(ctxt, MDSCR_EL1);
> -}
> -
> -static inline u64 ctxt_midr_el1(struct kvm_cpu_context *ctxt)
> -{
> -       struct kvm *kvm = kern_hyp_va(ctxt_to_vcpu(ctxt)->kvm);
> -
> -       if (!(ctxt_is_guest(ctxt) &&
> -             test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &kvm->arch.flags)))
> -               return read_cpuid_id();
> -
> -       return kvm_read_vm_id_reg(kvm, SYS_MIDR_EL1);
> -}
> -
> -static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
> -{
> -       *ctxt_mdscr_el1(ctxt)   = read_sysreg(mdscr_el1);
> -
> -       // POR_EL0 can affect uaccess, so must be saved/restored early.
> -       if (ctxt_has_s1poe(ctxt))
> -               ctxt_sys_reg(ctxt, POR_EL0)     = read_sysreg_s(SYS_POR_EL0);
> -}
> -
> -static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
> -{
> -       ctxt_sys_reg(ctxt, TPIDR_EL0)   = read_sysreg(tpidr_el0);
> -       ctxt_sys_reg(ctxt, TPIDRRO_EL0) = read_sysreg(tpidrro_el0);
> -}
> -
>  static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
>  {
>         struct kvm_vcpu *vcpu = ctxt_to_vcpu(ctxt);
> @@ -131,6 +88,47 @@ static inline bool ctxt_has_sctlr2(struct kvm_cpu_context *ctxt)
>         return kvm_has_sctlr2(kern_hyp_va(vcpu->kvm));
>  }
>
> +static inline bool ctxt_is_guest(struct kvm_cpu_context *ctxt)
> +{
> +       return host_data_ptr(host_ctxt) != ctxt;
> +}
> +
> +static inline u64 *ctxt_mdscr_el1(struct kvm_cpu_context *ctxt)
> +{
> +       struct kvm_vcpu *vcpu = ctxt_to_vcpu(ctxt);
> +
> +       if (ctxt_is_guest(ctxt) && kvm_host_owns_debug_regs(vcpu))
> +               return &vcpu->arch.external_mdscr_el1;
> +
> +       return &ctxt_sys_reg(ctxt, MDSCR_EL1);
> +}
> +
> +static inline u64 ctxt_midr_el1(struct kvm_cpu_context *ctxt)
> +{
> +       struct kvm *kvm = kern_hyp_va(ctxt_to_vcpu(ctxt)->kvm);
> +
> +       if (!(ctxt_is_guest(ctxt) &&
> +             test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &kvm->arch.flags)))
> +               return read_cpuid_id();
> +
> +       return kvm_read_vm_id_reg(kvm, SYS_MIDR_EL1);
> +}
> +
> +static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
> +{
> +       *ctxt_mdscr_el1(ctxt)   = read_sysreg(mdscr_el1);
> +
> +       // POR_EL0 can affect uaccess, so must be saved/restored early.
> +       if (ctxt_has_s1poe(ctxt))
> +               ctxt_sys_reg(ctxt, POR_EL0)     = read_sysreg_s(SYS_POR_EL0);
> +}
> +
> +static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
> +{
> +       ctxt_sys_reg(ctxt, TPIDR_EL0)   = read_sysreg(tpidr_el0);
> +       ctxt_sys_reg(ctxt, TPIDRRO_EL0) = read_sysreg(tpidrro_el0);
> +}
> +
>  static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
>  {
>         ctxt_sys_reg(ctxt, SCTLR_EL1)   = read_sysreg_el1(SYS_SCTLR);
>
> --
> 2.47.3
>

