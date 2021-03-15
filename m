Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B5E33A989
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 03:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhCOCGt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Mar 2021 22:06:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2600 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCOCGi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Mar 2021 22:06:38 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DzKTN656BzWLZW;
        Mon, 15 Mar 2021 10:03:36 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 15 Mar 2021 10:06:35 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 15 Mar 2021 10:06:34 +0800
Subject: Re: [RFC PATCH v4 2/9] tools headers: Add a macro to get HUGETLB page
 sizes for mmap
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
 <20210302125751.19080-3-wangyanan55@huawei.com>
 <20210312111456.ukxss6uxu3frqmiu@kamzik.brq.redhat.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <84b12a41-a922-4a5a-8861-d2c310cdaa66@huawei.com>
Date:   Mon, 15 Mar 2021 10:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210312111456.ukxss6uxu3frqmiu@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2021/3/12 19:14, Andrew Jones wrote:
> On Tue, Mar 02, 2021 at 08:57:44PM +0800, Yanan Wang wrote:
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
>> index f55bc680b5b0..8bd41128a0ee 100644
>> --- a/include/uapi/linux/mman.h
>> +++ b/include/uapi/linux/mman.h
>> @@ -41,4 +41,6 @@
>>   #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>>   #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>>   
>> +#define MAP_HUGE_PAGE_SIZE(x) (1 << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
> Needs to be '1ULL' to avoid shift overflow when given MAP_HUGE_16GB.
Thanks, drew. Will fix it.
> Thanks,
> drew
>
>> +
>>   #endif /* _UAPI_LINUX_MMAN_H */
>> diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
>> index f55bc680b5b0..8bd41128a0ee 100644
>> --- a/tools/include/uapi/linux/mman.h
>> +++ b/tools/include/uapi/linux/mman.h
>> @@ -41,4 +41,6 @@
>>   #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>>   #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>>   
>> +#define MAP_HUGE_PAGE_SIZE(x) (1 << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
>> +
>>   #endif /* _UAPI_LINUX_MMAN_H */
>> -- 
>> 2.23.0
>>
> .
