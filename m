Return-Path: <linux-kselftest+bounces-1731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D61D80F82A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F352820F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10864CDE;
	Tue, 12 Dec 2023 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xdy1wauA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5011121
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:12 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d34350cbe8so5832205ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414032; x=1703018832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lj4D0PhZEWa+J2oCsJqxn2vkhxEFsIHZYAmom0ZtdVA=;
        b=Xdy1wauAco14NOPJcwSIFWO8/PyfUzM4WYqVqKtXTgXWG3vYUzkDnLD66TEr2OeVq9
         B7wgqnugikyAPngChOi7LvBkYA1GCOAYomQtKHmRLp4q0l7c+z1HRRfPDgbcETTrhYU6
         /Cxyn5t5krDIfKIR21NYEa4r5JhyHkIQ7bApVqbz/ydfeWR9idwFD1pFhf/43wX/eWpD
         nfZmlSY7UeTSIJOrQAd37yA2t2R2qlEuyb7GI5P+//xKf2aHLDIkHZvRyC5qjhalsOL7
         JU8403mOascA15s6iEl33algbSFiiVVvXl3SkCtdsdzJU86xnuUH39Nhov0f1cD3nz3x
         g25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414032; x=1703018832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lj4D0PhZEWa+J2oCsJqxn2vkhxEFsIHZYAmom0ZtdVA=;
        b=YEUolCGP70eg89PEdh6US1fI76NC9qQ+RPmTBg1yLpxaVZH9gE7WYaXp5VUyNGcIQV
         McK4txXdI0vElaKW6NW8WAVvXtpBDP340L3DZMVH2PFdoQtqY6MvOMnMwuii/bz40KNy
         Sx6zlWRCCNCmTqR6BZxAR7B9xzVvuyUJzYyEPjeGSndxP1CVdLhCiBJvI6+OVcQPqbiD
         Rx05QVi0kiYA+iZ2V/AlVmTtHCrtAzOyfljVwPdFzBbaNbia1n2nXBZ1INoT/LFwVrBw
         ZRoyrn0sQ8FThSOOlgs2ii1Ubtn8115KsTe4wmJeL3Al/j67KcUi89Q7sWUj4x8Ra4vF
         HoXg==
X-Gm-Message-State: AOJu0YyNhZdxGl4xeCgsIv7ZIFq7jtCJc7oem7k7CYG11Ge18zZF5XoO
	3Jwcvb/7KLloDSzfROQW18XNUxLgxdYE6dQ/mPAYMobpFyzwigzxQ2UMaJKJpaW4y2w9AjjHQkg
	VVpR8t5W1w1ldvvC10gESIDoJeK6JqEdZxcL6ds5hFhfLS1pi7At+O/V3zp04no2Yw+9EFYk=
X-Google-Smtp-Source: AGHT+IHotCCGwJXLPLifE+SYJWNLJ6zJQfanWXZGjPBETibGjtypcltAqwaSRsI5lsDPWW1sws9s+tiRnQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:da8b:b0:1d0:cd87:64db with SMTP id
 j11-20020a170902da8b00b001d0cd8764dbmr49191plx.12.1702414031654; Tue, 12 Dec
 2023 12:47:11 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:23 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-9-sagis@google.com>
Subject: [RFC PATCH v5 08/29] KVM: selftests: TDX: Add TDX lifecycle test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Erdem Aktas <erdemaktas@google.com>

Adding a test to verify TDX lifecycle by creating a TD and running a
dummy TDG.VP.VMCALL <Instruction.IO> inside it.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
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
index a35150ab855f..80d4a50eeb9f 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -52,6 +52,9 @@ LIBKVM_x86_64 += lib/x86_64/vmx.c
 LIBKVM_x86_64 += lib/x86_64/sev.c
 LIBKVM_x86_64 += lib/x86_64/tdx/tdx_util.c
 LIBKVM_x86_64 += lib/x86_64/tdx/td_boot.S
+LIBKVM_x86_64 += lib/x86_64/tdx/tdcall.S
+LIBKVM_x86_64 += lib/x86_64/tdx/tdx.c
+LIBKVM_x86_64 += lib/x86_64/tdx/test_util.c
 
 LIBKVM_aarch64 += lib/aarch64/gic.c
 LIBKVM_aarch64 += lib/aarch64/gic_v3.c
@@ -152,6 +155,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
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
index 063ff486fb86..b302060049d5 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -224,6 +224,7 @@ static void tdx_enable_capabilities(struct kvm_vm *vm)
 		      KVM_X2APIC_API_USE_32BIT_IDS |
 			      KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
 	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
+	vm_enable_cap(vm, KVM_CAP_MAX_VCPUS, 512);
 }
 
 static void tdx_configure_memory_encryption(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
new file mode 100644
index 000000000000..6905d0ca3877
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
+	return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_TDX_VM));
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
2.43.0.472.g3155946c3a-goog


