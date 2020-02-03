Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A94151312
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 00:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCXXF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 18:23:05 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:52770 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBCXXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 18:23:05 -0500
Received: by mail-qk1-f202.google.com with SMTP id q2so3871973qkq.19
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 15:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=evXlvsRkC45l1FNqZkERSSWKsaTTKSNm4FsMNo1DiIA=;
        b=S2n1jBR086gWrtZcWWgc0nUQP8zpuXeYwqrT9aJ2C8lGM3wzWIPpokEK5S2JOS/p6v
         6b08w41FKC3B4IarwKvRdYqbZruQSNYKk859nd0QDHpSXXiH7UYst6yD9Rn5VKs2KRpo
         2G5vl6lhcpvMLUgZaMW0vNYHX3gTo9qo/k5jnl7oRTePyaoQk0MmpcS5aCKvd89buHOk
         3FdxFvd+WnoomjrpcgEwC7jQX1u4dt0+gNNKFV1BEvrSa21Am6U53YWHibzWVow1ceI0
         4va53TrZnhs0Seu1OTmVToLnB6KPHiN6N4aHBV9P1CamzLT2v8+LvUqgUpXv/fcq4DcC
         P7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=evXlvsRkC45l1FNqZkERSSWKsaTTKSNm4FsMNo1DiIA=;
        b=M5O1mJSVlM7yYar5U4Q5hhY8XYVlnQ3VXsD1vw4sHtPJEbaxyxaOKMB7pnItKxvGDn
         ZCBVqnBpi/efNHeENWYNZ/sGlzYcQwEPXxKGi+/I2BlYXZT8pBkl5hK2L6Hkptznf+Ch
         fQLuQwOohQ7fphquHUTm+cUAua3sa12OI3PRIlC7K7wHA7wkeoKqfFgHW0r8vI7lUPXz
         ZKcsjGGbXBvwLhGyRAEz1xr780VOSrKN8klWcS14x3hwES/rn73d4d71eMMlBQ5eTK2L
         xwjtcGN3ZmnaggHafJkM/005J2/Ya9evyxI+6ZOEt7FHuFzWm2zuxMFYwt0KJZ9guVpZ
         APRA==
X-Gm-Message-State: APjAAAUNx0F7qP3YcE/YWLgta6PW2mbDhH68Wz3byuESG7AetiXnX59M
        i5WExKKCTOHTILVvyJUsm35BHs6Rc9hR7BPNFg==
X-Google-Smtp-Source: APXvYqxiYK9IzCRuv71AIn3vrEUndZLywbQR/89HZCYAIH7bJ7ucCijhI3cJIgueExlb4q99hodZf0KSqlhFd2P4NQ==
X-Received: by 2002:aed:3e53:: with SMTP id m19mr26284236qtf.387.1580772183552;
 Mon, 03 Feb 2020 15:23:03 -0800 (PST)
Date:   Mon,  3 Feb 2020 15:22:41 -0800
In-Reply-To: <20200203232248.104733-1-almasrymina@google.com>
Message-Id: <20200203232248.104733-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v11 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
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
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: David Rientjes <rientjes@google.com>

---

Changes in v11:
- Changed all 'reserved' or 'reservation' to 'rsvd' to reflect the user
interface.
- Expanded comment that describes tail pages usage.
facing naming.
Changes in v10:
- Added missing VM_BUG_ON
Changes in V9:
- Fixed HUGETLB_CGROUP_MIN_ORDER.
- Minor variable name update.
- Moved some init/cleanup code from later patches in the series to this patch.
- Updated reparenting of reservation accounting.

---
 include/linux/hugetlb_cgroup.h |  66 +++++++++++++--------
 mm/hugetlb.c                   |  19 +++---
 mm/hugetlb_cgroup.c            | 103 ++++++++++++++++++++++++---------
 3 files changed, 128 insertions(+), 60 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 063962f6dfc6a..91bc5e920e9d0 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -20,29 +20,38 @@
 struct hugetlb_cgroup;
 /*
  * Minimum page order trackable by hugetlb cgroup.
- * At least 3 pages are necessary for all the tracking information.
+ * At least 4 pages are necessary for all the tracking information.
+ * The second tail page (hpage[2]) is the fault usage cgroup.
+ * The third tail page (hpage[3]) is the reservation usage cgroup.
  */
 #define HUGETLB_CGROUP_MIN_ORDER	2

 #ifdef CONFIG_CGROUP_HUGETLB

-static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
+static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
+							      bool rsvd)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);

 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
