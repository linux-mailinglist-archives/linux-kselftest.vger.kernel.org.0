Return-Path: <linux-kselftest+bounces-47582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 910CCCBDA85
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 12:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2772530819D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A4332913;
	Mon, 15 Dec 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd+hrig3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F9C29A9C8
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798994; cv=none; b=aB4vjBtM7mlckWRUbxGVq5z5GEDlyr2/peiCSeMzpMojwlMozYSQtTFw9yPWKyruCLFYc3mitNwKiMZTEY0YCxLoS/k/zHxr8VYxF+yrOLspTw4BluK/+wTY2K0GHslpHCQxq59eMwGT6vPjDPE3Z8ZWlzNV22/psmPe8IAdq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798994; c=relaxed/simple;
	bh=1P1thL9zI5U/OHGIiYzXdaJ4xWzTSugzI554aAfiLM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I62/NKrJV0B/BorKDUB+XNXCxqO0f3Ej714/V8jzdI6X5qOsmTaIgxNvgUNiNtuwLF+AZOj/xBFL7q+AtGkZYQQwr1OYYUP18KCOsqJ32T3cKqREQCPrJOSagx/Epr3T5QzxcSdSIiXXnYric2gOGGvtmIIuFtHbSaZL0Zwo/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd+hrig3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b91680f8so33748675e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 03:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798988; x=1766403788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLb7lu6k1dl1c8hC4JILF0bEB9OOGY9XCBW6C8+pPO4=;
        b=Zd+hrig3Q3IW7XF8/2QoA5lHM51gP3v/0z+RTHigMlURy92JATY5ljK6mCUkTtXtkm
         CMeQn4BgFhF1cdvFRYPtsJK8FwPK/JJRYjFRbax8R/+16v5IYIRaJp9fZzwz+qhPRU2i
         GvYNjAzA23WdkxdtV3sCRm0R2nq95+RsfF2+2nwWKW4zVfigcW7NTxKBr3FFmT3Lf3c5
         MbUlMgfx3qm3Oi/3UHMey/ieUi9bAnElMyIrCtJ2haTJhKDp4ZVsaGFKBIyqT1NQpuDO
         qoXHYxLYgEnynZTYdULm3BcMjmD3yGdyCgFXg54MqW5VH+44STO/ILo9Msx91AocxpyM
         FeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798988; x=1766403788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLb7lu6k1dl1c8hC4JILF0bEB9OOGY9XCBW6C8+pPO4=;
        b=eyUAyrfFQv4/pqriY8YK3h/2Y7Gc6C4nAz+sEcJXruDu7CPlQNpBSNODOHMOLZ2M1d
         cZtftc0mXn/KBElCoGZ9B7ApwbCuCBsAp8fRJAAdJGNmo7C+icX3eEav3vc+M75LkXzz
         KFPLB18E/OIpqA3sKVtHjn5HsMPOH2PrYfHLAsMdVyyp4yVR2k1IPaSiFjaj6qy997aE
         fwFJQQcT6Wa2w5FI/RAoE3Y2U4Sigh3uBd2EwbAezWTcnexirn7T45bkt8WjDR8Fx25u
         /Ao7PsZ9AQ9w1OxbyWWvYYIgEc+Fr8PswDgaDTpSOaO7nHLIHUAmf+DpyxspjiPF69YK
         u17A==
X-Forwarded-Encrypted: i=1; AJvYcCV4OyOEnGyDWdPuos1XvVxZcDk1djWLHmpGtGVzMU5ff0qS2ZjEHqeEUtBA0MUOkKHXHfm7Ceuq4Le0viqivWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyamQs4yb6PrwR6tKlBOLT5YuW5VTgQRTNSCDWLe6H4fpzV0d3P
	fBBZlStNQbcpPPq2fMQ6dG6N4E3OSNrPkfLmp2j4ASzWb6zHRax6FF0r
X-Gm-Gg: AY/fxX4qqeTVc1FKb8A2LI7S8QiZpwbqJ+bOXMnMHtrMsw1Hlc/DP4JQicmcduEJ7Pp
	pTiMcUZW/Gv9WJEgxoMup+4E7sr/JFXxBHQzbzgmFE1mRd7rms9KuO+4C5hv4OVCB8cP97zwq3Q
	eKUjBkV9aEVW/FL6rnbPLAZ83WiUShDRds0y5OYMry9ptk+m3azRNgahXQzCT/tFzUjwAUgxt5D
	rJMPlJx8gNaoTjHELv7AfS/SHSnGYSgqfqGiXKycbqK1QcpUB9S8pzkpd5XiSwJbtgHs2gyeTUT
	nHp0U/E/Q+IU6VZbs1zDfa9gvFBRBFJfWX4CJEaA6jpSa5RQEwTW0yXZbylS1PeQW3la/8He34I
	U0lykCCgIfdfOkbhtbeDnVIulOpYh62mSjx4FZikQ2LApELrasv27T/YoqpS+qUpabKO/svhC2t
	e2Ksn9TXDuWKfIXEylM2qI1Cm2I3ocgoU=
