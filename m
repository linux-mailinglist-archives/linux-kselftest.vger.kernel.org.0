Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248EA47BC46
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 09:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhLUI6k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 03:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235932AbhLUI6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 03:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640077118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVR4PvJKHFeSzU5crvfo9OYJqBu6oFHSIXSjaKlKHz0=;
        b=DZ6wCIH8GNxILLDfMTJRPzfafJvAkUT+h80e/LVMkVXpVmnz22Sd6U5BeEI3yuis5Z0BZG
        ml0wOvR/gomE7pjlXbOlxiifeTg0UDHezbM+u4arUo7p4apENng9mKVsdObbAolp/8XNMC
        GybzHetXYRjh/1AkELXZuCn9rGGYn2U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-fCeGDHf4OsS8fqjZWCmFMA-1; Tue, 21 Dec 2021 03:58:36 -0500
X-MC-Unique: fCeGDHf4OsS8fqjZWCmFMA-1
Received: by mail-wm1-f71.google.com with SMTP id g189-20020a1c20c6000000b00345bf554707so151199wmg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 00:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=uVR4PvJKHFeSzU5crvfo9OYJqBu6oFHSIXSjaKlKHz0=;
        b=c3lc7MSqU3lS67uCsvuvRTza853HF7RU5jbAI83GgX4pBHW9RmTpCVK+kvRJ5iK/os
         sUfUeznDH2MUmrOsgQnQKGvQvx1tz70K1c54tomOZf/2GYWXFbLs8OU5i/xbBvBIFOw1
         uLK/joWF7P/b1JgqtG7dJGATd4XzRun+54ZchZXCjKwo2CR3lzK9O2CQznIcLYHn7271
         Q10VPYXgpwvWxxnmLlB6EWd9w83xrkJimaMze0R2Ue37Q/+T2U/E6nHEWbvaa0wDHPzu
         OLmliqHNPga5smU8FqBLZONsqyQfs37E+H+kl4L6Klr7tsMMdLf1RJL93YfQc9NDJq0z
         6mSQ==
X-Gm-Message-State: AOAM5339GeWgZTErVA6e/SzAQIz0Ew3RxSqvim+ChglJ8kwssTiBM/yG
        NWCcO9+TBsanNFeYxvpP13QcY0q1mk2PBt5cMMhnb69/DwgMDXSdy7wAm9qMZUKsWpKCLBv7v2i
        9rRtR01uRHPF+z2l8vvgfayCEiC7o
X-Received: by 2002:a5d:51c4:: with SMTP id n4mr1837031wrv.284.1640077115595;
        Tue, 21 Dec 2021 00:58:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzM0oGi2ZHVF2MCsY1b5Db7LzMJhwOQHQJLn7kMnNH2H4732HHmgsfPMPPFXj3ALoM/Lan5yQ==
X-Received: by 2002:a5d:51c4:: with SMTP id n4mr1836989wrv.284.1640077115256;
        Tue, 21 Dec 2021 00:58:35 -0800 (PST)
Received: from [192.168.3.132] (p5b0c64a4.dip0.t-ipconnect.de. [91.12.100.164])
        by smtp.gmail.com with ESMTPSA id bg12sm2203944wmb.5.2021.12.21.00.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 00:58:34 -0800 (PST)
Message-ID: <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
Date:   Tue, 21 Dec 2021 09:58:32 +0100
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
References: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <20211221010312.GC1432915@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21.12.21 02:03, Jason Gunthorpe wrote:
> On Sun, Dec 19, 2021 at 06:59:51PM +0100, David Hildenbrand wrote:
> 
>> handler (COW or unshare). Outside of COW/Unshare code, the bit can only
>> be set if page_count() == 1 and we sync against fork(). (and that's the
>> problem for gup-fast-only that I'm investigating right now, because it
>> would then always have to fallback to the slow variant if the bit isn't
>> already set)
> 

[in the meantime I figured out which pageflag we can reuse for anon
pages, which is at least one step into the right direction]

> I'm having a hard time imagining how gup_fast can maintain any sort of
> bit - it lacks all forms of locks so how can we do an atomic test and
> set between two pieces of data?

And exactly that is to be figured out.

Note that I am trying to make also any kind of R/O pins on an anonymous
page work as expected as well, to fix any kind of GUP after fork() and
GUP before fork(). So taking a R/O pin on an !PageAnonExclusive() page
similarly has to make sure that the page is exclusive -- even if it's
mapped R/O (!).

In the pagefault handler we can then always reuse a PageAnonExclusive()
page, because we know it's exclusive and it will stay exclusive because
concurrent fork() isn't possible.

> 
> I think the point of Linus's plan really is that the new bit is
> derived from page_count, we get the set the new bit when we observe
> page_count==1 in various situations and we clear the new bit whenever
> we write protect with the intent to copy.

