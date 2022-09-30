Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC605F0D54
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 16:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiI3OUp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiI3OUc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 10:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666ED163CE8
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664547626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BgHuUZqK9el1Q359iaqosMQiNhGcGN8eqaVP266/i4g=;
        b=GxQ2j4lLzFfyw6uSNdL8wNvYPOC8QO06G2a2+xNsuzMkDNfvh6+zBlD2QY5We91F7Bxry0
        7Gxze69epWyV7/JJGFySquTOIRPvB0kzVn/1PxnIx/m/EB2AzT3Krn0Ecup4hRFL7S3yHl
        cQZdAic7Jed0RWnr9wMWoFh1J5rDW7s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-ew032SwtPdytGZ38382Xcg-1; Fri, 30 Sep 2022 10:20:23 -0400
X-MC-Unique: ew032SwtPdytGZ38382Xcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB375858F13;
        Fri, 30 Sep 2022 14:20:22 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3271C1121315;
        Fri, 30 Sep 2022 14:19:53 +0000 (UTC)
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
Subject: [PATCH v1 3/7] mm: remove VM_FAULT_WRITE
Date:   Fri, 30 Sep 2022 16:19:27 +0200
Message-Id: <20220930141931.174362-4-david@redhat.com>
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

All users -- GUP and KSM -- are gone, let's just remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 3 ---
 mm/huge_memory.c         | 2 +-
 mm/memory.c              | 9 ++++-----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8f30f262431c..6a1375dcb4ac 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -807,7 +807,6 @@ typedef __bitwise unsigned int vm_fault_t;
  * @VM_FAULT_OOM:		Out Of Memory
  * @VM_FAULT_SIGBUS:		Bad access
  * @VM_FAULT_MAJOR:		Page read from storage
- * @VM_FAULT_WRITE:		Special case for get_user_pages
  * @VM_FAULT_HWPOISON:		Hit poisoned small page
  * @VM_FAULT_HWPOISON_LARGE:	Hit poisoned large page. Index encoded
  *				in upper bits
@@ -828,7 +827,6 @@ enum vm_fault_reason {
 	VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
 	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
 	VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
-	VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,
 	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
 	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
 	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
@@ -854,7 +852,6 @@ enum vm_fault_reason {
 	{ VM_FAULT_OOM,                 "OOM" },	\
 	{ VM_FAULT_SIGBUS,              "SIGBUS" },	\
 	{ VM_FAULT_MAJOR,               "MAJOR" },	\
-	{ VM_FAULT_WRITE,               "WRITE" },	\
 	{ VM_FAULT_HWPOISON,            "HWPOISON" },	\
 	{ VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },	\
 	{ VM_FAULT_SIGSEGV,             "SIGSEGV" },	\
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 84bf1d5f6b7e..b351c1d4f858 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1376,7 +1376,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
 			update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		spin_unlock(vmf->ptl);
-		return VM_FAULT_WRITE;
+		return 0;
 	}
 
 unlock_fallback:
diff --git a/mm/memory.c b/mm/memory.c
index e49faa0a1f9a..6e2f47d05f2b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3240,7 +3240,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	}
 
 	delayacct_wpcopy_end();
-	return (page_copied && !unshare) ? VM_FAULT_WRITE : 0;
+	return 0;
 oom_free_new:
 	put_page(new_page);
 oom:
@@ -3304,14 +3304,14 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 		return finish_mkwrite_fault(vmf);
 	}
 	wp_page_reuse(vmf);
-	return VM_FAULT_WRITE;
+	return 0;
 }
 
 static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	vm_fault_t ret = VM_FAULT_WRITE;
+	vm_fault_t ret = 0;
 
 	get_page(vmf->page);
 
@@ -3462,7 +3462,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			return 0;
 		}
 		wp_page_reuse(vmf);
-		return VM_FAULT_WRITE;
+		return 0;
 	} else if (unshare) {
 		/* No anonymous page -> nothing to do. */
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -3960,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (vmf->flags & FAULT_FLAG_WRITE) {
 			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 			vmf->flags &= ~FAULT_FLAG_WRITE;
-			ret |= VM_FAULT_WRITE;
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
-- 
2.37.3

