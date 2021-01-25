Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DDA302CE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 21:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbhAYUny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 15:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbhAYTtf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 14:49:35 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99CCC06178B
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 11:47:57 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x81so10854754qkb.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 11:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/BFgBC6QAZDKdqJwclIw/UFhagKoK9nwCvAO/0D2vSo=;
        b=CmdxkXZULQNoAHH3ACXza+mPWBw4TkEUp5gdwo9v367G5ivVreRo2jfDKVnAfklKCZ
         lj/PfZNwM9XMAgMXUnM98CEkHtoOECGI2Y0fu0q1xxQ0NEIxll/TMuaZo65GQpW2XHyU
         rIrv4ioZ4SPXFX6hExoeutaJaFN6Zu0xoA3DImi6eVCWWNdMmGSBi/p3ICAR+yl+WaeJ
         R3+LncgUE2Ls+wUl0QzLu91lk0bsnXlR1jdnsIdi+99JwLhK0a83VrLiaiiVKZqdSbG3
         1xmIOxMMElDpTxuj70785Z55JdnBzrgS5LSZRWHM+jZ0kX/7mCQz37JfMpZxQ6ziTejt
         Y3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BFgBC6QAZDKdqJwclIw/UFhagKoK9nwCvAO/0D2vSo=;
        b=XicfGgf3kzwLbAFEHlI/pP1B1ONWyV1Hj114tU0nxpNP5RDVN4OA/7vPNTU6lTSBE3
         O6K1viTRRAlr97bQqxg3wfZASbdz/kNEI0gzeoa8V6Kfud3E1lRJ1lZuJiX059qZaBgB
         YCxHjPfRvKpuovy8ADoN4wZppB4FOS3tuCkcU/QwMu3lmLCK5OQsLfChBIV9PYaCI655
         6gtyKS07m79lr0rrXRFwp5QGAREpA8+ejWb28mj9vUsaDHlktJCxRNvM4m/R0i+qAO+l
         +zyLpwX1Ci9SIAvHFgPYYJxnJXfR6cKazZbm6hak1CqGbeMXmaLmZ1We+MvCaquvq3UI
         7TWQ==
X-Gm-Message-State: AOAM531kTtbI5o1l73qGV8yoIuvP8Pix+gtma8O6yO5mXRFQF3O91kcz
        kRw/o/yNovCaTh3Ujaf0CDouhA==
X-Google-Smtp-Source: ABdhPJz+Q8gL0GZ9W1lsgErCnpY5WXm31yZTxCvb9A79URsfZ1Q6xwrI2e5Q2K0QFJueffLs1BietQ==
X-Received: by 2002:a37:d58:: with SMTP id 85mr2382064qkn.280.1611604076921;
        Mon, 25 Jan 2021 11:47:56 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c12sm12121569qtq.76.2021.01.25.11.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:47:56 -0800 (PST)
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
Subject: [PATCH v8 02/14] mm/gup: check every subpage of a compound page during isolation
Date:   Mon, 25 Jan 2021 14:47:39 -0500
Message-Id: <20210125194751.1275316-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When pages are isolated in check_and_migrate_movable_pages() we skip
compound number of pages at a time. However, as Jason noted, it is
not necessary correct that pages[i] corresponds to the pages that
we skipped. This is because it is possible that the addresses in
this range had split_huge_pmd()/split_huge_pud(), and these functions
do not update the compound page metadata.

The problem can be reproduced if something like this occurs:

1. User faulted huge pages.
2. split_huge_pmd() was called for some reason
3. User has unmapped some sub-pages in the range
4. User tries to longterm pin the addresses.

The resulting pages[i] might end-up having pages which are not compound
size page aligned.

Fixes: aa712399c1e8 ("mm/gup: speed up check_and_migrate_cma_pages() on huge page")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 24f25b1e9103..16f10d5a9eb6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1556,26 +1556,23 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					unsigned int gup_flags)
 {
 	unsigned long i;
-	unsigned long step;
 	bool drain_allow = true;
 	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
+	struct page *prev_head, *head;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-	for (i = 0; i < nr_pages;) {
-
-		struct page *head = compound_head(pages[i]);
-
-		/*
-		 * gup may start from a tail page. Advance step by the left
-		 * part.
-		 */
-		step = compound_nr(head) - (pages[i] - head);
+	prev_head = NULL;
+	for (i = 0; i < nr_pages; i++) {
+		head = compound_head(pages[i]);
+		if (head == prev_head)
+			continue;
+		prev_head = head;
 		/*
 		 * If we get a page from the CMA zone, since we are going to
 		 * be pinning these entries, we might as well move them out
@@ -1599,8 +1596,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 				}
 			}
 		}
-
-		i += step;
 	}
 
 	if (!list_empty(&cma_page_list)) {
-- 
2.25.1

