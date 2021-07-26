Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C713D66DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jul 2021 20:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhGZSCX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhGZSCW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 14:02:22 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C375C061764
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 11:42:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r23-20020a17090aa097b0290176fc47a8b7so144699pjp.6
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C35LkxlAv83GZqKJld/g6dVWtLYawkNIe+u7DQACAP0=;
        b=qOB3U6OXTmMQ8XAQEkniqZb5GHv9bjOUG90TAfp6aW35MZq0XLSsawV3SfZNiCkloH
         kWpWsjxyZYh2d9vt5skTr4QJCp78DRWmEOk5LaokFT0Xwxy8aYQzgy1gV7hLldz+oEez
         tJ//qWz+9uva37WMlNnAXdPOUYZEOZwgsImcECTdqWj1sQOYvISALG8F5SQR1kMGcyiv
         oDM0TNKo9d2rp/Gq6NXPtL+gMvJFUpS8P891LJ5IcHsi9/KzyOJGSxZt3cKAPb/BYBx/
         pOL1wQtStO+l0+4ZkI9Sc73ujrUXF/zak3qmTe3TpvDjGGtO+IBzOvOcAC6FPd0TJiXp
         SDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C35LkxlAv83GZqKJld/g6dVWtLYawkNIe+u7DQACAP0=;
        b=k8skrwAluXgSYzzffQJ5a/z+0rZHg3Nj6oJZTk+dy9ZTtS45BojIDP6/itCAOLQUar
         4aTCORwNTfM0JMfrP0njbp8mNl78xJb8WqCorCS0a3MfprDW9pne/SgjoQwzTWciULms
         EDWNCwRoWfLVxbQvhvHd5U49w7S66GL9cag1GDC9AYpJMZnxD05V3A3d4m4LaR+Q7KSf
         7Qk+ChAqLXCsgnObxQyUJBpAOoY/KaYmQOw/tK+EskFDcZ3AML+ctnbkaOoEXI2YBibN
         WNcxC25bBBZYU8d1ABMbuUJJwzGEpz3TyhXz6/7QV0vmhXQYIM+hj4ZXzZ7JKYjAP+I3
         LGIQ==
X-Gm-Message-State: AOAM531lTEH9qTdcueL0+AQ5I4czK/suanVpJvV2KGLFi2IBwjEVCrDY
        kskDgNAX/Kr7V6UlkLBxC1YynpN5HSP0PnROh+1hNgCllm3WW6Qv2t9tnPO2UtTIjxYC9r9Yok5
        FWjO9gZhjtSkFwNumG4sXYvUD+w9bWL/y7BjlPEUEgExveOEp2wJ2crB+LXvXfm93qFnP/m8jwI
        kQg2eaHVmr
X-Google-Smtp-Source: ABdhPJy/JcwgwWD0KhEVUoPmwYerjPzB807mpcLc15+LcP6ToyicmDU9VMJnBJP0DBcS/lwtITLsuEQMd2sMPuWK
X-Received: from nehir.kir.corp.google.com ([2620:15c:29:204:e222:115f:790c:cd0f])
 (user=erdemaktas job=sendgmr) by 2002:a17:902:c9cb:b029:12b:9a0c:9c65 with
 SMTP id q11-20020a170902c9cbb029012b9a0c9c65mr15635150pld.61.1627324969930;
 Mon, 26 Jul 2021 11:42:49 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:37:56 -0700
In-Reply-To: <20210726183816.1343022-1-erdemaktas@google.com>
Message-Id: <20210726183816.1343022-4-erdemaktas@google.com>
Mime-Version: 1.0
References: <20210726183816.1343022-1-erdemaktas@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [RFC PATCH 3/4] KVM: selftest: Adding TDX life cycle test.
From:   Erdem Aktas <erdemaktas@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Sagi Shahar <sagis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        Ricardo Koller <ricarkol@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding a test to verify TDX lifecycle by creating a TD and running a
dummy TDVMCALL<INSTRUCTION.IO> inside it.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Reviewed-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  | 131 ++++++++++++++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 102 ++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index d84c09b5e..259be634c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -72,6 +72,7 @@ TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
+TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests

 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index 6e3e8384e..395be3c81 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -86,4 +86,135 @@ void prepare_source_image(struct kvm_vm *vm, void *guest_code,
 			  size_t guest_code_size,
 			  uint64_t guest_code_signature);
 
