Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88EC58515F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jul 2022 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiG2OPq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jul 2022 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbiG2OPj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jul 2022 10:15:39 -0400
X-Greylist: delayed 1528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Jul 2022 07:15:37 PDT
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E27743C1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jul 2022 07:15:37 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oHQNm-004MP4-V5; Fri, 29 Jul 2022 15:50:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=hMw5w0EPif8FZOb6nZWrBE2MciY2imMiWQdD6+Ag/JU=; b=Pk3UDt93B+3EWuyx34lGybLHZX
        90bqJRslq8t+o2E8O1LOtgnO+lCOl3oqsYPrNnMVbDbHr6npwd8WeVxAKV4NfGAIKyU3gDgZwgoRq
        D5dErLiCgEQHEjfRVHU7IXjpjbGaQKEYhhqlUa0bL/EP6+KFdKba1ZEt87LnQHTUgovplYJFYYVr7
        BFDt+DPulBtEyeWUv2ONkCFDTO3Sullmyu8CP5QLhpdeM8fOqFsXqDCWLbCgmTUWWeWZJrzZKmCsw
        RIteNZa2WnqmYukJ9etkjsjMdq4sUf+b9E0pDbSHhTEjJIBkk4u3kmlEViSbXbbu2JTGV0ZFlqWmQ
        LN0oDk+g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oHQNm-0006Ir-Gj; Fri, 29 Jul 2022 15:50:26 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oHQNV-0001bD-K1; Fri, 29 Jul 2022 15:50:09 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, seanjc@google.com,
        pbonzini@redhat.com, shuah@kernel.org, Michal Luczaj <mhal@rbox.co>
Subject: [PATCH 2/2] KVM: selftests: x86: Test illegal LEA handling
Date:   Fri, 29 Jul 2022 15:48:03 +0200
Message-Id: <20220729134801.1120-2-mhal@rbox.co>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220729134801.1120-1-mhal@rbox.co>
References: <20220729134801.1120-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check if the emulator reveals host's kernel memory address.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Although checkpatch complains about the use of `extern`, I am sending this
as it is. Let me know if you need it in some better form.

[unpatched]$ ./tools/testing/selftests/kvm/x86_64/emulator_illegal_lea
==== Test Assertion Failure ====
  x86_64/emulator_illegal_lea.c:129: uc->args[0] == 0
  pid=957 tid=957 errno=4 - Interrupted system call
     1	: check_state at emulator_illegal_lea.c:129
     2	: main at emulator_illegal_lea.c:169 (discriminator 1)
     3	: ?? ??:0
     4	: ?? ??:0
     5	: _start at ??:?
  Host's address leaked: 0xffff88811a5d3620 (2)

[patched]$ ./tools/testing/selftests/kvm/x86_64/emulator_illegal_lea
[patched]$

 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/emulator_illegal_lea.c         | 180 ++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/emulator_illegal_lea.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 4509a3a7eeae..8977458080b9 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -17,6 +17,7 @@
 /x86_64/debug_regs
 /x86_64/evmcs_test
 /x86_64/emulator_error_test
+/x86_64/emulator_illegal_lea
 /x86_64/fix_hypercall_test
 /x86_64/get_msr_index_features
 /x86_64/kvm_clock_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 22423c871ed6..453cd34e1fde 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -75,6 +75,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
 TEST_GEN_PROGS_x86_64 += x86_64/emulator_error_test
