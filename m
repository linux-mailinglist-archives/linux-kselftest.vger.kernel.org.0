Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6B7AF34A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2019 01:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfIJXb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 19:31:59 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50093 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfIJXb5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 19:31:57 -0400
Received: by mail-pl1-f201.google.com with SMTP id p8so10762042plo.16
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2019 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fLM4n8WI6nBKYjlzv5uprslhLlKE5TPWeWkrSrLwO08=;
        b=aszPrJ2tWxWHZapeGA8AYjx2qGTRQziicUp8CmGG7Qp+54nwJxkE2yH8s4TD9eLTUJ
         H/wRBsbflFvO0nRXzK0ZIEJOb7vNyqdtJ18FmLBQO8axQW4qHyfzmbMfSoOBiLdtkc7i
         J4ZyrsHuc2c73N4u3oUhcspX/axS09sgPD/QpMZy48+RfHB3oJPYe1ZGGAsD3jkL2tPY
         eqkAZxtN+h6pBPb9Vjzq7yAuJMled3Y9FZIbnYumCdV8qjm9DGnSuc4DKPTOu7weMP2U
         MWx8AV7fOx1WCL2R8X9Y2/jB6UHfDmLwK58rSKUc5A3iUhC2WMCMOwMsJ3AULWoRQtHE
         943Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fLM4n8WI6nBKYjlzv5uprslhLlKE5TPWeWkrSrLwO08=;
        b=DTP8bc90a8jG7/tg0cKb7KoTxQvv9ESQHVnHNoz6iHSTdSXB7RqB1ZPc2GmlY71Vs0
         UUSeV3MK+DmuXSmjUZQOPw5SfB0vGeM5TxqJimmhCCGHXjRLNBgkvnlTRve1GN8mgEPT
         e3AMXeZQPeaAcMYIgA7IwI8FpaB8e3HlpaIi8cmklilCcgdgHc6/JDkFZgp490LZO+kj
         rkTLRuOgz2qvwO0DPai1kCXz35RFQX78CxBNTuZopUu9MDUAwva4mHjvG2o0W8ep/Z1q
         yk3u+7F3BzBQ3/R0OF6qg8HnGjJJyZhl+WEnl8/By5vriDqzQWJKWSQthS2DNCtfeRon
         umbw==
X-Gm-Message-State: APjAAAWnNG/sVnVUAqK5s+rvOEHacTKzOVkUb7n5WoeMSsBeADofl28i
        iqU22rBVcLDkUksaLeUhU/Y2s6MI5QVfOsK1oA==
X-Google-Smtp-Source: APXvYqz8UkwjV9XfOFsV5NW86oxIsr5ArI24hFNz5KsCsRreiOOxGnQMOfXbgKHuDPGJArpX4kC+vvEQBe0w60wsaA==
X-Received: by 2002:a63:67c6:: with SMTP id b189mr30789935pgc.163.1568158315499;
 Tue, 10 Sep 2019 16:31:55 -0700 (PDT)
Date:   Tue, 10 Sep 2019 16:31:39 -0700
In-Reply-To: <20190910233146.206080-1-almasrymina@google.com>
Message-Id: <20190910233146.206080-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20190910233146.206080-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v4 2/9] hugetlb_cgroup: add interface for charge/uncharge
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

Augements hugetlb_cgroup_charge_cgroup to be able to charge hugetlb
usage or hugetlb reservation counter.

Adds a new interface to uncharge a hugetlb_cgroup counter via
hugetlb_cgroup_uncharge_counter.

Integrates the counter with hugetlb_cgroup, via hugetlb_cgroup_init,
hugetlb_cgroup_have_usage, and hugetlb_cgroup_css_offline.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/hugetlb_cgroup.h | 13 ++++--
 mm/hugetlb.c                   |  6 ++-
 mm/hugetlb_cgroup.c            | 82 +++++++++++++++++++++++++++-------
 3 files changed, 80 insertions(+), 21 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 063962f6dfc6a..c467715dd8fb8 100644
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
@@ -83,7 +88,7 @@ static inline bool hugetlb_cgroup_disabled(void)

 static inline int
 hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-			     struct hugetlb_cgroup **ptr)
+			     struct hugetlb_cgroup **ptr, bool reserved)
 {
 	return 0;
 }
@@ -102,7 +107,7 @@ hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages, struct page *page)

 static inline void
 hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-			       struct hugetlb_cgroup *h_cg)
