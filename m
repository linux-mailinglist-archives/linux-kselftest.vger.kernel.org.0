Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C639D9F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 01:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfHZXdN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Aug 2019 19:33:13 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:57123 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfHZXdM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Aug 2019 19:33:12 -0400
Received: by mail-pl1-f202.google.com with SMTP id v4so10866421plp.23
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2019 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uc/Bxgl8/G5DxzGreN+2iN3CK7kfIwg81Xz78wt68Qs=;
        b=wVRkk70f30+NNxMobMfVFljvCZeKig2AltfxZFKj7EWrhGvu4pNqCsDIRPdta5sOQJ
         PJV/NFJCdyGaJQA21bDCR0ClrS4fLuh1bZ3yjBvEGo38Ycb33I9XJFPwqcfyALDD4Kd1
         jxIWKThikK0jY7iYN1/QVnp4PQC5hE1AFGmiRdsSj2yMtdhzww4t8jXLW/y5kZqspKFy
         uZkwFvf4/531qJkN2UVYyHrB/1heGod7g/rikvfxl1ArajgjiO9nHnPbxQ3S7SKFziw6
         0Ter772XUqYhrF/o1ACt3pkBtSP3MA5KZJUaj7owtFUDW/7m3oWebY/fQxSN4HyDI7ne
         fHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uc/Bxgl8/G5DxzGreN+2iN3CK7kfIwg81Xz78wt68Qs=;
        b=DyjyjukQtSbEsI3+TEG2aP0KELlhGNneY7IRYELlPfMlJCmq/TFYMfyo8nbciOT/rP
         v2j7wY5Mha3rfT2TjFExwnT5X3Mzv+wICyG6/aZ6q2WUOnsP/gTEo3CzTB9Y8SLiAo1d
         aCuXaRs7GTUd+78z2ipcU0dwwo1v7aePRe6eD+NXKjDMq0fgq9fxk57RIiVDZq6yUv38
         iU2JP+LzFTT+lDWWdMzoEdRY8xl+fNQUJuwFHIz6xE16L1KLDMy+5Hk/QEd7xRSLBetk
         DF2EWAymgTLDUE/brAfuInSagmDMYHCD/aI2U+n0nXGBeRN3syLYHZ93Jn2gNp2KcIG2
         3Euw==
X-Gm-Message-State: APjAAAVludPxov9pVbLzfwqLGsNaflWJxovr2FXHH5mfODGLU4Kk8p6M
        nxpQGk+aSpe7Muom188SxyAttPgvPT3Jli1AlA==
X-Google-Smtp-Source: APXvYqx1nImRSXgha8he4XQ/Sx3Ei7KiGXyU4G3j+PuAraV8jOGx3X52Nf9gp7Ulw3NmQL8Wg9OeAC9ffPAAbLKhEA==
X-Received: by 2002:a65:6815:: with SMTP id l21mr18967231pgt.146.1566862391378;
 Mon, 26 Aug 2019 16:33:11 -0700 (PDT)
Date:   Mon, 26 Aug 2019 16:32:38 -0700
In-Reply-To: <20190826233240.11524-1-almasrymina@google.com>
Message-Id: <20190826233240.11524-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20190826233240.11524-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 4/6] hugetlb_cgroup: add accounting for shared mappings
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

For shared mappings, the pointer to the hugetlb_cgroup to uncharge lives
in the resv_map entries, in file_region->reservation_counter.

When a file_region entry is added to the resv_map via region_add, we
also charge the appropriate hugetlb_cgroup and put the pointer to that
in file_region->reservation_counter. This is slightly delicate since we
need to not modify the resv_map until we know that charging the
reservation has succeeded. If charging doesn't succeed, we report the
error to the caller, so that the kernel fails the reservation.

On region_del, which is when the hugetlb memory is unreserved, we delete
the file_region entry in the resv_map, but also uncharge the
file_region->reservation_counter.

region_add() and region_chg() are heavily refactored to in this commit
to make the code easier to understand and remove duplication.

---
 mm/hugetlb.c | 443 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 280 insertions(+), 163 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c2df7574cf50..953e93359f021 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -242,208 +242,276 @@ struct file_region {
 	struct list_head link;
 	long from;
 	long to;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * On shared mappings, each reserved region appears as a struct
+	 * file_region in resv_map. These fields hold the info needed to
+	 * uncharge each reservation.
+	 */
+	struct page_counter *reservation_counter;
+	unsigned long pages_per_hpage;
+#endif
 };

