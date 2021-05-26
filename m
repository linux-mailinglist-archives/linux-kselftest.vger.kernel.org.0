Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD49A391F2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhEZSd1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 14:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235549AbhEZSd0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 14:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622053914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94syvOS2iq38iWgkmR3FPLbAVi2GFd1p/dJkRiGRhzE=;
        b=eYyQfHe51CTv8OvkyM9yBMtuII2JFa60adtTursqTIMN0VsYxHnilOnLCc8jRKyull4iRm
        DystXtF+O8qPaLM7A/Yy2n1lUdnRDLhjr2sCOGO1YDSimKE1eQulisJGq/zyEORNFpYyhv
        aqK9U2jQrbwMWeudJUCo4UZb7zudKDk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-XL0KxUKrP6C3FTMWxgp7dw-1; Wed, 26 May 2021 14:31:53 -0400
X-MC-Unique: XL0KxUKrP6C3FTMWxgp7dw-1
Received: by mail-ej1-f70.google.com with SMTP id i8-20020a1709068508b02903d75f46b7aeso750984ejx.18
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 11:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=94syvOS2iq38iWgkmR3FPLbAVi2GFd1p/dJkRiGRhzE=;
        b=i/P1lDDpcrKuH5IsFXgdO/bWkQYDKiDXZmSfP3GEjPEItMkGrC7QgGpvuwk4YrIi7T
         MGeJLEtwOXAp2ajPqh3fRBdrQaXfveKIXFwGPxCZ4kE0d1xuik+Wyf/BeDcz+Rutv9zd
         uO0gYw+8zr+EcyVebnAtkTk3jG+e4glwIZDTd7E6eFumCcMi+TNbL7SFbZzvjFN800OB
         ylz6KWtWDNeOByXWUJH+HSdpRVaOhHcRRvxrL1HUDzi3M/NSsrbZphiUErfFQNVqmV2z
         vgn8em86VGVvMpc/1ItfFcN0O6mPy4880iF/8uhShh2cWvoWy0Q3ahGLmYtOMHdkx3ld
         ulpw==
X-Gm-Message-State: AOAM530GiZyZwlf74U8PTqtDK+V+ILVXrWgewbwoAQStY25CNjo/nxQX
        MDtYrYGcex0GyXCiadgYnVtT5vT2bwdfiAgWSsofLZ5+1ERH6UidbOzjb2kHQsjIvpyGbSPPK8V
        /Y4toZx3cFxK2SWlgA22Gu7wtEF+ANwrWoyj2uJw04tPCPjMz1uyaikYKd1f3p/3MfJQIIDi9cO
        piWEAD
X-Received: by 2002:a50:fd9a:: with SMTP id o26mr38385088edt.76.1622053911717;
        Wed, 26 May 2021 11:31:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxj/b4bQQAPZkwDCfSoX9eFDQaSkp7wcMIVVjBNJ19mjHBr5KE8Y3yPV7V8ObuGwD50taeBew==
X-Received: by 2002:a50:fd9a:: with SMTP id o26mr38385033edt.76.1622053911300;
        Wed, 26 May 2021 11:31:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dh21sm12995260edb.28.2021.05.26.11.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 11:31:50 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] KVM: selftests: create alias mappings when using
 shared memory
To:     Axel Rasmussen <axelrasmussen@google.com>,
        David Matlack <dmatlack@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Gardon <bgardon@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
References: <20210519200339.829146-1-axelrasmussen@google.com>
 <20210519200339.829146-9-axelrasmussen@google.com>
 <CALzav=eGi2_TBx=LDYpg6hRi8JabGPsHLC8M5-Vzf8DJHomSVQ@mail.gmail.com>
 <CAJHvVcjFJT8E35nhiNCLzT=f3DsPaWu1RjJNQqPWK9zspoBnSw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <553e0fdc-53ff-10a6-385a-2cf47f00899f@redhat.com>
Date:   Wed, 26 May 2021 20:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJHvVcjFJT8E35nhiNCLzT=f3DsPaWu1RjJNQqPWK9zspoBnSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26/05/21 19:22, Axel Rasmussen wrote:
> I applied this change on top of kvm/master and tested it, and indeed
> it compiles and works correctly.
> 
> Paolo, feel free to take this with a:
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> 
> Or alternatively if you prefer I'm happy to send it as a real
> git-send-email patch.

Yes, I squashed it.

Paolo

