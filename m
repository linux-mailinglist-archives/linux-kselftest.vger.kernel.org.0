Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC12FFB55
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbhAVDn4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbhAVDjh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:39:37 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEDBC061224
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:07 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c12so3261153qtv.5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=oESNTGgVdyEaOuywKNSv4UZ4Fqr105szHy3fzQiAUMaaw+zvBvKum3SLUrozslMU9M
         cAj+Ot1b/fFJ8nFeIzsLld2IUjs+OTiOfx8u3eHda1Vjhp0x+S4w7x9pOqlMGyA8KW0z
         XxG4jvNaMCjVxJA2aHMEg2/KHoMeZHoGL8KR1dAK/O0PPxZPfkF2U/KJO99lhEw2rmab
         34RJTNAL+1bV9CrzKRnFYZxRuyuWWQCihPpsvfgQ+CH5H9xVCjYfjged5wCJs+40uZ8k
         VKHY+mG3d1LIApnSmHDVkphe6/BK/AJGyfeLG1oekroFXhDv9+yhuZTIaPVuxk/J7p1d
         i3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=ni5yxiRVmH0povV5hnwP7r2XbO4pkBow5ff6monNEX5r/rWUAIn/1ihnkrfnzabxfZ
         sL6rTkOZLrqB3ngVxpnyzRegGOX+fMm1Eh03gjX9TZ5CTD4LVOIjB2VnhfXAgSx5jHJC
         ZzE3MPYkIh2WQ9R3H/PRkcmkCYefgVP3ZtY5XkXNWKWtSp2dR1y6W5jBWDt542/4dZJQ
         Riy/Sn8s8TRvmT3d4DLEHOj/mLe+rb1C5ijHQ4e1TqiXdiNaiep46JDpTtsBg+XHdrrc
         3O/jrzYmr89tyXdIYFZMT4Wb0qlw1sOECRAO+eBEOg+WbR6OWPfbz1uQHaXwjlmTN8yg
         /1Ag==
X-Gm-Message-State: AOAM531LQ2OwX4cmpFwJpJYcI7WgfvKICvgsNj0RYu6BfZCV/c2I7rCn
        xag6gowEhUKHqNR9X/IcfHXnzw==
X-Google-Smtp-Source: ABdhPJxB8QpjUpktMAJ0m18/G6Q1XfGvgXeD5f015WLHjIZOzXXTX5cTmWMprMh6urdwdAieXCCMwA==
X-Received: by 2002:aed:3165:: with SMTP id 92mr2752407qtg.388.1611286687049;
        Thu, 21 Jan 2021 19:38:07 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:38:06 -0800 (PST)
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
Subject: [PATCH v7 10/14] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Thu, 21 Jan 2021 22:37:44 -0500
Message-Id: <20210122033748.924330-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Document the special handling of page pinning when ZONE_MOVABLE present.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/mm/memory-hotplug.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 5c4432c96c4b..c6618f99f765 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -357,6 +357,15 @@ creates ZONE_MOVABLE as following.
    Unfortunately, there is no information to show which memory block belongs
    to ZONE_MOVABLE. This is TBD.
 
+.. note::
+   Techniques that rely on long-term pinnings of memory (especially, RDMA and
+   vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
+   hot remove. Pinned pages cannot reside on ZONE_MOVABLE, to guarantee that
+   memory can still get hot removed - be aware that pinning can fail even if
+   there is plenty of free memory in ZONE_MOVABLE. In addition, using
+   ZONE_MOVABLE might make page pinning more expensive, because pages have to be
+   migrated off that zone first.
+
 .. _memory_hotplug_how_to_offline_memory:
 
 How to offline memory
-- 
2.25.1

