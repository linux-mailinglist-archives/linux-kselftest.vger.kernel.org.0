Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5F31BF0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 17:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhBOQX5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 11:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhBOQRR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 11:17:17 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC57C0611C2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:14:03 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id q85so6795582qke.8
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9+I2YL20vIMEn1f1+NRTujbux5LnqLr6dmxmUUzNGH0=;
        b=ijhTSwggny9zK7iGkfL/pEpINleDTxUH8QkHc3vNFgmZf7pNeYhLn1vpVAqDj82yTY
         Pngejcnd3Qll93X/xq2NUk/YAGn6fwXnaqqpuReOBib62p8jCnjntqRjktqjRlg9OdLi
         unkFxxOjiu21ne+04lgRMbkUZVsvT1Pv2d9+9t1WfCj8/ZkigNEmhKBYz8s97Y6ROz11
         EhstXfzvFI+K8Vvt8BfARWVXSL7nAbxBA5RqRVMQ/P0Q0Yk2oEZVqWF6XP09pXSteh41
         Y1499ZiokKAB6MfoYidyLgDpB+gBssFPE0zmQwXZxF0LjyaiRy3zJi013uMo0Zi/f/cM
         2WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+I2YL20vIMEn1f1+NRTujbux5LnqLr6dmxmUUzNGH0=;
        b=VonHZyP4OKUKPfTQVHn3ZUrO5JebNPwid3uNxVFbWJzJhsiQC/aPyx0m/f6EGFx5VN
         jhAUIFsG/+3UUXI+CaaFnJ1uNQJouwgy8Z2KVINQgGgDPj7p17SrnkohqdSwje3JOqU9
         V0yQKfNU3//fQ+T0joMZv4C5Rum9y4nG6Yes6x/c8diKsnxaxtc6hhoc+CjmCPej2lo3
         7P8TJSGAMBykDAudV9XPBNmuOGukrWpZLIpRMB6fl6Z30JTDlkmGDPX7P9O9Rl1+ckes
         4LIF6EnWSAzRqC1bhsYnD2POud9lNmwiBav+oQJ8qLV5jU8FUdenCSrTUILWBCqoMCqw
         DaLA==
X-Gm-Message-State: AOAM531P+8NyZvnxzVt0r+uIiaJuP4xVXCYsrjN/lOoxa+gv3k5/ofsv
        PlWx9d0OG/yHfP7rJOmZwXP9SQ==
X-Google-Smtp-Source: ABdhPJxjYsrqF0x2VMI4WuuO6FsfHdYQnfEarAwQ8bLXxiaeNi4N4rKzMcr4vBsB0q8RoXJPfwP/Fg==
X-Received: by 2002:a37:bd84:: with SMTP id n126mr15359454qkf.54.1613405642887;
        Mon, 15 Feb 2021 08:14:02 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:14:02 -0800 (PST)
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
Subject: [PATCH v11 07/14] mm: honor PF_MEMALLOC_PIN for all movable pages
Date:   Mon, 15 Feb 2021 11:13:42 -0500
Message-Id: <20210215161349.246722-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
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
 include/linux/mm.h       | 18 ++++++++++++++++++
 include/linux/sched/mm.h |  6 +++++-
 mm/hugetlb.c             |  2 +-
 mm/page_alloc.c          | 20 +++++++++-----------
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..7f56d8d62148 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1116,6 +1116,11 @@ static inline bool is_zone_device_page(const struct page *page)
 }
 #endif
 
+static inline bool is_zone_movable_page(const struct page *page)
+{
+	return page_zonenum(page) == ZONE_MOVABLE;
+}
+
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 void free_devmap_managed_page(struct page *page);
 DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
@@ -1487,6 +1492,19 @@ static inline unsigned long page_to_section(const struct page *page)
 }
 #endif
 
+/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
+#ifdef CONFIG_MIGRATION
+static inline bool is_pinnable_page(struct page *page)
+{
+	return !is_zone_movable_page(page) && !is_migrate_cma_page(page);
+}
+#else
+static inline bool is_pinnable_page(struct page *page)
+{
+	return true;
+}
+#endif
+
 static inline void set_page_zone(struct page *page, enum zone_type zone)
 {
 	page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);
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
index 861de87daf07..d1bcf5ed8df2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1052,7 +1052,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-		if (pin && is_migrate_cma_page(page))
+		if (pin && !is_pinnable_page(page))
 			continue;
 
 		if (PageHWPoison(page))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f6058e8f3105..ed38a3ccb9eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3807,16 +3807,13 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 	return alloc_flags;
 }
 
-static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
-					unsigned int alloc_flags)
+/* Must be called after current_gfp_context() which can change gfp_mask */
+static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
+						  unsigned int alloc_flags)
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
@@ -4472,7 +4469,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	} else if (unlikely(rt_task(current)) && !in_interrupt())
 		alloc_flags |= ALLOC_HARDER;
 
-	alloc_flags = current_alloc_flags(gfp_mask, alloc_flags);
+	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
 
 	return alloc_flags;
 }
@@ -4774,7 +4771,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
-		alloc_flags = current_alloc_flags(gfp_mask, reserve_flags);
+		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags);
 
 	/*
 	 * Reset the nodemask and zonelist iterators if memory policies can be
@@ -4943,7 +4940,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	if (should_fail_alloc_page(gfp_mask, order))
 		return false;
 
-	*alloc_flags = current_alloc_flags(gfp_mask, *alloc_flags);
+	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
 
 	/* Dirty zone balancing only done in the fast path */
 	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);
@@ -4985,7 +4982,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
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

