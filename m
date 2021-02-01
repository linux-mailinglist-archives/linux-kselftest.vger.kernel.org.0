Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BDC30AB9E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBAPjS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 10:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhBAPjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 10:39:12 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58213C0613ED
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Feb 2021 07:38:32 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id s77so3179482qke.4
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Feb 2021 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=ZK7zb4JfZxvJDH4rP++rGO4ym9RA4/AUZq57tVze+Z39Aim4mSkSHLogDTGtN029/D
         6FKlTuyF7Siie7kPLweGrab7Qj4CCRi3fUa7zYUdqJB+ukCQAg67+FfZGHra3shRU4Ud
         XSQjsrghTq6HK17jPWf+ftPrMORmjZ9/641OwzeMwJT4YqrvIoKXPQbWrcjzurfyPb+k
         xxV1sKrqi85++t3Vyb0ayML+GV3TZbLXZcho47XFFjbuATYGCbAsVmPW2/kzxVdUyP4B
         RgvhOuTqVrtMx48Cg8MWcisNzMKsv6p1XORa/mwNdjEm4OFltCV2B8stVa7AkGAFALZa
         udxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=kACnujCNDDauo9KVZqfE9Ot0DWW/fKoqXltizthftayman03i2Ismuo0nElmH5jxDA
         V5L+NczIsCA6Z5OQObAvZXLQwQQR9UETyFFasU4+x2UGObpxf1bjdd8JXzq0att/Nv4j
         C88xITVOLubrDx+v+1A+AjxMYMF1fFjrlWH2JpruBPKu/U7Y7L7HfpxHqT8jWLQQ7Bbx
         WLVA1nvPKgabXCgLnJ3C6NuuYO0BHVkWMfaVuXuStq6D9VMw69DNFwwez4+yEhLuyr45
         QZ+OGbAoUxQ/CGQ5jD+Pvu5VEBQwp7h6jAByILSFzNxI7wZipUnf+yKtt39tVAKq70Nd
         Czlw==
X-Gm-Message-State: AOAM532+ANhALGhV5BTLDvSOO+L7epVYo9najx8eA8WtMbkHcxKByfP1
        qhvo2DYmaJ8lGVSy5KtdU3XWfw==
X-Google-Smtp-Source: ABdhPJxLW2knwkEUqx65lpqbqovanbpJQgv8STLvLG5owMyBbjkmB+/m15zX9T7iv27mkC5256j0Hw==
X-Received: by 2002:a37:484f:: with SMTP id v76mr9917370qka.312.1612193911600;
        Mon, 01 Feb 2021 07:38:31 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 22sm14853307qke.123.2021.02.01.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:38:30 -0800 (PST)
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
Subject: [PATCH v9 01/14] mm/gup: don't pin migrated cma pages in movable zone
Date:   Mon,  1 Feb 2021 10:38:14 -0500
Message-Id: <20210201153827.444374-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201153827.444374-1-pasha.tatashin@soleen.com>
References: <20210201153827.444374-1-pasha.tatashin@soleen.com>
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

