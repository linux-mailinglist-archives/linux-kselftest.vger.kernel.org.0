Return-Path: <linux-kselftest+bounces-34947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F53AD953C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFFE16FA4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B442E338B;
	Fri, 13 Jun 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlY69zyA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D244B2472B0
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842082; cv=none; b=bPNHPjhWsELLS+Su7GP7B3f7EsHNyEoF5RSEpGupNrN1+dq2pB35/B7xufvMno0cLYycgyVTFm7A7IZBSz2oEFaKfLDxvEHsnoX2NA+1pGfGUk9qdKAXw7tKeTf3xgNXh2++X1PbjyAV9mksUQI3fSMrqi29liaoc6jMv0Fj8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842082; c=relaxed/simple;
	bh=vkQnGxmnq3FvWRlYyZOPtyDrMgqjYVCxKWTGDV4H4l0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iFk0L2bOB43Q2XLbAoGhhNdbrh7e+xxfDYdVCzKNMuFdahTaXFqNsh0LgqjMEpVybj6NeM0jAPQyFm94nXv5c8DC1S3Zt6kN2D0SIinw4eSl/HFadN+AVe1DVnNUFUQcuGWnvvg2ATL/6CdPMd8ZBwHVvXYalXZA0nbCVcFtjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OlY69zyA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c38df7ed2so1784906a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842080; x=1750446880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFkZUcYMwmohc1Na3cW6XmGA564dj6tHlEnjLwaRw6s=;
        b=OlY69zyA8JvnJHM0GkCNhfa1WE2HwAAx3flkbQcGFUQXdHBXciTkbKFcouuypk/nwJ
         8VQpb1Yn/K5XwCdcz8UpTrMVMh1DAmN/T+CWr9xlWTuIEflRMn6+3P3PkPti4Tu+gkc7
         eKf8NixQjOjYZaWNe564TVAL4F0senu2YHcRplegqDKfZgHYBomSTeAKhqN4oY1P3h2S
         e7XJeDVU9deY8cYM1oCS9A5CFxEJP3ETCRW4qPSUH+8ePLmgNVFSQZpVhxaFp7ec0iXl
         xolbZTDcl9v+esa0Vg8Bar/DF0nDTuvz+n0ApKkD+92A0RyUDKXBtdi9Gw4thCBD0mIS
         qCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842080; x=1750446880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFkZUcYMwmohc1Na3cW6XmGA564dj6tHlEnjLwaRw6s=;
        b=wB3MJxNvsyB9BK3odovucHFpZOAbA/VdrKuDA7RbpgyCkDC0L6fjLsT2MVj+nTL9e6
         TD7LZa2CfyrR8+c/wVl/h2T+IV9Gf5TWd5IV9T5UqxMF0Dap1WX9H8HUOFjPduGpJMQF
         PBwwCfhGe9kSYS/K/y5YO/7iuWn7vkLxatkYz8e5G1wyDY/0dm6dh5blnuNB9YqHuMjB
         2qyNDgDHDXTvOzo/bHuP2SF9EPNIlAFI/RyYAt/QBfUiC+wTHwHxIvbB92+Dq6+NS5rT
         H6WqHc77h3yvDfHHMe5C2zON1t1Mde3Aoip4pqOzz4lLOFtQa6389JlxO6z65E1sGiDS
         I0Tg==
X-Gm-Message-State: AOJu0Yyz4Ny2bY0bOs17h0QgV/jy94kzwcg242JawXyl91A/eFNlLhpT
	lS3AFqz0YcFWH5yw5Ij70+rGE5cBUwURz8iIT4CIFS12oedX1skQxKkab8QBMUdtkxSnpLBJio5
	pU2309PUil6DMRInaCs++Mz6a6Afajm7V+AAHH8tTHyxL/B2d9aY+5XhIWGe2lT0uuElxNUREld
	V5i3qTZjFz+cYyzuB6cNcrr6dam6+riuAdy+h4mOtgwdg=
X-Google-Smtp-Source: AGHT+IHFucHe7xsJxlONn8CbQPufZ/dQvuLc3jBfr1TAOpqGksCXxRbdNPlYykzSm67XzETVBgDYNOSnog==
X-Received: from pgct7.prod.google.com ([2002:a05:6a02:5287:b0:b2c:4ef2:c9f8])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3289:b0:1f5:a3e8:64c1
 with SMTP id adf61e73a8af0-21fbd3d4182mr781718637.0.1749842080043; Fri, 13
 Jun 2025 12:14:40 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:45 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-19-sagis@google.com>
Subject: [PATCH v7 18/30] KVM: selftests: TDX: Add TDX MMIO reads test
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

The test verifies MMIO reads of various sizes from the host to the guest.

Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       |  4 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  1 +
 .../selftests/kvm/include/x86/tdx/test_util.h | 11 +++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 20 +++++
 .../selftests/kvm/lib/x86/tdx/test_util.c     | 19 ++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 89 ++++++++++++++++++-
 6 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index b5831919a215..fa0b24873a8f 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -13,6 +13,7 @@
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
 #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO 48
 
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
@@ -22,4 +23,7 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
 uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
+uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
+					    uint64_t *data_out);
+
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index d66cf17f03ea..c942aec7ad26 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -6,6 +6,7 @@
 
 #include "kvm_util.h"
 
+extern uint64_t tdx_s_bit;
 void tdx_filter_cpuid(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid_data);
 void __tdx_mask_cpuid_features(struct kvm_cpuid_entry2 *entry);
 
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
index 91031e956462..3330d5a54698 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
@@ -17,6 +17,10 @@
 #define PORT_READ	0
 #define PORT_WRITE	1
 
