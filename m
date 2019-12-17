Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A7123AA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2019 00:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLQXQc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 18:16:32 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37415 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfLQXQc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 18:16:32 -0500
Received: by mail-pf1-f202.google.com with SMTP id 13so36323pfj.4
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2019 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m/0PEKDIs5EAE9V+LXDiU9+GrPzSxNsg2GcbnT02PzI=;
        b=AruRn4ej2VsNuz7auIffE04SPrO2HQA+bJ01iLESyeIWTl+UGSxDMV9UfRPIUXIwr2
         LXoggi1DeTrGzbfzXClfVcOVL/HEhvfAAl79gJq32ECO7ZMLgwIaqyAuuVInPo27HI2Y
         fgqUoegyWUgqKh3IIrb2X9/3AHMwpNHoB15FUnr4gIDk6+mFJkv3e1NAY7zwkHnWpkH+
         nK9B2nelvMk+JGQD5d7ZOnfweWvaYmjzAilOPsWpmzyCFyJ4NxWBIQhBYLCjWtrnwHHC
         dU3h53W3TbZnHPeZ6tXizhVul5oTwwshnZj7zcs18PfawGfH/0kEQedHwvJDTXgXodSd
         SShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m/0PEKDIs5EAE9V+LXDiU9+GrPzSxNsg2GcbnT02PzI=;
        b=UliDiFMRcVcw1Je3s7CGPcwC3lHmjLnO/7U1JCZHx+CN6KQDT9bH1piw6f6bPenaee
         0pKyMwa1mr9mKi9bA8wT0U1n644KE6+0sOHv3YeqQBVw0kol0D03jtnHcO5nkxLd+hZC
         c7nf/vsM8y/M6qg+gYXXenL95x/S+cwYJt1Lnd/1sW2D6cY4AZb1PxsQR8XCgL9wth2w
         HyXVVcol9hmu4o8LYbhcFS9hvxEclw1Q4BIoJ+VdJ/+53sxlQKUPUZ8E7gJJiWqHywL1
         l7NJ37TMWvcsjxFXJFPcwCZxlvVPnrUJ/f7w5WvlwEiQgH1r8XEIi2ixVkC2zckaV47F
         hPNA==
X-Gm-Message-State: APjAAAUK0NCuMXn9jYXwBENVNKGqbOXYZ8LLTA5bWuaKhhyj6WmPPoz4
        6lDOKqrcUvR/4A9Z7vUmOUZaH8d5OytGThT5Xw==
X-Google-Smtp-Source: APXvYqxWhvReT2kHTN7BRR1uEs7bCMIbW3AILDIIajF2PeJU8/Ww9+TRlWFpAbhP0tCmehYnjidsBMCI68zCxxrR2g==
X-Received: by 2002:a63:444c:: with SMTP id t12mr27326341pgk.433.1576624589150;
 Tue, 17 Dec 2019 15:16:29 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:16:12 -0800
In-Reply-To: <20191217231615.164161-1-almasrymina@google.com>
Message-Id: <20191217231615.164161-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v9 5/8] hugetlb_cgroup: add accounting for shared mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
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

Changes in V9:
- Updated for hugetlb reservation repareting.

---
 mm/hugetlb.c | 161 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 129 insertions(+), 32 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3f70742e3aee4..39eb2fa53a420 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -242,6 +242,16 @@ struct file_region {
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
+	struct cgroup_subsys_state *css;
+#endif
 };

 /* Helper that removes a struct file_region from the resv_map cache and returns
@@ -265,6 +275,25 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
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
@@ -272,7 +301,9 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
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
@@ -311,6 +342,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 			if (!count_only) {
 				nrg = get_file_region_entry_from_cache(
 					resv, last_accounted_offset, rg->from);
+				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
+								    h);
 				list_add(&nrg->link, rg->link.prev);
 			} else if (regions_needed)
 				*regions_needed += 1;
@@ -327,11 +360,13 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
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

@@ -352,7 +387,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
  * fail; region_chg will always allocate at least 1 entry and a region_add for
  * 1 page will only require at most 1 entry.
  */
