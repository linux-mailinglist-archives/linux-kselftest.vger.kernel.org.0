Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4336DB8B3
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Apr 2023 06:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDHEAx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Apr 2023 00:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjDHEAv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Apr 2023 00:00:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738BCD529;
        Fri,  7 Apr 2023 21:00:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so413012pjb.1;
        Fri, 07 Apr 2023 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680926448; x=1683518448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQiReo0GxtaI21B3doWVmOMyb6wAwDDb3O19pEKyz6U=;
        b=Iga/sQIwbsIR2Hen/tu+nMZiJidVtMQBGi7Jj+LcnqDP7J2uVwRgmzNHWVEd/WnmfY
         yIzpvz7HjsHaj0yX6Un5EVOphQpiDUFKFG3zCXTdN5PuOVFUiaxbAb27ymgQ5air6Lno
         rCTcgiU//SfUGbojw5Uri7B5CzPzMzyDA734W7Ydf2phA+64QKvaG+4OFts7yNhrko0Q
         jfwMpMtv7VFEhysJlWIPxfCfPFRDKIDy6U+7QkiD5ADJ4iC8UeSM8TeWKXuqJ0DRhb58
         hmisH+QXm9RHV+VlflYQjoa93fY3/xtlU81crk+TXEUUd+NknLrydq5YUjc1+gHHyVHO
         3dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680926448; x=1683518448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQiReo0GxtaI21B3doWVmOMyb6wAwDDb3O19pEKyz6U=;
        b=HBxUxBcHDoTtWFV9WpxpemNe8aI6YN6usMmR8vDCiH1O5sLT36/kcFYO+DqtAzbdPT
         r5xWGa+I8Bggi5pP8xyFmCBXiLlqGLzSJhRQ5tOQDA/LBsT7crk/29W6e32K6qAYCzcr
         as3wxPLkaf1p/9x5ERW835u468VY6KLLQO/0RNc8VM+B0w0q3q/Rix//zkRIC4eR31J8
         2UQ1e/dmu9nWv+k/P+XS6NNLxGbIYMj4aMJphvJl/RzZKwP3cSReP8IcDHVWiUQLfl52
         /kyyR7kD9c4RKPiiLWpjGCaPTo/zoaKxv4R2jUK+OVZ68m1sy+VUe3uF/r38QI8+1hJa
         5hDQ==
X-Gm-Message-State: AAQBX9fJqybYC9jyPaXqLJutj6I4MGBX12f+tjvJHlsY4Fd8xobEwWml
        JnDAqqPDCPz/aXV2YpqEX8w=
X-Google-Smtp-Source: AKy350ZBbA25OmqN1/TUGDsPIPWFjzNrHrA4tVLyvBtiRc3dEc5zm9OZ7FaW7gUFTRmgnfzpcCI7Fg==
X-Received: by 2002:a05:6a20:4f9d:b0:c6:bd82:ea2d with SMTP id gh29-20020a056a204f9d00b000c6bd82ea2dmr3381037pzb.2.1680926447501;
        Fri, 07 Apr 2023 21:00:47 -0700 (PDT)
Received: from wheely.local0.net ([203.59.189.25])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b006328ee1e56csm263872pfw.2.2023.04.07.21.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 21:00:46 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/4] KVM: PPC: selftests: add support for powerpc
Date:   Sat,  8 Apr 2023 14:00:19 +1000
Message-Id: <20230408040020.868929-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230408040020.868929-1-npiggin@gmail.com>
References: <20230408040020.868929-1-npiggin@gmail.com>
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

For now virtual memory is only implemented for the radix MMU, and only
the base page size is supported.

Guest interrupts are taken in real-mode, so require a real-mode page at
gRA 0. Interrupt entry requires some tricky code because gVA:gRA is not
1:1 mapped like the kernel is, so we can't just switch MMU on and off.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |  13 +
 .../selftests/kvm/include/kvm_util_base.h     |  20 +
 .../selftests/kvm/include/powerpc/hcall.h     |  19 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  33 ++
 tools/testing/selftests/kvm/lib/guest_modes.c |   3 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 429 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  30 ++
 tools/testing/selftests/kvm/powerpc/helpers.h |  46 ++
 13 files changed, 777 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
 create mode 100644 tools/testing/selftests/kvm/powerpc/helpers.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c6283280683e..d353cbd5416c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11305,6 +11305,8 @@ F:	arch/powerpc/include/asm/kvm*
 F:	arch/powerpc/include/uapi/asm/kvm*
 F:	arch/powerpc/kernel/kvm*
 F:	arch/powerpc/kvm/
