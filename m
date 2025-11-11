Return-Path: <linux-kselftest+bounces-45369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEECC500F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 00:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25F2A4E1803
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7852F39A4;
	Tue, 11 Nov 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zyBh4dcx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E135CBC6
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903946; cv=none; b=muuWwXm8HNNfGuTx9dQ7BQU2fV5OEcaJVaJ1LcMnuc3aFnktoIdG/ivaLZwujROn8sT7MmYicgTo7PmUBXbXafZA91njuRXaPc7XsvGrUeCjCOW8mONtdwCntYvbmsRKnFbJupLR4e33UaG3+AhZyO2mT9jEF7FbaWFTC1bkZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903946; c=relaxed/simple;
	bh=JjX9POR99X3WO8seBV4smfP/yFiulAv2T8J9krlcaG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+R9dbY3FtZeHwSdkeX9adVkRIXQj+dYUIYOf1q9O4R/sly3pKNTYyGCdouDVkV7OhuonuHfgVXEsuHTDYv2pgS2L/fyfrK2XzV5NnDXGxv1d6SMIqnKHN2XJ8C2l6F9TWb/l2ESx95hxuNyKDo2qsvfN9Fu0KRLxfHiBQLfP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zyBh4dcx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47777136777so17575e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 15:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762903943; x=1763508743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfSphR+3zkc3ca5t+ekeHVOKX60kamodZsUsUQPEe+8=;
        b=zyBh4dcxJ01scHduHnb8os9MhBZywHRHbf4VA6Pg9sKToqdNyitgbleQLG4PkrVjOB
         r1KmjPuWIVTWeBBsXT2zBhHbC9Y2WG976ZJ5nHDCwioo3g79rUkOD8StGQBmOgrwLILK
         YZuCw3Z9p98rWWzSLzyNcupYWx6jNRhnPvSNRze+rYkL1z8ugatxxUwKVjVMqnRRUbP7
         GprOSJ2nZzXI6UGilJwevqyXo7tPvWCxAkol9cQAZuUkpd0l5sH0raAoCblIaMIlmcgl
         FBROGqAGgmSrY9AHGapHoIYt5ebE7Rda4J8NDsHQss8RbzFCud4sAg5hD6sH9TMg2wFf
         iwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762903943; x=1763508743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DfSphR+3zkc3ca5t+ekeHVOKX60kamodZsUsUQPEe+8=;
        b=VJTd7yfpM90uN1+dXyPqRKDUWv+3K2cgyoSBiR0/ldMWfdWHAH6viyQvu6zP5F2jLt
         uAG9ImuEM/ZPIDtDKgJH393wrj/L9v3KsLhfJMO01JNx46yxt1pHCrndiSSkosNDBOS6
         sWd2JnKXzMuF5xzWUx5HwAZyd4f5gv6RK1GK4SXTasznzBQ9ZUsXYBoNoSY1/tL+xsuQ
         qs4F67AEgnVjxhZxXijjK0jBK5h2O6dywLmU1lcAEvcUvzeg92cVcs2gCgnXPVMnM9FG
         NnQXsMMDeK4Nrhij6qdUQn59VVDBIEAV0hG43pozkg9ZrAEvEwI4cjlVwOG9MfeDWJiZ
         YlxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7hpWNbRRq8DxRgpwyVcp/MjtsQYgQEHt2GZnepjzBedsR7DnmNW2bOkZuCW8zX3/3ffQAdsKSmk74U0uvr2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhohLGvJghlF9ZrEcGHNVKHMf9nZffE6epPwo/1Sa/tDlEqqZ
	/hAcSrFKrBu4D8xYGNez+du45NlOoOfuNA7+WMWGvZCkj8u5B1BSbCSqWsr2cG6orYGnrrsinKf
	jJhPeyTp+l21r0FQnPZjD51w4eqv0DEA/Y8uRcohC
X-Gm-Gg: ASbGncuOkD3KaZuEhCPz2ygBabI1eoDRAWWA8wL3dqARMU0VxdHyyAEd5SzHFvBttyi
	BnZkVMWdt10i0kDF60EKZg0uNGMtTAEkq/0YOiFO3Vc+0EniKcBM5PI68QswCTjkMJQAqTYQdJI
	kPCB0fnQYbyOQVmrVo5sOh4vn0bNk2d4GncWvpORC7eAtzEl0g2vejBc4KBGQEcej6+CdWV020p
	B+dAJ5kh8MGTKZ0fWciLS2l0cXP3gQZ6clut/x7Ne5gTMhR+/w3h1rnLthvXN1kR2L3J19986eD
	qSGOz4+4iWMT/DQ+DiJQUcPaLA==
