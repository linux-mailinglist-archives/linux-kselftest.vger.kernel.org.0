Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8952362394A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 02:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiKJByh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 20:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiKJByf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 20:54:35 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D5DDFFF;
        Wed,  9 Nov 2022 17:54:34 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668045268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUsD3eBCKbdoGj1PTEkb6Ygy4UgyIiHbIOlpThhPpiY=;
        b=PO+ypaaJeM3qPl0fWuF2uvP/fo/sqnO82JCtIdUg25hsgiQyKcdBDlRzweSXh+qscVOKlI
        Q3Q3zySTlqmrXCBsQ3So4vz5HJAZ7xJA/EYr0Swvi0jsLbLcp5dIfK3cVQoVJ9FM6d/LLI
        9FEG79SWTqEsViN5pBalcdS0DyxZDBQ=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     Raghavendra Rao Ananta <rananta@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 3/3] KVM: selftests: Test user hypercalls
Date:   Thu, 10 Nov 2022 01:53:27 +0000
Message-Id: <20221110015327.3389351-4-oliver.upton@linux.dev>
In-Reply-To: <20221110015327.3389351-1-oliver.upton@linux.dev>
References: <20221110015327.3389351-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/user_hypercalls.c   | 130 ++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/aarch64/user_hypercalls.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 2f0d705db9db..4f45e987985f 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -5,6 +5,7 @@
 /aarch64/get-reg-list
 /aarch64/hypercalls
 /aarch64/psci_test
+/aarch64/user_hypercalls
 /aarch64/vcpu_width_config
 /aarch64/vgic_init
 /aarch64/vgic_irq
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 0172eb6cb6ee..8ac1988ea669 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -153,6 +153,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
 TEST_GEN_PROGS_aarch64 += aarch64/psci_test
+TEST_GEN_PROGS_aarch64 += aarch64/user_hypercalls
 TEST_GEN_PROGS_aarch64 += aarch64/vcpu_width_config
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
diff --git a/tools/testing/selftests/kvm/aarch64/user_hypercalls.c b/tools/testing/selftests/kvm/aarch64/user_hypercalls.c
new file mode 100644
index 000000000000..94ac821c5474
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/user_hypercalls.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/arm-smccc.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+struct test_case {
+	uint64_t	cap;
+	uint32_t	function;
+	uint64_t	args[6];
+};
+
+#define TEST_OWNER(name)							\
+{										\
+	.cap		= BIT_ULL(KVM_ARM_USER_HYPERCALL_OWNER_ ## name),	\
+	.function	= ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+					     ARM_SMCCC_SMC_32,			\
+					     ARM_SMCCC_OWNER_ ## name,		\
+					     0),				\
+	.args		= {							\
+		__LINE__,							\
+		__LINE__ + 1,							\
+		__LINE__ + 2,							\
+		__LINE__ + 3,							\
+		__LINE__ + 4,							\
+		__LINE__ + 5,							\
+	},									\
+},										\
+{										\
+	.cap		= BIT_ULL(KVM_ARM_USER_HYPERCALL_OWNER_ ## name),	\
+	.function	= ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+					     ARM_SMCCC_SMC_64,			\
+					     ARM_SMCCC_OWNER_ ## name,		\
+					     0),				\
+	.args		= {							\
+		__LINE__,							\
+		__LINE__ + 1,							\
+		__LINE__ + 2,							\
+		__LINE__ + 3,							\
+		__LINE__ + 4,							\
+		__LINE__ + 5,							\
+	},									\
+}										\
+
+static struct test_case test_cases[] = {
+	TEST_OWNER(ARCH),
+	TEST_OWNER(CPU),
+	TEST_OWNER(SIP),
+	TEST_OWNER(OEM),
+	TEST_OWNER(STANDARD),
+	TEST_OWNER(STANDARD_HYP),
+	TEST_OWNER(VENDOR_HYP),
+	TEST_OWNER(TRUSTED_APP),
+	TEST_OWNER(TRUSTED_OS),
+};
+
+static void guest_main(const struct test_case *test)
+{
+	struct arm_smccc_res unused;
+
+	smccc_hvc(test->function, test->args[0], test->args[1], test->args[2],
+		  test->args[3], test->args[4], test->args[5], 0, &unused);
+
+	GUEST_ASSERT(0);
+}
+
+static void handle_hvc(const struct test_case *test, struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+
+	TEST_ASSERT(run->hypercall.nr == test->function,
+		    "unexpected function ID: %llx (expected %x)",
+		    run->hypercall.nr, test->function);
+
+	TEST_ASSERT(!memcmp(&run->hypercall.args, &test->args, sizeof(test->args)),
+		    "unexpected hypercall arguments");
+}
+
+static void handle_ucall(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	default:
+		TEST_FAIL("unhandled ucall: %lu", uc.cmd);
+	}
+}
+
+static void run_test(const struct test_case *test)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
+	vm_enable_cap(vm, KVM_CAP_ARM_USER_HYPERCALLS, test->cap);
+	ucall_init(vm, NULL);
+
+	vcpu_args_set(vcpu, 1, test);
+
+	vcpu_run(vcpu);
+	switch (vcpu->run->exit_reason) {
+	case KVM_EXIT_HYPERCALL:
+		handle_hvc(test, vcpu);
+		break;
+	case KVM_EXIT_MMIO:
+		handle_ucall(vcpu);
+		break;
+	default:
+		TEST_FAIL("unhandled exit reason: %u (%s)", vcpu->run->exit_reason,
+			  exit_reason_str(vcpu->run->exit_reason));
+	}
+
+	ucall_uninit(vm);
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	int i;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_USER_HYPERCALLS));
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
+		run_test(&test_cases[i]);
+}
-- 
2.38.1.431.g37b22c650d-goog

