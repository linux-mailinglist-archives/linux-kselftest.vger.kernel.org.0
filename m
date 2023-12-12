Return-Path: <linux-kselftest+bounces-1757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57980FB22
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982961F218B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92AC6472E;
	Tue, 12 Dec 2023 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lX1FHusX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5FB2
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:12 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d9f879f784so3384896a34.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423032; x=1703027832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmouMMuL78gKzcDFfbVzkzXE8UDTo3Q4rwqrYea/myQ=;
        b=lX1FHusXWCgacqtjr4amN5wcHfC3jsH9j08xBbFV+d/o/JAuCEJymeuO3F+i6aVb6u
         2aH9ytcBN6Dr1ePRno5TSIhR62rt0pjMlPLjRdO7I1Lq/D35erfiH5gLJBF+MwP9LPf5
         Z3vhD8hrveQ7OybEF7hZ94uP9vVNzyH98m614=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423032; x=1703027832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmouMMuL78gKzcDFfbVzkzXE8UDTo3Q4rwqrYea/myQ=;
        b=wvt2CsCdDbgon5at8xBYjXRqbP0378w71s1aSSbM7onlI+n1UwkM+oBN+wpVcvmpVC
         wOfBWrrI2XnydaNJ47czKzY4VPb7dILeCZI0o6CrSo7rVGoP27wGbgGUGNzrOQTI5VzA
         jjcpJTiAFYRsofyAHxx6DHx50bB3R0IVXihck+1EsD99w1rQ+Rerw6N49S10uwRAWhSc
         dgZUJMnDRM/bW/6kpdtSkrKFs7LYnBk0r/LckW+fdIBllHGdC4qdMrZUtjHufpsvc10B
         FAxVBCwLi6TVgG3OXrL2At/4A4Lh/FFtUFw867rk8q393ng128X3EfhAP+Mz0WoTOfWX
         Ef5Q==
X-Gm-Message-State: AOJu0YzTGTqiczrhjh0dx60FpSN/03/eaxWTqAy7BidzfBEQdjN53BIM
	R2MdEPJosK5bukjJkkSsnktitw==
X-Google-Smtp-Source: AGHT+IHWRbxCpkSD3Z0OA1+KEQM7Nb43rRei8W5sZbD56ePXA6pfN1fHTdnYRm+1Er/WpLM8j3G00Q==
X-Received: by 2002:a05:6871:b06:b0:1fb:337c:402c with SMTP id fq6-20020a0568710b0600b001fb337c402cmr8802265oab.37.1702423031712;
        Tue, 12 Dec 2023 15:17:11 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id p2-20020aa78602000000b006ce691a1419sm8646308pfn.186.2023.12.12.15.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:11 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
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
Subject: [RFC PATCH v3 01/11] mseal: Add mseal syscall.
Date: Tue, 12 Dec 2023 23:16:55 +0000
Message-ID: <20231212231706.2680890-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212231706.2680890-1-jeffxu@chromium.org>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

The new mseal() is an architecture independent syscall, and with
following signature:

mseal(void addr, size_t len, unsigned long types, unsigned long flags)

addr/len: memory range.  Must be continuous/allocated memory, or else
mseal() will fail and no VMA is updated. For details on acceptable
arguments, please refer to comments in mseal.c. Those are also covered
by the selftest.

This CL adds three sealing types.
MM_SEAL_BASE
MM_SEAL_PROT_PKEY
MM_SEAL_SEAL

The MM_SEAL_BASE:
The base package includes the features common to all VMA sealing
types. It prevents sealed VMAs from:
1> Unmapping, moving to another location, and shrinking the size, via
munmap() and mremap(), can leave an empty space, therefore can be
replaced with a VMA with a new set of attributes.
2> Move or expand a different vma into the current location, via mremap().
3> Modifying sealed VMA via mmap(MAP_FIXED).
4> Size expansion, via mremap(), does not appear to pose any specific
risks to sealed VMAs. It is included anyway because the use case is
unclear. In any case, users can rely on merging to expand a sealed
VMA.

