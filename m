Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52715371F3A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhECSJB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 14:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhECSIt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 14:08:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44501C061344
        for <linux-kselftest@vger.kernel.org>; Mon,  3 May 2021 11:07:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j63-20020a25d2420000b02904d9818b80e8so4277666ybg.14
        for <linux-kselftest@vger.kernel.org>; Mon, 03 May 2021 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mgeEBSGDh62ytbvMSwCqj+rl6kmACCXPYm0spOxIoFQ=;
        b=dV1cIFFeG2aERZIN1kEtGfTQj7HwfDfrrcSrpzLK/f2K8KMylB2QXzzL4BKaxoDgEc
         veKlwAFBdXrSBJ5rP0wOOCpNJluik9CC/Ok608gZ2OgGNJEdGKbGtJAjobBL+/jQhwdo
         cVWazsVkaBKxjMYZEFBtTgGBsyfpRSQY0Kc4gSBFZgMsIgP6X+cfRlgC9l+MCuhK1V2d
         KOK98GFIDAafdmVMLZXggAGxd+jtf8NZ17gY2wifTjetYG6YAfO9eot21zEUQNrEiav3
         JmwWBTB98Fr1+n9rqMY3TUn4gfzap5xJYj0KGlioeU9rH+xWzNiXvzH8kA/1nRL9XP4D
         FGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mgeEBSGDh62ytbvMSwCqj+rl6kmACCXPYm0spOxIoFQ=;
        b=k+FC7HAsoe1wNNaAQ7qNNyo1HEcyrlWTgDeYRnaK1ggqTiYtQELyEsBN3eIlyTJsfG
         qWXDkDzOEnQ7kGv/jO62BJoFhzQje9jQ3K7xBbPmsw/sv7pe+Hm7BaX7QqvKuLzDLDyh
         XYIpBvRv/jIQWYVCduf77g/kkwcEfQ+tkuzcHPzgjug0uJTCwxcMBUUKqYctgHPCCeSp
         cTGwZhvDUEzOyAQNe84w+iVKPfINZwB58VYzZRZrXV81Er0cVoqvoYOsIqyo4qIrHIyd
         6UuezZIXOjF63EXWA+0fCgrTEMG4B+9Dq9dxNSDCWU+aooRwaT/9e3kKCNJGlHuGAz9i
         ycOQ==
X-Gm-Message-State: AOAM530anU1BOI5DlOrEEeTL9CJM+I19PCOD0pv1VF3hJxJxyJbWZMjA
        ZsvcpQ/hb/fp9lsTLWtqgQDsrO6E031AQKJ+k2Eg
X-Google-Smtp-Source: ABdhPJwJ6SP7JGkjnl+bcTQRe27B+KvmXwxZSqJ8x4DW2HmOmcxi5K8Q+abD9f3MoH9Y+Hz123oZ/DZUPBIplOBXSRH1
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:a25:2407:: with SMTP id
 k7mr9130284ybk.404.1620065270439; Mon, 03 May 2021 11:07:50 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:31 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 04/10] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
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

With this change, userspace can resolve a minor fault within a
shmem-backed area with a UFFDIO_CONTINUE ioctl. The semantics for this
match those for hugetlbfs - we look up the existing page in the page
cache, and install a PTE for it.

This commit introduces a new helper: mfill_atomic_install_pte.

Why handle UFFDIO_CONTINUE for shmem in mm/userfaultfd.c, instead of in
shmem.c? The existing userfault implementation only relies on shmem.c
for VM_SHARED VMAs. However, minor fault handling / CONTINUE work just
fine for !VM_SHARED VMAs as well. We'd prefer to handle CONTINUE for
shmem in one place, regardless of shared/private (to reduce code
duplication).

Why add a new mfill_atomic_install_pte helper? A problem we have with
continue is that shmem_mfill_atomic_pte() and mcopy_atomic_pte() are
*close* to what we want, but not exactly. We do want to setup the PTEs
in a CONTINUE operation, but we don't want to e.g. allocate a new page,
charge it (e.g. to the shmem inode), manipulate various flags, etc. Also
we have the problem stated above: shmem_mfill_atomic_pte() and
mcopy_atomic_pte() both handle one-half of the problem (shared /
private) continue cares about. So, introduce mcontinue_atomic_pte(), to
handle all of the shmem continue cases. Introduce the helper so it
doesn't duplicate code with mcopy_atomic_pte().

In a future commit, shmem_mfill_atomic_pte() will also be modified to
use this new helper. However, since this is a bigger refactor, it seems
most clear to do it as a separate change.

Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/userfaultfd.c | 172 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 127 insertions(+), 45 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 242b7a04c16d..d1ac73a0d2a9 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -48,6 +48,83 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 	return dst_vma;
 }
 
