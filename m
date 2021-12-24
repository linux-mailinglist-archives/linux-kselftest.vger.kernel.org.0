Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C51D47EB76
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 05:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhLXExz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Dec 2021 23:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbhLXExz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Dec 2021 23:53:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F4C061401;
        Thu, 23 Dec 2021 20:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q8w6vJlPkDbS/DrH5IOenXLh3tsJgjfSoA1ZgPxsyRg=; b=RLa6CpDWsILp5BM50R2uDaFxLY
        kckmBXACDfFG18rbWU451uZgJf2XJ6YxtUUeNLNZmEWFd0bzKnYVXpCPc6tGF8TT52vEyvbQIf5bD
        MdWiWj22xuFFnEWraqZZlU5OFHtDMSJkSyl6WS/CqP+8NzAmJFq/crbD3+u0ycPbxtg6alM7OQAS7
        0rxKqIjEMrapCBDpChh+XaNVK9bFLaUjZ6T/wbs741J9fKkComlKwv/7xxFAxg3wgl4AVqgrDGBfm
        fec1iv69kA5NXlRg5KuUaX0Cvdkji5gnIC+RedwkG4oWu9cxd2swHojNuY5D5/rDqLghNmFwOcEx9
        o/OObrqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0caI-004px5-1k; Fri, 24 Dec 2021 04:53:38 +0000
Date:   Fri, 24 Dec 2021 04:53:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <YcVSUmfzTrhjZapc@casper.infradead.org>
References: <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz>
 <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
 <YcPA8gJ0OBPTdCdB@casper.infradead.org>
 <20211224025309.GF1779224@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224025309.GF1779224@nvidia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 23, 2021 at 10:53:09PM -0400, Jason Gunthorpe wrote:
> On Thu, Dec 23, 2021 at 12:21:06AM +0000, Matthew Wilcox wrote:
> > On Wed, Dec 22, 2021 at 02:09:41PM +0100, David Hildenbrand wrote:
> > > Right, from an API perspective we really want people to use FOLL_PIN.
> > > 
> > > To optimize this case in particular it would help if we would have the
> > > FOLL flags on the unpin path. Then we could just decide internally
> > > "well, short-term R/O FOLL_PIN can be really lightweight, we can treat
> > > this like a FOLL_GET instead". And we would need that as well if we were
> > > to keep different counters for R/O vs. R/W pinned.
> > 
> > FYI, in my current tree, there's a gup_put_folio() which replaces
> > put_compound_head:
> > 
> > static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
> > {
> >         if (flags & FOLL_PIN) {
> >                 node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
> >                 if (hpage_pincount_available(&folio->page))
> >                         hpage_pincount_sub(&folio->page, refs);
> >                 else
> >                         refs *= GUP_PIN_COUNTING_BIAS;
> >         }
> > 
> >         folio_put_refs(folio, refs);
> > }
> > 
> > That can become non-static if it's needed.  I'm still working on that
> > series, because I'd like to get it to a point where we return one
> > folio pointer instead of N page pointers.  Not quite there yet.
> 
> I'm keen to see what that looks like, every driver I'm working on that
> calls PUP goes through gyrations to recover contiguous pages, so this
> is most welcomed!

I'm about to take some time off, so alas, you won't see it any time
soon.  It'd be good to talk with some of the interested users because
it's actually a pretty tricky problem.  We can't just return an array
of the struct folios because the actual memory you want to access
might be anywhere in that folio, and you don't want to have to redo
the lookup just to find out which subpages of the folio are meant.

So I'm currently thinking about returning a bio_vec:

struct bio_vec {
        struct page     *bv_page;
        unsigned int    bv_len;
        unsigned int    bv_offset;
};

In the iomap patchset which should go upstream in the next merge window,
you can iterate over a bio like this:

        struct folio_iter fi;

        bio_for_each_folio_all(fi, bio)
                iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);

There aren't any equivalent helpers for a bvec yet, but obviously we can
add them so that you can iterate over each folio in a contiguous range.

But now that each component in it is variable length, the caller can't
know how large an array of bio_vecs to allocate.

1. The callee can allocate the array and let the caller free it when it's
   finished
2. The caller passes in a (small, fixed-size, on-stack) array of bio_vecs
   over (potentially) multiple calls.
3. The caller can overallocate and ignore that most of the array isn't
   used.

Any preferences?  I don't like #3.
