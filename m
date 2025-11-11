Return-Path: <linux-kselftest+bounces-45289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2221EC4CC67
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F41118850C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6BF2FC017;
	Tue, 11 Nov 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvyuqpQt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6A2F693E;
	Tue, 11 Nov 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854785; cv=none; b=hzw2xmTIxa5fflCyzOJWy+jUpSPsCJv1fbZP4abdjVSZQ4Rb3HiAcqmmOnqbmsir8m9LiCW07oqngWxsKSeqrFaf1mKdu22IjWMhCZ131VgbpjlC5pw78TzaKhOU3fambxd6GVqn4BmpV/hy6FqnCOjR+ixcLRnbqlTsOp2Tgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854785; c=relaxed/simple;
	bh=iDhbZOal2wnEXBNqtnf0/uj4kQN5h/UJan7jrM1zSwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWqyCd1ukiwZ/Y9yVNcO5TMe0nCnL9DjwdeT5mB44I+fSWJhpPrKoM/++kjjmdlPS6sAHOaf1VXHZgoxXDeu9YFmu9FCP465tjQjw49evYl7NOXzBWiZkDl73MaMyan+OfAjZWbL2FT+z8c2E8sb0u/PAXbNQpb7JAkfXyeqVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvyuqpQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6957AC4CEFB;
	Tue, 11 Nov 2025 09:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854784;
	bh=iDhbZOal2wnEXBNqtnf0/uj4kQN5h/UJan7jrM1zSwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvyuqpQtk0Q6hYQ6gNSeFX8b9Es2msAbN8+gQ0SFGS0il5537frS9ZBNWiJHoWhMo
	 /juDrre53fD9dTCmBTGtcYvSzvKRIm99a8p2VAPszdWXqvkl5TnKQwoPoKNpt3EWTh
	 /LmT97aljg7pGdrpVEb9qkGCbbHMdJGTmadUknN3ZCxt1a/Zb5TP8aAh17YKpJ0mQI
	 XEwcfP2+y/eXt+yWGeugUUAaSizGdaknSm4e+sXB18HNskbOMNygLmjK22XzaM/VVC
	 ZvOhvZOmFvE8mkD2w5qTq+xrEBUw3xIXs3IWLU+4k3ycBvgnFZnhx3dqELNGQIt0Wx
	 W95UyabgI+svg==
Date: Tue, 11 Nov 2025 01:53:01 -0800
From: Oliver Upton <oupton@kernel.org>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Jose Marinho <jose.marinho@arm.com>, maz@kernel.org,
	oliver.upton@linux.dev, duenwen@google.com, rananta@google.com,
	jthoughton@google.com, vsethi@nvidia.com, jgg@nvidia.com,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com,
	corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/3] KVM: arm64: VM exit to userspace to handle SEA
Message-ID: <aRMHfS1-K4E4UCbc@kernel.org>
References: <20251013185903.1372553-1-jiaqiyan@google.com>
 <20251013185903.1372553-2-jiaqiyan@google.com>
 <7a61bcf9-a57d-a8e9-a9b8-4eacef80acd3@arm.com>
 <CACw3F51_0A8CuCgzcvoA3Db=Wxo8mm5XZw5in+nTKrst+NCcqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F51_0A8CuCgzcvoA3Db=Wxo8mm5XZw5in+nTKrst+NCcqw@mail.gmail.com>

Hi Jiaqi,

