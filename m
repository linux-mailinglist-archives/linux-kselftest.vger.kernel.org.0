Return-Path: <linux-kselftest+bounces-30784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF9A88E66
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C282189AE2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BB322D799;
	Mon, 14 Apr 2025 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5HxBivz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A7226888
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667351; cv=none; b=Di8j4msO6rgwFCx5080xTZEm1y60qmH/JR4lKKjDp6nyMHH19FlPJa75bAspAB9aylzlqZTj1p9MnM+pkEsPz2q2rrxYE4NpBdXPa4IvXcpbfG40e6iwjQYHIm4UKJhoBCJv7pjrLqNnsG7V+iypnKMgFm1D7u3QbqMkthaHRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667351; c=relaxed/simple;
	bh=Y6eMHmKXAJqMczddkRzIdBR8EpWdf0rce91o1reoHc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KM9LU0L5OdIWwzl1z5uK/Z1z1VlAxLQLW+rlLwKyOUFYhVqqjns9+xDLhcz9AtPmSqPk1xElOpSTyRHAUj4HhtnXIEWeAAsnsnrtsB3A8YwB5roEW7r50dooVWckHCoicsVRgfx9x+Dg/QTC1qNEuNK9TbfIMhJIMWD/EOGeFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5HxBivz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c135f695so3285823b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667349; x=1745272149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYwg8TdmWCk3T9p5kNwzx3t5d6I30QKfFvk2L0UQtuk=;
        b=V5HxBivzwaMwvzxzMrRz8gz+VOyWUvhHD50vCyp/etzFfjDdky0u73NIYbfWh0fv4d
         t/Z1YG259/tV1Zsq4xbIIBl9OMqwCJPA6g7+BxyNzi+2uW7O8snSdhHy52sy1J0y3KzS
         sn9LRTFdBpd2Jl+LB3/E8bzuC/NL9lT8vT//mjuPLCUA+ckGaWfSdn8iXJtUWfQQrZPi
         mxwLQ2bG4yqBbvY5tJXYf+8z+V6wezp4KQfbStt6zMBloOcK3yhJ9j1ucRlrLeis4QZW
         D+qmAzoN6XbeQjOlBwwzNGhi/B9zgyeYDXfBzvgPLpjv+HQQ1rF3lP2KBvr3IRiV0s1Y
         r/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667349; x=1745272149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYwg8TdmWCk3T9p5kNwzx3t5d6I30QKfFvk2L0UQtuk=;
        b=aDW7pGuxdRPpi6YC5kJKEFIfR+NqGHij0Iej/tufZOiK/K2H8s/oiAQIhovf2w62/V
         foj0i43nGV0MdMuhO5sArgn0eXodR+O/Ng9OV2UfM1rOkpPyedLbCEkPXb1GYoSH8P0S
         Yc4nDenXhdjXSxhtVeCjuQNWEsi3bTd02SXqc04Lj3aWz9Eq3kMIfsXKWQZyV7fgWKiZ
         gZJlHVKOiSFB6Fvwp5sDK8RYpsMsB+dTDVupRqljCNl5RkSzy0/ivMS3Qkva7LwxCeHV
         mYFsB1rK/StEYoOjHh84VnqKH0IFWWnZp+U+5KZQeMz3BmY80vMTc3No0WAet2VDc3BJ
         25Bg==
X-Gm-Message-State: AOJu0YxuRbKzCX65jJJU01csCIslQw6IXRbjmLNmGUgG+lh4OjMC4T9b
	6YYPkz9JsnHvlXZGZllmTx0f57R9/xty7iWkK8uEeVyx/JZovuJqnlQBe3k05/+ahi8juJWePNW
	0GcfRNIcOBs7IC36Zidb136l3KiO50XFTubI8Pz0jZkySpXTdiGuf9SuakeYAHOnM3BmtPArJ8s
	on1RYXW7crqZVeJGZqDWW/C9lip+VDvUfOOqYTWx4=
X-Google-Smtp-Source: AGHT+IFfnjHvI0Hr8zbOlQpaZID7B5dC+bHIujEPDiLUj9dravF8KildUU8LlTOQMct5heWK/HK8gMJsiA==
X-Received: from pgbk9.prod.google.com ([2002:a63:5609:0:b0:b06:7f2c:24d6])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9012:b0:1f5:59e5:8ade
 with SMTP id adf61e73a8af0-2017996f6c8mr21511859637.29.1744667348833; Mon, 14
 Apr 2025 14:49:08 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:49 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-21-sagis@google.com>
