Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE561F917
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiKGQUI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 11:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiKGQUH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 11:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D707DEA1
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667837908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVOAyJTl2MTgo2X9FfMYjP1wgsYUPslaZQjoDmvS5eo=;
        b=F7ShYpgWJGGm6cI74s3F4CmVtJcoZepqfQJwwFCsvXLg2bNe32R6SOUC8nyyxj1/VOr8dB
        TT1bIV50WIkFi+XVA2661cfHG/pcGLqUk7o9xevJ4DsI0qq9gUiC8BEbJGi2OLTYiN22hg
        RAfHMJlzbapgQ6MBo8NiKgXANNQQdc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-3Mv0bTVcNnGiSvjrzw7oMg-1; Mon, 07 Nov 2022 11:18:24 -0500
X-MC-Unique: 3Mv0bTVcNnGiSvjrzw7oMg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05639185A7AA;
        Mon,  7 Nov 2022 16:18:23 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A60F24B3FC8;
        Mon,  7 Nov 2022 16:18:17 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 06/19] mm: rework handling in do_wp_page() based on private vs. shared mappings
Date:   Mon,  7 Nov 2022 17:17:27 +0100
Message-Id: <20221107161740.144456-7-david@redhat.com>
In-Reply-To: <20221107161740.144456-1-david@redhat.com>
References: <20221107161740.144456-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We want to extent FAULT_FLAG_UNSHARE support to anything mapped into a
COW mapping (pagecache page, zeropage, PFN, ...), not just anonymous pages.
Let's prepare for that by handling shared mappings first such that we can
handle private mappings last.

While at it, use folio-based functions instead of page-based functions
where we touch the code either way.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 826353da7b23..41e4c697033a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3341,7 +3341,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	struct vm_area_struct *vma = vmf->vma;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	if (likely(!unshare)) {
 		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
@@ -3359,13 +3359,12 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	}
 
 	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
-	if (!vmf->page) {
-		if (unlikely(unshare)) {
-			/* No anonymous page -> nothing to do. */
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return 0;
-		}
 
+	/*
+	 * Shared mapping: we are guaranteed to have VM_WRITE and
+	 * FAULT_FLAG_WRITE set at this point.
+	 */
+	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
 		 * VM_PFNMAP VMA.
@@ -3373,20 +3372,19 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 * We should not cow pages in a shared writeable mapping.
 		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
 		 */
-		if ((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
-				     (VM_WRITE|VM_SHARED))
+		if (!vmf->page)
 			return wp_pfn_shared(vmf);
-
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return wp_page_copy(vmf);
+		return wp_page_shared(vmf);
 	}
 
+	if (vmf->page)
+		folio = page_folio(vmf->page);
+
 	/*
-	 * Take out anonymous pages first, anonymous shared vmas are
-	 * not dirty accountable.
+	 * Private mapping: create an exclusive anonymous page copy if reuse
+	 * is impossible. We might miss VM_WRITE for FOLL_FORCE handling.
 	 */
-	folio = page_folio(vmf->page);
-	if (folio_test_anon(folio)) {
+	if (folio && folio_test_anon(folio)) {
 		/*
 		 * If the page is exclusive to this process we must reuse the
 		 * page without further checks.
@@ -3437,19 +3435,17 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		/* No anonymous page -> nothing to do. */
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return 0;
-	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
-					(VM_WRITE|VM_SHARED))) {
-		return wp_page_shared(vmf);
 	}
 copy:
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
-	get_page(vmf->page);
+	if (folio)
+		folio_get(folio);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 #ifdef CONFIG_KSM
-	if (PageKsm(vmf->page))
+	if (folio && folio_test_ksm(folio))
 		count_vm_event(COW_KSM);
 #endif
 	return wp_page_copy(vmf);
-- 
2.38.1