+F:	tools/testing/selftests/kvm/*/powerpc/
+F:	tools/testing/selftests/kvm/powerpc/
 
 KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
 M:	Anup Patel <anup@brainfault.org>
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
index 8a27bd4111ff..b59566869f65 100644
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
@@ -160,6 +161,8 @@ enum vm_guest_mode {
 	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
 	VM_MODE_P47V64_4K,
 	VM_MODE_P44V64_4K,
+	VM_MODE_P52V52_4K,
+	VM_MODE_P52V52_64K,
 	VM_MODE_P36V48_4K,
 	VM_MODE_P36V48_16K,
 	VM_MODE_P36V48_64K,
@@ -197,6 +200,23 @@ extern enum vm_guest_mode vm_mode_default;
 #define MIN_PAGE_SHIFT			12U
 #define ptes_per_page(page_size)	((page_size) / 8)
 
+#elif defined(__powerpc64__)
+
+/* Radix guest EA and RA are 52-bit on POWER9 and POWER10 */
+#define VM_MODE_DEFAULT			VM_MODE_P52V52_64K
+/*
+ * XXX: This is a hack to allocate more memory for page tables because we
+ * don't pack "fragments" well with 64K page sizes. Should rework generic
+ * code to allow more flexible page table memory estimation (and fix our
+ * page table allocation).
+ */
+#define MIN_PAGE_SHIFT			12U
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
index 000000000000..ba119f5a3fef
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -0,0 +1,19 @@
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
+#define UCALL_R4_SIMPLE	0x0000 // simple exit usable by asm with no ucall data
+
+int64_t hcall0(uint64_t token);
+int64_t hcall1(uint64_t token, uint64_t arg1);
+int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2);
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/ppc_asm.h b/tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
new file mode 100644
index 000000000000..b9df64659792
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
@@ -0,0 +1,32 @@
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
+#define SPR_SRR0	0x01a
+#define SPR_SRR1	0x01b
+#define SPR_CFAR	0x01c
+
+#define MSR_SF		0x8000000000000000ULL
+#define MSR_HV		0x1000000000000000ULL
+#define MSR_VEC		0x0000000002000000ULL
+#define MSR_VSX		0x0000000000800000ULL
+#define MSR_EE		0x0000000000008000ULL
+#define MSR_PR		0x0000000000004000ULL
+#define MSR_FP		0x0000000000002000ULL
+#define MSR_ME		0x0000000000001000ULL
+#define MSR_IR		0x0000000000000020ULL
+#define MSR_DR		0x0000000000000010ULL
+#define MSR_RI		0x0000000000000002ULL
+#define MSR_LE		0x0000000000000001ULL
+
+#define LPCR_ILE	0x0000000002000000ULL
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
new file mode 100644
index 000000000000..4141a09b7f42
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * powerpc processor specific defines
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_H
+#define SELFTEST_KVM_PROCESSOR_H
+
+#include <linux/compiler.h>
+#include "ppc_asm.h"
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
diff --git a/tools/testing/selftests/kvm/lib/guest_modes.c b/tools/testing/selftests/kvm/lib/guest_modes.c
index 1df3ce4b16fd..74e644ca6d93 100644
--- a/tools/testing/selftests/kvm/lib/guest_modes.c
+++ b/tools/testing/selftests/kvm/lib/guest_modes.c
@@ -85,6 +85,9 @@ void guest_modes_append_default(void)
 			guest_mode_append(VM_MODE_P48V48_4K, true, true);
 	}
 #endif
+#ifdef __powerpc__
+	guest_mode_append(VM_MODE_P52V52_4K, true, true);
+#endif
 }
 
 void for_each_guest_mode(void (*func)(enum vm_guest_mode, void *), void *arg)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 4f15bbbb8f5e..ee38bb22d74d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -153,6 +153,8 @@ const char *vm_guest_mode_string(uint32_t i)
 		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
 		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
 		[VM_MODE_P44V64_4K]	= "PA-bits:44,  VA-bits:64,  4K pages",
+		[VM_MODE_P52V52_4K]	= "PA-bits:52,  VA-bits:52,  4K pages",
+		[VM_MODE_P52V52_64K]	= "PA-bits:52,  VA-bits:52, 64K pages",
 		[VM_MODE_P36V48_4K]	= "PA-bits:36,  VA-bits:48,  4K pages",
 		[VM_MODE_P36V48_16K]	= "PA-bits:36,  VA-bits:48, 16K pages",
 		[VM_MODE_P36V48_64K]	= "PA-bits:36,  VA-bits:48, 64K pages",
@@ -178,6 +180,8 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_PXXV48_4K]	= {  0,  0,  0x1000, 12 },
 	[VM_MODE_P47V64_4K]	= { 47, 64,  0x1000, 12 },
 	[VM_MODE_P44V64_4K]	= { 44, 64,  0x1000, 12 },
