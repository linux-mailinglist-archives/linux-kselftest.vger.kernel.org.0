Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516DB479A0A
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 10:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhLRJ6A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 04:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232559AbhLRJ57 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 04:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639821479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhnlOnE5Zw/akPI9MUS3YPheTam56HL5gZvtQRAMy6s=;
        b=YCmIb0J7lX/9L5FjLwGHTaq/bJmeBUTdH7R1bmqNONF39Hzcigts0hylCGaSKsHIPAl0z3
        R+rpgaAUhedmsn26WyPtAV16li/wcZ+TA6A2YakNuJlLEZQLF8Id7JRNuKvDyX0FRjLKf/
        JizTAgP249PBg4eN3/2Oc1Tn2QRyTwg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-C97ZwF0zMhCtRL5gTg5ONw-1; Sat, 18 Dec 2021 04:57:57 -0500
X-MC-Unique: C97ZwF0zMhCtRL5gTg5ONw-1
Received: by mail-wm1-f72.google.com with SMTP id z13-20020a05600c0a0d00b003457d6619f8so1666561wmp.1
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 01:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=HhnlOnE5Zw/akPI9MUS3YPheTam56HL5gZvtQRAMy6s=;
        b=l5soVN0YcahG8Kzdxx0kbXCaX1xIySLKDTb2sfPHPCGzAsrfj0BFnN3ON5EOBujP90
         8U8jv9F3fbrh171nDXPvgLKgPn4pQwFrYfcFgWHEGbq8Orx6lJSysU2SL9Ua3oCAu4de
         Y4LjxYJnz0B6tra4p7iP46aSDpEvTbHNRqEzhJRlgQIQuCF9w+ZwI1Gzsco1r/cLeh1J
         rWxOlCYVodahRXBl5oisuVYtyJbe9JIAudODvEw7JtboAFl5g9LUyz97PUifp/AYiFIg
         kiXsC9Ce2O58Iz0bjJp+BuuDBhi0KpNbyy3HeFU7A3oNp89kr0mLZwmf/aDLW4yORjTx
         /cmA==
X-Gm-Message-State: AOAM533SSMY4CTauerM3S/iG2DWIfA0WOlYu4aFGyhQ0kv0lWOz552hj
        +O1/0M4zuJ6Vf6rDqTtEGerTAuO/ia3KA8807tWc4RX6oh1BzMy26ETddHbnR8UzQq4dSNyopp0
        cN4ohgDY40F7wWAQnZ8brxpLQkt3I
X-Received: by 2002:adf:eb06:: with SMTP id s6mr5893692wrn.96.1639821476608;
        Sat, 18 Dec 2021 01:57:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9LbEcpllPC7Xh1e1TAUDJFAcJuppWJcec9eB7enbSgMiKNtwU6H4/Sx3BKFYdlbxSdLnFrQ==
X-Received: by 2002:adf:eb06:: with SMTP id s6mr5893665wrn.96.1639821476253;
        Sat, 18 Dec 2021 01:57:56 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6703.dip0.t-ipconnect.de. [91.12.103.3])
        by smtp.gmail.com with ESMTPSA id i15sm16076211wmq.18.2021.12.18.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 01:57:55 -0800 (PST)
Message-ID: <40e7e0ab-0828-b2e7-339f-35f68a228b3d@redhat.com>
Date:   Sat, 18 Dec 2021 10:57:54 +0100
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
 <f271bb98-dfdd-1126-d9b9-3103e4398e00@redhat.com>
 <CAHk-=wjvoTRSb87R-D50yOXqX4mshjiiAyurAKCsdW0_J+sf7A@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=wjvoTRSb87R-D50yOXqX4mshjiiAyurAKCsdW0_J+sf7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18.12.21 00:20, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 2:43 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> The pages stay PageAnon(). swap-backed pages simply set a bit IIRC.
>> mapcount still applies.
> 
> Our code-base is too large for me to remember all the details, but if
> we still end up having PageAnon for swapbacked pages, then mapcount
> can increase from another process faulting in an pte with that swap
> entry.

"Our code-base is too large for me to remember all the details". I
second that.

You might a valid point with the mapcount regarding concurrent swapin in
the current code, I'll have to think further about that if it could be a
problem and if it cannot be handled without heavy synchronization (I
think the concern is that gup unsharing could miss doing an unshare
because it doesn't detect that there are other page sharers not
expressed in the mapcount code but via the swap code when seeing
mapcount == 1).

Do you have any other concerns regarding the semantics/stability
regarding the following points (as discussed, fork() is not the issue
because it can be handled via write_protect_seq or something comparable.
handling per-process thingies is not the problem):

a) Using PageAnon(): It cannot possibly change in the pagefault path or
   in the gup-fast-only path (otherwise there would be use-after-free
   already).
b) Using PageKsm(): It cannot possibly change in the pagefault path or
   in the gup-fast path (otherwise there would be use-after-free
   already).
