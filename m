Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842FF2FFB56
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbhAVDn6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbhAVDjd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:39:33 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F503C061355
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:01 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 143so3968719qke.10
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BhWP1P8Q7i9lD0EGpT6UypXh912bl/nwbH5yu3+aADs=;
        b=QQ8+VWijc/yAWwdAGJiQAVGLSbr2QH6gQ7nJa0fZ29rqha6kVEV4Tn1Wn/RF+EF0N2
         ia7uZK/DGFoMKCqy8hMwTwjULmLMiVTu8+/u9vHIAG5QdyYOeLY04RyS+hFRmfWGGpWB
         kv8RX6M8Dwx0UotH3Laxo94jaM8AYDSrRw379UkUmBC2yGNT7za2V2mVhPEKCQvIZrCR
         82eSdwcQrY+yzusg6u7PVzqBY+kaTDsy8HsUMIH84qMEFHCdth103OK5ng25OVdNZKCc
         wQFaZsHPIjZngIiprFp2d/HogCh02iivfg3T80DvVqsLYuI2bjP3WTwpL+p4NKjlX6Xc
         NY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhWP1P8Q7i9lD0EGpT6UypXh912bl/nwbH5yu3+aADs=;
        b=h/LE/MxB7vvmjGhsJvi2Mxuba6gXqMENzOw8wgFpPUP6rLOSvXZ71Q9Yl/PnC0wofg
         oc2k05r/PMpqcc3cuN2bs5ZD/AszpYDgc2ZusN4ZWhZ8km+cSmjQhSBtisC/3v84j72p
         Om0mFEmFox2V3MMs3Y1I8TLRMUbsBvQvbby9pY6hhBF2hYVuIVKTe8VsOILlpfDZdaZ+
         6hiNu1AqF7HCTXh7gfMxA1LWc07q89mDRX74mvzsHrq8f/qUBfknRI3Yvtaqf2QgbKb7
         Yl/AYFGvYLeoxvErY+geOquAf1Os2jpfWyEaErYim7q+2KboxCWYknbYkzR/G3du7Z02
         OD6A==
X-Gm-Message-State: AOAM531q2sS4VvHw3cptVElOAUq6SnWQM97JZvIfvmCZHRAyi5j3/oj/
        rmdH9nnpGPgIVPYiIetIEOWp7g==
X-Google-Smtp-Source: ABdhPJxJ7MxgQzJjGlvCgCXRTmo+0vyGi0SRsSyNOon5zLKQWhZZVvEGOfk+yAAx4jKG8i3uKLqxQA==
X-Received: by 2002:ae9:c013:: with SMTP id u19mr3041084qkk.59.1611286680459;
        Thu, 21 Jan 2021 19:38:00 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:37:59 -0800 (PST)
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
Subject: [PATCH v7 06/14] mm: apply per-task gfp constraints in fast path
Date:   Thu, 21 Jan 2021 22:37:40 -0500
Message-Id: <20210122033748.924330-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Function current_gfp_context() is called after fast path. However, soon we
will add more constraints which will also limit zones based on context.
Move this call into fast path, and apply the correct constraints for all
allocations.

Also update .reclaim_idx based on value returned by current_gfp_context()
because it soon will modify the allowed zones.

Note:
With this patch we will do one extra current->flags load during fast path,
but we already load current->flags in fast-path:

__alloc_pages_nodemask()
 prepare_alloc_pages()
  current_alloc_flags(gfp_mask, *alloc_flags);

Later, when we add the zone constrain logic to current_gfp_context() we
will be able to remove current->flags load from current_alloc_flags, and
therefore return fast-path to the current performance level.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f92d7c810953..c93e801a45e9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4981,6 +4981,13 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	}
 
 	gfp_mask &= gfp_allowed_mask;
+	/*
+	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
+	 * resp. GFP_NOIO which has to be inherited for all allocation requests
+	 * from a particular context which has been marked by
+	 * memalloc_no{fs,io}_{save,restore}.
+	 */
+	gfp_mask = current_gfp_context(gfp_mask);
 	alloc_mask = gfp_mask;
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
@@ -4996,13 +5003,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	if (likely(page))
 		goto out;
 
-	/*
-	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
-	 * resp. GFP_NOIO which has to be inherited for all allocation requests
-	 * from a particular context which has been marked by
-	 * memalloc_no{fs,io}_{save,restore}.
-	 */
-	alloc_mask = current_gfp_context(gfp_mask);
+	alloc_mask = gfp_mask;
 	ac.spread_dirty_pages = false;
 
 	/*
-- 
2.25.1

