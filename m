Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977EDB85D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2019 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436491AbfISWYl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 18:24:41 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54204 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436485AbfISWYl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 18:24:41 -0400
Received: by mail-pf1-f202.google.com with SMTP id x10so3208133pfr.20
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2019 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w3ACmte6egiwVJq7WooMwjbIUlbNLDJvrYl5eRXSizY=;
        b=nZolixhdr9hyc1loOvXdhxBfrOXn913PN8vBnJqRw6OYWph005EbFoHB78nRnKtfTm
         RDK37R3Int3zVkPMafjqcoYadPwtIMQjX5Ilv+ZRhsBqwSTPRyOnfJsXzb7XzE5hNf04
         /DrJvjqbHTUv3TnjTFzOOGBFtxKYk5n6TceqLd4YnKvbO1W2SrMqoOeuUHBmUg8tHIlB
         sVmaTYJ9maclBW3upoa8AxRVgNPAxZ0kDOJRttPg604XIEGsvE3drOx+XW5ivraqjfwG
         aWvNc2QNLEDNNEHS2Yk4aT3/gqFTStWwePazlROoy0kjA07voduthtaHIPc6YJMeLjdl
         WRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w3ACmte6egiwVJq7WooMwjbIUlbNLDJvrYl5eRXSizY=;
        b=c8cVDF7JDbgsTfVqXN8ipKzzKERNQ7/rmqLuY/OvgTxbxr2+RuSYVdkdMl0gvq77eA
         b/Wn925SEnsch2BTwPxQT0dHT8AYcRmItI4Ihz4pqdJ2/88kOaVGESJ8iGySiQs8g6Bs
         nbPlj4OURiI9qppV/3mNUJ0NeP+WIBfeZnqMV5Nd50Ooa0Uc1CD1O0LK35wegr16oFx5
         UAzI4pjhaxSddhHxuBghaLw/YwPQX9VUXIokemhOPC8ua0cBI/ATvLhFGSy7gsPIPHMV
         2BzXRDJ5rb66z3VcUOrwa4W71jCJ9XWwsxUeu2AytbA+wV3eppfdIZoxuA1f5E50syK5
         EKDw==
X-Gm-Message-State: APjAAAUJeZuSAcTWBrmjG/KektFWxBJlz0N+oWi6OqJz7hIIMPMFtY5u
        /7azkMHMrofFyuTuq0sYdsgUb9+4wGRmMi1QpA==
X-Google-Smtp-Source: APXvYqz7fzN1VgvahSFq2e7OQbc6dZrNEuqC3XfRTfoVaU0ks4qoKZurv0TF7fD6bM9BUj87uIWLAlvZEhGVOlNX5A==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr11848031pgv.168.1568931878664;
 Thu, 19 Sep 2019 15:24:38 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:24:19 -0700
In-Reply-To: <20190919222421.27408-1-almasrymina@google.com>
Message-Id: <20190919222421.27408-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v5 5/7] hugetlb_cgroup: add accounting for shared mappings
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
 mm/hugetlb.c | 126 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 105 insertions(+), 21 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d03b048084a3..ae573eff80bb 100644
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
@@ -250,12 +259,30 @@ struct file_region {
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
  * list.
  */
 static long add_reservation_in_range(struct resv_map *resv, long f, long t,
-				     bool count_only)
+				     struct hugetlb_cgroup *h_cg,
+				     struct hstate *h, bool count_only)
 {
 	long add = 0;
 	struct list_head *head = &resv->regions;
@@ -291,6 +318,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 			if (!count_only) {
 				nrg = get_file_region_entry_from_cache(
 					resv, last_accounted_offset, rg->from);
+				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
+								    h);
 				list_add(&nrg->link, rg->link.prev);
 			}
 		}
@@ -306,11 +335,13 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		if (!count_only) {
 			nrg = get_file_region_entry_from_cache(
 				resv, last_accounted_offset, t);
+			record_hugetlb_cgroup_uncharge_info(h_cg, nrg, h);
 			list_add(&nrg->link, rg->link.prev);
 		}
 		last_accounted_offset = t;
 	}

