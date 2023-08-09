Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D876D776CC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 01:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjHIXYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 19:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjHIXYY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 19:24:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4FCE42
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 16:24:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc6bfc4b58so3381995ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 16:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691623463; x=1692228263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmBbsdQ/RomBbwS1vxZnTkZx2Et0MhurExBgxgdCP1I=;
        b=2+bjYsQuCuir4dXzfsoxd+f2uLvMo+55BujM3RV74p9qc01puICn3suYXl9PdG27HR
         6MlZXk8AAnRoaiKJL13ccMX1uf4QKbGt8Hh/bNm1YesgqMS51G0b/8fzdP9eA6NrA/1l
         rFgvFkJHzxu987W8DljvJYRi+n62AtZKjSJtheuMQvxpOPwMUgtQG8AF8UHYaoGKbmNX
         HUgJPK3bCetz7V1Yo7dT3SuJINERzhRHFq5fuSJUqF49V90xFMKgXrCbZNMkE42mVKF0
         h+9/V8lzU/iPyiDJ2uY3OxrgT6eQp95NvTdYAGOmf4wohaiXftvKIMkcBpUDdiaSQh8P
         rrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623463; x=1692228263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmBbsdQ/RomBbwS1vxZnTkZx2Et0MhurExBgxgdCP1I=;
        b=hew0QoBZXBo4tj2KSCi0khocppYzHlzGeGEgUL8Iqh72HMCe5IilhOqJjPPUWhuSaV
         JOMKL+HORB63ygmfdvN13z5ce0J8hEkctRRPliuYX5g7XRQ5XZsBlp5NlJMQnNWOGmKu
         4GBycn2HqBILEI60NgIM66hAIhelvv3vLrnCZbm0hXIvBgSSNLTkOBKKPz2T9x1Ci10h
         J47ZmviCuHr9ARScr3TvTPSuWb/tZrTJ8QJRwr0tOVzNRef3oDo0xJiwOPSqPdCziXBz
         q38Ribww75lc5tHCSvPyjXq588oVexy8AznIQkWlF3UJJD1nojKSSUqM4ZrRDohFeKes
         Rsig==
X-Gm-Message-State: AOJu0YyZcmDrkw/NB/yzx19SRreaYp2hUJ/9HKb68M1gtotvc4TVKg3d
        8mDY7e7HuGAjNPrqxo/rI0HJIQ==
X-Google-Smtp-Source: AGHT+IEvMNXMKRDHFqB7btAA63/lSftDQmnwUngeNUblgGgKLK4eUIYFOblXSJ04gi6spIkTx3aMKQ==
X-Received: by 2002:a17:902:db06:b0:1bc:506a:58f2 with SMTP id m6-20020a170902db0600b001bc506a58f2mr632035plx.46.1691623462666;
        Wed, 09 Aug 2023 16:24:22 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001b54d064a4bsm82765plk.259.2023.08.09.16.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:24:22 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v10 1/4] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Date:   Wed,  9 Aug 2023 16:22:01 -0700
Message-ID: <20230809232218.849726-2-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809232218.849726-1-charlie@rivosinc.com>
References: <20230809232218.849726-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make sv48 the default address space for mmap as some applications
currently depend on this assumption. A hint address passed to mmap will
cause the largest address space that fits entirely into the hint to be
used. If the hint is less than or equal to 1<<38, an sv39 address will
be used. An exception is that if the hint address is 0, then a sv48
address will be used. After an address space is completely full, the next
smallest address space will be used.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/elf.h       |  2 +-
 arch/riscv/include/asm/pgtable.h   | 25 ++++++++++++--
 arch/riscv/include/asm/processor.h | 52 ++++++++++++++++++++++++++----
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index c24280774caf..5d3368d5585c 100644
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
index 75970ee2bda2..bb0b9ac7b581 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -62,11 +62,16 @@
  * struct pages to map half the virtual address space. Then
  * position vmemmap directly below the VMALLOC region.
  */
+#define VA_BITS_SV32 32
 #ifdef CONFIG_64BIT
+#define VA_BITS_SV39 39
+#define VA_BITS_SV48 48
+#define VA_BITS_SV57 57
+
 #define VA_BITS		(pgtable_l5_enabled ? \
-				57 : (pgtable_l4_enabled ? 48 : 39))
+				VA_BITS_SV57 : (pgtable_l4_enabled ? VA_BITS_SV48 : VA_BITS_SV39))
 #else
-#define VA_BITS		32
+#define VA_BITS		VA_BITS_SV32
 #endif
 
 #define VMEMMAP_SHIFT \
@@ -111,11 +116,27 @@
 #include <asm/page.h>
 #include <asm/tlbflush.h>
 #include <linux/mm_types.h>
+#include <asm/compat.h>
 
 #define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
 
 #ifdef CONFIG_64BIT
 #include <asm/pgtable-64.h>
+
+#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
+#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
+#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
+
+#ifdef CONFIG_COMPAT
+#define MMAP_VA_BITS_64 ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
+#define MMAP_MIN_VA_BITS_64 (VA_BITS_SV39)
+#define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
+#define MMAP_MIN_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_MIN_VA_BITS_64)
+#else
+#define MMAP_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
+#define MMAP_MIN_VA_BITS (VA_BITS_SV39)
+#endif /* CONFIG_COMPAT */
+
 #else
 #include <asm/pgtable-32.h>
 #endif /* CONFIG_64BIT */
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index c950a8d9edef..3e23e1786d05 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,19 +13,59 @@
 
 #include <asm/ptrace.h>
 
+#ifdef CONFIG_64BIT
+#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
+#define STACK_TOP_MAX		TASK_SIZE_64
+
+#define arch_get_mmap_end(addr, len, flags)			\
+({								\
+	unsigned long mmap_end;					\
+	typeof(addr) _addr = (addr);				\
+	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+		mmap_end = STACK_TOP_MAX;			\
+	else if ((_addr) >= VA_USER_SV57)			\
+		mmap_end = STACK_TOP_MAX;			\
+	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
+		mmap_end = VA_USER_SV48;			\
+	else							\
+		mmap_end = VA_USER_SV39;			\
+	mmap_end;						\
+})
+
+#define arch_get_mmap_base(addr, base)				\
+({								\
+	unsigned long mmap_base;				\
+	typeof(addr) _addr = (addr);				\
+	typeof(base) _base = (base);				\
+	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
+	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+		mmap_base = (_base);				\
+	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
+		mmap_base = VA_USER_SV57 - rnd_gap;		\
+	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
+		mmap_base = VA_USER_SV48 - rnd_gap;		\
+	else							\
+		mmap_base = VA_USER_SV39 - rnd_gap;		\
+	mmap_base;						\
+})
+
+#else
+#define DEFAULT_MAP_WINDOW	TASK_SIZE
+#define STACK_TOP_MAX		TASK_SIZE
+#endif
+#define STACK_ALIGN		16
+
+#define STACK_TOP		DEFAULT_MAP_WINDOW
+
 /*
  * This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
-
-#define STACK_TOP		TASK_SIZE
 #ifdef CONFIG_64BIT
-#define STACK_TOP_MAX		TASK_SIZE_64
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN((UL(1) << MMAP_MIN_VA_BITS) / 3)
 #else
-#define STACK_TOP_MAX		TASK_SIZE
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
 #endif
-#define STACK_ALIGN		16
 
 #ifndef __ASSEMBLY__
 
-- 
2.34.1

