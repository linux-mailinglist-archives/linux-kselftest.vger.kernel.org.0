Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE75D315ED0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Feb 2021 06:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBJFOa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Feb 2021 00:14:30 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3437 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhBJFOa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Feb 2021 00:14:30 -0500
Received: from dggeme763-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Db7DL6dLyz5Qfn;
        Wed, 10 Feb 2021 13:12:18 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 10 Feb 2021 13:13:42 +0800
Subject: Re: [RFC PATCH 2/2] KVM: selftests: Add a test for kvm page table
 code
To:     Ben Gardon <bgardon@google.com>
CC:     kvm <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
References: <20210208090841.333724-1-wangyanan55@huawei.com>
 <20210208090841.333724-3-wangyanan55@huawei.com>
 <CANgfPd_yrtEmmm4_O+WaZTMXmW5gxQmJiwMk0JAswkrH+aYjsw@mail.gmail.com>
 <a7adf6ff-195f-6494-39c2-4b8592281309@huawei.com>
 <CANgfPd8NBM3TSVBU+jbY-wVf5r+x=wPBBZGYMXLUx6cc8_ZiAw@mail.gmail.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <20b6ca04-1883-8545-127e-20a83a57a007@huawei.com>
Date:   Wed, 10 Feb 2021 13:13:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd8NBM3TSVBU+jbY-wVf5r+x=wPBBZGYMXLUx6cc8_ZiAw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2021/2/10 1:38, Ben Gardon wrote:
> On Mon, Feb 8, 2021 at 11:22 PM wangyanan (Y) <wangyanan55@huawei.com> wrote:
>> Hi Ben,
>>
>> On 2021/2/9 4:29, Ben Gardon wrote:
>>> On Mon, Feb 8, 2021 at 1:08 AM Yanan Wang <wangyanan55@huawei.com> wrote:
>>>> This test serves as a performance tester and a bug reproducer for
>>>> kvm page table code (GPA->HPA mappings), so it gives guidance for
>>>> people trying to make some improvement for kvm.
>>>>
>>>> The function guest_code() is designed to cover conditions where a single vcpu
>>>> or multiple vcpus access guest pages within the same memory range, in three
>>>> VM stages(before dirty-logging, during dirty-logging, after dirty-logging).
>>>> Besides, the backing source memory type(ANONYMOUS/THP/HUGETLB) of the tested
>>>> memory region can be specified by users, which means normal page mappings or
>>>> block mappings can be chosen by users to be created in the test.
>>>>
>>>> If use of ANONYMOUS memory is specified, kvm will create page mappings for the
>>>> tested memory region before dirty-logging, and update attributes of the page
>>>> mappings from RO to RW during dirty-logging. If use of THP/HUGETLB memory is
>>>> specified, kvm will create block mappings for the tested memory region before
>>>> dirty-logging, and split the blcok mappings into page mappings during
>>>> dirty-logging, and coalesce the page mappings back into block mappings after
>>>> dirty-logging is stopped.
>>>>
>>>> So in summary, as a performance tester, this test can present the performance
>>>> of kvm creating/updating normal page mappings, or the performance of kvm
>>>> creating/splitting/recovering block mappings, through execution time.
>>>>
>>>> When we need to coalesce the page mappings back to block mappings after dirty
>>>> logging is stopped, we have to firstly invalidate *all* the TLB entries for the
>>>> page mappings right before installation of the block entry, because a TLB conflict
>>>> abort error could occur if we can't invalidate the TLB entries fully. We have
>>>> hit this TLB conflict twice on aarch64 software implementation and fixed it.
>>>> As this test can imulate process from dirty-logging enabled to dirty-logging
>>>> stopped of a VM with block mappings, so it can also reproduce this TLB conflict
>>>> abort due to inadequate TLB invalidation when coalescing tables.
>>>>
>>>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>>> Thanks for sending this! Happy to see more tests for weird TLB
>>> flushing edge cases and races.
>>>
>>> Just out of curiosity, were you unable to replicate the bug with the
>>> dirty_log_perf_test and setting the wr_fract option?
>>> With "KVM: selftests: Disable dirty logging with vCPUs running"
>>> (https://lkml.org/lkml/2021/2/2/1431), the dirty_log_perf_test has
>>> most of the same features as this one.
>>> Please correct me if I'm wrong, but it seems like the major difference
>>> here is a more careful pattern of which pages are dirtied when.
>> Actually the procedures in KVM_UPDATE_MAPPINGS stage are specially
>> designed for
>> reproduce of the TLB conflict bug. The following explains why.
>> In x86 implementation, the related page mappings will be all destroyed
>> in advance when
>> stopping dirty logging while vcpus are still running. So after dirty
>> logging is successfully
>> stopped, there will certainly be page faults when accessing memory, and
>> KVM will handle
>> the faults and create block mappings once again. (Is this right?)
>> So in this case, dirty_log_perf_test can replicate the bug theoretically.
>>
>> But there is difference in ARM implementation. The related page mappings
>> will not be
>> destroyed immediately when stopping dirty logging and will  be kept
>> instead. And after
>> dirty logging, KVM will destroy these mappings together with creation of
>> block mappings
>> when handling a guest fault (page fault or permission fault).  So based
>> on guest_code() in
>> dirty_log_perf_test, there will not be any page faults after dirty
>> logging because all the
>> page mappings have been created and KVM has no chance to recover block
>> mappings
>> at all. So this is why I left half of the pages clean and another half
>> dirtied.
> Ah okay, I'm sorry. I shouldn't have assumed that ARM does the same
> thing as x86 when disabling dirty logging. It makes sense then why
> your guest code is so carefully structured. Does that mean that if a
> VM dirties all its memory during dirty logging, that it will never be
> able to reconstitute the broken down mappings into large page / block
> mappings?

Indeed, but it's really a rare case to happen. I think both the x86 way 
and ARM way have

it's own benefits and are based on different considerations. Anyway, the 
more carefully

structured code is compatible for the TLB bug of different architectures.

>>> Within Google we have a system for pre-specifying sets of arguments to
>>> e.g. the dirty_log_perf_test. I wonder if something similar, even as
>>> simple as a script that just runs dirty_log_perf_test several times
>>> would be helpful for cases where different arguments are needed for
>>> the test to cover different specific cases. Even with this test, for
>> I not sure I have got your point :), but it depends on what exactly the
>> specific cases are,
>> and sometimes we have to use different arguments. Is this right?
> Exactly, it might be kind of a moot point in this case though if the
> default arguments catch the TLB invalidation bug.
>
>>> example, I assume the test doesn't work very well with just 1 vCPU,
>>> but it's still a good default in the test, so having some kind of
>>> configuration (lite) file would be useful.
>> Actually it's only with 1 vCPU that the real efficiency of KVM page
>> table code path can be tested,
>> such as efficiency of creating new mappings or efficiency of updating
>> existing mappings.
>> And with numerous vCPUs, efficiency of KVM handling concurrent
>> conditions can be tested.
>>>> ---
>>>>    tools/testing/selftests/kvm/Makefile          |   3 +
>>>>    .../selftests/kvm/kvm_page_table_test.c       | 518 ++++++++++++++++++
>>>>    2 files changed, 521 insertions(+)
>>>>    create mode 100644 tools/testing/selftests/kvm/kvm_page_table_test.c
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>>>> index fe41c6a0fa67..697318019bd4 100644
>>>> --- a/tools/testing/selftests/kvm/Makefile
>>>> +++ b/tools/testing/selftests/kvm/Makefile
>>>> @@ -62,6 +62,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
>>>>    TEST_GEN_PROGS_x86_64 += demand_paging_test
>>>>    TEST_GEN_PROGS_x86_64 += dirty_log_test
>>>>    TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
>>>> +TEST_GEN_PROGS_x86_64 += kvm_page_table_test
>>>>    TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
>>>>    TEST_GEN_PROGS_x86_64 += set_memory_region_test
>>>>    TEST_GEN_PROGS_x86_64 += steal_time
>>>> @@ -71,6 +72,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
>>>>    TEST_GEN_PROGS_aarch64 += demand_paging_test
>>>>    TEST_GEN_PROGS_aarch64 += dirty_log_test
>>>>    TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
>>>> +TEST_GEN_PROGS_aarch64 += kvm_page_table_test
>>>>    TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
>>>>    TEST_GEN_PROGS_aarch64 += set_memory_region_test
>>>>    TEST_GEN_PROGS_aarch64 += steal_time
>>>> @@ -80,6 +82,7 @@ TEST_GEN_PROGS_s390x += s390x/resets
>>>>    TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>>>>    TEST_GEN_PROGS_s390x += demand_paging_test
>>>>    TEST_GEN_PROGS_s390x += dirty_log_test
>>>> +TEST_GEN_PROGS_s390x += kvm_page_table_test
>>>>    TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
>>>>    TEST_GEN_PROGS_s390x += set_memory_region_test
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
>>>> new file mode 100644
>>>> index 000000000000..b09c05288937
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
>>>> @@ -0,0 +1,518 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * KVM page table test
>>>> + * Based on dirty_log_test.c
>>>> + * Based on dirty_log_perf_test.c
>>>> + *
>>>> + * Copyright (C) 2018, Red Hat, Inc.
>>>> + * Copyright (C) 2020, Google, Inc.
>>>> + * Copyright (C) 2021, Huawei, Inc.
>>>> + *
>>>> + * Make sure that enough THP/HUGETLB pages have been allocated on systems
>>>> + * to cover the testing memory region before running this program, if you
>>>> + * wish to create block mappings in this test.
>>>> + */
>>>> +
>>>> +#define _GNU_SOURCE /* for program_invocation_name */
>>>> +
>>>> +#include <stdio.h>
>>>> +#include <stdlib.h>
>>>> +#include <time.h>
>>>> +#include <pthread.h>
>>>> +
>>>> +#include "test_util.h"
>>>> +#include "kvm_util.h"
>>>> +#include "processor.h"
>>>> +#include "guest_modes.h"
>>>> +
>>>> +#define TEST_MEM_SLOT_INDEX             1
>>>> +
>>>> +/* Default size(1GB) of the memory for testing */
>>>> +#define DEFAULT_TEST_MEM_SIZE          (1 << 30)
>>>> +
>>>> +/* Default guest test virtual memory offset */
>>>> +#define DEFAULT_GUEST_TEST_MEM         0xc0000000
>>>> +
>>>> +/* Different memory accessing types for a vcpu */
>>>> +enum access_type {
>>>> +       ACCESS_TYPE_READ,
>>>> +       ACCESS_TYPE_WRITE,
>>>> +       NUM_ACCESS_TYPES,
>>>> +};
>>>> +
>>>> +/* Different memory accessing stages for a vcpu */
>>>> +enum test_stage {
>>>> +       KVM_CREATE_MAPPINGS,
>>>> +       KVM_UPDATE_MAPPINGS,
>>>> +       KVM_ADJUST_MAPPINGS,
>>>> +       KVM_BEFORE_MAPPINGS,
>>> NIT: this might be easier to understand if it was first, since AFAIK
>>> KVM_BEFORE_MAPPINGS is the first state chronologically.
>>>
>>>> +       NUM_TEST_STAGES,
>>>> +};
>>>> +
>>>> +static const char * const access_type_string[] = {
>>>> +       "ACCESS_TYPE_READ ",
>>>> +       "ACCESS_TYPE_WRITE",
>>>> +};
>>>> +
>>>> +static const char * const test_stage_string[] = {
>>>> +       "KVM_CREATE_MAPPINGS",
>>>> +       "KVM_UPDATE_MAPPINGS",
>>>> +       "KVM_ADJUST_MAPPINGS",
>>>> +       "KVM_BEFORE_MAPPINGS",
>>>> +};
>>>> +
>>>> +struct perf_test_vcpu_args {
>>>> +       int vcpu_id;
>>>> +       enum access_type vcpu_access_type;
>>>> +};
>>>> +
>>>> +struct perf_test_args {
>>>> +       struct kvm_vm *vm;
>>>> +       uint64_t guest_test_virt_mem;
>>>> +       uint64_t host_page_size;
>>>> +       uint64_t host_num_pages;
>>>> +       uint64_t block_page_size;
>>>> +       uint64_t block_num_pages;
>>>> +       uint64_t host_pages_perblock;
>>> Is block a more common term in ARM than in x86? I don't think it makes
>>> too much difference, but most of the test's and code I've looked at
>>> use "huge page" to refer to 2M mappings and "large page" to refer
>>> generically to mappings bigger than the base page size. Unless block
>>> has some other specific meaning, I'd suggest:
>>>
>>> uint64_t large_page_size;
>>> uint64_t large_page_num_pages;
>>> uint64_t host_pages_per_large_page;
>>>
>>> or
>>>
>>> uint64_t lpage_size;
>>> uint64_t lpage_num_pages;
>>> uint64_t host_pages_per_lpage;
>>>
>>> and so on through the file.
>>>
>>>> +       enum vm_mem_backing_src_type backing_src_type;
>>>> +       struct perf_test_vcpu_args vcpu_args[KVM_MAX_VCPUS];
>>>> +};
>>>> +
>>>> +/*
>>>> + * Guest variables. Use addr_gva2hva() if these variables need
>>>> + * to be changed in host.
>>>> + */
>>>> +static enum test_stage guest_test_stage;
>>>> +
>>>> +/* Host variables */
>>>> +static uint32_t nr_vcpus = 1;
>>>> +static struct perf_test_args perf_test_args;
>>>> +static enum test_stage *current_stage;
>>>> +static enum test_stage vcpu_last_completed_stage[KVM_MAX_VCPUS];
>>>> +static bool host_quit;
>>>> +
>>>> +/*
>>>> + * Guest physical memory offset of the testing memory slot.
>>>> + * This will be set to the topmost valid physical address minus
>>>> + * the test memory size.
>>>> + */
>>>> +static uint64_t guest_test_phys_mem;
>>>> +
>>>> +/*
>>>> + * Guest virtual memory offset of the testing memory slot.
>>>> + * Must not conflict with identity mapped test code.
>>>> + */
>>>> +static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
>>>> +
>>>> +static void guest_code(int vcpu_id)
>>>> +{
>>>> +       struct perf_test_vcpu_args *vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
>>>> +       enum vm_mem_backing_src_type src_type = perf_test_args.backing_src_type;
>>>> +       uint64_t host_page_size = perf_test_args.host_page_size;
>>>> +       uint64_t host_num_pages = perf_test_args.host_num_pages;
>>>> +       uint64_t block_page_size = perf_test_args.block_page_size;
>>>> +       uint64_t block_num_pages = perf_test_args.block_num_pages;
>>>> +       uint64_t host_pages_perblock = perf_test_args.host_pages_perblock;
>>>> +       uint64_t half = host_pages_perblock / 2;
>>>> +       enum access_type vcpu_access_type;
>>>> +       enum test_stage stage;
>>>> +       uint64_t addr;
>>>> +       int i, j;
>>>> +
>>>> +       /* Make sure vCPU args data structure is not corrupt */
>>>> +       GUEST_ASSERT(vcpu_args->vcpu_id == vcpu_id);
>>>> +       vcpu_access_type = vcpu_args->vcpu_access_type;
>>>> +
>>>> +       while (true) {
>>>> +               stage = READ_ONCE(guest_test_stage);
>>>> +               addr = perf_test_args.guest_test_virt_mem;
>>>> +
>>>> +               switch (stage) {
>>>> +               /*
>>>> +                * Before dirty-logging, vCPUs concurrently access the first
>>>> +                * 8 bytes of pages within the same memory range with different
>>>> +                * and random access types(read or write). Then KVM will create
>>>> +                * mappings for them (page mappings or block mappings).
>>>> +                */
>>>> +               case KVM_CREATE_MAPPINGS:
>>>> +                       for (i = 0; i < block_num_pages; i++) {
>>>> +                               if (vcpu_access_type == ACCESS_TYPE_READ)
>>>> +                                       READ_ONCE(*(uint64_t *)addr);
>>>> +                               else
>>>> +                                       *(uint64_t *)addr = 0x0123456789ABCDEF;
>>>> +
>>>> +                               addr += block_page_size;
>>>> +                       }
>>>> +                       break;
>>>> +
>>>> +               /*
>>>> +                * During dirty-logging, KVM will only update attributes of the
>>>> +                * normal page mappings from RO to RW if backing source type is
>>>> +                * anonymous, and will split the block mappings into normal page
>>>> +                * mappings if backing source type is THP or HUGETLB.
>>>> +                */
>>>> +               case KVM_UPDATE_MAPPINGS:
>>>> +                       if (src_type == VM_MEM_SRC_ANONYMOUS) {
>>>> +                               for (i = 0; i < host_num_pages; i++) {
>>>> +                                       *(uint64_t *)addr = 0x0123456789ABCDEF;
>>>> +                                       addr += host_page_size;
>>>> +                               }
>>>> +                               break;
>>>> +                       }
>>>> +
>>>> +                       for (i = 0; i < block_num_pages; i++) {
>>>> +                               /* Write to the first host page of each block */
>>>> +                               *(uint64_t *)addr = 0x0123456789ABCDEF;
>>>> +
>>>> +                               /* Create half new page mappings for each block */
>>> suggestion:
>>> /*
>>>    * Access the middle page in each large page region. Since dirty
>>> logging is enabled,
>>>    * this will create a new mapping at the smallest page granularity.
>>>    */
>>>
>>>
>>>> +                               addr += host_page_size * half;
>>>> +                               for (j = half; j < host_pages_perblock; j++) {
>>>> +                                       READ_ONCE(*(uint64_t *)addr);
>>>> +                                       addr += host_page_size;
>>>> +                               }
>>>> +                       }
>>>> +                       break;
>>>> +
>>>> +               /*
>>>> +                * After dirty-logging is stopped, vCPUs concurrently read from
>>>> +                * every single host page. Then KVM will coalesce the splitted
>>>> +                * page mappings back to block mappings. And a TLB conflict abort
>>>> +                * could occur here if TLB entries of the page mappings are not
>>>> +                * fully invalidated.
>>>> +                */
>>>> +               case KVM_ADJUST_MAPPINGS:
>>>> +                       for (i = 0; i < host_num_pages; i++) {
>>>> +                               READ_ONCE(*(uint64_t *)addr);
>>>> +                               addr += host_page_size;
>>>> +                       }
>>>> +                       break;
>>>> +
>>>> +               default:
>>>> +                       break;
>>>> +               }
>>>> +
>>>> +               GUEST_SYNC(1);
>>>> +       }
>>>> +}
>>>> +
>>>> +static void *vcpu_worker(void *data)
>>>> +{
>>>> +       int ret;
>>>> +       struct perf_test_vcpu_args *vcpu_args = data;
>>>> +       struct kvm_vm *vm = perf_test_args.vm;
>>>> +       int vcpu_id = vcpu_args->vcpu_id;
>>>> +       struct kvm_run *run;
>>>> +       struct timespec start;
>>>> +       struct timespec ts_diff;
>>>> +       enum test_stage stage;
>>>> +
>>>> +       vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
>>>> +       run = vcpu_state(vm, vcpu_id);
>>>> +
>>>> +       while (!READ_ONCE(host_quit)) {
>>>> +               clock_gettime(CLOCK_MONOTONIC, &start);
>>>> +               ret = _vcpu_run(vm, vcpu_id);
>>>> +               ts_diff = timespec_diff_now(start);
>>>> +
>>>> +               TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
>>>> +
>>>> +               TEST_ASSERT(get_ucall(vm, vcpu_id, NULL) == UCALL_SYNC,
>>>> +                           "Invalid guest sync status: exit_reason=%s\n",
>>>> +                           exit_reason_str(run->exit_reason));
>>>> +
>>>> +               pr_debug("Got sync event from vCPU %d\n", vcpu_id);
>>>> +               stage = READ_ONCE(*current_stage);
>>>> +               vcpu_last_completed_stage[vcpu_id] = stage;
>>>> +               pr_debug("vCPU %d has completed stage %s\n"
>>>> +                        "execution time is: %ld.%.9lds\n\n",
>>>> +                        vcpu_id, test_stage_string[stage],
>>>> +                        ts_diff.tv_sec, ts_diff.tv_nsec);
>>>> +
>>>> +               while (stage == READ_ONCE(*current_stage) &&
>>>> +                      !READ_ONCE(host_quit)) {}
>>>> +       }
>>>> +
>>>> +       return NULL;
>>>> +}
>>>> +
>>>> +struct test_params {
>>>> +       enum vm_mem_backing_src_type backing_src_type;
>>>> +       uint64_t backing_src_granule;
>>> Nit: suggest changing this to block_page_size (or large_page_size) as
>>> you use below. (block|large)_page_size is easier for me to read.
>> Thanks for all the above suggestions, I will make adjustments accordingly.
>>>> +       uint64_t test_mem_size;
>>>> +       uint64_t phys_offset;
>>>> +};
>>>> +
>>>> +static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
>>>> +{
>>>> +       struct test_params *p = arg;
>>>> +       struct perf_test_vcpu_args *vcpu_args;
>>>> +       uint64_t guest_page_size, guest_num_pages, host_page_size;
>>>> +       uint64_t block_page_size = p->backing_src_granule;
>>>> +       uint64_t test_mem_size = p->test_mem_size, test_num_pages;
>>>> +       void * host_test_mem;
>>>> +       struct kvm_vm *vm;
>>>> +       int vcpu_id;
>>>> +
>>>> +       guest_page_size = vm_guest_mode_params[mode].page_size;
>>>> +       host_page_size = getpagesize();
>>>> +
>>>> +       /*
>>>> +        * Ensure that testing memory size is aligned to guest page size,
>>>> +        * host page size and block page size, and that block page size
>>>> +        * is aligned to host page size.
>>>> +        */
>>>> +       TEST_ASSERT(test_mem_size % guest_page_size == 0,
>>>> +                   "Testing memory size is not guest page size aligned.");
>>>> +       TEST_ASSERT(test_mem_size % block_page_size  == 0,
>>>> +                   "Testing memory size is not block page size aligned.");
>>>> +       TEST_ASSERT(block_page_size % host_page_size == 0,
>>>> +                   "Block page size is not host page size aligned.");
>>>> +
>>>> +       guest_num_pages = test_mem_size / guest_page_size;
>>>> +       test_num_pages = test_mem_size / MIN_PAGE_SIZE;
>>>> +       vm = vm_create_with_vcpus(mode, nr_vcpus, test_num_pages, 0, guest_code, NULL);
>>>> +
>>>> +       if (!p->phys_offset) {
>>>> +               guest_test_phys_mem = (vm_get_max_gfn(vm) -
>>>> +                                      guest_num_pages) * guest_page_size;
>>>> +               guest_test_phys_mem &= ~(block_page_size - 1);
>>>> +       } else {
>>>> +               guest_test_phys_mem = p->phys_offset;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * Ensure that guest physical offset of the testing memory slot is
>>>> +        * block page size aligned, so that block mappings can be created
>>>> +        * successfully by KVM.
>>>> +        */
>>>> +       TEST_ASSERT(guest_test_phys_mem % block_page_size == 0,
>>>> +                   "Guest physical offset is not block page size aligned.");
>>>> +#ifdef __s390x__
>>>> +       /* Align to 1M (segment size) */
>>>> +       guest_test_phys_mem &= ~((1 << 20) - 1);
>>>> +#endif
>>>> +
>>>> +       /* Set up the shared data structure perf_test_args */
>>>> +       perf_test_args.vm = vm;
>>>> +       perf_test_args.guest_test_virt_mem = guest_test_virt_mem;
>>>> +       perf_test_args.host_page_size = host_page_size;
>>>> +       perf_test_args.host_num_pages = test_mem_size / host_page_size;
>>>> +       perf_test_args.block_page_size = block_page_size;
>>>> +       perf_test_args.block_num_pages = test_mem_size / block_page_size;
>>>> +       perf_test_args.host_pages_perblock = block_page_size / host_page_size;
>>>> +       perf_test_args.backing_src_type = p->backing_src_type;
>>>> +
>>>> +       for(vcpu_id = 0; vcpu_id < KVM_MAX_VCPUS; vcpu_id++) {
>>>> +               vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
>>>> +               vcpu_args->vcpu_id = vcpu_id;
>>>> +               vcpu_args->vcpu_access_type = random() % NUM_ACCESS_TYPES;
>>>> +               pr_debug("Set access type of vCPU %d as %s\n",
>>>> +                        access_type_string[vcpu_args->vcpu_access_type]);
>>>> +
>>>> +               vcpu_last_completed_stage[vcpu_id] = NUM_TEST_STAGES;
>>>> +       }
>>>> +
>>>> +       /* Add an extra memory slot with specified backing source type */
>>>> +       vm_userspace_mem_region_add(vm, p->backing_src_type,
>>>> +                                   guest_test_phys_mem,
>>>> +                                   TEST_MEM_SLOT_INDEX,
>>>> +                                   guest_num_pages, 0);
>>>> +
>>>> +       /* Do mapping for the testing memory slot */
>>>> +       virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_pages, 0);
>>>> +
>>>> +       /* Cache the HVA pointer of the region */
>>>> +       host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
>>>> +
>>>> +       /* Export shared structure perf_test_args to guest */
>>>> +       ucall_init(vm, NULL);
>>>> +       sync_global_to_guest(vm, perf_test_args);
>>>> +
>>>> +       current_stage = addr_gva2hva(vm, (vm_vaddr_t)(&guest_test_stage));
>>>> +       *current_stage = NUM_TEST_STAGES;
>>>> +
>>>> +       pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
>>>> +       pr_info("Testing backing source type: %s\n",
>>>> +               vm_mem_backing_src_type_string(p->backing_src_type));
>>>> +       pr_info("Testing backing source granule: 0x%lx\n", block_page_size);
>>>> +       pr_info("Testing memory size: 0x%lx\n", test_mem_size);
>>>> +       pr_info("Guest physical test memory offset: 0x%lx\n",
>>>> +               guest_test_phys_mem);
>>>> +       pr_info("Host  virtual  test memory offset: 0x%lx\n",
>>>> +               (uint64_t)host_test_mem);
>>>> +       pr_info("Number of testing vCPUs: %d\n", nr_vcpus);
>>>> +
>>>> +       return vm;
>>>> +}
>>>> +
>>>> +static void run_test(enum vm_guest_mode mode, void *arg)
>>>> +{
>>>> +       pthread_t *vcpu_threads;
>>>> +       struct kvm_vm *vm;
>>>> +       int vcpu_id;
>>>> +       enum test_stage stage;
>>>> +       struct timespec start;
>>>> +       struct timespec ts_diff;
>>>> +
>>>> +       /* Create VM with vCPUs and make some pre-initialization */
>>>> +       vm = pre_init_before_test(mode, arg);
>>>> +
>>>> +       vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
>>>> +       TEST_ASSERT(vcpu_threads, "Memory allocation failed");
>>>> +
>>>> +       host_quit = false;
>>>> +       stage = KVM_BEFORE_MAPPINGS;
>>>> +       *current_stage = stage;
>>>> +
>>>> +       for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
>>>> +               pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
>>>> +                              &perf_test_args.vcpu_args[vcpu_id]);
>>>> +       }
>>>> +       for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
>>>> +               while (READ_ONCE(vcpu_last_completed_stage[vcpu_id]) != stage)
>>>> +                       pr_debug("Waiting for vCPU %d to complete stage %s\n",
>>>> +                                vcpu_id, test_stage_string[stage]);
>>>> +       }
>>>> +       pr_info("Started all vCPUs successfully\n");
>>>> +
>>>> +       /* Test the stage of KVM creating mappings */
>>>> +       clock_gettime(CLOCK_MONOTONIC, &start);
>>>> +       stage = KVM_CREATE_MAPPINGS;
>>>> +       *current_stage = stage;
>>>> +
>>>> +       for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
>>>> +               while (READ_ONCE(vcpu_last_completed_stage[vcpu_id]) != stage)
>>>> +                       pr_debug("Waiting for vCPU %d to complete stage %s\n",
>>>> +                                vcpu_id, test_stage_string[stage]);
>>>> +       }
>>>> +
>>>> +       ts_diff = timespec_diff_now(start);
>>>> +       pr_info("KVM_CREATE_MAPPINGS: total execution time: %ld.%.9lds\n\n",
>>>> +               ts_diff.tv_sec, ts_diff.tv_nsec);
>>>> +
>>>> +       /* Test the stage of KVM updating mappings */
>>>> +       vm_mem_region_set_flags(vm, TEST_MEM_SLOT_INDEX, KVM_MEM_LOG_DIRTY_PAGES);
>>>> +
>>>> +       clock_gettime(CLOCK_MONOTONIC, &start);
>>>> +       stage = KVM_UPDATE_MAPPINGS;
>>>> +       *current_stage = stage;
>>>> +
>>>> +       for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
>>>> +               while (READ_ONCE(vcpu_last_completed_stage[vcpu_id]) != stage)
>>>> +                       pr_debug("Waiting for vCPU %d to complete stage %s\n",
>>>> +                                vcpu_id, test_stage_string[stage]);
>>>> +       }
>>>> +
>>>> +       ts_diff = timespec_diff_now(start);
>>>> +       pr_info("KVM_UPDATE_MAPPINGS: total execution time: %ld.%.9lds\n\n",
>>>> +               ts_diff.tv_sec, ts_diff.tv_nsec);
>>>> +
>>>> +       /* Test the stage of KVM adjusting mappings */
>>>> +       vm_mem_region_set_flags(vm, TEST_MEM_SLOT_INDEX, 0);
>>>> +
>>>> +       clock_gettime(CLOCK_MONOTONIC, &start);
>>>> +       stage = KVM_ADJUST_MAPPINGS;
>>>> +       *current_stage = stage;
>>>> +
>>>> +       for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
>>>> +               while (READ_ONCE(vcpu_last_completed_stage[vcpu_id]) != stage)
>>>> +                       pr_debug("Waiting for vCPU %d to complete stage %s\n",
>>>> +                                vcpu_id, test_stage_string[stage]);
>>>> +       }
>>>> +
>>>> +       ts_diff = timespec_diff_now(start);
>>>> +       pr_info("KVM_ADJUST_MAPPINGS: total execution time: %ld.%.9lds\n\n",
>>>> +               ts_diff.tv_sec, ts_diff.tv_nsec);
>>>> +
>>>> +       /* Tell the vcpu thread to quit */
>>>> +       host_quit = true;
>>>> +       for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++)
>>>> +               pthread_join(vcpu_threads[vcpu_id], NULL);
>>>> +
>>>> +       free(vcpu_threads);
>>>> +       ucall_uninit(vm);
>>>> +       kvm_vm_free(vm);
>>>> +}
>>>> +
>>>> +static void vm_mem_backing_src_types_help(void)
>>>> +{
>>>> +       int i;
>>>> +
>>>> +       printf(" -t: specify backing source type of the testing memory region\n"
>>>> +              "     (default: VM_MEM_SRC_ANONYMOUS)\n"
>>>> +              "     Backing source type IDs:\n");
>>>> +
>>>> +       for (i = 0; i < NUM_VM_BACKING_SRC_TYPES; i++)
>>>> +               printf("         %d:    %s\n", i,  vm_mem_backing_src_type_string(i));
>>>> +}
>>>> +
>>>> +static void help(char *name)
>>>> +{
>>>> +       puts("");
>>>> +       printf("usage: %s [-h] [-m mode] [-t type] [-g granule] [-p offset] "
>>>> +              "[-s size] [-v vcpus]\n", name);
>>>> +       puts("");
>>>> +       guest_modes_help();
>>>> +       vm_mem_backing_src_types_help();
>>>> +       printf(" -g: specify granule of the backing source pages. e.g. 2M or 1G.\n"
>>>> +              "     (default: host page size)\n");
>>> I'm not sure that 1G page support is fully implemented in this test.
>>> At minimum, I believe a flag is needed in the call to
>>> vm_userspace_mem_region_add, but it might be cleaner to add a
>>> VM_MEM_SRC_ANONYMOUS_1G_HUGETLB backing src type that causes the flag
>>> to be added in vm_userspace_mem_region_add.
>>>
>>>
>>>> +       printf(" -p: specify guest physical test memory offset\n"
>>>> +              "     must be aligned to granule of the backing source pages.\n"
>>>> +              "     Warning: a low offset can conflict with the loaded test code.\n");
>>>> +       printf(" -s: specify size of the memory region for testing. e.g. 10M or 3G.\n"
>>>> +              "     must be aligned to granule of the backing source pages.\n"
>>>> +              "     (default: 1G)\n");
>>>> +       printf(" -v: specify the number of vCPUs to run\n"
>>>> +              "     (default: 1)\n");
>>>> +       puts("");
>>>> +       exit(0);
>>>> +}
>>>> +
>>>> +int main(int argc, char *argv[])
>>>> +{
>>>> +       int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
>>>> +       struct test_params p = {
>>>> +               .backing_src_type = VM_MEM_SRC_ANONYMOUS,
>>>> +               .backing_src_granule = getpagesize(),
>>>> +               .test_mem_size = DEFAULT_TEST_MEM_SIZE,
>>>> +       };
>>>> +       int opt, type;
>>>> +
>>>> +       guest_modes_append_default();
>>>> +
>>>> +       while ((opt = getopt(argc, argv, "hm:t:g:p:s:v:")) != -1) {
>>>> +               switch (opt) {
>>>> +               case 'm':
>>>> +                       guest_modes_cmdline(optarg);
>>>> +                       break;
>>>> +               case 't':
>>>> +                       type = strtoul(optarg, NULL, 10);
>>>> +                       TEST_ASSERT(type < NUM_VM_BACKING_SRC_TYPES,
>>>> +                                   "Backing source type ID %d too big", type);
>>>> +                       p.backing_src_type = type;
>>>> +                       break;
>>>> +               case 'g':
>>>> +                       p.backing_src_granule = parse_size(optarg);
>>>> +                       break;
>>>> +               case 'p':
>>>> +                       p.phys_offset = strtoull(optarg, NULL, 0);
>>>> +                       break;
>>>> +               case 's':
>>>> +                       p.test_mem_size = parse_size(optarg);
>>>> +                       break;
>>>> +               case 'v':
>>>> +                       nr_vcpus = atoi(optarg);
>>>> +                       TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
>>>> +                                   "Invalid number of vcpus, must be between 1 and %d", max_vcpus);
>>>> +                       break;
>>>> +               case 'h':
>>>> +               default:
>>>> +                       help(argv[0]);
>>>> +                       break;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       for_each_guest_mode(run_test, &p);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> --
>>>> 2.23.0
>>>>
>>> .
> .
