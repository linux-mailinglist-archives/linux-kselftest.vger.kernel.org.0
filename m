Return-Path: <linux-kselftest+bounces-43263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EECBE0CDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 23:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172123AFAED
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7952F49FB;
	Wed, 15 Oct 2025 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xn7t0kHD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BB2DC79E
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563426; cv=none; b=HkFdqNIyYtVLF5wO69iQJoIVkl5Myi8/wGKjOWCaECFL8yWS4uHW0Tm1hRQESvxDNyYTzCDF5gDcjF6zomPVl8Qi+xUhQUxrTznZoaV97xHTxwRx00A1871CjpIEBtymE8mltO+s6iBBL/z8HeoHwsv2EGrerppiwSQhaYN3oLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563426; c=relaxed/simple;
	bh=z/ZAt/JqimvxhupKM/WQo3eIZ02qoztm40C2hOIV7Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfXstZoboO3pVvM+MP8CVlixPIfYfuHhD5ir+3rNE4QKPn+eeeuf4xNZmBnDbgNRtED9lu6pLB/L7/2UZaOEYLErHffME2xp1YMDcXmRDyRXP6vnIr5nkwjVwwS1eD6nNungtzzAYERui4+od9Zcb/FZMPQH3nHgxDd9jM5PC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xn7t0kHD; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Oct 2025 21:23:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760563411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tpCIpMhKpNVFUq8XLpVJcsrRwbNZaA4mgV8CdcBWnWs=;
	b=Xn7t0kHDndE+FUUNhj8T81D2rk2Y1bR1K7lKc6/YmhNojKZ6yQL6q+ao44Uavl7ZygojFY
	bOUY6SZD9WLXZGFKMo8nqi9exheJRxF0mtQUeHtwFYf14/QcXSDTvxgql7+4f4sll6fuDN
	wfmAzX13sMa+07OIyfrjE1Gkyr4L6d4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
Message-ID: <l7txoioo3gntu3lyl542jg3n3wvkqruf2qh33xy7lmr5mjgfq5@iw4wsfdurlc7>
References: <20250917215031.2567566-1-jmattson@google.com>
 <20250917215031.2567566-4-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917215031.2567566-4-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 17, 2025 at 02:48:39PM -0700, Jim Mattson wrote:
