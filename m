Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF956549AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 01:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiLWAOp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 19:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiLWAOT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 19:14:19 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6327B35
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:10 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m13-20020a170902f64d00b001899a70c8f1so2330128plg.14
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfG5JzhSPPBTmyeZqygfonNF3+eUcGyRu0K6yDYOFAo=;
        b=SM4+xKni226DpVhRn0NlBoUPPfriOG1H2UYRt16IbgCmpCE7yuX0JtitW2/sUsc3MJ
         /v0ne16UCwUCdgWvGj3qRXuEcilujaVVDmjG3codhksg+Oy4OleFYozdtiXrqznBYA3P
         Guyy3es8av6ciLytcA8Tw7UEANDlWCUDN2U5Z4tgNipzL8frjSSB2XHLi2AlmtTQ4pWh
         txpTtgar9LDSfDplgpjUttEesi1dSv79Tt1fSryGRU2Efr++lIuHRoSUICFmzFxLAyXA
         c2MtMSQv6A4vOxw7ZN0ob0IHH45SveGoCbCa6afIwm0yl3EUWRl8pT2+5Di12B5qQ94t
         oQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfG5JzhSPPBTmyeZqygfonNF3+eUcGyRu0K6yDYOFAo=;
        b=3+aTLX2gV1O4iDx10Mziu6IX5AfpJsO3SRqNUpU1i4ILXYXFbrH5c2U1oMRmLEqqqd
         bHC8RjZPgPTsI13dbPeGSz1pm7wAwp/zjy2a/tA+zgTYOUVuUddozI5272tFeyyiQkd3
         OYVKnFL0F3wsIFVrcWKzN1pLOJVgnG3Yi/3c81xhRd0C3Uzkco0Cp1aHzn7OPZwrwFps
         ZdsMmPKB8m3CInCSzBm6pbihH+2UZkR1+gCdcjktoHQwVZunBAPDp8jaDEyZcPo15uq7
         QkFafcRpehlO8Esgw53CDhOIANV1IhW1GK+/jWHwxOQ2LfbxsrlIv2wS80NZuKm9yzKq
         kBWA==
X-Gm-Message-State: AFqh2kpTjoHmBPcyS6GHAl0nJD+6MwIXz3O1UtKbkrZsupJ3FoUQVpOz
        DvNpGOvEcTEmP0I/xMAUei7onGXCw0ChEO9x
X-Google-Smtp-Source: AMrXdXud1PoPlKT4y1F5KMib0Fr4Tkf0gq528zsd01g47m76L9pYsV1T8JlsoH7XBdJPnfuKbWmcx618eW/AtxjD
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:1309:b0:219:4487:f763 with SMTP
 id h9-20020a17090a130900b002194487f763mr845655pja.201.1671754449592; Thu, 22
 Dec 2022 16:14:09 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:50 +0000
In-Reply-To: <20221223001352.3873203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221223001352.3873203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-7-vannapurve@google.com>
Subject: [V3 PATCH 6/8] KVM: selftests: Refactor private_mem_test
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
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com,
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

Move most of the logic from private mem test to a library to allow
possible sharing of private_mem_test logic amongst non-confidential and
confidential VM selftests.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../include/x86_64/private_mem_test_helper.h  |  15 ++
 .../kvm/lib/x86_64/private_mem_test_helper.c  | 197 ++++++++++++++++++
 .../selftests/kvm/x86_64/private_mem_test.c   | 187 +----------------
 4 files changed, 214 insertions(+), 186 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ee8c3aebee80..83c649c9de23 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -56,6 +56,7 @@ LIBKVM_x86_64 += lib/x86_64/handlers.S
 LIBKVM_x86_64 += lib/x86_64/hyperv.c
 LIBKVM_x86_64 += lib/x86_64/memstress.c
 LIBKVM_x86_64 += lib/x86_64/private_mem.c
+LIBKVM_x86_64 += lib/x86_64/private_mem_test_helper.c
 LIBKVM_x86_64 += lib/x86_64/processor.c
 LIBKVM_x86_64 += lib/x86_64/svm.c
 LIBKVM_x86_64 += lib/x86_64/ucall.c
