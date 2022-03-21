Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8284E2A97
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348854AbiCUO3E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 10:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349276AbiCUO1x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97D1FCC1;
        Mon, 21 Mar 2022 07:21:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BB0E5C013E;
        Mon, 21 Mar 2022 10:21:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 21 Mar 2022 10:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=7T5ogzTVz+pREW
        HQHtFgoPpVXuCA2hjAwdosZDFI+CE=; b=Hix2FzTy2ZmuW6BK5lkeOMhTARfjBT
        iXuQbSBngj5gdw/VmLXkW+E3As9ekKUJZ1b7wDm8/fgF6VVZdmgt1cFarPv+t0zD
        Xkx5NrxWQDB8gcbges8ZoPkqMPa/tsGGB5mnmawXLNSoNWeZjWoEo4paikqBdr0W
        wgWrbut9Gf33ODzbPuhh7j6x4oWYmSP2fYSd+geKslJ8FY4f0wOOO/olunlxkf6i
        q4LuFSsWhLtr523ErhFU3nWRuiJlsK0sKxdYxPB7/3VPqQvQpwp1eYHOua76cxBt
        ACSMWNBZhSt0wGx4994pciJUxQjJ6vuN32eaoaeI9uA/zAAhRuhWNptg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=7T5ogzTVz+pREWHQHtFgoPpVXuCA2hjAwdosZDFI+CE=; b=H/8cFbIw
        MMeoQQuyERsEmp99t9K7E3Zp3B9107hEZVjLr6hj4ieVlk8qswifA7n/4YynuLzU
        UhEpRZkpbPNNJRCJaQzy+n8blXiFKi802qNE5YN9TWOA8msFNmkeqRHWEV/q8+9E
        7EfVHeMJonpw3vq6xbhKrUUapJ4oTQtTsnYOeO+sy1IgiHbYXrc+pNMGpyjbLGAH
        U3LKF1yzj/yJziPbo4gPo6Z4m5GCsrGabrdO9UGrkO6SsxqIErx5BcjE9qOC0oMQ
        lwqGIUfTqg/61H8WXkHWOHySCkePma8FayAyejHGxY/cN0Tkiy7CFLuYdYhIxpVC
        geq0uWthWeZiOg==
X-ME-Sender: <xms:8ok4YifS5wimkFFuf_GT9Jgxlk1k92_f9f8d4moo1Cy7TtOfRN97Kw>
    <xme:8ok4YsOgbed1bx5i11DwAoaPwHFlVVCUqk577UK7YqQRJj39_FmUoMr3QKuDpx-Rd
    QqqsL-sDsH-sgWKAw>
X-ME-Received: <xmr:8ok4Yjj9QE28atuf0RDA2NKr6K8cfl1wvli45MaySSyXRekT-PfRlMwljzLx7xwhy35-THETy_DnI5MVQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:8ok4Yv-Mr4yet1gWVeWUTgjRd9gTtF6_aQfmMlvlEsbB8J52fXdLMg>
    <xmx:8ok4Yuvmw_gvy2r4NuyPV4UYWS1H1avgeW_ustCn_E05dbk119NE3Q>
    <xmx:8ok4YmEQaxg6b2DbuKAFuSgvX-2tRFVaS-4HyO_jTpG57cAiSA2ZHg>
    <xmx:8ok4YvkJbgTH7eZHy2Rh6JS6KA9ie3NIp7HAnPGvz8091UInzOH1yQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 10:21:37 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 3/5] mm: thp: split huge page to any lower order pages.
Date:   Mon, 21 Mar 2022 10:21:26 -0400
Message-Id: <20220321142128.2471199-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321142128.2471199-1-zi.yan@sent.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 mm/huge_memory.c        | 111 ++++++++++++++++++++++++++++++----------
 2 files changed, 91 insertions(+), 28 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2999190adc22..c7153cd7e9e4 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -186,6 +186,8 @@ void free_transhuge_page(struct page *page);
=20
 bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *=
