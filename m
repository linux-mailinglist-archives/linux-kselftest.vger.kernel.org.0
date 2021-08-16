Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169A13ECCD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Aug 2021 04:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhHPCyQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Aug 2021 22:54:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13319 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHPCyN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Aug 2021 22:54:13 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GnzHz1Fr0z86gj;
        Mon, 16 Aug 2021 10:53:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 10:53:40 +0800
Received: from [10.67.100.236] (10.67.100.236) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 10:53:40 +0800
Subject: Re: [PATCH -next 1/2] selftests: Fix vm_handle_exception undefined
 error
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>,
        <bgardon@google.com>, <wangyanan55@huawei.com>,
        <axelrasmussen@google.com>, <drjones@redhat.com>,
        <seanjc@google.com>, <vkuznets@redhat.com>, <dwmw@amazon.co.uk>,
        <joao.m.martins@oracle.com>, <yangyingliang@huawei.com>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210709063741.355325-1-chenlifu@huawei.com>
 <f130f6ec-0c80-7a83-fad2-7d72d389b96b@linuxfoundation.org>
 <b6fca25d-f241-4de2-5a8e-cbcd34abc758@redhat.com>
From:   chenlifu <chenlifu@huawei.com>
Message-ID: <b8f2a211-b2e0-b8e0-4215-a428e4044f88@huawei.com>
Date:   Mon, 16 Aug 2021 10:53:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <b6fca25d-f241-4de2-5a8e-cbcd34abc758@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.100.236]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks. Got it.

在 2021/8/14 7:26, Paolo Bonzini 写道:
> On 13/08/21 19:01, Shuah Khan wrote:
>> On 7/9/21 12:37 AM, Chen Lifu wrote:
>>> Compile setftests on x86_64 occurs following error:
>>> make -C tools/testing/selftests
>>> ...
>>>
>>> x86_64/hyperv_features.c:618:2: warning: implicit declaration of 
>>> function ‘vm_handle_exception’ [-Wimplicit-function-declaration]
>>>    618 |  vm_handle_exception(vm, GP_VECTOR, guest_gp_handler);
>>> /usr/bin/ld: /tmp/cclOnpml.o: in function `main':
>>> tools/testing/selftests/kvm/x86_64/hyperv_features.c:618: undefined 
>>> reference to `vm_handle_exception'
>>> collect2: error: ld returned 1 exit status
>>>
>>> The reason is that commit b78f4a596692 ("KVM: selftests: Rename 
>>> vm_handle_exception")
>>> renamed "vm_handle_exception" function to 
>>> "vm_install_exception_handler" function.
>>>
>>> Fix it by replacing "vm_handle_exception" with 
>>> "vm_install_exception_handler"
>>> in corresponding selftests files.
>>>
>>> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
>>> ---
>>>   tools/testing/selftests/kvm/x86_64/hyperv_features.c | 2 +-
>>>   tools/testing/selftests/kvm/x86_64/mmu_role_test.c   | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>
>>
>> Please include kvm in the commit summary. I think it is not getting
>> the right attention because of the summary line.
> 
> The same patch was already committed:
> 
>     commit f8f0edabcc09fafd695ed2adc0eb825104e35d5c
>     Author: Marc Zyngier <maz@kernel.org>
>     Date:   Thu Jul 1 08:19:28 2021 +0100
> 
>     KVM: selftests: x86: Address missing vm_install_exception_handler 
> conversions
>     Commit b78f4a59669 ("KVM: selftests: Rename vm_handle_exception")
>     raced with a couple of new x86 tests, missing two vm_handle_exception
>     to vm_install_exception_handler conversions.
>     Help the two broken tests to catch up with the new world.
>     Cc: Andrew Jones <drjones@redhat.com>
>     CC: Ricardo Koller <ricarkol@google.com>
>     Cc: Paolo Bonzini <pbonzini@redhat.com>
>     Signed-off-by: Marc Zyngier <maz@kernel.org>
>     Message-Id: <20210701071928.2971053-1-maz@kernel.org>
>     Reviewed-by: Andrew Jones <drjones@redhat.com>
>     Reviewed-by: Ricardo Koller <ricarkol@google.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> For the other patch, returning 0 is going to cause issues elsewhere
> in the tests.  Either the test is failed immediately, or all callers
> must be examined carefully.
> 
> Paolo
> 
> .