X-Google-Smtp-Source: AGHT+IEeDQpvobbuwupfGiM5uFsRvzqhSqqhXPwsogSR24Yld7AT9v3CQqs0OrKCGgHyBRAjSgk9dw==
X-Received: by 2002:a05:6000:22c1:b0:431:104:6db2 with SMTP id ffacd0b85a97d-4310104705fmr1298336f8f.3.1765798988051;
        Mon, 15 Dec 2025 03:43:08 -0800 (PST)
Received: from [10.24.67.48] ([15.248.3.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fb0fc8d5fsm21235995f8f.2.2025.12.15.03.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 03:43:07 -0800 (PST)
Message-ID: <bc93c396-78b1-491c-8857-41114aa585d7@gmail.com>
Date: Mon, 15 Dec 2025 11:43:06 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] KVM: arm64: Add pre_fault_memory implementation
To: Marc Zyngier <maz@kernel.org>
Cc: oliver.upton@linux.dev, pbonzini@redhat.com, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, isaku.yamahata@intel.com,
 xmarcalx@amazon.co.uk, kalyazin@amazon.co.uk, jackabt@amazon.com
References: <20251119154910.97716-1-jackabt.amazon@gmail.com>
 <20251119154910.97716-2-jackabt.amazon@gmail.com>
 <86see3r7e9.wl-maz@kernel.org>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <86see3r7e9.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/11/2025 11:34 am, Marc Zyngier wrote:
> On Wed, 19 Nov 2025 15:49:08 +0000,
> Jack Thomson <jackabt.amazon@gmail.com> wrote:
>>
>> From: Jack Thomson <jackabt@amazon.com>
>>
>> Add kvm_arch_vcpu_pre_fault_memory() for arm64. The implementation hands
>> off the stage-2 faulting logic to either gmem_abort() or
>> user_mem_abort().
>>
>> Add an optional page_size output parameter to user_mem_abort() to
>> return the VMA page size, which is needed when pre-faulting.
>>
>> Update the documentation to clarify x86 specific behaviour.
>>
>> Signed-off-by: Jack Thomson <jackabt@amazon.com>
>> ---
>>   Documentation/virt/kvm/api.rst |  3 +-
>>   arch/arm64/kvm/Kconfig         |  1 +
>>   arch/arm64/kvm/arm.c           |  1 +
>>   arch/arm64/kvm/mmu.c           | 73 ++++++++++++++++++++++++++++++++--
>>   4 files changed, 73 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 57061fa29e6a..30872d080511 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6493,7 +6493,8 @@ Errors:
>>   KVM_PRE_FAULT_MEMORY populates KVM's stage-2 page tables used to map memory
>>   for the current vCPU state.  KVM maps memory as if the vCPU generated a
>>   stage-2 read page fault, e.g. faults in memory as needed, but doesn't break
>> -CoW.  However, KVM does not mark any newly created stage-2 PTE as Accessed.
>> +CoW.  However, on x86, KVM does not mark any newly created stage-2 PTE as
>> +Accessed.
>>   
>>   In the case of confidential VM types where there is an initial set up of
>>   private guest memory before the guest is 'finalized'/measured, this ioctl
>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>> index 4f803fd1c99a..6872aaabe16c 100644
>> --- a/arch/arm64/kvm/Kconfig
>> +++ b/arch/arm64/kvm/Kconfig
>> @@ -25,6 +25,7 @@ menuconfig KVM
>>   	select HAVE_KVM_CPU_RELAX_INTERCEPT
>>   	select KVM_MMIO
>>   	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>> +	select KVM_GENERIC_PRE_FAULT_MEMORY
>>   	select VIRT_XFER_TO_GUEST_WORK
>>   	select KVM_VFIO
>>   	select HAVE_KVM_DIRTY_RING_ACQ_REL
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 870953b4a8a7..88c5dc2b4ee8 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -327,6 +327,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   	case KVM_CAP_IRQFD_RESAMPLE:
>>   	case KVM_CAP_COUNTER_OFFSET:
>>   	case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
>> +	case KVM_CAP_PRE_FAULT_MEMORY:
>>   		r = 1;
> 
> How does with pKVM, where the host is not in charge of dealing with
> stage-2?
For the pKVM case would
     if (vcpu_is_protected(vcpu))
         return -EPERM;
be the appropriate way to handle this?
>>   		break;
>>   	case KVM_CAP_SET_GUEST_DEBUG2:
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 7cc964af8d30..cba09168fc6d 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -1599,8 +1599,8 @@ static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   
>>   static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   			  struct kvm_s2_trans *nested,
>> -			  struct kvm_memory_slot *memslot, unsigned long hva,
>> -			  bool fault_is_perm)
>> +			  struct kvm_memory_slot *memslot, long *page_size,
> 
> Why is page_size a signed type? A page size is never negative.
> 
>> +			  unsigned long hva, bool fault_is_perm)
> 
> I really wish we'd stop adding parameters to this function, as it has
> long stopped being readable. It would make a lot more sense if we
> passed a descriptor for the fault, containing the ipa, hva, memslot
> and fault type.
I found a patch series which looks to address this [1]. Would you like
this fixed for this series?

