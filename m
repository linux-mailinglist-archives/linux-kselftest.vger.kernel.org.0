Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E56DB8B5
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Apr 2023 06:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjDHEBA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Apr 2023 00:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDHEA5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Apr 2023 00:00:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49FDD529;
        Fri,  7 Apr 2023 21:00:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b5-20020a17090a6e0500b0023f32869993so2917549pjk.1;
        Fri, 07 Apr 2023 21:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680926452; x=1683518452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urJp/BAdSkaYpcrB6kEZ/DojlaCXwavrN0LyIu1f5qc=;
        b=L+xOxDgYR2QlpG0E+28oMr5bGUSKSCDI026WnS7qfn/uMMhdYeDpZ4xqmipJYZOp6N
         iFPK7AVQ6lrIT34uNijzFurOF5KutXjr5I9SEH/DWJUHyDkW/DezxCRlz6j5UVq71Nkr
         MNAnCWuUBPcYUYgC3nsS6f+CE4UurWHRE6Zfi15Z2XiDtklweaPOeRNSKVtRNBNKT24a
         VR9kAXS5bqiO0jEiPk0Md0QB4sIGfC+Yh0S1UexDXwknRqXcEobVrqMy397je/Qqbb90
         XEY+tyvrC0AMLNy0OJ88ZWNUDcAeTwD4oQgL9dNJZZjP49ENkNoN/vDbspCq5pzAVW7K
         4aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680926452; x=1683518452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urJp/BAdSkaYpcrB6kEZ/DojlaCXwavrN0LyIu1f5qc=;
        b=Jx8xTpuyg7vkTMqHI9c5BoXdtSlxOkxyJ/rt7TPyprqq1HmDP/zsyGyiYYHFtQt38o
         i5vWCAeUv3ZXeVb+N7NwNx0aMwhhAbRLsCI8M4kTEPAj5ECZ+uXUqwveZxaoieH/P4pB
         73o+J9fBSLWqM/wzi3CLW+hRS6FIACf5c3QzjAqB6dN0AvBPcmue4nrqkV+RVV1p3mn3
         95TTJT5weZ1IddQPScId573SWIHr+K1d3A92zbB5pohHLPeITclCFQeKMLsfTMW3sqPC
         yIvnfpAm+M45iT2KKPUaxl4aU9GcD/atB4rYP8/NEHBXzlcT0PD6PfA813Ooe93I5qmb
         xETg==
X-Gm-Message-State: AAQBX9eAV26jtldms2/T7AMKfAzZXdHfjXCxbHT81QdPax8AvlgRJGur
        Tr/7nf3GFCatulNccCkoF4Y=
X-Google-Smtp-Source: AKy350aaKgOlMhod4SyXpt2dDfiAokBi2thBWxFr3j8EfN1C1a1V+aj686JZ14hHCAO9m+SOHBpE5A==
X-Received: by 2002:a05:6a20:7a95:b0:d9:4269:4d2b with SMTP id u21-20020a056a207a9500b000d942694d2bmr742983pzh.0.1680926451906;
        Fri, 07 Apr 2023 21:00:51 -0700 (PDT)
Received: from wheely.local0.net ([203.59.189.25])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b006328ee1e56csm263872pfw.2.2023.04.07.21.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 21:00:51 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/4] KVM: PPC: selftests: add selftests sanity tests
Date:   Sat,  8 Apr 2023 14:00:20 +1000
Message-Id: <20230408040020.868929-5-npiggin@gmail.com>
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

Add tests that exercise very basic functions of the kvm selftests
framework, guest creation, ucalls, hcalls, copying data between guest
and host, interrupts and page faults.

These don't stress KVM so much as being useful when developing support
for powerpc.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/powerpc/hcall.h     |   2 +
 .../testing/selftests/kvm/powerpc/null_test.c | 166 ++++++++++++++++++
 .../selftests/kvm/powerpc/rtas_hcall.c        | 146 +++++++++++++++
 4 files changed, 316 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/powerpc/null_test.c
 create mode 100644 tools/testing/selftests/kvm/powerpc/rtas_hcall.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 908602a9f513..d4052eccaaee 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -181,6 +181,8 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 
+TEST_GEN_PROGS_powerpc += powerpc/null_test
+TEST_GEN_PROGS_powerpc += powerpc/rtas_hcall
 TEST_GEN_PROGS_powerpc += demand_paging_test
 TEST_GEN_PROGS_powerpc += dirty_log_test
 TEST_GEN_PROGS_powerpc += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
index ba119f5a3fef..04c7d2d13020 100644
--- a/tools/testing/selftests/kvm/include/powerpc/hcall.h
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -12,6 +12,8 @@
 #define UCALL_R4_UCALL	0x5715 // regular ucall, r5 contains ucall pointer
 #define UCALL_R4_SIMPLE	0x0000 // simple exit usable by asm with no ucall data
 
