Return-Path: <linux-kselftest+bounces-48618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0FD0B192
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 17:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C5C3043927
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05303563F3;
	Fri,  9 Jan 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePac9VHr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ACA27FD44
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974192; cv=pass; b=M1bJQo9smyMfNy6hB05NpvBQjGxS/k3HN0Q2KAvCZOgVGMsDLSBL2xUK0yTIXVNOyD51h5IvSa0cstlg18Cce9gf3JH/BIVrUYBO8twJd8M/oq8oQ8oYaNSPLcg7cjXjlG4i2z8LQXguHMLsrPYF5xzEl61HO3aC5H+YJrByjGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974192; c=relaxed/simple;
	bh=drbfeLZIZyZs1P1OG1bi9mGh0XTSFJ6dEcumEQXA0xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOepYwc/waQkT6BJitWOdpaWDh7MWyRUvGDjRnlgz1kusNljxksN2psoN9NGGu7sRBkTrAOm3uEqLMifaYiUVsTnQ2DkG2wW7Z3aM03DL0WMObHSsVbV/lGrFl/0SUfYsmkoMrfC5gKEXfYIKFIgVPxmLGifz1BDIDLQDY+dI7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePac9VHr; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee147baf7bso439741cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 07:56:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767974188; cv=none;
        d=google.com; s=arc-20240605;
        b=SvOLP+4QkvEiIBfj6YneR8KYnep5FZsO4+dgfW0b6QRjJSp5611Q7vJwZltNS0khV1
         xox5FZLaFiDt2wBQ2axQRJCJaPP2IKhs2gIL7FEVTx7au/rfnEaCfWhFpNzbBUp5DAjV
         Pz6EKZIZrGwv3qtscjuyH/LS9kSTfSjr6lCge+4iKF+V9/jcdjebCJb7SSHk/O9/71Hh
         R8YVfgzDu8z39HC1YD229AbVd93Jr61wozTXB9hZ7QJ1gQLjKd2l3cxRsNMKOKIiliVJ
         27ZC6MwPT9trLW+5suQocbwrt5hqT6pVajxG/dYJc8uKsAI+BiZPuGLI33+PYlO+z4mx
         6+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lO4kv7J4FSmcCFF5cavwgM24+IZ64AUylx9G5mDhyIM=;
        fh=W7rfJq5g6bcdNaEIsAv7xbJpdttvAmRHHUhld9KlGqs=;
        b=Vx/gPcII3YduHZ45pks/Azuv43yZviHNC7ewRdycZJaQYwofWBhDPOhyRnJSVVuHQQ
         SdPe29oKYipVHQ+xQt8FIkENUaJPVKMqYm2H6OK3CnGtfzcpRwaP/BmJADPjqjSwRGZG
         K14B1ytEwEzSh2RpMUEK5YisBdy0aNMQ04sY9wJzIMTQKhagJZ4aZJif2S0FhzUC8pB+
         v9jWWClaPgODLXeG3pCqzm0Yrhgv7mtwcj5QYy7OESX3n5lAOZICEdNpaDYB+3ehHEK4
         SATP+uijDqMPPiTIKScKKnzDxpYYGRyykwoH3/f5FGgZp6/jA9UEIWw9KlN6y61+0Zzp
         KhLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767974188; x=1768578988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lO4kv7J4FSmcCFF5cavwgM24+IZ64AUylx9G5mDhyIM=;
        b=ePac9VHropQ0HH8KRj+llAeKcZeZdc93Fem+P9Ko2wBd0DJC3dJQByMJDcFiWEPk3h
         BYTiPFXNnAo+n8E3K0H5XuaTYYmDO6+pXDqTnngEbtN0UowtaoFw343E/gT1plIRuu4k
         sKl9VVnP0rfgPgMNWnuatznM77glnbK3kXd6w8CAjDze7+M9qukRqIY1IsR6OYAgRWvF
         jeb8k21i09ncmYGD2+MW1o3TGr2eedlzh3cu4p1Adx0R0oWePOoy/0kLv8EtJuFLjTeQ
         d6V4/WyZxQvfVJqgi4vhyVH9uXmjanmsBw5a80ZNZqN/4L4AVkOGsuWeUlxn8cb9GE0R
         VeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767974188; x=1768578988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO4kv7J4FSmcCFF5cavwgM24+IZ64AUylx9G5mDhyIM=;
        b=aeW0pOvEZGUIl8/5zu1eJ13Gi0O3BhYGDNinfKZZXMFTIaN/vEm7f4uTnQyo823kH5
         6Zor+5EU3/nZh05FtD5kQMUNWbv8PguGBTy1l8BfUDIfx85Tw/ppZERt/pqfc2DQM+gc
         9jJN9Gw0Dr8rY3CpGSaOHA/4QtlmrKxQdNBPhBqH/8Rcdfe5as417Gfd+NS7GvkCgFbV
         3H9FUnANlH/AQzfpb3Qyv6vXNSD4JMQBuw+2uKNTi9JbFuF2ct2Ewg/0ZR9GCA23S/Cu
         pEmQScO68sj9B0063XOIDu7AJJ7FyAtQLlFNSu8nKYla7OtKJg8qN4Dn9ZA7WX0nV1qM
         USPg==
