Return-Path: <linux-kselftest+bounces-40756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A065B43713
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 11:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D5B173A06
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1872F4A0E;
	Thu,  4 Sep 2025 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1mky/tm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3480277CB4;
	Thu,  4 Sep 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978073; cv=none; b=PL63Fqy4MNkV3R0iwBCN7NF4EPaNQV/mS2/K/ZVlOAWaplVyKBYoAEAo/Dvlbj9gJ4E2dLyoK2so8naN5s9s2N+/iCs2gt6ha31PQ5KhkGFTcjdql5Rm7FbE/yc3LMnQCYbT7HSi3XTESARoV7Yep0x/rprUF+8HmvNDitgXJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978073; c=relaxed/simple;
	bh=3vmcO3IDLVqiIgvWlLZTNLw6ISoWbnTQAzKUb0u3ILk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AY9FvpfbepdE5HdTy1405J+uvBoZjyObSrxBLmm8DYw9MWKW+7jhu+2VWahRmng+IYPppJ9e0z0O6XTwaK7fIxQc0LK6LpXyHnEEVjM+Gqe+0hpBkwZloja1OJZ86vjlHwnODDTUblOpL5LM2snIIwZ5uQ9ckRlKMbHdV8/+mn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1mky/tm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756978072; x=1788514072;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3vmcO3IDLVqiIgvWlLZTNLw6ISoWbnTQAzKUb0u3ILk=;
  b=b1mky/tmPhOHLK1kWPV1MQR5+zFwuFfLc+Lw0Zff42ob3FM4ODKxiXf/
   uWH7QqcOEz4mkoazlmS20LnTSayphcYsAqPpi/GWTao/LM7Wp+7I7nDwT
   1cW/YxknPRmONch1x+WJHH8J7rNkMxG8aMazfJT7dLwDoyS5Ue7eD7x+X
   IDKA2DFcOql5E1ywLtjPjejWS2ijJlhZrs/R2msb6yT2Kbt1dCeY4VJVt
   TErvcfWDTliSx/DcR8UrEIk5EBQ7rbxTrp+mGNn9OYL0Wmle49oTJ4XFu
   bYblwhUf/U1O9ednK8Bpk3t/5sdWH6qpnet7Jc8Rm99fcV+WlXPmj4ZMa
   Q==;
X-CSE-ConnectionGUID: RHe/RclLR8Ku7DfT59fbqw==
X-CSE-MsgGUID: Rjgn2z/KQm+K2YGtJ2gMJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="62951487"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="62951487"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 02:27:51 -0700
X-CSE-ConnectionGUID: wlcGnxx/Su2kFT5/P2TcRg==
X-CSE-MsgGUID: RjDfgkfRS/unBfaFd0oW5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="195501501"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 02:27:46 -0700
Message-ID: <9247e150-800c-4e95-a5e9-e0032dc7d3ed@linux.intel.com>
Date: Thu, 4 Sep 2025 17:27:44 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/21] KVM: selftests: Expose function to allocate
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
References: <20250904065453.639610-1-sagis@google.com>
 <20250904065453.639610-4-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-4-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
> TDX guests' registers cannot be initialized directly using
> vcpu_regs_set(), hence the stack pointer needs to be initialized by
> the guest itself, running boot code beginning at the reset vector.
>
> Expose the function to allocate the guest stack so that TDX
> initialization code can allocate it itself and skip the allocation in
> vm_arch_vcpu_add() in that case.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>   .../selftests/kvm/include/x86/processor.h        |  2 ++
>   tools/testing/selftests/kvm/lib/x86/processor.c  | 16 +++++++++++-----
>   2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index f610c09cadf4..8e75df5e6bc9 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -1109,6 +1109,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
>   	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
>   }
>   
> +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
> +
>   uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
>   int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
>   
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 83efcf48faad..82369373e843 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -658,12 +658,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
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
> @@ -684,6 +681,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
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
> @@ -692,7 +698,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>   	/* Setup guest general purpose registers */
>   	vcpu_regs_get(vcpu, &regs);
>   	regs.rflags = regs.rflags | 0x2;
> -	regs.rsp = stack_vaddr;
> +	regs.rsp = kvm_allocate_vcpu_stack(vm);
>   	vcpu_regs_set(vcpu, &regs);
>   
>   	/* Setup the MP state */


