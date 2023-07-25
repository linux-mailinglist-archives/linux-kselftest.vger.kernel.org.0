Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04D376256B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGYWDR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjGYWCx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE62D67
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c361777c7f7so576701276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322522; x=1690927322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3TA6eRwoQ6g/SpqvA9+wSDQ7I0IggaPt15ikMs2HS8=;
        b=xcbMiOYvveUBsY5MvIi5Yf2jG7IB7TfR//tEZBfNvVUz70ksZ7GWo0NCz3jElnpjtS
         CgCBUL89oWqZXpDtdBVt3002I+Jvyg3k9K9XSUMS6MCkBdHbyqQH4Ed9LBnHTZMG196L
         CLtJXt205VbN4Q54dzQUkrH4Joa9JEkGcXI9WLVLMZ4Cvnn1IseSSTYXuUXPcEHpXmS8
         13uNleX930r0p1VFymtm5R0X7HQ2Icw8oBgV5wiEEzTjC2X0Ok5SN2rvcCstV4PJ9r0z
         +5RmltJ7zng9UatFd7wUlTAt0XaJCp5L9OfgKR4GrwkRLeMER3kce965r8XrlkrohKz9
         FDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322522; x=1690927322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3TA6eRwoQ6g/SpqvA9+wSDQ7I0IggaPt15ikMs2HS8=;
        b=WUmM2wTuKGLOJ3cyvmzMDRxT5NThek3qSebFVRnmhhnlk51e7psRwDDlJznyIDBDh5
         S/K5ONH6odKzS1i7/8kc6dR6mIoJxT6CAhzBmWRXOmLvL+U77TjmB1Ua14F141gN7Njt
         eolhDPW9mh0DuqOLIMUyFpqWlwKhNPnmOn1bZcpQXJeOiZ2r207UoX/KFGVdcenhKbXS
         AtTdf3loa0g8q996eleJD6j7PRCqT4Kuhg7VevTpBnFaaE38WRt08Q24w7b+0wevevGZ
         HhB9gTgoi7nLa+HwiM6zagPVmSp2kFj7PuBSrFDuPVczOoIqoN70Meg9NgS8TirVuOp4
         +ZTg==
X-Gm-Message-State: ABy/qLbJiOa+61wktHrpPArDw9cn7IzwkDqUPf1JK0bpfBavBp6+OfVq
        ji3VW7bxqrZD80XhT10WkXPt7egAENesY1uG5OFo8qqy9BggMwUVdt/QwyypehZ1exOafkd2AQi
        UMNJgABbgqHirRN4IApy6bnPTTNb2qVJndBB5jauhbFd54t1nJXVTZWZ1R6NXxamfOTaQLIWHoW
        qN
X-Google-Smtp-Source: APBJJlFChpe86383vb98krN1gnPXjPQ6IQSrIfXO5lK1kcYtzUXSEwvRYR5X2wspvSKb3otKpTs43UPcii5L
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:ab4e:0:b0:d10:2ff3:ec03 with SMTP id
 u72-20020a25ab4e000000b00d102ff3ec03mr5484ybi.1.1690322522072; Tue, 25 Jul
 2023 15:02:02 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:01 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-9-afranji@google.com>
Subject: [PATCH v4 08/28] KVM: selftests: TDX: Add TDX lifecycle test
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Erdem Aktas <erdemaktas@google.com>

Adding a test to verify TDX lifecycle by creating a TD and running a
dummy TDG.VP.VMCALL <Instruction.IO> inside it.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I0b638424ca00a7b121db5e357b0e475f7b1290bd
---
 tools/testing/selftests/kvm/Makefile          |  4 +
 .../selftests/kvm/include/x86_64/tdx/tdcall.h | 35 ++++++++
 .../selftests/kvm/include/x86_64/tdx/tdx.h    | 12 +++
 .../kvm/include/x86_64/tdx/test_util.h        | 52 +++++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdcall.S     | 90 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 27 ++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  1 +
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 34 +++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 45 ++++++++++
 9 files changed, 300 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 9b2210b64ab5..5cdced288025 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -41,6 +41,9 @@ LIBKVM_x86_64 += lib/x86_64/ucall.c
 LIBKVM_x86_64 += lib/x86_64/vmx.c
 LIBKVM_x86_64 += lib/x86_64/tdx/tdx_util.c
 LIBKVM_x86_64 += lib/x86_64/tdx/td_boot.S
+LIBKVM_x86_64 += lib/x86_64/tdx/tdcall.S
+LIBKVM_x86_64 += lib/x86_64/tdx/tdx.c
+LIBKVM_x86_64 += lib/x86_64/tdx/test_util.c
 
 LIBKVM_aarch64 += lib/aarch64/gic.c
 LIBKVM_aarch64 += lib/aarch64/gic_v3.c
