Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74DBAD5380
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2019 02:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfJMAan (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 20:30:43 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39795 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbfJMAam (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 20:30:42 -0400
Received: by mail-pl1-f201.google.com with SMTP id w11so8185854ply.6
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2019 17:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7D+BwcFwF9MIweYeaUnktctPXmN7Px2zmN0DVSpL+yk=;
        b=DKrO4FjB33f9+BhpISVLb63wTqT5BuDpR92MaWPe0wr07ZXPaqHGc0tYhK/9LwXXIy
         zQlEvMvVhuPCoMvoAo8rEq46qD9Y/TufAMKPDSyBQ1eIufEKg6IIYKK4i90ZDGTPglxg
         v0wJ5JBS/QwMpw+t0MYamZ5yqh3TqKsgest3XIIFfx8tydbW+zvi66Ef2wQdQ71D/U/+
         4zNdHNG1J9pQK8bsyXjNjE2KuvILv1AfB1hi7nj9kP79wnTU0bLzZw8OckpOKq7ZSvrW
         jdI2+Qjng5cITuECeHDsmGZOyKp12bm/wLbPlouACcTAGfumKm5imVJig7n/6fgKA5Ii
         sbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7D+BwcFwF9MIweYeaUnktctPXmN7Px2zmN0DVSpL+yk=;
        b=t25UWPBlpOknUnqtgdHbrcEqGYrbOUTf+j6pRppuRHaRgrJJv1xhAZ/Uh45TaSNrl8
         QSPBVhel1ZAt3ZQvletl/xGEpcySL4Gkh06bkXGUg6y4CsY3tuI+h8lWY2hSx2cOSEmx
         I7u71bEzazdrT2OE6ScCNmdog2uYfckgZOEZQ0L+ouYxi/BkzKd6efXmfnUdnRFIKctF
         1mTUnicGuKnDoJVvTxh85yxu+Nk9TPe1UVKpMJC1SPl1FqeLBQQ7c2LtsA9f1VtQxLpX
         vK3P64iI+Z8xHXCdmZDZZxywPi7MaS2LR9Pv9OyYbWAXK95PLqq41TSnnUvNcH1BiBiw
         5Ujw==
X-Gm-Message-State: APjAAAUlL1+HVYUo+jAqzbq/lvyF9HQK034U8TC1H0l11dG+dOmFwvGo
        zsj89fl7Tzv238rXyjdAZ8GxGns/flY1NFmnHA==
X-Google-Smtp-Source: APXvYqwNcTMUfpeALxNxyO+727Acah9psvwfnkoRfG/8TpDRhe9bRbhhRZ0u+DKKPenst2XENPL6G+5qFroLgZiDiA==
X-Received: by 2002:a63:36c7:: with SMTP id d190mr24464655pga.287.1570926639409;
 Sat, 12 Oct 2019 17:30:39 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:30:20 -0700
In-Reply-To: <20191013003024.215429-1-almasrymina@google.com>
Message-Id: <20191013003024.215429-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20191013003024.215429-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v6 5/9] hugetlb: disable region_add file_region coalescing
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

A follow up patch in this series adds hugetlb cgroup uncharge info the
file_region entries in resv->regions. The cgroup uncharge info may
differ for different regions, so they can no longer be coalesced at
region_add time. So, disable region coalescing in region_add in this
patch.

Behavior change:

Say a resv_map exists like this [0->1], [2->3], and [5->6].

Then a region_chg/add call comes in region_chg/add(f=0, t=5).

Old code would generate resv->regions: [0->5], [5->6].
New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
[5->6].

Special care needs to be taken to handle the resv->adds_in_progress
variable correctly. In the past, only 1 region would be added for every
region_chg and region_add call. But now, each call may add multiple
regions, so we can no longer increment adds_in_progress by 1 in region_chg,
or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
region_chg calls add_reservation_in_range() to count the number of regions
needed and allocates those, and that info is passed to region_add and
region_abort to decrement adds_in_progress correctly.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v6:
- Fix bug in number of region_caches allocated by region_chg

---
 mm/hugetlb.c | 256 +++++++++++++++++++++++++++++----------------------
 1 file changed, 147 insertions(+), 109 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a60d7d44b4c3..f9c1947925bb9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -244,6 +244,12 @@ struct file_region {
 	long to;
 };

+/* Helper that removes a struct file_region from the resv_map cache and returns
+ * it for use.
+ */
+static struct file_region *
+get_file_region_entry_from_cache(struct resv_map *resv, long from, long to);
+
 /* Must be called with resv->lock held. Calling this with count_only == true
  * will count the number of pages to be added but will not modify the linked
  * list.
@@ -251,51 +257,61 @@ struct file_region {
 static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 				     bool count_only)
 {
-	long chg = 0;
+	long add = 0;
 	struct list_head *head = &resv->regions;
+	long last_accounted_offset = f;
 	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;

-	/* Locate the region we are before or in. */
-	list_for_each_entry (rg, head, link)
-		if (f <= rg->to)
-			break;
-
-	/* Round our left edge to the current segment if it encloses us. */
-	if (f > rg->from)
-		f = rg->from;
-
-	chg = t - f;
+	/* In this loop, we essentially handle an entry for the range
+	 * last_accounted_offset -> rg->from, at every iteration, with some
+	 * bounds checking.
+	 */
+	list_for_each_entry_safe(rg, trg, head, link) {
+		/* Skip irrelevant regions that start before our range. */
+		if (rg->from < f) {
+			/* If this region ends after the last accounted offset,
+			 * then we need to update last_accounted_offset.
+			 */
+			if (rg->to > last_accounted_offset)
+				last_accounted_offset = rg->to;
+			continue;
+		}

-	/* Check for and consume any regions we now overlap with. */
-	nrg = rg;
-	list_for_each_entry_safe (rg, trg, rg->link.prev, link) {
-		if (&rg->link == head)
-			break;
+		/* When we find a region that starts beyond our range, we've
+		 * finished.
+		 */
 		if (rg->from > t)
 			break;

-		/* We overlap with this area, if it extends further than
-		 * us then we must extend ourselves.  Account for its
-		 * existing reservation.
+		/* Add an entry for last_accounted_offset -> rg->from, and
+		 * update last_accounted_offset.
 		 */
-		if (rg->to > t) {
-			chg += rg->to - t;
-			t = rg->to;
+		if (rg->from > last_accounted_offset) {
+			add += rg->from - last_accounted_offset;
+			if (!count_only) {
+				nrg = get_file_region_entry_from_cache(
+					resv, last_accounted_offset, rg->from);
+				list_add(&nrg->link, rg->link.prev);
+			}
 		}
-		chg -= rg->to - rg->from;

-		if (!count_only && rg != nrg) {
-			list_del(&rg->link);
-			kfree(rg);
-		}
+		last_accounted_offset = rg->to;
 	}

-	if (!count_only) {
-		nrg->from = f;
-		nrg->to = t;
+	/* Handle the case where our range extends beyond
+	 * last_accounted_offset.
+	 */
+	if (last_accounted_offset < t) {
+		add += t - last_accounted_offset;
+		if (!count_only) {
+			nrg = get_file_region_entry_from_cache(
+				resv, last_accounted_offset, t);
+			list_add(&nrg->link, rg->link.prev);
+		}
+		last_accounted_offset = t;
 	}

-	return chg;
+	return add;
 }

 /*
@@ -305,46 +321,24 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
  * must exist in the cache due to the previous call to region_chg with
  * the same range.
  *
+ * regions_needed is the out value provided by a previous
+ * call to region_chg.
+ *
  * Return the number of new huge pages added to the map.  This
  * number is greater than or equal to zero.
  */
-static long region_add(struct resv_map *resv, long f, long t)
+static long region_add(struct resv_map *resv, long f, long t,
+		       long regions_needed)
 {
-	struct list_head *head = &resv->regions;
-	struct file_region *rg, *nrg;
 	long add = 0;

 	spin_lock(&resv->lock);
-	/* Locate the region we are either in or before. */
-	list_for_each_entry(rg, head, link)
-		if (f <= rg->to)
-			break;
-
-	/*
-	 * If no region exists which can be expanded to include the
-	 * specified range, pull a region descriptor from the cache
-	 * and use it for this range.
-	 */
-	if (&rg->link == head || t < rg->from) {
-		VM_BUG_ON(resv->region_cache_count <= 0);
-
-		resv->region_cache_count--;
-		nrg = list_first_entry(&resv->region_cache, struct file_region,
-					link);
-		list_del(&nrg->link);

-		nrg->from = f;
-		nrg->to = t;
-		list_add(&nrg->link, rg->link.prev);
-
-		add += t - f;
-		goto out_locked;
-	}
+	VM_BUG_ON(resv->region_cache_count < regions_needed);

 	add = add_reservation_in_range(resv, f, t, false);
+	resv->adds_in_progress -= regions_needed;

-out_locked:
-	resv->adds_in_progress--;
 	spin_unlock(&resv->lock);
 	VM_BUG_ON(add < 0);
 	return add;
@@ -361,31 +355,39 @@ static long region_add(struct resv_map *resv, long f, long t)
  * as a placeholder, so that the subsequent region_add
  * call will have all the regions it needs and will not fail.
  *
+ * out_regions_needed is the number of regions added to the
+ * resv->region_cache_count.  This value needs to be provided to a follow up
+ * call to region_add or region_abort for proper accounting.
+ *
  * Returns the number of huge pages that need to be added to the existing
  * reservation map for the range [f, t).  This number is greater or equal to
  * zero.  -ENOMEM is returned if a new file_region structure or cache entry
  * is needed and can not be allocated.
  */
-static long region_chg(struct resv_map *resv, long f, long t)
+static long region_chg(struct resv_map *resv, long f, long t,
+		       long *out_regions_needed)
 {
+	struct file_region *trg = NULL;
 	long chg = 0;

+	/* Allocate the maximum number of regions we're going to need for this
+	 * reservation. The maximum number of regions we're going to need is
+	 * (t - f) / 2 + 1, which corresponds to a region with alternating
+	 * reserved and unreserved pages.
+	 */
+	*out_regions_needed = (t - f) / 2 + 1;
+
 	spin_lock(&resv->lock);
-retry_locked:
-	resv->adds_in_progress++;
+
+	resv->adds_in_progress += *out_regions_needed;

 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
 	 * the number of in progress add operations.
 	 */
-	if (resv->adds_in_progress > resv->region_cache_count) {
-		struct file_region *trg;
-
-		VM_BUG_ON(resv->adds_in_progress - resv->region_cache_count > 1);
+	while (resv->region_cache_count < resv->adds_in_progress) {
 		/* Must drop lock to allocate a new descriptor. */
-		resv->adds_in_progress--;
 		spin_unlock(&resv->lock);
-
 		trg = kmalloc(sizeof(*trg), GFP_KERNEL);
 		if (!trg)
 			return -ENOMEM;
@@ -393,9 +395,9 @@ static long region_chg(struct resv_map *resv, long f, long t)
 		spin_lock(&resv->lock);
 		list_add(&trg->link, &resv->region_cache);
 		resv->region_cache_count++;
-		goto retry_locked;
 	}

+	/* Count how many hugepages in this range are NOT respresented. */
 	chg = add_reservation_in_range(resv, f, t, true);

 	spin_unlock(&resv->lock);
@@ -407,17 +409,19 @@ static long region_chg(struct resv_map *resv, long f, long t)
  * of the resv_map keeps track of the operations in progress between
  * calls to region_chg and region_add.  Operations are sometimes
  * aborted after the call to region_chg.  In such cases, region_abort
- * is called to decrement the adds_in_progress counter.
+ * is called to decrement the adds_in_progress counter. regions_needed
+ * is the value returned by the region_chg call, it is used to decrement
+ * the adds_in_progress counter.
  *
  * NOTE: The range arguments [f, t) are not needed or used in this
  * routine.  They are kept to make reading the calling code easier as
  * arguments will match the associated region_chg call.
  */
-static void region_abort(struct resv_map *resv, long f, long t)
+static void region_abort(struct resv_map *resv, long f, long t,
+			 long regions_needed)
 {
 	spin_lock(&resv->lock);
-	VM_BUG_ON(!resv->region_cache_count);
-	resv->adds_in_progress--;
+	resv->adds_in_progress -= regions_needed;
 	spin_unlock(&resv->lock);
 }

@@ -1898,9 +1902,10 @@ enum vma_resv_mode {
 	VMA_END_RESV,
 	VMA_ADD_RESV,
 };
-static long __vma_reservation_common(struct hstate *h,
-				struct vm_area_struct *vma, unsigned long addr,
-				enum vma_resv_mode mode)
+static long
+__vma_reservation_common(struct hstate *h, struct vm_area_struct *vma,
+			 unsigned long addr, enum vma_resv_mode mode,
+			 long *out_regions_needed, long in_regions_needed)
 {
 	struct resv_map *resv;
 	pgoff_t idx;
@@ -1913,20 +1918,24 @@ static long __vma_reservation_common(struct hstate *h,
 	idx = vma_hugecache_offset(h, vma, addr);
 	switch (mode) {
 	case VMA_NEEDS_RESV:
-		ret = region_chg(resv, idx, idx + 1);
+		VM_BUG_ON(!out_regions_needed);
+		ret = region_chg(resv, idx, idx + 1, out_regions_needed);
 		break;
 	case VMA_COMMIT_RESV:
-		ret = region_add(resv, idx, idx + 1);
+		VM_BUG_ON(in_regions_needed == -1);
+		ret = region_add(resv, idx, idx + 1, in_regions_needed);
 		break;
 	case VMA_END_RESV:
-		region_abort(resv, idx, idx + 1);
+		VM_BUG_ON(in_regions_needed == -1);
+		region_abort(resv, idx, idx + 1, in_regions_needed);
 		ret = 0;
 		break;
 	case VMA_ADD_RESV:
+		VM_BUG_ON(in_regions_needed == -1);
 		if (vma->vm_flags & VM_MAYSHARE)
-			ret = region_add(resv, idx, idx + 1);
+			ret = region_add(resv, idx, idx + 1, in_regions_needed);
 		else {
-			region_abort(resv, idx, idx + 1);
+			region_abort(resv, idx, idx + 1, in_regions_needed);
 			ret = region_del(resv, idx, idx + 1);
 		}
 		break;
@@ -1959,28 +1968,32 @@ static long __vma_reservation_common(struct hstate *h,
 		return ret < 0 ? ret : 0;
 }

-static long vma_needs_reservation(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long addr)
+static long vma_needs_reservation(struct hstate *h, struct vm_area_struct *vma,
+				  unsigned long addr, long *out_regions_needed)
 {
-	return __vma_reservation_common(h, vma, addr, VMA_NEEDS_RESV);
+	return __vma_reservation_common(h, vma, addr, VMA_NEEDS_RESV,
+					out_regions_needed, -1);
 }

-static long vma_commit_reservation(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long addr)
+static long vma_commit_reservation(struct hstate *h, struct vm_area_struct *vma,
+				   unsigned long addr, long regions_needed)
 {
-	return __vma_reservation_common(h, vma, addr, VMA_COMMIT_RESV);
+	return __vma_reservation_common(h, vma, addr, VMA_COMMIT_RESV, NULL,
+					regions_needed);
 }

-static void vma_end_reservation(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long addr)
+static void vma_end_reservation(struct hstate *h, struct vm_area_struct *vma,
+				unsigned long addr, long regions_needed)
 {
-	(void)__vma_reservation_common(h, vma, addr, VMA_END_RESV);
+	(void)__vma_reservation_common(h, vma, addr, VMA_END_RESV, NULL,
+				       regions_needed);
 }

-static long vma_add_reservation(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long addr)
+static long vma_add_reservation(struct hstate *h, struct vm_area_struct *vma,
+				unsigned long addr, long regions_needed)
 {
-	return __vma_reservation_common(h, vma, addr, VMA_ADD_RESV);
+	return __vma_reservation_common(h, vma, addr, VMA_ADD_RESV, NULL,
+					regions_needed);
 }

 /*
@@ -1998,8 +2011,10 @@ static void restore_reserve_on_error(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address,
 			struct page *page)
 {
+	long regions_needed = 0;
 	if (unlikely(PagePrivate(page))) {
-		long rc = vma_needs_reservation(h, vma, address);
+		long rc =
+			vma_needs_reservation(h, vma, address, &regions_needed);

 		if (unlikely(rc < 0)) {
 			/*
@@ -2015,7 +2030,8 @@ static void restore_reserve_on_error(struct hstate *h,
 			 */
 			ClearPagePrivate(page);
 		} else if (rc) {
-			rc = vma_add_reservation(h, vma, address);
+			rc = vma_add_reservation(h, vma, address,
+						 regions_needed);
 			if (unlikely(rc < 0))
 				/*
 				 * See above comment about rare out of
@@ -2023,7 +2039,7 @@ static void restore_reserve_on_error(struct hstate *h,
 				 */
 				ClearPagePrivate(page);
 		} else
-			vma_end_reservation(h, vma, address);
+			vma_end_reservation(h, vma, address, regions_needed);
 	}
 }

@@ -2037,6 +2053,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	long gbl_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg;
+	long regions_needed = 0;

 	idx = hstate_index(h);
 	/*
@@ -2044,7 +2061,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * has a reservation for the page to be allocated.  A return
 	 * code of zero indicates a reservation exists (no change).
 	 */
-	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
+	map_chg = gbl_chg =
+		vma_needs_reservation(h, vma, addr, &regions_needed);
 	if (map_chg < 0)
 		return ERR_PTR(-ENOMEM);

@@ -2058,7 +2076,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	if (map_chg || avoid_reserve) {
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
 		if (gbl_chg < 0) {
-			vma_end_reservation(h, vma, addr);
+			vma_end_reservation(h, vma, addr, regions_needed);
 			return ERR_PTR(-ENOSPC);
 		}

@@ -2105,7 +2123,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,

 	set_page_private(page, (unsigned long)spool);

-	map_commit = vma_commit_reservation(h, vma, addr);
+	map_commit = vma_commit_reservation(h, vma, addr, regions_needed);
 	if (unlikely(map_chg > map_commit)) {
 		/*
 		 * The page was added to the reservation map between
@@ -2129,7 +2147,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
-	vma_end_reservation(h, vma, addr);
+	vma_end_reservation(h, vma, addr, regions_needed);
 	return ERR_PTR(-ENOSPC);
 }

@@ -3850,6 +3868,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page = false;
+	long regions_needed = 0;

 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -3967,12 +3986,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * the spinlock.
 	 */
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+		if (vma_needs_reservation(h, vma, haddr, &regions_needed) < 0) {
 			ret = VM_FAULT_OOM;
 			goto backout_unlocked;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		vma_end_reservation(h, vma, haddr, regions_needed);
 	}

 	ptl = huge_pte_lock(h, mm, ptep);
@@ -4062,6 +4081,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct address_space *mapping;
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
+	long regions_needed = 0;

 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
@@ -4116,12 +4136,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * consumed.
 	 */
 	if ((flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+		if (vma_needs_reservation(h, vma, haddr, &regions_needed) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		vma_end_reservation(h, vma, haddr, regions_needed);

 		if (!(vma->vm_flags & VM_MAYSHARE))
 			pagecache_page = hugetlbfs_pagecache_page(h,
@@ -4584,7 +4604,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg;
-	long gbl_reserve;
+	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
 	if (from > to) {
@@ -4614,7 +4634,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 		 */
 		resv_map = inode_resv_map(inode);

-		chg = region_chg(resv_map, from, to);
+		chg = region_chg(resv_map, from, to, &regions_needed);

 	} else {
 		/* Private mapping. */
@@ -4684,7 +4704,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		long add = region_add(resv_map, from, to);
+		long add = region_add(resv_map, from, to, regions_needed);

 		if (unlikely(chg > add)) {
 			/*
@@ -4706,7 +4726,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Don't call region_abort if region_chg failed */
 		if (chg >= 0)
-			region_abort(resv_map, from, to);
+			region_abort(resv_map, from, to, regions_needed);
 	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		kref_put(&resv_map->refs, resv_map_release);
 	return ret;
@@ -5130,3 +5150,21 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		spin_unlock(&hugetlb_lock);
 	}
 }
+
+static struct file_region *
+get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
+{
+	struct file_region *nrg = NULL;
+
+	VM_BUG_ON(resv->region_cache_count <= 0);
+
+	resv->region_cache_count--;
+	nrg = list_first_entry(&resv->region_cache, struct file_region, link);
+	VM_BUG_ON(!nrg);
+	list_del(&nrg->link);
+
+	nrg->from = from;
+	nrg->to = to;
+
+	return nrg;
+}
--
2.23.0.700.g56cf767bdb-goog
