Return-Path: <linux-kselftest+bounces-41107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20514B50E7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754CB18852D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BE12D7DD6;
	Wed, 10 Sep 2025 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clr6bm+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3925C802;
	Wed, 10 Sep 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486986; cv=none; b=dtTBt6BQX9s/ZDOABi/iZy1Gy4uVnMSvFFq6czuXtRZ5MdNZAcwPwJh6gI0GkWiYLTh3KdeQo4dFR+PH3nymMDd/bVMvT7tiRv0vJiFc53EE+NI2YqaHby7AcNpmxdLQ+ozuNjcDDPPav2SM5f2NCs+uiuNN4GnNUUl0m8QQnpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486986; c=relaxed/simple;
	bh=tM264F131NSVRDDSixKUn6MfaXc6ISwBU0d2l7UtgHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VR16yqsKrKlGahCIN5zPYEjuybUsKtORifVRwimLyrhB4YVG0YRfZVDT8w3uADWhujE6XdCKIIjRCKb66v0dley/pI/MV49JxeiS+hLTA6MAp47alWfS6Dqw3RINA21COCF+KFM8IC1uAhokwiSWheI7VjWZh5jdH1iO0whMU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clr6bm+D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757486985; x=1789022985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tM264F131NSVRDDSixKUn6MfaXc6ISwBU0d2l7UtgHE=;
  b=clr6bm+DMt8JAv4bU7yLppSuw6rmjs2aN8q4BjPMeyJkZSCxIYgz7Ik2
   NO1B4o+80hIK6nVxPnvlCv1ZaN3lBW71LOFxUFsCAR6j3JAVCP6xP80T8
   1NOcSBjGf3S81RiyeCBhNNb4/2SgX4DI3N1YOwrp7xnz6PPmPBGgJzaGV
   4vkZ1yLbWsas9/f1nZYetfgEGICCfbmO/XKCvd9KE61WNCD+mioO+/qLy
   pBhjwJYutsWMU7Snp8CsoHpCKeyAosKxAByqY8CSselav8D040TSZxaz3
   0lhD2RovQUGim1u49NgcdkREuPKFz9LZTubdne6AtWJujG/2Sg534wKi6
   g==;
X-CSE-ConnectionGUID: xSQ+AJYNQ2CeVLTUr6YeUg==
X-CSE-MsgGUID: EBYoJiNOQ8itdl1bHsZlqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="63616652"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="63616652"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 23:49:44 -0700
X-CSE-ConnectionGUID: eJBOefZ2RaGYOfcyOR9Wgg==
X-CSE-MsgGUID: zWcCrSzfTn+nVXkT9u3aiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="177637509"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 23:49:39 -0700
Message-ID: <461c050a-b1f6-445a-867e-d43997046581@linux.intel.com>
Date: Wed, 10 Sep 2025 14:49:37 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 13/21] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
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
 <20250904065453.639610-14-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-14-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> TDX protected memory needs to be measured and encrypted before it can be
> used by the guest. Traverse the VM's memory regions and initialize all
> the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
>
> Once all the memory is initialized, the VM can be finalized by calling
> KVM_TDX_FINALIZE_VM.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
>   .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 61 +++++++++++++++++++
>   2 files changed, 63 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index a2509959c7ce..2467b6c35557 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
>   void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
>   void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
>   
> +void vm_tdx_finalize(struct kvm_vm *vm);
> +
>   #endif // SELFTESTS_TDX_TDX_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 1b5c01faf1cd..d5df2de81a75 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -273,3 +273,64 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>   
>   	free(init_vm);
>   }
> +
> +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
> +				uint64_t gpa, uint64_t size)
> +{
> +	uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
> +	struct kvm_tdx_init_mem_region mem_region = {
> +		.source_addr = (uint64_t)source_pages,
> +		.gpa = gpa,
> +		.nr_pages = size / PAGE_SIZE,
> +	};
> +	struct kvm_vcpu *vcpu;
> +
> +	vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
> +
> +	TEST_ASSERT((mem_region.nr_pages > 0) &&
> +		    ((mem_region.nr_pages * PAGE_SIZE) == size),
> +		    "Cannot add partial pages to the guest memory.\n");
> +	TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
> +		    "Source memory buffer is not page aligned\n");
> +	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
> +}
> +
> +static void load_td_private_memory(struct kvm_vm *vm)
> +{
> +	struct userspace_mem_region *region;
> +	int ctr;
> +
> +	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
> +		const struct sparsebit *protected_pages = region->protected_phy_pages;
> +		const vm_paddr_t gpa_base = region->region.guest_phys_addr;
> +		const uint64_t hva_base = region->region.userspace_addr;
> +		const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
> +

A spare white line?

> +		sparsebit_idx_t i;
> +		sparsebit_idx_t j;

i and j could be defined in one line.

> +
> +		if (!sparsebit_any_set(protected_pages))
> +			continue;
> +
> +		TEST_ASSERT(region->region.guest_memfd != -1,
> +			    "TD private memory must be backed by guest_memfd");
> +
> +		sparsebit_for_each_set_range(protected_pages, i, j) {
> +			const uint64_t size_to_load = (j - i + 1) * vm->page_size;
> +			const uint64_t offset =
> +				(i - lowest_page_in_region) * vm->page_size;
> +			const uint64_t hva = hva_base + offset;
> +			const uint64_t gpa = gpa_base + offset;
> +
> +			vm_set_memory_attributes(vm, gpa, size_to_load,
> +						 KVM_MEMORY_ATTRIBUTE_PRIVATE);
Nit:
There is a helper vm_mem_set_private() for it.

> +			tdx_init_mem_region(vm, (void *)hva, gpa, size_to_load);
> +		}
> +	}
> +}
> +
> +void vm_tdx_finalize(struct kvm_vm *vm)
> +{
> +	load_td_private_memory(vm);
> +	vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> +}


