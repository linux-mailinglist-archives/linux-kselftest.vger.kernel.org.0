Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8D786AB0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2019 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbfHHTlD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 15:41:03 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:34290 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390275AbfHHTlD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 15:41:03 -0400
Received: by mail-vs1-f74.google.com with SMTP id x22so24564080vsj.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2019 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=U1NAgq1ixDzFMwSloc1w79e7XXEz1ZUNwswDpRikI0U=;
        b=Qfk8nM64QuxMJYn2z2eAQfts80sKQuHv/5JJhlfd6480WBbm3I+mMxUttvsVcqxNIk
         38MJesd5l3M4T9wqI9EftDFs95ZnZIwoG8Bgxn/kUo/53l5j1nDy5upQASqSiq8D99AV
         kFzhhYm6q8lsZLCp7GgO3t8feB7QCmr1oJLI8W1PJzAI8zWkxH5JgBsfRv/NERq14vhh
         v6UqRjl/mFSHwouP540sxW50vC9a9XQI8LB2/Vp0ge10gtRJgTBlO4iF1B4CmL3EMWLO
         ieHi+Bo1wn4bDVyzaOgdcNAeWnx+x1JG01u1X9CG63Ubbpx0Q1ibjEARi5ZsouPFcRwN
         JLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=U1NAgq1ixDzFMwSloc1w79e7XXEz1ZUNwswDpRikI0U=;
        b=DsUlyzW63fMBW6RJcOLm/LJqhXqPX0GiUHyZ+b9OOtWDMB7VkQrxbRePCoOY09eoV2
         fHN0hqU3dUyI9VmdQqO8luNouFZ+B+lVi/jx9xdT9Ei2Kz+YAoGrCZn+sMidwOL+h+Tl
         D2FqihJYwqSFHtt5QM9/qSyeyKIA5uYZ8OzLJbcgyXoQjQcZ6rXdN08z51qEGLxlfLce
         HT3s8gz6nKua3Td6I31pLkq5mzI6rAwhC5jwysd+sn6VIoQNDbHqSoEc0Q9XaDtxij38
         YyWNlQ/GMp4mJ/ECEDgO8SFAFjVN4+V8cYjayWh9fi9pMDzBtoVpJbplJcaTUnf/VAjn
         LK9Q==
X-Gm-Message-State: APjAAAXwQDqZXSbEk4S506Ep17Gx4gOGSjSqy/LiLaGIAi37pSqo3XLN
        ZLa57bZaONy0x76W0v+mZCQKe907qJEYOi/2ww==
X-Google-Smtp-Source: APXvYqyhi5qBGagRnNny0O1slRm0+AtzDichZzBrhBHBYSpFDd9H0oEtM9Z3a/ZoEP1w4tMkYuCYpkr5Xvm8vthUBQ==
X-Received: by 2002:a1f:ac1:: with SMTP id 184mr6898719vkk.0.1565293260993;
 Thu, 08 Aug 2019 12:41:00 -0700 (PDT)
Date:   Thu,  8 Aug 2019 12:40:02 -0700
Message-Id: <20190808194002.226688-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [RFC PATCH] hugetlbfs: Add hugetlb_cgroup reservation limits
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Problem:
Currently tasks attempting to allocate more hugetlb memory than is available get
a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
However, if a task attempts to allocate hugetlb memory only more than its
hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
but will SIGBUS the task when it attempts to fault the memory in.

We have developers interested in using hugetlb_cgroups, and they have expressed
dissatisfaction regarding this behavior. We'd like to improve this
behavior such that tasks violating the hugetlb_cgroup limits get an error on
mmap/shmget time, rather than getting SIGBUS'd when they try to fault
the excess memory in.

The underlying problem is that today's hugetlb_cgroup accounting happens
at hugetlb memory *fault* time, rather than at *reservation* time.
Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
the offending task gets SIGBUS'd.

Proposed Solution:
A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes. This
counter has slightly different semantics than
hugetlb.xMB.[limit|usage]_in_bytes:

- While usage_in_bytes tracks all *faulted* hugetlb memory,
reservation_usage_in_bytes tracks all *reserved* hugetlb memory.

- If a task attempts to reserve more memory than limit_in_bytes allows,
the kernel will allow it to do so. But if a task attempts to reserve
more memory than reservation_limit_in_bytes, the kernel will fail this
reservation.

This proposal is implemented in this patch, with tests to verify
functionality and show the usage.

Alternatives considered:
1. A new cgroup, instead of only a new page_counter attached to
   the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
   duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
   hugetlb_cgroup seemed cleaner as well.

2. Instead of adding a new counter, we considered adding a sysctl that modifies
   the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
   reservation time rather than fault time. Adding a new page_counter seems
   better as userspace could, if it wants, choose to enforce different cgroups
   differently: one via limit_in_bytes, and another via
   reservation_limit_in_bytes. This could be very useful if you're
   transitioning how hugetlb memory is partitioned on your system one
   cgroup at a time, for example. Also, someone may find usage for both
   limit_in_bytes and reservation_limit_in_bytes concurrently, and this
   approach gives them the option to do so.

Caveats:
1. This support is implemented for cgroups-v1. I have not tried
   hugetlb_cgroups with cgroups v2, and AFAICT it's not supported yet.
   This is largely because we use cgroups-v1 for now. If required, I
   can add hugetlb_cgroup support to cgroups v2 in this patch or
   a follow up.
2. Most complicated bit of this patch I believe is: where to store the
   pointer to the hugetlb_cgroup to uncharge at unreservation time?
   Normally the cgroup pointers hang off the struct page. But, with
   hugetlb_cgroup reservations, one task can reserve a specific page and another
   task may fault it in (I believe), so storing the pointer in struct
   page is not appropriate. Proposed approach here is to store the pointer in
   the resv_map. See patch for details.

[1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/hugetlb.h                       |  10 +-
 include/linux/hugetlb_cgroup.h                |  19 +-
 mm/hugetlb.c                                  | 256 ++++++++--
 mm/hugetlb_cgroup.c                           | 153 +++++-
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   4 +
 .../selftests/vm/charge_reserved_hugetlb.sh   | 438 ++++++++++++++++++
 .../selftests/vm/write_hugetlb_memory.sh      |  22 +
 .../testing/selftests/vm/write_to_hugetlbfs.c | 252 ++++++++++
 9 files changed, 1087 insertions(+), 68 deletions(-)
 create mode 100755 tools/testing/selftests/vm/charge_reserved_hugetlb.sh
 create mode 100644 tools/testing/selftests/vm/write_hugetlb_memory.sh
 create mode 100644 tools/testing/selftests/vm/write_to_hugetlbfs.c

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index edfca42783192..90b3c928d16c1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -46,6 +46,14 @@ struct resv_map {
 	long adds_in_progress;
 	struct list_head region_cache;
 	long region_cache_count;
+ #ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * On private mappings, the counter to uncharge reservations is stored
+	 * here. If these fields are 0, then the mapping is shared.
+	 */
+	struct page_counter *reservation_counter;
+	unsigned long pages_per_hpage;
+#endif
 };
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
@@ -340,7 +348,7 @@ struct hstate {
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
-	struct cftype cgroup_files[5];
+	struct cftype cgroup_files[9];
 #endif
 	char name[HSTATE_NAME_LEN];
 };
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 063962f6dfc6a..1fdde63a4e775 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -25,6 +25,17 @@ struct hugetlb_cgroup;
 #define HUGETLB_CGROUP_MIN_ORDER	2

 #ifdef CONFIG_CGROUP_HUGETLB
+struct hugetlb_cgroup {
+	struct cgroup_subsys_state css;
+	/*
+	 * the counter to account for hugepages from hugetlb.
+	 */
+	struct page_counter hugepage[HUGE_MAX_HSTATE];
+	/*
+	 * the counter to account for hugepage reservations from hugetlb.
+	 */
+	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
+};

 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
 {
@@ -52,7 +63,8 @@ static inline bool hugetlb_cgroup_disabled(void)
 }

 extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-					struct hugetlb_cgroup **ptr);
