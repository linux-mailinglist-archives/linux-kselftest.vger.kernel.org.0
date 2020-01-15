Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4C13B6D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 02:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgAOB07 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 20:26:59 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39386 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgAOB06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 20:26:58 -0500
Received: by mail-pl1-f201.google.com with SMTP id p15so937357plq.6
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2020 17:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VD9B9XQiTIZ/I3GgP2atJmksN68hbJNGgZeyi4+Kld8=;
        b=lGs4BLNH5UJp8PirX+0cIBqHW95lTXQIuPY018sNrBns1BSssPpXT3HuuO7QeQGuIe
         u9Q/LVnpf1MptbB+AzYedmLDV26mXSRP8MpWL9lTvLGWMGIbRwOGxSxnCBMk7sd+o4yo
         s2Zay07dkVOJQeRnbeIva9zpUHc1dkmAq8FzgR6QiQ46BAqfCR0kZEteEgb5gRb6U9oz
         WllB3SFiOGY/FGJCcJ5dmT553Kfl75iBs9yhf92PpZWZc/8Q5FtErBGT/5i4DdpAiMNI
         3/B44ps4npXEDY0hN7Vl2HehrtsCkNx+S7DP4joBNKGGqr/75S+33NtwDRyTJNWWN4my
         NZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VD9B9XQiTIZ/I3GgP2atJmksN68hbJNGgZeyi4+Kld8=;
        b=ozrrorm+xZKoKjx0dxkoyIcHVXLaVKRWPhDpSdkYuH9yOKXF0ytTjMq3qoqMBLE7Oh
         MeHwCXLc1BktbRpvW1L15Pgn2MNFCbs2v10oQVOMVYGGqZ+0U+I0cut8v3d3XJgOyhvL
         pkkviawdGDqlsSyWjNUx6N8/kxwllhzhaxinXjeuQ2HK5Ppde0M5jggLjjYSKuoCvzFM
         jLUCc26WBsnVos8jM7LX54KXGh6JTzVB5b6zOR7MKP8ztLfppNYgnXX7SWPCYEbXTCK3
         Lw3fcA8qK3LSIbyxQxdTdd5Hd49uUVUSdFmNS45s9/dfOcjnRi9p8I8WUFGCUo4tWpdT
         pttQ==
X-Gm-Message-State: APjAAAWPUFYwhtbBrUz/eP56Y4MsZJpxyNk6nPaPk05jLvPeoAX/oBOx
        aiAtpvAXBqASdjJPaizzpOJ0e5Sac/PzCXWduw==
X-Google-Smtp-Source: APXvYqy8wu+rN6XIvdPZvljPhhlginlJ4IfOUPOeV7wb2cEpfAUMfQvkqZxabEz78XjhuB2+EONpJS7WCBe000q0UA==
X-Received: by 2002:a63:e84d:: with SMTP id a13mr31663837pgk.274.1579051617276;
 Tue, 14 Jan 2020 17:26:57 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:26:45 -0800
In-Reply-To: <20200115012651.228058-1-almasrymina@google.com>
Message-Id: <20200115012651.228058-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v10 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com, rientjes@google.com, shakeelb@google.com
Cc:     shuah@kernel.org, almasrymina@google.com, gthelen@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Augments hugetlb_cgroup_charge_cgroup to be able to charge hugetlb
usage or hugetlb reservation counter.

Adds a new interface to uncharge a hugetlb_cgroup counter via
hugetlb_cgroup_uncharge_counter.

Integrates the counter with hugetlb_cgroup, via hugetlb_cgroup_init,
hugetlb_cgroup_have_usage, and hugetlb_cgroup_css_offline.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v10:
- Added missing VM_BUG_ON
Changes in V9:
- Fixed HUGETLB_CGROUP_MIN_ORDER.
- Minor variable name update.
- Moved some init/cleanup code from later patches in the series to this patch.
- Updated reparenting of reservation accounting.

---
 include/linux/hugetlb_cgroup.h | 68 ++++++++++++++---------
 mm/hugetlb.c                   | 19 ++++---
 mm/hugetlb_cgroup.c            | 99 +++++++++++++++++++++++++---------
 3 files changed, 128 insertions(+), 58 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 063962f6dfc6a..eab8a70d5bcb5 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -20,29 +20,37 @@
 struct hugetlb_cgroup;
 /*
  * Minimum page order trackable by hugetlb cgroup.
- * At least 3 pages are necessary for all the tracking information.
+ * At least 4 pages are necessary for all the tracking information.
  */
 #define HUGETLB_CGROUP_MIN_ORDER	2

 #ifdef CONFIG_CGROUP_HUGETLB

-static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
+static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
+							      bool reserved)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);

 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
-	return (struct hugetlb_cgroup *)page[2].private;
+	if (reserved)
+		return (struct hugetlb_cgroup *)page[3].private;
+	else
+		return (struct hugetlb_cgroup *)page[2].private;
 }

-static inline
-int set_hugetlb_cgroup(struct page *page, struct hugetlb_cgroup *h_cg)
+static inline int set_hugetlb_cgroup(struct page *page,
+				     struct hugetlb_cgroup *h_cg,
+				     bool reservation)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);

 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return -1;
