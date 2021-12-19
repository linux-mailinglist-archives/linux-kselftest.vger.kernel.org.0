Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AEF47A238
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 22:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhLSVMQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 16:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbhLSVMQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 16:12:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCD0C061574;
        Sun, 19 Dec 2021 13:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zqlFDBLHajnmW6mUIPthSeuQfJKdlQjNzAtsDu8MOeQ=; b=tzKRd0PdZDTg6wWSKsTKnQJ+sN
        NuDm+zLpq0sHd09YzKzCFKNAn0pZHXnADRt4x7oNk+0wGxCZT4OSKCsXjzKtc1PCc3rPkJ7MJpKF1
        65uWo3bUMXalRpgVUFGlSfITew3R6EBqH/kmYi4NSea+GVqPdref3E4884uQoTCrH2tpFtA/ihWNB
        wvcVCg8yV38ut+cSqikjvSNUpJ1mRbjm7OKwodEMdAXoVtKwVLt1YtRMjwksMcNgh5EVDvDLNyRKX
        cEnAKQAuHAqKkr1v6C9u+7zlLWafdjgNzMk54g7I/OxMDCN9g+ZEzqoNl35SgZu3LexTURLeoaZu7
        8JJGApJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz3TN-0012HD-BR; Sun, 19 Dec 2021 21:12:01 +0000
Date:   Sun, 19 Dec 2021 21:12:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <Yb+gId/gXocrlJYD@casper.infradead.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 19, 2021 at 06:59:51PM +0100, David Hildenbrand wrote:
> On 19.12.21 18:44, Linus Torvalds wrote:
> > David, you said that you were working on some alternative model. Is it
> > perhaps along these same lines below?
> > 
> > I was thinking that a bit in the page tables to say "this page is
> > exclusive to this VM" would be a really simple thing to deal with for
> > fork() and swapout and friends.
> > 
> > But we don't have such a bit in general, since many architectures have
> > very limited sets of SW bits, and even when they exist we've spent
> > them on things like UDDF_WP.,
> > 
> > But the more I think about the "bit doesn't even have to be in the
> > page tables", the more I think maybe that's the solution.
> > 
> > A bit in the 'struct page' itself.
> > 
> 
> Exactly what I am prototyping right now.
> 
> > For hugepages, you'd have to distribute said bit when  you split the hugepage.
> 
> Yes, that's one tricky part ...

That part shouldn't be that tricky ...

Can we get rid of ->mapcount altogether?  Three states:
 - Not mapped
 - Mapped exactly once
 - Possibly mapped more than once

I appreciate "Not mapped" is not a state that anon pages can
meaningfully have (maybe when they go into the swap cache?)

And this information would only be present on the head page (ie stored
per folio).  If one VMA has multiple PTEs that map the same folio,
then hopefully that only counts as mapped once.

I must admit about half this conversation is going over my head.  I need
more time to understand all the constraints than exists between emails
:-)
