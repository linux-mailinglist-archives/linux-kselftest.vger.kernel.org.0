Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C46C361276
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 20:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhDOSsv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhDOSsb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 14:48:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FE4C061357
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r14so2279723ybm.18
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v9xlEQGtGuPspP2FjEugb5gdXLKMl4Mugi5uBEOH2nE=;
        b=T76082fI83VPlMoiWddX0ek2eIvKb+iWRgPwBr/bQQcE+4gU7Hm1ARnNpyrYPHsrMH
         fZVLmq3xMQPc+SjQJH53xUmSnPzcGpt7Yhsz0umHzPtX4F7pJTIIm65ayFJ5GS/wLJia
         Ezf8ieDfzUM8jcA9PKa1pEVCOX+wGq/UO7ZZBupYQIUIn6vsOEb1UV90XtTEFhCtbIRA
         r74jip5n+x7v1Cz1L/UhdIhLzAUoKQL03ldu15y+vaUPeYWU6b6cA7aXG1PgTriDZwqE
         Mgou+VD+EviCbOXjlFXkexpeZk4QlLCqusVoTU808jV3JqanmigKzKzBDtLpzmiAi96j
         d+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v9xlEQGtGuPspP2FjEugb5gdXLKMl4Mugi5uBEOH2nE=;
        b=oLrNDg652g8oSk3BuFVbc1j9XAtuIwyIHLhoRn901xTUHsJpCxIFiAAEu1675loM9M
         laNdL2Tgh/zYqyCEUSiA1kKQg9RX/2hz7Rlm/LRj/sd0K/SshRBGxHdDL0oklPc+0pm8
         sVfPDsuV2B+u78afF+XF3gwnpokVGgMA4LnYOVUJHdpmhwhQag4+lm80+epXdzjOPwGf
         Ywbiy+eoxyWmPiH6wLaJnMw3WrANuBMKyAUdwherNLYfZOeAWyUhEOE2i2QI/nNwIcjy
         egnf4s7vJZzWTGeMpwfrel5dMoQBwX+E3NAtCapaRzY8LlbYcS1TBW2Y7uL5yQQfFHfK
         8Aqw==
X-Gm-Message-State: AOAM53332man17Jh3bsJyC0uwrYRnTg9wwldOIvwVwGxFjl5BU2GAOIL
        QcgVHEi1Ok4HHXi77UehWjkgWwlFiV0doL0VyAu/
X-Google-Smtp-Source: ABdhPJxnvnR2fSiF7/uDugL3YYnELQACt0bs3YY9kPzKO3XsbPoyXMWcq8d/8b6Z/82f2of4G//QSzvNdpAB2fOLYovl
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:21b1:6e5c:b371:7e3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:becd:: with SMTP id
 k13mr5873788ybm.459.1618512472368; Thu, 15 Apr 2021 11:47:52 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:47:31 -0700
In-Reply-To: <20210415184732.3410521-1-axelrasmussen@google.com>
Message-Id: <20210415184732.3410521-10-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210415184732.3410521-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 09/10] userfaultfd/shmem: modify shmem_mcopy_atomic_pte to
 use install_ptes
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In a previous commit, we added the mcopy_atomic_install_ptes() helper.
This helper does the job of setting up PTEs for an existing page, to map
it into a given VMA. It deals with both the anon and shmem cases, as
well as the shared and private cases.

In other words, shmem_mcopy_atomic_pte() duplicates a case it already
handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
directly, to reduce code duplication.

This requires that we refactor shmem_mcopy_atomic-pte() a bit:

Instead of doing accounting (shmem_recalc_inode() et al) part-way
through the PTE setup, do it beforehand. This frees up
mcopy_atomic_install_ptes() from having to care about this accounting,
but it does mean we need to clean it up if we get a failure afterwards
(shmem_uncharge()).

We can *almost* use shmem_charge() to do this, reducing code
duplication. But, it does `inode->i_mapping->nrpages++`, which would
double-count since shmem_add_to_page_cache() also does this.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h |  5 ++++
 mm/shmem.c                    | 52 +++++++----------------------------
 mm/userfaultfd.c              | 25 ++++++++---------
 3 files changed, 27 insertions(+), 55 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 794d1538b8ba..3e20bfa9ef80 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -53,6 +53,11 @@ enum mcopy_atomic_mode {
 	MCOPY_ATOMIC_CONTINUE,
 };
 
