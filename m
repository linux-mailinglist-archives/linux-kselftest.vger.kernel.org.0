Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A974789FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhLQLd7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235464AbhLQLd7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/7mUTo+iv3R8B8oSdwI4pdW6+nsiLEWXHYLzjN+rhg=;
        b=Vg8NjjABQtzo0/RSFWut12mEYfhQxExh0EhV1xhrqZjD5Rd/dv+C7gAT7zkgVRhMLuFOcY
        rU7ncKGG/EzlTHbPZHfnJj+NF9CJ1DHfhpoYOCxvZ2oNQOhcVIQUDCBCep9Fa1O5ir/dR3
        6RjR3hWHvNAdicAh8TWp5INzbN3PJ1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-2ztkeZRXPsGpaJ5xK1c3YQ-1; Fri, 17 Dec 2021 06:33:55 -0500
X-MC-Unique: 2ztkeZRXPsGpaJ5xK1c3YQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E2F91853026;
        Fri, 17 Dec 2021 11:33:52 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81FA58ACF7;
        Fri, 17 Dec 2021 11:33:45 +0000 (UTC)
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
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v1 05/11] mm: thp: allow for reading the THP mapcount atomically via a raw_seqlock_t
Date:   Fri, 17 Dec 2021 12:30:43 +0100
Message-Id: <20211217113049.23850-6-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, we are not able to read the mapcount of a THP atomically
without expensive locking, for example, if the THP is getting split
concurrently.

Also, we don't want mapcount readers to observe jitter on concurrent GUP
and unmapping like:
	2 -> 1 -> 2 -> 1
Instead, we want to avoid such jitter and want the mapcount of a THP to
move into one direction only instead.

The main challenge to avoid such jitter is PageDoubleMap. If the
compound_mapcount and the tail mapcounts move in the same direction,
there is no problem. However when the compound_mapcount is decreased and
reaches zero, the reader will see initially a decrease in the THP mapcount
that will then be followed by the PageDoubleMap being cleared and the
mapcount getting increased again. The act of clearing PageDoubleMap will
lead readers to overestimate the mapcount until all tail mapcounts (that
the PageDoubleMap flag kept artificially elevated) are finally released.

Introduce a raw_seqlock_t in the THP subpage at index 1 to allow reading
the THP mapcount atomically without grabbing the page lock, avoiding racing
with THP splitting or PageDoubleMap processing. For now, we only require
the seqlock for anonymous THP.

We use a PG_lock-based spinlock to synchronize the writer side. Note
that the PG_lock is located on the THP subpage at index 1, which is
unused so far.

To make especially page_mapcount() safe to be called from IRQ context, as
required by GUP via get_user_pages_fast_only() in the context of
GUP-triggered unsharing of shared anonymous pages soon, make sure the
reader side cannot deadlock if the writer side would be interrupted:
disable local interrupts on the writer side. Note that they are already
disabled during lock_page_memcg() in some configurations.

Fortunately, we do have as of now (mm/Kconfig)
	config TRANSPARENT_HUGEPAGE
		bool "Transparent Hugepage Support"
		depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
so the disabling of interrupts in our case in particular has no effect
on PREEMPT_RT, which is good.

We don't need this type of locking on the THP freeing path: Once the
compound_mapcount of an anonymous THP drops to 0, it won't suddenly
increase again, so PageDoubleMap cannot be cleared concurrently and
consequently the seqlock only needs to be taken if the PageDoubleMap
flag is found set.

Note: In the future, we could avoid disabling local interrupts on the
      writer side by providing alternative functions that can be called
      from IRQ context without deadlocking: These functions must not spin
      but instead have to signal that locking failed. OR maybe we'll find
      a way to just simplify that whole mapcount handling logic for
      anonymous THP, but for now none has been identified.
      Let's keep it simple for now.

This commit is based on prototype patches by Andrea.

Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reported-by: Hugh Dickins <hughd@google.com>
Fixes: c444eb564fb1 ("mm: thp: make the THP mapcount atomic against __split_huge_pmd_locked()")
Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/huge_mm.h  | 65 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h |  9 ++++++
 mm/huge_memory.c         | 56 +++++++++++++++++++++++-----------
 mm/rmap.c                | 40 +++++++++++++++----------
 mm/swapfile.c            | 35 +++++++++++++---------
 mm/util.c                | 17 +++++++----
 6 files changed, 170 insertions(+), 52 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f280f33ff223..44e02d47c65a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -318,6 +318,49 @@ static inline struct list_head *page_deferred_list(struct page *page)
 	return &page[2].deferred_list;
 }
 
