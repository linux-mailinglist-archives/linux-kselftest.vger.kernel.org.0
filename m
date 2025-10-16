Return-Path: <linux-kselftest+bounces-43327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B3BE3D63
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FAA1883F3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790391C84BC;
	Thu, 16 Oct 2025 14:01:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D43146585;
	Thu, 16 Oct 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623281; cv=none; b=PaHj1gA4/YXXKNaEqttTyNXMAsNsJGaJc/FlQR0g38P1VJmeHTN5xDO76zCU4jU2uAS9TMiP1Y+nv0NlCYNRRHZCB9K653iYKFkdMRqPYcNFql2Anj9CaHQWdv4GT7vq5AWcjrT+NQL0Eul7nV6BknuOBcybBrhea+n1xrQRUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623281; c=relaxed/simple;
	bh=589DrFu9KazghOPguQIWPB5Q4KJLDcH3rsDrzmHjzCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMe/CcTWqxKqVvkGR0LGJHdDlk75z4Z5HTZnzZpVMQorKJNGPP+vO69lKFIYZK/XrKfJXJ1q8lCE7YAcnmjkQJXwhP4Mlkr5jzY/G85raMoEp9nMqUP59IrN6DU8UhUUz0frpMRQIBTuLc2HdwljsrY0XtamCrug+ZOd9F6wCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 954AF1688;
	Thu, 16 Oct 2025 07:01:10 -0700 (PDT)
