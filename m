Return-Path: <linux-kselftest+bounces-30786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB1A88E6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F55189AD22
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6162231A23;
	Mon, 14 Apr 2025 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRWmrwcX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C51F4C84
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667354; cv=none; b=iYD5dIIxZunSC2CsbWkYdBxXj7kmSf6K/Duo6JDcY+bijE2dok1RdxBOUFy54GwZs4XUGLigkbCmaktn2hcBLRJWYij/3JRp+L2GIJM2XJ5qnz5s6k4WN5fp8xrYdBOjnDW2KKzPZw43ts6QDC31HnOZSUgDAHRQgf9fxZBhATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667354; c=relaxed/simple;
	bh=Sfv3kaQBIswYGgWMRUcQxpV/Jg9F5jZkyKFBeR1M4Bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SYynYVeI+szoLdRlww7TsyyyjQcwfO0+kBDVbgeJmCx5L3WOG/pYzUYDf4IgYLd1A2VAa/dxAboOPqG5sDlKFdIZzVVoORBRua3TxihRgvsi9Rf76LW88gtFmT2jj8TK18NM5PgP1ZxSFJ79vb1LjQewdKzLaUYgUptH3jWBxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XRWmrwcX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso4963141a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667352; x=1745272152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1iGWcX26V+detLfLQGDCBUiccNnSHIVr4x2B96ebg0=;
        b=XRWmrwcX9WflxWJRPvnYN5Simhnl2mK7GR6i4paCVGiYC8fvS0PdkYtHrKDeecnSGw
         g0f0kQOjRE+vuSNzQz+A93tNxcH+bBR/oaGSDjsyeCGphEPrqPi176gRcqCkPfoEkKKD
         j1x0TFeB6yiaKDNxRH3RY3xVoAhtPFdCUJJ35xhNBFF5/hTGme6w1XXh8h7B4bY6y44d
         PnLxc4bVZ0GMzaEL5AIL9YGqGObf1J6I1SQEuyqfvvQeyulnvwmECVcrCrrXFZE1r+Ea
         JAG6UcDkX6qGS818dTv1+9cVhIHTvNF0kXp3fOveIx7YsBr8IIrY9YLWLvknI5z4lzdW
         TAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667352; x=1745272152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1iGWcX26V+detLfLQGDCBUiccNnSHIVr4x2B96ebg0=;
        b=GMAxEV3QpqL1GmBn4DCawFEPFtd1ksatV7JT9ockPjWDS7q2dVa65QNQdYm0bgp90F
         WjvqGl0nklUJFT68A4WwqhjmH06Uu0ofoRonGR6f53ShxkOJbp7daLx1+a7SmgEkC7R1
         teJCoVMU8xZDFdVf3errJvImjAeN/BMgbVaACq+KrLmI0bFSkATPxzwpyclGlDKdyfff
         B7vyjSRtd5eOe2nkqfaMu504juZ54jtsA2nNFvuSRbeTNpRbN/LHWtv4rDLnss+xKBM/
         QMrg/5MfDXL+bRACS1+neRSmb2x/UNA1G9JGi0UbsQ709+NmZaH7MID1RfNjRmKBnpvB
         aHeA==
X-Gm-Message-State: AOJu0YzvBTW7LtkS3nV8TnUUFwlCPx8vVNqnzAoG9J4fc14PcmAAz2px
	epZW2xjtuClbpmapVEUstxDTFV34vmGliYtuxYSbUAugeiEgPYPJOHkklDvxiktEWfW5/+S12rG
	NLrobLfhm6JhW9Bjs4/jBPGXDA++jXpWZuOW5LJzrT7Suw2llRo3LAa9VNUFKR5yoLx8TpoXS6K
	02Kd42BqWka0kO8gb0XGUFWGd/BNhxaRS6UGr01E4=
X-Google-Smtp-Source: AGHT+IHN/o3u5VMP0gocs5ttFv3BCUG4toEkqnn4bn9CXYA1Wm0slXGQetWNhpp0BXp2cbPVLXA0gPZ4kw==
X-Received: from pjz3.prod.google.com ([2002:a17:90b:56c3:b0:301:2679:9aa])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:524f:b0:2ee:f80c:6889
 with SMTP id 98e67ed59e1d1-30823680abamr22201923a91.33.1744667351964; Mon, 14
 Apr 2025 14:49:11 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:51 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-23-sagis@google.com>
Subject: [PATCH v6 22/30] KVM: selftests: TDX: Add TDG.VP.INFO test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Roger Wang <runanwang@google.com>

Adds a test for TDG.VP.INFO.

Introduce __tdx_module_call() that does needed shuffling from function
parameters to registers used by the TDCALL instruction that is used by the
guest to communicate with the TDX module. The first function parameter is
the leaf number indicating which guest side function should be run, for
example, TDG.VP.INFO.

