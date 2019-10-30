Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5EE94BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 02:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfJ3Bhk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Oct 2019 21:37:40 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:54317 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfJ3BhR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Oct 2019 21:37:17 -0400
Received: by mail-qk1-f202.google.com with SMTP id v143so577651qka.21
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2019 18:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1iVFDgQE5aQOaG321Q+7/TumZqho77N7vysWifp5RIY=;
        b=S4w2I2+YZkckAY8eCcovUqdJ3EOoH2TtxLzmDp9hKi1PxjKAotEIARK/1Oj7zRpW6l
         1ubMQZhUwNLhUiAzRndjrIZH56+N38umNTDsyotUBY/JJaWhdTWoMfy5fJ7PJB6mCa6H
         TX5vt9KnWGra+fFcCPz2Ih/rRN/n3CWoJR3VlvPudZLjairOEzpdi9r0QSzy8+MqiFQ2
         CpLjmzJZrVpzRMyrJcHR79nVkHCakKkCL8MUzFT9CUANaSigb73o7rwmXCIiducnNEbN
         Lsleb/NPr/wF6VKdDWNyeNQNQqDna0tazhSIVygXgUdMods4yCn8q7nVwPWTfViLU9On
         ysrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1iVFDgQE5aQOaG321Q+7/TumZqho77N7vysWifp5RIY=;
        b=FAMC3PRg2KZh4onBNhBpriY+eBUKL1E74CHxEEkP1tCSxJJZpRJk411QglWNC3XAEz
         UilbqFIDzdSSeDbRDCZdBTZWfYtirzVFcif2RxDdieJy5l6Eg3jtBcqie6twr6UDKMU1
         /L/lfZWSjwX1KLTUqsbIh42ptvyR03m+8KjMcHd0ZV1o3SY/sgX/pU4QRFD2xG8dCFgW
         HqpmplipD3N5B9qR8KangISv7CTbLnFiX0JcBeWZy1YWAtvWEuz/In05UdvE4g7tkJb9
         YoZyHCr4W3c8mEQSW4a91EZC8XdmDIPvqf2/FX/W/x8qQd8ZP34plnamQSZKZJnGulZx
         FuNg==
X-Gm-Message-State: APjAAAWS5Hd2pZ5t5MFKl17RslEL3YhuEV9lZ4RF4t9p/cTbnsHheI4P
        CEW9hJKUEWSukkLSknQmtXT5ebzLA2XHEYZ3IA==
X-Google-Smtp-Source: APXvYqzxCjkyY4/El7thj1QApQvQJF9pkhfX1XT1gpKeTDZziigEnT6sUyoZHHBujTXp2m8CeV6yP/TSa9yGLlm/sw==
X-Received: by 2002:a0c:eda9:: with SMTP id h9mr12337780qvr.41.1572399436096;
 Tue, 29 Oct 2019 18:37:16 -0700 (PDT)
Date:   Tue, 29 Oct 2019 18:36:57 -0700
In-Reply-To: <20191030013701.39647-1-almasrymina@google.com>
Message-Id: <20191030013701.39647-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v8 5/9] hugetlb: disable region_add file_region coalescing
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
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
Changes in v8:
- Addressed comments from Mike, especially:
  - fixing region_add not allocating enough regions sometimes.
  - reverted vma_*_reservation API changes.
Changes in v7:
- region_chg no longer allocates (t-f) / 2 file_region entries.
Changes in v6:
- Fix bug in number of region_caches allocated by region_chg

---
 mm/hugetlb.c | 315 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 213 insertions(+), 102 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8d8aa89a9928e..1162eeaf8d160 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -244,110 +244,178 @@ struct file_region {
 	long to;
 };

+/* Helper that removes a struct file_region from the resv_map cache and returns
+ * it for use.
+ */
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
+
 /* Must be called with resv->lock held. Calling this with count_only == true
  * will count the number of pages to be added but will not modify the linked
- * list.
+ * list. If regions_needed != NULL and count_only == true, then regions_needed
+ * will indicate the number of file_regions needed in the cache to carry out to
+ * add the regions for this range.
  */
 static long add_reservation_in_range(struct resv_map *resv, long f, long t,
-				     bool count_only)
+				     long *regions_needed, bool count_only)
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
+	if (regions_needed)
+		*regions_needed = 0;

