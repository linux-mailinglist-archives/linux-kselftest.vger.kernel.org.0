Return-Path: <linux-kselftest+bounces-44678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B8C2E0E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 21:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCEC334B6AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 20:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC32C11E2;
	Mon,  3 Nov 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIPDfEoV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4142C0F67
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202766; cv=none; b=Jv5znYCpKh+tGZtln+52THQP8ieY9Eo4KceIdZkdOLtP9FQA3kF/YrQI7yU/BC87NGgE5ewIWAJaFbcRXgS/daZhP0sCO1/biv7vyipZkZu62HGwCuj9chT25BATScvIZsIZdyrS3+GPGqa0Dtq9Gmi8q36QcGD0gJkpBsMahd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202766; c=relaxed/simple;
	bh=78VVdJBIjH7DUWFrqgAJg5hmrAaLyzBHn4nSy26ktbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDFDASOVfrgS+3LibEhD0lRFjlXwsmLg8D2eG+AsushzFqjuZZtC27pxFHU+8OtrC9MoBU7go5J8cHzLVvqRVOSJjiPJDZsmmncplOY7AoXbJ0agQMUhEGbY6kRAD8PoESARPGWGx7oIvCJwUVPMk9OSUsnSPYn9YIAcMYMdig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIPDfEoV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47105bbb8d9so2045e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Nov 2025 12:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762202762; x=1762807562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFLQG05yxnGeCUjCRezA06BGBQoij7YwrxYVw5ACcfo=;
        b=wIPDfEoV5fT8DZeaMjcFiC6rE8jsFG6tyN4iSMR1FR+5C45Bc5dqRHpH5fFKo5ACf0
         pfyGWIUhEYdI92md0KtpyGztW1Bs9cRP8Q9jzXm76ZF2qkWYE/9d4p0E/jA2sGpR7knE
         tAtt3VmKjN8/rllfIzxiyLKmEe9yPa+27BlFR2DleMdmUP5gZZBv3g5THjqJVMphQ5G0
         VriDMyMCpQto1XJtZCyRRgYf6uMlxVHcEdxTFu3CVeePg5db/OdgP3Vgp3w2i2tn+l36
         03WtFAkiTPK0oIoH6zwEaQUQAZ725h/yza7GDhCIHRbK3nbOSa8GGTU9afSSrRJopxG/
         mTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762202762; x=1762807562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFLQG05yxnGeCUjCRezA06BGBQoij7YwrxYVw5ACcfo=;
        b=Fhp5XiT0th2crgTukyU/Udr/cEwRmqoO/0MJbyR53J2fPY5mjVIgRAE9wFXKqmE/T2
         WO1pTTSI9y19+xjYWJPE35LAC6s76Tx6MGd3Izx+fRjC4JgA7Syw4myIyKMZwObRAdJF
         dhjROVZa3Mt3h80Fvw6tjxX7br4ykDd+y7RueZyWTds/XHgjtltXQsAAoz6/m/RFjcsF
         p7sDVYvTqb2BVY3cJXZEfygDOlH4vua4ysBvlNp44U6ykV+E4BK7M1z7ED1+DOP3Uore
         txjYN9AniIdAFPnEH4y4iihATfDW7uPCAmNFI8+7I80MIgyU2aTv5c/mvlztD+IecY/D
         /F2g==
X-Forwarded-Encrypted: i=1; AJvYcCX9cOOFH/c9vXU8oSOKKAkYENKIqSl94QmMpq2+bgcSa9rVN1LR1SrWY4vST35qIIzNZI5NLlvC7JYeraEmlOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8Fi2ICVgTlIy9+YT7Waquny/uMDXAQf8NxXOuxEE8SWMRv0q
	aWC4drF9oXaR4Qbckagu/HHVwQvT4wqbiP92Gif5p1DFQx3Ze1B5J6DS6EwgaQ39sGBow2le+cP
	AXApisPrn+vr7T/VSDCMFE6IH7qUN6Xgmv6bWEIHS
X-Gm-Gg: ASbGncvg3xZd31vpCVXjvf/j5xxBLt6zkvwEs5Y9lIw77O+61bM3qrpuNxX6B8jqFMZ
	TFm3Qa+Zg4htdb/Dr3PsbtLmJqr/RSuXfkGsbP5D7yCcxzg32EecNGHfC5p6tc3j8ZPXZk6ufB0
	e/4gcWm8k9QCYRW0XPmYUwBzMb4+flqz/IOBMRz0iobeyy5qWCdEPbeu9LTDm6RmToh4BwPH5qu
	uE1qLB9wNMnqdSuZlNxMXrN2DVOJscxgdQnav6FPA2wudzgrdBwOUs7zuGruk/H+N1jrXHSWyuU
	UfKWd01k6Janrw==
