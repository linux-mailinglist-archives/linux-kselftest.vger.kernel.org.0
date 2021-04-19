Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F31363E8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Apr 2021 11:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhDSJeh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Apr 2021 05:34:37 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3340 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbhDSJeg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Apr 2021 05:34:36 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FP1kg29bRz14J9b;
        Mon, 19 Apr 2021 17:30:19 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 19 Apr 2021 17:33:59 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 17:33:58 +0800
Subject: Re: [PATCH v6 03/10] KVM: selftests: Use flag CLOCK_MONOTONIC_RAW for
 timing
To:     David Laight <David.Laight@ACULAB.COM>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Xu <peterx@redhat.com>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        kvm <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210330080856.14940-1-wangyanan55@huawei.com>
 <20210330080856.14940-4-wangyanan55@huawei.com>
 <1f892f30-1a72-1bcb-462f-b3d6f2bababb@redhat.com>
 <82def592-e36c-25c3-c8c5-84c9be83e926@huawei.com>
 <8f36c1973c8147858000dd2a28d046ce@AcuMS.aculab.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <4ab0ec23-51c7-0258-4776-3268120f0c9e@huawei.com>
Date:   Mon, 19 Apr 2021 17:33:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8f36c1973c8147858000dd2a28d046ce@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2021/4/19 16:22, David Laight wrote:
> From: wangyanan (Y)
>> Sent: 19 April 2021 07:40
>>
>> Hi Paolo,
>>
>> On 2021/4/17 21:23, Paolo Bonzini wrote:
>>> On 30/03/21 10:08, Yanan Wang wrote:
>>>> In addition to function of CLOCK_MONOTONIC, flag CLOCK_MONOTONIC_RAW can
>>>> also shield possiable impact of NTP, which can provide more robustness.
>>>>
>>>> Suggested-by: Vitaly Kuznetsov<vkuznets@redhat.com>
>>>> Signed-off-by: Yanan Wang<wangyanan55@huawei.com>
>>>> Reviewed-by: Ben Gardon<bgardon@google.com>
>>>> Reviewed-by: Andrew Jones<drjones@redhat.com>
>>> I'm not sure about this one, is the effect visible?
>>>
>> In practice, difference between results got with CLOCK_MONOTONIC and
>> CLOCK_MONOTONIC_RAW
>> actually is too little to be visible. But if just in theory,
>> CLOCK_MONOTONIC_RAW can ensure time results
>> of the compared tests are based on the same local oscillator frequency,
>> which is not subject to possible
>> NTP frequency adjustment. Change in this patch seems like a bit of
>> optimization.
> The real annoyance is when NTP is realigning the local clock.
> This typically happens after boot - but can take quite a few
> minutes (don't think it can quite get to an hour).
> (I think something similar is caused by leap seconds.)
>
> During this period CLOCK_MONOTONIC can run at a significantly
> different rate from 'real time'.
> This may not matter for timing self tests, but is significant
> for RTP audio.
>
> The problem there is that you want the NTP corrected time
> during 'normal running' because the small correction (for
> crystal error) is useful.
>
> But the kernel HR timers are only defined for CLOCK_MONOTONIC
> and the userspace requests for CLOCK_MONOTONIC_RAW are likely
> to be real system calls.
>
> What you really want is a clock whose frequency is adjusted
> by NTP but doesn't have the NTP offset adjuctments.
> In reality this ought to be CLOCK_MONOTONIC.
Hi David,

I see now, much thanks for the above explanation. :)
Still have a lot to learn about this part.

Thanks,
Yanan
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
