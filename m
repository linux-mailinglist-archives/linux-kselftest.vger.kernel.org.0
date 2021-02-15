Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26EF31BEF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 17:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBOQVj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 11:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhBOQSO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 11:18:14 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D7BC0611BE
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:14:06 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v10so5142437qtq.7
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4cyZtopRv2N4VTLbZRZ9cz9IiC/X2Br4gTBlwkFbXX8=;
        b=XBLPGZxx78dn0PwE/wpLIEtCKekpmfxfcYYWyF3kPJuX3XUOu5NhsPQ6IZ5Pk3YXPO
         +Eqkzx9eDH13NTbr76GNq3isXawaVgZKkQOaz8wZr/vlRaoyeKSTf2KDf+wWsincl8m3
         2SD+TM/tSoxRjmIxT6Rmg8V55F8JBwLhXVWJo9GWOFXmChJ19ODIZuZ3v+tg0T0tddTk
         jIuogxp6tWs+eE/kYz4ibeypWdRmKsXH5XyvPxSLQBoC0hnRHQwpFLs9UityFA3MaOCZ
         4cp6NBoCo38S2SO6gdccsgOUvZ9X7Pm7uoO/OYMWs+gY+BEFNy9Ciy22kFsC+GH+FKEo
         k/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4cyZtopRv2N4VTLbZRZ9cz9IiC/X2Br4gTBlwkFbXX8=;
        b=e7LWJ9ZDj5xBF9To1J48VcHdb5j35fz44iio+MS5Km5beHQ/F4kwM2TnXDcd0k4LNr
         +vzTdosYIRSwOVgiAhU7TC9Jx0s7VhG54tv5N1eGOyCDVC0903OS9rNJRDnibRqLFv96
         5Y3CYS7asxG2d6l0ZGS2GAMrs89AS42vhW4dBABTdOg+h0CkGplL9EonaiQQYu/k3wKt
         NczezBjAjV97udTDsPR54n9W7BeTaUcTpQrx04yfDfXisdJjjQ+ttajUlPB7GcGu8wfv
         eeO734RDcTUFMzrtWZ3sH87CIfP2/HiC6NXzfv/CVppOo+GuHRxKmKFdsiGPrl6WJWem
         ri4w==
X-Gm-Message-State: AOAM533dJY3OcEma956RpRKysTCfVpQNZC+dGsnTGZTKmFw1W1KxJzsl
        Omy+o0DpoTYYgdAF9jcfxWj98g==
X-Google-Smtp-Source: ABdhPJyx6tsEeqcl4TM3SVpqd2ABLDZ9p8CsahBkStqIgjJeyAZxG4c8ZNYcyO6VFv64ZCHQC486XQ==
X-Received: by 2002:aed:33c4:: with SMTP id v62mr15319509qtd.377.1613405645931;
        Mon, 15 Feb 2021 08:14:05 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:14:05 -0800 (PST)
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
Subject: [PATCH v11 09/14] mm/gup: migrate pinned pages out of movable zone
Date:   Mon, 15 Feb 2021 11:13:44 -0500
Message-Id: <20210215161349.246722-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
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
index 4594838a0f7c..aae5ef0b3ba1 100644
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
index c56f508be031..e8ccd4eab75e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -387,8 +387,13 @@ enum zone_type {
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
index 9af6faf1b2b3..da6d370fe551 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -88,11 +88,12 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
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
@@ -1540,17 +1541,17 @@ struct page *get_dump_page(unsigned long addr)
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
@@ -1568,13 +1569,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
 			if (PageHuge(head)) {
-				if (!isolate_huge_page(head, &cma_page_list))
+				if (!isolate_huge_page(head, &movable_page_list))
 					isolation_error_count++;
 			} else {
 				if (!PageLRU(head) && drain_allow) {
@@ -1586,7 +1586,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					isolation_error_count++;
 					continue;
 				}
-				list_add_tail(&head->lru, &cma_page_list);
+				list_add_tail(&head->lru, &movable_page_list);
 				mod_node_page_state(page_pgdat(head),
 						    NR_ISOLATED_ANON +
 						    page_is_file_lru(head),
@@ -1599,10 +1599,10 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1612,12 +1612,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
 
@@ -1636,16 +1636,16 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1669,8 +1669,9 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 
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