-/*
- * Add the huge page range represented by [f, t) to the reserve
- * map.  In the normal case, existing regions will be expanded
- * to accommodate the specified range.  Sufficient regions should
- * exist for expansion due to the previous call to region_chg
- * with the same range.  However, it is possible that region_del
- * could have been called after region_chg and modifed the map
- * in such a way that no region exists to be expanded.  In this
- * case, pull a region descriptor from the cache associated with
- * the map and use that for the new range.
- *
- * Return the number of new huge pages added to the map.  This
- * number is greater than or equal to zero.
+/* Helper that removes a struct file_region from the resv_map cache and returns
+ * it for use.
  */
-static long region_add(struct resv_map *resv, long f, long t)
+static struct file_region *get_file_region_entry_from_cache(
+		struct resv_map *resv, long from, long to)
 {
-	struct list_head *head = &resv->regions;
-	struct file_region *rg, *nrg, *trg;
-	long add = 0;
+	struct file_region *nrg = NULL;

-	spin_lock(&resv->lock);
-	/* Locate the region we are either in or before. */
-	list_for_each_entry(rg, head, link)
-		if (f <= rg->to)
-			break;
+	VM_BUG_ON(resv->region_cache_count <= 0);

-	/*
-	 * If no region exists which can be expanded to include the
-	 * specified range, the list must have been modified by an
-	 * interleving call to region_del().  Pull a region descriptor
-	 * from the cache and use it for this range.
-	 */
-	if (&rg->link == head || t < rg->from) {
-		VM_BUG_ON(resv->region_cache_count <= 0);
+	resv->region_cache_count--;
+	nrg = list_first_entry(&resv->region_cache, struct file_region,
+			link);
+	VM_BUG_ON(!nrg);
+	list_del(&nrg->link);

-		resv->region_cache_count--;
-		nrg = list_first_entry(&resv->region_cache, struct file_region,
-					link);
-		list_del(&nrg->link);
+	nrg->from = from;
+	nrg->to = to;

-		nrg->from = f;
-		nrg->to = t;
-		list_add(&nrg->link, rg->link.prev);
+	return nrg;
+}

-		add += t - f;
-		goto out_locked;
+/* Helper that records hugetlb_cgroup uncharge info. */
+static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
+		struct file_region *nrg, struct hstate *h)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	if (h_cg) {
+		nrg->reservation_counter =
+			&h_cg->reserved_hugepage[hstate_index(h)];
+		nrg->pages_per_hpage = pages_per_huge_page(h);
 	}
+#endif
+}

-	/* Round our left edge to the current segment if it encloses us. */
-	if (f > rg->from)
-		f = rg->from;
+/* Must be called with resv->lock held. Calling this with dry_run == true will
+ * count the number of pages to be added but will not modify the linked list.
+ */
+static long add_reservations_in_range(struct resv_map *resv,
+		struct list_head *head, long f, long t,
+		struct hugetlb_cgroup *h_cg,
+		struct hstate *h,
+		bool dry_run)
+{
+	long add = 0;
+	long last_accounted_offset = f;
+	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;

-	/* Check for and consume any regions we now overlap with. */
-	nrg = rg;
-	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
-		if (&rg->link == head)
-			break;
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
+
+		/* When we find a region that starts beyond our range, we've
+		 * finished.
+		 */
 		if (rg->from > t)
 			break;

-		/* If this area reaches higher then extend our area to
-		 * include it completely.  If this is not the first area
-		 * which we intend to reuse, free it. */
-		if (rg->to > t)
-			t = rg->to;
-		if (rg != nrg) {
-			/* Decrement return value by the deleted range.
-			 * Another range will span this area so that by
-			 * end of routine add will be >= zero
-			 */
-			add -= (rg->to - rg->from);
-			list_del(&rg->link);
-			kfree(rg);
+		/* Add an entry for last_accounted_offset -> rg->from, and
+		 * update last_accounted_offset.
+		 */
+		if (rg->from > last_accounted_offset) {
+			add += rg->from - last_accounted_offset;
+			if (!dry_run) {
+				nrg = get_file_region_entry_from_cache(resv,
+						last_accounted_offset,
+						rg->from);
+				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
+						h);
+				list_add(&nrg->link, rg->link.prev);
+			}
+		}
+
+		last_accounted_offset = rg->to;
+
+		if (!dry_run) {
+			if (rg->from == rg->to) {
+				list_del(&rg->link);
+				kfree(rg);
+			}
 		}
 	}