-	page[2].private	= (unsigned long)h_cg;
+	if (reservation)
+		page[3].private = (unsigned long)h_cg;
+	else
+		page[2].private = (unsigned long)h_cg;
 	return 0;
 }

@@ -52,26 +60,34 @@ static inline bool hugetlb_cgroup_disabled(void)
 }

 extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-					struct hugetlb_cgroup **ptr);
+					struct hugetlb_cgroup **ptr,
+					bool reserved);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
-					 struct page *page);
+					 struct page *page, bool reserved);
 extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-					 struct page *page);
+					 struct page *page, bool reserved);
+
 extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-					   struct hugetlb_cgroup *h_cg);
+					   struct hugetlb_cgroup *h_cg,
+					   bool reserved);
+extern void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
+					    unsigned long nr_pages,
+					    struct cgroup_subsys_state *css);
+
 extern void hugetlb_cgroup_file_init(void) __init;
 extern void hugetlb_cgroup_migrate(struct page *oldhpage,
 				   struct page *newhpage);

 #else
-static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
+static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
+							      bool reserved)
 {
 	return NULL;
 }

-static inline
-int set_hugetlb_cgroup(struct page *page, struct hugetlb_cgroup *h_cg)
+static inline int set_hugetlb_cgroup(struct page *page,
+				     struct hugetlb_cgroup *h_cg, bool reserved)
 {
 	return 0;
 }
@@ -81,28 +97,30 @@ static inline bool hugetlb_cgroup_disabled(void)
 	return true;
 }

-static inline int
-hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-			     struct hugetlb_cgroup **ptr)
+static inline int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
+					       struct hugetlb_cgroup **ptr,
+					       bool reserved)
 {
 	return 0;
 }

-static inline void
-hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
-			     struct hugetlb_cgroup *h_cg,
-			     struct page *page)
+static inline void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
+						struct hugetlb_cgroup *h_cg,
+						struct page *page,
+						bool reserved)
 {
 }

-static inline void
-hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages, struct page *page)
+static inline void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
+						struct page *page,
+						bool reserved)
 {
 }

-static inline void
-hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-			       struct hugetlb_cgroup *h_cg)
+static inline void hugetlb_cgroup_uncharge_cgroup(int idx,
+						  unsigned long nr_pages,
+						  struct hugetlb_cgroup *h_cg,
+						  bool reserved)
 {
 }

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd8737a94bec4..62a4cf3db4090 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1068,7 +1068,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
 	}
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, false), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, true), page);
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
@@ -1178,8 +1179,8 @@ static void __free_huge_page(struct page *page)

 	spin_lock(&hugetlb_lock);
 	clear_page_huge_active(page);
-	hugetlb_cgroup_uncharge_page(hstate_index(h),
-				     pages_per_huge_page(h), page);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, false);
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -1253,7 +1254,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	spin_lock(&hugetlb_lock);
-	set_hugetlb_cgroup(page, NULL);
+	set_hugetlb_cgroup(page, NULL, false);
+	set_hugetlb_cgroup(page, NULL, true);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	spin_unlock(&hugetlb_lock);
@@ -2039,7 +2041,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

-	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
+	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
+					   false);
 	if (ret)
 		goto out_subpool_put;

@@ -2063,7 +2066,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		list_move(&page->lru, &h->hugepage_activelist);
 		/* Fall through */
 	}
-	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
+	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
+				     false);
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2087,7 +2091,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return page;

 out_uncharge_cgroup:
-	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
+	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
+				       false);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 209f9b9604d34..c434f69f38354 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -96,8 +96,12 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
 	int idx;

 	for (idx = 0; idx < hugetlb_max_hstate; idx++) {
-		if (page_counter_read(&h_cg->hugepage[idx]))
+		if (page_counter_read(
+			    hugetlb_cgroup_get_counter(h_cg, idx, true)) ||
+		    page_counter_read(
+			    hugetlb_cgroup_get_counter(h_cg, idx, false))) {
 			return true;
+		}
 	}
 	return false;
 }
@@ -108,18 +112,33 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 	int idx;

 	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
-		struct page_counter *counter = &h_cgroup->hugepage[idx];
-		struct page_counter *parent = NULL;
+		struct page_counter *fault_parent = NULL;
+		struct page_counter *reserved_parent = NULL;
 		unsigned long limit;
 		int ret;

-		if (parent_h_cgroup)
-			parent = &parent_h_cgroup->hugepage[idx];
-		page_counter_init(counter, parent);
+		if (parent_h_cgroup) {
+			fault_parent = hugetlb_cgroup_get_counter(
+				parent_h_cgroup, idx, false);
+			reserved_parent = hugetlb_cgroup_get_counter(
+				parent_h_cgroup, idx, true);
+		}
+		page_counter_init(hugetlb_cgroup_get_counter(h_cgroup, idx,
+							     false),
+				  fault_parent);
+		page_counter_init(hugetlb_cgroup_get_counter(h_cgroup, idx,
+							     true),
+				  reserved_parent);

 		limit = round_down(PAGE_COUNTER_MAX,
 				   1 << huge_page_order(&hstates[idx]));
