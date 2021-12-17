Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38823478A03
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhLQLeS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:34:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235517AbhLQLeL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcIVNk9FqOqzjRi5JqPcDJ4wYU12HMN6l6PoOYX4XeU=;
        b=SloD0UewO5ZzG3HL4trjWPnYfYz09MR+lAclOXDuhQmeQ9JJVt2eaZjxyP3uUjFojzaeug
        sm1V9XK6JLq+6Vz25daVoFkVZppARDympxcZSoy5is09VQxrv01yZzPeQeyjy4VPLJXx+K
        5cLWf5lYJsaaF7knmu4N5vLgS9jWDow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-oSDSQLLFP4mmgy0batSDew-1; Fri, 17 Dec 2021 06:34:07 -0500
X-MC-Unique: oSDSQLLFP4mmgy0batSDew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FC52101AFAC;
        Fri, 17 Dec 2021 11:34:05 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 307788ACF7;
        Fri, 17 Dec 2021 11:33:59 +0000 (UTC)
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
Subject: [PATCH v1 07/11] mm: gup: trigger unsharing via FAULT_FLAG_UNSHARE when required (!hugetlb)
Date:   Fri, 17 Dec 2021 12:30:45 +0100
Message-Id: <20211217113049.23850-8-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is currently possible for a child process to observe modifications of
anonymous pages by the parent process after fork() in some cases, which is
not only a userspace visible violation of the POSIX semantics of
MAP_PRIVATE, but more importantly a real security issue.

This issue, including other related COW issues, has been summarized in [1]:
"
  1. Observing Memory Modifications of Private Pages From A Child Process

  Long story short: process-private memory might not be as private as you
  think once you fork(): successive modifications of private memory
  regions in the parent process can still be observed by the child
  process, for example, by smart use of vmsplice()+munmap().

  The core problem is that pinning pages readable in a child process, such
  as done via the vmsplice system call, can result in a child process
  observing memory modifications done in the parent process the child is
  not supposed to observe. [1] contains an excellent summary and [2]
  contains further details. This issue was assigned CVE-2020-29374 [9].

  For this to trigger, it's required to use a fork() without subsequent
  exec(), for example, as used under Android zygote. Without further
  details about an application that forks less-privileged child processes,
  one cannot really say what's actually affected and what's not -- see the
  details section the end of this mail for a short sshd/openssh analysis.

  While commit 17839856fd58 ("gup: document and work around "COW can break
  either way" issue") fixed this issue and resulted in other problems
  (e.g., ptrace on pmem), commit 09854ba94c6a ("mm: do_wp_page()
  simplification") re-introduced part of the problem unfortunately.

  The original reproducer can be modified quite easily to use THP [3] and
  make the issue appear again on upstream kernels. I modified it to use
  hugetlb [4] and it triggers as well. The problem is certainly less
  severe with hugetlb than with THP; it merely highlights that we still
  have plenty of open holes we should be closing/fixing.

  Regarding vmsplice(), the only known workaround is to disallow the
  vmsplice() system call ... or disable THP and hugetlb. But who knows
  what else is affected (RDMA? O_DIRECT?) to achieve the same goal -- in
  the end, it's a more generic issue.
"

This security issue / MAP_PRIVATE POSIX violation was first reported by
Jann Horn on 27 May 2020 and it currently affects anonymous THP and
hugetlb.

Ordinary anonymous pages are currently not affected, because the COW logic
was changed in commit 09854ba94c6a ("mm: do_wp_page() simplification")
for them to COW on "page_count() != 1" instead of "mapcount > 1", which
unfortunately results in other COW issues, some of them documented in [1]
as well.

To fix this COW issue once and for all, introduce GUP-triggered unsharing
that can be conditionally triggered via FAULT_FLAG_UNSHARE. In contrast to
traditional COW, unsharing will leave the copied page mapped
write-protected in the page table, not having the semantics of a write
fault.

Logically, unsharing is triggered "early", as soon as GUP performs the
action that could result in a COW getting missed later and the security
issue triggering: however, unsharing is not triggered as before via a
write fault with undesired side effects.

GUP triggers unsharing if all of the following conditions are met:
* The page is mapped R/O
* We have an anonymous page, excluding KSM
* We want to read (!FOLL_WRITE)
* Unsharing is not disabled (!FOLL_NOUNSHARE)
* We want to take a reference (FOLL_GET or FOLL_PIN)
* The page is a shared anonymous page: mapcount > 1

As this patch introduces the same unsharing logic also for ordinary
PTE-mapped anonymous pages, it also paves the way to fix the other known
COW related issues documented in [1] without reintroducing the security
issue or reintroducing other issues we observed in the past (e.g., broken
ptrace on pmem).

We better leave the follow_page() API alone: it's an internal API and
its users don't actually allow for user space to read page content and they
don't expect to get "NULL" for actually present pages -- because they
usually don't trigger faults. Introduce and use FOLL_NOUNSHARE for that
purpose. We could also think about using it for other corner cases, such
as get_dump_page().

Note: GUP users that use memory notifiers to synchronize with the MM
      don't have to bother about unsharing: they don't actually take
      a reference on the pages and are properly synchronized against MM
      changes to never result in consistency issues.

Add a TODO item that the mechanism should be extended to improve GUP
long-term as a whole, avoiding the requirement for FOLL_WRITE|FOLL_FORCE.

hugetlb case will be handled separately.

This commit is based on prototype patches by Andrea.

[1] https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com

Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 10 ++++++
 mm/gup.c           | 90 ++++++++++++++++++++++++++++++++++++++++++++--
 mm/huge_memory.c   |  7 ++++
 3 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 37d1fb2f865e..ebcdaed60701 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2975,6 +2975,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
 #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
+#define FOLL_NOUNSHARE	0x100000 /* don't trigger unsharing on shared anon pages */
 
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
@@ -3029,6 +3030,12 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
  * releasing pages: get_user_pages*() pages must be released via put_page(),
  * while pin_user_pages*() pages must be released via unpin_user_page().
  *
+ * FOLL_NOUNSHARE should be set when no unsharing should be triggered when
+ * eventually taking a read-only reference on a shared anonymous page, because
+ * we are sure that user space cannot use that reference for reading the page
+ * after eventually unmapping the page. FOLL_NOUNSHARE is implicitly set for the
+ * follow_page() API.
+ *
  * Please see Documentation/core-api/pin_user_pages.rst for more information.
  */
 
@@ -3043,6 +3050,9 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 	return 0;
 }
 
