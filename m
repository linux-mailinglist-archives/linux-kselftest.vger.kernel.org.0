Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437B67E5DC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjKHTA7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjKHTAg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BDD2125;
        Wed,  8 Nov 2023 11:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470030; x=1731006030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WncAUid6KO1Ivbzdf2tCq4CfgWTAb6KTypc2P94NIhE=;
  b=KDc9GfIymhcVTqwrY9TVJlJj9eScoUCT6lrh6K35oBCrWidV9QyypQJj
   s1Kkiha9B3U9kh2dxasEK1vU/Z6tWxFUoThAs6SLr05XHqHJ4mBUiYK9i
   Ey0q3LsRWNSFewdpse/O6kEeG5mhOw0wZizByZVRJTBAx/MdvMJea523b
   fOnDfQb7jtSndVgeXwmpK9g6TiWZvQm0Nyh1xwSGcuypWsiA2xZo/+mva
   8cc4nSiZ4J9jc7BQnd+7akMS0hOh+9GldHFsWuzmUe1Bj+w/gtV9hZn9I
   EKa1PTjJsSDP/NAEtuuH9abrZ+m5uJon1kODytrvhHIp58W/mXFWl8ce1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486478"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486478"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892522"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:28 -0800
From:   Xin Li <xin3.li@intel.com>
To:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, vkuznets@redhat.com, peterz@infradead.org,
        ravi.v.shankar@intel.com
Subject: [PATCH v1 23/23] KVM: selftests: Add fred exception tests
Date:   Wed,  8 Nov 2023 10:30:03 -0800
Message-ID: <20231108183003.5981-24-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Shan Kang <shan.kang@intel.com>

Add tests for FRED event data and VMX nested-exception.

FRED is designed to save a complete event context in its stack frame,
e.g., FRED saves the faulting linear address of a #PF into a 64-bit
event data field defined in FRED stack frame.  As such, FRED VMX adds
event data handling during VMX transitions.

FRED introduces event stack levels to dispatch an event handler onto a
stack baesd on current stack level and stack levels defined in
IA32_FRED_STKLVLS MSR for each exception vector.  VMX nested-exception
support ensures a correct event stack level is chosen when a VM entry
injects a nested exception, which is "regarded" as occurred in ring 0.

Signed-off-by: Shan Kang <shan.kang@intel.com>
Co-developed-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/processor.h  |  29 ++
 .../testing/selftests/kvm/x86_64/fred_test.c  | 262 ++++++++++++++++++
 3 files changed, 292 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/fred_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a5963ab9215b..06d16e59aa3c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -76,6 +76,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
 TEST_GEN_PROGS_x86_64 += x86_64/exit_on_emulation_failure_test
 TEST_GEN_PROGS_x86_64 += x86_64/fix_hypercall_test
 TEST_GEN_PROGS_x86_64 += x86_64/hwcr_msr_test
+TEST_GEN_PROGS_x86_64 += x86_64/fred_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_clock
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_evmcs
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 165d21fd1577..9c26705aa320 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1260,4 +1260,33 @@ void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 #define PFERR_GUEST_PAGE_MASK	BIT_ULL(PFERR_GUEST_PAGE_BIT)
 #define PFERR_IMPLICIT_ACCESS	BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
 
