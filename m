Return-Path: <linux-kselftest+bounces-6474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5288634F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 23:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EB21F22725
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44242136999;
	Thu, 21 Mar 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1BM9hdN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C180134CD2;
	Thu, 21 Mar 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711060181; cv=none; b=JiMysf3tXhbRHHg2gFz8zbYtwvu4KMrxSYV2vJrT52RqFhTu8Phvgjo8vluwwETNBSc0voBx/6Zjt5D9tzGJV6yUysZF84/pbRcji1tr62cX7HpTllDc0bcIZnPnPTF93uyz7T2o1J1oH18/QGgdAgNIQH6TY0WFjTpwEziBpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711060181; c=relaxed/simple;
	bh=mncrWCICS4VL0Hc+/fAWMig/vblihxDQF+m/SdRG54Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hA4OOVSmBopu3pl9WbVzXegYzdZatInDYlVwuJGrg6NJxR0j26FSJIG3QY6Njba/Wc5SBOFZue2ZcyYitrZd7+x3GXRCDoNCFKjjEyC1ThqJgzm2eg5nEhcHF3zLnY7zNDWW9xIRCKWPNvAmPg01TaXq/ymtKIvd9e9NxR7hHOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1BM9hdN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711060180; x=1742596180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mncrWCICS4VL0Hc+/fAWMig/vblihxDQF+m/SdRG54Q=;
  b=K1BM9hdNG66zDvPIMlX5xMWcfvI2a+ZTBRiGLEwnKKRXC8q54wwVxq1H
   sNuiVjeDfJ+Q3rjulJ1N+4CxaVUG76r9VShxNYzTHje32ZUb+/estOhEu
   pbHFZf5u0lzHFgiQSEGDArmvS+w7N9olSCS8WXc24F1ICepOxxWM76Mnv
   sZppywXPlchLU7LtYRRxmD2O4NGP0qsWDal7V8giwhdbt5hvEPCr5Evxn
   zAz4IRkOzxBetwxH1G4yCH7D0qR34yCPmUUD1yHTf6NjqeoJSSwARI8eP
   F818RvslyEopoeVwdH2Xe55+TdzVKpzx8ly9OjSNVIiRJsoFW0vESkcx1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6211088"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="6211088"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="19240026"
Received: from dongshen-mobl1.amr.corp.intel.com (HELO [10.212.116.150]) ([10.212.116.150])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:29:38 -0700
Message-ID: <797bfae3-6419-4a7a-991a-1d203691d2cb@intel.com>
Date: Thu, 21 Mar 2024 15:29:37 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 01/29] KVM: selftests: Add function to allow
 one-to-one GVA to GPA mappings
To: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-2-sagis@google.com>
Content-Language: en-US
From: "Zhang, Dongsheng X" <dongsheng.x.zhang@intel.com>
In-Reply-To: <20231212204647.2170650-2-sagis@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2023 12:46 PM, Sagi Shahar wrote:
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
>  .../selftests/kvm/include/kvm_util_base.h     |  2 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 63 ++++++++++++++++---
>  2 files changed, 55 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 1426e88ebdc7..c2e5c5f25dfc 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -564,6 +564,8 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
>  vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
>  			    enum kvm_mem_region_type type);
>  vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
> +vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
> +			       vm_vaddr_t vaddr_min, uint32_t data_memslot);
>  vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
>  vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
>  				 enum kvm_mem_region_type type);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index febc63d7a46b..4f1ae0f1eef0 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1388,17 +1388,37 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
>  	return pgidx_start * vm->page_size;
>  }
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
>  static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> -				     vm_vaddr_t vaddr_min,
> -				     enum kvm_mem_region_type type,
> -				     bool encrypt)
> +				     vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
> +				     uint32_t data_memslot, bool encrypt)
>  {
>  	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
>  
>  	virt_pgd_alloc(vm);
> -	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages,
> -					      KVM_UTIL_MIN_PFN * vm->page_size,
> -					      vm->memslots[type], encrypt);
> +	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages, paddr_min,
> +					       data_memslot, encrypt);
>  
>  	/*
>  	 * Find an unused range of virtual page addresses of at least
> @@ -1408,8 +1428,7 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
>  
>  	/* Map the virtual pages. */
>  	for (vm_vaddr_t vaddr = vaddr_start; pages > 0;
> -		pages--, vaddr += vm->page_size, paddr += vm->page_size) {
> -
> +	     pages--, vaddr += vm->page_size, paddr += vm->page_size) {
>  		virt_pg_map(vm, vaddr, paddr);
>  
>  		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
> @@ -1421,12 +1440,16 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
>  vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
>  			    enum kvm_mem_region_type type)
>  {
> -	return ____vm_vaddr_alloc(vm, sz, vaddr_min, type, vm->protected);
> +	return ____vm_vaddr_alloc(vm, sz, vaddr_min,
> +				  KVM_UTIL_MIN_PFN * vm->page_size,
> +				  vm->memslots[type], vm->protected);
>  }
>  
>  vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
>  {
> -	return ____vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA, false);
> +	return ____vm_vaddr_alloc(vm, sz, vaddr_min,
> +				  KVM_UTIL_MIN_PFN * vm->page_size,
> +				  vm->memslots[MEM_REGION_TEST_DATA], false);
>  }
>  
>  /*
> @@ -1453,6 +1476,26 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
>  	return __vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA);
>  }
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

By 1to1, do you mean virtual address=physical address?, community tends to call this identity mapping.
Examples (function name):
create_identity_mapping_pagetables()
hellcreek_setup_tc_identity_mapping()
identity_mapping_add()

> +
> +	return gva;
> +}
> +
>  /*
>   * VM Virtual Address Allocate Pages
>   *

