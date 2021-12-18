Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29333479C4B
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 20:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhLRTWD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 14:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhLRTWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 14:22:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D867CC061574
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 11:22:02 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bm14so8344496edb.5
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 11:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjtEsM+c2EyxYgM67CZlqAl9WiDlSVGEZ5HgXw8/krU=;
        b=TI7a4DuiAgA8wrGTjTNe4IJqA5QCDWzlI/ak2Au56EB89uo5bkXaUTBrXIKMz7aV//
         TsHYsaOsVaAeodq3kc4PNAhvLQuCaG+UhiFV2j6pk8NZFPurH0DqDTd5nSDxKgH+44wi
         r9a0hJm40ZzKEAraB5mo+A0uKuHHt+djZOfLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjtEsM+c2EyxYgM67CZlqAl9WiDlSVGEZ5HgXw8/krU=;
        b=yl3F7bMJTTx8ou067Qv1m+CXcq/CK7SaQ0dVPrCXbOKbj7/RyWQtBmZIWfWSdDjCkI
         TxF4r5OyM1dt2XmtH2xabNTzgElT/e9Otbkfi1AD51opArYIt6ncipibZMr8y34lCoeN
         aqeJQU3ZtVGV4S6OEE55hTDdQ0nLQEwCRfks4+ei3ZM6dJtEKIph+bZ2HLiYiCyikxPh
         HcGKxj33IVjWx2sjlq9eA6KMqRYKka4Q90K+prOe71YootQU/YqRqtoJ4welPt/hW9HW
         sfwFvM9/WPESTymZRc2KP+ktemD309/3ZBV4FueiJ0JnkBvDGuUJjOYvBD0MIq4KZ89o
         BTIQ==
X-Gm-Message-State: AOAM5326qnQRYAIqbTyruqX+hbkQvvKmIxCOUJ2EAkgoH6Zsycj/DSt0
        FMfYSeVoSiV9nH/X2+7kHSfY9GE8sCec6kZ85Bw=
X-Google-Smtp-Source: ABdhPJwUzzORrkSz5QqqC0Wuyftj1I3Z8fAHgbHK47vAEHWskqfi7SF0Cczs/Eatl2EkOhftUgP7sw==
X-Received: by 2002:a17:907:3e9f:: with SMTP id hs31mr6987699ejc.625.1639855321217;
        Sat, 18 Dec 2021 11:22:01 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id hp18sm1202861ejc.120.2021.12.18.11.22.01
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 11:22:01 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso5521549wmc.1
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 11:22:01 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr14586823wmq.8.1639855310502;
 Sat, 18 Dec 2021 11:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com> <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com> <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com> <CAHk-=wiujJLsLdGQho8oSbEe2-B1k1tJg6pzePkbqZBqEZL56A@mail.gmail.com>
 <f271bb98-dfdd-1126-d9b9-3103e4398e00@redhat.com> <CAHk-=wjvoTRSb87R-D50yOXqX4mshjiiAyurAKCsdW0_J+sf7A@mail.gmail.com>
 <40e7e0ab-0828-b2e7-339f-35f68a228b3d@redhat.com>
In-Reply-To: <40e7e0ab-0828-b2e7-339f-35f68a228b3d@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Dec 2021 11:21:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg95CiyT45ZOxtnWQ7cdKmejXcOydEyJcTTNnp5-nd+xg@mail.gmail.com>
Message-ID: <CAHk-=wg95CiyT45ZOxtnWQ7cdKmejXcOydEyJcTTNnp5-nd+xg@mail.gmail.com>
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

[ Cutting down ruthlessly to the core of the issue ]

On Sat, Dec 18, 2021 at 1:58 AM David Hildenbrand <david@redhat.com> wrote:
>
> 1) Missed COW
>
> 2) Unnecessary COW
>
> 3) Wrong COW

> Does that make sense? If we agree on the above, then here is how the
> currently discussed approaches differ:
>
> page_count != 1:
> * 1) cannot happen
> * 2) can happen easily (speculative references due to pagecache,
>      migration, daemon, pagevec, ...)
> * 3) can happen in the current code

I claim that (1) "cannot happen" is a huge mother of a deal. It's
*LITERALLY* the bug you are chasing, and it's the security issue, so
on a bug scale, it's about the worst there is.

I further then claim that (2) "happen easily" is you just making
things up. Yes, it can happen. But no, it's not actually that common,
and since (2) is harmless from a correctness standpoint, it is purely
about performance.

And as mentioned, not using the mapcount actually makes *common*
operations much simpler and faster. You don't need the page lock to
serialize the mapcount.

So (2) is a performance argument, and you haven't actually shown it to
be a problem.

Which really only leaves (3). Which I've already explained what the
fix is: don't ever mark pages that shouldn't be COW'ed as being COW
pages.

