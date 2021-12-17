Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EED47974C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 23:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhLQWnt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 17:43:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231249AbhLQWnt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 17:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639781028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2l3tv70qw5U/DFH1AeqC7MLWadTCO2kcG/3tbtkmi6M=;
        b=a2x9CJGOGVCT8aT6zitmsTneNAw1uJA0p6Thl5WgH2KpX6xuD1uw5qwg91iefeYZN0uTi8
        Kb16zbGkIh8ByKiWwjhpE8n5duyFbovBjx7ACE5NDvpSuClA3yfXElxqkSyjgRJxehF3T2
        d7crDBzy13bXG6gBmcZbKIYyXiWKURU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-pWe-ZaFjNumcuE__IklUmQ-1; Fri, 17 Dec 2021 17:43:47 -0500
X-MC-Unique: pWe-ZaFjNumcuE__IklUmQ-1
Received: by mail-wr1-f72.google.com with SMTP id h7-20020adfaa87000000b001885269a937so1016776wrc.17
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 14:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=2l3tv70qw5U/DFH1AeqC7MLWadTCO2kcG/3tbtkmi6M=;
        b=gcLPd4W0hCnzccOUBaStW5ZlWMyhmmVpKinoh5RPAZEi3Dw48RsBawSM+mT6/7/Pjc
         2HFK0+cl54KVNeOr33MRpTbr19iK+5U4E50s4QzMDcAzHNIH8KJRIRPwN94ZuKwOPDrv
         7ZQ0ARPtRoQgTvjP7OIZ2SINFhFZopDDGOnkjLDdpWksdiFlVb2HiFk9nbon0RS53JC/
         z7vRuNlJzQWL+VAcWAEr65un4k0oBW8PSpaDVtLOEaxPVZVoQ5Hyhsj2V9vtCSAZUCqC
         xCnbTKQcdU2IsjHzoyOFS01qwkkEFKZYxq5J2pSxkvF05G6+18Pf3jXDDWfcdTfWqcE3
         9RKA==
X-Gm-Message-State: AOAM532PBf67n+Bwzmw0YcyJkkBerWcnxRwr5spQQ0FUvPafpXfrvWoi
        JJwEHRSCjaBk3uYDqLtAQz/3Kq7wp5QrarbV+5N7xOe0P7dpKig37j04U6tNj8jaiVvfHIwtUpe
        +ydciggJN/PGeUA5fdpac0OkCHKoj
X-Received: by 2002:adf:f48e:: with SMTP id l14mr4202095wro.88.1639781026623;
        Fri, 17 Dec 2021 14:43:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlsG6viaLqvbuV/wNUm4ZwQ7VL/P5e2xT8/kUZ9SE40GD4CaG/NiGfqmJpgjssvi9LApgTBw==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr4202074wro.88.1639781026429;
        Fri, 17 Dec 2021 14:43:46 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id p5sm8945149wrd.13.2021.12.17.14.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 14:43:46 -0800 (PST)
Message-ID: <f271bb98-dfdd-1126-d9b9-3103e4398e00@redhat.com>
Date:   Fri, 17 Dec 2021 23:43:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
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
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
 <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
 <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com>
 <CAHk-=wiujJLsLdGQho8oSbEe2-B1k1tJg6pzePkbqZBqEZL56A@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=wiujJLsLdGQho8oSbEe2-B1k1tJg6pzePkbqZBqEZL56A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 23:18, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 1:47 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> For now I have not heard a compelling argument why the mapcount is
>> dubious, I repeat:
>>
>> * mapcount can only increase due to fork()
>> * mapcount can decrease due to unmap / zap
> 
> And to answer the "why is this dubious", let' sjust look at your
> actual code that I reacted to:
> 
> +       vmf->page = vm_normal_page(vmf->vma, vmf->address, vmf->orig_pte);
> +       if (vmf->page && PageAnon(vmf->page) && !PageKsm(vmf->page) &&
> +           page_mapcount(vmf->page) > 1) {
> 
> Note how you don't just check page_mapcount(). Why not? Because
> mapcount is completely immaterial if it's not a PageAnon page, so you
> test for that.
> 
> So even when you do the mapcount read as one atomic thing, it's one
> atomic thing that depends on _other_ things, and all these checks are
> not atomic.
> 
> But a PageAnon() page can actually become a swap-backed page, and as
> far as I can tell, your code doesn't have any locking to protect
> against that.

The pages stay PageAnon(). swap-backed pages simply set a bit IIRC.
mapcount still applies.

> 
> So now you need not only the mmap_sem (to protect against fork), you
> also need the page lock (to protect against rmap changing the type of
> page).

No, I don't think so. But I'm happy to be proven wrong because I might
just be missing something important.

> 
> I don't see you taking the page lock anywhere. Maybe the page table
> lock ends up serializing sufficiently with the rmap code that it ends
> up working
> 
> In the do_wp_page() path, we currently do those kinds of racy checks
> too, but then we do a trylock_page, and re-do them. And at any time
> there is any question about things, we fall back to copying - because
> a copy is always safe.

Yes, I studied that code in detail as well.

> 
> Well, it's always safe if we have the rule that "once we've pinned
> things, we don't cause them to be COW again".

We should also be handling FOLL_GET, but that's a completely different
discussion.

> 
> But that "it's safe if" was exactly my (b) case.
> 
> That's why I much prefer the model I'm trying to push - it's
> conceptually quite simple. I can literally explain mine at a
> conceptual level with that "break pre-existing COW, make sure no
> future COW" model.

:)

We really might be talking about the same thing just that my point is
that the mapcount is the right thing to use for making the discussion
whether to break COW -> triger unsharing.

> 
> In contrast, I look at your page_mapcount() code, and I go "there is
> no conceptual rules here, and the actual implementation details look
> dodgy".
> 
> I personally like having clear conceptual rules - as opposed to random
> implementation details.

Oh, don't get me wrong, me to. But for me it just all makes perfect.

What we document is:

"The fault is an unsharing request to unshare a shared anonymous page
(-> mapped R/O). Does not apply to KSM."

And the code checks for exactly that. And in that context the mapcount
just expresses exactly what we want. Again, unless I am missing
something important that you raise above.


Anyhow, it's late in Germany. thanks for the discussion Linus!

-- 
Thanks,

David / dhildenb

