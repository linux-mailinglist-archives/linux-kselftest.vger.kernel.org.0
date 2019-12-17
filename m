Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51670123AAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2019 00:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLQXQx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 18:16:53 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:39787 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfLQXQZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 18:16:25 -0500
Received: by mail-qv1-f73.google.com with SMTP id e14so212486qvr.6
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2019 15:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ef61v4ufR71o7uKhOFEtM/Aty/YCrnVSUfAAbbh7U/s=;
        b=dOg5r7sETbBnSk3Bd0wRVsX3h+q2fdczjKNl0yRAIeLWymUf05hqMG9pQNAzBLuLta
         fD9IBoQkPXnt+mCNDjhffEq1onYV7Q1vq1MB9t+GYG1ecy5Zgnnu1VxliX/GYSYMVVnR
         68QUP+8K4YSBZOthOO7QXZPU8duwhZFUl7gB8aPnLoE+kVrvzjZHdgMarzmF0zLgXQRE
         UPsqLzSSXy2UwGXcGH2RY++6rt9L4SKdmxE1+0Je81ztgFtGLp2mlIBSf8zfaDXwevbr
         nBmpOOrnu0PXsAfiAkFdNxQthPkeY3iZ2j4FCDDT0SmUPQJqw/+aXS5S6k5ZCV/33umP
         BzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ef61v4ufR71o7uKhOFEtM/Aty/YCrnVSUfAAbbh7U/s=;
        b=FZ178d0AmxkyylwBRaof7dAcKFIlBuoYehnMp49QsG3PLtugiSFaNccGuY+m8MhrNF
         KcTGZKeNJk+E5akG4JzS4GCHukNagl3uT8cCLMOpKUQ/1XZsbAQAbww9O7cGjpeZ8ttx
         f64fh5/x9RvsBIabp5qTpTCUApnRLXSR6j2gG7nH6vj/Di7urlKL84gXbMTmEs/fnU+Q
         BslWrCnp7GAsjZHuR3PZ2qt7pQQWpbD/DUAd6Pg3W7DpFlIAWvgKnDS8XdP7HlNylhiX
         GG0SCwTDupSqoQAVpk/yQ4a+MAFivukgAtGVq0VazY16x9X96ZK5svx9HssqSKIiRtCF
         3PRw==
X-Gm-Message-State: APjAAAV1QEINoaeayzMMWC2aoPLyxaa7kaa/g8Mv3sJYvUtukuQZW1I2
        4ZJci+kATcxTDfL+Z8pMpQDDwIS2StwSC9t0fg==
X-Google-Smtp-Source: APXvYqwdxmY5Oq2Fw3kYURfXzUB9MvXmabUYU7SoILemyv88CgMXLvS4bCDvi33AvAzrRrBDONH2hj300qYxWtgKfw==
X-Received: by 2002:a05:620a:b06:: with SMTP id t6mr528720qkg.373.1576624584216;
 Tue, 17 Dec 2019 15:16:24 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:16:10 -0800
In-Reply-To: <20191217231615.164161-1-almasrymina@google.com>
Message-Id: <20191217231615.164161-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v9 3/8] hugetlb_cgroup: add reservation accounting for private mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Normally the pointer to the cgroup to uncharge hangs off the struct
page, and gets queried when it's time to free the page. With
hugetlb_cgroup reservations, this is not possible. Because it's possible
for a page to be reserved by one task and actually faulted in by another
task.

The best place to put the hugetlb_cgroup pointer to uncharge for
reservations is in the resv_map. But, because the resv_map has different
semantics for private and shared mappings, the code patch to
charge/uncharge shared and private mappings is different. This patch
implements charging and uncharging for private mappings.

For private mappings, the counter to uncharge is in
resv_map->reservation_counter. On initializing the resv_map this is set
to NULL. On reservation of a region in private mapping, the tasks
hugetlb_cgroup is charged and the hugetlb_cgroup is placed is
resv_map->reservation_counter.

On hugetlb_vm_op_close, we uncharge resv_map->reservation_counter.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Hillf Danton <hdanton@sina.com>

---

Changes in V9:
- Updated for reparenting of hugetlb reservation accounting.

