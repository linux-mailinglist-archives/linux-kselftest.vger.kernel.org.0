Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E9D676236
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjAUATL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjAUAS6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:18:58 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32341B451
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:28 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id f15-20020a62380f000000b0058db55a8d7aso3120414pfa.21
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKecfS8+aCqniCqQsmGPHH5353ve1A7On6Nm/ZOADmI=;
        b=YxTtusFyOuKDAaFVVkuYaK6JCrdmVg2hd8rfn7R3kpLiH7ws96PmQ8/ws5s11KIcIX
         zLEnTLc6KDmWTlMSrg9afGkAagNc87TrQtWMR6LCIK3Q6Wm/Olu9NvN5K9VO7izwCZTy
         ptHOWki55WOJBpgnNEP0HlvY0cft/52KiPRxdrqwNHiMsrdTOzxfz8mQPfRSZ+U453ki
         j0Ph42TE4os2wpwppD2t0oMaSH5fH0HrE0LRcvZpmmjWe1XWBGfgEJkp0qxqPA1yHBQQ
         7gvefe7PCbubTZxyKDDvOfrXp6h79ox0prYOmYxB5mdXGflEg22Tva9g3TWJvd5C7aC+
         7r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKecfS8+aCqniCqQsmGPHH5353ve1A7On6Nm/ZOADmI=;
        b=KPcEjgBAi5RWvy+siEP/B4bHiJm0MUouDj6GoiU9Ngvcf3dMWsgF5r5j33zg/2tY7L
         hEG3cxVb9KbgigFOp24DVW+4gp2zQ488Fz+fMM1ZIFNOGH9CcLCjELkjdkJmCE3V0s91
         Bs52wcwOl/kNgiEZKeg/o/bwD4Hu1995zP0Tp+ST/UeMfusNB0Dq2ctBCuEDODKaeK/7
         hppvtfco5+p37Foc2odazg4gMKFEbHEOkzqc+zyDznCISbaniGcb86X8EnOYguVMn5/p
         D1+3Dk/k2u1ndjhZ5iirPbDV/bn8UzdgEN14L3+u/i97ySfRre+GyLyr8vxzMTLAUrYl
         a0cg==
X-Gm-Message-State: AFqh2kpBUn5JDBhXCPYDw7AWgkFVVh0gp+SwkT5fpApAI7vHvvLH9/nA
        W9sNDIQJtsqQQy49Zv8oXRAy+frobHhPDGVT5+SGV9K2W9XN4oE6WJsF0kCKL0wZ8roUNGItZz/
        KwBILlGiIt8sOcNRfyksxUYgNc/1SgX3lVKIFeiOe7Nw57Wu3Yst/7v8jYS6RkVagYlrAygWhNf
        kxM/LMSI6K8I4=
X-Google-Smtp-Source: AMrXdXsL0BwUIitPOylfaYyud/HjRDUIjwS3hLjmd5OU0WR5b+zjn1m5iCaFoRoJ5nUO9HS0emXgUGIxakBYwGD6WQ==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a62:864b:0:b0:58d:be66:c31f with SMTP
 id x72-20020a62864b000000b0058dbe66c31fmr1941671pfd.73.1674260268576; Fri, 20
 Jan 2023 16:17:48 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:33 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-23-ackerleytng@google.com>
Subject: [RFC PATCH v3 22/31] KVM: selftests: TDX: Add TDG.VP.INFO test
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
Changes RFCv2 -> RFCv3
+ Use KVM_CAP_MAX_VCPUS to set max_vcpus, check that it was passed to
  the TDX module by reading it back
---
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |  19 +++
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   6 +
 .../selftests/kvm/lib/x86_64/tdx/tdcall.S     |  68 ++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  27 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 148 ++++++++++++++++++
 5 files changed, 268 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
index 95fcdbd8404e9..a65ce8f3c109b 100644
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
index e746372206a25..ffab2c3ca312b 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -4,6 +4,8 @@

 #include <stdint.h>

+#define TDG_VP_INFO 1
+
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003

@@ -31,4 +33,8 @@ uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
 					uint32_t *ret_eax, uint32_t *ret_ebx,
 					uint32_t *ret_ecx, uint32_t *ret_edx);

+uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
+		uint64_t *r8, uint64_t *r9,
+		uint64_t *r10, uint64_t *r11);
+
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
index df9c1ed4bb2d1..601d715314434 100644
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
index d9d60dd58dfdd..a280136634d3b 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -162,3 +162,30 @@ uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,

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
index 4c338206dbaf2..e2dba3b5ee63e 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1153,6 +1153,153 @@ void verify_host_reading_private_mem(void)
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
+#define TEST_VP_INFO_MAX_VCPUS 75
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
+	cpuid_entry = kvm_get_supported_cpuid_entry(0x80000008);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+	max_pa = cpuid_entry->eax & 0xff;
+
+	for (i = 0; i < num_vcpus; i++) {
+		struct kvm_vcpu *vcpu = vcpus[i];
+
+		/* Wait for guest to report rcx value */
+		vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		rcx = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report rdx value */
+		vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		rdx = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r8 value */
+		vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		r8 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r9 value */
+		vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		r9 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r10 value */
+		vcpu_run(vcpu);
+		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+		r10 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r11 value */
+		vcpu_run(vcpu);
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
+		vcpu_run(vcpu);
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
@@ -1176,6 +1323,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_mmio_writes);
 	run_in_new_process(&verify_td_cpuid_tdcall);
 	run_in_new_process(&verify_host_reading_private_mem);
+	run_in_new_process(&verify_tdcall_vp_info);

 	return 0;
 }
--
2.39.0.246.g2a6d74b583-goog
