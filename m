Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357B0676261
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAUA1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjAUA1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:27:50 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52493712
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:27:17 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id cg18-20020a056830631200b0068646c482f8so3109046otb.18
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk93+I6OSUVBwh4z5UqKhx2Qsqvlb7tzifbo6JQZrLA=;
        b=QSt/BGsIAVFgQS4TFoM+/Ns9P7myw95OR2fCkvn8AnXU5Qn4Ec/4VwQyL46QnjhOpx
         88xKxceOjjsJUusCS3YtMySzB+tHJO3V4nvhLzHoYYcYMGba+zt/ST72NKlaIuTPft17
         nho8JSX6MFo66QDC73OS16hJr7JbB9zkYHsu28VDDXJufKHFFU8DgHUWIB/vFjLD93sV
         xlDcmT9S1VTMxx9kXIGS6etIBjwfqRUz9f4kVnBpyrELjgcC9H5hsFiX/jAY/o6WEojr
         DjoIc2ny8sRKK56QsbR6DiN6oVOO7BJN5ZksftSU+pvwlQtqCT6Ggw7XbM+dUWiJdtcC
         DitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk93+I6OSUVBwh4z5UqKhx2Qsqvlb7tzifbo6JQZrLA=;
        b=eQNRtz9ibRgk1OvkPLQSk3J5sIjBwoHQRuqjCcanSQ5C9DcHNgFISJFF9t1Zhjeuen
         DejGoRfjwvEpXzdc7y7j8rDGV3lxc1FyXEYNExw+gGmifPDMudexc3z7j0FcTQEAGxIZ
         Uy3tvmdLG6tNzeD71GVDO0go0gHXr3P12oIt/yLFDIhYDnyPz9AhWL7oPatqcy/uBqmQ
         ekqPwOIEFkymC9Ib2mfc0PmEpJrBxuIreiEdAmWIWisOkQkbFgjgXKLMT5VajzRJQadV
         kHJ59Ld25yHFe57FzeepS3YhCMcQQ9tYktIh1EAAkemuclWjUI+ZB2qFU7b0Uzg7UA36
         X64A==
X-Gm-Message-State: AFqh2koh3nnLkAqTsoQVqKxQPrCpTHc75vqAK2R+VzccmIjIug//ssF6
        93MGcbQGgfdWEJM5TJHZwBl/87yVVmtHOyu34A41csdFj6ichWYU0gHQ2IXT3yFxhXtdAdvn1M3
        Jr8FGMPlTHWeFVrX6VdJBJRLHqI5Y8l4RlLPLv6CefzmKcONPZOO/Q/3XRGWtkLmLQzq+MeE8ZV
        EQoJzzy+FUf54=
X-Google-Smtp-Source: AMrXdXvbhFjIbngJm8ErEeG/qhphnIdjZioJjL96XNDZforpLrNZ6apT1jSjI/H9OjskWAY5+lRmFIaj8cab5havgw==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:11cd:b0:7d3:55e0:1cc6 with
 SMTP id n13-20020a05690211cd00b007d355e01cc6mr1843208ybu.435.1674260303753;
 Fri, 20 Jan 2023 16:18:23 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:41 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-31-ackerleytng@google.com>
Subject: [RFC PATCH v3 30/31] KVM: selftests: TDX: Add TDX UPM selftest
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

This tests the use of restricted memory with explicit MapGPA calls.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/tdx_upm_test.c       | 392 ++++++++++++++++++
 3 files changed, 394 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_upm_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index e1663b0f809b4..c1def2271f4cd 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -67,6 +67,7 @@
 /x86_64/triple_fault_event_test
 /x86_64/tdx_vm_tests
 /x86_64/tdx_shared_mem_test
+/x86_64/tdx_upm_test
 /access_tracking_perf_test
 /demand_paging_test
 /dirty_log_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 27e9148212fa5..2b1434368a0f2 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -153,6 +153,7 @@ TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 += system_counter_offset_test
 TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
 TEST_GEN_PROGS_x86_64 += x86_64/tdx_shared_mem_test
