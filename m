Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B3E3D45
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfJXU3X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 16:29:23 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39797 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfJXU3X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 16:29:23 -0400
Received: by mail-pg1-f202.google.com with SMTP id m20so18696063pgv.6
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2019 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2rdK3DiBa7mDVnyA2/ffO0qdL+FsPrLOQTLjTTST7yE=;
        b=VW0wa55Ma0WKWKRm+4FxUqf4CbD997BjRDODtjb5OPNTNcMKI198GEkYops23xr0z9
         XrMziEQX6M3Xta9+d6pcnWeHTsRErY3quFNSf9s6NLFLqscio3T1zxJhI5ZhjJBlLmUQ
         ZaBGx+2VOuc3/nYraVo/d4kfr58bP0TdqwG0UJZV+E0KlefQx66Y/ZRtqggNNg6EFvfI
         zYIsB+hQ7/eKSCesnlgbw931lLTD2nxBi+OE5H1RBNwx7ZZDJGaudyAvgnCeW14PS+yF
         6Qu33OkY+9OGwzbeXFA9zWHj9m50XjOjWlUxFDbBAAguqLSD8r6ODtQSdK6aINJ10TfP
         CBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2rdK3DiBa7mDVnyA2/ffO0qdL+FsPrLOQTLjTTST7yE=;
        b=bhZBiaQ5RrskH4e8pkx5O3VujTMP44/sioaQIhZPRR27ejl78jHV7xeGiMhvpHhMb5
         XzCa2o6T+PMynZvRqrsPwQ+0xTKmRZlCzWlxemGTT8sDBvr+7KpoBA++92JQFXSdAcyA
         UfsGjxul/OzyYvJngiVHhhndqwC/yhbCe3iy/EF1PDBgKf6mtjIq+d14UOynV6skrtHY
         hvcFcuBOx9ggngYE3CHdFozb30h+PWnG14mpwtqerzVl6L+7Ol2+ka0Ahj/whfRq6wKY
         fq8uR7s9aDrfRt08OxUTWBRn5zEBvyaB+0CLlU58AkhbB/t3p7FPrHkUXznZrN4FJyGf
         NQ/A==
X-Gm-Message-State: APjAAAVsKgu/jRBEGj66Dt2YfOSrPy6jAFKbe5e91Hsvs+7A8k8RKQN6
        0B6FSCvrhjS7NJtekJgTwYzuznpRDGy6sA+9EA==
X-Google-Smtp-Source: APXvYqzMoLvyNUBTHZXQsC0HclTrjyqv3JxXiVw3wM4IxjpWXCq+/N6ztxMI7ttqbwgDJWTWHVKf+yqUlHLWpA1WOQ==
X-Received: by 2002:a63:165b:: with SMTP id 27mr18570722pgw.420.1571948961467;
 Thu, 24 Oct 2019 13:29:21 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:28:55 -0700
In-Reply-To: <20191024202858.95342-1-almasrymina@google.com>
Message-Id: <20191024202858.95342-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20191024202858.95342-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v7 6/9] hugetlb_cgroup: add accounting for shared mappings
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
 mm/hugetlb.c | 151 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 119 insertions(+), 32 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3d98e1b771390..cef15e68626bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -242,6 +242,15 @@ struct file_region {
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

 /* Helper that removes a struct file_region from the resv_map cache and returns
@@ -250,6 +259,23 @@ struct file_region {
 static struct file_region *
 get_file_region_entry_from_cache(struct resv_map *resv, long from, long to);

+/* Helper that records hugetlb_cgroup uncharge info. */
+static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
+						struct file_region *nrg,
+						struct hstate *h)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	if (h_cg) {
+		nrg->reservation_counter =
+			&h_cg->reserved_hugepage[hstate_index(h)];
+		nrg->pages_per_hpage = pages_per_huge_page(h);
+	} else {
+		nrg->reservation_counter = NULL;
+		nrg->pages_per_hpage = 0;
+	}
+#endif
+}
+
 /* Must be called with resv->lock held. Calling this with count_only == true
  * will count the number of pages to be added but will not modify the linked
  * list. If regions_needed != NULL and count_only == true, then regions_needed
@@ -257,7 +283,9 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to);
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
@@ -296,6 +324,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 			if (!count_only) {
 				nrg = get_file_region_entry_from_cache(
 					resv, last_accounted_offset, rg->from);
+				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
+								    h);
 				list_add(&nrg->link, rg->link.prev);
 			} else if (regions_needed)
 				*regions_needed += 1;
@@ -312,12 +342,14 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		if (!count_only) {
 			nrg = get_file_region_entry_from_cache(
 				resv, last_accounted_offset, t);
+			record_hugetlb_cgroup_uncharge_info(h_cg, nrg, h);
 			list_add(&nrg->link, rg->link.prev);
 		} else if (regions_needed)
 			*regions_needed += 1;
 		last_accounted_offset = t;
 	}

+	VM_BUG_ON(add < 0);
 	return add;
 }

@@ -336,7 +368,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
  * region_add of regions of length 1 never allocate file_regions and cannot
  * fail.
  */
-static long region_add(struct resv_map *resv, long f, long t,
+static long region_add(struct hstate *h, struct hugetlb_cgroup *h_cg,
+		       struct resv_map *resv, long f, long t,
 		       long in_regions_needed)
 {
 	long add = 0, actual_regions_needed = 0;
@@ -346,7 +379,8 @@ static long region_add(struct resv_map *resv, long f, long t,
 retry:

 	/* Count how many regions are actually needed to execute this add. */
-	add_reservation_in_range(resv, f, t, &actual_regions_needed, true);
+	add_reservation_in_range(resv, f, t, NULL, NULL, &actual_regions_needed,
+				 true);

 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
@@ -372,7 +406,7 @@ static long region_add(struct resv_map *resv, long f, long t,
 		goto retry;
 	}

-	add = add_reservation_in_range(resv, f, t, NULL, false);
+	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL, false);

 	resv->adds_in_progress -= in_regions_needed;

@@ -410,7 +444,8 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	spin_lock(&resv->lock);

 	/* Count how many hugepages in this range are NOT respresented. */
-	chg = add_reservation_in_range(resv, f, t, out_regions_needed, true);
+	chg = add_reservation_in_range(resv, f, t, NULL, NULL,
+				       out_regions_needed, true);

 	if (*out_regions_needed < 1)
 		*out_regions_needed = 1;
@@ -459,6 +494,24 @@ static void region_abort(struct resv_map *resv, long f, long t,
 	spin_unlock(&resv->lock);
 }

+static void uncharge_cgroup_if_shared_mapping(struct resv_map *resv,
+					      struct file_region *rg,
+					      unsigned long nr_pages)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * If resv->reservation_counter is NULL, then this is shared
+	 * reservation, and the reserved memory is tracked in the file_struct
+	 * entries inside of resv_map. So we need to uncharge the memory here.
+	 */
+	if (rg->reservation_counter && rg->pages_per_hpage && nr_pages > 0 &&
+	    !resv->reservation_counter) {
+		hugetlb_cgroup_uncharge_counter(rg->reservation_counter,
+						nr_pages * rg->pages_per_hpage);
+	}
+#endif
+}
+
 /*
  * Delete the specified range [f, t) from the reserve map.  If the
  * t parameter is LONG_MAX, this indicates that ALL regions after f
@@ -528,6 +581,9 @@ static long region_del(struct resv_map *resv, long f, long t)
 			/* Original entry is trimmed */
 			rg->to = f;

+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  nrg->to - nrg->from);
+
 			list_add(&nrg->link, &rg->link);
 			nrg = NULL;
 			break;
