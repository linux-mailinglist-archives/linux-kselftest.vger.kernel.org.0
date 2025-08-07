Return-Path: <linux-kselftest+bounces-38513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08523B1DE09
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4968622973
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA92A27E048;
	Thu,  7 Aug 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhUUPjGr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF727B50F
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597827; cv=none; b=ocff/Y6tZkGu8289GcOmuYQm/edQZBD/e94bGfnXCnfonLPNIuqAE4ngm1+T9yPCZTqhmYcu8HZ/8PtRxkCmv1HSbZfc4DRsj5e5VI4W2iS8s9P3EzGJS+UmFtp7rz1hXQ4Sw5EE5t1uIflHz5WAnh11ZwSs4xC/c8fQ35upR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597827; c=relaxed/simple;
	bh=FMkCKSKRcFZpMNh9Q4IZQtr8MTE2KZEt29yOX29RxXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=emlQd4xAILhOLxtpX+xGgNdJ2QUz5Ecm6XoWI0RcyKFBXKLQVMAkWDxy2OmkORQlCDHyOvXbjmN6lfxGgGcPgLwFVUyedaNwzSxky9bQDrlosH1qIYtLC0bqN4t3wbvZRlvp2qTDaK6rau/ySxFEE5Uk/+/h5Z/62+kwI5M9ZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhUUPjGr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2400117dd80so10486805ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597825; x=1755202625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsLTirUbGG0My77t7cEfLYkbyyzIAN4Kfd6VyRL4I/U=;
        b=WhUUPjGrjUdnRJShX1M5UOsdsCW+4pITrOUxlJUfGBXND4cwnRCGEhOEc/cTJi2OR1
         NvtRVKdRFaPy06y1lMuT35l+jMULtYyN2ElvP5p9OhQH66vgWbxgsuwypQRcjHySxpa/
         KLlrXSOtsQR8KeWLjYkxEmGBOUUrgUuDEXHWHJHNXv0EjGsT7rwdtWYEtk6kEEsYYQsj
         syz0BMZPxnzZkMneopZt0s2PsJ0x5LmNDCNJYo/m8OrJ23UJnDzGlbjck1sFbKI5iEMc
         0AZbhNSjw0AJ2oHJ2GHCpo7XItOPgtAMfuQQ1lxvavze/m7nqgsdcLrATYc0zEewxvDb
         sOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597825; x=1755202625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsLTirUbGG0My77t7cEfLYkbyyzIAN4Kfd6VyRL4I/U=;
        b=KNtTkJVbQejXN4ien3/KuocOOKCXhKEBrqBekud37XPrX9L0Oa/orulv+N2akwe8Jm
         KBJb589h/qLpT2MaT3rrRlq2lkfTy5Sr3el03pWauTwrB+d51QI+jyyg+Y9D26nsR7Wn
         dPXTd1VKMBRVYIfw+51EJ0+8CbvFZ7upfc3tHjEr//1GN8Fifp2lnh/AhkUj8eZW3HAG
         oJ7yyTzUUhHfvjDrcVI+vXXB6Os8aLm7NWSeBWGZ6gLHAOjAWDPJKwithpEEFBjKaXGW
         fE82k1OFYw6mBh4QXDpcqDVke3Sow77LX2LymTc84fPnGsZ6gGMbn1KY6SJyfZaT6DPW
         E2zA==
X-Gm-Message-State: AOJu0YwQKEYUHV1+0tnKvayaM66lgdNrRK8MYPxR8aahwFU0261YIAmX
	A3a0hsBv7ep8Y/v/xctPJ33g4alL1z/PL9hkHZmqwyXHFyyMYXAoXjd8Ma0oG3O++f0bPRYyxx2
	rUpIM4tZVm7BSq12mZV4t981GppwiX+F4C7UOPykJF5DXLr2u8HkNvP/Hc4lQqtgajtFwDYyxLa
	0qrBmCD0bTRKgPTYbBli0/Krmr6yLES6bbOK5aB0p+z5o=
X-Google-Smtp-Source: AGHT+IEy6HdocJrCpnlewHwLvbW820fcwP7ySk0EHJc3YqSOfGsDRzi8yyD5Xo/x97qQOjknevYhxEyStA==
X-Received: from pjbso3.prod.google.com ([2002:a17:90b:1f83:b0:311:1a09:11ff])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dace:b0:240:3e41:57bf
 with SMTP id d9443c01a7336-242c2003f68mr4699385ad.13.1754597824722; Thu, 07
 Aug 2025 13:17:04 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:14 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-19-sagis@google.com>
Subject: [PATCH v8 18/30] KVM: selftests: TDX: Add TDX MMIO reads test
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
2.51.0.rc0.155.g4a0f42376b-goog