+	[VM_MODE_P52V52_4K]	= { 52, 52,  0x1000, 12 },
+	[VM_MODE_P52V52_64K]	= { 52, 52, 0x10000, 16 },
 	[VM_MODE_P36V48_4K]	= { 36, 48,  0x1000, 12 },
 	[VM_MODE_P36V48_16K]	= { 36, 48,  0x4000, 14 },
 	[VM_MODE_P36V48_64K]	= { 36, 48, 0x10000, 16 },
@@ -279,6 +283,14 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 	case VM_MODE_P44V64_4K:
 		vm->pgtable_levels = 5;
 		break;
+#ifdef __powerpc__
+	case VM_MODE_P52V52_64K:
+		vm->pgtable_levels = 4;
+		break;
+	case VM_MODE_P52V52_4K:
+		vm->pgtable_levels = 4;
+		break;
+#endif
 	default:
 		TEST_FAIL("Unknown guest mode, mode: 0x%x", mode);
 	}
diff --git a/tools/testing/selftests/kvm/lib/powerpc/handlers.S b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
new file mode 100644
index 000000000000..a68c187b835f
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
@@ -0,0 +1,93 @@
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
index 000000000000..7052ce9b5029
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM selftest powerpc library code - CPU-related functions (page tables...)
+ */
+
+#include <linux/sizes.h>
+
+#include "processor.h"
+#include "kvm_util.h"
+#include "kvm_util_base.h"
+#include "hcall.h"
+
+#define RADIX_TREE_SIZE ((0x2UL << 61) | (0x5UL << 5)) // 52-bits
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
+	set_proc_table(vm, pid, pgd | RADIX_TREE_SIZE | RADIX_PGD_INDEX_SIZE, 0);
+}
+
+void virt_arch_pgd_alloc(struct kvm_vm *vm)
+{
+	struct kvm_ppc_mmuv3_cfg mmu_cfg;
+	vm_paddr_t prtb, pgtb;
+	size_t pgd_pages;
+
+	TEST_ASSERT((vm->mode == VM_MODE_P52V52_4K) ||
+		    (vm->mode == VM_MODE_P52V52_64K),
+		    "Unsupported guest mode, mode: 0x%x", vm->mode);
+
+	prtb = vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+				 vm->memslots[MEM_REGION_PT]);
+	vm->prtb = prtb;
+
+	pgd_pages = (1UL << (RADIX_PGD_INDEX_SIZE + 3)) >> vm->page_shift;
+	if (!pgd_pages)
+		pgd_pages = 1;
+	pgtb = vm_phy_pages_alloc_align(vm, pgd_pages, pgd_pages,
+					KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+					vm->memslots[MEM_REGION_PT]);
+	vm->pgd = pgtb;
+
+	/* Set the base page directory in the proc table */
+	set_radix_proc_table(vm, 0, pgtb);
+
+	if (vm->mode == VM_MODE_P52V52_4K)
+		mmu_cfg.process_table = prtb | 0x8000000000000000UL | 0x0; // 4K size
+	else /* vm->mode == VM_MODE_P52V52_64K */
+		mmu_cfg.process_table = prtb | 0x8000000000000000UL | 0x4; // 64K size
+	mmu_cfg.flags = KVM_PPC_MMUV3_RADIX | KVM_PPC_MMUV3_GTSE;
+
+	vm_ioctl(vm, KVM_PPC_CONFIGURE_V3_MMU, &mmu_cfg);
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
+		if (vm->mode == VM_MODE_P52V52_4K)
+			return 9;
+		else /* vm->mode == VM_MODE_P52V52_64K */
+			return 5;
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
+		if (vm->mode == VM_MODE_P52V52_4K)
+			*nls = 0x9;
+		else /* vm->mode == VM_MODE_P52V52_64K */
+			*nls = 0x5;
+		return (vaddr >> 21) & 0x1ff;
+	case 4:
+		if (vm->mode == VM_MODE_P52V52_4K)
+			return (vaddr >> 12) & 0x1ff;
+		else /* vm->mode == VM_MODE_P52V52_64K */
+			return (vaddr >> 16) & 0x1f;
+	default:
+		TEST_ASSERT(false, "Invalid page table level %d\n", level);
+		return 0;
+	}
+}
+
+static uint64_t *virt_get_pte(struct kvm_vm *vm, vm_paddr_t pt,
+			  uint64_t vaddr, int level, uint64_t *nls)
+{
+	int idx = pt_idx(vm, vaddr, level, nls);
+	uint64_t *ptep = addr_gpa2hva(vm, pt + idx*8);
+
+	return ptep;
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
+		size_t pt_pages;
+
+		if (pde) {
+			TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
+				    "Invalid PDE at level: %u gva: 0x%lx pde:0x%lx\n",
+				    level, gva, pde);
+			pt = pde & PDE_PT_MASK;
+			continue;
+		}
+
+		pt_pages = (1ULL << (nls + 3)) >> vm->page_shift;
+		if (!pt_pages)
+			pt_pages = 1;
+		pt = vm_phy_pages_alloc_align(vm, pt_pages, pt_pages,
+					KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+					vm->memslots[MEM_REGION_PT]);
+		pde = PDE_VALID | nls | pt;
+		*pdep = cpu_to_be64(pde);
+	}
+
+	ptep = virt_get_pte(vm, pt, gva, level, NULL);
+	pte = be64_to_cpu(*ptep);
+
+	TEST_ASSERT(!pte, "PTE already present at level: %u gva: 0x%lx pte:0x%lx\n",
+		    level, gva, pte);
+
+	pte = PTE_VALID | PTE_LEAF | PTE_REFERENCED | PTE_CHANGED |PTE_PRIV |
+	      PTE_READ | PTE_RW | PTE_EXEC | (gpa & PTE_PAGE_MASK);
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
+	TEST_ASSERT((pte & PTE_VALID) && (pte & PTE_LEAF) &&
+		    (pte & PTE_READ) && (pte & PTE_RW) && (pte & PTE_EXEC),
+		    "PTE not valid at level: %u gva: 0x%lx pte:0x%lx\n",
+		    level, gva, pte);
+
+	return (pte & PTE_PAGE_MASK) + (gva & (vm->page_size - 1));
+}
+
+static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, vm_paddr_t pt,
+			 vm_vaddr_t va, int level, uint8_t indent)
+{
+	int size, idx;
+
+	size = 1U << (pt_shift(vm, level) + 3);
+
+	for (idx = 0; idx < size; idx += 8, va += pt_entry_coverage(vm, level)) {
+		uint64_t *page_table = addr_gpa2hva(vm, pt + idx);
+		uint64_t pte = be64_to_cpu(*page_table);
+
+		if (!(pte & PTE_VALID))
+			continue;
+
+		if (pte & PTE_LEAF) {
+			fprintf(stream,
+				"%*s PTE[%d] gVA:0x%016lx -> gRA:0x%016llx\n",
+				indent, "", idx/8, va, pte & PTE_PAGE_MASK);
+		} else {
+			fprintf(stream, "%*sPDE%d[%d] gVA:0x%016lx\n",
+				indent, "", level, idx/8, va);
+			virt_dump_pt(stream, vm, pte & PDE_PT_MASK, va,
+				     level + 1, indent + 2);
+		}
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
+	virt_dump_pt(stream, vm, pt, 0, 1, indent);
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
+	const size_t stack_size =  SZ_64K;
+	vm_vaddr_t stack_vaddr, ex_regs_vaddr;
+	vm_paddr_t ex_regs_paddr;
+	struct ex_regs *ex_regs;
+	struct kvm_regs regs;
+	struct kvm_vcpu *vcpu;
+	uint64_t lpcr;
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
+	regs.gpr[1] = stack_vaddr + stack_size - 256;
+	regs.gpr[2] = (uintptr_t)get_r2();
+	regs.gpr[12] = (uintptr_t)guest_code;
+	regs.gpr[13] = (uintptr_t)ex_regs_paddr;
+
+	regs.msr = MSR_SF | MSR_VEC | MSR_VSX | MSR_FP |
+		   MSR_ME | MSR_IR | MSR_DR | MSR_RI;
+
+	if (BYTE_ORDER == LITTLE_ENDIAN) {
+		regs.msr |= MSR_LE;
+		lpcr |= LPCR_ILE;
+	} else {
+		lpcr &= ~LPCR_ILE;
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
+	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args: %u\n",
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
+	fprintf(stream, "%*sNIA: 0x%016llx  MSR: 0x%016llx\n",
+			indent, "", regs.pc, regs.msr);
+	fprintf(stream, "%*sLR:  0x%016llx  CTR :0x%016llx\n",
+			indent, "", regs.lr, regs.ctr);
+	fprintf(stream, "%*sCR:  0x%08llx          XER :0x%016llx\n",
+			indent, "", regs.cr, regs.xer);
+}
+
+void vm_init_descriptor_tables(struct kvm_vm *vm)
+{
+}
+
+void kvm_arch_vm_post_create(struct kvm_vm *vm)
+{
+	vm_paddr_t excp_paddr;
+	void *mem;
+
+	excp_paddr = vm_phy_page_alloc(vm, 0, vm->memslots[MEM_REGION_DATA]);
+
+	TEST_ASSERT(excp_paddr == 0,
+		    "Interrupt vectors not allocated at gPA address 0: (0x%lx)",
+		    excp_paddr);
+
+	mem = addr_gpa2hva(vm, excp_paddr);
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
+		TEST_FAIL("Unexpected interrupt in guest NIA:0x%016lx MSR:0x%016lx TRAP:0x%04x",
+			  ex_regs->nia, ex_regs->msr, ex_regs->trap);
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
2.40.0

