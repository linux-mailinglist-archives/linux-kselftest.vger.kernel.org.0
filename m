Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBC6359ED6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 14:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhDIMe6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 08:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233028AbhDIMe5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 08:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617971681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrEm6vZHVri6hjV+VlEozAzJGJuNVgmg6MRBLGVidsk=;
        b=O3zTGjnJIVAR7QMEFSiU8/2Nhp2BeXtq+dPKSWmseCY42xccjRjOjbw3oN2/sTeJRCORnQ
        5QIWNFfn1UNiJWod5945YLFQAKO4W0Qpz2l85gwKCLSAVZZoHnl/DsvLiB4JCHEaxRfTIH
        p8cPPyMKYW/KmCBTbwoTxc9kQDLxKJ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-r7xJv-ccOiGOmOnsVIa5Xg-1; Fri, 09 Apr 2021 08:34:40 -0400
X-MC-Unique: r7xJv-ccOiGOmOnsVIa5Xg-1
Received: by mail-wm1-f72.google.com with SMTP id y82-20020a1ce1550000b02901262158f1e9so507842wmg.8
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Apr 2021 05:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WrEm6vZHVri6hjV+VlEozAzJGJuNVgmg6MRBLGVidsk=;
        b=h/Boyuo+sTlTzUtKcAI2RQDfaJWj2nLzPEFL2DoRSFPGI7LTzxtWmp5M9UxCbogsyZ
         evXpcYXyaw3KHIcyD7UC4bZbE1suT6aczxG5ExeIcXdPIe+fauq8oQn8D8hDiFckHhAA
         W5/gfsY8y0ULI0/PmHrnpZVqwso/waVYtB6sMnrm7eoYQlojVyIREuj6M15RaX9vg/lu
         E2LAP45XMCJcRm5RMvjACGsmNidxIvvODZQufS5f2MUwpfesT+oR8Nx5SCkfP8cOWj3Z
         LHWW3NYQ6VmktpuI/oc1SVhu9bl93Bm7KjRvkIKbrgmIv3PJaTGsSPTyn8dTwODhvRDv
         YABg==
X-Gm-Message-State: AOAM533RBpHzYl0QtYHFa0cTHHHTASjipJJCYdHQf3/ewzftHYxV4ZOV
        HjukrLg7PmzzaseLAD7K/MFnznnSUeFoaD7uVC6WIPKJGFBsdMonzdpNhtcnbd3eveaoEe2X8GZ
        ntIcJLLQ+Zx9zX1pYO6+l/hAkWvvfdfbF6pkBIO1kW0lOZrIcBhBD0aonuXs77psgkGr8MEOHow
        N1SmTx
X-Received: by 2002:a5d:644e:: with SMTP id d14mr17123606wrw.339.1617971678280;
        Fri, 09 Apr 2021 05:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxUGpD7HjO5daDt1oGsFMpgGK4lWP5dsiPMLmwvcZD85K+7Mp5kdBf3eYobr4sxrvRT5Q9mQ==
X-Received: by 2002:a5d:644e:: with SMTP id d14mr17123579wrw.339.1617971678102;
        Fri, 09 Apr 2021 05:34:38 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.173])
        by smtp.gmail.com with ESMTPSA id p17sm3774470wmg.5.2021.04.09.05.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:34:36 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] KVM: x86: Fix a spurious -E2BIG in
 KVM_GET_EMULATED_CPUID
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
References: <20210408114303.30310-1-eesposit@redhat.com>
 <20210408114303.30310-2-eesposit@redhat.com> <YG9nq6Y7GhFo9dUh@google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <74b017e4-5a44-e20f-3435-ec48c4927ec4@redhat.com>
Date:   Fri, 9 Apr 2021 14:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG9nq6Y7GhFo9dUh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 08/04/2021 22:29, Sean Christopherson wrote:
> On Thu, Apr 08, 2021, Emanuele Giuseppe Esposito wrote:
>> When retrieving emulated CPUID entries, check for an insufficient array
>> size if and only if KVM is actually inserting an entry.
>> If userspace has a priori knowledge of the exact array size,
>> KVM_GET_EMULATED_CPUID will incorrectly fail due to effectively requiring
>> an extra, unused entry.
>>
>> Fixes: 433f4ba19041 ("KVM: x86: fix out-of-bounds write in KVM_GET_EMULATED_CPUID (CVE-2019-19332)")
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 33 ++++++++++++++++-----------------
>>   1 file changed, 16 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 6bd2f8b830e4..d30194081892 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -567,34 +567,33 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
>>   
>>   static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>>   {
>> -	struct kvm_cpuid_entry2 *entry;
>> -
>> -	if (array->nent >= array->maxnent)
>> -		return -E2BIG;
>> +	struct kvm_cpuid_entry2 entry;
>>   
>> -	entry = &array->entries[array->nent];
>> -	entry->function = func;
>> -	entry->index = 0;
>> -	entry->flags = 0;
>> +	memset(&entry, 0, sizeof(entry));
>>   
>>   	switch (func) {
>>   	case 0:
>> -		entry->eax = 7;
>> -		++array->nent;
>> +		entry.eax = 7;
>>   		break;
>>   	case 1:
>> -		entry->ecx = F(MOVBE);
>> -		++array->nent;
>> +		entry.ecx = F(MOVBE);
>>   		break;
>>   	case 7:
>> -		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
>> -		entry->eax = 0;
>> -		entry->ecx = F(RDPID);
>> -		++array->nent;
>> -	default:
>> +		entry.flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
>> +		entry.ecx = F(RDPID);
>>   		break;
>> +	default:
>> +		goto out;
>>   	}
>>   
>> +	/* This check is performed only when func is valid */
> 
> Sorry to keep nitpicking and bikeshedding.  

No problem at all. Any comment is very welcome :)

Funcs aren't really "invalid", KVM
> just doesn't have any features it emulates in other leafs.  Maybe be more literal
> in describing what triggers the check?
> 
> 	/* Check the array capacity iff the entry is being copied over. */

What I mean here is that a func is "valid" if it matches one of the 
cases of the switch statement. If it is not valid, it ends up in the 
default case. But I agree, will change the comment your suggestion and 
resend.

Thank you,
Emanuele

> 
> Not a sticking point, so either way:
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> 
>> +	if (array->nent >= array->maxnent)
>> +		return -E2BIG;
>> +
>> +	entry.function = func;
>> +	memcpy(&array->entries[array->nent++], &entry, sizeof(entry));
>> +
>> +out:
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.30.2
>>
> 