@@ -136,6 +139,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 += system_counter_offset_test
+TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
new file mode 100644
index 000000000000..78001bfec9c8
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Adapted from arch/x86/include/asm/shared/tdx.h */
+
+#ifndef SELFTESTS_TDX_TDCALL_H
+#define SELFTESTS_TDX_TDCALL_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
+#define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
+
+#define TDX_HCALL_HAS_OUTPUT BIT(0)
+
+#define TDX_HYPERCALL_STANDARD 0
+
+/*
+ * Used in __tdx_hypercall() to pass down and get back registers' values of
+ * the TDCALL instruction when requesting services from the VMM.
+ *
+ * This is a software only structure and not part of the TDX module/VMM ABI.
+ */
+struct tdx_hypercall_args {
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+};
+
+/* Used to request services from the VMM */
+u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
+
+#endif // SELFTESTS_TDX_TDCALL_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
new file mode 100644
index 000000000000..a7161efe4ee2
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_TDX_TDX_H
+#define SELFTEST_TDX_TDX_H
+
+#include <stdint.h>
+
+#define TDG_VP_VMCALL_INSTRUCTION_IO 30
+
+uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
+				      uint64_t write, uint64_t *data);
+
+#endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
new file mode 100644
index 000000000000..b570b6d978ff
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_TDX_TEST_UTIL_H
+#define SELFTEST_TDX_TEST_UTIL_H
+
+#include <stdbool.h>
+
+#include "tdcall.h"
+
+#define TDX_TEST_SUCCESS_PORT 0x30
+#define TDX_TEST_SUCCESS_SIZE 4
+
+/**
+ * Assert that tdx_test_success() was called in the guest.
+ */
+#define TDX_TEST_ASSERT_SUCCESS(VCPU)					\
+	(TEST_ASSERT(							\
+		((VCPU)->run->exit_reason == KVM_EXIT_IO) &&		\
+		((VCPU)->run->io.port == TDX_TEST_SUCCESS_PORT) &&	\
+		((VCPU)->run->io.size == TDX_TEST_SUCCESS_SIZE) &&	\
+		((VCPU)->run->io.direction ==				\
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE),		\
+		"Unexpected exit values while waiting for test completion: %u (%s) %d %d %d\n", \
+		(VCPU)->run->exit_reason,				\
+		exit_reason_str((VCPU)->run->exit_reason),		\
+		(VCPU)->run->io.port, (VCPU)->run->io.size,		\
+		(VCPU)->run->io.direction))
+
+/**
+ * Run a test in a new process.
+ *
+ * There might be multiple tests we are running and if one test fails, it will
+ * prevent the subsequent tests to run due to how tests are failing with
+ * TEST_ASSERT function. The run_in_new_process function will run a test in a
+ * new process context and wait for it to finish or fail to prevent TEST_ASSERT
+ * to kill the main testing process.
+ */
+void run_in_new_process(void (*func)(void));
+
+/**
+ * Verify that the TDX is supported by KVM.
+ */
+bool is_tdx_enabled(void);
+
+/**
+ * Report test success to userspace.
+ *
+ * Use TDX_TEST_ASSERT_SUCCESS() to assert that this function was called in the
+ * guest.
+ */
+void tdx_test_success(void);
+
+#endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
new file mode 100644
index 000000000000..df9c1ed4bb2d
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Adapted from arch/x86/coco/tdx/tdcall.S */
+
+#define TDX_HYPERCALL_r10 0 /* offsetof(struct tdx_hypercall_args, r10) */
+#define TDX_HYPERCALL_r11 8 /* offsetof(struct tdx_hypercall_args, r11) */
+#define TDX_HYPERCALL_r12 16 /* offsetof(struct tdx_hypercall_args, r12) */
+#define TDX_HYPERCALL_r13 24 /* offsetof(struct tdx_hypercall_args, r13) */
+#define TDX_HYPERCALL_r14 32 /* offsetof(struct tdx_hypercall_args, r14) */
+#define TDX_HYPERCALL_r15 40 /* offsetof(struct tdx_hypercall_args, r15) */
+
+/*
+ * Bitmasks of exposed registers (with VMM).
+ */
+#define TDX_R10 0x400
+#define TDX_R11 0x800
+#define TDX_R12 0x1000
+#define TDX_R13 0x2000
+#define TDX_R14 0x4000
+#define TDX_R15 0x8000
+
+#define TDX_HCALL_HAS_OUTPUT 0x1
+
+/*
+ * These registers are clobbered to hold arguments for each
+ * TDVMCALL. They are safe to expose to the VMM.
+ * Each bit in this mask represents a register ID. Bit field
+ * details can be found in TDX GHCI specification, section
+ * titled "TDCALL [TDG.VP.VMCALL] leaf".
+ */
+#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
+					  TDX_R12 | TDX_R13 | \
+					  TDX_R14 | TDX_R15 )
+
+.code64
+.section .text
+
+.globl __tdx_hypercall
+.type __tdx_hypercall, @function
+__tdx_hypercall:
+	/* Set up stack frame */
+	push %rbp
+	movq %rsp, %rbp
+
+	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
+	xor %eax, %eax
+
+	/* Copy hypercall registers from arg struct: */
+	movq TDX_HYPERCALL_r10(%rdi), %r10
+	movq TDX_HYPERCALL_r11(%rdi), %r11
+	movq TDX_HYPERCALL_r12(%rdi), %r12
+	movq TDX_HYPERCALL_r13(%rdi), %r13
+	movq TDX_HYPERCALL_r14(%rdi), %r14
+	movq TDX_HYPERCALL_r15(%rdi), %r15
+
+	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+
+	tdcall
+
+	/* TDVMCALL leaf return code is in R10 */
+	movq %r10, %rax
+
+	/* Copy hypercall result registers to arg struct if needed */
+	testq $TDX_HCALL_HAS_OUTPUT, %rsi
+	jz .Lout
+
+	movq %r10, TDX_HYPERCALL_r10(%rdi)
+	movq %r11, TDX_HYPERCALL_r11(%rdi)
+	movq %r12, TDX_HYPERCALL_r12(%rdi)
+	movq %r13, TDX_HYPERCALL_r13(%rdi)
+	movq %r14, TDX_HYPERCALL_r14(%rdi)
+	movq %r15, TDX_HYPERCALL_r15(%rdi)
+.Lout:
+	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	pop %rbp
+	ret
+
+/* Disable executable stack */
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
new file mode 100644
index 000000000000..c2414523487a
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+
+uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
+				      uint64_t write, uint64_t *data)
+{
+	uint64_t ret;
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_IO,
+		.r12 = size,
+		.r13 = write,
+		.r14 = port,
+	};
+
+	if (write)
+		args.r15 = *data;
+
+	ret = __tdx_hypercall(&args, write ? 0 : TDX_HCALL_HAS_OUTPUT);
+
+	if (!write)
+		*data = args.r11;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
index c30801f4f759..4ebb8ddb2a93 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -231,6 +231,7 @@ static void tdx_enable_capabilities(struct kvm_vm *vm)
 		      KVM_X2APIC_API_USE_32BIT_IDS |
 			      KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
 	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
