Return-Path: <linux-kselftest+bounces-38381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66417B1C824
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4726F18C3E97
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7359290BAB;
	Wed,  6 Aug 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO6B1sa5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53442944F
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492636; cv=none; b=Qw65lL5gikFdfOFlmJM2jSOmHXxwF1z8oKe0957xNyFVYtn62Emekr3V1T9XLGvMc+qtNP+ZtzR+lEeuDuuU0cB+o5Bf14f6fjsEceeqWGw9wwwQ6gMOXea7H00KPK1v06EWtyVgARxULuoL122/tx5wuBkgN7JFFOXbLuWWiu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492636; c=relaxed/simple;
	bh=0pkcvBT3e4XZc7ShBEniMBWN3q1RI9VEAouZGjIeY2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDGC6Jy32YLROaKOvf6w1xMO6JF4OQ4ZvNn+1PUFMGpYuz/1IamFqXlYIC3XpsD2eIzi4qu1JbXSaVBaTOkrbN4mmUc72pW/Gr++6eZaTnZ4yIxMdOLwCfRlhTleA7e4XNUzIu001aGWxFIlhTw7GgKty4NeZ4Rw4QgsoGVCAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EO6B1sa5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459e497776cso95845e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Aug 2025 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754492632; x=1755097432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9hzpMymLHd0tOskj55BKws7W4GFUy+vHJNe1oPqssU=;
        b=EO6B1sa5jQbDKgE97A3vbaKlh85hCX2TusyKoD1m9XCmFL1KxJnvl1uU1X6jcGWwhz
         4Q4Ky/Z7rmxiVu24HV70pgq65vhQo0qf6sXuSUjDkXEY+7Sknqof4WoHCSQDSKSElvmX
         MKUuLz5weJ6ZnESbY/L1Dg0kHUAVf2bMfcqmvVgBNQgq2T5F/uFMZrgPKPSzaDoJGHYu
         C4UA3v3WLBY8cVFlHhkAfrt/q7EottaLIR/zmTl/RIKfOA1yHOe7mI9mwSwVq6Ow5Orw
         IkNG0pqo9DhB1sMJw6gUfWpUaF4XVtcbcB2NIXEtZmYg31scC8vrJVxdVPhrSJyij3SD
         HTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754492632; x=1755097432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9hzpMymLHd0tOskj55BKws7W4GFUy+vHJNe1oPqssU=;
        b=dq+5r5k+DQmIFm0oTsvDAGAh+OKc8rgswJqT6LB16LnYpNGBYwp1YDwn6Vf4Ogv5hb
         lvdAq/MtBZ2OL5y/3IR8tyweJkmPKSNUGTANFpyKjbLKA1b2f/XwKPmLsD5F0g+Fc/F2
         T2Vfbj1Ud00yE9HEW3p0nbkECBT9IUvUByfjmwEpYXcDmblSMreq30tuM/nwieiggdHQ
         ioiK0TpWv/LmWPlWRKIz+fOsqbhdzwhFYQZe/tVfMGkK/L1W/R7mC7z5LGbccLDhSwUi
         uPnp5LzQ5T7LKKwvGhzMLireTiAVcKDYrUW/Fy7Q+C0Wwbk93DBiqPiEc9nEF24dxiqa
         aIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVawDk+NucCdP81QqqfBhFyZzqAnmk0WsQ+CgYQYYLOTfgGG+qdwI6lWSmBY08xUZogZIzD5QbvCaxbwqU5c6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/KOAWZYrUsWwC4bs5QJ1hSRrkR+hsYm7ppNGiI1o5JjMDkY+
	afOL2Xfw/nXsl89topd+lELECNjIFNkg3HQt3wlTrGvgYKy+CznZmH5h4jWf8FyMDOgA3czgpfN
	8JzxgejwRDXAutE9TCN6IvQcxb5dQ4Z64FXBIBtMe
X-Gm-Gg: ASbGncu8ONpw2FWSQsHGdl2Xn6fwtEShQQVCPI5thLpZ92lxuvEjpbNULJtqa4ItXbZ
	XaJbfiEJK9LdA9rln7Ut7XghefkOUVVt73pD8KD16kS/vnlSbpbLZ1AxZLk4vGbD38WUeH8kC3E
	JP5pmEJObOQ+lF6gbs6AR5tEKEm+Xg15Ka+uWVyqGu+GibyA5dRtxAZ2eN3+S7Uz/jq9VH8DdoW
	quhbVWYpQYKfRPX7TyAOjOB8B5j2LRM7wpUQfMk
X-Google-Smtp-Source: AGHT+IFRSHXB1edxE24M2cr8EagNxoS3Umr3ekhDunEvzG71eZ1BXAYU7hknAAcoq+dJ3w6ps9DyZyBPQWpQnPYmDrs=
X-Received: by 2002:a05:600d:18:b0:453:65e6:b4a6 with SMTP id
 5b1f17b1804b1-459e6c8b7ccmr1554045e9.6.1754492631287; Wed, 06 Aug 2025
 08:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731205844.1346839-1-jiaqiyan@google.com> <20250731205844.1346839-2-jiaqiyan@google.com>
