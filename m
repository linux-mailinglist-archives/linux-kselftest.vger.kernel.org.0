Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9944F6B14EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 23:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCHWT5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 17:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCHWTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 17:19:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0BE9609E
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 14:19:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w192-20020a25dfc9000000b009fe14931caaso148976ybg.7
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 14:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678313987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LvHQfBSgJpk2leJg2lbv23wkIb9ch0JlJ29o+UkLqLA=;
        b=Yz9Wf7aQWqLQu1CN+0EwInCRKNr1DZvHqklRMi8tSv9Sr1rghhBdpEihEd63RbUoa0
         2NRJujBJLTC3SpjGMRlifUR1fwSqU6aR7EVWjIhNnC7xz6dv0ZVz/cEGUem3moSNsQBs
         XfRbhbkuDe372oOYOP/U6vAvu4Wup3jUKLucRHtNKiunVDgWUp7QfzcB8SW7WoL7L0um
         Lp9LZwsGK/jZR42Tx3qTYyWARChru2UYNB2Hhq1LY8YGVuN2DUuPvNBD5GhwEN8+BBJr
         cl6f7pex42DgsZtrrBikRfz7crFb0JCd4BK26FQYBBq+XArctEwmIDjuZ9GLW2KyzIRr
         A0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvHQfBSgJpk2leJg2lbv23wkIb9ch0JlJ29o+UkLqLA=;
        b=CzP6inZ3aMQ40UMfLwQwwW9laVx8fiWfcI3rUy/LP7oIeISpDM/LRNqRrGHiCVrLBE
         D5HD0EPMH07HpZyOh/nzoxcFTr57IDYSmDThFhgigWK1XX4+T/b+rU8XTbB4UWy9GR87
         00MygmXO14orERmCbzvzldMlzSrwVN78vb2tmXgxyaGj4Jg0X/l4GNAX9MPEdOWw+syh
         UhWZO52YhoJ6J7q/uKvYjjQUmtWAlxm2Wc54Omc5pOOoZ+4SD11CnrJmzPNCuws86io1
         sJ+jXknAdK+4kuak+bWN0Es8NAEJmRB7Kk3XfVVsqgRJ8XOV3io6z57oDWQpoxXiNlrw
         0gIg==
X-Gm-Message-State: AO0yUKV/mDXq0n5Z2njGGqhCnn2O3EOwEP5wm7I7TcJu2um3YzhzCsEW
        1eUiYOcyU17h0UZ04oKgeZzwMt2QL7aB3SOlQopW
X-Google-Smtp-Source: AK7set9UW1FIPyZ8r+wZxfqJFfSITGVvxyKDazvFuPddI3cchLABBfsGdj4cnjKMOvoWWBNNOwQLCA920hU23FYdRvgk
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:96cb:1c04:7322:78a4])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:145:b0:ac2:a7a7:23c3 with
 SMTP id p5-20020a056902014500b00ac2a7a723c3mr7748521ybh.12.1678313986816;
 Wed, 08 Mar 2023 14:19:46 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:19:31 -0800
In-Reply-To: <20230308221932.1548827-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230308221932.1548827-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230308221932.1548827-4-axelrasmussen@google.com>
Subject: [PATCH v4 3/4] mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Many userfaultfd ioctl functions take both a 'mode' and a 'wp_copy'
argument. In future commits we plan to plumb the flags through to more
places, so we'd be proliferating the very long argument list even
further.

Let's take the time to simplify the argument list. Combine the two
arguments into one - and generalize, so when we add more flags in the
future, it doesn't imply more function arguments.

Since the modes (copy, zeropage, continue) are mutually exclusive, store
them as an integer value (0, 1, 2) in the low bits. Place combine-able
flag bits in the high bits.

This is quite similar to an earlier patch proposed by Nadav Amit
("userfaultfd: introduce uffd_flags" [1]). The main difference is that
patch only handled flags, whereas this patch *also* combines the "mode"
argument into the same type to shorten the argument list.

[1]: https://lore.kernel.org/all/20220619233449.181323-2-namit@vmware.com/

Acked-by: James Houghton <jthoughton@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c              |  5 ++-
 include/linux/hugetlb.h       | 10 ++---
 include/linux/shmem_fs.h      |  5 ++-
 include/linux/userfaultfd_k.h | 45 +++++++++++++--------
 mm/hugetlb.c                  | 12 +++---
 mm/shmem.c                    |  7 ++--
 mm/userfaultfd.c              | 76 ++++++++++++++++-------------------
 7 files changed, 83 insertions(+), 77 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 84d5d402214a..56e54e50414e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1714,6 +1714,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	struct uffdio_copy uffdio_copy;
 	struct uffdio_copy __user *user_uffdio_copy;
 	struct userfaultfd_wake_range range;
