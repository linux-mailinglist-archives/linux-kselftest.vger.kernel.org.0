Return-Path: <linux-kselftest+bounces-18505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1B0988A6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C638A284749
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 18:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E045C1C2440;
	Fri, 27 Sep 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dk54P7sJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4211C2421
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463142; cv=none; b=IWmqpKNBshk0NkJoAe3vAPqQv6t8NM366SPyIC5r0YGO58t65AfqrsIzMmWcg7b/NyzXY3Htgma+Ft27ZCiUBNV70rmtOhxyxqwRY8K7JqsG088APi4i9jTKXeFfSWhe3or5A5QbkpE0mf0XvbTtI+tLZ7vWZDHH3aH8doYaGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463142; c=relaxed/simple;
	bh=9K8runSLMV+OfYL8iFNs67NXH51vnIQjgo0lk3NvHBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4OFPnKuK3So8WWaGbsNGXWF4UEtJIH35yu09CitORRd192vE8XbtxyvTddxoHxAp0n0Mlkov8XZsPCeXPoKTHCmzkxQcZ1RKMG8HfffXJ5k+g1Cbj3cpbJ7866Otg/RU8e9sQ933LlAO3hDMJ7NA/tXQ5cLyld2e7CYpa9SMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dk54P7sJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718e0421143so413891b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 11:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727463140; x=1728067940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfyXqoMtWqenASR38zLJNi3VQfzSDgJSqi/u6wpODVU=;
        b=dk54P7sJU8w2VRhwwdoqPWrpygblcH2l9CtRAsQ1Mn4krO2yu5Wlb2x0XKDKeNXQnT
         +D+bcDH6nDn7cIZ9ksuPnXR5On0+va8oJKbQWYiGC29Acl5rMLrgSRLtvSkHoCOx2yYX
         mSFIy3EILjk1QtTHBZDE/04OVksoAgJhK62/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463140; x=1728067940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfyXqoMtWqenASR38zLJNi3VQfzSDgJSqi/u6wpODVU=;
        b=K3LpWUrlAn5mLUXi1k88x4ifJKyQpyRj3vYoy32nnxsQ5N2E2TyrnmiBeo9znE1P2g
         NvB0KatsjMdXAVgj1+4yAOKAAYAHzfQLlPgvjuv5SJUFw2wjaC7l7I0bdDbUgUxT4k2R
         M4XNOksRJEsqNZsCC3KC1lI59QSISxa4TUBcqoKk1RZ9oT9COJNo6ABjg2vh1itq/Uuo
         8RD9TA8aP3lpiMSR/3fv7nza7vkVMGl5EW0bRevvdu0HQadDH8fHavEz/qgNV08Ilz6P
         8qemL8m2jRS5oQNzeuF2v/9COcDlj7eBO054rveksx6//JTOPvcb16ghKF+0M9hHHz2A
         m9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVgie6I/oFf4VgNx2EaLRqxdxNdyBKpnRfjBRpnxIJD+/kPCKDyRwLSuYMU3G8tVdICYiUxfoDZ4nWxux1sPsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx20rcWoaROukTmJmGduNYmlDdd1C9rFPMhBU/D8iQDx6DHizzY
	zbWNxsNm4I7ZQhUY6oUiFS3rJmcDWO5JY/wnLsu406L8IRfDuzeCdNxR+R8P+Q==
X-Google-Smtp-Source: AGHT+IGYqM3/u97TFMAlwjkNJcBcSyclQlFrx56w6mOUkfUJsFAyAIXnisUf5TERTiMJ7mItkyoYPw==
X-Received: by 2002:a05:6a20:8420:b0:1d4:f5e4:6a9a with SMTP id adf61e73a8af0-1d4fa810412mr2856791637.12.1727463139796;
        Fri, 27 Sep 2024 11:52:19 -0700 (PDT)
