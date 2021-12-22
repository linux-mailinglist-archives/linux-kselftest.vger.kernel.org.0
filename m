Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFC47D559
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbhLVQo4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 11:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbhLVQoz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 11:44:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DCFC061574;
        Wed, 22 Dec 2021 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OZrPu/M8Hceg766ih22RPa2zy9wilvTWAaB475eNeyA=; b=heWKO8ps0AGajXs8BrNxqvRQjl
        m7xQxIHpN+ngLUJhGPtz0f2XbHJB56k0M1qMp0M4t2hz05NPrRQ6pGU+pC0oHkuyyde4NdFNusRW0
        VszzPepp60mZhjTtPk7EwpANozCL0WnQDSM8Z4VWJJLELTya8vM6pCSQLOblJ6qLxwRcTPOdi6Sld
        onhowzpCdccfg7rhoUWgQ+1WUDlgFF9Wism78juB0cFQ7iIrAgL71Rabkcbpolp30IGNQ4yXXwgHV
        gf45IZUnI80Fapdgows6u4cSRI7DqAdyCnPbes8xpFinvZMH4WEw39DShQKFBH82vt2IG+tpKonTK
        Yh0Y/S0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n04jI-003X5C-GC; Wed, 22 Dec 2021 16:44:40 +0000
Date:   Wed, 22 Dec 2021 16:44:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <YcNV+C6yeNLRzMH3@casper.infradead.org>
References: <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz>
 <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
 <20211222144255.GE685@quack2.suse.cz>
 <505d3d0f-23ee-0eec-0571-8058b8eedb97@redhat.com>
 <20211222160846.GH685@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222160846.GH685@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 22, 2021 at 05:08:46PM +0100, Jan Kara wrote:
> On Wed 22-12-21 15:48:34, David Hildenbrand wrote:
> > On 22.12.21 15:42, Jan Kara wrote:
> > > On Wed 22-12-21 14:09:41, David Hildenbrand wrote:
> > >>>> IIUC, our COW logic makes sure that a shared anonymous page that might
> > >>>> still be used by a R/O FOLL_GET cannot be modified, because any attempt
> > >>>> to modify it would result in a copy.
> > >>>
> > >>> Well, we defined FOLL_PIN to mean the intent that the caller wants to access
> > >>> not only page state (for which is enough FOLL_GET and there are some users
> > >>> - mostly inside mm - who need this) but also page data. Eventually, we even
> > >>> wanted to make FOLL_GET unavailable to broad areas of kernel (and keep it
> > >>> internal to only MM for its dirty deeds ;)) to reduce the misuse of GUP.
> > >>>
> > >>> For file pages we need this data vs no-data access distinction so that
> > >>> filesystems can detect when someone can be accessing page data although the
> > >>> page is unmapped.  Practically, filesystems care most about when someone
> > >>> can be *modifying* page data (we need to make sure data is stable e.g. when
> > >>> writing back data to disk or doing data checksumming or other operations)
> > >>> so using FOLL_GET when wanting to only read page data should be OK for
> > >>> filesystems but honestly I would be reluctant to break the rule of "use
> > >>> FOLL_PIN when wanting to access page data" to keep things simple and
> > >>> reasonably easy to understand for parties such as filesystem developers or
> > >>> driver developers who all need to interact with pinned pages...
> > >>
> > >> Right, from an API perspective we really want people to use FOLL_PIN.
> > >>
> > >> To optimize this case in particular it would help if we would have the
> > >> FOLL flags on the unpin path. Then we could just decide internally
> > >> "well, short-term R/O FOLL_PIN can be really lightweight, we can treat
> > >> this like a FOLL_GET instead". And we would need that as well if we were
> > >> to keep different counters for R/O vs. R/W pinned.
> > > 
> > > Well, I guess the question here is: Which GUP user needs only R/O access to
> > > page data and is so performance critical that it would be worth it to
> > > sacrifice API clarity for speed? I'm not aware of any but I was not looking
> > > really hard...
> > 
> > I'd be interested in examples as well. Maybe databases that use O_DIRECT
> > after fork()?
> 
> Well, but O_DIRECT reads must use FOLL_PIN in any case because they modify
> page data (and so we need to detect them both for COW and filesystem needs).
> O_DIRECT writes could use FOLL_GET but at this point I'm not convinced it
> is worth it.

Wow, I didn't realise the plan was to make FOLL_PIN the "default".
I hoped it was weird crap that was going away soon.  Looks like we'd
better fix all the bugs in it then ...
