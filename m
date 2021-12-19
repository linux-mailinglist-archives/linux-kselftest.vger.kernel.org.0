Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7347A068
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhLSLag (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 06:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbhLSLaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 06:30:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3AAC061574;
        Sun, 19 Dec 2021 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+xLGuwkGLHj6F7qVwSYYRQuCk2pKTFB8i/Od87i7OI4=; b=gRcXsixJbfh9FauWZ461228HXj
        eiOUlnI/kN8lAHWcRfPWIUUcbKLX9gTpfvnLUaEH547R3d7CTdwspdKQIy578WckdditrK3ydgd7E
        wiCwBRF9jdFOnsULc3pUf6lu7RDGR4hyve5eS5DrjWqQ7gqRJk7diGoIjV69tHlPqEJClfZt0M9cX
        5zyzzcUCqzi9qmvXMcwBIJv/6fqkvbXqPdRPE7cvff0aILtksT5/gtjBegOXuz1BYlUEbFCQDPBWV
        m03FUkC2RC6un46QqBCrJhN4SIxSCcIXD9QIs5i5qkPNUxKMBH1E+y1Zv7iAaBkPfS4BT82RAv9Qq
        ilFAdGrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myuOT-000hbL-AB; Sun, 19 Dec 2021 11:30:21 +0000
Date:   Sun, 19 Dec 2021 11:30:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <Yb8XzTRX8TZOYIQ/@casper.infradead.org>
References: <20211218030509.GA1432915@nvidia.com>
 <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
 <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <341cf567-468e-b5cf-6813-b26c49e851b5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <341cf567-468e-b5cf-6813-b26c49e851b5@nvidia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 19, 2021 at 12:01:59AM -0800, John Hubbard wrote:
> On 12/18/21 22:02, Nadav Amit wrote:
> > I found my old messy code for the software-PTE thing.
> > 
> > I see that eventually I decided to hold a pointer to the “extra PTEs”
> > of each page in the PMD-page-struct. [ I also implemented the 2-adjacent
> > pages approach but this code is long gone. ]
>
> a) The PMD-page-struct approach won't help as much, because (assuming
> that we're using it in an attempt to get a true, perfect pin count), you
> are combining the pin counts of a PMD's worth of pages. OTOH...maybe
> that actually *is* OK, assuming you don't overflow--except that you can
> only answer the "is it dma-pinned?" question at a PMD level. That's a
> contradiction of your stated desire above to have very granular control.
> 
> Also, because of not having bit 0 available in page._pt_pad_1, I think
> the count would have to be implemented as adding and subtracting 2,
> instead of 1 (in order to keep the value even), further reducing the
> counter range.

I think you misunderstood Nadav's approach.  He's talking about making
an extra side-allocation per PMD if you're using uffd, and storing
extra information in it.  I think it's a worthwile approach.
