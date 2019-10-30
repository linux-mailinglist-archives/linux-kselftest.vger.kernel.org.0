Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51620E94B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 02:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfJ3Bhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Oct 2019 21:37:39 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33222 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfJ3BhV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Oct 2019 21:37:21 -0400
Received: by mail-pg1-f202.google.com with SMTP id b71so436055pga.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2019 18:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ssFvuk0QwiNdDKtxF9cfWOelfIf78FQ2C/PtpI944yM=;
        b=mFc0gaPn4+VtUnI+sKXZq6Rbt7U7TlRL2Fbyt2WcirmO4EW/I6YAIxCL/OZ+VSeG/d
         7LjNVrFXvDK8NxErbG3ICDiOUxBi/h/ze5AzHpxGRmgxOYD1qQ/LbgawvyqZMFkP3Ic3
         gxHY0YsrRXpa3AuRelnMPVCCcTaXo3ymxJAvl1p128I0QIzdmirI+rvK1pTC6O+UiIgf
         LodM4HWFDrBkEzVme0QCQMfjQO3U4ZM51UevgkIJaYU6o/ewhnMAQcEhD+ER+mo70g+6
         /yCScps/qV5SprmOZagCz1ajlf14xvxQPoGjrPeSxG7w8jKf+73FxTuPS6tQz9MdyVwb
         +csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ssFvuk0QwiNdDKtxF9cfWOelfIf78FQ2C/PtpI944yM=;
        b=RirtKT22pff4rhUE6IeehAq2u+FWXK4cbVrE0zZNIXZXGkM7OQr3uK5TC9invZ1xuq
         k5IUj5tp6994LSb9VBxpWqvLYud4Wneuf9N78BY8OOmd7WCCBa8byT/9SqwiaBqnXmbW
         yK6jziiWkJx8nwQMxFlnJlMrgUTzPIQ+uppDj33NpXtIwz/S8njvb/56gzkhJiXzcYzV
         eT5bxKzD5waRBWGXib8z+DFXoqE4k3KVVZvhPna4rn+dsvgBU2nS4zzLd0MgnV+rF1PV
         /KK3rc0DKL7DBmCXG/MjJxAxgnZ76O7XRCdnjqZ+l7ugns868gfs6F49YASTKn9opdms
         iFBw==
X-Gm-Message-State: APjAAAWfHSCrFVvCiC6ECjtI6rb7/WF6ue3Jb/ABUbMqRso7xS8nDz1q
        BmcyBePdlGS3umoXw0gWfpI4I6rOHKoLQovZSg==
X-Google-Smtp-Source: APXvYqyfljDGlEbqdyichT3gDqFF/INDoWM+kXTzr44JK6GZRNZHGTLJJHtZJyFdtBpnf9GUBVFylkm4p989Wv+UKg==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr23888231pgk.341.1572399438731;
 Tue, 29 Oct 2019 18:37:18 -0700 (PDT)
Date:   Tue, 29 Oct 2019 18:36:58 -0700
In-Reply-To: <20191030013701.39647-1-almasrymina@google.com>
Message-Id: <20191030013701.39647-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v8 6/9] hugetlb_cgroup: add accounting for shared mappings
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
 mm/hugetlb.c | 149 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 117 insertions(+), 32 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1162eeaf8d160..40f4b85de59c4 100644
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
@@ -265,6 +274,23 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
 	return nrg;
 }

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
@@ -272,7 +298,9 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
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
@@ -311,6 +339,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 			if (!count_only) {
 				nrg = get_file_region_entry_from_cache(
 					resv, last_accounted_offset, rg->from);
+				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
+								    h);
 				list_add(&nrg->link, rg->link.prev);
 			} else if (regions_needed)
 				*regions_needed += 1;
@@ -327,12 +357,14 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
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

@@ -351,7 +383,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
  * region_add of regions of length 1 never allocate file_regions and cannot
  * fail.
  */
-static long region_add(struct resv_map *resv, long f, long t,
+static long region_add(struct hstate *h, struct hugetlb_cgroup *h_cg,
+		       struct resv_map *resv, long f, long t,
 		       long in_regions_needed)
 {
 	long add = 0, actual_regions_needed = 0, i = 0;
@@ -364,7 +397,8 @@ static long region_add(struct resv_map *resv, long f, long t,
 retry:

 	/* Count how many regions are actually needed to execute this add. */
-	add_reservation_in_range(resv, f, t, &actual_regions_needed, true);
+	add_reservation_in_range(resv, f, t, NULL, NULL, &actual_regions_needed,
+				 true);

 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
@@ -402,7 +436,7 @@ static long region_add(struct resv_map *resv, long f, long t,
 		goto retry;
 	}

-	add = add_reservation_in_range(resv, f, t, NULL, false);
+	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL, false);

 	resv->adds_in_progress -= in_regions_needed;

@@ -450,7 +484,8 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	spin_lock(&resv->lock);

 	/* Count how many hugepages in this range are NOT respresented. */
-	chg = add_reservation_in_range(resv, f, t, out_regions_needed, true);
+	chg = add_reservation_in_range(resv, f, t, NULL, NULL,
+				       out_regions_needed, true);

 	if (*out_regions_needed < 1)
 		*out_regions_needed = 1;
@@ -515,6 +550,24 @@ static void region_abort(struct resv_map *resv, long f, long t,
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
@@ -584,6 +637,9 @@ static long region_del(struct resv_map *resv, long f, long t)
 			/* Original entry is trimmed */
 			rg->to = f;

+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  nrg->to - nrg->from);
+
 			list_add(&nrg->link, &rg->link);
 			nrg = NULL;
 			break;
@@ -591,6 +647,8 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  rg->to - rg->from);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -599,14 +657,20 @@ static long region_del(struct resv_map *resv, long f, long t)
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

@@ -2015,7 +2079,7 @@ static long __vma_reservation_common(struct hstate *h,
 		VM_BUG_ON(dummy_out_regions_needed != 1);
 		break;
 	case VMA_COMMIT_RESV:
-		ret = region_add(resv, idx, idx + 1, 1);
+		ret = region_add(NULL, NULL, resv, idx, idx + 1, 1);
 		/* region_add calls of range 1 should never fail. */
 		VM_BUG_ON(ret < 0);
 		break;
@@ -2025,7 +2089,7 @@ static long __vma_reservation_common(struct hstate *h,
 		break;
 	case VMA_ADD_RESV:
 		if (vma->vm_flags & VM_MAYSHARE) {
-			ret = region_add(resv, idx, idx + 1, 1);
+			ret = region_add(NULL, NULL, resv, idx, idx + 1, 1);
 			/* region_add calls of range 1 should never fail. */
 			VM_BUG_ON(ret < 0);
 		} else {
@@ -4686,7 +4750,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
-	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
@@ -4727,23 +4791,6 @@ int hugetlb_reserve_pages(struct inode *inode,

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
@@ -4753,6 +4800,25 @@ int hugetlb_reserve_pages(struct inode *inode,
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
@@ -4761,7 +4827,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
 	if (gbl_reserve < 0) {
 		ret = -ENOSPC;
-		goto out_err;
+		goto out_uncharge_cgroup;
 	}

 	/*
@@ -4770,9 +4836,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4787,7 +4851,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		add = region_add(resv_map, from, to, regions_needed);
+		add = region_add(h, h_cg, resv_map, from, to, regions_needed);

 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
@@ -4804,12 +4868,33 @@ int hugetlb_reserve_pages(struct inode *inode,
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
2.24.0.rc1.363.gb1bccd3e3d-goog
