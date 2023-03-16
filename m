Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EE36BC45E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 04:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCPDR5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 23:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCPDRy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 23:17:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D797FEF;
        Wed, 15 Mar 2023 20:17:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4779237pjc.1;
        Wed, 15 Mar 2023 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678936672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYb17I8BCPb2EFCzQSFjEgo4PHKuxc2T5i8Z/xiebA4=;
        b=E8U5/GZGqf3PByeid13InXXn4yaA6mYkYAaRr4fA6KmG/G4JAE1adzFwf2wj3BZvTY
         /yXaHRsZ5jOtgGU1d6kX96WbE/YW29boqiX5kjWkwqD+nFVvsIJBEZa7b87TwspDREfL
         cbVDg09EGwfBvveCQMmUARNe3neGAOlN0yjCCP3IFsdlOGycMynTi1Y0Fje7qDJ/NKCk
         DFgkh/MmTxTfQopkqbPvE6Jr/h6416FFHcX/7jESbvqqRMGEQk/Gnlw24etaowuVqrBX
         yFHUVeaHbZLczegrZWCRaNt4RNmNX9DVxHFXsCIjbezLkrhtVv849ftT9SVWGqsOCWzr
         pYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678936672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYb17I8BCPb2EFCzQSFjEgo4PHKuxc2T5i8Z/xiebA4=;
        b=JBY2QIOyl40auFnQOH60IyXybBaAKjdX2P/qR/+O7dRKtrKFVwYPU2wR5txwErZAnP
         V1uS5Wro9wgvJ4iA8X4PKR0ipLdx4zqZdL7UTaLyE4x0F+JkXd48wYPL/rlc3rpCXWrv
         A+n7CeWEgtJLBbCwnLGscUl19qWF5kVCTTYXoy94jjJUXsrCHx58gMWpKAlW+vwQdOzl
         PX8q6YLHDIRFZtkC3xf+oljOBAtqUu2BnOdNUyIlxMoFyRKWzF5JxvgCkwKOJI7cmlwN
         9lDcb0HYrfehrGziQZNVZysmqlCDpNQLXwO9BgrVuNTbwkzDnVN56UsuJMMV5OWGiNSf
         1pCQ==
X-Gm-Message-State: AO0yUKUrgYhE0HiJqiVFhFXYr4kIrqWuCKx/HEkZfQTWp2cux3AdkeEr
        EfiVamOaZFHaiU0xS7Khtdo=
X-Google-Smtp-Source: AK7set880WVudiccd4PFvawdxw6XmcT4cOtGB44ikAvMX6mjuioU29HtYJF9WCF6J4D6e35ixwEY3g==
X-Received: by 2002:a17:903:41d2:b0:1a0:57df:864f with SMTP id u18-20020a17090341d200b001a057df864fmr2268728ple.16.1678936672140;
        Wed, 15 Mar 2023 20:17:52 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (121-44-69-75.tpgi.com.au. [121.44.69.75])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0019a7bb18f98sm4331859plm.48.2023.03.15.20.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 20:17:51 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] KVM: PPC: Add basic framework tests for kvm selftests
Date:   Thu, 16 Mar 2023 13:17:32 +1000
Message-Id: <20230316031732.3591455-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230316031732.3591455-1-npiggin@gmail.com>
References: <20230316031732.3591455-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some tests that exercise basic functions of the kvm selftests
framework, guest creation, ucalls, hcalls, copying data between guest
and host, interrupts and page faults.

These don't test KVM so much, but were useful when developing the
selftests support for powerpc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/powerpc/hcall.h     |   4 +-
 .../testing/selftests/kvm/powerpc/null_test.c | 186 ++++++++++++++++++
 .../selftests/kvm/powerpc/rtas_hcall.c        | 146 ++++++++++++++
 4 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/powerpc/null_test.c
 create mode 100644 tools/testing/selftests/kvm/powerpc/rtas_hcall.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 081cee3ecc0c..1d9eb4f3284d 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -180,6 +180,8 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 
