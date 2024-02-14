Return-Path: <linux-kselftest+bounces-4639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE74B854C48
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 16:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4CD1C21F2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3590C5D90A;
	Wed, 14 Feb 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5b60jSn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD65C5E8
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923516; cv=none; b=tMMst0hQ3zwrPShS0x/Zv00KJWt02jUS5UqaPpqEAQarisjLnx8GDb9W7VGe4mobqTqlOGv9szm0ncjukgbiZ5ommfttxQa+/YazyvASZHAh+E5tELLSgth99W7x2j/oXCH42HKD0dlvHdk5MIGsUk8fK4Touy42+2Jh+C2EfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923516; c=relaxed/simple;
	bh=OLzGr2UqYjQ5wvQWSnv5hChQq8XcgB8hhmFIY58ieQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dkqn9bQ+KEZS/FLxThBeRnLWCcfR5YkTG53e04p+euAUX6s68PXdqnEtmNlTRn7Rp4qIeBTqsK3UxTcqMWP3t4zzXACvtOs2aLxzIraDUE+eTwfpCCO02v7PMwIvJpl+Stg/w054/E5u5b0PW0UIsrbo2EI+jI6ssPsiO9PvjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k5b60jSn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e10746c6f4so827343b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707923511; x=1708528311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeOU341dpK7/pSwmZHIwR5hTdtPU0C8qFKSlDUuggDQ=;
        b=k5b60jSnjXsGTL/TKjp1GG8WRPLt41YeJXtyWD7D08+deP7ZLfrnjlpq6ZVknbJkys
         VxoYIVZ7NkKJ/1jG2XzssO1lHEXBj04CNyXcb42MwWaNImD/67QxtTI4EshKqq/SNSIQ
         jfuo6+ZXcI2H6i9obiAUIa3rJg0IJGMXDZSHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923511; x=1708528311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeOU341dpK7/pSwmZHIwR5hTdtPU0C8qFKSlDUuggDQ=;
        b=mLS/8puv9rqpJbPGoUDt+BnAiDSV/ckHWaoiR0WlxHOehlj8xqCQ0X6/A+bzYhAh/5
         PSYcTzthdsU/pQ5pr7Lr6hlV9Bab8rM9yg5ASNNoKldWCczmD0itTYGerPHmVAcLZDLD
         e1zBa3q9yDE7jRWbjODJlwgBwFrYv8xKUJGaADu4W78TZxSz3hpkucfZFHEJB0vsz/5z
         2a118KDlKK1Cx0MeU/K1zcoeS8EOHuzfyQ+SOGs0OPC4dcQWHtgl7Pcv0JU+nLx/cvuQ
         69TxyaL3A+RFZi+HCYRRpqcWwL86cJa9Yl2+T/tWhJTbRIpby3ykS7kW852tgsssMd24
         VZXA==
X-Forwarded-Encrypted: i=1; AJvYcCVMGqUBvcsdIDYAu/cssgC8CAr9NWvQTOvkfEEs3hh0+mkAFhEAC0vcb4K9QIlLQWsVairjstbdr6d1ZrOj6WonQEzt3hSgDF2h7yvvkzfa
X-Gm-Message-State: AOJu0Yw8dtdHjyZpfQPPiF14qg6Fiwpd6iwfIHLRKd2MIbL2NYfPtn2F
	P4ATC0eJbOO0mE9B1Eo1LLJiREHthnRdu9vgd8MqrJcBB0Zc8pEuKodu7dq+DQ==
X-Google-Smtp-Source: AGHT+IF4fmk7naPGR8TxwhNa8pfOTh7fhRpFbuE0eb/jb3WuH6PMiQ+VPjfiTPpPuqolWXtMYqGsbw==
X-Received: by 2002:a05:6a20:6f8c:b0:19c:96e4:3671 with SMTP id gv12-20020a056a206f8c00b0019c96e43671mr3833752pzb.30.1707923510726;
        Wed, 14 Feb 2024 07:11:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0BGgcQPV3uP1lQPOUO28KGwWjMIVBV/p9Fc7LRZRg6amJg+l/sIpsmgWbG2aZQRNYcjE/YgJiWFHo2bNZb3sUbxn0R8Hn7r0uSeegQF7DDBGcpFCO4FrPilH7c0HKd+grDG/KtC6fPJbMdaS2/ljka+6eALg783sD7mOKOiUdUZi1//rgwVXwM/UF03iG6oKfkZKB1oTAmMqb50BhiB79WA433vBSw4aUVJp5GauMGMgo2bvwsWG38mkkvy1AUbO+/j1MsW010GRDBl+eILpPK20J8604lRBMMq35sc+4b2CYne4XRgijX1+QnvKBg7efvFgVxrJpYVveDqed/GMum1VHtJiON8wgLkmZjdrLwavgD+83luBhfUMpsgMhUZ/+AjRgnIr1NK6rxBP0CjA4D1Q/SMt0mb+/ZkdZfLVqBbOtOervrkKXHjztza7MXFDFFoxA02/0thwi6zFugdnxBj2Krxsm4B0Z/BgAJEGnqyZtE+aVL5i8I0qOGBahCjbAR3CvD2SBgW2Elc4F9SAiXi+plqnkz6a7/piIxFG2fUNIE2Qi14x8ixubhu7OIMTVqeIFahb3pVphMs+2Lp3dNvg+wFKk/mTpm3zZ3ehm+pBDexb9P3pvpSxD/kXYGaGrasdFlQ7QFs/PmKp+onBAiO+LWitLxE1o2Q950fPXaL7Yek3a1+nbtfIuvlXQoPSrplO5b2/jg/wV6HUFRoCm8CDoy83O5ymAdaicefVEQO4o8AkQRsRnmIrpqiGdSohX9NkL3wbmAwG/zy76zs8rc40=
