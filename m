Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8746F2B9760
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgKSQGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 11:06:48 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:59187 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728003AbgKSQGk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 11:06:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 2011388A;
        Thu, 19 Nov 2020 11:06:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 11:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=2hOwC3vD5z2wV
        X1SKfcH1zwPI63wkPgsCwpi9pqtZDg=; b=rlpQFsO10+XbTiq1a9cNkTMDly+co
        3bOS8q9jLQ/YbHNql0DlbPg9A08wgxbyD2Nk0vtdJBnIwe3S63ikdLlh4uV0YOsY
        XSn1TwzdHhO3cjRcBpWXJ/zxshuRFLjoKyrIW68s8FzoOloeV97mv4EaDUPwWjVB
        ZYUf8Dl8A24/zBehR9ISL5TPfikhL580UIPb5XgDk8K8DRjqe7bRCpMX/cyIJVWz
        1KtyRLKotZxXMwHmd9MzhdqNTpR01j1TtvuWJzHmjh+dSexnQKUEqc8abCYmHp0d
        CcwGAo4xLEdeC5Ui6OU82IbsAtd2d3HXMhxnX816MMm7NfQs+V5+jJQaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2hOwC3vD5z2wVX1SKfcH1zwPI63wkPgsCwpi9pqtZDg=; b=iE/717et
        uDPUC2YKAJEerz746LTZIk/MRtTLFlV477H+qhy1eE2wqTs9MqBFgGXilmjnesJg
        +Ae3GlBmr4DF0AW8e2S9Cl0675agqQsIyGheaJkS2qJuSqOy91gvZjzot9GmPAYK
        PnQll+DxULiufXSIxXj2YHkgz5Fst7dkkbYp3UJfwDy4TvRSHFbQCwITKsM8btEL
        735PlOxfSdCJwJ1pSZsdRWFu48dyQ6AOXlMCxoY0g2iLy7gqXTt6KnTMcNR9pIF6
        A1BlFu8Qr8rCPtfWJjxEBn83QPH45keBBpnAnKlk2eH5KFZq5f7H9v5CLay0yXUc
        JRlwi7HgIIjv8w==
X-ME-Sender: <xms:DZi2X0AyYoyHDLfvDa0AAwDSbHyTMulfProXFX6B1-HEpYpz7ApBsw>
    <xme:DZi2X2gB6xlT0nafx-_glT_6sKH42_9uAqjnWcOfilyjezYoqlEILyokvPhjq9nlY
    wAwFbt_uel-h2d_hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:DZi2X3lhk5__A09R0XGPTyBNnHCiwW-L5MdRBnWLw5q1eamNZ5OYxw>
    <xmx:DZi2X6yiwmlOWM3aw7F9xLFetFv2mCXZos8th2rDgiO6jJMjvpkVkA>
    <xmx:DZi2X5SP2UDVy9zuqXgPcpNWhMowifR6mTRAhzWc96MrqyXMOdR0bA>
    <xmx:DZi2X-Iu00lLxRHLzl-RMDsiGsLwUOvmEtUo4rTmq7YISVhp715BVj7a7pI>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0028E3064AB6;
        Thu, 19 Nov 2020 11:06:36 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH 5/7] mm: thp: split huge page to any lower order pages.
Date:   Thu, 19 Nov 2020 11:06:03 -0500
Message-Id: <20201119160605.1272425-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119160605.1272425-1-zi.yan@sent.com>
References: <20201119160605.1272425-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

To split a THP to any lower order pages, we need to reform THPs on
subpages at given order and add page refcount based on the new page
order. Also we need to reinitialize page_deferred_list after removing
the page from the split_queue, otherwise a subsequent split will see
list corruption when checking the page_deferred_list again.

