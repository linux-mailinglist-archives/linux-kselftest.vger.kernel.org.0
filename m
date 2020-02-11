Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464A0159B23
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 22:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBKVb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 16:31:59 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:41427 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbgBKVb5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 16:31:57 -0500
Received: by mail-pj1-f73.google.com with SMTP id ds13so2389604pjb.6
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BVcYMblHo6641wnjh0BNcs5SfcxEom2W5cCD1WNtrzk=;
        b=vwmuNQcG7XVQMnweR9mQ+8XSocH1puBK5otPbvWSQe43bLTleyrp59ERdrTx9+/9Er
         L14Wzt7Mq4cGzIz38mn+Ahao4lVxZXvVU/zncGAaJEQxcgKD80QqK+s0xeZKaWtyo+Ke
         xIr2Zy8tfT+TnOqhEt8dIXGKwguFCCVWQwLbXHwo+fUs3Ii34N9z+OW7HA9kLiOoz0Za
         BaGN3n5ZRRSwlfiHcNiwyHuKWlPhWov6Dael5DM9/NBmkr4tgEgVWr8d/qWdIpKwF6+x
         Oa1I8UtxT5ggEpSdJgQOnzOEUuCQ2R5dgXh0hZRbYNt6vb4As9/lFHaaXxMnEbGLOIFw
         Ea9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BVcYMblHo6641wnjh0BNcs5SfcxEom2W5cCD1WNtrzk=;
        b=H/UfVFxfo/nWObETh7hyfqlWLGzlmeS9ADWUrjcL55tXh8MuQpzeqbzriBTku3epIr
         sdnnCX367uo8+KW/RZyxEoZF3oaanS7gE1I/TyzcJlbQJut1tq2qU/XwFhwbifZ5E2KE
         enGDiW/8l0a+uvORx/63u47gR5dSykEvyvOpdlC4eFqEQmLvH60i86PkOIxzJOd0q9fo
         287nC1407mCwK3QKIX2K1inUW2B7Ovm342Ww9Ftwpe6Sz5VmO5Tw0UmGt6TmbQeRXxZF
         BE+5/PGUtih0q+yu/roClHGfjzJk7yQbO6JKFQHyXEuodE6Ii4M7BlC7xPHSzTFR29v/
         UEUQ==
X-Gm-Message-State: APjAAAUOl/YqyMFNozS6yld+WOSd2/jW+GDqjihUKvkFZTmNU3FvTjxa
        Bt7CPpliq6Lp+SLWVjMzVyEocTzhn00+1Jk6HA==
X-Google-Smtp-Source: APXvYqwh97REuZatMpAdAJxZ020CapGXzTC0ReAK88RHoEJQ1sKa2W/C/PD20sjeKiwM5DMnEOcerdklPjH4wFOZSA==
X-Received: by 2002:a65:56c6:: with SMTP id w6mr9188220pgs.167.1581456716306;
 Tue, 11 Feb 2020 13:31:56 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:31:24 -0800
In-Reply-To: <20200211213128.73302-1-almasrymina@google.com>
Message-Id: <20200211213128.73302-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v12 5/9] hugetlb_cgroup: add accounting for shared mappings
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

Changes in v12:
- Removed per-file-region pages_per_hpage field.
- Rearranged some function params.
- Fixed goto out_put_pages error condition.

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
 include/linux/hugetlb.h        |  35 ++++++++
 include/linux/hugetlb_cgroup.h |  10 +++
 mm/hugetlb.c                   | 148 +++++++++++++++++++++------------
 mm/hugetlb_cgroup.c            |  15 ++++
 4 files changed, 154 insertions(+), 54 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5491932ea5758..50480d16bd334 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -57,6 +57,41 @@ struct resv_map {
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
+	struct cgroup_subsys_state *css;
+#endif
+};
+
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 9974817eb995f..a09d4164ba910 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -133,11 +133,21 @@ extern void hugetlb_cgroup_uncharge_counter(struct resv_map *resv,
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
+static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
+						       struct file_region *rg,
+						       unsigned long nr_pages)
+{
+}
+
 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
 {
 	return NULL;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57739e1aedeca..a9171c3cbed6b 100644
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
@@ -266,6 +241,41 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
 	return nrg;
 }

