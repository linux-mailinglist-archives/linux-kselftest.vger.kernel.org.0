Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC61D30ABA5
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 16:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhBAPkQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 10:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhBAPkK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 10:40:10 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0388C0612F2
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Feb 2021 07:38:42 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c1so12540407qtc.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Feb 2021 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yw2/zMeAmyoZjT+2/nNtQtrKJ0lzG5UVFm3OGx6Im4I=;
        b=DLguHB6QCFL7F6VwGMxYRX1H+fLcVNwvZhwmdFysW6Er2huRz63qj2OKcgF8qEISlv
         upxH5gLBZbEQ5Og1v04kLfUatGJgGIRCOuXRFEaJzDn/X+koixRdB+WxexC+kTMzx8OQ
         jzZucGhLMRakFMVf3+EfDVYvBJdqIJa4jPlQ6xBw9/cIDwtkfV9Wi/4O+8eFR7H9wsjj
         wmIuAn9CEokQzBQt/eGwbE03megrMBCTOADCj7iUfSVDAFGVBPqvwM6eGnZECK3LTBLG
         vrRAJWsgyc52/XOye59UIztCx8LeXGMeZgjh37WoCH21LEorhTKM5HHhhlUrXfddzuSj
         badg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yw2/zMeAmyoZjT+2/nNtQtrKJ0lzG5UVFm3OGx6Im4I=;
        b=dDPbJzPbyp4R0Mty0CDaPxnQBMav6RxUW8eIpOvym+0JWdi739E/fjt4xPcaqTxUav
         DaCrFniUVKU7fFttUH38zarLx/UAaG+n3G8uibQiAcHeXF2b+bk95qf7I/qiEHGfKB0k
         j+CEne5Em2Sm2gJJQmnCiV3EPK/D93m/mT21dPWvZ1ZZ9YUhf3vwqmq7UfcyMYkxOQiF
         0OccT3oVk0/7B4mrVYfZSuEtQ0vCRRIbv6/1icYX5uxIb+ZllSlTjYcMnBPxNiEUlNZP
         /m3p5si1KWOSdjBqwnJYkQvYp15aEVvK07lA/4Mlx4TAuPb+SQ0HJ1Mp/42YMZ8920Me
         yGWA==
X-Gm-Message-State: AOAM530gpZPhkHewDX/MLGnpSylKIgmzUOqgKucnpNZrMNfxnikh8Uda
        3UWcfdqYmprxOBGgjyUNWK/q7w==
X-Google-Smtp-Source: ABdhPJzWIMV3tPwqt+OR5i5B+/9QKkVX7n1b9D+7W6IJOUyfLb2TZNPLCB+/cSjsw37snHi4wvV+RQ==
X-Received: by 2002:aed:2644:: with SMTP id z62mr16275615qtc.146.1612193922139;
        Mon, 01 Feb 2021 07:38:42 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 22sm14853307qke.123.2021.02.01.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:38:41 -0800 (PST)
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
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v9 07/14] mm: honor PF_MEMALLOC_PIN for all movable pages
Date:   Mon,  1 Feb 2021 10:38:20 -0500
Message-Id: <20210201153827.444374-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201153827.444374-1-pasha.tatashin@soleen.com>
References: <20210201153827.444374-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PF_MEMALLOC_PIN is only honored for CMA pages, extend
this flag to work for any allocations from ZONE_MOVABLE by removing
__GFP_MOVABLE from gfp_mask when this flag is passed in the current
context.

Add is_pinnable_page() to return true if page is in a pinnable page.
A pinnable page is not in ZONE_MOVABLE and not of MIGRATE_CMA type.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/mm.h       | 11 +++++++++++
 include/linux/sched/mm.h |  6 +++++-
 mm/hugetlb.c             |  2 +-
 mm/page_alloc.c          | 20 +++++++++-----------
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fee43eb43309..db228aa8d9f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1122,6 +1122,17 @@ static inline bool is_zone_device_page(const struct page *page)
 }
 #endif
 
+static inline bool is_zone_movable_page(const struct page *page)
+{
+	return page_zonenum(page) == ZONE_MOVABLE;
+}
+
+/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
+static inline bool is_pinnable_page(struct page *page)
+{
+	return !is_zone_movable_page(page) && !is_migrate_cma_page(page);
+}
+
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 void free_devmap_managed_page(struct page *page);
 DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 5f4dd3274734..a55277b0d475 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -150,12 +150,13 @@ static inline bool in_vfork(struct task_struct *tsk)
  * Applies per-task gfp context to the given allocation flags.
  * PF_MEMALLOC_NOIO implies GFP_NOIO
  * PF_MEMALLOC_NOFS implies GFP_NOFS
+ * PF_MEMALLOC_PIN  implies !GFP_MOVABLE
  */
 static inline gfp_t current_gfp_context(gfp_t flags)
 {
 	unsigned int pflags = READ_ONCE(current->flags);
 
-	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS))) {
+	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_PIN))) {
 		/*
 		 * NOIO implies both NOIO and NOFS and it is a weaker context
 		 * so always make sure it makes precedence
@@ -164,6 +165,9 @@ static inline gfp_t current_gfp_context(gfp_t flags)
 			flags &= ~(__GFP_IO | __GFP_FS);
 		else if (pflags & PF_MEMALLOC_NOFS)
 			flags &= ~__GFP_FS;
+
+		if (pflags & PF_MEMALLOC_PIN)
+			flags &= ~__GFP_MOVABLE;
 	}
 	return flags;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8499ec73c3c7..32261c957ddf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1047,7 +1047,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-		if (pin && is_migrate_cma_page(page))
+		if (pin && !is_pinnable_page(page))
 			continue;
 
 		if (PageHWPoison(page))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a068e8295931..ad3ed3ec4dd5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3808,16 +3808,13 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 	return alloc_flags;
 }
 
-static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
-					unsigned int alloc_flags)
+/* Must be called after current_gfp_context() which can change gfp_mask */
+static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
+					      unsigned int alloc_flags)
 {
 #ifdef CONFIG_CMA
-	unsigned int pflags = current->flags;
-
-	if (!(pflags & PF_MEMALLOC_PIN) &&
-	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
+	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
-
 #endif
 	return alloc_flags;
 }
@@ -4473,7 +4470,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	} else if (unlikely(rt_task(current)) && !in_interrupt())
 		alloc_flags |= ALLOC_HARDER;
 
-	alloc_flags = current_alloc_flags(gfp_mask, alloc_flags);
+	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
 
 	return alloc_flags;
 }
@@ -4775,7 +4772,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
-		alloc_flags = current_alloc_flags(gfp_mask, reserve_flags);
+		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags);
 
 	/*
 	 * Reset the nodemask and zonelist iterators if memory policies can be
@@ -4944,7 +4941,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	if (should_fail_alloc_page(gfp_mask, order))
 		return false;
 
-	*alloc_flags = current_alloc_flags(gfp_mask, *alloc_flags);
+	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
 
 	/* Dirty zone balancing only done in the fast path */
 	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);
@@ -4986,7 +4983,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
 	 * resp. GFP_NOIO which has to be inherited for all allocation requests
 	 * from a particular context which has been marked by
-	 * memalloc_no{fs,io}_{save,restore}.
+	 * memalloc_no{fs,io}_{save,restore}. And PF_MEMALLOC_PIN which ensures
+	 * movable zones are not used during allocation.
 	 */
 	gfp_mask = current_gfp_context(gfp_mask);
 	alloc_mask = gfp_mask;
-- 
2.25.1