X-Google-Smtp-Source: AGHT+IG9oVCZDDY5MyOKgKW4xlI1Oc/GPLlunrZYyxDoj2qoI35Mip7UpVZjaQGJTHznRiF6HsyMfkM02zJ0rlqdzwI=
X-Received: by 2002:a05:600c:21ce:b0:475:da0c:38a8 with SMTP id
 5b1f17b1804b1-47754f81696mr407755e9.4.1762202761807; Mon, 03 Nov 2025
 12:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013185903.1372553-1-jiaqiyan@google.com> <20251013185903.1372553-2-jiaqiyan@google.com>
 <7a61bcf9-a57d-a8e9-a9b8-4eacef80acd3@arm.com>
In-Reply-To: <7a61bcf9-a57d-a8e9-a9b8-4eacef80acd3@arm.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 3 Nov 2025 12:45:50 -0800
X-Gm-Features: AWmQ_bn3UtOS-iQBnGW8DyhNypxqDQ3vgsdMl2IVI_yUyITm8YFcPAhNl3XpHT4
Message-ID: <CACw3F51_0A8CuCgzcvoA3Db=Wxo8mm5XZw5in+nTKrst+NCcqw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] KVM: arm64: VM exit to userspace to handle SEA
To: Jose Marinho <jose.marinho@arm.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, duenwen@google.com, 
	rananta@google.com, jthoughton@google.com, vsethi@nvidia.com, jgg@nvidia.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 10:17=E2=80=AFAM Jose Marinho <jose.marinho@arm.com>=
 wrote:
>
> Thank you for these patches.

Thanks for your comments, Jose!

