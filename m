Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35C4B85D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2019 00:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407177AbfISWYd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 18:24:33 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39403 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407199AbfISWYd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 18:24:33 -0400
Received: by mail-pl1-f202.google.com with SMTP id d11so3085774plo.6
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2019 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+NcLR0j8oIkkrKRFig4Ivx79n0Rsn8K5jx0s8Am1QMc=;
        b=alBdQ/EZ13ksHIaeau6L5RjvgbvhN1X3ybaU3P/gT5wdxoOczAe9umIkdbhmPEwZ2P
         UwuZgMW10wJt+f01DOQiSeho2YQydfUQid15+jC+skYatAqNDAKjm26sn/JEZ4fyIPTp
         Lsc0uoT3pEH5pU+3vJz9IUSaMhhY//Bd30m33U7LG1VNjYSrmfwF/1BDKgEb3ytt3EDk
         7PaJq+eblBmqFVjq42vQYtvxuUkH06wObieTyxv8wRM7t/Uwr6BeiODB8SvkaQjO7Bch
         MLZTAbx/5fa7wPJjgZXDrz9PJ2dDIwwmM7s/qCn/sk+SqsTAbnDgc8IPemikzY7OFP7W
         l/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+NcLR0j8oIkkrKRFig4Ivx79n0Rsn8K5jx0s8Am1QMc=;
        b=kJypXTIyotr9FiQ1r3+3SPD1kgqNthVv8fB/3WNXznQ0tYGoQCmeFPmS5Repnr3A2S
         7mGSJ5gUbZJSagNR89RJ7sxpiOwarUZE0eDMlVWvuQfLIZpPU8V+9eUC96xmwFFjXl92
         eg48c5GPIdLgY7qSC0rGtoY1YTuPsqsOsQir+PB8FogLBI+gE9nRvAGdpjX8GOFkrrHe
         WHYco085b8A/PktnFu7c33AV5Asd5xAhAHHSybsws/HAYArRhKfoEzRK3oRKHgXvk0Wp
         oaPNoffzXNaa7VSsRo/9zw68rf/ddaDLo6a6bGIaboveH5QNgZhdo1dLxaEqQiy8+P+4
         lNWg==
X-Gm-Message-State: APjAAAUfYKsHY/PJ8COmk63z++xz5TIBt1BCNVEmIWmaB/VVPRPNU75h
        O5fz3B/x3VtjW8YX4nERuriqNyokA7PHq8KDTg==
X-Google-Smtp-Source: APXvYqzsuybquTuFLUcWDJ3NVK/1Pchi3aR2jEoe8YN6LOzz6WSBQ7ixj8q0Yqz8QL8Tl30Q+XEh91qhp4qzaoSjsA==
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr10698716pgb.19.1568931870522;
 Thu, 19 Sep 2019 15:24:30 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:24:16 -0700
In-Reply-To: <20190919222421.27408-1-almasrymina@google.com>
Message-Id: <20190919222421.27408-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v5 2/7] hugetlb_cgroup: add interface for charge/uncharge
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
 include/linux/hugetlb_cgroup.h | 22 ++++++----
 mm/hugetlb.c                   |  6 ++-
 mm/hugetlb_cgroup.c            | 77 ++++++++++++++++++++++++++++------
 3 files changed, 83 insertions(+), 22 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 063962f6dfc6..de35997bb5f9 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -52,14 +52,19 @@ static inline bool hugetlb_cgroup_disabled(void)
 }

 extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-					struct hugetlb_cgroup **ptr);
+					struct hugetlb_cgroup **ptr,
+					bool reserved);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
 					 struct page *page);
 extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 					 struct page *page);
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
@@ -81,9 +86,9 @@ static inline bool hugetlb_cgroup_disabled(void)
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
@@ -100,9 +105,10 @@ hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages, struct page *page)
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
index 052a2532528a..a52efcb70d04 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2032,7 +2032,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

-	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
+	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
+					   false);
 	if (ret)
 		goto out_subpool_put;

@@ -2080,7 +2081,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return page;

 out_uncharge_cgroup:
-	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
+	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
+				       false);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 1386da79c9d7..dc1ddc9b09c4 100644
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
@@ -249,12 +291,14 @@ void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 	if (unlikely(!h_cg))
 		return;
 	set_hugetlb_cgroup(page, NULL);
-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, false),
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
@@ -262,8 +306,17 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
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
--
2.23.0.351.gc4317032e6-goog
