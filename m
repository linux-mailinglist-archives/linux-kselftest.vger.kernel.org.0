Return-Path: <linux-kselftest+bounces-44677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4665DC2D9F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 19:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513EB3BD1E9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C255F1C8631;
	Mon,  3 Nov 2025 18:17:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4574B2356BE;
	Mon,  3 Nov 2025 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193842; cv=none; b=WFZytedev3Dd3sEbOnBwD/kUD3g84ps7wJB2ixphNDBdWfg6Y8x5RurUDD+wM4w/jOYizdUDiecWd8yYAhAY6xcrYzNr9BO2oE4QoP74kodvh2i216x2jnZcCt2GWHiRhOsknLMINpLT6YnQ+P6kCRg2MBRbqtTj3CaAQr7VzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193842; c=relaxed/simple;
	bh=1413B/LmkHBOP8CRV0SrbGGlj1RsxEbabOQ45tyV+Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMvJposYIOdlJqD0OtL57Y+0Xq5PNs2HVoQrSe7tmsz8LBYxJSwDDXBnM3TUR18U9+m8a5LqjGb/pld1PdOejkg+/bqIcF4SzruR9/dNuPMyabOFhpE/iw7Vu1PcOHhIcBT1cjbV8ekNvIsxPar+fr7+l//GFNx6AoZxwfIaEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E2812A6B;
	Mon,  3 Nov 2025 10:17:10 -0800 (PST)
Received: from [10.57.71.231] (unknown [10.57.71.231])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF8D33F694;
	Mon,  3 Nov 2025 10:17:13 -0800 (PST)
Message-ID: <7a61bcf9-a57d-a8e9-a9b8-4eacef80acd3@arm.com>
Date: Mon, 3 Nov 2025 18:17:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 1/3] KVM: arm64: VM exit to userspace to handle SEA
Content-Language: en-US
To: Jiaqi Yan <jiaqiyan@google.com>, maz@kernel.org, oliver.upton@linux.dev
Cc: duenwen@google.com, rananta@google.com, jthoughton@google.com,
 vsethi@nvidia.com, jgg@nvidia.com, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251013185903.1372553-1-jiaqiyan@google.com>
 <20251013185903.1372553-2-jiaqiyan@google.com>
From: Jose Marinho <jose.marinho@arm.com>
In-Reply-To: <20251013185903.1372553-2-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for these patches.

