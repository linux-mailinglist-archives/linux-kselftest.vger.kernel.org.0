Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A925C478A00
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhLQLeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235495AbhLQLeF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MstCAevuD1qvpTctpkyVpFQ9Km+HVMM2bhgtFFKdRTg=;
        b=KluuusnFWw+Z/Xq5jPOnT7RaRVL9rhjD1ckWWkKjoxEyqatG9W3nwg3cVeAFYgifaShvLk
        w0Ge+Nne2LrgoZPuoFnJjJoZXoEKwxH/GcIsK+J1Gf0aE8D7OA3Zuhn29b0mXHuvetmTji
        SX6FaqAYJSYqDbIGz7dG+XQv7BeH24A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-marQ5KkgObO5qIOHzCa4PA-1; Fri, 17 Dec 2021 06:34:01 -0500
X-MC-Unique: marQ5KkgObO5qIOHzCa4PA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C784C101AFAB;
        Fri, 17 Dec 2021 11:33:58 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 735F48D5B6;
        Fri, 17 Dec 2021 11:33:52 +0000 (UTC)
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
Subject: [PATCH v1 06/11] mm: support GUP-triggered unsharing via FAULT_FLAG_UNSHARE (!hugetlb)
Date:   Fri, 17 Dec 2021 12:30:44 +0100
Message-Id: <20211217113049.23850-7-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

FAULT_FLAG_UNSHARE is a new type of page fault applicable to COW-able
anonymous memory (including hugetlb but excluding KSM) and its purpose is
to allow for unsharing of shared anonymous pages on selected GUP *read*
access, in comparison to the traditional COW on *write* access.

In contrast to a COW, GUP-triggered unsharing will still maintain the write
protection. It will be triggered by GUP to properly prevent a child process
from finding ways via GUP to observe memory modifications of anonymous
memory of the parent process after fork().

Rename the relevant functions to make it clear whether we're dealing
with unsharing, cow, or both.

The hugetlb part will be added separately.

This commit is based on prototype patches by Andrea.

Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |   4 ++
 mm/memory.c        | 136 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 119 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..37d1fb2f865e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -436,6 +436,9 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to unshare a
+ *                      shared anonymous page (-> mapped R/O). Does not apply
+ *                      to KSM.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -467,6 +470,7 @@ enum fault_flag {
 	FAULT_FLAG_REMOTE =		1 << 7,
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
+	FAULT_FLAG_UNSHARE =		1 << 10,
 };
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..7253a2ad4320 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2707,8 +2707,9 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
  * read non-atomically.  Before making any commitment, on those architectures
  * or configurations (e.g. i386 with PAE) which might give a mix of unmatched
  * parts, do_swap_page must check under lock before unmapping the pte and
- * proceeding (but do_wp_page is only called after already making such a check;
- * and do_anonymous_page can safely check later on).
+ * proceeding (but do_wp_page_cow/do_wp_page_unshare is only called after
+ * already making such a check; and do_anonymous_page can safely check later
+ * on).
  */
 static inline int pte_unmap_same(struct vm_fault *vmf)
 {
@@ -2726,8 +2727,8 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
 	return same;
 }
 
-static inline bool cow_user_page(struct page *dst, struct page *src,
-				 struct vm_fault *vmf)
+static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
+				       struct vm_fault *vmf)
 {
 	bool ret;
 	void *kaddr;
@@ -2952,7 +2953,8 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 }
 
 /*
- * Handle the case of a page which we actually need to copy to a new page.
+ * Handle the case of a page which we actually need to copy to a new page,
+ * either due to COW or unsharing.
  *
  * Called with mmap_lock locked and the old page referenced, but
  * without the ptl held.
@@ -2967,7 +2969,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
  *   held to the old page, as well as updating the rmap.
  * - In any case, unlock the PTL and drop the reference we took to the old page.
  */
