Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34222FAFAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 05:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbhASEpO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 23:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732796AbhASElw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 23:41:52 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D934C0617B1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:39 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id s6so8586959qvn.6
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=ZzAEvUNsgm1gA/BtAGDww/ogGjjSgj1kDd613YzbM+YqhjB9Pm0Bnu+sVa84HgcfH9
         d9dFvXQUB9iDOJ/KZ399mPlbIcgiuc7vWLsQkp6289MXPOfYuuIxKVB7pC9ksqAYZEZe
         VHJOGBBUYn8hQ6PXGRXG73CrtaC66uYplcvxFE/pdoCVeg9FjOlJmv+ly8nTlfX/BqUE
         WeDBMlAG2f4CKhxvhm8/maPGZ6Wgmtd20Q6uoAv/arIKIriZGzM49D/YJ/bK79FPMAps
         TCtqulcq7dAP54Te25gabmp7YQpFkP8ipaMEsDALpfV2a99C+f1WA8wzTSVL3L/YzM23
         61hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=p/ynEKE3ANxBGaloSy48jJtNBy5NpHVwLY2pIPhqeXq5YTj+4mgEjs0GvkPhVr1prw
         0PP5oAUCsSXmXRgdjIjB3A67An1n0tMFj8554/PDWgrQhfsHNE8B7mDmpMFmJUu+WfrZ
         Q31zaeagNp5+gBbAjBjJtOx6/VNei/Lt4CbTj5qSXmm0aBQzFN/cwGAon0F+RCjjkKQc
         9JOAathuwyOajCnxV1/l6qjr8VssGNfqJzP2BbgRiu/5Sz1LgEMrrQmbdjnDtVANSx3e
         RFlqeO9JrtX2Ny1xyuqoxazEho7uoka1ktMn3c6lliGVz42iarC85+8d8CnmrCPyIDCg
         km6A==
X-Gm-Message-State: AOAM5331QLGlI+FI0PNw+uo6SgNS4u3McMgDNZyao3xy4PXf27B0+v2H
        2T2xRVkXpuscGq9U1fBZEERj+w==
X-Google-Smtp-Source: ABdhPJx3a4TDVVpQ3OtzgpKeD4fURR/7LsDvn4tqhZ4fXd18CTYySHhA2WdtdMDk2WAbkN8BxjxaMQ==
X-Received: by 2002:a0c:8027:: with SMTP id 36mr2871477qva.57.1611031178459;
        Mon, 18 Jan 2021 20:39:38 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z20sm11934536qkz.37.2021.01.18.20.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 20:39:37 -0800 (PST)
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
Subject: [PATCH v5 10/14] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Mon, 18 Jan 2021 23:39:16 -0500
Message-Id: <20210119043920.155044-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119043920.155044-1-pasha.tatashin@soleen.com>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
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

