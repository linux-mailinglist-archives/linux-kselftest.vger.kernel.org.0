Return-Path: <linux-kselftest+bounces-30773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF903A88E45
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD1C189A4E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11C720C47A;
	Mon, 14 Apr 2025 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SE4nZr5G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E32202F70
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667334; cv=none; b=I90qXwEQPCEDiB+LNewJj1LLkJYIgcjXCn5yOqh+CHJRGodw31bOH6hLK/7waxadxVT4rx16ZzFTdPpxReKlNwKXH2POy2/72rcSy/+5uXjgy6aMs4QGGICi48zzJCKSFn0ZDEqgtz8Na0oGHoEk74357MYW3bWyd+Z03QzVbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667334; c=relaxed/simple;
	bh=AwljbBHlJNb2pxBBkRDg/ZIfEgwIi7baPaAeA1iPhLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j4lW0376W2MbGPv3VT2/x3tEBiu/U9xyJp/Dpi9v6UUusMGK5xDN3fxlC3ZNZleEzprQrTrzP8oD7fjNBuEiNkNU11zA2QaJgcWpE70lHhRZQbQxrJLSEvXIIP8jXFuONTWlF9NxnakphsD4L7w1FuEYjDrK8Kj/GTzDWV4wqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SE4nZr5G; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-229668c8659so35476325ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667332; x=1745272132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgS0drNtXto2vjqcC+uAp6ay40RcqxFx1C4SRMQLUi8=;
        b=SE4nZr5G6alqj+Men1KNQV4iyXiTeH94LoTv408jRk9ks+Tmegsl8Nx0+lGFy8hAsc
         0Wa3LcEDLbYboqPd26KfG9WZEBxYXa5RE/dB3wVtTbBZHUbgQdGPFHtL1OuYoAG2Vvlm
         PrZ72N7Dzl+rIRKApjj/Lj+KgKl+X/zPG7jcVtm5hK6GgTDvbO8z0YhhUJTsVIKyrrbF
         cQdXls++jkwli+gQau03tWUiofEhImkhhm0v7IjMIxofxxLo4SXo6wyFt75VC1SbruN9
         0OnGKyB6w9qgSXVltejyB2/aYwvUunlEf6ghOAtUkSNBd5YOkCozxFbW+iQO8fVz8sD3
         z7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667332; x=1745272132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgS0drNtXto2vjqcC+uAp6ay40RcqxFx1C4SRMQLUi8=;
        b=J6/aXLtQanS561pT+pFA3hcUEDD7Yq0LUv/1OOV+Y3Nd3WvLrQFFArNSvcOl+saZla
         PVPb/5uE+z6o5Y6gg35b09c4wypuc+Zz8d9Vtw+naC0YAbJwVCk1EeVQvxAFBzrpqaUJ
         DY/Bj4cyZ3mGRq9wdwvfFwfGCs77jYZbdHrgxfZjFs126XqQ+KVCuWSvbeLh91CBaem8
         p/dIClyxFDlq64pGwyBasTttKZcqrkOiQOB0k1S9sXdM5X4TRkcWeOGs1GxfuSzVYII6
         N3Jmzp/dRW3h2YEsSZCYv843/e0FZz67cas0xfmmYXgkZHfhGALiIhvxaL4Y7RLrnIBf
         cXlA==
X-Gm-Message-State: AOJu0YwFat7l4aay3l4nla/kML/N55G3Qa5gEO0D8GLIny1UzKlkM+1H
	8PcBiqON0QZLcaV+xYoBo3GjSqU2d8pDp3RWxqhp33QcfvnICCVtxVlfJSP8NoKFhH6k2pYcubX
	sKfP1g/XzOpK/jy7chpzy5XBE16DxX0nIl58lfj/ZjTAHFPThP2FBZySf536d6Bvixz3ZRsNAcj
	M2d8XbqUX0/lhC7dr6TY6DVZXgUb0L1rXwk9xZh7s=
X-Google-Smtp-Source: AGHT+IGvpH2CVGXM8TBrY5c2fGY41xqkr6arLTnktI+7+7zZU0OC+/9v/DIhta55E+ZkUisFp+He4zFDtA==
X-Received: from plbju14.prod.google.com ([2002:a17:903:428e:b0:223:5a6e:b17])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230e:b0:226:30f6:1639
 with SMTP id d9443c01a7336-22bea50e0d3mr186211325ad.51.1744667331846; Mon, 14
 Apr 2025 14:48:51 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:38 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-10-sagis@google.com>
Subject: [PATCH v6 09/30] KVM: selftests: TDX: Add TDX lifecycle test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Erdem Aktas <erdemaktas@google.com>

