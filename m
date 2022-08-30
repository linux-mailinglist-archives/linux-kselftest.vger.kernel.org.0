Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414225A710A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiH3WoP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiH3Wnp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:43:45 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DFE84ED7
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:34 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 125-20020a621483000000b0053814ac4b8bso3420903pfu.16
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=lqixpQXBBABWZQORlxTuydpIP0GZwF2DjDV0e6REe5k=;
        b=d4nHpC0Ur/2l1zx8uv7diUCkftpV5Vp6eS/8jS9BbOEp7ec/TJDCKBYUpr9NZxQl3z
         xQP9x3TvMEjbgUkDeXQ2VMC+VKfyIcvqmhZrak7Ty2iI0+aaf2A7iDFImRoKRV9WNH7s
         kN94+gLz32tYIMkjEtL3H034U2gDjvqDdApLgHXd+qeBwDGhmG7g6J/8Ov+xm4OnDBIg
         wzO6ZXO8E1BD5P+rcR22geRPjBZMVcEWeA4VOPWlfwCMM4uGbI6xHwX1/cPZ59vc0mWb
         8ApRoYpRd7FYjG0ufGmgGYXWH4h9c86bQCEinqquiZmYmu/WkIGKbO67kSaJOSBq4FI6
         XA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=lqixpQXBBABWZQORlxTuydpIP0GZwF2DjDV0e6REe5k=;
        b=BHwH4lNGRrJfgJoDB5wHXxwks4N4XlJ5EByZoOVRhd4cvWXG9AnvwpcBqteJLqjzee
         MAOU9E1meTsAsheg4SWZPIYw55zMFi36e0KYEJpVY6JgoodpLCRNuBzpWiqeqEg1p8v2
         os+NS5D44ED75RGVRa8lkAQFJGXCOnmiCYRr3rSzvUUCdF0RtIKnMEhYOp5h0PRmPV48
         kOO3vsHxOuHVm3DHqQUJjhdaX/WfrAltyD9zJOXU5PcRV9W3Uwgb7M0k3HKyOL8UuO2s
         xZlotB8zQTFEawklvpqqBc0DzFYxPlGDF4nxoPiQvYuSYILzV6HZ/NuGTzI1uaz7al2O
         QR2g==
X-Gm-Message-State: ACgBeo05pXdPxNiFM28BNwb1RaxBLI7Fg8Mhn+xT62B+DxQBA2sMWt0A
        eRlSOkc25yBxDOEOLgQvtH5aL5mtldjqYoOs
X-Google-Smtp-Source: AA6agR4ml/Ql2xekqUAm4T/hSZGEEww9e0VlFIKKFuer2hjk7TU2Wk7Uwk9mBoOlkkPKqFgQci6wOzxkIp6dKzBD
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:e515:b0:1fd:6e58:40 with SMTP
 id t21-20020a17090ae51500b001fd6e580040mr272209pjy.46.1661899413403; Tue, 30
 Aug 2022 15:43:33 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:42:58 +0000
In-Reply-To: <20220830224259.412342-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220830224259.412342-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830224259.412342-8-vannapurve@google.com>
Subject: [RFC V2 PATCH 7/8] selftests: kvm: Refactor testing logic for private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Move all of the logic to execute memory conversion tests into library to
allow sharing the logic between normal non-confidential VMs and SEV VMs.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../include/x86_64/private_mem_test_helper.h  |  13 +
 .../kvm/lib/x86_64/private_mem_test_helper.c  | 273 ++++++++++++++++++
 .../selftests/kvm/x86_64/private_mem_test.c   | 246 +---------------
 4 files changed, 289 insertions(+), 244 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c5fc8ea2c843..36874fedff4a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -52,6 +52,7 @@ LIBKVM_x86_64 += lib/x86_64/apic.c
 LIBKVM_x86_64 += lib/x86_64/handlers.S
 LIBKVM_x86_64 += lib/x86_64/perf_test_util.c
 LIBKVM_x86_64 += lib/x86_64/private_mem.c
+LIBKVM_x86_64 += lib/x86_64/private_mem_test_helper.c
 LIBKVM_x86_64 += lib/x86_64/processor.c
 LIBKVM_x86_64 += lib/x86_64/svm.c
 LIBKVM_x86_64 += lib/x86_64/ucall.c
