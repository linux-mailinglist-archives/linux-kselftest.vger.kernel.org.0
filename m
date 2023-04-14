Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AB96E1CAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 08:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDNGaA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 02:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDNG37 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 02:29:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB77685;
        Thu, 13 Apr 2023 23:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681453777; x=1712989777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKAAs3mBhH6XPw5i/mAYs8vA60XsTk1j5n1Dr6j7stk=;
  b=P5e+NrS+NsEy0W3+22FV4mkN9p+8DiMHzRrUz1pST0cbE76KYXhvLa7a
   r7h80ChWniX2Y2E0jJKTRkbmlRs/1lXoRPqjCbzVrXdQjYBmTEqcIrxX7
   GSVabxgx4x39VwjG9YJZO9NyLC2bxscfAE/PQe47gUgLAJvkR1bDLbNa+
   kdVoqlTS+2gZQvYxTPsQBjrw7GohZqoF68kTwOMGci6iUyqqFsZwfL9gR
   fHkhhuhDCNrojzuPEXMAkp0bKpX1NUfI1V3Iwa5wTQ05ZuA2nTsPZnVCx
   8vF080rrLg2LvyeX1IRPQRToixIg0xzCVnZeYFMIaHgD8ue1UBKleAShR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="341892916"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="341892916"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 23:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935885985"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="935885985"
Received: from spr.sh.intel.com ([10.239.53.106])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 23:26:49 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     kvm@vger.kernel.org
Cc:     Jiaan Lu <jiaan.lu@intel.com>, Chao Gao <chao.gao@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Zhang Chen <chen.zhang@intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 10/11] KVM: selftests: Add tests for virtual enumeration/mitigation MSRs
Date:   Fri, 14 Apr 2023 14:25:31 +0800
Message-Id: <20230414062545.270178-11-chao.gao@intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414062545.270178-1-chao.gao@intel.com>
References: <20230414062545.270178-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Three virtual MSRs added for guest to report the usage of software
mitigations. They are enumerated in an architectural way. Try to
access the three MSRs to ensure the behavior is expected:
Specifically,

1. below three cases should cause #GP:
 * access to a non-present MSR
 * write to read-only MSRs
 * toggling reserved bit of a writeable MSR

2. rdmsr/wrmsr in other cases should succeed

3. rdmsr should return the value last written

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 tools/arch/x86/include/asm/msr-index.h        |  23 +++
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/virtual_mitigation_msr_test.c  | 175 ++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/virtual_mitigation_msr_test.c

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 6079a5fdb40b..55f75e9ebbb7 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -166,6 +166,7 @@
 						 * IA32_XAPIC_DISABLE_STATUS MSR
 						 * supported
 						 */
+#define ARCH_CAP_VIRTUAL_ENUM		BIT_ULL(63) /* MSR_VIRTUAL_ENUMERATION supported */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
@@ -1103,6 +1104,28 @@
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
 #define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
 #define MSR_IA32_VMX_MISC_PREEMPTION_TIMER_SCALE   0x1F
+
+/* Intel virtual MSRs */
+#define MSR_VIRTUAL_ENUMERATION			0x50000000
+#define VIRT_ENUM_MITIGATION_CTRL_SUPPORT	BIT(0)  /*
+							 * Mitigation ctrl via virtual
+							 * MSRs supported
+							 */
+
+#define MSR_VIRTUAL_MITIGATION_ENUM		0x50000001
+#define MITI_ENUM_BHB_CLEAR_SEQ_S_SUPPORT	BIT(0)	/* VMM supports BHI_DIS_S */
+#define MITI_ENUM_RETPOLINE_S_SUPPORT		BIT(1)	/* VMM supports RRSBA_DIS_S */
+
+#define MSR_VIRTUAL_MITIGATION_CTRL		0x50000002
+#define MITI_CTRL_BHB_CLEAR_SEQ_S_USED		BIT(0)	/*
+							 * Request VMM to deploy
+							 * BHI_DIS_S mitigation
+							 */
+#define MITI_CTRL_RETPOLINE_S_USED		BIT(1)	/*
+							 * Request VMM to deploy
+							 * RRSBA_DIS_S mitigation
+							 */
+
 /* AMD-V MSRs */
 
 #define MSR_VM_CR                       0xc0010114
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 84a627c43795..9db9a7e49a54 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -115,6 +115,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
 TEST_GEN_PROGS_x86_64 += x86_64/amx_test
 TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