(3) is really that simple, although it ended up depending on Jason and
John Hubbard and others doing that FOLL_PIN logic to distinguish "I
just want to see a random page, and I don't care about COW" from "I
want to get a page, and that page needs to be coherent with this VM
and not be COW'ed away"

So I'm not claiming (3) is "trivial", but at the same time it's
certainly not some fundamentally complicated thing, and it's easy to
explain what is going on.

> mapcount > 1:
> * 1) your concern is that this can happen due to concurrent swapin
> * 2) cannot happen.
> * 3) your concern is that this can happen due to concurrent swapin

No, my concern about (1) is that IT IS WRONG.

"mapcount" means nothing for COW. I even gave you an example of
exactly where it means nothing. It's crazy. It's illogical. And it's
complicated as hell.

The fact that only one user maps a page is simply not meaningful. That
page can have other users that you don't know anything about, and that
don't show up in the mapcount.

That page can be swapcached, in which case mapcount can change
radically in ways that you earlier indicated cannot happen. You were
wrong.

But even if you fix that - by taking the page lock in every single
place - there are still *other* users that for all you know may want
the old contents. You don't know.

The only thing that says "no other users" is the page count. Not the mapcount.

In other words, I claim that

 (a) mapcount is fundamentally the wrong thing to test. You can be the
only mapper, without being the "owner" of the page.

 (b) it's *LITERALLY* the direct and present source of that bug in the
testcase you added, where a page with a mapcount of 1 has other
concurrent users and needs to be COW'ed but isn't.

 (c) it's complicated and expensive to calculate (where one big part
of the expense is the page lock synchronization requirements, but
there are others)

And this all happens for that "case (1)", which is the worst adn
scariest of them all.

In contrast to that, your argument that "(2) cannot happen" is a total
non-argument. (2) isn't the problem.

And I claim that (3) can happen because you're testing the wrong
counter, so who knows if the COW is wrong or not?

> I am completely missing how 2) or 3) could *ever* be handled properly
> for page_count != 1. 3) is obviously more important and gives me nightmares.

Ok, so if I tell you how (2) and (3) are handled properly, you will
just admit you were wrong?

Here's how they are handled properly with page counts. I have told you
this before, but I'll summarize:

 (2) is handled semantically properly by definition - it may be
"unnecessary", but it has no semantic meaning

This is an IMPORTANT thing to realize. The fact is, (2) is not in the
same class as (1) or (3).

And honestly - we've been doing this for all the common cases already
since at least 5.9, and your performance argument simply has not
really reared its head.  Which makes the whole argument moot. I claim
that it simplifies lots of common operations and avoids having to
serialize on a lock that has been a real and major problem. You claim
it's extra overhead and can cause extra COW events. Neither of has any
numbers worth anything, but at least I can point to the fact that all
the *normal* VM paths have been doing the thing I advocate for many
releases now, and the sky most definitely is NOT falling.

So that only leaves (3).

Handling (3) really is so conceptually simple that I feel silly for
repeating it: if you don't want a COW to happen, then you mark the
page as being not-COW.

That sounds so simple as to be stupid. But it really is the solution.
It's what that pinning logic does, and keeps that "page may be pinned"
state around, and then operations like fork() that would otherwise
create a COW mapping of it will just not do it.

So that incredibly simple approach does require actual code: it
requires that explicit "fork() needs to copy instead of COW" code, it
requires that "if it's pinned, we don't make a new swapcache entry out
of it". So it's real code, and it's a real issue, but it's
conceptually absolutely trivial, and the code is usualyl really simple
to understand too.

So you have a *trivial* concept, and you have simple code that could
be described to a slightly developmentally challenged waterfowl.  If
you're one of the programmers doing the "explain your code to a rubber
ducky", you can look at code like this:

                /*
                 * Anonymous process memory has backing store?
                 * Try to allocate it some swap space here.
                 * Lazyfree page could be freed directly
                 */
                if (PageAnon(page) && PageSwapBacked(page)) {
                        if (!PageSwapCache(page)) {
                                if (!(sc->gfp_mask & __GFP_IO))
                                        goto keep_locked;
                                if (page_maybe_dma_pinned(page))
                                        goto keep_locked;

and you can explain that page_maybe_dma_pinned() test to your rubber
ducky, and that rubber ducky will literally nod its head. It gets it.

To recap:
 (1) is important, and page_count() is the only thing that guarantees
"you get full access to a page only when it's *obviously* exclusively
yours".
 (2) is NOT important, but could be a performance issue, but we have
real data from the past year that it isn't.
 (3) is important, and has a really spectacularly simple conceptual
fix with quite simple code too.

In contrast, with the "mapcount" games you can't even explain why they
should work, and the patches I see are actively buggy because
everything is so subtle.

                  Linus