On 10/13/2025 7:59 PM, Jiaqi Yan wrote:
> When APEI fails to handle a stage-2 synchronous external abort (SEA),
> today KVM injects an asynchronous SError to the VCPU then resumes it,
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
>    KVM's existing KVM_SET_VCPU_EVENTS API. If the memory poison
>    consumption or fault is not from guest kernel, blast radius can be
>    limited to the triggering thread in guest userspace, so VM can
>    keep running.
> - Allow VMM to protect from future memory poison consumption by
>    unmapping the page from stage-2, or to interrupt guest of the
>    poisoned page so guest kernel can unmap it from stage-1 page table.
> - Allow VMM to track SEA events that VM customers care about, to restart
>    VM when certain number of distinct poison events have happened,
>    to provide observability to customers in log management UI.
> 
> Introduce an userspace-visible feature to enable VMM handle SEA:
> - KVM_CAP_ARM_SEA_TO_USER. As the alternative fallback behavior
>    when host APEI fails to claim a SEA, userspace can opt in this new
>    capability to let KVM exit to userspace during SEA if it is not
>    owned by host.
> - KVM_EXIT_ARM_SEA. A new exit reason is introduced for this.
>    KVM fills kvm_run.arm_sea with as much as possible information about
>    the SEA, enabling VMM to emulate SEA to guest by itself.
>    - Sanitized ESR_EL2. The general rule is to keep only the bits
>      useful for userspace and relevant to guest memory.
>    - Flags indicating if faulting guest physical address is valid.
>    - Faulting guest physical and virtual addresses if valid.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>   arch/arm64/include/asm/kvm_host.h |  2 +
>   arch/arm64/kvm/arm.c              |  5 +++
>   arch/arm64/kvm/mmu.c              | 68 ++++++++++++++++++++++++++++++-
>   include/uapi/linux/kvm.h          | 10 +++++
>   4 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index b763293281c88..e2c65b14e60c4 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -350,6 +350,8 @@ struct kvm_arch {
>   #define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
>   	/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
>   #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
> +	/* Unhandled SEAs are taken to userspace */
> +#define KVM_ARCH_FLAG_EXIT_SEA				11
>   	unsigned long flags;
>   
>   	/* VM-wide vCPU feature set */
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index f21d1b7f20f8e..888600df79c40 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -132,6 +132,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>   		}
>   		mutex_unlock(&kvm->lock);
>   		break;
> +	case KVM_CAP_ARM_SEA_TO_USER:
> +		r = 0;
> +		set_bit(KVM_ARCH_FLAG_EXIT_SEA, &kvm->arch.flags);
> +		break;
>   	default:
>   		break;
>   	}
> @@ -327,6 +331,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_IRQFD_RESAMPLE:
>   	case KVM_CAP_COUNTER_OFFSET:
>   	case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
> +	case KVM_CAP_ARM_SEA_TO_USER:
>   		r = 1;
>   		break;
>   	case KVM_CAP_SET_GUEST_DEBUG2:
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 7cc964af8d305..09210b6ab3907 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1899,8 +1899,48 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>   	read_unlock(&vcpu->kvm->mmu_lock);
>   }
>   
> +/*
> + * Returns true if the SEA should be handled locally within KVM if the abort
> + * is caused by a kernel memory allocation (e.g. stage-2 table memory).
> + */
> +static bool host_owns_sea(struct kvm_vcpu *vcpu, u64 esr)
> +{
> +	/*
> +	 * Without FEAT_RAS HCR_EL2.TEA is RES0, meaning any external abort
> +	 * taken from a guest EL to EL2 is due to a host-imposed access (e.g.
> +	 * stage-2 PTW).
> +	 */
> +	if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
> +		return true;
> +
> +	/* KVM owns the VNCR when the vCPU isn't in a nested context. */
> +	if (is_hyp_ctxt(vcpu) && (esr & ESR_ELx_VNCR))
Is this check valid only for a "Data Abort"?
> +		return true;
> +
> +	/*
> +	 * Determine if an external abort during a table walk happened at
> +	 * stage-2 is only possible with S1PTW is set. Otherwise, since KVM
nit: Is the first sentence correct?

> +	 * sets HCR_EL2.TEA, SEAs due to a stage-1 walk (i.e. accessing the
> +	 * PA of the stage-1 descriptor) can reach here and are reported
> +	 * with a TTW ESR value.
> +	 */
> +	return (esr_fsc_is_sea_ttw(esr) && (esr & ESR_ELx_S1PTW));
> +}
> +
>   int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>   {
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_run *run = vcpu->run;
> +	u64 esr = kvm_vcpu_get_esr(vcpu);
> +	u64 esr_mask = ESR_ELx_EC_MASK	|
> +		       ESR_ELx_IL	|
> +		       ESR_ELx_FnV	|
> +		       ESR_ELx_EA	|
> +		       ESR_ELx_CM	|
> +		       ESR_ELx_WNR	|
> +		       ESR_ELx_FSC;
> +	u64 ipa;
> +
>   	/*
>   	 * Give APEI the opportunity to claim the abort before handling it
>   	 * within KVM. apei_claim_sea() expects to be called with IRQs enabled.
> @@ -1909,7 +1949,33 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
>   	if (apei_claim_sea(NULL) == 0)
>   		return 1;
>   
> -	return kvm_inject_serror(vcpu);
> +	if (host_owns_sea(vcpu, esr) ||
> +	    !test_bit(KVM_ARCH_FLAG_EXIT_SEA, &vcpu->kvm->arch.flags))
> +		return kvm_inject_serror(vcpu);
> +
> +	/* ESR_ELx.SET is RES0 when FEAT_RAS isn't implemented. */
> +	if (kvm_has_ras(kvm))
> +		esr_mask |= ESR_ELx_SET_MASK;
> +
> +	/*
> +	 * Exit to userspace, and provide faulting guest virtual and physical
> +	 * addresses in case userspace wants to emulate SEA to guest by
> +	 * writing to FAR_ELx and HPFAR_ELx registers.
> +	 */
> +	memset(&run->arm_sea, 0, sizeof(run->arm_sea));
> +	run->exit_reason = KVM_EXIT_ARM_SEA;
> +	run->arm_sea.esr = esr & esr_mask;
> +
> +	if (!(esr & ESR_ELx_FnV))
> +		run->arm_sea.gva = kvm_vcpu_get_hfar(vcpu) > +
> +	ipa = kvm_vcpu_get_fault_ipa(vcpu);
> +	if (ipa != INVALID_GPA) {
> +		run->arm_sea.flags |= KVM_EXIT_ARM_SEA_FLAG_GPA_VALID;
> +		run->arm_sea.gpa = ipa;

Are we interested in the value of PFAR_EL2 (if FEAT_PFAR implemented)?
I believe kvm_vcpu_get_fault_ipa gets the HPFAR_EL2, which is valid for 
S2 translation and GPC faults, but unknown for other cases.

Jose

> +	}
> +
> +	return 0;
>   }
>   
>   /**
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6efa98a57ec11..acc7b3a346992 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -179,6 +179,7 @@ struct kvm_xen_exit {
>   #define KVM_EXIT_LOONGARCH_IOCSR  38
>   #define KVM_EXIT_MEMORY_FAULT     39
>   #define KVM_EXIT_TDX              40
> +#define KVM_EXIT_ARM_SEA          41
>   
>   /* For KVM_EXIT_INTERNAL_ERROR */
>   /* Emulate instruction failed. */
> @@ -473,6 +474,14 @@ struct kvm_run {
>   				} setup_event_notify;
>   			};
>   		} tdx;
> +		/* KVM_EXIT_ARM_SEA */
> +		struct {
> +#define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID	(1ULL << 0)
> +			__u64 flags;
> +			__u64 esr;
> +			__u64 gva;
> +			__u64 gpa;
> +		} arm_sea;
>   		/* Fix the size of the union. */
>   		char padding[256];
>   	};
> @@ -963,6 +972,7 @@ struct kvm_enable_cap {
>   #define KVM_CAP_RISCV_MP_STATE_RESET 242
>   #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
>   #define KVM_CAP_GUEST_MEMFD_MMAP 244
> +#define KVM_CAP_ARM_SEA_TO_USER 245
>   
>   struct kvm_irq_routing_irqchip {
>   	__u32 irqchip;

