Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291622FC762
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 03:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbhATBoX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 20:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbhATBoV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 20:44:21 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF86C0613D3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 17:43:38 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 22so23986484qkf.9
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 17:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=k3UV+tDJFr+BKK3SSCpump1HUAtfuWyB3vS0LsN5fFAtz4WTPM/kPfMX6f7azPyAi2
         Hy5M6t3n4O4rmylRtxe4c7sC0bV8+0OvyNP3ZZ4nLrIpmoNU4o58Zfglxs2St1XzFukH
         hsbqH769UPvhuyWV+rOOmMbI1AObZhKuZ2SCh7bwxPLN7QRrqdO7fuq5Tr4Uv8e2Id0O
         Xc+E/yROvbKWmlFHupHjdhDN1/7oMmnz1o3AUNkHOTb1MC0LQ2B88d9ClGIfu6MV9bo3
         rn4PiTCrb7/vrinyIPhnEftr0SI0zN3glm7iCVTH7vDhfmaS5WPQi4cdSa3IIvRm/hfE
         htpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=mbl3aDpRfOGpN4uFbvoiQrITugbb77w5ovtUrMyLmYgcaAiwodeNZngRw5qmzdyBlc
         au57vhZPVQzMegUQNtWikYMu68bKisxSXFyheLv67hdaIlmsFIfDWXGUYKhH8HGry/UO
         dNYUkdNVa49kcBeoVWDy/KLIsRXnAeyBj3ek10AmwGeL3Oq5XEkxwNdmLlCsPogFJ6qL
         wenvSRJO2X8I+02+thgygCbgQPWyhbTHkPPuUVvuxMJlauPVrbcDN8RqF0jaHHdvvDzS
         Mik6LURf4YkhVSj4f5Ma6cmstaVwpN8Fl8IOAeUAJLe/2ELgWUVU1MSRpfjRHL85t0Vu
         cCAg==
X-Gm-Message-State: AOAM530IfUSaMsghin1bOs3fPU5vN32Ys+eDnKw/SvK2iaYcVE426kK7
        MKpOqXknfDUSo3UspNqoslR8BQ==
X-Google-Smtp-Source: ABdhPJw/w3n1JtoHciRMldIMV+u/1mfbbFkskDr23rQOCI1lzfOX0iF0LEkdMvvV0EJt5+9QPKx29Q==
X-Received: by 2002:a37:883:: with SMTP id 125mr7628509qki.366.1611107017485;
        Tue, 19 Jan 2021 17:43:37 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id a9sm391871qkk.39.2021.01.19.17.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:43:36 -0800 (PST)
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
Subject: [PATCH v6 01/14] mm/gup: don't pin migrated cma pages in movable zone
Date:   Tue, 19 Jan 2021 20:43:20 -0500
Message-Id: <20210120014333.222547-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120014333.222547-1-pasha.tatashin@soleen.com>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
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