We consider the MM_SEAL_BASE feature, on which other sealing features
will depend. For instance, it probably does not make sense to seal
PROT_PKEY without sealing the BASE, and the kernel will implicitly add
SEAL_BASE for SEAL_PROT_PKEY. (If the application wants to relax this
in future, we could use the “flags” field  in mseal() to overwrite
this the behavior of implicitly adding SEAL_BASE.)

The MM_SEAL_PROT_PKEY:
Seal PROT and PKEY of the address range, in other words, mprotect()
and pkey_mprotect() will be denied if the memory is sealed with
MM_SEAL_PROT_PKEY.

The MM_SEAL_SEAL
MM_SEAL_SEAL denies adding a new seal for an VMA.
The kernel will remember which seal types are applied, and the
application doesn’t need to repeat all existing seal types in the next
mseal().  Once a seal type is applied, it can’t be unsealed. Call
mseal() on an existing seal type is a no-action, not a failure.

Data structure:
Internally, the vm_area_struct adds a new field, vm_seals, to store
the bit masks. The vm_seals field is added because the existing
vm_flags field is full in 32-bit CPUs. The vm_seals field can be
merged into vm_flags in the future if the size of vm_flags is ever
expanded.

TODO: Sealed VMA won't merge with other VMA in this patch, merging
support will be added in later patch.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/mm.h        |  45 ++++++-
 include/linux/mm_types.h  |   7 ++
 include/linux/syscalls.h  |   2 +
 include/uapi/linux/mman.h |   4 +
 kernel/sys_ni.c           |   1 +
 mm/Kconfig                |   9 ++
 mm/Makefile               |   1 +
 mm/mmap.c                 |   3 +
 mm/mseal.c                | 257 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 328 insertions(+), 1 deletion(-)
 create mode 100644 mm/mseal.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 19fc73b02c9f..3d1120570de5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -30,6 +30,7 @@
 #include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
+#include <uapi/linux/mman.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -257,9 +258,17 @@ extern struct rw_semaphore nommu_region_sem;
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+/*
+ * MM_SEAL_ALL is all supported flags in mseal().
+ */
+#define MM_SEAL_ALL ( \
+	MM_SEAL_SEAL | \
+	MM_SEAL_BASE | \
+	MM_SEAL_PROT_PKEY)
+
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
- * When changing, update also include/trace/events/mmflags.h
+ * When changing, update also include/trace/events/mmflags.h.
  */
 #define VM_NONE		0x00000000
 
@@ -3308,6 +3317,40 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
 static inline void mm_populate(unsigned long addr, unsigned long len) {}
 #endif
 
