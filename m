Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8491B6BA25E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCNWUP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 18:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCNWTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 18:19:53 -0400
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B55E39CFE
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 15:18:58 -0700 (PDT)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-536d63d17dbso181514187b3.22
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678831989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLH8n4YXArkUQffQbzzj3eK/Q2WLoaxfMp0XyWUCAx0=;
        b=MI0DIqw5o1kZ1LidUuNaCJMA1DxP0NtutTXWrUU8amV1STMNMqNO2OPPS9//RZuv3A
         zzB0FueU6Jqwgkt3s73/teOAXyeLiYzeAhcfl72HJAz9vcXG4WiP4Cl6pwvUeooTLu8X
         qLDXXeOJ5LFaOKHGQ4BrfEnF6FOPwA1/isprSDTO7hbDxWSQ8EueIhnqKeM5j7T/C9Ht
         w3RMJcxALYuduZmuu/mzmTD0DbkgnvmNEvul75x9RGDTSACOgQ54D+7BARCdmMU8K6oe
         7MiOfSGSiV9f+yhGhCKUbtBNj06VNFw1ccDp2m/3PInTQvkDFM7rN0LFb/AlNiFMhgvu
         5b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLH8n4YXArkUQffQbzzj3eK/Q2WLoaxfMp0XyWUCAx0=;
        b=NxcI+IdE8N/MP/p+17dqCrdISNJs0TFUDZHdQUYqp4CkIFjXBu0uIRSI65mD/6LWCN
         McJ45qvny0e41cWhEzqQXP6x23vSHi0taLIxruOO1j3p0uEOeFXH3qQbHx/2F8VHOCIM
         4dGHzirq0ilw3ZfSn+1WJGUiu1d2XtaT0pDcwwATJnttRchszIXMzuQglznipYtg3F9A
         6nlQ0cBESSPcVlAlKxx8gylK13aGLpO8Z8ZVyjHTlBdf5qYTbEUnzWDckkzL0gALztcq
         YoxdTG+j94jKx8SGnJf1SiW6ZuG1DQbC+yhUwzO1AMVFgmwxCT5qe9JEX834kLo3+3Eu
         aI0w==
X-Gm-Message-State: AO0yUKU8hFUhUqVdumD6iZdlfhOg9ZGIPi36ggaIn7xYklqyHiAjZm7f
        LhGKV376LmwnXXnbCW+Mn7K1mwXYAi8O65EpixKb
X-Google-Smtp-Source: AK7set8X8Ot/dtqhk3gU8wbWHExODdLNpBgnH2rdmHFOGldWEBXjs/mUM1rQq6qsmvaLIXxgbT15ZCWXxNsrjbSSl02K
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:21ce:bab3:17ec:2276])
 (user=axelrasmussen job=sendgmr) by 2002:a81:ad66:0:b0:52e:e8b1:d51e with
 SMTP id l38-20020a81ad66000000b0052ee8b1d51emr11451580ywk.1.1678831989108;
 Tue, 14 Mar 2023 15:13:09 -0700 (PDT)
Date:   Tue, 14 Mar 2023 15:12:48 -0700
In-Reply-To: <20230314221250.682452-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230314221250.682452-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230314221250.682452-3-axelrasmussen@google.com>
Subject: [PATCH v5 2/4] mm: userfaultfd: don't pass around both mm and vma
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quite a few userfaultfd functions took both mm and vma pointers as
arguments. Since the mm is trivially accessible via vma->vm_mm, there's
no reason to pass both; it just needlessly extends the already long
argument list.

Get rid of the mm pointer, where possible, to shorten the argument list.

Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c              |  2 +-
 include/linux/hugetlb.h       |  5 ++-
 include/linux/shmem_fs.h      |  4 +--
 include/linux/userfaultfd_k.h |  4 +--
 mm/hugetlb.c                  |  4 +--
 mm/shmem.c                    |  7 ++--
 mm/userfaultfd.c              | 61 +++++++++++++++++------------------
 7 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 365bf00dd8dd..84d5d402214a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1629,7 +1629,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 		/* Reset ptes for the whole vma range if wr-protected */
 		if (userfaultfd_wp(vma))
-			uffd_wp_range(mm, vma, start, vma_end - start, false);
+			uffd_wp_range(vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8f0467bf1cbd..8b9325f77ac3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -158,7 +158,7 @@ unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
 #ifdef CONFIG_USERFAULTFD
-int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
+int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
@@ -393,8 +393,7 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 }
 
 #ifdef CONFIG_USERFAULTFD