list,
+		unsigned int new_order);
 static inline int split_huge_page(struct page *page)
 {
 	return split_huge_page_to_list(page, NULL);
@@ -355,6 +357,12 @@ split_huge_page_to_list(struct page *page, struct list=
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
index fcfa46af6c4c..3617aa3ad0b1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2236,11 +2236,13 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 static void unmap_page(struct page *page)
 {
 	struct folio *folio =3D page_folio(page);
-	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
-		TTU_SYNC;
+	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SYNC;
=20
 	VM_BUG_ON_PAGE(!PageHead(page), page);
=20
+	if (folio_order(folio) >=3D HPAGE_PMD_ORDER)
+		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
+
 	/*
 	 * Anon pages need migration entries to preserve them, but file
 	 * pages can simply be left unmapped, then faulted back on demand.
@@ -2254,9 +2256,9 @@ static void unmap_page(struct page *page)
 	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
 }
=20
-static void remap_page(struct folio *folio, unsigned long nr)
+static void remap_page(struct folio *folio, unsigned short nr)
 {
-	int i =3D 0;
+	unsigned int i;
=20
 	/* If unmap_page() uses try_to_migrate() on file, remove this check */
 	if (!folio_test_anon(folio))
@@ -2274,7 +2276,6 @@ static void lru_add_page_tail(struct page *head, stru=
ct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
 	VM_BUG_ON_PAGE(!PageHead(head), head);
-	VM_BUG_ON_PAGE(PageCompound(tail), head);
 	VM_BUG_ON_PAGE(PageLRU(tail), head);
 	lockdep_assert_held(&lruvec->lru_lock);
=20
@@ -2295,9 +2296,10 @@ static void lru_add_page_tail(struct page *head, str=
uct page *tail,
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
@@ -2321,6 +2323,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 #ifdef CONFIG_64BIT
 			 (1L << PG_arch_2) |
 #endif
+			 compound_head_flag |
 			 (1L << PG_dirty)));
=20
 	/* ->mapping in first tail page is compound_mapcount */
@@ -2329,7 +2332,10 @@ static void __split_huge_page_tail(struct page *head=
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
@@ -2339,10 +2345,15 @@ static void __split_huge_page_tail(struct page *hea=
d, int tail,
 	 * which needs correct compound_head().
 	 */
 	clear_compound_head(page_tail);
+	if (new_order) {
+		prep_compound_page(page_tail, new_order);
+		prep_transhuge_page(page_tail);
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
@@ -2360,7 +2371,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 }
=20
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end)
+		pgoff_t end, unsigned int new_order)
 {
 	struct folio *folio =3D page_folio(page);
 	struct page *head =3D &folio->page;
@@ -2369,10 +2380,11 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
 	unsigned long offset =3D 0;
 	unsigned int order =3D thp_order(head);
 	unsigned int nr =3D thp_nr_pages(head);
+	unsigned int new_nr =3D 1 << new_order;
 	int i;
=20
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, nr, 0);
+	split_page_memcg(head, nr, new_order);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
@@ -2387,42 +2399,50 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
=20
 	ClearPageHasHWPoisoned(head);
=20
-	for (i =3D nr - 1; i >=3D 1; i--) {
-		__split_huge_page_tail(head, i, lruvec, list);
+	for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
+		__split_huge_page_tail(head, i, lruvec, list, new_order);
 		/* Some pages can be beyond EOF: drop them from page cache */
 		if (head[i].index >=3D end) {
 			ClearPageDirty(head + i);
 			__delete_from_page_cache(head + i, NULL);
 			if (shmem_mapping(head->mapping))
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
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
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
 	local_irq_enable();
@@ -2435,7 +2455,14 @@ static void __split_huge_page(struct page *page, str=
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
@@ -2472,36 +2499,60 @@ bool can_split_folio(struct folio *folio, int *pext=
ra_pins)
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
 	struct folio *folio =3D page_folio(page);
 	struct page *head =3D &folio->page;
 	struct deferred_split *ds_queue =3D get_deferred_split_queue(head);
-	XA_STATE(xas, &head->mapping->i_pages, head->index);
+	/* reset xarray order to new order after split */
+	XA_STATE_ORDER(xas, &head->mapping->i_pages, head->index, new_order);
 	struct anon_vma *anon_vma =3D NULL;
 	struct address_space *mapping =3D NULL;
 	int extra_pins, ret;
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
@@ -2582,7 +2633,7 @@ int split_huge_page_to_list(struct page *page, struct=
 list_head *list)
 	if (page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
-			list_del(page_deferred_list(head));
+			list_del_init(page_deferred_list(head));
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
@@ -2592,14 +2643,18 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
 			if (PageSwapBacked(head)) {
 				__mod_lruvec_page_state(head, NR_SHMEM_THPS,
 							-nr);
-			} else {
+			} else if (!new_order) {
+				/*
+				 * Decrease THP stats only if split to normal
+				 * pages
+				 */
 				__mod_lruvec_page_state(head, NR_FILE_THPS,
 							-nr);
 				filemap_nr_thps_dec(mapping);
 			}
 		}
=20
-		__split_huge_page(page, list, end);
+		__split_huge_page(page, list, end, new_order);
 		ret =3D 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
--=20
2.35.1

