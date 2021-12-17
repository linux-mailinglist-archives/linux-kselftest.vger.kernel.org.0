Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F1478A0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhLQLe1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235524AbhLQLeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwpaYH90QrdomBtkH4bbU2T/tiB0wo98uDxZc7uFD1s=;
        b=YvhhQZmbEWn1ltcPbgpeiXwsBSTZjGzKB5zDnwx1n5GxpZPQmChNZnolt4iJopps8Rq8tB
        2LxDbz96Be2JBTqZF5hTU9YJIE3tGdNBBYVfYylP5fdmDDAbvb2e1yrC9Vy5pYZGAg7A9W
        M/1xLDQs0nDhv3GYknwn4TQeL2N4hY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-1Bp9m0YsN3OXQAACCFsDzA-1; Fri, 17 Dec 2021 06:34:21 -0500
X-MC-Unique: 1Bp9m0YsN3OXQAACCFsDzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4C781CCB5;
        Fri, 17 Dec 2021 11:34:18 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B0BB8ACF7;
        Fri, 17 Dec 2021 11:34:12 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 09/11] mm: gup: trigger unsharing via FAULT_FLAG_UNSHARE when required (hugetlb)
Date:   Fri, 17 Dec 2021 12:30:47 +0100
Message-Id: <20211217113049.23850-10-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Similar to the !hugetlb variant, invoke unsharing for shared anonymous
pages when required during GUP by setting FOLL_FAULT_UNSHARE in hugetlb
code as well.

FAULT_FLAG_UNSHARE will trigger unsharing of shared anonymous pages during
GUP, resulting in a child process no longer being able to observe memory
modifications performed by the parent after fork() to anonymous shared
hugetlb pages.

This commit is based on prototype patches by Andrea.

Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c     |  3 +--
 mm/hugetlb.c | 43 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2a83388c3fb4..35d1b28e3829 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -67,8 +67,7 @@ bool gup_must_unshare(unsigned int flags, struct page *page, bool is_head)
 	if (PageKsm(page))
 		return false;
 	if (PageHuge(page))
-		/* TODO: handle hugetlb as well. */
-		return false;
+		return __page_mapcount(page) > 1;
 	if (is_head) {
 		VM_BUG_ON(!PageTransHuge(page));
 		return page_trans_huge_mapcount(page, NULL) > 1;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5f2863b046ef..dc42018ee1a6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5971,6 +5971,25 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 	}
 }
 
+static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
+					       bool *unshare)
+{
+	pte_t pteval = huge_ptep_get(pte);
+
+	*unshare = false;
+	if (is_swap_pte(pteval))
+		return true;
+	if (huge_pte_write(pteval))
+		return false;
+	if (flags & FOLL_WRITE)
+		return true;
+	if (gup_must_unshare(flags, pte_page(pteval), true)) {
+		*unshare = true;
+		return true;
+	}
+	return false;
+}
+
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
 			 unsigned long *position, unsigned long *nr_pages,
@@ -5985,6 +6004,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	while (vaddr < vma->vm_end && remainder) {
 		pte_t *pte;
 		spinlock_t *ptl = NULL;
+		bool unshare;
 		int absent;
 		struct page *page;
 
@@ -6035,9 +6055,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * both cases, and because we can't follow correct pages
 		 * directly from any kind of swap entries.
 		 */
-		if (absent || is_swap_pte(huge_ptep_get(pte)) ||
-		    ((flags & FOLL_WRITE) &&
-		      !huge_pte_write(huge_ptep_get(pte)))) {
+		if (absent ||
+		    __follow_hugetlb_must_fault(flags, pte, &unshare)) {
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
@@ -6045,6 +6064,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				spin_unlock(ptl);
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
+			else if (unshare)
+				fault_flags |= FAULT_FLAG_UNSHARE;
 			if (locked)
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
 					FAULT_FLAG_KILLABLE;
@@ -6734,7 +6755,21 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 		goto out;
 	pte = huge_ptep_get((pte_t *)pmd);
 	if (pte_present(pte)) {
-		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
+		struct page *head_page = pmd_page(*pmd);
+
+		/*
+		 * follow_huge_pmd() is only called when coming via
+		 * follow_page(), where we set FOLL_NOUNSHARE. Ordinary GUP
+		 * goes via follow_hugetlb_page(), where we can properly unshare
+		 * if required.
+		 */
+		if (WARN_ON_ONCE(!huge_pte_write(pte) &&
+				 gup_must_unshare(flags, head_page, true))) {
+			page = NULL;
+			goto out;
+		}
+
+		page = head_page + ((address & ~PMD_MASK) >> PAGE_SHIFT);
 		/*
 		 * try_grab_page() should always succeed here, because: a) we
 		 * hold the pmd (ptl) lock, and b) we've just checked that the
-- 
2.31.1

