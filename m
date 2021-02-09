Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F80314E2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBILYm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 06:24:42 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2582 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhBILWc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 06:22:32 -0500
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DZgQY40tpzW2Zc;
        Tue,  9 Feb 2021 19:19:33 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme764-chm.china.huawei.com (10.3.19.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 9 Feb 2021 19:21:47 +0800
Subject: Re: [RFC PATCH 1/2] KVM: selftests: Add a macro to get string of
 vm_mem_backing_src_type
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
 <20210208090841.333724-2-wangyanan55@huawei.com>
 <CANgfPd967wgLk0tb6mNaWsaAa9Tn0LyecEZ_4-e+nKoa-HkCBg@mail.gmail.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <c9c1207f-09ae-e601-5789-bd39ceb4071e@huawei.com>
Date:   Tue, 9 Feb 2021 19:21:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd967wgLk0tb6mNaWsaAa9Tn0LyecEZ_4-e+nKoa-HkCBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2021/2/9 2:13, Ben Gardon wrote:
> On Mon, Feb 8, 2021 at 1:08 AM Yanan Wang <wangyanan55@huawei.com> wrote:
>> Add a macro to get string of the backing source memory type, so that
>> application can add choices for source types in the help() function,
>> and users can specify which type to use for testing.
> Coincidentally, I sent out a change last week to do the same thing:
> "KVM: selftests: Add backing src parameter to dirty_log_perf_test"
> (https://lkml.org/lkml/2021/2/2/1430)
> Whichever way this ends up being implemented, I'm happy to see others
> interested in testing different backing source types too.

Thanks Ben! I have a little question here.

Can we just present three IDs (0/1/2) but not strings for users to 
choose which backing_src_type to use like the way of guest modes,

which I think can make cmdlines more consise and easier to print. And is 
it better to make a universal API to get backing_src_strings

like Sean have suggested, so that the API can be used elsewhere ?

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
>>   #define PTES_PER_MIN_PAGE      ptes_per_page(MIN_PAGE_SIZE)
>>
>>   #define vm_guest_mode_string(m) vm_guest_mode_string[m]
>> +#define vm_mem_backing_src_type_string(s) vm_mem_backing_src_type_string[s]
>>   extern const char * const vm_guest_mode_string[];
>> +extern const char * const vm_mem_backing_src_type_string[];
>>
>>   struct vm_guest_mode_params {
>>          unsigned int pa_bits;
>> @@ -83,6 +85,7 @@ enum vm_mem_backing_src_type {
>>          VM_MEM_SRC_ANONYMOUS,
>>          VM_MEM_SRC_ANONYMOUS_THP,
>>          VM_MEM_SRC_ANONYMOUS_HUGETLB,
>> +       NUM_VM_BACKING_SRC_TYPES,
>>   };
>>
>>   int kvm_check_cap(long cap);
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index fa5a90e6c6f0..a9b651c7f866 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -165,6 +165,14 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>>   _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
>>                 "Missing new mode params?");
>>
>> +const char * const vm_mem_backing_src_type_string[] = {
>> +       "VM_MEM_SRC_ANONYMOUS        ",
>> +       "VM_MEM_SRC_ANONYMOUS_THP    ",
>> +       "VM_MEM_SRC_ANONYMOUS_HUGETLB",
>> +};
>> +_Static_assert(sizeof(vm_mem_backing_src_type_string)/sizeof(char *) == NUM_VM_BACKING_SRC_TYPES,
>> +              "Missing new source type strings?");
>> +
>>   /*
>>    * VM Create
>>    *
>> --
>> 2.23.0
>>
> .
