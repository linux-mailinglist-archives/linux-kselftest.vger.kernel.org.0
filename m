Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5919332A7DC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Mar 2021 18:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446006AbhCBQo7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Mar 2021 11:44:59 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2913 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350546AbhCBMWI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Mar 2021 07:22:08 -0500
Received: from dggeme714-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Dqbld21tWz5Wjv;
        Tue,  2 Mar 2021 20:19:09 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme714-chm.china.huawei.com (10.1.199.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 2 Mar 2021 20:21:15 +0800
Subject: Re: [RFC PATCH v3 6/8] KVM: selftests: List all hugetlb src types
 specified with page sizes
To:     Ben Gardon <bgardon@google.com>
CC:     kvm <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <yuzenghui@huawei.com>
References: <20210301065916.11484-1-wangyanan55@huawei.com>
 <20210301065916.11484-7-wangyanan55@huawei.com>
 <CANgfPd_edxLBBgdnXHiq-pr=6iVf_n8qxSYQeq9JZgK05DwDRQ@mail.gmail.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <2274ec0b-71d0-e2cc-22a9-784f27ad3ccf@huawei.com>
Date:   Tue, 2 Mar 2021 20:21:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd_edxLBBgdnXHiq-pr=6iVf_n8qxSYQeq9JZgK05DwDRQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme714-chm.china.huawei.com (10.1.199.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ben,

On 2021/3/2 1:09, Ben Gardon wrote:
> On Sun, Feb 28, 2021 at 11:00 PM Yanan Wang <wangyanan55@huawei.com> wrote:
>> With VM_MEM_SRC_ANONYMOUS_HUGETLB, we currently can only use system
>> default hugetlb pages to back the testing guest memory. In order to
>> add flexibility, now list all the known hugetlb backing src types with
>> different page sizes, so that we can specify use of hugetlb pages of the
>> exact granularity that we want. And as all the known hugetlb page sizes
>> are listed, it's appropriate for all architectures.
>>
>> Besides, the helper get_backing_src_pagesz() is added to get the
>> granularity of different backing src types(anonumous, thp, hugetlb).
>>
>> Suggested-by: Ben Gardon <bgardon@google.com>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   .../testing/selftests/kvm/include/test_util.h | 19 ++++++-
>>   tools/testing/selftests/kvm/lib/kvm_util.c    |  2 +-
>>   tools/testing/selftests/kvm/lib/test_util.c   | 56 +++++++++++++++----
>>   3 files changed, 63 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
>> index ef24c76ba89a..be5d08bcdca7 100644
>> --- a/tools/testing/selftests/kvm/include/test_util.h
>> +++ b/tools/testing/selftests/kvm/include/test_util.h
>> @@ -70,16 +70,31 @@ struct timespec timespec_div(struct timespec ts, int divisor);
>>   enum vm_mem_backing_src_type {
>>          VM_MEM_SRC_ANONYMOUS,
>>          VM_MEM_SRC_ANONYMOUS_THP,
>> -       VM_MEM_SRC_ANONYMOUS_HUGETLB,
> I apologize I didn't catch this in v2, but it looks like this patch
> removes a default hugetlb size option. I could see this being
> intentional if we want to force developers to think about there being
> multiple page sizes, but it might also be nice for folks to have an
> option to use the system default hugepage size.
Thanks for pointing out this. I was trying to let developers to use the 
accurate
page size in all cases if they want to use hugetlb pages, so I removed 
the default
enum of VM_MEM_SRC_ANONYMOUS_HUGETLB. But maybe it's not right to do so.

It's possible that a program just wants to use hugetlb pages and doesn't 
really care
the page size and the default option is the best in this case. Anyway, I 
will add
VM_MEM_SRC_ANONYMOUS_HUGETLB in next version :). As for the default hugetlb
page size, it can be got by reading file /proc/meminfo.
> Otherwise, this series looks good to me. Please feel free to add
> Reviewed-by: Ben Gardon <bgardon@google.com>.

Thanks for your review of this series and the good suggestions,

Yanan

>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
>> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
>> +       NUM_SRC_TYPES,
>>   };
>>
>>   struct vm_mem_backing_src_alias {
>>          const char *name;
>> -       enum vm_mem_backing_src_type type;
>> +       uint32_t flag;
>>   };
>>
>>   bool thp_configured(void);
>>   size_t get_trans_hugepagesz(void);
>> +const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
>> +size_t get_backing_src_pagesz(uint32_t i);
>>   void backing_src_help(void);
>>   enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>>
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index cc22c4ab7d67..b91c8e3a7ee1 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -757,7 +757,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>>          region->mmap_start = mmap(NULL, region->mmap_size,
>>                                    PROT_READ | PROT_WRITE,
>>                                    MAP_PRIVATE | MAP_ANONYMOUS
>> -                                 | (src_type == VM_MEM_SRC_ANONYMOUS_HUGETLB ? MAP_HUGETLB : 0),
>> +                                 | vm_mem_backing_src_alias(src_type)->flag,
>>                                    -1, 0);
>>          TEST_ASSERT(region->mmap_start != MAP_FAILED,
>>                      "test_malloc failed, mmap_start: %p errno: %i",
>> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
>> index f2d133f76c67..1f5e7241c80e 100644
>> --- a/tools/testing/selftests/kvm/lib/test_util.c
>> +++ b/tools/testing/selftests/kvm/lib/test_util.c
>> @@ -11,6 +11,7 @@
>>   #include <stdlib.h>
>>   #include <time.h>
>>   #include <sys/stat.h>
>> +#include <linux/mman.h>
>>   #include "linux/kernel.h"
>>
>>   #include "test_util.h"
>> @@ -112,12 +113,6 @@ void print_skip(const char *fmt, ...)
>>          puts(", skipping test");
>>   }
>>
>> -const struct vm_mem_backing_src_alias backing_src_aliases[] = {
>> -       {"anonymous", VM_MEM_SRC_ANONYMOUS,},
>> -       {"anonymous_thp", VM_MEM_SRC_ANONYMOUS_THP,},
>> -       {"anonymous_hugetlb", VM_MEM_SRC_ANONYMOUS_HUGETLB,},
>> -};
>> -
>>   bool thp_configured(void)
>>   {
>>          int ret;
>> @@ -153,22 +148,61 @@ size_t get_trans_hugepagesz(void)
>>          return size;
>>   }
>>
>> +const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
>> +{
>> +       static const struct vm_mem_backing_src_alias aliases[] = {
>> +               { "anonymous",               0                            },
>> +               { "anonymous_thp",           0                            },
>> +               { "anonymous_hugetlb_16kb",  MAP_HUGETLB | MAP_HUGE_16KB  },
>> +               { "anonymous_hugetlb_64kb",  MAP_HUGETLB | MAP_HUGE_64KB  },
>> +               { "anonymous_hugetlb_512kb", MAP_HUGETLB | MAP_HUGE_512KB },
>> +               { "anonymous_hugetlb_1mb",   MAP_HUGETLB | MAP_HUGE_1MB   },
>> +               { "anonymous_hugetlb_2mb",   MAP_HUGETLB | MAP_HUGE_2MB   },
>> +               { "anonymous_hugetlb_8mb",   MAP_HUGETLB | MAP_HUGE_8MB   },
>> +               { "anonymous_hugetlb_16mb",  MAP_HUGETLB | MAP_HUGE_16MB  },
>> +               { "anonymous_hugetlb_32mb",  MAP_HUGETLB | MAP_HUGE_32MB  },
>> +               { "anonymous_hugetlb_256mb", MAP_HUGETLB | MAP_HUGE_256MB },
>> +               { "anonymous_hugetlb_512mb", MAP_HUGETLB | MAP_HUGE_512MB },
>> +               { "anonymous_hugetlb_1gb",   MAP_HUGETLB | MAP_HUGE_1GB   },
>> +               { "anonymous_hugetlb_2gb",   MAP_HUGETLB | MAP_HUGE_2GB   },
>> +               { "anonymous_hugetlb_16gb",  MAP_HUGETLB | MAP_HUGE_16GB  },
>> +       };
>> +       _Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
>> +                      "Missing new backing src types?");
>> +
>> +       TEST_ASSERT(i < NUM_SRC_TYPES, "Backing src type ID %d too big", i);
>> +
>> +       return &aliases[i];
>> +}
>> +
>> +size_t get_backing_src_pagesz(uint32_t i)
>> +{
>> +       uint32_t flag = vm_mem_backing_src_alias(i)->flag;
>> +
>> +       if (i == VM_MEM_SRC_ANONYMOUS)
>> +               return getpagesize();
>> +       if (i == VM_MEM_SRC_ANONYMOUS_THP)
>> +               return get_trans_hugepagesz();
>> +
>> +       return MAP_HUGE_PAGE_SIZE(flag);
>> +}
>> +
>>   void backing_src_help(void)
>>   {
>>          int i;
>>
>>          printf("Available backing src types:\n");
>> -       for (i = 0; i < ARRAY_SIZE(backing_src_aliases); i++)
>> -               printf("\t%s\n", backing_src_aliases[i].name);
>> +       for (i = 0; i < NUM_SRC_TYPES; i++)
>> +               printf("\t%s\n", vm_mem_backing_src_alias(i)->name);
>>   }
>>
>>   enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name)
>>   {
>>          int i;
>>
>> -       for (i = 0; i < ARRAY_SIZE(backing_src_aliases); i++)
>> -               if (!strcmp(type_name, backing_src_aliases[i].name))
>> -                       return backing_src_aliases[i].type;
>> +       for (i = 0; i < NUM_SRC_TYPES; i++)
>> +               if (!strcmp(type_name, vm_mem_backing_src_alias(i)->name))
>> +                       return i;
>>
>>          backing_src_help();
>>          TEST_FAIL("Unknown backing src type: %s", type_name);
>> --
>> 2.23.0
>>
> .