-static long region_add(struct resv_map *resv, long f, long t,
+static long region_add(struct hstate *h, struct hugetlb_cgroup *h_cg,
+		       struct resv_map *resv, long f, long t,
 		       long in_regions_needed)
 {
 	long add = 0, actual_regions_needed = 0, i = 0;
@@ -365,7 +401,8 @@ static long region_add(struct resv_map *resv, long f, long t,
 retry:

 	/* Count how many regions are actually needed to execute this add. */
-	add_reservation_in_range(resv, f, t, &actual_regions_needed, true);
+	add_reservation_in_range(resv, f, t, NULL, NULL, &actual_regions_needed,
+				 true);

 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
@@ -403,7 +440,7 @@ static long region_add(struct resv_map *resv, long f, long t,
 		goto retry;
 	}

-	add = add_reservation_in_range(resv, f, t, NULL, false);
+	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL, false);

 	resv->adds_in_progress -= in_regions_needed;

@@ -451,7 +488,8 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	spin_lock(&resv->lock);

 	/* Count how many hugepages in this range are NOT respresented. */
-	chg = add_reservation_in_range(resv, f, t, out_regions_needed, true);
+	chg = add_reservation_in_range(resv, f, t, NULL, NULL,
+				       out_regions_needed, true);

 	if (*out_regions_needed == 0)
 		*out_regions_needed = 1;
@@ -523,6 +561,25 @@ static void region_abort(struct resv_map *resv, long f, long t,
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
+						nr_pages * rg->pages_per_hpage,
+						rg->css);
+	}
+#endif
+}
+
 /*
  * Delete the specified range [f, t) from the reserve map.  If the
  * t parameter is LONG_MAX, this indicates that ALL regions after f
@@ -587,11 +644,20 @@ static long region_del(struct resv_map *resv, long f, long t)
 			/* New entry for end of split region */
 			nrg->from = t;
 			nrg->to = rg->to;
+
+			nrg->reservation_counter = rg->reservation_counter;
+			nrg->pages_per_hpage = rg->pages_per_hpage;
+			nrg->css = rg->css;
+			css_get(rg->css);
+
 			INIT_LIST_HEAD(&nrg->link);

 			/* Original entry is trimmed */
 			rg->to = f;

+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  nrg->to - nrg->from);
+
 			list_add(&nrg->link, &rg->link);
 			nrg = NULL;
 			break;
@@ -599,6 +665,8 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  rg->to - rg->from);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -607,14 +675,20 @@ static long region_del(struct resv_map *resv, long f, long t)
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

@@ -1953,7 +2027,7 @@ static long __vma_reservation_common(struct hstate *h,
 		VM_BUG_ON(dummy_out_regions_needed != 1);
 		break;
 	case VMA_COMMIT_RESV:
-		ret = region_add(resv, idx, idx + 1, 1);
+		ret = region_add(NULL, NULL, resv, idx, idx + 1, 1);
 		/* region_add calls of range 1 should never fail. */
 		VM_BUG_ON(ret < 0);
 		break;
@@ -1963,7 +2037,7 @@ static long __vma_reservation_common(struct hstate *h,
 		break;
 	case VMA_ADD_RESV:
 		if (vma->vm_flags & VM_MAYSHARE) {
-			ret = region_add(resv, idx, idx + 1, 1);
+			ret = region_add(NULL, NULL, resv, idx, idx + 1, 1);
 			/* region_add calls of range 1 should never fail. */
 			VM_BUG_ON(ret < 0);
 		} else {
@@ -4639,7 +4713,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
-	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
@@ -4680,23 +4754,6 @@ int hugetlb_reserve_pages(struct inode *inode,

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
@@ -4706,6 +4763,26 @@ int hugetlb_reserve_pages(struct inode *inode,
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
+		resv_map->css = &h_cg->css;
+	}
+#endif
+
 	/*
 	 * There must be enough pages in the subpool for the mapping. If
 	 * the subpool has a minimum size, there may be some global
@@ -4714,7 +4791,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
 	if (gbl_reserve < 0) {
 		ret = -ENOSPC;
-		goto out_err;
+		goto out_uncharge_cgroup;
 	}

 	/*
@@ -4723,9 +4800,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4740,7 +4815,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		add = region_add(resv_map, from, to, regions_needed);
+		add = region_add(h, h_cg, resv_map, from, to, regions_needed);

 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
@@ -4757,12 +4832,34 @@ int hugetlb_reserve_pages(struct inode *inode,
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
+		resv_map->css = &h_cg->css;
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
2.24.1.735.g03f4e72817-goog
