Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D356C76DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 06:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCXFNU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 01:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCXFNT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 01:13:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F14229438;
        Thu, 23 Mar 2023 22:13:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so566811pjb.0;
        Thu, 23 Mar 2023 22:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679634797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky+3Osb3XHhCsVer+BE+PVCsvhSoKdU+o0vp//yvAHs=;
        b=H4m3JCGI7LIGYePL8iVXiJFHwmGUija+dcESiQfSmMl8qj3r3CRxrWevtsa1tIIzY6
         +cdOP+wIDy/vt/Mrp8beCkWaQBmELZtgPeu+YOS0TqYNCObCvRWFOlm13gH7jxYz2GKi
         ZLB4RYrejOkoyxJALRlxwemgHHreY5o7No6LGlRl8UoyM3DMwA+/YFqq95NQZ3hI7zDr
         4KBjkW5fHLDlEV8a2srqVXPfbTLXrOCOUufpH4oN3oWDCET6FO8u5/h+77D0I0PUVWxH
         AJACQqM+tehW/iplUJIqghZLEUiP73++D0jsfDkimKom5wK8STFRB51Roh8ZSdC4IUUm
         39eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679634797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky+3Osb3XHhCsVer+BE+PVCsvhSoKdU+o0vp//yvAHs=;
        b=P1jtLSgJDwRa7UpMF6qMWB9U+Y0TwudMXEKzOg9nJ460n5W05x4PLlxu1e96GUZM0h
         LSKsZbzVN1vDWPziSH4aBal2viWp4LHXOsYcAWJ537e55sXts/DcgMwQYxG1qhJUtvXG
         FGEuZVAk9KGGuSMK3zpO9Vc+j+OxF5oQT+ZD9iz/yGVh9TKEuhial49ZMJIkIjM4NNtE
         DYtfL7+0sOO6JVU+E9YDpvM2RbhKiJCMB2DH24oyEa/f/RxO2NOnMzX+I0drc9b1InAd
         rNGYjTDzMyNofeG3a+Ulk2IVDj3NThm1uNxjiUfznsD1ytf18ADRM1hvT5e8VXwRnUrF
         PP2g==
X-Gm-Message-State: AAQBX9eTc5frj59/Qrc1QmH4SJ39ZFibnepYnlHZ+a+uQ3Pynn+nHCTF
        cxpyF0SH6HbHLxFZDYL/ztA=
X-Google-Smtp-Source: AKy350ZDNKbaWnEgFyZZShTkYgvQy46VbezLc1G2ArMovkD0o42GKH1PXp4U0B9F6ZNff4K3cR9UZQ==
X-Received: by 2002:a17:903:1108:b0:1a1:e867:f2a7 with SMTP id n8-20020a170903110800b001a1e867f2a7mr1771519plh.22.1679634796586;
        Thu, 23 Mar 2023 22:13:16 -0700 (PDT)
Received: from bobo.ibm.com ([124.170.18.191])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b0019a70a85e8fsm13169774plb.220.2023.03.23.22.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:13:16 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: PPC: selftests: implement support for powerpc
Date:   Fri, 24 Mar 2023 15:12:53 +1000
Message-Id: <20230324051254.1894918-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230324051254.1894918-1-npiggin@gmail.com>
References: <20230324051254.1894918-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implement KVM selftests support for powerpc (Book3S-64).

ucalls are implemented with an unsuppored PAPR hcall number which causes
KVM to exit to userspace.

Virtual memory is only implemented for 64K page size and the radix MMU,
and only the base page size is supported for now.

Guest interrupt handlers run in real-mode so require a real-mode page at
gRA 0 and require a bit of juggling around because gVA:gRA is not 1:1
mapped like the kernel has, so we can't just switch MMU on and off.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tools/testing/selftests/kvm/Makefile          |  13 +
 .../selftests/kvm/include/kvm_util_base.h     |  13 +
 .../selftests/kvm/include/powerpc/hcall.h     |  20 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  17 +
 .../selftests/kvm/include/powerpc/processor.h |  32 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  10 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  96 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 411 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  30 ++
 tools/testing/selftests/kvm/powerpc/helpers.h |  46 ++
 11 files changed, 733 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
 create mode 100644 tools/testing/selftests/kvm/powerpc/helpers.h

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 84a627c43795..908602a9f513 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -55,6 +55,11 @@ LIBKVM_s390x += lib/s390x/ucall.c
 LIBKVM_riscv += lib/riscv/processor.c
 LIBKVM_riscv += lib/riscv/ucall.c
 
