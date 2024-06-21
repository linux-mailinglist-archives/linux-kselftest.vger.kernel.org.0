Return-Path: <linux-kselftest+bounces-12465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33926912E60
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95381F2694E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78EE17C223;
	Fri, 21 Jun 2024 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="gB/KkC7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB817B512;
	Fri, 21 Jun 2024 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000918; cv=none; b=WkY4BG/0TooOHtVg81P45Ok7EzBS/WOCm9wMj3jMb8je2WTelKBcGiV/60G3x3qRae9m8E9pE7NR2FvsKzwThM058Z9iAPCdojigAHiFhiuso8XNCoLAgaaASALRs0tRryn3NzZg8BnQIJyMn0aw41AIB2e7uhU/bUXF/ZEmGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000918; c=relaxed/simple;
	bh=bSBdZGF6LRssAI/Rx+kIA+ji3YUXlfirm2I1itL62nE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqrSZiXw6vlCF+N7Y9+1aqqigJx09z4nlF4tPgl17qLrY7h7sJYWti6Fh60RQr+NOoU3s4gFNsjoh9n/kfISJdwhDGDSnyNVOn6d6qzO5Gwv2TUTTmEkz6iTlIgRL6oyQJOYo7j1jo1dVdCGDp8scAOZk6Gd1rFmrZ+r33/4fWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=gB/KkC7o; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1719000917; x=1750536917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8A8fBnTBJUktIhE7t/qfVb2lWMxrmgjjk5MKWEGnJ74=;
  b=gB/KkC7oeMGCCpFEHJNhmD+BvJk1BNlXoqtuO5uxXQmJmcb/P8/yDOxJ
   7z5e6dewyPO5/6LYEUFFM2QUyN6nn6saebiswR0+lq5a3kddcgIjQtBGR
   A2yI7z1S2mpBWlWcQ0hdLubXoyEzD5KPuMnBZv2dOlmYUFkMcdwFeuE+Y
   I=;
X-IronPort-AV: E=Sophos;i="6.08,255,1712620800"; 
   d="scan'208";a="404915380"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 20:15:14 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:50033]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.42.217:2525] with esmtp (Farcaster)
 id 96bdc7d3-11c3-449e-b050-961be9d82a02; Fri, 21 Jun 2024 20:15:13 +0000 (UTC)
X-Farcaster-Flow-ID: 96bdc7d3-11c3-449e-b050-961be9d82a02
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 20:15:10 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 20:15:09 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.95.134.31) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34 via Frontend Transport; Fri, 21 Jun 2024 20:15:08 +0000
From: Roman Kagan <rkagan@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Dragan Cvetic <dragan.cvetic@amd.com>,
	Fares Mehanna <faresx@amazon.de>, Alexander Graf <graf@amazon.de>, "Derek
 Kiernan" <derek.kiernan@amd.com>, <linux-kselftest@vger.kernel.org>,
	<nh-open-source@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-mm@kvack.org>, David Woodhouse <dwmw@amazon.co.uk>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 2/3] mm/secretmem: implement mm-local kernel allocations
Date: Fri, 21 Jun 2024 22:15:00 +0200
Message-ID: <20240621201501.1059948-3-rkagan@amazon.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621201501.1059948-1-rkagan@amazon.de>
References: <20240621201501.1059948-1-rkagan@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Fares Mehanna <faresx@amazon.de>

In order to be resilient against cross-process speculation-based
attacks, it makes sense to store certain (secret) items in kernel memory
local to mm.

Implement such allocations on top of secretmem infrastructure.

Specifically, on allocate

1. Create secretmem file.
2. To distinguish it from the conventional memfd_secret()-created one
   and to maintain associated mm-local allocation context, put the
   latter on ->private_data of the file.
3. Create virtual mapping in user virtual address space using mmap().
4. Seal the virtual mapping to disallow the user from affecting it in
   any way.
5. Fault the pages in, effectively calling secretmem fault handler to
   remove the pages from kernel linear address and make them local to
   process mm.
6. Change the PTE from user mode to kernel mode, any access from
   userspace will result in segmentation fault. Kernel can access this
   virtual address now.
7. Return the secure area as a struct containing the pointer to the
   actual memory and providing the context for the release function
   later.

On release,

- if called while mm is still in use, remove the mapping
- otherwise, if performed at mm teardown, no unmapping is necessary

The rest is taken care of by secretmem file cleanup, including returning
the pages to the kernel direct map.

Signed-off-by: Fares Mehanna <faresx@amazon.de>
Signed-off-by: Roman Kagan <rkagan@amazon.de>
---
 include/linux/secretmem.h |   8 ++
 mm/gup.c                  |   4 +-
 mm/secretmem.c            | 208 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+), 2 deletions(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index e918f96881f5..c6d65b5a89bd 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -4,6 +4,10 @@
 
 #ifdef CONFIG_SECRETMEM
 
+struct secretmem_area {
+	void *ptr;
+};
+
 extern const struct address_space_operations secretmem_aops;
 
 static inline bool secretmem_mapping(struct address_space *mapping)
@@ -12,8 +16,12 @@ static inline bool secretmem_mapping(struct address_space *mapping)
 }
 
 bool vma_is_secretmem(struct vm_area_struct *vma);
