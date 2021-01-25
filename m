Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C32302D0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 21:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbhAYUxh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 15:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbhAYTsg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 14:48:36 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21D8C0613D6
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 11:47:55 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z6so10629717qtn.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 11:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=APd7o0SfBkNxtMpH7XgAZalnVlax3qUjjcZ+T+cdkl721zjTqiyrNgXce5aI1JJhVI
         bNjSKFbZ1wyY6khN4tVflZG3pBI0NyM2Pn5NrhEvsFSUoi1iFeBR0qBTvqdDK2YqWTol
         HRwdRsuAbAocWhIzZA35IFuhtxT8eF3U+58pIGQioZzxndFcdjcQ6Emht1tGSp1l+rE1
         kWHtBDtJIHZ3ynh8lE5qFiJaIg3upEOlt3xN0Q5EXPmSjxt3CHFa8QBb1U8FuKGt/KY5
         5LkyG1H1xtQv/uujJpKHSKwMbDKLK8S3mJSx/veQ+M8RVAWGWdY7TtO2zjzMb8ITmdw3
         OzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uI6NShNpRZxuWFJgcFGIsf9y7F3FhEyQzIGIbDpR8GM=;
        b=OlXtCaulTnlG8opwe0yP3HQOXPqP29+GZ2tiM4OB+Ch+LpZzRxITxXp37gMqOqQm5W
         axNk92v2A84CyHOXPqKytbop5DWBUF7rI9mk4kfaVnzyDFjUoskuX3cawEZho6kSgz+a
         iscWVjxe4qBMu4YM7nQkCtmR+XyTCijH+DVkKJPNqO/Km31Qun2biRpN+PB2T8sUqksn
         ljzSbsYlmMx69x7sHS6JNPYB75BIzI/dFYgRgyXzACrwb0Pn0QAANbG9dskWmNWvJUmo
         e1g/ivbrO1k5CaEaAK5h+6SQSt9ktI5vSFaOw06pAjOcbXcafr5cWbgfD/e0S22LpE9o
         3gbA==
X-Gm-Message-State: AOAM530RWPtl235yHwtCr1HDYZZzhMmFc9ROSWzrjVfzL9UKRTqUeTBt
        SfJfE/XHQN9IOd/zPxbMcVVytA==
X-Google-Smtp-Source: ABdhPJw5iCQaRdjeqKnek/6/7TMDHdOTBAJYl2HAxX/BZQACvfjwwxQckKi3CGyggwDyfJkTML5qaw==
X-Received: by 2002:ac8:e82:: with SMTP id v2mr2047681qti.164.1611604075264;
        Mon, 25 Jan 2021 11:47:55 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c12sm12121569qtq.76.2021.01.25.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:47:54 -0800 (PST)
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
Subject: [PATCH v8 01/14] mm/gup: don't pin migrated cma pages in movable zone
Date:   Mon, 25 Jan 2021 14:47:38 -0500
Message-Id: <20210125194751.1275316-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
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

