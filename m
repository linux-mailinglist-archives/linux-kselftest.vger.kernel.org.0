Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1505076257E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGYWD1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjGYWDE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2FD30EA
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583a89cccf6so40313717b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322537; x=1690927337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JviUKZ1WikgtFqYv+P4IGk4tLEv8CEsFncpim7Y4e5s=;
        b=D1y/MVltWTXa4IcpWUzFdATHvOWvmn1dwLzsPNh5Y93NDDQsTCNChP81hHvJarPjic
         ON/n2MWZls86BkDMt7ujEcUnuBMxunrwotQtN9ce+foGcdUr209SpFmkOJqI57FZVX63
         HEIjJeHjdPEl3t/4uFw6Wa49GNx6kfWwnEHNCn1KjHvvd72jaYQTJ9t0bO7ePPG9j9Z7
         dCQgPhHYTEqw8a/wD0kaCC3xDodu41b7UnQaxAjX9szXIC7j6ulW9E4cj2zeWoa6ucaN
         h/EnqBLXIk1dQIQik2a14eOFv+nX5jNMu9/sjCpyoRyEsp+iJ18wb3QBhur5z6OExxlq
         RUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322537; x=1690927337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JviUKZ1WikgtFqYv+P4IGk4tLEv8CEsFncpim7Y4e5s=;
        b=JlUdRwhuPsYud/IM8JnBhKlJaOKldo3N21PxzYeT5HrsXi+bVOJBedkb3udpl0Odp/
         VuAuA+mDnHjEKHeItULtz6IBjUt3bmzDjBdanC5Zp5nrFdb1giOgqR4d1nmSR4PlNHkc
         M7JysFAxIldV97d4S2xP+9WhsmZvHRS8HcOW/4Join4tKdXcClky5wkuP4SXa3bgZ4UT
         p/uMwvv8A7UV+gsK6DkiKg/9I6i3uCSdJsOszULRkly5QasK7uIKfHK7NDzSwBCIShhK
         4yr4Gv0LPIdQY/VEsXGYwqwucw3J2B7ErMEQGIRU+EAhagROgbsIkuoZ/ClSghG9YUg+
         e9OA==
X-Gm-Message-State: ABy/qLbd32TPP1WbQUKw2iGroiSl76kye5Z11/1qE28bhYDETZBbhJg0
        CJvG/3m+UFDjrV8IgMOVICPvwEpkhisiAdUrv0fjvEyFbOQoEglCVsN5kiSNa3UCDDl/VRs0ZrR
        CsfQn2U94sL8l654i7PPu/J5AGDXTQIUEIC7mlkqWwrXqEMVjUQzbbAJv0oRcf0kkupkcYY8LT/
        vR
X-Google-Smtp-Source: APBJJlEHqxwhP///liU7UA79dOoaKwZ/CSF1Twj3yq/4Oi6KWpPKvwTjGJGEWdWSkm6RGiC0wNcowfQxs/Re
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:ac0c:0:b0:d0f:cf5:3282 with SMTP id
 w12-20020a25ac0c000000b00d0f0cf53282mr2411ybi.1.1690322536797; Tue, 25 Jul
 2023 15:02:16 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:08 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-16-afranji@google.com>
Subject: [PATCH v4 15/28] KVM: selftests: TDX: Add TDX MSR read/write tests
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test verifies reads and writes for MSR registers with different access
level.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Idb98e4e9ae64f31ab99b80d2e0e01252316d256a
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   5 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  27 +++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 209 ++++++++++++++++++
 3 files changed, 241 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 63788012bf94..85ba6aab79a7 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -9,11 +9,16 @@
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
+#define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
+#define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
+
 void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
 void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
 uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 					uint64_t *r13, uint64_t *r14);
+uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
+uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index e5a9e13c62e2..88ea6f2a6469 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -87,3 +87,30 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 
 	return ret;
 }
+
+uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value)
+{
+	uint64_t ret;
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_RDMSR,
+		.r12 = index,
+	};
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
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 9ac0b793f8c5..41dad6cf249b 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -515,6 +515,213 @@ void verify_guest_reads(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Define a filter which denies all MSR access except the following:
+ * MSR_X2APIC_APIC_ICR: Allow read/write access (allowed by default)
+ * MSR_IA32_MISC_ENABLE: Allow read access
+ * MSR_IA32_POWER_CTL: Allow write access
+ */
+#define MSR_X2APIC_APIC_ICR 0x830
+static u64 tdx_msr_test_allow_bits = 0xFFFFFFFFFFFFFFFF;
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
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdx_test_report_64bit_to_user_space(data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_rdmsr(MSR_IA32_MISC_ENABLE, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdx_test_report_64bit_to_user_space(data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	/* We expect this call to fail since MSR_IA32_POWER_CTL is write only */
+	ret = tdg_vp_vmcall_instruction_rdmsr(MSR_IA32_POWER_CTL, &data);
+	if (ret) {
+		ret = tdx_test_report_64bit_to_user_space(ret);
+		if (ret)
+			tdx_test_fatal(ret);
+	} else {
+		tdx_test_fatal(-99);
+	}
+
+	tdx_test_success();
+}
+
+void verify_guest_msr_reads(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
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
+	ret = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
+	TEST_ASSERT(ret, "KVM_CAP_X86_USER_SPACE_MSR is unavailable");
+	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
+
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
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	ASSERT_EQ(data, 4);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	ASSERT_EQ(data, 5);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	ASSERT_EQ(data, TDG_VP_VMCALL_INVALID_OPERAND);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
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
+	if (ret)
+		tdx_test_fatal(ret);
+
+	/* We expect this call to fail since MSR_IA32_MISC_ENABLE is read only */
+	ret = tdg_vp_vmcall_instruction_wrmsr(MSR_IA32_MISC_ENABLE, 5);
+	if (ret) {
+		ret = tdx_test_report_64bit_to_user_space(ret);
+		if (ret)
+			tdx_test_fatal(ret);
+	} else {
+		tdx_test_fatal(-99);
+	}
+
+
+	ret = tdg_vp_vmcall_instruction_wrmsr(MSR_IA32_POWER_CTL, 6);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_msr_writes(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
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
+	ret = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
+	TEST_ASSERT(ret, "KVM_CAP_X86_USER_SPACE_MSR is unavailable");
+	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
+
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
+	printf("Verifying guest msr writes:\n");
+
+	printf("\t ... Running guest\n");
+	/* Only the write to MSR_IA32_MISC_ENABLE should trigger an exit */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	ASSERT_EQ(data, TDG_VP_VMCALL_INVALID_OPERAND);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	printf("\t ... Verifying MSR values writen by guest\n");
+
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_X2APIC_APIC_ICR), 4);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_MISC_ENABLE), 0x1800);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_POWER_CTL), 6);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -531,6 +738,8 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_get_td_vmcall_info);
 	run_in_new_process(&verify_guest_writes);
 	run_in_new_process(&verify_guest_reads);
+	run_in_new_process(&verify_guest_msr_writes);
+	run_in_new_process(&verify_guest_msr_reads);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

