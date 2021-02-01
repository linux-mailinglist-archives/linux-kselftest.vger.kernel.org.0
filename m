Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58F330ABA0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 16:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhBAPjz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 10:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhBAPjw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 10:39:52 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E34C06178A
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Feb 2021 07:38:34 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id j13so8279861qvu.10
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Feb 2021 07:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/BFgBC6QAZDKdqJwclIw/UFhagKoK9nwCvAO/0D2vSo=;
        b=JQR2l5q2FxTXJmHbPFSlNGtyZOup8fe3+a/Jd1O4t6lh9Agl1DDavVvAYV0PKCw8aE
         dT+2hLR/1yP4EA97ca5wit4g02UZdNZU6NYa7CZjnsrOFaQ8tY5bu/ZXNnm/f/Cn+yg2
         xwTcRozwmj6g31VhQsy1n9qKLpBlAwyVHpnwVBKm77KNgfWOm6xJjIpTbfUIBzTEDHY4
         YbOD7x8G/8MxBhG4ubKzQuDtDymfPOtB+gUJV0IA55CXBwqW81Nm8OMSeQM/3TJ3HLOM
         q4GsqlbxPCUlBOCHwyVGHyWbq1327tlwOXN46Bh0/Ae+SNdkrzpwXue8BjcZMF5aIcix
         K78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BFgBC6QAZDKdqJwclIw/UFhagKoK9nwCvAO/0D2vSo=;
        b=MeugkllOXz3PJgF14/tOpbhEtMBSYWnI8OfIvYKYVvdPh4AWlalHwgOEPW9dPBeoZ4
         KMxlhE8/PSpOYrQMSpkdD7KZkCnMhPaNOi8esq8al3KoEdTh8L2P/nxOasQVi78EH8GF
         tsj4ELXxpaOpSofEhrfdnLOPTYGrctoW65QB33kdvnlG3ykb46YGUWeLK64WAHbInVbw
         fZ9Vv6XuXLSlyAgBN06lwwbhT3Up8qSup641cYSXGAGcWY0WITSIqf29ejQEAOABiEkM
         moe1chYxiD5bQFfeNQQtQDB3em+fjHMvuZIdEIeo6rO6kTjvmeNGjmvk6bMHOgrB1q6H
         DiVg==
X-Gm-Message-State: AOAM532RpRYxPc439pyHe00mViLggZu9svJU0o3W/+t8GVCTuvc9vBgw
        IzOQKrLuxmaRLgItLLKgy69IaQ==
X-Google-Smtp-Source: ABdhPJzkIYa3T6/uQYHSoedmQ+YQr5pq7dhFvGtlP5lG7RzeiWLX+FQTg7qYdxso34nsemW0sghkXQ==
X-Received: by 2002:a0c:b929:: with SMTP id u41mr15864576qvf.30.1612193913267;
        Mon, 01 Feb 2021 07:38:33 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 22sm14853307qke.123.2021.02.01.07.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:38:32 -0800 (PST)
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
Subject: [PATCH v9 02/14] mm/gup: check every subpage of a compound page during isolation
Date:   Mon,  1 Feb 2021 10:38:15 -0500
Message-Id: <20210201153827.444374-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201153827.444374-1-pasha.tatashin@soleen.com>
References: <20210201153827.444374-1-pasha.tatashin@soleen.com>
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

