Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734DE7CBE7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjJQJIZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJQJIX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:08:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4FFA
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5ab2cb900fcso2258855a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697533700; x=1698138500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONFWwgK5lj2ZpjjMWHEuYRjeJZbiZQQ2L6zlDrNvyHE=;
        b=FmzDejBxU/+jaH9dVTmTLhSQB0O1gw9SP28Bsqg+8f01LRVvvwIW2CU8eIFyFHsicT
         kpcvV0220kQcVpCpIQ5oFFbdLApf7EeAUNvfa6mmbDARkIqMEQ7H8Rus3Kl2+Eljjl4P
         jZtLYiQwGGv/DjemB20S0NHNVU4iXqws6jmkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533700; x=1698138500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONFWwgK5lj2ZpjjMWHEuYRjeJZbiZQQ2L6zlDrNvyHE=;
        b=nyRiwDgSv2s92Cb3tTHbnXyvUm7uxwer+/w2azWRmqpGSGTMLD1UU7v3P+Idv7I+uX
         GaSy1cVKMwmSOkIenfWi0WVTwOEIXLnY7WfSNiq1+KrWmoX+k98KfwbIG939iJBdF+Fs
         AFoYfFFihKWU+xA4rOY5b1wqegq1R/V7h/znvQh7rGdu9uqET2CSMaFhyUsa2f3vfEYd
         LZS6L1JyejzWVZuctjGxNA2fx+RtjH3VPdtQNhMW8jHzZ6tMhF/ZGQHQD0WKug6EBC4O
         YMAPYS5hiSM8tZUKkRd6kfqpwb002vJ/WIxTalkngAUa3kvikRqbgXK9BzbiwUEyggg9
         Jt2A==
X-Gm-Message-State: AOJu0Yz1ffEI33IbVwos3fHMZ+KAL4eihnFTFSGKrMm48nztuu0SsAXp
        NFWhoalDedhMQLVaa73ocfjFGQ==
X-Google-Smtp-Source: AGHT+IFx84m8bigMOvX11yXy6GBlD52QqNEpmNFYE4AlviCUipj3jIvD/AeEXO283xhOeBSoscXP1g==
X-Received: by 2002:a17:90b:1048:b0:27c:edd6:b08d with SMTP id gq8-20020a17090b104800b0027cedd6b08dmr1360755pjb.24.1697533699711;
        Tue, 17 Oct 2023 02:08:19 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id gd22-20020a17090b0fd600b0026f90d7947csm868534pjb.34.2023.10.17.02.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:08:19 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v2 1/8] mseal: Add mseal(2) syscall.
Date:   Tue, 17 Oct 2023 09:08:08 +0000
Message-ID: <20231017090815.1067790-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017090815.1067790-1-jeffxu@chromium.org>
References: <20231017090815.1067790-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

This patchset proposes a new mseal() syscall for the Linux kernel.

Modern CPUs support memory permissions such as RW and NX bits. Linux has
supported NX since the release of kernel version 2.6.8 in August 2004 [1].
The memory permission feature improves security stance on memory
corruption bugs, i.e. the attacker can’t just write to arbitrary memory
and point the code to it, the memory has to be marked with X bit, or
else an exception will happen.

Memory sealing additionally protects the mapping itself against
modifications. This is useful to mitigate memory corruption issues where
a corrupted pointer is passed to a memory management syscall. For example,
such an attacker primitive can break control-flow integrity guarantees
since read-only memory that is supposed to be trusted can become writable
or .text pages can get remapped. Memory sealing can automatically be
applied by the runtime loader to seal .text and .rodata pages and
applications can additionally seal security critical data at runtime.
A similar feature already exists in the XNU kernel with the
VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the mimmutable syscall [4].
Also, Chrome wants to adopt this feature for their CFI work [2] and this
patchset has been designed to be compatible with the Chrome use case.

The new mseal() is an architecture independent syscall, and with
following signature:

