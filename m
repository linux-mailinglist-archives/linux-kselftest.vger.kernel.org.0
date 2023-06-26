Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE673EA03
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjFZSm2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjFZSmV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 14:42:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA7E75
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 11:42:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1b80b343178so7044355ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687804937; x=1690396937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sH+Wgq7qee9mtA5bUr48f+V2rObrYAubOQ/hBwHBBAk=;
        b=5jOcJbYgURyb3J6wys4kHRocknTCyFf9DmYKXPI6WWwFeH+IzDzf8V7qBxgAk6QiFe
         ZICQr2wByw+QIh2YHTfcNCq9n0qjNOw4Ux1PdpIGnxS0bNO3kHmjjtSB1dN2tW8zrD5m
         MfqhEyFNRJ5XVCFouju9OuMkzzH9kI0/ofGhS8pMKE/DJE4cmqIrUQFr+C66H6LQg0ll
         kdWhcs0rTAwl1+SQiKOCLt5XPDSIMd3AyVGP9SQBZRTSOLy5fRGduX0thzH4ORM8A8yV
         W0nWciMAD0ErUCdeiyqpQ+3+G2wl/KtPYyBuHHtI8gdcF7FOmPHxAvvYu7IUinmCM7Ai
         IILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687804937; x=1690396937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sH+Wgq7qee9mtA5bUr48f+V2rObrYAubOQ/hBwHBBAk=;
        b=NLPYYkDwIgYxMgaL6SnFTGHDm+rCjWGgicPUEmZfY6lokQD4X+HAnZlSO3cBJbX2gA
         l2iQWJwvZBX8tx2NP25j8opcUhCBQ0bbj8067rBudCqgzcbMuTKJ2XsxodkPGNObwBPj
         1jiw+esk16G7K6NsYPZM1eagaV243SlAXN+nhQfngZ4ceQniuki5ta6YyNKQmk7r5aSb
         POA4Vq/2GPNbdF6GAyqf77GCG8g8Y6y5u12BB8gLH/iNfyI1wDi4xGeOxBt7ZmYX+I1Y
         6u6bhRn7Wu+wUUyJW4dZjWjaucYTSbKEsTPcE6QbC6AXj2/9fhxVc/zT6KdabpiPP+H+
         oEkA==
X-Gm-Message-State: AC+VfDztT+uoV+9HA1Q46qqcRmmPMYTcFVMUPhejc+YP1Ae7cK2gTv73
        8eG/eL+odFqzx34MHAlbR44rQw==
X-Google-Smtp-Source: ACHHUZ7GAK2YSHgB1Pfl7VnnRZIXnXSTX8LZ1n4BLxAfd60w8XE6TD9SeBhk2ADjGleoRlERF2HeNw==
X-Received: by 2002:a17:903:1250:b0:1b5:3c7f:1b3b with SMTP id u16-20020a170903125000b001b53c7f1b3bmr6938892plh.35.1687804936989;
        Mon, 26 Jun 2023 11:42:16 -0700 (PDT)
Received: from ghost.hq.rivosinc.com ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y6-20020a1709029b8600b001b682336f66sm4499842plp.55.2023.06.26.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:42:16 -0700 (PDT)
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
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        David Hildenbrand <david@redhat.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Evan Green <evan@rivosinc.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-mm@kvack.org (open list:EXEC & BINFMT API),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH 2/2] RISC-V: mm: Update documentation and include test
Date:   Mon, 26 Jun 2023 11:36:04 -0700
Message-Id: <20230626183611.40479-3-charlie@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626183611.40479-1-charlie@rivosinc.com>
References: <20230626183611.40479-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add documentation explaining the behavior of mmap. Include
a simple test that ensures that mmap returns an address less
than the hint address while there are still addresses available.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/riscv/vm-layout.rst             | 20 ++++++++
 arch/riscv/include/asm/pgtable.h              |  8 +--
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/mm/Makefile     | 22 +++++++++
 .../selftests/riscv/mm/testcases/mmap.c       | 49 +++++++++++++++++++
 5 files changed, 97 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index 5462c84f4723..365a481be90b 100644
--- a/Documentation/riscv/vm-layout.rst
+++ b/Documentation/riscv/vm-layout.rst
@@ -133,3 +133,23 @@ RISC-V Linux Kernel SV57
    ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules, BPF
    ffffffff80000000 |  -2     GB | ffffffffffffffff |    2 GB | kernel
   __________________|____________|__________________|_________|____________________________________________________________
