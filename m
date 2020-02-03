Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD60151321
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 00:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgBCXXT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 18:23:19 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34265 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgBCXXR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 18:23:17 -0500
Received: by mail-pg1-f201.google.com with SMTP id j72so3620458pgc.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 15:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wsWIosO9/zicdXldiCJsrhpPQpGovfIhWd0inlVmdSU=;
        b=eZs/0cuDAl+QpPfPZpA25cLnY4UiIl243OCax6SWD4xgvrXlvfqK/sl0TckvrB0Vcj
         yjobirU8CYZ9/pkMnqglLuUxVHWGDVx/AoENF3uq8Ta4s5ki8xYaOCDLIWGErdflQ4Sp
         7+0KMBstc4zSX00W/SbcpipFVMqDwPIZt0Pe+XfWyUrWZGHioR937ems6vKt8nlpLZYP
         7/lzSknA11+xcvJqcPJOZOfRFctRPG9CtEizDHY+C24LB9DkFIqMOzpxm807LuQzGlIs
         vq+X0PBNFu6AV9Bha7vA3roi1Qk9rHnObCtZHDUUaInSAZtcbi53871I3oLq9XOcQy75
         D7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wsWIosO9/zicdXldiCJsrhpPQpGovfIhWd0inlVmdSU=;
        b=ZhtpZ9kaDkC/PGYy92tXaLVSA9pLGA/ZJzdxG0d25FLFdqGd8CDi+c1rlhYtzsYOFG
         bhveoQUSxcsdG5Fs8kPguFvQUDyY6qtth+/NbhLyoYIafnRgLSlHFOwm2cIGLFBf7+gQ
         6Cen0NRzOr/kWGjr3VFh1dWeXdbYwvtMGGto5onTTRQQCEeWy4TBwljsaSzKrgHh8z0n
         7SFM2tRwPWkm2CtoMHbpnaBVrMUKiYDSWFlLgm3OIGfZd4Et3vC/uvyssAlH9o5zobDo
         AOh8QBjTUjA5WbCAqrjaBDaqyUOghi2E4p+CVXADTfVvxNYyGJLD1frt8YK1n3MeW6wK
         ErHA==
X-Gm-Message-State: APjAAAU8fRNqhN1NXZgIRLgxPjMpA8h790ZdXZNEJxS7jBuvcWvJ8bc4
        tjRk+giFtjN3i3KIRvEoQeNTmdOY7QDcETugbg==
X-Google-Smtp-Source: APXvYqwA3Wv5pPD2MQHIpW4u/dGaH6ZAPKZ55czsG7Xx/Fculq/FTc774NhJYjs25VnhLDQHBex+l/nDBw8zRM4yJQ==
X-Received: by 2002:a63:2355:: with SMTP id u21mr27497968pgm.179.1580772196257;
 Mon, 03 Feb 2020 15:23:16 -0800 (PST)
Date:   Mon,  3 Feb 2020 15:22:44 -0800
In-Reply-To: <20200203232248.104733-1-almasrymina@google.com>
Message-Id: <20200203232248.104733-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v11 5/9] hugetlb_cgroup: add accounting for shared mappings
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

For shared mappings, the pointer to the hugetlb_cgroup to uncharge lives
in the resv_map entries, in file_region->reservation_counter.

After a call to region_chg, we charge the approprate hugetlb_cgroup, and if
successful, we pass on the hugetlb_cgroup info to a follow up region_add call.
When a file_region entry is added to the resv_map via region_add, we put the
pointer to that cgroup in file_region->reservation_counter. If charging doesn't
succeed, we report the error to the caller, so that the kernel fails the
reservation.

On region_del, which is when the hugetlb memory is unreserved, we also uncharge
the file_region->reservation_counter.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v11:
- Created new function, hugetlb_cgroup_uncharge_file_region to clean up
some #ifdefs.
- Moved file_region definition to hugetlb.h.
- Added copy_hugetlb_cgroup_uncharge_info function to clean up more
 #ifdefs in the middle of hugetlb code.

Changes in v10:
- Deleted duplicated code snippet.

Changes in V9:
- Updated for hugetlb reservation repareting.

