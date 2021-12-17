Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CDA478A07
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhLQLeU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:34:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235514AbhLQLeS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzUv6yJDwt+7H5HJzvGctMAG29y8XOFpvzAZtyudpbM=;
        b=HLbFVAnJaNtv3/8Vt2w6uUhQSesGyIpGpw9hh7FHwUudWFyQChlWxsESvpbu1/UbNj1vAs
        ww4kQN+649gs4gIzre+hLyKNjQofP03GqaewhFBWWURorQ3k2fvfHYDw6R58YHow3QSmHf
        0Odre/Dv4RuUmDA3m8LC1/iSTQFHFU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-9MIwY5ONN1m72xO_4dQ4yg-1; Fri, 17 Dec 2021 06:34:14 -0500
X-MC-Unique: 9MIwY5ONN1m72xO_4dQ4yg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEF7A1853020;
        Fri, 17 Dec 2021 11:34:11 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8DB68ACF7;
        Fri, 17 Dec 2021 11:34:05 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 08/11] mm: hugetlb: support GUP-triggered unsharing via FAULT_FLAG_UNSHARE
Date:   Fri, 17 Dec 2021 12:30:46 +0100
Message-Id: <20211217113049.23850-9-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's support FAULT_FLAG_UNSHARE to implement GUP-triggered unsharing,
preparing for its use in the GUP paths when there is need to unshare a
shared anonymous hugetlb page.

We'll make use of it next by setting FAULT_FLAG_UNSHARE in case we
detect that unsharing is necessary.

This commit is based on a prototype patch by Andrea.

Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 86 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 23 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1baa198519a..5f2863b046ef 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5130,14 +5130,15 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 /*
- * Hugetlb_cow() should be called with page lock of the original hugepage held.
+ * __wp_hugetlb() should be called with page lock of the original hugepage held.
  * Called with hugetlb_fault_mutex_table held and pte_page locked so we
  * cannot race with other handlers or page migration.
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
-static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
-		       unsigned long address, pte_t *ptep,
-		       struct page *pagecache_page, spinlock_t *ptl)
+static __always_inline vm_fault_t
+__wp_hugetlb(struct mm_struct *mm, struct vm_area_struct *vma,
+	     unsigned long address, pte_t *ptep, struct page *pagecache_page,
+	     spinlock_t *ptl, bool unshare)
 {
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
@@ -5151,11 +5152,21 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	old_page = pte_page(pte);
 
 retry_avoidcopy:
-	/* If no-one else is actually using this page, avoid the copy
-	 * and just make the page writable */
-	if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
-		page_move_anon_rmap(old_page, vma);
-		set_huge_ptep_writable(vma, haddr, ptep);
+	if (!unshare) {
+		/*
+		 * If no-one else is actually using this page, avoid the copy
+		 * and just make the page writable.
+		 */
+		if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
+			page_move_anon_rmap(old_page, vma);
+			set_huge_ptep_writable(vma, haddr, ptep);
+			return 0;
+		}
+	} else if (!PageAnon(old_page) || page_mapcount(old_page) == 1) {
+		/*
+		 * GUP-triggered unsharing only applies to shared anonymous
+		 * pages. If that does no longer apply, there is nothing to do.
+		 */
 		return 0;
 	}
 
@@ -5256,11 +5267,11 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
 		ClearHPageRestoreReserve(new_page);
 
-		/* Break COW */
+		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
 		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, new_page, 1));
+				make_huge_pte(vma, new_page, !unshare));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
 		SetHPageMigratable(new_page);
@@ -5270,7 +5281,10 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
 out_release_all:
-	/* No restore in case of successful pagetable update (Break COW) */
+	/*
+	 * No restore in case of successful pagetable update (Break COW or
+	 * unshare)
+	 */
 	if (new_page != old_page)
 		restore_reserve_on_error(h, vma, haddr, new_page);
 	put_page(new_page);
@@ -5281,6 +5295,23 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+static vm_fault_t
+wp_hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
+	       unsigned long address, pte_t *ptep, struct page *pagecache_page,
+	       spinlock_t *ptl)
+{
+	return __wp_hugetlb(mm, vma, address, ptep, pagecache_page, ptl,
+			    false);
+}
+
+static vm_fault_t
+wp_hugetlb_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
+		   unsigned long address, pte_t *ptep,
+		   struct page *pagecache_page, spinlock_t *ptl)
+{
+	return __wp_hugetlb(mm, vma, address, ptep, pagecache_page, ptl, true);
+}
+
 /* Return the pagecache page at a given address within a VMA */
 static struct page *hugetlbfs_pagecache_page(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
@@ -5393,7 +5424,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	/*
 	 * Currently, we are forced to kill the process in the event the
 	 * original mapper has unmapped pages from the child due to a failed
-	 * COW. Warn that such a situation has occurred as it may not be obvious
+	 * COW/unsharing. Warn that such a situation has occurred as it may not
+	 * be obvious.
 	 */
 	if (is_vma_resv_set(vma, HPAGE_RESV_UNMAPPED)) {
 		pr_warn_ratelimited("PID %d killed due to inadequate hugepage pool\n",
@@ -5519,7 +5551,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_cow(mm, vma, address, ptep, page, ptl);
+		ret = wp_hugetlb_cow(mm, vma, address, ptep, page, ptl);
 	}
 
 	spin_unlock(ptl);
@@ -5649,14 +5681,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_mutex;
 
 	/*
-	 * If we are going to COW the mapping later, we examine the pending
-	 * reservations for this page now. This will ensure that any
+	 * If we are going to COW/unshare the mapping later, we examine the
+	 * pending reservations for this page now. This will ensure that any
 	 * allocations necessary to record that reservation occur outside the
 	 * spinlock. For private mappings, we also lookup the pagecache
 	 * page now as it is used to determine if a reservation has been
 	 * consumed.
 	 */
-	if ((flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
+	    !huge_pte_write(entry)) {
 		if (vma_needs_reservation(h, vma, haddr) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
@@ -5671,14 +5704,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 
-	/* Check for a racing update before calling hugetlb_cow */
+	/*
+	 * Check for a racing update before calling wp_hugetlb_cow /
+	 * wp_hugetlb_unshare
+	 */
 	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
 	/*
-	 * hugetlb_cow() requires page locks of pte_page(entry) and
-	 * pagecache_page, so here we need take the former one
-	 * when page != pagecache_page or !pagecache_page.
+	 * wp_hugetlb_cow()/wp_hugetlb_unshare() requires page locks of
+	 * pte_page(entry) and pagecache_page, so here we need take the former
+	 * one when page != pagecache_page or !pagecache_page.
 	 */
 	page = pte_page(entry);
 	if (page != pagecache_page)
@@ -5691,11 +5727,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & FAULT_FLAG_WRITE) {
 		if (!huge_pte_write(entry)) {
-			ret = hugetlb_cow(mm, vma, address, ptep,
-					  pagecache_page, ptl);
+			ret = wp_hugetlb_cow(mm, vma, address, ptep,
+					     pagecache_page, ptl);
 			goto out_put_page;
 		}
 		entry = huge_pte_mkdirty(entry);
+	} else if (flags & FAULT_FLAG_UNSHARE && !huge_pte_write(entry)) {
+		ret = wp_hugetlb_unshare(mm, vma, address, ptep, pagecache_page,
+					 ptl);
+		goto out_put_page;
 	}
 	entry = pte_mkyoung(entry);
 	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
-- 
2.31.1

