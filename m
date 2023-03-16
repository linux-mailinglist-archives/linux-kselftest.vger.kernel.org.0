Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765516BC468
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 04:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCPDSE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 23:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCPDR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 23:17:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78867968D0;
        Wed, 15 Mar 2023 20:17:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so234524pjt.5;
        Wed, 15 Mar 2023 20:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678936669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmS3mLL3nzfQ8o/6n9Sdx8zeiYCTltflGl3p0cpjpss=;
        b=l7krKmn1zdQbFi2RIltF3cUHiFq6lV2isfGFtsengHgMUYdVx8mUbEqljBXsbYxMvp
         /f+p00G996VLX29zKOXvFnro/KDKEB16EALeBj05TUU2PweYDLODQ1iuJ61Q+f9DCS3G
         saXatTgwt18hVzTlnPEn8BBJ0NDyj0roFAO3BOYrCKzmAYG2u1SeRr5L7n1gd65vSMbq
         bLKnflmHdGADVInbHj4wsuzDVTDSNoDVq6FJAmY3gHKdCtL+qgEfHa8TarAxkUbft8yT
         ZLNo8+f+XnEDU8HKgfgoILWV2zsvt8TrzLc94aW5WON/XyjyOWH7du/qCK9nF3deKLBM
         yziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678936669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmS3mLL3nzfQ8o/6n9Sdx8zeiYCTltflGl3p0cpjpss=;
        b=QaGHHMy4iYP7OHOspIRYkJ6Kad29/ZYsURuj3k4il5kSWMNq7DY5ZohA6A1UGFdbWt
         jLaUwk9TJb+ac20GKXo+s2Rkg6P93kdvHX4EDFZk3wofBGfbYQYOZMDQN/XGXuqUyy70
         x+KmUy2X2oMQJ+rvaj42pQH+hC4h5flA/lb0F96IxXlvc//7S+GYz0QtEGFFApE7m1Hy
         Ju0VYmGQO12W0QrqQEa3VflD4q6OyM6sISn6PvcJye4uylhpe8X7P8sgpkeoIk0MAGEt
         pb1mgRuBh8ah6z8Rah9ST2uXVvR+IQmgSL23GUn35DRws0Fwh4FTg1SzXHdiMtE3wUSr
         bhvA==
X-Gm-Message-State: AO0yUKV4Sr6djsqa89zJ7PHcfYpmGV7aC8GnEQlZGPkNAqoWKlc/5PlH
        yYr7Cm6VHMx2VI6RZM7JQD5+Q8KzoP+Nsg==
X-Google-Smtp-Source: AK7set8osiC8hva/4HJqzu6mLqLU057VJr6yoEbrUuhDxy4cs5OCqjqrPgVMcJQrY+dEXhONhHGS6Q==
X-Received: by 2002:a17:902:c40c:b0:19a:a815:2868 with SMTP id k12-20020a170902c40c00b0019aa8152868mr2041730plk.44.1678936668625;
        Wed, 15 Mar 2023 20:17:48 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (121-44-69-75.tpgi.com.au. [121.44.69.75])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0019a7bb18f98sm4331859plm.48.2023.03.15.20.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 20:17:48 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] KVM: PPC: Add kvm selftests support for powerpc
Date:   Thu, 16 Mar 2023 13:17:31 +1000
Message-Id: <20230316031732.3591455-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230316031732.3591455-1-npiggin@gmail.com>
References: <20230316031732.3591455-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implement KVM selftests support for Book3S-64.

ucalls are implemented with an unsuppored PAPR hcall number which causes
KVM to exit to userspace.

Virtual memory is only implemented for 64K page size and the radix MMU,
and only the base page size is supported for now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tools/testing/selftests/kvm/Makefile          |  12 +
 .../selftests/kvm/include/kvm_util_base.h     |  13 +
 .../selftests/kvm/include/powerpc/hcall.h     |  20 +
 .../selftests/kvm/include/powerpc/processor.h |  13 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  10 +
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 +++
 .../selftests/kvm/lib/powerpc/processor.c     | 355 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  30 ++
 8 files changed, 498 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 84a627c43795..081cee3ecc0c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -55,6 +55,10 @@ LIBKVM_s390x += lib/s390x/ucall.c
 LIBKVM_riscv += lib/riscv/processor.c
 LIBKVM_riscv += lib/riscv/ucall.c
 