In-Reply-To: <20250731205844.1346839-2-jiaqiyan@google.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 6 Aug 2025 08:03:39 -0700
X-Gm-Features: Ac12FXxJqYpQQ--vvuonDndHyeTf3i5rlJy2TpzkQAYWmQtSnPZvo6WJzUZ-3Qo
Message-ID: <CACw3F53dQmeLjwc4LG5SipiEhB7jj9hK+C_XWrT2eFQghMHXQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] KVM: arm64: VM exit to userspace to handle SEA
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	duenwen@google.com, rananta@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping for review

On Thu, Jul 31, 2025 at 1:58=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> When APEI fails to handle a stage-2 synchronous external abort (SEA),
> today KVM directly injects an async SError to the VCPU then resumes it,
> which usually results in unpleasant guest kernel panic.
>
> One major situation of guest SEA is when vCPU consumes recoverable
> uncorrected memory error (UER). Although SError and guest kernel panic
> effectively stops the propagation of corrupted memory, guest may
> re-use the corrupted memory if auto-rebooted; in worse case, guest
> boot may run into poisoned memory. So there is room to recover from
> an UER in a more graceful manner.
>
> Alternatively KVM can redirect the synchronous SEA event to VMM to
> - Reduce blast radius if possible. VMM can inject a SEA to VCPU via
>   KVM's existing KVM_SET_VCPU_EVENTS API. If the memory poison
>   consumption or fault is not from guest kernel, blast radius can be
>   limited to the triggering thread in guest userspace, so VM can
>   keep running.
> - Allow VMM to protect from future memory poison consumption by
>   unmapping the page from stage-2, or to interrupt guest of the
>   poisoned page so guest kernel can unmap it from stage-1 page table.
> - Allow VMM to track SEA events that VM customers care about, to restart
>   VM when certain number of distinct poison events have happened,
>   to provide observability to customers in log management UI.
>
> Introduce an userspace-visible feature to enable VMM handle SEA:
> - KVM_CAP_ARM_SEA_TO_USER. As the alternative fallback behavior
>   when host APEI fails to claim a SEA, userspace can opt in this new
>   capability to let KVM exit to userspace during SEA if it is not
>   owned by host.
> - KVM_EXIT_ARM_SEA. A new exit reason is introduced for this.
>   KVM fills kvm_run.arm_sea with as much as possible information about
>   the SEA, enabling VMM to emulate SEA to guest by itself.
>   - Sanitized ESR_EL2. The general rule is to keep only the bits
>     useful for userspace and relevant to guest memory.
>   - Flags indicating if faulting guest physical address is valid.
>   - Faulting guest physical and virtual addresses if valid.
>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  arch/arm64/include/asm/kvm_host.h |  2 +
>  arch/arm64/kvm/arm.c              |  5 +++
>  arch/arm64/kvm/mmu.c              | 68 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/kvm.h          | 10 +++++
>  4 files changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/k=
vm_host.h
> index d373d555a69ba..8b4133a5aacf3 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -349,6 +349,8 @@ struct kvm_arch {
>  #define KVM_ARCH_FLAG_GUEST_HAS_SVE                    9
>         /* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace=
 */
>  #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS             10
> +       /* Unhandled SEAs are taken to userspace */
> +#define KVM_ARCH_FLAG_EXIT_SEA                         11
>         unsigned long flags;
>
>         /* VM-wide vCPU feature set */
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 7a1a8210ff918..aec6034db1e75 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -133,6 +133,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>                 }
>                 mutex_unlock(&kvm->lock);
>                 break;
> +       case KVM_CAP_ARM_SEA_TO_USER:
> +               r =3D 0;
> +               set_bit(KVM_ARCH_FLAG_EXIT_SEA, &kvm->arch.flags);
> +               break;
>         default:
>                 break;
>         }
> @@ -322,6 +326,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>         case KVM_CAP_IRQFD_RESAMPLE:
>         case KVM_CAP_COUNTER_OFFSET:
>         case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
> +       case KVM_CAP_ARM_SEA_TO_USER:
>                 r =3D 1;
>                 break;
>         case KVM_CAP_SET_GUEST_DEBUG2:
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 9a45daf817bfd..f6a545700c15b 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1812,8 +1812,48 @@ static void handle_access_fault(struct kvm_vcpu *v=
cpu, phys_addr_t fault_ipa)
>         read_unlock(&vcpu->kvm->mmu_lock);
>  }
>
> +/*
> + * Returns true if the SEA should be handled locally within KVM if the a=
bort
> + * is caused by a kernel memory allocation (e.g. stage-2 table memory).
> + */
> +static bool host_owns_sea(struct kvm_vcpu *vcpu, u64 esr)
> +{
> +       /*
> +        * Without FEAT_RAS HCR_EL2.TEA is RES0, meaning any external abo=
rt
> +        * taken from a guest EL to EL2 is due to a host-imposed access (=
e.g.
> +        * stage-2 PTW).
> +        */
> +       if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
> +               return true;
> +
> +       /* KVM owns the VNCR when the vCPU isn't in a nested context. */
> +       if (is_hyp_ctxt(vcpu) && (esr & ESR_ELx_VNCR))
> +               return true;
> +
> +       /*
> +        * Determine if an external abort during a table walk happened at
> +        * stage-2 is only possible when S1PTW is set. Otherwise, since K=
VM
> +        * sets HCR_EL2.TEA, SEAs due to a stage-1 walk (i.e. accessing t=
he
> +        * PA of the stage-1 descriptor) can reach here and are reported
> +        * with a TTW ESR value.
> +        */
> +       return (esr_fsc_is_sea_ttw(esr) && (esr & ESR_ELx_S1PTW));
> +}
> +
>  int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>  {
> +       struct kvm *kvm =3D vcpu->kvm;
> +       struct kvm_run *run =3D vcpu->run;
> +       u64 esr =3D kvm_vcpu_get_esr(vcpu);
> +       u64 esr_mask =3D ESR_ELx_EC_MASK  |
> +                      ESR_ELx_IL       |
> +                      ESR_ELx_FnV      |
> +                      ESR_ELx_EA       |
> +                      ESR_ELx_CM       |
> +                      ESR_ELx_WNR      |
> +                      ESR_ELx_FSC;
> +       u64 ipa;
> +
>         /*
>          * Give APEI the opportunity to claim the abort before handling i=
t
>          * within KVM. apei_claim_sea() expects to be called with IRQs en=
abled.
> @@ -1822,7 +1862,33 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>         if (apei_claim_sea(NULL) =3D=3D 0)
>                 return 1;
>
> -       return kvm_inject_serror(vcpu);
> +       if (host_owns_sea(vcpu, esr) ||
> +           !test_bit(KVM_ARCH_FLAG_EXIT_SEA, &vcpu->kvm->arch.flags))
> +               return kvm_inject_serror(vcpu);
> +
> +       /* ESR_ELx.SET is RES0 when FEAT_RAS isn't implemented. */
> +       if (kvm_has_ras(kvm))
> +               esr_mask |=3D ESR_ELx_SET_MASK;
> +
> +       /*
> +        * Exit to userspace, and provide faulting guest virtual and phys=
ical
> +        * addresses in case userspace wants to emulate SEA to guest by
> +        * writing to FAR_ELx and HPFAR_ELx registers.
> +        */
> +       memset(&run->arm_sea, 0, sizeof(run->arm_sea));
> +       run->exit_reason =3D KVM_EXIT_ARM_SEA;
> +       run->arm_sea.esr =3D esr & esr_mask;
> +
> +       if (!(esr & ESR_ELx_FnV))
> +               run->arm_sea.gva =3D kvm_vcpu_get_hfar(vcpu);
> +
> +       ipa =3D kvm_vcpu_get_fault_ipa(vcpu);
> +       if (ipa !=3D INVALID_GPA) {
> +               run->arm_sea.flags |=3D KVM_EXIT_ARM_SEA_FLAG_GPA_VALID;
> +               run->arm_sea.gpa =3D ipa;
> +       }
> +
> +       return 0;
>  }
>
>  /**
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index e4e566ff348b0..b2cc3d74d769c 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -179,6 +179,7 @@ struct kvm_xen_exit {
>  #define KVM_EXIT_LOONGARCH_IOCSR  38
>  #define KVM_EXIT_MEMORY_FAULT     39
>  #define KVM_EXIT_TDX              40
> +#define KVM_EXIT_ARM_SEA          41
>
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -469,6 +470,14 @@ struct kvm_run {
>                                 } get_tdvmcall_info;
>                         };
>                 } tdx;
> +               /* KVM_EXIT_ARM_SEA */
> +               struct {
> +#define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID        (1ULL << 0)
> +                       __u64 flags;
> +                       __u64 esr;
> +                       __u64 gva;
> +                       __u64 gpa;
> +               } arm_sea;
>                 /* Fix the size of the union. */
>                 char padding[256];
>         };
> @@ -957,6 +966,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_ARM_EL2_E2H0 241
>  #define KVM_CAP_RISCV_MP_STATE_RESET 242
>  #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
> +#define KVM_CAP_ARM_SEA_TO_USER 244
>
>  struct kvm_irq_routing_irqchip {
>         __u32 irqchip;
> --
> 2.50.1.565.gc32cd1483b-goog
>

