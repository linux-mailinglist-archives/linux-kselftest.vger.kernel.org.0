Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8CE34F9BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhCaHVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 03:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234034AbhCaHVR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 03:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617175276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiW3s6POuiBtrk66pwAu3NhlizCTRO+r/CxAonDvxF8=;
        b=STkOkzFiqbPHGwNfLFJM0Z2FsOsDXTQptK8sAQQLhPWf+V0OZu+w9LHsKgyxAPg5TduLTc
        i2E6+nOb5ERZp+uPe2/tUIUM5qRnvLKS71JeXTl/XL3AV1A7dFvWBITJ9Ztm/aaVeOvOOX
        7pp+4TXvi6hBy2tYlF5lZqbTGEc7+OA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-5suplRdCPH25XTlM3Ympxg-1; Wed, 31 Mar 2021 03:21:14 -0400
X-MC-Unique: 5suplRdCPH25XTlM3Ympxg-1
Received: by mail-ed1-f71.google.com with SMTP id v27so640094edx.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 00:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TiW3s6POuiBtrk66pwAu3NhlizCTRO+r/CxAonDvxF8=;
        b=ElrXEMOO07Psy6vsFr4CzQHYf9MUOSFo7dCPFLQ0Yp1N+oJA82b+DFnjoxfM764IPx
         GbytkSrMqzSwRqbw6RmHvSFS2/RO6a682t/Tzg7kM4+1duL4DhfmGhbCNDAdr8bfVaMY
         0rZiDiwtpsAGIfU2DWGj2+LBS1sxuc/uzHWppH1rSLxGX3NeyTDUWMXMN08dpclnXyXk
         BTZeopOBRJW8/hvpQKnEoHcOrfy8dOzCza8FZebX3hH5y/MLgd9eYTSSpNUbp62DuJcU
         ROcSyej3vZmqrUDHsFvD2gwChrKWij25oijPlHFSW8bb87TzZY+gb9YMytjvXc9t3PWB
         vt+w==
X-Gm-Message-State: AOAM5306jpXxzVREfQEHBixjjchRRwZSl73asguf23Dl0G9fotKcLlFG
        I1tKmL0BO3Hd0fglkbv/oKB9pMG0+5ap5ImOSuwQmTbJ3skg6a6mNvhJxPJsw8kHJRSTqs95cfg
        mRmTTxQUZTrVDQyYGaqDt14yuYGRo7hZuQIsuggzH7ZQVc8JFQ1lT3utOjfD/o10nXUNakkBxQt
        XP4b2X
X-Received: by 2002:aa7:c88e:: with SMTP id p14mr1915441eds.119.1617175273346;
        Wed, 31 Mar 2021 00:21:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwOtUMcLcAd9P6nCkRIJO4s2Udkyqh4y7phmUPuSIFRQtTdU6xxywBbPo3oVrvHX/7u38Zsg==
X-Received: by 2002:aa7:c88e:: with SMTP id p14mr1915403eds.119.1617175273039;
        Wed, 31 Mar 2021 00:21:13 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.154])
        by smtp.gmail.com with ESMTPSA id s11sm838337edt.27.2021.03.31.00.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 00:21:12 -0700 (PDT)
Subject: Re: [PATCH 1/4] kvm: cpuid: adjust the returned nent field of
 kvm_cpuid2 for KVM_GET_SUPPORTED_CPUID and KVM_GET_EMULATED_CPUID
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20210330185841.44792-1-eesposit@redhat.com>
 <20210330185841.44792-2-eesposit@redhat.com> <YGPmDbO++agqdqQL@google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <1be7c716-8160-926e-6d76-fb15b4adc066@redhat.com>
Date:   Wed, 31 Mar 2021 09:21:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YGPmDbO++agqdqQL@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 31/03/2021 05:01, Sean Christopherson wrote:
> On Tue, Mar 30, 2021, Emanuele Giuseppe Esposito wrote:
>> Calling the kvm KVM_GET_[SUPPORTED/EMULATED]_CPUID ioctl requires
>> a nent field inside the kvm_cpuid2 struct to be big enough to contain
>> all entries that will be set by kvm.
>> Therefore if the nent field is too high, kvm will adjust it to the
>> right value. If too low, -E2BIG is returned.
>>
>> However, when filling the entries do_cpuid_func() requires an
>> additional entry, so if the right nent is known in advance,
>> giving the exact number of entries won't work because it has to be increased
>> by one.
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 6bd2f8b830e4..5412b48b9103 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -975,6 +975,12 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>>   
>>   	if (cpuid->nent < 1)
>>   		return -E2BIG;
>> +
>> +	/* if there are X entries, we need to allocate at least X+1
>> +	 * entries but return the actual number of entries
>> +	 */
>> +	cpuid->nent++;
> 
> I don't see how this can be correct.
> 
> If this bonus entry really is needed, then won't that be reflected in array.nent?
> I.e won't KVM overrun the userspace buffer?
> 
> If it's not reflected in array.nent, that would imply there's an off-by-one check
> somewhere, or KVM is creating an entry that it doesn't copy to userspace.  The
> former seems unlikely as there are literally only two checks against maxnent,
> and they both look correct (famous last words...).
> 
> KVM does decrement array->nent in one specific case (CPUID.0xD.2..64), i.e. a
> false positive is theoretically possible, but that carries a WARN and requires a
> kernel or CPU bug as well.  And fudging nent for that case would still break
> normal use cases due to the overrun problem.
> 
> What am I missing?

(Maybe I should have put this series as RFC)

The problem I see and noticed while doing the KVM_GET_EMULATED_CPUID 
selftest is the following: assume there are 3 kvm emulated entries, and 
the user sets cpuid->nent = 3. This should work because kvm sets 3 
array->entries[], and copies them to user space.

However, when the 3rd entry is populated inside kvm (array->entries[2]), 
array->nent is increased once more (do_host_cpuid and 
__do_cpuid_func_emulated). At that point, the loop in 
kvm_dev_ioctl_get_cpuid and get_cpuid_func can potentially iterate once 
more, going into the

if (array->nent >= array->maxnent)
	return -E2BIG;

in __do_cpuid_func_emulated and do_host_cpuid, returning the error. I 
agree that we need that check there because the following code tries to 
access the array entry at array->nent index, but from what I understand 
that access can be potentially useless because it might just jump to the 
default entry in the switch statement and not set the entry, leaving 
array->nent to 3. Therefore with 3 kvm entries, the user would need to 
set cpuid->nent = 4 in order to work, even though only 3 entries are set.

There is no user space overflow because kvm uses array.nent in 
kvm_dev_ioctl_get_cpuid to specify how many entries to copy to the user.
My fix simply pre-increments the nent field on behalf of user space, so 
that an additional allocation is performed just in case but if not 
filled, it will not be copied to userspace.

Of course any better solution is very welcome :)

If you are wondering how a user can know in advance the exact number of 
nentries, the only way is to initially invoke the ioctl with cpuid->nent 
= 1000 or simply KVM_MAX_CPUID_ENTRIES, and kvm will not only set the 
entries but also adjust the nent field. In my case it was returning 3, 
but without this fix a successive KVM_GET_EMULATED_CPUID ioctl with nent 
= 3 would just return -E2BIG.

Thank you,
Emanuele

> 
>> +
>>   	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
>>   		cpuid->nent = KVM_MAX_CPUID_ENTRIES;
>>   
>> -- 
>> 2.30.2
>>
> 

