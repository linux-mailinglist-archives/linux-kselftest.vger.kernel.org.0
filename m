Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C675A7087
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiH3WUR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiH3WUN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:20:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D732201BF
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:11 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id cj15-20020a056a00298f00b0053a700f1178so1395826pfb.14
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=T9yOZxwNH1Vwea4FbMMjM8N2gmoqmFgTmVLKZvXCyGw=;
        b=eOlvFAgZHsItzGfjv1tWpFsZXrOJO22R3iWXR8OZBM91PKIkAjTfnCHMDNUvt+SdhZ
         Bm6lmB7UOemd4FkIOLnGeMo6bCoB6YH2EvQJiroRFzf8w0AfjL8GSBHSQDD1a7Q084dB
         2LHamFKzMB7cIe94d4EsxfRHbl0zxq7TTcNYGFq2r2o5TJWSQkMVnMxPxEuoPYgKpCQ9
         ST35fHZqFlS03jmaCfdmYLlJJchkR4S+iPX+2JSVH2IKBkdMPPod97mx5tS3rgEWa3kd
         GY08Y4z9mbP5elCtcrPjQPNzQbKoZsjDT0/qh7F5wRv2WKNtye4tdGj/3cp0R0E+iedR
         00Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=T9yOZxwNH1Vwea4FbMMjM8N2gmoqmFgTmVLKZvXCyGw=;
        b=52L7l/YWc+RiUyYc39PC2pOctjVWWROqOzFkQqSP65oM0lYIdeKXc7Q8CNuEGc46lH
         znrstEckQgw/5PlJKboI8cJz5fSD50jXaQKmjwjl5y9jQ7eJOejz/ROS2OpfWQ5IpDu9
         wyPzbDzIzGDGrsn/3K1ZPNYfNFvRm2jFqdKR+RdZJvzVYvTESpFPdmt3fxxRJkOfPflh
         DV0+B+hj31OxunpCOABncR5PFeOjahNC7Yo34yUVVvgk4dWo6soWuYWBlKNOqX2zX9Ko
         ZZE7lX2ZRCNHvliDaVJXaEzbDyf50OudLyS8k1I5gN+JALKROl1OkkAM80/CR6zftOOl
         vynQ==
X-Gm-Message-State: ACgBeo2GUsC9jN8JiO5uUPPUmsU48hRZh52tvx3oFPrEzI9pwFhsvVxo
        K20UV1zMYuUpIAZyuGl/8Y9azeFg0ROXALZim9Lcjm+I8rimcQ3P+7K2z1zy5anugNwEtODTKfb
        Nk4mjHZLgP/kkT542Jp0DwnLwlFYRFriPXgWO/uoVB/ZgfSr7bsHYsm50R5eYCsqyldP+uTs=
X-Google-Smtp-Source: AA6agR49dftSu7HryzIxwzZ7zqElJ1O/VcP3iP5eNArJd97RI7PeT9sdyt8bgBBm02Y5j1XhYfDwyGnqGA==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a63:fb56:0:b0:429:983f:b91e with SMTP id
 w22-20020a63fb56000000b00429983fb91emr19753498pgj.399.1661898010578; Tue, 30
 Aug 2022 15:20:10 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:46 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-4-sagis@google.com>
Subject: [RFC PATCH v2 03/17] KVM: selftest: Adding TDX life cycle test.
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Ryan Afranji <afranji@google.com>,
        Roger Wang <runanwang@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>, Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Erdem Aktas <erdemaktas@google.com>

Adding a test to verify TDX lifecycle by creating a TD and running a
dummy TDVMCALL<INSTRUCTION.IO> inside it.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  | 149 ++++++++++++++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 104 ++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ad4d60dadc06..208e0cc30048 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -140,6 +140,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 += system_counter_offset_test
+TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index 61b997dfc420..d5de52657112 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -51,6 +51,12 @@
 #define _PAGE_RW            (1UL<<1)       /* writeable */
 #define _PAGE_PS            (1UL<<7)       /* page size bit*/
 
+#define TDX_INSTRUCTION_IO 30
+
+#define TDX_SUCCESS_PORT 0x30
+#define TDX_IO_READ 0
+#define TDX_IO_WRITE 1
+
 #define GDT_ENTRY(flags, base, limit)				\
 		((((base)  & 0xff000000ULL) << (56-24)) |	\
 		 (((flags) & 0x0000f0ffULL) << 40) |		\
@@ -83,4 +89,147 @@ void prepare_source_image(struct kvm_vm *vm, void *guest_code,
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
+static inline uint64_t tdvmcall_io(uint64_t port, uint64_t size,
+				   uint64_t write, uint64_t *data)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_INSTRUCTION_IO;
+	regs.r12 = size;
+	regs.r13 = write;
+	regs.r14 = port;
+	if (write) {
+		regs.r15 = *data;
+		regs.rcx = 0xFC00;
+	} else {
+		regs.rcx = 0x7C00;
+	}
+	tdcall(&regs);
+	if (!write)
+		*data = regs.r11;
+	return regs.r10;
+}
+
+/*
+ * Report test success to user space.
+ */
+static inline void tdvmcall_success(void)
+{
+	uint64_t code = 0;
+
+	tdvmcall_io(TDX_SUCCESS_PORT, /*size=*/4, TDX_IO_WRITE, &code);
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
index 000000000000..590e45aa7570
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <fcntl.h>
+#include <limits.h>
+#include <kvm_util.h>
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
+#define CHECK_GUEST_COMPLETION(VCPU)								\
+	(TEST_ASSERT(										\
+		((VCPU)->run->exit_reason == KVM_EXIT_IO) &&					\
+		((VCPU)->run->io.port == TDX_SUCCESS_PORT) &&					\
+		((VCPU)->run->io.size == 4) &&							\
+		((VCPU)->run->io.direction == TDX_IO_WRITE),					\
+		"Unexpected exit values while waiting for test complition: %u (%s) %d %d %d\n",	\
+		(VCPU)->run->exit_reason, exit_reason_str((VCPU)->run->exit_reason),		\
+		(VCPU)->run->io.port, (VCPU)->run->io.size, (VCPU)->run->io.direction))
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
+	tdvmcall_success();
+}
+
+/*
+ * TD lifecycle test will create a TD which runs a dumy IO exit to verify that
+ * the guest TD has been created correctly.
+ */
+void verify_td_lifecycle(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	printf("Verifying TD lifecycle:\n");
+	/* Create a TD VM with no memory.*/
+	vm = vm_create_tdx();
+
+	/* Allocate TD guest memory and initialize the TD.*/
+	initialize_td(vm);
+
+	/* Initialize the TD vcpu and copy the test code to the guest memory.*/
+	vcpu = vm_vcpu_add_tdx(vm, 0);
+
+	/* Setup and initialize VM memory */
+	prepare_source_image(vm, guest_dummy_exit,
+			     TDX_FUNCTION_SIZE(guest_dummy_exit), 0);
+	finalize_td_memory(vm);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+int main(int argc, char **argv)
+{
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
2.37.2.789.g6183377224-goog

