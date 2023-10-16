Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928387CABAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjJPOjE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjJPOjB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 10:39:01 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102209F
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:38:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b8a0f320dso2578871eaf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697467137; x=1698071937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0WNNc5z5Rp4qcc+bUjy2EO5P5kIEIYGxWQPd2Onn9M=;
        b=XZgn9pGtfiksdV+hqyJc4Ihb54ulGGzT9p7F8/zFVTt29mYTkWiR5OrI30d/xa/apR
         2mCVJIV7EQprrhw3dFRnBwFCvKjW++u1sSX+dmpjol3uHIbyPy7ajvC7kZwTlL3zSJa8
         jn32K/avgbbPNzq0ncObsbqG6Z5K5LVwbFqac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467137; x=1698071937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0WNNc5z5Rp4qcc+bUjy2EO5P5kIEIYGxWQPd2Onn9M=;
        b=K65ic1GJE+pbfT5ov1p2PYIdqBl3yMShmIMBtRqADPFsnSZY6+ehFcOjHMgtAfsrIi
         OFIx24hIQGwDSLnVybQNqwyyeSBXIp8WXbbf6ntMrzkTEWgesGQGQ2uwLm4MY8uLW88g
         BS9pfRoZOdiSad4ID3zamjEVL88X0toGs6p5Ape69m3l6ktXAT+LVmVQAyMMfW5p7dcX
         MZqTd99E+fXXw+GBprcJJy2uJjYkoTelookLhRH+QENbGEhI6TcT1ciwizAn/ZFaPVxg
         UUC8QNyh7mZSkGsa6vQ8A1TRuGVWYUmEVrBHb4qotUeWaCi9CdUjzofpRx4d81NjkQZZ
         mNDg==
X-Gm-Message-State: AOJu0YwSz3CVfhA9r6bvN/ezDmRKD0QiI4D0SI591CNNQ3Ufb4L+Bp6k
        uHMRl+H1m2bRbD0Mdz7tCzThAw==
X-Google-Smtp-Source: AGHT+IHl+pMgyvtur/JNbIrQM0sYpoTu0Sl4CBWNwTFYDB3ETNHzopbO9fK1CG39Fnz3dURR6iY0pg==
X-Received: by 2002:a05:6358:4311:b0:13c:fd78:bb43 with SMTP id r17-20020a056358431100b0013cfd78bb43mr36098417rwc.27.1697467137176;
        Mon, 16 Oct 2023 07:38:57 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id s5-20020aa78bc5000000b006be0fb89ac3sm2298667pfd.30.2023.10.16.07.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:38:56 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v1 1/8] Add mseal syscall
Date:   Mon, 16 Oct 2023 14:38:20 +0000
Message-ID: <20231016143828.647848-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
MIME-Version: 1.0
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

mseal() prevents system calls from modifying the metadata of
virtual addresses.

