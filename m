Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F3274066D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 00:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjF0WXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 18:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF0WXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 18:23:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1351FFE
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 15:23:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8171718a1so13428715ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687904602; x=1690496602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b1uVANehIH/+ZRkMH5+9QKYLvg0brFXglBZxj/Lb5k=;
        b=gEcExF6ctP9ecPj0QdqDgAMhxYjv7gEA2EWt5Y19A2daB2l8HRLMkEr6We3il4IgP3
         vevmVr8fRe7IriRi65dyKzYMFgEGBEWpYz/x9jTSEpBgGZ+jYYarELi/NjfHnww+lzwN
         rQToyYkdVETwl2WczZGkqaJ4hoJ79UatG4QvdDJxvSf1dW8OCuZEdDmPIAKmWRLx3RFb
         S5kQigp+4/aDWD2kqAGi3NJe/ghuP+ZmoJGGZd/g7O27j8tOAjQFdsovK7/ONC9t9XFT
         f8FJNYDTdjWXwzWLtMYkAqQ1tKAiOgD+yH3lOhGkiAyRe/BGzpg/s0s50kwg1twgcn7L
         WGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687904602; x=1690496602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0b1uVANehIH/+ZRkMH5+9QKYLvg0brFXglBZxj/Lb5k=;
        b=lJG+gQ9Dr+PJYDBLgdiQZQQiqcl4pkSGzZYhzylkIVsv+aL7H9g9mISehKSU0DFIsh
         eRcLYAx9JZVpEYohrjePIlckPnsskfhvTutJT8FHvvDsfRioJ89P6CXcbzcPmwk1q/36
         Em5YCLoePJv2we3hQzN6f6Zr00hD3qj+2I+X14+sZoKMsDL4pxm5TTcrJb5uoOrjreSE
         5YayoNW6u3kNScuP1oAOgoR02qJsPk+cx5f0NjW81IJact7ZW7TR1L0LGlYSfPP2R3eD
         Jf3nuQg2SKKB9F6/AKZOiezK3gV/DGgHDslrGqKMEyvbWhKWvYFmHDRTk6g3rVmle/0x
         C39w==
X-Gm-Message-State: AC+VfDzmA6lPG6iaUQombklSO1+SRqcqWzutNUCOEOzPEQsBEFhFn7su
        n7GgRQ2HgNF3j5FH1D+hU7XXUQ==
X-Google-Smtp-Source: ACHHUZ6Tj8W8zHg8xhmH4tU7cYqw43xProPUlEbN/8uZqACTAzhliVCOpHStCVkiQqvhKTPN9Q2VBw==
X-Received: by 2002:a17:903:1205:b0:1b3:e90b:93e1 with SMTP id l5-20020a170903120500b001b3e90b93e1mr16854146plh.36.1687904602358;
        Tue, 27 Jun 2023 15:23:22 -0700 (PDT)
Received: from ghost.hq.rivosinc.com ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c24400b001ac94b33ab1sm5108271plg.304.2023.06.27.15.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 15:23:21 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     alexghiti@rivosinc.com
Cc:     charlie@rivosinc.com, atishp@rivosinc.com, conor@kernel.org,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, bjorn@rivosinc.com, anup@brainfault.org,
        evan@rivosinc.com, linux-riscv@lists.infradead.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Date:   Tue, 27 Jun 2023 15:21:51 -0700
Message-Id: <20230627222152.177716-2-charlie@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627222152.177716-1-charlie@rivosinc.com>
References: <20230627222152.177716-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make sv39 the default address space for mmap as some applications
currently depend on this assumption. The RISC-V specification enforces
that bits outside of the virtual address range are not used, so
restricting the size of the default address space as such should be
temporary. A hint address passed to mmap will cause the largest address
space that fits entirely into the hint to be used. If the hint is less
than or equal to 1<<38, a 39-bit address will be used. After an address
space is completely full, the next smallest address space will be used.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/elf.h       |  2 +-
 arch/riscv/include/asm/pgtable.h   | 13 +++++++++-
 arch/riscv/include/asm/processor.h | 41 +++++++++++++++++++++++++-----
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 30e7d2455960..1b57f13a1afd 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -49,7 +49,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
  * the loader.  We need to make sure that it is out of the way of the program
  * that it will "exec", and that there is sufficient room for the brk.
  */
-#define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
+#define ELF_ET_DYN_BASE		((DEFAULT_MAP_WINDOW / 3) * 2)
 
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_COMPAT
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 75970ee2bda2..e83912e97870 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -57,18 +57,29 @@
 #define MODULES_END		(PFN_ALIGN((unsigned long)&_start))
 #endif
 
+
 /*
  * Roughly size the vmemmap space to be large enough to fit enough
  * struct pages to map half the virtual address space. Then
  * position vmemmap directly below the VMALLOC region.
  */
 #ifdef CONFIG_64BIT
+#define VA_BITS_SV39 39
+#define VA_BITS_SV48 48
+#define VA_BITS_SV57 57
+
+#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
+#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
+#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
+
 #define VA_BITS		(pgtable_l5_enabled ? \
-				57 : (pgtable_l4_enabled ? 48 : 39))
+				VA_BITS_SV57 : (pgtable_l4_enabled ? VA_BITS_SV48 : VA_BITS_SV39))
 #else
 #define VA_BITS		32
 #endif
 
+#define DEFAULT_VA_BITS ((VA_BITS >= VA_BITS_SV39) ? VA_BITS_SV39 : VA_BITS)
+
 #define VMEMMAP_SHIFT \
 	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
 #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 6fb8bbec8459..019dcd4ecae4 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -12,20 +12,47 @@
 
 #include <asm/ptrace.h>
 
-/*
- * This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
-
-#define STACK_TOP		TASK_SIZE
 #ifdef CONFIG_64BIT
+#define DEFAULT_MAP_WINDOW	(UL(1) << (DEFAULT_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE_64
+
+#define arch_get_mmap_end(addr, len, flags) \
+	((addr) == 0 || (addr) >= VA_USER_SV57 ? STACK_TOP_MAX :   \
+	 (((addr) >= VA_USER_SV48) && (VA_BITS >= VA_BITS_SV48)) ? \
+						 VA_USER_SV48 : \
+						 VA_USER_SV39)
+
+#define arch_get_mmap_base(addr, base) \
+	(((addr >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) ?   \
+		 base + STACK_TOP_MAX - DEFAULT_MAP_WINDOW : \
+	 (((addr) >= VA_USER_SV48) && (VA_BITS >= VA_BITS_SV48)) ? \
+		 base + VA_USER_SV48 - DEFAULT_MAP_WINDOW : \
+		 base)
+
 #else
+#define DEFAULT_MAP_WINDOW	TASK_SIZE
 #define STACK_TOP_MAX		TASK_SIZE
+
+#define arch_get_mmap_end(addr, len, flags) \
+	((addr) > DEFAULT_MAP_WINDOW ? STACK_TOP_MAX : DEFAULT_MAP_WINDOW)
+
+#define arch_get_mmap_base(addr, base) \
+	((addr > DEFAULT_MAP_WINDOW) ? \
+		base + STACK_TOP_MAX - DEFAULT_MAP_WINDOW : \
+		base)
+
 #endif
 #define STACK_ALIGN		16
 
+
+#define STACK_TOP		DEFAULT_MAP_WINDOW
+
+/*
+ * This decides where the kernel will search for a free chunk of vm
+ * space during mmap's.
+ */
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(DEFAULT_MAP_WINDOW / 3)
+
 #ifndef __ASSEMBLY__
 
 struct task_struct;
-- 
2.34.1