+	uffd_flags_t flags = 0;
 
 	user_uffdio_copy = (struct uffdio_copy __user *) arg;
 
@@ -1740,10 +1741,12 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 		goto out;
 	if (uffdio_copy.mode & ~(UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP))
 		goto out;
+	if (uffdio_copy.mode & UFFDIO_COPY_MODE_WP)
+		flags |= MFILL_ATOMIC_WP;
 	if (mmget_not_zero(ctx->mm)) {
 		ret = mfill_atomic_copy(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
 					uffdio_copy.len, &ctx->mmap_changing,
-					uffdio_copy.mode);
+					flags);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8b9325f77ac3..6270a4786584 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -162,9 +162,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
-			     enum mcopy_atomic_mode mode,
-			     struct page **pagep,
-			     bool wp_copy);
+			     uffd_flags_t flags,
+			     struct page **pagep);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -397,9 +396,8 @@ static inline int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 					   struct vm_area_struct *dst_vma,
 					   unsigned long dst_addr,
 					   unsigned long src_addr,
-					   enum mcopy_atomic_mode mode,
-					   struct page **pagep,
-					   bool wp_copy)
+					   uffd_flags_t flags,
+					   struct page **pagep)
 {
 	BUG();
 	return 0;
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index b82916c25e61..b7048bd88a8d 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -9,6 +9,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
+#include <linux/userfaultfd_k.h>
 
 /* inode in-kernel data */
 
@@ -155,11 +156,11 @@ extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
-				  bool zeropage, bool wp_copy,
+				  uffd_flags_t flags,
 				  struct page **pagep);
 #else /* !CONFIG_SHMEM */
 #define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
-			       src_addr, zeropage, wp_copy, pagep) ({ BUG(); 0; })
+			       src_addr, flags, pagep) ({ BUG(); 0; })
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ba79e296fcc7..4d7425684171 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -40,30 +40,43 @@ extern int sysctl_unprivileged_userfaultfd;
 
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
-/*
- * The mode of operation for __mcopy_atomic and its helpers.
- *
- * This is almost an implementation detail (mcopy_atomic below doesn't take this
- * as a parameter), but it's exposed here because memory-kind-specific
- * implementations (e.g. hugetlbfs) need to know the mode of operation.
- */
-enum mcopy_atomic_mode {
-	/* A normal copy_from_user into the destination range. */
-	MCOPY_ATOMIC_NORMAL,
-	/* Don't copy; map the destination range to the zero page. */
-	MCOPY_ATOMIC_ZEROPAGE,
-	/* Just install pte(s) with the existing page(s) in the page cache. */
-	MCOPY_ATOMIC_CONTINUE,
+/* A combined operation mode + behavior flags. */
+typedef unsigned int __bitwise uffd_flags_t;
+
+/* Mutually exclusive modes of operation. */
+enum mfill_atomic_mode {
+	MFILL_ATOMIC_COPY,
+	MFILL_ATOMIC_ZEROPAGE,
+	MFILL_ATOMIC_CONTINUE,
+	NR_MFILL_ATOMIC_MODES,
 };
 
+#define MFILL_ATOMIC_MODE_BITS (const_ilog2(NR_MFILL_ATOMIC_MODES - 1) + 1)
+#define MFILL_ATOMIC_BIT(nr) BIT(MFILL_ATOMIC_MODE_BITS + (nr))
+#define MFILL_ATOMIC_FLAG(nr) ((__force uffd_flags_t) MFILL_ATOMIC_BIT(nr))
+#define MFILL_ATOMIC_MODE_MASK ((__force uffd_flags_t) (MFILL_ATOMIC_BIT(0) - 1))
+
+static inline bool uffd_flags_has_mode(uffd_flags_t flags, enum mfill_atomic_mode expected)
+{
+	return (flags & MFILL_ATOMIC_MODE_MASK) == ((__force uffd_flags_t) expected);
+}
+
+static inline uffd_flags_t uffd_flags_set_mode(uffd_flags_t flags, enum mfill_atomic_mode mode)
+{
+	return flags | ((__force uffd_flags_t) mode);
+}
+
+/* Flags controlling behavior. */
+#define MFILL_ATOMIC_WP MFILL_ATOMIC_FLAG(0)
+
 extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
 				    struct vm_area_struct *dst_vma,
 				    unsigned long dst_addr, struct page *page,
-				    bool newly_allocated, bool wp_copy);
+				    bool newly_allocated, uffd_flags_t flags);
 
 extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
 				 unsigned long src_start, unsigned long len,
