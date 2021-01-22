Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459042FFB34
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbhAVDjX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbhAVDjS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:39:18 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93BBC0617A7
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:37:57 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id et9so2056816qvb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g2firNhV/7kB7YU7cH9BNSgXaQWIxvW5HlS98FNnYEs=;
        b=LLz3F3lxw4IkMEwA5odpdMEc0+L74Y5BQjYoh3itMT8zF0T8nt2cX5yVqwKFLKxa0W
         Hy8lM6tnCH/B1NsQyqxdl24SgHQ42a4I76ttnieERwV2PW2MqeJCOtyc4KIqRjU6lGHK
         GGCsZkcOwq7l8jHp5BTX+W9gtRNEn+qzx3UgkwWxo/LojYJFz0yjk8GTq8l+QcncUK93
         DPWUG589Wi0Lpzh2/CsK50lcRndUrrG3vyEdxlO89cRzGjiTxYnUMjKVJLqvy7bSTqRn
         fDS9hrN03Aq4l5FG+Zr2Mk8qlLE8+ZphQRorp4Ac6GsjnjhgslXkULA8EIN11ITX9oFc
         hckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2firNhV/7kB7YU7cH9BNSgXaQWIxvW5HlS98FNnYEs=;
        b=SQ+ou7QaDZdXAc2FxN3n7sKJ/Sqi4B6lVy+6dq/0+TVmr1JMg1+LDqgwwaq7/Zxx3i
         iCee8ymZJkdJ4s1JM+K4i4Yqu1nOU3b09DzL3WLclOlkHKbXBG/dW9S7bNoTvAAh4I34
         0YzhD/Eu+UKJsKvltZi05hvTU4eyrOt+OS0kJsUZEiAyTOaYLyMxAm24fvreF5eeEdoG
         8mTPvKvSN6kIisu/WcGtRldVd27Mfi+nv2YTPg6EzO1qbyJilOrWUWcAWBtVtfYHgbqQ
         abVhBB6Gj0/z6Nr25qhyhbJMardvh3niRtRV/n3jmNqebGLWnha1zJ9kKMbyp4A/TYd3
         PxmA==
X-Gm-Message-State: AOAM530puszl67RgF+pH1Heiye9DfFLLKGiAh9/Ht1aIYBOSgVyRWk6X
        M4gMJ/VJKGbi3xSpZ37o51b2tm2BuIB1Jg==
X-Google-Smtp-Source: ABdhPJzhknY4xL3IJfFb7/Bh9fd7QoMOLZQzUU8SOEXRCk8tnGMA4I/AOATMMwkdh5C0pgpCzdWEkQ==
X-Received: by 2002:a0c:8203:: with SMTP id h3mr2687151qva.0.1611286677248;
        Thu, 21 Jan 2021 19:37:57 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:37:56 -0800 (PST)
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
Subject: [PATCH v7 04/14] mm/gup: check for isolation errors
Date:   Thu, 21 Jan 2021 22:37:38 -0500
Message-Id: <20210122033748.924330-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
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
index 88ce41f41543..7ecca2d66dff 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1555,8 +1555,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1567,6 +1567,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 
 check_again:
 	prev_head = NULL;
+	isolation_error_count = 0;
+	drain_allow = true;
 	for (i = 0; i < nr_pages; i++) {
 		head = compound_head(pages[i]);
 		if (head == prev_head)
@@ -1578,25 +1580,35 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1616,23 +1628,19 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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