Here are is one problems I'm fighting with:


Assume we set the bit whenever we create a new anon page (either due to
COW, ordinary fault, unsharing request, ..., even if it's mapped R/O
first). We know the page is exclusive at that point because we created
it and fork() could not happen yet.

fork() is the only code that can share the page between processes and
turn it non-exclusive.

We can only clear the bit during fork() -- to turn the share page
exclusive and map it R/O into both processes -- when we are sure that
*nobody* concurrently takes a reference on the page the would be
problematic (-> GUP).

So to clear the bit during fork, we have to
(1) Check against page_count == 1
(2) Synchronize against GUP

(2) is easy using the mmap_lock and the mm->write_protect_seq


BUT, it would mean that whenever we fork() and there is one additional
reference on a page (even if it's from the swapcache), we would slow
down fork() even if there was never any GUP. This would apply to any
process out there that does a fork() ...


So the idea is to mark a page only exclusive as soon as someone needs
the page to be exclusive and stay exclusive (-> e.g., GUP with FOLL_PIN
or selected FOLL_GET like O_DIRECT). This can happen in my current
approach using two ways:

(1) Set the bit when we know we are the only users

We can set PageAnonExclusive() in case *we sync against fork* and the
page cannot get unmapped (pt lock) when:
* The page is mapped writable
* The page is mapped readable and page_count == 1

This should work during ordinary GUP in many cases.

If we cannot set the page exclusive, we have to trigger a page fault.

(2) During pagefaults when FOLL_FAULT_UNSHARE is set.

GUP will set FOLL_FAULT_UNSHARE for a pagefault when required (again
e.g., FOLL_PIN or selected FOLL_GET users), and manual setting of the
bit failed. The page fault will then try once again to set the bit if
there is a page mapped, and if that fails, do the COW/unshare and set
the bit.


The above should work fairly reliable with GUP. But indeed,
gup-fast-only is the problem. I'm still investigating what kind of
lightweight synchronization we could do against fork() such that we
wouldn't try setting a page PageAnonExclusive() while fork()
concurrently shares the page.

We could eventually use the page lock and do a try_lock(), both in
fork() and in gup-fast-only. fork() would only clear the bit if the
try_lock() succeeded. gup-fast-only would only be able to set the bit
and not fallback to the slow path if try_lock() succeeded.


But I'm still investigating if there are better alternatives ...

> 
> GUP doesn't interact with this bit. A writable page would still be the
> second way you can say "you clearly have full ownership of the page',
> so GUP just checks writability and bumps the refcount. The challenge
> of GUP reamins to sanely sequence it with things that are doing WP.
> 
> The elevated GUP refcount prevents the page from getting the bit set
> again, regardless of what happens to it.
> 
> Then on the WP sides.. Obviously we clear the bit when applying a WP
> for copy. So all the bad GUP cases are halted now, as with a cleared
> bit and a != 1 refcount COW must happen.
> 
> Then, it is also the case that most often a read-only page will have
> this bit cleared, UFFWD WP being the exception.
> 
> UFFWD WP works fine as it will have the bit set in the cases we care
> about and COW will not happen.
> 
> If the bit is not set then everything works as is today and you get
> extra COWs. We still have to fix the things that are missing the extra
> COWs to check the page ref to fix this.
> 
> It seems this new bit is acting as a 'COW disable', so, the accuracy
> of COW vs GUP&speculative pagerefs now relies on setting the bit as
> aggressively as possible when it is safe and cheap to do so.

But we really want to avoid degrading fork() for everybody that doesn't
do heavy GUP ...

> 
> If I got it right this is why it is not just mapcount reduced to 1
> bit. It is quite different, even though "this VM owns the page
> outright" sure sounds like "mapcount == 1"..
> 
> It seems like an interesting direction - the security properties seem
> good as we only have to take care of sites applying WP to decide what
> to do with the extra bit, and all places that set the bit to 1 do so
> after testing refcount under various locks preventing PTE WP.
> 
> That just leave the THP splitting.. I suppose we get the PTL, then
> compute the current value of the new bit based on refcount and diffuse
> it to all tail pages, then update the PMD and release the PTL. Safe
> against concurrent WP - don't need DoubleMap horrors because it isn't
> a counter.
> 
>> Not set it stone, just an idea what I'm playing with right now ... and I
>> have to tripple-check if
>> * page is PTE mapped in the page table I'm walking
>> * page_count() == 1
>> Really means that "this is the only reference.". I do strongly believe
>> so .. :)
> 
> AFAIK the only places that can break this are places putting struct
> page memory into special PTEs. Which is horrific and is just bugs, but
> I think I've seen it from time to time :(

As we only care about anon pages, I think that doesn't apply. At least
that's what I hope.


-- 
Thanks,

David / dhildenb

