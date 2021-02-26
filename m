Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A6A325D4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 06:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBZFt3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Feb 2021 00:49:29 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2590 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZFt2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Feb 2021 00:49:28 -0500
Received: from dggeme711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DmzD02MpYzWCW0;
        Fri, 26 Feb 2021 13:46:08 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme711-chm.china.huawei.com (10.1.199.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 26 Feb 2021 13:48:44 +0800
Subject: Re: [RFC PATCH v2 6/7] KVM: selftests: Adapt
 vm_userspace_mem_region_add to new helpers
To:     Ben Gardon <bgardon@google.com>
CC:     kvm <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
References: <20210225055940.18748-1-wangyanan55@huawei.com>
 <20210225055940.18748-7-wangyanan55@huawei.com>
 <CANgfPd9EF6Yc_SAR9sRY7oXMx3um+6phb71yNL=AsHDV4+tCRA@mail.gmail.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <cb2cc0d3-2914-435c-ad7c-e637ef66e213@huawei.com>
Date:   Fri, 26 Feb 2021 13:48:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd9EF6Yc_SAR9sRY7oXMx3um+6phb71yNL=AsHDV4+tCRA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme711-chm.china.huawei.com (10.1.199.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2021/2/26 7:44, Ben Gardon wrote:
> On Wed, Feb 24, 2021 at 10:03 PM Yanan Wang <wangyanan55@huawei.com> wrote:
>> With VM_MEM_SRC_ANONYMOUS_THP specified in vm_userspace_mem_region_add(),
>> we have to get the transparent hugepage size for HVA alignment. With the
>> new helpers, we can use get_backing_src_pagesz() to check whether THP is
>> configured and then get the exact configured hugepage size.
>>
>> As different architectures may have different THP page sizes configured,
>> this can get the accurate THP page sizes on any platform.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   tools/testing/selftests/kvm/lib/kvm_util.c | 27 +++++++---------------
>>   1 file changed, 8 insertions(+), 19 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index b91c8e3a7ee1..0105fbfed036 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -18,7 +18,6 @@
>>   #include <unistd.h>
>>   #include <linux/kernel.h>
>>
>> -#define KVM_UTIL_PGS_PER_HUGEPG 512
>>   #define KVM_UTIL_MIN_PFN       2
>>
>>   /* Aligns x up to the next multiple of size. Size must be a power of 2. */
>> @@ -686,7 +685,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>>   {
>>          int ret;
>>          struct userspace_mem_region *region;
>> -       size_t huge_page_size = KVM_UTIL_PGS_PER_HUGEPG * vm->page_size;
>> +       size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
>>          size_t alignment;
>>
>>          TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
>> @@ -748,7 +747,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>>   #endif
>>
>>          if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
>> -               alignment = max(huge_page_size, alignment);
>> +               alignment = max(backing_src_pagesz, alignment);
>>
>>          /* Add enough memory to align up if necessary */
>>          if (alignment > 1)
>> @@ -767,22 +766,12 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>>          region->host_mem = align(region->mmap_start, alignment);
>>
>>          /* As needed perform madvise */
>> -       if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
>> -               struct stat statbuf;
>> -
>> -               ret = stat("/sys/kernel/mm/transparent_hugepage", &statbuf);
>> -               TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
>> -                           "stat /sys/kernel/mm/transparent_hugepage");
>> -
>> -               TEST_ASSERT(ret == 0 || src_type != VM_MEM_SRC_ANONYMOUS_THP,
>> -                           "VM_MEM_SRC_ANONYMOUS_THP requires THP to be configured in the host kernel");
>> -
>> -               if (ret == 0) {
>> -                       ret = madvise(region->host_mem, npages * vm->page_size,
>> -                                     src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
>> -                       TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %x",
>> -                                   region->host_mem, npages * vm->page_size, src_type);
>> -               }
>> +       if (src_type <= VM_MEM_SRC_ANONYMOUS_THP && thp_configured()) {
> This check relies on an unstated property of the backing src type
> enums where VM_MEM_SRC_ANONYMOUS and VM_MEM_SRC_ANONYMOUS_THP are
> declared first.
> It would probably be more readable for folks if the check was explicit:
> if ((src_type == VM_MEM_SRC_ANONYMOUS || src_type ==
> VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
>
Yes, this makes sense, I will fix it.

Thanks,

Yanan

>> +               ret = madvise(region->host_mem, npages * vm->page_size,
>> +                             src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
>> +               TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
>> +                           region->host_mem, npages * vm->page_size,
>> +                           vm_mem_backing_src_alias(src_type)->name);
>>          }
>>
>>          region->unused_phy_pages = sparsebit_alloc();
>> --
>> 2.19.1
>>
> .
