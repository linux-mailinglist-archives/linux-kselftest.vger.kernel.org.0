Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324E3643976
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 00:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiLEXYT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 18:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiLEXYM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 18:24:12 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A0D1F630
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 15:24:01 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i8-20020a170902c94800b0018712ccd6bbso14666759pla.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 15:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4cT5T4kx5vV5G9qvldZN1GECLXLHFCHNlOSZmIc8Z4k=;
        b=MSm36zjFu6mM+RphFRhsmlmaQyUoFJB0YM0+rChhr1tlfWke1UXduhSz6qDk1U/p2h
         FyJwkto/N/PE2o78KOHsNxYMcclIv/h0KhRdKbsL+XavASCjGVCsaUN5E2Rv/aKmtlil
         1NyfJffrd33nAYHPiyp6FZgRIIJSDDkCUQPM05Ul/yHFKW/+SqdKvC4ZzcZGapKJedBy
         CaV2moL13a7T6cP6mf42IEZ5+88ljwkdO5/aKk2D1uAw1AjCBYdUfBEl5WNRJvM8jhPT
         iiJ+9MGzjWp9fA9C5el/0GTTO/nk0bCWpXvo2F339y9Xj9YrqzA2Vwu88MHmmuZBCnWZ
         EVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cT5T4kx5vV5G9qvldZN1GECLXLHFCHNlOSZmIc8Z4k=;
        b=tOnccbx6cl/ecm5fTq7jzM+fPHHHC6jyU4FzyYvpimEew67FTlIQPDZf7wr/mc+Hjc
         dsp1lXAy63Qnu2VltKOnMeVFqjGvS1kauVsbdBnEgH7fJ00OZMDPMI0gQVEe4NRdG+Xk
         YTsoiXDNjPA5Fm528hG3Qkx10flz4HdhIn857tnyfYaPs3HqRkt46qPlJ4rgZYuyrHjA
         ZZoTHEz3RVqieN/a40CV66xCZgG+YpcF1U/p7HoF6IYcXR1hdCu9tsCBEzyq7EvCzwJN
         zBgMwHtWHJksyTDgoBs4JxS+edi5VNQTbW/VxUwIwzijpSqB4wiJ01j6qci/mlY9iU25
         bkhg==
X-Gm-Message-State: ANoB5pk1OuLuRQ33jJaMX5GmoYF0r9JUJPFoQhCGPVnuPD58u8qZMs8X
        O4sq6ZOZhfHmg2vJz4YoG7prEmRgka9GfOj2
X-Google-Smtp-Source: AA0mqf4UFnuvrvDn3jIhzMzVaZzt3ltuRFmfUtGo3Om7zoi8ApgY8/8IL5jZeTQdynJbAAGM5lt53AWd1Ct/beY/
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:903:330e:b0:189:57e4:c470 with SMTP
 id jk14-20020a170903330e00b0018957e4c470mr57735426plb.66.1670282640756; Mon,
 05 Dec 2022 15:24:00 -0800 (PST)
Date:   Mon,  5 Dec 2022 23:23:41 +0000
In-Reply-To: <20221205232341.4131240-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205232341.4131240-7-vannapurve@google.com>
Subject: [V2 PATCH 6/6] KVM: selftests: x86: Add selftest for private memory
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
 .../selftests/kvm/x86_64/private_mem_test.c   | 212 ++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 082855d94c72..19cdcde2ed08 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -34,6 +34,7 @@
 /x86_64/nested_exceptions_test
 /x86_64/nx_huge_pages_test
 /x86_64/platform_info_test
+/x86_64/private_mem_test
 /x86_64/pmu_event_filter_test
 /x86_64/set_boot_cpu_id
 /x86_64/set_sregs_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 97f7d52c553b..beb793dd3e1c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -99,6 +99,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/monitor_mwait_test
 TEST_GEN_PROGS_x86_64 += x86_64/nested_exceptions_test
 TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
 TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
+TEST_GEN_PROGS_x86_64 += x86_64/private_mem_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_test.c
new file mode 100644
index 000000000000..015ada2e3d54
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_test.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
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
+#define ASSERT_CONV_TEST_EXIT_IO(vcpu, stage) \
+	{ \
+		struct ucall uc; \
+		ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_IO); \
+		ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC); \
+		ASSERT_EQ(uc.args[1], stage); \
+	}
+
+#define ASSERT_GUEST_DONE(vcpu) \
+	{ \
+		struct ucall uc; \
+		ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_IO); \
+		ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE); \
+	}
+
+static void host_conv_test_fn(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	void *test_area_hva = addr_gpa2hva(vm, TEST_AREA_GPA);
+	void *guest_test_mem_hva = (test_area_hva + GUEST_TEST_MEM_OFFSET);
+
+	vcpu_run_and_handle_mapgpa(vm, vcpu);
+	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_STARTED);
+	populate_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4);
+	VM_STAGE_PROCESSED(GUEST_STARTED);
+
+	vcpu_run_and_handle_mapgpa(vm, vcpu);
+	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_PRIVATE_MEM_POPULATED);
+	TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
+			TEST_MEM_DATA_PATTERN4), "failed");
+	VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED);
+
+	vcpu_run_and_handle_mapgpa(vm, vcpu);
+	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_SHARED_MEM_POPULATED);
+	TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
+			TEST_MEM_DATA_PATTERN2), "failed");
+	populate_guest_test_mem(guest_test_mem_hva, TEST_MEM_DATA_PATTERN5);
+	VM_STAGE_PROCESSED(GUEST_SHARED_MEM_POPULATED);
+
+	vcpu_run_and_handle_mapgpa(vm, vcpu);
+	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_PRIVATE_MEM_POPULATED2);
+	TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
+			TEST_MEM_DATA_PATTERN5), "failed");
+	VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED2);
+
+	vcpu_run_and_handle_mapgpa(vm, vcpu);
+	ASSERT_GUEST_DONE(vcpu);
+}
+
+static void execute_vm_with_private_test_mem(
+			enum vm_mem_backing_src_type test_mem_src)
+{
+	struct kvm_vm *vm;
+	struct kvm_enable_cap cap;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_conv_test_fn);
+
+	vm_check_cap(vm, KVM_CAP_EXIT_HYPERCALL);
+	cap.cap = KVM_CAP_EXIT_HYPERCALL;
+	cap.flags = 0;
+	cap.args[0] = (1 << KVM_HC_MAP_GPA_RANGE);
+	vm_ioctl(vm, KVM_ENABLE_CAP, &cap);
+
+	vm_userspace_mem_region_add(vm, test_mem_src, TEST_AREA_GPA,
+		TEST_AREA_SLOT, TEST_AREA_SIZE / vm->page_size, KVM_MEM_PRIVATE);
+	vm_allocate_private_mem(vm, TEST_AREA_GPA, TEST_AREA_SIZE);
+
+	virt_map(vm, TEST_AREA_GPA, TEST_AREA_GPA, TEST_AREA_SIZE/vm->page_size);
+
+	host_conv_test_fn(vm, vcpu);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	execute_vm_with_private_test_mem(
+				VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD);
+
+	/* Needs 2MB Hugepages */
+	if (get_free_huge_2mb_pages() >= 1) {
+		printf("Running private mem test with 2M pages\n");
+		execute_vm_with_private_test_mem(
+				VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD);
+	} else
+		printf("Skipping private mem test with 2M pages\n");
+
+	return 0;
+}
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

