Return-Path: <linux-kselftest+bounces-8005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB18A57DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2E228262D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E778249D;
	Mon, 15 Apr 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bmXTwVMF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF42824A0
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198941; cv=none; b=gqkriS7n2xQihzVnsU4P43Mnhd7w0qdJpNbBj1eu1NxMkQAYsam+CiLtl6mbzudnLpPPhJNZ3tVktEioU0dzMSFd0B6VKdn2Ndgi4BJGfIvLhVb2yxBa6scCyVthIVipOANDuoRjCg7L1YVPHH3r5nu2nRRptWwMC++oAZFpg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198941; c=relaxed/simple;
	bh=wDjHw23M3GeWEybe4zkmtwCtAijGFwmC+3Yo+ns00Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6pf5T5NRz+a2ZBmQyf1Lma6HiUIoSrd/Z7UXlNP3CLII7FuYcF/iAE3h3OMpvQNDfhV3HhcV/5BeAiUXronYZW41kjOm67cuSVDH60wygUkgQ8LLyB9wMeLaE8XcxNtlXDUyNcJbwMVKmZHGRjX5Y+2g2DcCfDuWl22iAEgtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bmXTwVMF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso3201225b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713198939; x=1713803739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnCTCSle99WuorIKXvt4zXtQrdrGKvYsPewqlVt4SL8=;
        b=bmXTwVMFiBj8RjcWi5tTvFEmJM2ozIyFmornVzOCVPOHYWSEU81/KBDhIRp0w3BEWP
         MsW0iQa77XqZGG/CSRaLse2j9RSAxiA5takn59eYktmmvvF+/rkJsaRh4DqN9ECjLRW8
         VSr3PHbgSmQ/Kv0rJlPbAVfL0+gm8r0v3p2H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198939; x=1713803739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnCTCSle99WuorIKXvt4zXtQrdrGKvYsPewqlVt4SL8=;
        b=Kfqm0sLqW+7D5NV2n2IOaM9QzlFFVVh5hX8V37jLdhqNbEANbKUKUDHaAfquZSWxZs
         mr20QU3YEBXEWkOwHGeIVgnSx0MiZ231WS5qAFN/bv+Nn6JfqFITFGjizsWUQD+A6Aop
         aRGz+qpRysCPpFPoqO7UmqoCdnWY+VuIuDg/olV1O40vCLydP4H+AX8zCs2rVjcUUeLv
         oCtCeEAoSJlIYHvikwKiiNgJFNFln0OBlUsStrXR0Jl6BRXMhg8uVfPIFLoKN48PLew8
         xO+9uSDpw44tP6fcUweL3T6CPPu5ea9M9P+3p76nz0cFKyGeqUefocHg83ucgM0wo1gi
         AQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTwRMy3zTSfbhG8hE4Bfze8FPJdKkEKHSJTP+Cu/B6+TqiDVPX5p6ECtL6JyMRSOmkw/GP7SQR6gn6D1y/IZ9fBcpokcDvh8A2+9Auq9b0
X-Gm-Message-State: AOJu0Yz2mvfEBhJpyHp4GCghzhDM5h9HqjbGarn1njrvGMRkzmMcJGxn
	GqdmNt1QF3+OFFEXo4XYed/0lF2e96fCpz7Y9pGm3Rlo09/qWdQO2Gylo/e90Q==
X-Google-Smtp-Source: AGHT+IHQNHj7ENiJ0rCkxfuN0ytHMjzNjPBlUKmoggR3i0J7wtyEtoqG7oL4MpdgV62krnVmQYGOeg==
X-Received: by 2002:a05:6a00:801:b0:6ea:9252:435 with SMTP id m1-20020a056a00080100b006ea92520435mr13773673pfk.30.1713198938753;
        Mon, 15 Apr 2024 09:35:38 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id e10-20020a63aa0a000000b005dc5129ba9dsm7199863pgf.72.2024.04.15.09.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:35:38 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v10 2/5] mseal: add mseal syscall