Received: from localhost (56.72.82.34.bc.googleusercontent.com. [34.82.72.56])
        by smtp.gmail.com with UTF8SMTPSA id ll9-20020a056a00728900b006e05b63bf59sm9416083pfb.26.2024.02.14.07.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:11:50 -0800 (PST)
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
	=David.Laight@aculab.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v9 4/5] mseal:add documentation
Date: Wed, 14 Feb 2024 15:11:28 +0000
Message-ID: <20240214151130.616240-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240214151130.616240-1-jeffxu@chromium.org>
References: <20240214151130.616240-1-jeffxu@chromium.org>
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
 Documentation/userspace-api/mseal.rst | 199 ++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)
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
index 000000000000..4132eec995a3
--- /dev/null
+++ b/Documentation/userspace-api/mseal.rst
@@ -0,0 +1,199 @@
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
+    For blocked operations, one can expect the given address is unmodified,
+    i.e. no partial update. Note, this is different from existing mm
+    system call behaviors, where partial updates are made till an error is
+    found and returned to userspace. To give an example:
+
+    Assume following code sequence:
+
+    - ptr = mmap(null, 8192, PROT_NONE);
+    - munmap(ptr + 4096, 4096);
+    - ret1 = mprotect(ptr, 8192, PROT_READ);
+    - mseal(ptr, 4096);
+    - ret2 = mprotect(ptr, 8192, PROT_NONE);
+
+    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
+
+    ret2 will be -EPERM, the page remains to be PROT_READ.
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
+Use cases:
+==========
+- glibc:
+  The dynamic linker, during loading ELF executables, can apply sealing to
+  non-writable memory segments.
+
+- Chrome browser: protect some security sensitive data-structures.
+
+Notes on which memory to seal:
+==============================
+
+It might be important to note that sealing changes the lifetime of a mapping,
+i.e. the sealed mapping won’t be unmapped till the process terminates or the
+exec system call is invoked. Applications can apply sealing to any virtual
+memory region from userspace, but it is crucial to thoroughly analyze the
+mapping's lifetime prior to apply the sealing.
+
+For example:
+
+- aio/shm
+
+  aio/shm can call mmap()/munmap() on behalf of userspace, e.g. ksys_shmdt() in
+  shm.c. The lifetime of those mapping are not tied to the lifetime of the
+  process. If those memories are sealed from userspace, then munmap() will fail,
+  causing leaks in VMA address space during the lifetime of the process.
+
+- Brk (heap)
+
+  Currently, userspace applications can seal parts of the heap by calling
+  malloc() and mseal().
+  let's assume following calls from user space:
+
+  - ptr = malloc(size);
+  - mprotect(ptr, size, RO);
+  - mseal(ptr, size);
+  - free(ptr);
+
+  Technically, before mseal() is added, the user can change the protection of
+  the heap by calling mprotect(RO). As long as the user changes the protection
+  back to RW before free(), the memory range can be reused.
+
+  Adding mseal() into the picture, however, the heap is then sealed partially,
+  the user can still free it, but the memory remains to be RO. If the address
+  is re-used by the heap manager for another malloc, the process might crash
+  soon after. Therefore, it is important not to apply sealing to any memory
+  that might get recycled.
+
+  Furthermore, even if the application never calls the free() for the ptr,
+  the heap manager may invoke the brk system call to shrink the size of the
+  heap. In the kernel, the brk-shrink will call munmap(). Consequently,
+  depending on the location of the ptr, the outcome of brk-shrink is
+  nondeterministic.
+
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
2.43.0.687.g38aa6559b0-goog


