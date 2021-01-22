Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689EE2FFB58
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbhAVDn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbhAVDjc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:39:32 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C5EC0617AB
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:37:59 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id a1so2044654qvd.13
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e74/zX5No5cOCfpB2W0t8AirTAoBoOVLhRriobZDhjw=;
        b=UBcjrLT+H0UeEyTgHtDXvMrqHcqXTxAcenv4cacXsnLKRsq1H+031H24ZjueUTWHPT
         TVmaZPXjNscLVgWRLePCLKCiK1LMLIR7ndna2liqlfxV96wdMYls9zXrSj04rs+mLFPj
         jY1rpiJiRo/JqDFbluWSmSORg2HWTTGdOfNnDhcnFVgXLENXo0wwpLgwu897OzyFMmLi
         d2+QOqCVtn2Rk+yhHiTl/FGPnxaIfwQM/LfY+RjVOZR5SiiH3aAthfrxrHWQLeGiVY2V
         BH7KzTUOsBMgy3m7z16n1bqEyo2IFezQuUt4qpqNokuVDYhaWkhT8gS/EeBe+qAV5bWu
         pB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e74/zX5No5cOCfpB2W0t8AirTAoBoOVLhRriobZDhjw=;
        b=kVYh/mp/68PI4iFSyNWcA85cGqykDgTM6/S0fRL9uxnMs37rEGeXxWRWuoLV3jcMda
         9rdNJmbV3pu6zVVvGp0cQM7fkzgwRF2BS2j18kFZU5od1NUOcjtVQNiUHZwq3ZzvV0NT
         BhWZ+czzb2hK91tbqo04xfjQ9mhyljDy/0PfpX1cbXNUKo/oGLz5CI217ooqDCXTfQb/
         chQCt3yWQgkfd6a1WQIlNAUw7RzwNc3ALqyd0jk+Pp76tyvKK2TDKlJG/Dh7bBs8XDxH
         6Qt6o2dnGKRQf3bE5eVXMBxGIHShpGOAfGMRk3xiTl5Kjj2M0srgt8vLO1t/wKf3BMp+
         DQ4Q==
X-Gm-Message-State: AOAM533TvsMlP2xOQrJ0Bb/FA9lxHhsFqwT5Nu4C7QE+mA2HiebMnREz
        YCWYELxBBrVac557K2lYij1HwA==
X-Google-Smtp-Source: ABdhPJzh0RdTeNC3TFDCK+Ts6AHunnADAqdwJtNemxI/WM/8RNJIMf9WiR+jq3LWJdvSu6siZb2TMA==
X-Received: by 2002:ad4:4b72:: with SMTP id m18mr2929665qvx.10.1611286678814;
        Thu, 21 Jan 2021 19:37:58 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:37:58 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 05/14] mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
Date:   Thu, 21 Jan 2021 22:37:39 -0500
Message-Id: <20210122033748.924330-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PF_MEMALLOC_NOCMA is used ot guarantee that the allocator will not return
pages that might belong to CMA region. This is currently used for long
term gup to make sure that such pins are not going to be done on any CMA
pages.

When PF_MEMALLOC_NOCMA has been introduced we haven't realized that it is
focusing on CMA pages too much and that there is larger class of pages that
need the same treatment. MOVABLE zone cannot contain any long term pins as
well so it makes sense to reuse and redefine this flag for that usecase as
well. Rename the flag to PF_MEMALLOC_PIN which defines an allocation
context which can only get pages suitable for long-term pins.

Also re-name:
memalloc_nocma_save()/memalloc_nocma_restore
to
memalloc_pin_save()/memalloc_pin_restore()
and make the new functions common.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/sched.h    |  2 +-
 include/linux/sched/mm.h | 21 +++++----------------
 mm/gup.c                 |  4 ++--
 mm/hugetlb.c             |  4 ++--
 mm/page_alloc.c          |  4 ++--
 5 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5e088c1bf282..43c4efa4f575 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1576,7 +1576,7 @@ extern struct pid *cad_pid;
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
-#define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
+#define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 1ae08b8462a4..5f4dd3274734 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -270,29 +270,18 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
 }
 
-#ifdef CONFIG_CMA
-static inline unsigned int memalloc_nocma_save(void)
+static inline unsigned int memalloc_pin_save(void)
 {
-	unsigned int flags = current->flags & PF_MEMALLOC_NOCMA;
+	unsigned int flags = current->flags & PF_MEMALLOC_PIN;
 
-	current->flags |= PF_MEMALLOC_NOCMA;
+	current->flags |= PF_MEMALLOC_PIN;
 	return flags;
 }
 
-static inline void memalloc_nocma_restore(unsigned int flags)
+static inline void memalloc_pin_restore(unsigned int flags)
 {
-	current->flags = (current->flags & ~PF_MEMALLOC_NOCMA) | flags;
+	current->flags = (current->flags & ~PF_MEMALLOC_PIN) | flags;
 }
-#else
-static inline unsigned int memalloc_nocma_save(void)
-{
-	return 0;
-}
-
-static inline void memalloc_nocma_restore(unsigned int flags)
-{
-}
-#endif
 
 #ifdef CONFIG_MEMCG
 DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
diff --git a/mm/gup.c b/mm/gup.c
index 7ecca2d66dff..857b273e32ac 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1669,7 +1669,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	long rc;
 
 	if (gup_flags & FOLL_LONGTERM)
-		flags = memalloc_nocma_save();
+		flags = memalloc_pin_save();
 
 	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
 				     gup_flags);
@@ -1678,7 +1678,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 		if (rc > 0)
 			rc = check_and_migrate_cma_pages(mm, start, rc, pages,
 							 vmas, gup_flags);
-		memalloc_nocma_restore(flags);
+		memalloc_pin_restore(flags);
 	}
 	return rc;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a6bad1f686c5..2d79e515a7a3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1049,10 +1049,10 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 {
 	struct page *page;
-	bool nocma = !!(current->flags & PF_MEMALLOC_NOCMA);
+	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-		if (nocma && is_migrate_cma_page(page))
+		if (pin && is_migrate_cma_page(page))
 			continue;
 
 		if (PageHWPoison(page))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b031a5ae0bd5..f92d7c810953 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3813,8 +3813,8 @@ static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
 #ifdef CONFIG_CMA
 	unsigned int pflags = current->flags;
 
-	if (!(pflags & PF_MEMALLOC_NOCMA) &&
-			gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
+	if (!(pflags & PF_MEMALLOC_PIN) &&
+	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
 
 #endif
-- 
2.25.1

