Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A96676219
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjAUASC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjAUARp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:17:45 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1349DCC5E7
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:21 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 74-20020a62184d000000b0058b9f769609so3097573pfy.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5oNII0+lLuKlf86/kD2DoUVJCXq3iLqKc12JrydmuE=;
        b=LAEhu7IkGXJf2FuHkgdLDDQdJw5VBwJJZc2AEokK24pr3alf+8FDMjZ2pinHR4ciHa
         +Oq98y722TU4COUPfEnyjM4uESO8QJBDHGnVB3w6Vsuux0DUHEz27ZW7Z3KKfc5LBvD8
         TGs5+WTQPbgaRa5Y3/V8V2K514JbDDUqjQ3m39BfWJbauqvu05Mz8MsoZFqLp80t/lzN
         p4XfjNXi14DaUj2JEj4WJHNZvW0x9dZZJWn3caDoDhkAbuVwAfoCkLVg3WZUCRoY9ahk
         AK1EDaJ3UMuYTScpM3TZgKN1hKf76Im39SagK1u0d1eq13O6iYyZj6fK+iIYcqPVDZg6
         FTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5oNII0+lLuKlf86/kD2DoUVJCXq3iLqKc12JrydmuE=;
        b=uZp0V0YD4gUYuiMb0ffEOYguthVidV/VKGQbWsoeRQJ9LVAESiZX1rJSutqLiE7Qxd
         ZVuUrS8ma0t2Em7PJpap0Zgmlxzjh2NxgfFA9qVJojDbHgjaz2JeZDvmE/IOLJvXNrTS
         rYsOjBqbhF+uw2oTPZDLTHG/OfY+Gv0tWdLGie64TMk7NzugrwdR68c/YtC7wAVOi4LQ
         Zbw89PlvkBK9M3mikclD+V6/PWiKft6f0ARN/ZKE1+1+ppNv1NjIqh6i2pt5+oMWjdXY
         /wE4QS8sDgOd7Uc/+NtQETrrbB/vVRlGfHlOfxiwU3WZn8ar3Vf3epHSaqb+cxSV8IgX
         QYQA==
X-Gm-Message-State: AFqh2kr4THHM4KfrlIztckBEPClLgqi5x2PdP8xdbm4sdqPIw7LtnY00
        H88pLUT4rWmEqPQvPqgmwewZwYJOxo+/5aVbN9M4EHGNtKNoU5Aw0pHqPHNecje1XaseoWueNSJ
        KKA1le0Kibq0smBrI8GNER/WpkBWsBw6HTLayW8/sWAYRs4iQb9zToGCvEK2h7dvfXga+1aitQz
        0rut3+1EHrGQI=
X-Google-Smtp-Source: AMrXdXuTfxIVAzTb1jlUYpnuT5J/zUqBDcX1N7GbIRzVdvA7coUgCHn/bU54/8cQLxM96lqf3TWWbP1uxHSoMjoYsA==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a62:ae10:0:b0:580:9b0b:4fde with SMTP
 id q16-20020a62ae10000000b005809b0b4fdemr1894341pff.49.1674260224601; Fri, 20
 Jan 2023 16:17:04 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:23 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-13-ackerleytng@google.com>
Subject: [RFC PATCH v3 12/31] KVM: selftests: TDX: Add basic TDX CPUID test
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test reads CPUID values from inside a TD VM and compare them
to expected values.

The test targets CPUID values which are virtualized as "As Configured",
"As Configured (if Native)", "Calculated", "Fixed" and "Native"
according to the TDX spec.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
Changes RFCv2 -> RFCv3
+ Manually inlined cpuid function in cpuid test. This highlights the
  purpose of this test - to test the result of the cpuid instruction.
+ Replace find_cpuid_entry with kvm_get_supported_cpuid_entry from
  tools/testing/selftests/kvm/lib/x86_64/processor.c
---
 .../kvm/include/x86_64/tdx/test_util.h        |   9 ++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  |  11 ++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 106 ++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index 95a5d5be7f0bf..af0ddbfe8d71b 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
@@ -9,6 +9,9 @@
 #define TDX_TEST_SUCCESS_PORT 0x30
 #define TDX_TEST_SUCCESS_SIZE 4

+#define TDX_TEST_REPORT_PORT 0x31
+#define TDX_TEST_REPORT_SIZE 4
+
 /**
  * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
  * called in the guest.
@@ -102,4 +105,10 @@ void tdx_test_fatal(uint64_t error_code);
  */
 void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);

