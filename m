Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E92318FEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 17:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhBKQ1k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 11:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhBKQZR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 11:25:17 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C73C0617A9
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:35 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h8so5703630qkk.6
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3YGhOpgTUnoFUZs688fDjhyQOugw+M5mTwB+lsQcb5I=;
        b=o+yT0iXdBFV800Ng44S1WVngLnEx6WCic9zMtJB1wm+4xQZGNvyzm0ZeSKiPypriL4
         ptcoRie3RdwdjYq0uvrNJwyokXgKEX8YRuGP9uTqpW5Df6MWRCoGllBnhdbj9nKOKZXI
         Z3FTCPmgWAHnIj6UdHe1V1prDVaBUwkVEUIIkJXxchk9pzM88eOuB3dvd7xXGroMcAc6
         UoPJ9r/E01wdE4SC/gUyYf+SyYX8Ii1zA9TxCEQex9T7P+5xmjLqQfqlyz50BpY1pjkn
         L2ktEgolhpYdlvz4IWMmPpLnV7SHaPwC8KVAvS4dgpqXP4pGXntiAE6vPYuvudxqeZUo
         0JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YGhOpgTUnoFUZs688fDjhyQOugw+M5mTwB+lsQcb5I=;
        b=Pf9Edjlg8ZA/yewHnkHpkOCB6xhEbpXq32/b3rCsuYObG/loXEEUO7k6L+0ZcH0tej
         XoLAuKyzimUJTd7CLtcAnwc5j+tCCAlIWmP9n52lBoMlE+RGeqBiQmyhNAYtzH2VwDxz
         ZCvdwxZ2gEkHEtQob6MCW6+VxtQIjVVcpoHUH2m6m8N1lnD0/VDOLJXC1Nu2NgjtOTJd
         SEN6A5xYO+jVa1yb/qP+fPidje7yZTE91AXWu96jxiE31MD+w5RVqaMYY4zQuRO8b2/8
         vllYlo+gipjgKjgNYYW4ggwt4AIn0gTxKXpb+NQn69REV7mZ8+TROIGBES0GbezXebSf
         HFbA==
X-Gm-Message-State: AOAM5301l5mNi52Ti3k2E2Uxe1r2ra2iykJMSVp4e5kFR4QoBz3ce6rl
        guTikMBUyzDHiYo74cSPXmzogA==
X-Google-Smtp-Source: ABdhPJwnKajWFyfDuBVS+SGOOtyiqDkHprT6U4jwJWb/Dszw7JzrRM/J6ktUBAouVL19l73ROOoTFg==
X-Received: by 2002:a05:620a:13ae:: with SMTP id m14mr8944398qki.35.1613060674348;
        Thu, 11 Feb 2021 08:24:34 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:33 -0800 (PST)
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
Subject: [PATCH v10 03/14] mm/gup: return an error on migration failure
Date:   Thu, 11 Feb 2021 11:24:16 -0500
Message-Id: <20210211162427.618913-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
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
index 1f73cbf7fb37..eb8c39953d53 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1549,7 +1549,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 {
 	unsigned long i;
 	bool drain_allow = true;
-	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
 	struct page *prev_head, *head;
@@ -1600,17 +1599,15 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1620,7 +1617,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 						   pages, vmas, NULL,
 						   gup_flags);
 
-		if ((ret > 0) && migrate_allow) {
+		if (ret > 0) {
 			nr_pages = ret;
 			drain_allow = true;
 			goto check_again;
-- 
2.25.1

