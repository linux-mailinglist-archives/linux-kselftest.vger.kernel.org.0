Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74B834FDC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhCaKHa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 06:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234974AbhCaKHU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 06:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617185239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bm++c+1VlgWS+VnaCRHUFFk01a8cY+kp6lk42gfIfr4=;
        b=QlnCCpTTI8T7drBNIQX6xl2Q12UzGEJTKoyCuxaNls3LY6iTLqnDffWPyfUx07ZRsbYp1j
        nxAg0rCUHdN7Js00FxARrI0xnBbKndFeLhiijH4ZnEKW02YKAaVDjGCA9uXbuFHbEhp9su
        QVwUp1RLqWx+8HRjh26A4BVwWDwqI40=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-NL_g6V6gPo-FfZhVd8lBcg-1; Wed, 31 Mar 2021 06:07:18 -0400
X-MC-Unique: NL_g6V6gPo-FfZhVd8lBcg-1
Received: by mail-ed1-f71.google.com with SMTP id q12so840189edv.9
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 03:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bm++c+1VlgWS+VnaCRHUFFk01a8cY+kp6lk42gfIfr4=;
        b=uNXoKBrhEWvnUX5S99QFVDdiQjTKbU+hg/nYK9VZGaJ64yw7h0q2AcWqE0rjHo/vK1
         Oa3cOxb0GFZjhAOR1Xtfyrjx6Zxh0BHeMem8Awv8AtvU9ldLXtAHBs4XW8nhFkeMXy5b
         ivBZdjANG+5bmiTZ6Mt9QPrcnUCu0hHUKuauck7tEbcsa8e/PK34KrJp/1THlo1/GwZe
         ff50S4X5q3zavZS+XecGqSkCSDCS2vEN31hp0t6RdUL2qhw9qELdRx/G6kqkKN3AnJXD
         daG6cIQ/3MOnka6hW5owo+UzMA4vhtiaO144OlQKvVQzboEqdkE5eetzUwCRxdBa7yOv
         xcvg==
X-Gm-Message-State: AOAM531pzpYsKRN4WUrzk7JSzHjESTOTygm2b2F7OmNVTASUUi1y5/hz
        YnJ3+hP2U8NmV58ExxvY+e9SCM5xBsdkhFTfSQpbQyC/z0ug392hnXdcg5XLi89IgmBFM1pmHVm
        sBsIZFd114iVEW8lDH89BSP/sG+aq
X-Received: by 2002:aa7:d2d5:: with SMTP id k21mr2677869edr.216.1617185236724;
        Wed, 31 Mar 2021 03:07:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvzhv1VUya9K3jIgLaWMjPWf122CdHmdeQRUIqNd3m/Au+UXZfEO2S14HnC6jPB+w5izpKLw==
X-Received: by 2002:aa7:d2d5:: with SMTP id k21mr2677832edr.216.1617185236430;
        Wed, 31 Mar 2021 03:07:16 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.154])
        by smtp.gmail.com with ESMTPSA id a22sm1162412edu.14.2021.03.31.03.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 03:07:15 -0700 (PDT)
Subject: Re: [PATCH 1/4] kvm: cpuid: adjust the returned nent field of
 kvm_cpuid2 for KVM_GET_SUPPORTED_CPUID and KVM_GET_EMULATED_CPUID
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
References: <20210330185841.44792-1-eesposit@redhat.com>
 <20210330185841.44792-2-eesposit@redhat.com> <YGPmDbO++agqdqQL@google.com>
 <1be7c716-8160-926e-6d76-fb15b4adc066@redhat.com>
 <877dlnu56q.fsf@vitty.brq.redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <9b68907b-cb99-db0d-9151-0d3d5cf3c972@redhat.com>
