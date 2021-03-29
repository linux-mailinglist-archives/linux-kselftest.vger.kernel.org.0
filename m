Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F4634DC99
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 01:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC2XoR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Mar 2021 19:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhC2XoO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Mar 2021 19:44:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD0C061765
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Mar 2021 16:44:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v186so12900561ybe.5
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Mar 2021 16:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uoU32IU0pqTRkbWEkjmYD519qCQDwaxCfM+B/mBEeuo=;
        b=nsWDPG4/gHBmdumT95TxKr+RFTidK1afkH6jAkr7L0ngzD8b8e9ZPDpEmZpAeh2uyS
         QPEYRRQl5TP8L0W8LhbBsrswqR3Wzjm1kkGwoco++CBEMZNWEQ6lOkM1fBeTttDtUCi/
         Ltp9pspRsqyloBv1n3lFtDemERmM1N4opnVD/Mt1c4zVOhpM2j2Zq9sTXveOfUmrtD+Z
         6b4k4PBuZydijBcvGlu2q16lGVL6PZz+HaRoS4x7wPVhW+BABzDYbzS/YSaDXTEfrz2u
         bqRcMzJ1WzHXXnS5J3ait4UhU/etIqyINQUTlrvS1dRsBKBhRhSmJohg4pb+ignhth4j
         5HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uoU32IU0pqTRkbWEkjmYD519qCQDwaxCfM+B/mBEeuo=;
        b=t8W/jdosR2QX09Uy7nS4QuzdEoHfASPyY8KqTzOY8PpltHntUCaZ3BkGP4TqgcaY33
         XMTWhLGdb/kY5uYgAda+Kc0qORbw/5LxrD9Gr4wuy9KcL0fTyQ3oayDo4qEDiy24Rh/W
         5rvlaCi2+7u7MRi7mURqB/r1X/0XBo9tU+PNSuZXuQUN2YgFNgZTi2RP0GH7DAk8KH5X
         aG4669fZ18cHhNMPH9dSw6ohIz6d4kQ46dhLY1WsN1pMMV0hkfi6kDwZRFAFtJ1+gAK7
         c61iMkKV9gGXPV9ly2HkdZmNI+aywmMIrpGgzwCxCUArtAz5RvTAGi3oAthfJ8LiWi2z
         ytsw==
X-Gm-Message-State: AOAM532Hiijl94PCg5qIBFLBUjQm1dYLVDYIqxxKEg0MVC2wEYlkyZIQ
        m1vRWJaxdD3CVpkrHVyDYzG/vWe1fFWa+lUmOg4y
X-Google-Smtp-Source: ABdhPJwel6nkEx2Uf1jY/NOtLUUm4qo9nYXu+LKQeD/JFEoCY4Zo0CcVUV27K2q5Sw5mBSS1DEVk98amOijlC1q4s+YZ
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:8578:c167:dddf:13a2])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:751:: with SMTP id
 s17mr778317ybq.108.1617061453526; Mon, 29 Mar 2021 16:44:13 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:41:31 -0700
Message-Id: <20210329234131.304999-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTNUE behavior
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously, we shared too much of the code with COPY and ZEROPAGE, so we
manipulated things in various invalid ways:

- Previously, we unconditionally called shmem_inode_acct_block. In the
  continue case, we're looking up an existing page which would have been
  accounted for properly when it was allocated. So doing it twice
  results in double-counting, and eventually leaking.

- Previously, we made the pte writable whenever the VMA was writable.
  However, for continue, consider this case:

  1. A tmpfs file was created
  2. The non-UFFD-registered side mmap()-s with MAP_SHARED
  3. The UFFD-registered side mmap()-s with MAP_PRIVATE

  In this case, even though the UFFD-registered VMA may be writable, we
  still want CoW behavior. So, check for this case and don't make the
  pte writable.

- The initial pgoff / max_off check isn't necessary, so we can skip past
  it. The second one seems likely to be unnecessary too, but keep it
  just in case. Modify both checks to use pgoff, as offset is equivalent
  and not needed.

- Previously, we unconditionally called ClearPageDirty() in the error
  path. In the continue case though, since this is an existing page, it
  might have already been dirty before we started touching it. It's very
  problematic to clear the bit incorrectly, but not a problem to leave
  it - so, just omit the ClearPageDirty() entirely.

- Previously, we unconditionally removed the page from the page cache in
  the error path. But in the continue case, we didn't add it - it was
  already there because the page is present in some second
  (non-UFFD-registered) mapping. So, removing it is invalid.

Because the error handling issues are easy to exercise in the selftest,
make a small modification there to do so.

Finally, refactor shmem_mcopy_atomic_pte a bit. By this point, we've
added a lot of "if (!is_continue)"-s everywhere. It's cleaner to just
check for that mode first thing, and then "goto" down to where the parts
we actually want are. This leaves the code in between cleaner.