+#define H_RTAS		0xf000
+
 int64_t hcall0(uint64_t token);
 int64_t hcall1(uint64_t token, uint64_t arg1);
 int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2);
diff --git a/tools/testing/selftests/kvm/powerpc/null_test.c b/tools/testing/selftests/kvm/powerpc/null_test.c
new file mode 100644
index 000000000000..31db0b6becd6
--- /dev/null
+++ b/tools/testing/selftests/kvm/powerpc/null_test.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Tests for guest creation, run, ucall, interrupt, and vm dumping.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "kselftest.h"
+#include "processor.h"
+#include "helpers.h"
+
+extern void guest_code_asm(void);
+asm(".global guest_code_asm");
+asm(".balign 4");
+asm("guest_code_asm:");
+asm("li 3,0"); // H_UCALL
+asm("li 4,0"); // UCALL_R4_SIMPLE
+asm("sc 1");
+
+static void test_asm(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_asm);
+
+	vcpu_run(vcpu);
+	handle_ucall(vcpu, UCALL_NONE);
+
+	kvm_vm_free(vm);
+}
+
+static void guest_code_ucall(void)
+{
+	GUEST_DONE();
+}
+
+static void test_ucall(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_ucall);
+
+	vcpu_run(vcpu);
+	handle_ucall(vcpu, UCALL_DONE);
+
+	kvm_vm_free(vm);
+}
+
+static void trap_handler(struct ex_regs *regs)
+{
+	GUEST_SYNC(1);
+	regs->nia += 4;
+}
+
+static void guest_code_trap(void)
+{
+	GUEST_SYNC(0);
+	asm volatile("trap");
+	GUEST_DONE();
+}
+
+static void test_trap(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_trap);
+	vm_install_exception_handler(vm, 0x700, trap_handler);
+
+	vcpu_run(vcpu);
+	host_sync(vcpu, 0);
+	vcpu_run(vcpu);
+	host_sync(vcpu, 1);
+	vcpu_run(vcpu);
+	handle_ucall(vcpu, UCALL_DONE);
+
+	vm_install_exception_handler(vm, 0x700, NULL);
+
+	kvm_vm_free(vm);
+}
+
+static void dsi_handler(struct ex_regs *regs)
+{
+	GUEST_SYNC(1);
+	regs->nia += 4;
+}
+
+static void guest_code_dsi(void)
+{
+	GUEST_SYNC(0);
+	asm volatile("stb %r0,0(0)");
+	GUEST_DONE();
+}
+
+static void test_dsi(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_dsi);
+	vm_install_exception_handler(vm, 0x300, dsi_handler);
+
+	vcpu_run(vcpu);
+	host_sync(vcpu, 0);
+	vcpu_run(vcpu);
+	host_sync(vcpu, 1);
+	vcpu_run(vcpu);
+	handle_ucall(vcpu, UCALL_DONE);
+
+	vm_install_exception_handler(vm, 0x300, NULL);
+
+	kvm_vm_free(vm);
+}
+
+static void test_dump(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_ucall);
+
+	vcpu_run(vcpu);
+	handle_ucall(vcpu, UCALL_DONE);
+
+	printf("Testing vm_dump...\n");
+	vm_dump(stderr, vm, 2);
+
+	kvm_vm_free(vm);
+}
+
+
+struct testdef {
+	const char *name;
+	void (*test)(void);
+} testlist[] = {
+	{ "null asm test", test_asm},
+	{ "null ucall test", test_ucall},
+	{ "trap test", test_trap},
+	{ "page fault test", test_dsi},
+	{ "vm dump test", test_dump},
+};
+
+int main(int argc, char *argv[])
+{
+	int idx;
+
+	ksft_print_header();
+
+	ksft_set_plan(ARRAY_SIZE(testlist));
+
+	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
+		testlist[idx].test();
+		ksft_test_result_pass("%s\n", testlist[idx].name);
+	}
+
+	ksft_finished();	/* Print results and exit() accordingly */
+}
diff --git a/tools/testing/selftests/kvm/powerpc/rtas_hcall.c b/tools/testing/selftests/kvm/powerpc/rtas_hcall.c
new file mode 100644
index 000000000000..4d5532eac650
--- /dev/null
+++ b/tools/testing/selftests/kvm/powerpc/rtas_hcall.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test the KVM H_RTAS hcall and copying buffers between guest and host.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "kselftest.h"
+#include "hcall.h"
+
+struct rtas_args {
+	__be32 token;
+	__be32 nargs;
+	__be32 nret;
+	__be32 args[16];
+        __be32 *rets;     /* Pointer to return values in args[]. */
+};
+
+static void guest_code(void)
+{
+	struct rtas_args r;
+	int64_t rc;
+
+	r.token = cpu_to_be32(0xdeadbeef);
+	r.nargs = cpu_to_be32(3);
+	r.nret = cpu_to_be32(2);
+	r.rets = &r.args[3];
+	r.args[0] = cpu_to_be32(0x1000);
+	r.args[1] = cpu_to_be32(0x1001);
+	r.args[2] = cpu_to_be32(0x1002);
+	rc = hcall1(H_RTAS, (uint64_t)&r);
+	GUEST_ASSERT(rc == 0);
+	GUEST_ASSERT_1(be32_to_cpu(r.rets[0]) == 0xabc, be32_to_cpu(r.rets[0]));
+	GUEST_ASSERT_1(be32_to_cpu(r.rets[1]) == 0x123, be32_to_cpu(r.rets[1]));
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_regs regs;
+	struct rtas_args *r;
+	vm_vaddr_t rtas_vaddr;
+	struct ucall uc;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t tmp;
+	int ret;
+
+	ksft_print_header();
+
+	ksft_set_plan(1);
+
+	/* Create VM */
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	printf("Running H_RTAS guest vcpu.\n");
+
+	ret = _vcpu_run(vcpu);
+	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+	switch ((tmp = get_ucall(vcpu, &uc))) {
+	case UCALL_NONE:
+		break; // good
+	case UCALL_DONE:
+		TEST_FAIL("Unexpected final guest exit %lu\n", tmp);
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT_N(uc, "values: %lu (0x%lx)\n",
+				      GUEST_ASSERT_ARG(uc, 0),
+				      GUEST_ASSERT_ARG(uc, 0));
+		break;
+	default:
+		TEST_FAIL("Unexpected guest exit %lu\n", tmp);
+	}
+
+	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_PAPR_HCALL,
+		    "Expected PAPR_HCALL exit, got %s\n",
+		    exit_reason_str(vcpu->run->exit_reason));
+	TEST_ASSERT(vcpu->run->papr_hcall.nr == H_RTAS,
+		    "Expected H_RTAS exit, got %lld\n",
+		    vcpu->run->papr_hcall.nr);
+
+	printf("Got H_RTAS exit.\n");
+
+	vcpu_regs_get(vcpu, &regs);
+	rtas_vaddr = regs.gpr[4];
+	printf("H_RTAS rtas_args at gEA=0x%lx\n", rtas_vaddr);
+
+	r = addr_gva2hva(vm, rtas_vaddr);
+
+	TEST_ASSERT(r->token == cpu_to_be32(0xdeadbeef),
+		    "Expected RTAS token 0xdeadbeef, got 0x%x\n",
+		    be32_to_cpu(r->token));
+	TEST_ASSERT(r->nargs == cpu_to_be32(3),
+		    "Expected RTAS nargs 3, got %u\n",
+		    be32_to_cpu(r->nargs));
+	TEST_ASSERT(r->nret == cpu_to_be32(2),
+		    "Expected RTAS nret 2, got %u\n",
+		    be32_to_cpu(r->nret));
+	TEST_ASSERT(r->args[0] == cpu_to_be32(0x1000),
+		    "Expected args[0] to be 0x1000, got 0x%x\n",
+		    be32_to_cpu(r->args[0]));
+	TEST_ASSERT(r->args[1] == cpu_to_be32(0x1001),
+		    "Expected args[1] to be 0x1001, got 0x%x\n",
+		    be32_to_cpu(r->args[1]));
+	TEST_ASSERT(r->args[2] == cpu_to_be32(0x1002),
+		    "Expected args[2] to be 0x1002, got 0x%x\n",
+		    be32_to_cpu(r->args[2]));
+
+	printf("Guest rtas_args is correct, setting rets.\n");
+
+	r->args[3] = cpu_to_be32(0xabc);
+	r->args[4] = cpu_to_be32(0x123);
+
+	regs.gpr[3] = 0;
+	vcpu_regs_set(vcpu, &regs);
+
+	printf("Running H_RTAS guest vcpu again (hcall return H_SUCCESS).\n");
+
+	ret = _vcpu_run(vcpu);
+	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+	switch ((tmp = get_ucall(vcpu, &uc))) {
+	case UCALL_DONE:
+		printf("Got final guest exit.\n");
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT_N(uc, "values: %lu (0x%lx)\n",
+				      GUEST_ASSERT_ARG(uc, 0),
+				      GUEST_ASSERT_ARG(uc, 0));
+		break;
+	default:
+		TEST_FAIL("Unexpected guest exit %lu\n", tmp);
+	}
+
+	kvm_vm_free(vm);
+
+	ksft_test_result_pass("%s\n", "rtas test");
+	ksft_finished();	/* Print results and exit() accordingly */
+}
-- 
2.40.0

