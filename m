Return-Path: <linux-kselftest+bounces-3325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC6836C03
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65A6281A0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDC5DF36;
	Mon, 22 Jan 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I/kNe/D9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773415DF07
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937355; cv=none; b=tencbpTIq+/2jGrwTt3FR0iIDOC9HFK/UMUuUayGu9ypuoT+SMYd7no4ckKjjgP8dcMDeiILiVmY6PDaZ6AkeD5qF/lxNxkCtCSuoEvq+AR3IHmsTsWQn/Eehre3iSLN6430bP4LIlkurOZonrO81HwfJnEMgNVzTBkGjAzFPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937355; c=relaxed/simple;
	bh=qFLLEzEQY9RrJb+O54+DXQZdLE3RHpmttMYetOYEUZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3VYZqWpl6XfWxUJQJJZaXkDftl97e5an3X7gJ5WV3/OVCA5koq4eDjzV0N91lMoboQZcJkLKZSPm2Su69KRhOkH7MejUXGL2PzIuffns3jl6kvEsVzr2t0gWPPCss2AOes2dLjDCo8uPpoAroPM9PI2F6VgyXj5StdXTsHBgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I/kNe/D9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dbe5014eb5so512285b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705937352; x=1706542152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkL2/JBu7Xm4fXV2SaZyo6nhyEe635LV1RL9ITVGXBc=;
        b=I/kNe/D9MkTdUjPg95g2RJjJxGKrk38WWob/MLhT9HactWp1N6DRCpWSQZY7s/sxiT
         4akMR6KVIkUYpYKWX2L+7+tzQk20qchOPq/ccNuRnUgatAtOQdBF+xgjK8zr7pEppJBI
         htrwu1RxnqIm+Ou4g0ZKkh331SjXSSDpoqZfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705937352; x=1706542152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkL2/JBu7Xm4fXV2SaZyo6nhyEe635LV1RL9ITVGXBc=;
        b=V9dYqsvZuXFq3BUloFS44qUVvBFCB1GIsmtc9YxFrE+T2HuemFrwCrgFwGER6QA9xW
         O/hGLECJhong0vFk7/r5LATF3QlU3Z5O82Xf65gUz/pF2GVIfmM0sUXhJTxi9zbsHKk3
         rZPgYIqnhdNkf2jcnKmNeLLW+xW1Kof/WrYPZ6zrnZ77QCDlBb5laKS8k57aE85ndOf8
         uOiMYCK6SdW5pM8qi4/IaCVs3r1FGxyI8C9CQYrM+IZjD5gIE7Yn8oZhHEkEgZqh3aDS
         ZGTParbgmH1hc+F+CQD1QjG4VbG6PRM1R7EoW+h80QstCQQQubyMFqA8vknot4kUrjMI
         a/gg==
X-Gm-Message-State: AOJu0YwNOOwugm3DyRIFFqiLQkHf7YL4HBrT6JwdLfDckiURIOkPsXWF
	gyOTEIf9lBYIEUM+d27iHUZVbdg84eLgMSb//14UDGi28S1i0uCjJTfQTRs5CQ==
X-Google-Smtp-Source: AGHT+IEojaweEqOqB9iixvGtj85QUL1W2QLrCxvGYzSIRt4xieXc2D9OQdVdixqSGP+kissYVTN+GQ==
X-Received: by 2002:a17:902:d489:b0:1d6:fbab:d409 with SMTP id c9-20020a170902d48900b001d6fbabd409mr2261821plg.58.1705937351561;
        Mon, 22 Jan 2024 07:29:11 -0800 (PST)
Received: from localhost (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.gmail.com with UTF8SMTPSA id h30-20020a056a00001e00b006d9ac70682bsm9638639pfk.167.2024.01.22.07.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:29:11 -0800 (PST)
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
Subject: [PATCH v7 4/4] mseal:add documentation
Date: Mon, 22 Jan 2024 15:28:50 +0000
Message-ID: <20240122152905.2220849-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240122152905.2220849-1-jeffxu@chromium.org>
References: <20240122152905.2220849-1-jeffxu@chromium.org>
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
 Documentation/userspace-api/mseal.rst | 183 ++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)
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
index 000000000000..929a706b70eb
--- /dev/null
+++ b/Documentation/userspace-api/mseal.rst
@@ -0,0 +1,183 @@
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
+
+Applications that don't care about sealing will expect their
+behavior unchanged. For those that need sealing support, opt in
+by adding ``MAP_SEALABLE`` in mmap().
+
+Note: for a map created without ``MAP_SEALABLE`` or a map created
+with ``MAP_SEALABLE`` but not sealed yet, mmap(MAP_FIXED) can
+change the sealable or sealing bit.
+
+Use Case:
+=========
+- glibc:
+  The dynamic linker, during loading ELF executables, can apply sealing to
+  non-writable memory segments.
+
+- Chrome browser: protect some security sensitive data-structures.
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