-	return (struct hugetlb_cgroup *)page[2].private;
+	if (rsvd)
+		return (struct hugetlb_cgroup *)page[3].private;
+	else
+		return (struct hugetlb_cgroup *)page[2].private;
 }

-static inline
-int set_hugetlb_cgroup(struct page *page, struct hugetlb_cgroup *h_cg)
+static inline int set_hugetlb_cgroup(struct page *page,
+				     struct hugetlb_cgroup *h_cg, bool rsvd)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);

 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return -1;
-	page[2].private	= (unsigned long)h_cg;
+	if (rsvd)
+		page[3].private = (unsigned long)h_cg;
+	else
+		page[2].private = (unsigned long)h_cg;
 	return 0;
 }

@@ -52,26 +61,33 @@ static inline bool hugetlb_cgroup_disabled(void)
 }

 extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-					struct hugetlb_cgroup **ptr);
+					struct hugetlb_cgroup **ptr, bool rsvd);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
-					 struct page *page);
+					 struct page *page, bool rsvd);
 extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-					 struct page *page);
+					 struct page *page, bool rsvd);
+
 extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-					   struct hugetlb_cgroup *h_cg);
+					   struct hugetlb_cgroup *h_cg,
+					   bool rsvd);
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
+							      bool rsvd)
 {
 	return NULL;
 }

-static inline
-int set_hugetlb_cgroup(struct page *page, struct hugetlb_cgroup *h_cg)
+static inline int set_hugetlb_cgroup(struct page *page,
+				     struct hugetlb_cgroup *h_cg, bool rsvd)
 {
 	return 0;
 }
@@ -81,28 +97,28 @@ static inline bool hugetlb_cgroup_disabled(void)
 	return true;
 }

-static inline int
-hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-			     struct hugetlb_cgroup **ptr)
+static inline int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
+					       struct hugetlb_cgroup **ptr,
+					       bool rsvd)
 {
 	return 0;
 }

-static inline void
-hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
-			     struct hugetlb_cgroup *h_cg,
-			     struct page *page)
+static inline void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
+						struct hugetlb_cgroup *h_cg,
+						struct page *page, bool rsvd)
 {
 }

-static inline void
-hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages, struct page *page)
+static inline void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
+						struct page *page, bool rsvd)
 {
 }

-static inline void
-hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-			       struct hugetlb_cgroup *h_cg)
+static inline void hugetlb_cgroup_uncharge_cgroup(int idx,
+						  unsigned long nr_pages,
+						  struct hugetlb_cgroup *h_cg,
+						  bool rsvd)
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
index cd1f44775259c..640555d7f78c6 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -97,8 +97,12 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
 	int idx;

 	for (idx = 0; idx < hugetlb_max_hstate; idx++) {
-		if (page_counter_read(&h_cg->hugepage[idx]))
+		if (page_counter_read(hugetlb_cgroup_counter_from_cgroup(
+			    h_cg, idx, true)) ||
+		    page_counter_read(hugetlb_cgroup_counter_from_cgroup(
+			    h_cg, idx, false))) {
 			return true;
+		}
 	}
 	return false;
 }
@@ -109,18 +113,34 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 	int idx;

 	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
-		struct page_counter *counter = &h_cgroup->hugepage[idx];
-		struct page_counter *parent = NULL;
+		struct page_counter *fault_parent = NULL;
+		struct page_counter *rsvd_parent = NULL;
 		unsigned long limit;
 		int ret;

-		if (parent_h_cgroup)
-			parent = &parent_h_cgroup->hugepage[idx];
-		page_counter_init(counter, parent);
+		if (parent_h_cgroup) {
+			fault_parent = hugetlb_cgroup_counter_from_cgroup(
+				parent_h_cgroup, idx, false);
+			rsvd_parent = hugetlb_cgroup_counter_from_cgroup(
+				parent_h_cgroup, idx, true);
+		}
+		page_counter_init(hugetlb_cgroup_counter_from_cgroup(
+					  h_cgroup, idx, false),
+				  fault_parent);
+		page_counter_init(hugetlb_cgroup_counter_from_cgroup(h_cgroup,
+								     idx, true),
+				  rsvd_parent);

 		limit = round_down(PAGE_COUNTER_MAX,
 				   1 << huge_page_order(&hstates[idx]));
-		ret = page_counter_set_max(counter, limit);
+
+		ret = page_counter_set_max(hugetlb_cgroup_counter_from_cgroup(
+						   h_cgroup, idx, false),
+					   limit);
+		VM_BUG_ON(ret);
+		ret = page_counter_set_max(
+			hugetlb_cgroup_counter_from_cgroup(h_cgroup, idx, true),
+			limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -150,7 +170,6 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(h_cgroup);
 }