+#ifdef CONFIG_MSEAL
+static inline bool check_vma_seals_mergeable(unsigned long vm_seals)
+{
+	/*
+	 * Set sealed VMA not mergeable with another VMA for now.
+	 * This will be changed in later commit to make sealed
+	 * VMA also mergeable.
+	 */
+	if (vm_seals & MM_SEAL_ALL)
+		return false;
+
+	return true;
+}
+
+/*
+ * return the valid sealing (after mask).
+ */
+static inline unsigned long vma_seals(struct vm_area_struct *vma)
+{
+	return (vma->vm_seals & MM_SEAL_ALL);
+}
+
+#else
+static inline bool check_vma_seals_mergeable(unsigned long vm_seals1)
+{
+	return true;
+}
+
+static inline unsigned long vma_seals(struct vm_area_struct *vma)
+{
+	return 0;
+}
+#endif
+
 /* These take the mm semaphore themselves */
 extern int __must_check vm_brk(unsigned long, unsigned long);
 extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 589f31ef2e84..052799173c86 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -687,6 +687,13 @@ struct vm_area_struct {
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+#ifdef CONFIG_MSEAL
+	/*
+	 * bit masks for seal.
+	 * need this since vm_flags is full.
+	 */
+	unsigned long vm_seals;		/* seal flags, see mm.h. */
+#endif
 } __randomize_layout;
 
 #ifdef CONFIG_SCHED_MM_CID
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 0901af60d971..b1c766b74765 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -812,6 +812,8 @@ asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
+asmlinkage long sys_mseal(unsigned long start, size_t len, unsigned long types,
+			  unsigned long flags);
 asmlinkage long sys_mbind(unsigned long start, unsigned long len,
 				unsigned long mode,
 				const unsigned long __user *nmask,
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index a246e11988d5..f561652886c4 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -55,4 +55,8 @@ struct cachestat {
 	__u64 nr_recently_evicted;
 };
 
+#define MM_SEAL_SEAL		_BITUL(0)
+#define MM_SEAL_BASE		_BITUL(1)
+#define MM_SEAL_PROT_PKEY	_BITUL(2)
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 9db51ea373b0..716d64df522d 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -195,6 +195,7 @@ COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
 COND_SYSCALL(cachestat);
+COND_SYSCALL(mseal);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/Kconfig b/mm/Kconfig
index 264a2df5ecf5..63972d476d19 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1258,6 +1258,15 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config MSEAL
+	default n
+	bool "Enable mseal() system call"
+	depends on MMU
+	help
+	  Enable the virtual memory sealing.
+	  This feature allows sealing each virtual memory area separately with
+	  multiple sealing types.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index ec65984e2ade..643d8518dac0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
 obj-$(CONFIG_SECRETMEM) += secretmem.o
+obj-$(CONFIG_MSEAL) += mseal.o
 obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
 obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
 obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
diff --git a/mm/mmap.c b/mm/mmap.c
index 9e018d8dd7d6..42462c2a0c35 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -740,6 +740,9 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 		return false;
 	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
 		return false;
+	if (!check_vma_seals_mergeable(vma_seals(vma)))
+		return false;
+
 	return true;
 }
 