---
 include/linux/hugetlb.h        |  36 ++++++++
 include/linux/hugetlb_cgroup.h |  10 +++
 mm/hugetlb.c                   | 147 +++++++++++++++++++++------------
 mm/hugetlb_cgroup.c            |  15 ++++
 4 files changed, 155 insertions(+), 53 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5491932ea5758..395f5b1fad416 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -57,6 +57,42 @@ struct resv_map {
 	struct cgroup_subsys_state *css;
 #endif
 };
+
+/*
+ * Region tracking -- allows tracking of reservations and instantiated pages
+ *                    across the pages in a mapping.
+ *
+ * The region data structures are embedded into a resv_map and protected
+ * by a resv_map's lock.  The set of regions within the resv_map represent
+ * reservations for huge pages, or huge pages that have already been
+ * instantiated within the map.  The from and to elements are huge page
+ * indicies into the associated mapping.  from indicates the starting index
+ * of the region.  to represents the first index past the end of  the region.
+ *
+ * For example, a file region structure with from == 0 and to == 4 represents
+ * four huge pages in a mapping.  It is important to note that the to element
+ * represents the first element past the end of the region. This is used in
+ * arithmetic as 4(to) - 0(from) = 4 huge pages in the region.
+ *
+ * Interval notation of the form [from, to) will be used to indicate that
+ * the endpoint from is inclusive and to is exclusive.
+ */
+struct file_region {
+	struct list_head link;
+	long from;
+	long to;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * On shared mappings, each reserved region appears as a struct
+	 * file_region in resv_map. These fields hold the info needed to
+	 * uncharge each reservation.
+	 */
+	struct page_counter *reservation_counter;
+	unsigned long pages_per_hpage;
+	struct cgroup_subsys_state *css;
+#endif
+};
+
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 6a6c80df95ae3..c3fd417c268c5 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -102,11 +102,21 @@ extern void hugetlb_cgroup_uncharge_counter(struct resv_map *resv,
 					    unsigned long start,
 					    unsigned long end);

+extern void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
+						struct file_region *rg,
+						unsigned long nr_pages);
+
 extern void hugetlb_cgroup_file_init(void) __init;
 extern void hugetlb_cgroup_migrate(struct page *oldhpage,
 				   struct page *newhpage);

 #else
+
+static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
+						       struct file_region *rg,
+						       unsigned long nr_pages)
+{
+}
 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
 							      bool rsvd)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 986e9a9cc6fbe..33818ccaf7e89 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -220,31 +220,6 @@ static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
 	return subpool_inode(file_inode(vma->vm_file));
 }

-/*
- * Region tracking -- allows tracking of reservations and instantiated pages
- *                    across the pages in a mapping.
- *
- * The region data structures are embedded into a resv_map and protected
- * by a resv_map's lock.  The set of regions within the resv_map represent
- * reservations for huge pages, or huge pages that have already been
- * instantiated within the map.  The from and to elements are huge page
- * indicies into the associated mapping.  from indicates the starting index
- * of the region.  to represents the first index past the end of  the region.
- *
- * For example, a file region structure with from == 0 and to == 4 represents
- * four huge pages in a mapping.  It is important to note that the to element
- * represents the first element past the end of the region. This is used in
- * arithmetic as 4(to) - 0(from) = 4 huge pages in the region.
- *
- * Interval notation of the form [from, to) will be used to indicate that
- * the endpoint from is inclusive and to is exclusive.
- */
-struct file_region {
-	struct list_head link;
-	long from;
-	long to;
-};
-
 /* Helper that removes a struct file_region from the resv_map cache and returns
  * it for use.
  */
@@ -266,6 +241,37 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
 	return nrg;
 }