Subject: [PATCH v6 20/30] KVM: selftests: TDX: Add TDX CPUID TDVMCALL test
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

This test issues a CPUID TDVMCALL from inside the guest to get the CPUID
values as seen by KVM.

Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       |  4 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 25 ++++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 78 ++++++++++++++++++-
 3 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 2fd67c3e5128..060158cb046b 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -9,6 +9,7 @@
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
+#define TDG_VP_VMCALL_INSTRUCTION_CPUID 10
 #define TDG_VP_VMCALL_INSTRUCTION_HLT 12
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
@@ -27,5 +28,8 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 					    uint64_t *data_out);
 uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
 					     uint64_t data_in);
+uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
+					 uint32_t *ret_eax, uint32_t *ret_ebx,
+					 uint32_t *ret_ecx, uint32_t *ret_edx);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index d61940fe7df4..fb391483d2fa 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -137,3 +137,28 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
 
 	return __tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
+					 uint32_t *ret_eax, uint32_t *ret_ebx,
+					 uint32_t *ret_ecx, uint32_t *ret_edx)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_CPUID,
+		.r12 = eax,
+		.r13 = ecx,
+	};
+	uint64_t ret;
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (ret_eax)
+		*ret_eax = args.r12;
+	if (ret_ebx)
+		*ret_ebx = args.r13;
+	if (ret_ecx)
+		*ret_ecx = args.r14;
+	if (ret_edx)
+		*ret_edx = args.r15;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 6ad675a93eeb..2f75f12d2a44 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -885,6 +885,80 @@ void verify_mmio_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies CPUID TDVMCALL functionality.
+ * The guest will then send the values to userspace using an IO write to be
+ * checked against the expected values.
+ */
+void guest_code_cpuid_tdcall(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+	uint64_t err;
+
+	/* Read CPUID leaf 0x1 from host. */
+	err = tdg_vp_vmcall_instruction_cpuid(/*eax=*/1, /*ecx=*/0,
+					      &eax, &ebx, &ecx, &edx);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_to_user_space(eax);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_to_user_space(ebx);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_to_user_space(ecx);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_to_user_space(edx);
+	tdx_assert_error(err);
+
+	tdx_test_success();
+}
+
+void verify_td_cpuid_tdcall(void)
+{
+	struct kvm_cpuid_entry2 *cpuid_entry;
+	uint32_t eax, ebx, ecx, edx;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_cpuid_tdcall);
+	td_finalize(vm);
+
+	printf("Verifying TD CPUID TDVMCALL:\n");
+
+	/* Wait for guest to report CPUID values */
+	tdx_run(vcpu);
+	eax = tdx_test_read_report_from_guest(vcpu);
+
+	tdx_run(vcpu);
+	ebx = tdx_test_read_report_from_guest(vcpu);
+
+	tdx_run(vcpu);
+	ecx = tdx_test_read_report_from_guest(vcpu);
+
+	tdx_run(vcpu);
+	edx = tdx_test_read_report_from_guest(vcpu);
+
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	/* Get KVM CPUIDs for reference */
+	cpuid_entry = vcpu_get_cpuid_entry(vcpu, 1);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+
+	TEST_ASSERT_EQ(cpuid_entry->eax, eax);
+	/* Mask lapic ID when comparing ebx. */
+	TEST_ASSERT_EQ(cpuid_entry->ebx & ~0xFF000000, ebx & ~0xFF000000);
+	TEST_ASSERT_EQ(cpuid_entry->ecx, ecx);
+	TEST_ASSERT_EQ(cpuid_entry->edx, edx);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -892,7 +966,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(12);
+	ksft_set_plan(13);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -917,6 +991,8 @@ int main(int argc, char **argv)
 			 "verify_mmio_reads\n");
 	ksft_test_result(!run_in_new_process(&verify_mmio_writes),
 			 "verify_mmio_writes\n");
+	ksft_test_result(!run_in_new_process(&verify_td_cpuid_tdcall),
+			 "verify_td_cpuid_tdcall\n");
 
 	ksft_finished();
 	return 0;
-- 
2.49.0.504.g3bcea36a83-goog


