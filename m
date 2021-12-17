Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D6F479763
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 23:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhLQW70 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 17:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhLQW70 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 17:59:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE9C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 14:59:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bm14so565216edb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 14:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rs3RPGk851m6kBvnTkDZNuCHS7bqxE4YiPXPeOnsMec=;
        b=WSqIxUtqn5jcmA6NC9BVpsfsO/6YYpI4P+quaDiBpik06F329fj372+mpAs6nkU6hi
         UgKtVq/JNx9O5+tUI1FaDEc9lAWL66/z1RpLwMtAJZ086ni6cHm+R02sIgHA08fo/qlY
         ertG4Ei0o7WJ3lUoVgGOz1iW744OYt4w3zD7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rs3RPGk851m6kBvnTkDZNuCHS7bqxE4YiPXPeOnsMec=;
        b=tilRsi95Mz0uRQGY7Eo50SwwrYwyFC2LuivUlDDPMiO1rUcUZSSVsL+WJUBJDV9Dtc
         SwBGhmrWS4tLC0TjvYkBcml55YuO18MGUe8Ej94lIw2XxOC/GmLw/D6Jzi9KIcsDGhGe
         0RtRsSmiKV79v5eLpHcua/OPXVjvZ/0Lxo64YcvMuCavSLl2/ouDiHU7lXzGrUu4EiMp
         zK83tD2PwDlMSXEU3+GdgFWFF9e6PcAdtNLGkzwXQAtABs1iGn+C4mLA8+pLS1ZkNxxp
         hO7LPCGoGJGVZDXZ66rd3GfJd4GIWJJqpQLhsIki1TkvBlbBN6Nq+7XHsfW2bchu/Nrk
         Q+WA==
X-Gm-Message-State: AOAM531zflpHoeMi5AMYVb7KFtI7+AOr2qB2UhFghNMYLYCGfk4gZz7g
        QnvuRE8Zscf5M8PnlL6/rpjOF00dwD16AeWkd0A=
X-Google-Smtp-Source: ABdhPJyT2Ek19rf25X/e7sd1hO2XiLyguTM5PNlVs/fH3wRJjnniq5tO3QxN/aooCTaaQSoTkBKMfQ==
X-Received: by 2002:a17:907:4cd:: with SMTP id vz13mr3990808ejb.145.1639781964115;
        Fri, 17 Dec 2021 14:59:24 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id sh8sm2248212ejc.175.2021.12.17.14.59.23
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 14:59:23 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id g14so13368107edb.8
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 14:59:23 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr4140437wrp.442.1639781952748;
 Fri, 17 Dec 2021 14:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com> <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com> <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com> <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
 <0aa27d7d-0db6-94ee-ca16-91d19997286b@redhat.com>
In-Reply-To: <0aa27d7d-0db6-94ee-ca16-91d19997286b@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 14:58:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKACiq4sygvRwvJ7bE+dnbMVftoudEVvcbyws6G_FDyw@mail.gmail.com>
Message-ID: <CAHk-=wgKACiq4sygvRwvJ7bE+dnbMVftoudEVvcbyws6G_FDyw@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 2:29 PM David Hildenbrand <david@redhat.com> wrote:
>
> While I do care about future use cases, I cannot possibly see fork() not
> requiring the mmap_lock in the foreseeable future. Just so much depends
> on it as of now.

It's not that *fork()* depends on it.

Of course fork() takes the mmap_sem.

It's that fast-gup really really doesn't want it, and can't take it.

So any fast-gup user fundamentally cannot look at mapcount(), because
that would be fundamentally wrong and racy, and could race with fork.

And yet, as far as I can tell, that's *exactly* what your gup patches
do, with gup_pte_range() adding

+               if (!pte_write(pte) && gup_must_unshare(flags, page, false)) {
+                       put_compound_head(head, 1, flags);
+                       goto pte_unmap;
+               }

which looks at the page mapcount without holding the mmap sem at all.

And see my other email - I think there are other examples of your
patches looking at data that isn't stable because you don't hold the
right locks.

And you can't even do the optimistic case without taking the lock,
because in your world, a COW that optimistically copies in the case of
a race condition is fundamentally *wrong* and buggy. Because in your
world-view, GUP and COW are very different and have different rules,
but you need things to be *exact*, and they aren't.

And none of this is anything at least I can think about, because I
don't see what the "design" is.

I really have a hard time following what the rules actually are. You
seem to think that "page_mapcount()" is a really simple rule, and I
fundamentally disagree. It's a _very_ complicated thing indeed, with
locking issues, AND YOU ACTIVELY VIOLATE THE LOCKING RULES!

See why I'm so unhappy?

We *did* do the page_mapcount() thing. It was bad. It forced COW to
always take the page lock. There's a very real reason why I'm pushing
my "let's have a _design_ here", instead of your "let's look at
page_mapcount without even doing the locking".

And yes, I *know* that fork() takes the mmap_sem, and likely always
will. That really isn't the problem here. The problem is that your
page_mapcount() paths DO NOT take that lock.

Btw, maybe I'm misreading things. I looked at the individual patches,
I didn't apply them, maybe I missed something. But I don't think I am.

             Linus
