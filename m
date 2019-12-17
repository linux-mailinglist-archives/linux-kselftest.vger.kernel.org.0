Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2817123A9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2019 00:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfLQXQY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 18:16:24 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44489 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfLQXQW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 18:16:22 -0500
Received: by mail-pf1-f202.google.com with SMTP id r127so24074pfc.11
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2019 15:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1RAezW9fLf3nXbYReNvBadjhkwd8YvlVOv26vWHnjgE=;
        b=SL/DQW1byLq/lhsQHThgUbmA8kcQVhYlh/ekDbDBXmH+hVMAXdRUJL/WeE72qsJsqu
         dSYKxaMgcoSqU4+OsrNmZLi+0lHxxsMmvd0t8tyM7e6pfcJn4/Jr/uyw+O9d+lv4MkID
         YLXHFSpfw6xpdIiCOAdNtEIWEofrWID+XIHwPtGFo9NGeNOaF8umq6WBqA+7BTToLs0z
         RHGCTcJpQRo4Welu5HtkLd9edGE4yjCi7bbaKHjSmxbe+ewylglCu/TTFYtWjR4HaA7u
         JOQm8+ZrZ7z5mJzr6KrGuRywSrUDyyl6wOTF+OBkPo++Qz73i5QyGdrRyd6EiVuHhbNr
         CGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1RAezW9fLf3nXbYReNvBadjhkwd8YvlVOv26vWHnjgE=;
        b=fsqmD1wuxxxlzXmIS5T6KNYt7qlttqaK/cAJF/7Ml8TPqNoBgxaLNN7Hn9sAnTiD22
         ZX5z503dlNGL10PACpWEfGos+6s3qgtplecDsLAT/DBGBlPDO0uuzPR+CuLc2VcOCuC6
         2VKR/hYsGw04yz4OlGsM9D3q1Hbbh0q8iLrOPyvM3T/J7+82RmOzkdImcKulSN89Pdrg
         C1ldrjQ2eF0yZHMwi18y0/9AgpFqL54px/Drw5XIgAHAuofWA3UG8yDm7cTEgDyaLQ6U
         /dTnSNf5ICflCi7z7CnmTTZrw27+osbBWK4suFNA8VAijeJw6uQ0kzsckUjnuCTMyZho
         JZlw==
X-Gm-Message-State: APjAAAVEPEak52s2dtix1GLr9bPJxgqoIddNOZb1sahBKx3ZMdheIuZc
        8JmdI6hHd6CEYFJjR4HKYdVEaAXCf2E9XIkolw==
X-Google-Smtp-Source: APXvYqySX/etUuoiWTDisCilyD4xDjwWW6Dl3celLpvw2iAE+pfwWOSBff6e+yFfQSjp+vRAKE+ml6TBdAdR06eOVw==
X-Received: by 2002:a63:3484:: with SMTP id b126mr27602463pga.17.1576624581762;
 Tue, 17 Dec 2019 15:16:21 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:16:09 -0800
In-Reply-To: <20191217231615.164161-1-almasrymina@google.com>
Message-Id: <20191217231615.164161-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v9 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
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

Changes in V9:
- Fixed HUGETLB_CGROUP_MIN_ORDER.
- Minor variable name update.
- Moved some init/cleanup code from later patches in the series to this patch.
- Updated reparenting of reservation accounting.

---
 include/linux/hugetlb_cgroup.h | 68 ++++++++++++++---------
 mm/hugetlb.c                   | 19 ++++---
 mm/hugetlb_cgroup.c            | 98 +++++++++++++++++++++++++---------
 3 files changed, 127 insertions(+), 58 deletions(-)

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
index ac65bb5e38ac2..e6e8240f1718c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1067,7 +1067,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
 	}
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, false), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, true), page);
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
@@ -1177,8 +1178,8 @@ void free_huge_page(struct page *page)

 	spin_lock(&hugetlb_lock);
 	clear_page_huge_active(page);
-	hugetlb_cgroup_uncharge_page(hstate_index(h),
-				     pages_per_huge_page(h), page);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, false);
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -1204,7 +1205,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	spin_lock(&hugetlb_lock);
-	set_hugetlb_cgroup(page, NULL);
+	set_hugetlb_cgroup(page, NULL, false);
+	set_hugetlb_cgroup(page, NULL, true);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	spin_unlock(&hugetlb_lock);
@@ -1990,7 +1992,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

-	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
+	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
+					   false);
 	if (ret)
 		goto out_subpool_put;

@@ -2014,7 +2017,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		list_move(&page->lru, &h->hugepage_activelist);
 		/* Fall through */
 	}
-	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
+	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
+				     false);
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2038,7 +2042,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return page;

 out_uncharge_cgroup:
-	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
+	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
+				       false);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 35415af9ed26f..b03270b0d5833 100644
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
@@ -108,18 +112,32 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
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
+		ret = page_counter_set_max(
+			hugetlb_cgroup_get_counter(h_cgroup, idx, true), limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -149,7 +167,6 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(h_cgroup);
 }

-
 /*
  * Should be called with hugetlb_lock held.
  * Since we are holding hugetlb_lock, pages cannot get moved from
@@ -165,7 +182,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	struct hugetlb_cgroup *page_hcg;
 	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);

-	page_hcg = hugetlb_cgroup_from_page(page);
+	page_hcg = hugetlb_cgroup_from_page(page, false);
 	/*
 	 * We can have pages in active list without any cgroup
 	 * ie, hugepage with less than 3 pages. We can safely
@@ -184,7 +201,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	/* Take the pages off the local counter */
 	page_counter_cancel(counter, nr_pages);

-	set_hugetlb_cgroup(page, parent);
+	set_hugetlb_cgroup(page, parent, false);
 out:
 	return;
 }
@@ -227,7 +244,7 @@ static inline void hugetlb_event(struct hugetlb_cgroup *hugetlb, int idx,
 }

 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-				 struct hugetlb_cgroup **ptr)
+				 struct hugetlb_cgroup **ptr, bool reserved)
 {
 	int ret = 0;
 	struct page_counter *counter;
@@ -250,13 +267,20 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
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
@@ -265,12 +289,12 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
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

@@ -278,23 +302,29 @@ void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
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
@@ -302,8 +332,22 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
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
@@ -678,6 +722,7 @@ void __init hugetlb_cgroup_file_init(void)
 void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 {
 	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg_reservation;
 	struct hstate *h = page_hstate(oldhpage);

 	if (hugetlb_cgroup_disabled())
@@ -685,11 +730,12 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)

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
2.24.1.735.g03f4e72817-goog
