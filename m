Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A1762574
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGYWDV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGYWDA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408CF30C4
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b13cso5512457b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322528; x=1690927328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xhc4eOKi5wp2n2R0SFVFds9ep1FeOoOAgAXPOq++kg=;
        b=ac5P4dYrAOCuHR280ftIr+OhbOuN7M6/qOCna+H3VrY6YDyU3RfTCOP1lEPB8X71X/
         iNCo078JP4qqvUs2UdE7KaDYIeLSLKoq/d+qq1ZWjBGGaYpTMGOXAbZhff6MDkk2atNX
         B8VkccwihlwSu8p2mH7u1vzPmx2TpUfY8EHhn9FTCcbDUHHStzHDyXljuFKsqAcgOAFX
         O1a5twBPrMKaqS57qhZdp43+ncIJfLxR/P6EafUiyNz3puUrmAWrRBZGzFmp7qt+3ZUA
         4T1ylcH0jKz6ATDWA11whySnFbmUqZk4vYkfBmd+xgav1adN7rGlJuLG5L+tVKqzdkdd
         Cj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322528; x=1690927328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xhc4eOKi5wp2n2R0SFVFds9ep1FeOoOAgAXPOq++kg=;
        b=IIsfL5DJcxBOTsIsQzYRsvuiocKL5cpZfKXoYmkbXAGz8mgGkvOYUtOlazTHT4G43Y
         4CtwTW7lehzpMsXEM1LtlREqoa2f1v/2dxfgpaRqlsWEq45+p+6R8nhGraaBmqjB1NbP
         I4nBjHSJDrkW66tLiFax6i7dqrwWdEnIkLFSymOYICSiz/qNnTXVrJGGKYx95551TnEL
         VKqGEey76XXbS2UviPsE53JKlh13b9E6C2ck7gXZLRme90Z7Uno84mvfcPfacZAjJrIz
         mExg0TXLkildoVZCWwNP/YP8xqap8hjlXBPxRHNDUvu7Xvo72ykWsp218sxS0ga/3Snb
         16nQ==
X-Gm-Message-State: ABy/qLaBGszYYN1bHVaqMdriJcKc+HHYJi5cYiDTwGreJQmAa+CsxPTk
        HySStqX1Nk0ujCjHHU5j07UCgKW2RjL3GxS+5HNxgAqxgVQ/vgYj10aRGgtD+kwSzb8FWRETTYj
        EUMCbbjS+s29b1HVnDK3OSzLeLFnMaNGFQ/vEYYzKwzZSGoalRTFUbcjTBb0h/GSF3vCOQdg86T
        AZ
X-Google-Smtp-Source: APBJJlEYlG7qzc/hpBc7Pflw28PgfP/vuFvUMKwwL4ygbVoco2Ufx+JY8F9po7QifP+wcexxECYSu416UpWl
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a81:99d7:0:b0:576:e268:903d with SMTP id
 q206-20020a8199d7000000b00576e268903dmr7818ywg.2.1690322527809; Tue, 25 Jul
 2023 15:02:07 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:04 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-12-afranji@google.com>
Subject: [PATCH v4 11/28] KVM: selftests: TDX: Add basic TDX CPUID test
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Change-Id: I8d1760e39c3c14a69d69181232d523425211bcfb
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../kvm/include/x86_64/tdx/test_util.h        |   9 ++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  |  11 ++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 106 ++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index 95a5d5be7f0b..af0ddbfe8d71 100644
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
index 0419c3c54341..36d2647210da 100644
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
index cde4b171446f..d68ace3db097 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -2,6 +2,7 @@
 
 #include <signal.h>
 #include "kvm_util_base.h"
+#include "processor.h"
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
@@ -155,6 +156,110 @@ void verify_td_ioexit(void)
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
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ebx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	/* Wait for guest to report either ecx value or error */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ecx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	/* Wait for guest to complete execution */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	/* Verify the CPUID values we got from the guest. */
+	printf("\t ... Verifying CPUID values from guest\n");
+
+	/* Get KVM CPUIDs for reference */
+	cpuid_entry = get_cpuid_entry(kvm_get_supported_cpuid(), 1, 0);
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
@@ -167,6 +272,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_lifecycle);
 	run_in_new_process(&verify_report_fatal_error);
 	run_in_new_process(&verify_td_ioexit);
+	run_in_new_process(&verify_td_cpuid);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

