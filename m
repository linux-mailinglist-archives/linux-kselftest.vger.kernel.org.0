Return-Path: <linux-kselftest+bounces-5111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA685CD85
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DE8284F2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080C74428;
	Wed, 21 Feb 2024 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPpRDcD1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394A17D5;
	Wed, 21 Feb 2024 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708479805; cv=none; b=NnYofGxbx/ETwpIl3SsG/ni785oZ0qGVI8rr44J/p7bND2riZrkbUXFnAh8zPAwnG7WiSiZ7Ydd/keIYPF1sYJJIUY+gjmrzEJ6YPxrUxrNl8Flgp7Ck946rLqX8HZy9astiVXuEIDoDPavdxXsVW+aBQUMhF1WLI/Or4TRLXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708479805; c=relaxed/simple;
	bh=lGGbcLxDjtl1FUL44Pi8sUhy6VBubv51KjZsxs/qefo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEjlHETdldk1RC7inbmNmJxXuuW6kRd0LhzkMg4M7Wfwk72JAgH8Dzani5UYJRQKydH8B7xL5k8YXVrOiEG+Zt71o+NfLvIC3gcHeg4rx77ajUeGmdhUwURpyilIWpRfClvGo5pC/hotXo1ZdNL9/1J2LWx6U68OX6pbjzzuzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPpRDcD1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708479804; x=1740015804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lGGbcLxDjtl1FUL44Pi8sUhy6VBubv51KjZsxs/qefo=;
  b=hPpRDcD1mVRpezugAJWihKJotYCLyKPcHJJ2EvqMobD0O+8MOXGaHSQ8
   68EeONrY0Bd1AhmMGNKjX3snqDctMTCPmPmaVNJGrSs8W27wdyUOMU8za
   nyiTmTyp7ZV6Q2Rlg+W+PPJQcMSNnuoAAbwEzYv3Xr6w+oxsnEG0WkIbl
   QGE40B80DMCm/MrYP/GVaMayHEhwgXxjphzoxzqsy0o2Uv25sJ0KF7G8+
   MXHndlpxjOCkuA+wPUO56EqC9jQsovLBBj5JE+NnqfErGhDjT7iRb84e7
   BjYGBLQNqVAzHxGlUz1nk0dcLNFnhAJqFl6tlFpODxSkXmpdwJkWGsVBj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13179402"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13179402"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 17:43:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="36004407"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.18.46]) ([10.93.18.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 17:43:19 -0800
Message-ID: <516247d2-7ba8-4b3e-8325-8c6dd89b929e@linux.intel.com>
Date: Wed, 21 Feb 2024 09:43:16 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 01/29] KVM: selftests: Add function to allow
 one-to-one GVA to GPA mappings
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Ryan Afranji
 <afranji@google.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-2-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-2-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> One-to-one GVA to GPA mappings can be used in the guest to set up boot
> sequences during which paging is enabled, hence requiring a transition
> from using physical to virtual addresses in consecutive instructions.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/kvm_util_base.h     |  2 +
>   tools/testing/selftests/kvm/lib/kvm_util.c    | 63 ++++++++++++++++---
>   2 files changed, 55 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 1426e88ebdc7..c2e5c5f25dfc 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -564,6 +564,8 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
>   vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
>   			    enum kvm_mem_region_type type);
>   vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
> +vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
> +			       vm_vaddr_t vaddr_min, uint32_t data_memslot);
>   vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
>   vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
>   				 enum kvm_mem_region_type type);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index febc63d7a46b..4f1ae0f1eef0 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1388,17 +1388,37 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
>   	return pgidx_start * vm->page_size;
>   }
>   
> +/*
> + * VM Virtual Address Allocate Shared/Encrypted
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   sz - Size in bytes
> + *   vaddr_min - Minimum starting virtual address
> + *   paddr_min - Minimum starting physical address
> + *   data_memslot - memslot number to allocate in
> + *   encrypt - Whether the region should be handled as encrypted
> + *
> + * Output Args: None
> + *
> + * Return:
> + *   Starting guest virtual address
> + *
> + * Allocates at least sz bytes within the virtual address space of the vm
> + * given by vm.  The allocated bytes are mapped to a virtual address >=
> + * the address given by vaddr_min.  Note that each allocation uses a
> + * a unique set of pages, with the minimum real allocation being at least
> + * a page.
> + */
>   static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> -				     vm_vaddr_t vaddr_min,
> -				     enum kvm_mem_region_type type,
> -				     bool encrypt)
> +				     vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
> +				     uint32_t data_memslot, bool encrypt)
>   {
>   	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
>   
>   	virt_pgd_alloc(vm);
> -	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages,
> -					      KVM_UTIL_MIN_PFN * vm->page_size,
> -					      vm->memslots[type], encrypt);
> +	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages, paddr_min,
> +					       data_memslot, encrypt);
>   
>   	/*
>   	 * Find an unused range of virtual page addresses of at least
> @@ -1408,8 +1428,7 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
>   
>   	/* Map the virtual pages. */
>   	for (vm_vaddr_t vaddr = vaddr_start; pages > 0;
> -		pages--, vaddr += vm->page_size, paddr += vm->page_size) {
> -
> +	     pages--, vaddr += vm->page_size, paddr += vm->page_size) {
>   		virt_pg_map(vm, vaddr, paddr);
>   
>   		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
> @@ -1421,12 +1440,16 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
>   vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
>   			    enum kvm_mem_region_type type)
>   {
> -	return ____vm_vaddr_alloc(vm, sz, vaddr_min, type, vm->protected);
> +	return ____vm_vaddr_alloc(vm, sz, vaddr_min,
> +				  KVM_UTIL_MIN_PFN * vm->page_size,
> +				  vm->memslots[type], vm->protected);
>   }
>   
>   vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
>   {
> -	return ____vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA, false);
> +	return ____vm_vaddr_alloc(vm, sz, vaddr_min,
> +				  KVM_UTIL_MIN_PFN * vm->page_size,
> +				  vm->memslots[MEM_REGION_TEST_DATA], false);
>   }
>   
>   /*
> @@ -1453,6 +1476,26 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
>   	return __vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA);
>   }
>   
> +/**
> + * Allocate memory in @vm of size @sz in memslot with id @data_memslot,
> + * beginning with the desired address of @vaddr_min.
> + *
> + * If there isn't enough memory at @vaddr_min, find the next possible address
> + * that can meet the requested size in the given memslot.
> + *
> + * Return the address where the memory is allocated.
> + */
> +vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
> +			       vm_vaddr_t vaddr_min, uint32_t data_memslot)
> +{
> +	vm_vaddr_t gva = ____vm_vaddr_alloc(vm, sz, vaddr_min,
> +					    (vm_paddr_t)vaddr_min, data_memslot,
> +					    vm->protected);
> +	TEST_ASSERT_EQ(gva, addr_gva2gpa(vm, gva));

How can this be guaranteed?
For ____vm_vaddr_alloc(), generically there is no enforcement about the
identity of virtual and physical address.

> +
> +	return gva;
> +}
> +
>   /*
>    * VM Virtual Address Allocate Pages
>    *


