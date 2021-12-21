Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2F47B8FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 04:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhLUD3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 22:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhLUD3u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 22:29:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D607C061574;
        Mon, 20 Dec 2021 19:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4/ofnA93MB0dtNJDnD1hlkEoHaSdJsk2n9FUm5M/5P4=; b=jhNWENbQ7taimgHAwhZK+qk4O/
        B0SrrJQsLG31HJBXTkSiLOYCGMEz38WndNA2sLzuqm4pnZ3fsnMtYQrXD7oa3gDYQV+2/bE6aCZqJ
        di+T2/wvtz6CotoytzvKvjuiwzsN2wh8iGnrexn0njrRIcc6iKLggwF18gEHWSvMXReRsD5zu19li
        +dQdybF1DCY1lGff19sXOK8dyQJB/TY7z7Eg2btAzScGrXGefOwOpR1ZXLe3FR1Dbcgzj4oGJV2hi
        WzK2YXlMvojWbc88kRurNY3+M43ngGye/j3WHnOH/C7RAGSnmB3HRuuUOBPAt/ICwMnX0e4Rvsy5U
        7hpnFIAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzVqJ-0028lH-RV; Tue, 21 Dec 2021 03:29:35 +0000
Date:   Tue, 21 Dec 2021 03:29:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <YcFKH2kXFec9/pyn@casper.infradead.org>
References: <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221010312.GC1432915@nvidia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 20, 2021 at 09:03:12PM -0400, Jason Gunthorpe wrote:
> That just leave the THP splitting.. I suppose we get the PTL, then
> compute the current value of the new bit based on refcount and diffuse
> it to all tail pages, then update the PMD and release the PTL. Safe
> against concurrent WP - don't need DoubleMap horrors because it isn't
> a counter.

One of the things I've been trying to figure out is how we do
can_split_huge_page().  Maybe an rmap walk to figure out how many
refcounts we would subtract if we did unmap it from everywhere it's
currently mapped?  (just to be clear, we call unmap_page() as the
next thing, so I don't mind warming up the rbtree cachelines
if it's mapped anywhere)