Five syscalls can be sealed, as specified by bitmasks:
MM_SEAL_MPROTECT: Deny mprotect(2)/pkey_mprotect(2).
MM_SEAL_MUNMAP: Deny munmap(2).
MM_SEAL_MMAP: Deny mmap(2).
MM_SEAL_MREMAP: Deny mremap(2).
MM_SEAL_MSEAL: Deny adding a new seal type.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 include/linux/mm.h        |  14 ++
 include/linux/mm_types.h  |   7 +
 include/linux/syscalls.h  |   2 +
 include/uapi/linux/mman.h |   6 +
 kernel/sys_ni.c           |   1 +
 mm/Kconfig                |   8 ++
 mm/Makefile               |   1 +
 mm/mmap.c                 |  14 ++
 mm/mseal.c                | 268 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 321 insertions(+)
 create mode 100644 mm/mseal.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 53efddc4d178..e790b91a0cd4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -257,6 +257,20 @@ extern struct rw_semaphore nommu_region_sem;
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+/*
+ * vm_seals in vm_area_struct, see mm_types.h.
+ */
+#define VM_SEAL_NONE		0x00000000
+#define VM_SEAL_MSEAL		0x00000001
+#define VM_SEAL_MPROTECT	0x00000002
+#define VM_SEAL_MUNMAP		0x00000004
+#define VM_SEAL_MREMAP		0x00000008
+#define VM_SEAL_MMAP		0x00000010
+
+#define VM_SEAL_ALL                                                            \
+	(VM_SEAL_MSEAL | VM_SEAL_MPROTECT | VM_SEAL_MUNMAP | VM_SEAL_MMAP |    \
+	 VM_SEAL_MREMAP)
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
index c0cb22cd607d..f574c7dbee76 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -802,6 +802,8 @@ asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
+asmlinkage long sys_mseal(unsigned long start, size_t len, unsigned int types,
+			  unsigned int flags);
 asmlinkage long sys_mbind(unsigned long start, unsigned long len,
 				unsigned long mode,
 				const unsigned long __user *nmask,
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index a246e11988d5..d7882b5984ce 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -55,4 +55,10 @@ struct cachestat {
 	__u64 nr_recently_evicted;
 };
 
+#define MM_SEAL_MSEAL		0x1
+#define MM_SEAL_MPROTECT	0x2
+#define MM_SEAL_MUNMAP		0x4
+#define MM_SEAL_MMAP		0x8
+#define MM_SEAL_MREMAP		0x10
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
index 514ced13c65c..9b6c477e713e 100644
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
+	if (vma->vm_seals & VM_SEAL_ALL)
+		return 0;
+#endif
 	return true;
 }
 
diff --git a/mm/mseal.c b/mm/mseal.c
new file mode 100644
index 000000000000..615b6e06ab44
--- /dev/null
+++ b/mm/mseal.c
@@ -0,0 +1,268 @@
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
+static bool can_do_mseal(unsigned int types, unsigned int flags)
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
+static bool can_add_vma_seals(struct vm_area_struct *vma, unsigned int newSeals)
+{
+	/* When SEAL_MSEAL is set, reject if a new type of seal is added */
+	if ((vma->vm_seals & VM_SEAL_MSEAL) &&
+	    (newSeals & ~(vma->vm_seals & VM_SEAL_ALL)))
+		return false;
+
+	return true;
+}
+
+static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct vm_area_struct **prev, unsigned long start,
+		unsigned long end, unsigned int addtypes)
+{
+	int ret = 0;
+
+	if (addtypes & ~(vma->vm_seals & VM_SEAL_ALL)) {
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
+ * convert user input to internal type for seal type.
+ */
+static unsigned int convert_user_seal_type(unsigned int types)
+{
+	unsigned int newtypes = VM_SEAL_NONE;
+
+	if (types & MM_SEAL_MSEAL)
+		newtypes |= VM_SEAL_MSEAL;
+
+	if (types & MM_SEAL_MPROTECT)
+		newtypes |= VM_SEAL_MPROTECT;
+
+	if (types & MM_SEAL_MUNMAP)
+		newtypes |= VM_SEAL_MUNMAP;
+
+	if (types & MM_SEAL_MMAP)
+		newtypes |= VM_SEAL_MMAP;
+
+	if (types & MM_SEAL_MREMAP)
+		newtypes |= VM_SEAL_MREMAP;
+
+	return newtypes;
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
+			 unsigned int newtypes)
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
+			 unsigned int newtypes)
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
+static int do_mseal(unsigned long start, size_t len_in, unsigned int types,
+		    unsigned int flags)
+{
+	int ret = 0;
+	unsigned long end;
+	struct mm_struct *mm = current->mm;
+	unsigned int newtypes;
+	size_t len;
+
+	if (!can_do_mseal(types, flags))
+		return -EINVAL;
+
+	newtypes = convert_user_seal_type(types);
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
+	ret = check_mm_seal(start, end, newtypes);
+	if (ret)
+		goto out;
+
+	ret = apply_mm_seal(start, end, newtypes);
+
+out:
+	mmap_write_unlock(current->mm);
+	return ret;
+}
+
+SYSCALL_DEFINE4(mseal, unsigned long, start, size_t, len, unsigned int, types, unsigned int,
+		flags)
+{
+	return do_mseal(start, len, types, flags);
+}
-- 
2.42.0.609.gbb76f46606-goog