Received: from localhost (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71b26529d61sm1986540b3a.171.2024.09.27.11.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 11:52:19 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 1/1] mseal: update mseal.rst
Date: Fri, 27 Sep 2024 18:52:09 +0000
Message-ID: <20240927185211.729207-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240927185211.729207-1-jeffxu@chromium.org>
References: <20240927185211.729207-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update doc after in-loop change: mprotect/madvise can have
partially updated and munmap is atomic.

Fix indentation and clarify some sections to improve readability.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/mseal.rst | 290 ++++++++++++--------------
 1 file changed, 136 insertions(+), 154 deletions(-)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 4132eec995a3..68986084e191 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -23,177 +23,159 @@ applications can additionally seal security critical data at runtime.
 A similar feature already exists in the XNU kernel with the
 VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall [2].
 
-User API
-========
-mseal()
------------
-The mseal() syscall has the following signature:
-
-``int mseal(void addr, size_t len, unsigned long flags)``
-
-**addr/len**: virtual memory address range.
-
-The address range set by ``addr``/``len`` must meet:
-   - The start address must be in an allocated VMA.
-   - The start address must be page aligned.
-   - The end address (``addr`` + ``len``) must be in an allocated VMA.
-   - no gap (unallocated memory) between start and end address.
-
-The ``len`` will be paged aligned implicitly by the kernel.
-
-**flags**: reserved for future use.
-
-**return values**:
-
-- ``0``: Success.
-
-- ``-EINVAL``:
-    - Invalid input ``flags``.
-    - The start address (``addr``) is not page aligned.
-    - Address range (``addr`` + ``len``) overflow.
-
-- ``-ENOMEM``:
-    - The start address (``addr``) is not allocated.
-    - The end address (``addr`` + ``len``) is not allocated.
-    - A gap (unallocated memory) between start and end address.
-
-- ``-EPERM``:
-    - sealing is supported only on 64-bit CPUs, 32-bit is not supported.
-
-- For above error cases, users can expect the given memory range is
-  unmodified, i.e. no partial update.
-
-- There might be other internal errors/cases not listed here, e.g.
-  error during merging/splitting VMAs, or the process reaching the max
-  number of supported VMAs. In those cases, partial updates to the given
-  memory range could happen. However, those cases should be rare.
-
-**Blocked operations after sealing**:
-    Unmapping, moving to another location, and shrinking the size,
-    via munmap() and mremap(), can leave an empty space, therefore
-    can be replaced with a VMA with a new set of attributes.
-
-    Moving or expanding a different VMA into the current location,
-    via mremap().
-
-    Modifying a VMA via mmap(MAP_FIXED).
-
-    Size expansion, via mremap(), does not appear to pose any
-    specific risks to sealed VMAs. It is included anyway because
-    the use case is unclear. In any case, users can rely on
-    merging to expand a sealed VMA.
-
-    mprotect() and pkey_mprotect().
-
-    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
-    for anonymous memory, when users don't have write permission to the
-    memory. Those behaviors can alter region contents by discarding pages,
-    effectively a memset(0) for anonymous memory.
-
-    Kernel will return -EPERM for blocked operations.
-
-    For blocked operations, one can expect the given address is unmodified,
-    i.e. no partial update. Note, this is different from existing mm
-    system call behaviors, where partial updates are made till an error is
-    found and returned to userspace. To give an example:
-
-    Assume following code sequence:
-
-    - ptr = mmap(null, 8192, PROT_NONE);
-    - munmap(ptr + 4096, 4096);
-    - ret1 = mprotect(ptr, 8192, PROT_READ);
-    - mseal(ptr, 4096);
-    - ret2 = mprotect(ptr, 8192, PROT_NONE);
-
-    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
-
-    ret2 will be -EPERM, the page remains to be PROT_READ.
-
-**Note**:
-
-- mseal() only works on 64-bit CPUs, not 32-bit CPU.
-
-- users can call mseal() multiple times, mseal() on an already sealed memory
-  is a no-action (not error).
-
-- munseal() is not supported.
+SYSCALL
+=======
+mseal syscall signature
+-----------------------
+   **int** mseal(**void \*** addr, **size_t** len, **unsigned long** flags)
+
+   **addr**/**len**: virtual memory address range.
+      The address range set by **addr**/**len** must meet:
+         - The start address must be in an allocated VMA.
+         - The start address must be page aligned.
+         - The end address (**addr** + **len**) must be in an allocated VMA.
+         - no gap (unallocated memory) between start and end address.
+
+      The ``len`` will be paged aligned implicitly by the kernel.
+
+   **flags**: reserved for future use.
+
+   **Return values**:
+      - **0**: Success.
+      - **-EINVAL**:
+         * Invalid input ``flags``.
+         * The start address (``addr``) is not page aligned.
+         * Address range (``addr`` + ``len``) overflow.
+      - **-ENOMEM**:
+         * The start address (``addr``) is not allocated.
+         * The end address (``addr`` + ``len``) is not allocated.
+         * A gap (unallocated memory) between start and end address.
+      - **-EPERM**:
+         * sealing is supported only on 64-bit CPUs, 32-bit is not supported.
+
+   **Note about error return**:
+      - For above error cases, users can expect the given memory range is
+        unmodified, i.e. no partial update.
+      - There might be other internal errors/cases not listed here, e.g.
+        error during merging/splitting VMAs, or the process reaching the max
+        number of supported VMAs. In those cases, partial updates to the given
+        memory range could happen. However, those cases should be rare.
+
+   **Architecture support**:
+      mseal only works on 64-bit CPUs, not 32-bit CPU.
+
+   **Idempotent**:
+      users can call mseal multiple times, mseal on an already sealed memory
+      is a no-action (not error).
+
+   **no munseal**
+      Once mapping is sealed, it can't be unsealed. kernel should never
+      have munseal, this is consistent with other sealing feature, e.g.
+      F_SEAL_SEAL for file.
+
+Blocked mm syscall for sealed mapping
+-------------------------------------
+   It might be imporant to note: **once the mapping is sealed, it will
+   stay in the process's memory till the process terminates**.
+
+   Example::
+
+         *ptr = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+         rc = mseal(ptr, 4096, 0);
+         /* munmap will fail */
+         rc = munmap(ptr, 4096);
+         assert(rc < 0);
+
+   Blocked mm syscall:
+      - munmap
+      - mmap
+      - mremap
+      - mprotect and pkey_mprotect
+      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FREE,
+        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK
+
+   The first set of syscall to block is munmap, mremap, mmap. They can
+   either leave an empty space in the address space, therefore allow
+   replacement with a new mapping with new set of attributes, or can
+   overwrite the existing mapping with another mapping.
+
+   mprotect and pkey_mprotect are blocked because they changes the
+   protection bits (rwx) of the mapping.
+
+   Some destructive madvice behaviors (MADV_DONTNEED, MADV_FREE,
+   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
+   for anonymous memory, when users don't have write permission to the
+   memory. Those behaviors can alter region contents by discarding pages,
+   effectively a memset(0) for anonymous memory.
+
+   Kernel will return -EPERM for blocked syscalls.
+
+   When blocked syscall return -EPERM due to sealing, the memory regions may or may not be changed, depends on the syscall being blocked:
+      - munmap: munmap is atomic. If one of VMAs in the given range is
+        sealed, none of VMAs are updated.
+      - mprotect, pkey_mprotect, madvise: partial update might happen, e.g.
+        when mprotect over multiple VMAs, mprotect might update the beginning
+        VMAs before reaching the sealed VMA and return -EPERM.
+      - mmap and mremap: undefined behavior.
 
 Use cases:
 ==========
 - glibc:
   The dynamic linker, during loading ELF executables, can apply sealing to
-  non-writable memory segments.
+  mapping segments.
 
 - Chrome browser: protect some security sensitive data-structures.
 
-Notes on which memory to seal:
-==============================
-
-It might be important to note that sealing changes the lifetime of a mapping,
-i.e. the sealed mapping won’t be unmapped till the process terminates or the
-exec system call is invoked. Applications can apply sealing to any virtual
-memory region from userspace, but it is crucial to thoroughly analyze the
-mapping's lifetime prior to apply the sealing.
+Don't use mseal on:
+===================
+Applications can apply sealing to any virtual memory region from userspace,
+but it is *crucial to thoroughly analyze the mapping's lifetime* prior to
+apply the sealing. This is because the sealed mapping *won’t be unmapped*
+till the process terminates or the exec system call is invoked.
 
 For example:
+   - aio/shm
+     aio/shm can call mmap and  munmap on behalf of userspace, e.g.
+     ksys_shmdt() in shm.c. The lifetime of those mapping are not tied to
+     the lifetime of the process. If those memories are sealed from userspace,
+     then munmap will fail, causing leaks in VMA address space during the
+     lifetime of the process.
+
+   - ptr allocated by malloc (heap)
+     Don't use mseal on the memory ptr return from malloc().
+     malloc() is implemented by allocator, e.g. by glibc. Heap manager might
+     allocate a ptr from brk or mapping created by mmap.
+     If app calls mseal on ptr returned from malloc(), this can affect the heap
+     manager's ability to manage the mappings, the outcome is non-deterministic.
+     Example::
+
+        ptr = malloc(size);
+        /* don't call mseal on ptr return from malloc. */
+        mseal(ptr, size);
+        /* free will success, allocator can't shrink heap lower than ptr */
+        free(ptr);
+
+mseal doesn't block:
+====================
+In a nutshell, mseal blocks certain mm syscall from modifying some of VMA's
+attributes, such as protection bits (rwx). Sealed mappings doesn't mean the
+memory is immutable.
 
-- aio/shm
-
-  aio/shm can call mmap()/munmap() on behalf of userspace, e.g. ksys_shmdt() in
-  shm.c. The lifetime of those mapping are not tied to the lifetime of the
-  process. If those memories are sealed from userspace, then munmap() will fail,
-  causing leaks in VMA address space during the lifetime of the process.
-
-- Brk (heap)
-
-  Currently, userspace applications can seal parts of the heap by calling
-  malloc() and mseal().
-  let's assume following calls from user space:
-
-  - ptr = malloc(size);
-  - mprotect(ptr, size, RO);
-  - mseal(ptr, size);
-  - free(ptr);
-
-  Technically, before mseal() is added, the user can change the protection of
-  the heap by calling mprotect(RO). As long as the user changes the protection
-  back to RW before free(), the memory range can be reused.
-
-  Adding mseal() into the picture, however, the heap is then sealed partially,
-  the user can still free it, but the memory remains to be RO. If the address
-  is re-used by the heap manager for another malloc, the process might crash
-  soon after. Therefore, it is important not to apply sealing to any memory
-  that might get recycled.
-
-  Furthermore, even if the application never calls the free() for the ptr,
-  the heap manager may invoke the brk system call to shrink the size of the
-  heap. In the kernel, the brk-shrink will call munmap(). Consequently,
-  depending on the location of the ptr, the outcome of brk-shrink is
-  nondeterministic.
-
-
-Additional notes:
-=================
 As Jann Horn pointed out in [3], there are still a few ways to write
-to RO memory, which is, in a way, by design. Those cases are not covered
-by mseal(). If applications want to block such cases, sandbox tools (such as
-seccomp, LSM, etc) might be considered.
+to RO memory, which is, in a way, by design. And those could be blocked
+by different security measures.
 
 Those cases are:
-
-- Write to read-only memory through /proc/self/mem interface.
-- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
-- userfaultfd.
+   - Write to read-only memory through /proc/self/mem interface (FOLL_FORCE).
+   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
+   - userfaultfd.
 
 The idea that inspired this patch comes from Stephen Röttger’s work in V8
 CFI [4]. Chrome browser in ChromeOS will be the first user of this API.
 
 Reference:
 ==========
-[1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
-
-[2] https://man.openbsd.org/mimmutable.2
-
-[3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com
-
-[4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
+- [1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
+- [2] https://man.openbsd.org/mimmutable.2
+- [3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com
+- [4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
-- 
2.46.1.824.gd892dcdcdd-goog