-static inline int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
-					   pte_t *dst_pte,
+static inline int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 					   struct vm_area_struct *dst_vma,
 					   unsigned long dst_addr,
 					   unsigned long src_addr,
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 103d1000a5a2..b82916c25e61 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -151,14 +151,14 @@ extern void shmem_uncharge(struct inode *inode, long pages);
 
 #ifdef CONFIG_USERFAULTFD
 #ifdef CONFIG_SHMEM
-extern int shmem_mfill_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
 				  bool zeropage, bool wp_copy,
 				  struct page **pagep);
 #else /* !CONFIG_SHMEM */
-#define shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
+#define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
 			       src_addr, zeropage, wp_copy, pagep) ({ BUG(); 0; })
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 468080125612..ba79e296fcc7 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -56,7 +56,7 @@ enum mcopy_atomic_mode {
 	MCOPY_ATOMIC_CONTINUE,
 };
 
-extern int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
 				    struct vm_area_struct *dst_vma,
 				    unsigned long dst_addr, struct page *page,
 				    bool newly_allocated, bool wp_copy);
@@ -73,7 +73,7 @@ extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, atomic_t *mmap_changing);
-extern long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *vma,
+extern long uffd_wp_range(struct vm_area_struct *vma,
 			  unsigned long start, unsigned long len, bool enable_wp);
 
 /* mm helpers */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4c9276549394..fe043034ab46 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6157,8 +6157,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  * Used by userfaultfd UFFDIO_* ioctls. Based on userfaultfd's mfill_atomic_pte
  * with modifications for hugetlb pages.
  */
-int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
-			     pte_t *dst_pte,
+int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
@@ -6166,6 +6165,7 @@ int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
 			     struct page **pagep,
 			     bool wp_copy)
 {
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct hstate *h = hstate_vma(dst_vma);
 	struct address_space *mapping = dst_vma->vm_file->f_mapping;
diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2..1d751b6cf1ac 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2415,8 +2415,7 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 }
 
 #ifdef CONFIG_USERFAULTFD
-int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
-			   pmd_t *dst_pmd,
+int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
@@ -2506,11 +2505,11 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	ret = shmem_add_to_page_cache(folio, mapping, pgoff, NULL,
-				      gfp & GFP_RECLAIM_MASK, dst_mm);
+				      gfp & GFP_RECLAIM_MASK, dst_vma->vm_mm);
 	if (ret)
 		goto out_release;
 
-	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
 				       &folio->page, true, wp_copy);
 	if (ret)
 		goto out_delete_from_cache;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 84db5b2fad3a..4fc373476739 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -55,12 +55,13 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
  * This function handles both MCOPY_ATOMIC_NORMAL and _CONTINUE for both shmem
  * and anon, and for both shared and private VMAs.
  */
-int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+int mfill_atomic_install_pte(pmd_t *dst_pmd,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr, struct page *page,
 			     bool newly_allocated, bool wp_copy)
 {
 	int ret;
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	pte_t _dst_pte, *dst_pte;
 	bool writable = dst_vma->vm_flags & VM_WRITE;
 	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -127,8 +128,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	return ret;
 }
 