X-Forwarded-Encrypted: i=1; AJvYcCWvcY2YFVORf2eStT+d39EqaW2aTu0eRYAaMKYZcKkdDP5kpqJO65acid/ACGfA872CUGJrO05LzTRYoYkpkps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvtyWm3l8bdjhN9lefFKLFCg0SA/x9WxgqgJ7ox/Gpl2lLKBSY
	CIAoT5JQcB1Sz8GZdNLoRksrlBt9T4UdzOfF29j2bFjJgqHxv8gY02+7ZYe8PrWcgyHHtTDkmL6
	zi3M1aHvhlgl+6sXfw0Qr0THmUkLgx6S44H0Mt1yJ
X-Gm-Gg: AY/fxX6wPegh35mNbIxoYvW2enea9/aev/cLAFrRVSDcSHXKn2Z7C90hZpq6eXD6BK8
	g6sqW6TTclAPeOLKUzV6KGYAzkiSF8vMYYGfX903wHpu41DfAbwFKlgXQ4y7nsYEMyHwMDRkNgZ
	YigWnxjD/GC6x9DGqhDmW2Gzbcu8pcAgO6bbqqs1g0DjU8gh4DDzSzKR8Q0ajJaLdKuHcCJYXDu
	3E+ZE5+VyCzEmu9ybTeTytNBy1aiffUCuaYxlkFML+q2/wcmUO6PEqMugrmLaoRQlC9RrMx
X-Received: by 2002:ac8:5ac6:0:b0:4ff:bf96:db86 with SMTP id
 d75a77b69052e-4ffca3afdd2mr12092391cf.16.1767974187462; Fri, 09 Jan 2026
 07:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-13-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-13-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 9 Jan 2026 15:55:50 +0000
X-Gm-Features: AZwV_QgHKSx9xrRlwCUXH9McoFdoQwQ7z-YH_ruv5puKBu-bPD_SzO17DT3QY2I
Message-ID: <CA+EHjTw8twejbO+0Adje0pmNJi7EDnRkcLRW5ZgiCwJ7nAna1Q@mail.gmail.com>
Subject: Re: [PATCH v9 13/30] KVM: arm64: Store vector lengths in an array
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
> SME adds a second vector length configured in a very similar way to the
> SVE vector length, in order to facilitate future code sharing for SME
> refactor our storage of vector lengths to use an array like the host does.
> We do not yet take much advantage of this so the intermediate code is not
> as clean as might be.
>
> No functional change.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/include/asm/kvm_host.h       | 17 +++++++++++------
>  arch/arm64/include/asm/kvm_hyp.h        |  2 +-
>  arch/arm64/include/asm/kvm_pkvm.h       |  2 +-
>  arch/arm64/kvm/fpsimd.c                 |  2 +-
>  arch/arm64/kvm/guest.c                  |  6 +++---
>  arch/arm64/kvm/hyp/include/hyp/switch.h |  6 +++---
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  6 +++---
>  arch/arm64/kvm/hyp/nvhe/pkvm.c          |  7 ++++---
>  arch/arm64/kvm/reset.c                  | 22 +++++++++++-----------
>  9 files changed, 38 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0816180dc551..3a3330b2a6a9 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -77,8 +77,10 @@ enum kvm_mode kvm_get_mode(void);
>  static inline enum kvm_mode kvm_get_mode(void) { return KVM_MODE_NONE; };
>  #endif
>
> -extern unsigned int __ro_after_init kvm_sve_max_vl;
> -extern unsigned int __ro_after_init kvm_host_sve_max_vl;
> +extern unsigned int __ro_after_init kvm_max_vl[ARM64_VEC_MAX];
> +extern unsigned int __ro_after_init kvm_host_max_vl[ARM64_VEC_MAX];
> +DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);

