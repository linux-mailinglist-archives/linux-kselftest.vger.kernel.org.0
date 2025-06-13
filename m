Return-Path: <linux-kselftest+bounces-34949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4BAAD9544
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA337ABEFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C72E6D2E;
	Fri, 13 Jun 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xI02baTt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD832E613C
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842085; cv=none; b=OhcTOxsGHzDc6TwUJGiTYPux0qs3T2vvBxLgZOoeb5P6HjnXkmKGuxaMPymE7UEM/fz4KijsSHLQ+rHGPalOeFWDjP+nf7SXQl806fa9a91+UKVN4Ukr7BqSWEJlztE5FG0DEcam4akxX3i/kvZuQN6Vm6yLrYyMLJJfS60Oc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842085; c=relaxed/simple;
	bh=Si628ZF6xZn+0lEUbdChfRrtx3LQddm9+0kcT06bBJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hgtqyg8LT4iDpNRKDaeW/dIV+xyg0Ec+SWclmLhwMb4NsXTOmJBnKym9PKoOUzAiMI60hW1R5ekcloXtd2ZAY1rBs3JSfC8kRZNfH9enVQs5Snp4xjSzUySmUu1i1T8kvg1vN0/IeSRk5Y++GxpIjb+hpKMNilcDxkfIsbnCWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xI02baTt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso3002151a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842083; x=1750446883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNxHC47MRamy30edTQ2/Z7TS0MyTkgzXr6gKO99CUZI=;
        b=xI02baTtBg3Vp86AFgZC0AE0+yTiGCZe/Qe8BnauT0AYOg7DFPSwiZvZ6sArzuwdw4
         XbPrIFXNO22wmKQXZSm1owVACzMBX/coat3ap4Eo7C8DwuMcO20c98SdxzPkBoQeFN3T
         JYEuB9O9M7cvTVpjIhR0AP/sB9zShZbJiK+Ovtoc/y8kDFR9E8g6CGv7gYR14jj7hP0m
         GYpO3Myv9Lqw2IJdfuQ556WZoLveIR0fCHElTz7YGtaMI68CkvbPAGKCGY90PKz+S9a7
         /PelIE5JeqiTmnvlBpAc29iIwHCYElM/CbPQOb9tP8RoHJnGaGMAFNajA+ltous76nAb
         NdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842083; x=1750446883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNxHC47MRamy30edTQ2/Z7TS0MyTkgzXr6gKO99CUZI=;
        b=WEHZFaAuH0MLW4c1prG9xMdWgkHcVFDf4KN+JbYN9ls5OrLCHbLTMBrcCjwaGNqcj8
         7Fgf8+/FDATRRaSGBo8Idb4/q5j+N/ebzcAVykp+DhzqyOUx0TEicZvweBWivKSKd4Oa
         GoCzhXNuRWpycRIVfM+2J+DeRwEa0xnG6riFYEtqWAgVomHWJPm7jTYl5VygVPAXIvwN
         zH6KY6LJVT7t31lEqf2qq7rTD9T1Zu9dRZjAZZCT2pu9chY1BLGT6+1Z3sYbgd8ecaQB
         /vXhUkh2nPKElrxzJVtwAUlUwDDpNcgNBm/tmRx4rBmg5ZP/v0mTj6+X+U0fYrKmqvXg
         2lgg==
X-Gm-Message-State: AOJu0YwZXaAJuIwg/RA2+2mE9mx0xARPStXv5vAedipdLS/e9b6IUGn1
	nz4wVCK2C0j6WgYvJmS5iweDnVilWMyqKJzboG80k+OTrotPZmDymrB0kt1zXLqzcdQDeQYUoI2
	sEbhlaf3VTSQAy2no1dE4r6LEw+LXfykGuL4eyzYAoNrlXk5IZW8NsRIxknhBoHppjxA5iBWeNT
	qXeFDXa/myIIE6F4oWU1ybvHMeyHHc4W5bhMvHhub7By8=
X-Google-Smtp-Source: AGHT+IFOSI/m+gX9R97dY/cQSKdcl8peNI0MZYBJ+JGRKw/vExof9CTDCaycN+5dWmWHQl7Mc5mFd4dNoA==
X-Received: from pjbok12.prod.google.com ([2002:a17:90b:1d4c:b0:312:e266:f849])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f44:b0:311:c970:c9c5
 with SMTP id 98e67ed59e1d1-313f1bff73dmr1095769a91.7.1749842082969; Fri, 13
 Jun 2025 12:14:42 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:47 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-21-sagis@google.com>
Subject: [PATCH v7 20/30] KVM: selftests: TDX: Add TDX CPUID TDVMCALL test
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
2.50.0.rc2.692.g299adb8693-goog


