Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A0947A268
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 22:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhLSVsI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhLSVsI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 16:48:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318D0C061574;
        Sun, 19 Dec 2021 13:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1v3rhVRtSpHuYJv9uFlNf7MqDRGkx1dQifx2JIc8fF4=; b=a6OvZ5RxPnNXGyhPGK5/t54Z2A
        Z3dfIZ8x1oIxZ2e2eORFv94NgAjGnPH6BDro1KL11cWSjjetgfzik7fSfmMz6HI5pFrw/CA7hb6VN
        oFrBAn60FUDg+dJ0lg6uDk98mSzermjS2G2T3Slqn3+fBntxVsfPLSvLTPhAVemkzWJNjV5VgNqL6
        aoKOWhn82L6zKISZI+ulN0oEBg5ashlxsTt5SLEwHsV0zyyMb0WwflEvzTCVTS/2p8Plkxe6U8oN6
        Db+NrW2LjzFyYwbEDjxeXq80WCqNDeVNAoEEQYtyHja0RjiHXBuGhIyjTRHMTOfBduBn3YS/Xqf8k
        QDBmX7ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz427-0013Ui-GD; Sun, 19 Dec 2021 21:47:55 +0000
Date:   Sun, 19 Dec 2021 21:47:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
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
Message-ID: <Yb+oi8fg1dJe1uBm@casper.infradead.org>
References: <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <Yb+gId/gXocrlJYD@casper.infradead.org>
 <CAHk-=wiAzmB-jiHvF+EZ1-b0X3ts4LAYHaVhzpzXEjmC0X95eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiAzmB-jiHvF+EZ1-b0X3ts4LAYHaVhzpzXEjmC0X95eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 19, 2021 at 01:27:07PM -0800, Linus Torvalds wrote:
> On Sun, Dec 19, 2021 at 1:12 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Can we get rid of ->mapcount altogether?  Three states:
> >  - Not mapped
> >  - Mapped exactly once
> >  - Possibly mapped more than once
> 
> I don't think even that is useful. We should get rid of mapcount entirely.
> 
> It doesn't actually help to know "mapped exactly once", exactly
> because even when that's true, there may be non-mapped references to
> the page.
> 
> Mapped references really aren't that special in general.
> 
> One case where it *can* be special is on virtually indexed cache
> architectures, where "is this mapped anywhere else" can be an issue
> for cache flushing.
> 
> There the page_mapcount() can actually really matter, but it's such an
> odd case that I'm not convinced it should be something the kernel VM
> code should bend over backwards for.
> 
> And the count could be useful for 'rmap' operations, where you can
> stop walking the rmap once you've found all mapped cases (paghe
> migration being one case of this). But again, I'm not convinced the
> serialization is worth it, or that it's a noticeable win.
> 
> However, I'm not 100% convinced it's worth it even there, and I'm not
> sure we necessarily use it there.
> 
> So in general, I think page_mapcount() can be useful as a count for
> those things that are _literally_ about "where is this page mapped".
> Page migration, virtual cache coherency, things like that can
> literally be about "how many different virtual mappings can we find".
> 
> It's just that pages can have a number of non-mapped users too, so
> mapcount isn't all that meaningful in general.
> 
> And you can look it up with rmap too, and so I do think it would be
> worth discussing whether we really should strive to maintain
> 'mapcount' at all.

Yes, agreed, I was thinking that we could use "not mapped at all"
as an optimisation to avoid doing rmap walks.  eg __unmap_and_move().

Perhaps more interestingly in truncate_cleanup_page():
        if (page_mapped(page))
                unmap_mapping_page(page);
where we can skip the i_mmap rbtree walk if we know the page isn't
mapped.  I'd be willing to give up that optimisation if we had "this
page was never mapped" (ie if page_mapped() was allowed to return
false positives).
