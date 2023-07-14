Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54114752E2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 02:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjGNAO6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 20:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjGNAO5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 20:14:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8C82735
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 17:14:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666e6541c98so1301405b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 17:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689293694; x=1689898494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaOlsfnVfuDi3L0JPH/BTa+gkm3/5AuBwRdskT34l3o=;
        b=AL3kuhM3H/KioO8nbvBIAHfJSh0ylMITN2V1WGhpPItpZGNPicIwiuWqPGD+7VoS0z
         9FGlE1CgfAh8cjmYagx4MRN+8wl2lQ+QACCOgOXgGwch30R34LbpdjmgbsCbRm7/1+qS
         5lQgBLaufmp7hE48Kz0gDSHhxzktORPOkcKaw+5sYuu2JixEoI9KNU/qSO4KHEMkTjk7
         2AO7O4PH5DOiBbl9tv04KSv9dDiZGCL5Ttk+UHhDWqky0jutHbNrNoKDBlqyG+gjhLA4
         +CaqYrjt2lGBjIIpu0YFmeiHh6e2hCPllmikOwdH4S53O2RezlO9/m1MwSgzi3xPi/3n
         gFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689293694; x=1689898494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaOlsfnVfuDi3L0JPH/BTa+gkm3/5AuBwRdskT34l3o=;
        b=MQ8i/G0SuS81PhKL/GlUU0G2Y4DWfSBnnIjNs0eTpd7RPGPTItqG4xVNdp/h1ivdfJ
         nl00VmN8mWU8prKznTS5DJUs4JpywzPOynySZkOAYqJqioDFkc1/4esIRSB+D175xBDf
         phjcrUoJUc08mvoYDSCmN5fT+9ygmlkvPWLRwvUdVRHW5AewWww2HRI96yeKb+6fhcYq
         UgKA0t+5A1yL2RtAK3PMkSLm22iZKehq3CwMRukz/W+ClOQpmQjAT//A2ZawVriyTwRq
         aD3aNwK4IxbObUiabHZX91xPefwOu5l7Venhl0ZBystA6ZGI/LKZ9AGXaXMiZ2ANj64F
         iO2A==
X-Gm-Message-State: ABy/qLbF6lt/OHE0eNeqBYAkf+58DSd+ROjIwKip5zjJ7I4isAL1vRZq
        o3t5Ae3/9wF25qa5Jbt263YwlA==
X-Google-Smtp-Source: APBJJlEm0y+XwN1HcIrD1Y1SpQoPIoi8ZkhnjBzIMT1G9MQroevPWLioJkyh+pJ5J18N+bgxMtKKmg==
X-Received: by 2002:a05:6a00:23d1:b0:667:e17e:85b7 with SMTP id g17-20020a056a0023d100b00667e17e85b7mr4000094pfc.1.1689293694212;
        Thu, 13 Jul 2023 17:14:54 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x25-20020aa793b9000000b00673e652985esm5938107pff.44.2023.07.13.17.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 17:14:53 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v5 1/4] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Date:   Thu, 13 Jul 2023 17:14:00 -0700
Message-ID: <20230714001430.75798-2-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714001430.75798-1-charlie@rivosinc.com>
References: <20230714001430.75798-1-charlie@rivosinc.com>
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
index 6fb8bbec8459..d889dabada46 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -12,20 +12,52 @@
 
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

