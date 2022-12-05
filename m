Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9830D642C08
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 16:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiLEPko (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 10:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiLEPko (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 10:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9572A324
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670254790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4DnLiVd7TqHoYp1fGwa2EmHtbH0Mt+vbsAU9CAo3Kg=;
        b=FEWftpJqlsZ+xuMK3q2+ypIen5AMXulabs1YSc9XoAbqDPzy4eK0riKYFTIpG08kLj7jUW
        Jfc0Npf1TK0b5pngm7/Cg7agPeDNKVnpPYDHgf43uP7dVXiPQ5mctaFemlySI5lD9PqWme
        Vp2XcFHQT7maIn/qactdxrMrbuIKa5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-303-gGGRFhSIM4i9p-96-ZKy0g-1; Mon, 05 Dec 2022 10:39:49 -0500
X-MC-Unique: gGGRFhSIM4i9p-96-ZKy0g-1
Received: by mail-wm1-f69.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso7054522wms.5
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 07:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4DnLiVd7TqHoYp1fGwa2EmHtbH0Mt+vbsAU9CAo3Kg=;
        b=ilJReLhNWJLozyzHUXbUfWgCNJHH1t40oKbf947K+4Q11Lagb2L3f+zfLI2Pm//vdR
         M+/FgM47Y1+bBT2VBIe/QfexQ8pt2kb4eOX4zc3LgMvuLMEdAftKF6tmp04ntL8MPAHQ
         3PNTDqCXdYx21DMQRkB2TFX3LISenOOf7qYH4O19NKUI6hYfyl91ST+G8z6e6RdNZpr8
         BBkBfEcm53DY7O35TW6MsA6srv7pUo9Z7P+REsmjZaOm1AbmOTnnWmb2Rf8qd4s6USTR
         4nAjIyTfxCL09OMtDCRyABxenHkD7o9dQ2i2R8uWk14DZ6LKTOJsMAC/hU2YT82Bldum
         TXwA==
X-Gm-Message-State: ANoB5plM2wSo544vkG8XMSNalvxuLLDo8CmKragjDQc/GNkQibDmZg7O
        eWyRvIAg4B6tCoCikQpIXIqopaFaPo0TFUULyQNMUj/zIPxhv58yxTwt8BLgQcWsmCq5SfdgOJJ
        cnOneLd88dEvSwpQ7/A/Sn67IQoXh
X-Received: by 2002:adf:f54e:0:b0:242:1534:7b57 with SMTP id j14-20020adff54e000000b0024215347b57mr23767622wrp.404.1670254787289;
        Mon, 05 Dec 2022 07:39:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ns6147ENVOY+4U+3nXYBeqCfVc+dkCMwDQGQmjak40ZYtcAJWcTD3SyK7GUPxaX4/yVdqKw==
X-Received: by 2002:adf:f54e:0:b0:242:1534:7b57 with SMTP id j14-20020adff54e000000b0024215347b57mr23767580wrp.404.1670254786889;
        Mon, 05 Dec 2022 07:39:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:fe00:a7c9:b0d6:909d:124a? (p200300cbc701fe00a7c9b0d6909d124a.dip0.t-ipconnect.de. [2003:cb:c701:fe00:a7c9:b0d6:909d:124a])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b003b47e75b401sm24728909wmq.37.2022.12.05.07.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 07:39:46 -0800 (PST)
Message-ID: <b3ca2e31-547e-6a73-abba-83ac0de74f0a@redhat.com>
Date:   Mon, 5 Dec 2022 16:39:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <9c167d01-ef09-ec4e-b4a1-2fff62bf01fe@redhat.com>
 <6fdce544-8d4f-8b3c-9208-735769a9e624@collabora.com>
 <a90ee936-67a9-340d-bf2c-2f331617b0da@redhat.com>
 <254130e7-7fb1-6cf1-e8fa-5bc2d4450431@collabora.com>
 <bfcae708-db21-04b4-0bbe-712badd03071@redhat.com>
 <3d069746-d440-f1a6-1b64-5ee196c2fc21@collabora.com>
 <d7f7b120-b62d-dc2e-ad7a-f7957d3456e3@redhat.com>
 <31fe345b-06ac-8c2c-1540-76dd09eca3ee@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 0/3] Implement IOCTL to get and/or the clear info about
 PTEs
In-Reply-To: <31fe345b-06ac-8c2c-1540-76dd09eca3ee@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05.12.22 16:29, Muhammad Usama Anjum wrote:
> On 11/30/22 5:10 PM, David Hildenbrand wrote:
>> On 30.11.22 12:42, Muhammad Usama Anjum wrote:
>>> On 11/21/22 8:55 PM, David Hildenbrand wrote:
>>>> On 21.11.22 16:00, Muhammad Usama Anjum wrote:
>>>>> Hello,
>>>>>
>>>>> Thank you for replying.
>>>>>
>>>>> On 11/14/22 8:46 PM, David Hildenbrand wrote:
>>>>>>> The soft-dirtiness is stored in the PTE. VMA is marked dirty to store
>>>>>>> the
>>>>>>> dirtiness for reused regions. Clearing the soft-dirty status of whole
>>>>>>> process is straight forward. When we want to clear/monitor the
>>>>>>> soft-dirtiness of a part of the virtual memory, there is a lot of
>>>>>>> internal
>>>>>>> noise. We don't want the non-dirty pages to become dirty because of how
>>>>>>> the
>>>>>>> soft-dirty feature has been working. Soft-dirty feature wasn't being
>>>>>>> used
>>>>>>> the way we want to use now. While monitoring a part of memory, it is not
>>>>>>> acceptable to get non-dirty pages as dirty. Non-dirty pages become dirty
>>>>>>> when the two VMAs are merged without considering if they both are
>>>>>>> dirty or
>>>>>>> not (34228d473efe). To monitor changes over the memory, sometimes
>>>>>>> VMAs are
>>>>>>> split to clear the soft-dirty bit in the VMA flags. But sometimes kernel
>>>>>>> decide to merge them backup. It is so waste of resources.
>>>>>>
>>>>>> Maybe you'd want a per-process option to not merge if the VM_SOFTDIRTY
>>>>>> property differs. But that might be just one alternative for handling
>>>>>> this
>>>>>> case.
>>>>>>
>>>>>>>
>>>>>>> To keep things consistent, the default behavior of the IOCTL is to
>>>>>>> output
>>>>>>> even the extra non-dirty pages as dirty from the kernel noise. A
>>>>>>> optional
>>>>>>> PAGEMAP_NO_REUSED_REGIONS flag is added for those use cases which aren't
>>>>>>> tolerant of extra non-dirty pages. This flag can be considered as
>>>>>>> something
>>>>>>> which is by-passing the already present buggy implementation in the
>>>>>>> kernel.
>>>>>>> It is not buggy per say as the issue can be solved if we don't allow the
>>>>>>> two VMA which have different soft-dirty bits to get merged. But we are
>>>>>>> allowing that so that the total number of VMAs doesn't increase. This
>>>>>>> was
>>>>>>> acceptable at the time, but now with the use case of monitoring a
>>>>>>> part of
>>>>>>> memory for soft-dirty doesn't want this merging. So either we need to
>>>>>>> revert 34228d473efe and PAGEMAP_NO_REUSED_REGIONS flag will not be
>>>>>>> needed
>>>>>>> or we should allow PAGEMAP_NO_REUSED_REGIONS or similar mechanism to
>>>>>>> ignore
>>>>>>> the extra dirty pages which aren't dirty in reality.
>>>>>>>
>>>>>>> When PAGEMAP_NO_REUSED_REGIONS flag is used, only the PTEs are
>>>>>>> checked to
>>>>>>> find if the pages are dirty. So re-used regions cannot be detected. This
>>>>>>> has the only side-effect of not checking the VMAs. So this is
>>>>>>> limitation of
>>>>>>> using this flag which should be acceptable in the current state of code.
>>>>>>> This limitation is okay for the users as they can clear the
>>>>>>> soft-dirty bit
>>>>>>> of the VMA before starting to monitor a range of memory for
>>>>>>> soft-dirtiness.
>>>>>>>
>>>>>>>
>>>>>>>> Please separate that part out from the other changes; I am still not
>>>>>>>> convinced that we want this and what the semantical implications are.
>>>>>>>>
>>>>>>>> Let's take a look at an example: can_change_pte_writable()
>>>>>>>>
>>>>>>>>         /* Do we need write faults for softdirty tracking? */
>>>>>>>>         if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
>>>>>>>>             return false;
>>>>>>>>
>>>>>>>> We care about PTE softdirty tracking, if it is enabled for the VMA.
>>>>>>>> Tracking is enabled if: vma_soft_dirty_enabled()
>>>>>>>>
>>>>>>>>         /*
>>>>>>>>          * Soft-dirty is kind of special: its tracking is enabled when
>>>>>>>>          * the vma flags not set.
>>>>>>>>          */
>>>>>>>>         return !(vma->vm_flags & VM_SOFTDIRTY);
>>>>>>>>
>>>>>>>> Consequently, if VM_SOFTDIRTY is set, we are not considering the
>>>>>>>> soft_dirty
>>>>>>>> PTE bits accordingly.
>>>>>>> Sorry, I'm unable to completely grasp the meaning of the example. We
>>>>>>> have
>>>>>>> followed clear_refs_write() to write the soft-dirty bit clearing code in
>>>>>>> the current patch. Dirtiness of the VMA and the PTE may be set
>>>>>>> independently. Newer allocated memory has dirty bit set in the VMA. When
>>>>>>> something is written the memory, the soft dirty bit is set in the
>>>>>>> PTEs as
>>>>>>> well regardless if the soft dirty bit is set in the VMA or not.
>>>>>>>
>>>>>>
>>>>>> Let me try to find a simple explanation:
>>>>>>
>>>>>> After clearing a SOFTDIRTY PTE flag inside an area with VM_SOFTDIRTY set,
>>>>>> there are ways that PTE could get written to and it could become dirty,
>>>>>> without the PTE becoming softdirty.
>>>>>>
>>>>>> Essentially, inside a VMA with VM_SOFTDIRTY set, the PTE softdirty values
>>>>>> might be stale: there might be entries that are softdirty even though the
>>>>>> PTE is *not* marked softdirty.
>>>>> Can someone please share the example to reproduce this? In all of my
>>>>> testing, even if I ignore VM_SOFTDIRTY and only base my decision of
>>>>> soft-dirtiness on individual pages, it always passes.
>>>>
>>>> Quick reproducer (the first and easiest one that triggered :) )
>>>> attached.
>>>>
>>>> With no kernel changes, it works as expected.
>>>>
>>>> # ./softdirty_mprotect
>>>>
>>>>
>>>> With the following kernel change to simulate what you propose it fails:
>>>>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index d22687d2e81e..f2c682bf7f64 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -1457,8 +1457,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct
>>>> pagemapread *pm,
>>>>                   flags |= PM_FILE;
>>>>           if (page && !migration && page_mapcount(page) == 1)
>>>>                   flags |= PM_MMAP_EXCLUSIVE;
>>>> -       if (vma->vm_flags & VM_SOFTDIRTY)
>>>> -               flags |= PM_SOFT_DIRTY;
>>>> +       //if (vma->vm_flags & VM_SOFTDIRTY)
>>>> +       //      flags |= PM_SOFT_DIRTY;
>>>>             return make_pme(frame, flags);
>>>>    }
>>>>
>>>>
>>>> # ./softdirty_mprotect
>>>> Page #1 should be softdirty
>>>>
>>> Thank you so much for sharing the issue and reproducer.
>>>
>>> After remapping the second part of the memory and m-protecting +
>>> m-unprotecting the whole memory, the PTE of the first half of the memory
>>> doesn't get marked as soft dirty even after writing multiple times to it.
>>> Even if soft-dirtiness is cleared on the whole process, the PTE of the
>>> first half memory doesn't get dirty. This seems like more of a bug in
>>> mprotect. The mprotect should not mess up with the soft-dirty flag in the
>>> PTEs.
>>>
>>> I'm debugging this. I hope to find the issue soon. Soft-dirty tracking in
>>> PTEs should be working correctly irrespective of the VM_SOFTDIRTY is set or
>>> not on the VMA.
>>
>> No, it's not a bug and these are not the VM_SOFTDIRTY semantics -- just
>> because you think they should be like this. As people explained,
>> VM_SOFTDIRTY implies *until now* that any PTE is consideres softdirty. And
>> there are other scenarios that can similarly trigger something like that,
>> besides mprotect().
>>
>> Sorry if I sound annoyed, but please
>>
>> 1) factor out that from your patch set for now
>> 2) find a way to handle this cleanly, for example, not merging VMAs that
>>     differ in VM_SOFTDIRTY
>>
> 
> I'm extremely sorry for the annoyance. I absolutely understand your point.

No need to be sorry :)

> The problem is that the half of this IOCTL wouldn't be useful without
> solving the extra soft-dirty pages issue. We don't want to upstream
> something which we wouldn't be using until 2 is solved. This is why we are
> trying to solve the point 2 before upstreaming the 1. I'm working on ideas
> on how this can be resolved or redesigned entirely. Maybe Cyril will share
> the ideas soon once he has some time. He was involved in the soft-dirty
> feature development.

Got it, thanks for the info on usability without this feature. Let me 
make my point clearer: exposing VM_SOFTDIRTY details to user space and 
providing different kinds of "soft dirty" really is sub-optimal from an 
ABI POV.

It would be really preferred if we could just find a way to improve the 
soft-dirty implementation in a way such that no such ABI hacks are 
required and that the existing interface will provide the semantics you 
want. For example, if we could rework the VMA merging case that would be 
really preferable.

I understand that we might want more fine-grained soft-dirty clearing 
IOCTLs. My primary concern is regarding the VM_SOFTDIRTY special-casing 
just when observing whether a PTE is softdirty.

-- 
Thanks,

David / dhildenb

