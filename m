Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CDD479C6E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 20:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhLRTxL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 14:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhLRTxL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 14:53:11 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C3C061574
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 11:53:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y13so21258069edd.13
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 11:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwDKq6c1mQYLU0p0J66kK9b9U2JQzk1+tCZIkkXvJ6I=;
        b=U5uC3Kaqj3Jyz9ClVkVNdaCklm+oiz2jhIexhCBthnjLmX3U7Wkoqfro6mIgIQYih1
         fYnIl74HxHVmm4oN5qZYu46cLpq/0a9MM0L7iLgtvdvWn7S16gUCjgjGv0WBg5JYcwY8
         2t/4p+6P3qYm2phM4iAacdJb1uzh4Bb51ORJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwDKq6c1mQYLU0p0J66kK9b9U2JQzk1+tCZIkkXvJ6I=;
        b=k7fNjGtO9BBm/Hw6s84XdgzSKmUH0xVSNLu7NHI6p1yg3nj9HrMKDqiiQGTJaHHT7u
         t8CjkyJAgqpJ4qAQLBtadzIPva8qrFuxN0UshM5adKdK1MIxEFWKJhSe88t0a7OUO1AD
         xtmvkqRTCv56AJHBZXint4wYw+efjmoOhLiZy+lwl5VNms+CBpOOn1Y/hiIdw7Lhv8hF
         jHzrJwCaI2ZPilD4+mhpmMtNWuWOpx5pUKbWWejmAyaTUKMMmyqGy81x1b3pQy1J6k3a
         hc3gJudiTsqpANpeXx/mC0He1mDuuDs0GI3oY/xLMOVur2kQGKaiLrIg2rfN6XVGV8TR
         58Mw==
X-Gm-Message-State: AOAM530tA6kqkyn1r38XRcVDYsDcJGxxb/DDSPfhP/VJW32TtwRr26q4
        m5bk3UaKsDrVTc0xlcO4WSu9TX/eEhxOZUM5QgM=
X-Google-Smtp-Source: ABdhPJySEDJTFYZe5fAJJbMFw22ZvOtout+fgbddaGGAVJEPr4pdsLle/KrHopgqD9hQt49VbeXOCQ==
X-Received: by 2002:a17:907:6d1b:: with SMTP id sa27mr3822743ejc.117.1639857189118;
        Sat, 18 Dec 2021 11:53:09 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id o1sm3951833ejy.150.2021.12.18.11.53.08
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 11:53:08 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id j21so16981750edt.9
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 11:53:08 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr6423478wrx.193.1639857177671;
 Sat, 18 Dec 2021 11:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com> <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com> <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com> <CAHk-=wiujJLsLdGQho8oSbEe2-B1k1tJg6pzePkbqZBqEZL56A@mail.gmail.com>
 <f271bb98-dfdd-1126-d9b9-3103e4398e00@redhat.com> <CAHk-=wjvoTRSb87R-D50yOXqX4mshjiiAyurAKCsdW0_J+sf7A@mail.gmail.com>
 <40e7e0ab-0828-b2e7-339f-35f68a228b3d@redhat.com> <CAHk-=wg95CiyT45ZOxtnWQ7cdKmejXcOydEyJcTTNnp5-nd+xg@mail.gmail.com>
In-Reply-To: <CAHk-=wg95CiyT45ZOxtnWQ7cdKmejXcOydEyJcTTNnp5-nd+xg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Dec 2021 11:52:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjevjeL44qafYd8=cJHZgNUOUuWVJ28vkS4U4v_Af-xaQ@mail.gmail.com>
Message-ID: <CAHk-=wjevjeL44qafYd8=cJHZgNUOUuWVJ28vkS4U4v_Af-xaQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     David Hildenbrand <david@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 18, 2021 at 11:21 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> To recap:
>  (1) is important, and page_count() is the only thing that guarantees
> "you get full access to a page only when it's *obviously* exclusively
> yours".
>  (2) is NOT important, but could be a performance issue, but we have
> real data from the past year that it isn't.
>  (3) is important, and has a really spectacularly simple conceptual
> fix with quite simple code too.
>
> In contrast, with the "mapcount" games you can't even explain why they
> should work, and the patches I see are actively buggy because
> everything is so subtle.

So to challenge you, please explain exactly how mapcount works to
solve (1) and (3), and how it incidentally guarantees that (2) doesn't
happen.

And that really involves explaining the actual code too. I can explain
the high-level concepts in literally a couple of sentences.

For (1), "the page_count()==1 guarantees you are the only owner, so a
COW event can re-use the page" really explains it. And the code is
pretty simple too. There's nothing subtle about "goto copy" when
pagecount is not 1. And even the locking is simple: "we hold the page
table lock, we found a page, it has only one ref to it, we own it"

Our VM is *incredibly* complicated. There really are serious
advantages to having simple rules in place.

And for (2), the simple rule is "yeah, we can cause spurious cow
events". That's not only simple to explain, it's simple to code for.
Suddenly you don't need to worry. "Copying the page is always safe".
That's a really really powerful statement.

Now, admittedly (3) is the one that ends up being more complicated,
but the *concept* sure is simple. "If you don't want to COW this page,
then don't mark it for COW".

The *code* for (3) is admittedly a bit more complicated. The "don't
mark it for COW" is simple to say, but we do have that fairly odd
locking thing with fork() doing a seqcount_write_begin/end, and then
GIP does the read-seqcount thing with retry. So it's a bit unusual,
and I don't think we have that particular pattern anywhere else, but
it's one well-defined lock and while unusual it's not *complicated* as
far as kernel locking rules go. It's unusual and perhaps not trivial,
but in the end those seqcount code sequences are maybe 10 lines total,
and they don't interact with anything else.

And yes, the "don't mark it for COW" means that write-protecting
something is special, mainly because we sadly do not have extra bits
in the page tables. It would be *really* easy if we could just hide
this "don't COW this page" in the page table. Truly trivial. We don't,
because of portability across different architectures ;(

So I'll freely give you that my (3) is somewhat painful, but it's
painful with a really simple concept.

And the places that get (3) wrong are generally places that nobody has
been able to care about. I didn't realize the problem with creating a
swap page after the fact for a while, so that commit feb889fb40fa
("mm: don't put pinned pages into the swap cache") came later, but
it's literally a very simple two-liner.

The commit message for commit feb889fb40fa may be worth reading. It
very much explains the spirit of the thing, and is much longer than
the trivial patch itself.

Simple and clear concepts matter. Code gets complicated even then, but
complex code with complex concepts is a bad combination.

              Linus
