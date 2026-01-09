Return-Path: <linux-kselftest+bounces-48629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40063D0BC84
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58049301177E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D64A366554;
	Fri,  9 Jan 2026 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IORnjLMh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA17364EB0
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981763; cv=pass; b=fDUSfuZx4nJS4SBGBko1cScyaATn8oo/XC/soz0t+aB6tsEuhwTOsKXuoutPdB5lNp1UZHHuvSMzzd7RWeRx+0jfyDxVlyvpcoycLKB+CpspNiO4UzeDi/wWtcEoJCduGRYEaIXQOpSKt92v4hqXlTNyF01y/m6RfuEatOaOQiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981763; c=relaxed/simple;
	bh=waz35Dit5obwJm4+6Pqr6z8GYP9jwuqNcLuFmQkHyWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku0xsWQVjQMqqk0v93mCQSmDlszOUSPACv0SK43bOIx0rDx1phAxiBxFQ1d+lHUA/Lv2RyT4wqVB7+D8Jbto3Veh/bAqus/zrQGXYqwtF7LDMZCTBuTa6pHzCbnTlifMi4Cv9eM1nFzhARy95yLBpr0Z9ji/wdibG1fdw2YpNdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IORnjLMh; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ffbaaafac4so43881cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 10:02:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767981760; cv=none;
        d=google.com; s=arc-20240605;
        b=TpG/nGPuFHOSO1FD126EE1yLyqOI5eAYAFEJ1DOmflb9EWo8S3uQ+kh3pJHi/Eicql
         Q/sV+g5/VWaTjvhDoaWBDfPkJYONdAtQS0o1a6msKFQll2BkEwCNeVntYhKKwfmLScNz
         +wG/mEi47NvtBQfE5MbxVn4pXMmt9FDZxJIAqfORDZ8pCjVJdUlgBtAhC7tRjvlmaIwU
         GbzmCCV+e+hkTROXaooAgApbjeHaUe/REE+fphRJylItmS2DZ0CCF7oBf+YLQbO2Bt77
         QIycfzpft3yY4TOdhen3TPZjUDftGkESaf4z33Y6LmV16ePwmaOrX3LEMgsWZxrXbed8
         0W8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fus9hklj3G1seHxQuK5bfg4xK6ZEq5azhzXVMqskmqY=;
        fh=/sTapi6Y670gLicJYzn4ikuFfY2dH8iH1kP9OHRfzPA=;
        b=dal1XLt9MakJZo1dw6XXcoyckpm2sUG04aOeTeiHaRurzWjX9uH5jD7KQQ8wPKT+/X
         2ERiyh0+wvvoWxb1PUgAlEfr9IhipbjXGtmx1JqI2u1BAEKPVEk6Jwk6Jzat7e5xOf6J
         o+BIkjEBINeCOO0f/uKXc84XrKAhnnFVoHxTbaGRQrD55dj60XBanqnrsdtdV1nW0tx/
         Pqhop+2xDiZU9tBs1proNQgOHFhlAQd9H0AMmoripxRnfpao1euDlSNblJC3sSy4sXiM
         +j2zyoyA4KI1PKKDEHIvpn2H828lI4v6NW8OMOCh6N/Xzlc0ITykLFB4WqRid3qCNc30
         K1IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767981760; x=1768586560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fus9hklj3G1seHxQuK5bfg4xK6ZEq5azhzXVMqskmqY=;
        b=IORnjLMhtaJmiOBDS1amkQXaiXt4Q6CXxOe9U72f8Vwy4ue1GRAX8CbfOqkFgzi3kT
         JDuVxuVwR3jgM2DtjE8XPxNDMVZMGoGvpV/e2sAeZFRO31AMwZz12ntHrn3XbZtLfjEP
         /ng0hIrK1G4iVyRJR02oCmYvkRfR2Ypkkg2Nf9Uy1lsHS+9ANqgiUPlngkbkpas36YBw
         bW+zNd4lJbBQ5LHWUGnbBpf7oZaj4xtIQBx6pkL2qxJjBf9NKzFn9tuyD1Kq2GS5/C0D
         XlBUT5kSVTzSlb852cEbeOu2C6JtKy+U/1tBa//MiJteOcV4Vppu842fh+FrvM6TeaNM
         hMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767981760; x=1768586560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fus9hklj3G1seHxQuK5bfg4xK6ZEq5azhzXVMqskmqY=;
        b=AYmcZvxKoDk2JDju3ARefDoylrycnFIfclE0lk+nKYf2TPTUJHF1tXfJB6Vi7Uk9Uy
         ukzOfQGR2jXUM8NF/yq6aqK72ZvCEexnlJ6aiNyu+WQl2VlE1c2GW5FFy6ITqz/uHFFa
         pZeSo/XX1hGJb77AMBI29zwd6trsLAFLRUOyjMcIShWszOWjsf6KqcovUu0HmazEwPzc
         i4RDhsmC786VYx8RBdTOsd01buGfojBc+fsefMK2oD4IHOGQPUH/DlXHNvoI4zy7QItU
         rq1rAc/HpIGyameEF627xncj1B8WCwZshkZfqttmX0xuRwdxpVigFAkxsK3K3IIMYkJ7
         DjSw==
