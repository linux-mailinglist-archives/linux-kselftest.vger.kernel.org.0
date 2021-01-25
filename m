Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7516302BFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbhAYTu0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 14:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbhAYTtf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 14:49:35 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBCCC06178C
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 11:47:59 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d85so13713933qkg.5
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 11:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gHgQfTRvar1lIU9rNG4Q491ak9Bif38ih9mdt5Czeeg=;
        b=c7sG1z0zx4IBwrpL9ujY99TSc8IAU20MGw/TaPpyT+YoiodG5nGIzUR/NTujP0u1kd
         Rn3irH637aV9Tmqlkhd1csC9dMvLFqE/l4J73pOWLHBaE3rnkGsjFAYCS75cZmh9X/Lt
         1TOlZeUR85/P6119/G1x0xgTxAB4RbFCyKLmQv712qp8Sftqrk4WSgdOJZ6OAba0d3o1
         ThrDl65vkoeoFfWW3zq4GYnGO2B/aFe1mVY6tV2v2QtEZtBJOicRcxRAsE6gZMKuRVhD
         YBiPHBxO83ut5cd4fxWVQPDYCMuccwOB2WH2d9CFF/jxKSQJLwOgPwjtb3L85cI7WFie
         N16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHgQfTRvar1lIU9rNG4Q491ak9Bif38ih9mdt5Czeeg=;
        b=f6w390931CIGCLsxSSuJZepIkGd1YLdo5p334CXdpP1J7T7xig46rAKTydJ7hyyrrM
         SE2DBQdGu9k1G+vb6jybf95W0lI+ArtH+1lVxq1HUCRpovFpp2JO7m8vxWxbZ5GiFz3g
         JHJEh7KBgRfgyk3IpfEwHNOzkNMRKybojKMInKNfFRRn//XMWcx+vag5GRsQNFDwzBU/
         zgU7x+02/KWSoB+9RBimRJDr23TPTsExW4GfiGU4+Vt6uaQKTAEuhPiSViiMU28EE/9h
         bEjF74TFO15+e2qDj3HvQOf2VvhrJinITlV8IAnnm4Sq1RCcVSfYjaLAqKSGZAU44Psc
         OcoQ==
X-Gm-Message-State: AOAM533WDa8Q4klQ82YNatTe2gCgT4L3YhcYAT+u+dUPXSUKZHOpqLAV
        BLvSqntZqiWICPfGg2nIKQ0w6A==
X-Google-Smtp-Source: ABdhPJz3Za/JbaLs+6ZSMuUuylAr92cCaBZaN+5myWkrAXEtJPMKFBUlfdcIgUMufV3m8N/ZNiYoqg==
X-Received: by 2002:a37:8703:: with SMTP id j3mr2422378qkd.455.1611604078581;
        Mon, 25 Jan 2021 11:47:58 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c12sm12121569qtq.76.2021.01.25.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:47:58 -0800 (PST)
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
Subject: [PATCH v8 03/14] mm/gup: return an error on migration failure
Date:   Mon, 25 Jan 2021 14:47:40 -0500
Message-Id: <20210125194751.1275316-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
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