[1] 
https://lore.kernel.org/linux-arm-kernel/20250821210042.3451147-1-seanjc@google.com/
>>   {
>>   	int ret = 0;
>>   	bool topup_memcache;
>> @@ -1878,6 +1878,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	kvm_release_faultin_page(kvm, page, !!ret, writable);
>>   	kvm_fault_unlock(kvm);
>>   
>> +	if (page_size)
>> +		*page_size = vma_pagesize;
>> +
>>   	/* Mark the page dirty only if the fault is handled successfully */
>>   	if (writable && !ret)
>>   		mark_page_dirty_in_slot(kvm, memslot, gfn);
>> @@ -2080,8 +2083,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>>   		ret = gmem_abort(vcpu, fault_ipa, nested, memslot,
>>   				 esr_fsc_is_permission_fault(esr));
>>   	else
>> -		ret = user_mem_abort(vcpu, fault_ipa, nested, memslot, hva,
>> -				     esr_fsc_is_permission_fault(esr));
>> +		ret = user_mem_abort(vcpu, fault_ipa, nested, memslot, NULL,
>> +				     hva, esr_fsc_is_permission_fault(esr));
>>   	if (ret == 0)
>>   		ret = 1;
>>   out:
>> @@ -2457,3 +2460,65 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
>>   
>>   	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
>>   }
>> +
>> +long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>> +				    struct kvm_pre_fault_memory *range)
>> +{
>> +	int ret, idx;
>> +	hva_t hva;
>> +	phys_addr_t end;
>> +	struct kvm_memory_slot *memslot;
>> +	struct kvm_vcpu_fault_info stored_fault, *fault_info;
>> +
>> +	long page_size = PAGE_SIZE;
>> +	phys_addr_t ipa = range->gpa;
>> +	gfn_t gfn = gpa_to_gfn(range->gpa);
> 
> nit: Please order this in a more readable way, preferably with long
> line first.
> 
>> +
>> +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> 
> ??? Aren't we already guaranteed to be under the SRCU read lock?
> 
>> +
>> +	if (ipa >= kvm_phys_size(vcpu->arch.hw_mmu)) {
>> +		ret = -ENOENT;
>> +		goto out_unlock;
>> +	}
>> +
>> +	memslot = gfn_to_memslot(vcpu->kvm, gfn);
>> +	if (!memslot) {
>> +		ret = -ENOENT;
>> +		goto out_unlock;
>> +	}
>> +
>> +	fault_info = &vcpu->arch.fault;
>> +	stored_fault = *fault_info;
> 
> If this is a vcpu ioctl, can the fault information be actually valid
> while userspace is issuing an ioctl? Wouldn't that mean that we are
> exiting to userspace in the middle of handling an exception?
> 
>> +
>> +	/* Generate a synthetic abort for the pre-fault address */
>> +	fault_info->esr_el2 = ESR_ELx_EC_DABT_LOW;
>> +	fault_info->esr_el2 &= ~ESR_ELx_ISV;
> 
> You are constructing this from scratch. How can ISV be set?
> 
>> +	fault_info->esr_el2 |= ESR_ELx_FSC_FAULT_L(KVM_PGTABLE_LAST_LEVEL);
>> +
>> +	fault_info->hpfar_el2 = HPFAR_EL2_NS |
>> +		FIELD_PREP(HPFAR_EL2_FIPA, ipa >> 12);
>> +
>> +	if (kvm_slot_has_gmem(memslot)) {
>> +		ret = gmem_abort(vcpu, ipa, NULL, memslot, false);
>> +	} else {
>> +		hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
>> +		if (kvm_is_error_hva(hva)) {
>> +			ret = -EFAULT;
>> +			goto out;
>> +		}
>> +		ret = user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva,
>> +				     false);
>> +	}
>> +
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	end = (range->gpa & ~(page_size - 1)) + page_size;
> 
> This suspiciously looks like one of the __ALIGN_KERNEL* macros.
> 
>> +	ret = min(range->size, end - range->gpa);
>> +
>> +out:
>> +	*fault_info = stored_fault;
>> +out_unlock:
>> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
>> +	return ret;
>> +}
> 
> Thanks,
> 
> 	M.
> 

-- 
Thanks,
Jack

