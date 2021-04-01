Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE6351234
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Apr 2021 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhDAJ2w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Apr 2021 05:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233827AbhDAJ2l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Apr 2021 05:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617269320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdAJIUk4E0rZzWrFLM7OQdm2JVVzi0mVz8CuYgR6iRQ=;
        b=ToJ0UwdOd4Qh4AGmWgAdUtFFtLWpwYKTAdqUFsrrWdB8U6G/hqzYeSlJvJJAlJXdr3buYK
        sU0pzgzb6HUEGcyXpLJErLkTthybYHZV9Ua6In6wat7cqhcpg1dAYcQ1WDZzGkqgjNJa75
        IgPtvHOyA7ngF8uXw8GVCHUj8J01gJU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-Zh6fwM53MbOZJDU9NaawuQ-1; Thu, 01 Apr 2021 05:28:39 -0400
X-MC-Unique: Zh6fwM53MbOZJDU9NaawuQ-1
Received: by mail-ed1-f72.google.com with SMTP id k8so2529578edn.19
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Apr 2021 02:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CdAJIUk4E0rZzWrFLM7OQdm2JVVzi0mVz8CuYgR6iRQ=;
        b=p9rGkpwtIHI7tJtO7kFTp+lAjxU5WIz3A7N3eZ9P4J3Q3gtyeIg3mSl3m3aYAKqnJC
         SmQtpsCVVKp6Z9yKxy9LopuVsj/Rt0Os6Bfgxl90oE1uI6f15IICyeM6xLzXslrhdjhC
         Gg8Z+NsJIHddHVJvoJcKVwVsuVUx11X3PnXaLsp9pn5SdGQ1t+P9TIGnA1bgY3GfdVeE
         rfVGk2JqPSJlzkimfz+SyFrB04kEKZYnqUwPkfh/aXvXHtHxHwU92YvAU8CkrBAsPcM9
         QJcfLGnXwGgwS+B/7m++SPMKZ9/UrRqj6x0RQFUz3LqNvaOJi+w9iw+uwDQFW6J4pLmR
         m5CQ==
X-Gm-Message-State: AOAM53072VzQwa1kuYnoN4BpXHULxE8NGahfR5q3qlN8wJuX2F/qyiwr
        16xh7qIeZjW34l1URBvAlTzExLFdWzBAfILcIMGVlOz1kocO6AVGyJ4FUpazMCtA7h9AJTvPrDk
        p4C1kAH7jRIJWNRTLLYAVRGXvlWEeqAS2l32NeBATTRnIcdDCUB+hvAOEeSF8ADaHns5nTBwBdY
        +yWvg8
X-Received: by 2002:a17:906:e16:: with SMTP id l22mr8099326eji.173.1617269318037;
        Thu, 01 Apr 2021 02:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIlGvqJGxpSAvkxwuKoS+tfRvPYTtyqOWPe5X29pYmiMYvtWLlSZhmpHnmVGL4jZJzfGGOcA==
X-Received: by 2002:a17:906:e16:: with SMTP id l22mr8099291eji.173.1617269317705;
        Thu, 01 Apr 2021 02:28:37 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.195])
        by smtp.gmail.com with ESMTPSA id t17sm3215284edr.36.2021.04.01.02.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:28:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] kvm: cpuid: adjust the returned nent field of
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
References: <20210331122649.38323-1-eesposit@redhat.com>
 <20210331122649.38323-2-eesposit@redhat.com> <YGS/7hQo91cVuXbB@google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <c0f9e1b6-e751-a06f-e753-6603f17a6bce@redhat.com>
Date:   Thu, 1 Apr 2021 11:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YGS/7hQo91cVuXbB@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 31/03/2021 20:31, Sean Christopherson wrote:
> On Wed, Mar 31, 2021, Emanuele Giuseppe Esposito wrote:
>> Calling the kvm KVM_GET_[SUPPORTED/EMULATED]_CPUID ioctl requires
>> a nent field inside the kvm_cpuid2 struct to be big enough to contain
>> all entries that will be set by kvm.
>> Therefore if the nent field is too high, kvm will adjust it to the
>> right value. If too low, -E2BIG is returned.
>>
>> However, when filling the entries do_cpuid_func() requires an
>> additional entry, so if the right nent is known in advance,
>> giving the exact number of entries won't work because it has to be
>> increased by one.
> 
> I'd strong prefer to reword the shortlog and changelog.  It's not immediately
> obvious what this is changing without the context from the v1 thread.  E.g.
> 
>    KVM: x86: Fix a spurious -E2BIG in KVM_GET_EMULATED_CPUID
> 
>    When retrieving emulated CPUID entries, check for an insufficient array size
>    if and only if KVM is actually inserting an entry.  If userspace has a priori
>    knowledge of the exact array size, KVM_GET_EMULATED_CPUID will incorrectly
>    fail due to effectively requiring an extra, unused entry.

I will update it with v3, thanks.

> 
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 35 ++++++++++++++++++-----------------
>>   1 file changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 6bd2f8b830e4..02a51f921548 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -567,34 +567,34 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
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
>> +	entry.function = func;
>> +	entry.index = 0;
>> +	entry.flags = 0;
> 
> Depending on the leaf, eax/ebx/ecx/edx will be left uninitialized.  This wasn't
> a bug before since @array is zeroed on allocation.
> 
> What about pre-checking @func?  I don't particular like the duplicate checks,
> but none of the solutions are particularly elegant.  E.g.
You're right, I should have zeroed it. I agree that memsetting and 
memcopying is not elegant either, but unless I am missing something and 
it changes the intended behavior, IMHO this avoids duplicate checks and 
makes it simpler to add a new 'func'.

Emanuele
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6bd2f8b830e4..9824947bd5ad 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -565,14 +565,18 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
>          return entry;
>   }
> 
> -static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
> +static noinline int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>   {
>          struct kvm_cpuid_entry2 *entry;
> 
> +       if (func != 0 && func != 1 && func != 7)
> +               return 0;
> +
>          if (array->nent >= array->maxnent)
>                  return -E2BIG;
> 
> -       entry = &array->entries[array->nent];
> +       entry = &array->entries[array->nent++];
> +
>          entry->function = func;
>          entry->index = 0;
>          entry->flags = 0;
> @@ -580,19 +584,17 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>          switch (func) {
>          case 0:
>                  entry->eax = 7;
> -               ++array->nent;
>                  break;
>          case 1:
>                  entry->ecx = F(MOVBE);
> -               ++array->nent;
>                  break;
>          case 7:
>                  entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
>                  entry->eax = 0;
>                  entry->ecx = F(RDPID);
> -               ++array->nent;
> -       default:
>                  break;
> +       default:
> +               BUG();
>          }
> 
>          return 0
> 
> 
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
>> +		entry.flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
>> +		entry.eax = 0;
>> +		entry.ecx = F(RDPID);
>>   		break;
>> +	default:
>> +		goto out;
>>   	}
>>   
>> +	if (array->nent >= array->maxnent)
>> +		return -E2BIG;
>> +
>> +	memcpy(&array->entries[array->nent++], &entry, sizeof(entry));
>> +
>> +out:
>>   	return 0;
>>   }
>>   
>> @@ -975,6 +975,7 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>>   
>>   	if (cpuid->nent < 1)
>>   		return -E2BIG;
>> +
>>   	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
>>   		cpuid->nent = KVM_MAX_CPUID_ENTRIES;
>>   
>> -- 
>> 2.30.2
>>
> 