It has many uses, like minimizing the number of pages after
truncating a pagecache THP. For anonymous THPs, we can only split them
to order-0 like before until we add support for any size anonymous THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h |   8 +++
 mm/huge_memory.c        | 119 +++++++++++++++++++++++++++++-----------
 mm/swap.c               |   1 -
 3 files changed, 96 insertions(+), 32 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7723deda33e2..0c856f805617 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -182,6 +182,8 @@ bool is_transparent_hugepage(struct page *page);
=20
 bool can_split_huge_page(struct page *page, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *=
list,
+		unsigned int new_order);
 static inline int split_huge_page(struct page *page)
 {
 	return split_huge_page_to_list(page, NULL);
@@ -385,6 +387,12 @@ split_huge_page_to_list(struct page *page, struct list=
_head *list)
 {
 	return 0;
 }
+static inline int
+split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+		unsigned int new_order)
+{
+	return 0;
+}
 static inline int split_huge_page(struct page *page)
 {
 	return 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index aae7405a0989..cc70f70862d8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2325,12 +2325,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
=20
 static void unmap_page(struct page *page)
 {
-	enum ttu_flags ttu_flags =3D TTU_IGNORE_MLOCK |
-		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
+	enum ttu_flags ttu_flags =3D TTU_IGNORE_MLOCK | TTU_RMAP_LOCKED;
 	bool unmap_success;
=20
 	VM_BUG_ON_PAGE(!PageHead(page), page);
=20
+	if (thp_order(page) >=3D HPAGE_PMD_ORDER)
+		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
+
 	if (PageAnon(page))
 		ttu_flags |=3D TTU_SPLIT_FREEZE;
=20
@@ -2338,21 +2340,23 @@ static void unmap_page(struct page *page)
 	VM_BUG_ON_PAGE(!unmap_success, page);
 }
=20
-static void remap_page(struct page *page, unsigned int nr)
+static void remap_page(struct page *page, unsigned int nr, unsigned int ne=
w_nr)
 {
-	int i;
-	if (PageTransHuge(page)) {
+	unsigned int i;
+
+	if (thp_nr_pages(page) =3D=3D nr) {
 		remove_migration_ptes(page, page, true);
 	} else {
-		for (i =3D 0; i < nr; i++)
+		for (i =3D 0; i < nr; i +=3D new_nr)
 			remove_migration_ptes(page + i, page + i, true);
 	}
 }
=20
 static void __split_huge_page_tail(struct page *head, int tail,
-		struct lruvec *lruvec, struct list_head *list)
+		struct lruvec *lruvec, struct list_head *list, unsigned int new_order)
 {
 	struct page *page_tail =3D head + tail;
+	unsigned long compound_head_flag =3D new_order ? (1L << PG_head) : 0;
=20
 	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) !=3D -1, page_tail);
=20
@@ -2376,6 +2380,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 #ifdef CONFIG_64BIT
 			 (1L << PG_arch_2) |
 #endif
+			 compound_head_flag |
 			 (1L << PG_dirty)));
=20
 	/* ->mapping in first tail page is compound_mapcount */
@@ -2384,7 +2389,10 @@ static void __split_huge_page_tail(struct page *head=
, int tail,
 	page_tail->mapping =3D head->mapping;
 	page_tail->index =3D head->index + tail;
=20
-	/* Page flags must be visible before we make the page non-compound. */
+	/*
+	 * Page flags must be visible before we make the page non-compound or
+	 * a compound page in new_order.
+	 */
 	smp_wmb();
=20
 	/*
@@ -2394,10 +2402,15 @@ static void __split_huge_page_tail(struct page *hea=
d, int tail,
 	 * which needs correct compound_head().
 	 */
 	clear_compound_head(page_tail);
+	if (new_order) {
+		prep_compound_page(page_tail, new_order);
+		thp_prep(page_tail);
+	}
=20
 	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
-					  PageSwapCache(head)));
+	page_ref_unfreeze(page_tail, 1 + ((!PageAnon(head) ||
+					   PageSwapCache(head)) ?
+						thp_nr_pages(page_tail) : 0));
=20
 	if (page_is_young(head))
 		set_page_young(page_tail);
