Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C386DC1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 01:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404711AbfHHXOE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 19:14:04 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39399 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404633AbfHHXOB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 19:14:01 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so60114053pfi.6
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2019 16:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+wNNF10zN2glTEVlCyNTwfvE/ShUZWkrH2OVFnVoyK4=;
        b=cHvzQV+JUEBPGkWz4oh8bEtYs18v5GHnZGHn7x45P+W1pL8U1mYr5uO38kfP7gO83B
         JY5jhe3eG0tn9dHHNJtCyTAF5zntEb93HcpZ+X0e2Ey+do5W1FAFscDhvED7CLnXWsOw
         WRgC96Lrpmi0lYydy+TK8FTduKC2ZCBxQ9etuT52ycRh/sl2m77Gl0+uQ5qlA+y0wZ0Y
         FuHpNiAFzLsBvdrQe6N7IPY8TbglQ/BOQhPBPA50NISWvfqb40u+ujnhGEVoSrbYvmEr
         uaTYD5AChzo27g5Csi8Ub4jYFIeJ3iLbExyWqlPbbusYfI1s0MAhTahg+1DYLst8cZRg
         4q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+wNNF10zN2glTEVlCyNTwfvE/ShUZWkrH2OVFnVoyK4=;
        b=AeZ/VBvXIEn530kne/ThMqWXDGUo/mE9goFkWicQUqLLWpi765jDxLiSP80hoU17es
         sOt7NHNWO0/RTmCUXhVGDD6kZxL+3o2VlaDJ5y+znCA8D2eLaLgfrUAW5T3wK3d5TUVW
         /VRl0Lkn6+8zDSqK6fLRaercCN0etxKCAQvLXng2ToHZ7sD4c4a6zbM7HOsFQ0aE/2a3
         yxZIDzalAmj3kuAUc0Qb1gc+S4fvW0nz2/IDi62RaCdmiD+BvpNIxOOBEOJHH9UcIgTy
         +s1eZTZI6GB3j+DEVBywyhKSorJlzBGHZFZepPmO7A2lbsFJqSNuBEW2SF4Rb+wLqm8F
         J4wg==
X-Gm-Message-State: APjAAAUxrPpibd2AhIrzj6QMnYfhL5hfW7PJFI0+yn8UoI9Hhhr5Jb5J
        i27d1eD96hj+b2EYCJZWkczV9r+DIpxh1fRvHA==
X-Google-Smtp-Source: APXvYqxiELON7MBP5DXs3jkqLdiH5sTqXqtOk/noxLZmdDFa0RCeUeXTnlV4V5nVMv0MfW4AtOE6gp48V0EL0oVwrQ==
X-Received: by 2002:a63:c013:: with SMTP id h19mr14955058pgg.108.1565306040809;
 Thu, 08 Aug 2019 16:14:00 -0700 (PDT)
Date:   Thu,  8 Aug 2019 16:13:37 -0700
In-Reply-To: <20190808231340.53601-1-almasrymina@google.com>
Message-Id: <20190808231340.53601-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20190808231340.53601-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [RFC PATCH v2 2/5] hugetlb_cgroup: Add interface for charge/uncharge
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
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

---
 include/linux/hugetlb_cgroup.h |  8 +++--
 mm/hugetlb.c                   |  3 +-
 mm/hugetlb_cgroup.c            | 63 ++++++++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 063962f6dfc6a..0725f809cd2d9 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -52,7 +52,8 @@ static inline bool hugetlb_cgroup_disabled(void)
 }

 extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-					struct hugetlb_cgroup **ptr);
+					struct hugetlb_cgroup **ptr,
+					bool reserved);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
 					 struct page *page);
@@ -60,6 +61,9 @@ extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 					 struct page *page);
 extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg);
+extern void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
+					    unsigned long nr_pages);
+
 extern void hugetlb_cgroup_file_init(void) __init;
 extern void hugetlb_cgroup_migrate(struct page *oldhpage,
 				   struct page *newhpage);
@@ -83,7 +87,7 @@ static inline bool hugetlb_cgroup_disabled(void)

 static inline int
 hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-			     struct hugetlb_cgroup **ptr)
+			     struct hugetlb_cgroup **ptr, bool reserved)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ede7e7f5d1ab2..c153bef42e729 100644
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

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 708103663988a..119176a0b2ec5 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -74,8 +74,10 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
 	int idx;

 	for (idx = 0; idx < hugetlb_max_hstate; idx++) {
-		if (page_counter_read(&h_cg->hugepage[idx]))
+		if (page_counter_read(get_counter(h_cg, idx, true)) ||
+		    page_counter_read(get_counter(h_cg, idx, false))) {
 			return true;
+		}
 	}
 	return false;
 }
@@ -86,18 +88,27 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
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
+			parent = get_counter(parent_h_cgroup, idx, false);
+			reserved_parent = get_counter(parent_h_cgroup, idx,
+						      true);
+		}
+		page_counter_init(get_counter(h_cgroup, idx, false), parent);
+		page_counter_init(get_counter(h_cgroup, idx, true),
+				  reserved_parent);

 		limit = round_down(PAGE_COUNTER_MAX,
 				   1 << huge_page_order(&hstates[idx]));
-		ret = page_counter_set_max(counter, limit);
+
+		ret = page_counter_set_max(get_counter(
+					h_cgroup, idx, false), limit);
+		ret = page_counter_set_max(get_counter(
+					h_cgroup, idx, true), limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -127,6 +138,25 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
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
+				page_counter_read(get_counter(h_cg, idx,
+							      true)));
+	}
+
+	/* Take the pages off the local counter */
+	page_counter_cancel(get_counter(h_cg, idx, true),
+			    page_counter_read(get_counter(h_cg, idx, true)));
+}

 /*
  * Should be called with hugetlb_lock held.
@@ -181,6 +211,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 	do {
 		for_each_hstate(h) {
 			spin_lock(&hugetlb_lock);
+			hugetlb_cgroup_move_parent_reservation(idx, h_cg);
 			list_for_each_entry(page, &h->hugepage_activelist, lru)
 				hugetlb_cgroup_move_parent(idx, h_cg, page);

@@ -192,7 +223,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 }

 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-				 struct hugetlb_cgroup **ptr)
+				 struct hugetlb_cgroup **ptr, bool reserved)
 {
 	int ret = 0;
 	struct page_counter *counter;
@@ -215,8 +246,10 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 	}
 	rcu_read_unlock();

-	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages, &counter))
+	if (!page_counter_try_charge(get_counter(h_cg, idx, reserved),
+				     nr_pages, &counter)) {
 		ret = -ENOMEM;
+	}
 	css_put(&h_cg->css);
 done:
 	*ptr = h_cg;
@@ -250,7 +283,8 @@ void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 	if (unlikely(!h_cg))
 		return;
 	set_hugetlb_cgroup(page, NULL);
-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	page_counter_uncharge(get_counter(h_cg, idx, false), nr_pages);
+
 	return;
 }

@@ -263,7 +297,16 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
 		return;

-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	page_counter_uncharge(get_counter(h_cg, idx, false), nr_pages);
+}
+
+void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
+				     unsigned long nr_pages)
+{
+	if (hugetlb_cgroup_disabled() || !p)
+		return;
+
+	page_counter_uncharge(p, nr_pages);
 	return;
 }

--
2.23.0.rc1.153.gdeed80330f-goog
