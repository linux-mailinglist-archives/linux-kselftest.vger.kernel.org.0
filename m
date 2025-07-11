Return-Path: <linux-kselftest+bounces-37176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428BCB02826
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 02:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABC83AEA6F
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 00:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F422D7B5;
	Fri, 11 Jul 2025 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lU/7H5/6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6A225A31
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278367; cv=none; b=Zppw5dOfTm1zfFJbVjfCsXohewy3ObS3FIFGYPXF9hrBkuIvxuVHLjIU/lmhV2MuTmUb12Li6FKSVoj6u9H2XrwJMhwhSpMshDPUyNQ7YQXVx1zGHMEdVyTxNlBwM0ltwMcjJ1PrHQ7sI5HTzvy3pBgE8Y1u1mukdpmJP7BP95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278367; c=relaxed/simple;
	bh=w0kqOrWj3NcrBJY5EhQytYEAAkh8Bum3csMCS0XUo3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfPyOGRprdP7ZSvMg9hARC4YGRFbTkah1bd9X8Ecfs94LycgdHjkooorQS44oAI4JlvgY5gMvkBvIexljS+drDdn/csQYxSH94zVp9FpprfYdOMble9elzri5+fOumbp4kvxcWLy+SdqiN2tAt/jUCFmTRNjScLFbLNQrU2D+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lU/7H5/6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so26035e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752278363; x=1752883163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx0iuUtrXjaS9cECOj10GYU2PRdzkgNl851QXdF7aTw=;
        b=lU/7H5/6tDBcF7fMWNJeCCT43A01jmrJNc8q0sxYhL807BwgXsl4OM2IaubkWMZ3tr
         Z8l0y2BB0Q2UdlZOtDs9oeoIq/2DjK4t59A5kvTLPs7Q7ocyDdmrY/yqcL8i+YTYrACd
         9ZBQjN0mHG6yzvKCp5Yr3HJOnNw7m+WK9BTU5D2GTXLfGXaFhQrzj0Gf2o1YAx3pNCOc
         Kl8kJnKok+FefdcNL9Hi6uR0jAu5V0tCfZnVX2ieqW7G7b+wA98yFcWk3a0WOP+YHSyx
         9jyWwfyprlC/+iEEXY1SFhihWqvNiDBIxV8AN4bbRhV3YX2Mi+wI2jmuhg+H64jmdd6I
         p/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752278363; x=1752883163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx0iuUtrXjaS9cECOj10GYU2PRdzkgNl851QXdF7aTw=;
        b=VFThubiq7sLmKeMVTSfy0vHqmxIC33B7mLGN7M030NXC1mEk/YWKXl4Rg/cp/8FTg8
         Sbxd/I4lG4er2yUlxZ88RqsDrqPJelfQgpCAewHiCGMHZ/ru32cJGWjDKWv6w8rbcXgn
         OgqnFYEaieHMtEVWWqA2xchl2OtouUlQvyr4Y2kL/vVkPeiQ44gfGm2AIQANvaUAb/8g
         LcTjIWPLMD0XfkS0XjM6pcvxCgDxMEoQEqTVauxK+OVr8q84CNigph2JVVCuqSnIOKdZ
         UMxfgqtUJiiTHG73SgzfhwitYJCdETecsKVfMTdjgd3D0stzsrfvgEurfGwzVwiQ85Ke
         W6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXViTQCt+hlSiCm11XgMX8vklGS3vfNUGfBSG8vFKIU9fcj0Jg/Q4R5+jB4GJBRqrKmqgLxkh/Wv/jA7P1aJ7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyErX5AUVa3qLHOGHIvzyiwMUgzsTPeQesp4X053LTsr5+jZNaY
	M6wu+/TeMnPQOR+Hd7q4vGCeCPjKwzwyrXLNgWDa9o4uBsVSoU1ZCJjpJtsMB25BuNl0GUeEIuc
	hP3uDssSGlBz7eC5LQwVOPjHZUZlBLIyWNzZaWgXm
X-Gm-Gg: ASbGncuYeSymxLbTa/RlZsiIsZ83Dk4vtD2I479hDIadvxB/fK7Ay1DUPygusRmUsV1
	caBq5HThFHcdw/Lz90Xywl/eShJRUwMLw4BKEegmM97E6eMhyc50WO/U3+6fRem9sni7NSOsteL
	pXWCk9p1St6wh1vB7O9sOqmIazlYGkHvDgS/REbmiAg1yybPq5i7ZuVGuWUtVMEDmML6ycaBCch
	r0xeGWC54ezPP688b9YEImK6u7kR5vnP/Km1g==
