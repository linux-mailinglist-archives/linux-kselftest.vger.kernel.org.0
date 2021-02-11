Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423DF318FE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhBKQ1f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 11:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhBKQZO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 11:25:14 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63296C061793
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:33 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id s77so5709484qke.4
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LL91sOR6eNdLBKKX+cwP2EUL4T0OiDJ4l8AEtucy7F0=;
        b=Cu6OHd4IUjAcSplCwvpYfXX30K5w7v6nYpY1ArywdPsTP+EXS6Oaiocsonki3raoXR
         SLxlbJk5ql00SZPeoI3Tl2LzMaXU1I5Cquh/q5MCHSMzr8UDfoCLn0igPWuGMbHc6ckR
         /GXj7V2jbEsnNl8OtcHyY80k3q6kHFSgEpAWWE3hnTxUPdV7hKwxqU0vPufG77ip5IeD
         1nvTBp2ZkabycEZ954AkMsimOJGZPux+lDVJKPXX9/1i6MxZrhfky6eJVJZiVQ2kb1qN
         u7xl4XzcGzgfKDZdwz6mF1NZca6lQca5gq1Kcfnh16KgeVBRwLxlSWbyGeLTQgvMjshv
         5t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LL91sOR6eNdLBKKX+cwP2EUL4T0OiDJ4l8AEtucy7F0=;
        b=n6KsHcl5zSB2d7MYtAq3OhW9GCawdkpQrrHBPlXOUgEQFYi3AgZJkBny6kSL+L7g5K
         W0LKf8zUhVQ7voYX3PjN0xnxHAvrGxLMFtNiDKSmeP8C5rZkZOAKsoYdDC979P5BWcdl
         hfcKD1sogf1bDDt1bNnoOLpIiariwhWMvACIXYdhpiDyXu2rzZlkK77c8EuTsNjkYdaS
         8tyjlc71tToaASAxYq4WCKfUMTvi8FGKtYYYAU4lUoMZ/N+BPcZ4nF5OyTvwSyMQ7s1t
         dCAzssoufgOeobS2Zy+bhmaymDRg5NAn6e/EFIK2D5zGmlbrsI3QNTulQSjFxCV1HEKO
         D1CQ==
X-Gm-Message-State: AOAM5303IdhSE5uZe0XMKvlqdJnAz5V/ar1B4NE6gH4srRdEZoTRMlXz
        TH4UFYs3L9f5eEBORfROG3BdtA==
X-Google-Smtp-Source: ABdhPJwOvjkc4WjRekXFLBt/hqaYUExG2N08qrgzJfAlZ/EDH7efpQkM+/m48smbKkvu5kmAAyDM8A==
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr8596059qko.213.1613060672602;
        Thu, 11 Feb 2021 08:24:32 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:32 -0800 (PST)
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
Subject: [PATCH v10 02/14] mm/gup: check every subpage of a compound page during isolation
Date:   Thu, 11 Feb 2021 11:24:15 -0500
Message-Id: <20210211162427.618913-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
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
index 88441de65e34..1f73cbf7fb37 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1548,26 +1548,23 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1591,8 +1588,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 				}
 			}
 		}
-
-		i += step;
 	}
 
 	if (!list_empty(&cma_page_list)) {
-- 
2.25.1

