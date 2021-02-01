Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD82F30ABC7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 16:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhBAPnY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 10:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhBAPka (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 10:40:30 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDDC0611C2
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Feb 2021 07:38:52 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t17so12532861qtq.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Feb 2021 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IY6D8/ZMyGIUDKqllv86b5qOcyIRLy633LCHCtaaquY=;
        b=oVL04tKJhPZXNTm/tSGlt9wq7zPOy2Tf8VxZEZHXJ5HW7cFe+sAyUAjIGq9GiytRnq
         b0dMTa8okb0jB90g5tZMaQtK4RIroStvEJb2Yi6emO1QbKw6dVUHXoI2wjnCXjGn1qpg
         p/UV4rPuV8V6E70Q2Zj9BH3cfX64CP5xnY2m1fnBBkJbzu0swqDbX/6/Y/vXpCEr2zzm
         zXM8GtcZAz+LplNkdO67tZc9bybOg1vNjl8f6qcKEQQCdHX04dTZoIsET6+M1j7IgpE0
         tLo0ybBF7KNHWWBxyQ2nmA535TFSKu+hTkfF8GAkZF8Mjo0hCEUwxRGHw9YXbSLBcJcp
         1Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IY6D8/ZMyGIUDKqllv86b5qOcyIRLy633LCHCtaaquY=;
        b=VkrJ+bo9aJCJGctTAbqPTTuC4tptXX5vSpNWpEebzqI4VPwDGoaUnyItdxd69Hz1mg
         SSYEG5NGg8L0ETDQEPhVACpyHQEbAxSmvzY7i9xEfjvEVhrHfafw0CHTrlF0+9oH32DV
         j3MCDyd+2xec/yfCSgBczSs+YuMI5XEl81OOu1YCwspjFxskvDsdwdWg2BaKKvwZUYnl
         MINreXIBlFH28KTIybx3iAD2PAHHbo4TSmARxw6AHW6Gq7Imx40CrNE7o8kupckLVCzB
         6HB378XdyAPOQf49TkBN5qp0nd7cUJiAmCI+uUDWr4kbOFCoNjmcrnPnA0aYiiuVnRRk
         Kr7g==
X-Gm-Message-State: AOAM532VhqLUS68ikGS9KIQJGlt8Gfpgnn34Hz0XJl46tf8u8CwwtmUK
        ElaIf+Unuv9Rca3lj+fcrfY/kw==
X-Google-Smtp-Source: ABdhPJw6cxz5LrQfliJoV4qNwqKUs2MT1e09fwBDV4sp4+jrbzLxQ2ZcMDMyJuf321t2NDUQgUkc2g==
X-Received: by 2002:aed:2022:: with SMTP id 31mr15751459qta.85.1612193931196;
        Mon, 01 Feb 2021 07:38:51 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 22sm14853307qke.123.2021.02.01.07.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:38:50 -0800 (PST)
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
Subject: [PATCH v9 12/14] mm/gup: longterm pin migration cleanup
Date:   Mon,  1 Feb 2021 10:38:25 -0500
Message-Id: <20210201153827.444374-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201153827.444374-1-pasha.tatashin@soleen.com>
References: <20210201153827.444374-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When pages are longterm pinned, we must migrated them out of movable zone.
The function that migrates them has a hidden loop with goto. The loop is
to retry on isolation failures, and after successful migration.

Make this code better by moving this loop to the caller.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 93 ++++++++++++++++++++++----------------------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f98af75dab0f..fabfe2a5c627 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1549,27 +1549,28 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #ifdef CONFIG_MIGRATION
-static long check_and_migrate_movable_pages(struct mm_struct *mm,
-					    unsigned long start,
-					    unsigned long nr_pages,
+/*
+ * Check whether all pages are pinnable, if so return number of pages.  If some
+ * pages are not pinnable, migrate them, and unpin all pages. Return zero if
+ * pages were migrated, or if some pages were not successfully isolated.
+ * Return negative error if migration fails.
+ */
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
-					    struct vm_area_struct **vmas,
 					    unsigned int gup_flags)
 {
-	unsigned long i, isolation_error_count;
-	bool drain_allow;
+	unsigned long i;
+	unsigned long isolation_error_count = 0;
+	bool drain_allow = true;
 	LIST_HEAD(movable_page_list);
-	long ret = nr_pages;
-	struct page *prev_head, *head;
+	long ret = 0;
+	struct page *prev_head = NULL;
+	struct page *head;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
-check_again:
-	prev_head = NULL;
-	isolation_error_count = 0;
-	drain_allow = true;
 	for (i = 0; i < nr_pages; i++) {
 		head = compound_head(pages[i]);
 		if (head == prev_head)
@@ -1607,47 +1608,27 @@ static long check_and_migrate_movable_pages(struct mm_struct *mm,
 	 * in the correct zone.
 	 */
 	if (list_empty(&movable_page_list) && !isolation_error_count)
-		return ret;
+		return nr_pages;
 
+	if (gup_flags & FOLL_PIN) {
+		unpin_user_pages(pages, nr_pages);
+	} else {
+		for (i = 0; i < nr_pages; i++)
+			put_page(pages[i]);
+	}
 	if (!list_empty(&movable_page_list)) {
-		/*
-		 * drop the above get_user_pages reference.
-		 */
-		if (gup_flags & FOLL_PIN)
-			unpin_user_pages(pages, nr_pages);
-		else
-			for (i = 0; i < nr_pages; i++)
-				put_page(pages[i]);
-
 		ret = migrate_pages(&movable_page_list, alloc_migration_target,
 				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
 				    MR_LONGTERM_PIN);
-		if (ret) {
-			if (!list_empty(&movable_page_list))
-				putback_movable_pages(&movable_page_list);
-			return ret > 0 ? -ENOMEM : ret;
-		}
-
-		/* We unpinned pages before migration, pin them again */
-		ret = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
-					      NULL, gup_flags);
-		if (ret <= 0)
-			return ret;
-		nr_pages = ret;
+		if (ret && !list_empty(&movable_page_list))
+			putback_movable_pages(&movable_page_list);
 	}
 
-	/*
-	 * check again because pages were unpinned, and we also might have
-	 * had isolation errors and need more pages to migrate.
-	 */
-	goto check_again;
+	return ret > 0 ? -ENOMEM : ret;
 }
 #else
-static long check_and_migrate_movable_pages(struct mm_struct *mm,
-					    unsigned long start,
-					    unsigned long nr_pages,
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
-					    struct vm_area_struct **vmas,
 					    unsigned int gup_flags)
 {
 	return nr_pages;
@@ -1665,22 +1646,22 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 				  struct vm_area_struct **vmas,
 				  unsigned int gup_flags)
 {
-	unsigned long flags = 0;
+	unsigned int flags;
 	long rc;
 
-	if (gup_flags & FOLL_LONGTERM)
-		flags = memalloc_pin_save();
-
-	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
-				     gup_flags);
+	if (!(gup_flags & FOLL_LONGTERM))
+		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					       NULL, gup_flags);
+	flags = memalloc_pin_save();
+	do {
+		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					     NULL, gup_flags);
+		if (rc <= 0)
+			break;
+		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
+	} while (!rc);
+	memalloc_pin_restore(flags);
 
-	if (gup_flags & FOLL_LONGTERM) {
-		if (rc > 0)
-			rc = check_and_migrate_movable_pages(mm, start, rc,
-							     pages, vmas,
-							     gup_flags);
-		memalloc_pin_restore(flags);
-	}
 	return rc;
 }
 
-- 
2.25.1