+static void copy_hugetlb_cgroup_uncharge_info(struct file_region *nrg,
+					      struct file_region *rg)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	nrg->reservation_counter = rg->reservation_counter;
+	nrg->css = rg->css;
+	if (rg->css)
+		css_get(rg->css);
+#endif
+}
+
+/* Helper that records hugetlb_cgroup uncharge info. */
+static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
+						struct hstate *h,
+						struct resv_map *resv,
+						struct file_region *nrg)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	if (h_cg) {
+		nrg->reservation_counter =
+			&h_cg->rsvd_hugepage[hstate_index(h)];
+		nrg->css = &h_cg->css;
+		if (!resv->pages_per_hpage)
+			resv->pages_per_hpage = pages_per_huge_page(h);
+		/* pages_per_hpage should be the same for all entries in
+		 * a resv_map.
+		 */
+		VM_BUG_ON(resv->pages_per_hpage != pages_per_huge_page(h));
+	} else {
+		nrg->reservation_counter = NULL;
+		nrg->css = NULL;
+	}
+#endif
+}
+
 /* Must be called with resv->lock held. Calling this with count_only == true
  * will count the number of pages to be added but will not modify the linked
  * list. If regions_needed != NULL and count_only == true, then regions_needed
@@ -273,7 +283,9 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
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
@@ -312,6 +324,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 			if (!count_only) {
 				nrg = get_file_region_entry_from_cache(
 					resv, last_accounted_offset, rg->from);
+				record_hugetlb_cgroup_uncharge_info(h_cg, h,
+								    resv, nrg);
 				list_add(&nrg->link, rg->link.prev);
 			} else if (regions_needed)
 				*regions_needed += 1;
@@ -328,6 +342,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		if (!count_only) {
 			nrg = get_file_region_entry_from_cache(
 				resv, last_accounted_offset, t);
+			record_hugetlb_cgroup_uncharge_info(h_cg, h, resv, nrg);
 			list_add(&nrg->link, rg->link.prev);
 		} else if (regions_needed)
 			*regions_needed += 1;
@@ -355,7 +370,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
  * 1 page will only require at most 1 entry.
  */
 static long region_add(struct resv_map *resv, long f, long t,
-		       long in_regions_needed)
+		       long in_regions_needed, struct hstate *h,
+		       struct hugetlb_cgroup *h_cg)
 {
 	long add = 0, actual_regions_needed = 0, i = 0;
 	struct file_region *trg = NULL, *rg = NULL;
@@ -367,7 +383,8 @@ static long region_add(struct resv_map *resv, long f, long t,
 retry:

 	/* Count how many regions are actually needed to execute this add. */
-	add_reservation_in_range(resv, f, t, &actual_regions_needed, true);
+	add_reservation_in_range(resv, f, t, NULL, NULL, &actual_regions_needed,
+				 true);

 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
@@ -405,7 +422,7 @@ static long region_add(struct resv_map *resv, long f, long t,
 		goto retry;
 	}

-	add = add_reservation_in_range(resv, f, t, NULL, false);
+	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL, false);

 	resv->adds_in_progress -= in_regions_needed;

@@ -453,7 +470,8 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	spin_lock(&resv->lock);

 	/* Count how many hugepages in this range are NOT respresented. */
-	chg = add_reservation_in_range(resv, f, t, out_regions_needed, true);
+	chg = add_reservation_in_range(resv, f, t, NULL, NULL,
+				       out_regions_needed, true);

 	if (*out_regions_needed == 0)
 		*out_regions_needed = 1;
@@ -589,11 +607,17 @@ static long region_del(struct resv_map *resv, long f, long t)
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
@@ -601,6 +625,8 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+			hugetlb_cgroup_uncharge_file_region(resv, rg,
+							    rg->to - rg->from);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -609,9 +635,15 @@ static long region_del(struct resv_map *resv, long f, long t)
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

@@ -2018,7 +2050,7 @@ static long __vma_reservation_common(struct hstate *h,
 		VM_BUG_ON(dummy_out_regions_needed != 1);
 		break;
 	case VMA_COMMIT_RESV:
-		ret = region_add(resv, idx, idx + 1, 1);
+		ret = region_add(resv, idx, idx + 1, 1, NULL, NULL);
 		/* region_add calls of range 1 should never fail. */
 		VM_BUG_ON(ret < 0);
 		break;
@@ -2028,7 +2060,7 @@ static long __vma_reservation_common(struct hstate *h,
 		break;
 	case VMA_ADD_RESV:
 		if (vma->vm_flags & VM_MAYSHARE) {
-			ret = region_add(resv, idx, idx + 1, 1);
+			ret = region_add(resv, idx, idx + 1, 1, NULL, NULL);
 			/* region_add calls of range 1 should never fail. */
 			VM_BUG_ON(ret < 0);
 		} else {
@@ -4686,7 +4718,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
-	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
@@ -4727,19 +4759,6 @@ int hugetlb_reserve_pages(struct inode *inode,

 		chg = to - from;

-		if (hugetlb_cgroup_charge_cgroup_rsvd(
-			    hstate_index(h), chg * pages_per_huge_page(h),
-			    &h_cg)) {
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
@@ -4749,6 +4768,21 @@ int hugetlb_reserve_pages(struct inode *inode,
 		goto out_err;
 	}

+	ret = hugetlb_cgroup_charge_cgroup_rsvd(
+		hstate_index(h), chg * pages_per_huge_page(h), &h_cg);
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
@@ -4757,7 +4791,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
 	if (gbl_reserve < 0) {
 		ret = -ENOSPC;
-		goto out_err;
+		goto out_uncharge_cgroup;
 	}

 	/*
@@ -4766,9 +4800,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4783,13 +4815,11 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		add = region_add(resv_map, from, to, regions_needed);
+		add = region_add(resv_map, from, to, regions_needed, h, h_cg);

 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
-			/* put back original number of pages, chg */
-			(void)hugepage_subpool_put_pages(spool, chg);
-			goto out_err;
+			goto out_put_pages;
 		} else if (unlikely(chg > add)) {
 			/*
 			 * pages in this range were added to the reserve
@@ -4800,12 +4830,22 @@ int hugetlb_reserve_pages(struct inode *inode,
 			 */
 			long rsv_adjust;

+			hugetlb_cgroup_uncharge_cgroup_rsvd(
+				hstate_index(h),
+				(chg - add) * pages_per_huge_page(h), h_cg);
+
 			rsv_adjust = hugepage_subpool_put_pages(spool,
 								chg - add);
 			hugetlb_acct_memory(h, -rsv_adjust);
 		}
 	}
 	return 0;
+out_put_pages:
+	/* put back original number of pages, chg */
+	(void)hugepage_subpool_put_pages(spool, chg);
+out_uncharge_cgroup:
+	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
+					    chg * pages_per_huge_page(h), h_cg);
 out_err:
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index bae7bf6b8372f..ad777fecad28a 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -392,6 +392,21 @@ void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
 	css_put(resv->css);
 }

+void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
+					 struct file_region *rg,
+					 unsigned long nr_pages)
+{
+	if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
+		return;
+
+	if (rg->reservation_counter && resv->pages_per_hpage && nr_pages > 0 &&
+	    !resv->reservation_counter) {
+		page_counter_uncharge(rg->reservation_counter,
+				      nr_pages * resv->pages_per_hpage);
+		css_put(rg->css);
+	}
+}
+
 enum {
 	RES_USAGE,
 	RES_RSVD_USAGE,
--
2.25.0.225.g125e21ebc7-goog