+TEST_GEN_PROGS_x86_64 += x86_64/virtual_mitigation_msr_test
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86_64/virtual_mitigation_msr_test.c b/tools/testing/selftests/kvm/x86_64/virtual_mitigation_msr_test.c
new file mode 100644
index 000000000000..4d924a0cf2dd
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/virtual_mitigation_msr_test.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Intel, Inc.
+ *
+ * tests for virtual mitigation MSR accesses
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "processor.h"
+
+static int guest_exception_count;
+static int expected_exception_count;
+static void guest_gp_handler(struct ex_regs *regs)
+{
+	/* RDMSR/WRMSR are 2 bytes */
+	regs->rip += 2;
+	++guest_exception_count;
+}
+
+static void write_msr_expect_gp(uint32_t msr, uint64_t val)
+{
+	uint64_t old_val;
+
+	old_val = rdmsr(msr);
+	wrmsr(msr, val);
+	expected_exception_count++;
+	GUEST_ASSERT_2(guest_exception_count == expected_exception_count,
+		       guest_exception_count, expected_exception_count);
+	GUEST_ASSERT_2(rdmsr(msr) == old_val, rdmsr(msr), old_val);
+}
+
+static void write_msr_expect_no_gp(uint32_t msr, uint64_t val)
+{
+	wrmsr(msr, val);
+	GUEST_ASSERT_EQ(guest_exception_count, expected_exception_count);
+	GUEST_ASSERT_EQ(rdmsr(msr), val);
+}
+
+static void read_msr_expect_gp(uint32_t msr)
+{
+	(void)rdmsr(msr);
+	expected_exception_count++;
+	GUEST_ASSERT_2(guest_exception_count == expected_exception_count,
+		       guest_exception_count, expected_exception_count);
+}
+
+static void guest_code_with_virtual_mitigation_ctrl(void)
+{
+	uint64_t val, miti_ctrl = 0;
+	int i;
+
+	val = rdmsr(MSR_VIRTUAL_ENUMERATION);
+	/* MSR_VIRTUAL_ENUMERATION is read-only. #GP is expected on write */
+	write_msr_expect_gp(MSR_VIRTUAL_ENUMERATION, val);
+
+	val = rdmsr(MSR_VIRTUAL_MITIGATION_ENUM);
+	/* MSR_VIRTUAL_MITIGATION_ENUM is read-only. #GP is expected on write */
+	write_msr_expect_gp(MSR_VIRTUAL_MITIGATION_ENUM, val);
+
+	for (i = 0; i < 64; i++) {
+		if (val & BIT_ULL(i)) {
+			miti_ctrl |= BIT_ULL(i);
+			write_msr_expect_no_gp(MSR_VIRTUAL_MITIGATION_CTRL, miti_ctrl);
+		} else {
+			write_msr_expect_gp(MSR_VIRTUAL_MITIGATION_CTRL, miti_ctrl | BIT_ULL(i));
+		}
+	}
+
+	write_msr_expect_no_gp(MSR_VIRTUAL_MITIGATION_CTRL, 0);
+	GUEST_DONE();
+}
+
+static void guest_code_no_virtual_enumeration(void)
+{
+	read_msr_expect_gp(MSR_VIRTUAL_ENUMERATION);
+	read_msr_expect_gp(MSR_VIRTUAL_MITIGATION_ENUM);
+	read_msr_expect_gp(MSR_VIRTUAL_MITIGATION_CTRL);
+	GUEST_DONE();
+}
+
+bool kvm_cpu_has_virtual_mitigation_ctrl(void)
+{
+	const struct kvm_msr_list *feature_list;
+	u64 virt_enum = 0;
+	int i;
+
+	feature_list = kvm_get_feature_msr_index_list();
+	for (i = 0; i < feature_list->nmsrs; i++) {
+		if (feature_list->indices[i] == MSR_VIRTUAL_ENUMERATION)
+			virt_enum = kvm_get_feature_msr(MSR_VIRTUAL_ENUMERATION);
+	}
+
+	return virt_enum & VIRT_ENUM_MITIGATION_CTRL_SUPPORT;
+}
+
+static void enable_virtual_mitigation_ctrl(struct kvm_vcpu *vcpu)
+{
+	vcpu_set_msr(vcpu, MSR_IA32_ARCH_CAPABILITIES, ARCH_CAP_VIRTUAL_ENUM);
+	vcpu_set_msr(vcpu, MSR_VIRTUAL_ENUMERATION, VIRT_ENUM_MITIGATION_CTRL_SUPPORT);
+	vcpu_set_msr(vcpu, MSR_VIRTUAL_MITIGATION_ENUM,
+		     kvm_get_feature_msr(MSR_VIRTUAL_MITIGATION_ENUM));
+}
+
+static void disable_virtual_enumeration(struct kvm_vcpu *vcpu)
+{
+	vcpu_set_msr(vcpu, MSR_IA32_ARCH_CAPABILITIES, 0);
+}
+
+static void test_virtual_mitiation_ctrl(bool enable)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	void *guest_code;
+
+	guest_code = enable ? guest_code_with_virtual_mitigation_ctrl :
+			      guest_code_no_virtual_enumeration;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	run = vcpu->run;
+
+	if (enable)
+		enable_virtual_mitigation_ctrl(vcpu);
+	else
+		disable_virtual_enumeration(vcpu);
+
+
+	/* Register #GP handler */
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+	vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
+
+	while (1) {
+		vcpu_run(vcpu);
+
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+			    "Unexpected exit reason: %u (%s),\n",
+			    run->exit_reason,
+			    exit_reason_str(run->exit_reason));
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT_2(uc, "real %ld expected %ld");
+			break;
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+
+done:
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_ARCH_CAPABILITIES));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GET_MSR_FEATURES));
+	TEST_REQUIRE(kvm_cpu_has_virtual_mitigation_ctrl());
+
+	test_virtual_mitiation_ctrl(true);
+	test_virtual_mitiation_ctrl(false);
+
+	return 0;
+}
-- 
2.40.0