X-Forwarded-Encrypted: i=1; AJvYcCVjK/Y6i6ZejmulUiSx5pdROjrWM6LXUcfCvKcKpz76J1h8Y1HkV+LnfRlrrV606QM1pk/49aj7oWOh3zmUUvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyAcP9PMDsHfhcidc+NsLeUq4/Qu1nypj9WaMX2B67B7SNX/Q
	tzKNax4JxNj5JvdQPWbFuGorciwHyadxDXj9sxnTE3NwuOoApeplGOl1fG4+4FKRuKA4Rdsxnnv
	92pgVAv9owjPWFcwuhoHY13UQSoYJ8/Ic2e8QfMJq
X-Gm-Gg: AY/fxX4r1u0w4coswxI8Tsi+uu98BDUp1RgZV//urYAMyLLH800/8eec1g1pZSA7VWt
	BKqnnatjSYSrsNUnpY1zc7+P8v2MAcIJU+3/zFIEY5hzsH7/vNhQ6xvYI0zoPjbFjwU+NrenXUV
	UkFXw3Uj7TmG/j6JzRh6bJ+MKzmJbx7QJFLVzzAfLW6wS4gNhncCzrOWNnEcClytI9B362YbNZb
	WbKO98bFNQlwjOugZu9lK14Wp/tEHlGoqvG8DqDZ5kbtUfBLgtjFzloGBMjrFhgn0Gpwxpd
X-Received: by 2002:a05:622a:1187:b0:4e5:8707:d31 with SMTP id
 d75a77b69052e-5011856b0f5mr522651cf.7.1767981759778; Fri, 09 Jan 2026
 10:02:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-17-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-17-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 9 Jan 2026 18:01:00 +0000
X-Gm-Features: AZwV_QiYol_KQciMdPiGzXkA1B5EfVQnDlekgBd_EKl4LUMtbj0GKBGclxvm6Ig
Message-ID: <CA+EHjTxaL7YwztugxyhS--948WUQ5BkME-P1cmrHvvJqEGEEBA@mail.gmail.com>
Subject: Re: [PATCH v9 17/30] KVM: arm64: Support SME identification registers
 for guests
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

.



On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:
>
> The primary register for identifying SME is ID_AA64PFR1_EL1.SME.  This
> is hidden from guests unless SME is enabled by the VMM.
> When it is visible it is writable and can be used to control the
> availability of SME2.
>
> There is also a new register ID_AA64SMFR0_EL1 which we make writable,
> forcing it to all bits 0 if SME is disabled.  This includes the field
> SMEver giving the SME version, userspace is responsible for ensuring
> the value is consistent with ID_AA64PFR1_EL1.SME.  It also includes
> FA64, a separately enableable extension which provides the full FPSIMD
> and SVE instruction set including FFR in streaming mode.  Userspace can
> control the availability of FA64 by writing to this field.  The other
> features enumerated there only add new instructions, there are no
> architectural controls for these.
>
> There is a further identification register SMIDR_EL1 which provides a
> basic description of the SME microarchitecture, in a manner similar to
> MIDR_EL1 for the PE.  It also describes support for priority management
> and a basic affinity description for shared SME units, plus some RES0
> space.  We do not support priority management for guests so this is
> hidden from guests, along with any new fields.
>
> As for MIDR_EL1 and REVIDR_EL1 we expose the implementer and revision
> information to guests with the raw value from the CPU we are running on,
> this may present issues for asymmetric systems or for migration as it
> does for the existing registers.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h          |  3 +++
>  arch/arm64/kvm/config.c                    |  8 +-----
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 11 ++++++++
>  arch/arm64/kvm/hyp/nvhe/pkvm.c             |  4 ++-
>  arch/arm64/kvm/sys_regs.c                  | 40 +++++++++++++++++++++++++++---
>  5 files changed, 54 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 825b74f752d6..fead6988f47c 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -400,6 +400,7 @@ struct kvm_arch {
>         u64 revidr_el1;
>         u64 aidr_el1;
>         u64 ctr_el0;
> +       u64 smidr_el1;
>
>         /* Masks for VNCR-backed and general EL2 sysregs */
>         struct kvm_sysreg_masks *sysreg_masks;
> @@ -1543,6 +1544,8 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
>                 return &ka->revidr_el1;
>         case SYS_AIDR_EL1:
>                 return &ka->aidr_el1;
> +       case SYS_SMIDR_EL1:
> +               return &ka->smidr_el1;
>         default:
>                 WARN_ON_ONCE(1);
>                 return NULL;
> diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
> index 24bb3f36e9d5..7e26991b2df1 100644
> --- a/arch/arm64/kvm/config.c
> +++ b/arch/arm64/kvm/config.c
> @@ -274,14 +274,8 @@ static bool feat_anerr(struct kvm *kvm)
>
>  static bool feat_sme_smps(struct kvm *kvm)
>  {
> -       /*
> -        * Revists this if KVM ever supports SME -- this really should
> -        * look at the guest's view of SMIDR_EL1. Funnily enough, this
> -        * is not captured in the JSON file, but only as a note in the
> -        * ARM ARM.
> -        */
>         return (kvm_has_feat(kvm, FEAT_SME) &&
> -               (read_sysreg_s(SYS_SMIDR_EL1) & SMIDR_EL1_SMPS));
> +               (kvm_read_vm_id_reg(kvm, SYS_SMIDR_EL1) & SMIDR_EL1_SMPS));
>  }
>
>  static bool feat_spe_fds(struct kvm *kvm)
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index 8c3b3d6df99f..d921db152119 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -125,6 +125,17 @@ static inline u64 ctxt_midr_el1(struct kvm_cpu_context *ctxt)
>         return kvm_read_vm_id_reg(kvm, SYS_MIDR_EL1);
>  }
>
> +static inline u64 ctxt_smidr_el1(struct kvm_cpu_context *ctxt)
> +{
> +       struct kvm *kvm = kern_hyp_va(ctxt_to_vcpu(ctxt)->kvm);
> +
> +       if (!(ctxt_is_guest(ctxt) &&
> +             test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &kvm->arch.flags)))
> +               return read_sysreg_s(SYS_SMIDR_EL1);
> +
> +       return kvm_read_vm_id_reg(kvm, SYS_SMIDR_EL1);
> +}

