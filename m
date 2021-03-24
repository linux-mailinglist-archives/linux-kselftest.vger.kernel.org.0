Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF4346F07
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Mar 2021 02:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhCXBs7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 21:48:59 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3317 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhCXBsx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 21:48:53 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4F4rfX5jh6z1476S;
        Wed, 24 Mar 2021 09:45:40 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 24 Mar 2021 09:48:50 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 09:48:50 +0800
Subject: Re: [RFC PATCH v5 02/10] tools headers: Add a macro to get HUGETLB
 page sizes for mmap
To:     Andrew Jones <drjones@redhat.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
References: <20210323135231.24948-1-wangyanan55@huawei.com>
 <20210323135231.24948-3-wangyanan55@huawei.com>
 <20210323140341.nkikwolwzpu6ectp@kamzik.brq.redhat.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <4b4df379-4fe4-abf3-3756-448290309a1d@huawei.com>
Date:   Wed, 24 Mar 2021 09:48:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210323140341.nkikwolwzpu6ectp@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2021/3/23 22:03, Andrew Jones wrote:
> $SUBJECT says "tools headers", but this is actually changing
> a UAPI header and then copying the change to tools.
Indeed. I think head of the subject should be "mm/hugetlb".
I will fix it.

Thanks,
Yanan
> Thanks,
> drew
>
> On Tue, Mar 23, 2021 at 09:52:23PM +0800, Yanan Wang wrote:
>> We know that if a system supports multiple hugetlb page sizes,
>> the desired hugetlb page size can be specified in bits [26:31]
>> of the flag arguments. The value in these 6 bits will be the
>> shift of each hugetlb page size.
>>
>> So add a macro to get the page size shift and then calculate the
>> corresponding hugetlb page size, using flag x.
>>
>> Cc: Ben Gardon <bgardon@google.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Suggested-by: Ben Gardon <bgardon@google.com>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> Reviewed-by: Ben Gardon <bgardon@google.com>
>> ---
>>   include/uapi/linux/mman.h       | 2 ++
>>   tools/include/uapi/linux/mman.h | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
>> index f55bc680b5b0..d72df73b182d 100644
>> --- a/include/uapi/linux/mman.h
>> +++ b/include/uapi/linux/mman.h
>> @@ -41,4 +41,6 @@
>>   #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>>   #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>>   
>> +#define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
>> +
>>   #endif /* _UAPI_LINUX_MMAN_H */
>> diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
>> index f55bc680b5b0..d72df73b182d 100644
>> --- a/tools/include/uapi/linux/mman.h
>> +++ b/tools/include/uapi/linux/mman.h
>> @@ -41,4 +41,6 @@
>>   #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>>   #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>>   
>> +#define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
>> +
>>   #endif /* _UAPI_LINUX_MMAN_H */
>> -- 
>> 2.19.1
>>
> .