>
> On 10/13/2025 7:59 PM, Jiaqi Yan wrote:
> > When APEI fails to handle a stage-2 synchronous external abort (SEA),
> > today KVM injects an asynchronous SError to the VCPU then resumes it,
> > which usually results in unpleasant guest kernel panic.
> >
> > One major situation of guest SEA is when vCPU consumes recoverable
> > uncorrected memory error (UER). Although SError and guest kernel panic
> > effectively stops the propagation of corrupted memory, guest may
> > re-use the corrupted memory if auto-rebooted; in worse case, guest
> > boot may run into poisoned memory. So there is room to recover from
> > an UER in a more graceful manner.
> >
> > Alternatively KVM can redirect the synchronous SEA event to VMM to
> > - Reduce blast radius if possible. VMM can inject a SEA to VCPU via
> >    KVM's existing KVM_SET_VCPU_EVENTS API. If the memory poison
> >    consumption or fault is not from guest kernel, blast radius can be
> >    limited to the triggering thread in guest userspace, so VM can
> >    keep running.
> > - Allow VMM to protect from future memory poison consumption by
> >    unmapping the page from stage-2, or to interrupt guest of the
> >    poisoned page so guest kernel can unmap it from stage-1 page table.
> > - Allow VMM to track SEA events that VM customers care about, to restar=
t
> >    VM when certain number of distinct poison events have happened,
> >    to provide observability to customers in log management UI.
> >
> > Introduce an userspace-visible feature to enable VMM handle SEA:
> > - KVM_CAP_ARM_SEA_TO_USER. As the alternative fallback behavior
> >    when host APEI fails to claim a SEA, userspace can opt in this new
> >    capability to let KVM exit to userspace during SEA if it is not
> >    owned by host.
> > - KVM_EXIT_ARM_SEA. A new exit reason is introduced for this.
> >    KVM fills kvm_run.arm_sea with as much as possible information about
> >    the SEA, enabling VMM to emulate SEA to guest by itself.
> >    - Sanitized ESR_EL2. The general rule is to keep only the bits
> >      useful for userspace and relevant to guest memory.
> >    - Flags indicating if faulting guest physical address is valid.
> >    - Faulting guest physical and virtual addresses if valid.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> >   arch/arm64/include/asm/kvm_host.h |  2 +
> >   arch/arm64/kvm/arm.c              |  5 +++
> >   arch/arm64/kvm/mmu.c              | 68 ++++++++++++++++++++++++++++++=
-
> >   include/uapi/linux/kvm.h          | 10 +++++
> >   4 files changed, 84 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm=
/kvm_host.h
> > index b763293281c88..e2c65b14e60c4 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -350,6 +350,8 @@ struct kvm_arch {
> >   #define KVM_ARCH_FLAG_GUEST_HAS_SVE                 9
> >       /* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace=
 */
> >   #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS          10
> > +     /* Unhandled SEAs are taken to userspace */
> > +#define KVM_ARCH_FLAG_EXIT_SEA                               11
> >       unsigned long flags;
> >
> >       /* VM-wide vCPU feature set */
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index f21d1b7f20f8e..888600df79c40 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -132,6 +132,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> >               }
> >               mutex_unlock(&kvm->lock);
> >               break;
> > +     case KVM_CAP_ARM_SEA_TO_USER:
> > +             r =3D 0;
> > +             set_bit(KVM_ARCH_FLAG_EXIT_SEA, &kvm->arch.flags);
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -327,6 +331,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
> >       case KVM_CAP_IRQFD_RESAMPLE:
> >       case KVM_CAP_COUNTER_OFFSET:
> >       case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
> > +     case KVM_CAP_ARM_SEA_TO_USER:
> >               r =3D 1;
> >               break;
> >       case KVM_CAP_SET_GUEST_DEBUG2:
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 7cc964af8d305..09210b6ab3907 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -1899,8 +1899,48 @@ static void handle_access_fault(struct kvm_vcpu =
*vcpu, phys_addr_t fault_ipa)
> >       read_unlock(&vcpu->kvm->mmu_lock);
> >   }
> >
> > +/*
> > + * Returns true if the SEA should be handled locally within KVM if the=
 abort
> > + * is caused by a kernel memory allocation (e.g. stage-2 table memory)=
.
> > + */
> > +static bool host_owns_sea(struct kvm_vcpu *vcpu, u64 esr)
> > +{
> > +     /*
> > +      * Without FEAT_RAS HCR_EL2.TEA is RES0, meaning any external abo=
rt
> > +      * taken from a guest EL to EL2 is due to a host-imposed access (=
e.g.
> > +      * stage-2 PTW).
> > +      */
> > +     if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
> > +             return true;
> > +
> > +     /* KVM owns the VNCR when the vCPU isn't in a nested context. */
> > +     if (is_hyp_ctxt(vcpu) && (esr & ESR_ELx_VNCR))
> Is this check valid only for a "Data Abort"?

Yes, the VNCR bit is specific to a Data Abort (provided we can only
reach host_owns_sea if kvm_vcpu_abt_issea).
I don't think we need to explicitly exclude the check here for
Instruction Abort.

> > +             return true;
> > +
> > +     /*
> > +      * Determine if an external abort during a table walk happened at
> > +      * stage-2 is only possible with S1PTW is set. Otherwise, since K=
VM
> nit: Is the first sentence correct?

Oh, it should be "Determining ...".

>
> > +      * sets HCR_EL2.TEA, SEAs due to a stage-1 walk (i.e. accessing t=
he
> > +      * PA of the stage-1 descriptor) can reach here and are reported
> > +      * with a TTW ESR value.
> > +      */
> > +     return (esr_fsc_is_sea_ttw(esr) && (esr & ESR_ELx_S1PTW));
> > +}
> > +
> >   int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
> >   {
> > +     struct kvm *kvm =3D vcpu->kvm;
> > +     struct kvm_run *run =3D vcpu->run;
> > +     u64 esr =3D kvm_vcpu_get_esr(vcpu);
> > +     u64 esr_mask =3D ESR_ELx_EC_MASK  |
> > +                    ESR_ELx_IL       |
> > +                    ESR_ELx_FnV      |
> > +                    ESR_ELx_EA       |
> > +                    ESR_ELx_CM       |
> > +                    ESR_ELx_WNR      |
> > +                    ESR_ELx_FSC;
> > +     u64 ipa;
> > +
> >       /*
> >        * Give APEI the opportunity to claim the abort before handling i=
t
> >        * within KVM. apei_claim_sea() expects to be called with IRQs en=
abled.
> > @@ -1909,7 +1949,33 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
> >       if (apei_claim_sea(NULL) =3D=3D 0)
> >               return 1;
> >
> > -     return kvm_inject_serror(vcpu);
> > +     if (host_owns_sea(vcpu, esr) ||
> > +         !test_bit(KVM_ARCH_FLAG_EXIT_SEA, &vcpu->kvm->arch.flags))
> > +             return kvm_inject_serror(vcpu);
> > +
> > +     /* ESR_ELx.SET is RES0 when FEAT_RAS isn't implemented. */
> > +     if (kvm_has_ras(kvm))
> > +             esr_mask |=3D ESR_ELx_SET_MASK;
> > +
> > +     /*
> > +      * Exit to userspace, and provide faulting guest virtual and phys=
ical
> > +      * addresses in case userspace wants to emulate SEA to guest by
> > +      * writing to FAR_ELx and HPFAR_ELx registers.
> > +      */
> > +     memset(&run->arm_sea, 0, sizeof(run->arm_sea));
> > +     run->exit_reason =3D KVM_EXIT_ARM_SEA;
> > +     run->arm_sea.esr =3D esr & esr_mask;
> > +
> > +     if (!(esr & ESR_ELx_FnV))
> > +             run->arm_sea.gva =3D kvm_vcpu_get_hfar(vcpu) > +
> > +     ipa =3D kvm_vcpu_get_fault_ipa(vcpu);
> > +     if (ipa !=3D INVALID_GPA) {
> > +             run->arm_sea.flags |=3D KVM_EXIT_ARM_SEA_FLAG_GPA_VALID;
> > +             run->arm_sea.gpa =3D ipa;
>
> Are we interested in the value of PFAR_EL2 (if FEAT_PFAR implemented)?

I don't think userspace (VMM) or the guest would need or make any use
of the physical memory address. I believe host physical address in
general should be hidden from userspace process.

Completely off-topic: if FEAT_PFAR is implemented, I would propose EL3
RAS to implement something below so that host APEI can claim the SEA:
1. Triage the SEA to determine if it has to be handled in place, or
should it be redirected to lower EL2.
2. If SEA should be redirected to EL2, craft a memory error CPER that
contains a valid physical memory address.
3. When redirect a SEA to EL2, also populate it to host APEI GHES.

This way, memory error caused SEA can properly trigger the normal
memory_failure routine provided by host kernel, instead of handled as
an exception without memory error context by KVM.

> I believe kvm_vcpu_get_fault_ipa gets the HPFAR_EL2, which is valid for
> S2 translation and GPC faults, but unknown for other cases.

You are absolutely right that HPFAR_EL2 register is unknown for SEA.
However, thanks to Oliver [1] KVM now performs a FAR to HPFAR address
translation (__translate_far_to_hpfar) for certain SEA cases (see
__fault_safe_to_translate), and stores the translation status +
results in vcpu->arch.fault. These SEA cases are returned to userspace
in this patchset.

[1] https://lore.kernel.org/all/20250402201725.2963645-4-oliver.upton@linux=
.dev.

>
> Jose
>
> > +     }
> > +
> > +     return 0;
> >   }
> >
> >   /**
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 6efa98a57ec11..acc7b3a346992 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -179,6 +179,7 @@ struct kvm_xen_exit {
> >   #define KVM_EXIT_LOONGARCH_IOCSR  38
> >   #define KVM_EXIT_MEMORY_FAULT     39
> >   #define KVM_EXIT_TDX              40
> > +#define KVM_EXIT_ARM_SEA          41
> >
> >   /* For KVM_EXIT_INTERNAL_ERROR */
> >   /* Emulate instruction failed. */
> > @@ -473,6 +474,14 @@ struct kvm_run {
> >                               } setup_event_notify;
> >                       };
> >               } tdx;
> > +             /* KVM_EXIT_ARM_SEA */
> > +             struct {
> > +#define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID      (1ULL << 0)
> > +                     __u64 flags;
> > +                     __u64 esr;
> > +                     __u64 gva;
> > +                     __u64 gpa;
> > +             } arm_sea;
> >               /* Fix the size of the union. */
> >               char padding[256];
> >       };
> > @@ -963,6 +972,7 @@ struct kvm_enable_cap {
> >   #define KVM_CAP_RISCV_MP_STATE_RESET 242
> >   #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
> >   #define KVM_CAP_GUEST_MEMFD_MMAP 244
> > +#define KVM_CAP_ARM_SEA_TO_USER 245
> >
> >   struct kvm_irq_routing_irqchip {
> >       __u32 irqchip;

