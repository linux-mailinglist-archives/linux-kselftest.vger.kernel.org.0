Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA1762594
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjGYWDv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjGYWDI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E91C35A8
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57a3620f8c0so58164767b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322548; x=1690927348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvFwrgTOLnBanKPH3PYlGlbmNZflZsIQaoxtTrOgiYw=;
        b=r3Oz+3e5fF1FIPXwK5C/E/n4L6f+/VnbJVIt0sKbrnyMxaEJJUqUmxIbzeSK7m76Qv
         mu74Gykc2QRkfuHEK485PQ1hIy1KzTb8wjGIP+uy+WWMEASwLa9mFICoKd4rt5IYkePN
         ZLJrO75IlXOy79GRKQTTAlb4YXy1+X/OmeiZSO1gj8dekXcrCi8/7Z7furkQhA4RNXr5
         5YFZ8PkpuOLgs2rTIJOrJz6ZKyimGhXEownCAMukV+ZVPWrNQ3JBltsPZGoJucpD6NwR
         Ln0XbyEiodqiR1YWPdTHjlT/Y7iDHrcEVvQ2moRDdFB27j0HXkpj8Vb5a+DKT7rgUTdX
         nsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322548; x=1690927348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvFwrgTOLnBanKPH3PYlGlbmNZflZsIQaoxtTrOgiYw=;
        b=PaGfXKN7Qef1BNyOajlUBLRHprie6w3PaKztdVhB+1BakdFUQ6Ttqu1AS5B2bopNer
         aa2+PHbGbg1w2KRn+QmhPFoZg/GRlhsnlswksU43Nj5JsYTQ6bIt9PbGRgZfKM+aEBFN
         N2YG9zZRZQvhyeOoHQah0FIDxlcBbF4UpHFkF61DLdhHR4MJmBQhvGFPkvE1BGf5rZCg
         GvJrhzxZGNFk5/pmfpwkvE/SKzzO2kwQ6ij71k8ayBhvwE3oPq9TwjEJ1NDSwd01fy/G
         c6HgsJw7GUeMMbAgBjXzmceSB0HKceEGp+Ed8Q77CRZf/qUVgb4uADmqap6Br1mFNE00
         hKFQ==
X-Gm-Message-State: ABy/qLYX8IiIagXQCPpvdP+njZDC/n3VbhuZwnKCV8nkVi4BNx3NO6yA
        9njH7bzAMP96MRNfR99qqIAE8ey7tVYryJdEiY1WJe/8XFr8j/Fgt5EicfTsVaPqm3LDSRFgFyU
        paDWTWOZOhLFDJ291Lqq3E+BkTqjtL1dG0ciHkwOlI6KXokx7ltsEsCGTu8KEqK9ob0d/FqPTrI
        Wz
X-Google-Smtp-Source: APBJJlE0ltnUvFQgXzSaQWz2Qr5Tha7ukN/o6oAeZgAw1a2rwzerNAmZ5VWALpD145mo82FQ6JNqKps+b+sl
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a81:c509:0:b0:583:4f6c:e03b with SMTP id
 k9-20020a81c509000000b005834f6ce03bmr4321ywi.2.1690322548401; Tue, 25 Jul
 2023 15:02:28 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:14 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-22-afranji@google.com>
Subject: [PATCH v4 21/28] KVM: selftests: TDX: Add TDG.VP.INFO test
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roger Wang <runanwang@google.com>

Adds a test for TDG.VP.INFO

Signed-off-by: Roger Wang <runanwang@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Ib20895c7bda626aaf1dcbe21d32733444bd0811d
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |  19 +++
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   5 +
 .../selftests/kvm/lib/x86_64/tdx/tdcall.S     |  68 ++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  27 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 148 ++++++++++++++++++
 5 files changed, 267 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
index 95fcdbd8404e..a65ce8f3c109 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
@@ -37,4 +37,23 @@ struct tdx_hypercall_args {
 /* Used to request services from the VMM */
 u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
 
+/*
+ * Used to gather the output registers values of the TDCALL and SEAMCALL
+ * instructions when requesting services from the TDX module.
+ *
+ * This is a software only structure and not part of the TDX module/VMM ABI.
+ */
+struct tdx_module_output {
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+};
+
+/* Used to communicate with the TDX module */
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+		struct tdx_module_output *out);
+
 #endif // SELFTESTS_TDX_TDCALL_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index b13a533234fd..6b176de1e795 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -5,6 +5,8 @@
 #include <stdint.h>
 #include "kvm_util_base.h"
 
