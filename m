Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940F2676231
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjAUAS7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjAUASj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:18:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0066917C8
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so7427784ybc.18
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOwGtki9KFPboHEALtokyYZ7SUKgOo9ywAkWpYTPLlY=;
        b=GNQli3vbWyBQzWxSUIC96W0IJYbF/Ojtzs3NaAk6EebJ69mMu9B+S0lR/AJ9VJNhM+
         +P4JZw6H/PyqDMcyw3GGXZIdf/Mrzaek7lKsK5lapeiukAg4Q+GsGhb35Iveh2wG2Tqp
         /lI8101PQATC701yjLYNZ/0O+drh4usGew30l4ALSElGN4St029Q+bITRmxWi6h9N5C1
         0c3FrL2OGNPIpjK9SEuo3Z/HOPkIMlGSs756uoHPN+TOgAfAnHFf3k7cjJv4oa+iakWO
         SiZJdc/Y+YwlsFlLLBMvrFt/tFkHq8Ovxm1JcaxykTQ8QxByz5py1XYnkLuq4pfN9ALw
         780Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOwGtki9KFPboHEALtokyYZ7SUKgOo9ywAkWpYTPLlY=;
        b=5tsNUMMOfbhIB9VkndgAeYPrErwkwh7TEJRynAv53nH92GLRD7ZCtUMUnhzuTx7jdr
         rWQXTYJLPHIAW7eUQwUxqfy7f90oQTutgF3nz2zjZOxy2jgAuLhxa6aIF9QHyISb0dSw
         jij6IZ0+blm527A+OuiDqfbxwJ5i1cdh44Ogt7AvdyXCbQbbIfH9p489eEopbpEYjVo4
         S8Fho2olnzhWz4WsxS4pFYG9oXQy63uQ/hvlfssNKcsIHnUpx5VQoC93t84L2SlAr+LN
         0VBUjL8wBphYgRfKnjQc259NtfgYGp6Xajr4yOF+Gg8//ghYNjYxHXxYt0MFsirUlWqe
         VP0Q==
X-Gm-Message-State: AFqh2koVn5+w35Y4KgaoAIqDlr4OPm7pdLqYp8lK3zn2fMIRpo/cdITX
        k9bLyM1jTgISwWNDcUFOxtFAqs6w+KFlXZxYy6+PsH3OZGgrp9xEhFjfI1hrc5a2pkU3jZs71ed
        SHdA5SxYAZREKf8+hehQUlzRcZHfLxJQkgCGo8UlKqW1Ebp3SK04HMdbX9IgG7m6LaAu17Zlzrf
        UXA+KtaMWv4dw=
X-Google-Smtp-Source: AMrXdXuSW1/3B2FF32Z+SDnMOS3ZH7UUnyhC9T3Hm4i/Pcki1sMFzn9oqHPTA56gsX45+48sstycBezE8mJwl0r8/A==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a81:3985:0:b0:3ef:cbd2:224d with SMTP
 id g127-20020a813985000000b003efcbd2224dmr2465407ywa.459.1674260259812; Fri,
 20 Jan 2023 16:17:39 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:31 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-21-ackerleytng@google.com>
Subject: [RFC PATCH v3 20/31] KVM: selftests: TDX: Add TDX CPUID TDVMCALL test
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  4 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 26 +++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 94 +++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index f2a90ad8a55c6..e746372206a25 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -7,6 +7,7 @@
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
+#define TDG_VP_VMCALL_INSTRUCTION_CPUID 10
 #define TDG_VP_VMCALL_INSTRUCTION_HLT 12
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
@@ -26,5 +27,8 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 					uint64_t *data_out);
 uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
 					uint64_t data_in);
+uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
+					uint32_t *ret_eax, uint32_t *ret_ebx,
+					uint32_t *ret_ecx, uint32_t *ret_edx);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index 8b12ac7049572..d9d60dd58dfdd 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -136,3 +136,29 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
 
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
index dcc0940a74e92..b9d96b5f6521f 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -976,6 +976,99 @@ void verify_mmio_writes(void)
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
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	eax = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ebx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ecx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	edx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	/* Get KVM CPUIDs for reference */
+	cpuid_entry = kvm_get_supported_cpuid_entry(1);
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
@@ -997,6 +1090,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_hlt);
 	run_in_new_process(&verify_mmio_reads);
 	run_in_new_process(&verify_mmio_writes);
+	run_in_new_process(&verify_td_cpuid_tdcall);
 
 	return 0;
 }
-- 
2.39.0.246.g2a6d74b583-goog