+extern bool gup_must_unshare(unsigned int flags, struct page *page,
+			     bool is_head);
+
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
diff --git a/mm/gup.c b/mm/gup.c
index 2c51e9748a6a..2a83388c3fb4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,6 +29,53 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
+/*
+ * Indicates for which pages that are write-protected in the page table,
+ * whether GUP has to trigger unsharing via FAULT_FLAG_UNSHARE such that the
+ * GUP pin will remain consistent with the pages mapped into the page tables
+ * of the MM.
+ *
+ * This handling is required to guarantee that a child process that triggered
+ * a read-only GUP before unmapping the page of interest cannot observe
+ * modifications of shared anonymous pages with COW semantics in the parent
+ * after fork().
+ *
+ * TODO: although the security issue described does no longer apply in any case,
+ * the full consistency between the pinned pages and the pages mapped into the
+ * page tables of the MM only apply to short-term pinnings only. For
+ * FOLL_LONGTERM, FOLL_WRITE|FOLL_FORCE is required for now, which can be
+ * inefficient and still result in some consistency issues. Extend this
+ * mechanism to also provide full synchronicity to FOLL_LONGTERM, avoiding
+ * FOLL_WRITE|FOLL_FORCE.
+ *
+ * This function is safe to be called in IRQ context.
+ */
+bool gup_must_unshare(unsigned int flags, struct page *page, bool is_head)
+{
+	/* We only care about read faults where unsharing is desired. */
+	if (flags & (FOLL_WRITE | FOLL_NOUNSHARE))
+		return false;
+	/*
+	 * We only care when the reference count of the page is to get
+	 * increased. In particular, GUP users that rely on memory notifiers
+	 * instead don't have to trigger unsharing.
+	 */
+	if (!(flags & (FOLL_GET|FOLL_PIN)))
+		return false;
+	if (!PageAnon(page))
+		return false;
+	if (PageKsm(page))
+		return false;
+	if (PageHuge(page))
+		/* TODO: handle hugetlb as well. */
+		return false;
+	if (is_head) {
+		VM_BUG_ON(!PageTransHuge(page));
+		return page_trans_huge_mapcount(page, NULL) > 1;
+	}
+	return page_mapcount(page) > 1;
+}
+
 static void hpage_pincount_add(struct page *page, int refs)
 {
 	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
@@ -543,6 +590,14 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		}
 	}
 