@@ -535,6 +591,8 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  rg->to - rg->from);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -543,14 +601,20 @@ static long region_del(struct resv_map *resv, long f, long t)
 		if (f <= rg->from) {	/* Trim beginning of region */
 			del += t - rg->from;
 			rg->from = t;
+
+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  t - rg->from);
 		} else {		/* Trim end of region */
 			del += rg->to - f;
 			rg->to = f;
+
+			uncharge_cgroup_if_shared_mapping(resv, rg, rg->to - f);
 		}
 	}

 	spin_unlock(&resv->lock);
 	kfree(nrg);
+
 	return del;
 }

@@ -1956,7 +2020,8 @@ __vma_reservation_common(struct hstate *h, struct vm_area_struct *vma,
 		break;
 	case VMA_COMMIT_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
-		ret = region_add(resv, idx, idx + 1, in_regions_needed);
+		ret = region_add(NULL, NULL, resv, idx, idx + 1,
+				 in_regions_needed);
 		/* region_add calls of range 1 should never fail. */
 		VM_BUG_ON(ret < 0);
 		break;
@@ -1968,7 +2033,8 @@ __vma_reservation_common(struct hstate *h, struct vm_area_struct *vma,
 	case VMA_ADD_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
 		if (vma->vm_flags & VM_MAYSHARE) {
-			ret = region_add(resv, idx, idx + 1, in_regions_needed);
+			ret = region_add(NULL, NULL, resv, idx, idx + 1,
+					 in_regions_needed);
 			/* region_add calls of range 1 should never fail. */
 			VM_BUG_ON(ret < 0);
 		} else {
@@ -4640,7 +4706,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
-	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
@@ -4681,23 +4747,6 @@ int hugetlb_reserve_pages(struct inode *inode,

 		chg = to - from;

-		if (hugetlb_cgroup_charge_cgroup(hstate_index(h),
-						 chg * pages_per_huge_page(h),
-						 &h_cg, true)) {
-			kref_put(&resv_map->refs, resv_map_release);
-			return -ENOMEM;
-		}
-
-#ifdef CONFIG_CGROUP_HUGETLB
-		/*
-		 * Since this branch handles private mappings, we attach the
-		 * counter to uncharge for this reservation off resv_map.
-		 */
-		resv_map->reservation_counter =
-			&h_cg->reserved_hugepage[hstate_index(h)];
-		resv_map->pages_per_hpage = pages_per_huge_page(h);
-#endif
-
 		set_vma_resv_map(vma, resv_map);
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
@@ -4707,6 +4756,25 @@ int hugetlb_reserve_pages(struct inode *inode,
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
+#ifdef CONFIG_CGROUP_HUGETLB
+	if (vma && !(vma->vm_flags & VM_MAYSHARE)) {
+		/* For private mappings, the hugetlb_cgroup uncharge info hangs
+		 * of the resv_map.
+		 */
+		resv_map->reservation_counter =
+			&h_cg->reserved_hugepage[hstate_index(h)];
+		resv_map->pages_per_hpage = pages_per_huge_page(h);
+	}
+#endif
+
 	/*
 	 * There must be enough pages in the subpool for the mapping. If
 	 * the subpool has a minimum size, there may be some global
@@ -4715,7 +4783,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
 	if (gbl_reserve < 0) {
 		ret = -ENOSPC;
-		goto out_err;
+		goto out_uncharge_cgroup;
 	}

 	/*
@@ -4724,9 +4792,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4741,7 +4807,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		add = region_add(resv_map, from, to, regions_needed);
+		add = region_add(h, h_cg, resv_map, from, to, regions_needed);

 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
@@ -4758,12 +4824,33 @@ int hugetlb_reserve_pages(struct inode *inode,
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
+	} else {
+#ifdef CONFIG_CGROUP_HUGETLB
+		/*
+		 * Since this branch handles private mappings, we attach the
+		 * counter to uncharge for this reservation off resv_map.
+		 */
+		resv_map->reservation_counter =
+			&h_cg->reserved_hugepage[hstate_index(h)];
+		resv_map->pages_per_hpage = pages_per_huge_page(h);
+#endif
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
--
2.24.0.rc0.303.g954a862665-goog