+LIBKVM_powerpc += lib/powerpc/processor.c
+LIBKVM_powerpc += lib/powerpc/ucall.c
+LIBKVM_powerpc += lib/powerpc/hcall.c
+
 # Non-compiled test targets
 TEST_PROGS_x86_64 += x86_64/nx_huge_pages_test.sh
 
@@ -176,6 +180,14 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 
+TEST_GEN_PROGS_powerpc += demand_paging_test
+TEST_GEN_PROGS_powerpc += dirty_log_test
+TEST_GEN_PROGS_powerpc += kvm_create_max_vcpus
+TEST_GEN_PROGS_powerpc += kvm_page_table_test
+TEST_GEN_PROGS_powerpc += rseq_test
+TEST_GEN_PROGS_powerpc += set_memory_region_test
+TEST_GEN_PROGS_powerpc += kvm_binary_stats_test
+
 TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index fbc2a79369b8..f6807aea634f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -105,6 +105,7 @@ struct kvm_vm {
 	bool pgd_created;
 	vm_paddr_t ucall_mmio_addr;
 	vm_paddr_t pgd;
+	vm_paddr_t prtb; // powerpc process table
 	vm_vaddr_t gdt;
 	vm_vaddr_t tss;
 	vm_vaddr_t idt;
@@ -160,6 +161,7 @@ enum vm_guest_mode {
 	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
 	VM_MODE_P47V64_4K,
 	VM_MODE_P44V64_4K,
+	VM_MODE_P52V52_64K,
 	VM_MODE_P36V48_4K,
 	VM_MODE_P36V48_16K,
 	VM_MODE_P36V48_64K,
@@ -197,6 +199,17 @@ extern enum vm_guest_mode vm_mode_default;
 #define MIN_PAGE_SHIFT			12U
 #define ptes_per_page(page_size)	((page_size) / 8)
 
+#elif defined(__powerpc64__)
+
+/* Radix guest EA and RA are 52-bit on POWER9 and POWER10 */
+#define VM_MODE_DEFAULT			VM_MODE_P52V52_64K
+#define MIN_PAGE_SHIFT			12U /// XXX: hack to allocate more page table memory because we aren't allocating page tables well on 64K base page size
+#define ptes_per_page(page_size)	((page_size) / 8)
+
+#else
+
+#error "KVM selftests not implemented for architecture"
+
 #endif
 
 #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
new file mode 100644
index 000000000000..bbad5904f37a
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * powerpc hcall defines
+ */
+#ifndef SELFTEST_KVM_HCALL_H
+#define SELFTEST_KVM_HCALL_H
+
+#include <linux/compiler.h>
+
+/* Ucalls use unimplemented PAPR hcall 0 which exits KVM */
+#define H_UCALL	0
+#define UCALL_R4_UCALL	0x5715 // regular ucall, r5 contains ucall pointer
+#define UCALL_R4_EXCPT	0x1b0f // other exception, r5 contains vector, r6,7 SRRs
+			       // R4==0 is a simple asm exit
+
+int64_t hcall0(uint64_t token);
+int64_t hcall1(uint64_t token, uint64_t arg1);
+int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2);
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
new file mode 100644
index 000000000000..b800b565b638
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * powerpc processor specific defines
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_H
+#define SELFTEST_KVM_PROCESSOR_H
+
+#include <linux/compiler.h>
+
+struct kvm_vcpu;
+extern bool (*interrupt_handler)(struct kvm_vcpu *vcpu, unsigned trap);
+
+#endif
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3ea24a5f4c43..28ece960a0bb 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -153,6 +153,7 @@ const char *vm_guest_mode_string(uint32_t i)
 		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
 		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
 		[VM_MODE_P44V64_4K]	= "PA-bits:44,  VA-bits:64,  4K pages",
+		[VM_MODE_P52V52_64K]	= "PA-bits:52,  VA-bits:52, 64K pages",
 		[VM_MODE_P36V48_4K]	= "PA-bits:36,  VA-bits:48,  4K pages",
 		[VM_MODE_P36V48_16K]	= "PA-bits:36,  VA-bits:48, 16K pages",
 		[VM_MODE_P36V48_64K]	= "PA-bits:36,  VA-bits:48, 64K pages",
@@ -178,6 +179,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_PXXV48_4K]	= {  0,  0,  0x1000, 12 },
 	[VM_MODE_P47V64_4K]	= { 47, 64,  0x1000, 12 },
 	[VM_MODE_P44V64_4K]	= { 44, 64,  0x1000, 12 },
