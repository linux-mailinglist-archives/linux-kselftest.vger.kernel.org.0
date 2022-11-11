Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CB3624FD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 02:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiKKBng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 20:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiKKBnQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 20:43:16 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415BE63CE7
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:43:07 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t3-20020a170902e84300b00186ab03043dso2536263plg.20
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAyxrjZo7wxtbSAtJZX76etKRvZFI4xaABx+3pMzmko=;
        b=HzwPwq0RaYeCkTAuhbLY9FC/DYMH8LaEFxFxgOQvHZro6fbJXVCVRdaM0ZBVGw6N/g
         6RV6qbIBXfwDTDXjCVCa9pB/ddCf9csy4T3HP5hTk+7VVwdIpT75nAds9KXl4i88uzvh
         lMMvXGPmisM+sBbDqpJTGxjEnC4Up9K+6cHS9m1ti2kpFcNn6WFgVFnJ3lTcT6x2oYhL
         BWJ/O+3tV/l6QlAxBwIPHxo+IipoDMSzParq6Yn44SPRPb3OKVyw8tRx72itd/nDl1BX
         0HbUlsiXx4vaYx5ZfkIGRNCT2aPKMJvhUosOhS4li4I5ghJnj3l7yeb0EJj/azoBztvO
         GOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAyxrjZo7wxtbSAtJZX76etKRvZFI4xaABx+3pMzmko=;
        b=aTbkEQLoXE+n290KGDPnGbV3I9MdcEKPwd6kUYxEelnW4qSpPnPlERO1Rlv3Tz/MvY
         fSjV7Rgw3/EOFhqlTxApJjxb6oQc06dJ1df7L3CALWE53KwnwMhQWzQ0y5V0R1Ve4DSr
         tOyH84spWN62aZkALCR0Y2uzG/EJIhu0p06F/9zXKTiO2PNWPGWPQauERGi9EaZ7/VZU
         lxpXLwGYe64FYBhIJ1lF2B8UhQ0mzGs0OAAkH/XEHHmkUP2/EwNklX6vkuFn6t5p4JLe
         3dajNrzmTiEuS4BK6VOX4/Esw/wp+TWjwxFELBzlThHEsRYya5q4+dCi0qNaaiMkCpaq
         PWxw==
X-Gm-Message-State: ANoB5pmwvduUNy0cXfvh3aYJdeOl8udLxPtp7YP8bQPz2EdlHhxYcubP
        5hkNPp+IZ6bWKgkdamC6PSGu82mqWaiqOPjY
X-Google-Smtp-Source: AA0mqf6osqkg3PpxS+IbDqDaviT8e6/GDUt/kYfG2x4N729wFb68+5ZUV6p3FEDqUoVZEJvmt2d4w3KSoMuMQAQu
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:e82:b0:20a:fee1:8f69 with SMTP
 id fv2-20020a17090b0e8200b0020afee18f69mr13908pjb.0.1668130986468; Thu, 10
 Nov 2022 17:43:06 -0800 (PST)
Date:   Fri, 11 Nov 2022 01:42:44 +0000
In-Reply-To: <20221111014244.1714148-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221111014244.1714148-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111014244.1714148-7-vannapurve@google.com>
Subject: [V1 PATCH 6/6] KVM: selftests: x86: Add selftest for private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Add a selftest to exercise implicit/explicit conversion functionality
within KVM and verify:
1) Shared memory is visible to host userspace after conversion
2) Private memory is not visible to host userspace before/after conversion
3) Host userspace and guest can communicate over shared memory

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/private_mem_test.c   | 190 ++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 2f0d705db9db..77b79b740424 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -32,6 +32,7 @@
 /x86_64/nested_exceptions_test
 /x86_64/nx_huge_pages_test
 /x86_64/platform_info_test
+/x86_64/private_mem_test
 /x86_64/pmu_event_filter_test
 /x86_64/set_boot_cpu_id
 /x86_64/set_sregs_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 57385ad58527..d1fa27a58f8f 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -95,6 +95,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/monitor_mwait_test
 TEST_GEN_PROGS_x86_64 += x86_64/nested_exceptions_test
 TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
 TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
