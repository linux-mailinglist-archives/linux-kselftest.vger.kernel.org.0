Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB5D47DBA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Dec 2021 01:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbhLWAVW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 19:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhLWAVW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 19:21:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC61BC061574;
        Wed, 22 Dec 2021 16:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=47BEa1hBBev4vX+Gi5bGfRRBsw7bv8W386eAVjO1ObE=; b=eQy3zB97VxV99BacLcEaJWTRRs
        tE0WyDHbK77GpmAPcW7qbHLnAr0KDQ++U2pIULowmjTm6tOyWF5rpc6j7YQQNU2DoOs5IH9MZiZ6e
        pX8voct0+kLRvyyLzq53tykTDw/Jia+YeA7IQd6MtXXI6InXHTgySPfWXi91cPvBm98WmwSM5YSoX
        3ni5EcnDHHx1JaHxWmMC1Gdx4k0LlrS3OWE6LF2Qt8/bdsuZECflTMtqZiVUK0D8ibE/cVbDQ09Tr
        dotXGPxlQpWzFvXOHAZeAFdvS0rHLlsBABk5wzXUDrYwTsNFjStdGyeWERKodf5npN5Dg1BS9b7W6
        HdqSIzbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Br0-003oXl-KT; Thu, 23 Dec 2021 00:21:06 +0000
Date:   Thu, 23 Dec 2021 00:21:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <YcPA8gJ0OBPTdCdB@casper.infradead.org>
References: <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz>
 <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 22, 2021 at 02:09:41PM +0100, David Hildenbrand wrote:
> Right, from an API perspective we really want people to use FOLL_PIN.
> 
> To optimize this case in particular it would help if we would have the
> FOLL flags on the unpin path. Then we could just decide internally
> "well, short-term R/O FOLL_PIN can be really lightweight, we can treat
> this like a FOLL_GET instead". And we would need that as well if we were
> to keep different counters for R/O vs. R/W pinned.

FYI, in my current tree, there's a gup_put_folio() which replaces
put_compound_head:

static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
{
        if (flags & FOLL_PIN) {
                node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
                if (hpage_pincount_available(&folio->page))
                        hpage_pincount_sub(&folio->page, refs);
                else
                        refs *= GUP_PIN_COUNTING_BIAS;
        }

        folio_put_refs(folio, refs);
}

That can become non-static if it's needed.  I'm still working on that
series, because I'd like to get it to a point where we return one
folio pointer instead of N page pointers.  Not quite there yet.
