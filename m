Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4975D2FFB53
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbhAVDnH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbhAVDjh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:39:37 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B72C061222
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:06 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z11so3978151qkj.7
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kGQn1xMV23zbY7UQ/LS/tE4nwmXK/WKQjelj2EgYaT4=;
        b=FVvpHeyyCiXWrfmhBCaP1RBK0VoXsaiJbESEUSDnUQjZKYckKJ5G7iizKU6+jTFgBV
         U/cbqu+7Ecz3mU7XkW54+APcLSP6y9d+Di9D5ykKcs6cAk5M2qN16TASiBWYGIzlt0Ob
         aW2FXF6osZZOmyziS33PvbBJPM5o5Z9sy8ujCr/1IQUfhKjldMbx+H/E13mim+o+ZLOC
         dpCVmuwMcTY+X2Wj6HzzjykNAF7cBK0dWt3WJMF4QgR53jbai+UkpSYeAW6a0PC+rY/t
         wQfwC01D8AvdyUjErlaDsSh83ak8e5xnVnTILhF7TworWmwBFh1VlNpBkvG9GerE9/Z5
         4TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGQn1xMV23zbY7UQ/LS/tE4nwmXK/WKQjelj2EgYaT4=;
        b=pl7HF9hUIxLhrt+9wueur67rtqt8G0S+83O/Dsku9Nq+iEO/eDwpNwW5xqXBHC0pjv
         KtNRpkpdK5a3acImxKu9PQUwbvlyw4M7wX37ARqv87XCO9VjwrSwBybRaGiCnm1o9Du9
         P4yrKA7OcWzto8tYdTGaAhnH+LWCTWmCCqnIPT0VUBxOpQwuxlR6rpsH11ZRqY0mnvd5
         iboYgE/6E2Tm7dwAIRwRG7Yj1VPtmkBxe07zSEM76v4DBvYt5Z3JV1Alvi/mAwzVmiTs
         hMGvXF2mfKKFiu8ybSYXq06Fyf4iWbXtFXHCXPKLxjZK2TQPqiPNs3NhqkF42PSjOl1T
         aXKQ==
X-Gm-Message-State: AOAM5321Qz5MYMdPMvaSslZoEUoIqokcEILjvJOJEX4tusuw1hp6HbYP
        HWHSjkfDMB3WxnOQQQwIqcMdGg==