+static inline void thp_mapcount_seqcount_init(struct page *page)
+{
+	raw_seqcount_init(&page[1].mapcount_seqcount);
+}
+
+static inline unsigned int thp_mapcount_read_begin(struct page *page)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	return raw_read_seqcount_begin(&page[1].mapcount_seqcount);
+}
+
+static inline bool thp_mapcount_read_retry(struct page *page,
+					   unsigned int seqcount)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	if (!raw_read_seqcount_retry(&page[1].mapcount_seqcount, seqcount))
+		return false;
+	cpu_relax();
+	return true;
+}
+
+static inline void thp_mapcount_lock(struct page *page,
+				     unsigned long *irq_flags)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	/*
+	 * Prevent deadlocks in thp_mapcount_read_begin() if it is called in IRQ
+	 * context.
+	 */
+	local_irq_save(*irq_flags);
+	bit_spin_lock(PG_locked, &page[1].flags);
+	raw_write_seqcount_begin(&page[1].mapcount_seqcount);
+}
+
+static inline void thp_mapcount_unlock(struct page *page,
+				       unsigned long irq_flags)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	raw_write_seqcount_end(&page[1].mapcount_seqcount);
+	bit_spin_unlock(PG_locked, &page[1].flags);
+	local_irq_restore(irq_flags);
+}
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
 #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
@@ -467,6 +510,28 @@ static inline bool thp_migration_supported(void)
 {
 	return false;
 }
+
+static inline unsigned int thp_mapcount_read_begin(struct page *page)
+{
+	return 0;
+}
+
+static inline bool thp_mapcount_read_retry(struct page *page,
+					   unsigned int seqcount)
+{
+	return false;
+}
+
+static inline void thp_mapcount_lock(struct page *page,
+				     unsigned long *irq_flags)
+{
+}
+
+static inline void thp_mapcount_unlock(struct page *page,
+				       unsigned long irq_flags)
+{
+}
+
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /**
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c3a6e6209600..a85a2a75d4ff 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -151,6 +151,15 @@ struct page {
 			unsigned char compound_order;
 			atomic_t compound_mapcount;
 			unsigned int compound_nr; /* 1 << compound_order */
+			/*
+			 * THP only: allow for atomic reading of the mapcount,
+			 * for example when we might be racing with a concurrent
+			 * THP split. Initialized for all THP but locking is
+			 * so far only required for anon THP where such races
+			 * apply. Write access is serialized via the
+			 * PG_locked-based spinlock in the first tail page.
+			 */
+			raw_seqcount_t mapcount_seqcount;
 		};
 		struct {	/* Second tail page of compound page */
 			unsigned long _compound_pad_1;	/* compound_head */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 826cabcad11a..1685821525e8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -527,6 +527,7 @@ void prep_transhuge_page(struct page *page)
 
 	INIT_LIST_HEAD(page_deferred_list(page));
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
+	thp_mapcount_seqcount_init(page);
 }
 
 bool is_transparent_hugepage(struct page *page)
@@ -1959,11 +1960,11 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long haddr, bool freeze)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long addr, irq_flags;
 	struct page *page;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
 	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
-	unsigned long addr;
 	int i;
 
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
@@ -2108,6 +2109,13 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		/* Sub-page mapcount accounting for above small mappings. */
 		int val = 1;
 
+		/*
+		 * lock_page_memcg() is taken before thp_mapcount_lock() in
+		 * page_remove_anon_compound_rmap(), respect the same locking
+		 * order.
+		 */
+		lock_page_memcg(page);
+		thp_mapcount_lock(page, &irq_flags);
 		/*
 		 * Set PG_double_map before dropping compound_mapcount to avoid
 		 * false-negative page_mapped().
@@ -2121,7 +2129,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		for (i = 0; i < HPAGE_PMD_NR; i++)
 			atomic_add(val, &page[i]._mapcount);
 
-		lock_page_memcg(page);
 		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
 			/* Last compound_mapcount is gone. */
 			__mod_lruvec_page_state(page, NR_ANON_THPS,
@@ -2132,6 +2139,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 					atomic_dec(&page[i]._mapcount);
 			}
 		}