-static int mfill_atomic_pte_copy(struct mm_struct *dst_mm,
-				 pmd_t *dst_pmd,
+static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 				 struct vm_area_struct *dst_vma,
 				 unsigned long dst_addr,
 				 unsigned long src_addr,
@@ -190,10 +190,10 @@ static int mfill_atomic_pte_copy(struct mm_struct *dst_mm,
 	__SetPageUptodate(page);
 
 	ret = -ENOMEM;
-	if (mem_cgroup_charge(page_folio(page), dst_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(page), dst_vma->vm_mm, GFP_KERNEL))
 		goto out_release;
 
-	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
 				       page, true, wp_copy);
 	if (ret)
 		goto out_release;
@@ -204,8 +204,7 @@ static int mfill_atomic_pte_copy(struct mm_struct *dst_mm,
 	goto out;
 }
 
-static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
-				     pmd_t *dst_pmd,
+static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 				     struct vm_area_struct *dst_vma,
 				     unsigned long dst_addr)
 {
@@ -217,7 +216,7 @@ static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
 
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
-	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	dst_pte = pte_offset_map_lock(dst_vma->vm_mm, dst_pmd, dst_addr, &ptl);
 	if (dst_vma->vm_file) {
 		/* the shmem MAP_PRIVATE case requires checking the i_size */
 		inode = dst_vma->vm_file->f_inode;
@@ -230,7 +229,7 @@ static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
 	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
 		goto out_unlock;
-	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	set_pte_at(dst_vma->vm_mm, dst_addr, dst_pte, _dst_pte);
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 	ret = 0;
@@ -240,8 +239,7 @@ static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
 }
 
 /* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
-static int mfill_atomic_pte_continue(struct mm_struct *dst_mm,
-				     pmd_t *dst_pmd,
+static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 				     struct vm_area_struct *dst_vma,
 				     unsigned long dst_addr,
 				     bool wp_copy)
@@ -269,7 +267,7 @@ static int mfill_atomic_pte_continue(struct mm_struct *dst_mm,
 		goto out_release;
 	}
 
-	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
 				       page, false, wp_copy);
 	if (ret)
 		goto out_release;
@@ -310,7 +308,7 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
  * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
  * called with mmap_lock held, it will release mmap_lock before returning.
  */
-static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
+static __always_inline ssize_t mfill_atomic_hugetlb(
 					      struct vm_area_struct *dst_vma,
 					      unsigned long dst_start,
 					      unsigned long src_start,
@@ -318,6 +316,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 					      enum mcopy_atomic_mode mode,
 					      bool wp_copy)
 {
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
 	pte_t *dst_pte;
@@ -411,7 +410,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 		}
 
-		err = hugetlb_mfill_atomic_pte(dst_mm, dst_pte, dst_vma,
+		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma,
 					       dst_addr, src_addr, mode, &page,
 					       wp_copy);
 
@@ -463,17 +462,15 @@ static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 }
 #else /* !CONFIG_HUGETLB_PAGE */
 /* fail at build time if gcc attempts to use this */
-extern ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
-				      struct vm_area_struct *dst_vma,
-				      unsigned long dst_start,
-				      unsigned long src_start,
-				      unsigned long len,
-				      enum mcopy_atomic_mode mode,
-				      bool wp_copy);
+extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
+				    unsigned long dst_start,
+				    unsigned long src_start,
+				    unsigned long len,
+				    enum mcopy_atomic_mode mode,
+				    bool wp_copy);
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
-						pmd_t *dst_pmd,
+static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 						struct vm_area_struct *dst_vma,
 						unsigned long dst_addr,
 						unsigned long src_addr,
@@ -484,7 +481,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	ssize_t err;
 
 	if (mode == MCOPY_ATOMIC_CONTINUE) {
-		return mfill_atomic_pte_continue(dst_mm, dst_pmd, dst_vma,
+		return mfill_atomic_pte_continue(dst_pmd, dst_vma,
 						 dst_addr, wp_copy);
 	}
 
@@ -500,14 +497,14 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
 		if (mode == MCOPY_ATOMIC_NORMAL)
-			err = mfill_atomic_pte_copy(dst_mm, dst_pmd, dst_vma,
+			err = mfill_atomic_pte_copy(dst_pmd, dst_vma,
 						    dst_addr, src_addr, page,
 						    wp_copy);
 		else
-			err = mfill_atomic_pte_zeropage(dst_mm, dst_pmd,
+			err = mfill_atomic_pte_zeropage(dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
-		err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
+		err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
 					     dst_addr, src_addr,
 					     mode != MCOPY_ATOMIC_NORMAL,
 					     wp_copy, page);
@@ -588,7 +585,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(dst_mm, dst_vma, dst_start,
+		return  mfill_atomic_hugetlb(dst_vma, dst_start,
 					     src_start, len, mcopy_mode,
 					     wp_copy);
 
@@ -641,7 +638,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_none(*dst_pmd));
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
-		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
 				       src_addr, &page, mcopy_mode, wp_copy);
 		cond_resched();
 
@@ -710,7 +707,7 @@ ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
 			    mmap_changing, 0);
 }
 
-long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
+long uffd_wp_range(struct vm_area_struct *dst_vma,
 		   unsigned long start, unsigned long len, bool enable_wp)
 {
 	unsigned int mm_cp_flags;
@@ -730,7 +727,7 @@ long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 	 */
 	if (!enable_wp && vma_wants_manual_pte_write_upgrade(dst_vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
-	tlb_gather_mmu(&tlb, dst_mm);
+	tlb_gather_mmu(&tlb, dst_vma->vm_mm);
 	ret = change_protection(&tlb, dst_vma, start, start + len, mm_cp_flags);
 	tlb_finish_mmu(&tlb);
 
@@ -782,7 +779,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			goto out_unlock;
 	}
 
-	err = uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
+	err = uffd_wp_range(dst_vma, start, len, enable_wp);
 
 	/* Return 0 on success, <0 on failures */
 	if (err > 0)
-- 
2.40.0.rc1.284.g88254d51c5-goog

