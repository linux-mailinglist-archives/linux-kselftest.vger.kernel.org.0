Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0293113B6DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 02:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAOB1C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 20:27:02 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:37911 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgAOB1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 20:27:01 -0500
Received: by mail-ua1-f74.google.com with SMTP id i16so1491621ual.5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2020 17:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Kg+p/VmE2ROhKV/f4JfIzn9grk12cA50+GiyFmuccAU=;
        b=aQmn7cGyi4DTCWWDs/8MKLAnnwva8Ubb5n+C5BOd3SmYTQ9GvqFJGRc9/m0UDfBAUo
         egHMx514bdLFhyEiqHW3Z6seaUi1zIef7UrcDyE/3fiNXQla98SmA45FRe2iHeVwvAio
         PVSpj49XmlCQ4CrADmBE4g4SdQ5Kbzt73FH6yn5FvJdgXy3ETfbWjP4Rh2Pl/0326NRJ
         UpkwGmw5oLVNWMtH2KBOarSK1YxJheBtmQGEe0zctVuswXKNxBWM6DeX+IgYeM7oC/Gm
         /v9NF8x7Zx+XkVCLhCSh4E/+NhtJE3DTs5SlkNOb4Y50DYO+aXv2qjlcJ9qoREboroH2
         1UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Kg+p/VmE2ROhKV/f4JfIzn9grk12cA50+GiyFmuccAU=;
        b=KUNk9vvjjc1WlJsNcplp9gtoz1+DhL+XDoRlYf1443OFdSLz6Pw5M6sAySojkhi0JE
         EJJZSnv3ERoSgYBl81Kf7kvdcEpCFoOIxZBNfT278To6Eb6Mhl3hdNNbyDsbD7U/gHeo
         lKvBuJYzl1AmYY4zGK6ZHl0UOWRxpGeho4FmaCsvGUdHubKFcgevx7WdRc6pA0IovHtV
         fId3ouGnP/5pnq3UaxUiHFwtfQlzHWn8+jNO99UktdedGsVqa5EgnHoSuJWcdwI2StQm
         kXOpew14YKCcQw69m2euEhIlenw65fYQA5ekZmJP6XBMfOPX7DlNSLMzmk/ySfN1X03i
         uJjA==
X-Gm-Message-State: APjAAAW1Jjc4QIyAI75MrOadBUPiU/6FQfMx1ERvvBXaojOCkEuluz8J
        qKZst5GunubQrW1nrWikUbbTOvUYCwOgsQ89ZA==
X-Google-Smtp-Source: APXvYqzxDknpwcDc/7ZohHTw0rZ9c3Ju59PGISjRs0mxtbwIEst6J/yZEzTUCBawy1GQDoNg+Mk/LOZfZ23dttLoAw==
X-Received: by 2002:ab0:7450:: with SMTP id p16mr16108545uaq.20.1579051620011;
 Tue, 14 Jan 2020 17:27:00 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:26:46 -0800
In-Reply-To: <20200115012651.228058-1-almasrymina@google.com>
Message-Id: <20200115012651.228058-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v10 3/8] hugetlb_cgroup: add reservation accounting for
 private mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com, rientjes@google.com, shakeelb@google.com
Cc:     shuah@kernel.org, almasrymina@google.com, gthelen@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
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

---

Changes in v10:
- Fixed cases where the mapping is private but cgroup accounting is disabled.
Changes in V9:
- Updated for reparenting of hugetlb reservation accounting.

---
 include/linux/hugetlb.h        | 10 +++++++++
 include/linux/hugetlb_cgroup.h | 27 ++++++++++++++++++++++++
 mm/hugetlb.c                   | 38 +++++++++++++++++++++++++++++++++-
 mm/hugetlb_cgroup.c            | 28 -------------------------
 4 files changed, 74 insertions(+), 29 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index dea6143aa0685..5491932ea5758 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -46,6 +46,16 @@ struct resv_map {
 	long adds_in_progress;
 	struct list_head region_cache;
 	long region_cache_count;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * On private mappings, the counter to uncharge reservations is stored
+	 * here. If these fields are 0, then either the mapping is shared, or
+	 * cgroup accounting is disabled for this resv_map.
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
index 62a4cf3db4090..f1b63946ee95c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -666,6 +666,17 @@ struct resv_map *resv_map_alloc(void)
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
@@ -3194,7 +3205,11 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)

 	reserve = (end - start) - region_count(resv, start, end);

-	kref_put(&resv->refs, resv_map_release);
+#ifdef CONFIG_CGROUP_HUGETLB
+	hugetlb_cgroup_uncharge_counter(resv->reservation_counter,
+					(end - start) * resv->pages_per_hpage,
+					resv->css);
+#endif

 	if (reserve) {
 		/*
@@ -3204,6 +3219,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
+
+	kref_put(&resv->refs, resv_map_release);
 }

 static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -4550,6 +4567,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
+	struct hugetlb_cgroup *h_cg;
 	long gbl_reserve;

 	/* This should never happen */
@@ -4583,12 +4601,30 @@ int hugetlb_reserve_pages(struct inode *inode,
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
index c434f69f38354..ddfdf19a9ad35 100644
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
2.25.0.rc1.283.g88dfdc4193-goog
