Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACEA2FAFA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 05:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbhASEpA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 23:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732171AbhASElK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 23:41:10 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C050C061793
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:28 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d14so20742767qkc.13
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ytfD2jv9LpK9OyoWxdpQ8h2mx1T2vBI4HkZM2c9/uoU=;
        b=WI9StvdGxJtwVct6bWEQzgVAdDtxsdP38appW1O1jD8gW37Wd7ooWvrKFtUmMMwH0w
         5u2SvSTQafWmIdEwz4t0RRQ/iIX/DTuvcvsdR8J7ddzeLt2dn14zs49pkpLqddLpMKCP
         vJei4rkonnLjn5bc0xcgML+mLHZwTPO5W64qBaTast6FpCnjl0sPa5wb+Q+zAE7h7yN/
         BdKIl57CPOE/pkLwAZpAQeNPkc7JGDjRcR063jHoNpbD2moaDFihEMcKySLZZak/1e/Q
         4SIvCIGrE0xJs6uECf+dYDfouM6EazJ4t48SllQr0kjm39TZ55z5PDHsVXmXURK7rVIc
         /nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytfD2jv9LpK9OyoWxdpQ8h2mx1T2vBI4HkZM2c9/uoU=;
        b=BKnavAxsTXg377x+j6Q2r3VZF7lBl3aw5B+EPW9tmAvnUx0c00+jMxl7p/ko32dGKG
         YIObNaBShJhaYUSZskbidkUDFDTSS96Y2RT0BJEXs1j0w3bN2HiUEuD9MW5vrKlKev+Q
         DjOPIK5yvRwDRVrGXENEH/hTKGPRBhqTzeuoBrCbxGQ5ChHwTvgI3DTVfcWHUXB4cFW6
         im/DUqgyKyg1/rUALtdBTqiix3qBV92bALs9K5elQzqblVyW6rgI4mHICeEI7zWJcEJ+
         BdtJcGGvg82KcibLbfsDkXqmrM548wlFSe6+GN0YRxc0R4IzUb3MATtBQ4jCXVufV5vF
         J8iA==
X-Gm-Message-State: AOAM531vuesDiHT2txbd+1MLTPf4JgwTqak69qfoRTL+TqcW8Q7p2mq8
        UZbsMcPAqMXvJl3ZMVnKRGCfXg==
X-Google-Smtp-Source: ABdhPJy0zYNFSWy0LJjDibtg2Y6RNr75+8j75MGHeKJmvP2Y6khyzQB5/ILqXdXtET6yi/4SJGrBdg==
X-Received: by 2002:a05:620a:74e:: with SMTP id i14mr2794988qki.99.1611031167446;
        Mon, 18 Jan 2021 20:39:27 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z20sm11934536qkz.37.2021.01.18.20.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 20:39:26 -0800 (PST)
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
Subject: [PATCH v5 03/14] mm/gup: return an error on migration failure
Date:   Mon, 18 Jan 2021 23:39:09 -0500
Message-Id: <20210119043920.155044-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119043920.155044-1-pasha.tatashin@soleen.com>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When migration failure occurs, we still pin pages, which means
that we may pin CMA movable pages which should never be the case.

Instead return an error without pinning pages when migration failure
happens.

No need to retry migrating, because migrate_pages() already retries
10 times.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/gup.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 16f10d5a9eb6..88ce41f41543 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1557,7 +1557,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 {
 	unsigned long i;
 	bool drain_allow = true;
-	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
 	struct page *prev_head, *head;
@@ -1608,17 +1607,15 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			for (i = 0; i < nr_pages; i++)
 				put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
-			/*
-			 * some of the pages failed migration. Do get_user_pages
-			 * without migration.
-			 */
-			migrate_allow = false;
-
+		ret = migrate_pages(&cma_page_list, alloc_migration_target,
+				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+				    MR_CONTIG_RANGE);
+		if (ret) {
 			if (!list_empty(&cma_page_list))
 				putback_movable_pages(&cma_page_list);
+			return ret > 0 ? -ENOMEM : ret;
 		}
+
 		/*
 		 * We did migrate all the pages, Try to get the page references
 		 * again migrating any new CMA pages which we failed to isolate
@@ -1628,7 +1625,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 						   pages, vmas, NULL,
 						   gup_flags);
 
-		if ((ret > 0) && migrate_allow) {
+		if (ret > 0) {
 			nr_pages = ret;
 			drain_allow = true;
 			goto check_again;
-- 
2.25.1

