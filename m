Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5C47C5B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 19:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbhLUSHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 13:07:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46312 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhLUSHN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 13:07:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EAE401F388;
        Tue, 21 Dec 2021 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640110031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aHVar+NDv9LhVgPKkE8yVeRcY+l7hvW45ogGvLvZqI=;
        b=NrRBSTtBkpGrNyBZf9DmkNb9e8BDxusII75XYLrNqgQo1pb7pJ5w6SCGU0UgXF7iumVT0p
        m0l5ry5Bgl7ncB2YD4osjIjL2RryHzgFtxxDtCVY5im5GJ8V97iouma+3xLsty74dAlf9g
        c8Likz9rmpEzqcH1Uj/tFeBhgXrgqrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640110031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aHVar+NDv9LhVgPKkE8yVeRcY+l7hvW45ogGvLvZqI=;
        b=EQvIag3QDEARwfFqVfScA9TyRwLYYQtJ5j4IJSahIATSGzZfSZtnNNoBXqS5gebwGEhAk8
        g8Hpif72xjDR3vDQ==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 8550EA3B8A;
        Tue, 21 Dec 2021 18:07:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DBFFE1F2CEA; Tue, 21 Dec 2021 19:07:05 +0100 (CET)
Date:   Tue, 21 Dec 2021 19:07:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20211221180705.GA32603@quack2.suse.cz>
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 21-12-21 18:40:30, David Hildenbrand wrote:
> On 21.12.21 18:05, Linus Torvalds wrote:
> > On Tue, Dec 21, 2021 at 12:58 AM David Hildenbrand <david@redhat.com> wrote:
> >> Note that I am trying to make also any kind of R/O pins on an anonymous
> >> page work as expected as well, to fix any kind of GUP after fork() and
> >> GUP before fork(). So taking a R/O pin on an !PageAnonExclusive() page
> >> similarly has to make sure that the page is exclusive -- even if it's
> >> mapped R/O (!).
> > 
> > I do think the existing "maybe_pinned()" logic is fine for that. The
> > "exclusive to this VM" bit can be used to *help* that decision -
> > because only an exclusive page can be pinned - bit I don't think it
> > should _replace_ that logic.
> 
> The issue is that O_DIRECT uses FOLL_GET and cannot easily be changed to
> FOLL_PIN unfortunately. So I'm *trying* to make it more generic such
> that such corner cases can be handled as well correctly. But yeah, I'll
> see where this goes ... O_DIRECT has to be fixed one way or the other.
> 
> John H. mentioned that he wants to look into converting that to
> FOLL_PIN. So maybe that will work eventually.

For record we always intended (and still intend) to make O_DIRECT use
FOLL_PIN. Just it is tricky because some users mix pages pinned with GUP
and pages acquired through get_page() in a single bio (such as zero page)
and thus it is non-trivial to do the right thing on IO completion (unpin or
just put_page).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
