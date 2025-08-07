Return-Path: <linux-kselftest+bounces-38511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42173B1DE01
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4689A00E1E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFC727A927;
	Thu,  7 Aug 2025 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4EdfTbp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45EA27A10D
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597824; cv=none; b=OgIu3TkWBUsAu7PfeKNw4LD7fqjhA5z03OZzYNRefZjOTckTLyGDdTAnhEHlMU7IxVOCesTg0fWv/z0501ARhJDAvWaGr0iaXrkB+37qVcvUOncBIynSalMaxxxdp42RVaTOht7AMFOvON5cKwIm+XvtNIwAKkghSZJ9L3poEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597824; c=relaxed/simple;
	bh=mgieOFUSYa7cCcBHiMCkot7ZE759Q2zKk6cM14CkOtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sq1avWFwKiviiDPfrNtw670+UT3i5+SV3lJ/jUpqUSctHG1zUfkaBNjrdXrCyUSMtPGpPylj6mYJMumQu2hp3URMpDSErmvtdzOhNYQ4RVrtpfZDJCNCgaryYGhah+MD/owy/0Yz4v89MRFFzRxxDNOEjLdXOu4WC+OgknFM0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4EdfTbp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bfab12672so2913610b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597822; x=1755202622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0LkjNICrNMaEHIQPUz5pGQXMjCUxxwu1qIsBHlM+qg=;
        b=X4EdfTbpsIi96/MmD/xD1I030tMsf7MR1KP+TKLsa1HXNYVPSTB5RkF94bmlzdHPbR
         MAlPYa1ot11XRT/pOnRtDFavH5lcqva5k7OXuZtOj21i+PYFPJgrNl/ImSlripD/cSJZ
         jsU1NiOLkVasxjMnYmdDUrFVvtfKwKNF4rBlnNdhtMs+vbViAaoSY4Y7DIun2K7HYhTw
         wj66G8qPI8SmJxKRgQ2Rkexu6UFYKyHel6OR/HQ71xr/GXZCInY6xm6rP0nrI/jxjSbE
         MfqYT9chA4TFwTxXQiJ5k67+kRw0P+er+RbK3Q7xONEdNfs14kbzSS2q/gI5iXDEyKAF
         cWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597822; x=1755202622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0LkjNICrNMaEHIQPUz5pGQXMjCUxxwu1qIsBHlM+qg=;
        b=fmHr8BFPtv7wzaBq2RU/7rYA5DrpmCVd8cLeFwQWR9XVkclmymWDzsET6CBJDtL0Cd
         i6nTAWrSoV7kO6+WELjQqhkIwTBrFghD1XmOYdnUH0QveyFaCyZz7Jbs/fvNXVC0JTXX
         CpctVdntDPT3niiia9v9qvwoyt8467/3spmn6gvDxYcHfQcQSnDlukdogpSOBmwJlsW6
         kVMqYnX9SYNkKT2Yj+8Cu0D2w89+9yzoket/IOTLYxMj5TfQkECOOhfXTsbW3tfNZegL
         Qvwbay3cpQk2J3/vfKOoXqR1X5c5PI54ZHkBDgsotE0TZDRvGMVQU5F3ilxfrz13oTav
         oasQ==
X-Gm-Message-State: AOJu0YwY2ItCRYqkn10JpjT4gy3A2OTVGtRK6sBSu8S86jyv+ijsNJgk
	uqhjOZQpSn1i/uT04ZIzi8pSN5T47yNO+J2qkzk+iFlnjvgO1Qngyqzg6ADtqvNLBT5VXsNuUGY
	fMTSykLdWEZHLFTm74OkIWbrNaakwBeOILGwCN3GLjC1ZcUwFWIsSRAdHiIK8osE725kg1qD4TC
	s4RVb/V1JcrEQnFVLjpKzD8Glkg9H1Qd3w+w7aUwfsmFM=