On Mon, Nov 03, 2025 at 12:45:50PM -0800, Jiaqi Yan wrote:
> On Mon, Nov 3, 2025 at 10:17 AM Jose Marinho <jose.marinho@arm.com> wrote:
> >
> > Thank you for these patches.
> 
> Thanks for your comments, Jose!
> 
> >
> > On 10/13/2025 7:59 PM, Jiaqi Yan wrote:
> > > When APEI fails to handle a stage-2 synchronous external abort (SEA),
> > > today KVM injects an asynchronous SError to the VCPU then resumes it,
> > > which usually results in unpleasant guest kernel panic.
> > >
> > > One major situation of guest SEA is when vCPU consumes recoverable
> > > uncorrected memory error (UER). Although SError and guest kernel panic
> > > effectively stops the propagation of corrupted memory, guest may
> > > re-use the corrupted memory if auto-rebooted; in worse case, guest
> > > boot may run into poisoned memory. So there is room to recover from
> > > an UER in a more graceful manner.
> > >
> > > Alternatively KVM can redirect the synchronous SEA event to VMM to
> > > - Reduce blast radius if possible. VMM can inject a SEA to VCPU via
> > >    KVM's existing KVM_SET_VCPU_EVENTS API. If the memory poison
> > >    consumption or fault is not from guest kernel, blast radius can be
> > >    limited to the triggering thread in guest userspace, so VM can
> > >    keep running.
> > > - Allow VMM to protect from future memory poison consumption by
> > >    unmapping the page from stage-2, or to interrupt guest of the
> > >    poisoned page so guest kernel can unmap it from stage-1 page table.
> > > - Allow VMM to track SEA events that VM customers care about, to restart
> > >    VM when certain number of distinct poison events have happened,
> > >    to provide observability to customers in log management UI.
> > >
> > > Introduce an userspace-visible feature to enable VMM handle SEA:
> > > - KVM_CAP_ARM_SEA_TO_USER. As the alternative fallback behavior
> > >    when host APEI fails to claim a SEA, userspace can opt in this new
> > >    capability to let KVM exit to userspace during SEA if it is not
> > >    owned by host.
> > > - KVM_EXIT_ARM_SEA. A new exit reason is introduced for this.
> > >    KVM fills kvm_run.arm_sea with as much as possible information about
> > >    the SEA, enabling VMM to emulate SEA to guest by itself.
> > >    - Sanitized ESR_EL2. The general rule is to keep only the bits
> > >      useful for userspace and relevant to guest memory.
> > >    - Flags indicating if faulting guest physical address is valid.
> > >    - Faulting guest physical and virtual addresses if valid.
> > >
> > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
> > > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > > ---
> > >   arch/arm64/include/asm/kvm_host.h |  2 +
> > >   arch/arm64/kvm/arm.c              |  5 +++
> > >   arch/arm64/kvm/mmu.c              | 68 ++++++++++++++++++++++++++++++-
> > >   include/uapi/linux/kvm.h          | 10 +++++
> > >   4 files changed, 84 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > index b763293281c88..e2c65b14e60c4 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -350,6 +350,8 @@ struct kvm_arch {
> > >   #define KVM_ARCH_FLAG_GUEST_HAS_SVE                 9
> > >       /* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
> > >   #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS          10
> > > +     /* Unhandled SEAs are taken to userspace */
> > > +#define KVM_ARCH_FLAG_EXIT_SEA                               11
> > >       unsigned long flags;
> > >
> > >       /* VM-wide vCPU feature set */
> > > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > > index f21d1b7f20f8e..888600df79c40 100644
> > > --- a/arch/arm64/kvm/arm.c
> > > +++ b/arch/arm64/kvm/arm.c
> > > @@ -132,6 +132,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> > >               }
> > >               mutex_unlock(&kvm->lock);
> > >               break;
> > > +     case KVM_CAP_ARM_SEA_TO_USER:
> > > +             r = 0;
> > > +             set_bit(KVM_ARCH_FLAG_EXIT_SEA, &kvm->arch.flags);
> > > +             break;
> > >       default:
> > >               break;
> > >       }
> > > @@ -327,6 +331,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> > >       case KVM_CAP_IRQFD_RESAMPLE:
> > >       case KVM_CAP_COUNTER_OFFSET:
> > >       case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
> > > +     case KVM_CAP_ARM_SEA_TO_USER:
> > >               r = 1;
> > >               break;
> > >       case KVM_CAP_SET_GUEST_DEBUG2:
> > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > > index 7cc964af8d305..09210b6ab3907 100644
> > > --- a/arch/arm64/kvm/mmu.c
> > > +++ b/arch/arm64/kvm/mmu.c
> > > @@ -1899,8 +1899,48 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
> > >       read_unlock(&vcpu->kvm->mmu_lock);
> > >   }
> > >
> > > +/*
> > > + * Returns true if the SEA should be handled locally within KVM if the abort
> > > + * is caused by a kernel memory allocation (e.g. stage-2 table memory).
> > > + */
> > > +static bool host_owns_sea(struct kvm_vcpu *vcpu, u64 esr)
> > > +{
> > > +     /*
> > > +      * Without FEAT_RAS HCR_EL2.TEA is RES0, meaning any external abort
> > > +      * taken from a guest EL to EL2 is due to a host-imposed access (e.g.
> > > +      * stage-2 PTW).
> > > +      */
> > > +     if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
> > > +             return true;
> > > +
> > > +     /* KVM owns the VNCR when the vCPU isn't in a nested context. */
> > > +     if (is_hyp_ctxt(vcpu) && (esr & ESR_ELx_VNCR))
> > Is this check valid only for a "Data Abort"?
> 
> Yes, the VNCR bit is specific to a Data Abort (provided we can only
> reach host_owns_sea if kvm_vcpu_abt_issea).
> I don't think we need to explicitly exclude the check here for
> Instruction Abort.

You can take an external abort on an instruction fetch, in which case
bit 13 of the ISS (VNCR bit for data abort) is RES0. So this does need
to check for a data abort.

Thanks,
Oliver