+bool can_access_secretmem_vma(struct vm_area_struct *vma);
 bool secretmem_active(void);
 
+struct secretmem_area *secretmem_allocate_pages(unsigned int order);
+void secretmem_release_pages(struct secretmem_area *data);
+
 #else
 
 static inline bool vma_is_secretmem(struct vm_area_struct *vma)
diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b..ccf28b7baab9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1172,7 +1172,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	struct follow_page_context ctx = { NULL };
 	struct page *page;
 
-	if (vma_is_secretmem(vma))
+	if (!can_access_secretmem_vma(vma))
 		return NULL;
 
 	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
@@ -1377,7 +1377,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
-	if (vma_is_secretmem(vma))
+	if (!can_access_secretmem_vma(vma))
 		return -EFAULT;
 
 	if (write) {
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 3afb5ad701e1..de6860a0cb1b 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -13,13 +13,17 @@
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/pagemap.h>
+#include <linux/hugetlb.h>
 #include <linux/syscalls.h>
 #include <linux/pseudo_fs.h>
 #include <linux/secretmem.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/mm.h>
 
+#include <uapi/asm-generic/mman-common.h>
 #include <uapi/linux/magic.h>
+#include <uapi/linux/mman.h>
 
 #include <asm/tlbflush.h>
 
@@ -42,6 +46,15 @@ MODULE_PARM_DESC(secretmem_enable,
 
 static atomic_t secretmem_users;
 
+/* secretmem file private context */
+struct secretmem_ctx {
+	struct secretmem_area _area;
+	struct page **_pages;
+	unsigned long _nr_pages;
+	struct file *_file;
+	struct mm_struct *_mm;
+};
+
 bool secretmem_active(void)
 {
 	return !!atomic_read(&secretmem_users);
@@ -116,6 +129,7 @@ static const struct vm_operations_struct secretmem_vm_ops = {
 
 static int secretmem_release(struct inode *inode, struct file *file)
 {
+	kfree(file->private_data);
 	atomic_dec(&secretmem_users);
 	return 0;
 }
@@ -123,13 +137,23 @@ static int secretmem_release(struct inode *inode, struct file *file)
 static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long len = vma->vm_end - vma->vm_start;
+	struct secretmem_ctx *ctx = file->private_data;
+	unsigned long kernel_no_permissions;
+
+	kernel_no_permissions = (VM_READ | VM_WRITE | VM_EXEC | VM_MAYEXEC);
 
 	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
+	if (ctx && (vma->vm_flags & kernel_no_permissions))
+		return -EINVAL;
+
 	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
 		return -EAGAIN;
 
+	if (ctx)
+		vm_flags_set(vma, VM_MIXEDMAP);
+
 	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
 	vma->vm_ops = &secretmem_vm_ops;
 
@@ -141,6 +165,24 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
 	return vma->vm_ops == &secretmem_vm_ops;
 }
 
+bool can_access_secretmem_vma(struct vm_area_struct *vma)
+{
+	struct secretmem_ctx *ctx;
+
+	if (!vma_is_secretmem(vma))
+		return true;
+
+	/*
+	 * If VMA is owned by running process, and marked for kernel
+	 * usage, then allow access.
+	 */
+	ctx = vma->vm_file->private_data;
+	if (ctx && current->mm == vma->vm_mm)
+		return true;
+
+	return false;
+}
+
 static const struct file_operations secretmem_fops = {
 	.release	= secretmem_release,
 	.mmap		= secretmem_mmap,
@@ -230,6 +272,172 @@ static struct file *secretmem_file_create(unsigned long flags)
 	return file;
 }
 
+struct secretmem_area *secretmem_allocate_pages(unsigned int order)
+{
+	unsigned long uvaddr, uvaddr_inc, unused, nr_pages, bytes_length;
+	struct file *kernel_secfile;
+	struct vm_area_struct *vma;
+	struct secretmem_ctx *ctx;
+	struct page **sec_pages;
+	struct mm_struct *mm;
+	long nr_pinned_pages;
+	pte_t pte, old_pte;
+	spinlock_t *ptl;
+	pte_t *upte;
+	int rc;
+
+	nr_pages = (1 << order);
+	bytes_length = nr_pages * PAGE_SIZE;
+	mm = current->mm;
+
+	if (!mm || !mmget_not_zero(mm))
+		return NULL;
+
+	/* Create secret memory file / truncate it */
+	kernel_secfile = secretmem_file_create(0);
+	if (IS_ERR(kernel_secfile))
+		goto put_mm;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (IS_ERR(ctx))
+		goto close_secfile;
+	kernel_secfile->private_data = ctx;
+
+	rc = do_truncate(file_mnt_idmap(kernel_secfile),
+			 file_dentry(kernel_secfile), bytes_length, 0, NULL);
+	if (rc)
+		goto close_secfile;
+
+	if (mmap_write_lock_killable(mm))
+		goto close_secfile;
+
+	/* Map pages to the secretmem file */
+	uvaddr = do_mmap(kernel_secfile, 0, bytes_length, PROT_NONE,
+			 MAP_SHARED, 0, 0, &unused, NULL);
+	if (IS_ERR_VALUE(uvaddr))
+		goto unlock_mmap;
+
+	/* mseal() the VMA to make sure it won't change */
+	rc = do_mseal(uvaddr, uvaddr + bytes_length, true);
+	if (rc)
+		goto unmap_pages;
+
+	/* Make sure VMA is there, and is kernel-secure */
+	vma = find_vma(current->mm, uvaddr);
+	if (!vma)
+		goto unseal_vma;
+
+	if (!vma_is_secretmem(vma) ||
+	    !can_access_secretmem_vma(vma))
+		goto unseal_vma;
+
+	/* Pin user pages; fault them in */
+	sec_pages = kzalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
+	if (!sec_pages)
+		goto unseal_vma;
+
+	nr_pinned_pages = pin_user_pages(uvaddr, nr_pages, FOLL_FORCE | FOLL_LONGTERM, sec_pages);
+	if (nr_pinned_pages < 0)
+		goto free_sec_pages;
+	if (nr_pinned_pages != nr_pages)
+		goto unpin_pages;
+
+	/* Modify the existing mapping to be kernel accessible, local to this process mm */
+	uvaddr_inc = uvaddr;
+	while (uvaddr_inc < uvaddr + bytes_length) {
+		upte = get_locked_pte(mm, uvaddr_inc, &ptl);
+		if (!upte)
+			goto unpin_pages;
+		old_pte = ptep_modify_prot_start(vma, uvaddr_inc, upte);
+		pte = pte_modify(old_pte, PAGE_KERNEL);
+		ptep_modify_prot_commit(vma, uvaddr_inc, upte, old_pte, pte);
+		pte_unmap_unlock(upte, ptl);
+		uvaddr_inc += PAGE_SIZE;
+	}
+	flush_tlb_range(vma, uvaddr, uvaddr + bytes_length);
+
+	/* Return data */
+	mmgrab(mm);
+	ctx->_area.ptr = (void *) uvaddr;
+	ctx->_pages = sec_pages;
+	ctx->_nr_pages = nr_pages;
+	ctx->_mm = mm;
+	ctx->_file = kernel_secfile;
+
+	mmap_write_unlock(mm);
+	mmput(mm);
+
+	return &(ctx->_area);
+
+unpin_pages:
+	unpin_user_pages(sec_pages, nr_pinned_pages);
+free_sec_pages:
+	kfree(sec_pages);
+unseal_vma:
+	rc = do_mseal(uvaddr, uvaddr + bytes_length, false);
+	if (rc)
+		BUG();
+unmap_pages:
+	rc = do_munmap(mm, uvaddr, bytes_length, NULL);
+	if (rc)
+		BUG();
+unlock_mmap:
+	mmap_write_unlock(mm);
+close_secfile:
+	fput(kernel_secfile);
+put_mm:
+	mmput(mm);
+	return NULL;
+}
+
+void secretmem_release_pages(struct secretmem_area *data)
+{
+	unsigned long uvaddr, bytes_length;
+	struct secretmem_ctx *ctx;
+	int rc;
+
+	if (!data || !data->ptr)
+		BUG();
+
+	ctx = container_of(data, struct secretmem_ctx, _area);
+	if (!ctx || !ctx->_file || !ctx->_pages || !ctx->_mm)
+		BUG();
+
+	bytes_length = ctx->_nr_pages * PAGE_SIZE;
+	uvaddr = (unsigned long) data->ptr;
+
+	/*
+	 * Remove the mapping if mm is still in use.
+	 * Not secure to continue if unmapping failed.
+	 */
+	if (mmget_not_zero(ctx->_mm)) {
+		mmap_write_lock(ctx->_mm);
+		rc = do_mseal(uvaddr, uvaddr + bytes_length, false);
+		if (rc) {
+			mmap_write_unlock(ctx->_mm);
+			BUG();
+		}
+		rc = do_munmap(ctx->_mm, uvaddr, bytes_length, NULL);
+		if (rc) {
+			mmap_write_unlock(ctx->_mm);
+			BUG();
+		}
+		mmap_write_unlock(ctx->_mm);
+		mmput(ctx->_mm);
+	}
+
+	mmdrop(ctx->_mm);
+	unpin_user_pages(ctx->_pages, ctx->_nr_pages);
+	fput(ctx->_file);
+	kfree(ctx->_pages);
+
+	ctx->_nr_pages = 0;
+	ctx->_pages = NULL;
+	ctx->_file = NULL;
+	ctx->_mm = NULL;
+	ctx->_area.ptr = NULL;
+}
+
 SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 {
 	struct file *file;
-- 
2.34.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