+TEST_GEN_PROGS_x86_64 += x86_64/emulator_illegal_lea
 TEST_GEN_PROGS_x86_64 += x86_64/fix_hypercall_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_clock
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
diff --git a/tools/testing/selftests/kvm/x86_64/emulator_illegal_lea.c b/tools/testing/selftests/kvm/x86_64/emulator_illegal_lea.c
new file mode 100644
index 000000000000..5f0704e04fac
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/emulator_illegal_lea.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test for handling of illegal (ModRM mod = 3) LEA.
+ *
+ * To trigger the emulator and feed it with LEA, we VM-exit on IO (with a
+ * single OUTS), then race decoder's instruction fetch - hoping to replace the
+ * initial IO op with an illegal LEA.
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <string.h>
+#include <pthread.h>
+#include <sys/mman.h>
+
+/* defined in tools/testing/selftests/kvm/lib/x86_64/ucall.c */
+#define UCALL_PIO_PORT ((uint16_t)0x1000)
+
+#define VCPU_ID 0
+#define NOT_UCALL_PORT ((uint16_t)~UCALL_PIO_PORT)
+#define MAX_ATTEMPTS 0x10000
+#define MAYBE_KERNEL(addr) ((int64_t)(addr) < 0)
+
+extern uint32_t race_op;
+
+static void guest_ud_handler(struct ex_regs *regs)
+{
+	GUEST_ASSERT(regs->rip == (uint64_t)&race_op);
+	regs->rip += 4;
+}
+
+__aligned(0x1000) __attribute__((naked)) static void guest_code(void)
+{
+	uint32_t n = 1;
+	void *readable;
+	uint64_t rax;
+
+	do {
+		rax = 0;
+		readable = &guest_code;
+		/*
+		 * This is where
+		 *   3e 3e 3e 6f    outsl (%rsi), %dx
+		 * will be turned into
+		 *   3e 48 8d c0    lea rax (!), rax
+		 * Both instructions padded to 32 bits with DS prefixes.
+		 */
+		asm volatile(".align 8\n\t"
+			     "race_op:\n\t"
+			     "ds\n\t"
+			     "ds\n\t"
+			     "ds\n\t"
+			     "outsl (%[readable]), %[port]\n\t"
+			     ".fill 8, 1, 0x90"
+			     : [rax] "=a" (rax)
+			     : [readable] "S" (readable),
+			       [port] "d" (NOT_UCALL_PORT));
+	} while (!MAYBE_KERNEL(rax) && n++ < MAX_ATTEMPTS);
+
+	ucall(UCALL_DONE, 2, rax, n);
+}
+
+__attribute__((naked)) static void asm_lea(void)
+{
+	asm volatile("ds\n\t"
+		     "lea (%rax), %rax");
+}
+
+__attribute__((naked)) static void asm_outs(void)
+{
+	asm volatile("ds\n\t"
+		     "ds\n\t"
+		     "ds\n\t"
+		     "outsl (%rsi), %dx");
+}
+
+void *racer(void *arg)
+{
+	uint32_t *ptr = arg;
+	uint32_t lea, outs;
+
+	memcpy(&lea, &asm_lea, sizeof(lea));
+	/* set modrm mod = 3 */
+	lea |= 0xc0000000;
+
+	memcpy(&outs, &asm_outs, sizeof(outs));
+
+	while (true) {
+		*ptr = outs;
+		sched_yield();
+		*ptr = lea;
+		sched_yield();
+		pthread_testcancel();
+	};
+}
+
+int check_exit_reason(struct kvm_run *run)
+{
+	switch (run->exit_reason) {
+	case KVM_EXIT_IO:
+		/* race lost: OUTS was executed; ignore and retry */
+		TEST_ASSERT(run->io.port == NOT_UCALL_PORT,
+			    "Unexpected IO port: %u",
+			    run->io.port);
+		return 1;
+	case KVM_EXIT_INTERNAL_ERROR:
+		/* emulator hit bad LEA and bailed out; well done */
+		ASSERT_EQ(*(uint32_t *)&run->emulation_failure.insn_bytes,
+			  *(uint32_t *)&asm_lea | 0xc0000000);
+		TEST_ASSERT(run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION,
+			    "Unexpected suberror: %u",
+			    run->internal.suberror);
+		return 0;
+	default:
+		TEST_FAIL("Unexpected VM exit: %s",
+			  exit_reason_str(run->exit_reason));
+	}
+
+	__builtin_unreachable();
+}
+
+int check_state(struct kvm_run *run, struct ucall *uc)
+{
+	switch (uc->cmd) {
+	case UCALL_NONE:
+		return check_exit_reason(run);
+	case UCALL_DONE:
+		TEST_ASSERT(uc->args[0] == 0,
+			    "Host's address leaked: %#lx (%lu)",
+			    uc->args[0], uc->args[1]);
+		return 0;
+	case UCALL_ABORT:
+		TEST_FAIL("UCALL_ABORT: %s, line %ld\n",
+			  (char *)uc->args[0], uc->args[1]);
+	case UCALL_UNHANDLED:
+		TEST_FAIL("UCALL_UNHANDLED: #%ld\n", uc->args[0]);
+	default:
+		TEST_FAIL("Unexpected ucall");
+	}
+
+	__builtin_unreachable();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	pthread_t thread;
+	struct ucall uc;
+	int ret;
+
+	ret = mprotect(&guest_code, 0x1000, PROT_READ | PROT_WRITE | PROT_EXEC);
+	TEST_ASSERT(ret == 0, "mprotect() failed: %s", strerror(errno));
+
+	vm = vm_create_default(VCPU_ID, 0, (void *)guest_code);
+	run = vcpu_state(vm, VCPU_ID);
+
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
+
+	ret = pthread_create(&thread, 0, racer, addr_gva2hva(vm, (vm_vaddr_t)&race_op));
+	TEST_ASSERT(ret == 0, "pthread_create() failed: %s", strerror(ret));
+
+	do {
+		vcpu_run(vm, VCPU_ID);
+		get_ucall(vm, VCPU_ID, &uc);
+	} while (check_state(run, &uc));
+
+	ret = pthread_cancel(thread);
+	TEST_ASSERT(ret == 0, "pthread_cancel() failed: %s", strerror(ret));
+
+	ret = pthread_join(thread, 0);
+	TEST_ASSERT(ret == 0, "pthread_join() failed: %s", strerror(ret));
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.32.0