Received: from [10.57.2.131] (unknown [10.57.2.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61C663F738;
	Thu, 16 Oct 2025 07:01:16 -0700 (PDT)
Message-ID: <808b30b8-a85a-4fe3-be49-bf11414cef93@arm.com>
Date: Thu, 16 Oct 2025 15:01:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] KVM: arm64: Add pre_fault_memory implementation
Content-Language: en-GB
To: Jack Thomson <jackabt.amazon@gmail.com>, maz@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com
Cc: joey.gouly@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, isaku.yamahata@intel.com,
 roypat@amazon.co.uk, kalyazin@amazon.co.uk, jackabt@amazon.com
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
 <20251013151502.6679-2-jackabt.amazon@gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251013151502.6679-2-jackabt.amazon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 13/10/2025 16:14, Jack Thomson wrote:
> From: Jack Thomson <jackabt@amazon.com>
> 
> Add kvm_arch_vcpu_pre_fault_memory() for arm64. The implementation hands
> off the stage-2 faulting logic to either gmem_abort() or
> user_mem_abort().
> 
> Add an optional page_size output parameter to user_mem_abort() to
> return the VMA page size, which is needed when pre-faulting.
> 
> Update the documentation to clarify x86 specific behaviour.

Thanks for the patch ! Do we care about faulting beyond the requested 
range ? I understand this doesn't happen for anything that is not
backed by gmem (which might change with hugetlbfs support) or normal
VMs. But for coco VMs this might affect the measurement or even cause
failure in "pre-faulting" because of the extra security checks.
(e.g., trying to fault in twice, because the range is backed by say,
1G page).

Of course these could be addressed via a separate patch, when this
becomes a real requirement.

One way to solve this could be pass on the "pagesize" as the input
parameter which could force the backend to limit the vma_pagesize
that gets used for the stage2 mapping.

> 
> Signed-off-by: Jack Thomson <jackabt@amazon.com>
> ---
>   Documentation/virt/kvm/api.rst |  3 +-
>   arch/arm64/kvm/Kconfig         |  1 +
>   arch/arm64/kvm/arm.c           |  1 +
>   arch/arm64/kvm/mmu.c           | 73 ++++++++++++++++++++++++++++++++--
>   4 files changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index c17a87a0a5ac..9e8cc4eb505d 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6461,7 +6461,8 @@ Errors:
>   KVM_PRE_FAULT_MEMORY populates KVM's stage-2 page tables used to map memory
>   for the current vCPU state.  KVM maps memory as if the vCPU generated a
>   stage-2 read page fault, e.g. faults in memory as needed, but doesn't break
> -CoW.  However, KVM does not mark any newly created stage-2 PTE as Accessed.
> +CoW.  However, on x86, KVM does not mark any newly created stage-2 PTE as
> +Accessed.
>   
>   In the case of confidential VM types where there is an initial set up of
>   private guest memory before the guest is 'finalized'/measured, this ioctl
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index bff62e75d681..1ac0605f86cb 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -25,6 +25,7 @@ menuconfig KVM
>   	select HAVE_KVM_CPU_RELAX_INTERCEPT
>   	select KVM_MMIO
>   	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
> +	select KVM_GENERIC_PRE_FAULT_MEMORY
>   	select KVM_XFER_TO_GUEST_WORK
>   	select KVM_VFIO
>   	select HAVE_KVM_DIRTY_RING_ACQ_REL
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 888f7c7abf54..65654a742864 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -322,6 +322,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_IRQFD_RESAMPLE:
>   	case KVM_CAP_COUNTER_OFFSET:
>   	case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
> +	case KVM_CAP_PRE_FAULT_MEMORY:
>   		r = 1;
>   		break;
>   	case KVM_CAP_SET_GUEST_DEBUG2:
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index a36426ccd9b5..82f122e4b08c 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1597,8 +1597,8 @@ static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   
>   static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   			  struct kvm_s2_trans *nested,
> -			  struct kvm_memory_slot *memslot, unsigned long hva,
> -			  bool fault_is_perm)
> +			  struct kvm_memory_slot *memslot, long *page_size,
> +			  unsigned long hva, bool fault_is_perm)
>   {
>   	int ret = 0;
>   	bool topup_memcache;
> @@ -1871,6 +1871,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   	kvm_release_faultin_page(kvm, page, !!ret, writable);
>   	kvm_fault_unlock(kvm);
>   
> +	if (page_size)
> +		*page_size = vma_pagesize;
> +
>   	/* Mark the page dirty only if the fault is handled successfully */
>   	if (writable && !ret)
>   		mark_page_dirty_in_slot(kvm, memslot, gfn);
> @@ -2069,8 +2072,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>   		ret = gmem_abort(vcpu, fault_ipa, nested, memslot,
>   				 esr_fsc_is_permission_fault(esr));
>   	else
> -		ret = user_mem_abort(vcpu, fault_ipa, nested, memslot, hva,
> -				     esr_fsc_is_permission_fault(esr));
> +		ret = user_mem_abort(vcpu, fault_ipa, nested, memslot, NULL,
> +				     hva, esr_fsc_is_permission_fault(esr));
>   	if (ret == 0)
>   		ret = 1;
>   out:
> @@ -2446,3 +2449,65 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
>   
>   	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
>   }
> +
> +long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
> +				    struct kvm_pre_fault_memory *range)
> +{
> +	int ret, idx;
> +	hva_t hva;
> +	phys_addr_t end;
> +	struct kvm_memory_slot *memslot;
> +	struct kvm_vcpu_fault_info stored_fault, *fault_info;
> +
> +	long page_size = PAGE_SIZE;
> +	phys_addr_t ipa = range->gpa;
> +	gfn_t gfn = gpa_to_gfn(range->gpa);
> +
> +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> +
> +	if (ipa >= kvm_phys_size(vcpu->arch.hw_mmu)) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	memslot = gfn_to_memslot(vcpu->kvm, gfn);
> +	if (!memslot) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	fault_info = &vcpu->arch.fault;
> +	stored_fault = *fault_info;
> +
> +	/* Generate a synthetic abort for the pre-fault address */
> +	fault_info->esr_el2 = FIELD_PREP(ESR_ELx_EC_MASK, ESR_ELx_EC_DABT_CUR);

minor nit: Any reason why we don't use ESR_ELx_EC_DABT_LOW ? We always
get that for a data abort from the guest. Otherwise, this looks
good to me.

Suzuki


> +	fault_info->esr_el2 &= ~ESR_ELx_ISV;
> +	fault_info->esr_el2 |= ESR_ELx_FSC_FAULT_L(KVM_PGTABLE_LAST_LEVEL);
> +
> +	fault_info->hpfar_el2 = HPFAR_EL2_NS |
> +		FIELD_PREP(HPFAR_EL2_FIPA, ipa >> 12);
> +
> +	if (kvm_slot_has_gmem(memslot)) {
> +		ret = gmem_abort(vcpu, ipa, NULL, memslot, false);
> +	} else {
> +		hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
> +		if (kvm_is_error_hva(hva)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		ret = user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva,
> +				     false);
> +	}
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	end = (range->gpa & ~(page_size - 1)) + page_size;
> +	ret = min(range->size, end - range->gpa);
> +
> +out:
> +	*fault_info = stored_fault;
> +out_unlock:
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +	return ret;
> +}
m


