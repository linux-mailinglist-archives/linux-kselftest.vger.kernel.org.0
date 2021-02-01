Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7661F30ABC0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhBAPm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 10:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhBAPkm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 10:40:42 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265B1C061222
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Feb 2021 07:38:48 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t63so16611045qkc.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Feb 2021 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=AHmYYD8Uf8KGvHJW8MVVxXtqkqFhVxYZFo/y+SbSqwIYX7GwlLLiomi3JOJQZMdQAi
         bKHwvo43JM0PXEP3sfVnKqBJBeWSB/zA0i74oMnO7Vnt4HH4WkHKaMRdEVax1hHfY0mV
         81Y/qBf7AyFfx9jwAAz1y2vp5a5Q6AZUQCoWzocq0tB9KEs008vc6KUtfX6KYcZ5omgs
         zxHNup5vu+iWU5dmfRSNBaliZfLlslxblr9TDrIgTrHWQ8YDWsgSsYD8YOC/uec+995p
         7QWmM0BzAFryYjEhWRpFG/2hngYhbCy0ZpelZca2yEDQJnWpjCkT4FCCiTGYHFdADHNa
         UEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=SpMFsL9yzjDqOGEEFI/sEFyx7u9kaLaSzOciZuj2LbUZZcDLqzA8oYB/IhNFWPm+EU
         ilQknhQm4jEyFH2J2hbRCzIp11Sesd3Q0G4f4/i4FzBT5sPUhy//eHkvNyNNkWibtIFJ
         5jAZT9rcMWLCJhHYCdjdY3kE3sIRYPA22+VBOWsaeRyqymjcB4URcBo/XetLpOw0vTB/
         5n33NAdIeb6qvr4+BK9ttR0vXigPArQJ+MKobujcUr7txzyCT8xVFT9SiVPDK0ICjR/8
         X2X57Xj6t13wktuJRMitFOwFExEva6wiJ9ZtUmpxBB0wSXhyJgYW2DdIMl9TE9MHgZAd
         Oocw==
X-Gm-Message-State: AOAM531aNCbp/9Z+00gHrXMF67c1SkK1cDRGj57sP3SJkg+8u7aIRJ5Z
        rVcn416EQmHajy/diedV1bgsxg==
X-Google-Smtp-Source: ABdhPJydhT1EeSqCG81uSPKnUS/xT4UZSfZsofqpJUFGgxsGTeZgk0uM9rr5T/hAQj/7Ark0+s1gGg==
X-Received: by 2002:a05:620a:745:: with SMTP id i5mr16954962qki.321.1612193927413;
        Mon, 01 Feb 2021 07:38:47 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 22sm14853307qke.123.2021.02.01.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:38:46 -0800 (PST)
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
Subject: [PATCH v9 10/14] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Mon,  1 Feb 2021 10:38:23 -0500
Message-Id: <20210201153827.444374-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201153827.444374-1-pasha.tatashin@soleen.com>
References: <20210201153827.444374-1-pasha.tatashin@soleen.com>
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

