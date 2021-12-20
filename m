Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E118D47B33E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 19:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhLTSxG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 13:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbhLTSxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 13:53:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4BC061574;
        Mon, 20 Dec 2021 10:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kj2QTGmFgV7Djw7LNhrL5ROHsmbIWJF49HXpYPf8/UU=; b=G4W2D+AlLdNiv8olc5agr0Mi+h
        4GfDiEqN4qlk9+PrawUwlcprCA++0YwRh7IkFF33ev1js3rxkRRs5EfJO1Jy51/cd01bRVDGPvjwb
        c1RmwtI/BekNVLw3rqWV31vOCyGklOEVfVNiI8ZnBDNj6xWAHoSW3q/oRxOX7eC6dt5IZicxOSWAA
        /mJZunkex8i0f4L0kJAa5NAX2OvM5np6uCth6gukXAxux9NprSalVJHYB6XHGxBH4QUuf26j/3oeq
        1VwjhLn5rUVmgwqXZT8mAQ0MGDZX/RpLVFkOGxx4wUJGzxxJsjRHWI1m4YaH0Mvd0284zlXSbPbpc
        zfTlnE1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzNmN-001psh-7z; Mon, 20 Dec 2021 18:52:59 +0000
Date:   Mon, 20 Dec 2021 18:52:59 +0000
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
Message-ID: <YcDRC7e0fNAMYi3m@casper.infradead.org>
References: <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <Yb+gId/gXocrlJYD@casper.infradead.org>
 <YcDNaoGcGS6ypucg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcDNaoGcGS6ypucg@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 20, 2021 at 06:37:30PM +0000, Matthew Wilcox wrote:
> +++ b/mm/memory.c
> @@ -3626,7 +3626,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
>  	pte = mk_pte(page, vma->vm_page_prot);
> -	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
> +	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page)) {
>  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>  		vmf->flags &= ~FAULT_FLAG_WRITE;
>  		ret |= VM_FAULT_WRITE;
[...]
> @@ -1673,17 +1665,14 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
>   * reuse_swap_page() returns false, but it may be always overwritten
>   * (see the other implementation for CONFIG_SWAP=n).
>   */
> -bool reuse_swap_page(struct page *page, int *total_map_swapcount)
> +bool reuse_swap_page(struct page *page)
>  {
> -	int count, total_mapcount, total_swapcount;
> +	int count, total_swapcount;
>  
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  	if (unlikely(PageKsm(page)))
>  		return false;
> -	count = page_trans_huge_map_swapcount(page, &total_mapcount,
> -					      &total_swapcount);
> -	if (total_map_swapcount)
> -		*total_map_swapcount = total_mapcount + total_swapcount;
> +	count = page_trans_huge_map_swapcount(page, &total_swapcount);
>  	if (count == 1 && PageSwapCache(page) &&
>  	    (likely(!PageTransCompound(page)) ||
>  	     /* The remaining swap count will be freed soon */

It makes me wonder if reuse_swap_page() can also be based on refcount
instead of mapcount?