+	VM_BUG_ON(add < 0);
 	return add;
 }

@@ -327,7 +358,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
  * Return the number of new huge pages added to the map.  This
  * number is greater than or equal to zero.
  */
-static long region_add(struct resv_map *resv, long f, long t,
+static long region_add(struct hstate *h, struct hugetlb_cgroup *h_cg,
+		       struct resv_map *resv, long f, long t,
 		       long regions_needed)
 {
 	long add = 0;
@@ -336,7 +368,7 @@ static long region_add(struct resv_map *resv, long f, long t,

 	VM_BUG_ON(resv->region_cache_count < regions_needed);

-	add = add_reservation_in_range(resv, f, t, false);
+	add = add_reservation_in_range(resv, f, t, h_cg, h, false);
 	resv->adds_in_progress -= regions_needed;

 	spin_unlock(&resv->lock);
@@ -380,7 +412,7 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	spin_lock(&resv->lock);

 	/* Count how many hugepages in this range are NOT respresented. */
-	chg = add_reservation_in_range(resv, f, t, true);
+	chg = add_reservation_in_range(resv, f, t, NULL, NULL, true);

 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
@@ -430,6 +462,24 @@ static void region_abort(struct resv_map *resv, long f, long t,
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
@@ -499,6 +549,9 @@ static long region_del(struct resv_map *resv, long f, long t)
 			/* Original entry is trimmed */
 			rg->to = f;

+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  nrg->to - nrg->from);
+
 			list_add(&nrg->link, &rg->link);
 			nrg = NULL;
 			break;
@@ -506,6 +559,8 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  rg->to - rg->from);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -514,14 +569,20 @@ static long region_del(struct resv_map *resv, long f, long t)
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

@@ -1896,7 +1957,8 @@ __vma_reservation_common(struct hstate *h, struct vm_area_struct *vma,
 		break;
 	case VMA_COMMIT_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
-		ret = region_add(resv, idx, idx + 1, in_regions_needed);
+		ret = region_add(NULL, NULL, resv, idx, idx + 1,
+				 in_regions_needed);
 		break;
 	case VMA_END_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
@@ -1906,7 +1968,8 @@ __vma_reservation_common(struct hstate *h, struct vm_area_struct *vma,
 	case VMA_ADD_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
 		if (vma->vm_flags & VM_MAYSHARE)
-			ret = region_add(resv, idx, idx + 1, in_regions_needed);
+			ret = region_add(NULL, NULL, resv, idx, idx + 1,
+					 in_regions_needed);
 		else {
 			region_abort(resv, idx, idx + 1, in_regions_needed);
 			ret = region_del(resv, idx, idx + 1);
@@ -4538,7 +4601,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
-	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
@@ -4579,13 +4642,6 @@ int hugetlb_reserve_pages(struct inode *inode,

 		chg = to - from;

-		if (hugetlb_cgroup_charge_cgroup(hstate_index(h),
-						 chg * pages_per_huge_page(h),
-						 &h_cg, true)) {
-			kref_put(&resv_map->refs, resv_map_release);
-			return -ENOMEM;
-		}
-
 #ifdef CONFIG_CGROUP_HUGETLB
 		/*
 		 * Since this branch handles private mappings, we attach the
@@ -4605,6 +4661,14 @@ int hugetlb_reserve_pages(struct inode *inode,
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
 	/*
 	 * There must be enough pages in the subpool for the mapping. If
 	 * the subpool has a minimum size, there may be some global
@@ -4613,7 +4677,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
 	if (gbl_reserve < 0) {
 		ret = -ENOSPC;
-		goto out_err;
+		goto out_uncharge_cgroup;
 	}

 	/*
@@ -4622,9 +4686,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4639,7 +4701,8 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		long add = region_add(resv_map, from, to, regions_needed);
+		long add =
+			region_add(h, h_cg, resv_map, from, to, regions_needed);

 		if (unlikely(chg > add)) {
 			/*
@@ -4651,12 +4714,33 @@ int hugetlb_reserve_pages(struct inode *inode,
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
 		/* Don't call region_abort if region_chg failed */
--
2.23.0.351.gc4317032e6-goog