+/*
+ * Install PTEs, to map dst_addr (within dst_vma) to page.
+ *
+ * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
+ * whether or not dst_vma is VM_SHARED. It also handles the more general
+ * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
+ * backed, or not).
+ *
+ * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
+ * shmem_mcopy_atomic_pte instead.
+ */
+static int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+				    struct vm_area_struct *dst_vma,
+				    unsigned long dst_addr, struct page *page,
+				    bool newly_allocated, bool wp_copy)
+{
+	int ret;
+	pte_t _dst_pte, *dst_pte;
+	bool writable = dst_vma->vm_flags & VM_WRITE;
+	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
+	bool page_in_cache = page->mapping;
+	spinlock_t *ptl;
+	struct inode *inode;
+	pgoff_t offset, max_off;
+
+	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
+	if (page_in_cache && !vm_shared)
+		writable = false;
+	if (writable || !page_in_cache)
+		_dst_pte = pte_mkdirty(_dst_pte);
+	if (writable) {
+		if (wp_copy)
+			_dst_pte = pte_mkuffd_wp(_dst_pte);
+		else
+			_dst_pte = pte_mkwrite(_dst_pte);
+	}
+
+	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+
+	if (vma_is_shmem(dst_vma)) {
+		/* serialize against truncate with the page table lock */
+		inode = dst_vma->vm_file->f_inode;
+		offset = linear_page_index(dst_vma, dst_addr);
+		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+		ret = -EFAULT;
+		if (unlikely(offset >= max_off))
+			goto out_unlock;
+	}
+
+	ret = -EEXIST;
+	if (!pte_none(*dst_pte))
+		goto out_unlock;
+
+	if (page_in_cache)
+		page_add_file_rmap(page, false);
+	else
+		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+
+	/*
+	 * Must happen after rmap, as mm_counter() checks mapping (via
+	 * PageAnon()), which is set by __page_set_anon_rmap().
+	 */
+	inc_mm_counter(dst_mm, mm_counter(page));
+
+	if (newly_allocated)
+		lru_cache_add_inactive_or_unevictable(page, dst_vma);
+
+	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+
+	/* No need to invalidate - it was non-present before */
+	update_mmu_cache(dst_vma, dst_addr, dst_pte);
+	ret = 0;
+out_unlock:
+	pte_unmap_unlock(dst_pte, ptl);
+	return ret;
+}
+
 static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    pmd_t *dst_pmd,
 			    struct vm_area_struct *dst_vma,
@@ -56,13 +133,9 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    struct page **pagep,
 			    bool wp_copy)
 {
-	pte_t _dst_pte, *dst_pte;
-	spinlock_t *ptl;
 	void *page_kaddr;
 	int ret;
 	struct page *page;
-	pgoff_t offset, max_off;
-	struct inode *inode;
 
 	if (!*pagep) {
 		ret = -ENOMEM;
@@ -99,43 +172,12 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL))
 		goto out_release;
 
-	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
-	if (dst_vma->vm_flags & VM_WRITE) {
-		if (wp_copy)
-			_dst_pte = pte_mkuffd_wp(_dst_pte);
-		else
-			_dst_pte = pte_mkwrite(_dst_pte);
-	}
-
-	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
-	if (dst_vma->vm_file) {
-		/* the shmem MAP_PRIVATE case requires checking the i_size */
-		inode = dst_vma->vm_file->f_inode;
-		offset = linear_page_index(dst_vma, dst_addr);
-		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-		ret = -EFAULT;
-		if (unlikely(offset >= max_off))
-			goto out_release_uncharge_unlock;
-	}
-	ret = -EEXIST;
-	if (!pte_none(*dst_pte))
-		goto out_release_uncharge_unlock;
-
-	inc_mm_counter(dst_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
-	lru_cache_add_inactive_or_unevictable(page, dst_vma);
-
-	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
-
-	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(dst_vma, dst_addr, dst_pte);
-
-	pte_unmap_unlock(dst_pte, ptl);
-	ret = 0;
+	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+				       page, true, wp_copy);
+	if (ret)
+		goto out_release;
 out:
 	return ret;
-out_release_uncharge_unlock:
-	pte_unmap_unlock(dst_pte, ptl);
 out_release:
 	put_page(page);
 	goto out;
@@ -176,6 +218,41 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	return ret;
 }
 
+/* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
+static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
+				pmd_t *dst_pmd,
+				struct vm_area_struct *dst_vma,
+				unsigned long dst_addr,
+				bool wp_copy)
+{
+	struct inode *inode = file_inode(dst_vma->vm_file);
+	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
+	struct page *page;
+	int ret;
+
+	ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
+	if (ret)
+		goto out;
+	if (!page) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+				       page, false, wp_copy);
+	if (ret)
+		goto out_release;
+
+	unlock_page(page);
+	ret = 0;
+out:
+	return ret;
+out_release:
+	unlock_page(page);
+	put_page(page);
+	goto out;
+}
+
 static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 {
 	pgd_t *pgd;
@@ -415,11 +492,16 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 						unsigned long dst_addr,
 						unsigned long src_addr,
 						struct page **page,
-						bool zeropage,
+						enum mcopy_atomic_mode mode,
 						bool wp_copy)
 {
 	ssize_t err;
 
+	if (mode == MCOPY_ATOMIC_CONTINUE) {
+		return mcontinue_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+					    wp_copy);
+	}
+
 	/*
 	 * The normal page fault path for a shmem will invoke the
 	 * fault, fill the hole in the file and COW it right away. The
@@ -431,7 +513,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	 * and not in the radix tree.
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
-		if (!zeropage)
+		if (mode == MCOPY_ATOMIC_NORMAL)
 			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					       dst_addr, src_addr, page,
 					       wp_copy);
@@ -441,7 +523,8 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	} else {
 		VM_WARN_ON_ONCE(wp_copy);
 		err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
-					     dst_addr, src_addr, zeropage,
+					     dst_addr, src_addr,
+					     mode != MCOPY_ATOMIC_NORMAL,
 					     page);
 	}
 
@@ -463,7 +546,6 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	long copied;
 	struct page *page;
 	bool wp_copy;
-	bool zeropage = (mcopy_mode == MCOPY_ATOMIC_ZEROPAGE);
 
 	/*
 	 * Sanitize the command parameters:
@@ -526,7 +608,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-	if (mcopy_mode == MCOPY_ATOMIC_CONTINUE)
+	if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
 		goto out_unlock;
 
 	/*
@@ -574,7 +656,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
 		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       src_addr, &page, zeropage, wp_copy);
+				       src_addr, &page, mcopy_mode, wp_copy);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
-- 
2.31.1.527.g47e6f16901-goog

