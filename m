Return-Path: <linux-kselftest+bounces-40024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944D9B377B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 04:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFFA1B65554
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 02:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB942737EB;
	Wed, 27 Aug 2025 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHL3GrFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDB2727F4;
	Wed, 27 Aug 2025 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261454; cv=none; b=PDMiD67Cp+1DWH5dO5AO/EgCpiC8Xw4/EqPiuYhH4YWU2ZCqIyQmSTHPC7Bpqdsz+DHIA+mMW1CAE0L7bcQSxhT66pkllLbhhfMQAiurIcCuGyHdnFrsvDwrO2XmHAG0eFcYcRTbghg1bE1kxtWICk/CxVHpqof59m+aE/HYuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261454; c=relaxed/simple;
	bh=9O5covZ/PBS82MTmAF2q8dcGpYCmRc/sVWncSnvYRAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uc/hZjDmBQ5U+hYeCeVmXiuFSKI8IodCipwVYJOaf3wjXv12bThf1H/+7Zo1WpydCDvWE15TOeRjz60MJMvB57WSHt9imItwEmmiX6r0FhPnikWf3yQ/taH2uWAVisQZbeIw2XU6qKk6YTpyVLDKcJvnonCLB17KbjkRdXUOo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHL3GrFU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756261452; x=1787797452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9O5covZ/PBS82MTmAF2q8dcGpYCmRc/sVWncSnvYRAc=;
  b=IHL3GrFU71EtLWAs/UsgYpliZhdM87YxbfeYNz6xp280lvp/52dNGEQN
   5r6SSHD1eH84JHlCcj63d+XimrppfRzsG5SZiWIRKaCAr2cpVZy4gg+If
   ZddpGgetsUP2fjDbGnIqKjwDPAulQsZqbO/Sjx+GiQe6Jll/I5jeo14bJ
   6MlFsXITA1qUEKeMJpn0sgfYMeWrVjU16j//x5y96u9KSM4l4bIigv/dc
   bsDipghXlAccqdPA2Mwr8LwwGhxi650rsOuw5ouFpEU4Ic+qqi0U70cFQ
   Vmg0bZv+w1jyfOrNen2QK7Dqmt+N+Nab56ZPpRmCXfkuG2CU5DEAFLVOY
   w==;
X-CSE-ConnectionGUID: GeH7whp2QmClJTTD1RdwSQ==
X-CSE-MsgGUID: ux3Apb4yTiyUYfJwHnuDuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="68779100"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68779100"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 19:24:11 -0700
X-CSE-ConnectionGUID: WiWP+sYRRXuPPsYnRF+O5w==
X-CSE-MsgGUID: 5Epv/vZMTfa56PB0r65XfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="206893613"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.233.111]) ([10.124.233.111])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 19:24:06 -0700
Message-ID: <2a97db5e-ee82-43b0-a148-e4af1b93ca10@linux.intel.com>
Date: Wed, 27 Aug 2025 10:24:03 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/19] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
To: Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>
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
 <20250821042915.3712925-15-sagis@google.com>
 <aKwhchKBV1ts+Jhm@yzhao56-desk.sh.intel.com>
 <CAAhR5DGZnrpW8u9Y0O+EFLJJsbTVO6mdrh4jbG4CrFgR13Y60g@mail.gmail.com>
 <aK0IxsvmlNvc/u7j@yzhao56-desk.sh.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aK0IxsvmlNvc/u7j@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/26/2025 9:07 AM, Yan Zhao wrote:
