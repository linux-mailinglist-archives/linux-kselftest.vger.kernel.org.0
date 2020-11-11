Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3522AF9FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 21:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgKKUqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 15:46:03 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:35353 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgKKUqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 15:46:02 -0500
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2020 15:46:01 EST
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id AB7BAB44;
        Wed, 11 Nov 2020 15:40:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 11 Nov 2020 15:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=FFtNPcXr4xGJ9
        kwfOrLCBoFxL6hUUpz35sirIAoWiiA=; b=nNqAHO1cgSD8k1/k0UX7u64YpLvHJ
        RN5VLlFA+6q9RP8y1geK6BZ7qOXGB2Vj7TK6CgJYSoFtjHogYDPLSQo8H3Qpzpmy
        ptvVSkPedS4IMPYqVpC07nq2rRnpsqqEEbfGfb69TFwdGsSQtaJp7anDMO5hJLLa
        zUKruMxkg0ydPQfR48JmlUOa86lFAvMK/AOV8nLqBAa+2MKUV027HDR4vId+hT1U
        XpVlA8ZmpL4PWyQZTQjqiTvSvEystURTvYGiUtruj0b2ShBOfRmQJ68Fy+H8kJzy
        fGe+ETvhTsbH/+CMNc2ZgR40tXX9fw4L3w1M5//cYoUb2h++qam66zrPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FFtNPcXr4xGJ9kwfOrLCBoFxL6hUUpz35sirIAoWiiA=; b=mK6KtfCe
        pdcav9+CQDBPGtDBrzCpjPeMOimHbPcD8pH1KlyCwypNLkfsKha04nRt1L04xLKi
        MWRF5g5gjJX0TpjkmnVs2lItP4RUV/KOSYUNNaSW5QbnTbiHMDrv/mPRQX7ArfNk
        X0JxmzknIBwDrZPo/mYr4GfmfJGA8o6hgQrPtC3LiHafWaD+S5XGY+rUjedKVEvM
        KbbvuC/y5FHBLOjzo/cPOojOCdVxj0ASwF2VvA2+oS4PL8czI1MVS9C0qp9NdFfs
        GbWF0fZhC12vb3mE3Ix0DzzEtVBzyClm6875kgX8FX1Gg6Jhhu45mDQAM0IET38W
        MIdxx2bYCc1QVQ==
X-ME-Sender: <xms:SUysXxzGY6l1xwiBtbG6mXgBxlwyY5UqdV9rj4PnGqTbkDzydlBoHw>
    <xme:SUysXxSePvXBB9kN8YouB3Ymz346bvZerPgCJCMepYUa-OjOGeajlptbinpVzv_0J
    wx968XQiedu2oOKdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvtddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:SUysX7Wef7eCx_AS8SdhJh0tKYvnzYwPduikRTikb8KaAU4Wym9UvQ>
    <xmx:SUysXzidrFOh8HUgoJsV_PB4D7XeRXFqeIFPcdbhmvMy-n8yJSt-Hw>
    <xmx:SUysXzAFo3Gu6RJwkrGVjCLMT5CjdsoxR-04EUvMfh1dzcNfn5CUHA>
    <xmx:SUysX35DlQr98dHCF_G9Lk2dbXynvyeBLcc6pE1gGkEthUFL-dWnbBDXzHo>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id A773B3280066;
        Wed, 11 Nov 2020 15:40:40 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 4/6] mm: thp: add support for split huge page to any lower order pages.
Date:   Wed, 11 Nov 2020 15:40:06 -0500
Message-Id: <20201111204008.21332-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111204008.21332-1-zi.yan@sent.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
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
 include/linux/huge_mm.h |  8 +++++
 mm/huge_memory.c        | 78 +++++++++++++++++++++++++++++------------
 mm/swap.c               |  1 -
 3 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 60a907a19f7d..9819cd9b4619 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -189,6 +189,8 @@ bool is_transparent_hugepage(struct page *page);
