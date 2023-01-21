Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761CC67620F
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAUARf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjAUARa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:17:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B2C41DE
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z9-20020a25ba49000000b007d4416e3667so7512219ybj.23
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8fVu8QqTyecSUV8C3Vx7eVvdYsMLP9B/z2QHEeyWh0=;
        b=i5XEImBpyUeHSwTbKwhHcRZgMwVEdGe03n+MFsqTosDso+tBjMIOrGOnjLAM8/yky5
         N4xhtWLwaFTCrzTc1/jhO8PJF3LDPjMBTYLowMXjeYy3ymUQmO35tlGr1y8GHmtAL2sH
         sfUB4Ydijv5hmx9wqVMWbLUo216Dcss6FPXZXeM5lm5CUQdAx6DwntdQLGBama8eC7r8
         HSzcNAHXMYaquf6UWlPzQqgklPqhhRTF+U9yotPs103TVSsBYlOEoJKyXRFp2dWpM4TT
         4eifnWcKS1kd5S3guDUMqKBoGzwfieLeEnFzoL1iONxvvnVHsG59qiJLJ5KK4TKEiHWd
         oKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e8fVu8QqTyecSUV8C3Vx7eVvdYsMLP9B/z2QHEeyWh0=;
        b=I+s4axaf2NIBlitR9QCd1GQCYWYK2vl3mDQgAHuVwFb0Ov8EI48IyljUyDmIfdZ6+U
         mxJVLagWuP61lVqL3EiuAA0QUuWgCClaGX9O0SJDILxMX/KinFc6TNu7kUGNYf5UJ9M4
         UrNfhC1dod6XV73oT/RxHmC0yhqINnrKnXMjhIcBQX7MirsQeYNp7yh2RYZddazmL45m
         cuhHDF46RdQ7RcxTVdqtzS2RIqafz41pm5xPPix79gJL4j1yahrNwxEiDyB9pV/KHXXz
         St1FuCEFtZO/Xoa3LdGKPGsZZmXdu49pnwZwgGvdy2+yoUkKV4UaL7nQCDf6ackHY9ZG
         87sg==
X-Gm-Message-State: AFqh2kq+tu3s7jJs0MFtJtb/bSzdHW8P4yLm37OCfXW9cge7ZK7zNayL
        CNfkytiJu615daHp6t3Xt1Rqi1wf2GQtxUq387/EqIGWimMMa4GR87ec27O4dn/NSC6Ek0foaUb
        KuN2Iq8EYcfP2dmL7seYEhbO+uJQciHD/WL4SOrN/VOQnQmDxSqmzYXt34bNopVzTXwEssQu4fs
        V9+PAbUWyPdxg=
X-Google-Smtp-Source: AMrXdXs4cYCD+h7+e40ddRslg/axY93Tvds7sBJEjfQJwo0v5rVjQMzFA5/S09H+XvohVO57EXS5SSV7wzwv6fTLcw==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a0d:dd4e:0:b0:4eb:e96a:1c63 with SMTP
 id g75-20020a0ddd4e000000b004ebe96a1c63mr1986522ywe.82.1674260210698; Fri, 20
 Jan 2023 16:16:50 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:20 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-10-ackerleytng@google.com>
Subject: [RFC PATCH v3 09/31] KVM: selftests: TDX: Add TDX lifecycle test
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
Changes RFCv2 -> RFCv3
+ Add gitignore for tdx_vm_tests binary
+ Thanks to Isaku for the comment about saving rbp separately for gcc!
  In this revision, the assembly that wraps tdcall has been mostly taken
  from the kernel=E2=80=99s implementation, which would be familiar to you!
+ TDX test-related code is now grouped in
  tools/testing/selftests/kvm/include/x86_64/tdx/test_util.{c,h} and
  test-related functions and macros are prefixed with tdx_test to
  indicate its purpose.
---
 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  4 +
 .../selftests/kvm/include/x86_64/tdx/tdcall.h | 35 ++++++++
 .../selftests/kvm/include/x86_64/tdx/tdx.h    | 12 +++
 .../kvm/include/x86_64/tdx/test_util.h        | 52 +++++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdcall.S     | 90 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 27 ++++++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 34 +++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 45 ++++++++++
 9 files changed, 300 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/test_uti=
l.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftes=
ts/kvm/.gitignore
index 813e7610619d9..370d6430b32b4 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -65,6 +65,7 @@
 /x86_64/xss_msr_test
 /x86_64/vmx_pmu_caps_test
 /x86_64/triple_fault_event_test
+/x86_64/tdx_vm_tests
 /access_tracking_perf_test
 /demand_paging_test
 /dirty_log_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests=
/kvm/Makefile
index 5f9cc1e6ee67e..9f289322a4933 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -61,6 +61,9 @@ LIBKVM_x86_64 +=3D lib/x86_64/vmx.c
 LIBKVM_x86_64 +=3D lib/x86_64/sev.c
 LIBKVM_x86_64 +=3D lib/x86_64/tdx/tdx_util.c
 LIBKVM_x86_64 +=3D lib/x86_64/tdx/td_boot.S