I think this slipped in here by mistake, i.e., userspace_irqchip_in_use.

With that removed:
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> +
>  int __init kvm_arm_init_sve(void);
>
>  u32 __attribute_const__ kvm_target_cpu(void);
> @@ -811,7 +813,7 @@ struct kvm_vcpu_arch {
>          */
>         void *sve_state;
>         enum fp_type fp_type;
> -       unsigned int sve_max_vl;
> +       unsigned int max_vl[ARM64_VEC_MAX];
>
>         /* Stage 2 paging state used by the hardware on next switch */
>         struct kvm_s2_mmu *hw_mmu;
> @@ -1098,9 +1100,12 @@ struct kvm_vcpu_arch {
>
>  /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
>  #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +     \
> -                            sve_ffr_offset((vcpu)->arch.sve_max_vl))
> +                            sve_ffr_offset((vcpu)->arch.max_vl[ARM64_VEC_SVE]))
> +
> +#define vcpu_vec_max_vq(vcpu, type) sve_vq_from_vl((vcpu)->arch.max_vl[type])
> +
> +#define vcpu_sve_max_vq(vcpu)  vcpu_vec_max_vq(vcpu, ARM64_VEC_SVE)
>
> -#define vcpu_sve_max_vq(vcpu)  sve_vq_from_vl((vcpu)->arch.sve_max_vl)
>
>  #define vcpu_sve_zcr_elx(vcpu)                                         \
>         (unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
> @@ -1119,7 +1124,7 @@ struct kvm_vcpu_arch {
>         __size_ret;                                                     \
>  })
>
> -#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.sve_max_vl)
> +#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.max_vl[ARM64_VEC_SVE])
>
>  /*
>   * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 76ce2b94bd97..0317790dd3b7 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -146,6 +146,6 @@ extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
>
>  extern unsigned long kvm_nvhe_sym(__icache_flags);
>  extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
> -extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
> +extern unsigned int kvm_nvhe_sym(kvm_host_max_vl[ARM64_VEC_MAX]);
>
>  #endif /* __ARM64_KVM_HYP_H__ */
> diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
> index 0aecd4ac5f45..0697c88f2210 100644
> --- a/arch/arm64/include/asm/kvm_pkvm.h
> +++ b/arch/arm64/include/asm/kvm_pkvm.h
> @@ -167,7 +167,7 @@ static inline size_t pkvm_host_sve_state_size(void)
>                 return 0;
>
>         return size_add(sizeof(struct cpu_sve_state),
> -                       SVE_SIG_REGS_SIZE(sve_vq_from_vl(kvm_host_sve_max_vl)));
> +                       SVE_SIG_REGS_SIZE(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE])));
>  }
>
>  struct pkvm_mapping {
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 9158353d8be3..1f4fcc8b5554 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -75,7 +75,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
>                  */
>                 fp_state.st = &vcpu->arch.ctxt.fp_regs;
>                 fp_state.sve_state = vcpu->arch.sve_state;
> -               fp_state.sve_vl = vcpu->arch.sve_max_vl;
> +               fp_state.sve_vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
>                 fp_state.sme_state = NULL;
>                 fp_state.svcr = __ctxt_sys_reg(&vcpu->arch.ctxt, SVCR);
>                 fp_state.fpmr = __ctxt_sys_reg(&vcpu->arch.ctxt, FPMR);
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 8c3405b5d7b1..456ef61b6ed5 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -318,7 +318,7 @@ static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>         if (!vcpu_has_sve(vcpu))
>                 return -ENOENT;
>
> -       if (WARN_ON(!sve_vl_valid(vcpu->arch.sve_max_vl)))
> +       if (WARN_ON(!sve_vl_valid(vcpu->arch.max_vl[ARM64_VEC_SVE])))
>                 return -EINVAL;
>
>         memset(vqs, 0, sizeof(vqs));
> @@ -356,7 +356,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>                 if (vq_present(vqs, vq))
>                         max_vq = vq;
>
> -       if (max_vq > sve_vq_from_vl(kvm_sve_max_vl))
> +       if (max_vq > sve_vq_from_vl(kvm_max_vl[ARM64_VEC_SVE]))
>                 return -EINVAL;
>
>         /*
> @@ -375,7 +375,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>                 return -EINVAL;
>
>         /* vcpu->arch.sve_state will be alloc'd by kvm_vcpu_finalize_sve() */
> -       vcpu->arch.sve_max_vl = sve_vl_from_vq(max_vq);
> +       vcpu->arch.max_vl[ARM64_VEC_SVE] = sve_vl_from_vq(max_vq);
>
>         return 0;
>  }
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index c5d5e5b86eaf..9ce53524d664 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -458,8 +458,8 @@ static inline void __hyp_sve_save_host(void)
>         struct cpu_sve_state *sve_state = *host_data_ptr(sve_state);
>
>         sve_state->zcr_el1 = read_sysreg_el1(SYS_ZCR);
> -       write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
> -       __sve_save_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
> +       write_sysreg_s(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1, SYS_ZCR_EL2);
> +       __sve_save_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_max_vl[ARM64_VEC_SVE]),
>                          &sve_state->fpsr,
>                          true);
>  }
> @@ -514,7 +514,7 @@ static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
>                         zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
>                         write_sysreg_el2(zcr_el2, SYS_ZCR);
>                 } else {
> -                       zcr_el2 = sve_vq_from_vl(kvm_host_sve_max_vl) - 1;
> +                       zcr_el2 = sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1;
>                         write_sysreg_el2(zcr_el2, SYS_ZCR);
>
>                         zcr_el1 = vcpu_sve_max_vq(vcpu) - 1;
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index a7c689152f68..208e9042aca4 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -34,7 +34,7 @@ static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
>          */
>         sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
>         __sve_save_state(vcpu_sve_pffr(vcpu), &vcpu->arch.ctxt.fp_regs.fpsr, true);
> -       write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
> +       write_sysreg_s(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1, SYS_ZCR_EL2);
>  }
>
>  static void __hyp_sve_restore_host(void)
> @@ -50,8 +50,8 @@ static void __hyp_sve_restore_host(void)
>          * that was discovered, if we wish to use larger VLs this will
>          * need to be revisited.
>          */
> -       write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
> -       __sve_restore_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
> +       write_sysreg_s(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1, SYS_ZCR_EL2);
> +       __sve_restore_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_max_vl[ARM64_VEC_SVE]),
>                             &sve_state->fpsr,
>                             true);
>         write_sysreg_el1(sve_state->zcr_el1, SYS_ZCR);
> diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> index b402dcb7691e..f4ec6695a6a5 100644
> --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> @@ -20,7 +20,7 @@ unsigned long __icache_flags;
>  /* Used by kvm_get_vttbr(). */
>  unsigned int kvm_arm_vmid_bits;
>
> -unsigned int kvm_host_sve_max_vl;
> +unsigned int kvm_host_max_vl[ARM64_VEC_MAX];
>
>  /*
>   * The currently loaded hyp vCPU for each physical CPU. Used in protected mode
> @@ -450,7 +450,8 @@ static int pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *h
>         }
>
>         /* Limit guest vector length to the maximum supported by the host. */
> -       sve_max_vl = min(READ_ONCE(host_vcpu->arch.sve_max_vl), kvm_host_sve_max_vl);
> +       sve_max_vl = min(READ_ONCE(host_vcpu->arch.max_vl[ARM64_VEC_SVE]),
> +                        kvm_host_max_vl[ARM64_VEC_SVE]);
>         sve_state_size = sve_state_size_from_vl(sve_max_vl);
>         sve_state = kern_hyp_va(READ_ONCE(host_vcpu->arch.sve_state));
>
> @@ -464,7 +465,7 @@ static int pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *h
>                 goto err;
>
>         vcpu->arch.sve_state = sve_state;
> -       vcpu->arch.sve_max_vl = sve_max_vl;
> +       vcpu->arch.max_vl[ARM64_VEC_SVE] = sve_max_vl;
>
>         return 0;
>  err:
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index f7c63e145d54..a8684a1346ec 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -32,7 +32,7 @@
>
>  /* Maximum phys_shift supported for any VM on this host */
>  static u32 __ro_after_init kvm_ipa_limit;
> -unsigned int __ro_after_init kvm_host_sve_max_vl;
> +unsigned int __ro_after_init kvm_host_max_vl[ARM64_VEC_MAX];
>
>  /*
>   * ARMv8 Reset Values
> @@ -46,14 +46,14 @@ unsigned int __ro_after_init kvm_host_sve_max_vl;
>  #define VCPU_RESET_PSTATE_SVC  (PSR_AA32_MODE_SVC | PSR_AA32_A_BIT | \
>                                  PSR_AA32_I_BIT | PSR_AA32_F_BIT)
>
> -unsigned int __ro_after_init kvm_sve_max_vl;
> +unsigned int __ro_after_init kvm_max_vl[ARM64_VEC_MAX];
>
>  int __init kvm_arm_init_sve(void)
>  {
>         if (system_supports_sve()) {
> -               kvm_sve_max_vl = sve_max_virtualisable_vl();
> -               kvm_host_sve_max_vl = sve_max_vl();
> -               kvm_nvhe_sym(kvm_host_sve_max_vl) = kvm_host_sve_max_vl;
> +               kvm_max_vl[ARM64_VEC_SVE] = sve_max_virtualisable_vl();
> +               kvm_host_max_vl[ARM64_VEC_SVE] = sve_max_vl();
> +               kvm_nvhe_sym(kvm_host_max_vl[ARM64_VEC_SVE]) = kvm_host_max_vl[ARM64_VEC_SVE];
>
>                 /*
>                  * The get_sve_reg()/set_sve_reg() ioctl interface will need
> @@ -61,16 +61,16 @@ int __init kvm_arm_init_sve(void)
>                  * order to support vector lengths greater than
>                  * VL_ARCH_MAX:
>                  */
> -               if (WARN_ON(kvm_sve_max_vl > VL_ARCH_MAX))
> -                       kvm_sve_max_vl = VL_ARCH_MAX;
> +               if (WARN_ON(kvm_max_vl[ARM64_VEC_SVE] > VL_ARCH_MAX))
> +                       kvm_max_vl[ARM64_VEC_SVE] = VL_ARCH_MAX;
>
>                 /*
>                  * Don't even try to make use of vector lengths that
>                  * aren't available on all CPUs, for now:
>                  */
> -               if (kvm_sve_max_vl < sve_max_vl())
> +               if (kvm_max_vl[ARM64_VEC_SVE] < sve_max_vl())
>                         pr_warn("KVM: SVE vector length for guests limited to %u bytes\n",
> -                               kvm_sve_max_vl);
> +                               kvm_max_vl[ARM64_VEC_SVE]);
>         }
>
>         return 0;
> @@ -78,7 +78,7 @@ int __init kvm_arm_init_sve(void)
>
>  static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
>  {
> -       vcpu->arch.sve_max_vl = kvm_sve_max_vl;
> +       vcpu->arch.max_vl[ARM64_VEC_SVE] = kvm_max_vl[ARM64_VEC_SVE];
>
>         /*
>          * Userspace can still customize the vector lengths by writing
> @@ -99,7 +99,7 @@ static int kvm_vcpu_finalize_vec(struct kvm_vcpu *vcpu)
>         size_t reg_sz;
>         int ret;
>
> -       vl = vcpu->arch.sve_max_vl;
> +       vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
>
>         /*
>          * Responsibility for these properties is shared between
>
> --
> 2.47.3
>