+			       struct hugetlb_cgroup *h_cg, bool reserved)
 {
 }

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d7296dd11b83..e975f55aede94 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2078,7 +2078,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

-	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
+	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
+					   false);
 	if (ret)
 		goto out_subpool_put;

@@ -2126,7 +2127,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return page;

 out_uncharge_cgroup:
-	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
+	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
+			false);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 51a72624bd1ff..2ab36a98d834e 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -38,8 +38,8 @@ struct hugetlb_cgroup {
 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;

 static inline
-struct page_counter *hugetlb_cgroup_get_counter(struct hugetlb_cgroup *h_cg, int idx,
-				 bool reserved)
+struct page_counter *hugetlb_cgroup_get_counter(struct hugetlb_cgroup *h_cg,
+						int idx, bool reserved)
 {
 	if (reserved)
 		return  &h_cg->reserved_hugepage[idx];
@@ -74,8 +74,12 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
 	int idx;

 	for (idx = 0; idx < hugetlb_max_hstate; idx++) {
-		if (page_counter_read(&h_cg->hugepage[idx]))
+		if (page_counter_read(hugetlb_cgroup_get_counter(h_cg, idx,
+						true)) ||
+		    page_counter_read(hugetlb_cgroup_get_counter(h_cg, idx,
+				    false))) {
 			return true;
+		}
 	}
 	return false;
 }
@@ -86,18 +90,30 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
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
+			parent = hugetlb_cgroup_get_counter(
+					parent_h_cgroup, idx, false);
+			reserved_parent = hugetlb_cgroup_get_counter(
+					parent_h_cgroup, idx, true);
+		}
+		page_counter_init(hugetlb_cgroup_get_counter(
+					h_cgroup, idx, false), parent);
+		page_counter_init(hugetlb_cgroup_get_counter(
+					h_cgroup, idx, true),
+				  reserved_parent);

 		limit = round_down(PAGE_COUNTER_MAX,
 				   1 << huge_page_order(&hstates[idx]));
-		ret = page_counter_set_max(counter, limit);
+
+		ret = page_counter_set_max(hugetlb_cgroup_get_counter(
+					h_cgroup, idx, false), limit);
+		ret = page_counter_set_max(hugetlb_cgroup_get_counter(
+					h_cgroup, idx, true), limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -127,6 +143,26 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
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
+				&root_h_cgroup->reserved_hugepage[idx],
+				page_counter_read(hugetlb_cgroup_get_counter(
+						h_cg, idx, true)));
+	}
+
+	/* Take the pages off the local counter */
+	page_counter_cancel(hugetlb_cgroup_get_counter(h_cg, idx, true),
+			    page_counter_read(hugetlb_cgroup_get_counter(h_cg,
+					    idx, true)));
+}

 /*
  * Should be called with hugetlb_lock held.
@@ -181,6 +217,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 	do {
 		for_each_hstate(h) {
 			spin_lock(&hugetlb_lock);
+			hugetlb_cgroup_move_parent_reservation(idx, h_cg);
 			list_for_each_entry(page, &h->hugepage_activelist, lru)
 				hugetlb_cgroup_move_parent(idx, h_cg, page);

@@ -192,7 +229,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 }

 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-				 struct hugetlb_cgroup **ptr)
+				 struct hugetlb_cgroup **ptr, bool reserved)
 {
 	int ret = 0;
 	struct page_counter *counter;
@@ -215,8 +252,11 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
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
@@ -250,12 +290,14 @@ void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 	if (unlikely(!h_cg))
 		return;
 	set_hugetlb_cgroup(page, NULL);
-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, false),
+			nr_pages);
+
 	return;
 }

 void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-				    struct hugetlb_cgroup *h_cg)
+				    struct hugetlb_cgroup *h_cg, bool reserved)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
@@ -263,8 +305,17 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
 		return;

-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
-	return;
+	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, reserved),
+			nr_pages);
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
@@ -326,7 +377,8 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 		/* Fall through. */
 	case HUGETLB_RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
-		ret = page_counter_set_max(hugetlb_cgroup_get_counter(h_cg, idx, reserved),
+		ret = page_counter_set_max(hugetlb_cgroup_get_counter(h_cg, idx,
+								      reserved),
 					   nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
--
2.23.0.162.g0b9fbb3734-goog