mseal(void addr, size_t len, unsigned long types, unsigned long flags)

addr/len: memory range.  Must be continuous/allocated memory, or else
mseal() will fail and no VMA is updated. For details on acceptable
arguments, please refer to comments in mseal.c. Those are also fully
covered by the selftest.

types: bit mask to specify which syscall to seal.

Five syscalls can be sealed, as specified by bitmasks:
MM_SEAL_MPROTECT: Deny mprotect(2)/pkey_mprotect(2).
MM_SEAL_MUNMAP: Deny munmap(2).
MM_SEAL_MMAP: Deny mmap(2).
MM_SEAL_MREMAP: Deny mremap(2).
MM_SEAL_MSEAL: Deny adding a new seal type.

Each bit represents sealing for one specific syscall type, e.g.
MM_SEAL_MPROTECT will deny mprotect syscall. The consideration of bitmask
is that the API is extendable, i.e. when needed, the sealing can be
extended to madvise, mlock, etc. Backward compatibility is also easy.

The kernel will remember which seal types are applied, and the application
doesn’t need to repeat all existing seal types in the next mseal().  Once
a seal type is applied, it can’t be unsealed. Call mseal() on an existing
seal type is a no-action, not a failure.

MM_SEAL_MSEAL will deny mseal() calls that try to add a new seal type.

Internally, vm_area_struct adds a new field vm_seals, to store the bit
masks.

For the affected syscalls, such as mprotect, a check(can_modify_mm) for
sealing is added, this usually happens at the early point of the syscall,
before any update is made to VMAs. The effect of that is: if any of the
VMAs in the given address range fails the sealing check, none of the VMA
will be updated.

The idea that inspired this patch comes from Stephen Röttger’s work in
V8 CFI [5],  Chrome browser in ChromeOS will be the first user of this API.

In addition, Stephen is working on glibc change to add sealing support
into the dynamic linker to seal all non-writable segments at startup. When
that work is completed, all applications can automatically benefit from
these new protections.

[1] https://kernelnewbies.org/Linux_2_6_8
[2] https://v8.dev/blog/control-flow-integrity
[3] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
[4] https://man.openbsd.org/mimmutable.2
[5] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 include/linux/mm.h        |  11 ++
 include/linux/mm_types.h  |   7 ++
 include/linux/syscalls.h  |   2 +
 include/uapi/linux/mman.h |   6 +
 kernel/sys_ni.c           |   1 +
 mm/Kconfig                |   8 ++
 mm/Makefile               |   1 +
 mm/mmap.c                 |  14 +++
 mm/mseal.c                | 230 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 280 insertions(+)
 create mode 100644 mm/mseal.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 53efddc4d178..b511932df033 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -30,6 +30,7 @@
 #include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
