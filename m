Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B926C3661E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Apr 2021 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhDTWIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Apr 2021 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhDTWIq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Apr 2021 18:08:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E8C06138B
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 15:08:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c1-20020a5b0bc10000b02904e7c6399b20so13434582ybr.12
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a4VdN5aYyzVjjL2HqfgoVnRM8+bC3CDsNcvljqmhvtc=;
        b=uzsUF7c/nqA0cryXPZz+BzIxEuT0aA5ywKIJYlO4mqAho5vbHY/zWzehPflreVIG2/
         JmIb9Wuyf2YoHlpe0i9pngk6fbfyjVY6DpRdoIbNjBCDI2n5HVfOppTpjFigNVuf02hq
         woZKzepGZTNJeHTdUWkQQl6fboDizm2ND/smnXnIVwVyWAMT9F+TlcudnMZRUBKcACZL
         izVfxyZlL58aCX8mwvjgtLgTG0Y0mZHmRnb0cYpFEWV7v+7/OaBnlhzXU83w1MtVu94/
         VLimMmDqIhWhnzofYMN7Q/hVn9nXM+V3tjFHz7pVP83F5Oa6XOdrxquM5wckyUfCXu3R
         BfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a4VdN5aYyzVjjL2HqfgoVnRM8+bC3CDsNcvljqmhvtc=;
        b=MlFNvLz86Vq8bDl90GkhIEJA0qGy53Qb4dd+mhy9hOuzqYs4xsqm6CNjk8WbS8eKrt
         IhBmXrA9m1c632CIr4eeEIEait75LHlSKeI3JJmPD+vx4/lW5WoGUy3GYCWOnrKslx4h
         hkDLcQyqPgTef/0Yebpvp7ZmtbLmcy4bHyT6IdjdKtPz0TmlUF40bsnLCbQSGlegBGYG
         2UdqZqKuKigrW6nahaJdKE2c2pSAY9Wzn0oImFRBKzCpxulIGHAd9/NjB5phmyySKavd
         P9u/4ZTxMCSH/NLDixesjIpsJ1jo325Auc5sf9OfgyaO+v/TVp7Qt2qRRnIVNr/VpNDm
         xqeA==
X-Gm-Message-State: AOAM530cP8/tRWeZW1+NWdKvUv826zC9soFdj9d0c4zhUrN5kfypbGl9
        Gzk9NODdtr2YwNEZkLHnC8O20uJMPvv8Z6/Yrd++
X-Google-Smtp-Source: ABdhPJzePMEMmP2y9ogK36u5OfBacHtf6kJR7MjKT30Aj+bxcaQdJ2gVnC91JVbD4LoXtfaXLsiMASeS7IpVHaLZl7KS
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:28e:: with SMTP id
 x14mr10647700ybl.493.1618956492299; Tue, 20 Apr 2021 15:08:12 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:07:56 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 02/10] userfaultfd/shmem: combine shmem_{mcopy_atomic,mfill_zeropage}_pte
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

Previously, we did a dance where we had one calling path in
userfaultfd.c (mfill_atomic_pte), but then we split it into two in
shmem_fs.h (shmem_{mcopy_atomic,mfill_zeropage}_pte), and then rejoined
into a single shared function in shmem.c (shmem_mfill_atomic_pte).

This is all a bit overly complex. Just call the single combined shmem
function directly, allowing us to clean up various branches,
boilerplate, etc.

While we're touching this function, two other small cleanup changes:
- offset is equivalent to pgoff, so we can get rid of offset entirely.
- Split two VM_BUG_ON cases into two statements. This means the line
  number reported when the BUG is hit specifies exactly which condition
  was true.

Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/shmem_fs.h | 17 ++++++-------
 mm/shmem.c               | 52 +++++++++++++---------------------------
 mm/userfaultfd.c         | 10 +++-----
 3 files changed, 26 insertions(+), 53 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d82b6f396588..47c3409d02ac 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -122,21 +122,18 @@ static inline bool shmem_file(struct file *file)
 extern bool shmem_charge(struct inode *inode, long pages);
 extern void shmem_uncharge(struct inode *inode, long pages);
 
+#ifdef CONFIG_USERFAULTFD
 #ifdef CONFIG_SHMEM
 extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
+				  bool zeropage,
 				  struct page **pagep);
-extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
-				    pmd_t *dst_pmd,
-				    struct vm_area_struct *dst_vma,
-				    unsigned long dst_addr);
-#else
-#define shmem_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
-			       src_addr, pagep)        ({ BUG(); 0; })
-#define shmem_mfill_zeropage_pte(dst_mm, dst_pmd, dst_vma, \
-				 dst_addr)      ({ BUG(); 0; })
-#endif
+#else /* !CONFIG_SHMEM */
+#define shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
+			       src_addr, zeropage, pagep)       ({ BUG(); 0; })
+#endif /* CONFIG_SHMEM */
+#endif /* CONFIG_USERFAULTFD */
 
 #endif
diff --git a/mm/shmem.c b/mm/shmem.c
index 26c76b13ad23..b72c55aa07fc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2354,13 +2354,14 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 	return inode;
 }
 
-static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
-				  pmd_t *dst_pmd,
-				  struct vm_area_struct *dst_vma,
-				  unsigned long dst_addr,
-				  unsigned long src_addr,
-				  bool zeropage,
-				  struct page **pagep)
+#ifdef CONFIG_USERFAULTFD
+int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
+			   pmd_t *dst_pmd,
+			   struct vm_area_struct *dst_vma,
+			   unsigned long dst_addr,
+			   unsigned long src_addr,
+			   bool zeropage,
+			   struct page **pagep)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -2372,7 +2373,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	struct page *page;
 	pte_t _dst_pte, *dst_pte;
 	int ret;
-	pgoff_t offset, max_off;
+	pgoff_t max_off;
 
 	ret = -ENOMEM;
 	if (!shmem_inode_acct_block(inode, 1))
@@ -2383,7 +2384,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		if (!page)
 			goto out_unacct_blocks;
 
-		if (!zeropage) {	/* mcopy_atomic */
+		if (!zeropage) {	/* COPY */
 			page_kaddr = kmap_atomic(page);
 			ret = copy_from_user(page_kaddr,
 					     (const void __user *)src_addr,
@@ -2397,7 +2398,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 				/* don't free the page */
 				return -ENOENT;
 			}
-		} else {		/* mfill_zeropage_atomic */
+		} else {		/* ZEROPAGE */
 			clear_highpage(page);
 		}
 	} else {
@@ -2405,15 +2406,15 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		*pagep = NULL;
 	}
 
-	VM_BUG_ON(PageLocked(page) || PageSwapBacked(page));
+	VM_BUG_ON(PageLocked(page));
+	VM_BUG_ON(PageSwapBacked(page));
 	__SetPageLocked(page);
 	__SetPageSwapBacked(page);
 	__SetPageUptodate(page);
 
 	ret = -EFAULT;
-	offset = linear_page_index(dst_vma, dst_addr);
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(offset >= max_off))
+	if (unlikely(pgoff >= max_off))
 		goto out_release;
 
 	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
@@ -2439,7 +2440,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 	ret = -EFAULT;
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(offset >= max_off))
+	if (unlikely(pgoff >= max_off))
 		goto out_release_unlock;
 
 	ret = -EEXIST;
@@ -2476,28 +2477,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	shmem_inode_unacct_blocks(inode, 1);
 	goto out;
 }
-
-int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
-			   pmd_t *dst_pmd,
-			   struct vm_area_struct *dst_vma,
-			   unsigned long dst_addr,
-			   unsigned long src_addr,
-			   struct page **pagep)
-{
-	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
-				      dst_addr, src_addr, false, pagep);
-}
-
-int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
-			     pmd_t *dst_pmd,
-			     struct vm_area_struct *dst_vma,
-			     unsigned long dst_addr)
-{
-	struct page *page = NULL;
-
-	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
-				      dst_addr, 0, true, &page);
-}
+#endif /* CONFIG_USERFAULTFD */
 
 #ifdef CONFIG_TMPFS
 static const struct inode_operations shmem_symlink_inode_operations;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e14b3820c6a8..23fa2583bbd1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -440,13 +440,9 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 						 dst_vma, dst_addr);
 	} else {
 		VM_WARN_ON_ONCE(wp_copy);
-		if (!zeropage)
-			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
-						     dst_vma, dst_addr,
-						     src_addr, page);
-		else
-			err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
-						       dst_vma, dst_addr);
+		err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
+					     dst_addr, src_addr, zeropage,
+					     page);
 	}
 
 	return err;
-- 
2.31.1.368.gbe11c130af-goog