@@ -2415,7 +2428,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 }
=20
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned long flags)
+		pgoff_t end, unsigned long flags, unsigned int new_order)
 {
 	struct page *head =3D compound_head(page);
 	pg_data_t *pgdat =3D page_pgdat(head);
@@ -2424,12 +2437,13 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
 	unsigned long offset =3D 0;
 	unsigned int order =3D thp_order(head);
 	unsigned int nr =3D thp_nr_pages(head);
+	unsigned int new_nr =3D 1 << new_order;
 	int i;
=20
 	lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
=20
 	/* complete memcg works before add pages to LRU */
-	mem_cgroup_split_huge_fixup(head, 0);
+	mem_cgroup_split_huge_fixup(head, new_order);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
@@ -2439,46 +2453,54 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
 		xa_lock(&swap_cache->i_pages);
 	}
=20
-	for (i =3D nr - 1; i >=3D 1; i--) {
-		__split_huge_page_tail(head, i, lruvec, list);
+	for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
+		__split_huge_page_tail(head, i, lruvec, list, new_order);
 		/* Some pages can be beyond i_size: drop them from page cache */
 		if (head[i].index >=3D end) {
 			ClearPageDirty(head + i);
 			__delete_from_page_cache(head + i, NULL);
 			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
-				shmem_uncharge(head->mapping->host, 1);
+				shmem_uncharge(head->mapping->host, new_nr);
 			put_page(head + i);
 		} else if (!PageAnon(page)) {
 			__xa_store(&head->mapping->i_pages, head[i].index,
 					head + i, 0);
 		} else if (swap_cache) {
+			/*
+			 * split anonymous THPs (including swapped out ones) to
+			 * non-zero order not supported
+			 */
+			VM_BUG_ON(new_order);
 			__xa_store(&swap_cache->i_pages, offset + i,
 					head + i, 0);
 		}
 	}
=20
-	ClearPageCompound(head);
+	if (!new_order)
+		ClearPageCompound(head);
+	else
+		set_compound_order(head, new_order);
=20
-	split_page_owner(head, order, 0);
+	split_page_owner(head, order, new_order);
=20
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
 		/* Additional pin to swap cache */
 		if (PageSwapCache(head)) {
-			page_ref_add(head, 2);
+			page_ref_add(head, 1 + new_nr);
 			xa_unlock(&swap_cache->i_pages);
 		} else {
 			page_ref_inc(head);
 		}
 	} else {
 		/* Additional pin to page cache */
-		page_ref_add(head, 2);
+		page_ref_add(head, 1 + new_nr);
 		xa_unlock(&head->mapping->i_pages);
 	}
=20
 	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
