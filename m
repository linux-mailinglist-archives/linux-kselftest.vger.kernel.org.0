Return-Path: <linux-kselftest+bounces-5133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5B85CFE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 06:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3E128503D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 05:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB6C3A1AF;
	Wed, 21 Feb 2024 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBJ3/FU4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348A39863;
	Wed, 21 Feb 2024 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494196; cv=none; b=vAJqJO8QPbEgWH45+NqPQXtwWEQTHEZTKjeCs3uNY8z820CEAIl48m97PG567V9c5MWVNo4NGe5ETrmhPVZQQdEcDegO77Uxng4RMRGebvTWp8k/UYnPC8MABHaA4yIeYpWk276wBMM8kKa6FXmCOFnRnhu1cjdqcHLG20OndO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494196; c=relaxed/simple;
	bh=Uukhj9fpIxxRlYAD8QGrCgdODLB1OI42Ei20zSHeD8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHX9v/UiHYHo26z5U+F/ENbfiylEzvmwisqmaS7iWnMUJ5AvuY38wI3j/q4O0HyFtwhOHes9c/1xJq4cSa+USJ3Nnqv+t7FrmroSOGC/PoFG92YUaHq37TY0KBzuZFgLVXa+FULgrxCU7MARhmTrFOlJ77ODTk/doV/Jnw1ZB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBJ3/FU4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708494194; x=1740030194;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Uukhj9fpIxxRlYAD8QGrCgdODLB1OI42Ei20zSHeD8g=;
  b=lBJ3/FU4zdM2qtfv4MG4jY9nYWqG9bDjAOuh4z3INi3B9ukwlEZY8O/E
   BvA4TLXoQZAcnevUwdOYC7WdGo02IiohM0u+yVl642/2Jr2wErAm2xvpD
   ZwZcE+qXwwLZaVizh8guwMIomCeWhoDH0TdXxfvnqIHhrHlXNmhdZqdjI
   5d4j6e4de0GGv/JXwyFH65jHGu1zIW3zDGLFFBTStZaP7EzcsYQ68D9gs
   7gp/SoY0Zu7BJEoudR/ecy5s11NStXGWlguyDrLxSjq4pA/sITetLhI/0
   Q7De4xARpm0fVuEPkenBUW43osm4KEkgloFFpamW4y4jjSSGDCNS36Yer
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2749581"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2749581"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 21:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="28172586"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.18.46]) ([10.93.18.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 21:43:09 -0800
Message-ID: <5749ff16-ca81-440d-85f0-62a1c3a572d0@linux.intel.com>
Date: Wed, 21 Feb 2024 13:43:06 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 04/29] KVM: selftests: Refactor steps in vCPU
 descriptor table initialization
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-5-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-5-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> Split the vCPU descriptor table initialization process into a few
> steps and expose them:
>
> + Setting up the IDT
> + Syncing exception handlers into the guest
>
> In kvm_setup_idt(), we conditionally allocate guest memory for vm->idt
> to avoid double allocation when kvm_setup_idt() is used after
> vm_init_descriptor_tables().
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86_64/processor.h  |  2 ++
>   .../selftests/kvm/lib/x86_64/processor.c      | 19 ++++++++++++++++---
>   2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 0b8855d68744..5c4e9a27d9e2 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -1089,6 +1089,8 @@ struct idt_entry {
>   	uint32_t offset2; uint32_t reserved;
>   };
>   
> +void kvm_setup_idt(struct kvm_vm *vm, struct kvm_dtable *dt);
> +void sync_exception_handlers_to_guest(struct kvm_vm *vm);
>   void vm_init_descriptor_tables(struct kvm_vm *vm);
>   void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
>   void vm_install_exception_handler(struct kvm_vm *vm, int vector,
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index b6b9438e0a33..566d82829da4 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1155,19 +1155,32 @@ void vm_init_descriptor_tables(struct kvm_vm *vm)
>   			DEFAULT_CODE_SELECTOR);
>   }
>   
> +void kvm_setup_idt(struct kvm_vm *vm, struct kvm_dtable *dt)
> +{
> +	if (!vm->idt)
> +		vm->idt = vm_vaddr_alloc_page(vm);

IDT is allocated in DATA memslot in current code, but here, when using
vm_vaddr_alloc_page(), it will be allocated in TEST_DATA memslot.

Do we need to follow the current code to use
__vm_vaddr_alloc_page(vm, MEM_REGION_DATA) instead?

> +
> +	dt->base = vm->idt;
> +	dt->limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +}
> +
> +void sync_exception_handlers_to_guest(struct kvm_vm *vm)
> +{
> +	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
> +}
> +
>   void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_vm *vm = vcpu->vm;
>   	struct kvm_sregs sregs;
>   
>   	vcpu_sregs_get(vcpu, &sregs);
> -	sregs.idt.base = vm->idt;
> -	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +	kvm_setup_idt(vcpu->vm, &sregs.idt);
>   	sregs.gdt.base = vm->gdt;
>   	sregs.gdt.limit = getpagesize() - 1;
>   	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
>   	vcpu_sregs_set(vcpu, &sregs);
> -	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
> +	sync_exception_handlers_to_guest(vm);
>   }
>   
>   void vm_install_exception_handler(struct kvm_vm *vm, int vector,