X-Google-Smtp-Source: AGHT+IEFVyoAcKs88ZinjKACl2in26RA2Ulg4hwVbiPwjRL/ixynji4/f1TVt67UUXxDpe/cHBTPN/6zNnOi8MU74rE=
X-Received: by 2002:a05:600c:4f50:b0:477:73f4:26b with SMTP id
 5b1f17b1804b1-47787e10f86mr299925e9.3.1762903942551; Tue, 11 Nov 2025
 15:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013185903.1372553-1-jiaqiyan@google.com> <20251013185903.1372553-2-jiaqiyan@google.com>
 <7a61bcf9-a57d-a8e9-a9b8-4eacef80acd3@arm.com> <CACw3F51_0A8CuCgzcvoA3Db=Wxo8mm5XZw5in+nTKrst+NCcqw@mail.gmail.com>
 <aRMHfS1-K4E4UCbc@kernel.org>
In-Reply-To: <aRMHfS1-K4E4UCbc@kernel.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 11 Nov 2025 15:32:10 -0800
X-Gm-Features: AWmQ_bnzli5IDq508gd9gl_I2k2ye51PrgqB8PlLzeSpUSiMz9YXG-gXISoy5Ow
Message-ID: <CACw3F51x4sxwSm0ZGeO-Mk3Q3b7iwY-9cnxCveXkc6MF5RGnyA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] KVM: arm64: VM exit to userspace to handle SEA
To: Oliver Upton <oupton@kernel.org>, Jose Marinho <jose.marinho@arm.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, duenwen@google.com, 
	rananta@google.com, jthoughton@google.com, vsethi@nvidia.com, jgg@nvidia.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 1:53=E2=80=AFAM Oliver Upton <oupton@kernel.org> wr=