+					struct hugetlb_cgroup **ptr,
+					bool reserved);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
 					 struct page *page);
@@ -60,6 +72,9 @@ extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 					 struct page *page);
 extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg);
+extern void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
+					    unsigned long nr_pages);
+
 extern void hugetlb_cgroup_file_init(void) __init;
 extern void hugetlb_cgroup_migrate(struct page *oldhpage,
 				   struct page *newhpage);
@@ -83,7 +98,7 @@ static inline bool hugetlb_cgroup_disabled(void)

 static inline int
 hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-			     struct hugetlb_cgroup **ptr)
+			     struct hugetlb_cgroup **ptr, bool reserved)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ede7e7f5d1ab2..d76e3137110ab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -242,8 +242,72 @@ struct file_region {
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

+/* Must be called with resv->lock held. Calling this with dry_run == true will
+ * count the number of pages added but will not modify the linked list.
+ */
+static long consume_regions_we_overlap_with(struct file_region *rg,
+		struct list_head *head, long f, long *t,
+		struct hugetlb_cgroup *h_cg,
+		struct hstate *h,
+		bool dry_run)
+{
+	long add = 0;
+	struct file_region *trg = NULL, *nrg = NULL;
+
+	/* Consume any regions we now overlap with. */
+	nrg = rg;
+	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
+		if (&rg->link == head)
+			break;
+		if (rg->from > *t)
+			break;
+
+		/* If this area reaches higher then extend our area to
+		 * include it completely.  If this is not the first area
+		 * which we intend to reuse, free it.
+		 */
+		if (rg->to > *t)
+			*t = rg->to;
+		if (rg != nrg) {
+			/* Decrement return value by the deleted range.
+			 * Another range will span this area so that by
+			 * end of routine add will be >= zero
+			 */
+			add -= (rg->to - rg->from);
+			if (!dry_run) {
+				list_del(&rg->link);
+				kfree(rg);
+			}
+		}
+	}
+
+	add += (nrg->from - f);		/* Added to beginning of region */
+	add += *t - nrg->to;		/* Added to end of region */
+
+	if (!dry_run) {
+		nrg->from = f;
+		nrg->to = *t;
+#ifdef CONFIG_CGROUP_HUGETLB
+		nrg->reservation_counter =
+			&h_cg->reserved_hugepage[hstate_index(h)];
+		nrg->pages_per_hpage = pages_per_huge_page(h);
+#endif
+	}
+
+	return add;
+}
+
 /*
  * Add the huge page range represented by [f, t) to the reserve
  * map.  In the normal case, existing regions will be expanded
@@ -258,11 +322,13 @@ struct file_region {
  * Return the number of new huge pages added to the map.  This
  * number is greater than or equal to zero.
  */
-static long region_add(struct resv_map *resv, long f, long t)
+static long region_add(struct hstate *h, struct resv_map *resv, long f, long t)
 {
 	struct list_head *head = &resv->regions;
-	struct file_region *rg, *nrg, *trg;
-	long add = 0;
+	struct file_region *rg, *nrg;
+	long add = 0, newadd = 0;
+	struct hugetlb_cgroup *h_cg = NULL;
+	int ret = 0;

 	spin_lock(&resv->lock);
 	/* Locate the region we are either in or before. */
@@ -277,6 +343,23 @@ static long region_add(struct resv_map *resv, long f, long t)
 	 * from the cache and use it for this range.
 	 */
 	if (&rg->link == head || t < rg->from) {
+#ifdef CONFIG_CGROUP_HUGETLB
+		/*
+		 * If res->reservation_counter is NULL, then it means this is
+		 * a shared mapping, and hugetlb cgroup accounting should be
+		 * done on the file_region entries inside resv_map.
+		 */
+		if (!resv->reservation_counter) {
+			ret = hugetlb_cgroup_charge_cgroup(
+					hstate_index(h),
+					(t - f) * pages_per_huge_page(h),
+					&h_cg, true);
+		}
+
+		if (ret)
+			goto out_locked;
+#endif
+
 		VM_BUG_ON(resv->region_cache_count <= 0);

 		resv->region_cache_count--;
@@ -286,6 +369,15 @@ static long region_add(struct resv_map *resv, long f, long t)

 		nrg->from = f;
 		nrg->to = t;
+
+#ifdef CONFIG_CGROUP_HUGETLB
+		if (h_cg) {
+			nrg->reservation_counter =
+				&h_cg->reserved_hugepage[hstate_index(h)];
+			nrg->pages_per_hpage = pages_per_huge_page(h);
+		}
+#endif
+
 		list_add(&nrg->link, rg->link.prev);

 		add += t - f;
@@ -296,38 +388,37 @@ static long region_add(struct resv_map *resv, long f, long t)
 	if (f > rg->from)
 		f = rg->from;

-	/* Check for and consume any regions we now overlap with. */
-	nrg = rg;
-	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
-		if (&rg->link == head)
-			break;
-		if (rg->from > t)
-			break;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/* Count any regions we now overlap with. */
+	add = consume_regions_we_overlap_with(rg, head, f, &t, NULL, NULL,
+			true);

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
-		}
+	if (!resv->reservation_counter) {
+		ret = hugetlb_cgroup_charge_cgroup(
+				hstate_index(h),
+				add * pages_per_huge_page(h),
+				&h_cg, true);
 	}

-	add += (nrg->from - f);		/* Added to beginning of region */
-	nrg->from = f;
-	add += t - nrg->to;		/* Added to end of region */
-	nrg->to = t;
+	if (ret)
+		goto out_locked;
+#endif
+
+	/* Check for and consume any regions we now overlap with. */
+	newadd = consume_regions_we_overlap_with(rg, head, f, &t, h_cg, h,
+			false);
+	/*
+	 * If these aren't equal, then there is a bug with
+	 * consume_regions_we_overlap_with, and we're charging the wrong amount
+	 * of memory.
+	 */
+	WARN_ON(add != newadd);

 out_locked:
 	resv->adds_in_progress--;
 	spin_unlock(&resv->lock);
+	if (ret)
+		return ret;
 	VM_BUG_ON(add < 0);
 	return add;
 }
