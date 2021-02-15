Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9EA31BED0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhBOQSu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 11:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhBOQPv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 11:15:51 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2B5C061797
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:55 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id c25so3350988qvb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wbKChk2S6INWVHujUhFrYBg8HdmXN2ULiFT8EAgmMTM=;
        b=jVWwBWAt+XJBmDPeGDR7OktAAl46lGJUU9XsLgPbd0vvVehIA+qph4Nxq3xseZ+5p+
         HkyL7jClveN4M3Ei8sP0yLwv+XSjchVVqsOjvfhPnX476cryjhVA8QEOi3CknsvicSdr
         w/JPlXf7S0RnG+oiq2Rpb0pZGaO4unwHVWXtrMr7NcROg534k4pesxPm1Vf9MMK/hjsp
         cFlotnbr1SE5GTxv/zLCJaZmxwkL3iPquTz3znjxKGVknfOeFyktYXDF32zdHOAab6fB
         kXeemFTdekLeujeT26xJf2ktxwoEAvtLdQ8bXcCfskdR0jVXjbZtCXLsLX/aJK6rLn5P
         9hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbKChk2S6INWVHujUhFrYBg8HdmXN2ULiFT8EAgmMTM=;
        b=tgh5mEjBk96SBcZlXssBICfBUDNZXD4OkPa7lJynM8eCWO3gVklrhc4CcAjH2L26bL
         /cHhRuNZHgaGVuvPRhB/W6QF1XHz98RiD8d0hs9EAbz2jr73EYnspw0B1jN6u9Ldaqu7
         NEujBncya2PSqpu9Wp+uKNnyfQzfKMLfAc+l96U43xcJT2oGHNinfwuLlsznGDOy6VNr
         5Keb2IF+PhbAS4mxHM77dUW7KP74B6m1g0uLgh4St8BaAiEmFiGbsXpRMIYtj9zT7yAN
         te3XTEgcv00AsofK4zS0OduISHHQ5NF8J2jObj1DOmafwQOcGFu/cfBzPc61z+AvzE9M
         260g==
X-Gm-Message-State: AOAM5303FO897CyrKaKfD5alXie5WydocBIrAgyuQufzMCvFIq+XEVfJ
        JkBauk59+xsGtI5qu6jkK8K69A==
X-Google-Smtp-Source: ABdhPJxlq253kavqQUAIWhTMqplKiGCG184qHWdu/ph3bS8U0nsZsvorlETMdgWLFMhxvFrAmN9pNw==
X-Received: by 2002:a0c:aa44:: with SMTP id e4mr12595374qvb.49.1613405634747;
        Mon, 15 Feb 2021 08:13:54 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:13:54 -0800 (PST)
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
Subject: [PATCH v11 02/14] mm/gup: check every subpage of a compound page during isolation
Date:   Mon, 15 Feb 2021 11:13:37 -0500
Message-Id: <20210215161349.246722-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
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
index df92170e3730..11ca49f3f11d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1549,26 +1549,23 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1592,8 +1589,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 				}
 			}
 		}
-
-		i += step;
 	}
 
 	if (!list_empty(&cma_page_list)) {
-- 
2.25.1

