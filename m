Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F35B77508A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 03:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjHIBxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 21:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjHIBxJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 21:53:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C851BCE
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 18:53:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbc06f830aso3346175ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 18:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691545988; x=1692150788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS9t1IQslP2lZOcFIMMBEvL86hG9xRW12aLXbO27oNk=;
        b=Z+OB3UIxb6UJl4LqG4lOl8uoEklqlYBf9fFwC0SMsGtkHV738p4LE/eBRuGJp3a7UL
         wiCEXG/nMIuiiOQ7dHYWcDcYDiZ0ZcWXZQ1pgmZ/9o7/7EIhMFgNACuq5EWyHaQJ3Z7E
         G6kwf7AbrVK8ofW7juhqT77yDPEbZow9W3sjyhQnYVmRcEDxZmUSGarbtD1I7I3ufInS
         hpDnZmswCg7wHzP7gZzoJ4bbO4uBGnuWGbFO0kEtksOZCBlotH47BAkIcT5zEnw+UIYM
         X6/5ndgr/c496H7frfwd+bRtqm0VeHE4I0TmM4v7PHuRHDwdflAx5jyymiQ36NBcmSnr
         I07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691545988; x=1692150788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS9t1IQslP2lZOcFIMMBEvL86hG9xRW12aLXbO27oNk=;
        b=iQZNqYZLO+y26KYZGN0/IGva8cvQy8Ps0Pq9dN9l1xByEGtxna7t1EcGBK/G/Y25Hf
         MlpQ5RSufnqQ/TAZL4UdlFS2QESjODL5jIFc02On0sab8f/q3hCHMe86llxjL5Zp7XF6
         /n4eN2+JNLxIF+/WuHH+esgCbZXV1TYo5TJHNK72Tm/SmPcXFc1TG/OyTHzf/uFV7el/
         JxfI8QzAsZ482dcS7JAqX4wN4LKDshbzaM5IE1/3FfXm4RV6zynomfwyA1a/3tOtef2w
         yLjhdRk1XZ5RFphhKPjh4hjarzb/xPyJbpzXoovq9aBRY2a2GYRZ6JzvSHH2oRp+mwfn
         Wk9Q==
X-Gm-Message-State: AOJu0YzcidK7gWYbnYMp3Xkwua6amLUaVfX/u7V2nqu0qoKTEYumLEwp
        exfE7F5NuLflhBTxNua3XAt9vw==
X-Google-Smtp-Source: AGHT+IFhoPRNUuepUsmxYmygopTPVe56v5cNvHLyHa5Ol8fKT1Rsk8P+vvViBz+AASwbOoRW+3rwYA==
X-Received: by 2002:a17:902:d491:b0:1b0:3ab6:5140 with SMTP id c17-20020a170902d49100b001b03ab65140mr1838365plg.4.1691545987885;
        Tue, 08 Aug 2023 18:53:07 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id bj7-20020a170902850700b001b87bedcc6fsm9657591plb.93.2023.08.08.18.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:53:07 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v9 1/4] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Date:   Tue,  8 Aug 2023 18:51:07 -0700
Message-Id: <20230809015110.3290774-2-charlie@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809015110.3290774-1-charlie@rivosinc.com>
References: <20230809015110.3290774-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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
 arch/riscv/include/asm/pgtable.h   | 21 +++++++++++-
 arch/riscv/include/asm/processor.h | 52 ++++++++++++++++++++++++++----
 3 files changed, 67 insertions(+), 8 deletions(-)

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
index 75970ee2bda2..2611c1324a7c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -63,8 +63,27 @@
  * position vmemmap directly below the VMALLOC region.
  */
 #ifdef CONFIG_64BIT
+#define VA_BITS_SV32 32
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
+
+#ifdef CONFIG_COMPAT
+#define MMAP_VA_BITS_64 ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
+#define MMAP_MIN_VA_BITS_64 (VA_BITS_SV39)
+#define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
+#define MMAP_MIN_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_MIN_VA_BITS_64)
+#else
+#define MMAP_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
+#define MMAP_MIN_VA_BITS (VA_BITS_SV39)
+#endif
 #else
 #define VA_BITS		32
 #endif
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