Changes since v2:
- Drop the ClearPageDirty() entirely, instead of trying to remember the
  old value.
- Modify both pgoff / max_off checks to use pgoff. It's equivalent to
  offset, but offset wasn't initialized until the first check (which
  we're skipping).
- Keep the second pgoff / max_off check in the continue case.

Changes since v1:
- Refactor to skip ahead with goto, instead of adding several more
  "if (!is_continue)".
- Fix unconditional ClearPageDirty().
- Don't pte_mkwrite() when is_continue && !VM_SHARED.

Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/shmem.c                               | 60 +++++++++++++-----------
 tools/testing/selftests/vm/userfaultfd.c | 12 +++++
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d2e0e81b7d2e..fbcce850a16e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2377,18 +2377,22 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	struct page *page;
 	pte_t _dst_pte, *dst_pte;
 	int ret;
-	pgoff_t offset, max_off;
-
-	ret = -ENOMEM;
-	if (!shmem_inode_acct_block(inode, 1))
-		goto out;
+	pgoff_t max_off;
+	int writable;
 
 	if (is_continue) {
 		ret = -EFAULT;
 		page = find_lock_page(mapping, pgoff);
 		if (!page)
-			goto out_unacct_blocks;
-	} else if (!*pagep) {
+			goto out;
+		goto install_ptes;
+	}
+
+	ret = -ENOMEM;
+	if (!shmem_inode_acct_block(inode, 1))
+		goto out;
+
+	if (!*pagep) {
 		page = shmem_alloc_page(gfp, info, pgoff);
 		if (!page)
 			goto out_unacct_blocks;
@@ -2415,30 +2419,29 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 		*pagep = NULL;
 	}
 
-	if (!is_continue) {
-		VM_BUG_ON(PageSwapBacked(page));
-		VM_BUG_ON(PageLocked(page));
-		__SetPageLocked(page);
-		__SetPageSwapBacked(page);
-		__SetPageUptodate(page);
-	}
+	VM_BUG_ON(PageSwapBacked(page));
+	VM_BUG_ON(PageLocked(page));
+	__SetPageLocked(page);
+	__SetPageSwapBacked(page);
+	__SetPageUptodate(page);
 
 	ret = -EFAULT;
-	offset = linear_page_index(dst_vma, dst_addr);
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(offset >= max_off))
+	if (unlikely(pgoff >= max_off))
 		goto out_release;
 
-	/* If page wasn't already in the page cache, add it. */
-	if (!is_continue) {
-		ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
-					      gfp & GFP_RECLAIM_MASK, dst_mm);
-		if (ret)
-			goto out_release;
-	}
+	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
+				      gfp & GFP_RECLAIM_MASK, dst_mm);
+	if (ret)
+		goto out_release;
 
+install_ptes:
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
-	if (dst_vma->vm_flags & VM_WRITE)
+	/* For CONTINUE on a non-shared VMA, don't pte_mkwrite for CoW. */
+	writable = is_continue && !(dst_vma->vm_flags & VM_SHARED)
+		? 0
+		: dst_vma->vm_flags & VM_WRITE;
+	if (writable)
 		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
 	else {
 		/*
@@ -2455,7 +2458,7 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 
 	ret = -EFAULT;
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(offset >= max_off))
+	if (unlikely(pgoff >= max_off))
 		goto out_release_unlock;
 
 	ret = -EEXIST;
@@ -2485,13 +2488,14 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	return ret;
 out_release_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
-	ClearPageDirty(page);
-	delete_from_page_cache(page);
+	if (!is_continue)
+		delete_from_page_cache(page);
 out_release:
 	unlock_page(page);
 	put_page(page);
 out_unacct_blocks:
-	shmem_inode_unacct_blocks(inode, 1);
+	if (!is_continue)
+		shmem_inode_unacct_blocks(inode, 1);
 	goto out;
 }
 #endif /* CONFIG_USERFAULTFD */
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index f6c86b036d0f..d8541a59dae5 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -485,6 +485,7 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 static void continue_range(int ufd, __u64 start, __u64 len)
 {
 	struct uffdio_continue req;
+	int ret;
 
 	req.range.start = start;
 	req.range.len = len;
@@ -493,6 +494,17 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
 		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
 		    (uint64_t)start);
+
+	/*
+	 * Error handling within the kernel for continue is subtly different
+	 * from copy or zeropage, so it may be a source of bugs. Trigger an
+	 * error (-EEXIST) on purpose, to verify doing so doesn't cause a BUG.
+	 */
+	req.mapped = 0;
+	ret = ioctl(ufd, UFFDIO_CONTINUE, &req);
+	if (ret >= 0 || req.mapped != -EEXIST)
+		err("failed to exercise UFFDIO_CONTINUE error handling, ret=%d, mapped=%" PRId64,
+		    ret, req.mapped);
 }
 
 static void *locking_thread(void *arg)
-- 
2.31.0.291.g576ba9dcdaf-goog

