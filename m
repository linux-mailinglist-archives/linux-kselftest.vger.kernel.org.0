Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC5151315
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 00:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBCXXI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 18:23:08 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:36751 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBCXXI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 18:23:08 -0500
Received: by mail-pj1-f74.google.com with SMTP id m61so667148pjb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 15:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=02HPd2cJM7Jo0iTyyH5qNp+T4PluqSC562rwiwPFy94=;
        b=I3gJBeDwasXLRyhAQyyC3herX9YYX2KavjD5Z/iWkNWmPykzwk855cIj97tIad//lD
         cOH3ixBOToKlWZ/qp0YYJ9Liz6W9E31czgjYw0M+deaRHz30WMpMu36kWls27dGTvPLl
         ks67q/zfpLVDU0q3LhN4/dqYQr2cTMzM0cFzehSiEp5idrTbkRDTYmvKoH9EGlR0gpnl
         q7o4Yq/3Aag11mUTcptYEXxChD2ghezxSB/HYe81sPwWg0Bv5OqDpM4KB7iBF5rL6h/I
         usJ+oWR0rXVcKDvNkGC/5Ia6wKQX64wzNeo6nMgxULV0TpjOlGcvANwA+EJg9e0QaReq
         163A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=02HPd2cJM7Jo0iTyyH5qNp+T4PluqSC562rwiwPFy94=;
        b=YFrP4uI3tLLYZAUYM3xkvnNxzelgqRus3zMj90NVSGjixJ4boJ6kASWs/Zx5e1M5NX
         WG3szhRQoGDVAcyBFBVxNLRTVhZu+zTosP33n3uBzFoCSlsbWb7KcJDT0778Vkurreqz
         pXCevHSwoPoARNH0g542DxSl08uO4YlvDkIoaPN3KhxZF0c8WQMry0IhXzrS9akxXWtY
         N27a7kowAYfLmXhofuJFYrQgOEuqYjIKZTU7PHCKBPCEgkj5Ti2ZLe36opDcMiqoMOt/
         b039cEcOyNNsHov9k/+70nCPEluc9hNg5wI9lUbGN1GRGxff0jjhr8ZflGoG/3Xo9Qbw
         kINQ==
X-Gm-Message-State: APjAAAUhT1bGLFct1kxBTqMebSa6107yUxtAdDY7C72RdJWbogDx4yC8
        8MiUMF6vqsE6mMI5p9ENdzh2r3qLTLC3xCZ6XQ==
X-Google-Smtp-Source: APXvYqxCE24Ff01FZFjbQCTa4jx1AXTdpAb3sjGREE9SfbWl4GocGe/oeIy48WSdpG4ZDRGqYBWmxoMc/ZDtSrVwzA==
X-Received: by 2002:a63:447:: with SMTP id 68mr14292202pge.97.1580772187526;
 Mon, 03 Feb 2020 15:23:07 -0800 (PST)
Date:   Mon,  3 Feb 2020 15:22:42 -0800
In-Reply-To: <20200203232248.104733-1-almasrymina@google.com>
Message-Id: <20200203232248.104733-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v11 3/9] hugetlb_cgroup: add reservation accounting for
 private mappings
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: David Rientjes <rientjes@google.com>

---

Changes in v11:
- Refactored hugetlb_cgroup_uncharge_conuter a bit to eliminate
unnecessary #ifdefs.
- Added resv_map_set_hugetlb_cgroup_uncharge_info() to eliminate #ifdefs
in the middle of hugetlb logic.

Changes in v10:
- Fixed cases where the mapping is private but cgroup accounting is disabled.

Changes in V9:
- Updated for reparenting of hugetlb reservation accounting.

---
 include/linux/hugetlb.h        | 10 ++++++++
 include/linux/hugetlb_cgroup.h | 39 +++++++++++++++++++++++++---
 mm/hugetlb.c                   | 47 +++++++++++++++++++++++++++++++---
 mm/hugetlb_cgroup.c            | 41 +++++------------------------
 4 files changed, 97 insertions(+), 40 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index dea6143aa0685..5491932ea5758 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -46,6 +46,16 @@ struct resv_map {
 	long adds_in_progress;
 	struct list_head region_cache;
 	long region_cache_count;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * On private mappings, the counter to uncharge reservations is stored
+	 * here. If these fields are 0, then either the mapping is shared, or
+	 * cgroup accounting is disabled for this resv_map.
+	 */
+	struct page_counter *reservation_counter;
+	unsigned long pages_per_hpage;
+	struct cgroup_subsys_state *css;
+#endif
 };
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 91bc5e920e9d0..6a6c80df95ae3 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -27,6 +27,33 @@ struct hugetlb_cgroup;
 #define HUGETLB_CGROUP_MIN_ORDER	2

 #ifdef CONFIG_CGROUP_HUGETLB
+enum hugetlb_memory_event {
+	HUGETLB_MAX,
+	HUGETLB_NR_MEMORY_EVENTS,
+};
+
+struct hugetlb_cgroup {
+	struct cgroup_subsys_state css;
+
+	/*
+	 * the counter to account for hugepages from hugetlb.
+	 */
+	struct page_counter hugepage[HUGE_MAX_HSTATE];
+
+	/*
+	 * the counter to account for hugepage reservations from hugetlb.
+	 */
+	struct page_counter rsvd_hugepage[HUGE_MAX_HSTATE];
+
+	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
+	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
+
+	/* Handle for "hugetlb.events" */
+	struct cgroup_file events_file[HUGE_MAX_HSTATE];
+
+	/* Handle for "hugetlb.events.local" */
+	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
+};

 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
 							      bool rsvd)