+		thp_mapcount_unlock(page, irq_flags);
 		unlock_page_memcg(page);
 	}
 
@@ -2501,6 +2509,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 int total_mapcount(struct page *page)
 {
 	int i, compound, nr, ret;
+	unsigned int seqcount;
+	bool double_map;
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -2510,13 +2520,19 @@ int total_mapcount(struct page *page)
 		return head_compound_mapcount(page);
 
 	nr = compound_nr(page);
-	ret = compound = head_compound_mapcount(page);
-	for (i = 0; i < nr; i++)
-		ret += atomic_read(&page[i]._mapcount) + 1;
+
+	do {
+		seqcount = thp_mapcount_read_begin(page);
+		ret = compound = head_compound_mapcount(page);
+		for (i = 0; i < nr; i++)
+			ret += atomic_read(&page[i]._mapcount) + 1;
+		double_map = PageDoubleMap(page);
+	} while (thp_mapcount_read_retry(page, seqcount));
+
 	/* File pages has compound_mapcount included in _mapcount */
 	if (!PageAnon(page))
 		return ret - compound * nr;
-	if (PageDoubleMap(page))
+	if (double_map)
 		ret -= nr;
 	return ret;
 }
@@ -2548,6 +2564,7 @@ int total_mapcount(struct page *page)
 int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
 {
 	int i, ret, _total_mapcount, mapcount;
+	unsigned int seqcount;
 
 	/* hugetlbfs shouldn't call it */
 	VM_BUG_ON_PAGE(PageHuge(page), page);
@@ -2561,17 +2578,22 @@ int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
 
 	page = compound_head(page);
 
-	_total_mapcount = ret = 0;
-	for (i = 0; i < thp_nr_pages(page); i++) {
-		mapcount = atomic_read(&page[i]._mapcount) + 1;
-		ret = max(ret, mapcount);
-		_total_mapcount += mapcount;
-	}
-	if (PageDoubleMap(page)) {
-		ret -= 1;
-		_total_mapcount -= thp_nr_pages(page);
-	}
-	mapcount = compound_mapcount(page);
+	do {
+		_total_mapcount = ret = 0;
+
+		seqcount = thp_mapcount_read_begin(page);
+		for (i = 0; i < thp_nr_pages(page); i++) {
+			mapcount = atomic_read(&page[i]._mapcount) + 1;
+			ret = max(ret, mapcount);
+			_total_mapcount += mapcount;
+		}
+		if (PageDoubleMap(page)) {
+			ret -= 1;
+			_total_mapcount -= thp_nr_pages(page);
+		}
+		mapcount = compound_mapcount(page);
+	} while (thp_mapcount_read_retry(page, seqcount));
+
 	ret += mapcount;
 	_total_mapcount += mapcount;
 	if (total_mapcount)
diff --git a/mm/rmap.c b/mm/rmap.c
index 163ac4e6bcee..0218052586e7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1294,6 +1294,7 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 
 static void page_remove_anon_compound_rmap(struct page *page)
 {
+	unsigned long irq_flags;
 	int i, nr;
 
 	if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
@@ -1308,23 +1309,30 @@ static void page_remove_anon_compound_rmap(struct page *page)
 
 	__mod_lruvec_page_state(page, NR_ANON_THPS, -thp_nr_pages(page));
 
-	if (TestClearPageDoubleMap(page)) {
-		/*
-		 * Subpages can be mapped with PTEs too. Check how many of
-		 * them are still mapped.
-		 */
-		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
-			if (atomic_add_negative(-1, &page[i]._mapcount))
-				nr++;
-		}
+	if (PageDoubleMap(page)) {
+		thp_mapcount_lock(page, &irq_flags);
+		if (TestClearPageDoubleMap(page)) {
+			/*
+			 * Subpages can be mapped with PTEs too. Check how many
+			 * of them are still mapped.
+			 */
+			for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
+				if (atomic_add_negative(-1, &page[i]._mapcount))
+					nr++;
+			}
+			thp_mapcount_unlock(page, irq_flags);
 
-		/*
-		 * Queue the page for deferred split if at least one small
-		 * page of the compound page is unmapped, but at least one
-		 * small page is still mapped.
-		 */
-		if (nr && nr < thp_nr_pages(page))
-			deferred_split_huge_page(page);
+			/*
+			 * Queue the page for deferred split if at least one
+			 * small page of the compound page is unmapped, but at
+			 * least one small page is still mapped.
+			 */
+			if (nr && nr < thp_nr_pages(page))
+				deferred_split_huge_page(page);
+		} else {
+			thp_mapcount_unlock(page, irq_flags);
+			nr = thp_nr_pages(page);
+		}
 	} else {
 		nr = thp_nr_pages(page);
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e59e08ef46e1..82aeb927a7ba 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1610,6 +1610,7 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 	struct swap_cluster_info *ci = NULL;
 	unsigned char *map = NULL;
 	int mapcount, swapcount = 0;
+	unsigned int seqcount;
 
 	/* hugetlbfs shouldn't call it */
 	VM_BUG_ON_PAGE(PageHuge(page), page);
@@ -1625,7 +1626,6 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 
 	page = compound_head(page);
 
-	_total_mapcount = _total_swapcount = map_swapcount = 0;
 	if (PageSwapCache(page)) {
 		swp_entry_t entry;
 
@@ -1638,21 +1638,28 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 	}
 	if (map)
 		ci = lock_cluster(si, offset);
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
-		mapcount = atomic_read(&page[i]._mapcount) + 1;
-		_total_mapcount += mapcount;
-		if (map) {
-			swapcount = swap_count(map[offset + i]);
-			_total_swapcount += swapcount;
+
+	do {
+		_total_mapcount = _total_swapcount = map_swapcount = 0;
+
+		seqcount = thp_mapcount_read_begin(page);
+		for (i = 0; i < HPAGE_PMD_NR; i++) {
+			mapcount = atomic_read(&page[i]._mapcount) + 1;
+			_total_mapcount += mapcount;
+			if (map) {
+				swapcount = swap_count(map[offset + i]);
+				_total_swapcount += swapcount;
+			}
+			map_swapcount = max(map_swapcount, mapcount + swapcount);
 		}
-		map_swapcount = max(map_swapcount, mapcount + swapcount);
-	}
+		if (PageDoubleMap(page)) {
+			map_swapcount -= 1;
+			_total_mapcount -= HPAGE_PMD_NR;
+		}
+		mapcount = compound_mapcount(page);
+	} while (thp_mapcount_read_retry(page, seqcount));
+
 	unlock_cluster(ci);
-	if (PageDoubleMap(page)) {
-		map_swapcount -= 1;
-		_total_mapcount -= HPAGE_PMD_NR;
-	}
-	mapcount = compound_mapcount(page);
 	map_swapcount += mapcount;
 	_total_mapcount += mapcount;
 	if (total_mapcount)
diff --git a/mm/util.c b/mm/util.c
index 3239e75c148d..f4b81c794da1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -730,6 +730,8 @@ EXPORT_SYMBOL(folio_mapping);
 /* Slow path of page_mapcount() for compound pages */
 int __page_mapcount(struct page *page)
 {
+	struct page *head_page;
+	unsigned int seqcount;
 	int ret;
 
 	if (PageHuge(page))
@@ -741,11 +743,16 @@ int __page_mapcount(struct page *page)
 	if (!PageAnon(page))
 		return atomic_read(&page->_mapcount) + 1;
 
-	ret = atomic_read(&page->_mapcount) + 1;
-	page = compound_head(page);
-	ret += head_compound_mapcount(page);
-	if (PageDoubleMap(page))
-		ret--;
+	/* The mapcount_seqlock is so far only required for anonymous THP. */
+	head_page = compound_head(page);
+	do {
+		seqcount = thp_mapcount_read_begin(head_page);
+		ret = atomic_read(&page->_mapcount) + 1;
+		ret += head_compound_mapcount(head_page);
+		if (PageDoubleMap(head_page))
+			ret--;
+	} while (thp_mapcount_read_retry(head_page, seqcount));
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__page_mapcount);
-- 
2.31.1