-	/* Round our left edge to the current segment if it encloses us. */
-	if (f > rg->from)
-		f = rg->from;
-
-	chg = t - f;
+	/* In this loop, we essentially handle an entry for the range
+	 * [last_accounted_offset, rg->from), at every iteration, with some
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
+			} else if (regions_needed)
+				*regions_needed += 1;
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
+		} else if (regions_needed)
+			*regions_needed += 1;
+		last_accounted_offset = t;
 	}

-	return chg;
+	return add;
 }

 /*
  * Add the huge page range represented by [f, t) to the reserve
- * map.  Existing regions will be expanded to accommodate the specified
- * range, or a region will be taken from the cache.  Sufficient regions
- * must exist in the cache due to the previous call to region_chg with
- * the same range.
+ * map.  Regions will be taken from the cache to fill in this range.
+ * Sufficient regions should exist in the cache due to the previous
+ * call to region_chg with the same range, but in some cases the cache will not
+ * have sufficient entries.  The extra needed entries will be allocated.
+ *
+ * regions_needed is the out value provided by a previous call to region_chg.
  *
- * Return the number of new huge pages added to the map.  This
- * number is greater than or equal to zero.
+ * Return the number of new huge pages added to the map.  This number is greater
+ * than or equal to zero.  If file_region entries needed to be allocated for
+ * this operation and we were not able to allocate, it ruturns -ENOMEM.
+ * region_add of regions of length 1 never allocate file_regions and cannot
+ * fail.
  */
-static long region_add(struct resv_map *resv, long f, long t)
+static long region_add(struct resv_map *resv, long f, long t,
+		       long in_regions_needed)
 {
-	struct list_head *head = &resv->regions;
-	struct file_region *rg, *nrg;
-	long add = 0;
+	long add = 0, actual_regions_needed = 0, i = 0;
+	struct file_region *trg = NULL, *rg = NULL;
+	struct list_head allocated_regions;
+
+	INIT_LIST_HEAD(&allocated_regions);

 	spin_lock(&resv->lock);
-	/* Locate the region we are either in or before. */
-	list_for_each_entry(rg, head, link)
-		if (f <= rg->to)
-			break;
+retry:
+
+	/* Count how many regions are actually needed to execute this add. */
+	add_reservation_in_range(resv, f, t, &actual_regions_needed, true);

 	/*
-	 * If no region exists which can be expanded to include the
-	 * specified range, pull a region descriptor from the cache
-	 * and use it for this range.
+	 * Check for sufficient descriptors in the cache to accommodate
+	 * this add operation. Note that actual_regions_needed may be greater
+	 * than in_regions_needed. In this case, we need to make sure that we
+	 * allocate extra entries, such that we have enough for all the
+	 * existing adds_in_progress, plus the excess needed for this
+	 * operation.
 	 */
-	if (&rg->link == head || t < rg->from) {
-		VM_BUG_ON(resv->region_cache_count <= 0);
+	if (resv->region_cache_count <
+	    resv->adds_in_progress +
+		    (actual_regions_needed - in_regions_needed)) {
+		/* region_add operation of range 1 should never need to
+		 * allocate file_region entries.
+		 */
+		VM_BUG_ON(t - f <= 1);

-		resv->region_cache_count--;
-		nrg = list_first_entry(&resv->region_cache, struct file_region,
-					link);
-		list_del(&nrg->link);
+		/* Must drop lock to allocate a new descriptor. */
+		spin_unlock(&resv->lock);
+		for (i = 0; i < (actual_regions_needed - in_regions_needed);
+		     i++) {
+			trg = kmalloc(sizeof(*trg), GFP_KERNEL);
+			if (!trg)
+				goto out_of_memory;
+			list_add(&trg->link, &allocated_regions);
+		}
+		spin_lock(&resv->lock);

-		nrg->from = f;
-		nrg->to = t;
-		list_add(&nrg->link, rg->link.prev);
+		list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
+			list_del(&rg->link);
+			list_add(&rg->link, &resv->region_cache);
+			resv->region_cache_count++;
+		}

-		add += t - f;
-		goto out_locked;
+		goto retry;
 	}

-	add = add_reservation_in_range(resv, f, t, false);
+	add = add_reservation_in_range(resv, f, t, NULL, false);
+
+	resv->adds_in_progress -= in_regions_needed;

-out_locked:
-	resv->adds_in_progress--;
 	spin_unlock(&resv->lock);
 	VM_BUG_ON(add < 0);
 	return add;
+
+out_of_memory:
+	list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
+		list_del(&rg->link);
+		kfree(rg);
+	}
+	return -ENOMEM;
 }

 /*
@@ -357,49 +425,72 @@ static long region_add(struct resv_map *resv, long f, long t)
  * call to region_add that will actually modify the reserve
  * map to add the specified range [f, t).  region_chg does
  * not change the number of huge pages represented by the
- * map.  A new file_region structure is added to the cache
- * as a placeholder, so that the subsequent region_add
- * call will have all the regions it needs and will not fail.
+ * map.  A number of new file_region structures is added to the cache as a
+ * placeholder, for the subsequent region_add call to use. At least 1
+ * file_region structure is added.
+ *
+ * out_regions_needed is the number of regions added to the
+ * resv->adds_in_progress.  This value needs to be provided to a follow up call
+ * to region_add or region_abort for proper accounting.
  *
  * Returns the number of huge pages that need to be added to the existing
  * reservation map for the range [f, t).  This number is greater or equal to
  * zero.  -ENOMEM is returned if a new file_region structure or cache entry
  * is needed and can not be allocated.
  */