> On Mon, Aug 25, 2025 at 02:02:00PM -0500, Sagi Shahar wrote:
>> On Mon, Aug 25, 2025 at 3:41 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
>>> On Wed, Aug 20, 2025 at 09:29:07PM -0700, Sagi Shahar wrote:
>>>> From: Ackerley Tng <ackerleytng@google.com>
>>>>
>>>> TDX protected memory needs to be measured and encrypted before it can be
>>>> used by the guest. Traverse the VM's memory regions and initialize all
>>>> the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
>>>>
>>>> Once all the memory is initialized, the VM can be finalized by calling
>>>> KVM_TDX_FINALIZE_VM.
>>>>
>>>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>>>> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
>>>> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
>>>> Co-developed-by: Sagi Shahar <sagis@google.com>
>>>> Signed-off-by: Sagi Shahar <sagis@google.com>
>>>> ---
>>>>   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
>>>>   .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 97 +++++++++++++++++++
>>>>   2 files changed, 99 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
>>>> index a2509959c7ce..2467b6c35557 100644
>>>> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
>>>> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
>>>> @@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
>>>>   void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
>>>>   void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
>>>>
>>>> +void vm_tdx_finalize(struct kvm_vm *vm);
>>>> +
>>>>   #endif // SELFTESTS_TDX_TDX_UTIL_H
>>>> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
>>>> index d8eab99d9333..4024587ed3c2 100644
>>>> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
>>>> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
>>>> @@ -274,3 +274,100 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>>>>
>>>>        free(init_vm);
>>>>   }
>>>> +
>>>> +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
>>>> +                             uint64_t gpa, uint64_t size)
>>>> +{
>>>> +     uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
>>>> +     struct kvm_tdx_init_mem_region mem_region = {
>>>> +             .source_addr = (uint64_t)source_pages,
>>>> +             .gpa = gpa,
>>>> +             .nr_pages = size / PAGE_SIZE,
>>>> +     };
>>>> +     struct kvm_vcpu *vcpu;
>>>> +
>>>> +     vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
>>>> +
>>>> +     TEST_ASSERT((mem_region.nr_pages > 0) &&
>>>> +                 ((mem_region.nr_pages * PAGE_SIZE) == size),
>>>> +                 "Cannot add partial pages to the guest memory.\n");
>>>> +     TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
>>>> +                 "Source memory buffer is not page aligned\n");
>>>> +     vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
>>>> +}
>>>> +
>>>> +static void tdx_init_pages(struct kvm_vm *vm, void *hva, uint64_t gpa,
>>>> +                        uint64_t size)
>>>> +{
>>>> +     void *scratch_page = calloc(1, PAGE_SIZE);
>>>> +     uint64_t nr_pages = size / PAGE_SIZE;
>>>> +     int i;
>>>> +
>>>> +     TEST_ASSERT(scratch_page,
>>>> +                 "Could not allocate memory for loading memory region");
>>>> +
>>>> +     for (i = 0; i < nr_pages; i++) {
>>>> +             memcpy(scratch_page, hva, PAGE_SIZE);
>>>> +
>>>> +             tdx_init_mem_region(vm, scratch_page, gpa, PAGE_SIZE);
>>>> +
>>>> +             hva += PAGE_SIZE;
>>>> +             gpa += PAGE_SIZE;
>>>> +     }
>>>> +
>>>> +     free(scratch_page);
>>>> +}
>>>> +
>>>> +static void load_td_private_memory(struct kvm_vm *vm)
>>>> +{
>>>> +     struct userspace_mem_region *region;
>>>> +     int ctr;
>>>> +
>>>> +     hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
>>>> +             const struct sparsebit *protected_pages = region->protected_phy_pages;
>>>> +             const vm_paddr_t gpa_base = region->region.guest_phys_addr;
>>>> +             const uint64_t hva_base = region->region.userspace_addr;
>>>> +             const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
>>>> +
>>>> +             sparsebit_idx_t i;
>>>> +             sparsebit_idx_t j;
>>>> +
>>>> +             if (!sparsebit_any_set(protected_pages))
>>>> +                     continue;
>>>> +
>>>> +             sparsebit_for_each_set_range(protected_pages, i, j) {
>>>> +                     const uint64_t size_to_load = (j - i + 1) * vm->page_size;
>>>> +                     const uint64_t offset =
>>>> +                             (i - lowest_page_in_region) * vm->page_size;
>>>> +                     const uint64_t hva = hva_base + offset;
>>>> +                     const uint64_t gpa = gpa_base + offset;
>>>> +
>>>> +                     vm_set_memory_attributes(vm, gpa, size_to_load,
>>>> +                                              KVM_MEMORY_ATTRIBUTE_PRIVATE);
>>>> +
>>>> +                     /*
>>>> +                      * Here, memory is being loaded from hva to gpa. If the memory
>>>> +                      * mapped to hva is also used to back gpa, then a copy has to be
>>>> +                      * made just for loading, since KVM_TDX_INIT_MEM_REGION ioctl
>>>> +                      * cannot encrypt memory in place.
>>>> +                      *
>>>> +                      * To determine if memory mapped to hva is also used to back
>>>> +                      * gpa, use a heuristic:
>>>> +                      *
>>>> +                      * If this memslot has guest_memfd, then this memslot should
>>>> +                      * have memory backed from two sources: hva for shared memory
>>>> +                      * and gpa will be backed by guest_memfd.
>>>> +                      */
>>>> +                     if (region->region.guest_memfd == -1)
>>> Why to pass !guest_memfd region to tdx_init_mem_region()?
>>>
>> Not sure I understand your comment.
>  From the implementation of tdx_init_pages(), it also invokes
> tdx_init_mem_region(), which further invokes ioctl KVM_TDX_INIT_MEM_REGION.
>
> However, if the region is with guest_memfd == -1, the ioctl
> KVM_TDX_INIT_MEM_REGION should fail as kvm_gmem_populate() won't succeed.
>
> So, I'm wondering why there's a need to for the case of
> "region->region.guest_memfd == -1".
>
> Or anything I missed?
I had the same question in v8
https://lore.kernel.org/lkml/4b7e7099-79da-4178-8f16-6780d8137ae1@linux.intel.com/

I guess the code path for non-guest_memfd is due to some old versions of TDX KVM
code before upstream. Currently, KVM doesn't support private memory from
non-guest_memfd backed memory.

>
>>>> +                             tdx_init_pages(vm, (void *)hva, gpa, size_to_load);
>>>> +                     else
>>>> +                             tdx_init_mem_region(vm, (void *)hva, gpa, size_to_load);
>>>> +             }
>>>> +     }
>>>> +}
>>>> +
>>>> +void vm_tdx_finalize(struct kvm_vm *vm)
>>>> +{
>>>> +     load_td_private_memory(vm);
>>>> +     vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
>>>> +}
>>>> --
>>>> 2.51.0.rc1.193.gad69d77794-goog
>>>>
>>>>