@@ -487,6 +578,10 @@ static long region_del(struct resv_map *resv, long f, long t)
 	struct file_region *rg, *trg;
 	struct file_region *nrg = NULL;
 	long del = 0;
+#ifdef CONFIG_CGROUP_HUGETLB
+	struct page_counter *reservation_counter = NULL;
+	unsigned long pages_per_hpage = 0;
+#endif

 retry:
 	spin_lock(&resv->lock);
@@ -514,6 +609,14 @@ static long region_del(struct resv_map *resv, long f, long t)
 				nrg = list_first_entry(&resv->region_cache,
 							struct file_region,
 							link);
+#ifdef CONFIG_CGROUP_HUGETLB
+				/*
+				 * Save counter information from the deleted
+				 * node, in case we need to do an uncharge.
+				 */
+				reservation_counter = nrg->reservation_counter;
+				pages_per_hpage = nrg->pages_per_hpage;
+#endif
 				list_del(&nrg->link);
 				resv->region_cache_count--;
 			}
@@ -543,6 +646,14 @@ static long region_del(struct resv_map *resv, long f, long t)

 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
+#ifdef CONFIG_CGROUP_HUGETLB
+			/*
+			 * Save counter information from the deleted node,
+			 * in case we need to do an uncharge.
+			 */
+			reservation_counter = rg->reservation_counter;
+			pages_per_hpage = rg->pages_per_hpage;
+#endif
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -559,6 +670,19 @@ static long region_del(struct resv_map *resv, long f, long t)

 	spin_unlock(&resv->lock);
 	kfree(nrg);
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * If resv->reservation_counter is NULL, then this is shared
+	 * reservation, and the reserved memory is tracked in the file_struct
+	 * entries inside of resv_map. So we need to uncharge the memory here.
+	 */
+	if (reservation_counter && pages_per_hpage && del > 0 &&
+	    !resv->reservation_counter) {
+		hugetlb_cgroup_uncharge_counter(
+				reservation_counter,
+				del * pages_per_hpage);
+	}
+#endif
 	return del;
 }

@@ -711,6 +835,16 @@ struct resv_map *resv_map_alloc(void)
 	INIT_LIST_HEAD(&resv_map->regions);

 	resv_map->adds_in_progress = 0;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * Initialize these to 0. On shared mappings, 0's here indicate these
+	 * fields don't do cgroup accounting. On private mappings, these will be
+	 * re-initialized to the proper values, to indicate that hugetlb cgroup
+	 * reservations are to be un-charged from here.
+	 */
+	resv_map->reservation_counter = NULL;
+	resv_map->pages_per_hpage = 0;
+#endif

 	INIT_LIST_HEAD(&resv_map->region_cache);
 	list_add(&rg->link, &resv_map->region_cache);
