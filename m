Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7673EBEBC
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Aug 2021 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhHMX1d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Aug 2021 19:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235475AbhHMX1c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Aug 2021 19:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628897224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ltnXqs72PoZJlgVvtR4opPys8udAwLGgtjNFBrBB1U=;
        b=LPfofpB5wsE3uc6DItki/QQW/2eVCk/b6zL/irB70K7e4UI3+cL/cmOREnjFc++hLP1EMr
        MzFofC7s8gNO5219Lo25faA44O6d2SsBuWj122soGep5949YYCiblXrdiQCS4mnx0gBCb7
        L45pIbp622pk64FEBaFwRQmWVI4vK4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-JpeiGEiUOn-Hq735IQbKvg-1; Fri, 13 Aug 2021 19:27:03 -0400
X-MC-Unique: JpeiGEiUOn-Hq735IQbKvg-1
Received: by mail-wm1-f72.google.com with SMTP id f19-20020a1c1f13000000b002e6bd83c344so1313934wmf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Aug 2021 16:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ltnXqs72PoZJlgVvtR4opPys8udAwLGgtjNFBrBB1U=;
        b=WuGkb4nUCVMQkxX/XY8SnQZemULbJ4v/SVeE5hNNNC9evZhfS6Xkah4K84P6nMs0cE
         M1jsrYYOuleh2D6RP1ImvjSBgC4TafxFeFAxbq2VbkGPehxcfI00dpx8pzMw1OqPt9VR
         8rL9yXLdPVWdiKvnPpLKN8n8zpyHllv5ofiPFebgQCEZNW8cQgPrWxbJ3wEqrneHXqji
         NXfpYtb54ZRHno/ZqgCsUp8PYRHVFN8l8Pzh3tex1jj3gNOjrat5SF5PQxTm4Y2VTEN1
         6hkDB9y4puOrMDNQwR3eYaJkKxd1jQ4RpxVEPxDbROzsMwc4k7NHjWS6eA46eDhS1PEz
         gldg==
X-Gm-Message-State: AOAM531qmm4rvsACQGCNNl74BLfuxwjrhE8TYm26qN0DDEp6R0txejz1
        w8sBobnaTNtaUHNzXwKd+4cWyAX1UT4P3dD8F6D5AYbZadcmWq9VG2PfeXUzyZLBnDLMXXw0WRF
        P4sHkIzeTbSUQMleDscPh56KUqbRk
X-Received: by 2002:a05:600c:1483:: with SMTP id c3mr4574073wmh.131.1628897222471;
        Fri, 13 Aug 2021 16:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0xDBu7qLTuycfsdJlyJRztUYK2z+Cba+NWhlTJD00FCnM/bVqlz1ZvzqvrtswSGYJMSQejg==
X-Received: by 2002:a05:600c:1483:: with SMTP id c3mr4574048wmh.131.1628897222249;
        Fri, 13 Aug 2021 16:27:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q17sm2712042wrr.91.2021.08.13.16.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 16:27:01 -0700 (PDT)
Subject: Re: [PATCH -next 1/2] selftests: Fix vm_handle_exception undefined
 error
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Chen Lifu <chenlifu@huawei.com>, shuah@kernel.org,
        bgardon@google.com, wangyanan55@huawei.com,
        axelrasmussen@google.com, drjones@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, dwmw@amazon.co.uk, joao.m.martins@oracle.com,
        yangyingliang@huawei.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210709063741.355325-1-chenlifu@huawei.com>
 <f130f6ec-0c80-7a83-fad2-7d72d389b96b@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6fca25d-f241-4de2-5a8e-cbcd34abc758@redhat.com>
Date:   Sat, 14 Aug 2021 01:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f130f6ec-0c80-7a83-fad2-7d72d389b96b@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/08/21 19:01, Shuah Khan wrote:
> On 7/9/21 12:37 AM, Chen Lifu wrote:
>> Compile setftests on x86_64 occurs following error:
>> make -C tools/testing/selftests
>> ...
>>
>> x86_64/hyperv_features.c:618:2: warning: implicit declaration of 
>> function ‘vm_handle_exception’ [-Wimplicit-function-declaration]
>>    618 |  vm_handle_exception(vm, GP_VECTOR, guest_gp_handler);
>> /usr/bin/ld: /tmp/cclOnpml.o: in function `main':
>> tools/testing/selftests/kvm/x86_64/hyperv_features.c:618: undefined 
>> reference to `vm_handle_exception'
>> collect2: error: ld returned 1 exit status
>>
>> The reason is that commit b78f4a596692 ("KVM: selftests: Rename 
>> vm_handle_exception")
>> renamed "vm_handle_exception" function to 
>> "vm_install_exception_handler" function.
>>
>> Fix it by replacing "vm_handle_exception" with 
>> "vm_install_exception_handler"
>> in corresponding selftests files.
>>
>> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
>> ---
>>   tools/testing/selftests/kvm/x86_64/hyperv_features.c | 2 +-
>>   tools/testing/selftests/kvm/x86_64/mmu_role_test.c   | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
> 
> 
> Please include kvm in the commit summary. I think it is not getting
> the right attention because of the summary line.

The same patch was already committed:

     commit f8f0edabcc09fafd695ed2adc0eb825104e35d5c
     Author: Marc Zyngier <maz@kernel.org>
     Date:   Thu Jul 1 08:19:28 2021 +0100

     KVM: selftests: x86: Address missing vm_install_exception_handler conversions
     
     Commit b78f4a59669 ("KVM: selftests: Rename vm_handle_exception")
     raced with a couple of new x86 tests, missing two vm_handle_exception
     to vm_install_exception_handler conversions.
     
     Help the two broken tests to catch up with the new world.
     
     Cc: Andrew Jones <drjones@redhat.com>
     CC: Ricardo Koller <ricarkol@google.com>
     Cc: Paolo Bonzini <pbonzini@redhat.com>
     Signed-off-by: Marc Zyngier <maz@kernel.org>
     Message-Id: <20210701071928.2971053-1-maz@kernel.org>
     Reviewed-by: Andrew Jones <drjones@redhat.com>
     Reviewed-by: Ricardo Koller <ricarkol@google.com>
     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

For the other patch, returning 0 is going to cause issues elsewhere
in the tests.  Either the test is failed immediately, or all callers
must be examined carefully.

Paolo

