Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEAD762581
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjGYWDb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjGYWDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A763582
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:37 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5635233876bso3130354a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322545; x=1690927345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MO/NczrHEVLOamUwe+IuExly///KToKF6wKDu6dCK1Y=;
        b=07qZM0u/QwoCkjj3KFMsnrBCLSkGBpgHI/TJh4v9wKrjuGMaJk3AIZaKVkYSQJw0MP
         y1hGoY+fOpi/SRmhYMjpZnk7LJJlQ/94uetQ+jLmJuMaL/VAfvGgq2B+hfpfCAG5Tjyj
         LpkcVTEI+qxhx5jIln4nPGOnXvNVe9k4NdjgzvvrrtBj8tMlVKBmHHnENSwJA2JvZZMK
         0oYZzOxDrqEUNIN5cU9rHfhdM+XRAq196dAXqIf+VyREZ606ZvTg1J1CDwPaYHaWUC1l
         jv/oHq9bALYu0b75n/FhNvU7EzwHASm09aL0AAyu+DDNwAXupywEoeNiPbAWYuNC5rkT
         rCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322545; x=1690927345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MO/NczrHEVLOamUwe+IuExly///KToKF6wKDu6dCK1Y=;
        b=OOPwPc9ccLzyHMVexVnkbq6tV5AM0Sy5Zy326xLXsdSDmdad3JB+ltE0VpMRv/GKQ4
         7k/E3C0fhPuLOHvFv4CSiyPHOgxe1Kn96THpeQ4HMMrQqQbihqLalVAXQ9aQ+4N5tWrS
         60IZUw7O+/JZnC5z/aVJZwgQvlJIDiupdvEtCihZUv47pjQerGa9d+SrK1TFS+VsGZ+v
         dpn6ZlaiDRK1t9HjB9RBiKnIwhQV6eZahglaMfDHTSkUvV/Lq5a5NVTRcrUrP1ytF125
         IS48qMASU5Bkf1Ejd5xjSGPwTH/plfNKvUPDT5YM/7x7WvzVTnRNsCQ+tf5jKQNaoSiQ
         cs+w==
X-Gm-Message-State: ABy/qLY3VZ7f9hAsONQxXj+Dai4snqpltHHkaXNivEslM7rb20umstVY
        VqlCmSqW4VwiFP0YEW76Sp7vdWUgd/ciABY6mUmJsCENxIfLZxHmsXGZpZUclawN7zUVET1saJD
        PZmBRaSIzVEWAvuIjf2Gx4X+lPNSXwZAd8Fg+N9sOLBDPOzMORKmBS4ukagKukDfuzS+FKaJbri
        hQ
X-Google-Smtp-Source: APBJJlGTfO5x1jWNvco1aJZJ5NRNF0RtBlIWVvceHkzMatw0dm3WyI2GRV5P5GCe1FGQrqHXeuHcBt0DpAjZ
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:7b5c:0:b0:563:87b3:8c0a with SMTP id
 k28-20020a637b5c000000b0056387b38c0amr1760pgn.7.1690322544316; Tue, 25 Jul
 2023 15:02:24 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:12 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-20-afranji@google.com>
Subject: [PATCH v4 19/28] KVM: selftests: TDX: Add TDX CPUID TDVMCALL test
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

This test issues a CPUID TDVMCALL from inside the guest to get the CPUID
values as seen by KVM.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Ibd1219a119f09e6537717bf48473a387a7c2f51e
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  4 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 26 +++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 94 +++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 502b670ea699..b13a533234fd 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -8,6 +8,7 @@
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
+					uint32_t *ret_eax, uint32_t *ret_ebx,
+					uint32_t *ret_ecx, uint32_t *ret_edx);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index f4afa09f7e3d..a45e2ceb6eda 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -157,3 +157,29 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
 
 	return __tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
+					uint32_t *ret_eax, uint32_t *ret_ebx,
+					uint32_t *ret_ecx, uint32_t *ret_edx)
+{
+	uint64_t ret;
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_CPUID,
+		.r12 = eax,
+		.r13 = ecx,
+	};
+
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
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 79fe56c1052d..a6da9fda1c6b 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -969,6 +969,99 @@ void verify_mmio_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies CPUID TDVMCALL functionality.
+ * The guest will then send the values to userspace using an IO write to be
+ * checked against the expected values.
+ */
+void guest_code_cpuid_tdcall(void)
+{
+	uint64_t err;
+	uint32_t eax, ebx, ecx, edx;
+
+	// Read CPUID leaf 0x1 from host.
+	err = tdg_vp_vmcall_instruction_cpuid(/*eax=*/1, /*ecx=*/0,
+					&eax, &ebx, &ecx, &edx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(eax);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(ebx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(ecx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(edx);
+	if (err)
+		tdx_test_fatal(err);
+
+	tdx_test_success();
+}
+
+void verify_td_cpuid_tdcall(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint32_t eax, ebx, ecx, edx;
+	const struct kvm_cpuid_entry2 *cpuid_entry;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_cpuid_tdcall);
+	td_finalize(vm);
+
+	printf("Verifying TD CPUID TDVMCALL:\n");
+
+	/* Wait for guest to report CPUID values */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	eax = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ebx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ecx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	edx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	/* Get KVM CPUIDs for reference */
+	cpuid_entry = get_cpuid_entry(kvm_get_supported_cpuid(), 1, 0);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+
+	ASSERT_EQ(cpuid_entry->eax, eax);
+	// Mask lapic ID when comparing ebx.
+	ASSERT_EQ(cpuid_entry->ebx & ~0xFF000000, ebx & ~0xFF000000);
+	ASSERT_EQ(cpuid_entry->ecx, ecx);
+	ASSERT_EQ(cpuid_entry->edx, edx);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -990,6 +1083,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_hlt);
 	run_in_new_process(&verify_mmio_reads);
 	run_in_new_process(&verify_mmio_writes);
+	run_in_new_process(&verify_td_cpuid_tdcall);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

