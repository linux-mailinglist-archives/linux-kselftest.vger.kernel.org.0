Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E401AF361
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2019 01:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfIJXce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 19:32:34 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:38244 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfIJXcA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 19:32:00 -0400
Received: by mail-pg1-f202.google.com with SMTP id w5so11570511pgs.5
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2019 16:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mZUy7Vl4WlAaKPPlo1SGP0dD97p4q4C7uD62LJh5Kro=;
        b=ahiXN/57Hx8pU/8w3RyQRjOyezvn5sN+aDaZhNIpskt5jXIuVMfJqDgNOFjsxNarak
         OsiWFRclaKX8/iNvDaAZQE306u2LvBU0Ra98M5bbJuqIBiXey4/GaeywyS+H8+/uW4UW
         uEU5G+6/TecMke0/5AiexxqTdK83XicFjkO5irdEbDn+nzoEZ24T/puDFx5v/MwVYhZB
         doA4m8J/bG81ocCSOUx3GC6z/uXjuo9RuGPbZucTdvI+KJt38NajRJdnojhnKPz5Ph8X
         wG/RGLSbTpQox2JkYyBjWqjwDLHE5FXO5qjMiG+unc2sldvdhNYJy38ml7Nr2dFkX0HM
         Zjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mZUy7Vl4WlAaKPPlo1SGP0dD97p4q4C7uD62LJh5Kro=;
        b=MAvG48ZGwO/bld6KtrX4QPxmkxZI5KztXEQt4c5kZYestX1MBZHfNJjuO2+s5nZAqD
         +p5TuRX4PzuQ224ryPVi4S8bv+SC2HuaBNiY8N8Q3TCY7PVeDYuC6z+4rG3kbjP6YBfM
         J7rRNm4BdvpNKhhxhsT0STfqCTcAw9b03ZQnqNBinEAlU7j68GT4kVFe9pirhVY96uKI
         uTmm7EKBiUwuYCRCXJVoyzbogqe2H/oKASSzFet80iVIystt3bveU+Z7sup2doKqjUR7
         Ztli4h75k/eh4cjxuo2ZWlT6W4Q20nxbhxJyEuvl4ZE4MXSoTzr5aGz+k+mv1G0nDeJ8
         JLAg==
X-Gm-Message-State: APjAAAWH9ajmuE/jqTscBx4JV9sFPbpU4beU+wQPwqpAy9WA+GcYmCYH
        XDf+28gt9OCp62dNLt2mAzFCIXUicfNyfhVtyw==
X-Google-Smtp-Source: APXvYqzDDIfM1YkRxGnTNbUcbG5VGJZzeeVi+8DsjY1EECkM7SWLPMCeuXCw4Zsop1Ui01SonOWXARD0pa3+dAp4pQ==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr30212218pgp.368.1568158318057;
 Tue, 10 Sep 2019 16:31:58 -0700 (PDT)
Date:   Tue, 10 Sep 2019 16:31:40 -0700
In-Reply-To: <20190910233146.206080-1-almasrymina@google.com>
Message-Id: <20190910233146.206080-4-almasrymina@google.com>
Mime-Version: 1.0
References: <20190910233146.206080-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v4 3/9] hugetlb_cgroup: add reservation accounting for private mappings
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

Normally the pointer to the cgroup to uncharge hangs off the struct
page, and gets queried when it's time to free the page. With
hugetlb_cgroup reservations, this is not possible. Because it's possible
for a page to be reserved by one task and actually faulted in by another
task.

The best place to put the hugetlb_cgroup pointer to uncharge for
reservations is in the resv_map. But, because the resv_map has different
semantics for private and shared mappings, the code patch to
charge/uncharge shared and private mappings is different. This patch
implements charging and uncharging for private mappings.

For private mappings, the counter to uncharge is in
resv_map->reservation_counter. On initializing the resv_map this is set
to NULL. On reservation of a region in private mapping, the tasks
hugetlb_cgroup is charged and the hugetlb_cgroup is placed is
resv_map->reservation_counter.

