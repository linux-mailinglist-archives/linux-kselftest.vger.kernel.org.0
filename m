Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A39D538F
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2019 02:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfJMAbK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 20:31:10 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33063 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfJMAao (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 20:30:44 -0400
Received: by mail-pf1-f201.google.com with SMTP id z4so10660139pfn.0
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2019 17:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LHbD1B91xdGNIRrZOTEf3dBGFn0prBcVwxkD9ZnMONk=;
        b=uBRme8l1r2nKIYeN05YBhUI6knKKwaG9a+9GFNYD9eBMZ9Z2hATV2tGBfpiVsm1LJ3
         QIkGjc3b9Cv9hBbtZWEV6C7Yh31smOG4bJKjhPbMeK6XnTaasRrNGnMSqszavrb7tk1S
         3Ic5TzRyL77sg5IEcYoIoqdVH847XNty/j/SOmNQKSpWH7adbDiz9QyRnA+DzWcLXDb8
         ok90UFF/QT15fIm99rnTlp9DYcoT3ZPd6y+mQTRsyhCXKdIosvFGbRbtibxmxVH856fE
         blUoepV7M4ViY4+XDwA3UihybZRJEHT1stWQijQAqB7lUZLVCujwSkCBtXFw1dHJnDpQ
         9Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LHbD1B91xdGNIRrZOTEf3dBGFn0prBcVwxkD9ZnMONk=;
        b=VQeRNpHjaV3aErDj1q6RscKrsrrl+tM7GMiU8c4PdMWY5saImmT17Lrwb84XggSguA
         h6GuB1DFray8AhOw0fqL9Ga68Ufqs/R/nlDgPaYSZW6UK0fJq50tHv8uQwg8DZA8U2qG
         jgwx4VJ9nSgryEwCyyWSkODN7cGfLQZFymp7E0Ze0eD9/iKbH3aoBwkcDIUwtxLwL7Nj
         /nbW8KdJRdkPgpNsFIrubrrl+bcZDKKX7AaimWA+eJdIxjlrD3+yTRgY8QswoKAtw29z
         XisRmZqmPMFmSgy0qowihOFxDfYwV3qEQGe3Bei/Q2kAcRe6MokzaiSajO2+fuJIiBQ8
         vjRg==
X-Gm-Message-State: APjAAAUqnzcd701ilLly7aFdNtiuE4mK2MqdSo6QpZqPJaN/eThHz77P
        9c38ApU4u+dwvVDYhCc8z7VSfllP3Kbp08sbCQ==
X-Google-Smtp-Source: APXvYqxkNR0wQCE/4rnpDdVUsJzyn46jJAt1BU9w53Atd8G2RenjUc0Fwe/LgYPbRpKmD659JZXqZIfHKC+oUobNEg==
X-Received: by 2002:a65:6096:: with SMTP id t22mr24472289pgu.409.1570926641714;
 Sat, 12 Oct 2019 17:30:41 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:30:21 -0700
In-Reply-To: <20191013003024.215429-1-almasrymina@google.com>
Message-Id: <20191013003024.215429-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20191013003024.215429-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v6 6/9] hugetlb_cgroup: add accounting for shared mappings
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
 1 file changed, 116 insertions(+), 31 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f9c1947925bb9..af336bf227fb6 100644
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
@@ -398,7 +430,7 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	}

 	/* Count how many hugepages in this range are NOT respresented. */
-	chg = add_reservation_in_range(resv, f, t, true);
+	chg = add_reservation_in_range(resv, f, t, NULL, NULL, true);

 	spin_unlock(&resv->lock);
 	return chg;
@@ -425,6 +457,24 @@ static void region_abort(struct resv_map *resv, long f, long t,
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
@@ -494,6 +544,9 @@ static long region_del(struct resv_map *resv, long f, long t)
 			/* Original entry is trimmed */
 			rg->to = f;

+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  nrg->to - nrg->from);
+
 			list_add(&nrg->link, &rg->link);
 			nrg = NULL;
 			break;
@@ -501,6 +554,8 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+			uncharge_cgroup_if_shared_mapping(resv, rg,
+							  rg->to - rg->from);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -509,14 +564,20 @@ static long region_del(struct resv_map *resv, long f, long t)
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

@@ -1923,7 +1984,8 @@ __vma_reservation_common(struct hstate *h, struct vm_area_struct *vma,
 		break;
 	case VMA_COMMIT_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
-		ret = region_add(resv, idx, idx + 1, in_regions_needed);
+		ret = region_add(NULL, NULL, resv, idx, idx + 1,
+				 in_regions_needed);
 		break;
 	case VMA_END_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
@@ -1933,7 +1995,8 @@ __vma_reservation_common(struct hstate *h, struct vm_area_struct *vma,
 	case VMA_ADD_RESV:
 		VM_BUG_ON(in_regions_needed == -1);
 		if (vma->vm_flags & VM_MAYSHARE)
-			ret = region_add(resv, idx, idx + 1, in_regions_needed);
+			ret = region_add(NULL, NULL, resv, idx, idx + 1,
+					 in_regions_needed);
 		else {
 			region_abort(resv, idx, idx + 1, in_regions_needed);
 			ret = region_del(resv, idx, idx + 1);
@@ -4603,7 +4666,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
-	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;

 	/* This should never happen */
@@ -4644,23 +4707,6 @@ int hugetlb_reserve_pages(struct inode *inode,

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
@@ -4670,6 +4716,25 @@ int hugetlb_reserve_pages(struct inode *inode,
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
@@ -4678,7 +4743,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
 	if (gbl_reserve < 0) {
 		ret = -ENOSPC;
-		goto out_err;
+		goto out_uncharge_cgroup;
 	}

 	/*
@@ -4687,9 +4752,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4704,7 +4767,8 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * else has to be done for private mappings here
 	 */
 	if (!vma || vma->vm_flags & VM_MAYSHARE) {
-		long add = region_add(resv_map, from, to, regions_needed);
+		long add =
+			region_add(h, h_cg, resv_map, from, to, regions_needed);

 		if (unlikely(chg > add)) {
 			/*
@@ -4716,12 +4780,33 @@ int hugetlb_reserve_pages(struct inode *inode,
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
2.23.0.700.g56cf767bdb-goog
