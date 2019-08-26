Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD79D9F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 01:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfHZXdI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Aug 2019 19:33:08 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40682 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfHZXdH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Aug 2019 19:33:07 -0400
Received: by mail-pg1-f202.google.com with SMTP id m19so10614392pgv.7
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2019 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eV/n12u1Q4WlKIOvU+I+Nlk8+5JFGTvz9XVivGHsZz0=;
        b=eXDiJX+JHmS4XRQXWaa/BMQNlA6jNeG4qSORngT9jRZ7ezoWatx1i+bY/6ladJwUCw
         1lXjr64hSA6rT+UvH4woqrrPSlRMVlOoZUNEx0XmEW+g+6mT2T7CucgU+kuQgvUGq1Y8
         W9vgT0KwYGG6QEFSRLheJJEAse+MIMj4H1Y0/wll+AweJsn2RdLAHbEmY0UI5GMRAmGP
         3H0EmlEYN/QhNwBI+Z2jY+/KvU+DnOjxNWUUpDbGr4twFfn2vETSk/yjOg+3yGVv+Q1d
         aOtpVpt/QlatmKfDn6kdw8sQ9cxx1I57YlBIUrJy6oLpwv1XytPZs+s1MfCHCRBo1CFt
         bYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eV/n12u1Q4WlKIOvU+I+Nlk8+5JFGTvz9XVivGHsZz0=;
        b=SMo/qGwcCcclR7hJ2zCzsqOtwsDGychKHOxJ3pP9jGRNJ4ZGRX65kQl2VQeqq+8W6F
         Vh9BOeRHEPlK6Br5nWWh9VviUrhtUXRXobZHI6qqtAio8TlT72v1rGCzZ3ASNY8/092t
         WGemrb56OXr075Q/hDBbqqdTOjWVOy+XsxzFlJ7Uoqzfm+Sfi0IujhY42QL4jh0QN29S
         BegB1KPXE4/rEYt0PZyAFs4vhdUK2+P0m6w0aQDvg0YJNgCsiEgdYPKN1JFMoCON7mI2
         7G2OqkgurZkaRPtTh11EixrI3EgUtq80sbmLt5U9VGoUDeTUsLkWxcpKwAcLTJ62Uwwm
         45cg==
X-Gm-Message-State: APjAAAVBbwZEsHBat20Kw8kxMEtH8OpPoQef2j0RwUjrZwP9OnaE2zdN
        2Bh0vy2zP4yC5znsP0rvc79asoiRj6/hrpBvjA==
X-Google-Smtp-Source: APXvYqwDX0jgsjwk1FwOpeOBhp4XuhZ4IRfnjZhNvu6KRIh4SvIEVpIwjGZib1uHLwT455w4J9czcleLSWx4hQqasg==
X-Received: by 2002:a63:5754:: with SMTP id h20mr18104797pgm.195.1566862386245;
 Mon, 26 Aug 2019 16:33:06 -0700 (PDT)
Date:   Mon, 26 Aug 2019 16:32:36 -0700
In-Reply-To: <20190826233240.11524-1-almasrymina@google.com>
Message-Id: <20190826233240.11524-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20190826233240.11524-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 2/6] hugetlb_cgroup: add interface for charge/uncharge
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

---
 include/linux/hugetlb_cgroup.h |  8 +++-
 mm/hugetlb.c                   |  3 +-
 mm/hugetlb_cgroup.c            | 80 ++++++++++++++++++++++++++++------
 3 files changed, 74 insertions(+), 17 deletions(-)

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
index 6d7296dd11b83..242cfeb7cc3e1 100644
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
index 51a72624bd1ff..bd9b58474be51 100644
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
@@ -250,7 +290,9 @@ void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 	if (unlikely(!h_cg))
 		return;
 	set_hugetlb_cgroup(page, NULL);
-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, false),
+			nr_pages);
+
 	return;
 }

@@ -263,8 +305,17 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
 		return;

-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
-	return;
+	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, false),
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
2.23.0.187.g17f5b7556c-goog
