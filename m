Return-Path: <linux-kselftest+bounces-6370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6387D90B
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Mar 2024 07:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C508A281DA6
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Mar 2024 06:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4389679F3;
	Sat, 16 Mar 2024 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bB0k2tLJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1378EAD4;
	Sat, 16 Mar 2024 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570284; cv=none; b=LXwtUa24ED8pNwyy+ss7kPbgl2qhvdQouZ75mFGeS78+y03DSizkYikbTblktn/AF8mCyG2r817MUEEp8BVq+xCdTJvoBwybwGL7znmhKtcJm+LYWX7ncEB/5iYPAv3Q7FKGJOMOOl1NhwnXOyRek5KMDu6vOy5W6E92VW7Rx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570284; c=relaxed/simple;
	bh=Z9CPgMx4k6xbyqdhStgFoDUX8JdMY2zitvwklGw/CEw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=i8lAN4Spc+UrS26Lffoi2CW4rMGCoPnj23rxwpnVK/4Mmw7398wxs7lpGVM8li0wWxnf7qclgsbtKZwl9CmU/7MvbO40HWEMWM7mRRjDuoMfEGbNqNCgLhJU9OTCU4P5Yz1Ff7Wz1BWudWJdJPcUOk2OYq9aA1Y7jmcqocBzTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bB0k2tLJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710570282; x=1742106282;
  h=message-id:date:mime-version:from:subject:to:references:
   cc:in-reply-to:content-transfer-encoding;
  bh=Z9CPgMx4k6xbyqdhStgFoDUX8JdMY2zitvwklGw/CEw=;
  b=bB0k2tLJwOS6DxRGtCGOfgbAtemIArROpuOt7uxVmBcjdwB071xpTPFK
   Ii+lBdWu9CSBXJIOGmuAffkl3G/3+ejlRL007f8gubcKkwKSHALy+rsUL
   1Krzv54wAPn6yXjdkeZBCf08N6voYtmbqFZ7QFG/k14YgUqq2cUd+Xu1Z
   tGLkblI1tG0mfbS2d6USNCQJSgGBW+Soiga61uGaxorPw+iutuGAUrmvT
   VfinWQLMAVcVaWiwyTq4ECEezNdR6hAAo4CFpSykIKOGl3JhYMI12ZzYL
   5/kInIKJl2Cv1YFWzIELDTv8mG8JOKVQJQ6XelbKbci7CkGro/8likAax
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="16099328"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="16099328"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 23:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="43953437"
Received: from jhanbaba-mobl.amr.corp.intel.com (HELO [10.124.36.86]) ([10.124.36.86])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 23:24:40 -0700
Message-ID: <98b54b29-6f1d-4a3b-97d1-1e08b0ed0465@intel.com>
Date: Fri, 15 Mar 2024 23:24:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Chen, Zide" <zide.chen@intel.com>
Subject: Re: [RFC PATCH v5 22/29] KVM: selftests: Add functions to allow
 mapping as shared
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 "Afranji, Ryan" <afranji@google.com>, "Aktas, Erdem"
 <erdemaktas@google.com>, Sagi Shahar <sagis@google.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-23-sagis@google.com>
 <DS7PR11MB7886BD37E5E56DAB9A0087A3F6292@DS7PR11MB7886.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "Annapurve, Vishal" <vannapurve@google.com>,
 Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>,
 jmattson@google.com, dmatlack@google.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <DS7PR11MB7886BD37E5E56DAB9A0087A3F6292@DS7PR11MB7886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2023 12:47 PM, Sagi Shahar wrote:

> 
> 
> -----Original Message-----
> From: Sagi Shahar <sagis@google.com> 
> Sent: Tuesday, December 12, 2023 12:47 PM
> To: linux-kselftest@vger.kernel.org; Ackerley Tng <ackerleytng@google.com>; Afranji, Ryan <afranji@google.com>; Aktas, Erdem <erdemaktas@google.com>; Sagi Shahar <sagis@google.com>; Yamahata, Isaku <isaku.yamahata@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>; Paolo Bonzini <pbonzini@redhat.com>; Shuah Khan <shuah@kernel.org>; Peter Gonda <pgonda@google.com>; Xu, Haibo1 <haibo1.xu@intel.com>; Chao Peng <chao.p.peng@linux.intel.com>; Annapurve, Vishal <vannapurve@google.com>; Roger Wang <runanwang@google.com>; Vipin Sharma <vipinsh@google.com>; jmattson@google.com; dmatlack@google.com; linux-kernel@vger.kernel.org; kvm@vger.kernel.org; linux-mm@kvack.org
> Subject: [RFC PATCH v5 22/29] KVM: selftests: Add functions to allow mapping as shared

