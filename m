Return-Path: <linux-kselftest+bounces-30782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E564BA88E63
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF58D16D72C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427A224B04;
	Mon, 14 Apr 2025 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdHdq4aA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947332222C7
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667348; cv=none; b=VASnvbFKo5a/LlpT4o0PFP4O0RYHBhg44gI3slsv91m19900hrZcFjb3c65zV2nPLG9DQmBkW/bLeiz1FIrhOIkiHeeIdvHikAyMgLfUSByEh4/V0TNAOq6oDwrB376bmpp7B9yqpydgniCLn/sq50Tmu2TlfAnFT7XU1IjEJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667348; c=relaxed/simple;
	bh=GoogKJsZeAyjjoFO4YLbREBy+OQLECrKYgUvZV99NCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SvHNklQJs1dkBTl+Dh0hprOAkYhtZRDvL+gycIUXnIlEiLvjASb+sWtNeowHZ2CIz0DHtGdcX51ny/MlvhS/bHDqZzF3aLmaNDTiQMdp2tPhPYKuUPqb37kt1wP795LajtPsgm4vkXetF1XbrFupTyI1DU3t8Xrv0m4PIATReJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdHdq4aA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7398d70abbfso6164821b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667346; x=1745272146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2RLsiM8uI/kDE51UxTPnyOrPf11hJbtqOdlUue6Dp4=;
        b=KdHdq4aAvZDMMX289iH5Ix5C8aIN24SFeJO6QlmPwUlSyXSMI+jDrPVBlyEnw7CDeR
         RI3xHOB/8Z6avO8r60QQbUzGI1N6eaRFwqakfU0ERXSiUdXZ/wrGSoCAZIz1EDzLDR1/
         +bLwwQ/m4B6Yld7XTkz8oMGrKXC/AMypvibog2bvXxc1FWyhusepN2rMERdEeqEePJ4v
         HzaroFQzMtq3/eTGmXb2/S+P1dxzSdNWReOjlVag/jzAHLcvuDlTj5YwxVltR44U54Ox
         0TRnYxCaQecnYNdWcrsDgVgt5fO0mXZ0TwlQ5MMhsp5f5I4tfgKpnP2DOgFuoAmVi+kl
         i0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667346; x=1745272146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2RLsiM8uI/kDE51UxTPnyOrPf11hJbtqOdlUue6Dp4=;
        b=R+N4mOZBUpbWj+qamm20aROZQ855R5HFIlK9ff147YAb92CSFUDXZ+zVHXcRiNHLw7
         SwLkmEjFvapVdmev3W0qfQE+1PM585xM+2RaaQuTrFxupEORyrUmstBUZ6AhubDcEp1F
         YeRW6IaULMDdOVI7jKPu8ui2KsEx15mAjd0Wn9cjZq21AJ/MFBd/3qzCEwZ+Osldbblg
         blsfcwH/kJcSbhjFm5eBj6FmTPCaZmMbM/wHzh0nHPRNXOdicNukTaY4fMQF+v2daQsG
         9KNc4C/wPjaM/kFiAO7OXdOgb4IbLnjQDeC/iXqaZbXvhZ2KK3IikfCrtFkn3uMqURTM
         Swkg==
X-Gm-Message-State: AOJu0YyWreMD2rr16isoxvWkl5hKXI18FoiL45L6jiQw+NKRhcPk7LDL
	wwTCnmyXQupQvZL/naMC5W4cTQg6S1A/YaB9fl1YHNRW+/2QpC+w65FG1Irx9p1LCjuEJ7DomSf
	Pndw6RjuVWRiHMO94XqO3tp9RB+RpdtiKyHTE2iKY5SC9d0OwbEX8HcSJOHerBg+75mGQnRAyqG
	ld0j3uygHrihMYhnfMhwYwsfZA1F1u4nvCi7Rrcv4=
X-Google-Smtp-Source: AGHT+IFMP3GPPBavUqpIcbrOTurfx3l/q04zj1oOnMy5jXvjQ07o0cQTfH/m1/kfd58dJk4yTRWy+ZT1Kw==
X-Received: from pfaz25.prod.google.com ([2002:aa7:91d9:0:b0:730:b665:d832])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4653:b0:736:3c2b:c38e
 with SMTP id d2e1a72fcca58-73bd11fb5ddmr14823713b3a.13.1744667345778; Mon, 14
 Apr 2025 14:49:05 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:47 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-19-sagis@google.com>
Subject: [PATCH v6 18/30] KVM: selftests: TDX: Add TDX MMIO reads test
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
2.49.0.504.g3bcea36a83-goog