diff --git a/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h b/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
new file mode 100644
index 000000000000..31bc559cd813
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+
+#ifndef SELFTEST_KVM_PRIVATE_MEM_TEST_HELPER_H
+#define SELFTEST_KVM_PRIVATE_MEM_TEST_HELPER_H
+
+void execute_memory_conversion_tests(void);
+
+void execute_sev_memory_conversion_tests(void);
+
+#endif  // SELFTEST_KVM_PRIVATE_MEM_TEST_HELPER_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c b/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c
new file mode 100644
index 000000000000..ce53bef7896e
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <private_mem.h>
+#include <private_mem_test_helper.h>
+#include <processor.h>
+#include <sev.h>
+
+#define VM_MEMSLOT0_PAGES	(512 * 10)
+
+#define TEST_AREA_SLOT		10
+#define TEST_AREA_GPA		0xC0000000
+#define TEST_AREA_SIZE		(2 * 1024 * 1024)
+#define GUEST_TEST_MEM_OFFSET	(1 * 1024 * 1024)
+#define GUEST_TEST_MEM_SIZE	(10 * 4096)
+
+#define VM_STAGE_PROCESSED(x)	pr_info("Processed stage %s\n", #x)
+
+#define TEST_MEM_DATA_PAT1	0x66
+#define TEST_MEM_DATA_PAT2	0x99
+#define TEST_MEM_DATA_PAT3	0x33
+#define TEST_MEM_DATA_PAT4	0xaa
+#define TEST_MEM_DATA_PAT5	0x12
+
+static bool verify_mem_contents(void *mem, uint32_t size, uint8_t pat)
+{
+	uint8_t *buf = (uint8_t *)mem;
+
+	for (uint32_t i = 0; i < size; i++) {
+		if (buf[i] != pat)
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Add custom implementation for memset to avoid using standard/builtin memset
+ * which may use features like SSE/GOT that don't work with guest vm execution
+ * within selftests.
+ */
+void *memset(void *mem, int byte, size_t size)
+{
+	uint8_t *buf = (uint8_t *)mem;
+
+	for (uint32_t i = 0; i < size; i++)
+		buf[i] = byte;
+
+	return buf;
+}
+
+static void populate_test_area(void *test_area_base, uint64_t pat)
+{
+	memset(test_area_base, pat, TEST_AREA_SIZE);
+}
+
+static void populate_guest_test_mem(void *guest_test_mem, uint64_t pat)
+{
+	memset(guest_test_mem, pat, GUEST_TEST_MEM_SIZE);
+}
+
+static bool verify_test_area(void *test_area_base, uint64_t area_pat,
+	uint64_t guest_pat)
+{
+	void *test_area1_base = test_area_base;
+	uint64_t test_area1_size = GUEST_TEST_MEM_OFFSET;
+	void *guest_test_mem = test_area_base + test_area1_size;
+	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
+	void *test_area2_base = guest_test_mem + guest_test_size;
+	uint64_t test_area2_size = (TEST_AREA_SIZE - (GUEST_TEST_MEM_OFFSET +
+			GUEST_TEST_MEM_SIZE));
+
+	return (verify_mem_contents(test_area1_base, test_area1_size, area_pat) &&
+		verify_mem_contents(guest_test_mem, guest_test_size, guest_pat) &&
+		verify_mem_contents(test_area2_base, test_area2_size, area_pat));
+}
+
+#define GUEST_STARTED			0
+#define GUEST_PRIVATE_MEM_POPULATED	1
+#define GUEST_SHARED_MEM_POPULATED	2
+#define GUEST_PRIVATE_MEM_POPULATED2	3
+#define GUEST_IMPLICIT_MEM_CONV1	4
+#define GUEST_IMPLICIT_MEM_CONV2	5
+
+/*
+ * Run memory conversion tests supporting two types of conversion:
+ * 1) Explicit: Execute KVM hypercall to map/unmap gpa range which will cause
+ *   userspace exit to back/unback private memory. Subsequent accesses by guest
+ *   to the gpa range will not cause exit to userspace.
+ * 2) Implicit: Execute KVM hypercall to update memory access to a gpa range as
+ *   private/shared without exiting to userspace. Subsequent accesses by guest
+ *   to the gpa range will result in KVM EPT/NPT faults and then exit to
+ *   userspace for each page.
+ *
+ * Test memory conversion scenarios with following steps:
+ * 1) Access private memory using private access and verify that memory contents
+ *   are not visible to userspace.
+ * 2) Convert memory to shared using explicit/implicit conversions and ensure
+ *   that userspace is able to access the shared regions.
+ * 3) Convert memory back to private using explicit/implicit conversions and
+ *   ensure that userspace is again not able to access converted private
+ *   regions.
+ */
+static void guest_conv_test_fn(bool test_explicit_conv)
+{
+	void *test_area_base = (void *)TEST_AREA_GPA;
+	void *guest_test_mem = (void *)(TEST_AREA_GPA + GUEST_TEST_MEM_OFFSET);
+	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
+
+	guest_map_ucall_page_shared();
+	GUEST_SYNC(GUEST_STARTED);
+
+	populate_test_area(test_area_base, TEST_MEM_DATA_PAT1);
+	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED);
+	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PAT1,
+		TEST_MEM_DATA_PAT1));
+
+	if (test_explicit_conv)
+		guest_update_mem_map(TO_SHARED, (uint64_t)guest_test_mem,
+			(uint64_t)guest_test_mem, guest_test_size);
+	else {
+		guest_update_mem_access(TO_SHARED, (uint64_t)guest_test_mem,
+			(uint64_t)guest_test_mem, guest_test_size);
+		GUEST_SYNC(GUEST_IMPLICIT_MEM_CONV1);
+	}
+
+	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PAT2);
+
+	GUEST_SYNC(GUEST_SHARED_MEM_POPULATED);
+	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PAT1,
+		TEST_MEM_DATA_PAT5));
+
+	if (test_explicit_conv)
+		guest_update_mem_map(TO_PRIVATE, (uint64_t)guest_test_mem,
+			(uint64_t)guest_test_mem, guest_test_size);
+	else {
+		guest_update_mem_access(TO_PRIVATE, (uint64_t)guest_test_mem,
+			(uint64_t)guest_test_mem, guest_test_size);
+		GUEST_SYNC(GUEST_IMPLICIT_MEM_CONV2);
+	}
+
+	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PAT3);
+	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED2);
+
+	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PAT1,
+		TEST_MEM_DATA_PAT3));
+	GUEST_DONE();
+}
+
+static void conv_test_ioexit_fn(struct kvm_vm *vm, uint32_t uc_arg1)
+{
+	void *test_area_hva = addr_gpa2hva(vm, TEST_AREA_GPA);
+	void *guest_test_mem_hva = (test_area_hva + GUEST_TEST_MEM_OFFSET);
+	uint64_t guest_mem_gpa = (TEST_AREA_GPA + GUEST_TEST_MEM_OFFSET);
+	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
+
+	switch (uc_arg1) {
+	case GUEST_STARTED:
+		populate_test_area(test_area_hva, TEST_MEM_DATA_PAT4);
+		VM_STAGE_PROCESSED(GUEST_STARTED);
+		break;
+	case GUEST_PRIVATE_MEM_POPULATED:
+		TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PAT4,
+				TEST_MEM_DATA_PAT4), "failed");
+		VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED);
+		break;
+	case GUEST_SHARED_MEM_POPULATED:
+		TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PAT4,
+				TEST_MEM_DATA_PAT2), "failed");
+		populate_guest_test_mem(guest_test_mem_hva, TEST_MEM_DATA_PAT5);
+		VM_STAGE_PROCESSED(GUEST_SHARED_MEM_POPULATED);
+		break;
+	case GUEST_PRIVATE_MEM_POPULATED2:
+		TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PAT4,
+				TEST_MEM_DATA_PAT5), "failed");
+		VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED2);
+		break;
+	case GUEST_IMPLICIT_MEM_CONV1:
+		/*
+		 * For first implicit conversion, memory is already private so
+		 * mark it private again just to zap the pte entries for the gpa
+		 * range, so that subsequent accesses from the guest will
+		 * generate ept/npt fault and memory conversion path will be
+		 * exercised by KVM.
+		 */
+		vm_update_private_mem(vm, guest_mem_gpa, guest_test_size,
+				ALLOCATE_MEM);
+		VM_STAGE_PROCESSED(GUEST_IMPLICIT_MEM_CONV1);
+		break;
+	case GUEST_IMPLICIT_MEM_CONV2:
+		/*
+		 * For second implicit conversion, memory is already shared so
+		 * mark it shared again just to zap the pte entries for the gpa
+		 * range, so that subsequent accesses from the guest will
+		 * generate ept/npt fault and memory conversion path will be
+		 * exercised by KVM.
+		 */
+		vm_update_private_mem(vm, guest_mem_gpa, guest_test_size,
+				UNBACK_MEM);
+		VM_STAGE_PROCESSED(GUEST_IMPLICIT_MEM_CONV2);
+		break;
+	default:
+		TEST_FAIL("Unknown stage %d\n", uc_arg1);
+		break;
+	}
+}
+
+static void guest_explicit_conv_test_fn(void)
+{
+	guest_conv_test_fn(true);
+}
+
+static void guest_implicit_conv_test_fn(void)
+{
+	guest_conv_test_fn(false);
+}
+
+/*
+ * Execute implicit and explicit memory conversion tests with non-confidential
+ * VMs using memslots with private memory.
+ */
+void execute_memory_conversion_tests(void)
+{
+	struct vm_setup_info info;
+	struct test_setup_info *test_info = &info.test_info;
+
+	info.vm_mem_src = VM_MEM_SRC_ANONYMOUS;
+	info.memslot0_pages = VM_MEMSLOT0_PAGES;
+	test_info->test_area_gpa = TEST_AREA_GPA;
+	test_info->test_area_size = TEST_AREA_SIZE;
+	test_info->test_area_slot = TEST_AREA_SLOT;
+	test_info->test_area_mem_src = VM_MEM_SRC_ANONYMOUS;
+	info.ioexit_cb = conv_test_ioexit_fn;
+
+	info.guest_fn = guest_explicit_conv_test_fn;
+	execute_vm_with_private_mem(&info);
+
+	info.guest_fn = guest_implicit_conv_test_fn;
+	execute_vm_with_private_mem(&info);
+}
+
+/*
+ * Execute implicit and explicit memory conversion tests with SEV VMs using
+ * memslots with private memory.
+ */
+void execute_sev_memory_conversion_tests(void)
+{
+	struct vm_setup_info info;
+	struct test_setup_info *test_info = &info.test_info;
+
+	info.vm_mem_src = VM_MEM_SRC_ANONYMOUS;
+	info.memslot0_pages = VM_MEMSLOT0_PAGES;
+	test_info->test_area_gpa = TEST_AREA_GPA;
+	test_info->test_area_size = TEST_AREA_SIZE;
+	test_info->test_area_slot = TEST_AREA_SLOT;
+	test_info->test_area_mem_src = VM_MEM_SRC_ANONYMOUS;
+	info.ioexit_cb = conv_test_ioexit_fn;
+
+	info.policy = SEV_POLICY_NO_DBG;
+	info.guest_fn = guest_explicit_conv_test_fn;
+	execute_sev_vm_with_private_mem(&info);
+
+	info.guest_fn = guest_implicit_conv_test_fn;
+	execute_sev_vm_with_private_mem(&info);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_test.c
index 52430b97bd0b..49da626e5807 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_test.c
@@ -1,263 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * tools/testing/selftests/kvm/lib/kvm_util.c
- *
  * Copyright (C) 2022, Google LLC.
  */
 #define _GNU_SOURCE /* for program_invocation_short_name */
-#include <fcntl.h>
-#include <limits.h>
-#include <sched.h>
-#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/ioctl.h>
-
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/kvm_para.h>
-#include <linux/memfd.h>
 
 #include <test_util.h>
 #include <kvm_util.h>
-#include <private_mem.h>
-#include <processor.h>
-
-#define VM_MEMSLOT0_PAGES	(512 * 10)
-
-#define TEST_AREA_SLOT		10
-#define TEST_AREA_GPA		0xC0000000
-#define TEST_AREA_SIZE		(2 * 1024 * 1024)
-#define GUEST_TEST_MEM_OFFSET	(1 * 1024 * 1024)
-#define GUEST_TEST_MEM_SIZE	(10 * 4096)
-
-#define VM_STAGE_PROCESSED(x)	pr_info("Processed stage %s\n", #x)
-
-#define TEST_MEM_DATA_PAT1	0x66
-#define TEST_MEM_DATA_PAT2	0x99
-#define TEST_MEM_DATA_PAT3	0x33
-#define TEST_MEM_DATA_PAT4	0xaa
-#define TEST_MEM_DATA_PAT5	0x12
-
-static bool verify_mem_contents(void *mem, uint32_t size, uint8_t pat)
-{
-	uint8_t *buf = (uint8_t *)mem;
-
-	for (uint32_t i = 0; i < size; i++) {
-		if (buf[i] != pat)
-			return false;
-	}
-
-	return true;
-}
-
-/*
- * Add custom implementation for memset to avoid using standard/builtin memset
- * which may use features like SSE/GOT that don't work with guest vm execution
- * within selftests.
- */
-void *memset(void *mem, int byte, size_t size)
-{
-	uint8_t *buf = (uint8_t *)mem;
-
-	for (uint32_t i = 0; i < size; i++)
-		buf[i] = byte;
-
-	return buf;
-}
-
-static void populate_test_area(void *test_area_base, uint64_t pat)
-{
-	memset(test_area_base, pat, TEST_AREA_SIZE);
-}
-
-static void populate_guest_test_mem(void *guest_test_mem, uint64_t pat)
-{
-	memset(guest_test_mem, pat, GUEST_TEST_MEM_SIZE);
-}
-
-static bool verify_test_area(void *test_area_base, uint64_t area_pat,
-	uint64_t guest_pat)
-{
-	void *test_area1_base = test_area_base;
-	uint64_t test_area1_size = GUEST_TEST_MEM_OFFSET;
-	void *guest_test_mem = test_area_base + test_area1_size;
-	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
-	void *test_area2_base = guest_test_mem + guest_test_size;
-	uint64_t test_area2_size = (TEST_AREA_SIZE - (GUEST_TEST_MEM_OFFSET +
-			GUEST_TEST_MEM_SIZE));
-
-	return (verify_mem_contents(test_area1_base, test_area1_size, area_pat) &&
-		verify_mem_contents(guest_test_mem, guest_test_size, guest_pat) &&
-		verify_mem_contents(test_area2_base, test_area2_size, area_pat));
-}
-
-#define GUEST_STARTED			0
-#define GUEST_PRIVATE_MEM_POPULATED	1
-#define GUEST_SHARED_MEM_POPULATED	2
-#define GUEST_PRIVATE_MEM_POPULATED2	3
-#define GUEST_IMPLICIT_MEM_CONV1	4
-#define GUEST_IMPLICIT_MEM_CONV2	5
-
-/*
- * Run memory conversion tests supporting two types of conversion:
- * 1) Explicit: Execute KVM hypercall to map/unmap gpa range which will cause
- *   userspace exit to back/unback private memory. Subsequent accesses by guest
- *   to the gpa range will not cause exit to userspace.
- * 2) Implicit: Execute KVM hypercall to update memory access to a gpa range as
- *   private/shared without exiting to userspace. Subsequent accesses by guest
- *   to the gpa range will result in KVM EPT/NPT faults and then exit to
- *   userspace for each page.
- *
- * Test memory conversion scenarios with following steps:
- * 1) Access private memory using private access and verify that memory contents
- *   are not visible to userspace.
- * 2) Convert memory to shared using explicit/implicit conversions and ensure
- *   that userspace is able to access the shared regions.
- * 3) Convert memory back to private using explicit/implicit conversions and
- *   ensure that userspace is again not able to access converted private
- *   regions.
- */
-static void guest_conv_test_fn(bool test_explicit_conv)
-{
-	void *test_area_base = (void *)TEST_AREA_GPA;
-	void *guest_test_mem = (void *)(TEST_AREA_GPA + GUEST_TEST_MEM_OFFSET);
-	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
-
-	guest_map_ucall_page_shared();
-	GUEST_SYNC(GUEST_STARTED);
-
-	populate_test_area(test_area_base, TEST_MEM_DATA_PAT1);
-	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED);
-	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PAT1,
-		TEST_MEM_DATA_PAT1));
-
-	if (test_explicit_conv)
-		guest_update_mem_map(TO_SHARED, (uint64_t)guest_test_mem,
-			guest_test_size);
-	else {
-		guest_update_mem_access(TO_SHARED, (uint64_t)guest_test_mem,
-			guest_test_size);
-		GUEST_SYNC(GUEST_IMPLICIT_MEM_CONV1);
-	}
-
-	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PAT2);
-
-	GUEST_SYNC(GUEST_SHARED_MEM_POPULATED);
-	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PAT1,
-		TEST_MEM_DATA_PAT5));
-
-	if (test_explicit_conv)
-		guest_update_mem_map(TO_PRIVATE, (uint64_t)guest_test_mem,
-			guest_test_size);
-	else {
-		guest_update_mem_access(TO_PRIVATE, (uint64_t)guest_test_mem,
-			guest_test_size);
-		GUEST_SYNC(GUEST_IMPLICIT_MEM_CONV2);
-	}
-
-	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PAT3);
-	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED2);
-
-	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PAT1,
-		TEST_MEM_DATA_PAT3));
-	GUEST_DONE();
-}
-
-static void conv_test_ioexit_fn(struct kvm_vm *vm, uint32_t uc_arg1)
-{
-	void *test_area_hva = addr_gpa2hva(vm, TEST_AREA_GPA);
-	void *guest_test_mem_hva = (test_area_hva + GUEST_TEST_MEM_OFFSET);
-	uint64_t guest_mem_gpa = (TEST_AREA_GPA + GUEST_TEST_MEM_OFFSET);
-	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
-
-	switch (uc_arg1) {
-	case GUEST_STARTED:
-		populate_test_area(test_area_hva, TEST_MEM_DATA_PAT4);
-		VM_STAGE_PROCESSED(GUEST_STARTED);
-		break;
-	case GUEST_PRIVATE_MEM_POPULATED:
-		TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PAT4,
-				TEST_MEM_DATA_PAT4), "failed");
-		VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED);
-		break;
-	case GUEST_SHARED_MEM_POPULATED:
-		TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PAT4,
-				TEST_MEM_DATA_PAT2), "failed");
-		populate_guest_test_mem(guest_test_mem_hva, TEST_MEM_DATA_PAT5);
-		VM_STAGE_PROCESSED(GUEST_SHARED_MEM_POPULATED);
-		break;
-	case GUEST_PRIVATE_MEM_POPULATED2:
-		TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PAT4,
-				TEST_MEM_DATA_PAT5), "failed");
-		VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED2);
-		break;
-	case GUEST_IMPLICIT_MEM_CONV1:
-		/*
-		 * For first implicit conversion, memory is already private so
-		 * mark it private again just to zap the pte entries for the gpa
-		 * range, so that subsequent accesses from the guest will
-		 * generate ept/npt fault and memory conversion path will be
-		 * exercised by KVM.
-		 */
-		vm_update_private_mem(vm, guest_mem_gpa, guest_test_size,
-				ALLOCATE_MEM);
-		VM_STAGE_PROCESSED(GUEST_IMPLICIT_MEM_CONV1);
-		break;
-	case GUEST_IMPLICIT_MEM_CONV2:
-		/*
-		 * For second implicit conversion, memory is already shared so
-		 * mark it shared again just to zap the pte entries for the gpa
-		 * range, so that subsequent accesses from the guest will
-		 * generate ept/npt fault and memory conversion path will be
-		 * exercised by KVM.
-		 */
-		vm_update_private_mem(vm, guest_mem_gpa, guest_test_size,
-				UNBACK_MEM);
-		VM_STAGE_PROCESSED(GUEST_IMPLICIT_MEM_CONV2);
-		break;
-	default:
-		TEST_FAIL("Unknown stage %d\n", uc_arg1);
-		break;
-	}
-}
-
-static void guest_explicit_conv_test_fn(void)
-{
-	guest_conv_test_fn(true);
-}
-
-static void guest_implicit_conv_test_fn(void)
-{
-	guest_conv_test_fn(false);
-}
-
-static void execute_memory_conversion_test(void)
-{
-	struct vm_setup_info info;
-	struct test_setup_info *test_info = &info.test_info;
-
-	info.vm_mem_src = VM_MEM_SRC_ANONYMOUS;
-	info.memslot0_pages = VM_MEMSLOT0_PAGES;
-	test_info->test_area_gpa = TEST_AREA_GPA;
-	test_info->test_area_size = TEST_AREA_SIZE;
-	test_info->test_area_slot = TEST_AREA_SLOT;
-	test_info->test_area_mem_src = VM_MEM_SRC_ANONYMOUS;
-	info.ioexit_cb = conv_test_ioexit_fn;
-
-	info.guest_fn = guest_explicit_conv_test_fn;
-	execute_vm_with_private_mem(&info);
-
-	info.guest_fn = guest_implicit_conv_test_fn;
-	execute_vm_with_private_mem(&info);
-}
+#include <private_mem_test_helper.h>
 
 int main(int argc, char *argv[])
 {
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
 
-	execute_memory_conversion_test();
+	execute_memory_conversion_tests();
 	return 0;
 }
-- 
2.37.2.672.g94769d06f0-goog

