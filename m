Return-Path: <linux-kselftest+bounces-39904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBACB3536F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 07:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4F11B6234A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 05:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F12ED15D;
	Tue, 26 Aug 2025 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgppWsx8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19611CA9;
	Tue, 26 Aug 2025 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186770; cv=none; b=SCkDaoUOluiyy+bRY72lVXZY8g5/jq8K0MUbzrSA76/PQlpsMk+zU1z/4D6j/7sfjupq2rdREfXy1LY0IkbKVdI3WnycMXCzeEBt3ijR7OtvZqzwzmEvPD7gCMfuFcmOP9E9eISB0lot499YPehZVMWUQWpTzgLOrxgaXwb04IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186770; c=relaxed/simple;
	bh=HRJjcbcyRfvO3v41VLnMi0TCRariXmHmNsEbLs52GtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJ/NcjcbhJ11tO09rmCO8S4aGUkbtvM3w26TPZ3QOpdb/lRhjKdZ22nJzroqKQXcKaRFMz3mczyJBVu1JojMzUco1JWTMPq65CS98uI0Auo2D822hNC6JfxroEz0kBbNvtESN8aEA65cbExj2YkUZKbyjEblJPjK8yLuO0z9Z2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgppWsx8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756186769; x=1787722769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HRJjcbcyRfvO3v41VLnMi0TCRariXmHmNsEbLs52GtQ=;
  b=jgppWsx8Ew0fbwYIMvXJP/CvMMrHuHLttIeeJJOruX9ONSX2m7Xiir0h
   NwuwXtvng2sdGyyq+HdjrVU6nD1dHJWHfKvHqSddm9LJ9594DZA7OcHfo
   1vJX6JKJtHrTubUfPeoyixz6vThkE08LmqKmb1/ka6VQq89aALQVBq5v/
   RBZse9Ady2RtjXM8kfMNCqDiID47n0KmOrjW5qon+Q1OWRyJwpoFP8YPo
   SLD5dKVsg7IgzyuZh1OHXu3O1DkFZspdn6iEObzxkr/tzwX8iDAjcAzaX
   qAcFYYUibBiQHNn1dc8EBmN/f/GJTl1dtzLOLRK2bShf93YGTlks27sqM
   g==;
X-CSE-ConnectionGUID: 1UfnXi8lRt6ZlbeeUckPrQ==
X-CSE-MsgGUID: FOmdkIa0RqyRT1x6aNYLCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69123201"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69123201"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 22:39:28 -0700
X-CSE-ConnectionGUID: 2eNAQR4oRJy8JCdYeCXpBA==
X-CSE-MsgGUID: 6gzzK6PFS/yu5WF5x/yI6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="193154065"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 22:39:23 -0700
Message-ID: <9ef0d1f4-3257-4821-8241-aedae0957c6a@linux.intel.com>
Date: Tue, 26 Aug 2025 13:39:20 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/19] KVM: selftests: Expose function to allocate
 guest vCPU stack
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-5-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250821042915.3712925-5-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 12:28 PM, Sagi Shahar wrote:
> TDX guests' registers cannot be initialized directly using
> vcpu_regs_set(), hence the stack pointer needs to be initialized by
> the guest itself, running boot code beginning at the reset vector.
>
> Expose the function to allocate the guest stack so that TDX
> initialization code can allocate it itself and skip the allocation in
> vm_arch_vcpu_add() in that case.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86/processor.h       |  2 ++
>   tools/testing/selftests/kvm/lib/x86/processor.c | 17 ++++++++++++-----
>   2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 5c16507f9b2d..8fcc5118683e 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -1111,6 +1111,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
>   	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
>   }
>   
> +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
> +
>   uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
>   int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
>   
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index b2a4b11ac8c0..1eae92957456 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -687,12 +687,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
>   	vcpu_regs_set(vcpu, &regs);
>   }
>   
> -struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
>   {
> -	struct kvm_mp_state mp_state;
> -	struct kvm_regs regs;
>   	vm_vaddr_t stack_vaddr;
> -	struct kvm_vcpu *vcpu;
>   
>   	stack_vaddr = __vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
>   				       DEFAULT_GUEST_STACK_VADDR_MIN,
> @@ -713,6 +710,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>   		    "__vm_vaddr_alloc() did not provide a page-aligned address");
>   	stack_vaddr -= 8;
>   
> +	return stack_vaddr;
> +}
> +
> +struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> +{
> +	struct kvm_mp_state mp_state;
> +	struct kvm_regs regs;
> +	struct kvm_vcpu *vcpu;
> +
>   	vcpu = __vm_vcpu_add(vm, vcpu_id);
>   	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
>   	vcpu_init_sregs(vm, vcpu);
> @@ -721,7 +727,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>   	/* Setup guest general purpose registers */
>   	vcpu_regs_get(vcpu, &regs);
>   	regs.rflags = regs.rflags | 0x2;
> -	regs.rsp = stack_vaddr;
> +	if (vm->type != KVM_X86_TDX_VM)
> +		regs.rsp = kvm_allocate_vcpu_stack(vm);

I am wondering if this could be more generic.
I.e, make vcpu_regs_get() return the error code.
If vcpu_regs_get() failed (for TDX, since it's guest state is protected, the
ioctl will return -EINVAL), the vcpu_regs_set(), including the allocation for
the vcpu stack, could be skipped.

>   	vcpu_regs_set(vcpu, &regs);
>   
>   	/* Setup the MP state */