-		ret = page_counter_set_max(counter, limit);
+
+		ret = page_counter_set_max(
+			hugetlb_cgroup_get_counter(h_cgroup, idx, false),
+			limit);
+		VM_BUG_ON(ret);
+		ret = page_counter_set_max(
+			hugetlb_cgroup_get_counter(h_cgroup, idx, true), limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -149,7 +168,6 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(h_cgroup);
 }

-
 /*
  * Should be called with hugetlb_lock held.
  * Since we are holding hugetlb_lock, pages cannot get moved from
@@ -165,7 +183,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	struct hugetlb_cgroup *page_hcg;
 	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);

-	page_hcg = hugetlb_cgroup_from_page(page);
+	page_hcg = hugetlb_cgroup_from_page(page, false);
 	/*
 	 * We can have pages in active list without any cgroup
 	 * ie, hugepage with less than 3 pages. We can safely
@@ -184,7 +202,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	/* Take the pages off the local counter */
 	page_counter_cancel(counter, nr_pages);

-	set_hugetlb_cgroup(page, parent);
+	set_hugetlb_cgroup(page, parent, false);
 out:
 	return;
 }
@@ -227,7 +245,7 @@ static inline void hugetlb_event(struct hugetlb_cgroup *hugetlb, int idx,
 }

 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-				 struct hugetlb_cgroup **ptr)
+				 struct hugetlb_cgroup **ptr, bool reserved)
 {
 	int ret = 0;
 	struct page_counter *counter;
@@ -250,13 +268,20 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 	}
 	rcu_read_unlock();

-	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
-				     &counter)) {
+	if (!page_counter_try_charge(hugetlb_cgroup_get_counter(h_cg, idx,
+								reserved),
+				     nr_pages, &counter)) {
 		ret = -ENOMEM;
 		hugetlb_event(hugetlb_cgroup_from_counter(counter, idx), idx,
 			      HUGETLB_MAX);
+		css_put(&h_cg->css);
+		goto done;
 	}
-	css_put(&h_cg->css);
+	/* Reservations take a reference to the css because they do not get
+	 * reparented.
+	 */
+	if (!reserved)
+		css_put(&h_cg->css);
 done:
 	*ptr = h_cg;
 	return ret;
@@ -265,12 +290,12 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 /* Should be called with hugetlb_lock held */
 void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
-				  struct page *page)
+				  struct page *page, bool reserved)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;

-	set_hugetlb_cgroup(page, h_cg);
+	set_hugetlb_cgroup(page, h_cg, reserved);
 	return;
 }

@@ -278,23 +303,29 @@ void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
  * Should be called with hugetlb_lock held
  */
 void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-				  struct page *page)
+				  struct page *page, bool reserved)
 {
 	struct hugetlb_cgroup *h_cg;

 	if (hugetlb_cgroup_disabled())
 		return;
 	lockdep_assert_held(&hugetlb_lock);
-	h_cg = hugetlb_cgroup_from_page(page);
+	h_cg = hugetlb_cgroup_from_page(page, reserved);
 	if (unlikely(!h_cg))
 		return;
-	set_hugetlb_cgroup(page, NULL);
-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	set_hugetlb_cgroup(page, NULL, reserved);
+
+	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, reserved),
+			      nr_pages);
+
+	if (reserved)
+		css_put(&h_cg->css);
+
 	return;
 }

 void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-				    struct hugetlb_cgroup *h_cg)
+				    struct hugetlb_cgroup *h_cg, bool reserved)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
@@ -302,8 +333,22 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
 		return;

-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
-	return;
+	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, reserved),
+			      nr_pages);
+
+	if (reserved)
+		css_put(&h_cg->css);
+}
+
+void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
+				     unsigned long nr_pages,
+				     struct cgroup_subsys_state *css)
+{
+	if (hugetlb_cgroup_disabled() || !p || !css)
+		return;
+
+	page_counter_uncharge(p, nr_pages);
+	css_put(css);
 }

 enum {
@@ -675,6 +720,7 @@ void __init hugetlb_cgroup_file_init(void)
 void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 {
 	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg_reservation;
 	struct hstate *h = page_hstate(oldhpage);

 	if (hugetlb_cgroup_disabled())
@@ -682,11 +728,12 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)

 	VM_BUG_ON_PAGE(!PageHuge(oldhpage), oldhpage);
 	spin_lock(&hugetlb_lock);
-	h_cg = hugetlb_cgroup_from_page(oldhpage);
-	set_hugetlb_cgroup(oldhpage, NULL);
+	h_cg = hugetlb_cgroup_from_page(oldhpage, false);
+	h_cg_reservation = hugetlb_cgroup_from_page(oldhpage, true);
+	set_hugetlb_cgroup(oldhpage, NULL, false);

 	/* move the h_cg details to new cgroup */
-	set_hugetlb_cgroup(newhpage, h_cg);
+	set_hugetlb_cgroup(newhpage, h_cg_reservation, true);
 	list_move(&newhpage->lru, &h->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	return;
--
2.25.0.rc1.283.g88dfdc4193-goog
