Return-Path: <linux-kselftest+bounces-48517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A39ED03687
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5132232747CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444464AC789;
	Thu,  8 Jan 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmBfbjLl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B74BE29D
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881436; cv=pass; b=XosbHFbBHXijhKIji4x0xN7IYfZ45WnlU+AwOqTCIPZ/P26336PKppvjdsssUl8x5a5Lo6XNdrYisFbA8qaN7iDygXU7XPRtobevKUgxnw6Zrmq/X+JC9yS2HeA3GL5XZOkCBkFs7msiuOLA+vZp5bQ/GXidKWNKny9cm4s8l/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881436; c=relaxed/simple;
	bh=1QDA0timfcoG8ZtW/MI90fo/ipTU9sabn6dcwMEqYDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUCIZomNrbrnils5u0b5W4kAxPWIqtNCqDKbqYe8epMLODM3Mqxga17sB1xAQvaGioaDKVqPfyI+R++P/Foto/YjboYxly3tMYWwGN0SLq4IIRUWPWK7mJqlRoHjwqaBmcrd5uZZCre2emdQHxTcjtHcIKhm7ksC9V4hIVpq4gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmBfbjLl; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee147baf7bso973501cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 06:10:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767881432; cv=none;
        d=google.com; s=arc-20240605;
        b=bicj10NPllndTMUbHnyzsX1Gms0Ikzg9pRzckBcIY5CybftDHP1xXPZ6lxXOy8aBIl
         CAOA2+QlBqhZUWe3EpCJCc1hB3DXAPFLbUPnSnsE4oW/BFGVNZatTw20Ie0Uoz2gCoX/
         BONDnMd69nfsA9hgSizfbqFKt5IDN2lh3xgLpKdfM9pnLPmkWPiJVCQfv2EQo0uY2bsC
         mz6VWeuNOh8LWUqyyXbKEVjf4qZIReOyfskhjUKj5R6YQ6y7/V04y//ukCpIEsyR3+rg
         Mtuqo7hbu1S6AiyQ3qmJeXCVxWRr8SRqHSnxth3Lmepv5bYhW3TT0mIUvnvQq5uXTfFo
         CDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HErK+ZAsiLkCooDCBi0EQVptvs7VIv5Dy3Hcl1WrQnM=;
        fh=igXzx0oX0iiuYHqbvDo0h47efa3cKNWPx+yUfab/QGs=;
        b=Aad0+PEuq0avv7bu3geTPAvB674G5dPRaRrUOKMJT0WfDHSZwmbpCHnLtAKjHkJD5F
         37fodkWdMp749WuxV9/iYIKzYHz4/7cwv/cjeRvc/sF/CBEzC8XDId2L+u29v5RBD8/d
         +f8nEjURVrFio02r2FZ+DLgrfkEKKCA4aL/6hVe6fdLAjXJA49vxHMCKgUiJb+1t3S7q
         LUqHI7b347iytEnxTVW9zJwtIlWqJHgHUBVYBEDY8u9AFpmbbOeTTczCYnem99+G16lj
         PTSGodKB0kDzkHyC2dgNuCAcwUVNeb785SW3B2KADxcA5KGYSmUFQK034i0dTTEb8TWA
         zKyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767881432; x=1768486232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HErK+ZAsiLkCooDCBi0EQVptvs7VIv5Dy3Hcl1WrQnM=;
        b=KmBfbjLl2CuFyJn/uZ16gI5NX1DIE+gnbCZ9ZIxG2u5z7KZWVeECDO/t06eYw2schc
         wp+seUAj0nqiPYEPJkCYHcl7X/ZlSgXG4suorNod7MbvaTdg8yw0424XFHQxUzpUxTXj
         RKG4iLSGIlohN5cBTpvnVieOdaZMU9Keu25tAW/CYda16JoMUE545yNhLVvOAFd/bxwc
         cs4rkpOqo+Xe4mGyg1lIvUzhdnVFY0/gCO2RGCK7sDUxB2rCbrDHkObCVJjNOVWSvQyh
         zBL1AAFRWR0ZmCLYIb06pH1wnysIc+ly/HgCib48jDHwtH7Rxb7mhffwZRnBZWD2v95j
         ECjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881432; x=1768486232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HErK+ZAsiLkCooDCBi0EQVptvs7VIv5Dy3Hcl1WrQnM=;
        b=dho4+eeJwxtg/6bN9293vHkCEaL91ijMrns8BJMm5gndc7qF2Q2g4SnHChl0BM+OB2
         RFBRIiir3WbcwpohuyRlP+XlUok/z4fM4HFPs1iNNJjy/DlDUrediDAFg/M6cZnH0dbw
         t/NjDMiC10D4JKZumeVrErXcZmh4N/NoaU6A6jAfy1kcBtuIjbQhV66x6cmd9kP4aE2f
         FJvkR4jzDhD5YtKS6Lm6ao6mFVj11V9+OwlNzUA7Ksklw+lbU/DW+jTitXRJ6CE+xWsA
         FJbftbswafFLi/bwKQ/MqfFUn97ZOKHuf/ap7QWMIpCXMmK61GxyhrfGmGB0CBFeTOM0
         JQ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkf/2LBf8kXmuTEmMYv6dUm2RNbLy3r9qDxkTsu/7P8jTQZXSvEiVLoDjzidrOVBR0dkb220JmceX6v9kp1CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwwc3wew4wsFHYAVXwAKhO6+hF2kg7Tdx/g3ALhLvJgDUD5oRc
	YZsy79QYh3Ypn8h6SH/lzfObJQIX/pNIKzRoZNLwQwb4QRX/4FFz6o8X4egi6PfWnRgl1hsu7M1
	0CsHqMq/SsrvWMGR8ad/7St4MPROecXua07GDWAj1
