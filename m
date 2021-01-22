Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28832FFB33
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbhAVDjS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbhAVDjQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:39:16 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5CFC06178A
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:37:54 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id j18so2075779qvu.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/BFgBC6QAZDKdqJwclIw/UFhagKoK9nwCvAO/0D2vSo=;
        b=kKgsB2CQMHOXl6l4NnSGe5x8rJ4GzuUTC3QLnAnOxmRV0udPKbmjL7p062AkZS+UCQ
         JcFrcD6L7/q73D/9wTk2YqO/vgoufj9Qa9bYBPIQoAu3t4yWiex9dJrxPnF4uDSSO2at
         r9kSbRoCXe+tdVibOB+fj048K9bjDmhsiqV7D96BW/Vzyq249oTbL9IcKkm5ob33YPoF
         2LzFnR+tc1D+48ee4eifMemr6sbdymyI2uThLeEqDMxj5NyQhiQ1bvUKK2eO4wJyYbJC
         LCUVZ1Ky9Cd0Q42m03lWChpT0eTIJtz/jqmfzggmxWTb5aeDoSMBTATbFpGytRbkLjCX
         rTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BFgBC6QAZDKdqJwclIw/UFhagKoK9nwCvAO/0D2vSo=;
        b=ZVprXmR/S+nlJVIB02Q8waGNrWX8RbB/IuSekmGspUHYak1Hzw7yZ+YzjZnLZ65FFS
         cwA7r5jl2DNMTmalHTubrO4S5N/cgVoIRyOPuAxHQMizi2+y1H8XjPIJ4m6WBUvZkLG1
         CIoYLwOLRhDw2LVGpoBMeRc2F873hoVByvQpXZokNdldE80wWjOm/fQufoC5dv/StU6c
         RAOYLerCodZMuMITQLb7efgduzuCp2kzHfRJgwLJuMcMwGEoHi1dPaNMVUq2xRWqts8W
         Vqrt53uczfgj3eLxnRT6Ojn1zrTWICP8B5xJYsaGuLdh9lZCx/i4zsghkKXA0xLtJ4HZ
         UrIg==
X-Gm-Message-State: AOAM530JvrON88k4P2uyVewGU/b0lFvwtP5QRJSpFJ/u19Os9f24O6sa
        AnGzLW0A34MP/DQbYFFTtR2w8w==
X-Google-Smtp-Source: ABdhPJxJMTjOenw+ATUsYhJ69O1yDrSPh4E8jsUEN0YT/PTJgh1bDXApROmgNCBkQbpkcliCDZ1x0Q==
X-Received: by 2002:a05:6214:4e2:: with SMTP id cl2mr2601023qvb.27.1611286673934;
        Thu, 21 Jan 2021 19:37:53 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:37:53 -0800 (PST)
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
Subject: [PATCH v7 02/14] mm/gup: check every subpage of a compound page during isolation
Date:   Thu, 21 Jan 2021 22:37:36 -0500
Message-Id: <20210122033748.924330-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When pages are isolated in check_and_migrate_movable_pages() we skip
compound number of pages at a time. However, as Jason noted, it is
not necessary correct that pages[i] corresponds to the pages that
we skipped. This is because it is possible that the addresses in
this range had split_huge_pmd()/split_huge_pud(), and these functions
do not update the compound page metadata.

The problem can be reproduced if something like this occurs:

1. User faulted huge pages.
2. split_huge_pmd() was called for some reason
3. User has unmapped some sub-pages in the range
4. User tries to longterm pin the addresses.

The resulting pages[i] might end-up having pages which are not compound
size page aligned.

Fixes: aa712399c1e8 ("mm/gup: speed up check_and_migrate_cma_pages() on huge page")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 24f25b1e9103..16f10d5a9eb6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1556,26 +1556,23 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					unsigned int gup_flags)
 {
 	unsigned long i;
-	unsigned long step;
 	bool drain_allow = true;
 	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
+	struct page *prev_head, *head;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-	for (i = 0; i < nr_pages;) {
-
-		struct page *head = compound_head(pages[i]);
-
-		/*
-		 * gup may start from a tail page. Advance step by the left
-		 * part.
-		 */
-		step = compound_nr(head) - (pages[i] - head);
+	prev_head = NULL;
+	for (i = 0; i < nr_pages; i++) {
+		head = compound_head(pages[i]);
+		if (head == prev_head)
+			continue;
+		prev_head = head;
 		/*
 		 * If we get a page from the CMA zone, since we are going to
 		 * be pinning these entries, we might as well move them out
@@ -1599,8 +1596,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 				}
 			}
 		}
-
-		i += step;
 	}
 
 	if (!list_empty(&cma_page_list)) {
-- 
2.25.1

