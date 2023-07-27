Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E903765E24
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 23:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjG0V1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 17:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjG0V0z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 17:26:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1E4198A
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 14:26:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686b9920362so1138498b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690493212; x=1691098012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3MSUXAZDlHxvJw5XBpFpvl/fyG6WFk9gov0cKUKQOU=;
        b=WUyJwKJPX1jLH0ROd0fzWsfMZAkoQJ/zQofoMYk2lYdpobktAenlvABnk4JZwHpjY5
         WvDq42U+gPL5MSTDxgvDRE6dXZTLh2FU/It8UyINzwEmymclonR4Y0AOvW5Z9Q/HA+hP
         UlAqHQbkeq1NLlVumQpfaDTbUcBjZ9pc/asdJ/p2EJm3zv0/rShcn1MU94GGVB8bsh+p
         rAkAcX9PQ06tbc6DdqNHbIa9qN4MoDe9IOgqU293iqT+rn1hHXDprtEdFDmsD5goGQnb
         KHFXw3D3dfM3/81YOre3JxqvqQjO5sIPW33VQ3yHsa9UPrEKTcSMpZBUp1PjeVpohIQh
         IUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493212; x=1691098012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3MSUXAZDlHxvJw5XBpFpvl/fyG6WFk9gov0cKUKQOU=;
        b=f6XUBuOUHR0GIODcuAd7XVWOcklj0Yb+8xKXP1XbjS/p2W9/PFVI3bf/eWXgOT9Kaz
         y3BggUS8fGI99yeJG0/6d3d8OMWdUD9DERNSQK0Tv+u8OcR3GD7ET6Au26fMFnEdvGRI
         qrhzCcwWVOIiAqDqdapngy+puVnRu8g3RXX6Pa/UhsTj0XE6vJcbT5+0nFD+mhA/IOwC
         77p/jQ0ES/te9HHULX3sUn7e+9EtVQmj+W99J+qdmnCsw42miD7dWs2DZfPJttnRLOGB
         yD4iaoA999BnBYGxz5GORed6KdsrMCJ2EPfLZcgWwUD9MmsiSEJZ8ljRjzrNJBBxdW1U
         SHJQ==
X-Gm-Message-State: ABy/qLZ9tVY0Klk3GTOjgk2Hwm/blf7r5qNFLm6Stf+4+S3RUSyxjrrP
        PnBCEXiXd/q7kwJyp/EQomdliw==
X-Google-Smtp-Source: APBJJlGaUoECRIux0BUm3diAsqoj6PNZLuLLwkdpIzX5n1LpY2mGSBcBTtHRABOlgGcWfWQnA6vSiQ==
X-Received: by 2002:a05:6a21:6d87:b0:137:68c3:c86f with SMTP id wl7-20020a056a216d8700b0013768c3c86fmr324290pzb.55.1690493212471;
        Thu, 27 Jul 2023 14:26:52 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c5-20020aa78c05000000b00682562b1549sm1912312pfd.24.2023.07.27.14.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:26:52 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v8 1/4] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Date:   Thu, 27 Jul 2023 14:26:26 -0700
Message-ID: <20230727212647.4182407-2-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727212647.4182407-1-charlie@rivosinc.com>
References: <20230727212647.4182407-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/riscv/include/asm/pgtable.h   | 20 +++++++++++-
 arch/riscv/include/asm/processor.h | 52 ++++++++++++++++++++++++++----
 3 files changed, 66 insertions(+), 8 deletions(-)

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
index 75970ee2bda2..c76a1ef094a4 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -63,8 +63,26 @@
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
+
+#ifdef CONFIG_COMPAT
+#define MMAP_VA_BITS_64 ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
+#define MMAP_MIN_VA_BITS_64 ((VA_BITS >= VA_BITS_SV39) ? VA_BITS_SV39 : VA_BITS)
+#define MMAP_VA_BITS (test_thread_flag(TIF_32BIT) ? 32 : MMAP_VA_BITS_64)
+#define MMAP_MIN_VA_BITS (test_thread_flag(TIF_32BIT) ? 32 : MMAP_MIN_VA_BITS_64)
+#else
+#define MMAP_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
+#define MMAP_MIN_VA_BITS ((VA_BITS >= VA_BITS_SV39) ? VA_BITS_SV39 : VA_BITS)
+#endif
 #else
 #define VA_BITS		32
 #endif
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index c950a8d9edef..e810244ea951 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,19 +13,59 @@
 
 #include <asm/ptrace.h>
 
+#ifdef CONFIG_64BIT
+#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
+#define STACK_TOP_MAX		TASK_SIZE_64
+
+#define arch_get_mmap_end(addr, len, flags)	\
+({	\
+	unsigned long mmap_end;	\
+	typeof(addr) _addr = (addr); \
+	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT))) \
+		mmap_end = DEFAULT_MAP_WINDOW;	\
+	else if ((_addr) >= VA_USER_SV57)	\
+		mmap_end = STACK_TOP_MAX;	\
+	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48))	\
+		mmap_end = VA_USER_SV48;	\
+	else	\
+		mmap_end = VA_USER_SV39;	\
+	mmap_end;	\
+})
+
+#define arch_get_mmap_base(addr, base) \
+({ \
+	unsigned long mmap_base; \
+	typeof(addr) _addr = (addr); \
+	typeof(base) _base = (base); \
+	unsigned long rnd_gap = (_base) - DEFAULT_MAP_WINDOW; \
+	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT))) \
+		mmap_base = (_base); \
+	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
+		mmap_base = VA_USER_SV57 + rnd_gap; \
+	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
+		mmap_base = VA_USER_SV48 + rnd_gap; \
+	else \
+		mmap_base = VA_USER_SV39 + rnd_gap; \
+	mmap_base; \
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
2.41.0