X-Google-Smtp-Source: AGHT+IHvHUxIq2c9hcTn9eoB+mM5K/ydF4PCHTTqsyGsI0A7WB9cz5lSEPAy1h5s7uUVuuYzUNVhGEJc8cN5YSZdxzw=
X-Received: by 2002:a05:600c:4302:b0:442:feea:622d with SMTP id
 5b1f17b1804b1-45604731777mr157435e9.1.1752278363318; Fri, 11 Jul 2025
 16:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com> <20250604050902.3944054-2-jiaqiyan@google.com>
 <aHFohmTb9qR_JG1E@linux.dev>
In-Reply-To: <aHFohmTb9qR_JG1E@linux.dev>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 11 Jul 2025 16:59:11 -0700
X-Gm-Features: Ac12FXyEUSuxc7r8GLcMk5nWGgqkSYOPBBV406o0QqoPhRyOHiOSPV8Iz9e8AVY
Message-ID: <CACw3F509B=AHhpaTcuH9O851rrDdHh1baC8uRYy7bDa7BSMhgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: arm64: VM exit to userspace to handle SEA
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:40=E2=80=AFPM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> Hi Jiaqi,
>
> On Wed, Jun 04, 2025 at 05:08:56AM +0000, Jiaqi Yan wrote:
> > When APEI fails to handle a stage-2 synchronous external abort (SEA),
> > today KVM directly injects an async SError to the VCPU then resumes it,
> > which usually results in unpleasant guest kernel panic.
> >
> > One major situation of guest SEA is when vCPU consumes recoverable
> > uncorrected memory error (UER). Although SError and guest kernel panic
> > effectively stops the propagation of corrupted memory, there is room
> > to recover from an UER in a more graceful manner.
> >
> > Alternatively KVM can redirect the synchronous SEA event to VMM to
> > - Reduce blast radius if possible. VMM can inject a SEA to VCPU via
> >   KVM's existing KVM_SET_VCPU_EVENTS API. If the memory poison
> >   consumption or fault is not from guest kernel, blast radius can be
> >   limited to the triggering thread in guest userspace, so VM can
> >   keep running.
> > - VMM can protect from future memory poison consumption by unmapping
> >   the page from stage-2, or interrupt guest of the poisoned guest page
> >   so guest kernel can unmap it from stage-1.
> > - VMM can also track SEA events that VM customers care about, restart
> >   VM when certain number of distinct poison events have happened,
> >   provide observability to customers in log management UI.
> >
> > Introduce an userspace-visible feature to enable VMM to handle SEA:
> > - KVM_CAP_ARM_SEA_TO_USER. As the alternative fallback behavior
> >   when host APEI fails to claim a SEA, userspace can opt in this new
> >   capability to let KVM exit to userspace during SEA if it is not
> >   caused by access on memory of stage-2 translation table.
> > - KVM_EXIT_ARM_SEA. A new exit reason is introduced for this.
> >   KVM fills kvm_run.arm_sea with as much as possible information about
> >   the SEA, enabling VMM to emulate SEA to guest by itself.
> >   - Sanitized ESR_EL2. The general rule is to keep only the bits
> >     useful for userspace and relevant to guest memory. See code
> >     comments for why bits are hidden/reported.
> >   - If faulting guest virtual and physical addresses are available.
> >   - Faulting guest virtual address if available.
> >   - Faulting guest physical address if available.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>
> I was reviewing this locally and wound up making enough changes where it
> just made more sense to share the diff. General comments:

Thanks for the diff, Oliver! I will work on a v3 based on it.

>
>  - Avoid adding helpers to headers when they're used in a single
>    callsite / compilation unit
>
>  - Add some detail about FEAT_RAS where we may still exit to userspace
>    for host-controlled memory, as we cannot differentiate between a
>    stage-1 or stage-2 TTW SEA when taken on the descriptor PA

Ah, IIUC, you are saying even if the FSC code tells fault is on TTW
(esr_fsc_is_secc_ttw or esr_fsc_is_sea_ttw), it can either be guest
stage-1's or stage-2's descriptor PA, and we can tell which from
which.

However, if ESR_ELx_S1PTW is set, we can tell this is a sub-case of
stage-2 descriptor PA, their usage is for stage-1 PTW but they are
stage-2 memory.

Is my current understanding right?