=20
-	remap_page(head, nr);
+	remap_page(head, nr, new_nr);
=20
 	if (PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
@@ -2486,7 +2508,14 @@ static void __split_huge_page(struct page *page, str=
uct list_head *list,
 		split_swap_cluster(entry);
 	}
=20
-	for (i =3D 0; i < nr; i++) {
+	/*
+	 * set page to its compound_head when split to THPs, so that GUP pin and
+	 * PG_locked are transferred to the right after-split page
+	 */
+	if (new_order)
+		page =3D compound_head(page);
+
+	for (i =3D 0; i < nr; i +=3D new_nr) {
 		struct page *subpage =3D head + i;
 		if (subpage =3D=3D page)
 			continue;
@@ -2604,37 +2633,61 @@ bool can_split_huge_page(struct page *page, int *pe=
xtra_pins)
  * This function splits huge page into normal pages. @page can point to any
  * subpage of huge page to split. Split doesn't change the position of @pa=
ge.
  *
+ * See split_huge_page_to_list_to_order() for more details.
+ *
+ * Returns 0 if the hugepage is split successfully.
+ * Returns -EBUSY if the page is pinned or if anon_vma disappeared from un=
der
+ * us.
+ */
+int split_huge_page_to_list(struct page *page, struct list_head *list)
+{
+	return split_huge_page_to_list_to_order(page, list, 0);
+}
+
+/*
+ * This function splits huge page into pages in @new_order. @page can poin=
t to
+ * any subpage of huge page to split. Split doesn't change the position of
+ * @page.
+ *
  * Only caller must hold pin on the @page, otherwise split fails with -EBU=
SY.
  * The huge page must be locked.
  *
  * If @list is null, tail pages will be added to LRU list, otherwise, to @=
list.
  *
- * Both head page and tail pages will inherit mapping, flags, and so on fr=
om
- * the hugepage.
+ * Pages in new_order will inherit mapping, flags, and so on from the huge=
page.
  *
- * GUP pin and PG_locked transferred to @page. Rest subpages can be freed =
if
- * they are not mapped.
+ * GUP pin and PG_locked transferred to @page or the compound page @page b=
elongs
+ * to. Rest subpages can be freed if they are not mapped.
  *
  * Returns 0 if the hugepage is split successfully.
  * Returns -EBUSY if the page is pinned or if anon_vma disappeared from un=
der
  * us.
  */
-int split_huge_page_to_list(struct page *page, struct list_head *list)
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *=
list,
+				     unsigned int new_order)
 {
 	struct page *head =3D compound_head(page);
 	struct pglist_data *pgdata =3D NODE_DATA(page_to_nid(head));
 	struct deferred_split *ds_queue =3D get_deferred_split_queue(head);
-	XA_STATE(xas, &head->mapping->i_pages, head->index);
+	/* reset xarray order to new order after split */
+	XA_STATE_ORDER(xas, &head->mapping->i_pages, head->index, new_order);
 	struct anon_vma *anon_vma =3D NULL;
 	struct address_space *mapping =3D NULL;
 	int count, mapcount, extra_pins, ret;
 	unsigned long flags;
 	pgoff_t end;
=20
+	VM_BUG_ON(thp_order(head) <=3D new_order);
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
 	VM_BUG_ON_PAGE(!PageLocked(head), head);
 	VM_BUG_ON_PAGE(!PageCompound(head), head);
=20
+	/* Cannot split THP to order-1 (no order-1 THPs) */
+	VM_BUG_ON(new_order =3D=3D 1);
+
+	/* Split anonymous THP to non-zero order not support */
+	VM_BUG_ON(PageAnon(head) && new_order);
+
 	if (PageWriteback(head))
 		return -EBUSY;
=20
@@ -2720,18 +2773,22 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
 	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
-			list_del(page_deferred_list(head));
+			list_del_init(page_deferred_list(head));
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
 			if (PageSwapBacked(head))
 				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
-			else
+			else if (!new_order)
+				/*
+				 * Decrease THP stats only if split to normal
+				 * pages
+				 */
 				__mod_lruvec_page_state(head, NR_FILE_THPS,
 						-thp_nr_pages(head));
 		}
=20
-		__split_huge_page(page, list, end, flags);
+		__split_huge_page(page, list, end, flags, new_order);
 		ret =3D 0;
 	} else {
 		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
@@ -2746,7 +2803,7 @@ int split_huge_page_to_list(struct page *page, struct=
 list_head *list)
 fail:		if (mapping)
 			xas_unlock(&xas);
 		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
-		remap_page(head, thp_nr_pages(head));
+		remap_page(head, thp_nr_pages(head), 1);
 		ret =3D -EBUSY;
 	}
=20
diff --git a/mm/swap.c b/mm/swap.c
index b667870c8a0b..8f53ab593438 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -983,7 +983,6 @@ void lru_add_page_tail(struct page *page, struct page *=
page_tail,
 		       struct lruvec *lruvec, struct list_head *list)
 {
 	VM_BUG_ON_PAGE(!PageHead(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
 	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
 	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
=20
--=20
2.28.0