> Add a new VM mode, VM_MODE_PXXV57_4K, to support tests that require
> 5-level paging on x86. This mode sets up a 57-bit virtual address
> space and sets CR4.LA57 in the guest.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 21 +++++++++++++++++
>  .../testing/selftests/kvm/lib/x86/processor.c | 23 ++++++++++++-------
>  tools/testing/selftests/kvm/lib/x86/vmx.c     |  7 +++---
>  4 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 23a506d7eca3..b6ea5d966715 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -175,6 +175,7 @@ enum vm_guest_mode {
>  	VM_MODE_P40V48_16K,
>  	VM_MODE_P40V48_64K,
>  	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
> +	VM_MODE_PXXV57_4K,	/* For 48bits VA but ANY bits PA */
>  	VM_MODE_P47V64_4K,
>  	VM_MODE_P44V64_4K,
>  	VM_MODE_P36V48_4K,
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index c3f5142b0a54..6b0e499c6e91 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -232,6 +232,7 @@ const char *vm_guest_mode_string(uint32_t i)
>  		[VM_MODE_P40V48_16K]	= "PA-bits:40,  VA-bits:48, 16K pages",
>  		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
>  		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
> +		[VM_MODE_PXXV57_4K]	= "PA-bits:ANY, VA-bits:57,  4K pages",
>  		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
>  		[VM_MODE_P44V64_4K]	= "PA-bits:44,  VA-bits:64,  4K pages",
>  		[VM_MODE_P36V48_4K]	= "PA-bits:36,  VA-bits:48,  4K pages",
> @@ -259,6 +260,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>  	[VM_MODE_P40V48_16K]	= { 40, 48,  0x4000, 14 },
>  	[VM_MODE_P40V48_64K]	= { 40, 48, 0x10000, 16 },
>  	[VM_MODE_PXXV48_4K]	= {  0,  0,  0x1000, 12 },
> +	[VM_MODE_PXXV57_4K]	= {  0,  0,  0x1000, 12 },
>  	[VM_MODE_P47V64_4K]	= { 47, 64,  0x1000, 12 },
>  	[VM_MODE_P44V64_4K]	= { 44, 64,  0x1000, 12 },
>  	[VM_MODE_P36V48_4K]	= { 36, 48,  0x1000, 12 },
> @@ -358,6 +360,25 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
>  		vm->va_bits = 48;
>  #else
>  		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
> +#endif
> +		break;
> +	case VM_MODE_PXXV57_4K:
> +#ifdef __x86_64__
> +		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
> +		kvm_init_vm_address_properties(vm);
> +		/*
> +		 * For 5-level paging, KVM requires LA57 to be enabled, which
> +		 * requires a 57-bit virtual address space.
> +		 */
> +		TEST_ASSERT(vm->va_bits == 57,
> +			    "Linear address width (%d bits) not supported for VM_MODE_PXXV57_4K",
> +			    vm->va_bits);
> +		pr_debug("Guest physical address width detected: %d\n",
> +			 vm->pa_bits);
> +		vm->pgtable_levels = 5;
> +		vm->va_bits = 57;

We assert that vm->va_bits is 57, and then we set it here again. Seems
like we're doing the same for VM_MODE_PXXV48_4K too.

> +#else
> +		TEST_FAIL("VM_MODE_PXXV57_4K not supported on non-x86 platforms");
>  #endif
>  		break;
>  	case VM_MODE_P47V64_4K:
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 433365c8196d..d566190ea488 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -124,10 +124,11 @@ bool kvm_is_tdp_enabled(void)
>  
>  void virt_arch_pgd_alloc(struct kvm_vm *vm)
>  {
> -	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
> -		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
> +	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
> +		    vm->mode == VM_MODE_PXXV57_4K,
> +		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
>  
> -	/* If needed, create page map l4 table. */
> +	/* If needed, create the top-level page table. */
>  	if (!vm->pgd_created) {
>  		vm->pgd = vm_alloc_page_table(vm);
>  		vm->pgd_created = true;
> @@ -187,8 +188,9 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
>  	uint64_t *pte = &vm->pgd;
>  	int current_level;
>  
> -	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K,
> -		    "Unknown or unsupported guest mode, mode: 0x%x", vm->mode);
> +	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
> +		    vm->mode == VM_MODE_PXXV57_4K,
> +		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
>  
>  	TEST_ASSERT((vaddr % pg_size) == 0,
>  		    "Virtual address not aligned,\n"
> @@ -279,8 +281,9 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
>  	TEST_ASSERT(*level >= PG_LEVEL_NONE && *level < PG_LEVEL_NUM,
>  		    "Invalid PG_LEVEL_* '%d'", *level);
>  
> -	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
> -		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
> +	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
> +		    vm->mode == VM_MODE_PXXV57_4K,
> +		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
>  	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
>  		(vaddr >> vm->page_shift)),
>  		"Invalid virtual address, vaddr: 0x%lx",
> @@ -481,7 +484,9 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_sregs sregs;
>  
> -	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
> +	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
> +		    vm->mode == VM_MODE_PXXV57_4K,
> +		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
>  
>  	/* Set mode specific system register values. */
>  	vcpu_sregs_get(vcpu, &sregs);
> @@ -495,6 +500,8 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
>  	if (kvm_cpu_has(X86_FEATURE_XSAVE))
>  		sregs.cr4 |= X86_CR4_OSXSAVE;
> +	if (vm->pgtable_levels == 5)
> +		sregs.cr4 |= X86_CR4_LA57;
>  	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
>  
>  	kvm_seg_set_unusable(&sregs.ldt);
> diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
> index d4d1208dd023..1b6d4a007798 100644
> --- a/tools/testing/selftests/kvm/lib/x86/vmx.c
> +++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
> @@ -401,11 +401,12 @@ void __nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
>  	struct eptPageTableEntry *pt = vmx->eptp_hva, *pte;
>  	uint16_t index;
>  
> -	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
> -		    "unknown or unsupported guest mode, mode: 0x%x", vm->mode);
> +	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
> +		    vm->mode == VM_MODE_PXXV57_4K,
> +		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
>  
>  	TEST_ASSERT((nested_paddr >> 48) == 0,
> -		    "Nested physical address 0x%lx requires 5-level paging",
> +		    "Nested physical address 0x%lx is > 48-bits and requires 5-level EPT",

Shouldn't this assertion be updated now? We technically support 5-level
EPT so it should only fire if the mode is VM_MODE_PXXV48_4K. Maybe we
should use vm->va_bits?


>  		    nested_paddr);
>  	TEST_ASSERT((nested_paddr % page_size) == 0,
>  		    "Nested physical address not on page boundary,\n"
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 

