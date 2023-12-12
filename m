Return-Path: <linux-kselftest+bounces-1744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E45F80F851
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A17B2144F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AB764139;
	Tue, 12 Dec 2023 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhbJW4is"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F419B2
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcc464a1cdso613805276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414057; x=1703018857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpSPCIRhHRpzymkSz5bDDdD/wHDWR62G9Siv+tSDD8s=;
        b=NhbJW4isfeFU7k3U6zdYtLtI2vtF/XBcpsU4bnX4wk1VBN1EUpjZ1A0Hl705wPhHsy
         5sOmNRCuXJ69evzb+mOw00IopgNV2H+7f6RhavDVZRGA0huTclBaj2BcTxbHybKH8Rf8
         4XPQY/4Hdrhi3LAXWH7bvXasygMOjT+gW1JHfdx9QTHW4bvLoEH9FyUwf+5Cpi7T1xRu
         kAw52oCczgOnlALqIastyrVXZrrJs2B4WzV3+7boLbNCpBmNWHK8I76NErQeGroYfkT8
         ZFjRYBy14WcpKNrjBT2n4x/dTRDxL06CgSsXTfjpxWwfHAqiUWEMTO1wUbpa08nAWJQt
         EQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414057; x=1703018857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpSPCIRhHRpzymkSz5bDDdD/wHDWR62G9Siv+tSDD8s=;
        b=afQx277xoLo2lu0h25FJfafNdAyjne2fb0GnOqL4aQI9yaofgFC1pJ17VNYER8jSA/
         Qoam344YFwjN1p310wlCwnvDC7Ghe5bTjkx+3H6tx3208bDYQwhaFXRABXkMh4aDWYNm
         hqYXF9wTRGjxcXnccE+CgqUPoG6eM9M/F26XXPNN4em3brzd0s8zE4QuIkNeWThf2vXK
         pW6CdN4S9Tozuv8ctHNtWXvBP+zgS6asIHjbu20BIjMIx6H8QztQE7sr6mUORltR09Ns
         oM8JmRd3lolD2wl6/7M5K7PE/sJ9gGL1jqk1sa8zrX0bSzIfJj5X0JzLJYeNMAEbsTgZ
         GHlQ==
X-Gm-Message-State: AOJu0YzQ1KjVPkbmhQm7G+TxdFvflxsNKCXH9hwgJ7GV06lf2FKnFti7
	yOSm78bQc2fHtd9pvDprXBIDzFCJrd9Hql0b7k15AVccpkZcrqZt2T777C8KNkwmlnJuUKOfMSp
	79b8LqtUklsFUELm9C3t7l6iPUJHWB5hYczpE4lgzoS/3OQ8GFI8DgV2G5nornY3HiHX5uus=
X-Google-Smtp-Source: AGHT+IHaFiHB5g0j+Gqc7x/rareqsp++1Hp/Vp6a8/GVs9HR5DCo9Yyja5AC9+ZLaoupb27tTR3Vn0cIqg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6902:534:b0:db5:41e9:aa1c with SMTP id
 y20-20020a056902053400b00db541e9aa1cmr43956ybs.11.1702414056918; Tue, 12 Dec
 2023 12:47:36 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:36 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-22-sagis@google.com>
Subject: [RFC PATCH v5 21/29] KVM: selftests: TDX: Add TDG.VP.INFO test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Roger Wang <runanwang@google.com>

Adds a test for TDG.VP.INFO

Signed-off-by: Roger Wang <runanwang@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |  19 +++
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   5 +
 .../selftests/kvm/lib/x86_64/tdx/tdcall.S     |  68 ++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  27 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 145 ++++++++++++++++++
 5 files changed, 264 insertions(+)

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
index c977223ff871..60b4504d1245 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1146,6 +1146,150 @@ void verify_host_reading_private_mem(void)
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
+
+	vm = td_create();
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
+		TEST_ASSERT_EQ(rcx & 0x3F, max_pa);
+		/* next 63:6 bits of rcx is reserved and must be 0 */
+		TEST_ASSERT_EQ(rcx >> 6, 0);
+		TEST_ASSERT_EQ(rdx, attributes);
+		TEST_ASSERT_EQ(ret_num_vcpus, num_vcpus);
+		TEST_ASSERT_EQ(ret_max_vcpus, 512);
+		/* VCPU_INDEX = i */
+		TEST_ASSERT_EQ(r9, i);
+		/*
+		 * verify reserved bits are 0
+		 * r10 bit 0 (SYS_RD) indicates that the TDG.SYS.RD/RDM/RDALL
+		 * functions are available and can be either 0 or 1.
+		 */
+		TEST_ASSERT_EQ(r10 & ~1, 0);
+		TEST_ASSERT_EQ(r11, 0);
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
@@ -1169,6 +1313,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_mmio_writes);
 	run_in_new_process(&verify_td_cpuid_tdcall);
 	run_in_new_process(&verify_host_reading_private_mem);
+	run_in_new_process(&verify_tdcall_vp_info);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog


