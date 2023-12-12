Return-Path: <linux-kselftest+bounces-1765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A580FB2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0691C20DF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5821A6472D;
	Tue, 12 Dec 2023 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q6rto8wf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101D9113
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:23 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d9d4193d94so4738715a34.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423042; x=1703027842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uU36FjOIbdJKQPRiJg4nrZQU0fb/SKB6wgyMQ4t+i44=;
        b=Q6rto8wfztnbMECUp7AIeqx0uu86PE9aG6ZHMHfsjUoqaLNMUDRhZk/SE9OjXCUtFl
         tyNx8suTCa8z103x5Vnhmo1qX9D6NaCaZE+t4uFYEu19z4tSFEZdam0z9d4iVNwCSfCg
         LwwbGS3JrdK+T+sSR4ad7VVWE1Nq2hRlTCaGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423042; x=1703027842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uU36FjOIbdJKQPRiJg4nrZQU0fb/SKB6wgyMQ4t+i44=;
        b=hroGy8FyPHAZhtaFIHdv5+niJ8sSDq/kO/Xw7p2V0gE/ah227Gzk9WzQIPVvubSbeq
         3fSAGZQghH866wc6RgA1YWk+qJ0F36Lx3ZV6B6R+yPN/kJxnMEbjrMBddGw08UoVg5QA
         hqQnCw3aqv7mf8jUFYws/7nmJdo4wo7w9d7sxYQloHq0Rsq8F+p5OVCUplGAIeJw5Dnk
         3AsN2Ip8atpxJk+8UQDyow6bHQr8MQJcRBjsfADvoSDwwh3mOQvdzxTXiAgeE6im+j5a
         KVvvnf1o5s3nIUq3FL0zjl/BMLVhSBIOxDgGhWBCyUGLSOKQyoa1/uSyIdVKEw/4xykl
         tGBg==
X-Gm-Message-State: AOJu0YyMVtls9v1nlE5Pq0+pNL6wzl1OevcvhgvO9/4aL8zdytTt//4q
	nL4UgyPT+BIa4hU1B/iJFvaF6g==
X-Google-Smtp-Source: AGHT+IESnkqDjGhkYEemYfFxmrgB/rWYhFKb6e57jqVPg8rTGimOrJk6IlvAbIgCglInHK6pIykjCw==
X-Received: by 2002:a05:6870:ec8b:b0:1fb:75c:400e with SMTP id eo11-20020a056870ec8b00b001fb075c400emr8193744oab.110.1702423042075;
        Tue, 12 Dec 2023 15:17:22 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id v29-20020a63481d000000b005c19c586cb7sm8685104pga.33.2023.12.12.15.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:21 -0800 (PST)
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
Subject: [RFC PATCH v3 11/11] mseal:add documentation
Date: Tue, 12 Dec 2023 23:17:05 +0000
Message-ID: <20231212231706.2680890-12-jeffxu@chromium.org>
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

