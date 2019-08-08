Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9D86DC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 01:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbfHHXOF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 19:14:05 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:42672 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404667AbfHHXOF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 19:14:05 -0400
Received: by mail-vs1-f74.google.com with SMTP id a11so24688630vso.9
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2019 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M6cyBd5hA6OsVmAelGzV5tX+uF9n4OBWzNC5c9d9ybI=;
        b=r1KEmh0qrOpvBm1/+0oF0sFMH6EQNPOKTvWW1271fb2M52m+iVMsdTPIGKzfVVpgj5
         x+Nc7IcNm8URXfh6TYEay9WEJj4RCDbRjTAMgdrTcpePccY/hODxMK3rNh/znjoVcOBh
         LHTQpfT5/V4EZ7R6N+KMldgXBUoH0DykmWZx9LJEzyLnRFCME7SC3gsq4nP41UK1D3az
         fXXxpAnfQK8rjWMgzEd+dqkIbR5A5/BX9N3Fv+dnJlUU3lDtlUjaBsCblfohOv1PHDlw
         HoFX3WEegCMRRcW1gySNo8nwEMo4BRcSGuyQWrwBWkybGT21t/g38QCSjpGUG2swlQU/
         vkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M6cyBd5hA6OsVmAelGzV5tX+uF9n4OBWzNC5c9d9ybI=;
        b=e0xKyoSsB0M2n5FRAJZgk0Mng210wNfSSJjFz4fbu7x04lOdaGzmqmTHOqeLe//UuB
         u/mAWSCd7NbPn2hA4YzwEcU3pye/ByjsFAQzVYy/Pxi1up13tlTgUi099POabDKP8ecE
         GCSA6Xi+KnWZZcIB1p6JAUNqGfEeZxckkJZQHJ0eHr+DB2QLG40pSkVByY9UzvmiWsv9
         T3dpKQIEh0u2pttdtXz8Tsl3of+uZXCpv/GwyPKPBCQ8Ch6QrHf9RU7fZL/MXOwlp6LK
         sUXA+tONIslcd9T2/tQubAnw2ccC0LgPSVVh+L8bE4Biwe/qp7gwTE+WE9SwbrjN3xZ3
         WlHg==
X-Gm-Message-State: APjAAAUsgdGLrfq8shH7fyCXCwy2Pz2oYTwAEK+SsKetg19mI1P63ECv
        eoMLTNkiu9T1Os2vAGbtt5b6hwqib2GlCT3WHQ==
X-Google-Smtp-Source: APXvYqw//j8PX12o0jMJ/sTXdB0ZGAaXDk7In1PyTrMUN50VA3e5H4NhBHXZpX/7PJT5SedxTsS+zxmp8Csw1EfK6w==
X-Received: by 2002:ac5:c853:: with SMTP id g19mr100310vkm.60.1565306043479;
 Thu, 08 Aug 2019 16:14:03 -0700 (PDT)
Date:   Thu,  8 Aug 2019 16:13:38 -0700
In-Reply-To: <20190808231340.53601-1-almasrymina@google.com>
Message-Id: <20190808231340.53601-4-almasrymina@google.com>
Mime-Version: 1.0
References: <20190808231340.53601-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [RFC PATCH v2 3/5] hugetlb_cgroup: Add reservation accounting for
 private mappings
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

---
 include/linux/hugetlb.h        |  8 ++++++
 include/linux/hugetlb_cgroup.h | 11 ++++++++
 mm/hugetlb.c                   | 47 ++++++++++++++++++++++++++++++++--
 mm/hugetlb_cgroup.c            | 12 ---------
 4 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6777b3013345d..90b3c928d16c1 100644
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
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 0725f809cd2d9..1fdde63a4e775 100644
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c153bef42e729..235996aef6618 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -711,6 +711,16 @@ struct resv_map *resv_map_alloc(void)
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
@@ -3192,7 +3202,19 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)

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
@@ -3202,6 +3224,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
+
+	kref_put(&resv->refs, resv_map_release);
 }

 static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -4516,6 +4540,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
+	struct hugetlb_cgroup *h_cg;
 	long gbl_reserve;

 	/* This should never happen */
@@ -4549,11 +4574,29 @@ int hugetlb_reserve_pages(struct inode *inode,
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
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 119176a0b2ec5..06e99ae1fec81 100644
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
2.23.0.rc1.153.gdeed80330f-goog