-				 atomic_t *mmap_changing, __u64 mode);
+				 atomic_t *mmap_changing, uffd_flags_t flags);
 extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 				     unsigned long dst_start,
 				     unsigned long len,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fe043034ab46..493406a2d61e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6161,12 +6161,12 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
-			     enum mcopy_atomic_mode mode,
-			     struct page **pagep,
-			     bool wp_copy)
+			     uffd_flags_t flags,
+			     struct page **pagep)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
-	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
+	bool is_continue = uffd_flags_has_mode(flags, MFILL_ATOMIC_CONTINUE);
+	bool wp_enabled = (flags & MFILL_ATOMIC_WP);
 	struct hstate *h = hstate_vma(dst_vma);
 	struct address_space *mapping = dst_vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
@@ -6301,7 +6301,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
 	 * with wp flag set, don't set pte write bit.
 	 */
-	if (wp_copy || (is_continue && !vm_shared))
+	if (wp_enabled || (is_continue && !vm_shared))
 		writable = 0;
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
@@ -6316,7 +6316,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	_dst_pte = huge_pte_mkdirty(_dst_pte);
 	_dst_pte = pte_mkyoung(_dst_pte);
 
-	if (wp_copy)
+	if (wp_enabled)
 		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
 
 	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
diff --git a/mm/shmem.c b/mm/shmem.c
index 1d751b6cf1ac..7d688afb5e31 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -76,7 +76,6 @@ static struct vfsmount *shm_mnt;
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
 #include <uapi/linux/memfd.h>
-#include <linux/userfaultfd_k.h>
 #include <linux/rmap.h>
 #include <linux/uuid.h>
 
@@ -2419,7 +2418,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
-			   bool zeropage, bool wp_copy,
+			   uffd_flags_t flags,
 			   struct page **pagep)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
@@ -2451,7 +2450,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 		if (!folio)
 			goto out_unacct_blocks;
 
-		if (!zeropage) {	/* COPY */
+		if (uffd_flags_has_mode(flags, MFILL_ATOMIC_COPY)) {
 			page_kaddr = kmap_local_folio(folio, 0);
 			/*
 			 * The read mmap_lock is held here.  Despite the
@@ -2510,7 +2509,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       &folio->page, true, wp_copy);
+				       &folio->page, true, flags);
 	if (ret)
 		goto out_delete_from_cache;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4fc373476739..dd807924446f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -58,7 +58,7 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 int mfill_atomic_install_pte(pmd_t *dst_pmd,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr, struct page *page,
-			     bool newly_allocated, bool wp_copy)
+			     bool newly_allocated, uffd_flags_t flags)
 {
 	int ret;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
@@ -77,7 +77,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 		writable = false;
 	if (writable)
 		_dst_pte = pte_mkwrite(_dst_pte);
-	if (wp_copy)
+	if (flags & MFILL_ATOMIC_WP)
 		_dst_pte = pte_mkuffd_wp(_dst_pte);
 
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
@@ -132,8 +132,8 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 				 struct vm_area_struct *dst_vma,
 				 unsigned long dst_addr,
 				 unsigned long src_addr,
-				 struct page **pagep,
-				 bool wp_copy)
+				 uffd_flags_t flags,
+				 struct page **pagep)
 {
 	void *page_kaddr;
 	int ret;
@@ -194,7 +194,7 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       page, true, wp_copy);
+				       page, true, flags);
 	if (ret)
 		goto out_release;
 out:
@@ -242,7 +242,7 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 				     struct vm_area_struct *dst_vma,
 				     unsigned long dst_addr,
-				     bool wp_copy)
+				     uffd_flags_t flags)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
@@ -268,7 +268,7 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	}
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       page, false, wp_copy);
+				       page, false, flags);
 	if (ret)
 		goto out_release;
 
@@ -313,8 +313,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      enum mcopy_atomic_mode mode,
-					      bool wp_copy)
+					      uffd_flags_t flags)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -334,7 +333,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * by THP.  Since we can not reliably insert a zero page, this
 	 * feature is not supported.
 	 */
-	if (mode == MCOPY_ATOMIC_ZEROPAGE) {
+	if (uffd_flags_has_mode(flags, MFILL_ATOMIC_ZEROPAGE)) {
 		mmap_read_unlock(dst_mm);
 		return -EINVAL;
 	}
@@ -402,7 +401,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 		}
 
-		if (mode != MCOPY_ATOMIC_CONTINUE &&
+		if (!uffd_flags_has_mode(flags, MFILL_ATOMIC_CONTINUE) &&
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			hugetlb_vma_unlock_read(dst_vma);
@@ -410,9 +409,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 		}
 
-		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma,
-					       dst_addr, src_addr, mode, &page,
-					       wp_copy);
+		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma, dst_addr,
+					       src_addr, flags, &page);
 
 		hugetlb_vma_unlock_read(dst_vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -466,23 +464,21 @@ extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
 				    unsigned long dst_start,
 				    unsigned long src_start,
 				    unsigned long len,
-				    enum mcopy_atomic_mode mode,
-				    bool wp_copy);
+				    uffd_flags_t flags);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 						struct vm_area_struct *dst_vma,
 						unsigned long dst_addr,
 						unsigned long src_addr,