+	/*
+	 * If unsharing is required, keep retrying to unshare until the
+	 * page becomes exclusive.
+	 */
+	if (!pte_write(pte) && gup_must_unshare(flags, page, false)) {
+		page = ERR_PTR(-EMLINK);
+		goto out;
+	}
 	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
 	if (unlikely(!try_grab_page(page, flags))) {
 		page = ERR_PTR(-ENOMEM);
@@ -790,6 +845,11 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  * When getting pages from ZONE_DEVICE memory, the @ctx->pgmap caches
  * the device's dev_pagemap metadata to avoid repeating expensive lookups.
  *
+ * When getting an anonymous page and the caller has to trigger unsharing
+ * of a shared anonymous page first, -EMLINK is returned. The caller should
+ * trigger a fault with FAULT_FLAG_UNSHARE set. With FOLL_NOUNSHARE set, will
+ * never require unsharing and consequently not return -EMLINK.
+ *
  * On output, the @ctx->page_mask is set according to the size of the page.
  *
  * Return: the mapped (struct page *), %NULL if no mapping exists, or
@@ -845,6 +905,12 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	if (vma_is_secretmem(vma))
 		return NULL;
 
+	/*
+	 * Don't require unsharing in case we stumble over a read-only mapped,
+	 * shared anonymous page: this is an internal API only and callers don't
+	 * actually use it for exposing page content to user space.
+	 */
+	foll_flags |= FOLL_NOUNSHARE;
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
@@ -910,7 +976,8 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
  * is, *@locked will be set to 0 and -EBUSY returned.
  */
 static int faultin_page(struct vm_area_struct *vma,
-		unsigned long address, unsigned int *flags, int *locked)
+		unsigned long address, unsigned int *flags, bool unshare,
+		int *locked)
 {
 	unsigned int fault_flags = 0;
 	vm_fault_t ret;
@@ -935,6 +1002,12 @@ static int faultin_page(struct vm_area_struct *vma,
 		 */
 		fault_flags |= FAULT_FLAG_TRIED;
 	}
+	if (unshare) {
+		VM_BUG_ON(unshare && *flags & FOLL_NOUNSHARE);
+		fault_flags |= FAULT_FLAG_UNSHARE;
+		/* FAULT_FLAG_WRITE and FAULT_FLAG_UNSHARE are incompatible */
+		VM_BUG_ON(fault_flags & FAULT_FLAG_WRITE);
+	}
 
 	ret = handle_mm_fault(vma, address, fault_flags, NULL);
 	if (ret & VM_FAULT_ERROR) {
@@ -1156,8 +1229,9 @@ static long __get_user_pages(struct mm_struct *mm,
 		cond_resched();
 
 		page = follow_page_mask(vma, start, foll_flags, &ctx);
-		if (!page) {
-			ret = faultin_page(vma, start, &foll_flags, locked);
+		if (!page || PTR_ERR(page) == -EMLINK) {
+			ret = faultin_page(vma, start, &foll_flags,
+					   PTR_ERR(page) == -EMLINK, locked);
 			switch (ret) {
 			case 0:
 				goto retry;
@@ -2311,6 +2385,11 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			goto pte_unmap;
 		}
 
+		if (!pte_write(pte) && gup_must_unshare(flags, page, false)) {
+			put_compound_head(head, 1, flags);
+			goto pte_unmap;
+		}
+
 		VM_BUG_ON_PAGE(compound_head(page) != head, page);
 
 		/*
@@ -2554,6 +2633,11 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		return 0;
 	}
 
+	if (!pmd_write(orig) && gup_must_unshare(flags, head, true)) {
+		put_compound_head(head, refs, flags);
+		return 0;
+	}
+
 	*nr += refs;
 	SetPageReferenced(head);
 	return 1;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1685821525e8..57842e8b13d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1375,6 +1375,13 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	page = pmd_page(*pmd);
 	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
 
+	/*
+	 * If unsharing is required, keep retrying to unshare until the
+	 * page becomes exclusive.
+	 */
+	if (!pmd_write(*pmd) && gup_must_unshare(flags, page, true))
+		return ERR_PTR(-EMLINK);
+
 	if (!try_grab_page(page, flags))
 		return ERR_PTR(-ENOMEM);
 
-- 
2.31.1