Since protected_phy_pages is introduced to keep track of the guest
memory's private/shared property, it's better to keep it consistent with
the guest mappings.

Instead of having a set of new APIs to force it to map shared guest
pages, how about to update protected_phy_pages sparsebits right before
the mapping, and just call the existing virt_pg_map() to do the mapping?


> From: Ackerley Tng <ackerleytng@google.com>
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h     | 24 ++++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++++++++++++++
>  .../selftests/kvm/lib/x86_64/processor.c      | 15 +++++++--
>  3 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index b353617fcdd1..efd7ae8abb20 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -574,6 +574,8 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
>  
>  void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  	      unsigned int npages);
> +void virt_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
> +		     unsigned int npages);
>  void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);  void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);  vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva); @@ -1034,6 +1036,28 @@ static inline void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr
>  	virt_arch_pg_map(vm, vaddr, paddr);
>  }
>  
> +/*
> + * VM Virtual Page Map as Shared
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vaddr - VM Virtual Address
> + *   paddr - VM Physical Address
> + *   memslot - Memory region slot for new virtual translation tables
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Within @vm, creates a virtual translation for the page starting
> + * at @vaddr to the page starting at @paddr.
> + */
> +void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, 
> +uint64_t paddr);
> +
> +static inline void virt_pg_map_shared(struct kvm_vm *vm, uint64_t 
> +vaddr, uint64_t paddr) {
> +	virt_arch_pg_map_shared(vm, vaddr, paddr); }
>  
>  /*
>   * Address Guest Virtual to Guest Physical diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 4f1ae0f1eef0..28780fa1f0f2 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1573,6 +1573,38 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  	}
>  }
>  
> +/*
> + * Map a range of VM virtual address to the VM's physical address as 
> +shared
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vaddr - Virtuall address to map
> + *   paddr - VM Physical Address
> + *   npages - The number of pages to map
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Within the VM given by @vm, creates a virtual translation for
> + * @npages starting at @vaddr to the page range starting at @paddr.
> + */
> +void virt_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
> +		     unsigned int npages)
> +{
> +	size_t page_size = vm->page_size;
> +	size_t size = npages * page_size;
> +
> +	TEST_ASSERT(vaddr + size > vaddr, "Vaddr overflow");
> +	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
> +
> +	while (npages--) {
> +		virt_pg_map_shared(vm, vaddr, paddr);
> +		vaddr += page_size;
> +		paddr += page_size;
> +	}
> +}
> +
>  /*
>   * Address VM Physical to Host Virtual
>   *
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 566d82829da4..aa2a57ddb8d3 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -190,7 +190,8 @@ static uint64_t *virt_create_upper_pte(struct kvm_vm *vm,
>  	return pte;
>  }
>  
> -void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
> +static void ___virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
> +			   int level, bool protected)
>  {
>  	const uint64_t pg_size = PG_LEVEL_SIZE(level);
>  	uint64_t *pml4e, *pdpe, *pde;
> @@ -235,17 +236,27 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
>  		    "PTE already present for 4k page at vaddr: 0x%lx\n", vaddr);
>  	*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK | (paddr & PHYSICAL_PAGE_MASK);
>  
> -	if (vm_is_gpa_protected(vm, paddr))
> +	if (protected)>  		*pte |= vm->arch.c_bit;
>  	else
>  		*pte |= vm->arch.s_bit;
>  }
>  
> +void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, 
> +int level) {
> +	___virt_pg_map(vm, vaddr, paddr, level, vm_is_gpa_protected(vm, 
> +paddr)); }
> +
>  void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)  {
>  	__virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K);  }
>  
> +void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, 
> +uint64_t paddr) {
> +	___virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K, false); }

Here, it tries to create the guest mappings regardless of what the value
of protected_phy_pages is, which could create confusion.

> +
>  void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  		    uint64_t nr_bytes, int level)
>  {
> --
> 2.43.0.472.g3155946c3a-goog
> 

