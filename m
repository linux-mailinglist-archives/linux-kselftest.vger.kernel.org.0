Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1230ABD3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 16:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhBAPpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 10:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhBAPjx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 10:39:53 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B325FC061794
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Feb 2021 07:38:35 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id t63so16610346qkc.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Feb 2021 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gHgQfTRvar1lIU9rNG4Q491ak9Bif38ih9mdt5Czeeg=;
        b=GC0toNm7BcOudNaj/YC9Axvt6fvOsNdbAgmE+JWdR4Yqwzf8ZdFKCSD1pQp2UfohPX
         r8MUgPpT6yf730PLmk6gqtmgfXJLOK76d5rXXg1ZQPkAFLKtPfHnJfgRoc3jcePAJ4dp
         t/KLt/MRx0UeJYXqOCsCs/zQ2HiuDGgXv9WrpGiMYf2Nnhn0I9kBeJ08PAxtZaWI/DZ2
         FKOezf6LfwHVxcsKl0XZJ9sARneq2SogUqa3oQQKOg4MvKr8H6ZCZwM55OFzBePS4PMj
         f4m1JsPU1WuDnzrsay1xk5cXQ61jqWJKq7Boc9vkZgTnRAMZ9YKN0SbWk46CXMB0B4u9
         tDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHgQfTRvar1lIU9rNG4Q491ak9Bif38ih9mdt5Czeeg=;
        b=cAG4k7lr8s66CfR+jOiYPUkhlnCJTwdbOGoHOETA9lGSfA9iHwjHfuiKfRNLz1bI4d
         mPhpPI9lxjOHrY+Z4fk42FC1SdpCKI3MNsg8Iv6LUhIqwhr9SMShxEuZ9/ujC9/AWkJB
         9aVUBRi14jqKANswWxx1SGity+ct6VqnvYdomzfm6nQFIrQ3lTNZof3LURDCo3hhse5y
         igJ7dPv0Cwcf69ZTnjZXncx7NpUBaeVGAI91F7oCFuIMNiF65U934baPKTWJC7S0eb2H
         yItpf5PMsLyMbXgKWJ4tjVrFRBAPntYM5RSTG2ujKUK8QXM58TBXncdmfL7AAurqSVKp
         YjAg==
X-Gm-Message-State: AOAM532CKwWAcflSjnl3mZLxFP6L+fUKVbghy8aAymb8jOTIgO4lkdqO
        ZQ2z4GP/UYiBaJnLSZxdShVJQQ==
X-Google-Smtp-Source: ABdhPJzYTS+4AOTbPpreXVUkljPmej3SQM2H6+2t7UJhXKvne6cS5DqT4JyjPRt9T7SRhMlU4kFuQw==
X-Received: by 2002:a37:6206:: with SMTP id w6mr16479068qkb.102.1612193914954;
        Mon, 01 Feb 2021 07:38:34 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 22sm14853307qke.123.2021.02.01.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:38:34 -0800 (PST)
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
Subject: [PATCH v9 03/14] mm/gup: return an error on migration failure
Date:   Mon,  1 Feb 2021 10:38:16 -0500
Message-Id: <20210201153827.444374-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201153827.444374-1-pasha.tatashin@soleen.com>
References: <20210201153827.444374-1-pasha.tatashin@soleen.com>
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

