Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DEC73E9FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 20:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjFZSmO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 14:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjFZSmK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 14:42:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4589610B
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 11:42:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8062c1ee1so11015865ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687804927; x=1690396927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b1uVANehIH/+ZRkMH5+9QKYLvg0brFXglBZxj/Lb5k=;
        b=bybKJLkY02mGgsEHB/G5huYNAjJ+Jax7ubFmyT/xSUWJapWYrReIBV/awAq2yPQwz1
         LjHqQahv88eqfHOji66+8tfPFl2X3OukadEVM7rwzVWa7W71PJ3tsejRPYK8HD92XYpK
         CEtbGwUpvVHYqe9q0qtEHxqJLLWSrsExtBqrh3SUsJTpokBfCvMOz0DBFqRSSB5EsbcT
         IlmGArf+IWgJcsxOVMwVw7EzBLpyyhk8qSc0NOSAvY+9nWpUoJgW5HHI9wccQ8iYxmYX
         wHVJCNO/fA9k47pR/QmmfBaTg/X4rTYX1LUtNSjVDb4jvoUD8U8b1o/11Pj4TdhKwedI
         cKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687804927; x=1690396927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0b1uVANehIH/+ZRkMH5+9QKYLvg0brFXglBZxj/Lb5k=;
        b=eyj+A3PLievTla9B09W/3fB8m9smIgmk0X4pK6y/YB3rXyS+dDK/vDsaz05abfeKV5
         GdAun8/uRZhMTDpngjKXZV2MbQeIbzMo2Vj6Lr8Lbuhzpu8genCsoB6eRmWMSy6bngnm
         xDKBanAGvd5m8mX6JaAc7N2sFWRWYTjrYnHnShe9Ox0C9htympCLSPaieM1TmyO7eYgY
         HcFj81Old+pehPH0QrfNggspe9mveorR8/vtSRCPjeVTcJgsHddseMZukuJwy2rwD+n+
         gU0/2lpTG7HeWGkNpVA2Yo0cIlYWjpRBO5AGooMap+l4RSO3fZAlO9OQCOB+lt1rxo7X
         EvIA==
X-Gm-Message-State: AC+VfDzuZAIeMXs73cFJ6bh+2otXHWiR9i/44+PNz5Wg7VvyNYwewD8I
        92MZ0WvXy6A3ejYtdMtOXOmzCw==
X-Google-Smtp-Source: ACHHUZ62/G8gBs8d6kAQdaMAXiShDB+yqOiLofZ8iajX1fHC5c1IefdBrnNt+qeRN+82Vda57HyAig==
X-Received: by 2002:a17:902:e88e:b0:1b6:b40c:b022 with SMTP id w14-20020a170902e88e00b001b6b40cb022mr9499718plg.30.1687804926663;
        Mon, 26 Jun 2023 11:42:06 -0700 (PDT)
Received: from ghost.hq.rivosinc.com ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y6-20020a1709029b8600b001b682336f66sm4499842plp.55.2023.06.26.11.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:42:06 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     charlie@rivosinc.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Juergen Gross <jgross@suse.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Evan Green <evan@rivosinc.com>,
        Mark Brown <broonie@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-mm@kvack.org (open list:EXEC & BINFMT API),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH 1/2] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Date:   Mon, 26 Jun 2023 11:36:03 -0700
Message-Id: <20230626183611.40479-2-charlie@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626183611.40479-1-charlie@rivosinc.com>
References: <20230626183611.40479-1-charlie@rivosinc.com>
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