+	[VM_MODE_P52V52_64K]	= { 52, 52, 0x10000, 16 },
 	[VM_MODE_P36V48_4K]	= { 36, 48,  0x1000, 12 },
 	[VM_MODE_P36V48_16K]	= { 36, 48,  0x4000, 14 },
 	[VM_MODE_P36V48_64K]	= { 36, 48, 0x10000, 16 },
@@ -279,6 +281,14 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 	case VM_MODE_P44V64_4K:
 		vm->pgtable_levels = 5;
 		break;
+	case VM_MODE_P52V52_64K:
+#ifdef __powerpc__
+		TEST_ASSERT(getpagesize() == 64*1024,
+			    "KVM selftests requires 64K host page size\n");
+
+		vm->pgtable_levels = 4;
+#endif
+		break;
 	default:
 		TEST_FAIL("Unknown guest mode, mode: 0x%x", mode);
 	}
diff --git a/tools/testing/selftests/kvm/lib/powerpc/hcall.c b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
new file mode 100644
index 000000000000..23a56aabad42
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PAPR (pseries) hcall support.
+ */
+#include "kvm_util.h"
+#include "hcall.h"
+
+int64_t hcall0(uint64_t token)
+{
+	register uintptr_t r3 asm ("r3") = token;
+
+	asm volatile("sc 1" : "+r"(r3) :
+			    : "r0", "r4", "r5", "r6", "r7", "r8", "r9",
+			      "r10","r11", "r12", "ctr", "xer",
+			      "memory");
+
+	return r3;
+}
+
+int64_t hcall1(uint64_t token, uint64_t arg1)
+{
+	register uintptr_t r3 asm ("r3") = token;
+	register uintptr_t r4 asm ("r4") = arg1;
+
+	asm volatile("sc 1" : "+r"(r3), "+r"(r4) :
+			    : "r0", "r5", "r6", "r7", "r8", "r9",
+			      "r10","r11", "r12", "ctr", "xer",
+			      "memory");
+
+	return r3;
+}
+
+int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2)
+{
+	register uintptr_t r3 asm ("r3") = token;
+	register uintptr_t r4 asm ("r4") = arg1;
+	register uintptr_t r5 asm ("r5") = arg2;
+
+	asm volatile("sc 1" : "+r"(r3), "+r"(r4), "+r"(r5) :
+			    : "r0", "r6", "r7", "r8", "r9",
+			      "r10","r11", "r12", "ctr", "xer",
+			      "memory");
+
+	return r3;
+}
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
new file mode 100644
index 000000000000..df9901d629cf
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM selftest powerpc library code - CPU-related functions (page tables...)
+ */
+
+#include "processor.h"
+#include "kvm_util.h"
+#include "kvm_util_base.h"
+#include "hcall.h"
+
+#define RTS ((0x2UL << 61) | (0x5UL << 5)) // 52-bits
+#define RADIX_PGD_INDEX_SIZE 13
+
+void virt_arch_pgd_alloc(struct kvm_vm *vm)
+{
+	struct kvm_ppc_mmuv3_cfg mmu_cfg;
+	vm_paddr_t prtb, pgtb;
+	uint64_t *proc_table, *page_table;
+	size_t pgd_pages;
+
+	TEST_ASSERT(vm->mode == VM_MODE_P52V52_64K, "Attempt to use "
+		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+
+	/* If needed, create page table */
+	if (vm->pgd_created)
+		return;
+
+	prtb = vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+				 vm->memslots[MEM_REGION_PT]);
+	proc_table = addr_gpa2hva(vm, prtb);
+	memset(proc_table, 0, vm->page_size);
+	vm->prtb = prtb;
+
+	pgd_pages = 1UL << ((RADIX_PGD_INDEX_SIZE + 3) >> vm->page_shift);
+	TEST_ASSERT(pgd_pages == 1, "PGD allocation must be single page");
+	pgtb = vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+				 vm->memslots[MEM_REGION_PT]);
+	page_table = addr_gpa2hva(vm, pgtb);
+	memset(page_table, 0, vm->page_size * pgd_pages);
+	vm->pgd = pgtb;
+
+	/* Set the base page directory in the proc table */
+	proc_table[0] = cpu_to_be64(pgtb | RTS | RADIX_PGD_INDEX_SIZE);
+
+	mmu_cfg.process_table = prtb | 0x8000000000000000UL | 0x4; // 64K size
+	mmu_cfg.flags = KVM_PPC_MMUV3_RADIX | KVM_PPC_MMUV3_GTSE;
+
+	vm_ioctl(vm, KVM_PPC_CONFIGURE_V3_MMU, &mmu_cfg);
+
+	vm->pgd_created = true;
+}
+
+static int pt_shift(struct kvm_vm *vm, int level)
+{
+	switch (level) {
+	case 1:
+		return 13;
+	case 2:
+	case 3:
+		return 9;
+	case 4:
+		return 5;
+	default:
+		TEST_ASSERT(false, "Invalid page table level %d\n", level);
+		return 0;
+	}
+}
+
+static uint64_t pt_entry_coverage(struct kvm_vm *vm, int level)
+{
+	uint64_t size = vm->page_size;
+
+	if (level == 4)
+		return size;
+	size <<= pt_shift(vm, 4);
+	if (level == 3)
+		return size;
+	size <<= pt_shift(vm, 3);
+	if (level == 2)
+		return size;
+	size <<= pt_shift(vm, 2);
+	return size;
+}
+
+static int pt_idx(struct kvm_vm *vm, uint64_t vaddr, int level, uint64_t *nls)
+{
+	switch (level) {
+	case 1:
+		*nls = 0x9;
+		return (vaddr >> 39) & 0x1fff;
+	case 2:
+		*nls = 0x9;
+		return (vaddr >> 30) & 0x1ff;
+	case 3:
+// 4K		*nls = 0x9;
+		*nls = 0x5;
+		return (vaddr >> 21) & 0x1ff;
+	case 4:
+// 4K		return (vaddr >> 12) & 0x1ff;
+		return (vaddr >> 16) & 0x1f;
+	default:
+		TEST_ASSERT(false, "Invalid page table level %d\n", level);
+		return 0;
+	}
+}
+
+static uint64_t *virt_get_pte(struct kvm_vm *vm, vm_paddr_t pt,
+			  uint64_t vaddr, int level, uint64_t *nls)
+{
+	uint64_t *page_table = addr_gpa2hva(vm, pt);
+	int idx = pt_idx(vm, vaddr, level, nls);
+
+	return &page_table[idx];
+}
+
+#define PTE_VALID	0x8000000000000000ull
+#define PTE_LEAF	0x4000000000000000ull
+#define PTE_REFERENCED	0x0000000000000100ull
+#define PTE_CHANGED	0x0000000000000080ull
+#define PTE_PRIV	0x0000000000000008ull
+#define PTE_READ	0x0000000000000004ull
+#define PTE_RW		0x0000000000000002ull
+#define PTE_EXEC	0x0000000000000001ull
+#define PTE_PAGE_MASK	0x01fffffffffff000ull
+
+#define PDE_VALID	PTE_VALID
+#define PDE_NLS		0x0000000000000011ull
+#define PDE_PT_MASK	0x0fffffffffffff00ull
+
+void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
+{
+	vm_paddr_t pt = vm->pgd;
+	uint64_t *ptep, pte;
+	int level;
+
+	for (level = 1; level <= 3; level++) {
+		uint64_t nls;
+		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		uint64_t pde = be64_to_cpu(*pdep);
+		uint64_t *page_table;
+
+		if (pde) {
+			TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
+				"Invalid PDE at level: %u gva: 0x%lx pde:0x%lx\n",
+				level, gva, pde);
+			pt = pde & PDE_PT_MASK;
+			continue;
+		}
+
+		// XXX: 64K geometry does not require full pages!
+		pt = vm_phy_page_alloc(vm,
+				       KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+				       vm->memslots[MEM_REGION_PT]);
+		page_table = addr_gpa2hva(vm, pt);
+		memset(page_table, 0, vm->page_size);
+		pde = PDE_VALID | nls | pt;
+		*pdep = cpu_to_be64(pde);
+	}
+
+	ptep = virt_get_pte(vm, pt, gva, level, NULL);
+	pte = be64_to_cpu(*ptep);
+
+	TEST_ASSERT(!pte,
+		"PTE already present at level: %u gva: 0x%lx pte:0x%lx\n",
+		level, gva, pte);
+
+	pte = PTE_VALID | PTE_LEAF | PTE_REFERENCED | PTE_CHANGED | PTE_PRIV | PTE_READ | PTE_RW | PTE_EXEC | (gpa & PTE_PAGE_MASK);
+	*ptep = cpu_to_be64(pte);
+}
+
+vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
+{
+	vm_paddr_t pt = vm->pgd;
+	uint64_t *ptep, pte;
+	int level;
+
+	for (level = 1; level <= 3; level++) {
+		uint64_t nls;
+		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		uint64_t pde = be64_to_cpu(*pdep);
+
+		TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
+			"PDE not present at level: %u gva: 0x%lx pde:0x%lx\n",
+			level, gva, pde);
+		pt = pde & PDE_PT_MASK;
+	}
+
+	ptep = virt_get_pte(vm, pt, gva, level, NULL);
+	pte = be64_to_cpu(*ptep);
+
+	TEST_ASSERT(pte,
+		"PTE not present at level: %u gva: 0x%lx pte:0x%lx\n",
+		level, gva, pte);
+
+	TEST_ASSERT((pte & PTE_VALID) && (pte & PTE_LEAF) && (pte & PTE_READ) && (pte & PTE_RW) && (pte & PTE_EXEC),
+		"PTE not valid at level: %u gva: 0x%lx pte:0x%lx\n",
+		level, gva, pte);
+
+	return (pte & PTE_PAGE_MASK) + (gva & (vm->page_size - 1));
+}
+
+static void virt_arch_dump_pt(FILE *stream, struct kvm_vm *vm, vm_paddr_t pt, vm_vaddr_t va, int level, uint8_t indent)
+{
+	uint64_t *page_table;
+	int size, idx;
+
+	page_table = addr_gpa2hva(vm, pt);
+	size = 1U << pt_shift(vm, level);
+	for (idx = 0; idx < size; idx++) {
+		uint64_t pte = be64_to_cpu(page_table[idx]);
+		if (pte & PTE_VALID) {
+			if (pte & PTE_LEAF) {
+				fprintf(stream, "%*sgVA:0x%016lx -> gRA:0x%016llx\n", indent, "", va, pte & PTE_PAGE_MASK);
+			} else {
+				virt_arch_dump_pt(stream, vm, pte & PDE_PT_MASK, va, level + 1, indent);
+			}
+		}
+		va += pt_entry_coverage(vm, level);
+	}
+
+}
+
+void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+{
+	vm_paddr_t pt = vm->pgd;
+
+	if (!vm->pgd_created)
+		return;
+
+	virt_arch_dump_pt(stream, vm, pt, 0, 1, indent);
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  void *guest_code)
+{
+	size_t stack_size =  64*1024;
+	uint64_t stack_vaddr;
+	struct kvm_regs regs;
+	struct kvm_vcpu *vcpu;
+	uint64_t lpcr;
+
+	TEST_ASSERT(vm->page_size == 64*1024, "Unsupported page size: 0x%x",
+		    vm->page_size);
+
+	stack_vaddr = __vm_vaddr_alloc(vm, stack_size,
+				       DEFAULT_GUEST_STACK_VADDR_MIN,
+				       MEM_REGION_DATA);
+
+	vcpu = __vm_vcpu_add(vm, vcpu_id);
+
+	vcpu_enable_cap(vcpu, KVM_CAP_PPC_PAPR, 1);
+
+	/* Setup guest registers */
+	vcpu_regs_get(vcpu, &regs);
+	vcpu_get_reg(vcpu, KVM_REG_PPC_LPCR_64, &lpcr);
+
+	regs.pc = (uintptr_t)guest_code;
+	regs.gpr[12] = (uintptr_t)guest_code;
+	regs.msr = 0x8000000002103032ull;
+	regs.gpr[1] = stack_vaddr + stack_size - 256;
+
+	if (BYTE_ORDER == LITTLE_ENDIAN) {
+		regs.msr |= 0x1; // LE
+		lpcr |= 0x0000000002000000; // ILE
+	} else {
+		lpcr &= ~0x0000000002000000; // !ILE
+	}
+
+	vcpu_regs_set(vcpu, &regs);
+	vcpu_set_reg(vcpu, KVM_REG_PPC_LPCR_64, lpcr);
+
+	return vcpu;
+}
+
+void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
+{
+	va_list ap;
+	struct kvm_regs regs;
+	int i;
+
+	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
+		    "  num: %u\n",
+		    num);
+
+	va_start(ap, num);
+	vcpu_regs_get(vcpu, &regs);
+
+	for (i = 0; i < num; i++)
+		regs.gpr[i + 3] = va_arg(ap, uint64_t);
+
+	vcpu_regs_set(vcpu, &regs);
+	va_end(ap);
+}
+
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
+{
+	struct kvm_regs regs;
+
+	vcpu_regs_get(vcpu, &regs);
+
+	fprintf(stream, "%*sNIA: 0x%016llx  MSR: 0x%016llx\n", indent, "", regs.pc, regs.msr);
+	fprintf(stream, "%*sLR:  0x%016llx  CTR :0x%016llx\n", indent, "", regs.lr, regs.ctr);
+	fprintf(stream, "%*sCR:  0x%08llx          XER :0x%016llx\n", indent, "", regs.cr, regs.xer);
+}
+
+void kvm_arch_vm_post_create(struct kvm_vm *vm)
+{
+	uint32_t stub[] = {
+		0x38600000,		     // li	r3,0
+		0x38800000 | UCALL_R4_EXCPT, // li	r4,UCALL_R4_EXCPT
+		0x38a00000,		     // li	r5,0
+		0x7cda02a6,		     // mfspr	r5,SRR0
+		0x7cfb02a6,		     // mfspr	r6,SRR1
+		0x44000022,		     // sc	1
+	};
+	void *mem;
+	int i;
+
+	vm_paddr_t excp_paddr = vm_phy_page_alloc(vm, 0,
+				 vm->memslots[MEM_REGION_DATA]);
+	TEST_ASSERT(excp_paddr == 0, "excp_paddr = 0x%lx\n", excp_paddr);
+
+	mem = addr_gpa2hva(vm, excp_paddr);
+
+	/* Fill with branch-to-self so SRR0/1 don't get lost */
+	/* XXX: this requires 2 pages on 4K */
+	for (i = 0x100; i < 0x2000; i += 0x20) {
+		stub[2] = 0x38a00000 | i;	// li	r5,i
+		memcpy(mem + i, stub, sizeof(stub));
+	}
+}
+
+bool (*interrupt_handler)(struct kvm_vcpu *vcpu, unsigned trap);
+
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_regs regs;
+
+	if (!(run->exit_reason == KVM_EXIT_PAPR_HCALL &&
+	    run->papr_hcall.nr == H_UCALL)) {
+		return;
+	}
+	vcpu_regs_get(vcpu, &regs);
+	if (regs.gpr[4] != UCALL_R4_EXCPT)
+		return;
+
+	if (interrupt_handler) {
+		if (interrupt_handler(vcpu, regs.gpr[5]))
+			return; // handled
+	}
+
+	TEST_FAIL("Unhandled exception 0x%llx at NIA:0x%016llx MSR:0x%016llx\n",
+			regs.gpr[5], regs.gpr[6], regs.gpr[7]);
+}
diff --git a/tools/testing/selftests/kvm/lib/powerpc/ucall.c b/tools/testing/selftests/kvm/lib/powerpc/ucall.c
new file mode 100644
index 000000000000..ce0ddde45fef
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/ucall.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ucall support. A ucall is a "hypercall to host userspace".
+ */
+#include "kvm_util.h"
+#include "hcall.h"
+
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
+{
+}
+
+void ucall_arch_do_ucall(vm_vaddr_t uc)
+{
+	hcall2(H_UCALL, UCALL_R4_UCALL, (uintptr_t)(uc));
+}
+
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+
+	if (run->exit_reason == KVM_EXIT_PAPR_HCALL &&
+	    run->papr_hcall.nr == H_UCALL) {
+		struct kvm_regs regs;
+
+		vcpu_regs_get(vcpu, &regs);
+		if (regs.gpr[4] == UCALL_R4_UCALL)
+			return (void *)regs.gpr[5];
+	}
+	return NULL;
+}
-- 
2.37.2

