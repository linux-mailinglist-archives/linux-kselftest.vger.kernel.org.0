Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0AD31BED5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBOQS7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 11:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhBOQQS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 11:16:18 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11571C061356
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:57 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id q85so6795254qke.8
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kEb4+EO5FfWEwvtEEV/r+bfuAysDp0uLtQ9Vtb7+Mxs=;
        b=Mjvcn9gFUcCdc22/z/QIMuZAHqj9t0eazT33m6nDiWcsf9dC7b5/Cqunj984C77GCh
         +eDO+f4jZHaYmRkVNyiVvE/AZoCTRqAe6ySBISnRnba2iYwkDWhLwgkZr28MD45Z8sGw
         M+IdB3IPXQBNCXU+B1NJgQpPoEUGoJX07e04vdomEuoHxT0c1nrf30wE5WbEK4Ri2kQc
         VtN/WdklMkVYcoU59sdJbpIYt6mFZ42vKB5YQWdBrt02lFAgo40Rb8TMLf+rPUXDO8Wh
         l4hG1rXQtAGTiPNm3SxKtjXYQ9tx1s3SARXTmDHVP/vcvhonKigVIdiYFwfdvJQ1h1J0
         MRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEb4+EO5FfWEwvtEEV/r+bfuAysDp0uLtQ9Vtb7+Mxs=;
        b=KyV+jE6esGo+NAZ5tAznOyybaJoHX8FZAXJRW9RJ9g/W8mcGCOQYiiIUZLZbp+u+4F
         qFy8SXmkyp7/eX6uqQbwE/Jhs0CRhzsG6U428tUTjxPx4B66c3aAWMWci6qtjy2cZqfU
         pjOZZelahtIWCNw0Hk32kDO+yduLP4XgAt7CV/vcqtKOnZgR7VpDHnhsIUMxS5Uy7dfh
         0lgFiqsQlX3VOCC8pehSA+y2J8hdhbq3oNu0miFYI3mZjTIlFVxNLM07gAAFzQsKCFVa
         mCphTjCPWnfzVxkUciLpStOiqJR1lozX8m5FoTQAwmjcZ9N7207zF2aboknJplbuMMHA
         DVww==
X-Gm-Message-State: AOAM531hvkxxvpUcuAbe1DrDcaXJdgTYkzGanhGuiNCz/ZLLa9o46lrF
        Obh+80ZP8KXFlvmjr+QUIDt1OQ==
X-Google-Smtp-Source: ABdhPJx1c/toBBYCrfBwQhlcATPk9ySGYdcd3wSTS0lxHztOk2SDxHuOaSIOFMhw+gB/ecl0UXpyHw==
X-Received: by 2002:a37:8306:: with SMTP id f6mr15907605qkd.366.1613405636226;
        Mon, 15 Feb 2021 08:13:56 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:13:55 -0800 (PST)
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
Subject: [PATCH v11 03/14] mm/gup: return an error on migration failure
Date:   Mon, 15 Feb 2021 11:13:38 -0500
Message-Id: <20210215161349.246722-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 11ca49f3f11d..2d0292980b1d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1550,7 +1550,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 {
 	unsigned long i;
 	bool drain_allow = true;
-	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
 	struct page *prev_head, *head;
@@ -1601,17 +1600,15 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1621,7 +1618,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 						   pages, vmas, NULL,
 						   gup_flags);
 
-		if ((ret > 0) && migrate_allow) {
+		if (ret > 0) {
 			nr_pages = ret;
 			drain_allow = true;
 			goto check_again;
-- 
2.25.1