Add documentation for mseal().

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/mseal.rst | 189 ++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100644 Documentation/userspace-api/mseal.rst

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
new file mode 100644
index 000000000000..651c618d0664
--- /dev/null
+++ b/Documentation/userspace-api/mseal.rst
@@ -0,0 +1,189 @@
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
+Two system calls are involved in virtual memory sealing, ``mseal()`` and ``mmap()``.
+
+``mseal()``
+-----------
+
+The ``mseal()`` is an architecture independent syscall, and with following
+signature:
+
+``int mseal(void addr, size_t len, unsigned long types, unsigned long flags)``
+
+**addr/len**: virtual memory address range.
+
+The address range set by ``addr``/``len`` must meet:
+   - start (addr) must be in a valid VMA.
+   - end (addr + len) must be in a valid VMA.
+   - no gap (unallocated memory) between start and end.
+   - start (addr) must be page aligned.
+
+The ``len`` will be paged aligned implicitly by kernel.
+
+**types**: bit mask to specify the sealing types, they are:
+
+- The ``MM_SEAL_BASE``: Prevent VMA from:
+
+    Unmapping, moving to another location, and shrinking the size,
+    via munmap() and mremap(), can leave an empty space, therefore
+    can be replaced with a VMA with a new set of attributes.
+
+    Move or expand a different vma into the current location,
+    via mremap().
+
+    Modifying sealed VMA via mmap(MAP_FIXED).
+
+    Size expansion, via mremap(), does not appear to pose any
+    specific risks to sealed VMAs. It is included anyway because
+    the use case is unclear. In any case, users can rely on
+    merging to expand a sealed VMA.
+
+    We consider the MM_SEAL_BASE feature, on which other sealing
+    features will depend. For instance, it probably does not make sense
+    to seal PROT_PKEY without sealing the BASE, and the kernel will
+    implicitly add SEAL_BASE for SEAL_PROT_PKEY. (If the application
+    wants to relax this in future, we could use the “flags” field in
+    mseal() to overwrite this the behavior.)
+
+- The ``MM_SEAL_PROT_PKEY``:
+
+    Seal PROT and PKEY of the address range, in other words,
+    mprotect() and pkey_mprotect() will be denied if the memory is
+    sealed with MM_SEAL_PROT_PKEY.
+
+- The ``MM_SEAL_DISCARD_RO_ANON``:
+
+    Certain types of madvise() operations are destructive [3], such
+    as MADV_DONTNEED, which can effectively alter region contents by
+    discarding pages, especially when memory is anonymous. This blocks
+    such operations for anonymous memory which is not writable to the
+    user.
+
+- The ``MM_SEAL_SEAL``
+    Denies adding a new seal.
+
+**flags**: reserved for future use.
+
+**return values**:
+
+- ``0``:
+    - Success.
+
+- ``-EINVAL``:
+    - Invalid seal type.
+    - Invalid input flags.
+    - Start address is not page aligned.
+    - Address range (``addr`` + ``len``) overflow.
+
+- ``-ENOMEM``:
+    - ``addr`` is not a valid address (not allocated).
+    - End address (``addr`` + ``len``) is not a valid address.
+    - A gap (unallocated memory) between start and end.
+
+- ``-EACCES``:
+    - ``MM_SEAL_SEAL`` is set, adding a new seal is not allowed.
+    - Address range is not sealable, e.g. ``MAP_SEALABLE`` is not
+      set during ``mmap()``.
+
+**Note**:
+
+- User can call mseal(2) multiple times to add new seal types.
+- Adding an already added seal type is a no-action (no error).
+- unseal() or removing a seal type is not supported.
+- In case of error return, one can expect the memory range is unchanged.
+
+``mmap()``
+----------
+``void *mmap(void* addr, size_t length, int prot, int flags, int fd,
+off_t offset);``
+
+We made two changes (``prot`` and ``flags``) to ``mmap()`` related to
+memory sealing.
+
+**prot**:
+
+- ``PROT_SEAL_SEAL``
+- ``PROT_SEAL_BASE``
+- ``PROT_SEAL_PROT_PKEY``
+- ``PROT_SEAL_DISCARD_RO_ANON``
+
+Allow ``mmap()`` to set the sealing type when creating a mapping. This is
+useful for optimization because it avoids having to make two system
+calls: one for ``mmap()`` and one for ``mseal()``.
+
+It's worth noting that even though the sealing type is set via the
+``prot`` field in ``mmap()``, we don't require it to be set in the ``prot``
+field in later ``mprotect()`` call. This is unlike the ``PROT_READ``,
+``PROT_WRITE``, ``PROT_EXEC`` bits, e.g. if ``PROT_WRITE`` is not set in
+``mprotect()``, it means that the region is not writable.
+
+**flags**
+The ``MAP_SEALABLE`` flag is added to the ``flags`` field of ``mmap()``.
+When present, it marks the map as sealable. A map created
+without ``MAP_SEALABLE`` will not support sealing; In other words,
+``mseal()`` will fail for such a map.
+
+Applications that don't care about sealing will expect their
+behavior unchanged. For those that need sealing support, opt-in
+by adding ``MAP_SEALABLE`` when creating the map.
+
+Use Case:
+=========
+- glibc:
+  The dymamic linker, during loading ELF executables, can apply sealing to
+  to non-writeable memory segments.
+
+- Chrome browser: protect some security sensitive data-structures.
+
+Additional notes:
+=================
+As Jann Horn pointed out in [3], there are still a few ways to write
+to RO memory, which is, in a way, by design. Those are not covered by
+``mseal()``. If applications want to block such cases, sandboxer
+(such as seccomp, LSM, etc) might be considered.
+
+Those cases are:
+
+- Write to read-only memory through ``/proc/self/mem`` interface.
+
+- Write to read-only memory through ``ptrace`` (such as ``PTRACE_POKETEXT``).
+
+- ``userfaultfd()``.
+
+The idea that inspired this patch comes from Stephen Röttger’s work in V8
+CFI [4].Chrome browser in ChromeOS will be the first user of this API.
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
2.43.0.472.g3155946c3a-goog


