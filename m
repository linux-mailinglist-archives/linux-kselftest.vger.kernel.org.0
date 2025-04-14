Return-Path: <linux-kselftest+bounces-30780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2A9A88E5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019A23ABEE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A56221F24;
	Mon, 14 Apr 2025 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+4/ilLz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAF22068D
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667344; cv=none; b=O2+2jD8DuI1/EwpO1CHsC3cJYg9cXa7FUOKMMoJlL4AMYEej4d/dXaQh9qE94kTdpZ6brcC9lpUMiffJr1zaR4iPQxyvXQXpcM0zvYyqI5CbJNiFVJZCnewYVGB8rZFz32yNXijiYOxBVUsImV3as6gaoJTtdRoXqHr96r37R6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667344; c=relaxed/simple;
	bh=bloYu7yWKG/RoRQCqnIADXdWVS+9eixtYsX0/60A/7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GuHKQLrtTtSd5IQEbVHNPL71Sid+pl7h83S0cl/QgWm6etW8q7aqEZoxJhZSPf2U2VBC0OqNonoP4jSdEVD+n8Eopgpcce246gUgCkDOnryTwzYfcaPuScvnCKATbYO2JK9F1YiefuBcyYp0yoCZTyq5qF4elT5HCgBry3leUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+4/ilLz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c135f695so3285790b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667342; x=1745272142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndE2kkPs2bCP8NMS/P4f1C/hPinkE036THKJ89mj2ig=;
        b=D+4/ilLzC4LXnp6XLCJz61oVb2PUZuN6UgKpljXH3Z5tmPCLXB98jfHRlJb6VvW4ym
         ecgUcTcAr0dmRvwVKMn1FKJlDtGg2wy7zGYu2UAWZzlDHsanbqdQHKuVeskhUUgXNWxs
         UiPK1cv57vLN9upYPUXFTAAaa49CLLArUt4BY6knd9YT0HTZ1kP6Aipa3t7CNxsYZ5X3
         FDPaY7bdKuawtvbUKy60ebs97j6S5RKFrcCZvZer5y5A1EzzD9gumQieOzev8zNg+pXh
         NzV/etN3EOuBirTLaQW/8O6BLpWdX1ji1HPKlQoLwlZB8AZQO4KslfZqLN8TOXCFM14b
         buEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667342; x=1745272142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndE2kkPs2bCP8NMS/P4f1C/hPinkE036THKJ89mj2ig=;
        b=GG81xtZhGkr5xWpxFVJfg3zPpkwBQ49n4L6SlZ9PAawTfjwOoUd5UbDO7JiHMbne/r
         MF6rrFtAsI6rU1VejXJ1dQ6bQ6tIYrNA/Ac9617+Ys4XiC+1oYgjz1TzqvGqdwZfW0j/
         hkG1ylLUqyxVfP0Wz3ggIH7v8S5SbyiwMDt5XIjHY0YnT1OIZEr4ER98N0SQH2xnJXWP
         KZ3G66GO2BfNzfODRsP8FMozwv/85OTXA25y96LVFeVJi6zCd3elF490o2o+zbNlLSXS
         B0fu/wYZWrPmReoyIVIxwFNr5JqxCBgyaGzd7CW7+0ZBwVqKh9jIDbjPSb7p2XA3Mjrp
         1Txg==
X-Gm-Message-State: AOJu0YyjYWBB7YbirNVUI9JD/FkcOG599xjp/x2DHdUFdhFUjprV5/Qo
	mABAZPgWkAfz8fml6zhEA4WvaFWogj4gztq4VALNNlf65LXA5KlZ20KW6XxaImn1I+98jG7zpi/
	lyPBNImCRlk0Dw2/r3vjKDNOlF90cfCftJKyLUJTsERjQFt9jfsayvDv2VhppIU3MmCmzeH9A3P
	Hb2NpDew8VjJeImIsNtSb2QvsJ8U7chUCIzYg1XyY=
X-Google-Smtp-Source: AGHT+IGMGK+/PA7ngbs+zF0Fk5eugmdjYN65OhZkDlQZjk9ZGgXv208tlpoCkRhe/gaW6NkShckG+QkxHQ==
X-Received: from pfbcn5.prod.google.com ([2002:a05:6a00:3405:b0:736:3cd5:ba36])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a0e:b0:737:5edd:9805
 with SMTP id d2e1a72fcca58-73bd129b3a6mr18411051b3a.19.1744667342234; Mon, 14
 Apr 2025 14:49:02 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:45 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-17-sagis@google.com>
Subject: [PATCH v6 16/30] KVM: selftests: TDX: Add TDX MSR read/write tests
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
2.49.0.504.g3bcea36a83-goog


