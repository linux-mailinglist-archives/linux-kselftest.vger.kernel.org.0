Return-Path: <linux-kselftest+bounces-46756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB88FC94EE4
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 12:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1873A4F46
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B6D2836A6;
	Sun, 30 Nov 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeR77mac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9D27A10F;
	Sun, 30 Nov 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764501513; cv=none; b=AjWXmjILljlBFQZaCp4/XAZOuB2+z57/LGzWOOIEPvzrXs6N/e9USCfTcybTbRw7bQj3wZVjMIMd0OKtGatw7GLb+2pw4ZuXhZKunOLeTQT9GPe4dGBDQELckcHgnN2UmCJepTRwg1XHYXlepiOUNYgZXRBwx5MCpJNj/1VKGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764501513; c=relaxed/simple;
	bh=No4OV/v0jQLoJl8PKO7GG/i2wSSVo7iZmz3MRUSzNrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojiMLhQjOAG0Z4lnO/CpzAGEIdjWLGHvg+iLRJVecjeBk9121s3E1DvK8k37GO8WlXklYj3iplZ+JWgM3HNfECgMMrQGMBb9DdKVfw48v+Dm4MjyY/WyaUpLX3uablgwBI6nEvFTHO9ibfu9jB6NlglUMmaTcj0Wx0HB7TSskc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeR77mac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353A8C116D0;
	Sun, 30 Nov 2025 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764501512;
	bh=No4OV/v0jQLoJl8PKO7GG/i2wSSVo7iZmz3MRUSzNrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YeR77mac03xw5SwBGRtzdZ/H+sOjspFJtYv8n6QV1GoUAtA5YBQtzB6KvA1McmoCj
	 KG9n1DxTyB8f5KX+wIv7kufbSzy9gESul7fy+1PQlps2ZbpuCHnm//qNHYAl6rdb0g
	 ppVz3ebKn5ThslvEpG/WIw0IQHAldkujMXFaHsjXgP69Fz5mFFnoaSO+M6Q/scZEFb
	 zXrX8iNB+/84yNGOQcJwEYDy8DWE2tSsHnhfkHwtFBe/HSjUf9gGvwuYyXcHM6oz0c
	 ORCVRYxO9icX1iVxjlcEPlwN8P+xjOcnQy4RUFOe38vEVO47X8Lwl16TMsJn4Sb/KE
	 aPvK0vIq3++yA==
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
	linux-kselftest@vger.kernel.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: [PATCH v3 2/5] userfaultfd, shmem: use a VMA callback to handle UFFDIO_CONTINUE
Date: Sun, 30 Nov 2025 13:18:09 +0200
Message-ID: <20251130111812.699259-3-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251130111812.699259-1-rppt@kernel.org>
References: <20251130111812.699259-1-rppt@kernel.org>
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

Instead of using shmem_get_folio() for that, add a get_folio_noalloc()
method to 'struct vm_operations_struct' that will return a folio if it
exists in the VMA's pagecache at given pgoff.

Implement get_folio_noalloc() method for shmem and slightly refactor
userfaultfd's mfill_atomic() and mfill_atomic_pte_continue() to support
this new API.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/mm.h |  9 ++++++++
 mm/shmem.c         | 18 ++++++++++++++++
 mm/userfaultfd.c   | 52 +++++++++++++++++++++++++++++-----------------
 3 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c79b3369b82..6351a9cde360 100644
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
+	struct folio *(*get_folio_noalloc)(struct inode *inode, pgoff_t pgoff);
+#endif
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/mm/shmem.c b/mm/shmem.c
index 5a3f0f754dc0..9f8c54ad0e32 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3262,6 +3262,18 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	shmem_inode_unacct_blocks(inode, 1);
 	return ret;
 }
+
+static struct folio *shmem_get_folio_noalloc(struct inode *inode, pgoff_t pgoff)
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
@@ -5294,6 +5306,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.get_folio_noalloc	= shmem_get_folio_noalloc,
+#endif
 };
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
@@ -5303,6 +5318,9 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.get_folio_noalloc	= shmem_get_folio_noalloc,
+#endif
 };
 
 int shmem_init_fs_context(struct fs_context *fc)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8dc964389b0d..5610f29dac73 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -388,15 +388,12 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	struct page *page;
 	int ret;
 
-	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
+	folio = dst_vma->vm_ops->get_folio_noalloc(inode, pgoff);
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
+		return vma->vm_ops && vma->vm_ops->get_folio_noalloc;
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
+		    vma->vm_ops->get_folio_noalloc)
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
2.51.0