@@ -1920,7 +2054,7 @@ static long __vma_reservation_common(struct hstate *h,
 		ret = region_chg(resv, idx, idx + 1);
 		break;
 	case VMA_COMMIT_RESV:
-		ret = region_add(resv, idx, idx + 1);
+		ret = region_add(h, resv, idx, idx + 1);
 		break;
 	case VMA_END_RESV:
 		region_abort(resv, idx, idx + 1);
@@ -1928,7 +2062,7 @@ static long __vma_reservation_common(struct hstate *h,
 		break;
 	case VMA_ADD_RESV:
 		if (vma->vm_flags & VM_MAYSHARE)
-			ret = region_add(resv, idx, idx + 1);
+			ret = region_add(h, resv, idx, idx + 1);
 		else {
 			region_abort(resv, idx, idx + 1);
 			ret = region_del(resv, idx, idx + 1);
@@ -2078,7 +2212,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

-	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
+	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
+					   false);
 	if (ret)
 		goto out_subpool_put;

@@ -3191,7 +3326,19 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)

 	reserve = (end - start) - region_count(resv, start, end);

-	kref_put(&resv->refs, resv_map_release);
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * Since we check for HPAGE_RESV_OWNER above, this must a private
+	 * mapping, and these values should be none-zero, and should point to
+	 * the hugetlb_cgroup counter to uncharge for this reservation.
+	 */
+	WARN_ON(!resv->reservation_counter);
+	WARN_ON(!resv->pages_per_hpage);
+
+	hugetlb_cgroup_uncharge_counter(
+			resv->reservation_counter,
+			(end - start) * resv->pages_per_hpage);
+#endif

 	if (reserve) {
 		/*
@@ -3201,6 +3348,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
+
+	kref_put(&resv->refs, resv_map_release);
 }

 static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -4511,10 +4660,11 @@ int hugetlb_reserve_pages(struct inode *inode,
 					struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
-	long ret, chg;
+	long ret, chg, add;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
+	struct hugetlb_cgroup *h_cg;
 	long gbl_reserve;

 	/* This should never happen */
@@ -4548,11 +4698,29 @@ int hugetlb_reserve_pages(struct inode *inode,
 		chg = region_chg(resv_map, from, to);

 	} else {
+		/* Private mapping. */
+		chg = to - from;
+
+		if (hugetlb_cgroup_charge_cgroup(
+					hstate_index(h),
+					chg * pages_per_huge_page(h),
+					&h_cg, true)) {
+			return -ENOMEM;
+		}
+
 		resv_map = resv_map_alloc();
 		if (!resv_map)
 			return -ENOMEM;

-		chg = to - from;
+#ifdef CONFIG_CGROUP_HUGETLB
+		/*
+		 * Since this branch handles private mappings, we attach the
+		 * counter to uncharge for this reservation off resv_map.
+		 */
+		resv_map->reservation_counter =
+			&h_cg->reserved_hugepage[hstate_index(h)];
+		resv_map->pages_per_hpage = pages_per_huge_page(h);
+#endif

 		set_vma_resv_map(vma, resv_map);
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
@@ -4580,9 +4748,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 */
 	ret = hugetlb_acct_memory(h, gbl_reserve);
 	if (ret < 0) {
-		/* put back original number of pages, chg */
-		(void)hugepage_subpool_put_pages(spool, chg);
-		goto out_err;
+		goto out_put_pages;
 	}

 	/*
@@ -4597,7 +4763,12 @@ int hugetlb_reserve_pages(struct inode *inode,
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
@@ -4615,10 +4786,15 @@ int hugetlb_reserve_pages(struct inode *inode,
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
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 68c2f2f3c05b7..06e99ae1fec81 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -19,20 +19,21 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>

-struct hugetlb_cgroup {
-	struct cgroup_subsys_state css;
-	/*
-	 * the counter to account for hugepages from hugetlb.
-	 */
-	struct page_counter hugepage[HUGE_MAX_HSTATE];
-};
-
 #define MEMFILE_PRIVATE(x, val)	(((x) << 16) | (val))
 #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)

 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;

+static inline
+struct page_counter *get_counter(struct hugetlb_cgroup *h_cg, int idx,
+				 bool reserved)
+{
+	if (reserved)
+		return  &h_cg->reserved_hugepage[idx];
+	return &h_cg->hugepage[idx];
+}
+
 static inline
 struct hugetlb_cgroup *hugetlb_cgroup_from_css(struct cgroup_subsys_state *s)
 {
@@ -61,8 +62,10 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
 	int idx;

 	for (idx = 0; idx < hugetlb_max_hstate; idx++) {
-		if (page_counter_read(&h_cg->hugepage[idx]))
+		if (page_counter_read(get_counter(h_cg, idx, true)) ||
+		    page_counter_read(get_counter(h_cg, idx, false))) {
 			return true;
+		}
 	}
 	return false;
 }
@@ -73,18 +76,27 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 	int idx;

 	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
-		struct page_counter *counter = &h_cgroup->hugepage[idx];
 		struct page_counter *parent = NULL;
+		struct page_counter *reserved_parent = NULL;
 		unsigned long limit;
 		int ret;

-		if (parent_h_cgroup)
-			parent = &parent_h_cgroup->hugepage[idx];
-		page_counter_init(counter, parent);
+		if (parent_h_cgroup) {
+			parent = get_counter(parent_h_cgroup, idx, false);
+			reserved_parent = get_counter(parent_h_cgroup, idx,
+						      true);
+		}
+		page_counter_init(get_counter(h_cgroup, idx, false), parent);
+		page_counter_init(get_counter(h_cgroup, idx, true),
+				  reserved_parent);

 		limit = round_down(PAGE_COUNTER_MAX,
 				   1 << huge_page_order(&hstates[idx]));
-		ret = page_counter_set_max(counter, limit);
+
+		ret = page_counter_set_max(get_counter(
+					h_cgroup, idx, false), limit);
+		ret = page_counter_set_max(get_counter(
+					h_cgroup, idx, true), limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -114,6 +126,25 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(h_cgroup);
 }

+static void hugetlb_cgroup_move_parent_reservation(int idx,
+						   struct hugetlb_cgroup *h_cg)
+{
+	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
+
+	/* Move the reservation counters. */
+	if (!parent_hugetlb_cgroup(h_cg)) {
+		parent = root_h_cgroup;
+		/* root has no limit */
+		page_counter_charge(
+				&root_h_cgroup->reserved_hugepage[idx],
+				page_counter_read(get_counter(h_cg, idx,
+							      true)));
+	}
+
+	/* Take the pages off the local counter */
+	page_counter_cancel(get_counter(h_cg, idx, true),
+			    page_counter_read(get_counter(h_cg, idx, true)));
+}

 /*
  * Should be called with hugetlb_lock held.
@@ -168,6 +199,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 	do {
 		for_each_hstate(h) {
 			spin_lock(&hugetlb_lock);
+			hugetlb_cgroup_move_parent_reservation(idx, h_cg);
 			list_for_each_entry(page, &h->hugepage_activelist, lru)
 				hugetlb_cgroup_move_parent(idx, h_cg, page);

@@ -179,7 +211,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 }

 int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-				 struct hugetlb_cgroup **ptr)
+				 struct hugetlb_cgroup **ptr, bool reserved)
 {
 	int ret = 0;
 	struct page_counter *counter;
@@ -202,8 +234,10 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 	}
 	rcu_read_unlock();

-	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages, &counter))
+	if (!page_counter_try_charge(get_counter(h_cg, idx, reserved),
+				     nr_pages, &counter)) {
 		ret = -ENOMEM;
+	}
 	css_put(&h_cg->css);
 done:
 	*ptr = h_cg;
@@ -237,7 +271,8 @@ void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 	if (unlikely(!h_cg))
 		return;
 	set_hugetlb_cgroup(page, NULL);
-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	page_counter_uncharge(get_counter(h_cg, idx, false), nr_pages);
+
 	return;
 }

@@ -250,34 +285,57 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
 		return;

-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	page_counter_uncharge(get_counter(h_cg, idx, false), nr_pages);
+}
+
+void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
+				     unsigned long nr_pages)
+{
+	if (hugetlb_cgroup_disabled() || !p)
+		return;
+
+	page_counter_uncharge(p, nr_pages);
 	return;
 }

 enum {
 	RES_USAGE,
+	RES_RESERVATION_USAGE,
 	RES_LIMIT,
+	RES_RESERVATION_LIMIT,
 	RES_MAX_USAGE,
+	RES_RESERVATION_MAX_USAGE,
 	RES_FAILCNT,
+	RES_RESERVATION_FAILCNT,
 };

 static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 				   struct cftype *cft)
 {
 	struct page_counter *counter;
+	struct page_counter *reserved_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);

 	counter = &h_cg->hugepage[MEMFILE_IDX(cft->private)];
+	reserved_counter = &h_cg->reserved_hugepage[MEMFILE_IDX(cft->private)];

 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_USAGE:
 		return (u64)page_counter_read(counter) * PAGE_SIZE;
+	case RES_RESERVATION_USAGE:
+		return (u64)page_counter_read(reserved_counter) * PAGE_SIZE;
 	case RES_LIMIT:
 		return (u64)counter->max * PAGE_SIZE;
+	case RES_RESERVATION_LIMIT:
+		return (u64)reserved_counter->max * PAGE_SIZE;
 	case RES_MAX_USAGE:
 		return (u64)counter->watermark * PAGE_SIZE;
+	case RES_RESERVATION_MAX_USAGE:
+		return (u64)reserved_counter->watermark * PAGE_SIZE;
 	case RES_FAILCNT:
 		return counter->failcnt;
+	case RES_RESERVATION_FAILCNT:
+		return reserved_counter->failcnt;
 	default:
 		BUG();
 	}
@@ -291,6 +349,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	int ret, idx;
 	unsigned long nr_pages;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
+	bool reserved = false;

 	if (hugetlb_cgroup_is_root(h_cg)) /* Can't set limit on root */
 		return -EINVAL;
@@ -303,10 +362,16 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	idx = MEMFILE_IDX(of_cft(of)->private);
 	nr_pages = round_down(nr_pages, 1 << huge_page_order(&hstates[idx]));

+	if (MEMFILE_ATTR(of_cft(of)->private) == RES_RESERVATION_LIMIT) {
+		reserved = true;
+	}
+
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
+	case RES_RESERVATION_LIMIT:
 	case RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
-		ret = page_counter_set_max(&h_cg->hugepage[idx], nr_pages);
+		ret = page_counter_set_max(get_counter(h_cg, idx, reserved),
+					   nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
 	default:
@@ -320,18 +385,26 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	int ret = 0;
-	struct page_counter *counter;
+	struct page_counter *counter, *reserved_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));

 	counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
+	reserved_counter = &h_cg->reserved_hugepage[
+		MEMFILE_IDX(of_cft(of)->private)];

 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_MAX_USAGE:
 		page_counter_reset_watermark(counter);
 		break;
+	case RES_RESERVATION_MAX_USAGE:
+		page_counter_reset_watermark(reserved_counter);
+		break;
 	case RES_FAILCNT:
 		counter->failcnt = 0;
 		break;
+	case RES_RESERVATION_FAILCNT:
+		reserved_counter->failcnt = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -357,7 +430,7 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	struct hstate *h = &hstates[idx];

 	/* format the size */
-	mem_fmt(buf, 32, huge_page_size(h));
+	mem_fmt(buf, sizeof(buf), huge_page_size(h));

 	/* Add the limit file */
 	cft = &h->cgroup_files[0];
@@ -366,28 +439,58 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	cft->read_u64 = hugetlb_cgroup_read_u64;
 	cft->write = hugetlb_cgroup_write;

-	/* Add the usage file */
+	/* Add the reservation limit file */
 	cft = &h->cgroup_files[1];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_limit_in_bytes",
+		 buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_LIMIT);
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+	cft->write = hugetlb_cgroup_write;
+
+	/* Add the usage file */
+	cft = &h->cgroup_files[2];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
 	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
 	cft->read_u64 = hugetlb_cgroup_read_u64;

