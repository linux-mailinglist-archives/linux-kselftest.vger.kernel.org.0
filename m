Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3A47A286
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 23:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhLSWCM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 17:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhLSWCK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 17:02:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F7FC061574;
        Sun, 19 Dec 2021 14:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ik7CaEEGpXRuQZR++uVqSeU17yFR4TjXp+S6ZiNh9rg=; b=az+/fZN5Ak/kbQo+9I5FXY8TPy
        EEJRR5S7BVufkP1mfPhtDSNGSqLr2ZEviQuohFwoOg6UM3YcEMkuWwP2FJR3nvR1Odmg2rftJqhgl
        9LYCodt4Rm3ZbuX0A0n0iN6asY0sEY7mxrzqB3U4RSB8Wpm7xZl1RE/FgPnMbOLvmB3AkEZIk8pss
        LCDPPSjNEf8EVmlvojXs+Udpopt0vieHfI4oCKJ/ayr2TOScFkepZ+vOlOh1YpVX9ZjpQbpTo8wIa
        EXnAzIZQlFrL/8Xw7EX3Me2vGZgLjBEAM/gkwHupiutdFzvNkHp/ZmNIUJX3jk2rnjGQr908Rtxtr
        Lyzw4W4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz4Fm-0014AH-18; Sun, 19 Dec 2021 22:02:02 +0000
Date:   Sun, 19 Dec 2021 22:02:01 +0000
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
Message-ID: <Yb+r2W6RCKhO5toC@casper.infradead.org>
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <Yb+gId/gXocrlJYD@casper.infradead.org>
 <CAHk-=wiAzmB-jiHvF+EZ1-b0X3ts4LAYHaVhzpzXEjmC0X95eg@mail.gmail.com>
 <Yb+oi8fg1dJe1uBm@casper.infradead.org>
 <CAHk-=wgLLRT_KeM5Se1AxGcf-g5MkCS-JmPy169Rpdeky_YkXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLLRT_KeM5Se1AxGcf-g5MkCS-JmPy169Rpdeky_YkXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 19, 2021 at 01:53:36PM -0800, Linus Torvalds wrote:
> On Sun, Dec 19, 2021 at 1:48 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Yes, agreed, I was thinking that we could use "not mapped at all"
> > as an optimisation to avoid doing rmap walks.  eg __unmap_and_move().
> 
> So the thing is, it's a very dodgy optimization for a rather simple
> reason: what if somebody pages the page in?
> 
> So even "not mapped at all" is questionable.
> 
> You have to check that it's also not a swapcache page, and hold the
> page lock for that check, at the very least.
> 
> And by then, you're really in a very unusual situation - and my gut
> feel says not one worth optimizing for (because anon pages are
> _usually_ mapped at least once).

I'd like to get rid of ->mapcount for file pages too.  And those are
definitely never mapped in the majority of cases.