diff --git a/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h b/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
new file mode 100644
index 000000000000..4d32c025876c
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+
+#ifndef SELFTEST_KVM_PRIVATE_MEM_TEST_HELPER_H
+#define SELFTEST_KVM_PRIVATE_MEM_TEST_HELPER_H
+
+#include <stdint.h>
+#include <kvm_util.h>
+
+void execute_vm_with_private_test_mem(
+			enum vm_mem_backing_src_type test_mem_src);
+
+#endif /* SELFTEST_KVM_PRIVATE_MEM_TEST_HELPER_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c b/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c
new file mode 100644
index 000000000000..600bd21d1bb8
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c
@@ -0,0 +1,197 @@
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
+#include <private_mem_test_helper.h>
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
+void execute_vm_with_private_test_mem(
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
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_test.c
index 015ada2e3d54..72c2f913ee92 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_test.c
@@ -3,197 +3,12 @@
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
 
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/kvm_para.h>
-#include <linux/memfd.h>
-
-#include <test_util.h>
 #include <kvm_util.h>
-#include <private_mem.h>
-#include <processor.h>
-
-#define TEST_AREA_SLOT		10
-#define TEST_AREA_GPA		0xC0000000
-#define TEST_AREA_SIZE		(2 * 1024 * 1024)
-#define GUEST_TEST_MEM_OFFSET	(1 * 1024 * 1024)
-#define GUEST_TEST_MEM_SIZE	(10 * 4096)
-
-#define VM_STAGE_PROCESSED(x)	pr_info("Processed stage %s\n", #x)
-
-#define TEST_MEM_DATA_PATTERN1	0x66
-#define TEST_MEM_DATA_PATTERN2	0x99
-#define TEST_MEM_DATA_PATTERN3	0x33
-#define TEST_MEM_DATA_PATTERN4	0xaa
-#define TEST_MEM_DATA_PATTERN5	0x12
-
-static bool verify_mem_contents(void *mem, uint32_t size, uint8_t pattern)
-{
-	uint8_t *buf = (uint8_t *)mem;
-
-	for (uint32_t i = 0; i < size; i++) {
-		if (buf[i] != pattern)
-			return false;
-	}
-
-	return true;
-}
-
-static void populate_test_area(void *test_area_base, uint64_t pattern)
-{
-	memset(test_area_base, pattern, TEST_AREA_SIZE);
-}
-
-static void populate_guest_test_mem(void *guest_test_mem, uint64_t pattern)
-{
-	memset(guest_test_mem, pattern, GUEST_TEST_MEM_SIZE);
-}
-
-static bool verify_test_area(void *test_area_base, uint64_t area_pattern,
-	uint64_t guest_pattern)
-{
-	void *guest_test_mem = test_area_base + GUEST_TEST_MEM_OFFSET;
-	void *test_area2_base = guest_test_mem + GUEST_TEST_MEM_SIZE;
-	uint64_t test_area2_size = (TEST_AREA_SIZE - (GUEST_TEST_MEM_OFFSET +
-			GUEST_TEST_MEM_SIZE));
-
-	return (verify_mem_contents(test_area_base, GUEST_TEST_MEM_OFFSET, area_pattern) &&
-		verify_mem_contents(guest_test_mem, GUEST_TEST_MEM_SIZE, guest_pattern) &&
-		verify_mem_contents(test_area2_base, test_area2_size, area_pattern));
-}
-
-#define GUEST_STARTED			0
-#define GUEST_PRIVATE_MEM_POPULATED	1
-#define GUEST_SHARED_MEM_POPULATED	2
-#define GUEST_PRIVATE_MEM_POPULATED2	3
-
-/*
- * Run memory conversion tests with explicit conversion:
- * Execute KVM hypercall to map/unmap gpa range which will cause userspace exit
- * to back/unback private memory. Subsequent accesses by guest to the gpa range
- * will not cause exit to userspace.
- *
- * Test memory conversion scenarios with following steps:
- * 1) Access private memory using private access and verify that memory contents
- *   are not visible to userspace.
- * 2) Convert memory to shared using explicit conversions and ensure that
- *   userspace is able to access the shared regions.
- * 3) Convert memory back to private using explicit conversions and ensure that
- *   userspace is again not able to access converted private regions.
- */
-static void guest_conv_test_fn(void)
-{
-	void *test_area_base = (void *)TEST_AREA_GPA;
-	void *guest_test_mem = (void *)(TEST_AREA_GPA + GUEST_TEST_MEM_OFFSET);
-	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
-
-	GUEST_SYNC(GUEST_STARTED);
-
-	populate_test_area(test_area_base, TEST_MEM_DATA_PATTERN1);
-	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED);
-	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
-		TEST_MEM_DATA_PATTERN1));
-
-	kvm_hypercall_map_shared((uint64_t)guest_test_mem, guest_test_size);
-
-	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PATTERN2);
-
-	GUEST_SYNC(GUEST_SHARED_MEM_POPULATED);
-	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
-		TEST_MEM_DATA_PATTERN5));
-
-	kvm_hypercall_map_private((uint64_t)guest_test_mem, guest_test_size);
-
-	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PATTERN3);
-	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED2);
-
-	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
-		TEST_MEM_DATA_PATTERN3));
-	GUEST_DONE();
-}
-
-#define ASSERT_CONV_TEST_EXIT_IO(vcpu, stage) \
-	{ \
-		struct ucall uc; \
-		ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_IO); \
-		ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC); \
-		ASSERT_EQ(uc.args[1], stage); \
-	}
-
-#define ASSERT_GUEST_DONE(vcpu) \
-	{ \
-		struct ucall uc; \
-		ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_IO); \
-		ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE); \
-	}
-
-static void host_conv_test_fn(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
-{
-	void *test_area_hva = addr_gpa2hva(vm, TEST_AREA_GPA);
-	void *guest_test_mem_hva = (test_area_hva + GUEST_TEST_MEM_OFFSET);
-
-	vcpu_run_and_handle_mapgpa(vm, vcpu);
-	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_STARTED);
-	populate_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4);
-	VM_STAGE_PROCESSED(GUEST_STARTED);
-
-	vcpu_run_and_handle_mapgpa(vm, vcpu);
-	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_PRIVATE_MEM_POPULATED);
-	TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
-			TEST_MEM_DATA_PATTERN4), "failed");
-	VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED);
-
-	vcpu_run_and_handle_mapgpa(vm, vcpu);
-	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_SHARED_MEM_POPULATED);
-	TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
-			TEST_MEM_DATA_PATTERN2), "failed");
-	populate_guest_test_mem(guest_test_mem_hva, TEST_MEM_DATA_PATTERN5);
-	VM_STAGE_PROCESSED(GUEST_SHARED_MEM_POPULATED);
-
-	vcpu_run_and_handle_mapgpa(vm, vcpu);
-	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_PRIVATE_MEM_POPULATED2);
-	TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
-			TEST_MEM_DATA_PATTERN5), "failed");
-	VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED2);
-
-	vcpu_run_and_handle_mapgpa(vm, vcpu);
-	ASSERT_GUEST_DONE(vcpu);
-}
-
-static void execute_vm_with_private_test_mem(
-			enum vm_mem_backing_src_type test_mem_src)
-{
-	struct kvm_vm *vm;
-	struct kvm_enable_cap cap;
-	struct kvm_vcpu *vcpu;
-
-	vm = vm_create_with_one_vcpu(&vcpu, guest_conv_test_fn);
-
-	vm_check_cap(vm, KVM_CAP_EXIT_HYPERCALL);
-	cap.cap = KVM_CAP_EXIT_HYPERCALL;
-	cap.flags = 0;
-	cap.args[0] = (1 << KVM_HC_MAP_GPA_RANGE);
-	vm_ioctl(vm, KVM_ENABLE_CAP, &cap);
-
-	vm_userspace_mem_region_add(vm, test_mem_src, TEST_AREA_GPA,
-		TEST_AREA_SLOT, TEST_AREA_SIZE / vm->page_size, KVM_MEM_PRIVATE);
-	vm_allocate_private_mem(vm, TEST_AREA_GPA, TEST_AREA_SIZE);
-
-	virt_map(vm, TEST_AREA_GPA, TEST_AREA_GPA, TEST_AREA_SIZE/vm->page_size);
-
-	host_conv_test_fn(vm, vcpu);
-
-	kvm_vm_free(vm);
-}
+#include <private_mem_test_helper.h>
 
 int main(int argc, char *argv[])
 {
-- 
2.39.0.314.g84b9a713c41-goog