ote:
>
> Hi Jiaqi,
>
> On Mon, Nov 03, 2025 at 12:45:50PM -0800, Jiaqi Yan wrote:
> > On Mon, Nov 3, 2025 at 10:17=E2=80=AFAM Jose Marinho <jose.marinho@arm.=
com> wrote:
> > >
> > > Thank you for these patches.
> >
> > Thanks for your comments, Jose!
> >
> > >
> > > On 10/13/2025 7:59 PM, Jiaqi Yan wrote:
> > > > When APEI fails to handle a stage-2 synchronous external abort (SEA=
),
> > > > today KVM injects an asynchronous SError to the VCPU then resumes i=
t,
> > > > which usually results in unpleasant guest kernel panic.
> > > >
> > > > One major situation of guest SEA is when vCPU consumes recoverable
> > > > uncorrected memory error (UER). Although SError and guest kernel pa=
nic
> > > > effectively stops the propagation of corrupted memory, guest may
> > > > re-use the corrupted memory if auto-rebooted; in worse case, guest
> > > > boot may run into poisoned memory. So there is room to recover from
> > > > an UER in a more graceful manner.
> > > >
> > > > Alternatively KVM can redirect the synchronous SEA event to VMM to
> > > > - Reduce blast radius if possible. VMM can inject a SEA to VCPU via
> > > >    KVM's existing KVM_SET_VCPU_EVENTS API. If the memory poison
> > > >    consumption or fault is not from guest kernel, blast radius can =
be
> > > >    limited to the triggering thread in guest userspace, so VM can
> > > >    keep running.
> > > > - Allow VMM to protect from future memory poison consumption by
> > > >    unmapping the page from stage-2, or to interrupt guest of the
> > > >    poisoned page so guest kernel can unmap it from stage-1 page tab=
le.
> > > > - Allow VMM to track SEA events that VM customers care about, to re=
start
> > > >    VM when certain number of distinct poison events have happened,
> > > >    to provide observability to customers in log management UI.
> > > >
> > > > Introduce an userspace-visible feature to enable VMM handle SEA:
> > > > - KVM_CAP_ARM_SEA_TO_USER. As the alternative fallback behavior
> > > >    when host APEI fails to claim a SEA, userspace can opt in this n=
ew
> > > >    capability to let KVM exit to userspace during SEA if it is not
> > > >    owned by host.
> > > > - KVM_EXIT_ARM_SEA. A new exit reason is introduced for this.
> > > >    KVM fills kvm_run.arm_sea with as much as possible information a=
bout
> > > >    the SEA, enabling VMM to emulate SEA to guest by itself.
> > > >    - Sanitized ESR_EL2. The general rule is to keep only the bits
> > > >      useful for userspace and relevant to guest memory.
> > > >    - Flags indicating if faulting guest physical address is valid.
> > > >    - Faulting guest physical and virtual addresses if valid.
> > > >
> > > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > > Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
> > > > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > > > ---
> > > >   arch/arm64/include/asm/kvm_host.h |  2 +
> > > >   arch/arm64/kvm/arm.c              |  5 +++
> > > >   arch/arm64/kvm/mmu.c              | 68 ++++++++++++++++++++++++++=
++++-
> > > >   include/uapi/linux/kvm.h          | 10 +++++
> > > >   4 files changed, 84 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include=
/asm/kvm_host.h
> > > > index b763293281c88..e2c65b14e60c4 100644
> > > > --- a/arch/arm64/include/asm/kvm_host.h
> > > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > > @@ -350,6 +350,8 @@ struct kvm_arch {
> > > >   #define KVM_ARCH_FLAG_GUEST_HAS_SVE                 9
> > > >       /* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from users=
pace */
> > > >   #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS          10
> > > > +     /* Unhandled SEAs are taken to userspace */
> > > > +#define KVM_ARCH_FLAG_EXIT_SEA                               11
> > > >       unsigned long flags;
> > > >
> > > >       /* VM-wide vCPU feature set */
> > > > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > > > index f21d1b7f20f8e..888600df79c40 100644
> > > > --- a/arch/arm64/kvm/arm.c
> > > > +++ b/arch/arm64/kvm/arm.c
> > > > @@ -132,6 +132,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> > > >               }
> > > >               mutex_unlock(&kvm->lock);
> > > >               break;
> > > > +     case KVM_CAP_ARM_SEA_TO_USER:
> > > > +             r =3D 0;
> > > > +             set_bit(KVM_ARCH_FLAG_EXIT_SEA, &kvm->arch.flags);
> > > > +             break;
> > > >       default:
> > > >               break;
> > > >       }
> > > > @@ -327,6 +331,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kv=
m, long ext)
> > > >       case KVM_CAP_IRQFD_RESAMPLE:
> > > >       case KVM_CAP_COUNTER_OFFSET:
> > > >       case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
> > > > +     case KVM_CAP_ARM_SEA_TO_USER:
> > > >               r =3D 1;
> > > >               break;
> > > >       case KVM_CAP_SET_GUEST_DEBUG2:
> > > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > > > index 7cc964af8d305..09210b6ab3907 100644
> > > > --- a/arch/arm64/kvm/mmu.c
> > > > +++ b/arch/arm64/kvm/mmu.c
> > > > @@ -1899,8 +1899,48 @@ static void handle_access_fault(struct kvm_v=
cpu *vcpu, phys_addr_t fault_ipa)
> > > >       read_unlock(&vcpu->kvm->mmu_lock);
> > > >   }
> > > >
> > > > +/*
> > > > + * Returns true if the SEA should be handled locally within KVM if=
 the abort
> > > > + * is caused by a kernel memory allocation (e.g. stage-2 table mem=
ory).
> > > > + */
> > > > +static bool host_owns_sea(struct kvm_vcpu *vcpu, u64 esr)
> > > > +{
> > > > +     /*
> > > > +      * Without FEAT_RAS HCR_EL2.TEA is RES0, meaning any external=
 abort
> > > > +      * taken from a guest EL to EL2 is due to a host-imposed acce=
ss (e.g.
> > > > +      * stage-2 PTW).
> > > > +      */
> > > > +     if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
> > > > +             return true;
> > > > +
> > > > +     /* KVM owns the VNCR when the vCPU isn't in a nested context.=
 */
> > > > +     if (is_hyp_ctxt(vcpu) && (esr & ESR_ELx_VNCR))
> > > Is this check valid only for a "Data Abort"?
> >
> > Yes, the VNCR bit is specific to a Data Abort (provided we can only
> > reach host_owns_sea if kvm_vcpu_abt_issea).
> > I don't think we need to explicitly exclude the check here for
> > Instruction Abort.
>
> You can take an external abort on an instruction fetch, in which case
> bit 13 of the ISS (VNCR bit for data abort) is RES0. So this does need
> to check for a data abort.

Agreed and thanks for correcting me, Oliver! I will fix this in v5.

>
> Thanks,
> Oliver