-static long region_chg(struct resv_map *resv, long f, long t)
+static long region_chg(struct resv_map *resv, long f, long t,
+		       long *out_regions_needed)
 {
-	long chg = 0;
+	struct file_region *trg = NULL, *rg = NULL;
+	long chg = 0, i = 0, to_allocate = 0;
+	struct list_head allocated_regions;
+
+	INIT_LIST_HEAD(&allocated_regions);

 	spin_lock(&resv->lock);
-retry_locked:
-	resv->adds_in_progress++;
+
+	/* Count how many hugepages in this range are NOT respresented. */
+	chg = add_reservation_in_range(resv, f, t, out_regions_needed, true);
+
+	if (*out_regions_needed < 1)
+		*out_regions_needed = 1;
+
+	resv->adds_in_progress += *out_regions_needed;

 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
 	 * the number of in progress add operations.
 	 */
-	if (resv->adds_in_progress > resv->region_cache_count) {
-		struct file_region *trg;
+	while (resv->region_cache_count < resv->adds_in_progress) {
+		to_allocate = resv->adds_in_progress - resv->region_cache_count;

-		VM_BUG_ON(resv->adds_in_progress - resv->region_cache_count > 1);
 		/* Must drop lock to allocate a new descriptor. */
-		resv->adds_in_progress--;
 		spin_unlock(&resv->lock);
-
-		trg = kmalloc(sizeof(*trg), GFP_KERNEL);
-		if (!trg)
-			return -ENOMEM;
+		for (i = 0; i < to_allocate; i++) {
+			trg = kmalloc(sizeof(*trg), GFP_KERNEL);
+			if (!trg)
+				goto out_of_memory;
+			list_add(&trg->link, &allocated_regions);
+		}

 		spin_lock(&resv->lock);
-		list_add(&trg->link, &resv->region_cache);
-		resv->region_cache_count++;
-		goto retry_locked;
-	}

-	chg = add_reservation_in_range(resv, f, t, true);
+		list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
+			list_del(&rg->link);
+			list_add(&rg->link, &resv->region_cache);
+			resv->region_cache_count++;
+		}
+	}

 	spin_unlock(&resv->lock);
 	return chg;
