Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B135F0D5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiI3OVW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiI3OUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 10:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E435B6573
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664547648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdWmhT+XCWVUBSGE3ZoFfg/O04jXqhSLTEOmUwlj3I8=;
        b=IngFk+YsCeKTCqqCzWzv2lwksAZAkLGwdOu4g2ZT7Ggu0XbNeH4C/ntmWwYmiQImhvZkUB
        isbZgdE41GQ10JO1XLvJwTFV7vmPwktlso2DCkMk/gN7iJTWUmsNdKRvPcXYMz+puJv6Zy
        4CLItYDKQwGnLUH1M49VLXL3t7RaOi8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-ZiHXnUcHNF6VF1dflaLRxQ-1; Fri, 30 Sep 2022 10:20:47 -0400
X-MC-Unique: ZiHXnUcHNF6VF1dflaLRxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F6342A5955A;
        Fri, 30 Sep 2022 14:20:46 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB731121314;
        Fri, 30 Sep 2022 14:20:32 +0000 (UTC)
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
Subject: [PATCH v1 6/7] mm/ksm: convert break_ksm() to use walk_page_range_vma()
Date:   Fri, 30 Sep 2022 16:19:30 +0200
Message-Id: <20220930141931.174362-7-david@redhat.com>
In-Reply-To: <20220930141931.174362-1-david@redhat.com>
References: <20220930141931.174362-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

FOLL_MIGRATION exists only for the purpose of break_ksm(), and
actually, there is not even the need to wait for the migration to
finish, we only want to know if we're dealing with a KSM page.

Using follow_page() just to identify a KSM page overcomplicates GUP
code. Let's use walk_page_range_vma() instead, because we don't actually
care about the page itself, we only need to know a single property --
no need to even grab a reference on the page.

In my setup (AMD Ryzen 9 3900X), running the KSM selftest to test unmerge
performance on 2 GiB (taskset 0x8 ./ksm_tests -D -s 2048), this results in
a performance degradation of ~4% (old: ~5010 MiB/s, new: ~4800 MiB/s).
I don't think we particularly care for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 4d7bcf7da7c3..814c1a37c323 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -39,6 +39,7 @@
 #include <linux/freezer.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/pagewalk.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -452,6 +453,60 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
+int break_ksm_pud_entry(pud_t *pud, unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	/* We only care about page tables to walk to a single base page. */
+	if (pud_leaf(*pud) || !pud_present(*pud))
+		return 1;
+	return 0;
+}
+
+int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	bool *ksm_page = walk->private;
+	struct page *page = NULL;
+	pte_t *pte, ptent;
+	spinlock_t *ptl;
+
+	/* We only care about page tables to walk to a single base page. */
+	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
+		return 1;
+
+	/*
+	 * We only lookup a single page (a) no need to iterate; and (b)
+	 * always return 1 to exit immediately and not iterate in the caller.
+	 */
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	ptent = *pte;
+
+	if (pte_none(ptent))
+		return 1;
+	if (!pte_present(ptent)) {
+		swp_entry_t entry = pte_to_swp_entry(ptent);
+
+		/*
+		 * We only care about migration of KSM pages. As KSM pages
+		 * remain KSM pages until freed, no need to wait here for
+		 * migration to end to identify such.
+		 */
+		if (is_migration_entry(entry))
+			page = pfn_swap_entry_to_page(entry);
+	} else {
+		page = vm_normal_page(walk->vma, addr, ptent);
+	}
+	if (page && PageKsm(page))
+		*ksm_page = true;
+	pte_unmap_unlock(pte, ptl);
+	return 1;
+}
+
+static const struct mm_walk_ops break_ksm_ops = {
+	.pud_entry = break_ksm_pud_entry,
+	.pmd_entry = break_ksm_pmd_entry,
+};
+
 /*
  * We use break_ksm to break COW on a ksm page by triggering unsharing,
  * such that the ksm page will get replaced by an exclusive anonymous page.
@@ -467,20 +522,19 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
  */
 static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 {
-	struct page *page;
 	vm_fault_t ret = 0;
 
+	if (WARN_ON_ONCE(!IS_ALIGNED(addr, PAGE_SIZE)))
+		return -EINVAL;
+
 	do {
 		bool ksm_page = false;
 
 		cond_resched();
-		page = follow_page(vma, addr,
-				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
-		if (IS_ERR_OR_NULL(page))
-			break;
-		if (PageKsm(page))
-			ksm_page = true;
-		put_page(page);
+		ret = walk_page_range_vma(vma, addr, addr + PAGE_SIZE,
+					  &break_ksm_ops, &ksm_page);
+		if (WARN_ON_ONCE(ret < 0))
+			return ret;
 
 		if (!ksm_page)
 			return 0;
-- 
2.37.3