> On Tue, May 25, 2021 at 4:50 PM David Matlack <dmatlack@google.com> wrote:
>>
>> On Wed, May 19, 2021 at 1:04 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>>>
>>> When a memory region is added with a src_type specifying that it should
>>> use some kind of shared memory, also create an alias mapping to the same
>>> underlying physical pages.
>>>
>>> And, add an API so tests can get access to these alias addresses.
>>> Basically, for a guest physical address, let us look up the analogous
>>> host *alias* address.
>>>
>>> In a future commit, we'll modify the demand paging test to take
>>> advantage of this to exercise UFFD minor faults. The idea is, we
>>> pre-fault the underlying pages *via the alias*. When the *guest*
>>> faults, it gets a "minor" fault (PTEs don't exist yet, but a page is
>>> already in the page cache). Then, the userfaultfd theads can handle the
>>> fault: they could potentially modify the underlying memory *via the
>>> alias* if they wanted to, and then they install the PTEs and let the
>>> guest carry on via a UFFDIO_CONTINUE ioctl.
>>>
>>> Reviewed-by: Ben Gardon <bgardon@google.com>
>>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>>> ---
>>>   .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>>>   tools/testing/selftests/kvm/lib/kvm_util.c    | 51 +++++++++++++++++++
>>>   .../selftests/kvm/lib/kvm_util_internal.h     |  2 +
>>>   3 files changed, 54 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>>> index a8f022794ce3..0624f25a6803 100644
>>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>>> @@ -146,6 +146,7 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>>>   void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
>>>   void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
>>>   vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
>>> +void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
>>>
>>>   /*
>>>    * Address Guest Virtual to Guest Physical
>>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> index e4a8d0c43c5e..0b88d1bbc1e0 100644
>>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> @@ -811,6 +811,19 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>>>
>>>          /* Add to linked-list of memory regions. */
>>>          list_add(&region->list, &vm->userspace_mem_regions);
>>> +
>>> +       /* If shared memory, create an alias. */
>>> +       if (region->fd >= 0) {
>>> +               region->mmap_alias = mmap(NULL, region->mmap_size,
>>> +                                         PROT_READ | PROT_WRITE,
>>> +                                         vm_mem_backing_src_alias(src_type)->flag,
>>> +                                         region->fd, 0);
>>> +               TEST_ASSERT(region->mmap_alias != MAP_FAILED,
>>> +                           "mmap of alias failed, errno: %i", errno);
>>> +
>>> +               /* Align host alias address */
>>> +               region->host_alias = align(region->mmap_alias, alignment);
>>> +       }
>>>   }
>>>
>>>   /*
>>> @@ -1239,6 +1252,44 @@ vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva)
>>>          return -1;
>>>   }
>>>
>>> +/*
>>> + * Address VM physical to Host Virtual *alias*.
>>> + *
>>> + * Input Args:
>>> + *   vm - Virtual Machine
>>> + *   gpa - VM physical address
>>> + *
>>> + * Output Args: None
>>> + *
>>> + * Return:
>>> + *   Equivalent address within the host virtual *alias* area, or NULL
>>> + *   (without failing the test) if the guest memory is not shared (so
>>> + *   no alias exists).
>>> + *
>>> + * When vm_create() and related functions are called with a shared memory
>>> + * src_type, we also create a writable, shared alias mapping of the
>>> + * underlying guest memory. This allows the host to manipulate guest memory
>>> + * without mapping that memory in the guest's address space. And, for
>>> + * userfaultfd-based demand paging, we can do so without triggering userfaults.
>>> + */
>>> +void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
>>> +{
>>> +       struct userspace_mem_region *region;
>>> +
>>> +       list_for_each_entry(region, &vm->userspace_mem_regions, list) {
>>
>> This patch fails to compile on top of with db0670ce3361 ("KVM:
>> selftests: Keep track of memslots more efficiently").
>>
>> This can be reproduced by checking out kvm/master and running `make -C
>> tools/testing/selftests/kvm`.
>>
>> The following diff fixes the compilation error but I did not have time
>> to test it yet:
>>
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c
>> b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index c98db1846e1b..28e528c19d28 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -1374,19 +1374,17 @@ vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva)
>>   void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
>>   {
>>          struct userspace_mem_region *region;
>> +       uintptr_t offset;
>>
>> -       list_for_each_entry(region, &vm->userspace_mem_regions, list) {
>> -               if (!region->host_alias)
>> -                       continue;
>> +       region = userspace_mem_region_find(vm, gpa, gpa);
>> +       if (!region)
>> +               return NULL;
>>
>> -               if ((gpa >= region->region.guest_phys_addr)
>> -                       && (gpa <= (region->region.guest_phys_addr
>> -                               + region->region.memory_size - 1)))
>> -                       return (void *) ((uintptr_t) region->host_alias
>> -                               + (gpa - region->region.guest_phys_addr));
>> -       }
>> +       if (!region->host_alias)
>> +               return NULL;
>>
>> -       return NULL;
>> +       offset = gpa - region->region.guest_phys_addr;
>> +       return (void *) ((uintptr_t) region->host_alias + offset);
>>   }
>>
>>   /*
>>
>>
>>
>>> +               if (!region->host_alias)
>>> +                       continue;
>>> +
>>> +               if ((gpa >= region->region.guest_phys_addr)
>>> +                       && (gpa <= (region->region.guest_phys_addr
>>> +                               + region->region.memory_size - 1)))
>>> +                       return (void *) ((uintptr_t) region->host_alias
>>> +                               + (gpa - region->region.guest_phys_addr));
>>> +       }
>>> +
>>> +       return NULL;
>>> +}
>>> +
>>>   /*
>>>    * VM Create IRQ Chip
>>>    *
>>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
>>> index 91ce1b5d480b..a25af33d4a9c 100644
>>> --- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
>>> +++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
>>> @@ -16,7 +16,9 @@ struct userspace_mem_region {
>>>          int fd;
>>>          off_t offset;
>>>          void *host_mem;
>>> +       void *host_alias;
>>>          void *mmap_start;
>>> +       void *mmap_alias;
>>>          size_t mmap_size;
>>>          struct list_head list;
>>>   };
>>> --
>>> 2.31.1.751.gd2f1c929bd-goog
>>>
> 

