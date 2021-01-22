Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7952FFB42
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhAVDkz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbhAVDkC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:40:02 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A219C061226
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:09 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l23so760589qtq.13
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yTrJ8UyvzX+KpiFSTPdiWeecmI/gWKbEGLZJ82OhrPo=;
        b=b0BUTnulWma1TeHW8eRVTOcopOdO5Lb/14LpveQRR2iyVcVX8Pb+rPZeqoe1trXsZV
         4f9Q/xESkT9IHm9k+yrnxykI4bvXDAkFAGBl0oMw4EOj03ngoEQcfBxvWc4TWEyTACrC
         KmxMWMkhF5NNKbPMEgq83OnRiTrjRdthUMDygBuNQrQmU3DMUqLcGXxvzWuKdhp/2wfI
         Dv9EqVySiVKDfCmutb3F9VImzaSCCYCDw/Th2hIB5N4YiZqqXODxAJgNIsaGXLx5TcHz
         rxEA67v25DNcOiwJnQiC9hfH4ybtXGE8t6zZ6WNad+rMcqZeP4VApAyWcVthAyxWyYFJ
         qNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTrJ8UyvzX+KpiFSTPdiWeecmI/gWKbEGLZJ82OhrPo=;
        b=LqkiPH4Qx0MqSKPdicIFb9nNmmAs684Vd1Ku/l4CfSWwGQCIqCp7G3dJFgUDBGOs3G
         kVcYJ+Tez4UrQa+63obPNzbG5dQPgJS8ysp1HAAqXLwOfuisJNDzJp6gIUeFru2WCtAt
         v5NvpOYhXNGOISt+Kgp1O7234E+/BIp0ytqwRY1rd4jW33A3VkFBoe9Byvbv8ZoOqegb
         XcrrZBjzftOixv7x3ijKwO9Pii/jzqkkxpaKw7A6C2MoWj/txEqHq8qyx+FE7RKyqR6P
         Wgapbol90ogEmH8IGnsfTyRdDKg7dny2Wk2aKaENxKe6CD3Q/Os3vV58k4ex2LkRkJd3
         ATjQ==
X-Gm-Message-State: AOAM530ZbjADOUJ8aIj5qep2qURVbkwvmeA3y2YvyI8/vwNgkjfSM0J9
        5BkXsidou0zrQMoD+YMTLsBz+w==
X-Google-Smtp-Source: ABdhPJx0JZ+IVdNQmLLHImDfzv/vfaj90+4ZYA8LsDu3lbuU+O3TTWa+y5KiLwkYnw8weVA4wVw9yw==
X-Received: by 2002:ac8:1184:: with SMTP id d4mr2686434qtj.103.1611286688669;
        Thu, 21 Jan 2021 19:38:08 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:38:08 -0800 (PST)
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
Subject: [PATCH v7 11/14] mm/gup: change index type to long as it counts pages
Date:   Thu, 21 Jan 2021 22:37:45 -0500
Message-Id: <20210122033748.924330-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In __get_user_pages_locked() i counts number of pages which should be
long, as long is used in all other places to contain number of pages, and
32-bit becomes increasingly small for handling page count proportional
values.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 0422dd150e80..ddbbee741d5d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1479,7 +1479,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 {
 	struct vm_area_struct *vma;
 	unsigned long vm_flags;
-	int i;
+	long i;
 
 	/* calculate required read or write permissions.
 	 * If FOLL_FORCE is set, we only require the "MAY" flags.
-- 
2.25.1