+static void copy_hugetlb_cgroup_uncharge_info(struct file_region *nrg,
+					      struct file_region *rg)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+
+	nrg->reservation_counter = rg->reservation_counter;
+	nrg->pages_per_hpage = rg->pages_per_hpage;
+	nrg->css = rg->css;
+	css_get(rg->css);
+#endif
+}
+
+/* Helper that records hugetlb_cgroup uncharge info. */
+static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
+						struct file_region *nrg,
+						struct hstate *h)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	if (h_cg) {
+		nrg->reservation_counter =
+			&h_cg->rsvd_hugepage[hstate_index(h)];
+		nrg->pages_per_hpage = pages_per_huge_page(h);
+		nrg->css = &h_cg->css;
+	} else {
+		nrg->reservation_counter = NULL;
+		nrg->pages_per_hpage = 0;
+		nrg->css = NULL;
+	}
+#endif
+}
+
 /* Must be called with resv->lock held. Calling this with count_only == true
  * will count the number of pages to be added but will not modify the linked
  * list. If regions_needed != NULL and count_only == true, then regions_needed
@@ -273,7 +279,9 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
  * add the regions for this range.
  */
 static long add_reservation_in_range(struct resv_map *resv, long f, long t,
-				     long *regions_needed, bool count_only)
+				     struct hugetlb_cgroup *h_cg,
+				     struct hstate *h, long *regions_needed,
+				     bool count_only)
 {
 	long add = 0;
 	struct list_head *head = &resv->regions;
@@ -312,6 +320,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 			if (!count_only) {
 				nrg = get_file_region_entry_from_cache(
 					resv, last_accounted_offset, rg->from);
+				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
+								    h);
 				list_add(&nrg->link, rg->link.prev);
 			} else if (regions_needed)
 				*regions_needed += 1;
@@ -328,11 +338,13 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		if (!count_only) {
 			nrg = get_file_region_entry_from_cache(
 				resv, last_accounted_offset, t);
+			record_hugetlb_cgroup_uncharge_info(h_cg, nrg, h);
 			list_add(&nrg->link, rg->link.prev);
 		} else if (regions_needed)
 			*regions_needed += 1;
 	}

+	VM_BUG_ON(add < 0);
 	return add;
 }

@@ -353,7 +365,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
  * fail; region_chg will always allocate at least 1 entry and a region_add for
  * 1 page will only require at most 1 entry.
  */
-static long region_add(struct resv_map *resv, long f, long t,
+static long region_add(struct hstate *h, struct hugetlb_cgroup *h_cg,
+		       struct resv_map *resv, long f, long t,
 		       long in_regions_needed)
 {
 	long add = 0, actual_regions_needed = 0, i = 0;
@@ -366,7 +379,8 @@ static long region_add(struct resv_map *resv, long f, long t,
 retry:

 	/* Count how many regions are actually needed to execute this add. */
-	add_reservation_in_range(resv, f, t, &actual_regions_needed, true);
+	add_reservation_in_range(resv, f, t, NULL, NULL, &actual_regions_needed,
+				 true);

 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
@@ -404,7 +418,7 @@ static long region_add(struct resv_map *resv, long f, long t,
 		goto retry;
 	}

-	add = add_reservation_in_range(resv, f, t, NULL, false);
+	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL, false);

 	resv->adds_in_progress -= in_regions_needed;

@@ -452,7 +466,8 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	spin_lock(&resv->lock);

 	/* Count how many hugepages in this range are NOT respresented. */
-	chg = add_reservation_in_range(resv, f, t, out_regions_needed, true);
+	chg = add_reservation_in_range(resv, f, t, NULL, NULL,
+				       out_regions_needed, true);

 	if (*out_regions_needed == 0)
 		*out_regions_needed = 1;
@@ -588,11 +603,17 @@ static long region_del(struct resv_map *resv, long f, long t)
 			/* New entry for end of split region */
 			nrg->from = t;
 			nrg->to = rg->to;
+
+			copy_hugetlb_cgroup_uncharge_info(nrg, rg);
+
 			INIT_LIST_HEAD(&nrg->link);

 			/* Original entry is trimmed */
 			rg->to = f;

+			hugetlb_cgroup_uncharge_file_region(
+				resv, rg, nrg->to - nrg->from);
+
 			list_add(&nrg->link, &rg->link);
 			nrg = NULL;
 			break;
@@ -600,6 +621,8 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+			hugetlb_cgroup_uncharge_file_region(resv, rg,
+							    rg->to - rg->from);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -608,14 +631,21 @@ static long region_del(struct resv_map *resv, long f, long t)
 		if (f <= rg->from) {	/* Trim beginning of region */
 			del += t - rg->from;
 			rg->from = t;
+
+			hugetlb_cgroup_uncharge_file_region(resv, rg,
+							    t - rg->from);
 		} else {		/* Trim end of region */
 			del += rg->to - f;
 			rg->to = f;
+
+			hugetlb_cgroup_uncharge_file_region(resv, rg,
+							    rg->to - f);
 		}
 	}

 	spin_unlock(&resv->lock);
 	kfree(nrg);
+
 	return del;
 }

