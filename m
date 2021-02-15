Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3F31BECE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhBOQSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 11:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhBOQOf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 11:14:35 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC87FC061794
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:53 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id g3so3356119qvl.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7vhkaFBd5aVLg+EiVqDFYdlu6KAvATuHV48NAuG9s4U=;
        b=FywcUj6ct0QTnpDPy8lzzH7x1K66FMG6qQTU3im2GB8CWoLMq/TDlcCOnPXsoVk4Uo
         /ccMXbZM8gpaTE2NiqsIH49FrSxMFj0h9Tf41irzLmI1YiuP50CAJdo/pq8XQB8ThEiK
         zek3+g/0Dg2+hoBdU2MIsSmf+vmxUSDQoOs+LMl6JifDaDMG6nLbiR6/8aIPKuCDXC6i
         E65s2mATnNNP79AW8TObMspNmeaW9UtbIhrgz6MknOLoAT18wTHiYQcyUQlhu3+VaHJX
         rL8pKigaqw6j04/B0PU3nSDZwvcA4wMgY9bDOyC8AU3+U0wGYp1/NVEjJHTil6AVQIto
         RIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vhkaFBd5aVLg+EiVqDFYdlu6KAvATuHV48NAuG9s4U=;
        b=s/ju2gGAQZgEJVb79XsrsG5IJme6C9tuumNAuFHCgG8zHDOgq+2xrTwjTWehEIgToR
         lykyenJGOCje0LF+ddydZ09ysihh/dseNDzG4rl74hlzMypZ2JI2nBfaHLoO8YeZSlr2
         Wrt/LQx+TiZ/9Eg559jIDNXuFPnctIpSXUTkNguuKJkF6GwOW5ttNOD9UjpiOBvq9kRd
         ydV5kxZIzFvQqDxE75bA/lWFlyDRQpJAxr5bbwJw8V32IBSVzNMXytq7ORUkOmOJgd4x
         loU+OQ1JtLxy0VzNfY982FWMxDXl6gnJY6LkHyfkq1rn7roZY/OU406AWmmG+yOh7XA3
         7DXg==
X-Gm-Message-State: AOAM533dfENbJ8R15inJSnuOQ0aBs0zaOfcFi/Izg4PuIerPadTw7yp5
        ILGfuPPxY/ZIpx/wJ2lcRuwxrw==
X-Google-Smtp-Source: ABdhPJzgy3c8eHGQYHWnWy7dklXzD+wnVi3JsMAEz3Tuu6ovJUqSSVfElA+GFD7VdaJGS9cNQw4Kxw==
X-Received: by 2002:ad4:4644:: with SMTP id y4mr15440502qvv.31.1613405633174;
        Mon, 15 Feb 2021 08:13:53 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:13:52 -0800 (PST)
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
Subject: [PATCH v11 01/14] mm/gup: don't pin migrated cma pages in movable zone
Date:   Mon, 15 Feb 2021 11:13:36 -0500
Message-Id: <20210215161349.246722-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
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
index e4c224cd9661..df92170e3730 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1556,7 +1556,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-- 
2.25.1