>
>  - Explicitly handle SEAs due to VNCR (I have a separate prereq patch)
>
> From aac0bb8f90c43b5b17c3b4e50379cb8ca828812c Mon Sep 17 00:00:00 2001
> From: Jiaqi Yan <jiaqiyan@google.com>
> Date: Wed, 4 Jun 2025 05:08:56 +0000
> Subject: [PATCH] KVM: arm64: VM exit to userspace to handle SEA
>
> When APEI fails to handle a stage-2 synchronous external abort (SEA),
> today KVM directly injects an async SError to the VCPU then resumes it,
> which usually results in unpleasant guest kernel panic.
>
> One major situation of guest SEA is when vCPU consumes recoverable
> uncorrected memory error (UER). Although SError and guest kernel panic
> effectively stops the propagation of corrupted memory, there is room
> to recover from an UER in a more graceful manner.
>
> Alternatively KVM can redirect the synchronous SEA event to VMM to
> - Reduce blast radius if possible. VMM can inject a SEA to VCPU via
>   KVM's existing KVM_SET_VCPU_EVENTS API. If the memory poison
>   consumption or fault is not from guest kernel, blast radius can be
>   limited to the triggering thread in guest userspace, so VM can
>   keep running.
> - VMM can protect from future memory poison consumption by unmapping
>   the page from stage-2, or interrupt guest of the poisoned guest page
>   so guest kernel can unmap it from stage-1.
> - VMM can also track SEA events that VM customers care about, restart
>   VM when certain number of distinct poison events have happened,
>   provide observability to customers in log management UI.
>
> Introduce an userspace-visible feature to enable VMM to handle SEA:
> - KVM_CAP_ARM_SEA_TO_USER. As the alternative fallback behavior
>   when host APEI fails to claim a SEA, userspace can opt in this new
>   capability to let KVM exit to userspace during SEA if it is not
>   caused by access on memory of stage-2 translation table.
> - KVM_EXIT_ARM_SEA. A new exit reason is introduced for this.
>   KVM fills kvm_run.arm_sea with as much as possible information about
>   the SEA, enabling VMM to emulate SEA to guest by itself.
>   - Sanitized ESR_EL2. The general rule is to keep only the bits
>     useful for userspace and relevant to guest memory. See code
>     comments for why bits are hidden/reported.
>   - If faulting guest virtual and physical addresses are available.
>   - Faulting guest virtual address if available.
>   - Faulting guest physical address if available.
>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> Link: https://lore.kernel.org/r/20250604050902.3944054-2-jiaqiyan@google.=
com
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  arch/arm64/include/asm/kvm_host.h |  2 +
>  arch/arm64/kvm/arm.c              |  5 +++
>  arch/arm64/kvm/mmu.c              | 67 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/kvm.h          | 10 +++++
>  4 files changed, 83 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/k=
vm_host.h
> index e54d29feb469..98ce2d58ac8d 100644
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
> index 7a1a8210ff91..aec6034db1e7 100644
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
> index a34924d75069..26b2e71994be 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1813,8 +1813,48 @@ static void handle_access_fault(struct kvm_vcpu *v=
cpu, phys_addr_t fault_ipa)
>         read_unlock(&vcpu->kvm->mmu_lock);
>  }
>
> +/*
> + * Returns true if the SEA should be handled locally within KVM if the a=
bort is
> + * caused by a kernel memory allocation (e.g. stage-2 table memory).
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
> +        * Determining if an external abort during a table walk happened =
at
> +        * stage-2 is only possible with S1PTW is set. Otherwise, since K=
VM
> +        * sets HCR_EL2.TEA, SEAs due to a stage-1 walk (i.e. accessing t=
he PA
> +        * of the stage-1 descriptor) can reach here and are reported wit=
h a
> +        * TTW ESR value.
> +        */
> +       return esr_fsc_is_sea_ttw(esr) && (esr & ESR_ELx_S1PTW);

Should we include esr_fsc_is_secc_ttw? like
  (esr_fsc_is_sea_ttw(esr) || esr_fsc_is_secc_ttw(esr)) && (esr & ESR_ELx_S=
1PTW)

> +}
> +
>  int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>  {
> +       u64 esr =3D kvm_vcpu_get_esr(vcpu);
> +       struct kvm_run *run =3D vcpu->run;
> +       struct kvm *kvm =3D vcpu->kvm;
> +       u64 esr_mask =3D ESR_ELx_EC_MASK  |
> +                      ESR_ELx_FnV      |
> +                      ESR_ELx_EA       |
> +                      ESR_ELx_CM       |
> +                      ESR_ELx_WNR      |
> +                      ESR_ELx_FSC;

Do you (and why) exclude ESR_ELx_IL on purpose?

BTW, if my previous statement about TTW SEA is correct, then I also
understand why we need to explicitly exclude ESR_ELx_S1PTW.

> +       u64 ipa;
> +
> +
>         /*
>          * Give APEI the opportunity to claim the abort before handling i=
t
>          * within KVM. apei_claim_sea() expects to be called with IRQs
> @@ -1824,7 +1864,32 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>         if (apei_claim_sea(NULL) =3D=3D 0)

I assume kvm should still lockdep_assert_irqs_enabled(), right? That
is, a WARN_ON_ONCE is still useful in case?


>                 return 1;
>
> -       return kvm_inject_serror(vcpu);
> +       if (host_owns_sea(vcpu, esr) || !test_bit(KVM_ARCH_FLAG_EXIT_SEA,=
 &kvm->arch.flags))
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
> +        * writing to FAR_EL1 and HPFAR_EL1 registers.
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
> index e4e566ff348b..b2cc3d74d769 100644
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
> 2.39.5