AFAIKT, this isn't used anywhere in this series. Dead code from a
previous iteration?

> +
>  static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
>  {
>         *ctxt_mdscr_el1(ctxt)   = read_sysreg(mdscr_el1);
> diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> index f4ec6695a6a5..b656449dff69 100644
> --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> @@ -351,8 +351,10 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
>                             host_kvm->arch.vcpu_features,
>                             KVM_VCPU_MAX_FEATURES);
>
> -               if (test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &host_arch_flags))
> +               if (test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &host_arch_flags)) {
>                         hyp_vm->kvm.arch.midr_el1 = host_kvm->arch.midr_el1;
> +                       hyp_vm->kvm.arch.smidr_el1 = host_kvm->arch.smidr_el1;
> +               }
>
>                 return;
>         }
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 7e550f045f4d..a7ab02822023 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1893,6 +1893,10 @@ static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
>                 if (!vcpu_has_sve(vcpu))
>                         return REG_RAZ;
>                 break;
> +       case SYS_ID_AA64SMFR0_EL1:
> +               if (!vcpu_has_sme(vcpu))
> +                       return REG_RAZ;
> +               break;
>         }
>
>         return 0;
> @@ -1920,10 +1924,25 @@ static unsigned int raz_visibility(const struct kvm_vcpu *vcpu,
>
>  /* cpufeature ID register access trap handlers */
>
> +static bool hidden_id_reg(struct kvm_vcpu *vcpu,
> +                         struct sys_reg_params *p,
> +                         const struct sys_reg_desc *r)
> +{
> +       switch (reg_to_encoding(r)) {
> +       case SYS_SMIDR_EL1:
> +               return !vcpu_has_sme(vcpu);
> +       default:
> +               return false;
> +       }
> +}
> +
>  static bool access_id_reg(struct kvm_vcpu *vcpu,
>                           struct sys_reg_params *p,
>                           const struct sys_reg_desc *r)
>  {
> +       if (hidden_id_reg(vcpu, p, r))
> +               return bad_trap(vcpu, p, r, "write to hidden ID register");
> +

The code in this file confuses me at times, that said, the
hidden_id_reg() check is added to access_id_reg(). However, SMIDR_EL1
is defined using IMPLEMENTATION_ID, which routes to
access_imp_id_reg(). This means the visibility check is bypassed for
SMIDR_EL1, and a guest without SME can still read the register.

>         if (p->is_write)
>                 return write_to_read_only(vcpu, p, r);
>
> @@ -2012,7 +2031,9 @@ static u64 sanitise_id_aa64pfr1_el1(const struct kvm_vcpu *vcpu, u64 val)
>               SYS_FIELD_GET(ID_AA64PFR0_EL1, RAS, pfr0) == ID_AA64PFR0_EL1_RAS_IMP))
>                 val &= ~ID_AA64PFR1_EL1_RAS_frac;
>
> -       val &= ~ID_AA64PFR1_EL1_SME;
> +       if (!kvm_has_sme(vcpu->kvm))
> +               val &= ~ID_AA64PFR1_EL1_SME;
> +
>         val &= ~ID_AA64PFR1_EL1_RNDR_trap;
>         val &= ~ID_AA64PFR1_EL1_NMI;
>         val &= ~ID_AA64PFR1_EL1_GCS;
> @@ -3038,6 +3059,9 @@ static bool access_imp_id_reg(struct kvm_vcpu *vcpu,
>         case SYS_AIDR_EL1:
>                 p->regval = read_sysreg(aidr_el1);
>                 break;
> +       case SYS_SMIDR_EL1:
> +               p->regval = read_sysreg_s(SYS_SMIDR_EL1);
> +               break;

In access_imp_id_reg(), we are returning the raw hardware value for
SYS_SMIDR_EL1. Since this register is not automatically sanitized by
the ID register infra, shouldn't we apply r->val here? Without this,
the bits we intended to hide leak to the guest.

I think this should apply to this function as a whole. For now, the
other two REVIDR_EL1 and AIDR_EL1 have a mask that covers the whole
register (so doing that preserves that behavior), but if we add more
registers similar to SMIDR_EL1, they also need to be sanitised.


>         default:
>                 WARN_ON_ONCE(1);
>         }
> @@ -3048,12 +3072,15 @@ static bool access_imp_id_reg(struct kvm_vcpu *vcpu,
>  static u64 __ro_after_init boot_cpu_midr_val;
>  static u64 __ro_after_init boot_cpu_revidr_val;
>  static u64 __ro_after_init boot_cpu_aidr_val;
> +static u64 __ro_after_init boot_cpu_smidr_val;
>
>  static void init_imp_id_regs(void)
>  {
>         boot_cpu_midr_val = read_sysreg(midr_el1);
>         boot_cpu_revidr_val = read_sysreg(revidr_el1);
>         boot_cpu_aidr_val = read_sysreg(aidr_el1);
> +       if (system_supports_sme())
> +               boot_cpu_smidr_val = read_sysreg_s(SYS_SMIDR_EL1);
>  }
>
>  static u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> @@ -3065,6 +3092,8 @@ static u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>                 return boot_cpu_revidr_val;
>         case SYS_AIDR_EL1:
>                 return boot_cpu_aidr_val;
> +       case SYS_SMIDR_EL1:
> +               return boot_cpu_smidr_val;

Similarly, this should probably return boot_cpu_smidr_val & r->val.
Otherwise, the internal feat_sme_smps() check will report the feature
as present for the guest if the host supports it, creating an
inconsistency between KVM's internal view and the guest-visible ID
register.

Cheers,
/fuad



>         default:
>                 KVM_BUG_ON(1, vcpu->kvm);
>                 return 0;
> @@ -3229,7 +3258,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>                                        ID_AA64PFR1_EL1_MTE_frac |
>                                        ID_AA64PFR1_EL1_NMI |
>                                        ID_AA64PFR1_EL1_RNDR_trap |
> -                                      ID_AA64PFR1_EL1_SME |
>                                        ID_AA64PFR1_EL1_RES0 |
>                                        ID_AA64PFR1_EL1_MPAM_frac |
>                                        ID_AA64PFR1_EL1_MTE)),
> @@ -3239,7 +3267,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>                     ID_AA64PFR2_EL1_MTESTOREONLY),
>         ID_UNALLOCATED(4,3),
>         ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
> -       ID_HIDDEN(ID_AA64SMFR0_EL1),
> +       ID_WRITABLE(ID_AA64SMFR0_EL1, ~ID_AA64SMFR0_EL1_RES0),
>         ID_UNALLOCATED(4,6),
>         ID_WRITABLE(ID_AA64FPFR0_EL1, ~ID_AA64FPFR0_EL1_RES0),
>
> @@ -3446,7 +3474,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>         { SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
>           .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
>         { SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
> -       { SYS_DESC(SYS_SMIDR_EL1), undef_access },
> +       IMPLEMENTATION_ID(SMIDR_EL1, (SMIDR_EL1_NSMC | SMIDR_EL1_HIP |
> +                                     SMIDR_EL1_AFFINITY2 |
> +                                     SMIDR_EL1_IMPLEMENTER |
> +                                     SMIDR_EL1_REVISION | SMIDR_EL1_SH |
> +                                     SMIDR_EL1_AFFINITY)),
>         IMPLEMENTATION_ID(AIDR_EL1, GENMASK_ULL(63, 0)),
>         { SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
>         ID_FILTERED(CTR_EL0, ctr_el0,
>
> --
> 2.47.3
>

