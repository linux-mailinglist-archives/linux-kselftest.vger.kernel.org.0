Return-Path: <linux-kselftest+bounces-38515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B1CB1DE0C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70194583EB3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607E727F01B;
	Thu,  7 Aug 2025 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBpt/ucI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5C2472AE
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597831; cv=none; b=cHZnR3q5SL5PYLzM7GQK0p9BITtgSR2vuN78vipd60NvR2iqLAPfHRFXm/ln4dxuACYefkxj504Bp1Kiah7+lbT2djXVqEdm+PplCStOHEnQC/PyGEFCtcSxyZpJM3nlFH3XWXqlX/sH8tNLVDvTsFqxZO9AB5YV7hmXkjdfWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597831; c=relaxed/simple;
	bh=xl6zU/zvfsPbrUYNAsccEMJ9PE4FINSoXlDmAhqFRU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p/Jedw7JE/8gJGELBiyU0j/FFx+CEsSEtY4YLTv3AXjuQNy6BU9/LLMUrv2P7dPVSLfgO8XK+SqWAbtqPlOMMN9Iy1v2+5x6Sn3kWqGHmiibPuugl7JByD6+GA/wg+69m57hvslbso9Zx56AcbDEWI2qDa4dfwRImaUDmbB1/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBpt/ucI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32147620790so1481748a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597828; x=1755202628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=druJe0O0RVRgmBCK/d78lVDLhUI96RPYL//ATHIqQ7o=;
        b=QBpt/ucI7IAdNccqbRTrH7rREGi4RTnWrmWgvdsXTKgAXQa3Ay07HpUSbSWKJhZ1Sh
         ncc3VX6i/6AwDrgK4PrS7tUFXybIBdtx1CytoeL7jSnDn9AxB2U/qgMmLX5iXHJm10+h
         pmB4LaZLqXd3qY0c9y3tsnP0/K44REyj/MFo+etzAQxI1yrb5/Gn5EPqJvJ+dGKwCRAV
         G10jVTMtA4QliHC3l79LqyL29OLdYJKPElXpPy2eKpWH9/XEO2HTr8izA3ne53eL+wHv
         Ke3o3kqZtlb2IO2ztFtwoshPLcUtrn+iCHwW0CNvE9ZsteoNjV/oiy1bh5JVANU7m0N5
         9+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597828; x=1755202628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=druJe0O0RVRgmBCK/d78lVDLhUI96RPYL//ATHIqQ7o=;
        b=rl1m39gBuuaq8gLKwuU576LXFtoQNn/ZXeQB+khvpo21eIVqoWJG9KSOZG7g18rcUE
         9PLecsXu+vLO9HuAuaJjb6EPN1RGRwE3O1wR3ZbhuN/BsVwVBJ6xwMYIpKkVPo7TOfKf
         TfaaFDZKOZNhoBs6cLIh5IXs9GsrF75ZfQr7TWQ/ZbY/bVU0ptuGuaHLI3nnczwuaM5m
         O1IHDwpqjmvy9WkP4GvBYlpIGLvTKcfCXAUKm8AZL8bFb/Hw/SFAZ6+jDKLKuQwcGg0o
         ntefOSJbMRypNCsbwGj+F/VUoA2q2xrQgguYxd7gRIeb3KNbzMKAEo1N+Rx6h1IBjnEw
         ZUyA==
X-Gm-Message-State: AOJu0Yzt9uwHWNhtxK3uYcNqaOJC/5G00pyu0rd5d9H6Sz93VpTUBAa0
	ur0yfg0x9XQ1WrcWjt1DGwNwthqdArAtV+YP8odCRtKKknlbhzefhA3aXIXf7ogqC229OSx8gY+
	jFWuG144WuBA+kGDIO7TgIcOryzJYwlF/8kdEZCQfn29aq/iG7g/J+KClKVjv4E1sBZY9gnWapJ
	KU4xt76/mwPMept4swEymSVSul8ruAaMZIBPhiGDFBJ1Y=
X-Google-Smtp-Source: AGHT+IGUSVXeE5dAKzb1GPjhE8I5Q7KUcp1AD2kuBLfcvmXIX2vkHNMZ7UR9w2EOlvLEGked2h5t1ulMcQ==
X-Received: from pjpy17.prod.google.com ([2002:a17:90a:a411:b0:321:370d:cae5])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a44:b0:31f:134:94ae
 with SMTP id 98e67ed59e1d1-321839e516dmr510895a91.11.1754597827850; Thu, 07
 Aug 2025 13:17:07 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:16 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-21-sagis@google.com>
Subject: [PATCH v8 20/30] KVM: selftests: TDX: Add TDX CPUID TDVMCALL test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
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
2.51.0.rc0.155.g4a0f42376b-goog