=20
 bool can_split_huge_page(struct page *page, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *=
list,
+		unsigned int new_order);
 static inline int split_huge_page(struct page *page)
 {
 	return split_huge_page_to_list(page, NULL);
@@ -396,6 +398,12 @@ split_huge_page_to_list(struct page *page, struct list=
_head *list)
 {
 	return 0;
 }
+static inline int
+split_huge_page_to_order_to_list(struct page *page, struct list_head *list,
+		unsigned int new_order)
+{
+	return 0;
+}
 static inline int split_huge_page(struct page *page)
 {
 	return 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8b7d771ee962..88f50da40c9b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2327,11 +2327,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 static void unmap_page(struct page *page)
 {
 	enum ttu_flags ttu_flags =3D TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
-		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
+		TTU_RMAP_LOCKED;
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
@@ -2339,21 +2342,22 @@ static void unmap_page(struct page *page)
 	VM_BUG_ON_PAGE(!unmap_success, page);
 }
=20
-static void remap_page(struct page *page, unsigned int nr)
+static void remap_page(struct page *page, unsigned int nr, unsigned int ne=
w_nr)
 {
 	int i;
-	if (PageTransHuge(page)) {
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
@@ -2377,6 +2381,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 #ifdef CONFIG_64BIT
 			 (1L << PG_arch_2) |
 #endif
+			 compound_head_flag |
 			 (1L << PG_dirty)));
=20
 	/* ->mapping in first tail page is compound_mapcount */
@@ -2395,10 +2400,15 @@ static void __split_huge_page_tail(struct page *hea=
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
@@ -2416,7 +2426,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 }
=20
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned long flags)
+		pgoff_t end, unsigned long flags, unsigned int new_order)
 {
 	struct page *head =3D compound_head(page);
 	pg_data_t *pgdat =3D page_pgdat(head);
@@ -2424,12 +2434,13 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
 	struct address_space *swap_cache =3D NULL;
 	unsigned long offset =3D 0;
 	unsigned int nr =3D thp_nr_pages(head);
+	unsigned int new_nr =3D 1 << new_order;
 	int i;
=20
 	lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
=20
 	/* complete memcg works before add pages to LRU */
-	mem_cgroup_split_huge_fixup(head, 1);
+	mem_cgroup_split_huge_fixup(head, new_nr);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
@@ -2439,14 +2450,14 @@ static void __split_huge_page(struct page *page, st=
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
@@ -2457,28 +2468,31 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
 		}
 	}
=20
-	ClearPageCompound(head);
+	if (!new_order)
+		ClearPageCompound(head);
+	else
+		set_compound_order(head, new_order);
=20
-	split_page_owner(head, nr, 1);
+	split_page_owner(head, nr, new_nr);
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
@@ -2486,7 +2500,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 		split_swap_cluster(entry);
 	}
=20
-	for (i =3D 0; i < nr; i++) {
+	for (i =3D 0; i < nr; i +=3D new_nr) {
 		struct page *subpage =3D head + i;
 		if (subpage =3D=3D page)
 			continue;
@@ -2620,21 +2634,39 @@ bool can_split_huge_page(struct page *page, int *pe=
xtra_pins)
  * us.
  */
 int split_huge_page_to_list(struct page *page, struct list_head *list)
+{
+	return split_huge_page_to_list_to_order(page, list, 0);
+}
+
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
+	if (new_order =3D=3D 1) {
+		WARN_ONCE(1, "Cannot split THP to order-1 (no order-1 THPs)");
+		return -EINVAL;
+	}
+
+	if (PageAnon(head) && new_order) {
+		WARN_ONCE(1, "Split anonymous THP to non-zero order not support");
+		return -EINVAL;
+	}
+
 	if (PageWriteback(head))
 		return -EBUSY;
=20
@@ -2720,18 +2752,18 @@ int split_huge_page_to_list(struct page *page, stru=
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
 				__mod_lruvec_page_state(head, NR_FILE_THPS,
 						-thp_nr_pages(head));
 		}
=20
-		__split_huge_page(page, list, end, flags);
+		__split_huge_page(page, list, end, flags, new_order);
 		ret =3D 0;
 	} else {
 		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
@@ -2746,7 +2778,7 @@ int split_huge_page_to_list(struct page *page, struct=
 list_head *list)
 fail:		if (mapping)
 			xas_unlock(&xas);
 		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
-		remap_page(head, thp_nr_pages(head));
+		remap_page(head, thp_nr_pages(head), 0);
 		ret =3D -EBUSY;
 	}
=20
diff --git a/mm/swap.c b/mm/swap.c
index 14c3bac607a6..6c33e6165597 100644
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