+/**
+ * Report a 32 bit value from the guest to user space using TDG.VP.VMCALL
+ * <Instruction.IO> call. Data is reported on port TDX_TEST_REPORT_PORT.
+ */
+uint64_t tdx_test_report_to_user_space(uint32_t data);
+
 #endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
index 7f3cd8089cea3..55c5a1e634df7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
@@ -42,3 +42,14 @@ void tdx_test_fatal(uint64_t error_code)
 {
 	tdx_test_fatal_with_data(error_code, 0);
 }
+
+uint64_t tdx_test_report_to_user_space(uint32_t data)
+{
+	/* Upcast data to match tdg_vp_vmcall_instruction_io signature */
+	uint64_t data_64 = data;
+
+	return tdg_vp_vmcall_instruction_io(TDX_TEST_REPORT_PORT,
+					TDX_TEST_REPORT_SIZE,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&data_64);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 885c2b6bb1b96..b6072769967fa 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -2,6 +2,7 @@

 #include <signal.h>
 #include "kvm_util_base.h"
+#include "processor.h"
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
@@ -154,6 +155,110 @@ void verify_td_ioexit(void)
 	printf("\t ... PASSED\n");
 }

+/*
+ * Verifies CPUID functionality by reading CPUID values in guest. The guest
+ * will then send the values to userspace using an IO write to be checked
+ * against the expected values.
+ */
+void guest_code_cpuid(void)
+{
+	uint64_t err;
+	uint32_t ebx, ecx;
+
+	/* Read CPUID leaf 0x1 */
+	asm volatile (
+		"cpuid"
+		: "=b" (ebx), "=c" (ecx)
+		: "a" (0x1)
+		: "edx");
+
+	err = tdx_test_report_to_user_space(ebx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(ecx);
+	if (err)
+		tdx_test_fatal(err);
+
+	tdx_test_success();
+}
+
+void verify_td_cpuid(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint32_t ebx, ecx;
+	const struct kvm_cpuid_entry2 *cpuid_entry;
+	uint32_t guest_clflush_line_size;
+	uint32_t guest_max_addressable_ids, host_max_addressable_ids;
+	uint32_t guest_sse3_enabled;
+	uint32_t guest_fma_enabled;
+	uint32_t guest_initial_apic_id;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_cpuid);
+	td_finalize(vm);
+
+	printf("Verifying TD CPUID:\n");
+
+	/* Wait for guest to report ebx value */
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ebx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	/* Wait for guest to report either ecx value or error */
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ecx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	/* Wait for guest to complete execution */
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	/* Verify the CPUID values we got from the guest. */
+	printf("\t ... Verifying CPUID values from guest\n");
+
+	/* Get KVM CPUIDs for reference */
+	cpuid_entry = kvm_get_supported_cpuid_entry(1);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+
+	host_max_addressable_ids = (cpuid_entry->ebx >> 16) & 0xFF;
+
+	guest_sse3_enabled = ecx & 0x1;  // Native
+	guest_clflush_line_size = (ebx >> 8) & 0xFF;  // Fixed
+	guest_max_addressable_ids = (ebx >> 16) & 0xFF;  // As Configured
+	guest_fma_enabled = (ecx >> 12) & 0x1;  // As Configured (if Native)
+	guest_initial_apic_id = (ebx >> 24) & 0xFF;  // Calculated
+
+	ASSERT_EQ(guest_sse3_enabled, 1);
+	ASSERT_EQ(guest_clflush_line_size, 8);
+	ASSERT_EQ(guest_max_addressable_ids, host_max_addressable_ids);
+
+	/* TODO: This only tests the native value. To properly test
+	 * "As Configured (if Native)" we need to override this value
+	 * in the TD params
+	 */
+	ASSERT_EQ(guest_fma_enabled, 1);
+
+	/* TODO: guest_initial_apic_id is calculated based on the number of
+	 * VCPUs in the TD. From the spec: "Virtual CPU index, starting from 0
+	 * and allocated sequentially on each successful TDH.VP.INIT"
+	 * To test non-trivial values we either need a TD with multiple VCPUs
+	 * or to pick a different calculated value.
+	 */
+	ASSERT_EQ(guest_initial_apic_id, 0);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -166,6 +271,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_lifecycle);
 	run_in_new_process(&verify_report_fatal_error);
 	run_in_new_process(&verify_td_ioexit);
+	run_in_new_process(&verify_td_cpuid);

 	return 0;
 }
--
2.39.0.246.g2a6d74b583-goog
