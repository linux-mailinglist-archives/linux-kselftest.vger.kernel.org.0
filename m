Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8854C754003
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjGNQz7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjGNQz6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:55:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2AD3594
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 09:55:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad8383faso16248515ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689353756; x=1689958556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPykY2M+iBxgnfF3tLWI+OoGLznOreuMykVpzGzQM9M=;
        b=azZgM6AeXJmCDZjMcCvpOfGXYgGHNCAAPxNXV/uspW22hdXFA8MPuhazigJp0SbCJS
         8tx99+fKEiCI1J31eTc92ZC6uoPPCBIEWn85byNxcOtC1TFjaiCPLzerJL2mujp5NPfe
         tcQkn3YgmIUEukMMAzAC+lS3FOWn7t2WGAWBaQbDxJ7F45liY/U120jgK6dSI82+FFGs
         cKJ+9Jrz+roxSXvXdpvhnZk6b+RrV4+d7dKzXAd2+9hgjhFiAUVDWsWNow2J0tlknkrp
         iXnusxEZA6uchq9Zw64fmDJgWEo8vBJlNrD/7xa/Q9WtmFrZU5dJZpb8ZTdqxtsXQj5e
         IR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689353756; x=1689958556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPykY2M+iBxgnfF3tLWI+OoGLznOreuMykVpzGzQM9M=;
        b=aUwPmI/yp/57OSD/RHpIZBOr+Y7peaMXLzG4nq3CHOB1AxV5u3mq/WkiWWN+jkEruv
         ckfqtxf6eVH0Vssn7Zmq/Kwfsofmerl6nwEbVliDkHzMI730LY67pCruatKZRzahAG1r
         qVzaZ+/ivZdy4Kg1CTDS+p0hsjgKBj0x/KsojttM3DmRc0AYxyMmX1/aKHSsXCyDNT68
         4XCTjso4itRUS5XxsMXQ8lEDZKTDcCHFSHCAUjdEYiDktbeVfLVKuYeHSWAOw3SEvP/A
         0QCTDxGIRayXeefIhZyAP4ehCWgvWu4q4dbWLUl2PO4SS/lh6OUJQf7lYIbMb649VUuI
         vj8w==
X-Gm-Message-State: ABy/qLaIh5m5jkbCU294KKpFsdC7dHC1xGcsP/TOPId+bf67ACdM68aZ
        xcugopyI1TieHnSKoWwenjFeHg==
X-Google-Smtp-Source: APBJJlEDGSDEGOdKDXhmmtq/RjWdYGrULh2CJQYPjEZOW+WH3IqJ8qF98vsQhnn68tlVv8hSzAc2BA==
X-Received: by 2002:a17:902:e5c2:b0:1b8:4f92:565e with SMTP id u2-20020a170902e5c200b001b84f92565emr5737152plf.21.1689353756696;
        Fri, 14 Jul 2023 09:55:56 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902b18800b001b694140d96sm8008081plr.170.2023.07.14.09.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:55:56 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v6 1/4] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Date:   Fri, 14 Jul 2023 09:54:49 -0700
Message-ID: <20230714165508.94561-2-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714165508.94561-1-charlie@rivosinc.com>
References: <20230714165508.94561-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 arch/riscv/include/asm/pgtable.h   | 12 +++++++-
 arch/riscv/include/asm/processor.h | 46 +++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 9 deletions(-)

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
index 75970ee2bda2..e13f5872bfe9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -63,12 +63,22 @@
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
 
+#define MMAP_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
+
 #define VMEMMAP_SHIFT \
 	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
 #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index c950a8d9edef..14a5396eed3d 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,20 +13,52 @@
 
 #include <asm/ptrace.h>
 
-/*
- * This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
-
-#define STACK_TOP		TASK_SIZE
 #ifdef CONFIG_64BIT
+#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE_64
+
+#define arch_get_mmap_end(addr, len, flags)	\
+({	\
+	unsigned long mmap_end;	\
+	if ((addr) >= VA_USER_SV57)	\
+		mmap_end = STACK_TOP_MAX;	\
+	else if ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48))	\
+		mmap_end = VA_USER_SV48;	\
+	else if ((addr) == 0)	\
+		mmap_end = DEFAULT_MAP_WINDOW;	\
+	else	\
+		mmap_end = VA_USER_SV39;	\
+	mmap_end;	\
+})
+
+#define arch_get_mmap_base(addr, base)	\
+({	\
+	unsigned long mmap_base;	\
+	if (((addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57))	\
+		mmap_base = (base) + (VA_USER_SV57 - DEFAULT_MAP_WINDOW);	\
+	else if ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48))	\
+		mmap_base = (base) + (VA_USER_SV48 - DEFAULT_MAP_WINDOW);	\
+	else if ((addr) == 0)	\
+		mmap_base = (base);	\
+	else	\
+		mmap_base = (base) + (VA_USER_SV39 - DEFAULT_MAP_WINDOW);	\
+	mmap_base;	\
+})
+
 #else
+#define DEFAULT_MAP_WINDOW	TASK_SIZE
 #define STACK_TOP_MAX		TASK_SIZE
 #endif
 #define STACK_ALIGN		16
 
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
2.41.0

