Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1610C363BA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Apr 2021 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhDSGki (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Apr 2021 02:40:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5136 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhDSGki (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Apr 2021 02:40:38 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FNxvl0GktzYXdt;
        Mon, 19 Apr 2021 14:37:55 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 19 Apr 2021 14:40:04 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 14:40:03 +0800
Subject: Re: [PATCH v6 03/10] KVM: selftests: Use flag CLOCK_MONOTONIC_RAW for
 timing
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Xu <peterx@redhat.com>, <wanghaibin.wang@huawei.com>,
        <yuzenghui@huawei.com>, kvm <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210330080856.14940-1-wangyanan55@huawei.com>
 <20210330080856.14940-4-wangyanan55@huawei.com>
 <1f892f30-1a72-1bcb-462f-b3d6f2bababb@redhat.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <82def592-e36c-25c3-c8c5-84c9be83e926@huawei.com>
Date:   Mon, 19 Apr 2021 14:40:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1f892f30-1a72-1bcb-462f-b3d6f2bababb@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paolo,

On 2021/4/17 21:23, Paolo Bonzini wrote:
> On 30/03/21 10:08, Yanan Wang wrote:
>> In addition to function of CLOCK_MONOTONIC, flag CLOCK_MONOTONIC_RAW can
>> also shield possiable impact of NTP, which can provide more robustness.
>>
>> Suggested-by: Vitaly Kuznetsov<vkuznets@redhat.com>
>> Signed-off-by: Yanan Wang<wangyanan55@huawei.com>
>> Reviewed-by: Ben Gardon<bgardon@google.com>
>> Reviewed-by: Andrew Jones<drjones@redhat.com>
>
> I'm not sure about this one, is the effect visible?
>
In practice, difference between results got with CLOCK_MONOTONIC and 
CLOCK_MONOTONIC_RAW
actually is too little to be visible. But if just in theory, 
CLOCK_MONOTONIC_RAW can ensure time results
of the compared tests are based on the same local oscillator frequency, 
which is not subject to possible
NTP frequency adjustment. Change in this patch seems like a bit of 
optimization.

But either of these two flags is good to me. If this patch is not 
convincing enough to be accepted, I will
post a patch later in fix use of CLOCK_MONOTONIC_RAW in 
kvm_page_table_test.c just to be consistent
with other kvm tests, please queue. :）

Thanks,
Yanan