The guest uses new __tdx_module_call() to call TDG.VP.INFO to obtain TDX
TD execution environment information from the TDX module. All returned
registers are passed back to the host that verifies values for
correctness.

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Roger Wang <runanwang@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdcall.h    |  19 +++
 .../selftests/kvm/include/x86/tdx/tdx.h       |   5 +
 .../selftests/kvm/lib/x86/tdx/tdcall.S        |  68 +++++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  27 ++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 133 +++++++++++++++++-
 5 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
index e7440f7fe259..ab1a97a82fa9 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
@@ -32,4 +32,23 @@ struct tdx_hypercall_args {
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
+		      struct tdx_module_output *out);
+
 #endif // SELFTESTS_TDX_TDCALL_H
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 060158cb046b..801ca879664e 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -6,6 +6,8 @@
 
 #include "kvm_util.h"
 
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
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
index b10769d1d557..c393a0fb35be 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
@@ -91,5 +91,73 @@ __tdx_hypercall:
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
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index fb391483d2fa..ab6fd3d7ae4b 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -162,3 +162,30 @@ uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
 
 	return ret;
 }
+
+uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
+		     uint64_t *r8, uint64_t *r9,
+		     uint64_t *r10, uint64_t *r11)
+{
+	struct tdx_module_output out;
+	uint64_t ret;
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
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index b6ef0348746c..82acc17a66ab 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -1038,6 +1038,135 @@ void verify_host_reading_private_mem(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Do a TDG.VP.INFO call from the guest
+ */
+void guest_tdcall_vp_info(void)
+{
+	uint64_t rcx, rdx, r8, r9, r10, r11;
+	uint64_t err;
+
+	err = tdg_vp_info(&rcx, &rdx, &r8, &r9, &r10, &r11);
+	tdx_assert_error(err);
+
+	/* return values to user space host */
+	err = tdx_test_report_64bit_to_user_space(rcx);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_64bit_to_user_space(rdx);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_64bit_to_user_space(r8);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_64bit_to_user_space(r9);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_64bit_to_user_space(r10);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_64bit_to_user_space(r11);
+	tdx_assert_error(err);
+
+	tdx_test_success();
+}
+
+/*
+ * TDG.VP.INFO call from the guest. Verify the right values are returned
+ */
+void verify_tdcall_vp_info(void)
+{
+	const struct kvm_cpuid_entry2 *cpuid_entry;
+	uint32_t ret_num_vcpus, ret_max_vcpus;
+	uint64_t rcx, rdx, r8, r9, r10, r11;
+	const int num_vcpus = 2;
+	struct kvm_vcpu *vcpus[num_vcpus];
+	uint64_t attributes;
+	struct kvm_vm *vm;
+	int gpa_bits = -1;
+	uint32_t i;
+
+	vm = td_create();
+
+#define TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT	BIT(28)
+	/* Setting attributes parameter used by TDH.MNG.INIT to 0x10000000 */
+	attributes = TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT;
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
+
+	for (i = 0; i < num_vcpus; i++) {
+		struct kvm_vcpu *vcpu = vcpus[i];
+
+		cpuid_entry = vcpu_get_cpuid_entry(vcpu, 0x80000008);
+		TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+		gpa_bits = (cpuid_entry->eax & GENMASK(23, 16)) >> 16;
+		TEST_ASSERT_EQ((1UL << (gpa_bits - 1)), tdx_s_bit);
+
+		/* Wait for guest to report rcx value */
+		tdx_run(vcpu);
+		rcx = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report rdx value */
+		tdx_run(vcpu);
+		rdx = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r8 value */
+		tdx_run(vcpu);
+		r8 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r9 value */
+		tdx_run(vcpu);
+		r9 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r10 value */
+		tdx_run(vcpu);
+		r10 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		/* Wait for guest to report r11 value */
+		tdx_run(vcpu);
+		r11 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+		ret_num_vcpus = r8 & 0xFFFFFFFF;
+		ret_max_vcpus = (r8 >> 32) & 0xFFFFFFFF;
+
+		/* first bits 5:0 of rcx represent the GPAW */
+		TEST_ASSERT_EQ(rcx & 0x3F, gpa_bits);
+		/* next 63:6 bits of rcx is reserved and must be 0 */
+		TEST_ASSERT_EQ(rcx >> 6, 0);
+		TEST_ASSERT_EQ(rdx, attributes);
+		TEST_ASSERT_EQ(ret_num_vcpus, num_vcpus);
+		TEST_ASSERT_EQ(ret_max_vcpus, vm_check_cap(vm, KVM_CAP_MAX_VCPUS));
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
+		tdx_run(vcpu);
+
+		tdx_test_assert_success(vcpu);
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
 	ksft_print_header();
@@ -1045,7 +1174,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(14);
+	ksft_set_plan(15);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -1074,6 +1203,8 @@ int main(int argc, char **argv)
 			 "verify_td_cpuid_tdcall\n");
 	ksft_test_result(!run_in_new_process(&verify_host_reading_private_mem),
 			 "verify_host_reading_private_mem\n");
+	ksft_test_result(!run_in_new_process(&verify_tdcall_vp_info),
+			 "verify_tdcall_vp_info\n");
 
 	ksft_finished();
 	return 0;
-- 
2.49.0.504.g3bcea36a83-goog