X-Google-Smtp-Source: ABdhPJxqVyh7S/sXzLdkwtt6f6bDPTHZJjmPLiEq5+bj0RerPXUz+QCC17o62t/ZznjwbulIfCZVBQ==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr3101745qkd.393.1611286685400;
        Thu, 21 Jan 2021 19:38:05 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:38:04 -0800 (PST)
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
Subject: [PATCH v7 09/14] mm/gup: migrate pinned pages out of movable zone
Date:   Thu, 21 Jan 2021 22:37:43 -0500
Message-Id: <20210122033748.924330-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We should not pin pages in ZONE_MOVABLE. Currently, we do not pin only
movable CMA pages. Generalize the function that migrates CMA pages to
migrate all movable pages. Use is_pinnable_page() to check which
pages need to be migrated

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/migrate.h        |  1 +
 include/linux/mmzone.h         |  9 ++++-
 include/trace/events/migrate.h |  3 +-
 mm/gup.c                       | 67 +++++++++++++++++-----------------
 4 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3a389633b68f..fdf65f23acec 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -27,6 +27,7 @@ enum migrate_reason {
 	MR_MEMPOLICY_MBIND,
 	MR_NUMA_MISPLACED,
 	MR_CONTIG_RANGE,
+	MR_LONGTERM_PIN,
 	MR_TYPES
 };
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 72b0b6eba854..300eb31439cb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -407,8 +407,13 @@ enum zone_type {
 	 * to increase the number of THP/huge pages. Notable special cases are:
 	 *
 	 * 1. Pinned pages: (long-term) pinning of movable pages might
-	 *    essentially turn such pages unmovable. Memory offlining might
-	 *    retry a long time.
+	 *    essentially turn such pages unmovable. Therefore, we do not allow
+	 *    pinning long-term pages in ZONE_MOVABLE. When pages are pinned and
+	 *    faulted, they come from the right zone right away. However, it is
+	 *    still possible that address space already has pages in
+	 *    ZONE_MOVABLE at the time when pages are pinned (i.e. user has
+	 *    touches that memory before pinning). In such case we migrate them
+	 *    to a different zone. When migration fails - pinning fails.
 	 * 2. memblock allocations: kernelcore/movablecore setups might create
 	 *    situations where ZONE_MOVABLE contains unmovable allocations
 	 *    after boot. Memory offlining and allocations fail early.
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 4d434398d64d..363b54ce104c 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -20,7 +20,8 @@
 	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
 	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
-	EMe(MR_CONTIG_RANGE,	"contig_range")
+	EM( MR_CONTIG_RANGE,	"contig_range")			\
+	EMe(MR_LONGTERM_PIN,	"longterm_pin")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff --git a/mm/gup.c b/mm/gup.c
index fdd5cda30a07..0422dd150e80 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -89,11 +89,12 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		int orig_refs = refs;
 
 		/*
-		 * Can't do FOLL_LONGTERM + FOLL_PIN with CMA in the gup fast
-		 * path, so fail and let the caller fall back to the slow path.
+		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
+		 * right zone, so fail and let the caller fall back to the slow
+		 * path.
 		 */
-		if (unlikely(flags & FOLL_LONGTERM) &&
-				is_migrate_cma_page(page))
+		if (unlikely((flags & FOLL_LONGTERM) &&
+			     !is_pinnable_page(page)))
 			return NULL;
 
 		/*
@@ -1547,17 +1548,17 @@ struct page *get_dump_page(unsigned long addr)
 }
 #endif /* CONFIG_ELF_CORE */
 
-#ifdef CONFIG_CMA
-static long check_and_migrate_cma_pages(struct mm_struct *mm,
-					unsigned long start,
-					unsigned long nr_pages,
-					struct page **pages,
-					struct vm_area_struct **vmas,
-					unsigned int gup_flags)
+#ifdef CONFIG_MIGRATION
+static long check_and_migrate_movable_pages(struct mm_struct *mm,
+					    unsigned long start,
+					    unsigned long nr_pages,
+					    struct page **pages,
+					    struct vm_area_struct **vmas,
+					    unsigned int gup_flags)
 {
 	unsigned long i, isolation_error_count;
 	bool drain_allow;
-	LIST_HEAD(cma_page_list);
+	LIST_HEAD(movable_page_list);
 	long ret = nr_pages;
 	struct page *prev_head, *head;
 	struct migration_target_control mtc = {
@@ -1575,15 +1576,14 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			continue;
 		prev_head = head;
 		/*
-		 * If we get a page from the CMA zone, since we are going to
-		 * be pinning these entries, we might as well move them out
-		 * of the CMA zone if possible.
+		 * If we get a movable page, since we are going to be pinning
+		 * these entries, try to move them out if possible.
 		 */
-		if (is_migrate_cma_page(head)) {
+		if (!is_pinnable_page(head)) {
 			if (is_zero_pfn(page_to_pfn(head)))
 				continue;
 			if (PageHuge(head)) {
-				if (!isolate_huge_page(head, &cma_page_list))
+				if (!isolate_huge_page(head, &movable_page_list))
 					isolation_error_count++;
 			} else {
 				if (!PageLRU(head) && drain_allow) {
@@ -1595,7 +1595,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					isolation_error_count++;
 					continue;
 				}
-				list_add_tail(&head->lru, &cma_page_list);
+				list_add_tail(&head->lru, &movable_page_list);
 				mod_node_page_state(page_pgdat(head),
 						    NR_ISOLATED_ANON +
 						    page_is_file_lru(head),
@@ -1608,10 +1608,10 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	 * If list is empty, and no isolation errors, means that all pages are
 	 * in the correct zone.
 	 */
-	if (list_empty(&cma_page_list) && !isolation_error_count)
+	if (list_empty(&movable_page_list) && !isolation_error_count)
 		return ret;
 
-	if (!list_empty(&cma_page_list)) {
+	if (!list_empty(&movable_page_list)) {
 		/*
 		 * drop the above get_user_pages reference.
 		 */
@@ -1621,12 +1621,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			for (i = 0; i < nr_pages; i++)
 				put_page(pages[i]);
 
-		ret = migrate_pages(&cma_page_list, alloc_migration_target,
+		ret = migrate_pages(&movable_page_list, alloc_migration_target,
 				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_CONTIG_RANGE);
+				    MR_LONGTERM_PIN);
 		if (ret) {
-			if (!list_empty(&cma_page_list))
-				putback_movable_pages(&cma_page_list);
+			if (!list_empty(&movable_page_list))
+				putback_movable_pages(&movable_page_list);
 			return ret > 0 ? -ENOMEM : ret;
 		}
 
@@ -1645,16 +1645,16 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	goto check_again;
 }
 #else
-static long check_and_migrate_cma_pages(struct mm_struct *mm,
-					unsigned long start,
-					unsigned long nr_pages,
-					struct page **pages,
-					struct vm_area_struct **vmas,
-					unsigned int gup_flags)
+static long check_and_migrate_movable_pages(struct mm_struct *mm,
+					    unsigned long start,
+					    unsigned long nr_pages,
+					    struct page **pages,
+					    struct vm_area_struct **vmas,
+					    unsigned int gup_flags)
 {
 	return nr_pages;
 }
-#endif /* CONFIG_CMA */
+#endif /* CONFIG_MIGRATION */
 
 /*
  * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
@@ -1678,8 +1678,9 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 
 	if (gup_flags & FOLL_LONGTERM) {
 		if (rc > 0)
-			rc = check_and_migrate_cma_pages(mm, start, rc, pages,
-							 vmas, gup_flags);
+			rc = check_and_migrate_movable_pages(mm, start, rc,
+							     pages, vmas,
+							     gup_flags);
 		memalloc_pin_restore(flags);
 	}
 	return rc;
-- 
2.25.1