c) Using mapcount: It cannot possibly change in the way we care about or
   cannot detect  (mapcount going from == 1 to > 1 concurrently) in the
   pagefault path or in the gup-fast path due to fork().

You're point for c) is that we might currently not handle swap
correctly. Any other concerns, especially regarding the mapcount or is
that it?


IIUC, any GUP approach to detect necessary unsharing would at least
require a check for a) and b). What we're arguing about is c).

> 
> And mmap_sem doesn't protect against that. Again, page_lock() does.
> 
> And taking the page lock was a big performance issue.
> 
> One of the reasons that new COW handling is so nice is that you can do
> things like
> 
>                 if (!trylock_page(page))
>                         goto copy;
> 
> exactly because in the a/b world order, the copy case is always safe.
> 
> In your model, as far as I can tell, you leave the page read-only and
> a subsequent COW fault _can_ happen, which means that now the
> subsequent COW needs to b every very careful, because if it ever
> copies a page that was GUP'ed, you just broke the rules.
> 
> So COWing too much is a bug (because it breaks the page from the GUP),
> but COWing too little is an even worse problem (because it measn that
> now the GUP user can see data it shouldn't have seen).

Good summary, I'll extend below.

> 
> Our old code literally COWed too  little. It's why all those changes
> happened in the first place.

Let's see if we can agree on some things to get a common understanding.


What can happen with COW is:

1) Missed COW

We miss a COW, therefore someone has access to a wrong page.

This is the security issue as in patch #11. The security issue
documented in [1].

2) Unnecessary COW

We do a COW, but there are no other valid users, so it's just overhead +
noise.

The performance issue documented in section 5 in [1].

3) Wrong COW

We do a COW but there are other valid users (-> GUP).

The memory corruption issue documented in section 2 and 3 in [1].

Most notably, the io_uring reproducer which races with the
page_maybe_dma_pinned() check in current code can trigger this easily,
and exactly this issues is what gives me nightmares. [2]


Does that make sense? If we agree on the above, then here is how the
currently discussed approaches differ:

page_count != 1:
* 1) cannot happen
* 2) can happen easily (speculative references due to pagecache,
     migration, daemon, pagevec, ...)
* 3) can happen in the current code

mapcount > 1:
* 1) your concern is that this can happen due to concurrent swapin
* 2) cannot happen.
* 3) your concern is that this can happen due to concurrent swapin


If we can agree on that, I can see why you dislike mapcount, can you see
why I dislike page_count?

Ideally we'd really have a fast and reliable check for "is this page
shared and could get used by multiple processes -- either multiple
processes are already mapping it R/O or could map it via the swap R/O
later".


> This is why I'm pushing that whole story line of
> 
>  (1) COW is based purely on refcounting, because that's the only thing
> that obviously can never COW too little.

I am completely missing how 2) or 3) could *ever* be handled properly
for page_count != 1. 3) is obviously more important and gives me nightmares.


And that's what I'm trying to communicate the whole time: page_count is
absolutely fragile, because anything that results in a page getting
mapped R/O into a page table can trigger 3). And as [2] proves that can
even happen with *swap*.

(see how we're running into the same swap issues with both approaches?
Stupid swap :) )

> 
>  (2) GUP pre-COWs (the thing I called the "(a)" rule earlier) and then
> makes sure to not mark pinned pages COW again (that "(b)" rule).
> 
> and here "don't use page_mapcount()" really is about that (1).
> 
> You do seem to have kept (1) in that your COW rules don't seem to
> change (but maybe I missed it), but because your GUP-vs-COW semantics
> are very different indeed, I'm not at all convinced about (2).

Oh yes, sorry, not in the context of this series. The point is that the
current page_count != 1 covers mapcount > 1, so we can adjust that
separately later.


You mentioned "design", so let's assume we have a nice function:

/*
 * Check if an anon page is shared or exclusively used by a single
 * process: if shared, the page is shared by multiple processes either
 * mapping the page R/O ("active sharing") or having swap entries that
 * could result in the page getting mapped R/O ("inactive sharing").
 *
 * This function is safe to be called under mmap_lock in read/write mode
 * because it prevents concurrent fork() sharing the page.
 * This function is safe to be called from gup-fast-only in IRQ context,
 * as it detects concurrent fork() sharing the page
 */
bool page_anon_shared();


Can we agree that that would that be a suitable function for (1) and (2)
instead of using either the page_count or the mapcount directly? (yes,
how to actually make it reliable due to swapin is to be discussed, but
it might be a problem worth solving if that's the way to go)

For hugetlb, this would really have to use the mapcount as explained
(after all, fortunately there is no swap ...).



[1]
https://lore.kernel.org/all/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com/

[2]
https://gitlab.com/aarcange/kernel-testcases-for-v5.11/-/blob/main/io_uring_swap.c
-- 
Thanks,

David / dhildenb