+extern int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+				     struct vm_area_struct *dst_vma,
+				     unsigned long dst_addr, struct page *page,
+				     bool newly_allocated, bool wp_copy);
+
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
 			    unsigned long src_start, unsigned long len,
 			    bool *mmap_changing, __u64 mode);
diff --git a/mm/shmem.c b/mm/shmem.c
index 30c0bb501dc9..64dc6d2a2e76 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2378,10 +2378,8 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	struct address_space *mapping = inode->i_mapping;
 	gfp_t gfp = mapping_gfp_mask(mapping);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
-	spinlock_t *ptl;
 	void *page_kaddr;
 	struct page *page;
-	pte_t _dst_pte, *dst_pte;
 	int ret;
 	pgoff_t max_off;
 
@@ -2391,8 +2389,10 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	if (!*pagep) {
 		page = shmem_alloc_page(gfp, info, pgoff);
-		if (!page)
-			goto out_unacct_blocks;
+		if (!page) {
+			shmem_inode_unacct_blocks(inode, 1);
+			goto out;
+		}
 
 		if (!zeropage) {	/* COPY */
 			page_kaddr = kmap_atomic(page);
@@ -2432,59 +2432,27 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (ret)
 		goto out_release;
 
-	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
-	if (dst_vma->vm_flags & VM_WRITE)
-		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
-	else {
-		/*
-		 * We don't set the pte dirty if the vma has no
-		 * VM_WRITE permission, so mark the page dirty or it
-		 * could be freed from under us. We could do it
-		 * unconditionally before unlock_page(), but doing it
-		 * only if VM_WRITE is not set is faster.
-		 */
-		set_page_dirty(page);
-	}
-
-	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
-
-	ret = -EFAULT;
-	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(pgoff >= max_off))
-		goto out_release_unlock;
-
-	ret = -EEXIST;
-	if (!pte_none(*dst_pte))
-		goto out_release_unlock;
-
-	lru_cache_add(page);
-
 	spin_lock_irq(&info->lock);
 	info->alloced++;
 	inode->i_blocks += BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
-	inc_mm_counter(dst_mm, mm_counter_file(page));
-	page_add_file_rmap(page, false);
-	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
+					page, true, false);
+	if (ret)
+		goto out_release_uncharge;
 
-	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(dst_vma, dst_addr, dst_pte);
-	pte_unmap_unlock(dst_pte, ptl);
 	unlock_page(page);
 	ret = 0;
 out:
 	return ret;
-out_release_unlock:
-	pte_unmap_unlock(dst_pte, ptl);
-	ClearPageDirty(page);
+out_release_uncharge:
 	delete_from_page_cache(page);
+	shmem_uncharge(inode, 1);
 out_release:
 	unlock_page(page);
 	put_page(page);
-out_unacct_blocks:
-	shmem_inode_unacct_blocks(inode, 1);
 	goto out;
 }
 #endif /* CONFIG_USERFAULTFD */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8df0438f5d6a..3f73ba0b99f0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -51,18 +51,13 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 /*
  * Install PTEs, to map dst_addr (within dst_vma) to page.
  *
- * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
- * whether or not dst_vma is VM_SHARED. It also handles the more general
- * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
- * backed, or not).
- *
- * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
- * shmem_mcopy_atomic_pte instead.
+ * This function handles both MCOPY_ATOMIC_NORMAL and _CONTINUE for both shmem
+ * and anon, and for both shared and private VMAs.
  */
-static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
-				     struct vm_area_struct *dst_vma,
-				     unsigned long dst_addr, struct page *page,
-				     bool newly_allocated, bool wp_copy)
+int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+			      struct vm_area_struct *dst_vma,
+			      unsigned long dst_addr, struct page *page,
+			      bool newly_allocated, bool wp_copy)
 {
 	int ret;
 	pte_t _dst_pte, *dst_pte;
@@ -116,8 +111,12 @@ static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	else
 		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
 
-	if (newly_allocated)
-		lru_cache_add_inactive_or_unevictable(page, dst_vma);
+	if (newly_allocated) {
+		if (vma_is_shmem(dst_vma) && vm_shared)
+			lru_cache_add(page);
+		else
+			lru_cache_add_inactive_or_unevictable(page, dst_vma);
+	}
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
-- 
2.31.1.368.gbe11c130af-goog