+/*
+ * FRED related data structures and functions
+ */
+struct fred_stack {
+	u64 r15;
+	u64 r14;
+	u64 r13;
+	u64 r12;
+	u64 bp;
+	u64 bx;
+	u64 r11;
+	u64 r10;
+	u64 r9;
+	u64 r8;
+	u64 ax;
+	u64 cx;
+	u64 dx;
+	u64 si;
+	u64 di;
+	u64 error_code;
+	u64 ip;
+	u64 csx;
+	u64 flags;
+	u64 sp;
+	u64 ssx;
+	u64 event_data;
+	u64 reserved;
+};
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/x86_64/fred_test.c b/tools/testing/selftests/kvm/x86_64/fred_test.c
new file mode 100644
index 000000000000..ed117db017cd
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/fred_test.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FRED nested exception tests
+ *
+ * Copyright (C) 2023, Intel, Inc.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <asm/msr-index.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+#include "guest_modes.h"
+#include "processor.h"
+
+#define FRED_STKLVL(v,l)		(_AT(unsigned long, l) << (2 * (v)))
+#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
+
+/* This address is already mapped in guest page table. */
+#define FRED_VALID_RSP			0x8000
+
+/*
+ * The following addresses are not yet mapped in both EPT and guest page
+ * tables at the beginning.  As a result, it causes an EPT violation VM
+ * exit with an original guest #PF to access any of them for the first
+ * time.
+ *
+ * Use these addresses as guest FRED RSP0 to generate nested #PFs to test
+ * if event data are properly virtualized.
+ */
+static unsigned long fred_invalid_rsp[4] = {
+	0x0,
+	0xf0000000,
+	0xe0000000,
+	0xd0000000,
+};
+
+extern char asm_user_wrmsr[];
+extern char asm_user_ud[];
+extern char asm_done_fault[];
+
+extern void asm_test_fault(int test);
+
+/*
+ * user level code for triggering faults.
+ */
+asm(".pushsection .text\n"
+    ".type asm_user_wrmsr, @function\n"
+    ".align 4096\n"
+    "asm_user_wrmsr:\n"
+    /* Trigger a #GP */
+    "wrmsr\n"
+
+    ".fill asm_user_ud - ., 1, 0xcc\n"
+
+    ".type asm_user_ud, @function\n"
+    ".org asm_user_wrmsr + 16\n"
+    "asm_user_ud:\n"
+    /* Trigger a #UD */
+    "ud2\n"
+
+    ".align 4096, 0xcc\n"
+    ".popsection");
+
+/* Send current stack level and #PF address */
+#define GUEST_SYNC_CSL_FA(__stage, __pf_address)		\
+	GUEST_SYNC_ARGS(__stage, __pf_address, 0, 0, 0)
+
+void fred_entry_from_user(struct fred_stack *stack)
+{
+	u32 current_stack_level = rdmsr(MSR_IA32_FRED_CONFIG) & 0x3;
+
+	GUEST_SYNC_CSL_FA(current_stack_level, stack->event_data);
+
+	/* Do NOT go back to user level, continue the next test instead */
+	stack->ssx = 0x18;
+	stack->csx = 0x10;
+	stack->ip = (u64)&asm_done_fault;
+}
+
+void fred_entry_from_kernel(struct fred_stack *stack)
+{
+	TEST_FAIL("kernel events not allowed in FRED tests.");
+}
+
+#define PUSH_REGS	\
+	"push %rdi\n"	\
+	"push %rsi\n"	\
+	"push %rdx\n"	\
+	"push %rcx\n"	\
+	"push %rax\n"	\
+	"push %r8\n"	\
+	"push %r9\n"	\
+	"push %r10\n"	\
+	"push %r11\n"	\
+	"push %rbx\n"	\
+	"push %rbp\n"	\
+	"push %r12\n"	\
+	"push %r13\n"	\
+	"push %r14\n"	\
+	"push %r15\n"
+
+#define POP_REGS	\
+	"pop %r15\n"	\
+	"pop %r14\n"	\
+	"pop %r13\n"	\
+	"pop %r12\n"	\
+	"pop %rbp\n"	\
+	"pop %rbx\n"	\
+	"pop %r11\n"	\
+	"pop %r10\n"	\
+	"pop %r9\n"	\
+	"pop %r8\n"	\
+	"pop %rax\n"	\
+	"pop %rcx\n"	\
+	"pop %rdx\n"	\
+	"pop %rsi\n"	\
+	"pop %rdi\n"
+
+/*
+ * FRED entry points.
+ */
+asm(".pushsection .text\n"
+    ".type asm_fred_entrypoint_user, @function\n"
+    ".align 4096\n"
+    "asm_fred_entrypoint_user:\n"
+    "endbr64\n"
+    PUSH_REGS
+    "movq %rsp, %rdi\n"
+    "call fred_entry_from_user\n"
+    POP_REGS
+    /* Do NOT go back to user level, continue the next test instead */
+    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
+
+    ".fill asm_fred_entrypoint_kernel - ., 1, 0xcc\n"
+
+    ".type asm_fred_entrypoint_kernel, @function\n"
+    ".org asm_fred_entrypoint_user + 256\n"
+    "asm_fred_entrypoint_kernel:\n"
+    "endbr64\n"
+    PUSH_REGS
+    "movq %rsp, %rdi\n"
+    "call fred_entry_from_kernel\n"
+    POP_REGS
+    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
+    ".align 4096, 0xcc\n"
+    ".popsection");
+
+extern char asm_fred_entrypoint_user[];
+
+/*
+ * Prepare a FRED stack frame for ERETU to run user level code, WRMSR or UD,
+ * which causes a #GP or #UD.  However because FRED RSP0 is not yet mapped
+ * in guest page table, the delivery of the #GP or #UD causes a nested #PF,
+ * which is then delivered on FRED RSPx (x is 1, 2 or 3, determinated by MSR
+ * FRED_STKLVL(PF_VECTOR)).
+ *
+ * If FRED RSPx is also not yet mapped in guest page table, a triple fault is
+ * generated.
+ */
+asm(".pushsection .text\n"
+    ".type asm_test_fault, @function\n"
+    ".align 4096\n"
+    "asm_test_fault:\n"
+    "endbr64\n"
+    "push %rbp\n"
+    "mov %rsp, %rbp\n"
+    "and $(~0x3f), %rsp\n"
+    "push $0\n"
+    "push $0\n"
+    "mov $0x2b, %rax\n"
+    "bts $57, %rax\n"
+    "push %rax\n"
+    /* The FRED user level test code does NOT need a stack. */
+    "push $0\n"
+    "pushf\n"
+    "mov $0x33, %rax\n"
+    "push %rax\n"
+    "cmp $0, %edi\n"
+    "jne 1f\n"
+    "lea asm_user_wrmsr(%rip), %rax\n"
+    "jmp 2f\n"
+    "1: lea asm_user_ud(%rip), %rax\n"
+    "2: push %rax\n"
+    "push $0\n"
+    /* ERETU to user level code to generate a fault immediately */
+    ".byte 0xf3,0x0f,0x01,0xca\n"
+    "asm_done_fault:\n"
+    "mov %rbp, %rsp\n"
+    "pop %rbp\n"
+    "ret\n"
+    ".align 4096, 0xcc\n"
+    ".popsection");
+
+static void guest_code(void)
+{
+	wrmsr(MSR_IA32_FRED_CONFIG,
+	      FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
+
+	wrmsr(MSR_IA32_FRED_RSP1, FRED_VALID_RSP);
+	wrmsr(MSR_IA32_FRED_RSP2, FRED_VALID_RSP);
+	wrmsr(MSR_IA32_FRED_RSP3, FRED_VALID_RSP);
+
+	/* Enable FRED */
+	set_cr4(get_cr4() | X86_CR4_FRED);
+
+	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 1));
+	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[1]);
+	/* 0: wrmsr to generate #GP */
+	asm_test_fault(0);
+
+	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 2));
+	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[2]);
+	/* 1: ud2 to generate #UD */
+	asm_test_fault(1);
+
+	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 3));
+	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[3]);
+	/* 0: wrmsr to generate #GP */
+	asm_test_fault(0);
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint64_t expected_current_stack_level = 1;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_FRED));
+
+	vm = __vm_create_with_vcpus(VM_MODE_PXXV48_4K_USER, 1, 0,
+				    guest_code, &vcpu);
+
+	while (true) {
+		uint64_t r;
+
+		vcpu_run(vcpu);
+
+		r = get_ucall(vcpu, &uc);
+
+		if (r == UCALL_DONE)
+			break;
+
+		if (r == UCALL_SYNC) {
+			TEST_ASSERT((uc.args[1] == expected_current_stack_level) &&
+				    (uc.args[2] == fred_invalid_rsp[expected_current_stack_level] - 1),
+				    "Incorrect stack level %lx and #PF address %lx\n",
+				    uc.args[1], uc.args[2]);
+			expected_current_stack_level++;
+		}
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.42.0

