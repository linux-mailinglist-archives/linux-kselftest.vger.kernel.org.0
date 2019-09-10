Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A21AF359
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2019 01:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfIJXcO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 19:32:14 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45412 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfIJXcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 19:32:10 -0400
Received: by mail-pl1-f201.google.com with SMTP id c14so10770679plo.12
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2019 16:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mOz86u3QJ+sPmIKgI57ByvOfjc1EZ3nQiIDshsmvLkw=;
        b=JhV4JwO1A5bIa0VgmyFn+MBseNlD4k7krI1e6X3wOOt1t8MKOLpwe/PxAnQBBfd2oL
         hYKDHrDe0PVO7dJFlioepndrdqSPZk1x6+FuTtpOVA1ETzY2Iav9b6zlFA7y9bEpccEZ
         2caqAD17Vj3OilaS/XEGBL9j0RzO7yIVkpenqzHWsC+wRKZO9QaX2Umq5Z5CZLSpxr6O
         N0pF6GUwm0vFVqgmJ1UnbDdyyk59QLqOV+We8CifdxT5FhjtFF8XKptivBZPaiXYusbz
         1+3U6asjJoK6P+1TNI9k4Bx3WPyFb80yloklQs5kP8NsGroTU5BzG0q4J5kW79/5YFZv
         i4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mOz86u3QJ+sPmIKgI57ByvOfjc1EZ3nQiIDshsmvLkw=;
        b=reOhtclU0XWSVR6D2WUZQ23+QQ/rLl4f1zESEbytjbk3oEYNyRq7aQIMiuoWJz+kol
         lbyGI4xevoaF6O9wZheR5Y95M5ElGJGCzIVejJkeYLXXflaTvYH5OvYlQEep3/O7Jmns
         b5EgA1Y5QrJxZELFwAU+NlzPtmuAKVysPDdAgGoOq0Ny0UcSbzXdQIFliKyzhsXnnlFz
         uV1zZQ67DcjvC9LQR+Yr3NUpMdbN0zxYhxyk9cDtI9IdBzvW9eqC2o9LKnvN38oRHmze
         g5S/MkaImivu48OydsTBGRMhZYD5lUoBWV7QU9Tzcb/SVqOdUln5+iwhqk495rwn/doA
         HqeA==
X-Gm-Message-State: APjAAAVfmddKQ9n4yioD9bPBSbuWbNQ5C2vElJorBfwBUGIiimli5aD7
        jnFDDjhCBb28JOZs1NrI04EgEQtTspY1vJW5XA==
X-Google-Smtp-Source: APXvYqzmoj4S3Dp1g5Vv7XvlgAqvNcF5D7Gc+g3ecwFB2Z0w+ryTTMEG5RPu03K836HGNqGQF6dZJsxSz7LN545bkg==
X-Received: by 2002:a63:f04:: with SMTP id e4mr29298540pgl.38.1568158329221;
 Tue, 10 Sep 2019 16:32:09 -0700 (PDT)
