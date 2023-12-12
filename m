Return-Path: <linux-kselftest+bounces-1764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8680180FB2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5C91F21820
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95FC64CE7;
	Tue, 12 Dec 2023 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B+rra7Ql"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62101F3
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28659348677so4893262a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423039; x=1703027839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTvy78zmaIXZsTIPkmebRTxUrUOjQ/CWIjSmsuuygoc=;
        b=B+rra7Qlh5GXmswpkI4XOv34lb9U47sKHZldy63FrdMK39oQ+BpBMOsxphFQ35KlmF
         oO2swczMZNXZQk/piSbpkEIYmyPCRauAnkACK4EYdpbB+/H8e+OpVc5Let8uvrc7CU6W
         Wdg1NmQMl4rIAmcdksYTCMfqgmL6UQBxH6ezM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423039; x=1703027839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTvy78zmaIXZsTIPkmebRTxUrUOjQ/CWIjSmsuuygoc=;
        b=Ak7VB+qfm+dB1RbYeLtE9pTNGu1QAaG9/oW1/MRYnwiqGs4CvI9cCUpvtxZ/lyGHXK
         RKvX0oa2xlBUEAdr+WbhxwzxGsdYn2v2cdg2Kd6UxYjTYAGpot5hcMagbIpBs0bVg6Tq
         ikMhAFNEWA0SGiKNW2yivwaRPcyaYYh8ednfu9pwm1dGY5F581Udldu344J2InGLwfGR
         wgVmC7/GlnUAZ3omzCLMIbrp5xxxD4E0CfnRibuCm/AY5kiRuVgD1UprKnu701R4hTiN
         hAeAKSBpdqWkl6p5fnR8qrd7N/RroChXgwXYW6AfKXl7aemEiDA0TltswkyRXgKyqc5y
         1uwQ==
X-Gm-Message-State: AOJu0YxrXoYFW+f0kT4Q91K/0/EMHZVA6pYLo+hDoDi4eBgJidSSkil8
	eGmTyZqPeqTNcBkcBOSEQw6ixA==
X-Google-Smtp-Source: AGHT+IGWlFc4mkpXoFC0PEpzgfDHSLkC9hOefaTM1E9H1ZoIhebEpqs8jP0iWKY6qbWGYpKoD0aROg==
X-Received: by 2002:a17:90a:7562:b0:28a:79b0:afc1 with SMTP id q89-20020a17090a756200b0028a79b0afc1mr5931086pjk.6.1702423038769;
        Tue, 12 Dec 2023 15:17:18 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id n20-20020a17090ade9400b00286a275d65asm11093878pjv.41.2023.12.12.15.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:18 -0800 (PST)
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
Subject: [RFC PATCH v3 08/11] mseal: add MM_SEAL_DISCARD_RO_ANON
Date: Tue, 12 Dec 2023 23:17:02 +0000
Message-ID: <20231212231706.2680890-9-jeffxu@chromium.org>
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

Certain types of madvise() operations are destructive, such as
MADV_DONTNEED, which can effectively alter region contents by
discarding pages, especially when memory is anonymous. This blocks
such operations for anonymous memory which is not writable to the
user.

The MM_SEAL_DISCARD_RO_ANON blocks such operations if users don't have
access to the memory, and the memory is anonymous memory.

We do not think such sealing is useful for file-backed mapping because
it should repopulate the memory contents from the underlying mapped
file. We also do not think it is useful if the user can write to the
memory because then the attacker can also write.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: Stephen Röttger <sroettger@google.com>
---
 include/linux/mm.h                     | 19 +++++--
 include/uapi/asm-generic/mman-common.h |  2 +
 include/uapi/linux/mman.h              |  1 +
 mm/madvise.c                           | 12 +++++
 mm/mseal.c                             | 73 ++++++++++++++++++++++++--
 5 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f162bb5b38d..50dda474acc2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -264,7 +264,8 @@ extern unsigned int kobjsize(const void *objp);
 #define MM_SEAL_ALL ( \
 	MM_SEAL_SEAL | \
 	MM_SEAL_BASE | \
-	MM_SEAL_PROT_PKEY)
+	MM_SEAL_PROT_PKEY | \
+	MM_SEAL_DISCARD_RO_ANON)
 
 /*
  * PROT_SEAL_ALL is all supported flags in mmap().
@@ -273,7 +274,8 @@ extern unsigned int kobjsize(const void *objp);
 #define PROT_SEAL_ALL ( \
 	PROT_SEAL_SEAL | \
 	PROT_SEAL_BASE | \
-	PROT_SEAL_PROT_PKEY)
+	PROT_SEAL_PROT_PKEY | \
+	PROT_SEAL_DISCARD_RO_ANON)
 
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
@@ -3354,6 +3356,9 @@ extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 extern bool can_modify_vma(struct vm_area_struct *vma,
 		unsigned long checkSeals);
 
+extern bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
+		unsigned long end, int behavior);
+
 /*
  * Convert prot field of mmap to vm_seals type.
  */
@@ -3362,9 +3367,9 @@ static inline unsigned long convert_mmap_seals(unsigned long prot)
 	unsigned long seals = 0;
 
 	/*
-	 * set SEAL_PROT_PKEY implies SEAL_BASE.
+	 * set SEAL_PROT_PKEY or SEAL_DISCARD_RO_ANON implies SEAL_BASE.
 	 */