---
 include/linux/hugetlb.h        |  9 +++++++
 include/linux/hugetlb_cgroup.h | 27 +++++++++++++++++++
 mm/hugetlb.c                   | 47 +++++++++++++++++++++++++++++++++-
 mm/hugetlb_cgroup.c            | 28 --------------------
 4 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index dea6143aa0685..e6ab499ba2086 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -46,6 +46,15 @@ struct resv_map {
 	long adds_in_progress;
 	struct list_head region_cache;
 	long region_cache_count;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * On private mappings, the counter to uncharge reservations is stored
+	 * here. If these fields are 0, then the mapping is shared.
+	 */
+	struct page_counter *reservation_counter;
+	unsigned long pages_per_hpage;
+	struct cgroup_subsys_state *css;
+#endif
 };
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index eab8a70d5bcb5..8c320accefe87 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -25,6 +25,33 @@ struct hugetlb_cgroup;
 #define HUGETLB_CGROUP_MIN_ORDER	2

 #ifdef CONFIG_CGROUP_HUGETLB
+enum hugetlb_memory_event {
+	HUGETLB_MAX,
+	HUGETLB_NR_MEMORY_EVENTS,
+};
+
+struct hugetlb_cgroup {
+	struct cgroup_subsys_state css;
+
+	/*
+	 * the counter to account for hugepages from hugetlb.
+	 */
+	struct page_counter hugepage[HUGE_MAX_HSTATE];
+
+	/*
+	 * the counter to account for hugepage reservations from hugetlb.
+	 */
+	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
+
+	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
+	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
+
+	/* Handle for "hugetlb.events" */
+	struct cgroup_file events_file[HUGE_MAX_HSTATE];
+
+	/* Handle for "hugetlb.events.local" */
+	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
+};

 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
 							      bool reserved)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e6e8240f1718c..7782977970301 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -665,6 +665,17 @@ struct resv_map *resv_map_alloc(void)
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
+	resv_map->css = NULL;
+#endif

 	INIT_LIST_HEAD(&resv_map->region_cache);
 	list_add(&rg->link, &resv_map->region_cache);
@@ -3145,7 +3156,20 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)

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
+	WARN_ON(!resv->css);
+
+	hugetlb_cgroup_uncharge_counter(resv->reservation_counter,
+					(end - start) * resv->pages_per_hpage,
+					resv->css);
+#endif

 	if (reserve) {
 		/*
@@ -3155,6 +3179,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
+
+	kref_put(&resv->refs, resv_map_release);
 }

 static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -4501,6 +4527,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
+	struct hugetlb_cgroup *h_cg;
 	long gbl_reserve;

 	/* This should never happen */
@@ -4534,12 +4561,30 @@ int hugetlb_reserve_pages(struct inode *inode,
 		chg = region_chg(resv_map, from, to);

 	} else {
+		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
 			return -ENOMEM;

 		chg = to - from;

+		if (hugetlb_cgroup_charge_cgroup(hstate_index(h),
+						 chg * pages_per_huge_page(h),
+						 &h_cg, true)) {
+			kref_put(&resv_map->refs, resv_map_release);
+			return -ENOMEM;
+		}
+
+#ifdef CONFIG_CGROUP_HUGETLB
+		/*
+		 * Since this branch handles private mappings, we attach the
+		 * counter to uncharge for this reservation off resv_map.
+		 */
+		resv_map->reservation_counter =
+			&h_cg->reserved_hugepage[hstate_index(h)];
+		resv_map->pages_per_hpage = pages_per_huge_page(h);
+#endif
+
 		set_vma_resv_map(vma, resv_map);
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index b03270b0d5833..e066122ab9f49 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -23,34 +23,6 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>

-enum hugetlb_memory_event {
-	HUGETLB_MAX,
-	HUGETLB_NR_MEMORY_EVENTS,
-};
-
-struct hugetlb_cgroup {
-	struct cgroup_subsys_state css;
-
-	/*
-	 * the counter to account for hugepages from hugetlb.
-	 */
-	struct page_counter hugepage[HUGE_MAX_HSTATE];
-
-	/*
-	 * the counter to account for hugepage reservations from hugetlb.
-	 */
-	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
-
-	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
-	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
-
-	/* Handle for "hugetlb.events" */
-	struct cgroup_file events_file[HUGE_MAX_HSTATE];
-
-	/* Handle for "hugetlb.events.local" */
-	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
-};
-
 #define MEMFILE_PRIVATE(x, val)	(((x) << 16) | (val))
 #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
--
2.24.1.735.g03f4e72817-goog
