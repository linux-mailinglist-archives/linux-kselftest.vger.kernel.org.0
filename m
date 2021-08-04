Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C883E0120
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhHDM0D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 08:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238103AbhHDMZU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 08:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628079906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sI16fQel/Ue3hvumrMVm+G2pFHp1eoZdAd31v+J9YrE=;
        b=QmGQsOVvjzUrsmdncsiTbuoQykQ9ZQq/JMItrZ8kgUp2XXcRwqm8AsUudsPQHJMd3YOfss
        QL4rwqONaWFWmRp8uczG9x4d132D6/suMFE1mFnBikAT+khAZf8Y0si9xffdQYoqaaU+6y
        7hC41YROAGWLgjbi6Nobeovddq5r3do=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-hbuyVUKUObKCEE2pZpV2_Q-1; Wed, 04 Aug 2021 08:25:05 -0400
X-MC-Unique: hbuyVUKUObKCEE2pZpV2_Q-1
Received: by mail-ed1-f70.google.com with SMTP id y19-20020a0564021713b02903bbfec89ebcso1348271edu.16
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Aug 2021 05:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sI16fQel/Ue3hvumrMVm+G2pFHp1eoZdAd31v+J9YrE=;
        b=gFRxRQKqtmdJvLeO25iEJaQopmU8nvuyXJUNUCdGQcbLRfKZ787FztBm+ssQApg+De
         BVgRFS9LjBqAtYjOoGbQHpCdqY8OQaVwnWIGe4cIYYp7AZfYpND4kSm5kszFzdEtTtIZ
         S1K9wDAPTjzfUZhqH98b3V3Vsmn1fAtuetd+7ao3QNl2/iOSID90NUS5HIE7OHtlvlbx
         N0g2GlFhC/LTuxVXEqRk/2g6F23wmY6ZVYOaMdEihbDfoUs+rGcRwFzlSXlxUoTexzo+
         PAIc1VY5h3wx65LIXA4+m5lurpQEcUCQ34qw3Vt9VNNkZtRzHKThrjxpPB1172sHwnPN
         9gsg==
X-Gm-Message-State: AOAM532RcALICdM6Zf/Ws5507C5u7zioR1DzSwXPjbNlRtkcQIdhrgMN
        pPgcrxQsGJ+waPSJdcxhH1kby387x00BZ1lCB2ghUlQZSiU78Wc1Uot/joy4Gkx/gZVG4T1rvSi
        tGI9G5M9L0Vj/O9ulR1bzjU2pEVMhknyjX0IXWa4pxW5VGcCvIw+ogJP9z7VUKMUFdgH4Gg93I/
        1Gm9Dr
X-Received: by 2002:aa7:dd84:: with SMTP id g4mr31573780edv.134.1628079903598;
        Wed, 04 Aug 2021 05:25:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkaiVi1nNq0RDnQQTeashPNGbvIKvldHEWSd3OzLiBffrdBtEgeWSxP9aWUjrB3V8zxmYqGw==
X-Received: by 2002:aa7:dd84:: with SMTP id g4mr31573752edv.134.1628079903384;
        Wed, 04 Aug 2021 05:25:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id c4sm913819edt.37.2021.08.04.05.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 05:25:02 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: fix hyperv_clock test
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20210804112057.409498-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74cec7b5-ae92-2f34-9aa5-30306509f933@redhat.com>
Date:   Wed, 4 Aug 2021 14:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804112057.409498-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/08/21 13:20, Maxim Levitsky wrote:
> The test was mistakenly using addr_gpa2hva on a gva
> and that happened to work accidentally.
> 
> commit 106a2e766eae ("KVM: selftests:
> Lower the min virtual address for misc page allocations")
> revealed this bug.
> 
> Fixes: 106a2e766eae ("KVM: selftests: Lower the min virtual address for misc page allocations")

The right "Fixes" is 2c7f76b4c42b ("selftests: kvm: Add basic Hyper-V 
clocksources tests", 2021-03-18).

Paolo

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   tools/testing/selftests/kvm/x86_64/hyperv_clock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> index bab10ae787b6..e0b2bb1339b1 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> @@ -215,7 +215,7 @@ int main(void)
>   	vcpu_set_hv_cpuid(vm, VCPU_ID);
>   
>   	tsc_page_gva = vm_vaddr_alloc_page(vm);
> -	memset(addr_gpa2hva(vm, tsc_page_gva), 0x0, getpagesize());
> +	memset(addr_gva2hva(vm, tsc_page_gva), 0x0, getpagesize());
>   	TEST_ASSERT((addr_gva2gpa(vm, tsc_page_gva) & (getpagesize() - 1)) == 0,
>   		"TSC page has to be page aligned\n");
>   	vcpu_args_set(vm, VCPU_ID, 2, tsc_page_gva, addr_gva2gpa(vm, tsc_page_gva));
> 