Date: Mon, 15 Apr 2024 16:35:21 +0000
Message-ID: <20240415163527.626541-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240415163527.626541-1-jeffxu@chromium.org>
References: <20240415163527.626541-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

The new mseal() is an syscall on 64 bit CPU, and with
following signature:

int mseal(void addr, size_t len, unsigned long flags)
addr/len: memory range.
flags: reserved.

mseal() blocks following operations for the given memory range.

1> Unmapping, moving to another location, and shrinking the size,
   via munmap() and mremap(), can leave an empty space, therefore can
   be replaced with a VMA with a new set of attributes.

2> Moving or expanding a different VMA into the current location,
   via mremap().

3> Modifying a VMA via mmap(MAP_FIXED).

4> Size expansion, via mremap(), does not appear to pose any specific
   risks to sealed VMAs. It is included anyway because the use case is
   unclear. In any case, users can rely on merging to expand a sealed VMA.

5> mprotect() and pkey_mprotect().

6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anonymous
   memory, when users don't have write permission to the memory. Those
   behaviors can alter region contents by discarding pages, effectively a
   memset(0) for anonymous memory.

Following input during RFC are incooperated into this patch:

Jann Horn: raising awareness and providing valuable insights on the
destructive madvise operations.
Linus Torvalds: assisting in defining system call signature and scope.
Liam R. Howlett: perf optimization.
Theo de Raadt: sharing the experiences and insight gained from
  implementing mimmutable() in OpenBSD.

Finally, the idea that inspired this patch comes from Stephen Röttger’s
work in Chrome V8 CFI.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/syscalls.h |   1 +
 mm/Makefile              |   4 +
 mm/internal.h            |  37 +++++
 mm/madvise.c             |  12 ++
 mm/mmap.c                |  31 +++-
 mm/mprotect.c            |  10 ++
 mm/mremap.c              |  31 ++++
 mm/mseal.c               | 307 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 432 insertions(+), 1 deletion(-)
 create mode 100644 mm/mseal.c

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e619ac10cd23..9104952d323d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -821,6 +821,7 @@ asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
+asmlinkage long sys_mseal(unsigned long start, size_t len, unsigned long flags);
 asmlinkage long sys_mbind(unsigned long start, unsigned long len,
 				unsigned long mode,
 				const unsigned long __user *nmask,
diff --git a/mm/Makefile b/mm/Makefile
index 4abb40b911ec..739811890e36 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -42,6 +42,10 @@ ifdef CONFIG_CROSS_MEMORY_ATTACH
 mmu-$(CONFIG_MMU)	+= process_vm_access.o
 endif
 
+ifdef CONFIG_64BIT
+mmu-$(CONFIG_MMU)	+= mseal.o
+endif
+
 obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   maccess.o page-writeback.o folio-compat.o \
 			   readahead.o swap.o truncate.o vmscan.o shrinker.o \
diff --git a/mm/internal.h b/mm/internal.h
index 7e486f2c502c..a858161489b3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1326,6 +1326,43 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
+#ifdef CONFIG_64BIT
+/* VM is sealed, in vm_flags */
+#define VM_SEALED	_BITUL(63)
+#endif
+
+#ifdef CONFIG_64BIT
+static inline int can_do_mseal(unsigned long flags)
+{
+	if (flags)
+		return -EINVAL;
+
+	return 0;
+}
+
+bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end);
+bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
+		unsigned long end, int behavior);
+#else
+static inline int can_do_mseal(unsigned long flags)
+{
+	return -EPERM;
+}
+
+static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end)
+{
+	return true;
+}
+
+static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
+		unsigned long end, int behavior)
+{
+	return true;
+}
+#endif
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/madvise.c b/mm/madvise.c
index 44a498c94158..f7d589534e82 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1394,6 +1394,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *  -EIO    - an I/O error occurred while paging in data.
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
+ *  -EPERM  - memory is sealed.
  */
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
@@ -1437,10 +1438,21 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	start = untagged_addr_remote(mm, start);
 	end = start + len;
 
