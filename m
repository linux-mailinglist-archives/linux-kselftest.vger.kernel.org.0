Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077EE25B283
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgIBRA5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 13:00:57 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10775 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgIBQ6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4fcebc0002>; Wed, 02 Sep 2020 09:56:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 09:58:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 02 Sep 2020 09:58:36 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 16:58:36 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Sep 2020 16:58:35 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4fcf3b0006>; Wed, 02 Sep 2020 09:58:35 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 3/7] mm: support THP migration to device private memory
Date:   Wed, 2 Sep 2020 09:58:26 -0700
Message-ID: <20200902165830.5367-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200902165830.5367-1-rcampbell@nvidia.com>
References: <20200902165830.5367-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599065788; bh=ygDexMJzjJUfxkuN3WsSz2/z2WzOjqcUxwUaOMlHt20=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=F+Hpezd9e18vYjA49QVZ0fYmYWZ2Vvmj6As5qakbW4Dt4nIfFPnXTuEnhOL5jouZ1
         hqT7my5HpXaFzJUYZRN1X5ilB0SBaxcY8etckRtAzVkmOqW4zE9bofv8IsJ/YeSghR
         226YAUFjEnJ1shFVjVKj3oOnxNL9qL6hG6A/QjqpmZQmEfdKUS0au2RtV3Q5QAEE0r
         Qx1gupTB9yd6PNgafnHfLKcC2Qt/RJk0NaRCMq7o+n5slQLtYZU42Su/d6CgYMlvcS
         4W7WsJr1lFcL2pcrQ89+LLX7t0ra/lX5Um5NHsJuCZKBmJLAKk/uWotcF01SLkQNwj
         4ZZI071urluRw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support transparent huge page migration to ZONE_DEVICE private memory.
A new selection flag (MIGRATE_VMA_SELECT_COMPOUND) is added to request
THP migration. Otherwise, THPs are split when filling in the source PFN
array. A new flag (MIGRATE_PFN_COMPOUND) is added to the source PFN array
to indicate a huge page can be migrated. If the device driver can allocate
a huge page, it sets the MIGRATE_PFN_COMPOUND flag in the destination PFN
array. migrate_vma_pages() will fallback to PAGE_SIZE pages if
MIGRATE_PFN_COMPOUND is not set in both source and destination arrays.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/huge_mm.h  |   7 +
 include/linux/memremap.h |   9 +
 include/linux/migrate.h  |   2 +
 mm/huge_memory.c         | 113 ++++++++---
 mm/memory.c              |  10 +-
 mm/migrate.c             | 413 ++++++++++++++++++++++++++++++++-------
 mm/rmap.c                |   2 +-
 7 files changed, 459 insertions(+), 97 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 8a8bc46a2432..87b42c81dedc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -192,6 +192,8 @@ bool is_transparent_hugepage(struct page *page);