+	/* Add the reservation usage file */
+	cft = &h->cgroup_files[3];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_usage_in_bytes",
+			buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_USAGE);
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
 	/* Add the MAX usage file */
-	cft = &h->cgroup_files[2];
+	cft = &h->cgroup_files[4];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
 	cft->private = MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

+	/* Add the MAX reservation usage file */
+	cft = &h->cgroup_files[5];
+	snprintf(cft->name, MAX_CFTYPE_NAME,
+			"%s.reservation_max_usage_in_bytes", buf);
+	cft->private = MEMFILE_PRIVATE(idx, RES_RESERVATION_MAX_USAGE);
+	cft->write = hugetlb_cgroup_reset;
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
 	/* Add the failcntfile */
-	cft = &h->cgroup_files[3];
+	cft = &h->cgroup_files[6];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
 	cft->private  = MEMFILE_PRIVATE(idx, RES_FAILCNT);
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;

+	/* Add the reservation failcntfile */
+	cft = &h->cgroup_files[7];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.reservation_failcnt", buf);
+	cft->private  = MEMFILE_PRIVATE(idx, RES_FAILCNT);
+	cft->write = hugetlb_cgroup_reset;
+	cft->read_u64 = hugetlb_cgroup_read_u64;
+
 	/* NULL terminate the last cft */
-	cft = &h->cgroup_files[4];
+	cft = &h->cgroup_files[8];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 31b3c98b6d34d..d3bed9407773c 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -14,3 +14,4 @@ virtual_address_range
 gup_benchmark
 va_128TBswitch
 map_fixed_noreplace
+write_to_hugetlbfs
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 9534dc2bc9295..8d37d5409b52c 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -18,6 +18,7 @@ TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
 TEST_GEN_FILES += va_128TBswitch
 TEST_GEN_FILES += virtual_address_range
+TEST_GEN_FILES += write_to_hugetlbfs

 TEST_PROGS := run_vmtests

@@ -29,3 +30,6 @@ include ../lib.mk
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread

 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
