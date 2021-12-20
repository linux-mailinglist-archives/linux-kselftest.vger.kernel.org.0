Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC23947B2F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 19:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbhLTShp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 13:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhLTShp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 13:37:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EAAC061574;
        Mon, 20 Dec 2021 10:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KcO4IBmwxvdifksiMXcdegNdDzs945uvstWYbC8eA0g=; b=ij4AEN7LQqiZDu0d35Tcr4w5/q
        WchZs4VQLujjfAk69rlOKg1iqYlr86sP3b+B6IFv13081bZ6oE6FkH/7DANhNp/f4SMCnYNL3cVmQ
        rExee7sEEU2lW1Jq/jc7GidImzRwQ2YM6k5vvM/ZBA0/4QDMjPG/kChu9Wk/yw+UblEhDmc13+obz
        lSoHPqEfKuRTDqlq3yMQNzFWWLetiSKtd3ajD8+dTKBOjHytttQDuxb9tyTOgdyp6cymHxgutMGRd
        jkJC5breq9JdNO/whz9yb0b66DpvXzjhSgXllJMlarMsQ3t7vYubFitT2iWG9ZBMTm5z4oSSQPXbp
        tKC6/xjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzNXO-001pGj-VB; Mon, 20 Dec 2021 18:37:31 +0000
Date:   Mon, 20 Dec 2021 18:37:30 +0000
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
Message-ID: <YcDNaoGcGS6ypucg@casper.infradead.org>
References: <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <Yb+gId/gXocrlJYD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yb+gId/gXocrlJYD@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 19, 2021 at 09:12:01PM +0000, Matthew Wilcox wrote:
> Can we get rid of ->mapcount altogether?  Three states:

This might be a step in the right direction?

From f723fb7cf2519428eee75e9e779907f80258f302 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Mon, 20 Dec 2021 13:24:04 -0500
Subject: [PATCH] mm: reuse_swap_page() no longer needs to return map_swapcount

All callers of reuse_swap_page() currently pass NULL, indicating that
they don't use the painstakingly calculated map_swapcount.  That lets
us further remove it from page_trans_huge_map_swapcount() and
page_trans_huge_mapcount().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
I don't know if this is a helpful patch to add at this point or
whether it will get in the way of David's much more extensive work.

 include/linux/mm.h   | 10 +++-------
 include/linux/swap.h |  6 +++---
 mm/huge_memory.c     | 32 +++++++++++---------------------
 mm/khugepaged.c      |  2 +-
 mm/memory.c          |  2 +-
 mm/swapfile.c        | 33 +++++++++++----------------------
 6 files changed, 30 insertions(+), 55 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..286eb4155c80 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -840,19 +840,15 @@ static inline int page_mapcount(struct page *page)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int total_mapcount(struct page *page);
-int page_trans_huge_mapcount(struct page *page, int *total_mapcount);
+int page_trans_huge_mapcount(struct page *page);
 #else
 static inline int total_mapcount(struct page *page)
 {
 	return page_mapcount(page);
 }
