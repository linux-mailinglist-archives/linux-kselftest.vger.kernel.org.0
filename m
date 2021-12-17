Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC86479640
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 22:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhLQV27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 16:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLQV26 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 16:28:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E472C061574;
        Fri, 17 Dec 2021 13:28:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639776536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OFrA0YAB5NqcgCSPrjgoGq4+oWDLHK3CbDZuQ3ZUUlE=;
        b=23WkD2MrN4FWPZMZ815HQRHb8Kn8Kwz/g45LGgLFfTVELNZuOt8QSHnnqk2GaK6fg1+LbS
        HidnYXMpCYVouy+xx6UoXFeSEFpd6E4BfpTx2cnolJ2GYNYKzvg4RSBkoosy6FQ+dflAUq
        qnvV1480A6xKYqRuOYH2RqiZyjUDbRCWHNLLScfwiL1DSulAD77f2QH3hjrrtj6azIbHmM
        Q3DZIx9rpawA03rEbF7dz1kfPemGvD0HVcudSiW+JfFOWAQZfK3wTvn707G6ntdFK3jzYS
        Ie5+SpYngYEEMbxMSgWVnGxSqlmr3VLbZU8kl7f1DOW5whlq/4tsn1JZ9GHqcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639776536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OFrA0YAB5NqcgCSPrjgoGq4+oWDLHK3CbDZuQ3ZUUlE=;
        b=CYGLcg86LFFqXWSljdKogfuduSWHPRdtVdDrKbtUpbxJmEqwqDghCeDcV1Kuus79KaN+Sa
        Kr87YulrrMba1dAQ==
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 01/11] seqlock: provide lockdep-free raw_seqcount_t
 variant
In-Reply-To: <20211217113049.23850-2-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-2-david@redhat.com>
Date:   Fri, 17 Dec 2021 22:28:55 +0100
Message-ID: <87h7b6c44o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 17 2021 at 12:30, David Hildenbrand wrote:
> Sometimes it is required to have a seqcount implementation that uses
> a structure with a fixed and minimal size -- just a bare unsigned int --
> independent of the kernel configuration. This is especially valuable, when
> the raw_ variants of the seqlock function will be used and the additional
> lockdep part of the seqcount_t structure remains essentially unused.
>
> Let's provide a lockdep-free raw_seqcount_t variant that can be used via
> the raw functions to have a basic seqlock.
>
> The target use case is embedding a raw_seqcount_t in the "struct page",
> where we really want a minimal size and cannot tolerate a sudden grow of
> the seqcount_t structure resulting in a significant "struct page"
> increase or even a layout change.

Cannot tolerate? Could you please provide a reason and not just a
statement?

> Provide raw_read_seqcount_retry(), to make it easy to match to
> raw_read_seqcount_begin() in the code.
>
> Let's add a short documentation as well.
>
> Note: There might be other possible users for raw_seqcount_t where the
>       lockdep part might be completely unused and just wastes memory --
>       essentially any users that only use the raw_ function variants.

Even when the reader side uses raw_seqcount_begin/retry() the writer
side still can use the non-raw variant which validates that the
associated lock is held on write.

Aside of that your proposed extra raw sequence count needs extra care
vs. PREEMPT_RT and this want's to be very clearly documented. Why?

The lock association has two purposes:

    1) Lockdep coverage which unearthed bugs already

    2) PREEMPT_RT livelock prevention

       Assume the following:

       spin_lock(wrlock);
       write_seqcount_begin(seq);

       ---> preemption by a high priority reader

       seqcount_begin(seq); <-- live lock

       The RT substitution does:

       seqcount_begin(seq)
           cnt = READ_ONCE(seq->sequence);

           if (cnt & 1) {
           	lock(s->lock);
                unlock(s->lock);
           }

       which prevents the deadlock because it makes the reader block on
       the associated lock, which allows the preempted writer to make
       progress.

       This applies to raw_seqcount_begin() as well.

I have no objections against the construct itself, but this has to be
properly documented vs. the restriction this imposes.

As you can see above the writer side therefore has to ensure that it
cannot preempted on PREEMPT_RT, which limits the possibilities what you
can do inside a preemption (or interrupt) disabled section on RT enabled
kernels. See Documentation/locking/locktypes.rst for further information.

Thanks,

        tglx
