Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF26319001
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 17:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhBKQaN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 11:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhBKQ1e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 11:27:34 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07E5C06121F
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:39 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id y10so2822799qvo.6
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xa5LKOQ1Wojb/IaKgusftf8SvQUt2A636ITgHJt77hY=;
        b=QuMd0RnE6BgQXcF3TU/Aalx/pmvifg1h/yIIuDlvMVxae+bBsx1tIWOo2WaZ9krtwN
         fzwP4tgytSbEzWBqWSdjgW0izkq03UyYoEWUH1UFzNCMKZdlh22w+Hi/LwcysQwRsH8d
         t4HqG0V43GGC9t3Xt4bkFAJ213Xomax14b4LXvog0yPZTfZ/OKboPp/Xeg6/Kylajuzu
         fSKsACaAug24h5RBBY+IUJ82X8CUm2PIa9FM6ueqnE80ENypy/COy+vhb+xEwL5uKDXA
         TZ3lgzSUg0fTa0NpaWWnAqOuA4zyqkceqtAj8xJ62n77e75A6x4ybcxMMKyJBkRCbOru
         MUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xa5LKOQ1Wojb/IaKgusftf8SvQUt2A636ITgHJt77hY=;
        b=lWIPs0kvjYTui1WrGxZios7gmrLYg9URwZFotXqO+aR57Bgb5UkNivCHrJKr8rc2Cu
         /159GpuezjCqfjPa9oP/wRJDLqA6Hd1dB5P4yzcWR6i5Oz1RbJlZS1CgBh762nHQi65+
         4bgh/XGbOsVPzDLb6mmYV/NZVd1ASVAbL5Pid5wbrTTo4VsWJPJRCu2cG9miei7vYoT8
         D7XZHCor22MvvUhdLqZaE5DUqaagrlTJgzH2oDB5TP9pC68A9RG/pDMxG+IUci5vgBNh
         mwjh3oKB572GJAu7/qqJvY2SqEOYCXuvwhfJL+EziP/LsMPJ0VoZNTZxfehs5OzsDjWu
         joHA==
X-Gm-Message-State: AOAM531TJqeyphYqYG3h7W9145oYJ1SiG4BXVdTYFkKYoqEdYxlHn0Cw
        9HutHCsIPfRxKLDEjmT7hRxngg==
X-Google-Smtp-Source: ABdhPJzfZ8RijkO/WVWPQGgo6D4s33Wh6di0PnL8JooWqRydoGyTSuS03HT4G0/PkO5wcC50Fs0DRQ==
X-Received: by 2002:a0c:c488:: with SMTP id u8mr8478946qvi.9.1613060679042;
        Thu, 11 Feb 2021 08:24:39 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:38 -0800 (PST)
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
Subject: [PATCH v10 06/14] mm: apply per-task gfp constraints in fast path
Date:   Thu, 11 Feb 2021 11:24:19 -0500
Message-Id: <20210211162427.618913-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
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
index c843dd64a74a..92f1741285c1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4982,6 +4982,13 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
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
@@ -4997,13 +5004,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
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