Date:   Tue, 10 Sep 2019 16:31:44 -0700
In-Reply-To: <20190910233146.206080-1-almasrymina@google.com>
Message-Id: <20190910233146.206080-8-almasrymina@google.com>
Mime-Version: 1.0
References: <20190910233146.206080-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v4 7/9] hugetlb_cgroup: add accounting for shared mappings
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
 mm/hugetlb.c | 147 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 115 insertions(+), 32 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5eca34d9b753d..711690b87dce5 100644
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
@@ -250,9 +259,29 @@ struct file_region {
 static struct file_region *get_file_region_entry_from_cache(
 		struct resv_map *resv, long from, long to);

-static long add_reservation_in_range(
-		struct resv_map *resv,
+/* Helper that records hugetlb_cgroup uncharge info. */
+static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
+		struct file_region *nrg, struct hstate *h)
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
+/* Must be called with resv->lock held. Calling this with dry_run == true will
+ * count the number of pages to be added but will not modify the linked list.
+ */
+static long add_reservation_in_range(struct resv_map *resv,
 		long f, long t,
+		struct hugetlb_cgroup *h_cg,
+		struct hstate *h,
 		long *regions_needed,
 		bool count_only)
 {
@@ -294,6 +323,8 @@ static long add_reservation_in_range(
 				nrg = get_file_region_entry_from_cache(resv,
 						last_accounted_offset,
 						rg->from);
+				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
+						h);
 				list_add(&nrg->link, rg->link.prev);
 			} else if (regions_needed)
 				*regions_needed += 1;
@@ -310,6 +341,7 @@ static long add_reservation_in_range(
 		if (!count_only) {
 			nrg = get_file_region_entry_from_cache(resv,
 					last_accounted_offset, t);
+			record_hugetlb_cgroup_uncharge_info(h_cg, nrg, h);
 			list_add(&nrg->link, rg->link.prev);
 		} else if (regions_needed)
 			*regions_needed += 1;
@@ -317,6 +349,7 @@ static long add_reservation_in_range(
 		last_accounted_offset = t;
 	}

+	VM_BUG_ON(add < 0);
 	return add;
 }

@@ -333,8 +366,8 @@ static long add_reservation_in_range(
  * Return the number of new huge pages added to the map.  This
  * number is greater than or equal to zero.
  */
-static long region_add(struct resv_map *resv, long f, long t,
-		long regions_needed)
+static long region_add(struct hstate *h, struct hugetlb_cgroup *h_cg,
+		struct resv_map *resv, long f, long t, long regions_needed)
 {
 	long add = 0;

@@ -342,7 +375,7 @@ static long region_add(struct resv_map *resv, long f, long t,

 	VM_BUG_ON(resv->region_cache_count < regions_needed);

-	add = add_reservation_in_range(resv, f, t, NULL, false);
+	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL, false);
 	resv->adds_in_progress -= regions_needed;

 	spin_unlock(&resv->lock);
@@ -380,7 +413,8 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	spin_lock(&resv->lock);

 	/* Count how many hugepages in this range are NOT respresented. */
-	chg = add_reservation_in_range(resv, f, t, &regions_needed, true);
+	chg = add_reservation_in_range(resv, f, t, NULL, NULL, &regions_needed,
+			true);


 	/*
@@ -433,6 +467,25 @@ static void region_abort(struct resv_map *resv, long f, long t,
 	spin_unlock(&resv->lock);
 }

+static void  uncharge_cgroup_if_shared_mapping(struct resv_map *resv,
+		struct file_region *rg,
+		unsigned long nr_pages)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * If resv->reservation_counter is NULL, then this is shared
+	 * reservation, and the reserved memory is tracked in the file_struct
+	 * entries inside of resv_map. So we need to uncharge the memory here.
+	 */
+	if (rg->reservation_counter && rg->pages_per_hpage && nr_pages > 0 &&
+			!resv->reservation_counter) {
+		hugetlb_cgroup_uncharge_counter(
+				rg->reservation_counter,
+				nr_pages * rg->pages_per_hpage);
+	}
+#endif
+}
+
 /*
  * Delete the specified range [f, t) from the reserve map.  If the
  * t parameter is LONG_MAX, this indicates that ALL regions after f
@@ -453,6 +506,8 @@ static long region_del(struct resv_map *resv, long f, long t)
 	struct file_region *rg, *trg;
 	struct file_region *nrg = NULL;
 	long del = 0;
+	struct page_counter *reservation_counter = NULL;
+	unsigned long pages_per_hpage = 0;

 retry:
 	spin_lock(&resv->lock);
@@ -502,6 +557,9 @@ static long region_del(struct resv_map *resv, long f, long t)
 			/* Original entry is trimmed */
 			rg->to = f;

+			uncharge_cgroup_if_shared_mapping(resv, rg,
+					nrg->to - nrg->from);
+
 			list_add(&nrg->link, &rg->link);
 			nrg = NULL;
 			break;
@@ -509,6 +567,8 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+			uncharge_cgroup_if_shared_mapping(resv, rg,
+					rg->to - rg->from);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -517,14 +577,20 @@ static long region_del(struct resv_map *resv, long f, long t)
 		if (f <= rg->from) {	/* Trim beginning of region */
 			del += t - rg->from;
 			rg->from = t;
+
+			uncharge_cgroup_if_shared_mapping(resv, rg,
+					t - rg->from);
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

@@ -1900,7 +1966,8 @@ static long __vma_reservation_common(struct hstate *h,
 		break;
 	case VMA_COMMIT_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
-		ret = region_add(resv, idx, idx + 1, in_regions_needed);
+		ret = region_add(NULL, NULL, resv, idx, idx + 1,
+				in_regions_needed);
 		break;
 	case VMA_END_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
@@ -1910,7 +1977,8 @@ static long __vma_reservation_common(struct hstate *h,
 	case VMA_ADD_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
 		if (vma->vm_flags & VM_MAYSHARE)
-			ret = region_add(resv, idx, idx + 1, in_regions_needed);
+			ret = region_add(NULL, NULL, resv, idx, idx + 1,
+					in_regions_needed);
 		else {
 			region_abort(resv, idx, idx + 1, in_regions_needed);
 			ret = region_del(resv, idx, idx + 1);
@@ -4547,7 +4615,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
-	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
@@ -4584,27 +4652,10 @@ int hugetlb_reserve_pages(struct inode *inode,
 		/* Private mapping. */
 		chg = to - from;

-		if (hugetlb_cgroup_charge_cgroup(
-					hstate_index(h),
-					chg * pages_per_huge_page(h),
-					&h_cg, true)) {
-			return -ENOMEM;
-		}
-
 		resv_map = resv_map_alloc();
 		if (!resv_map)
 			return -ENOMEM;

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
@@ -4614,6 +4665,16 @@ int hugetlb_reserve_pages(struct inode *inode,
 		goto out_err;
 	}

+	ret = hugetlb_cgroup_charge_cgroup(
+			hstate_index(h),
+			chg * pages_per_huge_page(h),
+			&h_cg, true);
+
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
 	/*
 	 * There must be enough pages in the subpool for the mapping. If
 	 * the subpool has a minimum size, there may be some global
@@ -4622,7 +4683,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
 	if (gbl_reserve < 0) {
 		ret = -ENOSPC;
-		goto out_err;
+		goto out_uncharge_cgroup;
 	}

 	/*
@@ -4631,9 +4692,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4648,7 +4707,8 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		long add = region_add(resv_map, from, to, regions_needed);
+		long add = region_add(h, h_cg, resv_map, from, to,
+				regions_needed);

 		if (unlikely(chg > add)) {
 			/*
@@ -4660,12 +4720,35 @@ int hugetlb_reserve_pages(struct inode *inode,
 			 */
 			long rsv_adjust;

+			hugetlb_cgroup_uncharge_cgroup(
+					hstate_index(h),
+					(chg - add) * pages_per_huge_page(h),
+					h_cg, true);
+
 			rsv_adjust = hugepage_subpool_put_pages(spool,
-								chg - add);
+					chg - add);
 			hugetlb_acct_memory(h, -rsv_adjust);
+
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
+	hugetlb_cgroup_uncharge_cgroup(hstate_index(h),
+			chg * pages_per_huge_page(h),
+			h_cg, true);
 out_err:
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Don't call region_abort if region_chg failed */
--
2.23.0.162.g0b9fbb3734-goog