=20
 bool can_split_huge_page(struct page *page, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
+int split_migrating_huge_page(struct vm_area_struct *vma, pmd_t *pmd,
+			      unsigned long address, struct page *page);
 static inline int split_huge_page(struct page *page)
 {
 	return split_huge_page_to_list(page, NULL);
@@ -454,6 +456,11 @@ static inline bool is_huge_zero_page(struct page *page=
)
 	return false;
 }
=20
+static inline bool is_huge_zero_pmd(pmd_t pmd)
+{
+	return false;
+}
+
 static inline bool is_huge_zero_pud(pud_t pud)
 {
 	return false;
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 4e9c738f4b31..5175b1eaea01 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -88,6 +88,15 @@ struct dev_pagemap_ops {
 	 * the page back to a CPU accessible page.
 	 */
 	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
+
+	/*
+	 * Used for private (un-addressable) device memory only.
+	 * This is called when a compound device private page is split.
+	 * The driver uses this callback to set tail_page->pgmap and
+	 * tail_page->zone_device_data appropriately based on the head
+	 * page.
+	 */
+	void (*page_split)(struct page *head, struct page *tail_page);
 };
=20
 #define PGMAP_ALTMAP_VALID	(1 << 0)
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 0f8d1583fa8e..92179bf360d1 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -144,6 +144,7 @@ static inline int migrate_misplaced_transhuge_page(stru=
ct mm_struct *mm,
 #define MIGRATE_PFN_MIGRATE	(1UL << 1)
 #define MIGRATE_PFN_LOCKED	(1UL << 2)
 #define MIGRATE_PFN_WRITE	(1UL << 3)
+#define MIGRATE_PFN_COMPOUND	(1UL << 4)
 #define MIGRATE_PFN_SHIFT	6
=20
 static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
@@ -161,6 +162,7 @@ static inline unsigned long migrate_pfn(unsigned long p=
fn)
 enum migrate_vma_direction {
 	MIGRATE_VMA_SELECT_SYSTEM =3D 1 << 0,
 	MIGRATE_VMA_SELECT_DEVICE_PRIVATE =3D 1 << 1,
+	MIGRATE_VMA_SELECT_COMPOUND =3D 1 << 2,
 };
=20
 struct migrate_vma {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 606d712d9505..a8d48994481a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1644,23 +1644,35 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_=
area_struct *vma,
 	} else {
 		struct page *page =3D NULL;
 		int flush_needed =3D 1;
+		bool is_anon =3D false;
=20
 		if (pmd_present(orig_pmd)) {
 			page =3D pmd_page(orig_pmd);
+			is_anon =3D PageAnon(page);
 			page_remove_rmap(page, true);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
 		} else if (thp_migration_supported()) {
 			swp_entry_t entry;
=20
-			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
 			entry =3D pmd_to_swp_entry(orig_pmd);
-			page =3D pfn_to_page(swp_offset(entry));
+			if (is_device_private_entry(entry)) {
+				page =3D device_private_entry_to_page(entry);
+				is_anon =3D PageAnon(page);
+				page_remove_rmap(page, true);
+				VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
+				VM_BUG_ON_PAGE(!PageHead(page), page);
+				put_page(page);
+			} else {
+				VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
+				page =3D pfn_to_page(swp_offset(entry));
+				is_anon =3D PageAnon(page);
+			}
 			flush_needed =3D 0;
 		} else
 			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
=20
-		if (PageAnon(page)) {
+		if (is_anon) {
 			zap_deposited_table(tlb->mm, pmd);
 			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
 		} else {
@@ -2320,9 +2332,10 @@ static void remap_page(struct page *page)
 }
=20
 static void __split_huge_page_tail(struct page *head, int tail,
-		struct lruvec *lruvec, struct list_head *list)
+		struct lruvec *lruvec, struct list_head *list, bool remap)
 {
 	struct page *page_tail =3D head + tail;
+	int pin_count;
=20
 	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) !=3D -1, page_tail);
=20
@@ -2360,10 +2373,17 @@ static void __split_huge_page_tail(struct page *hea=
d, int tail,
 	 * After successful get_page_unless_zero() might follow put_page()
 	 * which needs correct compound_head().
 	 */
-	clear_compound_head(page_tail);
+	if (is_device_private_page(head)) {
+		/* Restore page_tail->pgmap and page_tail->zone_device_data. */
+		head->pgmap->ops->page_split(head, page_tail);
+		pin_count =3D 2;
+	} else {
+		clear_compound_head(page_tail);
+		pin_count =3D 1;
+	}
=20
 	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
+	page_ref_unfreeze(page_tail, pin_count + (!PageAnon(head) ||
 					  PageSwapCache(head)));
=20
 	if (page_is_young(head))
@@ -2378,11 +2398,12 @@ static void __split_huge_page_tail(struct page *hea=
d, int tail,
 	 * pages to show after the currently processed elements - e.g.
 	 * migrate_pages
 	 */
-	lru_add_page_tail(head, page_tail, lruvec, list);
+	if (remap)
+		lru_add_page_tail(head, page_tail, lruvec, list);
 }
=20
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned long flags)
+		pgoff_t end, unsigned long flags, bool remap)
 {
 	struct page *head =3D compound_head(page);
 	pg_data_t *pgdat =3D page_pgdat(head);
@@ -2405,7 +2426,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	}
=20
 	for (i =3D HPAGE_PMD_NR - 1; i >=3D 1; i--) {
-		__split_huge_page_tail(head, i, lruvec, list);
+		__split_huge_page_tail(head, i, lruvec, list, remap);
 		/* Some pages can be beyond i_size: drop them from page cache */
 		if (head[i].index >=3D end) {
 			ClearPageDirty(head + i);
@@ -2432,6 +2453,8 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 		if (PageSwapCache(head)) {
 			page_ref_add(head, 2);
 			xa_unlock(&swap_cache->i_pages);
+		} else if (is_device_private_page(head)) {
+			page_ref_add(head, 2);
 		} else {
 			page_ref_inc(head);
 		}
@@ -2443,6 +2466,9 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
=20
 	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
=20
+	if (!remap)
+		return;
+
 	remap_page(head);
=20
 	for (i =3D 0; i < HPAGE_PMD_NR; i++) {
@@ -2577,7 +2603,8 @@ bool can_split_huge_page(struct page *page, int *pext=
ra_pins)
  * Returns -EBUSY if the page is pinned or if anon_vma disappeared from un=
der
  * us.
  */
-int split_huge_page_to_list(struct page *page, struct list_head *list)
+static int __split_huge_page_to_list(struct page *page, struct list_head *=
list,
+				     bool remap)
 {
 	struct page *head =3D compound_head(page);
 	struct pglist_data *pgdata =3D NODE_DATA(page_to_nid(head));
@@ -2590,7 +2617,7 @@ int split_huge_page_to_list(struct page *page, struct=
 list_head *list)
=20
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
 	VM_BUG_ON_PAGE(!PageLocked(head), head);
-	VM_BUG_ON_PAGE(!PageCompound(head), head);
+	VM_BUG_ON_PAGE(!PageHead(head), head);
=20
 	if (PageWriteback(head))
 		return -EBUSY;
@@ -2604,14 +2631,16 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
 		 * is taken to serialise against parallel split or collapse
 		 * operations.
 		 */
-		anon_vma =3D page_get_anon_vma(head);
-		if (!anon_vma) {
-			ret =3D -EBUSY;
-			goto out;
+		if (remap) {
+			anon_vma =3D page_get_anon_vma(head);
+			if (!anon_vma) {
+				ret =3D -EBUSY;
+				goto out;
+			}
+			anon_vma_lock_write(anon_vma);
 		}
 		end =3D -1;
 		mapping =3D NULL;
-		anon_vma_lock_write(anon_vma);
 	} else {
 		mapping =3D head->mapping;
=20
@@ -2637,13 +2666,18 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
 	/*
 	 * Racy check if we can split the page, before unmap_page() will
 	 * split PMDs
+	 * If we are splitting a migrating THP, there is no check needed
+	 * because the page is already unmapped and isolated from the LRU.
 	 */
-	if (!can_split_huge_page(head, &extra_pins)) {
+	if (!remap)
+		extra_pins =3D HPAGE_PMD_NR - 1 + is_device_private_page(head);
+	else if (!can_split_huge_page(head, &extra_pins)) {
 		ret =3D -EBUSY;
 		goto out_unlock;
 	}
=20
-	unmap_page(head);
+	if (remap)
+		unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
=20
 	/* prevent PageLRU to go away from under us, and freeze lru stats */
@@ -2668,7 +2702,7 @@ int split_huge_page_to_list(struct page *page, struct=
 list_head *list)
 	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
-			list_del(page_deferred_list(head));
+			list_del_init(page_deferred_list(head));
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
@@ -2678,7 +2712,7 @@ int split_huge_page_to_list(struct page *page, struct=
 list_head *list)
 				__dec_node_page_state(head, NR_FILE_THPS);
 		}
=20
-		__split_huge_page(page, list, end, flags);
+		__split_huge_page(page, list, end, flags, remap);
 		if (PageSwapCache(head)) {
 			swp_entry_t entry =3D { .val =3D page_private(head) };
=20
@@ -2698,7 +2732,8 @@ int split_huge_page_to_list(struct page *page, struct=
 list_head *list)
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
 		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
-		remap_page(head);
+		if (remap)
+			remap_page(head);
 		ret =3D -EBUSY;
 	}
=20
@@ -2714,6 +2749,36 @@ fail:		if (mapping)
 	return ret;
 }
=20
+int split_huge_page_to_list(struct page *page, struct list_head *list)
+{
+	return __split_huge_page_to_list(page, list, true);
+}
+
+/*
+ * Split a migrating huge page.
+ * The caller should have mmap_lock_read() held, the huge page unmapped an=
d
+ * isolated, and the PMD page table entry set to a migration entry for the
+ * given head page.
+ */
+int split_migrating_huge_page(struct vm_area_struct *vma, pmd_t *pmd,
+			      unsigned long address, struct page *head)
+{
+	spinlock_t *ptl;
+
+	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
+	VM_BUG_ON_PAGE(!PageLocked(head), head);
+	VM_BUG_ON_PAGE(!PageHead(head), head);
+	VM_BUG_ON_PAGE(PageWriteback(head), head);
+	VM_BUG_ON_PAGE(PageLRU(head), head);
+	VM_BUG_ON_PAGE(compound_mapcount(head), head);
+
+	ptl =3D pmd_lock(vma->vm_mm, pmd);
+	__split_huge_pmd_locked(vma, pmd, address, false);
+	spin_unlock(ptl);
+
+	return __split_huge_page_to_list(head, NULL, false);
+}
+
 void free_transhuge_page(struct page *page)
 {
 	struct deferred_split *ds_queue =3D get_deferred_split_queue(page);
@@ -2722,7 +2787,7 @@ void free_transhuge_page(struct page *page)
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (!list_empty(page_deferred_list(page))) {
 		ds_queue->split_queue_len--;
-		list_del(page_deferred_list(page));
+		list_del_init(page_deferred_list(page));
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 	free_compound_page(page);
@@ -2942,6 +3007,10 @@ void remove_migration_pmd(struct page_vma_mapped_wal=
k *pvmw, struct page *new)
 		pmde =3D pmd_mksoft_dirty(pmde);
 	if (is_write_migration_entry(entry))
 		pmde =3D maybe_pmd_mkwrite(pmde, vma);
+	if (unlikely(is_device_private_page(new))) {
+		entry =3D make_device_private_entry(new, pmd_write(pmde));
+		pmde =3D swp_entry_to_pmd(entry);
+	}
=20
 	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
 	if (PageAnon(new))
diff --git a/mm/memory.c b/mm/memory.c
index fb5463153351..81fcf5101fc6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4346,9 +4346,15 @@ static vm_fault_t __handle_mm_fault(struct vm_area_s=
truct *vma,
=20
 		barrier();
 		if (unlikely(is_swap_pmd(orig_pmd))) {
+			swp_entry_t entry =3D pmd_to_swp_entry(orig_pmd);
+
+			if (is_device_private_entry(entry)) {
+				vmf.page =3D device_private_entry_to_page(entry);
+				return vmf.page->pgmap->ops->migrate_to_ram(&vmf);
+			}
 			VM_BUG_ON(thp_migration_supported() &&
-					  !is_pmd_migration_entry(orig_pmd));
-			if (is_pmd_migration_entry(orig_pmd))
+					  !is_migration_entry(entry));
+			if (is_migration_entry(entry))
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index ce16ed3deab6..139844534dd8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -51,6 +51,7 @@
 #include <linux/oom.h>
=20
 #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/migrate.h>
@@ -2276,19 +2277,28 @@ static int migrate_vma_collect_hole(unsigned long s=
tart,
 {
 	struct migrate_vma *migrate =3D walk->private;
 	unsigned long addr;
+	unsigned long mpfn;
=20
 	/* Only allow populating anonymous memory. */
-	if (!vma_is_anonymous(walk->vma)) {
-		for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
-			migrate->src[migrate->npages] =3D 0;
-			migrate->dst[migrate->npages] =3D 0;
-			migrate->npages++;
-		}
-		return 0;
+	if (!vma_is_anonymous(walk->vma) ||
+	    !((migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)))
+		return migrate_vma_collect_skip(start, end, walk);
+
+	if (thp_migration_supported() &&
+	    (migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
+	    (start & ~PMD_MASK) =3D=3D 0 && (end & ~PMD_MASK) =3D=3D 0) {
+		migrate->src[migrate->npages] =3D MIGRATE_PFN_MIGRATE |
+						MIGRATE_PFN_COMPOUND;
+		migrate->dst[migrate->npages] =3D 0;
+		migrate->npages++;
+		migrate->cpages++;
+		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
 	}
=20
+	mpfn =3D (migrate->vma->vm_flags & VM_WRITE) ?
+		(MIGRATE_PFN_MIGRATE | MIGRATE_PFN_WRITE) : MIGRATE_PFN_MIGRATE;
 	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
-		migrate->src[migrate->npages] =3D MIGRATE_PFN_MIGRATE;
+		migrate->src[migrate->npages] =3D mpfn;
 		migrate->dst[migrate->npages] =3D 0;
 		migrate->npages++;
 		migrate->cpages++;
@@ -2297,59 +2307,133 @@ static int migrate_vma_collect_hole(unsigned long =
start,
 	return 0;
 }
=20
-static int migrate_vma_collect_pmd(pmd_t *pmdp,
-				   unsigned long start,
-				   unsigned long end,
-				   struct mm_walk *walk)
+static int migrate_vma_handle_pmd(pmd_t *pmdp, unsigned long start,
+				  unsigned long end, struct mm_walk *walk)
 {
 	struct migrate_vma *migrate =3D walk->private;
 	struct vm_area_struct *vma =3D walk->vma;
 	struct mm_struct *mm =3D vma->vm_mm;
-	unsigned long addr =3D start, unmapped =3D 0;
 	spinlock_t *ptl;
-	pte_t *ptep;
+	struct page *page;
+	unsigned long write =3D 0;
+	int ret;
=20
-again:
-	if (pmd_none(*pmdp))
+	ptl =3D pmd_lock(mm, pmdp);
+	if (pmd_none(*pmdp)) {
+		spin_unlock(ptl);
 		return migrate_vma_collect_hole(start, end, -1, walk);
-
+	}
 	if (pmd_trans_huge(*pmdp)) {
-		struct page *page;
-
-		ptl =3D pmd_lock(mm, pmdp);
-		if (unlikely(!pmd_trans_huge(*pmdp))) {
+		if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
 			spin_unlock(ptl);
-			goto again;
+			return migrate_vma_collect_skip(start, end, walk);
 		}
-
 		page =3D pmd_page(*pmdp);
 		if (is_huge_zero_page(page)) {
 			spin_unlock(ptl);
-			split_huge_pmd(vma, pmdp, addr);
-			if (pmd_trans_unstable(pmdp))
-				return migrate_vma_collect_skip(start, end,
-								walk);
-		} else {
-			int ret;
+			return migrate_vma_collect_hole(start, end, -1, walk);
+		}
+		if (pmd_write(*pmdp))
+			write =3D MIGRATE_PFN_WRITE;
+	} else if (!pmd_present(*pmdp)) {
+		swp_entry_t entry =3D pmd_to_swp_entry(*pmdp);
+
+		if (is_migration_entry(entry)) {
+			bool wait;
=20
-			get_page(page);
+			page =3D migration_entry_to_page(entry);
+			wait =3D get_page_unless_zero(page);
 			spin_unlock(ptl);
-			if (unlikely(!trylock_page(page)))
-				return migrate_vma_collect_skip(start, end,
-								walk);
-			ret =3D split_huge_page(page);
-			unlock_page(page);
-			put_page(page);
-			if (ret)
-				return migrate_vma_collect_skip(start, end,
-								walk);
-			if (pmd_none(*pmdp))
-				return migrate_vma_collect_hole(start, end, -1,
-								walk);
+			if (wait)
+				put_and_wait_on_page_locked(page);
+			return -EAGAIN;
+		}
+		if (!is_device_private_entry(entry)) {
+			spin_unlock(ptl);
+			return migrate_vma_collect_skip(start, end, walk);
+		}
+		page =3D device_private_entry_to_page(entry);
+		if (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
+		    page->pgmap->owner !=3D migrate->pgmap_owner) {
+			spin_unlock(ptl);
+			return migrate_vma_collect_skip(start, end, walk);
 		}
+		if (is_write_device_private_entry(entry))
+			write =3D MIGRATE_PFN_WRITE;
+	} else {
+		spin_unlock(ptl);
+		return -EAGAIN;
+	}
+
+	get_page(page);
+	if (unlikely(!trylock_page(page))) {
+		spin_unlock(ptl);
+		put_page(page);
+		return migrate_vma_collect_skip(start, end, walk);
+	}
+	if (thp_migration_supported() &&
+	    (migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
+	    (start & ~PMD_MASK) =3D=3D 0 && (start + PMD_SIZE) =3D=3D end) {
+		struct page_vma_mapped_walk vmw =3D {
+			.vma =3D vma,
+			.address =3D start,
+			.pmd =3D pmdp,
+			.ptl =3D ptl,
+		};
+
+		migrate->src[migrate->npages] =3D write |
+			migrate_pfn(page_to_pfn(page)) |
+			MIGRATE_PFN_MIGRATE | MIGRATE_PFN_LOCKED |
+			MIGRATE_PFN_COMPOUND;
+		migrate->dst[migrate->npages] =3D 0;
+		migrate->npages++;
+		migrate->cpages++;
+		migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
+
+		/* Note this also removes the page from the rmap. */
+		set_pmd_migration_entry(&vmw, page);
+		spin_unlock(ptl);
+
+		return 0;
+	}
+	spin_unlock(ptl);
+
+	ret =3D split_huge_page(page);
+	unlock_page(page);
+	put_page(page);
+
+	if (ret)
+		return migrate_vma_collect_skip(start, end, walk);
+	if (pmd_none(*pmdp))
+		return migrate_vma_collect_hole(start, end, -1, walk);
+
+	/* This just causes migrate_vma_collect_pmd() to handle PTEs. */
+	return -ENOENT;
+}
+
+static int migrate_vma_collect_pmd(pmd_t *pmdp,
+				   unsigned long start,
+				   unsigned long end,
+				   struct mm_walk *walk)
+{
+	struct migrate_vma *migrate =3D walk->private;
+	struct vm_area_struct *vma =3D walk->vma;
+	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long addr =3D start, unmapped =3D 0;
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+again:
+	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
+		int ret =3D migrate_vma_handle_pmd(pmdp, start, end, walk);
+
+		if (!ret)
+			return 0;
+		if (ret =3D=3D -EAGAIN)
+			goto again;
 	}
=20
-	if (unlikely(pmd_bad(*pmdp)))
+	if (unlikely(pmd_bad(*pmdp) || pmd_devmap(*pmdp)))
 		return migrate_vma_collect_skip(start, end, walk);
=20
 	ptep =3D pte_offset_map_lock(mm, pmdp, addr, &ptl);
@@ -2405,8 +2489,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			mpfn |=3D pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
 		}
=20
-		/* FIXME support THP */
-		if (!page || !page->mapping || PageTransCompound(page)) {
+		if (!page || !page->mapping) {
 			mpfn =3D 0;
 			goto next;
 		}
@@ -2528,14 +2611,6 @@ static bool migrate_vma_check_page(struct page *page=
)
 	 */
 	int extra =3D 1;
=20
-	/*
-	 * FIXME support THP (transparent huge page), it is bit more complex to
-	 * check them than regular pages, because they can be mapped with a pmd
-	 * or with a pte (split pte mapping).
-	 */
-	if (PageCompound(page))
-		return false;
-
 	/* Page from ZONE_DEVICE have one extra reference */
 	if (is_zone_device_page(page)) {
 		/*
@@ -2834,13 +2909,191 @@ int migrate_vma_setup(struct migrate_vma *args)
 }
 EXPORT_SYMBOL(migrate_vma_setup);
=20
+static pmd_t *find_pmd(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
+
+	pgdp =3D pgd_offset(mm, addr);
+	p4dp =3D p4d_alloc(mm, pgdp, addr);
+	if (!p4dp)
+		return NULL;
+	pudp =3D pud_alloc(mm, p4dp, addr);
+	if (!pudp)
+		return NULL;
+	return pmd_alloc(mm, pudp, addr);
+}
+
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+/*
+ * This code closely follows:
+ * do_huge_pmd_anonymous_page()
+ *   __do_huge_pmd_anonymous_page()
+ * except that the page being inserted is likely to be a device private pa=
ge
+ * instead of an allocated or zero page.
+ */
+static int insert_huge_pmd_anonymous_page(struct vm_area_struct *vma,
+					  unsigned long haddr,
+					  struct page *page,
+					  unsigned long *src,
+					  pmd_t *pmdp)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned int i;
+	spinlock_t *ptl;
+	bool flush =3D false;
+	pgtable_t pgtable;
+	gfp_t gfp;
+	pmd_t entry;
+
+	if (WARN_ON_ONCE(compound_order(page) !=3D HPAGE_PMD_ORDER))
+		goto abort;
+
+	if (unlikely(anon_vma_prepare(vma)))
+		goto abort;
+
+	prep_transhuge_page(page);
+
+	gfp =3D GFP_TRANSHUGE_LIGHT;
+	if (mem_cgroup_charge(page, mm, gfp))
+		goto abort;
+
+	pgtable =3D pte_alloc_one(mm);
+	if (unlikely(!pgtable))
+		goto abort;
+
+	__SetPageUptodate(page);
+
+	if (is_zone_device_page(page)) {
+		if (!is_device_private_page(page))
+			goto pgtable_abort;
+		entry =3D swp_entry_to_pmd(make_device_private_entry(page,
+						vma->vm_flags & VM_WRITE));
+	} else {
+		entry =3D mk_huge_pmd(page, vma->vm_page_prot);
+		entry =3D maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+	}
+
+	ptl =3D pmd_lock(mm, pmdp);
+
+	if (check_stable_address_space(mm))
+		goto unlock_abort;
+
+	/*
+	 * Check for userfaultfd but do not deliver the fault. Instead,
+	 * just back off.
+	 */
+	if (userfaultfd_missing(vma))
+		goto unlock_abort;
+
+	if (pmd_present(*pmdp)) {
+		if (!is_huge_zero_pmd(*pmdp))
+			goto unlock_abort;
+		flush =3D true;
+	} else if (!pmd_none(*pmdp))
+		goto unlock_abort;
+
+	get_page(page);
+	page_add_new_anon_rmap(page, vma, haddr, true);
+	if (!is_zone_device_page(page))
+		lru_cache_add_inactive_or_unevictable(page, vma);
+	if (flush) {
+		pte_free(mm, pgtable);
+		flush_cache_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
+		pmdp_invalidate(vma, haddr, pmdp);
+	} else {
+		pgtable_trans_huge_deposit(mm, pmdp, pgtable);
+		mm_inc_nr_ptes(mm);
+	}
+	set_pmd_at(mm, haddr, pmdp, entry);
+	update_mmu_cache_pmd(vma, haddr, pmdp);
+	add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
+	spin_unlock(ptl);
+	count_vm_event(THP_FAULT_ALLOC);
+	count_memcg_event_mm(mm, THP_FAULT_ALLOC);
+
+	return 0;
+
+unlock_abort:
+	spin_unlock(ptl);
+pgtable_abort:
+	pte_free(mm, pgtable);
+abort:
+	for (i =3D 0; i < HPAGE_PMD_NR; i++)
+		src[i] &=3D ~MIGRATE_PFN_MIGRATE;
+	return -EINVAL;
+}
+
+static void migrate_vma_split(struct migrate_vma *migrate, unsigned long i=
,
+			      unsigned long addr)
+{
+	const unsigned long npages =3D i + HPAGE_PMD_NR;
+	unsigned long mpfn;
+	unsigned long j;
+	bool migrating =3D false;
+	struct page *page;
+
+	migrate->src[i] &=3D ~MIGRATE_PFN_COMPOUND;
+
+	/* If no part of the THP is migrating, we can skip splitting. */
+	for (j =3D i; j < npages; j++) {
+		if (migrate->dst[j] & MIGRATE_PFN_VALID) {
+			migrating =3D true;
+			break;
+		}
+	}
+	if (!migrating)
+		return;
+
+	mpfn =3D migrate->src[i];
+	page =3D migrate_pfn_to_page(mpfn);
+	if (page) {
+		pmd_t *pmdp;
+		int ret;
+
+		pmdp =3D find_pmd(migrate->vma->vm_mm, addr);
+		if (!pmdp) {
+			migrate->src[i] =3D mpfn & ~MIGRATE_PFN_MIGRATE;
+			return;
+		}
+		ret =3D split_migrating_huge_page(migrate->vma, pmdp, addr, page);
+		if (ret) {
+			migrate->src[i] =3D mpfn & ~MIGRATE_PFN_MIGRATE;
+			return;
+		}
+		while (++i < npages) {
+			mpfn +=3D 1UL << MIGRATE_PFN_SHIFT;
+			migrate->src[i] =3D mpfn;
+		}
+	} else {
+		while (++i < npages)
+			migrate->src[i] =3D mpfn;
+	}
+}
+#else
+static int insert_huge_pmd_anonymous_page(struct vm_area_struct *vma,
+					  unsigned long haddr,
+					  struct page *page,
+					  unsigned long *src,
+					  pmd_t *pmdp)
+{
+	return 0;
+}
+
+static void migrate_vma_split(struct migrate_vma *migrate, unsigned long i=
,
+			      unsigned long addr)
+{
+}
+#endif
+
 /*
  * This code closely matches the code in:
  *   __handle_mm_fault()
  *     handle_pte_fault()
  *       do_anonymous_page()
- * to map in an anonymous zero page but the struct page will be a ZONE_DEV=
ICE
- * private page.
+ * to map in an anonymous zero page except the struct page is already allo=
cated
+ * and will likely be a ZONE_DEVICE private page.
  */
 static void migrate_vma_insert_page(struct migrate_vma *migrate,
 				    unsigned long addr,
@@ -2853,9 +3106,6 @@ static void migrate_vma_insert_page(struct migrate_vm=
a *migrate,
 	bool flush =3D false;
 	spinlock_t *ptl;
 	pte_t entry;
-	pgd_t *pgdp;
-	p4d_t *p4dp;
-	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
=20
@@ -2863,19 +3113,25 @@ static void migrate_vma_insert_page(struct migrate_=
vma *migrate,
 	if (!vma_is_anonymous(vma))
 		goto abort;
=20
-	pgdp =3D pgd_offset(mm, addr);
-	p4dp =3D p4d_alloc(mm, pgdp, addr);
-	if (!p4dp)
-		goto abort;
-	pudp =3D pud_alloc(mm, p4dp, addr);
-	if (!pudp)
-		goto abort;
-	pmdp =3D pmd_alloc(mm, pudp, addr);
+	pmdp =3D find_pmd(migrate->vma->vm_mm, addr);
 	if (!pmdp)
 		goto abort;
=20
-	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
-		goto abort;
+	if (thp_migration_supported() && *dst & MIGRATE_PFN_COMPOUND) {
+		int ret =3D insert_huge_pmd_anonymous_page(vma, addr, page, src,
+							 pmdp);
+		if (ret)
+			goto abort;
+		return;
+	}
+	if (!pmd_none(*pmdp)) {
+		if (pmd_trans_huge(*pmdp)) {
+			if (!is_huge_zero_pmd(*pmdp))
+				goto abort;
+			__split_huge_pmd(vma, pmdp, addr, false, NULL);
+		} else if (pmd_leaf(*pmdp))
+			goto abort;
+	}
=20
 	/*
 	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
@@ -2910,9 +3166,11 @@ static void migrate_vma_insert_page(struct migrate_v=
ma *migrate,
 		if (is_device_private_page(page)) {
 			swp_entry_t swp_entry;
=20
-			swp_entry =3D make_device_private_entry(page, vma->vm_flags & VM_WRITE)=
;
+			swp_entry =3D make_device_private_entry(page,
+						vma->vm_flags & VM_WRITE);
 			entry =3D swp_entry_to_pte(swp_entry);
-		}
+		} else
+			goto abort;
 	} else {
 		entry =3D mk_pte(page, vma->vm_page_prot);
 		if (vma->vm_flags & VM_WRITE)
@@ -2941,10 +3199,10 @@ static void migrate_vma_insert_page(struct migrate_=
vma *migrate,
 		goto unlock_abort;
=20
 	inc_mm_counter(mm, MM_ANONPAGES);
+	get_page(page);
 	page_add_new_anon_rmap(page, vma, addr, false);
 	if (!is_zone_device_page(page))
 		lru_cache_add_inactive_or_unevictable(page, vma);
-	get_page(page);
=20
 	if (flush) {
 		flush_cache_page(vma, addr, pte_pfn(*ptep));
@@ -2958,7 +3216,6 @@ static void migrate_vma_insert_page(struct migrate_vm=
a *migrate,
 	}
=20
 	pte_unmap_unlock(ptep, ptl);
-	*src =3D MIGRATE_PFN_MIGRATE;
 	return;
=20
 unlock_abort:
@@ -2989,11 +3246,23 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 		struct address_space *mapping;
 		int r;
=20
+		/*
+		 * If the caller didn't allocate a THP, split the PMD and
+		 * fix up the src array.
+		 */
+		if (thp_migration_supported() &&
+		    (migrate->src[i] & MIGRATE_PFN_MIGRATE) &&
+		    (migrate->src[i] & MIGRATE_PFN_COMPOUND) &&
+		    !(migrate->dst[i] & MIGRATE_PFN_COMPOUND))
+			migrate_vma_split(migrate, i, addr);
+
+		newpage =3D migrate_pfn_to_page(migrate->dst[i]);
 		if (!newpage) {
 			migrate->src[i] &=3D ~MIGRATE_PFN_MIGRATE;
 			continue;
 		}
=20
+		page =3D migrate_pfn_to_page(migrate->src[i]);
 		if (!page) {
 			if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE))
 				continue;
diff --git a/mm/rmap.c b/mm/rmap.c
index 9425260774a1..4a4d24ea5008 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1497,7 +1497,7 @@ static bool try_to_unmap_one(struct page *page, struc=
t vm_area_struct *vma,
 		}
=20
 		if (IS_ENABLED(CONFIG_MIGRATION) &&
-		    (flags & TTU_MIGRATION) &&
+		    (flags & (TTU_MIGRATION | TTU_SPLIT_FREEZE)) &&
 		    is_zone_device_page(page)) {
 			swp_entry_t entry;
 			pte_t swp_pte;
--=20
2.20.1

