Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFF4302CD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbhAYUnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 15:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbhAYTuz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 14:50:55 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06429C061222
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 11:48:11 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id x81so10855447qkb.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 11:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=ggxWFJx1XNRIPR+VPqKxFscBPx27Vie4AlDDaPRS0mTDqH54+IBnC1q4/B/aQgVuDi
         bQy/G19+TUuwriBvOR3qKylUfMo8aEA/sssA638vsok6rLz29eNdH0tzpRF9FZDTm6kX
         ZsdNcrXEc2WtBcqRjG7i1UuM/BBdeNi5zMLDut663oqjTUQgWKlhgDWc+pPfNnMxcFXm
         MjAdHpC+E6DmvxGDfoGxz8OL0j4Me4jtxqBMlcaTW4Qf/OzbN0ovx1DD0h+fCBpfgNHe
         BIg25RJ3G4qs8V+VRvGN/b3dhnUFlfr+IUa9j+QLE+WIUZR8QUyTTEGUz3p7BPxl+vnk
         HlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=Do+iBW6/fB/5/MaAzCnHamv8u27LcU3jOaYlDyUAd/x8S5fr05OyfK2hD0MuYFVgMS
         LoOKYZv/6+izpU+gl0aOydf95Sy+HCx8qh4UayfIOIY50BUW/nCB+InWaBOC6V2FwvtW
         QvWvPuO3k232eA5TXA/TsXf0cV3hDCX8O+8VjklrK1loRzku/aX1PkmHk83KGC4KbZdJ
         rDKysgq+O3OJTUGtNLE/X/1edQJJPBmYm0U3z8F0s3gHerYDBIjPs410cVPdcWVDkvIG
         vFKG7up8G38Uq7U5OltaWwEktPc5EsI+Nc2FWaypbkDP+VPgGngUtCHExqn+vKlfaBoG
         ck2g==
X-Gm-Message-State: AOAM5300JA3QuIkxFitF6+tHPfhn0Co6n65YpS/4v6VdVEecaYqYiqpg
        s/qrIsxn65v5E8TCofWH1YYCoQ==
X-Google-Smtp-Source: ABdhPJwHb2z3O87rhiHdk/7Xsu4L+A54QJcA/Onlzvq9WKtDY2/7cQjQseTRCIMa3SSoFW5xmC91oA==
X-Received: by 2002:a05:620a:13ae:: with SMTP id m14mr2317266qki.35.1611604090257;
        Mon, 25 Jan 2021 11:48:10 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c12sm12121569qtq.76.2021.01.25.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:48:09 -0800 (PST)
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
Subject: [PATCH v8 10/14] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Mon, 25 Jan 2021 14:47:47 -0500
Message-Id: <20210125194751.1275316-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
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