+TEST_GEN_PROGS_x86_64 += x86_64/tdx_upm_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
new file mode 100644
index 0000000000000..13914aebd7da7
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/kvm.h>
+#include <asm/vmx.h>
+#include <linux/kvm.h>
+#include <stdbool.h>
+#include <stdint.h>
+
+#include "kvm_util_base.h"
+#include "processor.h"
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
+#include "tdx/test_util.h"
+#include "test_util.h"
+
+/* TDX UPM test patterns */
+#define PATTERN_CONFIDENCE_CHECK (0x11)
+#define PATTERN_HOST_FOCUS (0x22)
+#define PATTERN_GUEST_GENERAL (0x33)
+#define PATTERN_GUEST_FOCUS (0x44)
+
+/*
+ * 0x80000000 is arbitrarily selected. The selected address need not be the same
+ * as TDX_UPM_TEST_AREA_GVA_PRIVATE, but it should not overlap with selftest
+ * code or boot page.
+ */
+#define TDX_UPM_TEST_AREA_GPA (0x80000000)
+/* Test area GPA is arbitrarily selected */
+#define TDX_UPM_TEST_AREA_GVA_PRIVATE (0x90000000)
+/* Select any bit that can be used as a flag */
+#define TDX_UPM_TEST_AREA_GVA_SHARED_BIT (32)
+/*
+ * TDX_UPM_TEST_AREA_GVA_SHARED is used to map the same GPA twice into the
+ * guest, once as shared and once as private
+ */
+#define TDX_UPM_TEST_AREA_GVA_SHARED				\
+	(TDX_UPM_TEST_AREA_GVA_PRIVATE |			\
+		BIT_ULL(TDX_UPM_TEST_AREA_GVA_SHARED_BIT))
+
+/* The test area is 2MB in size */
+#define TDX_UPM_TEST_AREA_SIZE (2 << 20)
+/* 0th general area is 1MB in size */
+#define TDX_UPM_GENERAL_AREA_0_SIZE (1 << 20)
+/* Focus area is 40KB in size */
+#define TDX_UPM_FOCUS_AREA_SIZE (40 << 10)
+/* 1st general area is the rest of the space in the test area */
+#define TDX_UPM_GENERAL_AREA_1_SIZE				\
+	(TDX_UPM_TEST_AREA_SIZE - TDX_UPM_GENERAL_AREA_0_SIZE -	\
+		TDX_UPM_FOCUS_AREA_SIZE)
+
+/*
+ * The test memory area is set up as two general areas, sandwiching a focus
+ * area.  The general areas act as control areas. After they are filled, they
+ * are not expected to change throughout the tests. The focus area is memory
+ * permissions change from private to shared and vice-versa.
+ *
+ * The focus area is intentionally small, and sandwiched to test that when the
+ * focus area's permissions change, the other areas' permissions are not
+ * affected.
+ */
+struct __packed tdx_upm_test_area {
+	uint8_t general_area_0[TDX_UPM_GENERAL_AREA_0_SIZE];
+	uint8_t focus_area[TDX_UPM_FOCUS_AREA_SIZE];
+	uint8_t general_area_1[TDX_UPM_GENERAL_AREA_1_SIZE];
+};
+
+static void fill_test_area(struct tdx_upm_test_area *test_area_base,
+			uint8_t pattern)
+{
+	memset(test_area_base, pattern, sizeof(*test_area_base));
+}
+
+static void fill_focus_area(struct tdx_upm_test_area *test_area_base,
+			    uint8_t pattern)
+{
+	memset(test_area_base->focus_area, pattern,
+	       sizeof(test_area_base->focus_area));
+}
+
+static bool check_area(uint8_t *base, uint64_t size, uint8_t expected_pattern)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++) {
+		if (base[i] != expected_pattern)
+			return false;
+	}
+
+	return true;
+}
+
+static bool check_general_areas(struct tdx_upm_test_area *test_area_base,
+				uint8_t expected_pattern)
+{
+	return (check_area(test_area_base->general_area_0,
+			   sizeof(test_area_base->general_area_0),
+			   expected_pattern) &&
+		check_area(test_area_base->general_area_1,
+			   sizeof(test_area_base->general_area_1),
+			   expected_pattern));
+}
+
+static bool check_focus_area(struct tdx_upm_test_area *test_area_base,
+			     uint8_t expected_pattern)
+{
+	return check_area(test_area_base->focus_area,
+			  sizeof(test_area_base->focus_area), expected_pattern);
+}
+
+static bool check_test_area(struct tdx_upm_test_area *test_area_base,
+			    uint8_t expected_pattern)
+{
+	return (check_general_areas(test_area_base, expected_pattern) &&
+		check_focus_area(test_area_base, expected_pattern));
+}
+
+static bool fill_and_check(struct tdx_upm_test_area *test_area_base, uint8_t pattern)
+{
+	fill_test_area(test_area_base, pattern);
+
+	return check_test_area(test_area_base, pattern);
+}
+
+#define TDX_UPM_TEST_ASSERT(x)				\
+	do {						\
+		if (!(x))				\
+			tdx_test_fatal(__LINE__);	\
+	} while (0)
+
+/*
+ * Shared variables between guest and host
+ */
+static struct tdx_upm_test_area *test_area_gpa_private;
+static struct tdx_upm_test_area *test_area_gpa_shared;
+
+/*
+ * Test stages for syncing with host
+ */
+enum {
+	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST = 1,
+	SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST,
+	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN,
+};
+
+#define TDX_UPM_TEST_ACCEPT_PRINT_PORT 0x87
+
+/**
+ * Does vcpu_run, and also manages memory conversions if requested by the TD.
+ */
+void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
+					    struct kvm_vcpu *vcpu)
+{
+	for (;;) {
+		vcpu_run(vcpu);
+		if (
+			vcpu->run->exit_reason == KVM_EXIT_IO &&
+			vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
+			uint64_t gpa = tdx_test_read_64bit(
+				vcpu, TDX_UPM_TEST_ACCEPT_PRINT_PORT);
+			printf("\t ... guest accepting 1 page at GPA: 0x%lx\n", gpa);
+			continue;
+		}
+
+		break;
+	}
+}
+
+static void guest_upm_explicit(void)
+{
+	uint64_t ret = 0;
+	uint64_t failed_gpa;
+
+	struct tdx_upm_test_area *test_area_gva_private =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_PRIVATE;
+	struct tdx_upm_test_area *test_area_gva_shared =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_SHARED;
+
+	/* Check: host reading private memory does not modify guest's view */
+	fill_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL);
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
+
+	TDX_UPM_TEST_ASSERT(
+		check_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/* Remap focus area as shared */
+	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_shared->focus_area,
+				    sizeof(test_area_gpa_shared->focus_area),
+				    &failed_gpa);
+	TDX_UPM_TEST_ASSERT(!ret);
+
+	/* General areas should be unaffected by remapping */
+	TDX_UPM_TEST_ASSERT(
+		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/*
+	 * Use memory contents to confirm that the memory allocated using mmap
+	 * is used as backing memory for shared memory - PATTERN_CONFIDENCE_CHECK
+	 * was written by the VMM at the beginning of this test.
+	 */
+	TDX_UPM_TEST_ASSERT(
+		check_focus_area(test_area_gva_shared, PATTERN_CONFIDENCE_CHECK));
+
+	/* Guest can use focus area after remapping as shared */
+	fill_focus_area(test_area_gva_shared, PATTERN_GUEST_FOCUS);
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
+
+	/* Check that guest has the same view of shared memory */
+	TDX_UPM_TEST_ASSERT(
+		check_focus_area(test_area_gva_shared, PATTERN_HOST_FOCUS));
+
+	/* Remap focus area back to private */
+	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_private->focus_area,
+				    sizeof(test_area_gpa_private->focus_area),
+				    &failed_gpa);
+	TDX_UPM_TEST_ASSERT(!ret);
+
+	/* General areas should be unaffected by remapping */
+	TDX_UPM_TEST_ASSERT(
+		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/* Focus area should be zeroed after remapping */
+	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_private, 0));
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
+
+	/* Check that guest can use private memory after focus area is remapped as private */
+	TDX_UPM_TEST_ASSERT(
+		fill_and_check(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_success();
+}
+
+static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+			 struct tdx_upm_test_area *test_area_base_hva)
+{
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
+		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		  SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
+
+	/*
+	 * Check that host should read PATTERN_CONFIDENCE_CHECK from guest's
+	 * private memory. This confirms that regular memory (userspace_addr in
+	 * struct kvm_userspace_memory_region) is used to back the host's view
+	 * of private memory, since PATTERN_CONFIDENCE_CHECK was written to that
+	 * memory before starting the guest.
+	 */
+	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		"Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");
+
+	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
+		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		  SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
+
+	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_GUEST_FOCUS),
+		"Host should have the same view of shared memory as guest.");
+	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		"Host's view of private memory should still be backed by regular memory.");
+
+	/* Check that host can use shared memory */
+	fill_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS);
+	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
+		    "Host should be able to use shared memory.");
+
+	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
+		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		  SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
+
+	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		"Host's view of private memory should be backed by regular memory.");
+	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
+		"Host's view of private memory should be backed by regular memory.");
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	printf("\t ... PASSED\n");
+}
+
+static bool address_between(uint64_t addr, void *lo, void *hi)
+{
+	return (uint64_t)lo <= addr && addr < (uint64_t)hi;
+}
+
+static void guest_ve_handler(struct ex_regs *regs)
+{
+	uint64_t ret;
+	struct ve_info ve;
+
+	ret = tdg_vp_veinfo_get(&ve);
+	TDX_UPM_TEST_ASSERT(!ret);
+
+	/* For this test, we will only handle EXIT_REASON_EPT_VIOLATION */
+	TDX_UPM_TEST_ASSERT(ve.exit_reason == EXIT_REASON_EPT_VIOLATION);
+
+	/* Validate GPA in fault */
+	TDX_UPM_TEST_ASSERT(
+		address_between(ve.gpa,
+				test_area_gpa_private->focus_area,
+				test_area_gpa_private->general_area_1));
+
+	tdx_test_send_64bit(TDX_UPM_TEST_ACCEPT_PRINT_PORT, ve.gpa);
+
+#define MEM_PAGE_ACCEPT_LEVEL_4K 0
+#define MEM_PAGE_ACCEPT_LEVEL_2M 1
+	ret = tdg_mem_page_accept(ve.gpa, MEM_PAGE_ACCEPT_LEVEL_4K);
+	TDX_UPM_TEST_ASSERT(!ret);
+}
+
+static void verify_upm_test(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm_vaddr_t test_area_gva_private;
+	struct tdx_upm_test_area *test_area_base_hva;
+	uint64_t test_area_npages;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_upm_explicit);
+
+	vm_install_exception_handler(vm, VE_VECTOR, guest_ve_handler);
+
+	/*
+	 * Set up shared memory page for testing by first allocating as private
+	 * and then mapping the same GPA again as shared. This way, the TD does
+	 * not have to remap its page tables at runtime.
+	 */
+	test_area_npages = TDX_UPM_TEST_AREA_SIZE / vm->page_size;
+	vm_userspace_mem_region_add(vm,
+				    VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD,
+				    TDX_UPM_TEST_AREA_GPA, 3, test_area_npages,
+				    0);
+
+	test_area_gva_private = _vm_vaddr_alloc(
+		vm, TDX_UPM_TEST_AREA_SIZE, TDX_UPM_TEST_AREA_GVA_PRIVATE,
+		TDX_UPM_TEST_AREA_GPA, 3, true);
+	ASSERT_EQ(test_area_gva_private, TDX_UPM_TEST_AREA_GVA_PRIVATE);
+
+	test_area_gpa_private = (struct tdx_upm_test_area *)
+		addr_gva2gpa(vm, test_area_gva_private);
+	virt_map_shared(vm, TDX_UPM_TEST_AREA_GVA_SHARED,
+			(uint64_t)test_area_gpa_private,
+			test_area_npages);
+	ASSERT_EQ(addr_gva2gpa(vm, TDX_UPM_TEST_AREA_GVA_SHARED),
+		  (vm_paddr_t)test_area_gpa_private);
+
+	test_area_base_hva = addr_gva2hva(vm, TDX_UPM_TEST_AREA_GVA_PRIVATE);
+
+	TEST_ASSERT(fill_and_check(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		"Failed to mark memory intended as backing memory for TD shared memory");
+
+	sync_global_to_guest(vm, test_area_gpa_private);
+	test_area_gpa_shared = (struct tdx_upm_test_area *)
+		((uint64_t)test_area_gpa_private | BIT_ULL(vm->pa_bits - 1));
+	sync_global_to_guest(vm, test_area_gpa_shared);
+
+	td_finalize(vm);
+
+	printf("Verifying UPM functionality: explicit MapGPA\n");
+
+	run_selftest(vm, vcpu, test_area_base_hva);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char **argv)
+{
+	/* Disable stdout buffering */
+	setbuf(stdout, NULL);
+
+	if (!is_tdx_enabled()) {
+		printf("TDX is not supported by the KVM\n"
+		       "Skipping the TDX tests.\n");
+		return 0;
+	}
+
+	run_in_new_process(&verify_upm_test);
+}
-- 
2.39.0.246.g2a6d74b583-goog

