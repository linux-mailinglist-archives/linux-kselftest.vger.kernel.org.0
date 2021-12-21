Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613B447C2A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 16:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhLUPTq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 10:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239343AbhLUPTm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 10:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640099981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gm3ZLQRBKvCHbJaSdAbt4E0N/aoi9RgH7ebjbXdmrk=;
        b=Zu2Vi9GjAiJsHK4DcHzaAS7U0Ij3iZ4/oB4ldM0NUAIeSmBO7wpBo8iDLvb84uY6+maVDM
        +BxLWg3gHIp46pYysxXHEWG+UF21LRG3rSqMehvYK1XXaW/EHe8J2VacAUCWdzANX17ZCc
        JRVlc/GHoNDSOr+LoFXLonrNpu8IkKk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-7jEhJC8vOPKjA2ncdFGR9A-1; Tue, 21 Dec 2021 10:19:39 -0500
X-MC-Unique: 7jEhJC8vOPKjA2ncdFGR9A-1
Received: by mail-wm1-f69.google.com with SMTP id bg20-20020a05600c3c9400b0033a9300b44bso1161430wmb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 07:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=5gm3ZLQRBKvCHbJaSdAbt4E0N/aoi9RgH7ebjbXdmrk=;
        b=rnYmG5LTqV55pZrAHf3nXIZdftgDvlwvzmnQXtMYCO/55bR1peDn20J9Ndw0SGLxbs
         wzr99gW5Q0cgmG7MOdNuKBHTdYXquvTOb3je4BgKMYB+IlmhXV+hEdpcBLGClz0QFgfL
         6C7SgYebckSVtngvXCAULYSC0lEnBMyUiJyzEjT8o4w5okTNVDhYYXCbAfjFGgoyBb8B
         WVdmXyBQlyoYGQTBHrRv5umoUzQK2OcU8+ARkcBrHDhOwbJoyU8KhlE91XLLX5Qatba7
         fwnysPQ4/RmncSLBlPU5DC/g3K7tJwSSmRoySmZcooWCgjtoeUGWallz7X53A0EhaC4n
         qbuw==
X-Gm-Message-State: AOAM530jot1bJYY7PRcqYVTHFNDdbchZa3hlcUFGBoXjqrZ+4GtIUcBu
        hHFPPAY7KOhHjJa8QYSEqjG+K8DIC8JqmqFWjo8qxqxWnVSVijr2CacAihT4RUBXrOHnX0W+RnA
        e04G2oFEMuvvqM52FvdAen+CxxHVX
X-Received: by 2002:adf:db04:: with SMTP id s4mr3123264wri.467.1640099978747;
        Tue, 21 Dec 2021 07:19:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwj9M2fdwpVEPT599gXIT3luVo4I7J5XVEWxtoh26mgFPng1aOUYRQ3MOTjaZ8BGRLBTURDIQ==
X-Received: by 2002:adf:db04:: with SMTP id s4mr3123235wri.467.1640099978458;
        Tue, 21 Dec 2021 07:19:38 -0800 (PST)
Received: from [192.168.3.132] (p5b0c64a4.dip0.t-ipconnect.de. [91.12.100.164])
        by smtp.gmail.com with ESMTPSA id o38sm2925317wms.4.2021.12.21.07.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:19:37 -0800 (PST)
Message-ID: <303f21d3-42b4-2f11-3f22-28f89f819080@redhat.com>
Date:   Tue, 21 Dec 2021 16:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <20211221142812.GD1432915@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <20211221142812.GD1432915@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21.12.21 15:28, Jason Gunthorpe wrote:
> On Tue, Dec 21, 2021 at 09:58:32AM +0100, David Hildenbrand wrote:
>>> I'm having a hard time imagining how gup_fast can maintain any sort of
>>> bit - it lacks all forms of locks so how can we do an atomic test and
>>> set between two pieces of data?
>>
>> And exactly that is to be figured out.
>>
>> Note that I am trying to make also any kind of R/O pins on an anonymous
>> page work as expected as well, to fix any kind of GUP after fork() and
>> GUP before fork(). So taking a R/O pin on an !PageAnonExclusive() page
>> similarly has to make sure that the page is exclusive -- even if it's
>> mapped R/O (!).
> 
> Why? AFAIK we don't have bugs here. If the page is RO and has an
> elevated refcount it cannot be 'PageAnonExclusive' and so any place
> that wants to drop the WP just cannot. What is the issue?