@@ -2017,7 +2047,7 @@ static long __vma_reservation_common(struct hstate *h,
 		VM_BUG_ON(dummy_out_regions_needed != 1);
 		break;
 	case VMA_COMMIT_RESV:
-		ret = region_add(resv, idx, idx + 1, 1);
+		ret = region_add(NULL, NULL, resv, idx, idx + 1, 1);
 		/* region_add calls of range 1 should never fail. */
 		VM_BUG_ON(ret < 0);
 		break;
@@ -2027,7 +2057,7 @@ static long __vma_reservation_common(struct hstate *h,
 		break;
 	case VMA_ADD_RESV:
 		if (vma->vm_flags & VM_MAYSHARE) {
-			ret = region_add(resv, idx, idx + 1, 1);
+			ret = region_add(NULL, NULL, resv, idx, idx + 1, 1);
 			/* region_add calls of range 1 should never fail. */
 			VM_BUG_ON(ret < 0);
 		} else {
@@ -4688,7 +4718,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
-	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
@@ -4729,19 +4759,6 @@ int hugetlb_reserve_pages(struct inode *inode,

 		chg = to - from;

-		if (hugetlb_cgroup_charge_cgroup(hstate_index(h),
-						 chg * pages_per_huge_page(h),
-						 &h_cg, true)) {
-			kref_put(&resv_map->refs, resv_map_release);
-			return -ENOMEM;
-		}
-
-		/*
-		 * Since this branch handles private mappings, we attach the
-		 * counter to uncharge for this reservation off resv_map.
-		 */
-		resv_map_set_hugetlb_cgroup_uncharge_info(resv_map, h_cg, h);
-
 		set_vma_resv_map(vma, resv_map);
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
@@ -4751,6 +4768,21 @@ int hugetlb_reserve_pages(struct inode *inode,
 		goto out_err;
 	}

+	ret = hugetlb_cgroup_charge_cgroup(
+		hstate_index(h), chg * pages_per_huge_page(h), &h_cg, true);
+
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
+		/* For private mappings, the hugetlb_cgroup uncharge info hangs
+		 * of the resv_map.
+		 */
+		resv_map_set_hugetlb_cgroup_uncharge_info(resv_map, h_cg, h);
+	}
+
 	/*
 	 * There must be enough pages in the subpool for the mapping. If
 	 * the subpool has a minimum size, there may be some global
@@ -4759,7 +4791,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
 	if (gbl_reserve < 0) {
 		ret = -ENOSPC;
-		goto out_err;
+		goto out_uncharge_cgroup;
 	}

 	/*
@@ -4768,9 +4800,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4785,7 +4815,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		add = region_add(resv_map, from, to, regions_needed);
+		add = region_add(h, h_cg, resv_map, from, to, regions_needed);

 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
@@ -4802,12 +4832,23 @@ int hugetlb_reserve_pages(struct inode *inode,
 			 */
 			long rsv_adjust;

-			rsv_adjust = hugepage_subpool_put_pages(spool,
-								chg - add);
+			hugetlb_cgroup_uncharge_cgroup(
+				hstate_index(h),
+				(chg - add) * pages_per_huge_page(h), h_cg,
+				true);
+
+			rsv_adjust =
+				hugepage_subpool_put_pages(spool, chg - add);
 			hugetlb_acct_memory(h, -rsv_adjust);
 		}
 	}
 	return 0;
+out_put_pages:
+	/* put back original number of pages, chg */
+	(void)hugepage_subpool_put_pages(spool, chg);
+out_uncharge_cgroup:
+	hugetlb_cgroup_uncharge_cgroup(
+		hstate_index(h), chg * pages_per_huge_page(h), h_cg, true);
 out_err:
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index e079513c8de0d..916ee24cc50d3 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -326,6 +326,21 @@ void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
 	css_put(resv->css);
 }

+void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
+					 struct file_region *rg,
+					 unsigned long nr_pages)
+{
+	if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
+		return;
+
+	if (rg->reservation_counter && rg->pages_per_hpage && nr_pages > 0 &&
+	    !resv->reservation_counter) {
+		page_counter_uncharge(rg->reservation_counter,
+				      nr_pages * rg->pages_per_hpage);
+		css_put(rg->css);
+	}
+}
+
 enum {
 	RES_USAGE,
 	RES_RSVD_USAGE,
--
2.25.0.341.g760bfbb309-goog