-	add += (nrg->from - f);		/* Added to beginning of region */
-	nrg->from = f;
-	add += t - nrg->to;		/* Added to end of region */
-	nrg->to = t;
+	/* Handle the case where our range extends beyond
+	 * last_accounted_offset.
+	 */
+	if (last_accounted_offset < t) {
+		add += t - last_accounted_offset;
+		if (!dry_run) {
+			nrg = get_file_region_entry_from_cache(resv,
+					last_accounted_offset, t);
+			record_hugetlb_cgroup_uncharge_info(h_cg, nrg, h);
+			list_add(&nrg->link, rg->link.prev);
+		}
+		last_accounted_offset = t;
+	}

-out_locked:
-	resv->adds_in_progress--;
-	spin_unlock(&resv->lock);
-	VM_BUG_ON(add < 0);
 	return add;
 }

-/*
- * Examine the existing reserve map and determine how many
- * huge pages in the specified range [f, t) are NOT currently
- * represented.  This routine is called before a subsequent
- * call to region_add that will actually modify the reserve
- * map to add the specified range [f, t).  region_chg does
- * not change the number of huge pages represented by the
- * map.  However, if the existing regions in the map can not
- * be expanded to represent the new range, a new file_region
- * structure is added to the map as a placeholder.  This is
- * so that the subsequent region_add call will have all the
- * regions it needs and will not fail.
- *
- * Upon entry, region_chg will also examine the cache of region descriptors
- * associated with the map.  If there are not enough descriptors cached, one
- * will be allocated for the in progress add operation.
+static int charge_cgroup_if_shared_mapping(struct resv_map *resv,
+		struct hstate *h, long nr_pages, struct hugetlb_cgroup **h_cg)
+{
+	int ret = 0;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * If res->reservation_counter is NULL, then it means this is
+	 * a shared mapping, and hugetlb cgroup accounting should be
+	 * done on the file_region entries inside resv_map.
+	 */
+	if (!resv->reservation_counter) {
+		ret = hugetlb_cgroup_charge_cgroup(
+				hstate_index(h),
+				nr_pages * pages_per_huge_page(h),
+				h_cg, true);
+	}
+#endif
+	return ret;
+}
+
+/* This function will examine resv_map and deterimine how many huge pages are
+ * NOT currently represented. Then it will make sure resv->region_cache_count
+ * has enough entries in it to satisfy a following add_reservations_in_range
+ * call.
  *
- * Returns the number of huge pages that need to be added to the existing
- * reservation map for the range [f, t).  This number is greater or equal to
- * zero.  -ENOMEM is returned if a new file_region structure or cache entry
- * is needed and can not be allocated.
+ * Returns the number of hugepages pages NOT respresented on success with
+ * resv->lock held. Returns -ENOMEM if it needs to allocate a region_cache item
+ * and fails to do so, with the lock NOT held.
  */