Sure it can.

1. Map page R/W
2. Pin it R/W
3. Swapout
4. Read access

Page is now mapped R/O and *has to be* marked PageAnonExclusive(), to
properly skip the COW fault. That's literally 60% of the reproducers we
have that need fixing.


But what I think you actually mean is if we want to get R/O pins right.
> 
>> BUT, it would mean that whenever we fork() and there is one additional
>> reference on a page (even if it's from the swapcache), we would slow
>> down fork() even if there was never any GUP. This would apply to any
>> process out there that does a fork() ...
> 
> You mean because we'd copy?

Yes.

> 
> Is this common? Linus' prior email was talking as though swap is so
> rare we should't optimize for it?
At least in the enterprise segment having swap enabled is mostly a hard
documented requirement. On customer installations swap is still common,
and even gets replaced zswap that is enabled automatically in many
installations ...

So in the world I live and work in, swap is used frequently.

>  
>> So the idea is to mark a page only exclusive as soon as someone needs
>> the page to be exclusive and stay exclusive (-> e.g., GUP with FOLL_PIN
>> or selected FOLL_GET like O_DIRECT). This can happen in my current
>> approach using two ways:
>>
>> (1) Set the bit when we know we are the only users
>>
>> We can set PageAnonExclusive() in case *we sync against fork* and the
>> page cannot get unmapped (pt lock) when:
>> * The page is mapped writable
>> * The page is mapped readable and page_count == 1
> 
> I'm still not sure I see that all this complexity is netting a gain?

Avoid copy on fork().

>  
>> If we cannot set the page exclusive, we have to trigger a page fault.
>>
>> (2) During pagefaults when FOLL_FAULT_UNSHARE is set.
> 
> Why do we need FOLL_FAULT_UNSHARE ? AFAICT that was part of this
> series because of mapcount, once the hugetlb COW is fixed to use
> refcount properly, as Linus showed, the bugs this was trying to fix go
> away.

The purpose of FOLL_FAULT_UNSHARE in the !mapcount version is to cleanly
support R/O pins without the need for FOLL_WRITE.

And it's comparatively easy to add on top. This is not core of the
complexity, really.

> 
> And as discussed before it is OK if READ gup becomes incoherent, that
> is its defined semantic.

And that's where I still disagree.

But anyhow, this is really more about FOLL_FAULT_UNSHARE, which is
pretty easy and natural to add on top and just gets this right.

> 
>> The above should work fairly reliable with GUP. But indeed,
>> gup-fast-only is the problem. I'm still investigating what kind of
>> lightweight synchronization we could do against fork() such that we
>> wouldn't try setting a page PageAnonExclusive() while fork()
>> concurrently shares the page.
>>
>> We could eventually use the page lock and do a try_lock(), both in
>> fork() and in gup-fast-only. fork() would only clear the bit if the
>> try_lock() succeeded. gup-fast-only would only be able to set the bit
>> and not fallback to the slow path if try_lock() succeeded.
> 
> I suspect that is worse than just having fork clear the bit and leave
> GUP as-is. try lock is an atomic, clearing PageAnonExclusive does not
> need to be atomic, it is protected by the PTL.

There are 2 models, leaving FOLL_FAULT_UNSHARE out of the picture for now:

1) Whenever mapping an anonymous page R/W (after COW, during ordinary
fault, on swapin), we mark the page exclusive. We must never lose the
PageAnonExclusive bit, not during migration, not during swapout.

fork() will process the bit for each and every process, even if there
was no GUP, and will copy if there are additional references.

2) Whenever GUP wants to pin/ref a page, we try marking it exclusive. We
can lose the PageAnonExclusive bit during migration and swapout, because
that can only happen when there are no additional references.

fork() will process the bit only if there was GUP. Ordinary fork() is
left unchanged.


Getting R/O supported in the same way just means that we have to check
on a R/O pin if the page is PageAnonExclusive, and if that's not the
case, trigger a FOLL_FAULT_UNSHARE fault. That's really the only
"complexity" on top which is without the mapcount really easy.

-- 
Thanks,

David / dhildenb

