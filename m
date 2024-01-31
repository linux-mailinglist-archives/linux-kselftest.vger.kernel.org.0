Return-Path: <linux-kselftest+bounces-3863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A2584467C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 18:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC2E283644
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D1712F5BF;
	Wed, 31 Jan 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IS/y/i87"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFC12F59F
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723440; cv=none; b=nxB4eNgCX7MKtR/Ht2yPNfjNUOhL1HshRG5Q0L+0n9YSHmfh2wlml5ogcour3snByePsyraqm1+AGh+/4lpcz0gVhxXqyoPuHs+nIX6THr5LY5VouSX3U/P7shAd5aCTMYvsg7r9XZPDP07dERuH/ttHHSh5z72zBWtDl7yBg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723440; c=relaxed/simple;
	bh=8kB3ptXnSr+9GjyoQdi5b+Ikq6l4+27yK8MoRvfdY9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCEz1UZVOIX+Hjy95Q7/bAh1IT4P8cgu+EXkykwT5m2dlLYLHmAXY3PCiJDkhA9LWVPKXrWg+k1gfOj7ViC1SZcFkove6nxcP/Vo7KJ8sPxjviRuUbPqwQzE6fHeR9C24mG5N2DTDwRkRUx6rHi+s6xXSbdGaXeNKLM5Ym+eO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IS/y/i87; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d8f3acc758so8594785ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706723438; x=1707328238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCjdMwZMA++5Y7uxHr8gfX97g0FD428wDoXzu0fVBfA=;
        b=IS/y/i87IDxSICkjcKzbiY9rUXM0RJLK2dLDgvVHZxxZVMZDacARBOxPkYDfrMRWUY
         GD+Y0sco9fKeb/gSK5q6zLt5aUTdirx3v1K4AGoSSGA31P7+m6MTdubwf6k/F915foGP
         c7AOSUXynh2G/NDFFtqhLYYpsraBCSxpsgay0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723438; x=1707328238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCjdMwZMA++5Y7uxHr8gfX97g0FD428wDoXzu0fVBfA=;
        b=a2klljU875CR0U4e3ne60K3W/zbT26Hh3Ey9J8mUn6t+MR5gNOOIGgROaJjafkAPfg
         TuMv8501KGH8plztvd5mW0eWVgNKCvR0bZSLS79IEzijqq2l3r8cIhByVxmcvHFKzWM4
         izWARh7eZal090YmF/BmxdAAQtrGtEikuSSi1wO3sN2K4kmuMKOHCJIWoY+qt84aDDKV
         N3oBDPxQDjKCnnlQY0AfYkDRoN+DRLliRica3FhBgK4fppRoUuSfuO1TIW+R5Di7Lgwm
         ulmB0eNk6SUzML4db+RHV1dda7wrKfNVPgtsgJJmPgV3nS+zXeNF77mcf8vhhfYXwLCo
         B53A==
X-Gm-Message-State: AOJu0Yxbmd73+sg+iWAAqx4TMgnU7r6z4aNZ+iBITkVpg20RNZQC5wMf
	k0TGjJqGbQNENLJtxK4oureYS7XuqxTnOAQhQ8wwT1dCjFKP4s0553DOG9JEnw==
X-Google-Smtp-Source: AGHT+IETZCfdsABJrO66JGuXN/f7sNRNe1QZ0wcnT3etXgH6bQnC6mhfP/tuS9KIVT/zWqnZ+YhOJw==
X-Received: by 2002:a17:902:ec92:b0:1d4:e6d0:34db with SMTP id x18-20020a170902ec9200b001d4e6d034dbmr6772391plg.19.1706723437815;
        Wed, 31 Jan 2024 09:50:37 -0800 (PST)
Received: from localhost (56.72.82.34.bc.googleusercontent.com. [34.82.72.56])
        by smtp.gmail.com with UTF8SMTPSA id ka7-20020a170903334700b001d7252fef6bsm9414860plb.299.2024.01.31.09.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:50:36 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
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
Subject: [PATCH v8 2/4] mseal: add mseal syscall
Date: Wed, 31 Jan 2024 17:50:24 +0000
Message-ID: <20240131175027.3287009-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240131175027.3287009-1-jeffxu@chromium.org>
References: <20240131175027.3287009-1-jeffxu@chromium.org>
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

In addition: mmap() has two related changes.

The PROT_SEAL bit in prot field of mmap(). When present, it marks
the map sealed since creation.

The MAP_SEALABLE bit in the flags field of mmap(). When present, it marks
the map as sealable. A map created without MAP_SEALABLE will not support
sealing, i.e. mseal() will fail.

Applications that don't care about sealing will expect their behavior
unchanged. For those that need sealing support, opt-in by adding
MAP_SEALABLE in mmap().

Following input during RFC are incooperated into this patch:

Jann Horn: raising awareness and providing valuable insights on the
destructive madvise operations.
Linus Torvalds: assisting in defining system call signature and scope.
Pedro Falcato: suggesting sealing in the mmap().
Liam R. Howlett: perf optimization.

Finally, the idea that inspired this patch comes from Stephen Röttger’s
work in Chrome V8 CFI.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/mman-common.h |   8 +
 mm/Makefile                            |   4 +
 mm/internal.h                          |  48 ++++
 mm/madvise.c                           |  12 +
 mm/mmap.c                              |  35 ++-
 mm/mprotect.c                          |  10 +
 mm/mremap.c                            |  31 +++
 mm/mseal.c                             | 343 +++++++++++++++++++++++++
 9 files changed, 491 insertions(+), 1 deletion(-)
 create mode 100644 mm/mseal.c

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index cdba4d0c6d4a..2d44e0d99e37 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -820,6 +820,7 @@ asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
+asmlinkage long sys_mseal(unsigned long start, size_t len, unsigned long flags);
 asmlinkage long sys_mbind(unsigned long start, unsigned long len,
 				unsigned long mode,
 				const unsigned long __user *nmask,
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..3ca4d694a621 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -17,6 +17,11 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
+/*
+ * The PROT_SEAL defines memory sealing in the prot argument of mmap().
+ */
+#define PROT_SEAL	0x04000000	/* _BITUL(26) */
+
 /* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
@@ -33,6 +38,9 @@
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
 
+/* map is sealable */
+#define MAP_SEALABLE	0x8000000	/* _BITUL(27) */
+
 /*
  * Flags for mlock
  */
diff --git a/mm/Makefile b/mm/Makefile
index e4b5b75aaec9..cbae83f74642 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -43,6 +43,10 @@ ifdef CONFIG_CROSS_MEMORY_ATTACH
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
index f309a010d50f..00b45c8550c4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1221,6 +1221,54 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
+#ifdef CONFIG_64BIT
+/* VM is sealable, in vm_flags */
+#define VM_SEALABLE	_BITUL(63)
+
+/* VM is sealed, in vm_flags */
+#define VM_SEALED	_BITUL(62)
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
+unsigned long get_mmap_seals(unsigned long prot,
+		unsigned long flags);
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
+
+static inline unsigned long get_mmap_seals(unsigned long prot,
+	unsigned long flags)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/madvise.c b/mm/madvise.c
index 912155a94ed5..9c0761c68111 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1393,6 +1393,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *  -EIO    - an I/O error occurred while paging in data.
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
+ *  -EPERM  - memory is sealed.
  */
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
@@ -1436,10 +1437,21 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
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
index b78e83d351d2..4b3143044db4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1213,6 +1213,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	int pkey = 0;
+	unsigned long vm_seals;
 
 	*populate = 0;
 
@@ -1233,6 +1234,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (flags & MAP_FIXED_NOREPLACE)
 		flags |= MAP_FIXED;
 
+	vm_seals = get_mmap_seals(prot, flags);
+
 	if (!(flags & MAP_FIXED))
 		addr = round_hint_to_min(addr);
 
@@ -1261,6 +1264,16 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
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
@@ -1376,6 +1389,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
+	vm_flags |= vm_seals;
 	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
@@ -2679,6 +2693,14 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
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
 
@@ -2741,7 +2763,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Unmap any existing mapping in the area */
-	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
+	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
+	if (error == -EPERM)
+		return error;
+	else if (error)
 		return -ENOMEM;
 
 	/*
@@ -3102,6 +3127,14 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
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
index 81991102f785..5f0f716bf4ae 100644
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
index 000000000000..abc00c0b9895
--- /dev/null
+++ b/mm/mseal.c
@@ -0,0 +1,343 @@
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
+static inline bool vma_is_sealable(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_SEALABLE;
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
+unsigned long get_mmap_seals(unsigned long prot,
+		unsigned long flags)
+{
+	unsigned long vm_seals;
+
+	if (prot & PROT_SEAL)
+		vm_seals = VM_SEALED | VM_SEALABLE;
+	else
+		vm_seals = (flags & MAP_SEALABLE) ? VM_SEALABLE : 0;
+
+	return vm_seals;
+}
+
+/*
+ * Check if a seal type can be added to VMA.
+ */
+static bool can_add_vma_seal(struct vm_area_struct *vma)
+{
+	/* if map is not sealable, reject. */
+	if (!vma_is_sealable(vma))
+		return false;
+
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
+		if (!can_add_vma_seal(vma))
+			return -EACCES;
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
+		tmp = vma_iter_end(&vmi);
+		nstart = tmp;
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
+ *  -EACCES:
+ *   MAP_SEALABLE is not set.
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
+	 * e.g. ENOMEM and EACCESS error.
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
2.43.0.429.g432eaa2c6b-goog


