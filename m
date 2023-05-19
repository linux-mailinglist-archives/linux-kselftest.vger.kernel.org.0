Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66872708D39
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 03:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjESBTc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 21:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjESBTa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 21:19:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCA4E7F
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:19:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d3491609fso6124b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684459168; x=1687051168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amUmjeQdjogZim3KCvDHtpibL1Mlx7r/unbXJ7VLzz4=;
        b=GibbkWqfiwuo0GDKTjKpCXZxRAC34F6flBcYc63YtvRDvtZ56HZtHKuhrJYSdwe3/+
         6kPjFdVzSbPq+cF3lXOpkjZLCMYa7ei/z4zXxpzej0So1g37PcWmqewUZUgxYJCMM+RN
         jmAWbhNUMedM1L5m+UzN6elDn6LRlSsQzlPeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459168; x=1687051168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amUmjeQdjogZim3KCvDHtpibL1Mlx7r/unbXJ7VLzz4=;
        b=aHa54ryquuCDv9KcgA9t/QwE3BoJGS2OE+UmcWuRHFiZGuLMBdjH7b+i8mwa0tbjDj
         +xR0zgbM4LT0wyaM7w1miESPqdyZHVUb+XDUkuTc0brber5bJRjnebSRBzeER29mymq4
         lfMWVpSw/P6eIK6HRbmjwjGUVfUfZ8Bagsr57hIwx4ZCy9QI8/Nz1Ly7eewV70NCg0tE
         /bd9s6YvnJoKtGQ/b8iVC8RzlTIRmqh4jhyKZT+3iLeyKtOiuji1ovF3UeXXrOOPuOw9
         IC8T9Df28AeN4lzSg/CkZG0AZQgZ1+/pSLZHi+yqarpZkeC1u0Jduoj4t5oZNQ8z1ooH
         bvMA==
X-Gm-Message-State: AC+VfDxM/s2YKzg518xVlSLSLdVHevgsiNQMOtfk2dLeTrpL0IRqSZ4Y
        JU8qasvXEX4lhkg7vHgOHYsxdw==
X-Google-Smtp-Source: ACHHUZ6CRfRqSBxkPWsay/WrlVhskzJPviRUVesausHDoJ1nxVzNabu1OJDVAOucE5hVphusdAmIbw==
X-Received: by 2002:a05:6a00:134c:b0:648:64fe:b14b with SMTP id k12-20020a056a00134c00b0064864feb14bmr881854pfu.32.1684459167669;
        Thu, 18 May 2023 18:19:27 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id b6-20020a630c06000000b00502ecb91940sm1824283pgl.55.2023.05.18.18.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 18:19:27 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v1 1/6] PKEY: Introduce PKEY_ENFORCE_API flag
Date:   Fri, 19 May 2023 01:19:09 +0000
Message-ID: <20230519011915.846407-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519011915.846407-1-jeffxu@chromium.org>
References: <20230519011915.846407-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

This patch introduces a new flag, PKEY_ENFORCE_API, to the pkey_alloc()
function. When a PKEY is created with this flag, it is enforced that any
thread that wants to make changes to the memory mapping (such as
mprotect/munmap) of the memory must have write access to the PKEY.
This is to prevent unauthorized access to protected memory.

PKEYs created without this flag will continue to work as they do now,
for backwards compatibility.

Signed-off-by: Jeff Xu<jeffxu@google.com>
---
 arch/powerpc/include/asm/pkeys.h | 11 ++++++++-
 arch/x86/include/asm/mmu.h       |  7 ++++++
 arch/x86/include/asm/pkeys.h     | 42 ++++++++++++++++++++++++++++++--
 arch/x86/mm/pkeys.c              |  2 +-
 include/linux/pkeys.h            |  9 ++++++-
 include/uapi/linux/mman.h        |  5 ++++
 mm/mprotect.c                    |  6 ++---
 7 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 59a2c7dbc78f..943333ac0fee 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -82,7 +82,7 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
  * Relies on the mmap_lock to protect against concurrency in mm_pkey_alloc() and
  * mm_pkey_free().
  */
-static inline int mm_pkey_alloc(struct mm_struct *mm)
+static inline int mm_pkey_alloc(struct mm_struct *mm, unsigned long flags)
 {
 	/*
 	 * Note: this is the one and only place we make sure that the pkey is
@@ -168,5 +168,14 @@ static inline bool arch_pkeys_enabled(void)
 	return mmu_has_feature(MMU_FTR_PKEY);
 }
 
+static inline bool arch_check_pkey_alloc_flags(unsigned long flags)
+{
+	/* No flags supported yet. */
+	if (flags)
+		return false;
+
+	return true;
+}
+
 extern void pkey_mm_init(struct mm_struct *mm);
 #endif /*_ASM_POWERPC_KEYS_H */
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 0da5c227f490..d97594b44d9a 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -66,6 +66,13 @@ typedef struct {
 	 */
 	u16 pkey_allocation_map;
 	s16 execute_only_pkey;
+	/*
+	 * One bit per protection key.
+	 * When set, thread must have write permission on corresponding
+	 * PKRU in order to call memory mapping API, such as mprotect,
+	 * munmap, etc.
+	 */
+	u16 pkey_enforce_api_map;
 #endif
 } mm_context_t;
 
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 2e6c04d8a45b..ecadf04a8251 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -51,6 +51,17 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 	mm_pkey_allocation_map(mm) &= ~(1U << pkey);	\
 } while (0)
 
