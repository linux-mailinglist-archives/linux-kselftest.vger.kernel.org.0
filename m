Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DDC4795B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 21:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhLQUpS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 15:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234472AbhLQUpR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 15:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639773917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPpPJN7KbPRNIPZSMIG4COjk+/gblJ9JKatIFH/NkxI=;
        b=eP1MYxRRl035onQPboTyMxsBeXMYeU/EzL3jWLA1HX/+l/Z1CThIxM7/GwBcjDaBqbSHnE
        lF4WTdSZPnHce/XTwYUL+ybOpY4/mQknbjHYt7SqbbhTSIPKXZ22gT4flvh3jfpdF5LIwM
        V5CB6+8uc7xTryECXc4dUbj7LxkEMYA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-oerSMr7CO2WwXmkqhD6yXw-1; Fri, 17 Dec 2021 15:45:16 -0500
X-MC-Unique: oerSMr7CO2WwXmkqhD6yXw-1
Received: by mail-wr1-f72.google.com with SMTP id h7-20020adfaa87000000b001885269a937so958836wrc.17
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=mPpPJN7KbPRNIPZSMIG4COjk+/gblJ9JKatIFH/NkxI=;
        b=Nl3zlJ/wK93zXlJGXdTMonFyL1ZZ/OgndArfTvLu4XDeolOkEEK6q7BetgzgvbRvj4
         pOGoAGeqtmJgdOvJ0rpfqBaoOCc7IC3LvrZVL3otQ5Dt8i05beOEqv41JVj/cmSv8O33
         WlOlXyiarQZQGxck4YfH5zVdtXqWjozMJNSzEpMCHeqWu9fgfg2Tf+Vq3ynAo4WdQ150
         s+v9XwAWRrYG7zsbBBxlL0xzxfZFuNrrIFmCrsmb1XlByrZabHgH4pSyH7L6Cylvc+/j
         xUm0Xe99e8UEgxZVIAhXv0IgUWddhpU3gjB+RNMkL3SeXsu7WZotESVATnvjDRjh+m9T
         i48Q==
X-Gm-Message-State: AOAM532SwUwulp40FvnopXt4IFauC6VEqn8gs1Cw3IHsLriHDIRofIdX
        ZcB9SslFblHYLdiK/HpmEWX3H4ZqDjCiCz8y7ZEx2ISKKnZRfp/2Uw9lGuGgwdtjd5HxtUfOg5R
        cZpbvbJcm+e024czRug3TysRNlz8W
X-Received: by 2002:a5d:4706:: with SMTP id y6mr3943598wrq.435.1639773914799;
        Fri, 17 Dec 2021 12:45:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfFap8HkDu143lE7Idu4Dk3kJRb/So/+z+DQIixqjYZjuuVPkfH789mDxQMEKE7OKKkVrJlg==
X-Received: by 2002:a5d:4706:: with SMTP id y6mr3943579wrq.435.1639773914589;
        Fri, 17 Dec 2021 12:45:14 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id z11sm8830241wmf.9.2021.12.17.12.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:45:14 -0800 (PST)
Message-ID: <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
Date:   Fri, 17 Dec 2021 21:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
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
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 20:04, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 3:34 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> + * If the child takes a read-only pin on such a page (i.e., FOLL_WRITE is not
>> + * set) and then unmaps the target page, we have:
>> + *
>> + * * page has mapcount == 1 and refcount > 1
> 

Hi Linus,

> All these games with mapcount makes me think this is still broken.
> 
> mapcount has been a horribly broken thing in the past, and I'm not
> convinced it's not a broken thing now.

It all started when Jann detected the security issue in GUP – and this
patch set is fixing the problem exactly there, in GUP itself. Are you
aware of COW issues regarding the mapcount if we would remove GUP from
the equation? My point is that COW without GUP works just perfectly
fine, but I’ll be happy to learn about other cases I was ignoring so far.

Unfortunately, page_count() is even more unreliable, and the issues
we're just detecting (see the link in the cover letter: memory
corruptions inside user space -- e.g., lost DMA writes) are even worse
than what we had before -- IMHO of course.

> 
>> +       vmf->page = vm_normal_page(vmf->vma, vmf->address, vmf->orig_pte);
>> +       if (vmf->page && PageAnon(vmf->page) && !PageKsm(vmf->page) &&
>> +           page_mapcount(vmf->page) > 1) {
> 
> What keeps the mapcount stable in here?

So, we're reading an atomic value here. It’s read via atomic_read for
regular pages, and the THP mapcount case has also been made atomic (as
lockless as page_count) in patch #5.

If a page is mapped exactly once, page_mapcount(page) == 1 and there is
nothing to do.

If the page is mapped more than once, page_mapcount(page) > 1 and we
would have to trigger unsharing. And it’s true that the value is
unstable in this case, but we really only care about page_mapcount(page)
> 1 vs. page_mapcount(page) == 1. In this respect, there is no
difference from the instability of the page_count and the mapcount – we
still only care if it’s >1 or == 1.

So the only case we could care about is concurrent additional mappings
that can increment the mapcount -- which can only happen due to
concurrent fork. So if we're reading page_mapcount(page) == 1 the only
way we can get page_mapcount(page) > 1 is due to fork(). But we're
holding the mmap_lock in read mode during faults and fork requires the
mmap_lock in write mode.


> 
> And I still believe that the whole notion that "COW should use
> mapcount" is pure and utter garbage.
> 
> If we are doing a COW, we need an *exclusive* access to the page. That
> is not mapcount, that is the page ref.

I thought about this a lot, because initially I had the same opinion.

But really, we don't care about any speculative references (pagecache,
migration, daemon, pagevec, ...) or any short-term "I just want to grab
this reference real quick such that the page can't get freed" references.

All we care about are GUP references, and we attack that problem at the
root by triggering unsharing exactly at the point where GUP comes into play.

So IMHO GUP is the problem and needs unsharing either:
* On write access to a shared anonymous page, which is just COW as we
know it.
* On read access to a shared anonymous page, which is what we’re
proposing in this patch set.

So as soon as GUP comes into play, even if only pinning R/O, we have to
trigger unsharing . Doing so enforces the invariant that it is
impossible to take a GUP pin on an anonymous page with a mapcount > 1.
In turn, the COW does not need to worry about the GUP after fork()
security issue anymore and it can focus on doing optimally the COW
faults as if GUP just wouldn’t exist.


-- 
Thanks,

David / dhildenb