+/* MMIO direction */
+#define MMIO_READ	0
+#define MMIO_WRITE	1
+
 /*
  * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
  * called in the guest.
@@ -24,6 +28,13 @@
 void tdx_test_assert_io(struct kvm_vcpu *vcpu, uint16_t port, uint8_t size,
 			uint8_t direction);
 
+/*
+ * Assert that some MMIO operation involving TDG.VP.VMCALL <#VERequestMMIO> was
+ * called in the guest.
+ */
+void tdx_test_assert_mmio(struct kvm_vcpu *vcpu, uint64_t phys_addr,
+			  uint32_t size, uint8_t is_write);
+
 /*
  * Run the tdx vcpu and check if there was some failure in the guest, either
  * an exception like a triple fault, or if a tdx_test_fatal() was hit.
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index e89ca727286e..8bf41e667fc1 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -4,6 +4,7 @@
 
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
+#include "tdx/test_util.h"
 
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data)
@@ -103,3 +104,22 @@ uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag)
 
 	return __tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
+					    uint64_t *data_out)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
+		.r12 = size,
+		.r13 = MMIO_READ,
+		.r14 = address,
+	};
+	uint64_t ret;
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (data_out)
+		*data_out = args.r11;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
index 8c3b6802c37e..f92ddda2d1ac 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
@@ -31,6 +31,25 @@ void tdx_test_assert_io(struct kvm_vcpu *vcpu, uint16_t port, uint8_t size,
 		    vcpu->run->io.direction);
 }
 
+void tdx_test_assert_mmio(struct kvm_vcpu *vcpu, uint64_t phys_addr,
+			  uint32_t size, uint8_t is_write)
+{
+	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_MMIO,
+		    "Got exit_reason other than KVM_EXIT_MMIO: %u (%s)\n",
+		    vcpu->run->exit_reason,
+		    exit_reason_str(vcpu->run->exit_reason));
+
+	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_MMIO &&
+		    vcpu->run->mmio.phys_addr == phys_addr &&
+		    vcpu->run->mmio.len == size &&
+		    vcpu->run->mmio.is_write == is_write,
+		    "Got an unexpected MMIO exit values: %u (%s) %llu %u %u\n",
+		    vcpu->run->exit_reason,
+		    exit_reason_str(vcpu->run->exit_reason),
+		    vcpu->run->mmio.phys_addr, vcpu->run->mmio.len,
+		    vcpu->run->mmio.is_write);
+}
+
 void tdx_run(struct kvm_vcpu *vcpu)
 {
 	td_vcpu_run(vcpu);
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 720ef5e87071..563f1025c8a3 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -719,6 +719,91 @@ void verify_guest_hlt(void)
 	_verify_guest_hlt(0);
 }
 
+/* Pick any address that was not mapped into the guest to test MMIO */
+#define TDX_MMIO_TEST_ADDR 0x200000000
+#define MMIO_SYNC_VALUE 0x42
+
+void guest_mmio_reads(void)
+{
+	uint64_t mmio_test_addr = TDX_MMIO_TEST_ADDR | tdx_s_bit;
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 1, &data);
+	tdx_assert_error(ret);
+	if (data != 0x12)
+		tdx_test_fatal(1);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 2, &data);
+	tdx_assert_error(ret);
+	if (data != 0x1234)
+		tdx_test_fatal(2);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 4, &data);
+	tdx_assert_error(ret);
+	if (data != 0x12345678)
+		tdx_test_fatal(4);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 8, &data);
+	tdx_assert_error(ret);
+	if (data != 0x1234567890ABCDEF)
+		tdx_test_fatal(8);
+
+	/* Make sure host and guest are synced to the same point of execution */
+	tdx_test_report_to_user_space(MMIO_SYNC_VALUE);
+
+	/* Read an invalid number of bytes. */
+	ret = tdg_vp_vmcall_ve_request_mmio_read(mmio_test_addr, 10, &data);
+	tdx_assert_error(ret);
+
+	tdx_test_success();
+}
+
+/*
+ * Verifies guest MMIO reads.
+ */
+void verify_mmio_reads(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_mmio_reads);
+	td_finalize(vm);
+
+	printf("Verifying TD MMIO reads:\n");
+
+	tdx_run(vcpu);
+	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 1, MMIO_READ);
+	*(uint8_t *)vcpu->run->mmio.data = 0x12;
+
+	tdx_run(vcpu);
+	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 2, MMIO_READ);
+	*(uint16_t *)vcpu->run->mmio.data = 0x1234;
+
+	tdx_run(vcpu);
+	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 4, MMIO_READ);
+	*(uint32_t *)vcpu->run->mmio.data = 0x12345678;
+
+	tdx_run(vcpu);
+	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 8, MMIO_READ);
+	*(uint64_t *)vcpu->run->mmio.data = 0x1234567890ABCDEF;
+
+	tdx_run(vcpu);
+	TEST_ASSERT_EQ(tdx_test_read_report_from_guest(vcpu), MMIO_SYNC_VALUE);
+
+	td_vcpu_run(vcpu);
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[12], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -726,7 +811,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(10);
+	ksft_set_plan(11);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -747,6 +832,8 @@ int main(int argc, char **argv)
 			 "verify_guest_msr_reads\n");
 	ksft_test_result(!run_in_new_process(&verify_guest_hlt),
 			 "verify_guest_hlt\n");
+	ksft_test_result(!run_in_new_process(&verify_mmio_reads),
+			 "verify_mmio_reads\n");
 
 	ksft_finished();
 	return 0;
-- 
2.50.0.rc2.692.g299adb8693-goog