-static long region_chg(struct resv_map *resv, long f, long t)
+static long allocate_enough_cache_for_range_and_lock(struct resv_map *resv,
+		long f, long t)
 {
 	struct list_head *head = &resv->regions;
-	struct file_region *rg, *nrg = NULL;
+	struct file_region *trg = NULL;
 	long chg = 0;

 retry:
 	spin_lock(&resv->lock);
-retry_locked:
-	resv->adds_in_progress++;
+
+	/* Count how many hugepages in this range are NOT respresented. */
+	chg = add_reservations_in_range(resv, head, f, t, NULL, NULL, true);

 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
-	 * the number of in progress add operations.
+	 * the number of in progress add operations. There must be at least
+	 * 1 extra in the cache.
 	 */
-	if (resv->adds_in_progress > resv->region_cache_count) {
-		struct file_region *trg;
-
-		VM_BUG_ON(resv->adds_in_progress - resv->region_cache_count > 1);
+	if (resv->region_cache_count < chg + 1) {
 		/* Must drop lock to allocate a new descriptor. */
-		resv->adds_in_progress--;
 		spin_unlock(&resv->lock);

-		trg = kmalloc(sizeof(*trg), GFP_KERNEL);
-		if (!trg) {
-			kfree(nrg);
-			return -ENOMEM;
-		}
+		while (resv->region_cache_count < chg + 1) {
+			trg = kmalloc(sizeof(*trg), GFP_KERNEL);
+			if (!trg)
+				return -ENOMEM;

-		spin_lock(&resv->lock);
-		list_add(&trg->link, &resv->region_cache);
-		resv->region_cache_count++;
-		goto retry_locked;
+			spin_lock(&resv->lock);
+			list_add(&trg->link, &resv->region_cache);
+			resv->region_cache_count++;
+			spin_unlock(&resv->lock);
+		}
+		goto retry;
 	}

-	/* Locate the region we are before or in. */
-	list_for_each_entry(rg, head, link)
-		if (f <= rg->to)
-			break;
+	return chg;
+}

-	/* If we are below the current region then a new region is required.
-	 * Subtle, allocate a new region at the position but make it zero
-	 * size such that we can guarantee to record the reservation. */
-	if (&rg->link == head || t < rg->from) {
-		if (!nrg) {
-			resv->adds_in_progress--;
-			spin_unlock(&resv->lock);
-			nrg = kmalloc(sizeof(*nrg), GFP_KERNEL);
-			if (!nrg)
-				return -ENOMEM;
+/*
+ * Add the huge page range represented by [f, t) to the reserve
+ * map.  In the normal case, existing regions will be taken off
+ * the cache to accommodate the specified range.  Sufficient
+ * regions should exist in the cache due to the previous call
+ * to region_chg with the same range, but we still check we have
+ * enough regions in the cache anyway, since something else could
+ * have consumed our regions.
+ *
+ * Return the number of new huge pages added to the map.  This
+ * number is greater than or equal to zero.  If for some reason
+ * we don't have enough entries in the cache, try to allocate
+ * more regions, and fail, we return -ENOMEM.
+ */
+static long region_add(struct hstate *h, struct resv_map *resv, long f, long t)
+{
+	struct list_head *head = &resv->regions;
+	long chg = 0, add = 0;
+	struct hugetlb_cgroup *h_cg = NULL;
+	int ret = 0;

-			nrg->from = f;
-			nrg->to   = f;
-			INIT_LIST_HEAD(&nrg->link);
-			goto retry;
-		}
+	/* Count how many charges we will need to do. Locks resv->lock on
+	 * success.
+	 */
+	chg = allocate_enough_cache_for_range_and_lock(resv, f, t);

-		list_add(&nrg->link, rg->link.prev);
-		chg = t - f;
-		goto out_nrg;
+	if (chg < 0) {
+		ret = chg;
+		spin_lock(&resv->lock);
+		goto out_locked;
 	}

-	/* Round our left edge to the current segment if it encloses us. */
-	if (f > rg->from)
-		f = rg->from;
-	chg = t - f;
+	ret = charge_cgroup_if_shared_mapping(resv, h, chg, &h_cg);

-	/* Check for and consume any regions we now overlap with. */
-	list_for_each_entry(rg, rg->link.prev, link) {
-		if (&rg->link == head)
-			break;
-		if (rg->from > t)
-			goto out;
+	if (ret)
+		goto out_locked;

-		/* We overlap with this area, if it extends further than
-		 * us then we must extend ourselves.  Account for its
-		 * existing reservation. */
-		if (rg->to > t) {
-			chg += rg->to - t;
-			t = rg->to;
-		}
-		chg -= rg->to - rg->from;
-	}
+	add = add_reservations_in_range(resv, head, f, t, h_cg, h,
+			false);

-out:
+	/*
+	 * If these aren't equal, then there is a bug with
+	 * consume_regions_we_overlap_with, and we're charging the wrong amount
+	 * of memory. This should never happen as we are holding to the lock
+	 * between the 2 add_reservations_in_range calls.
+	 */
+	WARN_ON(add != chg);
+
+out_locked:
+	resv->adds_in_progress = 0;
 	spin_unlock(&resv->lock);
-	/*  We already know we raced and no longer need the new region */
-	kfree(nrg);
-	return chg;
-out_nrg:
+	if (ret)
+		return ret;
+	VM_BUG_ON(add < 0);
+	return add;
+}
+
+/*
+ * Examine the existing reserve map and determine how many
+ * huge pages in the specified range [f, t) are NOT currently
+ * represented.  This routine is called before a subsequent
+ * call to region_add that will fill region_cache with enough
+ * entries to add the specified range [f, t).  region_chg does
+ * not change the number of huge pages represented by the
+ * map.
+ *
+ * Returns the number of huge pages that need to be added to the existing
+ * reservation map for the range [f, t).  This number is greater or equal to
+ * zero.  -ENOMEM is returned if a new file_region structure or cache entry
+ * is needed and can not be allocated.
+ */
+static long region_chg(struct resv_map *resv, long f, long t)
+{
+	long chg = allocate_enough_cache_for_range_and_lock(resv,
+			f, t);
+
+	if (chg < 0)
+		return chg;
+
+	resv->adds_in_progress = chg;
+
 	spin_unlock(&resv->lock);
 	return chg;
 }
@@ -463,10 +531,43 @@ static void region_abort(struct resv_map *resv, long f, long t)
 {
 	spin_lock(&resv->lock);
 	VM_BUG_ON(!resv->region_cache_count);
-	resv->adds_in_progress--;
+	resv->adds_in_progress = 0;
 	spin_unlock(&resv->lock);
 }

+static void get_hugetlb_cgroup_info(struct page_counter **reservation_counter,
+		unsigned long *pages_per_hpage, struct file_region *nrg)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * Save counter information from the deleted
+	 * node, in case we need to do an uncharge.
+	 */
+	*reservation_counter = nrg->reservation_counter;
+	*pages_per_hpage = nrg->pages_per_hpage;
+#endif
+}
+
+static void uncharge_cgroup_if_shared_mapping(struct resv_map *resv,
+		struct page_counter *reservation_counter,
+		unsigned long pages_per_hpage,
+		unsigned long nr_pages)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * If resv->reservation_counter is NULL, then this is shared
+	 * reservation, and the reserved memory is tracked in the file_struct
+	 * entries inside of resv_map. So we need to uncharge the memory here.
+	 */
+	if (reservation_counter && pages_per_hpage && nr_pages > 0 &&
+	    !resv->reservation_counter) {
+		hugetlb_cgroup_uncharge_counter(
+				reservation_counter,
+				nr_pages * pages_per_hpage);
+	}
+#endif
+}
+
 /*
  * Delete the specified range [f, t) from the reserve map.  If the
  * t parameter is LONG_MAX, this indicates that ALL regions after f
@@ -487,6 +588,8 @@ static long region_del(struct resv_map *resv, long f, long t)
 	struct file_region *rg, *trg;
 	struct file_region *nrg = NULL;
 	long del = 0;
+	struct page_counter *reservation_counter = NULL;
+	unsigned long pages_per_hpage = 0;

 retry:
 	spin_lock(&resv->lock);
@@ -543,6 +646,9 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+			get_hugetlb_cgroup_info(&reservation_counter,
+					&pages_per_hpage,
+					rg);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -559,6 +665,9 @@ static long region_del(struct resv_map *resv, long f, long t)

 	spin_unlock(&resv->lock);
 	kfree(nrg);
+
+	uncharge_cgroup_if_shared_mapping(resv, reservation_counter,
+			pages_per_hpage, del);
 	return del;
 }

@@ -1930,7 +2039,7 @@ static long __vma_reservation_common(struct hstate *h,
 		ret = region_chg(resv, idx, idx + 1);
 		break;
 	case VMA_COMMIT_RESV:
-		ret = region_add(resv, idx, idx + 1);
+		ret = region_add(h, resv, idx, idx + 1);
 		break;
 	case VMA_END_RESV:
 		region_abort(resv, idx, idx + 1);
@@ -1938,7 +2047,7 @@ static long __vma_reservation_common(struct hstate *h,
 		break;
 	case VMA_ADD_RESV:
 		if (vma->vm_flags & VM_MAYSHARE)
-			ret = region_add(resv, idx, idx + 1);
+			ret = region_add(h, resv, idx, idx + 1);
 		else {
 			region_abort(resv, idx, idx + 1);
 			ret = region_del(resv, idx, idx + 1);
@@ -4555,7 +4664,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 					struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
-	long ret, chg;
+	long ret, chg, add;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
@@ -4643,9 +4752,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4660,7 +4767,12 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		long add = region_add(resv_map, from, to);
+		add = region_add(h, resv_map, from, to);
+		if (add < 0) {
+			ret = -ENOMEM;
+			goto out_acct_memory;
+		}
+

 		if (unlikely(chg > add)) {
 			/*
@@ -4678,10 +4790,15 @@ int hugetlb_reserve_pages(struct inode *inode,
 		}
 	}
 	return 0;
+out_acct_memory:
+	hugetlb_acct_memory(h, -gbl_reserve);
+out_put_pages:
+	/* put back original number of pages, chg */
+	(void)hugepage_subpool_put_pages(spool, chg);
 out_err:
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
-		/* Don't call region_abort if region_chg failed */
-		if (chg >= 0)
+		/* Don't call region_abort if region_chg or region_add failed */
+		if (chg >= 0 && add >= 0)
 			region_abort(resv_map, from, to);
 	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		kref_put(&resv_map->refs, resv_map_release);
--
2.23.0.187.g17f5b7556c-goog
