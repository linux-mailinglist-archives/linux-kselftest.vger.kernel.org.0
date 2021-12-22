Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CD647D22C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbhLVMmM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:42:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48970 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbhLVMlo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 88D6B1F37E;
        Wed, 22 Dec 2021 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640176902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDzNf6Tqq2XWEQtFu0PI74ENcua2VcQ7pyxlNlLdJkY=;
        b=dNVetoaTuf36VLVTDAiYoVF2mRRUnaXUChfvN2zUsJwjE7+1Yzw5f/3EG/4ztuLS3T/Rt7
        zWtGwVwBu1mSBjDYrPok7QleF6NX7HeVkDfmHzt3hslMcY0INbCDQwqzB+BOlFqTY0bRwP
        NLQzrEEK8MKBAvIKjFim8z5HgNcom1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640176902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDzNf6Tqq2XWEQtFu0PI74ENcua2VcQ7pyxlNlLdJkY=;
        b=+sk/jtIu9Qc4QDt+yXf0eB+Y7Wg8hMOShKI1korq4z4P3dtgC/ihXl4Kora7AQihQgpd5A
        aP/ZKwLwF2IlwiCg==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 309A6A3B8C;
        Wed, 22 Dec 2021 12:41:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F02DD1F2CEF; Wed, 22 Dec 2021 13:41:41 +0100 (CET)
Date:   Wed, 22 Dec 2021 13:41:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20211222124141.GA685@quack2.suse.cz>
References: <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 22-12-21 10:58:36, David Hildenbrand wrote:
> On 22.12.21 09:51, David Hildenbrand wrote:
> > On 21.12.21 20:07, Jason Gunthorpe wrote:
> >> On Tue, Dec 21, 2021 at 06:40:30PM +0100, David Hildenbrand wrote:
> >>
> >>> 2) is certainly the cherry on top. But it just means that R/O pins don't
> >>> have to be the weird kid. And yes, achieving 2) would require
> >>> FAULT_FLAG_EXCLUSIVE / FAULT_FLAG_UNSHARED, but it would really 99% do
> >>> what existing COW logic does, just bypass the "map writable" and
> >>> "trigger write fault" semantics.
> >>
> >> I still don't agree with this - when you come to patches can you have
> >> this work at the end and under a good cover letter? Maybe it will make
> >> more sense then.
> > 
> > Yes. But really, I think it's the logical consequence of what Linus said
> > [1]:
> > 
> >   "And then all GUP-fast would need to do is to refuse to look up a page
> >    that isn't exclusive to that VM. We already have the situation that
> >    GUP-fast can fail for non-writable pages etc, so it's just another
> >    test."
> > 
> > We must not FOLL_PIN a page that is not exclusive (not only on gup-fast,
> > but really, on any gup). If we special case R/O FOLL_PIN, we cannot
> > enable the sanity check on unpin as suggested by Linus [2]:
> > 
> >   "If we only set the exclusive VM bit on pages that get mapped into
> >    user space, and we guarantee that GUP only looks up such pages, then
> >    we can also add a debug test to the "unpin" case that the bit is
> >    still set."
> > 
> > There are really only two feasible options I see when we want to take a
> > R/O FOLL_PIN on a !PageAnonExclusive() anon page
> > 
> > (1) Fail the pinning completely. This implies that we'll have to fail
> >     O_DIRECT once converted to FOLL_PIN.
> > (2) Request to mark the page PageAnonExclusive() via a
> >     FAULT_FLAG_UNSHARE and let it succeed.
> > 
> > 
> > Anything else would require additional accounting that we already
> > discussed in the past is hard -- for example, to differentiate R/O from
> > R/W pins requiring two pin counters.
> > 
> > The only impact would be that FOLL_PIN after fork() has to go via a
> > FAULT_FLAG_UNSHARE once, to turn the page PageAnonExclusive. IMHO this
> > is the right thing to do for FOLL_LONGTERM. For !FOLL_LONGTERM it would
> > be nice to optimize this, to *not* do that, but again ... this would
> > require even more counters I think, for example, to differentiate
> > between "R/W short/long-term or R/O long-term pin" and "R/O short-term pin".
> > 
> > So unless we discover a way to do additional accounting for ordinary 4k
> > pages, I think we really can only do (1) or (2) to make sure we never
> > ever pin a !PageAnonExclusive() page.
> 
> BTW, I just wondered if the optimization should actually be that R/O
> short-term FOLL_PIN users should actually be using FOLL_GET instead. So
> O_DIRECT with R/O would already be doing the right thing.
> 
> And it somewhat aligns with what we found: only R/W short-term FOLL_GET
> is problematic, where we can lose writes to the page from the device via
> O_DIRECT.
> 
> IIUC, our COW logic makes sure that a shared anonymous page that might
> still be used by a R/O FOLL_GET cannot be modified, because any attempt
> to modify it would result in a copy.

Well, we defined FOLL_PIN to mean the intent that the caller wants to access
not only page state (for which is enough FOLL_GET and there are some users
- mostly inside mm - who need this) but also page data. Eventually, we even
wanted to make FOLL_GET unavailable to broad areas of kernel (and keep it
internal to only MM for its dirty deeds ;)) to reduce the misuse of GUP.

For file pages we need this data vs no-data access distinction so that
filesystems can detect when someone can be accessing page data although the
page is unmapped.  Practically, filesystems care most about when someone
can be *modifying* page data (we need to make sure data is stable e.g. when
writing back data to disk or doing data checksumming or other operations)
so using FOLL_GET when wanting to only read page data should be OK for
filesystems but honestly I would be reluctant to break the rule of "use
FOLL_PIN when wanting to access page data" to keep things simple and
reasonably easy to understand for parties such as filesystem developers or
driver developers who all need to interact with pinned pages...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
