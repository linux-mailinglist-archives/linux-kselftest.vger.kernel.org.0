Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9B3439D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 07:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCVGnR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 02:43:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5103 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhCVGmr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 02:42:47 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F3lJ80TQmzYMsW;
        Mon, 22 Mar 2021 14:40:56 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 14:42:42 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 14:42:41 +0800
Subject: Re: [RFC PATCH v4 5/9] KVM: selftests: Add a helper to get system
 configured THP page size
To:     Andrew Jones <drjones@redhat.com>
CC:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Ben Gardon" <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <yuzenghui@huawei.com>
References: <20210302125751.19080-1-wangyanan55@huawei.com>
 <20210302125751.19080-6-wangyanan55@huawei.com>
 <20210312113112.laarzqhkslroagha@kamzik.brq.redhat.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <46362177-c514-96fe-6117-4ab9716ee01d@huawei.com>
Date:   Mon, 22 Mar 2021 14:42:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210312113112.laarzqhkslroagha@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Drew,

Thanks for your attention to this series!
On 2021/3/12 19:31, Andrew Jones wrote:
> On Tue, Mar 02, 2021 at 08:57:47PM +0800, Yanan Wang wrote:
>> If we want to have some tests about transparent hugepages, the system
>> configured THP hugepage size should better be known by the tests, which
>> can be used for kinds of alignment or guest memory accessing of vcpus...
>> So it makes sense to add a helper to get the transparent hugepage size.
>>
>> With VM_MEM_SRC_ANONYMOUS_THP specified in vm_userspace_mem_region_add(),
>> we now stat /sys/kernel/mm/transparent_hugepage to check whether THP is
>> configured in the host kernel before madvise(). Based on this, we can also
>> read file /sys/kernel/mm/transparent_hugepage/hpage_pmd_size to get THP
>> hugepage size.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> Reviewed-by: Ben Gardon <bgardon@google.com>
>> ---
>>   .../testing/selftests/kvm/include/test_util.h |  2 ++
>>   tools/testing/selftests/kvm/lib/test_util.c   | 36 +++++++++++++++++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
>> index b7f41399f22c..ef24c76ba89a 100644
>> --- a/tools/testing/selftests/kvm/include/test_util.h
>> +++ b/tools/testing/selftests/kvm/include/test_util.h
>> @@ -78,6 +78,8 @@ struct vm_mem_backing_src_alias {
>>   	enum vm_mem_backing_src_type type;
>>   };
>>   
>> +bool thp_configured(void);
>> +size_t get_trans_hugepagesz(void);
>>   void backing_src_help(void);
>>   enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>>   
>> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
>> index c7c0627c6842..f2d133f76c67 100644
>> --- a/tools/testing/selftests/kvm/lib/test_util.c
>> +++ b/tools/testing/selftests/kvm/lib/test_util.c
>> @@ -10,6 +10,7 @@
>>   #include <limits.h>
>>   #include <stdlib.h>
>>   #include <time.h>
>> +#include <sys/stat.h>
>>   #include "linux/kernel.h"
>>   
>>   #include "test_util.h"
>> @@ -117,6 +118,41 @@ const struct vm_mem_backing_src_alias backing_src_aliases[] = {
>>   	{"anonymous_hugetlb", VM_MEM_SRC_ANONYMOUS_HUGETLB,},
>>   };
>>   
>> +bool thp_configured(void)
>> +{
>> +	int ret;
>> +	struct stat statbuf;
>> +
>> +	ret = stat("/sys/kernel/mm/transparent_hugepage", &statbuf);
>> +	TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
>> +		    "Error in stating /sys/kernel/mm/transparent_hugepage: %d",
>> +		    errno);
> TEST_ASSERT will already output errno's string. Is that not sufficient? If
> not, I think extending TEST_ASSERT to output errno too would be fine.
I think it's a good idea to output the errno together with it's string 
in TEST_ASSERT,
it will explicitly indicate that the string is an error information and 
the errno is much
easier to be used for debugging than the string. I will make this change 
a separate
patch in next version and add your S-b tag.
>> +
>> +	return ret == 0;
>> +}
>> +
>> +size_t get_trans_hugepagesz(void)
>> +{
>> +	size_t size;
>> +	char buf[16];
>> +	FILE *f;
>> +
>> +	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
>> +
>> +	f = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
>> +	TEST_ASSERT(f != NULL,
>> +		    "Error in opening transparent_hugepage/hpage_pmd_size: %d",
>> +		    errno);
> Same comment as above.
>
>> +
>> +	if (fread(buf, sizeof(char), sizeof(buf), f) == 0) {
>> +		fclose(f);
>> +		TEST_FAIL("Unable to read transparent_hugepage/hpage_pmd_size");
>> +	}
>> +
>> +	size = strtoull(buf, NULL, 10);
> fscanf with %lld?
This makes senses. But it should be %ld corresponding to size_t.

Thanks,
Yanan.
>> +	return size;
>> +}
>> +
>>   void backing_src_help(void)
>>   {
>>   	int i;
>> -- 
>> 2.23.0
>>
> Thanks,
> drew
>
> .