+
+# Why does adding $(OUTPUT)/ like above not apply this flag..?
+write_to_hugetlbfs: CFLAGS += -static
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
new file mode 100755
index 0000000000000..bf0b6dcec9977
--- /dev/null
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -0,0 +1,438 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+cgroup_path=/dev/cgroup/memory
+if [[ ! -e $cgroup_path ]]; then
+      mkdir -p $cgroup_path
+      mount -t cgroup -o hugetlb,memory cgroup $cgroup_path
+fi
+
+cleanup () {
+	echo $$ > $cgroup_path/tasks
+
+	set +e
+	if [[ "$(pgrep write_to_hugetlbfs)" != "" ]]; then
+	      kill -2 write_to_hugetlbfs
+	      # Wait for hugetlbfs memory to get depleted.
+	      sleep 0.5
+	fi
+	set -e
+
+	if [[ -e /mnt/huge ]]; then
+	      rm -rf /mnt/huge/*
+	      umount /mnt/huge || echo error
+	      rmdir /mnt/huge
+	fi
+	if [[ -e $cgroup_path/hugetlb_cgroup_test ]]; then
+	      rmdir $cgroup_path/hugetlb_cgroup_test
+	fi
+	if [[ -e $cgroup_path/hugetlb_cgroup_test1 ]]; then
+	      rmdir $cgroup_path/hugetlb_cgroup_test1
+	fi
+	if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
+	      rmdir $cgroup_path/hugetlb_cgroup_test2
+	fi
+	echo 0 > /proc/sys/vm/nr_hugepages
+	echo CLEANUP DONE
+}
+
+cleanup
+
+function expect_equal() {
+      local expected="$1"
+      local actual="$2"
+      local error="$3"
+
+      if [[ "$expected" != "$actual" ]]; then
+	    echo "expected ($expected) != actual ($actual): $3"
+	    cleanup
+	    exit 1
+      fi
+}
+
+function setup_cgroup() {
+      local name="$1"
+      local cgroup_limit="$2"
+      local reservation_limit="$3"
+
+      mkdir $cgroup_path/$name
+
+      echo writing cgroup limit: "$cgroup_limit"
+      echo "$cgroup_limit" > $cgroup_path/$name/hugetlb.2MB.limit_in_bytes
+
+      echo writing reseravation limit: "$reservation_limit"
+      echo "$reservation_limit" > \
+	    $cgroup_path/$name/hugetlb.2MB.reservation_limit_in_bytes
+}
+
+function write_hugetlbfs_and_get_usage() {
+      local cgroup="$1"
+      local size="$2"
+      local populate="$3"
+      local write="$4"
+      local path="$5"
+      local method="$6"
+      local private="$7"
+      local expect_failure="$8"
+
+      # Function return values.
+      reservation_failed=0
+      oom_killed=0
+      hugetlb_difference=0
+      reserved_difference=0
+
+      local hugetlb_usage=$cgroup_path/$cgroup/hugetlb.2MB.usage_in_bytes
+      local reserved_usage=$cgroup_path/$cgroup/hugetlb.2MB.reservation_usage_in_bytes
+
+      local hugetlb_before=$(cat $hugetlb_usage)
+      local reserved_before=$(cat $reserved_usage)
+
+      echo
+      echo Starting:
+      echo hugetlb_usage="$hugetlb_before"
+      echo reserved_usage="$reserved_before"
+      echo expect_failure is "$expect_failure"
+
+      set +e
+      if [[ "$method" == "1" ]] || [[ "$method" == 2 ]] || \
+	    [[ "$private" == "-r" ]] && [[ "$expect_failure" != 1 ]]; then
+	    bash write_hugetlb_memory.sh "$size" "$populate" "$write" \
+		  "$cgroup"  "$path" "$method" "$private" "-l" &
+
+	    local write_result=$?
+	    # This sleep is to make sure that the script above has had enough
+	    # time to do its thing, since it runs in the background. This may
+	    # cause races...
+	    sleep 0.5
+	    echo write_result is $write_result
+      else
+	    bash write_hugetlb_memory.sh "$size" "$populate" "$write" \
+		  "$cgroup"  "$path" "$method" "$private"
+	    local write_result=$?
+      fi
+      set -e
+
+      if [[ "$write_result" == 1 ]]; then
+	    reservation_failed=1
+      fi
+
+      # On linus/master, the above process gets SIGBUS'd on oomkill, with
+      # return code 135. On earlier kernels, it gets actual oomkill, with return
+      # code 137, so just check for both conditions incase we're testing against
+      # an earlier kernel.
+      if [[ "$write_result" == 135 ]] || [[ "$write_result" == 137 ]]; then
+	    oom_killed=1
+      fi
+
+      local hugetlb_after=$(cat $hugetlb_usage)
+      local reserved_after=$(cat $reserved_usage)
+
+      echo After write:
+      echo hugetlb_usage="$hugetlb_after"
+      echo reserved_usage="$reserved_after"
+
+      hugetlb_difference=$(($hugetlb_after - $hugetlb_before))
+      reserved_difference=$(($reserved_after - $reserved_before))
+}
+
+function cleanup_hugetlb_memory() {
+      set +e
+      if [[ "$(pgrep write_to_hugetlbfs)" != "" ]]; then
+	    echo kiling write_to_hugetlbfs
+	    killall -2 write_to_hugetlbfs
+	    # Wait for hugetlbfs memory to get depleted.
+	    sleep 0.5
+      fi
+      set -e
+
+      if [[ -e /mnt/huge ]]; then
+	    rm -rf /mnt/huge/*
+	      umount /mnt/huge
+	      rmdir /mnt/huge
+      fi
+}
+
+function run_test() {
+      local size="$1"
+      local populate="$2"
+      local write="$3"
+      local cgroup_limit="$4"
+      local reservation_limit="$5"
+      local nr_hugepages="$6"
+      local method="$7"
+      local private="$8"
+      local expect_failure="$9"
+
+      # Function return values.
+      hugetlb_difference=0
+      reserved_difference=0
+      reservation_failed=0
+      oom_killed=0
+
+      echo nr hugepages = "$nr_hugepages"
+      echo "$nr_hugepages" > /proc/sys/vm/nr_hugepages
+
+      setup_cgroup "hugetlb_cgroup_test" "$cgroup_limit" "$reservation_limit"
+
+      mkdir -p /mnt/huge
+      mount -t hugetlbfs \
+	    -o pagesize=2M,size=256M none /mnt/huge
+
+      write_hugetlbfs_and_get_usage "hugetlb_cgroup_test" "$size" "$populate" \
+	    "$write" "/mnt/huge/test" "$method" "$private" "$expect_failure"
+
+      cleanup_hugetlb_memory
+
+      local final_hugetlb=$(cat $cgroup_path/hugetlb_cgroup_test/hugetlb.2MB.usage_in_bytes)
+      local final_reservation=$(cat $cgroup_path/hugetlb_cgroup_test/hugetlb.2MB.reservation_usage_in_bytes)
+
+      expect_equal "0" "$final_hugetlb" "final hugetlb is not zero"
+      expect_equal "0" "$final_reservation" "final reservation is not zero"
+}
+
+function run_multiple_cgroup_test() {
+      local size1="$1"
+      local populate1="$2"
+      local write1="$3"
+      local cgroup_limit1="$4"
+      local reservation_limit1="$5"
+
+      local size2="$6"
+      local populate2="$7"
+      local write2="$8"
+      local cgroup_limit2="$9"
+      local reservation_limit2="${10}"
+
+      local nr_hugepages="${11}"
+      local method="${12}"
+      local private="${13}"
+      local expect_failure="${14}"
+
+      # Function return values.
+      hugetlb_difference1=0
+      reserved_difference1=0
+      reservation_failed1=0
+      oom_killed1=0
+
+      hugetlb_difference2=0
+      reserved_difference2=0
+      reservation_failed2=0
+      oom_killed2=0
+
+
+      echo nr hugepages = "$nr_hugepages"
+      echo "$nr_hugepages" > /proc/sys/vm/nr_hugepages
+
+      setup_cgroup "hugetlb_cgroup_test1" "$cgroup_limit1" "$reservation_limit1"
+      setup_cgroup "hugetlb_cgroup_test2" "$cgroup_limit2" "$reservation_limit2"
+
+      mkdir -p /mnt/huge
+      mount -t hugetlbfs \
+	    -o pagesize=2M,size=256M none /mnt/huge
+
+      write_hugetlbfs_and_get_usage "hugetlb_cgroup_test1" "$size1" \
+	    "$populate1" "$write1" "/mnt/huge/test1" "$method" "$private" \
+	    "$expect_failure"
+
+      hugetlb_difference1=$hugetlb_difference
+      reserved_difference1=$reserved_difference
+      reservation_failed1=$reservation_failed
+      oom_killed1=$oom_killed
+
+      local cgroup1_hugetlb_usage=$cgroup_path/hugetlb_cgroup_test1/hugetlb.2MB.usage_in_bytes
+      local cgroup1_reservation_usage=$cgroup_path/hugetlb_cgroup_test1/hugetlb.2MB.reservation_usage_in_bytes
+      local cgroup2_hugetlb_usage=$cgroup_path/hugetlb_cgroup_test2/hugetlb.2MB.usage_in_bytes
+      local cgroup2_reservation_usage=$cgroup_path/hugetlb_cgroup_test2/hugetlb.2MB.reservation_usage_in_bytes
+
+      local usage_before_second_write=$(cat $cgroup1_hugetlb_usage)
+      local reservation_usage_before_second_write=$(cat \
+	    $cgroup1_reservation_usage)
+
+      write_hugetlbfs_and_get_usage "hugetlb_cgroup_test2" "$size2" \
+	    "$populate2" "$write2" "/mnt/huge/test2" "$method" "$private" \
+	    "$expect_failure"
+
+      hugetlb_difference2=$hugetlb_difference
+      reserved_difference2=$reserved_difference
+      reservation_failed2=$reservation_failed
+      oom_killed2=$oom_killed
+
+      expect_equal "$usage_before_second_write" \
+	    "$(cat $cgroup1_hugetlb_usage)" "Usage changed."
+      expect_equal "$reservation_usage_before_second_write" \
+	    "$(cat $cgroup1_reservation_usage)" "Reservation usage changed."
+
+      cleanup_hugetlb_memory
+
+      local final_hugetlb=$(cat $cgroup1_hugetlb_usage)
+      local final_reservation=$(cat $cgroup1_reservation_usage)
+
+      expect_equal "0" "$final_hugetlb" \
+	    "hugetlbt_cgroup_test1 final hugetlb is not zero"
+      expect_equal "0" "$final_reservation" \
+	    "hugetlbt_cgroup_test1 final reservation is not zero"
+
+      local final_hugetlb=$(cat $cgroup2_hugetlb_usage)
+      local final_reservation=$(cat $cgroup2_reservation_usage)
+
+      expect_equal "0" "$final_hugetlb" \
+	    "hugetlb_cgroup_test2 final hugetlb is not zero"
+      expect_equal "0" "$final_reservation" \
+	    "hugetlb_cgroup_test2 final reservation is not zero"
+}
+
+for private in "" "-r" ; do
+for populate in  "" "-o"; do
+for method in 0 1 2; do
+
+# Skip mmap(MAP_HUGETLB | MAP_SHARED). Doesn't seem to be supported.
+if [[ "$method" == 1 ]] && [[ "$private" == "" ]]; then
+      continue
+fi
+
+# Skip populated shmem tests. Doesn't seem to be supported.
+if [[ "$method" == 2"" ]] && [[ "$populate" == "-o" ]]; then
+      continue
+fi
+
+cleanup
+echo
+echo
+echo
+echo Test normal case.
+echo private=$private, populate=$populate, method=$method
+run_test $((10 * 1024 * 1024)) "$populate" "" $((20 * 1024 * 1024)) \
+      $((20 * 1024 * 1024)) 10 "$method" "$private" "0"
+
+echo Memory charged to hugtlb=$hugetlb_difference
+echo Memory charged to reservation=$reserved_difference
+
+if [[ "$populate" == "-o" ]]; then
+      expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference" \
+	    "Reserved memory charged to hugetlb cgroup."
+else
+      expect_equal "0" "$hugetlb_difference" \
+	    "Reserved memory charged to hugetlb cgroup."
+fi
+
+expect_equal "$((10 * 1024 * 1024))" "$reserved_difference" \
+      "Reserved memory not charged to reservation usage."
+echo 'PASS'
+
+cleanup
+echo
+echo
+echo
+echo Test normal case with write.
+echo private=$private, populate=$populate, method=$method
+run_test $((10 * 1024 * 1024)) "$populate" '-w' $((20 * 1024 * 1024)) \
+      $((20 * 1024 * 1024)) 10 "$method" "$private" "0"
+
+echo Memory charged to hugtlb=$hugetlb_difference
+echo Memory charged to reservation=$reserved_difference
+
+expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference" \
+      "Reserved memory charged to hugetlb cgroup."
+expect_equal "$((10 * 1024 * 1024))" "$reserved_difference" \
+      "Reserved memory not charged to reservation usage."
+echo 'PASS'
+
+
+cleanup
+echo
+echo
+echo
+echo Test more than reservation case.
+echo private=$private, populate=$populate, method=$method
+run_test "$((10 * 1024 * 1024))" "$populate" '' "$((20 * 1024 * 1024))" \
+      "$((5 * 1024 * 1024))" "10" "$method" "$private" "1"
+
+expect_equal "1" "$reservation_failed" "Reservation succeeded."
+echo 'PASS'
+
+cleanup
+
+echo
+echo
+echo
+echo Test more than cgroup limit case.
+echo private=$private, populate=$populate, method=$method
+
+# Not sure if shm memory can be cleaned up when the process gets sigbus'd.
+if [[ "$method" != 2 ]]; then
+      run_test $((10 * 1024 * 1024)) "$populate" "-w" $((5 * 1024 * 1024)) \
+	    $((20 * 1024 * 1024)) 10 "$method" "$private" "1"
+
+      expect_equal "1" "$oom_killed" "Not oom killed."
+fi
+echo 'PASS'
+
+cleanup
+
+echo
+echo
+echo
+echo Test normal case, multiple cgroups.
+echo private=$private, populate=$populate, method=$method
+run_multiple_cgroup_test "$((6 * 1024 * 1024))" "$populate" "" \
+      "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "$((10 * 1024 * 1024))" \
+      "$populate" "" "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "10" \
+      "$method" "$private" "0"
+
+echo Memory charged to hugtlb1=$hugetlb_difference1
+echo Memory charged to reservation1=$reserved_difference1
+echo Memory charged to hugtlb2=$hugetlb_difference2
+echo Memory charged to reservation2=$reserved_difference2
+
+expect_equal "$((6 * 1024 * 1024))" "$reserved_difference1" \
+      "Incorrect reservations charged to cgroup 1."
+expect_equal "$((10 * 1024 * 1024))" "$reserved_difference2" \
+      "Incorrect reservation charged to cgroup 2."
+if [[ "$populate" == "-o" ]]; then
+      expect_equal "$((6 * 1024 * 1024))" "$hugetlb_difference1" \
+	    "Incorrect hugetlb charged to cgroup 1."
+      expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference2" \
+	    "Incorrect hugetlb charged to cgroup 2."
+else
+      expect_equal "0" "$hugetlb_difference1" \
+	    "Incorrect hugetlb charged to cgroup 1."
+      expect_equal "0" "$hugetlb_difference2" \
+	    "Incorrect hugetlb charged to cgroup 2."
+fi
+echo 'PASS'
+
+cleanup
+echo
+echo
+echo
+echo Test normal case with write, multiple cgroups.
+echo private=$private, populate=$populate, method=$method
+run_multiple_cgroup_test "$((6 * 1024 * 1024))" "$populate" "-w" \
+      "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "$((10 * 1024 * 1024))" \
+      "$populate" "-w" "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "10" \
+      "$method" "$private" "0"
+
+echo Memory charged to hugtlb1=$hugetlb_difference1
+echo Memory charged to reservation1=$reserved_difference1
+echo Memory charged to hugtlb2=$hugetlb_difference2
+echo Memory charged to reservation2=$reserved_difference2
+
+expect_equal "$((6 * 1024 * 1024))" "$hugetlb_difference1" \
+      "Incorrect hugetlb charged to cgroup 1."
+expect_equal "$((6 * 1024 * 1024))" "$reserved_difference1" \
+      "Incorrect reservation charged to cgroup 1."
+expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference2" \
+      "Incorrect hugetlb charged to cgroup 2."
+expect_equal "$((10 * 1024 * 1024))" "$reserved_difference2" \
+      "Incorrected reservation charged to cgroup 2."
+
+echo 'PASS'
+
+done # private
+done # populate
+done # method
+
+umount $cgroup_path
+rmdir $cgroup_path
diff --git a/tools/testing/selftests/vm/write_hugetlb_memory.sh b/tools/testing/selftests/vm/write_hugetlb_memory.sh
new file mode 100644
index 0000000000000..08f5fa5527cfd
--- /dev/null
+++ b/tools/testing/selftests/vm/write_hugetlb_memory.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+size=$1
+populate=$2
+write=$3
+cgroup=$4
+path=$5
+method=$6
+private=$7
+want_sleep=$8
+
+echo "Putting task in cgroup '$cgroup'"
+echo $$ > /dev/cgroup/memory/"$cgroup"/tasks
+
+echo "Method is $method"
+
+set +e
+./write_to_hugetlbfs -p "$path" -s "$size" "$write" "$populate" -m "$method" \
+      "$private" "$want_sleep"
diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/testing/selftests/vm/write_to_hugetlbfs.c
new file mode 100644
index 0000000000000..f02a897427a97
--- /dev/null
+++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This program reserves and uses hugetlb memory, supporting a bunch of
+ * scenorios needed by the charged_reserved_hugetlb.sh test.
+ */
+
+#include <err.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/shm.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+/* Global definitions. */
+enum method {
+	HUGETLBFS,
+	MMAP_MAP_HUGETLB,
+	SHM,
+	MAX_METHOD
+};
+
+
+/* Global variables. */
+static const char *self;
+static char *shmaddr;
+static int shmid;
+
+/*
+ * Show usage and exit.
+ */
+static void exit_usage(void)
+{
+
+	printf("Usage: %s -p <path to hugetlbfs file> -s <size to map> "
+		"[-m <0=hugetlbfs | 1=mmap(MAP_HUGETLB)>] [-l] [-r] "
+		"[-o] [-w]\n", self);
+	exit(EXIT_FAILURE);
+}
+
+void sig_handler(int signo)
+{
+	printf("Received %d.\n", signo);
+	if (signo == SIGINT) {
+		printf("Deleting the memory\n");
+		if (shmdt((const void *)shmaddr) != 0) {
+			perror("Detach failure");
+			shmctl(shmid, IPC_RMID, NULL);
+			exit(4);
+		}
+
+		shmctl(shmid, IPC_RMID, NULL);
+		printf("Done deleting the memory\n");
+	}
+	exit(2);
+}
+
+int main(int argc, char **argv)
+{
+	int fd = 0;
+	int key = 0;
+	int *ptr = NULL;
+	int c = 0;
+	int size = 0;
+	char path[256] = "";
+	enum method method = MAX_METHOD;
+	int want_sleep = 0, private = 0;
+	int populate = 0;
+	int write = 0;
+
+	unsigned long i;
+
+
+	if (signal(SIGINT, sig_handler) == SIG_ERR)
+		err(1, "\ncan't catch SIGINT\n");
+
+	/* Parse command-line arguments. */
+	setvbuf(stdout, NULL, _IONBF, 0);
+	self = argv[0];
+
+	while ((c = getopt(argc, argv, "s:p:m:owlr")) != -1) {
+		switch (c) {
+		case 's':
+			size = atoi(optarg);
+			break;
+		case 'p':
+			strncpy(path, optarg, sizeof(path));
+			break;
+		case 'm':
+			if (atoi(optarg) >= MAX_METHOD) {
+				errno = EINVAL;
+				perror("Invalid -m.");
+				exit_usage();
+			}
+			method = atoi(optarg);
+			break;
+		case 'o':
+			populate = 1;
+			break;
+		case 'w':
+			write = 1;
+			break;
+		case 'l':
+			want_sleep = 1;
+			break;
+		case 'r':
+			private = 1;
+			break;
+		default:
+			errno = EINVAL;
+			perror("Invalid arg");
+			exit_usage();
+		}
+	}
+
+	if (strncmp(path, "", sizeof(path)) != 0) {
+		printf("Writing to this path: %s\n", path);
+	} else {
+		errno = EINVAL;
+		perror("path not found");
+		exit_usage();
+	}
+
+	if (size != 0) {
+		printf("Writing this size: %d\n", size);
+	} else {
+		errno = EINVAL;
+		perror("size not found");
+		exit_usage();
+	}
+
+	if (!populate)
+		printf("Not populating.\n");
+	else
+		printf("Populating.\n");
+
+	if (!write)
+		printf("Not writing to memory.\n");
+
+	if (method == MAX_METHOD) {
+		errno = EINVAL;
+		perror("-m Invalid");
+		exit_usage();
+	} else
+		printf("Using method=%d\n", method);
+
+	if (!private)
+		printf("Shared mapping.\n");
+	else
+		printf("Private mapping.\n");
+
+
+	switch (method) {
+	case HUGETLBFS:
+		printf("Allocating using HUGETLBFS.\n");
+		fd = open(path, O_CREAT | O_RDWR, 0777);
+		if (fd == -1)
+			err(1, "Failed to open file.");
+
+		ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			(private ? MAP_PRIVATE : MAP_SHARED) | (populate ?
+				MAP_POPULATE : 0), fd, 0);
+
+		if (ptr == MAP_FAILED) {
+			close(fd);
+			err(1, "Error mapping the file");
+		}
+		break;
+	case MMAP_MAP_HUGETLB:
+		printf("Allocating using MAP_HUGETLB.\n");
+		ptr = mmap(NULL, size,
+		PROT_READ | PROT_WRITE,
+		(private ? (MAP_PRIVATE | MAP_ANONYMOUS) : MAP_SHARED) |
+		MAP_HUGETLB | (populate ?
+			MAP_POPULATE : 0),
+		-1, 0);
+
+		if (ptr == MAP_FAILED)
+			err(1, "mmap");
+
+		printf("Returned address is %p\n", ptr);
+		break;
+	case SHM:
+		printf("Allocating using SHM.\n");
+		shmid = shmget(key, size, SHM_HUGETLB | IPC_CREAT | SHM_R |
+				SHM_W);
+		if (shmid < 0) {
+			shmid = shmget(++key, size, SHM_HUGETLB | IPC_CREAT |
+					SHM_R | SHM_W);
+			if (shmid < 0)
+				err(1, "shmget");
+
+		}
+		printf("shmid: 0x%x, shmget key:%d\n", shmid, key);
+
+		shmaddr = shmat(shmid, NULL, 0);
+		if (shmaddr == (char *)-1) {
+			perror("Shared memory attach failure");
+			shmctl(shmid, IPC_RMID, NULL);
+			exit(2);
+		}
+		printf("shmaddr: %p\n", shmaddr);
+
+		break;
+	default:
+		errno = EINVAL;
+		err(1, "Invalid method.");
+	}
+
+	if (write) {
+		printf("Writing to memory.\n");
+		if (method != SHM) {
+			memset(ptr, 1, size);
+		} else {
+			printf("Starting the writes:\n");
+			for (i = 0; i < size; i++) {
+				shmaddr[i] = (char)(i);
+				if (!(i % (1024 * 1024)))
+					printf(".");
+			}
+			printf("\n");
+
+			printf("Starting the Check...");
+			for (i = 0; i < size; i++)
+				if (shmaddr[i] != (char)i) {
+					printf("\nIndex %lu mismatched\n", i);
+					exit(3);
+				}
+			printf("Done.\n");
+
+
+		}
+	}
+
+	if (want_sleep) {
+		/* Signal to caller that we're done. */
+		printf("DONE\n");
+
+		/* Hold memory until external kill signal is delivered. */
+		while (1)
+			sleep(100);
+	}
+
+	close(fd);
+
+	return 0;
+}
--
2.23.0.rc1.153.gdeed80330f-goog
