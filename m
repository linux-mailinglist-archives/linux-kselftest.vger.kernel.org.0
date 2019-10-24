Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DDEE3D3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 22:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfJXU3M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 16:29:12 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:33368 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfJXU3M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 16:29:12 -0400
Received: by mail-qk1-f202.google.com with SMTP id o184so53648qke.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2019 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6fmPXNGUtlEoTf849fZFK20bPJN5d23mmhiRWe61iWk=;
        b=M6kp70picpVbgwmnUHknqLn4inZ/gs2j0puZKMF3oZBSTmSXOhKwNFw+lnSNCkuAag
         6pP4LsQ2gNzMflXrGHlJB+A3rcwr9/VIHPnioQJYwQBO47nAbDzTjRH670mM+kUkvfd3
         Y2pQLJ+qCUgd+6c4dHk94/cac1Kt/dN3w47+b5bxLuAPjK01A3T0FD6Q068Vdu1SCLHt
         Oy2IdaZvRGL7iRCtrLMJYek3BWO3/cMdXcKrMv3iCkATSaPlzlI6GVMH4sPbtzBf6+yh
         ynDc2sIV1qx4SfisEHAeFxr4dGR/8m4OdKy6cUkftZVtXdR1dE7vTSkJajjnlJrFErdl
         jcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6fmPXNGUtlEoTf849fZFK20bPJN5d23mmhiRWe61iWk=;
        b=n9OGA858kD+VxvLJZ7gi2iFCKljFb7vfT8QozJTxJvkAd1/0k+XgSRS3qZotrooMjs
         drWrAt7SBsQS3XeRzAv4LcsylYuHi+BHibfdQoYkWvAsHpYUSpqWEsHWjUFP4BfAugCQ
         0CGRP2wVZ39TDJ88dGJ/uSwqXcPbT8ndQ2/qTjoNRa2jRP3s8aQUMjl3v2NqILXEC9SU
         y7s9xrgS0BPQpKyn//D8HrEHXj/2Tu7yhIfMBGBuewhdM486348IYBBM5iHfnApaVpwr
         uomFIJ5dLcAX9c8DLw29Wu33k13aMzHwOC00vNlcZAbarliyXUIPhuUboQakHAOWAsXp
         H0xQ==
X-Gm-Message-State: APjAAAWi6Laf7tWQ/Y15Ua2eD6ut0QNXTgp9JerdGgz21ujDlXYVYxfg
        AnICeUVENruXmxS85OP86X9/JL/qqwk1+mp16A==
X-Google-Smtp-Source: APXvYqz30d2AK3m8R7LBMVJ1w1d9AAkMSYXz0t4ycD9X343sxeNPp+yA0YA9P+VmKsbJZuWJB6nvcWqKk91GzSStNQ==
X-Received: by 2002:ac8:2d2d:: with SMTP id n42mr6219529qta.119.1571948950812;
 Thu, 24 Oct 2019 13:29:10 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:28:51 -0700
In-Reply-To: <20191024202858.95342-1-almasrymina@google.com>
Message-Id: <20191024202858.95342-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20191024202858.95342-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v7 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
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
 include/linux/hugetlb_cgroup.h |  67 +++++++++++++---------
 mm/hugetlb.c                   |  17 +++---
 mm/hugetlb_cgroup.c            | 100 +++++++++++++++++++++++++--------
 3 files changed, 130 insertions(+), 54 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 063962f6dfc6a..1bb58a63af586 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -22,27 +22,35 @@ struct hugetlb_cgroup;
  * Minimum page order trackable by hugetlb cgroup.
  * At least 3 pages are necessary for all the tracking information.
  */
-#define HUGETLB_CGROUP_MIN_ORDER	2
+#define HUGETLB_CGROUP_MIN_ORDER 3

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

@@ -52,26 +60,33 @@ static inline bool hugetlb_cgroup_disabled(void)
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
+					    unsigned long nr_pages);
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
@@ -81,28 +96,30 @@ static inline bool hugetlb_cgroup_disabled(void)
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
index 37195cd60a345..325d5454bf168 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1140,7 +1140,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
 	}
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, false), page);
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
@@ -1250,8 +1250,8 @@ void free_huge_page(struct page *page)

 	spin_lock(&hugetlb_lock);
 	clear_page_huge_active(page);
-	hugetlb_cgroup_uncharge_page(hstate_index(h),
-				     pages_per_huge_page(h), page);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, false);
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -1277,7 +1277,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	spin_lock(&hugetlb_lock);
-	set_hugetlb_cgroup(page, NULL);
+	set_hugetlb_cgroup(page, NULL, false);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	spin_unlock(&hugetlb_lock);
@@ -2063,7 +2063,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