+/*
+ * Generic TDCALL function that can be used to communicate with TDX module or
+ * VMM.
+ * Input operands: rax, rbx, rcx, rdx, r8-r15, rbp, rsi, rdi
+ * Output operands: rax, r8-r15, rbx, rdx, rdi, rsi
+ * rcx is actually a bitmap to tell TDX module which register values will be
+ * exposed to the VMM.
+ * XMM0-XMM15 registers can be used as input operands but the current
+ * implementation does not support it yet.
+ */
+static inline void tdcall(struct kvm_regs *regs)
+{
+	asm volatile (
+			"mov %13, %%rax;\n\t"
+			"mov %14, %%rbx;\n\t"
+			"mov %15, %%rcx;\n\t"
+			"mov %16, %%rdx;\n\t"
+			"mov %17, %%r8;\n\t"
+			"mov %18, %%r9;\n\t"
+			"mov %19, %%r10;\n\t"
+			"mov %20, %%r11;\n\t"
+			"mov %21, %%r12;\n\t"
+			"mov %22, %%r13;\n\t"
+			"mov %23, %%r14;\n\t"
+			"mov %24, %%r15;\n\t"
+			"mov %25, %%rbp;\n\t"
+			"mov %26, %%rsi;\n\t"
+			"mov %27, %%rdi;\n\t"
+			".byte 0x66, 0x0F, 0x01, 0xCC;\n\t"
+			"mov %%rax, %0;\n\t"
+			"mov %%rbx, %1;\n\t"
+			"mov %%rdx, %2;\n\t"
+			"mov %%r8, %3;\n\t"
+			"mov %%r9, %4;\n\t"
+			"mov %%r10, %5;\n\t"
+			"mov %%r11, %6;\n\t"
+			"mov %%r12, %7;\n\t"
+			"mov %%r13, %8;\n\t"
+			"mov %%r14, %9;\n\t"
+			"mov %%r15, %10;\n\t"
+			"mov %%rsi, %11;\n\t"
+			"mov %%rdi, %12;\n\t"
+			: "=m" (regs->rax), "=m" (regs->rbx), "=m" (regs->rdx),
+			"=m" (regs->r8), "=m" (regs->r9), "=m" (regs->r10),
+			"=m" (regs->r11), "=m" (regs->r12), "=m" (regs->r13),
+			"=m" (regs->r14), "=m" (regs->r15), "=m" (regs->rsi),
+			"=m" (regs->rdi)
+			: "m" (regs->rax), "m" (regs->rbx), "m" (regs->rcx),
+			"m" (regs->rdx), "m" (regs->r8), "m" (regs->r9),
+			"m" (regs->r10), "m" (regs->r11), "m" (regs->r12),
+			"m" (regs->r13), "m" (regs->r14), "m" (regs->r15),
+			"m" (regs->rbp), "m" (regs->rsi), "m" (regs->rdi)
+			: "rax", "rbx", "rcx", "rdx", "r8", "r9", "r10", "r11",
+			"r12", "r13", "r14", "r15", "rbp", "rsi", "rdi");
+}
+
+
+/*
+ * Do a TDVMCALL IO request
+ *
+ * Input Args:
+ *  port - IO port to do read/write
+ *  size - Number of bytes to read/write. 1=1byte, 2=2bytes, 4=4bytes.
+ *  write - 1=IO write 0=IO read
+ *  data - pointer for the data to write
+ *
+ * Output Args:
+ *  data - pointer for data to be read
+ *
+ * Return:
+ *   On success, return 0. For Invalid-IO-Port error, returns -1.
+ *
+ * Does an IO operation using the following tdvmcall interface.
+ *
+ * TDG.VP.VMCALL<Instruction.IO>-Input Operands
+ * R11 30 for IO
+ *
+ * R12 Size of access. 1=1byte, 2=2bytes, 4=4bytes.
+ * R13 Direction. 0=Read, 1=Write.
+ * R14 Port number
+ * R15 Data to write, if R13 is 1.
+ *
+ * TDG.VP.VMCALL<Instruction.IO>-Output Operands
+ * R10 TDG.VP.VMCALL-return code.
+ * R11 Data to read, if R13 is 0.
+ *
+ * TDG.VP.VMCALL<Instruction.IO>-Status Codes
+ * Error Code Value Description
+ * TDG.VP.VMCALL_SUCCESS 0x0 TDG.VP.VMCALL is successful
+ * TDG.VP.VMCALL_INVALID_OPERAND 0x80000000 00000000 Invalid-IO-Port access
+ */
+static inline int tdvmcall_io(uint64_t port, uint64_t size,
+			      uint64_t write, uint64_t *data)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = 30;
+	regs.r12 = size;
+	regs.r13 = write;
+	regs.r14 = port;
+	if (write)
+		regs.r15 = *data;
+	/* TODO: update the bitmap register with only the relavent registers */
+	regs.rcx = 0xFC00;
+	tdcall(&regs);
+	if (!write)
+		*data = regs.r11;
+	return regs.r10;
+}
+
+
+#define TDX_FUNCTION_SIZE(name) ((uint64_t)&__stop_sec_ ## name -\
+			   (uint64_t)&__start_sec_ ## name) \
+
+#define TDX_GUEST_FUNCTION__(name, section_name) \
+extern char *__start_sec_ ## name ; \
+extern char *__stop_sec_ ## name ; \
+static void \
+__attribute__((__flatten__, section(section_name))) name(void *arg)
+
+
+#define STRINGIFY2(x) #x
+#define STRINGIFY(x) STRINGIFY2(x)
+#define CONCAT2(a, b) a##b
+#define CONCAT(a, b) CONCAT2(a, b)
+
+
+#define TDX_GUEST_FUNCTION(name) \
+TDX_GUEST_FUNCTION__(name, STRINGIFY(CONCAT(sec_, name)))
+
 #endif  // KVM_LIB_TDX_H_
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
new file mode 100644
index 000000000..da7ea67b1
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <fcntl.h>
+#include <limits.h>
+#include <kvm_util.h>
+#include "../lib/kvm_util_internal.h"
+#include "../lib/x86_64/tdx.h"
+#include <linux/kvm.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <test_util.h>
+#include <unistd.h>
+#include <processor.h>
+#include <time.h>
+#include <sys/mman.h>
+#include<sys/wait.h>
+
+/*
+ * There might be multiple tests we are running and if one test fails, it will
+ * prevent the subsequent tests to run due to how tests are failing with
+ * TEST_ASSERT function. The run_in_new_process function will run a test in a
+ * new process context and wait for it to finish or fail to prevent TEST_ASSERT
+ * to kill the main testing process.
+ */
+void run_in_new_process(void (*func)(void))
+{
+	if (fork() == 0) {
+		func();
+		exit(0);
+	}
+	wait(NULL);
+}
+
+/*
+ * Verify that the TDX  is supported by the KVM.
+ */
+bool is_tdx_enabled(void)
+{
+	return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_TDX_VM));
+}
+
+/*
+ * Do a dummy io exit to verify that the TD has been initialized correctly and
+ * guest can run some code inside.
+ */
+TDX_GUEST_FUNCTION(guest_dummy_exit)
+{
+	uint64_t data;
+
+	data = 0xAB;
+	tdvmcall_io(TDX_TEST_PORT, 1, 1, &data);
+}
+
+/*
+ * TD lifecycle test will create a TD which runs a dumy IO exit to verify that
+ * the guest TD has been created correctly.
+ */
+void  verify_td_lifecycle(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_run *run;
+
+	printf("Verifying TD lifecycle:\n");
+	/* Create a TD VM with no memory.*/
+	vm = __vm_create(VM_MODE_DEFAULT, 0, O_RDWR, KVM_X86_TDX_VM);
+
+	/* Allocate TD guest memory and initialize the TD.*/
+	initialize_td(vm);
+
+	/* Initialize the TD vcpu and copy the test code to the guest memory.*/
+	vm_vcpu_add_tdx(vm, 0);
+
+	/* Setup and initialize VM memory */
+	prepare_source_image(vm, guest_dummy_exit,
+			     TDX_FUNCTION_SIZE(guest_dummy_exit), 0);
+	finalize_td_memory(vm);
+
+	run = vcpu_state(vm, 0);
+	vcpu_run(vm, 0);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+int main(int argc, char **argv)
+{
+	if (!is_tdx_enabled()) {
+		printf("TDX is not supported by the KVM\n"
+		       "Skipping the TDX tests.\n");
+		return 0;
+	}
+
+	run_in_new_process(&verify_td_lifecycle);
+
+	return 0;
+}
-- 
2.32.0.432.gabb21c7263-goog

