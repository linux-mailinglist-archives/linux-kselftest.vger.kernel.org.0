Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B04315E14
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Feb 2021 05:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhBJEMZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 23:12:25 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4624 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhBJEMY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 23:12:24 -0500
Received: from dggeme718-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Db5rv0y7TzY6gS;
        Wed, 10 Feb 2021 12:10:23 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme718-chm.china.huawei.com (10.1.199.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 10 Feb 2021 12:11:38 +0800
Subject: Re: [RFC PATCH 1/2] KVM: selftests: Add a macro to get string of
 vm_mem_backing_src_type
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
CC:     kvm <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
References: <20210208090841.333724-1-wangyanan55@huawei.com>
 <20210208090841.333724-2-wangyanan55@huawei.com>
 <CANgfPd967wgLk0tb6mNaWsaAa9Tn0LyecEZ_4-e+nKoa-HkCBg@mail.gmail.com>
 <c9c1207f-09ae-e601-5789-bd39ceb4071e@huawei.com>
 <CANgfPd_u2uGmt645e9mLbBcTOV1mQ_iXjq8h7WwCDKETZJ9GJg@mail.gmail.com>
 <YCLHy82RcATHEDtC@google.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <bf173f0c-1694-8a31-4f96-55f821818cd1@huawei.com>
Date:   Wed, 10 Feb 2021 12:11:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <YCLHy82RcATHEDtC@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggeme718-chm.china.huawei.com (10.1.199.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2021/2/10 1:35, Sean Christopherson wrote:
> On Tue, Feb 09, 2021, Ben Gardon wrote:
>> On Tue, Feb 9, 2021 at 3:21 AM wangyanan (Y) <wangyanan55@huawei.com> wrote:
>>>
>>> On 2021/2/9 2:13, Ben Gardon wrote:
>>>> On Mon, Feb 8, 2021 at 1:08 AM Yanan Wang <wangyanan55@huawei.com> wrote:
>>>>> Add a macro to get string of the backing source memory type, so that
>>>>> application can add choices for source types in the help() function,
>>>>> and users can specify which type to use for testing.
>>>> Coincidentally, I sent out a change last week to do the same thing:
>>>> "KVM: selftests: Add backing src parameter to dirty_log_perf_test"
>>>> (https://lkml.org/lkml/2021/2/2/1430)
>>>> Whichever way this ends up being implemented, I'm happy to see others
>>>> interested in testing different backing source types too.
>>> Thanks Ben! I have a little question here.
>>>
>>> Can we just present three IDs (0/1/2) but not strings for users to
>>> choose which backing_src_type to use like the way of guest modes,
>> That would be fine with me. The string names are easier for me to read
>> than an ID number (especially if you were to add additional options
>> e.g. 1G hugetlb or file backed  / shared memory) but it's mostly an
>> aesthetic preference, so I don't have strong feelings either way.
> I vote to expose/consume strings, being able to do ".dirty_log_perf_test --help"
> and understand the backing options without having to dig into source was super
> nice.
> .
Fine then:), I will make some change based on 
(https://lkml.org/lkml/2021/2/2/1430), thanks!