-	if (prot & PROT_SEAL_PROT_PKEY)
+	if (prot & (PROT_SEAL_PROT_PKEY | PROT_SEAL_DISCARD_RO_ANON))
 		prot |= PROT_SEAL_BASE;
 
 	/*
@@ -3407,6 +3412,12 @@ static inline bool can_modify_vma(struct vm_area_struct *vma,
 	return true;
 }
 
+static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
+		unsigned long end, int behavior)
+{
+	return true;
+}
+
 static inline void update_vma_seals(struct vm_area_struct *vma, unsigned long vm_seals)
 {
 }
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index f07ad9e70b3a..bf503962409a 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -29,6 +29,8 @@
 #define PROT_SEAL_SEAL	_BITUL(PROT_SEAL_BIT_BEGIN)	/* 0x04000000 seal seal */
 #define PROT_SEAL_BASE	_BITUL(PROT_SEAL_BIT_BEGIN + 1)	/* 0x08000000 base for all sealing types */
 #define PROT_SEAL_PROT_PKEY	_BITUL(PROT_SEAL_BIT_BEGIN + 2)	/* 0x10000000 seal prot and pkey */
+/* seal destructive madvise for non-writeable anonymous memory. */
+#define PROT_SEAL_DISCARD_RO_ANON	_BITUL(PROT_SEAL_BIT_BEGIN + 3)	/* 0x20000000 */
 
 /* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f561652886c4..3872cc118c8a 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -58,5 +58,6 @@ struct cachestat {
 #define MM_SEAL_SEAL		_BITUL(0)
 #define MM_SEAL_BASE		_BITUL(1)
 #define MM_SEAL_PROT_PKEY	_BITUL(2)
+#define MM_SEAL_DISCARD_RO_ANON	_BITUL(3)
 
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index e2d219a4b6ef..ff038e323779 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1403,6 +1403,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *  -EIO    - an I/O error occurred while paging in data.
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
+ *  -EACCES - memory is sealed.
  */
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
@@ -1446,10 +1447,21 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	start = untagged_addr_remote(mm, start);
 	end = start + len;
 
+	/*
+	 * Check if the address range is sealed for do_madvise().
+	 * can_modify_mm_madv assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm_madv(mm, start, end, behavior)) {
+		error = -EACCES;
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
diff --git a/mm/mseal.c b/mm/mseal.c
index 3b90dce7d20e..294f48d33db6 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -11,6 +11,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/mmu_context.h>
 #include <linux/syscalls.h>
 #include <linux/sched.h>
 #include "internal.h"
@@ -66,6 +67,55 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end,
 	return true;
 }
 
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
+		if (is_ro_anon(vma) && !can_modify_vma(
+			vma, MM_SEAL_DISCARD_RO_ANON))
+			return false;
+
+	/* Allow by default. */
+	return true;
+}
+
 /*
  * Check if a seal type can be added to VMA.
  */
@@ -76,6 +126,12 @@ static bool can_add_vma_seals(struct vm_area_struct *vma, unsigned long newSeals
 	    (newSeals & ~(vma_seals(vma))))
 		return false;
 
+	/*
+	 * For simplicity, we allow adding all sealing types during mmap or mseal.
+	 * The actual sealing check will happen later during particular action.
+	 * E.g. For MM_SEAL_DISCARD_RO_ANON, we always allow adding it, at the
+	 * time madvice() call, we will check if the sealing condition isn't met.
+	 */
 	return true;
 }
 
@@ -225,15 +281,22 @@ static int apply_mm_seal(unsigned long start, unsigned long end,
  *	mprotect() and pkey_mprotect() will be denied if the memory is
  *	sealed with MM_SEAL_PROT_PKEY.
  *
- *   The MM_SEAL_SEAL
- *	MM_SEAL_SEAL denies adding a new seal for an VMA.
- *
  *	The kernel will remember which seal types are applied, and the
  *	application doesn’t need to repeat all existing seal types in
  *	the next mseal(). Once a seal type is applied, it can’t be
  *	unsealed. Call mseal() on an existing seal type is a no-action,
  *	not a failure.
  *
+ *   MM_SEAL_DISCARD_RO_ANON: block some destructive madvice()
+ *	behavior, such as MADV_DONTNEED, which can effectively
+ *	alter gegion contents by discarding pages, block such
+ *	operation if users don't have write access to the memory, and
+ *	the memory is anonymous memory.
+ *	Setting this implies MM_SEAL_BASE is also set.
+ *
+ *   The MM_SEAL_SEAL
+ *	MM_SEAL_SEAL denies adding a new seal for an VMA.
+ *
  *  flags: reserved.
  *
  * return values:
@@ -264,8 +327,8 @@ static int do_mseal(unsigned long start, size_t len_in, unsigned long types,
 	struct mm_struct *mm = current->mm;
 	size_t len;
 
-	/* MM_SEAL_BASE is set when other seal types are set. */
-	if (types & MM_SEAL_PROT_PKEY)
+	/* MM_SEAL_BASE is set when other seal types are set */
+	if (types & (MM_SEAL_PROT_PKEY | MM_SEAL_DISCARD_RO_ANON))
 		types |= MM_SEAL_BASE;
 
 	if (!can_do_mseal(types, flags))
-- 
2.43.0.472.g3155946c3a-goog