+#define mm_pkey_enforce_api_map(mm) (mm->context.pkey_enforce_api_map)
+#define mm_set_pkey_enforce_api(mm, pkey)                                      \
+	{                                                                      \
+		mm_pkey_enforce_api_map(mm) |= (1U << pkey);                   \
+	}
+
+#define mm_clear_pkey_enforce_api(mm, pkey)                                    \
+	{                                                                      \
+		mm_pkey_enforce_api_map(mm) &= ~(1U << pkey);                  \
+	}
+
 static inline
 bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
@@ -74,11 +85,25 @@ bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 	return mm_pkey_allocation_map(mm) & (1U << pkey);
 }
 
+/*
+ * Return true if the pkey has ENFORCE_API flag during allocation.
+ */
+static inline bool mm_pkey_enforce_api(struct mm_struct *mm, int pkey)
+{
+	/*
+	 * Only pkey created by user space has the flag.
+	 * execute_only_pkey check is in mm_pkey_is_allocated().
+	 */
+	if (pkey != ARCH_DEFAULT_PKEY && mm_pkey_is_allocated(mm, pkey))
+		return mm_pkey_enforce_api_map(mm) & (1U << pkey);
+
+	return false;
+}
+
 /*
  * Returns a positive, 4-bit key on success, or -1 on failure.
  */
-static inline
-int mm_pkey_alloc(struct mm_struct *mm)
+static inline int mm_pkey_alloc(struct mm_struct *mm, unsigned long flags)
 {
 	/*
 	 * Note: this is the one and only place we make sure
@@ -101,6 +126,9 @@ int mm_pkey_alloc(struct mm_struct *mm)
 
 	mm_set_pkey_allocated(mm, ret);
 
+	if (flags & PKEY_ENFORCE_API)
+		mm_set_pkey_enforce_api(mm, ret);
+
 	return ret;
 }
 
@@ -110,6 +138,7 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
 	if (!mm_pkey_is_allocated(mm, pkey))
 		return -EINVAL;
 
+	mm_clear_pkey_enforce_api(mm, pkey);
 	mm_set_pkey_free(mm, pkey);
 
 	return 0;
@@ -123,4 +152,13 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
 }
 
+static inline bool arch_check_pkey_alloc_flags(unsigned long flags)
+{
+	unsigned long valid_flags = PKEY_ENFORCE_API;
+
+	if (flags & ~valid_flags)
+		return false;
+
+	return true;
+}
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 7418c367e328..a76981f44acf 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -20,7 +20,7 @@ int __execute_only_pkey(struct mm_struct *mm)
 	/* Do we need to assign a pkey for mm's execute-only maps? */
 	if (execute_only_pkey == -1) {
 		/* Go allocate one to use, which might fail */
-		execute_only_pkey = mm_pkey_alloc(mm);
+		execute_only_pkey = mm_pkey_alloc(mm, 0);
 		if (execute_only_pkey < 0)
 			return -1;
 		need_to_set_mm_pkey = true;
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 86be8bf27b41..81a482c3e051 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -3,6 +3,7 @@
 #define _LINUX_PKEYS_H
 
 #include <linux/mm.h>
+#include <linux/mman.h>
 
 #define ARCH_DEFAULT_PKEY	0
 
@@ -25,7 +26,7 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 	return (pkey == 0);
 }
 
-static inline int mm_pkey_alloc(struct mm_struct *mm)
+static inline int mm_pkey_alloc(struct mm_struct *mm, unsigned long flags)
 {
 	return -1;
 }
@@ -46,6 +47,12 @@ static inline bool arch_pkeys_enabled(void)
 	return false;
 }
 
+static inline bool arch_check_pkey_alloc_flags(unsigned long flags)
+{
+	if (flags)
+		return false;
+	return true;
+}
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 #endif /* _LINUX_PKEYS_H */
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f55bc680b5b0..8c69b9a7ff5b 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -41,4 +41,9 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+/*
+ * Flags for pkey_alloc
+ */
+#define PKEY_ENFORCE_API (1 << 0)
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 92d3d3ca390a..8a68fdca8487 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -894,15 +894,15 @@ SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
 	int pkey;
 	int ret;
 
-	/* No flags supported yet. */
-	if (flags)
+	if (!arch_check_pkey_alloc_flags(flags))
 		return -EINVAL;
+
 	/* check for unsupported init values */
 	if (init_val & ~PKEY_ACCESS_MASK)
 		return -EINVAL;
 
 	mmap_write_lock(current->mm);
-	pkey = mm_pkey_alloc(current->mm);
+	pkey = mm_pkey_alloc(current->mm, flags);
 
 	ret = -ENOSPC;
 	if (pkey == -1)
-- 
2.40.1.606.ga4b1b128d6-goog

