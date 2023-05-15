Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B8702D7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 15:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbjEONGr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 09:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242186AbjEONGf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 09:06:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D54F268D
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 06:06:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5341737d7aeso1113112a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684155961; x=1686747961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amUmjeQdjogZim3KCvDHtpibL1Mlx7r/unbXJ7VLzz4=;
        b=N/+vAM467OglvcK5xTQfs4XWaq6XdqOUlnNqgaqWQ23QJto1u5hnHaDbMk15m9A1Dr
         YOq7k5ElDFHK8lgmhn3iChrsAtjQgcB4vHR77/JH3M/x2tgCBJK502XSHwtBKBaZYzbk
         rA7ZQqU99ZIhg7TK53UiwR7aFgmnN3dZNqKsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155961; x=1686747961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amUmjeQdjogZim3KCvDHtpibL1Mlx7r/unbXJ7VLzz4=;
        b=KStaVoT3FA+4R4hcDWVERkt90TJc1HliL4mEuxsts67UNDNMcLtMKYj6Oxho84fNNf
         +UdeuCAZxPglnTXZvJGDE/OqO1xmp1PKAAsATfH4OUCEczDAK3uphY4zqAnga0JmcSq0
         UBxfdYNCpXQ0Ssr2O6ia6f3HaqvKya3DhAQhpaHGmBv0IVs+GlKyDTscMmvs29scG90S
         AxSEjaAbFaYhWCLbreP2c/NK59/ieS/aBpiGnHj5idQ10N5/KTsI6jTfMZen5dalyd8u
         F7JcP31xAL2U3QtAYaEh7gBablB5dvq825Kolrxbu9gOBmosHa514CjKFyZl0L+usTB7
         ZUBw==
X-Gm-Message-State: AC+VfDzENdPtnrYA0jFyPNWKrNfoXw8pY9X9NDrpm3MOgsxOFj084DGl
        9sf3rKCGYVILsXFJduMNzM2NMQ==
X-Google-Smtp-Source: ACHHUZ54OoJ9C5mGmXEjFBPZ+0O08cKmkUJ5oO7isFCKnT6ICVIBMxV1xzNCBVY30Rgzi3YVlV184g==
X-Received: by 2002:a05:6a20:72aa:b0:100:d061:52ce with SMTP id o42-20020a056a2072aa00b00100d06152cemr30768717pzk.55.1684155961118;
        Mon, 15 May 2023 06:06:01 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id g17-20020aa78751000000b005aa60d8545esm11745710pfo.61.2023.05.15.06.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 06:06:00 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/6] PKEY: Introduce PKEY_ENFORCE_API flag
Date:   Mon, 15 May 2023 13:05:47 +0000
Message-ID: <20230515130553.2311248-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230515130553.2311248-1-jeffxu@chromium.org>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