+#define TDG_VP_INFO 1
+
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
@@ -31,5 +33,8 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
 uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
 					uint32_t *ret_eax, uint32_t *ret_ebx,
 					uint32_t *ret_ecx, uint32_t *ret_edx);
+uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
+		     uint64_t *r8, uint64_t *r9,
+		     uint64_t *r10, uint64_t *r11);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
index df9c1ed4bb2d..601d71531443 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
@@ -86,5 +86,73 @@ __tdx_hypercall:
 	pop %rbp
 	ret
 
+#define TDX_MODULE_rcx 0 /* offsetof(struct tdx_module_output, rcx) */
+#define TDX_MODULE_rdx 8 /* offsetof(struct tdx_module_output, rdx) */
+#define TDX_MODULE_r8 16 /* offsetof(struct tdx_module_output, r8) */
+#define TDX_MODULE_r9 24 /* offsetof(struct tdx_module_output, r9) */
+#define TDX_MODULE_r10 32 /* offsetof(struct tdx_module_output, r10) */
+#define TDX_MODULE_r11 40 /* offsetof(struct tdx_module_output, r11) */
+
+.globl __tdx_module_call
+.type __tdx_module_call, @function
+__tdx_module_call:
+	/* Set up stack frame */
+	push %rbp
+	movq %rsp, %rbp
+
+	/* Callee-saved, so preserve it */
+	push %r12
+
+	/*
+	 * Push output pointer to stack.
+	 * After the operation, it will be fetched into R12 register.
+	 */
+	push %r9
+
+	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
+	/* Move Leaf ID to RAX */
+	mov %rdi, %rax
+	/* Move input 4 to R9 */
+	mov %r8,  %r9
+	/* Move input 3 to R8 */
+	mov %rcx, %r8
+	/* Move input 1 to RCX */
+	mov %rsi, %rcx
+	/* Leave input param 2 in RDX */
+
+	tdcall
+
+	/*
+	 * Fetch output pointer from stack to R12 (It is used
+	 * as temporary storage)
+	 */
+	pop %r12
+
+	/*
+	 * Since this macro can be invoked with NULL as an output pointer,
+	 * check if caller provided an output struct before storing output
+	 * registers.
+	 *
+	 * Update output registers, even if the call failed (RAX != 0).
+	 * Other registers may contain details of the failure.
+	 */
+	test %r12, %r12
+	jz .Lno_output_struct
+
+	/* Copy result registers to output struct: */
+	movq %rcx, TDX_MODULE_rcx(%r12)
+	movq %rdx, TDX_MODULE_rdx(%r12)
+	movq %r8,  TDX_MODULE_r8(%r12)
+	movq %r9,  TDX_MODULE_r9(%r12)
+	movq %r10, TDX_MODULE_r10(%r12)
+	movq %r11, TDX_MODULE_r11(%r12)
+
+.Lno_output_struct:
+	/* Restore the state of R12 register */
+	pop %r12
+
+	pop %rbp
+	ret
+
 /* Disable executable stack */
 .section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index a45e2ceb6eda..bcd9cceb3372 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -183,3 +183,30 @@ uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
 
 	return ret;
 }
