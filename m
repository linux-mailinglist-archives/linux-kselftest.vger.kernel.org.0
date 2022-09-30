Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE075F0D64
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiI3OVh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 10:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiI3OVF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 10:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A511A1EB9
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664547660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRwNrzzGpz8bO60Pn63vXNqmewRV7ohymI+Kzy3OQVY=;
        b=LOyetPor1pjK/1INiyl7VTQQkf4tNUmRZnUVuKdyxnxwVCOKWv1QuRUZ7gC2Y6wMP3tbbd
        bOLWQrmsrhFwrGzapmD1/gh3e9otO2YjCbTxUdTcEWl1my3UDBZwe4m00QUCMz9/yrFy9a
        C3/CNN5F/pD1gK4fb0dt9nRtUef9xSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-ced8YZfqPOWKMAfTZSCfpQ-1; Fri, 30 Sep 2022 10:20:56 -0400
X-MC-Unique: ced8YZfqPOWKMAfTZSCfpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03AAE855305;
        Fri, 30 Sep 2022 14:20:56 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE74A112132C;
        Fri, 30 Sep 2022 14:20:46 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v1 7/7] mm/gup: remove FOLL_MIGRATION
Date:   Fri, 30 Sep 2022 16:19:31 +0200
Message-Id: <20220930141931.174362-8-david@redhat.com>
In-Reply-To: <20220930141931.174362-1-david@redhat.com>
References: <20220930141931.174362-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fortunately, the last user (KSM) is gone, so let's just remove this
rather special code from generic GUP handling -- especially because KSM
never required the PMD handling as KSM only deals with individual base
pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  1 -
 mm/gup.c           | 55 +++++-----------------------------------------
 2 files changed, 5 insertions(+), 51 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e56dd8f7eae1..4c176e308ead 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2942,7 +2942,6 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 				 * and return without waiting upon it */
 #define FOLL_NOFAULT	0x80	/* do not fault in pages */
 #define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
-#define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
 #define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
 #define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
 #define FOLL_ANON	0x8000	/* don't do file mappings */
diff --git a/mm/gup.c b/mm/gup.c
index ce00a4c40da8..37195c549f68 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -537,30 +537,13 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
 		return ERR_PTR(-EINVAL);
-retry:
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	pte = *ptep;
-	if (!pte_present(pte)) {
-		swp_entry_t entry;
-		/*
-		 * KSM's break_ksm() relies upon recognizing a ksm page
-		 * even while it is being migrated, so for that case we
-		 * need migration_entry_wait().
-		 */
-		if (likely(!(flags & FOLL_MIGRATION)))
-			goto no_page;
-		if (pte_none(pte))
-			goto no_page;
-		entry = pte_to_swp_entry(pte);
-		if (!is_migration_entry(entry))
-			goto no_page;
-		pte_unmap_unlock(ptep, ptl);
-		migration_entry_wait(mm, pmd, address);
-		goto retry;
-	}
+	if (!pte_present(pte))
+		goto no_page;
 	if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
 		goto no_page;
 
@@ -682,28 +665,8 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 			return page;
 		return no_page_table(vma, flags);
 	}
-retry:
-	if (!pmd_present(pmdval)) {
-		/*
-		 * Should never reach here, if thp migration is not supported;
-		 * Otherwise, it must be a thp migration entry.
-		 */
-		VM_BUG_ON(!thp_migration_supported() ||
-				  !is_pmd_migration_entry(pmdval));
-
-		if (likely(!(flags & FOLL_MIGRATION)))
-			return no_page_table(vma, flags);
-
-		pmd_migration_entry_wait(mm, pmd);
-		pmdval = READ_ONCE(*pmd);
-		/*
-		 * MADV_DONTNEED may convert the pmd to null because
-		 * mmap_lock is held in read mode
-		 */
-		if (pmd_none(pmdval))
-			return no_page_table(vma, flags);
-		goto retry;
-	}
+	if (!pmd_present(pmdval))
+		return no_page_table(vma, flags);
 	if (pmd_devmap(pmdval)) {
 		ptl = pmd_lock(mm, pmd);
 		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
@@ -717,18 +680,10 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(flags))
 		return no_page_table(vma, flags);
 
-retry_locked:
 	ptl = pmd_lock(mm, pmd);
-	if (unlikely(pmd_none(*pmd))) {
-		spin_unlock(ptl);
-		return no_page_table(vma, flags);
-	}
 	if (unlikely(!pmd_present(*pmd))) {
 		spin_unlock(ptl);
-		if (likely(!(flags & FOLL_MIGRATION)))
-			return no_page_table(vma, flags);
-		pmd_migration_entry_wait(mm, pmd);
-		goto retry_locked;
+		return no_page_table(vma, flags);
 	}
 	if (unlikely(!pmd_trans_huge(*pmd))) {
 		spin_unlock(ptl);
-- 
2.37.3

