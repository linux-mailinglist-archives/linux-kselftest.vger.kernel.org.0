Return-Path: <linux-kselftest+bounces-3864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA184467E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 18:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694441C25C7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFB3130E2A;
	Wed, 31 Jan 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCa7+/v6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66E12FF87
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723444; cv=none; b=RrFHMoXQelnYRO4V5J/x+3zE7CPhxALJhQ9qFfF4yz0W7WX7u+CifgkJGVVgUTGzZS3CBqujklf2JLLkJb2QkRLyQ14vRRB1P3VfhWBoZJccKjBP5asspVDtQd9D2FmnYMrFRcBys9/rEYp+nughVu6aDz1alKKMBTcn+R/pm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723444; c=relaxed/simple;
	bh=1l2eyJahT6/THhsGFQlwh1IGeaNT9b5VEW1CK/GnyDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfiG17SwCES6XJDIZzE4Fr/oUz5WwKW26Ub0lnuyS8BpMxlUy1ZshHJ/Ljy+UNJzRDjaZ46JGHdo/dAieaQ9Z189boEPfCRNxnbZwWRkZkVztYegxPSoCBnqz6Jl7zmULKKW1zBZY3pPthSNV499vnH/n9/AEmJYaTUC8rbzliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FCa7+/v6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso71758a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706723442; x=1707328242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPGI4dhOjsvjKsvP8oCKck8QX/3kjezSrJszAxYQUFA=;
        b=FCa7+/v6WDADNHMGmPQDKONNiTN1UnOp4lMzCcXIPiTfwnrYPRl6bXDo0/+L4G18hN
         FDtZgMyUduxGx6MNy/BCBRDneUSgXBvbCzCCgw2F97ai1iXyTTE65e9UCV/UAcET6lhr
         sdbPpvTdPAyRowF521Sli8jVjj4Lw7fSMyIik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723442; x=1707328242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPGI4dhOjsvjKsvP8oCKck8QX/3kjezSrJszAxYQUFA=;
        b=S+jnIDU6XGYXY8n+q2z5UEUyJcPKbFyJJZO2KAkEvRt+7BGbUMQ41w82+X1OJZjBtz
         Y04IfyqrP+6mSd7n8I4St6LAL/mbr1uZISsCxuqdDyFVjAzHa6uVB60Pnkxn8b30Jf4k
         jdJX7qGd4DoayacPiE82HmdGT9nixG2jKykRCLovkE8/OUrZH3bROLDBi8+d64J4RaJr
         za6yLiUlLPtrZI+Jafs5Ul6rt40GUnPSX+sDH2RSYtiE6cU7bAzTPPPdVRf6FTRhupAF
         LfQ5CBCLpab5xpjGKSGqHL/01S9+IlpvOpoQ3fksWoxvlpWnSbEIPl0lG59k9hr02Qgn
         AH3Q==
X-Gm-Message-State: AOJu0Yz36P4MFzIECDN6JOe70/X4h1SK5QZOFtI3hCYZ5iPzFQBbO0GQ
	n2vjG2njcEm5XzbQrzYL5F2PUH2HsW9L19PmdRe4nWxMZKZ1yC2HX4MEokXBbw==
X-Google-Smtp-Source: AGHT+IErS/Qe51+MwT203LmMmKX79RYaK08wm/6Fh0mULIDWu6/Ls4MRxnfdABmWbLbYiZSldSyxAg==
X-Received: by 2002:a05:6a20:2a26:b0:19c:8ed9:7b94 with SMTP id e38-20020a056a202a2600b0019c8ed97b94mr2072030pzh.51.1706723441835;
        Wed, 31 Jan 2024 09:50:41 -0800 (PST)
Received: from localhost (56.72.82.34.bc.googleusercontent.com. [34.82.72.56])
        by smtp.gmail.com with UTF8SMTPSA id fa20-20020a056a002d1400b006d70b0d4639sm10172924pfb.107.2024.01.31.09.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:50:41 -0800 (PST)
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
Subject: [PATCH v8 4/4] mseal:add documentation
Date: Wed, 31 Jan 2024 17:50:26 +0000
Message-ID: <20240131175027.3287009-5-jeffxu@chromium.org>
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

Add documentation for mseal().

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/index.rst |   1 +
 Documentation/userspace-api/mseal.rst | 215 ++++++++++++++++++++++++++
 2 files changed, 216 insertions(+)
 create mode 100644 Documentation/userspace-api/mseal.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 09f61bd2ac2e..178f6a1d79cb 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -26,6 +26,7 @@ place where this information is gathered.
    iommu
    iommufd
    media/index
