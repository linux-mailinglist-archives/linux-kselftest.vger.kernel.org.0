Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA4318FE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhBKQ1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 11:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhBKQZW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 11:25:22 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91968C0617AA
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:36 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id r77so5675880qka.12
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+uM7iGhfnoUeI1t0IUaH+Vl0pOebgnmrqgW4IescHko=;
        b=YyEw3VerwiWUlTZ//FfQlXGigghHmwC0XIsSkbgjnM/tN1cGCg7L6d1kxsu6VLbwDz
         Vi6CMBYbI3d+Io8phkGGDLU6axcDOyngmDu0fRPvuq0KiqOaZkbCBa8mHYRm6aPTvYtl
         6kkDzuUtLq9my2EJnaDnoF/0PyshrMdwEhmQ9C+jWIRVhCSAhY5tEG/OfqLUJ+HjjQPM
         /fNiZUUK1HRedq6RYs9Pjq6EKVMJXNF1T0r6VNA1V7KKAZutRcayLaxTk1lv0xlpcmUY
         vkIa6OCUPRuMAUQLIyRiQIxBXdD3ql6SvKWEWjri5HfxvWELIzcYl/TM6WxmDU/0BtcP
         s2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uM7iGhfnoUeI1t0IUaH+Vl0pOebgnmrqgW4IescHko=;
        b=ZL/eTSL6EMLYe+mDUEhY5SOBaV021p4wslR5ElRDzJyhWKnu1rWgGEH6o1vRBEdUkY
         tnAdVGyJ/dXEql1QXZxmZqoiIEA7I7zIXIKK3i5qn+nxs3V+LR1h7c6UBw5hpv7Yx/Gm
         6H+Wa41v+wpCOQcO+P/LnBLH+uZDD4A/OSrQB/EHY7o2jyXHA8AhHLfT56opkS8EGLGb
         SLS51DQKXihaccMGKK8DiMnf8IWQ+aMBeCxz8PCIpJUPmrhO+c9lSREXZHxx6ySGIWUN
         8GRqf31acK7Sn1w3lPQk/Z0CX6yAEV9lo/kKxgYWWNLzyrx9X2zo2UVjcm3RfKVGDxH7
         L2HA==
X-Gm-Message-State: AOAM533AmTLMD/iyUOvRLPgTJDOiokw/x/6nd7BjiTGnlQ0zH7HY8gfb
        uA7CJuEcyJi9xzj4rLdiu6Oj7g==
X-Google-Smtp-Source: ABdhPJxljTO3Qf3zp+sZkqxd4q6BMw4nfs2iDB2ViVZwrMwjGf1770lvI8Ep6TC0EFBI/13mBrcNVg==
X-Received: by 2002:a05:620a:16ab:: with SMTP id s11mr2477523qkj.106.1613060675829;
        Thu, 11 Feb 2021 08:24:35 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:35 -0800 (PST)
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
Subject: [PATCH v10 04/14] mm/gup: check for isolation errors
Date:   Thu, 11 Feb 2021 11:24:17 -0500
Message-Id: <20210211162427.618913-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is still possible that we pin movable CMA pages if there are isolation
errors and cma_page_list stays empty when we check again.

Check for isolation errors, and return success only when there are no
isolation errors, and cma_page_list is empty after checking.

Because isolation errors are transient, we retry indefinitely.

Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 60 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index eb8c39953d53..b1f6d56182b3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1547,8 +1547,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					struct vm_area_struct **vmas,
 					unsigned int gup_flags)
 {
-	unsigned long i;
-	bool drain_allow = true;
+	unsigned long i, isolation_error_count;
+	bool drain_allow;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
 	struct page *prev_head, *head;
@@ -1559,6 +1559,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 
 check_again:
 	prev_head = NULL;
+	isolation_error_count = 0;
+	drain_allow = true;
 	for (i = 0; i < nr_pages; i++) {
 		head = compound_head(pages[i]);
 		if (head == prev_head)
@@ -1570,25 +1572,35 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 		 * of the CMA zone if possible.
 		 */
 		if (is_migrate_cma_page(head)) {
-			if (PageHuge(head))
-				isolate_huge_page(head, &cma_page_list);
-			else {
+			if (PageHuge(head)) {
+				if (!isolate_huge_page(head, &cma_page_list))
+					isolation_error_count++;
+			} else {
 				if (!PageLRU(head) && drain_allow) {
 					lru_add_drain_all();
 					drain_allow = false;
 				}
 
-				if (!isolate_lru_page(head)) {
-					list_add_tail(&head->lru, &cma_page_list);
-					mod_node_page_state(page_pgdat(head),
-							    NR_ISOLATED_ANON +
-							    page_is_file_lru(head),
-							    thp_nr_pages(head));
+				if (isolate_lru_page(head)) {
+					isolation_error_count++;
+					continue;
 				}
+				list_add_tail(&head->lru, &cma_page_list);
+				mod_node_page_state(page_pgdat(head),
+						    NR_ISOLATED_ANON +
+						    page_is_file_lru(head),
+						    thp_nr_pages(head));
 			}
 		}
 	}
 
+	/*
+	 * If list is empty, and no isolation errors, means that all pages are
+	 * in the correct zone.
+	 */
+	if (list_empty(&cma_page_list) && !isolation_error_count)
+		return ret;
+
 	if (!list_empty(&cma_page_list)) {
 		/*
 		 * drop the above get_user_pages reference.
@@ -1608,23 +1620,19 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			return ret > 0 ? -ENOMEM : ret;
 		}
 
-		/*
-		 * We did migrate all the pages, Try to get the page references
-		 * again migrating any new CMA pages which we failed to isolate
-		 * earlier.
-		 */
-		ret = __get_user_pages_locked(mm, start, nr_pages,
-						   pages, vmas, NULL,
-						   gup_flags);
-
-		if (ret > 0) {
-			nr_pages = ret;
-			drain_allow = true;
-			goto check_again;
-		}
+		/* We unpinned pages before migration, pin them again */
+		ret = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					      NULL, gup_flags);
+		if (ret <= 0)
+			return ret;
+		nr_pages = ret;
 	}
 
-	return ret;
+	/*
+	 * check again because pages were unpinned, and we also might have
+	 * had isolation errors and need more pages to migrate.
+	 */
+	goto check_again;
 }
 #else
 static long check_and_migrate_cma_pages(struct mm_struct *mm,
-- 
2.25.1

