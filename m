Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B37B6E1CAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 08:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDNGaB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 02:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDNGaA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 02:30:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C8259C5;
        Thu, 13 Apr 2023 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681453778; x=1712989778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxJY2wVEfAv4F5NKI9HcNJKB859x2xbyF2CPCK/XZ18=;
  b=gO/T7Po05yrluLOTi7F/jCjj+BWtJhBvrSbwGeUcahs1B45AcGFHaKPw
   xTu68hXLSDc0amjrGhut54EvxK7AibHOgS1wA5aomFD5/zi4fTtonUfse
   09QuW0xLO6KO89z+zebr+jUcwKwgPvOw825GMGP9OpRtKRxtBmHSeZNNu
   E1wvE++Lb+8X2qhA7ts2g5eWNp1FTuVHouS2ou1NkOlnrq9WB0/3SIQyD
   U9vLvqNrfYHD1XqcGGCXRc+LYbBbC5Crof2QBnINNAZRkNiSBZt3H/qyd
   59q6CtTRmgo5/FiUCfnmxnnJTo231gFT4wqSRG1t482lLixt2EP5lh31c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="341892929"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="341892929"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 23:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935886005"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="935886005"
Received: from spr.sh.intel.com ([10.239.53.106])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 23:26:57 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     kvm@vger.kernel.org
Cc:     Jiaan Lu <jiaan.lu@intel.com>, Chao Gao <chao.gao@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Zhang Chen <chen.zhang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 11/11] KVM: selftests: Add tests for IA32_SPEC_CTRL MSR
Date:   Fri, 14 Apr 2023 14:25:32 +0800
Message-Id: <20230414062545.270178-12-chao.gao@intel.com>
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

Toggle supported bits of IA32_SPEC_CTRL and verify the result. And also
verify the MSR value is preserved across nested transitions.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 tools/arch/x86/include/asm/msr-index.h        |   6 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/processor.h  |   5 +
 .../selftests/kvm/x86_64/spec_ctrl_msr_test.c | 178 ++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/spec_ctrl_msr_test.c

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 55f75e9ebbb7..9ad6c307c0d0 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -48,6 +48,12 @@
 #define SPEC_CTRL_STIBP			BIT(SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
 #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
 #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
+#define SPEC_CTRL_IPRED_DIS_U_SHIFT	3	   /* Disable IPRED behavior in user mode */
+#define SPEC_CTRL_IPRED_DIS_U		BIT(SPEC_CTRL_IPRED_DIS_U_SHIFT)
+#define SPEC_CTRL_IPRED_DIS_S_SHIFT	4	   /* Disable IPRED behavior in supervisor mode */
+#define SPEC_CTRL_IPRED_DIS_S		BIT(SPEC_CTRL_IPRED_DIS_S_SHIFT)
+#define SPEC_CTRL_RRSBA_DIS_U_SHIFT	5	   /* Disable RRSBA behavior in user mode */
+#define SPEC_CTRL_RRSBA_DIS_U		BIT(SPEC_CTRL_RRSBA_DIS_U_SHIFT)
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior in supervisor mode */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
 #define SPEC_CTRL_BHI_DIS_S_SHIFT	10         /* Disable BHI behavior in supervisor mode */
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 9db9a7e49a54..9f117cf80477 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -116,6 +116,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/amx_test
 TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
 TEST_GEN_PROGS_x86_64 += x86_64/virtual_mitigation_msr_test
+TEST_GEN_PROGS_x86_64 += x86_64/spec_ctrl_msr_test
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 90387ddcb2a9..355aba25dfef 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -125,8 +125,13 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_IBT			KVM_X86_CPU_FEATURE(0x7, 0, EDX, 20)
 #define	X86_FEATURE_AMX_TILE		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 24)
 #define	X86_FEATURE_SPEC_CTRL		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 26)
+#define	X86_FEATURE_INTEL_STIBP		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 27)
+#define	X86_FEATURE_SPEC_CTRL_SSBD	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 31)
 #define	X86_FEATURE_ARCH_CAPABILITIES	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 29)
 #define	X86_FEATURE_PKS			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 31)