+   mseal
    netlink/index
    sysfs-platform_profile
    vduse
diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
new file mode 100644
index 000000000000..6bfac0622178
--- /dev/null
+++ b/Documentation/userspace-api/mseal.rst
@@ -0,0 +1,215 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Introduction of mseal
+=====================
+
+:Author: Jeff Xu <jeffxu@chromium.org>
+
+Modern CPUs support memory permissions such as RW and NX bits. The memory
+permission feature improves security stance on memory corruption bugs, i.e.
+the attacker can’t just write to arbitrary memory and point the code to it,
+the memory has to be marked with X bit, or else an exception will happen.
+
+Memory sealing additionally protects the mapping itself against
+modifications. This is useful to mitigate memory corruption issues where a
+corrupted pointer is passed to a memory management system. For example,
+such an attacker primitive can break control-flow integrity guarantees
+since read-only memory that is supposed to be trusted can become writable
+or .text pages can get remapped. Memory sealing can automatically be
+applied by the runtime loader to seal .text and .rodata pages and
+applications can additionally seal security critical data at runtime.
+
+A similar feature already exists in the XNU kernel with the
+VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall [2].
+
+User API
+========
+Two system calls are involved in virtual memory sealing, mseal() and mmap().
+
+mseal()
+-----------
+The mseal() syscall has the following signature:
+
+``int mseal(void addr, size_t len, unsigned long flags)``
+
+**addr/len**: virtual memory address range.
+
+The address range set by ``addr``/``len`` must meet:
+   - The start address must be in an allocated VMA.
+   - The start address must be page aligned.
+   - The end address (``addr`` + ``len``) must be in an allocated VMA.
+   - no gap (unallocated memory) between start and end address.
+
+The ``len`` will be paged aligned implicitly by the kernel.
+
+**flags**: reserved for future use.
+
+**return values**:
+
+- ``0``: Success.
+
+- ``-EINVAL``:
+    - Invalid input ``flags``.
+    - The start address (``addr``) is not page aligned.
+    - Address range (``addr`` + ``len``) overflow.
+
+- ``-ENOMEM``:
+    - The start address (``addr``) is not allocated.
+    - The end address (``addr`` + ``len``) is not allocated.
+    - A gap (unallocated memory) between start and end address.
+
+- ``-EACCES``:
+    - ``MAP_SEALABLE`` is not set during mmap().
+
+- ``-EPERM``:
+    - sealing is supported only on 64-bit CPUs, 32-bit is not supported.
+
+- For above error cases, users can expect the given memory range is
+  unmodified, i.e. no partial update.
+
+- There might be other internal errors/cases not listed here, e.g.
+  error during merging/splitting VMAs, or the process reaching the max
+  number of supported VMAs. In those cases, partial updates to the given
+  memory range could happen. However, those cases should be rare.
+
+**Blocked operations after sealing**:
+    Unmapping, moving to another location, and shrinking the size,
+    via munmap() and mremap(), can leave an empty space, therefore
+    can be replaced with a VMA with a new set of attributes.
+
+    Moving or expanding a different VMA into the current location,
+    via mremap().
+
+    Modifying a VMA via mmap(MAP_FIXED).
+
+    Size expansion, via mremap(), does not appear to pose any
+    specific risks to sealed VMAs. It is included anyway because
+    the use case is unclear. In any case, users can rely on
+    merging to expand a sealed VMA.
+
+    mprotect() and pkey_mprotect().
+
+    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
+    for anonymous memory, when users don't have write permission to the
+    memory. Those behaviors can alter region contents by discarding pages,
+    effectively a memset(0) for anonymous memory.
+
+    Kernel will return -EPERM for blocked operations.
+
+**Note**:
+
+- mseal() only works on 64-bit CPUs, not 32-bit CPU.
+
+- users can call mseal() multiple times, mseal() on an already sealed memory
+  is a no-action (not error).
+
+- munseal() is not supported.
+
+mmap()
+----------
+``void *mmap(void* addr, size_t length, int prot, int flags, int fd,
+off_t offset);``
+
+We add two changes in ``prot`` and ``flags`` of  mmap() related to
+memory sealing.
+
+**prot**
+
+The ``PROT_SEAL`` bit in ``prot`` field of mmap().
+
+When present, it marks the memory is sealed since creation.
+
+This is useful as optimization because it avoids having to make two
+system calls: one for mmap() and one for mseal().
+
+It's worth noting that even though the sealing is set via the
+``prot`` field in mmap(), it can't be set in the ``prot``
+field in later mprotect(). This is unlike the ``PROT_READ``,
+``PROT_WRITE``, ``PROT_EXEC`` bits, e.g. if ``PROT_WRITE`` is not set in
+mprotect(), it means that the region is not writable.
+
+Setting ``PROT_SEAL`` implies setting ``MAP_SEALABLE`` below.
+
+**flags**
+
+The ``MAP_SEALABLE`` bit in the ``flags`` field of mmap().
+
+When present, it marks the map as sealable. A map created
+without ``MAP_SEALABLE`` will not support sealing. In other words,
+mseal() will fail for such a map.
+
+Applications that don't care about sealing will expect their
+behavior unchanged. For those that need sealing support, opt in
+by adding ``MAP_SEALABLE`` in mmap().
+
+Use Case:
+=========
+- glibc:
+  The dynamic linker, during loading ELF executables, can apply sealing to
+  non-writable memory segments.
+
+- Chrome browser: protect some security sensitive data-structures.
+
+Notes On MAP_SEALABLE
+=====================
+With the MAP_SEALABLE flag in mmap(), the memory must be mmap() with
+MAP_SEALABLE, otherwise mseal() will fail. This raises the bar of
+which memory can be sealed.
+
+Today, in linux, sealing have known side effects if applied in below
+two cases:
+
+- aio/shm
+
+  aio/shm can mmap/munmap on behalf of userspace, e.g. ksys_shmdt() in shm.c. The lifetime of those mapping are not tied to the lifetime of the process. If those memories are sealed from userspace, then unmap will fail, causing leaks in VMA address space during the lifetime of the process.
+
+- Brk (heap/stack)
+
+  Currently, userspace applications can seal parts of the heap by calling malloc() and mseal().
+  let's assume following calls from user space:
+
+  - ptr = malloc(size);
+  - mprotect(ptr, size, RO);
+  - mseal(ptr, size);
+  - free(ptr);
+
+  Technically, before mseal() is added, the user can change the protection of the heap by calling mprotect(RO). As long as the user changes the protection back to RW before free(), the memory can be reused.
+
+  Adding mseal() into the picture, however, the heap is then sealed partially, the user can still free it, but the memory remains to be RO. In addition, the result of brk-shrink is nondeterministic, depending on if munmap() will try to free the sealed memory.(brk uses munmap to shrink the heap).
+
+  Given the heap is not marked with MAP_SEALABLE (at the time of this document's writing), this might discourage the inadvertent sealing on the heap.
+
+  It is noteworthy, nonetheless, for mappings that were created without the MAP_SEALABLE flag, a knowledgeable developer who wants to assume ownership of the memory range still has the option of mmap(MAP_FIXED|MAP_SEALABLE), which is equivalent to invoking munmap() and then mmap(MAP_FIXED). Indeed, a "not-allow-sealing" feature is not possible without some level of baseline sealing support and is out-of-scope currently.
+
+  In summary, the considerations for having MAP_SEALABLE are as follows:
+
+- Grants software owners the ability to incrementally incorporate sealing support for their designated memory ranges, such as brk.
+- Raises the bar for which memory can be sealed, and discourages inadvertent sealing.
+- Such a decision is reversible. In other words, a sysctl could be implemented to render all memory sealable in the future. However, if all memory were allowed to be sealable from the beginning, reversing that decision would be problematic.
+
+Additional notes:
+=================
+As Jann Horn pointed out in [3], there are still a few ways to write
+to RO memory, which is, in a way, by design. Those cases are not covered
+by mseal(). If applications want to block such cases, sandbox tools (such as
+seccomp, LSM, etc) might be considered.
+
+Those cases are:
+
+- Write to read-only memory through /proc/self/mem interface.
+- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
+- userfaultfd.
+
+The idea that inspired this patch comes from Stephen Röttger’s work in V8
+CFI [4]. Chrome browser in ChromeOS will be the first user of this API.
+
+Reference:
+==========
+[1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
+
+[2] https://man.openbsd.org/mimmutable.2
+
+[3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com
+
+[4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
-- 
2.43.0.429.g432eaa2c6b-goog


