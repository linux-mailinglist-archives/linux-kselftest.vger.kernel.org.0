Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7B346F45
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Mar 2021 03:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhCXCNg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 22:13:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5111 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhCXCNI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 22:13:08 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F4sD26JDxzYMl9;
        Wed, 24 Mar 2021 10:11:14 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 24 Mar 2021 10:13:03 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 10:13:03 +0800
Subject: Re: [RFC PATCH v5 00/10] KVM: selftests: some improvement and a new
 test for kvm page table
To:     Sean Christopherson <seanjc@google.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
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
 <YFoQJQ5OYEx3BD3Y@google.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <60808aa1-1574-e876-4c07-3340aaa2c979@huawei.com>
Date:   Wed, 24 Mar 2021 10:13:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <YFoQJQ5OYEx3BD3Y@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2021/3/23 23:58, Sean Christopherson wrote:
> On Tue, Mar 23, 2021, Yanan Wang wrote:
>> Hi,
>> This v5 series can mainly include two parts.
>> Based on kvm queue branch: https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=queue
> Given the number of Reviewed-by tags, I'm pretty sure you can drop the "RFC" :-)
Ah, yes! Will drop it in v6 where I hope everything would be fine. :)

Thanks,
Yanan
> .