Adding a test to verify TDX lifecycle by creating a TD and running a
dummy TDG.VP.VMCALL <Instruction.IO> inside it.

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  4 +
 .../selftests/kvm/include/x86/tdx/tdcall.h    | 32 +++++++
 .../selftests/kvm/include/x86/tdx/tdx.h       | 12 +++
 .../selftests/kvm/include/x86/tdx/test_util.h | 41 ++++++++
 .../selftests/kvm/lib/x86/tdx/tdcall.S        | 95 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 27 ++++++
 .../selftests/kvm/lib/x86/tdx/test_util.c     | 61 ++++++++++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 47 +++++++++
 8 files changed, 319 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/test_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_vm_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 8e7a12d74745..e98d5413991a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -30,6 +30,9 @@ LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
 LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/tdx/td_boot.S
+LIBKVM_x86 += lib/x86/tdx/tdcall.S
+LIBKVM_x86 += lib/x86/tdx/tdx.c
+LIBKVM_x86 += lib/x86/tdx/test_util.c
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
@@ -141,6 +144,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += x86/tdx_vm_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
new file mode 100644
index 000000000000..a6c966e93486
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Adapted from arch/x86/include/asm/shared/tdx.h */
+
+#ifndef SELFTESTS_TDX_TDCALL_H
+#define SELFTESTS_TDX_TDCALL_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
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
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
new file mode 100644
index 000000000000..a7161efe4ee2
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
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
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
new file mode 100644
index 000000000000..07d63bf1ffe1
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
@@ -0,0 +1,41 @@
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
+/* Port I/O direction */
+#define PORT_READ	0
+#define PORT_WRITE	1
+
+/*
+ * Run a test in a new process.
+ *
+ * There might be multiple tests running and if one test fails, it will
+ * prevent the subsequent tests to run due to how tests are failing with
+ * TEST_ASSERT function. run_in_new_process() will run a test in a new process
+ * context and wait for it to finish or fail to prevent TEST_ASSERT to kill the
+ * main testing process.
+ */
+int run_in_new_process(void (*func)(void));
+
+/*
+ * Verify that the TDX is supported by KVM.
+ */
+bool is_tdx_enabled(void);
+
+/*
+ * Report test success to userspace.
+ *
+ * Use tdx_test_assert_success() to assert that this function was called in the
+ * guest.
+ */
+void tdx_test_success(void);
+void tdx_test_assert_success(struct kvm_vcpu *vcpu);
+
+#endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
new file mode 100644
index 000000000000..b10769d1d557
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Adapted from arch/x86/coco/tdx/tdcall.S */
+
+/*
+ * TDCALL is supported in Binutils >= 2.36, add it for older version.
+ */
+#define tdcall		.byte 0x66,0x0f,0x01,0xcc
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
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
new file mode 100644
index 000000000000..f417ee75bee2
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+
+uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
+				      uint64_t write, uint64_t *data)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_IO,
+		.r12 = size,
+		.r13 = write,
+		.r14 = port,
+	};
+	uint64_t ret;
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
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
new file mode 100644
index 000000000000..7355b213c344
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kvm_util.h"
+#include "tdx/tdx.h"
+#include "tdx/test_util.h"
+
+int run_in_new_process(void (*func)(void))
+{
+	int wstatus;
+	pid_t ret;
+
+	if (fork() == 0) {
+		func();
+		exit(0);
+	}
+	ret = wait(&wstatus);
+	if (ret == -1)
+		return -1;
+
+	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus))
+		return -1;
+	else if (WIFSIGNALED(wstatus))
+		return -1;
+
+	return 0;
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
+	tdg_vp_vmcall_instruction_io(TDX_TEST_SUCCESS_PORT, TDX_TEST_SUCCESS_SIZE,
+				     PORT_WRITE, &code);
+}
+
+/*
+ * Assert that tdx_test_success() was called in the guest.
+ */
+void tdx_test_assert_success(struct kvm_vcpu *vcpu)
+{
+	TEST_ASSERT((vcpu->run->exit_reason == KVM_EXIT_IO) &&
+		    (vcpu->run->io.port == TDX_TEST_SUCCESS_PORT) &&
+		    (vcpu->run->io.size == TDX_TEST_SUCCESS_SIZE) &&
+		    (vcpu->run->io.direction == PORT_WRITE),
+		    "Unexpected exit values while waiting for test completion: %u (%s) %d %d %d\n",
+		    vcpu->run->exit_reason,
+		    exit_reason_str(vcpu->run->exit_reason),
+		    vcpu->run->io.port, vcpu->run->io.size,
+		    vcpu->run->io.direction);
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
new file mode 100644
index 000000000000..fdb7c40065a6
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <signal.h>
+
+#include "kvm_util.h"
+#include "tdx/tdx_util.h"
+#include "tdx/test_util.h"
+#include "test_util.h"
+
+static void guest_code_lifecycle(void)
+{
+	tdx_test_success();
+}
+
+static void verify_td_lifecycle(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_lifecycle);
+	td_finalize(vm);
+
+	printf("Verifying TD lifecycle:\n");
+
+	vcpu_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+
+	if (!is_tdx_enabled())
+		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
+
+	ksft_set_plan(1);
+	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
+			 "verify_td_lifecycle\n");
+
+	ksft_finished();
+	return 0;
+}
-- 
2.49.0.504.g3bcea36a83-goog


