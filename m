Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF147B49D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 22:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhLTVCO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 16:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhLTVCN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 16:02:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CACEC061574;
        Mon, 20 Dec 2021 13:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/7i/EyiBffh3uFhRPiI1lN3v+SNq4maU6QWoZIbFIf8=; b=KOKPu0fJgXqoZgD/h9NDuD9qAw
        8mD9YrV7i0OysQiwRdzwJciSXi60cSTpkWtleOU/8fKUXFBN1hs45AbYoKWYsWGBa4hUZDymm21GV
        ibcIggcK8oG7MtV7Nd/ZI6qZoFM9PACLtu2BsJ6o/ppvfEbwThbLy0/9n3g6VFsApz0Lgeu1HdLgK
        ScYOuIsf8BYNZErNz5R4gYcH5JX6bpNEqzJ3UqO3ef/BNtcbIZpVYuIwOZiJ5S7GkloC7hm0ZFWaQ
        DvefRV2jUkplhspfvRxdL3/WcpCrwXwo9y75569myXpkbyu8bVw9QRW8cDAZ4az0zo0fBMxhCDG5Q
        5nns1S6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzPnI-001ulY-GV; Mon, 20 Dec 2021 21:02:04 +0000
Date:   Mon, 20 Dec 2021 21:02:04 +0000
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
Message-ID: <YcDvTMUF3XWKWgSW@casper.infradead.org>
References: <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <Yb+gId/gXocrlJYD@casper.infradead.org>
 <YcDNaoGcGS6ypucg@casper.infradead.org>
 <CAHk-=wj+HbN0Ai+M2ABBvWnNKd2+J97kYPOsjwJC6o9xRF9jHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+HbN0Ai+M2ABBvWnNKd2+J97kYPOsjwJC6o9xRF9jHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 20, 2021 at 11:15:14AM -0800, Linus Torvalds wrote:
> Well, that patch seems to be a no-op removal of dead code, so absolutely yes.
> 
> That said, I think it would be good to split it up. I looked at that
> patch and went "is that really a no-op" to the point of recreating it.
> 
> I think it would be good to make it multiple patches that are each
> individally trivial. IOW, start with
> 
>  (1) remove second argument to reuse_swap_page() that is always NULL,
> without making any other changes
> 
>  (2) that now made 'total_mapcount' unused in reuse_swap_page(),
> remove it as an argument from page_trans_huge_map_swapcount()
> 
>  (3) that now made 'total_mapcount' unused in
> page_trans_huge_mapcount(), remove it as an argument there too.

Hah, that was actually how I did it originally (without actually
committing at each step, and with a few "Oh, hang on, now we can avoid
calculating this too" stops and restarts along the way), but I thought
it all hung together logically as a single change.  It's hard to see
things from the other person's perspective at times.