+#define	X86_FEATURE_IPRED_CTRL		KVM_X86_CPU_FEATURE(0x7, 2, EDX, 1)
+#define	X86_FEATURE_RRSBA_CTRL		KVM_X86_CPU_FEATURE(0x7, 2, EDX, 2)
+#define	X86_FEATURE_BHI_CTRL		KVM_X86_CPU_FEATURE(0x7, 2, EDX, 4)
 #define	X86_FEATURE_XTILECFG		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 17)
 #define	X86_FEATURE_XTILEDATA		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 18)
 #define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
diff --git a/tools/testing/selftests/kvm/x86_64/spec_ctrl_msr_test.c b/tools/testing/selftests/kvm/x86_64/spec_ctrl_msr_test.c
new file mode 100644
index 000000000000..ced4640ee92e
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/spec_ctrl_msr_test.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Intel, Inc.
+ *
+ * tests for IA32_SPEC_CTRL MSR accesses
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
+#include "vmx.h"
+#include "processor.h"
+
+static void set_spec_ctrl(u64 val)
+{
+	/* Set the bit and verify the result */
+	wrmsr(MSR_IA32_SPEC_CTRL, val);
+	GUEST_ASSERT_2(rdmsr(MSR_IA32_SPEC_CTRL) == val, rdmsr(MSR_IA32_SPEC_CTRL), val);
+
+	/* Clear the bit and verify the result */
+	val = 0;
+	wrmsr(MSR_IA32_SPEC_CTRL, val);
+	GUEST_ASSERT_2(rdmsr(MSR_IA32_SPEC_CTRL) == val, rdmsr(MSR_IA32_SPEC_CTRL), val);
+}
+
+static void guest_code(void)
+{
+	set_spec_ctrl(SPEC_CTRL_IBRS);
+
+	if (this_cpu_has(X86_FEATURE_INTEL_STIBP))
+		set_spec_ctrl(SPEC_CTRL_STIBP);
+
+	if (this_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
+		set_spec_ctrl(SPEC_CTRL_SSBD);
+
+	if (this_cpu_has(X86_FEATURE_IPRED_CTRL)) {
+		set_spec_ctrl(SPEC_CTRL_IPRED_DIS_S);
+		set_spec_ctrl(SPEC_CTRL_IPRED_DIS_U);
+	}
+
+	if (this_cpu_has(X86_FEATURE_RRSBA_CTRL)) {
+		set_spec_ctrl(SPEC_CTRL_RRSBA_DIS_S);
+		set_spec_ctrl(SPEC_CTRL_RRSBA_DIS_U);
+	}
+
+	if (this_cpu_has(X86_FEATURE_BHI_CTRL))
+		set_spec_ctrl(SPEC_CTRL_BHI_DIS_S);
+
+	GUEST_DONE();
+}
+
+static void test_spec_ctrl_access(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	run = vcpu->run;
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
+static void l2_guest_code(void)
+{
+	GUEST_ASSERT(rdmsr(MSR_IA32_SPEC_CTRL) == SPEC_CTRL_IBRS);
+	wrmsr(MSR_IA32_SPEC_CTRL, 0);
+
+	/* Exit to L1 */
+	__asm__ __volatile__("vmcall");
+}
+
+static void l1_guest_code(struct vmx_pages *vmx_pages)
+{
+#define L2_GUEST_STACK_SIZE 64
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	uint32_t control;
+
+	/*
+	 * Try to disable interception of writes to SPEC_CTRL by writing a
+	 * non-0 value. This test is intended to verify that SPEC_CTRL is
+	 * preserved across nested transitions particuarlly when writes to
+	 * the MSR isn't intercepted by L0 VMM or L1 VMM.
+	 */
+	wrmsr(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS);
+
+	GUEST_ASSERT(vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	GUEST_ASSERT(load_vmcs(vmx_pages));
+	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	prepare_vmcs(vmx_pages, l2_guest_code,
+		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control |= CPU_BASED_USE_MSR_BITMAPS;
+	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
+
+	GUEST_ASSERT(!vmlaunch());
+
+	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_ASSERT(rdmsr(MSR_IA32_SPEC_CTRL) == 0);
+
+	GUEST_DONE();
+}
+
+static void test_spec_ctrl_vmx_transition(void)
+{
+	vm_vaddr_t vmx_pages_gva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vcpu_alloc_vmx(vm, &vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
+	run = vcpu->run;
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
+			REPORT_GUEST_ASSERT(uc);
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
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SPEC_CTRL));
+	test_spec_ctrl_access();
+	test_spec_ctrl_vmx_transition();
+
+	return 0;
+}
-- 
2.40.0

