Return-Path: <linux-kselftest+bounces-45736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F5AC63E6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 12:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B244A28A45
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1B32C301;
	Mon, 17 Nov 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASNjqE6N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107932BF4C;
	Mon, 17 Nov 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380011; cv=none; b=MMMNJNUCmVgv3p5pwRZuEBkBr5Lz/98W0j/68H9AHu059JNB+Z2FAKzfSjNQsZCkPqv0/adIOKJkmRAVslIdcqkl7MUAp8GPOxbrTWmQoLYVCuFWv8B5ZIrJHdLEc13/RIhMuJLLqslK7/d4rVTBkI7yIp2/ZQwOVyi9TMsN/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380011; c=relaxed/simple;
	bh=8/+DCxIp/1x96wp7dFSji3YJsLxqOklYakr89V1mdJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgYNKywEGaEkImwtLJy5uSevvMNc3ue2cPTrqIPWnhJgPxh7pmbbL4qXxZDilVARsw2p7apYZf7eSeJduPIQIVxmUHri9tI1f3c/sqUFxFZpuVKrWdz/GYdfdjes6TZRcYSQGe/132nNEaIarjOyQyzMnx9SP6Tyv5UV2y6Ra7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASNjqE6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72761C4CEF1;
	Mon, 17 Nov 2025 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763380011;
	bh=8/+DCxIp/1x96wp7dFSji3YJsLxqOklYakr89V1mdJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASNjqE6NCAO95VKAaSFpgbdylkHEuDccnhTR+4XMMjtopn9NNlmICMwZupXLHvZy6
	 Qn/AezNBaLpynFAZBL1DDCFPWtOn2e42k08YQ12GzYdooD9h+NdNTSo3qUUr9GeUNR
	 O2LWdo7TOCrKKpGIy6F2ZZmHdG9MjYO/KC3JRz3bk+PxeMZIYSitWgECxXX1m42jeq
	 H+t2rSeKR90Nt9VS01rdCwAxdvTqPqzF40ysWM27GX8pZYVQHQ/m6+zGPAeTh9GbRD
	 /m3oTXdYnqgy+1X1Eh5aMpf7yzBGPvXIXfMw38JOXNYGvUhgxpDhq74QyPBQSyej2c
	 Q4hTMa4Kk6rug==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 2/4] userfaultfd, shmem: use a VMA callback to handle UFFDIO_CONTINUE
Date: Mon, 17 Nov 2025 13:46:29 +0200
Message-ID: <20251117114631.2029447-3-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117114631.2029447-1-rppt@kernel.org>
References: <20251117114631.2029447-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
it needs to get a folio that already exists in the pagecache backing
that VMA.

Instead of using shmem_get_folio() for that, add a get_pagecache_folio()
method to 'struct vm_operations_struct' that will return a folio if it
exists in the VMA's pagecache at given pgoff.

Implement get_pagecache_folio() method for shmem and slightly refactor
userfaultfd's mfill_atomic() and mfill_atomic_pte_continue() to support
this new API.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/mm.h |  9 +++++++
 mm/shmem.c         | 20 ++++++++++++++++
 mm/userfaultfd.c   | 60 ++++++++++++++++++++++++++++++----------------
 3 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..c35c1e1ac4dd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -690,6 +690,15 @@ struct vm_operations_struct {
 	struct page *(*find_normal_page)(struct vm_area_struct *vma,
 					 unsigned long addr);
 #endif /* CONFIG_FIND_NORMAL_PAGE */
+#ifdef CONFIG_USERFAULTFD
+	/*
+	 * Called by userfault to resolve UFFDIO_CONTINUE request.
+	 * Should return the folio found at pgoff in the VMA's pagecache if it
+	 * exists or ERR_PTR otherwise.
+	 */
+	struct folio *(*get_pagecache_folio)(struct vm_area_struct *vma,
+					     pgoff_t pgoff);
+#endif
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/mm/shmem.c b/mm/shmem.c
index b9081b817d28..4ac122284bff 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3260,6 +3260,20 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	shmem_inode_unacct_blocks(inode, 1);
 	return ret;
 }
+
+static struct folio *shmem_get_pagecache_folio(struct vm_area_struct *vma,
+					       pgoff_t pgoff)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	struct folio *folio;
+	int err;
+
+	err = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
+	if (err)
+		return ERR_PTR(err);
+
+	return folio;
+}
 #endif /* CONFIG_USERFAULTFD */
 
 #ifdef CONFIG_TMPFS
@@ -5292,6 +5306,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.get_pagecache_folio	= shmem_get_pagecache_folio,
+#endif
 };
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
@@ -5301,6 +5318,9 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.get_pagecache_folio	= shmem_get_pagecache_folio,
+#endif
 };
 
 int shmem_init_fs_context(struct fs_context *fc)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8dc964389b0d..60b3183a72c0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -382,21 +382,17 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 				     unsigned long dst_addr,
 				     uffd_flags_t flags)
 {
-	struct inode *inode = file_inode(dst_vma->vm_file);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
 	struct folio *folio;
 	struct page *page;
 	int ret;
 
-	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
+	folio = dst_vma->vm_ops->get_pagecache_folio(dst_vma, pgoff);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
-	if (ret == -ENOENT)
-		ret = -EFAULT;
-	if (ret)
-		goto out;
-	if (!folio) {
-		ret = -EFAULT;
-		goto out;
+	if (IS_ERR_OR_NULL(folio)) {
+		if (PTR_ERR(folio) == -ENOENT || !folio)
+			return -EFAULT;
+		return PTR_ERR(folio);
 	}
 
 	page = folio_file_page(folio, pgoff);
@@ -411,13 +407,12 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 		goto out_release;
 
 	folio_unlock(folio);
-	ret = 0;
-out:
-	return ret;
+	return 0;
+
 out_release:
 	folio_unlock(folio);
 	folio_put(folio);
-	goto out;
+	return ret;
 }
 
 /* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
@@ -694,6 +689,22 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	return err;
 }
 
+static __always_inline bool vma_can_mfill_atomic(struct vm_area_struct *vma,
+						 uffd_flags_t flags)
+{
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
+		if (vma->vm_ops && vma->vm_ops->get_pagecache_folio)
+			return true;
+		else
+			return false;
+	}
+
+	if (vma_is_anonymous(vma) || vma_is_shmem(vma))
+		return true;
+
+	return false;
+}
+
 static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 					    unsigned long dst_start,
 					    unsigned long src_start,
@@ -766,10 +777,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
 					     src_start, len, flags);
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
-		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+	if (!vma_can_mfill_atomic(dst_vma, flags))
 		goto out_unlock;
 
 	while (src_addr < src_start + len) {
@@ -1985,9 +1993,21 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 	if (vma->vm_flags & VM_DROPPABLE)
 		return false;
 
-	if ((vm_flags & VM_UFFD_MINOR) &&
-	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
-		return false;
+	if (vm_flags & VM_UFFD_MINOR) {
+		/*
+		 * If only MINOR mode is requested and we can request an
+		 * existing folio from VMA's page cache, allow it
+		 */
+		if (vm_flags == VM_UFFD_MINOR && vma->vm_ops &&
+		    vma->vm_ops->get_pagecache_folio)
+			return true;
+		/*
+		 * Only hugetlb and shmem can support MINOR mode in combination
+		 * with other modes
+		 */
+		if (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma))
+			return false;
+	}
 
 	/*
 	 * If wp async enabled, and WP is the only mode enabled, allow any
-- 
2.50.1