@@ -71,9 +98,9 @@ extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg,
 					   bool rsvd);
-extern void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
-					    unsigned long nr_pages,
-					    struct cgroup_subsys_state *css);
+extern void hugetlb_cgroup_uncharge_counter(struct resv_map *resv,
+					    unsigned long start,
+					    unsigned long end);

 extern void hugetlb_cgroup_file_init(void) __init;
 extern void hugetlb_cgroup_migrate(struct page *oldhpage,
@@ -122,6 +149,12 @@ static inline void hugetlb_cgroup_uncharge_cgroup(int idx,
 {
 }

+static inline void hugetlb_cgroup_uncharge_counter(struct resv_map *resv,
+						   unsigned long start,
+						   unsigned long end)
+{
+}
+
 static inline void hugetlb_cgroup_file_init(void)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 62a4cf3db4090..fd2f7d1d31f4e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -650,6 +650,25 @@ static void set_vma_private_data(struct vm_area_struct *vma,
 	vma->vm_private_data = (void *)value;
 }

+static void
+resv_map_set_hugetlb_cgroup_uncharge_info(struct resv_map *resv_map,
+					  struct hugetlb_cgroup *h_cg,
+					  struct hstate *h)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	if (!h_cg || !h) {
+		resv_map->reservation_counter = NULL;
+		resv_map->pages_per_hpage = 0;
+		resv_map->css = NULL;
+	} else {
+		resv_map->reservation_counter =
+			&h_cg->rsvd_hugepage[hstate_index(h)];
+		resv_map->pages_per_hpage = pages_per_huge_page(h);
+		resv_map->css = &h_cg->css;
+	}
+#endif
+}
+
 struct resv_map *resv_map_alloc(void)
 {
 	struct resv_map *resv_map = kmalloc(sizeof(*resv_map), GFP_KERNEL);
@@ -666,6 +685,13 @@ struct resv_map *resv_map_alloc(void)
 	INIT_LIST_HEAD(&resv_map->regions);

 	resv_map->adds_in_progress = 0;
+	/*
+	 * Initialize these to 0. On shared mappings, 0's here indicate these
+	 * fields don't do cgroup accounting. On private mappings, these will be
+	 * re-initialized to the proper values, to indicate that hugetlb cgroup
+	 * reservations are to be un-charged from here.
+	 */
+	resv_map_set_hugetlb_cgroup_uncharge_info(resv_map, NULL, NULL);

 	INIT_LIST_HEAD(&resv_map->region_cache);
 	list_add(&rg->link, &resv_map->region_cache);
@@ -3193,9 +3219,7 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 	end = vma_hugecache_offset(h, vma, vma->vm_end);

 	reserve = (end - start) - region_count(resv, start, end);
-
-	kref_put(&resv->refs, resv_map_release);
-
+	hugetlb_cgroup_uncharge_counter(resv, start, end);
 	if (reserve) {
 		/*
 		 * Decrement reserve counts.  The global reserve count may be
@@ -3204,6 +3228,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
+
+	kref_put(&resv->refs, resv_map_release);
 }

 static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -4550,6 +4576,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
+	struct hugetlb_cgroup *h_cg;
 	long gbl_reserve;

 	/* This should never happen */
@@ -4583,12 +4610,26 @@ int hugetlb_reserve_pages(struct inode *inode,
 		chg = region_chg(resv_map, from, to);

 	} else {
+		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
 			return -ENOMEM;

 		chg = to - from;

+		if (hugetlb_cgroup_charge_cgroup(hstate_index(h),
+						 chg * pages_per_huge_page(h),
+						 &h_cg, true)) {
+			kref_put(&resv_map->refs, resv_map_release);
+			return -ENOMEM;
+		}
+
+		/*
+		 * Since this branch handles private mappings, we attach the
+		 * counter to uncharge for this reservation off resv_map.
+		 */
+		resv_map_set_hugetlb_cgroup_uncharge_info(resv_map, h_cg, h);
+
 		set_vma_resv_map(vma, resv_map);
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 640555d7f78c6..e079513c8de0d 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -23,34 +23,6 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>

-enum hugetlb_memory_event {
-	HUGETLB_MAX,
-	HUGETLB_NR_MEMORY_EVENTS,
-};
-
-struct hugetlb_cgroup {
-	struct cgroup_subsys_state css;
-
-	/*
-	 * the counter to account for hugepages from hugetlb.
-	 */
-	struct page_counter hugepage[HUGE_MAX_HSTATE];
-
-	/*
-	 * the counter to account for hugepage reservations from hugetlb.
-	 */
-	struct page_counter rsvd_hugepage[HUGE_MAX_HSTATE];
-
-	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
-	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
-
-	/* Handle for "hugetlb.events" */
-	struct cgroup_file events_file[HUGE_MAX_HSTATE];
-
-	/* Handle for "hugetlb.events.local" */
-	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
-};
-
 #define MEMFILE_PRIVATE(x, val)	(((x) << 16) | (val))
 #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
@@ -342,15 +314,16 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 		css_put(&h_cg->css);
 }

-void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
-				     unsigned long nr_pages,
-				     struct cgroup_subsys_state *css)
+void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
+				     unsigned long end)
 {
-	if (hugetlb_cgroup_disabled() || !p || !css)
+	if (hugetlb_cgroup_disabled() || !resv || !resv->reservation_counter ||
+	    !resv->css)
 		return;

-	page_counter_uncharge(p, nr_pages);
-	css_put(css);
+	page_counter_uncharge(resv->reservation_counter,
+			      (end - start) * resv->pages_per_hpage);
+	css_put(resv->css);
 }

 enum {
--
2.25.0.341.g760bfbb309-goog