-static inline int page_trans_huge_mapcount(struct page *page,
-					   int *total_mapcount)
+static inline int page_trans_huge_mapcount(struct page *page)
 {
-	int mapcount = page_mapcount(page);
-	if (total_mapcount)
-		*total_mapcount = mapcount;
-	return mapcount;
+	return page_mapcount(page);
 }
 #endif
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1ea44b31f19..1d38d9475c4d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -514,7 +514,7 @@ extern int __swp_swapcount(swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
 extern struct swap_info_struct *page_swap_info(struct page *);
 extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
-extern bool reuse_swap_page(struct page *, int *);
+extern bool reuse_swap_page(struct page *);
 extern int try_to_free_swap(struct page *);
 struct backing_dev_info;
 extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
@@ -680,8 +680,8 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
-#define reuse_swap_page(page, total_map_swapcount) \
-	(page_trans_huge_mapcount(page, total_map_swapcount) == 1)
+#define reuse_swap_page(page) \
+	(page_trans_huge_mapcount(page) == 1)
 
 static inline int try_to_free_swap(struct page *page)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..6ed86a8f6a5b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1322,7 +1322,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	 * We can only reuse the page if nobody else maps the huge page or it's
 	 * part.
 	 */
-	if (reuse_swap_page(page, NULL)) {
+	if (reuse_swap_page(page)) {
 		pmd_t entry;
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
@@ -2542,38 +2542,28 @@ int total_mapcount(struct page *page)
  * need full accuracy to avoid breaking page pinning, because
  * page_trans_huge_mapcount() is slower than page_mapcount().
  */
-int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
+int page_trans_huge_mapcount(struct page *page)
 {
-	int i, ret, _total_mapcount, mapcount;
+	int i, ret;
 
 	/* hugetlbfs shouldn't call it */
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 
-	if (likely(!PageTransCompound(page))) {
-		mapcount = atomic_read(&page->_mapcount) + 1;
-		if (total_mapcount)
-			*total_mapcount = mapcount;
-		return mapcount;
-	}
+	if (likely(!PageTransCompound(page)))
+		return atomic_read(&page->_mapcount) + 1;
 
 	page = compound_head(page);
 
-	_total_mapcount = ret = 0;
+	ret = 0;
 	for (i = 0; i < thp_nr_pages(page); i++) {
-		mapcount = atomic_read(&page[i]._mapcount) + 1;
+		int mapcount = atomic_read(&page[i]._mapcount) + 1;
 		ret = max(ret, mapcount);
-		_total_mapcount += mapcount;
 	}
-	if (PageDoubleMap(page)) {
+
+	if (PageDoubleMap(page))
 		ret -= 1;
-		_total_mapcount -= thp_nr_pages(page);
-	}
-	mapcount = compound_mapcount(page);
-	ret += mapcount;
-	_total_mapcount += mapcount;
-	if (total_mapcount)
-		*total_mapcount = _total_mapcount;
-	return ret;
+
+	return ret + compound_mapcount(page);
 }
 
 /* Racy check whether the huge page can be split */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e99101162f1a..11794bdf513a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -681,7 +681,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		if (!pte_write(pteval) && PageSwapCache(page) &&
-				!reuse_swap_page(page, NULL)) {
+				!reuse_swap_page(page)) {
 			/*
 			 * Page is in the swap cache and cannot be re-used.
 			 * It cannot be collapsed into a THP.
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..dd85fd07cb24 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3626,7 +3626,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
 	pte = mk_pte(page, vma->vm_page_prot);
-	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
+	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 		vmf->flags &= ~FAULT_FLAG_WRITE;
 		ret |= VM_FAULT_WRITE;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e59e08ef46e1..bc0810c3b2a5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1601,31 +1601,30 @@ static bool page_swapped(struct page *page)
 	return false;
 }
 
-static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
+static int page_trans_huge_map_swapcount(struct page *page,
 					 int *total_swapcount)
 {
-	int i, map_swapcount, _total_mapcount, _total_swapcount;
+	int i, map_swapcount, _total_swapcount;
 	unsigned long offset = 0;
 	struct swap_info_struct *si;
 	struct swap_cluster_info *ci = NULL;
 	unsigned char *map = NULL;
-	int mapcount, swapcount = 0;
+	int swapcount = 0;
 
 	/* hugetlbfs shouldn't call it */
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 
 	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!PageTransCompound(page))) {
-		mapcount = page_trans_huge_mapcount(page, total_mapcount);
 		if (PageSwapCache(page))
 			swapcount = page_swapcount(page);
 		if (total_swapcount)
 			*total_swapcount = swapcount;
-		return mapcount + swapcount;
+		return swapcount + page_trans_huge_mapcount(page);
 	}
 
 	page = compound_head(page);
 
-	_total_mapcount = _total_swapcount = map_swapcount = 0;
+	_total_swapcount = map_swapcount = 0;
 	if (PageSwapCache(page)) {
 		swp_entry_t entry;
 
@@ -1639,8 +1638,7 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 	if (map)
 		ci = lock_cluster(si, offset);
 	for (i = 0; i < HPAGE_PMD_NR; i++) {
-		mapcount = atomic_read(&page[i]._mapcount) + 1;
-		_total_mapcount += mapcount;
+		int mapcount = atomic_read(&page[i]._mapcount) + 1;
 		if (map) {
 			swapcount = swap_count(map[offset + i]);
 			_total_swapcount += swapcount;
@@ -1648,15 +1646,9 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 		map_swapcount = max(map_swapcount, mapcount + swapcount);
 	}
 	unlock_cluster(ci);
-	if (PageDoubleMap(page)) {
+	if (PageDoubleMap(page))
 		map_swapcount -= 1;
-		_total_mapcount -= HPAGE_PMD_NR;
-	}
-	mapcount = compound_mapcount(page);
-	map_swapcount += mapcount;
-	_total_mapcount += mapcount;
-	if (total_mapcount)
-		*total_mapcount = _total_mapcount;
+	map_swapcount += compound_mapcount(page);
 	if (total_swapcount)
 		*total_swapcount = _total_swapcount;
 
@@ -1673,17 +1665,14 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
  * reuse_swap_page() returns false, but it may be always overwritten
  * (see the other implementation for CONFIG_SWAP=n).
  */
-bool reuse_swap_page(struct page *page, int *total_map_swapcount)
+bool reuse_swap_page(struct page *page)
 {
-	int count, total_mapcount, total_swapcount;
+	int count, total_swapcount;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	if (unlikely(PageKsm(page)))
 		return false;
-	count = page_trans_huge_map_swapcount(page, &total_mapcount,
-					      &total_swapcount);
-	if (total_map_swapcount)
-		*total_map_swapcount = total_mapcount + total_swapcount;
+	count = page_trans_huge_map_swapcount(page, &total_swapcount);
 	if (count == 1 && PageSwapCache(page) &&
 	    (likely(!PageTransCompound(page)) ||
 	     /* The remaining swap count will be freed soon */
-- 
2.33.0

