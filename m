Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0070C2DD8C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgLQSyJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgLQSyJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:54:09 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F9C061285
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:52:49 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id u21so20819817qtw.11
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=moKlK00n8Mdrp7ywZpC6MaDpohjdb0npdJnYeg/on6s=;
        b=ZOxXEpzZE5eoyaS0FfOo5PWGj/4PnUFDMcm9vo0KmaZNneDdSsxRUnXw/684pkorel
         Zt8q9wUL1+/2aHgfijA0vUU9udDbViRaxBO3weUCGeZChY5KhViitj/diOV3z2x2tttI
         wda7SeXLHcPsDOl5Ebl9rKvJ0ScaFNPXEeiEs51TIgOzz8yGpGIXtvHxd5OLbkKiFJdr
         FUyLRdWGVEAqGfOlCyU0Hh5iMHV5x+JuVXzwNcbp1lKW5L3CjWGOeQ4prbHHN/JoUAj8
         X3vysNNxwDmbtDj6EOJ2UpLam2FdfdRGtNm4VbBOsITaj3yoa47yJPcF7T5Gv3HbtL6H
         TndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moKlK00n8Mdrp7ywZpC6MaDpohjdb0npdJnYeg/on6s=;
        b=UprHaVERI6n6DrxckohLOWZ/psvJ+E8gIbtvO27kGlpsQLt7rLNf6MoLyLsflnhRVT
         4zVIFQgo2FinHCsJjnl7U6k4jDY4vxC5/jCn38C193RAl5TkVeB2dp2TTG5a5v/JtmW4
         D2CZhrsRFyItj1mwZ/1C0gDiDTth6U5eYE5iqnqSsOjFMx0eHqPcaRSmUObbwoJZvb/w
         +lPVzcVS82wpTkRJ0hF2vpE2lg0IlFeUqOxkutpoKNL463QbYENP9+P4YSXsRHDmHoio
         CUwNOV1+2UNRun0bI/b6sznDUYDQfX3wdqjolKpNFhp8o8HeaGXBlPRJJ2ApxYdfEQ2D
         cGzw==
X-Gm-Message-State: AOAM533haHflspZaVykraaU6Ev+WUZVqdro0o7vDGOZsSCaBB89n2hHA
        idGVbfoqirYjKWTK6NONK3a5mg==
X-Google-Smtp-Source: ABdhPJzR9Qh7lsqKjSY0T7wIxNIkDhJNQGdnPSt+BzV4Eg4mDwA9KfrzI+zYzcc82IhoDCH10Mujuw==
X-Received: by 2002:aed:23d6:: with SMTP id k22mr171171qtc.226.1608231168320;
        Thu, 17 Dec 2020 10:52:48 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m8sm4127434qkn.41.2020.12.17.10.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 10:52:47 -0800 (PST)
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
Subject: [PATCH v4 01/10] mm/gup: don't pin migrated cma pages in movable zone
Date:   Thu, 17 Dec 2020 13:52:34 -0500
Message-Id: <20201217185243.3288048-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
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
index 4f3cf14ac958..f2e50cdd7d67 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1565,7 +1565,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-- 
2.25.1