-
 /*
  * Should be called with hugetlb_lock held.
  * Since we are holding hugetlb_lock, pages cannot get moved from
@@ -166,7 +185,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	struct hugetlb_cgroup *page_hcg;
 	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);

-	page_hcg = hugetlb_cgroup_from_page(page);
+	page_hcg = hugetlb_cgroup_from_page(page, false);
 	/*
 	 * We can have pages in active list without any cgroup
 	 * ie, hugepage with less than 3 pages. We can safely
@@ -185,7 +204,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	/* Take the pages off the local counter */
 	page_counter_cancel(counter, nr_pages);

-	set_hugetlb_cgroup(page, parent);
+	set_hugetlb_cgroup(page, parent, false);
 out:
 	return;
 }
@@ -228,7 +247,7 @@ static inline void hugetlb_event(struct hugetlb_cgroup *hugetlb, int idx,
 }

 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-				 struct hugetlb_cgroup **ptr)
+				 struct hugetlb_cgroup **ptr, bool rsvd)
 {
 	int ret = 0;
 	struct page_counter *counter;
@@ -251,13 +270,20 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 	}
 	rcu_read_unlock();

-	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
-				     &counter)) {
+	if (!page_counter_try_charge(
+		    hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
+		    nr_pages, &counter)) {
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
+	if (!rsvd)
+		css_put(&h_cg->css);
 done:
 	*ptr = h_cg;
 	return ret;
@@ -266,12 +292,12 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 /* Should be called with hugetlb_lock held */
 void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
-				  struct page *page)
+				  struct page *page, bool rsvd)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;

-	set_hugetlb_cgroup(page, h_cg);
+	set_hugetlb_cgroup(page, h_cg, rsvd);
 	return;
 }

@@ -279,23 +305,29 @@ void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
  * Should be called with hugetlb_lock held
  */
 void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-				  struct page *page)
+				  struct page *page, bool rsvd)
 {
 	struct hugetlb_cgroup *h_cg;

 	if (hugetlb_cgroup_disabled())
 		return;
 	lockdep_assert_held(&hugetlb_lock);
-	h_cg = hugetlb_cgroup_from_page(page);
+	h_cg = hugetlb_cgroup_from_page(page, rsvd);
 	if (unlikely(!h_cg))
 		return;
-	set_hugetlb_cgroup(page, NULL);
-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	set_hugetlb_cgroup(page, NULL, rsvd);
+
+	page_counter_uncharge(
+		hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd), nr_pages);
+
+	if (rsvd)
+		css_put(&h_cg->css);
+
 	return;
 }

 void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-				    struct hugetlb_cgroup *h_cg)
+				    struct hugetlb_cgroup *h_cg, bool rsvd)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
@@ -303,8 +335,22 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
 		return;

-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
-	return;
+	page_counter_uncharge(
+		hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd), nr_pages);
+
+	if (rsvd)
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
@@ -450,8 +496,7 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));

 	counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
-	rsvd_counter =
-		&h_cg->rsvd_hugepage[MEMFILE_IDX(of_cft(of)->private)];
+	rsvd_counter = &h_cg->rsvd_hugepage[MEMFILE_IDX(of_cft(of)->private)];

 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_MAX_USAGE:
@@ -676,6 +721,7 @@ void __init hugetlb_cgroup_file_init(void)
 void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 {
 	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg_rsvd;
 	struct hstate *h = page_hstate(oldhpage);

 	if (hugetlb_cgroup_disabled())
@@ -683,11 +729,12 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)

 	VM_BUG_ON_PAGE(!PageHuge(oldhpage), oldhpage);
 	spin_lock(&hugetlb_lock);
-	h_cg = hugetlb_cgroup_from_page(oldhpage);
-	set_hugetlb_cgroup(oldhpage, NULL);
+	h_cg = hugetlb_cgroup_from_page(oldhpage, false);
+	h_cg_rsvd = hugetlb_cgroup_from_page(oldhpage, true);
+	set_hugetlb_cgroup(oldhpage, NULL, false);

 	/* move the h_cg details to new cgroup */
-	set_hugetlb_cgroup(newhpage, h_cg);
+	set_hugetlb_cgroup(newhpage, h_cg_rsvd, true);
 	list_move(&newhpage->lru, &h->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	return;
--
2.25.0.341.g760bfbb309-goog