+LIBKVM_powerpc += lib/powerpc/handlers.S
+LIBKVM_powerpc += lib/powerpc/processor.c
+LIBKVM_powerpc += lib/powerpc/ucall.c
+LIBKVM_powerpc += lib/powerpc/hcall.c
+
 # Non-compiled test targets
 TEST_PROGS_x86_64 += x86_64/nx_huge_pages_test.sh
 
@@ -176,6 +181,14 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
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
index 000000000000..4eb9ad635402
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
+#define UCALL_R4_SIMPLE	0x0000 // simple exit usable by asm with no ucall data
+
+int64_t hcall0(uint64_t token);
+int64_t hcall1(uint64_t token, uint64_t arg1);
+int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2);
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/ppc_asm.h b/tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
new file mode 100644
index 000000000000..f6ba8db6a19e
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * powerpc asm specific defines
+ */
+#ifndef SELFTEST_KVM_PPC_ASM_H
+#define SELFTEST_KVM_PPC_ASM_H
+
+#define STACK_FRAME_MIN_SIZE	112 /* Could be 32 on ELFv2 */
+#define STACK_REDZONE_SIZE	512
+
+#define INT_FRAME_SIZE		(STACK_FRAME_MIN_SIZE + STACK_REDZONE_SIZE)
+
+#define SPR_SRR0	0x1a
+#define SPR_SRR1	0x1b
+#define SPR_CFAR	0x1c
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
new file mode 100644
index 000000000000..804982d390b5
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * powerpc processor specific defines
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_H
+#define SELFTEST_KVM_PROCESSOR_H
+
+#include <linux/compiler.h>
+
+extern unsigned char __interrupts_start[];
+extern unsigned char __interrupts_end[];
+
+struct kvm_vm;
+struct kvm_vcpu;
+extern bool (*interrupt_handler)(struct kvm_vcpu *vcpu, unsigned trap);
+
+struct ex_regs {
+	uint64_t	gprs[32];
+	uint64_t	nia;
+	uint64_t	msr;
+	uint64_t	cfar;
+	uint64_t	lr;
+	uint64_t	ctr;
+	uint64_t	xer;
+	uint32_t	cr;
+	uint32_t	trap;
+	uint64_t	vaddr; /* vaddr of this struct */
+};
+
+void vm_install_exception_handler(struct kvm_vm *vm, int vector,
+			void (*handler)(struct ex_regs *));
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
diff --git a/tools/testing/selftests/kvm/lib/powerpc/handlers.S b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
new file mode 100644
index 000000000000..6fdcc12285e4
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <ppc_asm.h>
+
+.macro INTERRUPT vec
+. = __interrupts_start + \vec
+	std	%r0,(0*8)(%r13)
+	std	%r3,(3*8)(%r13)
+	mfspr	%r0,SPR_CFAR
+	li	%r3,\vec
+	b	handle_interrupt
+.endm
+
+.balign 0x1000
+.global __interrupts_start
+__interrupts_start:
+INTERRUPT 0x100
+INTERRUPT 0x200
+INTERRUPT 0x300
+INTERRUPT 0x380
+INTERRUPT 0x400
+INTERRUPT 0x480
+INTERRUPT 0x500
+INTERRUPT 0x600
+INTERRUPT 0x700
+INTERRUPT 0x800
+INTERRUPT 0x900
+INTERRUPT 0xa00
+INTERRUPT 0xc00
+INTERRUPT 0xd00
+INTERRUPT 0xf00
+INTERRUPT 0xf20
+INTERRUPT 0xf40
+INTERRUPT 0xf60
+
+#define MSR_DR 0x10
+#define MSR_IR 0x20
+
+virt_handle_interrupt:
+	stdu	%r1,-INT_FRAME_SIZE(%r1)
+	mr	%r3,%r31
+	bl	route_interrupt
+	ld	%r4,(32*8)(%r31) /* NIA */
+	ld	%r5,(33*8)(%r31) /* MSR */
+	ld	%r6,(35*8)(%r31) /* LR */
+	ld	%r7,(36*8)(%r31) /* CTR */
+	ld	%r8,(37*8)(%r31) /* XER */
+	lwz	%r9,(38*8)(%r31) /* CR */
+	mtspr	SPR_SRR0,%r4
+	mtspr	SPR_SRR1,%r5
+	mtlr	%r6
+	mtctr	%r7
+	mtxer	%r8
+	mtcr	%r9
+reg=4
+	ld	%r0,(0*8)(%r31)
+	ld	%r3,(3*8)(%r31)
+.rept 28
+	ld	reg,(reg*8)(%r31)
+	reg=reg+1
+.endr
+	addi	%r1,%r1,INT_FRAME_SIZE
+	rfid
+
+virt_handle_interrupt_p:
+	.llong virt_handle_interrupt
+
+handle_interrupt:
+reg=4
+.rept 28
+	std	reg,(reg*8)(%r13)
+	reg=reg+1
+.endr
+	mfspr	%r4,SPR_SRR0
+	mfspr	%r5,SPR_SRR1
+	mflr	%r6
+	mfctr	%r7
+	mfxer	%r8
+	mfcr	%r9
+	std	%r4,(32*8)(%r13) /* NIA */
+	std	%r5,(33*8)(%r13) /* MSR */
+	std	%r0,(34*8)(%r13) /* CFAR */
+	std	%r6,(35*8)(%r13) /* LR */
+	std	%r7,(36*8)(%r13) /* CTR */
+	std	%r8,(37*8)(%r13) /* XER */
+	stw	%r9,(38*8)(%r13) /* CR */
+	stw	%r3,(38*8 + 4)(%r13) /* TRAP */
+
+	ld	%r31,(39*8)(%r13) /* vaddr */
+	ld	%r4,virt_handle_interrupt_p - __interrupts_start(0)
+	mtspr	SPR_SRR0,%r4
+	/* Reuse SRR1 */
+
+	rfid
+.global __interrupts_end
+__interrupts_end:
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
index 000000000000..9e26798e8373
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -0,0 +1,411 @@
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
+static void set_proc_table(struct kvm_vm *vm, int pid, uint64_t dw0, uint64_t dw1)
+{
+	uint64_t *proc_table;
+
+	proc_table = addr_gpa2hva(vm, vm->prtb);
+	proc_table[pid * 2 + 0] = cpu_to_be64(dw0);
+	proc_table[pid * 2 + 1] = cpu_to_be64(dw1);
+}
+
+static void set_radix_proc_table(struct kvm_vm *vm, int pid, vm_paddr_t pgd)
+{
+	set_proc_table(vm, pid, (pgd | RTS | RADIX_PGD_INDEX_SIZE), 0);
+}
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
+	set_radix_proc_table(vm, 0, pgtb);
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
+static unsigned long get_r2(void)
+{
+	unsigned long r2;
+
+	asm("mr %0,%%r2" : "=r"(r2));
+
+	return r2;
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  void *guest_code)
+{
+	size_t stack_size =  64*1024;
+	vm_vaddr_t stack_vaddr, ex_regs_vaddr;
+	vm_paddr_t ex_regs_paddr;
+	struct ex_regs *ex_regs;
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
+	ex_regs_vaddr = __vm_vaddr_alloc(vm, stack_size,
+				       DEFAULT_GUEST_STACK_VADDR_MIN,
+				       MEM_REGION_DATA);
+	ex_regs_paddr = addr_gva2gpa(vm, ex_regs_vaddr);
+	ex_regs = addr_gpa2hva(vm, ex_regs_paddr);
+	ex_regs->vaddr = ex_regs_vaddr;
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
+	regs.gpr[2] = (uintptr_t)get_r2();
+	regs.gpr[12] = (uintptr_t)guest_code;
+	regs.gpr[13] = (uintptr_t)ex_regs_paddr;
+	regs.msr = 0x8000000002803032ull;
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
+void vm_init_descriptor_tables(struct kvm_vm *vm)
+{
+}
+
+void kvm_arch_vm_post_create(struct kvm_vm *vm)
+{
+	vm_paddr_t excp_paddr = vm_phy_page_alloc(vm, 0,
+				 vm->memslots[MEM_REGION_DATA]);
+	void *mem = addr_gpa2hva(vm, excp_paddr);
+
+	TEST_ASSERT(excp_paddr == 0, "excp_paddr = 0x%lx\n", excp_paddr);
+
+	memcpy(mem, __interrupts_start, __interrupts_end - __interrupts_start);
+}
+
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED) {
+		vm_paddr_t ex_regs_paddr;
+		struct ex_regs *ex_regs;
+		struct kvm_regs regs;
+
+		vcpu_regs_get(vcpu, &regs);
+		ex_regs_paddr = (vm_paddr_t)regs.gpr[13];
+		ex_regs = addr_gpa2hva(vcpu->vm, ex_regs_paddr);
+
+		TEST_FAIL("Unexpected interrupt in guest NIA:0x%016lx MSR:0x%016lx TRAP:0x%04x", ex_regs->nia, ex_regs->msr, ex_regs->trap);
+	}
+}
+
+struct handler {
+	void (*fn)(struct ex_regs *regs);
+	int trap;
+};
+
+#define NR_HANDLERS	10
+static struct handler handlers[NR_HANDLERS];
+
+void route_interrupt(struct ex_regs *regs)
+{
+	int i;
+
+	for (i = 0; i < NR_HANDLERS; i++) {
+		if (handlers[i].trap == regs->trap) {
+			handlers[i].fn(regs);
+			return;
+		}
+	}
+
+	ucall(UCALL_UNHANDLED, 0);
+}
+
+void vm_install_exception_handler(struct kvm_vm *vm, int trap,
+			       void (*fn)(struct ex_regs *))
+{
+	int i;
+
+	for (i = 0; i < NR_HANDLERS; i++) {
+		if (!handlers[i].trap || handlers[i].trap == trap) {
+			if (fn == NULL)
+				trap = 0; /* Clear handler */
+			handlers[i].trap = trap;
+			handlers[i].fn = fn;
+			sync_global_to_guest(vm, handlers[i]);
+			return;
+		}
+	}
+
+	TEST_FAIL("Out of exception handlers");
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
diff --git a/tools/testing/selftests/kvm/powerpc/helpers.h b/tools/testing/selftests/kvm/powerpc/helpers.h
new file mode 100644
index 000000000000..8f60bb826830
--- /dev/null
+++ b/tools/testing/selftests/kvm/powerpc/helpers.h
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#ifndef SELFTEST_KVM_HELPERS_H
+#define SELFTEST_KVM_HELPERS_H
+
+#include "kvm_util.h"
+#include "processor.h"
+
+static inline void __handle_ucall(struct kvm_vcpu *vcpu, uint64_t expect, struct ucall *uc)
+{
+	uint64_t ret;
+	struct kvm_regs regs;
+
+	ret = get_ucall(vcpu, uc);
+	if (ret == expect)
+		return;
+
+	vcpu_regs_get(vcpu, &regs);
+	fprintf(stderr, "Guest failure at NIA:0x%016llx MSR:0x%016llx\n", regs.pc, regs.msr);
+	fprintf(stderr, "Expected ucall: %lu\n", expect);
+
+	if (ret == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(*uc);
+	else
+		TEST_FAIL("Unexpected ucall: %lu exit_reason=%s",
+			ret, exit_reason_str(vcpu->run->exit_reason));
+}
+
+static inline void handle_ucall(struct kvm_vcpu *vcpu, uint64_t expect)
+{
+	struct ucall uc;
+
+	__handle_ucall(vcpu, expect, &uc);
+}
+
+static inline void host_sync(struct kvm_vcpu *vcpu, uint64_t sync)
+{
+	struct ucall uc;
+
+	__handle_ucall(vcpu, UCALL_SYNC, &uc);
+
+	TEST_ASSERT(uc.args[1] == (sync), "Sync failed host:%ld guest:%ld",
+						(long)sync, (long)uc.args[1]);
+}
+
+#endif
-- 
2.37.2