+LIBKVM_x86_64 +=3D lib/x86_64/tdx/tdcall.S
+LIBKVM_x86_64 +=3D lib/x86_64/tdx/tdx.c
+LIBKVM_x86_64 +=3D lib/x86_64/tdx/test_util.c

 LIBKVM_aarch64 +=3D lib/aarch64/gic.c
 LIBKVM_aarch64 +=3D lib/aarch64/gic_v3.c
@@ -148,6 +151,7 @@ TEST_GEN_PROGS_x86_64 +=3D set_memory_region_test
 TEST_GEN_PROGS_x86_64 +=3D steal_time
 TEST_GEN_PROGS_x86_64 +=3D kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 +=3D system_counter_offset_test
+TEST_GEN_PROGS_x86_64 +=3D x86_64/tdx_vm_tests

 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86_64 +=3D x86_64/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tool=
s/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
new file mode 100644
index 0000000000000..78001bfec9c8d
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
+ * Used in __tdx_hypercall() to pass down and get back registers' values o=
f
+ * the TDCALL instruction when requesting services from the VMM.
+ *
+ * This is a software only structure and not part of the TDX module/VMM AB=
I.
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
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/t=
esting/selftests/kvm/include/x86_64/tdx/tdx.h
new file mode 100644
index 0000000000000..a7161efe4ee2e
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
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/t=
ools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
new file mode 100644
index 0000000000000..b570b6d978ff1
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
+		((VCPU)->run->exit_reason =3D=3D KVM_EXIT_IO) &&		\
+		((VCPU)->run->io.port =3D=3D TDX_TEST_SUCCESS_PORT) &&	\
+		((VCPU)->run->io.size =3D=3D TDX_TEST_SUCCESS_SIZE) &&	\
+		((VCPU)->run->io.direction =3D=3D				\
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE),		\
+		"Unexpected exit values while waiting for test completion: %u (%s) %d %d=
 %d\n", \
+		(VCPU)->run->exit_reason,				\
+		exit_reason_str((VCPU)->run->exit_reason),		\
+		(VCPU)->run->io.port, (VCPU)->run->io.size,		\
+		(VCPU)->run->io.direction))
+
+/**
+ * Run a test in a new process.
+ *
+ * There might be multiple tests we are running and if one test fails, it =
will
+ * prevent the subsequent tests to run due to how tests are failing with
+ * TEST_ASSERT function. The run_in_new_process function will run a test i=
n a
+ * new process context and wait for it to finish or fail to prevent TEST_A=
SSERT
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
+ * Use TDX_TEST_ASSERT_SUCCESS() to assert that this function was called i=
n the
+ * guest.
+ */
+void tdx_test_success(void);
+
+#endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S b/tools/te=
sting/selftests/kvm/lib/x86_64/tdx/tdcall.S
new file mode 100644
index 0000000000000..df9c1ed4bb2d1
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Adapted from arch/x86/coco/tdx/tdcall.S */
+
+#define TDX_HYPERCALL_r10 0 /* offsetof(struct tdx_hypercall_args, r10) */
+#define TDX_HYPERCALL_r11 8 /* offsetof(struct tdx_hypercall_args, r11) */
+#define TDX_HYPERCALL_r12 16 /* offsetof(struct tdx_hypercall_args, r12) *=
/
+#define TDX_HYPERCALL_r13 24 /* offsetof(struct tdx_hypercall_args, r13) *=
/
+#define TDX_HYPERCALL_r14 32 /* offsetof(struct tdx_hypercall_args, r14) *=
/
+#define TDX_HYPERCALL_r15 40 /* offsetof(struct tdx_hypercall_args, r15) *=
/
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
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testi=
ng/selftests/kvm/lib/x86_64/tdx/tdx.c
new file mode 100644
index 0000000000000..c2414523487a7
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
+	struct tdx_hypercall_args args =3D {
+		.r10 =3D TDX_HYPERCALL_STANDARD,
+		.r11 =3D TDG_VP_VMCALL_INSTRUCTION_IO,
+		.r12 =3D size,
+		.r13 =3D write,
+		.r14 =3D port,
+	};
+
+	if (write)
+		args.r15 =3D *data;
+
+	ret =3D __tdx_hypercall(&args, write ? 0 : TDX_HCALL_HAS_OUTPUT);
+
+	if (!write)
+		*data =3D args.r11;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools=
/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
new file mode 100644
index 0000000000000..6905d0ca38774
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
+	if (fork() =3D=3D 0) {
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
+	uint64_t code =3D 0;
+
+	tdg_vp_vmcall_instruction_io(TDX_TEST_SUCCESS_PORT,
+				     TDX_TEST_SUCCESS_SIZE,
+				     TDG_VP_VMCALL_INSTRUCTION_IO_WRITE, &code);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/test=
ing/selftests/kvm/x86_64/tdx_vm_tests.c
new file mode 100644
index 0000000000000..a18d1c9d60264
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
+	vm =3D td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu =3D td_vcpu_add(vm, 0, guest_code_lifecycle);
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
2.39.0.246.g2a6d74b583-goog
