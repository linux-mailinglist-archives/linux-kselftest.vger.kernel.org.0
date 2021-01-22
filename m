Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D187A2FFB31
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbhAVDjS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbhAVDjQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:39:16 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1870DC061788
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:37:53 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id et9so2056757qvb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=JPFxiIpXfQz7s+HD+h+h53MJjfdFcIIb3fRCeiOL2nLTb7mQbwL/mv5bD6YwNIDlb0
         BFY7g1NGuXse+LEq41ouEsNL2gXTOwPaiR5GQExaxMEhuAeRYuHEyPmcy3TPLbX47vVE
         LgK7fRS4bUQpOBiTm8HrFG94WE1pNF7hff5zWb4gSNw9ArUMMqrpPtxr2Hdd8IFn0nsq
         otWlRvxKtojA55dd+CCjH/0X0/bnDxm6K27wzxRWifoK79oGb/3CRBxDgjMBTWxfPRFa
         7uUcOuV7mfY5ILLAsCPM5yVmzUm+wvxNLL3fe7M9oDRQxMYtz25aXENgZkyKm7tT/eiJ
         TkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=sjYg2DhmCFMDEwc2N+DNkkywryD79OH8akLEdOuxxENxJTRQWAa8lhSRO8JZKvjvh+
         cH3ZRe1AJQOisZxnW79MepFEHa1FCHSRerETaYfx84qB1Q21Pd1rnW7L3AvXSllruLS5
         WU+5Q0ZsggZV5tMKBMHZ93ARAYLKs0A8HnwAbmTF8P5Sg3el3idNA60hQgE8qmm3JKBq
         CfFN67zjQj5s+c7KdUnLoquFmHdOS8QJu4fOY5QdMVxrXWClzYw3gsuKJpEc0Q6bv+Jm
         KThwAi1V4ererwctXMpQDtOtepw3zMmGNZeWRNXJd9m1CBZ7ARZJQBqUBiMgdA3U9auk
         YgBw==
X-Gm-Message-State: AOAM533uQYc0uQGdpcDwtlVVdNsC/UQzHR0TnbU4NBc8hl11Rhchp0Lc
        nvaCNvpKn2BJTKtz/ntACT5Vhg==
X-Google-Smtp-Source: ABdhPJwSGFYJhC+Qib8qDxE3HBrhAWAJcwGgvgnJ2/IXoY6+kFqDz947kH5LHEFg/lVWRPLyadzxDg==
X-Received: by 2002:ad4:4e09:: with SMTP id dl9mr2838296qvb.44.1611286672365;
        Thu, 21 Jan 2021 19:37:52 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:37:51 -0800 (PST)
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
Subject: [PATCH v7 01/14] mm/gup: don't pin migrated cma pages in movable zone
Date:   Thu, 21 Jan 2021 22:37:35 -0500
Message-Id: <20210122033748.924330-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order not to fragment CMA the pinned pages are migrated. However,
they are migrated to ZONE_MOVABLE, which also should not have pinned pages.

Remove __GFP_MOVABLE, so pages can be migrated to zones where pinning
is allowed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3e086b073624..24f25b1e9103 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1563,7 +1563,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-- 
2.25.1

