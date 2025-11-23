Return-Path: <linux-kselftest+bounces-46344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE7C7DF81
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 11:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E877734D6C6
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C5D2D5412;
	Sun, 23 Nov 2025 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZTgflsa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E52C08CC;
	Sun, 23 Nov 2025 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763893648; cv=none; b=UXGdl2h/rkYp2RfUU593q4h/MnuIwHbJL04vBs8CDucYeVHgeI2YZz60Gm43AsOiof7rZiOCtRl6CgFV7ysqzejtQOBBvAHjY/MxIvcxafUOAaH+XZoYC6r4j0LP8QTYk9clXUqZ3UeOyxFuU5Ctgf7gjb6jX1UNC8zQRvVp0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763893648; c=relaxed/simple;
	bh=cDH3WIfWACYcFb+JNsVypvmaWJL8YVSC/VIGBsIP7Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUxDOwadseeqxT8f8Y8juKShRyK5XrziStQYcR/ardwoyY33HR5U0upJnpK1OfU44LIwrnhpZAbo3S9Yo8xMtDslQs/CXtg6f6/PrbwDXmdUBim144+oYjfbWhsW6nF9eOWTFnHf3PEaonF/Brt/XaNnYMFXC1QwbcXuRa4ClKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZTgflsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00A3C16AAE;
	Sun, 23 Nov 2025 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763893647;
	bh=cDH3WIfWACYcFb+JNsVypvmaWJL8YVSC/VIGBsIP7Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZTgflsai+RK4Zq/pWWn6QNq2LiWZYRqrDYPT9j65y4wruY+BECYFyU7uv40G1iax
	 bW8fTBuk6Lu3BtOjYVCZBgljqgnggLSJQLHTcEXJ6IZitWiNRjw208mdn2MQQLh2Sh
	 Uijip1NAgBV/tx1nw01ieSTlJhwMLcgTdXQ3urou9mrAjr68CjG38L7B0/O6BfmNmh
	 +9cxH1/UbV7FKUHnOLvEdabqRt0LDWE79HfTpexORoxfTdJRRUZ0+eaCZhjTkPx/fl
	 oC85lh31Qq8xJ6BW8UEd910uVkyWCMUYP34vKXO2Or/ljADNSw0Gc/HD07w357QLN3
	 cquCKQ8xaHgdQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
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
Subject: [PATCH 2/5] userfaultfd, shmem: use a VMA callback to handle UFFDIO_CONTINUE
Date: Sun, 23 Nov 2025 12:27:04 +0200
Message-ID: <20251123102707.559422-3-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251123102707.559422-1-rppt@kernel.org>
References: <20251123102707.559422-1-rppt@kernel.org>
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
 include/linux/mm.h |  9 ++++++++
 mm/shmem.c         | 19 +++++++++++++++++
 mm/userfaultfd.c   | 52 +++++++++++++++++++++++++++++-----------------
 3 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c79b3369b82..a5747c306cc2 100644
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
+	 * The returned folio is locked and with reference held.
+	 */
+	struct folio *(*get_shared_folio)(struct inode *inode, pgoff_t pgoff);
+#endif
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/mm/shmem.c b/mm/shmem.c
index 58701d14dd96..aaa21bb60f51 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3263,6 +3263,19 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	shmem_inode_unacct_blocks(inode, 1);
 	return ret;
 }
+
+static struct folio *shmem_get_shared_folio(struct inode *inode,
+					    pgoff_t pgoff)
+{
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
@@ -5295,6 +5308,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.get_shared_folio	= shmem_get_shared_folio,
+#endif
 };
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
@@ -5304,6 +5320,9 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.get_shared_folio	= shmem_get_shared_folio,
+#endif
 };
 
 int shmem_init_fs_context(struct fs_context *fc)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8dc964389b0d..04563f88aab5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -388,15 +388,12 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	struct page *page;
 	int ret;
 
-	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
+	folio = dst_vma->vm_ops->get_shared_folio(inode, pgoff);
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
@@ -411,13 +408,12 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
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
@@ -694,6 +690,15 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	return err;
 }
 
+static __always_inline bool vma_can_mfill_atomic(struct vm_area_struct *vma,
+						 uffd_flags_t flags)
+{
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+		return vma->vm_ops && vma->vm_ops->get_shared_folio;
+
+	return vma_is_anonymous(vma) || vma_is_shmem(vma);
+}
+
 static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 					    unsigned long dst_start,
 					    unsigned long src_start,
@@ -766,10 +771,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
 					     src_start, len, flags);
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
-		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+	if (!vma_can_mfill_atomic(dst_vma, flags))
 		goto out_unlock;
 
 	while (src_addr < src_start + len) {
@@ -1985,9 +1987,21 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
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
+		    vma->vm_ops->get_shared_folio)
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


