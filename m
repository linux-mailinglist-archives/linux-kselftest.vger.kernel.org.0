Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2C318FF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhBKQaH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 11:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhBKQ1j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 11:27:39 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0198CC061A27
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:46 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id n28so4528168qtv.12
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1y8YVJPfrTUIiLzCoLZfzLsb38Z+1ZQwX7g2yPLqtWE=;
        b=BMZBD7oFx42XW1Uk/eIT+ek2yqmO2Unwl542eAk9EtAij5sF54ALjQ+UxIzV6fseqn
         9KHoTP/AkRo/I9nUl/bckx72sPe9TsPWqhTnETapUUtoMI91yr0quP6I2g4jL9ElIwQI
         qlZT7xirvXSEQOXrLZ8Glpk4Dt2Y6sD2Vo7KfitLgkUuUXK0jU1Rhp+kNsDhVjc8oyTr
         UatAl1MdhuE/8fWIVU9acVXddvE7Yvu1P1HbnVuDAEZ3oRvBX5RSCzPGZplfL9STagRw
         YC3vR6mguTAhApUEkxNsXoKWoXBOMgXWuvtlZNOD+cHwfHFMlDheS5Kyw2acUXRC6opX
         Y2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1y8YVJPfrTUIiLzCoLZfzLsb38Z+1ZQwX7g2yPLqtWE=;
        b=W5eB/bH+3a2BORjqW53N+wNj3qYxIpb97t/0xpi4H1OPz4FWLhIgEaKMzO6MfZ03Qc
         5h8c9YsxpnfVxW4092s7EWQbhJCRk+aChVcXuXBYBzhYZxDWV/7T9XrlEmJgzcryvpv1
         /rHD78Xj6lTC7Kl6Uw+PYfG/lTU0noW9zOBJCAkQQ2vGLB+5g27th4LR1TFwFlfN5/oQ
         JD2F39mZ7XvlLu4BGeQRFeOd4eTruVQWsu/wcl0wwhRTupWXAdN4ddnLMxX9tsaqbNSL
         IEtVDtTK8+LJ6PxYZlG2FuAosTnuGbE5b8GYyUkjrm6CEgUmhOhatnwTt3pUEcvFXGxX
         EqIQ==
X-Gm-Message-State: AOAM5330uleiE+vACwXB5vX464++59oNZ6PJAFq5AiQbYf+RCT0fH+tU
        O9T2iwCjTdopTW24Kmy0zgkPJg==
X-Google-Smtp-Source: ABdhPJywW3R49OtwqHgSlgYoPuSklhjeeJfwnn3touZTrtXT9dvY7n8wJc0mz/T1j2uyZvz6BoDYwg==
X-Received: by 2002:ac8:4d43:: with SMTP id x3mr8211573qtv.17.1613060685225;
        Thu, 11 Feb 2021 08:24:45 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:44 -0800 (PST)
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
Subject: [PATCH v10 10/14] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Thu, 11 Feb 2021 11:24:23 -0500
Message-Id: <20210211162427.618913-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
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
index 5307f90738aa..05d51d2d8beb 100644
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