+
+
+Userspace VAs
+--------------------
+To maintain compatibility with software that relies on the VA space
+with a maximum of 39-bits, the kernel will, by default, return virtual
+return virtual addresses to userspace from a 39-bit range.
+
+Software can "opt-in" to receiving VAs from other VA space by providing
+a hint address to mmap. A call to mmap is guaranteed to return an address
+that will not override the unset left-aligned bits in the hint address,
+unless there is no space left in the address space. If there is no space
+available in the requested address space, an address in the next smallest
+available address space will be returned.
+
+For example, in order to obtain 48-bit VA space, a hint address greater than
+:code:`1 << 38` must be provided. Note that this is 38 due to sv39 userspace
+ending at :code:`1 << 38` with the addresses beyond this and up to :code:`1 << 39`
+being reserved for the kernel. Similarly, to obtain 57-bit VA space addresses, a
+hint address greater than or equal to :code:`1 << 47` must be provided.
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e83912e97870..93e7233d5d2a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -841,14 +841,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  * Task size is:
- * -     0x9fc00000 (~2.5GB) for RV32.
- * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
- * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
+ * -        0x9fc00000	(~2.5GB) for RV32.
+ * -      0x4000000000	( 256GB) for RV64 using SV39 mmu
+ * -    0x800000000000	( 128TB) for RV64 using SV48 mmu
+ * - 0x100000000000000	(  64PB) for RV64 using SV57 mmu
  *
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
  * Instruction Set Manual Volume II: Privileged Architecture" states that
  * "load and store effective addresses, which are 64bits, must have bits
  * 63–48 all equal to bit 47, or else a page-fault exception will occur."
+ * Similarly for SV57, bits 63–57 must be equal to bit 56.
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 32a72902d045..0fee58f990ae 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= hwprobe
+RISCV_SUBTARGETS ?= hwprobe mm
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
new file mode 100644
index 000000000000..4aadf04401db
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 ARM Limited
+# Originally tools/testing/selftests/arm64/signal
+
+# Additional include paths needed by kselftest.h and local headers
+CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+
+SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
+PROGS := $(patsubst %.c,%,$(SRCS))
+
+# Generated binaries to be installed by top KSFT script
+TEST_GEN_PROGS := $(notdir $(PROGS))
+
+# Get Kernel headers installed and use them.
+
+# Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
+# to account for any OUTPUT target-dirs optionally provided by
+# the toplevel makefile
+include ../../lib.mk
+
+$(TEST_GEN_PROGS): $(PROGS)
+	cp $(PROGS) $(OUTPUT)/
\ No newline at end of file
diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap.c b/tools/testing/selftests/riscv/mm/testcases/mmap.c
new file mode 100644
index 000000000000..aa37a623b93f
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/testcases/mmap.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/mman.h>
+#include "../../kselftest_harness.h"
+
+TEST(sv57_test)
+{
+		// Only works on 64 bit
+		#if __riscv_xlen == 64
+		// Place all of the hint addresses on the boundaries of mmap
+		// sv39, sv48, sv57
+		// User addresses end at 1<<38, 1<<47, 1<<56 respectively
+		void *on_37_bits = (void *) (1UL << 37);
+		void *on_38_bits = (void *) (1UL << 38);
+		void *on_46_bits = (void *) (1UL << 46);
+		void *on_47_bits = (void *) (1UL << 47);
+		void *on_55_bits = (void *) (1UL << 55);
+		void *on_56_bits = (void *) (1UL << 56);
+
+		int prot = PROT_READ | PROT_WRITE;
+		int flags = MAP_PRIVATE | MAP_ANONYMOUS;
+
+		int *no_hint = mmap(NULL, 5*sizeof(int), prot, flags, 0, 0);
+		int *on_37_addr = mmap(on_37_bits, 5*sizeof(int), prot, flags, 0, 0);
+		int *on_38_addr = mmap(on_38_bits, 5*sizeof(int), prot, flags, 0, 0);
+		int *on_46_addr = mmap(on_46_bits, 5*sizeof(int), prot, flags, 0, 0);
+		int *on_47_addr = mmap(on_47_bits, 5*sizeof(int), prot, flags, 0, 0);
+		int *on_55_addr = mmap(on_55_bits, 5*sizeof(int), prot, flags, 0, 0);
+		int *on_56_addr = mmap(on_56_bits, 5*sizeof(int), prot, flags, 0, 0);
+
+		EXPECT_NE(no_hint, MAP_FAILED);
+		EXPECT_NE(on_37_addr, MAP_FAILED);
+		EXPECT_NE(on_38_addr, MAP_FAILED);
+		EXPECT_NE(on_46_addr, MAP_FAILED);
+		EXPECT_NE(on_47_addr, MAP_FAILED);
+		EXPECT_NE(on_55_addr, MAP_FAILED);
+		EXPECT_NE(on_56_addr, MAP_FAILED);
+
+		EXPECT_LT((unsigned long) no_hint, 1UL << 38);
+		EXPECT_LT((unsigned long) on_37_addr, 1UL << 38);
+		EXPECT_LT((unsigned long) on_38_addr, 1UL << 38);
+		EXPECT_LT((unsigned long) on_46_addr, 1UL << 38);
+		EXPECT_LT((unsigned long) on_47_addr, 1UL << 47);
+		EXPECT_LT((unsigned long) on_55_addr, 1UL << 47);
+		EXPECT_LT((unsigned long) on_56_addr, 1UL << 57);
+		#else
+		#endif
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1