+
+uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
+		     uint64_t *r8, uint64_t *r9,
+		     uint64_t *r10, uint64_t *r11)
+{
+	uint64_t ret;
+	struct tdx_module_output out;
+
+	memset(&out, 0, sizeof(struct tdx_module_output));
+
+	ret = __tdx_module_call(TDG_VP_INFO, 0, 0, 0, 0, &out);
+
+	if (rcx)
+		*rcx = out.rcx;
+	if (rdx)
+		*rdx = out.rdx;
+	if (r8)
+		*r8 = out.r8;
+	if (r9)
+		*r9 = out.r9;
+	if (r10)
+		*r10 = out.r10;
+	if (r11)
+		*r11 = out.r11;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 36cc735fad30..c50e39b930f4 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1146,6 +1146,153 @@ void verify_host_reading_private_mem(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Do a TDG.VP.INFO call from the guest
+ */
+void guest_tdcall_vp_info(void)
+{
+	uint64_t err;
+	uint64_t rcx, rdx, r8, r9, r10, r11;
+
+	err = tdg_vp_info(&rcx, &rdx, &r8, &r9, &r10, &r11);
+	if (err)
+		tdx_test_fatal(err);
+
+	/* return values to user space host */
+	err = tdx_test_report_64bit_to_user_space(rcx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_64bit_to_user_space(rdx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_64bit_to_user_space(r8);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_64bit_to_user_space(r9);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_64bit_to_user_space(r10);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_64bit_to_user_space(r11);
+	if (err)
+		tdx_test_fatal(err);
+
+	tdx_test_success();
+}
+
+/*
+ * TDG.VP.INFO call from the guest. Verify the right values are returned
+ */
+void verify_tdcall_vp_info(void)
+{
+	const int num_vcpus = 2;
+	struct kvm_vcpu *vcpus[num_vcpus];
+	struct kvm_vm *vm;
+
+	uint64_t rcx, rdx, r8, r9, r10, r11;
+	uint32_t ret_num_vcpus, ret_max_vcpus;
+	uint64_t attributes;
+	uint32_t i;
+	const struct kvm_cpuid_entry2 *cpuid_entry;
+	int max_pa = -1;
+	int ret;
+
+	vm = td_create();
+
+	/* Set value for kvm->max_vcpus to be checked later */
+#define TEST_VP_INFO_MAX_VCPUS 1024
+	ret = kvm_check_cap(KVM_CAP_MAX_VCPUS);
+	TEST_ASSERT(ret, "TDX: KVM_CAP_MAX_VCPUS is not supported!");
+	vm_enable_cap(vm, KVM_CAP_MAX_VCPUS, TEST_VP_INFO_MAX_VCPUS);
+
+#define TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT	(1UL << 28)
+#define TDX_TDPARAM_ATTR_PKS_BIT		(1UL << 30)
+	/* Setting attributes parameter used by TDH.MNG.INIT to 0x50000000 */
+	attributes = TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT |
+		     TDX_TDPARAM_ATTR_PKS_BIT;
+
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, attributes);
+
+	for (i = 0; i < num_vcpus; i++)
+		vcpus[i] = td_vcpu_add(vm, i, guest_tdcall_vp_info);
+
+	td_finalize(vm);
+
+	printf("Verifying TDG.VP.INFO call:\n");
+
+	/* Get KVM CPUIDs for reference */
+	cpuid_entry = get_cpuid_entry(kvm_get_supported_cpuid(), 0x80000008, 0);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+	max_pa = cpuid_entry->eax & 0xff;
+
+	for (i = 0; i < num_vcpus; i++) {
+		struct kvm_vcpu *vcpu = vcpus[i];
+
+		/* Wait for guest to report rcx value */
+		td_vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		rcx = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report rdx value */
+		td_vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		rdx = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r8 value */
+		td_vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		r8 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r9 value */
+		td_vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		r9 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r10 value */
+		td_vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		r10 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r11 value */
+		td_vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		r11 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		ret_num_vcpus = r8 & 0xFFFFFFFF;
+		ret_max_vcpus = (r8 >> 32) & 0xFFFFFFFF;
+
+		/* first bits 5:0 of rcx represent the GPAW */
+		ASSERT_EQ(rcx & 0x3F, max_pa);
+		/* next 63:6 bits of rcx is reserved and must be 0 */
+		ASSERT_EQ(rcx >> 6, 0);
+		ASSERT_EQ(rdx, attributes);
+		ASSERT_EQ(ret_num_vcpus, num_vcpus);
+		ASSERT_EQ(ret_max_vcpus, TEST_VP_INFO_MAX_VCPUS);
+		/* VCPU_INDEX = i */
+		ASSERT_EQ(r9, i);
+		/* verify reserved registers are 0 */
+		ASSERT_EQ(r10, 0);
+		ASSERT_EQ(r11, 0);
+
+		/* Wait for guest to complete execution */
+		td_vcpu_run(vcpu);
+
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+		printf("\t ... Guest completed run on VCPU=%u\n", i);
+	}
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -1169,6 +1316,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_mmio_writes);
 	run_in_new_process(&verify_td_cpuid_tdcall);
 	run_in_new_process(&verify_host_reading_private_mem);
+	run_in_new_process(&verify_tdcall_vp_info);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

