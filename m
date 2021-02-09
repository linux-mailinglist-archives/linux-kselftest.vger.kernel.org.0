Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D2314D65
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 11:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhBIKqQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 05:46:16 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3432 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhBIKoH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 05:44:07 -0500
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DZfb31hTjz5QhJ;
        Tue,  9 Feb 2021 18:41:51 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 9 Feb 2021 18:43:13 +0800
Subject: Re: [RFC PATCH 1/2] KVM: selftests: Add a macro to get string of
 vm_mem_backing_src_type
To:     Sean Christopherson <seanjc@google.com>
CC:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
References: <20210208090841.333724-1-wangyanan55@huawei.com>
 <20210208090841.333724-2-wangyanan55@huawei.com>
 <YCF4QCPtSEFg3Qv4@google.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <ce64f38e-a26e-584d-b9ac-21856713a4c2@huawei.com>
Date:   Tue, 9 Feb 2021 18:43:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <YCF4QCPtSEFg3Qv4@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sean,

On 2021/2/9 1:43, Sean Christopherson wrote:
> On Mon, Feb 08, 2021, Yanan Wang wrote:
>> Add a macro to get string of the backing source memory type, so that
>> application can add choices for source types in the help() function,
>> and users can specify which type to use for testing.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   tools/testing/selftests/kvm/include/kvm_util.h | 3 +++
>>   tools/testing/selftests/kvm/lib/kvm_util.c     | 8 ++++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> index 5cbb861525ed..f5fc29dc9ee6 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -69,7 +69,9 @@ enum vm_guest_mode {
>>   #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
>>   
>>   #define vm_guest_mode_string(m) vm_guest_mode_string[m]
>> +#define vm_mem_backing_src_type_string(s) vm_mem_backing_src_type_string[s]
> Oof, I see this is just following vm_guest_mode_string.  IMO, defining the
> string to look like a function is unnecessary and rather mean.
>
>>   extern const char * const vm_guest_mode_string[];
>> +extern const char * const vm_mem_backing_src_type_string[];
>>   
>>   struct vm_guest_mode_params {
>>   	unsigned int pa_bits;
>> @@ -83,6 +85,7 @@ enum vm_mem_backing_src_type {
>>   	VM_MEM_SRC_ANONYMOUS,
>>   	VM_MEM_SRC_ANONYMOUS_THP,
>>   	VM_MEM_SRC_ANONYMOUS_HUGETLB,
>> +	NUM_VM_BACKING_SRC_TYPES,
>>   };
>>   
>>   int kvm_check_cap(long cap);
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index fa5a90e6c6f0..a9b651c7f866 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -165,6 +165,14 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>>   _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
>>   	       "Missing new mode params?");
>>   
>> +const char * const vm_mem_backing_src_type_string[] = {
> A shorter name would be nice, though I don't have a good suggestion.
>
>> +	"VM_MEM_SRC_ANONYMOUS        ",
>> +	"VM_MEM_SRC_ANONYMOUS_THP    ",
>> +	"VM_MEM_SRC_ANONYMOUS_HUGETLB",
> It'd be more robust to explicitly assign indices, that way tweaks to
> vm_mem_backing_src_type won't cause silent breakage.  Ditto for the existing
> vm_guest_mode_string.
>
> E.g. I think something like this would work (completely untested)
>
> const char *vm_guest_mode_string(int i)
> {
> 	static const char *const strings[] = {
> 		[VM_MODE_P52V48_4K]	= "PA-bits:52,  VA-bits:48,  4K pages",
> 		[VM_MODE_P52V48_64K]	= "PA-bits:52,  VA-bits:48, 64K pages",
> 		[VM_MODE_P48V48_4K]	= "PA-bits:48,  VA-bits:48,  4K pages",
> 		[VM_MODE_P48V48_64K]	= "PA-bits:48,  VA-bits:48, 64K pages",
> 		[VM_MODE_P40V48_4K]	= "PA-bits:40,  VA-bits:48,  4K pages",
> 		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
> 		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
> 	};
>
> 	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
> 		       "Missing new mode strings?");
>
> 	TEST_ASSERT(i < NUM_VM_MODES);
>
> 	return strings[i];
> }

I think this is better. Moving these three staffs together into a single 
function and check the indices here is more reasonable.

Thanks,

Yanan.

>
>> +};
>> +_Static_assert(sizeof(vm_mem_backing_src_type_string)/sizeof(char *) == NUM_VM_BACKING_SRC_TYPES,
>> +	       "Missing new source type strings?");
>> +
>>   /*
>>    * VM Create
>>    *
>> -- 
>> 2.23.0
>>
> .