Date:   Wed, 31 Mar 2021 12:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <877dlnu56q.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 31/03/2021 09:56, Vitaly Kuznetsov wrote:
> Emanuele Giuseppe Esposito <eesposit@redhat.com> writes:
> 
>> On 31/03/2021 05:01, Sean Christopherson wrote:
>>> On Tue, Mar 30, 2021, Emanuele Giuseppe Esposito wrote:
>>>> Calling the kvm KVM_GET_[SUPPORTED/EMULATED]_CPUID ioctl requires
>>>> a nent field inside the kvm_cpuid2 struct to be big enough to contain
>>>> all entries that will be set by kvm.
>>>> Therefore if the nent field is too high, kvm will adjust it to the
>>>> right value. If too low, -E2BIG is returned.
>>>>
>>>> However, when filling the entries do_cpuid_func() requires an
>>>> additional entry, so if the right nent is known in advance,
>>>> giving the exact number of entries won't work because it has to be increased
>>>> by one.
>>>>
>>>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>>>> ---
>>>>    arch/x86/kvm/cpuid.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>>>> index 6bd2f8b830e4..5412b48b9103 100644
>>>> --- a/arch/x86/kvm/cpuid.c
>>>> +++ b/arch/x86/kvm/cpuid.c
>>>> @@ -975,6 +975,12 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>>>>    
>>>>    	if (cpuid->nent < 1)
>>>>    		return -E2BIG;
>>>> +
>>>> +	/* if there are X entries, we need to allocate at least X+1
>>>> +	 * entries but return the actual number of entries
>>>> +	 */
>>>> +	cpuid->nent++;
>>>
>>> I don't see how this can be correct.
>>>
>>> If this bonus entry really is needed, then won't that be reflected in array.nent?
>>> I.e won't KVM overrun the userspace buffer?
>>>
>>> If it's not reflected in array.nent, that would imply there's an off-by-one check
>>> somewhere, or KVM is creating an entry that it doesn't copy to userspace.  The
>>> former seems unlikely as there are literally only two checks against maxnent,
>>> and they both look correct (famous last words...).
>>>
>>> KVM does decrement array->nent in one specific case (CPUID.0xD.2..64), i.e. a
>>> false positive is theoretically possible, but that carries a WARN and requires a
>>> kernel or CPU bug as well.  And fudging nent for that case would still break
>>> normal use cases due to the overrun problem.
>>>
>>> What am I missing?
>>
>> (Maybe I should have put this series as RFC)
>>
>> The problem I see and noticed while doing the KVM_GET_EMULATED_CPUID
>> selftest is the following: assume there are 3 kvm emulated entries, and
>> the user sets cpuid->nent = 3. This should work because kvm sets 3
>> array->entries[], and copies them to user space.
>>
>> However, when the 3rd entry is populated inside kvm (array->entries[2]),
>> array->nent is increased once more (do_host_cpuid and
>> __do_cpuid_func_emulated). At that point, the loop in
>> kvm_dev_ioctl_get_cpuid and get_cpuid_func can potentially iterate once
>> more, going into the
>>
>> if (array->nent >= array->maxnent)
>> 	return -E2BIG;
>>
>> in __do_cpuid_func_emulated and do_host_cpuid, returning the error. I
>> agree that we need that check there because the following code tries to
>> access the array entry at array->nent index, but from what I understand
>> that access can be potentially useless because it might just jump to the
>> default entry in the switch statement and not set the entry, leaving
>> array->nent to 3.
> 
> The problem seems to be exclusive to __do_cpuid_func_emulated(),
> do_host_cpuid() always does
> 
> entry = &array->entries[array->nent++];
> 
> Something like (completely untested and stupid):
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6bd2f8b830e4..54dcabd3abec 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -565,14 +565,22 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
>          return entry;
>   }
>   
> +static bool cpuid_func_emulated(u32 func)
> +{
> +       return (func == 0) || (func == 1) || (func == 7);
> +}
> +
>   static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>   {
>          struct kvm_cpuid_entry2 *entry;
>   
> +       if (!cpuid_func_emulated())
> +               return 0;
> +
>          if (array->nent >= array->maxnent)
>                  return -E2BIG;
>   
> -       entry = &array->entries[array->nent];
> +       entry = &array->entries[array->nent++];
>          entry->function = func;
>          entry->index = 0;
>          entry->flags = 0;
> @@ -580,18 +588,14 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
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
>          }
> 
> should do the job, right?
> 
> 

Yes, it would work better. Alternatively:

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ba7437308d28..452b0acd6e9d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -567,34 +567,37 @@ static struct kvm_cpuid_entry2 
*do_host_cpuid(struct kvm_cpuid_array *array,

  static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 
func)
  {
-	struct kvm_cpuid_entry2 *entry;
-
-	if (array->nent >= array->maxnent)
-		return -E2BIG;
+	struct kvm_cpuid_entry2 entry;
+	bool changed = true;

-	entry = &array->entries[array->nent];
-	entry->function = func;
-	entry->index = 0;
-	entry->flags = 0;
+	entry.function = func;
+	entry.index = 0;
+	entry.flags = 0;

  	switch (func) {
  	case 0:
-		entry->eax = 7;
-		++array->nent;
+		entry.eax = 7;
  		break;
  	case 1:
-		entry->ecx = F(MOVBE);
-		++array->nent;
+		entry.ecx = F(MOVBE);
  		break;
  	case 7:
-		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-		entry->eax = 0;
-		entry->ecx = F(RDPID);
-		++array->nent;
+		entry.flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+		entry.eax = 0;
+		entry.ecx = F(RDPID);
+		break;
  	default:
+		changed = false;
  		break;
  	}

+	if (changed) {
+		if (array->nent >= array->maxnent)
+			return -E2BIG;
+
+		memcpy(&array->entries[array->nent++], &entry, sizeof(entry));
+	}
+
  	return 0;
  }

pros: avoids hard-coding another function that would check what the 
switch already does. it will be more flexible if another func has to be 
added.
cons: there is a memcpy for each entry.

What do you think?

Emanuele

