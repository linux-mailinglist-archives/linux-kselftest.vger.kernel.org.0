Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA5E94AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 02:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfJ3BhQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Oct 2019 21:37:16 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:34818 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfJ3BhQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Oct 2019 21:37:16 -0400
Received: by mail-yw1-f73.google.com with SMTP id g69so534081ywb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2019 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qPaHEbPrYv6JUTplbHxnlfnp4zAORaH8vrWi/UicSm4=;
        b=IoXoUJuphbNgV9+X/Lt6knalFErc6s3NPqkOlQ1S9+wbHCVkgdrrVTFFV8e96qVxr/
         0WxOP+lLX3dm04M/Rm4QLxaw7PPDMOb4YA8sQ4FqlOteYVc4hLtgPZ8beJub3SoPjyJr
         AAWsxEFMqvfgjw7+6q9NT6dyDAVWFGcoldP5pC6gP6HhqcJRehTktAk+nJJSaGPbX3GK
         hLIFa8uM4Gei6GarKIYl6WV2534SqhVj2JpP9eQZRGef5nz6hXPnqrtlA59DHOmXOfQd
         VmNuRLkgOzTGa91wU/Dkt/tAuEfv4kgUBdrP141WQYWSiuXeHYv58sO8Llt+5ADfAKsF
         LPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qPaHEbPrYv6JUTplbHxnlfnp4zAORaH8vrWi/UicSm4=;
        b=M3vTOQKsHz1c55fZKiIHcV4hmbBQvLfaN+LAUQPSm89hWVf5Dx4eP8OJnWqHc5vwJj
         Audg+uEhrC6WNqjACsyKZn1nG3lkqkyN7p+QBXUtMgWXUCr9lgL+PAhJhjAVvMjyJ578
         RZTnhcANfNLjgSbbHQ4CjpEMlbM5SW5JMAeV1aH/d5zRaTouRnCAP/1q0dZ7kDSlC9fN
         l/zNyhsR5YiyLOan0mLqgG+k8x0ZZcirHg/IM9Fw4Tr+rAXD1qBZSjcDeA19aitjFP8q
         mAZJ6UmGTtSG9Xe3KdVplAHKQ3609ltnndo4rlbuFrExCHKmyPBWJQPHz1f6RGdiopnQ
         y3kw==
X-Gm-Message-State: APjAAAW0p2az5tC827QY6vp5k9rNfHDYizGXUNUWFy50U3+v2owHtupE
        urkOkKMiXzjPbZIKggqSjfmmiHbc4KiiGs686w==
X-Google-Smtp-Source: APXvYqwq6yygYVt3tY6tYtpBGDJ/fDbgkOJS1xGErEBdHsCzNqN+627UxywOTbJIshRr0GqN+Ey54sxWbBYsAt3Bog==
X-Received: by 2002:a81:25d7:: with SMTP id l206mr19187868ywl.36.1572399433419;
 Tue, 29 Oct 2019 18:37:13 -0700 (PDT)
Date:   Tue, 29 Oct 2019 18:36:56 -0700
In-Reply-To: <20191030013701.39647-1-almasrymina@google.com>
Message-Id: <20191030013701.39647-4-almasrymina@google.com>
Mime-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v8 4/9] hugetlb_cgroup: add reservation accounting for private mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, Hillf Danton <hdanton@sina.com>
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
 include/linux/hugetlb.h        |  8 +++++++
 include/linux/hugetlb_cgroup.h | 11 +++++++++
 mm/hugetlb.c                   | 44 +++++++++++++++++++++++++++++++++-
 mm/hugetlb_cgroup.c            | 12 ----------
 4 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9c49a0ba894d3..36dcda7be4b0e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -46,6 +46,14 @@ struct resv_map {
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
+#endif
 };
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 1bb58a63af586..f6e3d74a02536 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -25,6 +25,17 @@ struct hugetlb_cgroup;
 #define HUGETLB_CGROUP_MIN_ORDER 3

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

 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
 							      bool reserved)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 325d5454bf168..8d8aa89a9928e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -665,6 +665,16 @@ struct resv_map *resv_map_alloc(void)
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
@@ -3216,7 +3226,18 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)

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
+	hugetlb_cgroup_uncharge_counter(resv->reservation_counter,
+					(end - start) * resv->pages_per_hpage);
+#endif

 	if (reserve) {
 		/*
@@ -3226,6 +3247,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
+
+	kref_put(&resv->refs, resv_map_release);
 }

 static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -4559,6 +4582,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
+	struct hugetlb_cgroup *h_cg;
 	long gbl_reserve;

 	/* This should never happen */
@@ -4592,12 +4616,30 @@ int hugetlb_reserve_pages(struct inode *inode,
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
index ac1500205faf7..a0ca4024888e1 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -19,18 +19,6 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>

-struct hugetlb_cgroup {
-	struct cgroup_subsys_state css;
-	/*
-	 * the counter to account for hugepages from hugetlb.
-	 */
-	struct page_counter hugepage[HUGE_MAX_HSTATE];
-	/*
-	 * the counter to account for hugepage reservations from hugetlb.
-	 */
-	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
-};
-
 #define MEMFILE_PRIVATE(x, val)	(((x) << 16) | (val))
 #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
--
2.24.0.rc1.363.gb1bccd3e3d-goog
