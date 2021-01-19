Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595472FAFA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 05:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbhASEof (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 23:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732156AbhASElH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 23:41:07 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BACAC0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:25 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e15so12884813qte.9
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=ZQ4ChHtFQ1Vui0TZTK+8qlnkMNj4cYxEi09An18mRL7rTEhJB77yAnrC5pa23sC0bb
         aeFft0feb85ZFqldqDB/rcVDWUdyJhkzoId/6lbs4iIipnK80K38J22NyzAXRurt9c5W
         jg1Xnr1GVIFSf/b4m6N1ac9ZoIGoRhYdBJajqg3g2aQKRMLZl+QqkXiLHuiIuKoDjfir
         ofNyI3neT1Geu8Eap6uywCPPmXCSGwKMU2QpybbQHojlhxD9UBvvdYx93qcjl3nxt6p2
         gAKyyDPaVNZKWmIKMhgEOzEZ8OsR3um07TzagPL3gMXISMb4lqo/MfDe3ZeLDpNUdAFf
         HIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=s/IfvIEbinQo98Rd4r1exRfIaMkIuIH+QMm1ft3yTLElrSadq7uTX5nBM7THPcVyVw
         6Ta+zRA/k7vQl3oKKcH1D3PUGaxdRUbLES+dwYfJYxWiNaYVukuMPv8nMENePVjKCsZy
         IN9pYCeAT7P2zOFNRQs2M4cISAxAidcEGdvu5x01JwDg5do6OrWYVMCT6apFtvhGOq3w
         SryN1MIcVVPVWAxSlVEVpc2Gw8mV7fbMb5WvdAp2qGkJyH417tI06dKqso7XYV41PURg
         SnUyCd47TMlpsAwf9D8gvoDReW6mu4C/gU4SLhGtnjxPMiG/8KkaJ4/96u1lRKlraQ7r
         qt9A==
X-Gm-Message-State: AOAM532YeH3Sz27xnfLxdh/FNDCanS1nE/5av6Zpr947q3pM1RFiXKyF
        Kzv98Vj3aeOu9EL7SQ/aNcLdbQ==
X-Google-Smtp-Source: ABdhPJyjihPrpP9mOPB1OI6rHqwILuavjq4mpT5PgN977t0LWUaVr+YsoR8zfcukN05Q+WEbTQZN3Q==
X-Received: by 2002:aed:3629:: with SMTP id e38mr2681711qtb.354.1611031164317;
        Mon, 18 Jan 2021 20:39:24 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z20sm11934536qkz.37.2021.01.18.20.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 20:39:23 -0800 (PST)
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
Subject: [PATCH v5 01/14] mm/gup: don't pin migrated cma pages in movable zone
Date:   Mon, 18 Jan 2021 23:39:07 -0500
Message-Id: <20210119043920.155044-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119043920.155044-1-pasha.tatashin@soleen.com>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
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