+	vm_enable_cap(vm, KVM_CAP_MAX_VCPUS, 1024);
 }
 
 static void tdx_configure_memory_encryption(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
new file mode 100644
index 000000000000..f63d90898a6a
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kvm_util_base.h"
+#include "tdx/tdx.h"
+#include "tdx/test_util.h"
+
+void run_in_new_process(void (*func)(void))
+{
+	if (fork() == 0) {
+		func();
+		exit(0);
+	}
+	wait(NULL);
+}
+
+bool is_tdx_enabled(void)
+{
+	return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_PROTECTED_VM));
+}
+
+void tdx_test_success(void)
+{
+	uint64_t code = 0;
+
+	tdg_vp_vmcall_instruction_io(TDX_TEST_SUCCESS_PORT,
+				     TDX_TEST_SUCCESS_SIZE,
+				     TDG_VP_VMCALL_INSTRUCTION_IO_WRITE, &code);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
new file mode 100644
index 000000000000..a18d1c9d6026
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <signal.h>
+#include "kvm_util_base.h"
+#include "tdx/tdx_util.h"
+#include "tdx/test_util.h"
+#include "test_util.h"
+
+void guest_code_lifecycle(void)
+{
+	tdx_test_success();
+}
+
+void verify_td_lifecycle(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_lifecycle);
+	td_finalize(vm);
+
+	printf("Verifying TD lifecycle:\n");
+
+	vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+int main(int argc, char **argv)
+{
+	setbuf(stdout, NULL);
+
+	if (!is_tdx_enabled()) {
+		print_skip("TDX is not supported by the KVM");
+		exit(KSFT_SKIP);
+	}
+
+	run_in_new_process(&verify_td_lifecycle);
+
+	return 0;
+}
-- 
2.41.0.487.g6d72f3e995-goog