-						struct page **page,
-						enum mcopy_atomic_mode mode,
-						bool wp_copy)
+						uffd_flags_t flags,
+						struct page **pagep)
 {
 	ssize_t err;
 
-	if (mode == MCOPY_ATOMIC_CONTINUE) {
+	if (uffd_flags_has_mode(flags, MFILL_ATOMIC_CONTINUE)) {
 		return mfill_atomic_pte_continue(dst_pmd, dst_vma,
-						 dst_addr, wp_copy);
+						 dst_addr, flags);
 	}
 
 	/*
@@ -496,18 +492,17 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	 * and not in the radix tree.
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
-		if (mode == MCOPY_ATOMIC_NORMAL)
+		if (uffd_flags_has_mode(flags, MFILL_ATOMIC_COPY))
 			err = mfill_atomic_pte_copy(dst_pmd, dst_vma,
-						    dst_addr, src_addr, page,
-						    wp_copy);
+						    dst_addr, src_addr,
+						    flags, pagep);
 		else
 			err = mfill_atomic_pte_zeropage(dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
 		err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
 					     dst_addr, src_addr,
-					     mode != MCOPY_ATOMIC_NORMAL,
-					     wp_copy, page);
+					     flags, pagep);
 	}
 
 	return err;
@@ -517,9 +512,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 					    unsigned long dst_start,
 					    unsigned long src_start,
 					    unsigned long len,
-					    enum mcopy_atomic_mode mcopy_mode,
 					    atomic_t *mmap_changing,
-					    __u64 mode)
+					    uffd_flags_t flags)
 {
 	struct vm_area_struct *dst_vma;
 	ssize_t err;
@@ -527,7 +521,6 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct page *page;
-	bool wp_copy;
 
 	/*
 	 * Sanitize the command parameters:
@@ -577,8 +570,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * validate 'mode' now that we know the dst_vma: don't allow
 	 * a wrprotect copy if the userfaultfd didn't register as WP.
 	 */
-	wp_copy = mode & UFFDIO_COPY_MODE_WP;
-	if (wp_copy && !(dst_vma->vm_flags & VM_UFFD_WP))
+	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
 		goto out_unlock;
 
 	/*
@@ -586,12 +578,12 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  mfill_atomic_hugetlb(dst_vma, dst_start,
-					     src_start, len, mcopy_mode,
-					     wp_copy);
+					     src_start, len, flags);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
+	if (!vma_is_shmem(dst_vma) &&
+	    uffd_flags_has_mode(flags, MFILL_ATOMIC_CONTINUE))
 		goto out_unlock;
 
 	/*
@@ -639,7 +631,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
 		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
-				       src_addr, &page, mcopy_mode, wp_copy);
+				       src_addr, flags, &page);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
@@ -687,24 +679,24 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 
 ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
 			  unsigned long src_start, unsigned long len,
-			  atomic_t *mmap_changing, __u64 mode)
+			  atomic_t *mmap_changing, uffd_flags_t flags)
 {
-	return mfill_atomic(dst_mm, dst_start, src_start, len,
-			    MCOPY_ATOMIC_NORMAL, mmap_changing, mode);
+	return mfill_atomic(dst_mm, dst_start, src_start, len, mmap_changing,
+			    uffd_flags_set_mode(flags, MFILL_ATOMIC_COPY));
 }
 
 ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long start,
 			      unsigned long len, atomic_t *mmap_changing)
 {
-	return mfill_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_ZEROPAGE,
-			    mmap_changing, 0);
+	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
+			    uffd_flags_set_mode(0, MFILL_ATOMIC_ZEROPAGE));
 }
 
 ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
 			      unsigned long len, atomic_t *mmap_changing)
 {
-	return mfill_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
-			    mmap_changing, 0);
+	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
+			    uffd_flags_set_mode(0, MFILL_ATOMIC_CONTINUE));
 }
 
 long uffd_wp_range(struct vm_area_struct *dst_vma,
-- 
2.40.0.rc1.284.g88254d51c5-goog