X-Gm-Gg: AY/fxX5c1HKAclyt4tGqWpESFP8n24AB2KI1qm3Crvb3ENP5Pg/O5HdPjToEFSnPMN9
	lbIPFDeb1FfyDK08QgmdnUYgkB3p73lo2c8broThlQH/HfH8GFf779N1hpvl1Eby3KXQoisHFpK
	bTT4DBQJz7pcU4Q4CGPtry+RXMMGf6yca3DoKeREOYXNo8lI1w95XrZGn6EfeQnaEOokTgXCwGw
	B2vEk5dOJM+fCqRRrdjl8Y1EV1B9E36+76QdiZxcZn+Uv1U0/2dhC39PSTK5ExTh/3aegAz
X-Received: by 2002:a05:622a:1489:b0:4ed:ff79:e678 with SMTP id
 d75a77b69052e-4ffc099853bmr8042581cf.18.1767881431457; Thu, 08 Jan 2026
 06:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-9-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-9-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 8 Jan 2026 14:09:54 +0000
X-Gm-Features: AQt7F2rQXIZDgc9AB-_m9obzDaZR7vHikvpjlR9mwKIH8JfARH3pHLVi2pEmeM4
Message-ID: <CA+EHjTxAzGrgxtSbhb8f5cs4mj_mD31gOGhwUEZFN21xGfoKyg@mail.gmail.com>
Subject: Re: [PATCH v9 09/30] KVM: arm64: Rename SVE finalization constants to
 be more general
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
> Due to the overlap between SVE and SME vector length configuration
> created by streaming mode SVE we will finalize both at once.  Rename the
> existing finalization to use _VEC (vector) for the naming to avoid
> confusion.
>
> Since this includes the userspace API we create an alias
> KVM_ARM_VCPU_VEC for the existing KVM_ARM_VCPU_SVE capability, existing
> code which does not enable SME will be unaffected and any SME only code
> will not need to use SVE constants.
>
> No functional change.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/include/asm/kvm_host.h |  8 +++++---
>  arch/arm64/include/uapi/asm/kvm.h |  6 ++++++
>  arch/arm64/kvm/guest.c            | 10 +++++-----
>  arch/arm64/kvm/hyp/nvhe/pkvm.c    |  2 +-
>  arch/arm64/kvm/reset.c            | 20 ++++++++++----------
>  5 files changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index e6d25db10a6b..0f3d26467bf0 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -988,8 +988,8 @@ struct kvm_vcpu_arch {
>
>  /* KVM_ARM_VCPU_INIT completed */
>  #define VCPU_INITIALIZED       __vcpu_single_flag(cflags, BIT(0))
> -/* SVE config completed */
> -#define VCPU_SVE_FINALIZED     __vcpu_single_flag(cflags, BIT(1))
> +/* Vector config completed */
> +#define VCPU_VEC_FINALIZED     __vcpu_single_flag(cflags, BIT(1))
>  /* pKVM VCPU setup completed */
>  #define VCPU_PKVM_FINALIZED    __vcpu_single_flag(cflags, BIT(2))
>
> @@ -1062,6 +1062,8 @@ struct kvm_vcpu_arch {
>  #define vcpu_has_sve(vcpu)     kvm_has_sve((vcpu)->kvm)
>  #endif
>
> +#define vcpu_has_vec(vcpu) vcpu_has_sve(vcpu)
> +
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  #define vcpu_has_ptrauth(vcpu)                                         \
>         ((cpus_have_final_cap(ARM64_HAS_ADDRESS_AUTH) ||                \
> @@ -1458,7 +1460,7 @@ struct kvm *kvm_arch_alloc_vm(void);
>  int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
>  bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
>
> -#define kvm_arm_vcpu_sve_finalized(vcpu) vcpu_get_flag(vcpu, VCPU_SVE_FINALIZED)
> +#define kvm_arm_vcpu_vec_finalized(vcpu) vcpu_get_flag(vcpu, VCPU_VEC_FINALIZED)
>
>  #define kvm_has_mte(kvm)                                       \
>         (system_supports_mte() &&                               \
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index a792a599b9d6..c67564f02981 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -107,6 +107,12 @@ struct kvm_regs {
>  #define KVM_ARM_VCPU_HAS_EL2           7 /* Support nested virtualization */
>  #define KVM_ARM_VCPU_HAS_EL2_E2H0      8 /* Limit NV support to E2H RES0 */
>
> +/*
> + * An alias for _SVE since we finalize VL configuration for both SVE and SME
> + * simultaneously.
> + */
> +#define KVM_ARM_VCPU_VEC               KVM_ARM_VCPU_SVE
> +
>  struct kvm_vcpu_init {
>         __u32 target;
>         __u32 features[7];
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 1c87699fd886..d15aa2da1891 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -342,7 +342,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>         if (!vcpu_has_sve(vcpu))
>                 return -ENOENT;
>
> -       if (kvm_arm_vcpu_sve_finalized(vcpu))
> +       if (kvm_arm_vcpu_vec_finalized(vcpu))
>                 return -EPERM; /* too late! */
>
>         if (WARN_ON(vcpu->arch.sve_state))
> @@ -497,7 +497,7 @@ static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>         if (ret)
>                 return ret;
>
> -       if (!kvm_arm_vcpu_sve_finalized(vcpu))
> +       if (!kvm_arm_vcpu_vec_finalized(vcpu))
>                 return -EPERM;
>
>         if (copy_to_user(uptr, vcpu->arch.sve_state + region.koffset,
> @@ -523,7 +523,7 @@ static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>         if (ret)
>                 return ret;
>
> -       if (!kvm_arm_vcpu_sve_finalized(vcpu))
> +       if (!kvm_arm_vcpu_vec_finalized(vcpu))
>                 return -EPERM;
>
>         if (copy_from_user(vcpu->arch.sve_state + region.koffset, uptr,
> @@ -599,7 +599,7 @@ static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
>                 return 0;
>
>         /* Policed by KVM_GET_REG_LIST: */
> -       WARN_ON(!kvm_arm_vcpu_sve_finalized(vcpu));
> +       WARN_ON(!kvm_arm_vcpu_vec_finalized(vcpu));
>
>         return slices * (SVE_NUM_PREGS + SVE_NUM_ZREGS + 1 /* FFR */)
>                 + 1; /* KVM_REG_ARM64_SVE_VLS */
> @@ -617,7 +617,7 @@ static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu,
>                 return 0;
>
>         /* Policed by KVM_GET_REG_LIST: */
> -       WARN_ON(!kvm_arm_vcpu_sve_finalized(vcpu));
> +       WARN_ON(!kvm_arm_vcpu_vec_finalized(vcpu));
>
>         /*
>          * Enumerate this first, so that userspace can save/restore in
> diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> index 8911338961c5..b402dcb7691e 100644
> --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> @@ -445,7 +445,7 @@ static int pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *h
>         int ret = 0;
>
>         if (!vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE)) {
> -               vcpu_clear_flag(vcpu, VCPU_SVE_FINALIZED);
> +               vcpu_clear_flag(vcpu, VCPU_VEC_FINALIZED);
>                 return 0;
>         }
>
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 959532422d3a..f7c63e145d54 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -92,7 +92,7 @@ static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
>   * Finalize vcpu's maximum SVE vector length, allocating
>   * vcpu->arch.sve_state as necessary.
>   */
> -static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
> +static int kvm_vcpu_finalize_vec(struct kvm_vcpu *vcpu)
>  {
>         void *buf;
>         unsigned int vl;
> @@ -122,21 +122,21 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
>         }
>
>         vcpu->arch.sve_state = buf;
> -       vcpu_set_flag(vcpu, VCPU_SVE_FINALIZED);
> +       vcpu_set_flag(vcpu, VCPU_VEC_FINALIZED);
>         return 0;
>  }
>
>  int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
>  {
>         switch (feature) {
> -       case KVM_ARM_VCPU_SVE:
> -               if (!vcpu_has_sve(vcpu))
> +       case KVM_ARM_VCPU_VEC:
> +               if (!vcpu_has_vec(vcpu))
>                         return -EINVAL;
>
> -               if (kvm_arm_vcpu_sve_finalized(vcpu))
> +               if (kvm_arm_vcpu_vec_finalized(vcpu))
>                         return -EPERM;
>
> -               return kvm_vcpu_finalize_sve(vcpu);
> +               return kvm_vcpu_finalize_vec(vcpu);
>         }
>
>         return -EINVAL;
> @@ -144,7 +144,7 @@ int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
>
>  bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
>  {
> -       if (vcpu_has_sve(vcpu) && !kvm_arm_vcpu_sve_finalized(vcpu))
> +       if (vcpu_has_vec(vcpu) && !kvm_arm_vcpu_vec_finalized(vcpu))
>                 return false;
>
>         return true;
> @@ -163,7 +163,7 @@ void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
>         kfree(vcpu->arch.ccsidr);
>  }
>
> -static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
> +static void kvm_vcpu_reset_vec(struct kvm_vcpu *vcpu)
>  {
>         if (vcpu_has_sve(vcpu))
>                 memset(vcpu->arch.sve_state, 0, vcpu_sve_state_size(vcpu));
> @@ -203,11 +203,11 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>         if (loaded)
>                 kvm_arch_vcpu_put(vcpu);
>
> -       if (!kvm_arm_vcpu_sve_finalized(vcpu)) {
> +       if (!kvm_arm_vcpu_vec_finalized(vcpu)) {
>                 if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE))
>                         kvm_vcpu_enable_sve(vcpu);
>         } else {
> -               kvm_vcpu_reset_sve(vcpu);
> +               kvm_vcpu_reset_vec(vcpu);
>         }
>
>         if (vcpu_el1_is_32bit(vcpu))
>
> --
> 2.47.3
>

