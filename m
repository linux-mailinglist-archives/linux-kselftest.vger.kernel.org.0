Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86BA479654
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 22:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhLQVhL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 16:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhLQVhL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 16:37:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8385C06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:37:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z5so12899370edd.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9IysSCKwmnVf0clSv3vqtB9fmhRZmRL64GBWJwRw/Y=;
        b=NsoM3bp5z1ViaGMsoT3rdJ0GTTkM2nxbtO1rOArzSMsTMLZJNzIeeDbkuFjfjllNC8
         xn6hGkr0DopwV/8Eu5djljv17PjTjMOTC8v7g/t2TyO7f8rn0uZpLJ8UcnwQTupGApwJ
         t6+Rs305ThbmGf+HCSQiO/fTN2vHb+5yfsROE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9IysSCKwmnVf0clSv3vqtB9fmhRZmRL64GBWJwRw/Y=;
        b=g3kAeeesj6y6L4A34CVbjN/LuU03C0b4Winjq+qMkFcZ1LewhqbA+nZpyol5CDH/rJ
         21/hTXjhLBWHlKdKn7zIxooONSO5kga06B73yhbNGX5c+kB8NLXZjHOgy3l6lKML6cbR
         Gfii/t2GYJGBe6GKzfd5vQyCKNZbj8v4AcrKUVyOFIroIqDoJlmQJzoizIJTi7HKlFnJ
         sTWcZrlJB4cIAfW4ED4X0uwwJHhOBBpn60Xadk1BO4opzWV67rDLxKX3Ff+clh+rtT3p
         yfDHIFG0zuXZS3GhiI+ZKUfxllA1Zau7HftW49vJ72YbfUQRLhDeUKdiRxa3GFM8XsRT
         HeNQ==
X-Gm-Message-State: AOAM530DR8AxyXJcVKtlx89Y/6wWZlGUCElux9l+AXhcOEwEfS09NQXq
        1FjXnJ5eOAfV14HmtThPznM07AxCX7alHaBffGI=
X-Google-Smtp-Source: ABdhPJy8dX1ljhpHEUKxtkqZQQY+m0foMaYbp7NHD809+b8vdNCcdmErM5mgwYXBPwwF7JkGK/d87A==
X-Received: by 2002:a05:6402:2686:: with SMTP id w6mr4620832edd.141.1639777029125;
        Fri, 17 Dec 2021 13:37:09 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id o21sm3242550ejy.181.2021.12.17.13.37.08
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 13:37:08 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so2360699wmb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:37:08 -0800 (PST)
X-Received: by 2002:a05:600c:1e01:: with SMTP id ay1mr2170336wmb.152.1639777018053;
 Fri, 17 Dec 2021 13:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com> <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
In-Reply-To: <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 13:36:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
Message-ID: <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 12:55 PM David Hildenbrand <david@redhat.com> wrote:
>
> If we have a shared anonymous page we cannot have GUP references, not
> even R/O ones. Because GUP would have unshared and copied the page,
> resulting in a R/O mapped anonymous page.

Doing a GUP on an actual shared page is wrong to begin with.

You even know that, you try to use "page_mapcount() > 1" to disallow it.

My point is that it's wrong regardless, and that "mapcount" is
dubious, and that COW cannot - and must not - use mapcount, and that I
think your shared case should strive to avoid it for the exact same
reason.

So, what I think should happen is:

 (a) GUP makes sure that it only ever looks up pages that can be
shared with this VM. This may in involve breaking COW early with any
past fork().

 (b) it marks such pages so that any future work will not cause them
to COW either

Note that (a) is not necessarily "always COW and have to allocate and
copy new page". In particular, if the page is already writable, you
know you already have exclusive access to it and don't need to COW.

And if it isn't writable, then the other common case is "the cow has
only one user, and it's us" - that's the "refcount == 1" case.

And (b) is what we do with that page_maybe_dma_pinned() logic for
fork(), but also for things like swap cache creation (eg see commit
feb889fb40fa: "mm: don't put pinned pages into the swap cache").

Note that this code all already exists, and already works - even
without getting the (very expensive) mmap_sem. So it works with
fast-GUP and it can race with concurrent forking by another thread,
which is why we also have that seqcount thing.

As far as I can tell, your "mapcount" logic fundamentally requires
mmap_sem for the fork() race avoidance, for example.

So this is why I don't like the mapcount games - I think they are very
fragile, and not at all as logical as the two simple rules a/b above.

I believe you can make mapcount games _work_ - we used to have
something like that. It was incredibly fragile, and it had its own set
of bugs, but with enough care it's doable.

But my argument really is that I think it's the wrong approach, and
that we should simply strive to follow the two simple conceptual rules
above.

            Linus