diff --git a/mm/mseal.c b/mm/mseal.c
new file mode 100644
index 000000000000..13bbe9ef5883
--- /dev/null
+++ b/mm/mseal.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Implement mseal() syscall.
+ *
+ *  Copyright (c) 2023 Google, Inc.
+ *
+ *  Author: Jeff Xu <jeffxu@chromium.org>
+ */
+
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/syscalls.h>
+#include <linux/sched.h>
+#include "internal.h"
+
+static bool can_do_mseal(unsigned long types, unsigned long flags)
+{
+	/* check types is a valid bitmap. */
+	if (types & ~MM_SEAL_ALL)
+		return false;
+
+	/* flags isn't used for now. */
+	if (flags)
+		return false;
+
+	return true;
+}
+
+/*
+ * Check if a seal type can be added to VMA.
+ */
+static bool can_add_vma_seals(struct vm_area_struct *vma, unsigned long newSeals)
+{
+	/* When SEAL_MSEAL is set, reject if a new type of seal is added. */
+	if ((vma->vm_seals & MM_SEAL_SEAL) &&
+	    (newSeals & ~(vma_seals(vma))))
+		return false;
+
+	return true;
+}
+
+static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct vm_area_struct **prev, unsigned long start,
+		unsigned long end, unsigned long addtypes)
+{
+	int ret = 0;
+
+	if (addtypes & ~(vma_seals(vma))) {
+		/*
+		 * Handle split at start and end.
+		 * For now sealed VMA doesn't merge with other VMAs.
+		 * This will be updated in later commit to make
+		 * sealed VMA also mergeable.
+		 */
+		if (start != vma->vm_start) {
+			ret = split_vma(vmi, vma, start, 1);
+			if (ret)
+				goto out;
+		}
+
+		if (end != vma->vm_end) {
+			ret = split_vma(vmi, vma, end, 0);
+			if (ret)
+				goto out;
+		}
+
+		vma->vm_seals |= addtypes;
+	}
+
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
+ * 4> requested seal type can be added in given address range.
+ */
+static int check_mm_seal(unsigned long start, unsigned long end,
+			 unsigned long newtypes)
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
+		if (!can_add_vma_seals(vma, newtypes))
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
+static int apply_mm_seal(unsigned long start, unsigned long end,
+			 unsigned long newtypes)
+{
+	unsigned long nstart, nend;
+	struct vm_area_struct *vma, *prev = NULL;
+	struct vma_iterator vmi;
+	int error = 0;
+
+	vma_iter_init(&vmi, current->mm, start);
+	vma = vma_find(&vmi, end);
+
+	prev = vma_prev(&vmi);
+	if (start > vma->vm_start)
+		prev = vma;
+
+	nstart = start;
+
+	/* going through each vma to update. */
+	for_each_vma_range(vmi, vma, end) {
+		nend = vma->vm_end;
+		if (nend > end)
+			nend = end;
+
+		error = mseal_fixup(&vmi, vma, &prev, nstart, nend, newtypes);
+		if (error)
+			break;
+
+		nstart = vma->vm_end;
+	}
+
+	return error;
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
+ *  types: bit mask for sealed syscalls.
+ *   MM_SEAL_BASE: prevent VMA from:
+ *   1> Unmapping, moving to another location, and shrinking
+ *	the size, via munmap() and mremap(), can leave an empty
+ *	space, therefore can be replaced with a VMA with a new
+ *	set of attributes.
+ *   2> Move or expand a different vma into the current location,
+ *	via mremap().
+ *   3> Modifying sealed VMA via mmap(MAP_FIXED).
+ *   4> Size expansion, via mremap(), does not appear to pose any
+ *	specific risks to sealed VMAs. It is included anyway because
+ *	the use case is unclear. In any case, users can rely on
+ *	merging to expand a sealed VMA.
+ *
+ *   The MM_SEAL_PROT_PKEY:
+ *	Seal PROT and PKEY of the address range, in other words,
+ *	mprotect() and pkey_mprotect() will be denied if the memory is
+ *	sealed with MM_SEAL_PROT_PKEY.
+ *
+ *   The MM_SEAL_SEAL
+ *	MM_SEAL_SEAL denies adding a new seal for an VMA.
+ *
+ *	The kernel will remember which seal types are applied, and the
+ *	application doesn’t need to repeat all existing seal types in
+ *	the next mseal(). Once a seal type is applied, it can’t be
+ *	unsealed. Call mseal() on an existing seal type is a no-action,
+ *	not a failure.
+ *
+ *  flags: reserved.
+ *
+ * return values:
+ *  zero: success.
+ *  -EINVAL:
+ *   invalid seal type.
+ *   invalid input flags.
+ *   addr is not page aligned.
+ *   addr + len overflow.
+ *  -ENOMEM:
+ *   addr is not a valid address (not allocated).
+ *   end (addr + len) is not a valid address.
+ *   a gap (unallocated memory) between start and end.
+ *  -EACCES:
+ *   MM_SEAL_SEAL is set, adding a new seal is rejected.
+ *
+ * Note:
+ *  user can call mseal(2) multiple times to add new seal types.
+ *  adding an already added seal type is a no-action (no error).
+ *  adding a new seal type after MM_SEAL_SEAL will be rejected.
+ *  unseal() or removing a seal type is not supported.
+ */
+static int do_mseal(unsigned long start, size_t len_in, unsigned long types,
+		    unsigned long flags)
+{
+	int ret = 0;
+	unsigned long end;
+	struct mm_struct *mm = current->mm;
+	size_t len;
+
+	/* MM_SEAL_BASE is set when other seal types are set. */
+	if (types & MM_SEAL_PROT_PKEY)
+		types |= MM_SEAL_BASE;
+
+	if (!can_do_mseal(types, flags))
+		return -EINVAL;
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
+	ret = check_mm_seal(start, end, types);
+	if (ret)
+		goto out;
+
+	ret = apply_mm_seal(start, end, types);
+
+out:
+	mmap_write_unlock(current->mm);
+	return ret;
+}
+
+SYSCALL_DEFINE4(mseal, unsigned long, start, size_t, len, unsigned long, types, unsigned long,
+		flags)
+{
+	return do_mseal(start, len, types, flags);
+}
-- 
2.43.0.472.g3155946c3a-goog