+	/*
+	 * Check if the address range is sealed for do_madvise().
+	 * can_modify_mm_madv assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm_madv(mm, start, end, behavior)) {
+		error = -EPERM;
+		goto out;
+	}
+
 	blk_start_plug(&plug);
 	error = madvise_walk_vmas(mm, start, end, behavior,
 			madvise_vma_behavior);
 	blk_finish_plug(&plug);
+
+out:
 	if (write)
 		mmap_write_unlock(mm);
 	else
diff --git a/mm/mmap.c b/mm/mmap.c
index 6dbda99a47da..4b80076c319e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1267,6 +1267,16 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			return -EEXIST;
 	}
 
+	/*
+	 * addr is returned from get_unmapped_area,
+	 * There are two cases:
+	 * 1> MAP_FIXED == false
+	 *	unallocated memory, no need to check sealing.
+	 * 1> MAP_FIXED == true
+	 *	sealing is checked inside mmap_region when
+	 *	do_vmi_munmap is called.
+	 */
+
 	if (prot == PROT_EXEC) {
 		pkey = execute_only_pkey(mm);
 		if (pkey < 0)
@@ -2682,6 +2692,14 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
+	/*
+	 * Check if memory is sealed before arch_unmap.
+	 * Prevent unmapping a sealed VMA.
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(mm, start, end))
+		return -EPERM;
+
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
@@ -2744,7 +2762,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Unmap any existing mapping in the area */
-	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
+	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
+	if (error == -EPERM)
+		return error;
+	else if (error)
 		return -ENOMEM;
 
 	/*
@@ -3094,6 +3115,14 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 
+	/*
+	 * Check if memory is sealed before arch_unmap.
+	 * Prevent unmapping a sealed VMA.
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(mm, start, end))
+		return -EPERM;
+
 	arch_unmap(mm, start, end);
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }
diff --git a/mm/mprotect.c b/mm/mprotect.c
index f8a4544b4601..b30b2494bfcd 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -32,6 +32,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/memory-tiers.h>
+#include <uapi/linux/mman.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -743,6 +744,15 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+	/*
+	 * checking if memory is sealed.
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(current->mm, start, end)) {
+		error = -EPERM;
+		goto out;
+	}
+
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
diff --git a/mm/mremap.c b/mm/mremap.c
index 38d98465f3d8..d69b438dcf83 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -902,7 +902,25 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
+	/*
+	 * In mremap_to().
+	 * Move a VMA to another location, check if src addr is sealed.
+	 *
+	 * Place can_modify_mm here because mremap_to()
+	 * does its own checking for address range, and we only
+	 * check the sealing after passing those checks.
+	 *
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(mm, addr, addr + old_len))
+		return -EPERM;
+
 	if (flags & MREMAP_FIXED) {
+		/*
+		 * In mremap_to().
+		 * VMA is moved to dst address, and munmap dst first.
+		 * do_munmap will check if dst is sealed.
+		 */
 		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
 		if (ret)
 			goto out;
@@ -1061,6 +1079,19 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	/*
+	 * Below is shrink/expand case (not mremap_to())
+	 * Check if src address is sealed, if so, reject.
+	 * In other words, prevent shrinking or expanding a sealed VMA.
+	 *
+	 * Place can_modify_mm here so we can keep the logic related to
+	 * shrink/expand together.
+	 */
+	if (!can_modify_mm(mm, addr, addr + old_len)) {
+		ret = -EPERM;
+		goto out;
+	}
+
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
diff --git a/mm/mseal.c b/mm/mseal.c
new file mode 100644
index 000000000000..daadac4b8125
--- /dev/null
+++ b/mm/mseal.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Implement mseal() syscall.
+ *
+ *  Copyright (c) 2023,2024 Google, Inc.
+ *
+ *  Author: Jeff Xu <jeffxu@chromium.org>
+ */
+
+#include <linux/mempolicy.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/mm_inline.h>
+#include <linux/mmu_context.h>
+#include <linux/syscalls.h>
+#include <linux/sched.h>
+#include "internal.h"
+
+static inline bool vma_is_sealed(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & VM_SEALED);
+}
+
+static inline void set_vma_sealed(struct vm_area_struct *vma)
+{
+	vm_flags_set(vma, VM_SEALED);
+}
+
+/*
+ * check if a vma is sealed for modification.
+ * return true, if modification is allowed.
+ */
+static bool can_modify_vma(struct vm_area_struct *vma)
+{
+	if (vma_is_sealed(vma))
+		return false;
+
+	return true;
+}
+
+static bool is_madv_discard(int behavior)
+{
+	return	behavior &
+		(MADV_FREE | MADV_DONTNEED | MADV_DONTNEED_LOCKED |
+		 MADV_REMOVE | MADV_DONTFORK | MADV_WIPEONFORK);
+}
+
+static bool is_ro_anon(struct vm_area_struct *vma)
+{
+	/* check anonymous mapping. */
+	if (vma->vm_file || vma->vm_flags & VM_SHARED)
+		return false;
+
+	/*
+	 * check for non-writable:
+	 * PROT=RO or PKRU is not writeable.
+	 */
+	if (!(vma->vm_flags & VM_WRITE) ||
+		!arch_vma_access_permitted(vma, true, false, false))
+		return true;
+
+	return false;
+}
+
+/*
+ * Check if the vmas of a memory range are allowed to be modified.
+ * the memory ranger can have a gap (unallocated memory).
+ * return true, if it is allowed.
+ */
+bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
+{
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, mm, start);
+
+	/* going through each vma to check. */
+	for_each_vma_range(vmi, vma, end) {
+		if (!can_modify_vma(vma))
+			return false;
+	}
+
+	/* Allow by default. */
+	return true;
+}
+
+/*
+ * Check if the vmas of a memory range are allowed to be modified by madvise.
+ * the memory ranger can have a gap (unallocated memory).
+ * return true, if it is allowed.
+ */
+bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsigned long end,
+		int behavior)
+{
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, mm, start);
+
+	if (!is_madv_discard(behavior))
+		return true;
+
+	/* going through each vma to check. */
+	for_each_vma_range(vmi, vma, end)
+		if (is_ro_anon(vma) && !can_modify_vma(vma))
+			return false;
+
+	/* Allow by default. */
+	return true;
+}
+
+static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct vm_area_struct **prev, unsigned long start,
+		unsigned long end, vm_flags_t newflags)
+{
+	int ret = 0;
+	vm_flags_t oldflags = vma->vm_flags;
+
+	if (newflags == oldflags)
+		goto out;
+
+	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out;
+	}
+
+	set_vma_sealed(vma);
+out:
+	*prev = vma;
+	return ret;
+}
+
+/*
+ * Check for do_mseal:
+ * 1> start is part of a valid vma.
+ * 2> end is part of a valid vma.
+ * 3> No gap (unallocated address) between start and end.
+ * 4> map is sealable.
+ */
+static int check_mm_seal(unsigned long start, unsigned long end)
+{
+	struct vm_area_struct *vma;
+	unsigned long nstart = start;
+
+	VMA_ITERATOR(vmi, current->mm, start);
+
+	/* going through each vma to check. */
+	for_each_vma_range(vmi, vma, end) {
+		if (vma->vm_start > nstart)
+			/* unallocated memory found. */
+			return -ENOMEM;
+
+		if (vma->vm_end >= end)
+			return 0;
+
+		nstart = vma->vm_end;
+	}
+
+	return -ENOMEM;
+}
+
+/*
+ * Apply sealing.
+ */
+static int apply_mm_seal(unsigned long start, unsigned long end)
+{
+	unsigned long nstart;
+	struct vm_area_struct *vma, *prev;
+
+	VMA_ITERATOR(vmi, current->mm, start);
+
+	vma = vma_iter_load(&vmi);
+	/*
+	 * Note: check_mm_seal should already checked ENOMEM case.
+	 * so vma should not be null, same for the other ENOMEM cases.
+	 */
+	prev = vma_prev(&vmi);
+	if (start > vma->vm_start)
+		prev = vma;
+
+	nstart = start;
+	for_each_vma_range(vmi, vma, end) {
+		int error;
+		unsigned long tmp;
+		vm_flags_t newflags;
+
+		newflags = vma->vm_flags | VM_SEALED;
+		tmp = vma->vm_end;
+		if (tmp > end)
+			tmp = end;
+		error = mseal_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
+		if (error)
+			return error;
+		nstart = vma_iter_end(&vmi);
+	}
+
+	return 0;
+}
+
+/*
+ * mseal(2) seals the VM's meta data from
+ * selected syscalls.
+ *
+ * addr/len: VM address range.
+ *
+ *  The address range by addr/len must meet:
+ *   start (addr) must be in a valid VMA.
+ *   end (addr + len) must be in a valid VMA.
+ *   no gap (unallocated memory) between start and end.
+ *   start (addr) must be page aligned.
+ *
+ *  len: len will be page aligned implicitly.
+ *
+ *   Below VMA operations are blocked after sealing.
+ *   1> Unmapping, moving to another location, and shrinking
+ *	the size, via munmap() and mremap(), can leave an empty
+ *	space, therefore can be replaced with a VMA with a new
+ *	set of attributes.
+ *   2> Moving or expanding a different vma into the current location,
+ *	via mremap().
+ *   3> Modifying a VMA via mmap(MAP_FIXED).
+ *   4> Size expansion, via mremap(), does not appear to pose any
+ *	specific risks to sealed VMAs. It is included anyway because
+ *	the use case is unclear. In any case, users can rely on
+ *	merging to expand a sealed VMA.
+ *   5> mprotect and pkey_mprotect.
+ *   6> Some destructive madvice() behavior (e.g. MADV_DONTNEED)
+ *      for anonymous memory, when users don't have write permission to the
+ *	memory. Those behaviors can alter region contents by discarding pages,
+ *	effectively a memset(0) for anonymous memory.
+ *
+ *  flags: reserved.
+ *
+ * return values:
+ *  zero: success.
+ *  -EINVAL:
+ *   invalid input flags.
+ *   start address is not page aligned.
+ *   Address arange (start + len) overflow.
+ *  -ENOMEM:
+ *   addr is not a valid address (not allocated).
+ *   end (start + len) is not a valid address.
+ *   a gap (unallocated memory) between start and end.
+ *  -EPERM:
+ *  - In 32 bit architecture, sealing is not supported.
+ * Note:
+ *  user can call mseal(2) multiple times, adding a seal on an
+ *  already sealed memory is a no-action (no error).
+ *
+ *  unseal() is not supported.
+ */
+static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
+{
+	size_t len;
+	int ret = 0;
+	unsigned long end;
+	struct mm_struct *mm = current->mm;
+
+	ret = can_do_mseal(flags);
+	if (ret)
+		return ret;
+
+	start = untagged_addr(start);
+	if (!PAGE_ALIGNED(start))
+		return -EINVAL;
+
+	len = PAGE_ALIGN(len_in);
+	/* Check to see whether len was rounded up from small -ve to zero. */
+	if (len_in && !len)
+		return -EINVAL;
+
+	end = start + len;
+	if (end < start)
+		return -EINVAL;
+
+	if (end == start)
+		return 0;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	/*
+	 * First pass, this helps to avoid
+	 * partial sealing in case of error in input address range,
+	 * e.g. ENOMEM error.
+	 */
+	ret = check_mm_seal(start, end);
+	if (ret)
+		goto out;
+
+	/*
+	 * Second pass, this should success, unless there are errors
+	 * from vma_modify_flags, e.g. merge/split error, or process
+	 * reaching the max supported VMAs, however, those cases shall
+	 * be rare.
+	 */
+	ret = apply_mm_seal(start, end);
+
+out:
+	mmap_write_unlock(current->mm);
+	return ret;
+}
+
+SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
+		flags)
+{
+	return do_mseal(start, len, flags);
+}
-- 
2.44.0.683.g7961c838ac-goog


