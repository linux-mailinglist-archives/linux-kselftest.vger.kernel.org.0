Return-Path: <linux-kselftest+bounces-39897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C965B351C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 04:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E00617C6A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B6C221FB8;
	Tue, 26 Aug 2025 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6jVq2oQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B6244691;
	Tue, 26 Aug 2025 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175805; cv=none; b=JXfIGpOevqH8z2qE0uLOiom6mdIpp8JXBH9a4MPfvI/M+ZoZVX3H1v5ZPOv6dqrV5IrJ4oSvhlA/ro3juxA5sodQ1oiM3ukcadJNoCvdowFif3a478IhNPGMi3Ng6ztHpma/qJq5hzdV86zyDKJfG4kCtbQDym2RcXfLrUcAs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175805; c=relaxed/simple;
	bh=VDaYkusQnr+DdlP24bPLcmaDH+WQXq7aJffVQa3sxdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJOKH7oyRv/LCPsW3sO4tgRyzhlwpeajAlH1LKEdIB+qjvPpo6Qe7V1SDQFQePmItRJGddXvtXvAi++gHxLWJvby2L/n3v6gdRmwlt4U+CWVyegA2mN9phC+Dp2OXcCEf5Q5UvAR7ebFQ1oG3t74R8/tR+MRPcVUQYpzpFUP/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6jVq2oQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756175804; x=1787711804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VDaYkusQnr+DdlP24bPLcmaDH+WQXq7aJffVQa3sxdc=;
  b=k6jVq2oQmFv5emgyQ9pH3u2q8UB0Y0OqyIBM400NEyYszGedEJS52ui3
   I6JclnVo9ul3Jex6v1iFneagnedrT8vneHeIJWmRYIj90x+BGVIxZ8xuE
   L+FHC4jDhMHzWld7Rg4sJRdqfhpua4HMPrE+9S7wbM/WcwcxU4G2zscgn
   Qd2xSNKJdueQlqKolaExETx8RMoGZfrWf28L7RMbSXkVvIEEj+fd5Z9vt
   hiTV+j8Tg0iVvUaDyIUINTa1mYgiY/Hdflqy/o0mvYKv+ZUnQ2JOxTDZQ
   2QU4JNrc2jCISOVKTlwlqoPIrS9i9xWZzQprn51XvaKAdNsotL5+XWgCa
   g==;
X-CSE-ConnectionGUID: ungiOOHZQmGIVwzPGsAHsQ==
X-CSE-MsgGUID: 21FRf/yPShmBaSho2jc9aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="75851389"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="75851389"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 19:36:44 -0700
X-CSE-ConnectionGUID: 4UXdFcF2RYiEF5YxQaOSlw==
X-CSE-MsgGUID: KnEKI99EQG2L7UQSKOL0aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168661995"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 19:36:39 -0700
Message-ID: <e04d31a3-3243-4141-88d2-1f0ade6d648a@linux.intel.com>
Date: Tue, 26 Aug 2025 10:36:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/19] KVM: selftests: Expose functions to get default
 sregs values
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
 <20250821042915.3712925-4-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250821042915.3712925-4-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 12:28 PM, Sagi Shahar wrote:
> TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
> default values of certain sregs used by TDX VMs so they can be set
> manually.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86/processor.h     |  6 +++
>   .../testing/selftests/kvm/lib/x86/processor.c | 41 +++++++++++++++----
>   2 files changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 2efb05c2f2fb..5c16507f9b2d 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -1026,6 +1026,12 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
>   
>   void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
>   
> +uint16_t kvm_get_default_idt_limit(void);
> +uint16_t kvm_get_default_gdt_limit(void);
> +uint64_t kvm_get_default_cr0(void);
> +uint64_t kvm_get_default_cr4(void);
> +uint64_t kvm_get_default_efer(void);
Can these be defined in the header file as static inline?

> +
>   static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
>   {
>   	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index d4c19ac885a9..b2a4b11ac8c0 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -488,6 +488,35 @@ static void kvm_seg_set_tss_64bit(vm_vaddr_t base, struct kvm_segment *segp)
>   	segp->present = 1;
>   }
>   
> +uint16_t kvm_get_default_idt_limit(void)
> +{
> +	return NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +}
> +
> +uint16_t kvm_get_default_gdt_limit(void)
> +{
> +	return getpagesize() - 1;
> +}
> +
> +uint64_t kvm_get_default_cr0(void)
> +{
> +	return X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> +}
> +
> +uint64_t kvm_get_default_cr4(void)
> +{
> +	uint64_t cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
> +
> +	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> +		cr4 |= X86_CR4_OSXSAVE;
> +	return cr4;
> +}
> +
> +uint64_t kvm_get_default_efer(void)
> +{
> +	return EFER_LME | EFER_LMA | EFER_NX;
> +}
> +
>   static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_sregs sregs;
> @@ -498,15 +527,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>   	vcpu_sregs_get(vcpu, &sregs);
>   
>   	sregs.idt.base = vm->arch.idt;
> -	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +	sregs.idt.limit = kvm_get_default_idt_limit();
>   	sregs.gdt.base = vm->arch.gdt;
> -	sregs.gdt.limit = getpagesize() - 1;
> +	sregs.gdt.limit = kvm_get_default_gdt_limit();
>   
> -	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> -	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> -	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> -		sregs.cr4 |= X86_CR4_OSXSAVE;
> -	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
> +	sregs.cr0 = kvm_get_default_cr0();
> +	sregs.cr4 |= kvm_get_default_cr4();
> +	sregs.efer |= kvm_get_default_efer();
>   
>   	kvm_seg_set_unusable(&sregs.ldt);
>   	kvm_seg_set_kernel_code_64bit(&sregs.cs);