-	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
+	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
+					   false);
 	if (ret)
 		goto out_subpool_put;

@@ -2087,7 +2088,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		list_move(&page->lru, &h->hugepage_activelist);
 		/* Fall through */
 	}
-	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
+	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
+				     false);
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2111,7 +2113,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return page;

 out_uncharge_cgroup:
-	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
+	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
+				       false);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 1ed4448ca41d3..854117513979b 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -73,8 +73,12 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
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
@@ -85,18 +89,32 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 	int idx;

 	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
-		struct page_counter *counter = &h_cgroup->hugepage[idx];
 		struct page_counter *parent = NULL;
+		struct page_counter *reserved_parent = NULL;
 		unsigned long limit;
 		int ret;

-		if (parent_h_cgroup)
-			parent = &parent_h_cgroup->hugepage[idx];
-		page_counter_init(counter, parent);
+		if (parent_h_cgroup) {
+			parent = hugetlb_cgroup_get_counter(parent_h_cgroup,
+							    idx, false);
+			reserved_parent = hugetlb_cgroup_get_counter(
+				parent_h_cgroup, idx, true);
+		}
+		page_counter_init(hugetlb_cgroup_get_counter(h_cgroup, idx,
+							     false),
+				  parent);
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
@@ -126,6 +144,26 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(h_cgroup);
 }

+static void hugetlb_cgroup_move_parent_reservation(int idx,
+						   struct hugetlb_cgroup *h_cg)
+{
+	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
+
+	/* Move the reservation counters. */
+	if (!parent_hugetlb_cgroup(h_cg)) {
+		parent = root_h_cgroup;
+		/* root has no limit */
+		page_counter_charge(
+			&root_h_cgroup->reserved_hugepage[idx],
+			page_counter_read(
+				hugetlb_cgroup_get_counter(h_cg, idx, true)));
+	}
+
+	/* Take the pages off the local counter */
+	page_counter_cancel(
+		hugetlb_cgroup_get_counter(h_cg, idx, true),
+		page_counter_read(hugetlb_cgroup_get_counter(h_cg, idx, true)));
+}

 /*
  * Should be called with hugetlb_lock held.
@@ -142,7 +180,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	struct hugetlb_cgroup *page_hcg;
 	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);

-	page_hcg = hugetlb_cgroup_from_page(page);
+	page_hcg = hugetlb_cgroup_from_page(page, false);
 	/*
 	 * We can have pages in active list without any cgroup
 	 * ie, hugepage with less than 3 pages. We can safely
@@ -161,7 +199,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	/* Take the pages off the local counter */
 	page_counter_cancel(counter, nr_pages);

-	set_hugetlb_cgroup(page, parent);
+	set_hugetlb_cgroup(page, parent, false);
 out:
 	return;
 }
@@ -180,6 +218,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 	do {
 		for_each_hstate(h) {
 			spin_lock(&hugetlb_lock);
+			hugetlb_cgroup_move_parent_reservation(idx, h_cg);
 			list_for_each_entry(page, &h->hugepage_activelist, lru)
 				hugetlb_cgroup_move_parent(idx, h_cg, page);

@@ -191,7 +230,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 }

 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-				 struct hugetlb_cgroup **ptr)
+				 struct hugetlb_cgroup **ptr, bool reserved)
 {
 	int ret = 0;
 	struct page_counter *counter;
@@ -214,8 +253,11 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 	}
 	rcu_read_unlock();

-	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages, &counter))
+	if (!page_counter_try_charge(hugetlb_cgroup_get_counter(h_cg, idx,
+								reserved),
+				     nr_pages, &counter)) {
 		ret = -ENOMEM;
+	}
 	css_put(&h_cg->css);
 done:
 	*ptr = h_cg;
@@ -225,12 +267,12 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
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

@@ -238,23 +280,26 @@ void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
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
 	return;
 }

 void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-				    struct hugetlb_cgroup *h_cg)
+				    struct hugetlb_cgroup *h_cg, bool reserved)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
@@ -262,8 +307,17 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
 		return;

-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
-	return;
+	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, reserved),
+			      nr_pages);
+}
+
+void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
+				     unsigned long nr_pages)
+{
+	if (hugetlb_cgroup_disabled() || !p)
+		return;
+
+	page_counter_uncharge(p, nr_pages);
 }

 static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
@@ -475,6 +529,7 @@ void __init hugetlb_cgroup_file_init(void)
 void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 {
 	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg_reservation;
 	struct hstate *h = page_hstate(oldhpage);

 	if (hugetlb_cgroup_disabled())
@@ -482,11 +537,12 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)

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
2.24.0.rc0.303.g954a862665-goog
