Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F983439EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 07:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCVGp5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 02:45:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3046 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCVGpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 02:45:39 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F3lKv1Q8SzWPBk;
        Mon, 22 Mar 2021 14:42:27 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 14:45:35 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 14:45:34 +0800
Subject: Re: [RFC PATCH v4 6/9] KVM: selftests: Add a helper to get system
 default hugetlb page size
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
 <20210302125751.19080-7-wangyanan55@huawei.com>
 <20210312114029.ju66lm5rrqdakgar@kamzik.brq.redhat.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <a8637239-c292-c6c4-e72b-f7a258d5d8a5@huawei.com>
Date:   Mon, 22 Mar 2021 14:45:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210312114029.ju66lm5rrqdakgar@kamzik.brq.redhat.com>
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


On 2021/3/12 19:40, Andrew Jones wrote:
> On Tue, Mar 02, 2021 at 08:57:48PM +0800, Yanan Wang wrote:
>> If HUGETLB is configured in the host kernel, then we can know the system
>> default hugetlb page size through *cat /proc/meminfo*. Otherwise, we will
>> not see the information of hugetlb pages in file /proc/meminfo if it's not
>> configured. So add a helper to determine whether HUGETLB is configured and
>> then get the default page size by reading /proc/meminfo.
>>
>> This helper can be useful when a program wants to use the default hugetlb
>> pages of the system and doesn't know the default page size.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   .../testing/selftests/kvm/include/test_util.h |  1 +
>>   tools/testing/selftests/kvm/lib/test_util.c   | 27 +++++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
>> index ef24c76ba89a..e087174eefe5 100644
>> --- a/tools/testing/selftests/kvm/include/test_util.h
>> +++ b/tools/testing/selftests/kvm/include/test_util.h
>> @@ -80,6 +80,7 @@ struct vm_mem_backing_src_alias {
>>   
>>   bool thp_configured(void);
>>   size_t get_trans_hugepagesz(void);
>> +size_t get_def_hugetlb_pagesz(void);
>>   void backing_src_help(void);
>>   enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>>   
>> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
>> index f2d133f76c67..80d68dbd72d2 100644
>> --- a/tools/testing/selftests/kvm/lib/test_util.c
>> +++ b/tools/testing/selftests/kvm/lib/test_util.c
>> @@ -153,6 +153,33 @@ size_t get_trans_hugepagesz(void)
>>   	return size;
>>   }
>>   
>> +size_t get_def_hugetlb_pagesz(void)
>> +{
>> +	char buf[64];
>> +	const char *tag = "Hugepagesize:";
>> +	FILE *f;
>> +
>> +	f = fopen("/proc/meminfo", "r");
>> +	TEST_ASSERT(f != NULL, "Error in opening /proc/meminfo: %d", errno);
>> +
>> +	while (fgets(buf, sizeof(buf), f) != NULL) {
>> +		if (strstr(buf, tag) == buf) {
>> +			fclose(f);
>> +			return strtoull(buf + strlen(tag), NULL, 10) << 10;
>> +		}
>> +	}
>> +
>> +	if (feof(f)) {
>> +		fclose(f);
>> +		TEST_FAIL("HUGETLB is not configured in host kernel");
>> +	} else {
>> +		fclose(f);
>> +		TEST_FAIL("Error in reading /proc/meminfo: %d", errno);
>> +	}
> fclose() can be factored out.
>
>> +
>> +	return 0;
>> +}
>> +
>>   void backing_src_help(void)
>>   {
>>   	int i;
>> -- 
>> 2.23.0
>>
> Besides the fclose comment and the same errno comment as the previous
> patch
I will fix it and add your R-b in this patch.

Thanks,
Yanan
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>
> .