+#include <uapi/linux/mman.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -257,6 +258,16 @@ extern struct rw_semaphore nommu_region_sem;
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+/*
+ * MM_SEAL_ALL is all supported flags in mseal().
+ */
+#define MM_SEAL_ALL ( \
+	MM_SEAL_MSEAL | \
+	MM_SEAL_MPROTECT | \
+	MM_SEAL_MUNMAP | \
+	MM_SEAL_MMAP | \
+	MM_SEAL_MREMAP)
+
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..17d80f5a73dc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -660,6 +660,13 @@ struct vm_area_struct {
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
index c0cb22cd607d..dbc8d4f76646 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -802,6 +802,8 @@ asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
+asmlinkage long sys_mseal(unsigned long start, size_t len, unsigned long types,
+			  unsigned long flags);
 asmlinkage long sys_mbind(unsigned long start, unsigned long len,
 				unsigned long mode,
 				const unsigned long __user *nmask,
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index a246e11988d5..5ed4072cf4a6 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -55,4 +55,10 @@ struct cachestat {
 	__u64 nr_recently_evicted;
 };
 
+#define MM_SEAL_MSEAL		_BITUL(0)
+#define MM_SEAL_MPROTECT	_BITUL(1)
+#define MM_SEAL_MUNMAP		_BITUL(2)
+#define MM_SEAL_MMAP		_BITUL(3)
+#define MM_SEAL_MREMAP		_BITUL(4)
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 781de7cc6a4e..06fabf379e33 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -192,6 +192,7 @@ COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
 COND_SYSCALL(cachestat);
+COND_SYSCALL(mseal);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/Kconfig b/mm/Kconfig
index 264a2df5ecf5..db8a567cb4d3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1258,6 +1258,14 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config MSEAL
+	default n
+	bool "Enable mseal() system call"
+	depends on MMU
+	help
+	  Enable the mseal() system call. Make memory areas's metadata immutable
+	  by selected system calls, i.e. mprotect(), munmap(), mremap(), mmap().
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
index 514ced13c65c..414ac31aa9fa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -730,6 +730,20 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 		return false;
 	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
 		return false;
+#ifdef CONFIG_MSEAL
+	/*
+	 * If a VMA is sealed, it won't be merged with another VMA.
+	 * This might be useful for diagnosis, i.e. the boundary used
+	 * in the mseal() call will be preserved.
+	 * There are chances of too many mseal() calls can create
+	 * many segmentations. Considering mseal() usually comes
+	 * with a careful memory layout design by the application,
+	 * this might not be an issue in real world.
+	 * Though, we could add merging support later if needed.
+	 */
+	if (vma->vm_seals & MM_SEAL_ALL)
+		return 0;
+#endif
 	return true;
 }
 
diff --git a/mm/mseal.c b/mm/mseal.c
new file mode 100644
index 000000000000..ffe4c4c3f1bc
--- /dev/null
+++ b/mm/mseal.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Implement mseal() syscall.
+ *
+ *  Copyright (c) 2023 Google, Inc.
+ *
+ *  Author: Jeff Xu <jeffxu@google.com>
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
+	/* check types is a valid bitmap */
+	if (types & ~MM_SEAL_ALL)
+		return false;
+
+	/* flags isn't used for now */
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
+	/* When SEAL_MSEAL is set, reject if a new type of seal is added */
+	if ((vma->vm_seals & MM_SEAL_MSEAL) &&
+	    (newSeals & ~(vma->vm_seals & MM_SEAL_ALL)))
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
+	if (addtypes & ~(vma->vm_seals & MM_SEAL_ALL)) {
+		/*
+		 * Handle split at start and end.
+		 * Note: sealed VMA doesn't merge with other VMAs.
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
+	/* going through each vma to check */
+	for_each_vma_range(vmi, vma, end) {
+		if (vma->vm_start > nstart)
+			/* unallocated memory found */
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
+	/* going through each vma to update */
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
+ *   MM_SEAL_MPROTECT: seal mprotect(2)/pkey_mprotect(2).
+ *   MM_SEAL_MUNMAP: seal munmap(2).
+ *   MM_SEAL_MMAP: seal mmap(2).
+ *   MM_SEAL_MREMAP: seal mremap(2).
+ *   MM_SEAL_MSEAL: adding new seal type will be rejected.
+ *
+ *  flags: reserved.
+ *
+ * return values:
+ *  zero: success
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
+ *   MM_SEAL_MSEAL is set, adding a new seal is rejected.
+ *
+ * Note:
+ *  user can call mseal(2) multiple times to add new seal types.
+ *  adding an already added seal type is a no-action (no error).
+ *  adding a new seal type after MM_SEAL_MSEAL will be rejected.
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
+	if (!can_do_mseal(types, flags))
+		return -EINVAL;
+
+	start = untagged_addr(start);
+	if (!PAGE_ALIGNED(start))
+		return -EINVAL;
+
+	len = PAGE_ALIGN(len_in);
+	/* Check to see whether len was rounded up from small -ve to zero */
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
2.42.0.655.g421f12c284-goog