On hugetlb_vm_op_close, we uncharge resv_map->reservation_counter.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/hugetlb.h        |  8 ++++++
 include/linux/hugetlb_cgroup.h | 11 ++++++++
 mm/hugetlb.c                   | 47 ++++++++++++++++++++++++++++++++--
 mm/hugetlb_cgroup.c            | 12 ---------
 4 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 128ff1aff1c93..536cb144cf484 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -46,6 +46,14 @@ struct resv_map {
 	long adds_in_progress;
 	struct list_head region_cache;
 	long region_cache_count;
+ #ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * On private mappings, the counter to uncharge reservations is stored
+	 * here. If these fields are 0, then the mapping is shared.
+	 */
+	struct page_counter *reservation_counter;
+	unsigned long pages_per_hpage;
+#endif
 };
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index c467715dd8fb8..8c6ea58c63c89 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -25,6 +25,17 @@ struct hugetlb_cgroup;
 #define HUGETLB_CGROUP_MIN_ORDER	2

 #ifdef CONFIG_CGROUP_HUGETLB
+struct hugetlb_cgroup {
+	struct cgroup_subsys_state css;
+	/*
+	 * the counter to account for hugepages from hugetlb.
+	 */
+	struct page_counter hugepage[HUGE_MAX_HSTATE];
+	/*
+	 * the counter to account for hugepage reservations from hugetlb.
+	 */
+	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
+};

 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e975f55aede94..fbd7c52e17348 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -711,6 +711,16 @@ struct resv_map *resv_map_alloc(void)
 	INIT_LIST_HEAD(&resv_map->regions);

 	resv_map->adds_in_progress = 0;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * Initialize these to 0. On shared mappings, 0's here indicate these
+	 * fields don't do cgroup accounting. On private mappings, these will be
+	 * re-initialized to the proper values, to indicate that hugetlb cgroup
+	 * reservations are to be un-charged from here.
+	 */
+	resv_map->reservation_counter = NULL;
+	resv_map->pages_per_hpage = 0;
+#endif

 	INIT_LIST_HEAD(&resv_map->region_cache);
 	list_add(&rg->link, &resv_map->region_cache);
@@ -3193,7 +3203,19 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)

 	reserve = (end - start) - region_count(resv, start, end);

-	kref_put(&resv->refs, resv_map_release);
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * Since we check for HPAGE_RESV_OWNER above, this must a private
+	 * mapping, and these values should be none-zero, and should point to
+	 * the hugetlb_cgroup counter to uncharge for this reservation.
+	 */
+	WARN_ON(!resv->reservation_counter);
+	WARN_ON(!resv->pages_per_hpage);
+
+	hugetlb_cgroup_uncharge_counter(
+			resv->reservation_counter,
+			(end - start) * resv->pages_per_hpage);
+#endif

 	if (reserve) {
 		/*
@@ -3203,6 +3225,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
+
+	kref_put(&resv->refs, resv_map_release);
 }

 static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -4536,6 +4560,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
+	struct hugetlb_cgroup *h_cg;
 	long gbl_reserve;

 	/* This should never happen */
@@ -4569,11 +4594,29 @@ int hugetlb_reserve_pages(struct inode *inode,
 		chg = region_chg(resv_map, from, to);

 	} else {
+		/* Private mapping. */
+		chg = to - from;
+
+		if (hugetlb_cgroup_charge_cgroup(
+					hstate_index(h),
+					chg * pages_per_huge_page(h),
+					&h_cg, true)) {
+			return -ENOMEM;
+		}
+
 		resv_map = resv_map_alloc();
 		if (!resv_map)
 			return -ENOMEM;

-		chg = to - from;
+#ifdef CONFIG_CGROUP_HUGETLB
+		/*
+		 * Since this branch handles private mappings, we attach the
+		 * counter to uncharge for this reservation off resv_map.
+		 */
+		resv_map->reservation_counter =
+			&h_cg->reserved_hugepage[hstate_index(h)];
+		resv_map->pages_per_hpage = pages_per_huge_page(h);
+#endif

 		set_vma_resv_map(vma, resv_map);
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 2ab36a98d834e..66ffd32063722 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -19,18 +19,6 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>

-struct hugetlb_cgroup {
-	struct cgroup_subsys_state css;
-	/*
-	 * the counter to account for hugepages from hugetlb.
-	 */
-	struct page_counter hugepage[HUGE_MAX_HSTATE];
-	/*
-	 * the counter to account for hugepage reservations from hugetlb.
-	 */
-	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
-};
-
 #define MEMFILE_PRIVATE(x, val)	(((x) << 16) | (val))
 #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
--
2.23.0.162.g0b9fbb3734-goog
