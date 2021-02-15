Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F831BED4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhBOQSy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 11:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhBOQQS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 11:16:18 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C919C06121C
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:58 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id w19so6766479qki.13
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f2yaxZQFulou6CXYZ3Dw7hE1ZLU0SOFCh6rJiOJ1t1g=;
        b=huxQu44YdeJq8AfnoQUX0L6sLMffLXSxbCs3eJPdwBz8VmuwiTtLuZYmrqhBMZUylt
         RtLCdYhmTEjZWmC4RDlYGAC+Ht+U5vxeG1rj9a8lIasoA07PlVT1BcIXx3PH2y+EnLJz
         e4ycT2NMEUt6pMG6YaHFkl9SsC5Xn4w7w+7xp91FUqYt1zxafD7zpULlz8X8+NAO5V0I
         2BoRnH8kVsAH3mW7PD2ALL/FfokRTmee6k6GnCdZe+4r/xJyA16x90geS1nKbJ/Yzii9
         4ML4TUblhgS4Srbk7+/sMGlvNIi3AC7kXkYB9sn5ZzYA4nxzZ4TgMlaXDdO5YP0rlDax
         CYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2yaxZQFulou6CXYZ3Dw7hE1ZLU0SOFCh6rJiOJ1t1g=;
        b=Q28ZpasRUpSP8hEs90asshG4U7cGc73osNa6JFoJJKYGifaOjxaYBLQgy0l4hmkL/E
         zePGS/c5ZYoFNVJOj+RwqcdLYcv3sruX7RxN2XNkZM8TZygwHGWnDnbQKfWWzD//gKmV
         hMp5WKr8t/J8hsyeXs9LCape8xZ+7hUzv+7fmXc/aXYqTiF4uZte5jXKiWv2rCS+JkUF
         THPHDgqkxlDTDrxYQaFIchyDKm0dxJ/6DGgX9Ld5x5AaZY73uKNMMU+GyoyJyuwMpX+j
         hIiA8JnbU1n/zHGLmQmuobPbBIa8oaQ76/jpXnma1lmpkKeJJZTq+vwcJSbvU9J4s2t0
         Rr0A==
X-Gm-Message-State: AOAM533crAVB8ghuu9C1FpGWf2XPs5Di4ieVc4lmGyPFVcvGHb/q3RCp
        zeXxN6ukT3dVrKZnguWlWmR0JA==
X-Google-Smtp-Source: ABdhPJxs/cbAD2q2t+15v4vU1Bf5/Gv19mJh9/gffWmoB3jXHCcVkC0JHrtMhrXok+OOHS2N6Obw5A==
X-Received: by 2002:a37:4643:: with SMTP id t64mr5123409qka.344.1613405637737;
        Mon, 15 Feb 2021 08:13:57 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:13:57 -0800 (PST)
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
Subject: [PATCH v11 04/14] mm/gup: check for isolation errors
Date:   Mon, 15 Feb 2021 11:13:39 -0500
Message-Id: <20210215161349.246722-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
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
index 2d0292980b1d..be57836ba90f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1548,8 +1548,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1560,6 +1560,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 
 check_again:
 	prev_head = NULL;
+	isolation_error_count = 0;
+	drain_allow = true;
 	for (i = 0; i < nr_pages; i++) {
 		head = compound_head(pages[i]);
 		if (head == prev_head)
@@ -1571,25 +1573,35 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1609,23 +1621,19 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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