+TEST_GEN_PROGS_x86_64 += x86_64/private_mem_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_test.c
new file mode 100644
index 000000000000..a93f9e5d15a8
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_test.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tools/testing/selftests/kvm/lib/kvm_util.c
+ *
+ * Copyright (C) 2022, Google LLC.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/kvm_para.h>
+#include <linux/memfd.h>
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <private_mem.h>
+#include <processor.h>
+
+#define TEST_AREA_SLOT		10
+#define TEST_AREA_GPA		0xC0000000
+#define TEST_AREA_SIZE		(2 * 1024 * 1024)
+#define GUEST_TEST_MEM_OFFSET	(1 * 1024 * 1024)
+#define GUEST_TEST_MEM_SIZE	(10 * 4096)
+
+#define VM_STAGE_PROCESSED(x)	pr_info("Processed stage %s\n", #x)
+
+#define TEST_MEM_DATA_PATTERN1	0x66
+#define TEST_MEM_DATA_PATTERN2	0x99
+#define TEST_MEM_DATA_PATTERN3	0x33
+#define TEST_MEM_DATA_PATTERN4	0xaa
+#define TEST_MEM_DATA_PATTERN5	0x12
+
+static bool verify_mem_contents(void *mem, uint32_t size, uint8_t pattern)
+{
+	uint8_t *buf = (uint8_t *)mem;
+
+	for (uint32_t i = 0; i < size; i++) {
+		if (buf[i] != pattern)
+			return false;
+	}
+
+	return true;
+}
+
+static void populate_test_area(void *test_area_base, uint64_t pattern)
+{
+	memset(test_area_base, pattern, TEST_AREA_SIZE);
+}
+
+static void populate_guest_test_mem(void *guest_test_mem, uint64_t pattern)
+{
+	memset(guest_test_mem, pattern, GUEST_TEST_MEM_SIZE);
+}
+
+static bool verify_test_area(void *test_area_base, uint64_t area_pattern,
+	uint64_t guest_pattern)
+{
+	void *guest_test_mem = test_area_base + GUEST_TEST_MEM_OFFSET;
+	void *test_area2_base = guest_test_mem + GUEST_TEST_MEM_SIZE;
+	uint64_t test_area2_size = (TEST_AREA_SIZE - (GUEST_TEST_MEM_OFFSET +
+			GUEST_TEST_MEM_SIZE));
+
+	return (verify_mem_contents(test_area_base, GUEST_TEST_MEM_OFFSET, area_pattern) &&
+		verify_mem_contents(guest_test_mem, GUEST_TEST_MEM_SIZE, guest_pattern) &&
+		verify_mem_contents(test_area2_base, test_area2_size, area_pattern));
+}
+
+#define GUEST_STARTED			0
+#define GUEST_PRIVATE_MEM_POPULATED	1
+#define GUEST_SHARED_MEM_POPULATED	2
+#define GUEST_PRIVATE_MEM_POPULATED2	3
+
+/*
+ * Run memory conversion tests with explicit conversion:
+ * Execute KVM hypercall to map/unmap gpa range which will cause userspace exit
+ * to back/unback private memory. Subsequent accesses by guest to the gpa range
+ * will not cause exit to userspace.
+ *
+ * Test memory conversion scenarios with following steps:
+ * 1) Access private memory using private access and verify that memory contents
+ *   are not visible to userspace.
+ * 2) Convert memory to shared using explicit conversions and ensure that
+ *   userspace is able to access the shared regions.
+ * 3) Convert memory back to private using explicit conversions and ensure that
+ *   userspace is again not able to access converted private regions.
+ */
+static void guest_conv_test_fn(void)
+{
+	void *test_area_base = (void *)TEST_AREA_GPA;
+	void *guest_test_mem = (void *)(TEST_AREA_GPA + GUEST_TEST_MEM_OFFSET);
+	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
+
+	GUEST_SYNC(GUEST_STARTED);
+
+	populate_test_area(test_area_base, TEST_MEM_DATA_PATTERN1);
+	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED);
+	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
+		TEST_MEM_DATA_PATTERN1));
+
+	kvm_hypercall_map_shared((uint64_t)guest_test_mem, guest_test_size);
+
+	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PATTERN2);
+
+	GUEST_SYNC(GUEST_SHARED_MEM_POPULATED);
+	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
+		TEST_MEM_DATA_PATTERN5));
+
+	kvm_hypercall_map_private((uint64_t)guest_test_mem, guest_test_size);
+
+	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PATTERN3);
+	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED2);
+
+	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
+		TEST_MEM_DATA_PATTERN3));
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
+		populate_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4);
+		VM_STAGE_PROCESSED(GUEST_STARTED);
+		break;
+	case GUEST_PRIVATE_MEM_POPULATED:
+		TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
+				TEST_MEM_DATA_PATTERN4), "failed");
+		VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED);
+		break;
+	case GUEST_SHARED_MEM_POPULATED:
+		TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
+				TEST_MEM_DATA_PATTERN2), "failed");
+		populate_guest_test_mem(guest_test_mem_hva, TEST_MEM_DATA_PATTERN5);
+		VM_STAGE_PROCESSED(GUEST_SHARED_MEM_POPULATED);
+		break;
+	case GUEST_PRIVATE_MEM_POPULATED2:
+		TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
+				TEST_MEM_DATA_PATTERN5), "failed");
+		VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED2);
+		break;
+	default:
+		TEST_FAIL("Unknown stage %d\n", uc_arg1);
+		break;
+	}
+}
+
+static void execute_memory_conversion_test(enum vm_mem_backing_src_type test_mem_src)
+{
+	struct vm_setup_info info;
+	struct test_setup_info *test_info = &info.test_info;
+
+	info.test_mem_src = test_mem_src;
+	test_info->test_area_gpa = TEST_AREA_GPA;
+	test_info->test_area_size = TEST_AREA_SIZE;
+	test_info->test_area_slot = TEST_AREA_SLOT;
+	info.ioexit_cb = conv_test_ioexit_fn;
+
+	info.guest_fn = guest_conv_test_fn;
+	execute_vm_with_private_test_mem(&info);
+}
+
+int main(int argc, char *argv[])
+{
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	execute_memory_conversion_test(VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD);
+
+	/* Needs 2MB Hugepages */
+	if (get_free_huge_2mb_pages() >= 1) {
+		printf("Running private mem test with 2M pages\n");
+		execute_memory_conversion_test(VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD);
+	} else
+		printf("Skipping private mem test with 2M pages\n");
+
+	return 0;
+}
-- 
2.38.1.431.g37b22c650d-goog

