Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F702FFB47
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbhAVDlN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbhAVDkC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:40:02 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D04EC0611C3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:11 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id r9so3219623qtp.11
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5n2Z61YQ/LO6HRNKobWmiWmcOuYkZueXUaF1fevgvMs=;
        b=PY6VVqi0jkzV/I13PL72rl+9xROWW9CM1xLiOEHtaFP3c64sw9EIlzRLOe9kyqhQiq
         v0YVgxbUe542ryupmkDe1P37WQaEfYRG/DBqtrAJ2EMXTRspnO0zUwoq4LtmLRBxPW4B
         VCpWfwXcbGwgoggpG9ehYXfINtjuzrOpUFYKEq5CuE10YMy+8Xq6ImPSdK5QNL1hWgRI
         UltcXEZkRGTNwSQYekT5dGMPrIpSpNwy/nuSsYYgH+FV9e/A+LDh5XU6klBMzxKknTCS
         dZYIBuKDQCVLGusbm3r4lQ8TlEyV0K3SL3bfe8Rufkch66MPb6mHhdu/Csd4RaWQO+z/
         eeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5n2Z61YQ/LO6HRNKobWmiWmcOuYkZueXUaF1fevgvMs=;
        b=flV7SHrJDRYjPTPLxjv5pWgUGfBTKJ8PBAUp7j8HkkEYWyr3O7sLMd/JS7N7/YXeUR
         +ypDMemzFr1PgDVAUV8xyRGqEZhqcr0lp7Aigds0iIsnre4XB86la+2xh1X9+O0ELux/
         +XiKmwCkshl6/89ObZUXEpZV4+L0VbkNDM04zXR1RsWIvX4zo4gW1jVn5urJGjYUrgRj
         LwdoCdPkuqDXxYwUD8tk4+LGE74dIuRhpwCj8y12Dl+WtNzRYdWrzv2818gpPwFOO4SM
         Ch6bgj9226afGXy6mvlTHK9Px3iX82ZmKbbLyswFu/Hh30SxNuZZuluVaO7hvYrhJm2E
         sQmw==
X-Gm-Message-State: AOAM533qDEd1iTK+Ij2e0MJoXM5HMEl1N8EKH7W4z7gZtMP1qIFGXVDU
        P8k9FqFYxGi0hDn6gY/k68r+xg==
X-Google-Smtp-Source: ABdhPJxdwUZjwVe5h1yEIOc0pPlyepebKcCHxJDM6RKigeiNQy4Xu7cZdxixDwOI/SpPmvbDv4NJuw==
X-Received: by 2002:ac8:4550:: with SMTP id z16mr2776927qtn.374.1611286690428;
        Thu, 21 Jan 2021 19:38:10 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:38:09 -0800 (PST)
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
Subject: [PATCH v7 12/14] mm/gup: longterm pin migration cleanup
Date:   Thu, 21 Jan 2021 22:37:46 -0500
Message-Id: <20210122033748.924330-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
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
index ddbbee741d5d..4a5eed17f451 100644
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
@@ -1609,47 +1610,27 @@ static long check_and_migrate_movable_pages(struct mm_struct *mm,
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
@@ -1667,22 +1648,22 @@ static long __gup_longterm_locked(struct mm_struct *mm,
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