X-Google-Smtp-Source: AGHT+IHhxS2zq041/Rym1xe07wJU9Lm4/VTiXhKQTNb2lDWMIb1B0MXF3TLhCG9iExoGsWogGD5zoEjvNA==
X-Received: from pgbds10.prod.google.com ([2002:a05:6a02:430a:b0:b42:38ba:fe24])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a25:b0:238:351a:6442
 with SMTP id adf61e73a8af0-2405522ee22mr314041637.45.1754597821959; Thu, 07
 Aug 2025 13:17:01 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:12 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-17-sagis@google.com>
Subject: [PATCH v8 16/30] KVM: selftests: TDX: Add TDX MSR read/write tests
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

The test verifies reads and writes for MSR registers with different access
level.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       |   4 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  27 +++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 193 +++++++++++++++++-
 3 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 97ceb90c8792..56359a8c4c19 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -10,10 +10,14 @@
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
+#define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
+#define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
 
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
 void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
 uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 					  uint64_t *r13, uint64_t *r14);
+uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
+uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index 5105dfae0e9e..99ec45a5a657 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -66,3 +66,30 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 
 	return ret;
 }
+
+uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_RDMSR,
+		.r12 = index,
+	};
+	uint64_t ret;
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (ret_value)
+		*ret_value = args.r11;
+
+	return ret;
+}
+
+uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_WRMSR,
+		.r12 = index,
+		.r13 = value,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index ae5749e5c605..079ac266a44e 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -455,6 +455,193 @@ void verify_guest_reads(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Define a filter which denies all MSR access except the following:
+ * MSR_X2APIC_APIC_ICR: Allow read/write access (allowed by default)
+ * MSR_IA32_MISC_ENABLE: Allow read access
+ * MSR_IA32_POWER_CTL: Allow write access
+ */
+#define MSR_X2APIC_APIC_ICR 0x830
+static u64 tdx_msr_test_allow_bits = ~0ULL;
+struct kvm_msr_filter tdx_msr_test_filter = {
+	.flags = KVM_MSR_FILTER_DEFAULT_DENY,
+	.ranges = {
+		{
+			.flags = KVM_MSR_FILTER_READ,
+			.nmsrs = 1,
+			.base = MSR_IA32_MISC_ENABLE,
+			.bitmap = (uint8_t *)&tdx_msr_test_allow_bits,
+		}, {
+			.flags = KVM_MSR_FILTER_WRITE,
+			.nmsrs = 1,
+			.base = MSR_IA32_POWER_CTL,
+			.bitmap = (uint8_t *)&tdx_msr_test_allow_bits,
+		},
+	},
+};
+
+/*
+ * Verifies MSR read functionality.
+ */
+void guest_msr_read(void)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_rdmsr(MSR_X2APIC_APIC_ICR, &data);
+	tdx_assert_error(ret);
+
+	ret = tdx_test_report_64bit_to_user_space(data);
+	tdx_assert_error(ret);
+
+	ret = tdg_vp_vmcall_instruction_rdmsr(MSR_IA32_MISC_ENABLE, &data);
+	tdx_assert_error(ret);
+
+	ret = tdx_test_report_64bit_to_user_space(data);
+	tdx_assert_error(ret);
+
+	/* Expect this call to fail since MSR_IA32_POWER_CTL is write only */
+	ret = tdg_vp_vmcall_instruction_rdmsr(MSR_IA32_POWER_CTL, &data);
+	if (ret) {
+		ret = tdx_test_report_64bit_to_user_space(ret);
+		tdx_assert_error(ret);
+	} else {
+		tdx_test_fatal(-99);
+	}
+
+	tdx_test_success();
+}
+
+void verify_guest_msr_reads(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t data;
+	int ret;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+
+	/*
+	 * Set explicit MSR filter map to control access to the MSR registers
+	 * used in the test.
+	 */
+	printf("\t ... Setting test MSR filter\n");
+	ret = kvm_check_cap(KVM_CAP_X86_MSR_FILTER);
+	TEST_ASSERT(ret, "KVM_CAP_X86_MSR_FILTER is unavailable");
+
+	ret = ioctl(vm->fd, KVM_X86_SET_MSR_FILTER, &tdx_msr_test_filter);
+	TEST_ASSERT(ret == 0,
+		    "KVM_X86_SET_MSR_FILTER failed, ret: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+
+	vcpu = td_vcpu_add(vm, 0, guest_msr_read);
+	td_finalize(vm);
+
+	printf("Verifying guest msr reads:\n");
+
+	printf("\t ... Setting test MSR values\n");
+	/* Write arbitrary to the MSRs. */
+	vcpu_set_msr(vcpu, MSR_X2APIC_APIC_ICR, 4);
+	vcpu_set_msr(vcpu, MSR_IA32_MISC_ENABLE, 5);
+	vcpu_set_msr(vcpu, MSR_IA32_POWER_CTL, 6);
+
+	printf("\t ... Running guest\n");
+	tdx_run(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	TEST_ASSERT_EQ(data, 4);
+
+	tdx_run(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	TEST_ASSERT_EQ(data, 5);
+
+	tdx_run(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	TEST_ASSERT_EQ(data, TDG_VP_VMCALL_INVALID_OPERAND);
+
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+/*
+ * Verifies MSR write functionality.
+ */
+void guest_msr_write(void)
+{
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_wrmsr(MSR_X2APIC_APIC_ICR, 4);
+	tdx_assert_error(ret);
+
+	/* Expect this call to fail since MSR_IA32_MISC_ENABLE is read only */
+	ret = tdg_vp_vmcall_instruction_wrmsr(MSR_IA32_MISC_ENABLE, 5);
+	if (ret) {
+		ret = tdx_test_report_64bit_to_user_space(ret);
+		tdx_assert_error(ret);
+	} else {
+		tdx_test_fatal(-99);
+	}
+
+	ret = tdg_vp_vmcall_instruction_wrmsr(MSR_IA32_POWER_CTL, 6);
+	tdx_assert_error(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_msr_writes(void)
+{
+	uint64_t ia32_misc_enable_val;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t data;
+	int ret;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+
+	/*
+	 * Set explicit MSR filter map to control access to the MSR registers
+	 * used in the test.
+	 */
+	printf("\t ... Setting test MSR filter\n");
+	ret = kvm_check_cap(KVM_CAP_X86_MSR_FILTER);
+	TEST_ASSERT(ret, "KVM_CAP_X86_MSR_FILTER is unavailable");
+
+	ret = ioctl(vm->fd, KVM_X86_SET_MSR_FILTER, &tdx_msr_test_filter);
+	TEST_ASSERT(ret == 0,
+		    "KVM_X86_SET_MSR_FILTER failed, ret: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+
+	vcpu = td_vcpu_add(vm, 0, guest_msr_write);
+	td_finalize(vm);
+
+	ia32_misc_enable_val = vcpu_get_msr(vcpu, MSR_IA32_MISC_ENABLE);
+
+	printf("Verifying guest msr writes:\n");
+
+	printf("\t ... Running guest\n");
+	/* Only the write to MSR_IA32_MISC_ENABLE should trigger an exit */
+	tdx_run(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	TEST_ASSERT_EQ(data, TDG_VP_VMCALL_INVALID_OPERAND);
+
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	printf("\t ... Verifying MSR values written by guest\n");
+
+	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_X2APIC_APIC_ICR), 4);
+	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_MISC_ENABLE),
+		       ia32_misc_enable_val);
+	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_POWER_CTL), 6);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -462,7 +649,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(7);
+	ksft_set_plan(9);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -477,6 +664,10 @@ int main(int argc, char **argv)
 			 "verify_guest_writes\n");
 	ksft_test_result(!run_in_new_process(&verify_guest_reads),
 			 "verify_guest_reads\n");
+	ksft_test_result(!run_in_new_process(&verify_guest_msr_writes),
+			 "verify_guest_msr_writes\n");
+	ksft_test_result(!run_in_new_process(&verify_guest_msr_reads),
+			 "verify_guest_msr_reads\n");
 
 	ksft_finished();
 	return 0;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