-static vm_fault_t wp_page_copy(struct vm_fault *vmf)
+static vm_fault_t wp_page_copy(struct vm_fault *vmf, bool unshare)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
@@ -2991,7 +2993,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		if (!new_page)
 			goto oom;
 
-		if (!cow_user_page(new_page, old_page, vmf)) {
+		if (!__wp_page_copy_user(new_page, old_page, vmf)) {
 			/*
 			 * COW failed, if the fault was solved by other,
 			 * it's fine. If not, userspace would re-fault on
@@ -3033,7 +3035,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
-		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		if (unlikely(unshare)) {
+			if (pte_soft_dirty(vmf->orig_pte))
+				entry = pte_mksoft_dirty(entry);
+			if (pte_uffd_wp(vmf->orig_pte))
+				entry = pte_mkuffd_wp(entry);
+		} else {
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		}
 
 		/*
 		 * Clear the pte entry and flush it first, before updating the
@@ -3050,6 +3059,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * mmu page tables (such as kvm shadow page tables), we want the
 		 * new page to be mapped directly into the secondary page table.
 		 */
+		BUG_ON(unshare && pte_write(entry));
 		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
 		update_mmu_cache(vma, vmf->address, vmf->pte);
 		if (old_page) {
@@ -3109,6 +3119,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			free_swap_cache(old_page);
 		put_page(old_page);
 	}
+	if (unlikely(unshare))
+		return 0;
 	return page_copied ? VM_FAULT_WRITE : 0;
 oom_free_new:
 	put_page(new_page);
@@ -3118,6 +3130,70 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	return VM_FAULT_OOM;
 }
 
+static __always_inline vm_fault_t wp_page_cow(struct vm_fault *vmf)
+{
+	return wp_page_copy(vmf, false);
+}
+
+static __always_inline vm_fault_t wp_page_unshare(struct vm_fault *vmf)
+{
+	return wp_page_copy(vmf, true);
+}
+
+/*
+ * This routine handles present pages, when GUP tries to take a read-only
+ * pin on a shared anonymous page. It's similar to do_wp_page_cow(), except that
+ * it keeps the pages mapped read-only and doesn't apply to KSM pages.
+ *
+ * If a parent process forks a child process, we share anonymous pages between
+ * both processes with COW semantics. Both processes will map these now shared
+ * anonymous pages read-only, and any write access triggers unsharing via COW.
+ *
+ * If the child takes a read-only pin on such a page (i.e., FOLL_WRITE is not
+ * set) and then unmaps the target page, we have:
+ *
+ * * page has mapcount == 1 and refcount > 1
+ * * page is mapped read-only into the parent
+ * * page is pinned by the child and can still be read
+ *
+ * For now, we rely on refcount > 1 to perform the COW and trigger unsharing.
+ * However, that leads to other hard-to fix issues.
+ *
+ * GUP-triggered unsharing provides a parallel approach to trigger unsharing
+ * early, still allowing for relying on mapcount > 1 in COW code instead of on
+ * imprecise refcount > 1. Note that when we don't actually take a reference
+ * on the target page but instead use memory notifiers to synchronize to changes
+ * in the process page tables, unsharing is not required.
+ *
+ * Note that in the above scenario, it's impossible to distinguish during the
+ * write fault between:
+ *
+ * a) The parent process performed the pin and the child no longer has access
+ *    to the page.
+ *
+ * b) The child process performed the pin and the child still has access to the
+ *    page.
+ *
+ * In case of a), if we're dealing with a long-term read-only pin, the COW
+ * in the parent will result the pinned page differing from the page actually
+ * mapped into the process page tables in the parent: loss of synchronicity.
+ * Therefore, we really want to perform the copy when the read-only pin happens.
+ */
+static vm_fault_t do_wp_page_unshare(struct vm_fault *vmf)
+	__releases(vmf->ptl)
+{
+	vmf->page = vm_normal_page(vmf->vma, vmf->address, vmf->orig_pte);
+	if (vmf->page && PageAnon(vmf->page) && !PageKsm(vmf->page) &&
+	    page_mapcount(vmf->page) > 1) {
+		get_page(vmf->page);
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return wp_page_unshare(vmf);
+	}
+	vmf->page = NULL;
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
+}
+
 /**
  * finish_mkwrite_fault - finish page fault for a shared mapping, making PTE
  *			  writeable once the page is prepared
@@ -3226,7 +3302,7 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
  * but allow concurrent faults), with pte both mapped and locked.
  * We return with mmap_lock still held, but pte unmapped and unlocked.
  */
-static vm_fault_t do_wp_page(struct vm_fault *vmf)
+static vm_fault_t do_wp_page_cow(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -3258,7 +3334,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			return wp_pfn_shared(vmf);
 
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return wp_page_copy(vmf);
+		return wp_page_cow(vmf);
 	}
 
 	/*
@@ -3296,7 +3372,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return wp_page_copy(vmf);
+	return wp_page_cow(vmf);
 }
 
 static void unmap_mapping_range_vma(struct vm_area_struct *vma,
@@ -3670,7 +3746,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	if (vmf->flags & FAULT_FLAG_WRITE) {
-		ret |= do_wp_page(vmf);
+		ret |= do_wp_page_cow(vmf);
 		if (ret & VM_FAULT_ERROR)
 			ret &= VM_FAULT_ERROR;
 		goto out;
@@ -4428,6 +4504,16 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 /* `inline' is required to avoid gcc 4.1.2 build error */
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
+	if (vmf->flags & FAULT_FLAG_UNSHARE) {
+		/*
+		 * We'll simply split the THP and handle unsharing on the
+		 * PTE level. Unsharing only applies to anon THPs and we
+		 * shouldn't ever find them inside shared mappings.
+		 */
+		if (WARN_ON_ONCE(vmf->vma->vm_flags & VM_SHARED))
+			return 0;
+		goto split_fallback;
+	}
 	if (vma_is_anonymous(vmf->vma)) {
 		if (userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
@@ -4440,7 +4526,8 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 			return ret;
 	}
 
-	/* COW or write-notify handled on pte level: split pmd. */
+split_fallback:
+	/* COW, unsharing or write-notify handled on pte level: split pmd. */
 	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
 
 	return VM_FAULT_FALLBACK;
@@ -4551,8 +4638,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
-	if (!pte_present(vmf->orig_pte))
-		return do_swap_page(vmf);
+	if (!pte_present(vmf->orig_pte)) {
+		if (likely(!(vmf->flags & FAULT_FLAG_UNSHARE)))
+			return do_swap_page(vmf);
+		return 0;
+	}
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
@@ -4564,9 +4654,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
-	if (vmf->flags & FAULT_FLAG_WRITE) {
-		if (!pte_write(entry))
-			return do_wp_page(vmf);
+	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
+		if (!pte_write(entry)) {
+			if (vmf->flags & FAULT_FLAG_WRITE)
+				return do_wp_page_cow(vmf);
+			else
+				return do_wp_page_unshare(vmf);
+		}
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
@@ -4607,7 +4701,6 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.pgoff = linear_page_index(vma, address),
 		.gfp_mask = __get_fault_gfp_mask(vma),
 	};
-	unsigned int dirty = flags & FAULT_FLAG_WRITE;
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -4634,7 +4727,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 
 			/* NUMA case for anonymous PUDs would go here */
 
-			if (dirty && !pud_write(orig_pud)) {
+			if ((flags & FAULT_FLAG_WRITE) && !pud_write(orig_pud)) {
 				ret = wp_huge_pud(&vmf, orig_pud);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
@@ -4672,7 +4765,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf);
 
-			if (dirty && !pmd_write(vmf.orig_pmd)) {
+			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
+			    !pmd_write(vmf.orig_pmd)) {
 				ret = wp_huge_pmd(&vmf);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
-- 
2.31.1