+TEST_GEN_PROGS_powerpc += powerpc/null_test
+TEST_GEN_PROGS_powerpc += powerpc/rtas_hcall
 TEST_GEN_PROGS_powerpc += demand_paging_test
 TEST_GEN_PROGS_powerpc += dirty_log_test
 TEST_GEN_PROGS_powerpc += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
index bbad5904f37a..cbcaf180c427 100644
--- a/tools/testing/selftests/kvm/include/powerpc/hcall.h
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -11,7 +11,9 @@
 #define H_UCALL	0
 #define UCALL_R4_UCALL	0x5715 // regular ucall, r5 contains ucall pointer
 #define UCALL_R4_EXCPT	0x1b0f // other exception, r5 contains vector, r6,7 SRRs
-			       // R4==0 is a simple asm exit
+#define UCALL_R4_SIMPLE	0x0000 // simple exit usable by asm with no ucall data
+
+#define H_RTAS		0xf000
 
 int64_t hcall0(uint64_t token);
 int64_t hcall1(uint64_t token, uint64_t arg1);
diff --git a/tools/testing/selftests/kvm/powerpc/null_test.c b/tools/testing/selftests/kvm/powerpc/null_test.c
new file mode 100644
index 000000000000..ee3cf20a5cf3
--- /dev/null
+++ b/tools/testing/selftests/kvm/powerpc/null_test.c
@@ -0,0 +1,186 @@
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
+
+extern void guest_code_asm(void);
+asm(".global guest_code_asm");
+asm(".balign 4");
+asm("guest_code_asm:");
+asm("li 3,0"); // H_UCALL
+asm("li 4,0"); // UCALL_R4_SIMPLE
+asm("sc 1");
+
+static void guest_code_ucall(void)
+{
+	GUEST_DONE();
+}
+
+static void guest_code_trap(void)
+{
+	asm volatile("trap");
+}
+
+static void guest_code_dsi(void)
+{
+	*(volatile int *)0;
+}
+
+static void test_asm(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_asm);
+
+	ret = _vcpu_run(vcpu);
+
+	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+	TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_NONE,
+		    "Invalid guest done status: exit_reason=%s\n",
+		    exit_reason_str(vcpu->run->exit_reason));
+
+	kvm_vm_free(vm);
+}
+
+static void test_ucall(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_ucall);
+
+	ret = _vcpu_run(vcpu);
+
+	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+	TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_DONE,
+		    "Invalid guest done status: exit_reason=%s\n",
+		    exit_reason_str(vcpu->run->exit_reason));
+
+	kvm_vm_free(vm);
+}
+
+static bool got_trap;
+static bool trap_handler(struct kvm_vcpu *vcpu, unsigned trap)
+{
+	if (trap == 0x700) {
+		got_trap = true;
+		return true;
+	}
+	return false;
+}
+
+static void test_trap(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int ret;
+
+	interrupt_handler = trap_handler;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_trap);
+
+	ret = _vcpu_run(vcpu);
+
+	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+	TEST_ASSERT(got_trap,
+		    "Invalid guest done status: exit_reason=%s\n",
+		    exit_reason_str(vcpu->run->exit_reason));
+
+	kvm_vm_free(vm);
+
+	interrupt_handler = NULL;
+}
+
+static bool got_dsi;
+static bool dsi_handler(struct kvm_vcpu *vcpu, unsigned trap)
+{
+	if (trap == 0x300) {
+		got_dsi = true;
+		return true;
+	}
+	return false;
+}
+
+static void test_dsi(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int ret;
+
+	interrupt_handler = dsi_handler;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_dsi);
+
+	ret = _vcpu_run(vcpu);
+
+	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+	TEST_ASSERT(got_dsi,
+		    "Invalid guest done status: exit_reason=%s\n",
+		    exit_reason_str(vcpu->run->exit_reason));
+
+	vm_dump(stderr, vm, 2);
+
+	kvm_vm_free(vm);
+
+	interrupt_handler = NULL;
+}
+
+static void test_dump(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_ucall);
+
+	ret = _vcpu_run(vcpu);
+	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
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
index 000000000000..17a580d7fa55
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
+	ksft_test_result_pass("%s\n", "null test");
+	ksft_finished();	/* Print results and exit() accordingly */
+}
-- 
2.37.2