+
+out_of_memory:
+	list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
+		list_del(&rg->link);
+		kfree(rg);
+	}
+	return -ENOMEM;
 }

 /*
@@ -407,17 +498,20 @@ static long region_chg(struct resv_map *resv, long f, long t)
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
 	VM_BUG_ON(!resv->region_cache_count);
-	resv->adds_in_progress--;
+	resv->adds_in_progress -= regions_needed;
 	spin_unlock(&resv->lock);
 }

@@ -1904,6 +1998,7 @@ static long __vma_reservation_common(struct hstate *h,
 	struct resv_map *resv;
 	pgoff_t idx;
 	long ret;
+	long dummy_out_regions_needed;

 	resv = vma_resv_map(vma);
 	if (!resv)
@@ -1912,20 +2007,29 @@ static long __vma_reservation_common(struct hstate *h,
 	idx = vma_hugecache_offset(h, vma, addr);
 	switch (mode) {
 	case VMA_NEEDS_RESV:
-		ret = region_chg(resv, idx, idx + 1);
+		ret = region_chg(resv, idx, idx + 1, &dummy_out_regions_needed);
+		/* We assume that vma_reservation_* routines always operate on
+		 * 1 page, and that adding to resv map a 1 page entry can only
+		 * ever require 1 region.
+		 */
+		VM_BUG_ON(dummy_out_regions_needed != 1);
 		break;
 	case VMA_COMMIT_RESV:
-		ret = region_add(resv, idx, idx + 1);
+		ret = region_add(resv, idx, idx + 1, 1);
+		/* region_add calls of range 1 should never fail. */
+		VM_BUG_ON(ret < 0);
 		break;
 	case VMA_END_RESV:
-		region_abort(resv, idx, idx + 1);
+		region_abort(resv, idx, idx + 1, 1);
 		ret = 0;
 		break;
 	case VMA_ADD_RESV:
-		if (vma->vm_flags & VM_MAYSHARE)
-			ret = region_add(resv, idx, idx + 1);
-		else {
-			region_abort(resv, idx, idx + 1);
+		if (vma->vm_flags & VM_MAYSHARE) {
+			ret = region_add(resv, idx, idx + 1, 1);
+			/* region_add calls of range 1 should never fail. */
+			VM_BUG_ON(ret < 0);
+		} else {
+			region_abort(resv, idx, idx + 1, 1);
 			ret = region_del(resv, idx, idx + 1);
 		}
 		break;
@@ -4578,12 +4682,12 @@ int hugetlb_reserve_pages(struct inode *inode,
 					struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
-	long ret, chg;
+	long ret, chg, add = -1;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg;
-	long gbl_reserve;
+	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
 	if (from > to) {
@@ -4613,7 +4717,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 		 */
 		resv_map = inode_resv_map(inode);

-		chg = region_chg(resv_map, from, to);
+		chg = region_chg(resv_map, from, to, &regions_needed);

 	} else {
 		/* Private mapping. */
@@ -4683,9 +4787,14 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		long add = region_add(resv_map, from, to);
-
-		if (unlikely(chg > add)) {
+		add = region_add(resv_map, from, to, regions_needed);
+
+		if (unlikely(add < 0)) {
+			hugetlb_acct_memory(h, -gbl_reserve);
+			/* put back original number of pages, chg */
+			(void)hugepage_subpool_put_pages(spool, chg);
+			goto out_err;
+		} else if (unlikely(chg > add)) {
 			/*
 			 * pages in this range were added to the reserve
 			 * map between region_chg and region_add.  This
@@ -4703,9 +4812,11 @@ int hugetlb_reserve_pages(struct inode *inode,
 	return 0;
 out_err:
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
-		/* Don't call region_abort if region_chg failed */
-		if (chg >= 0)
-			region_abort(resv_map, from, to);
+		/* Only call region_abort if the region_chg succeeded but the
+		 * region_add failed or didn't run.
+		 */
+		if (chg >= 0 && add < 0)
+			region_abort(resv_map, from, to, regions_needed);
 	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		kref_put(&resv_map->refs, resv_map_release);
 	return ret;
--
2.24.0.rc1.363.gb1bccd3e3d-goog
