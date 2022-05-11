Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F10522835
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 02:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiEKAJD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 20:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiEKAIo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 20:08:44 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56305235148
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:38 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id h23-20020a17090adb9700b001dcce3bb2d4so2022104pjv.7
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EqhkSxXkH/+hwiomE5rucysbEqX3JGglkHqA2C3iBW8=;
        b=NgWeY6kV8a8KizJs9328ro0t3UwQMjfOojbQ/esljEF5c0+r5IRbfIBbUlb7BhJqZn
         2O0yfh85utUX7BuoAGzCPhhigxQLDK+kyny4dFgOFnCCD25qTZxVwMH9MjnEbm4f2de3
         IPDo2q+VxTmi7biw8RLJ2ddvosAS5pHlKbrJX6FVehyUK1JIfNPjWq4Nr7yrcW+krjK+
         0GU5+Kl+oJ6z3ByiTxl0oBPL70vEuqECPpWrb1JrbVI4htRWhtZs3IOCSaPyH1bZAx4E
         jVo6/4217uPqbfarKpd+e2zA/lj/G0wx/iGFZWpy7/KfNFpmCR1HlT0ziSyYSgtAT0Yi
         fk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EqhkSxXkH/+hwiomE5rucysbEqX3JGglkHqA2C3iBW8=;
        b=pJgyxMXWJoE3hCuxtPhbs/JBoSetClJliGR4z2/REhZSB6CtrDOPqfVYHwrqAvKhOd
         tCkMLN40/xMFhEDuTuLIIXmsD/HfuZFNsH5zHYSyPGv6CBDXJa8Xe+DjtkM0phchIWIY
         kVYYgYWVsbv9WG/vnYuDz1UyYjLXfcCETT9vWJSu9IURAVJ0tlXiraHAkmmd2V9igteV
         B+B7n3nJ+NY6Fdn1AZrakLg7QWbQJdtVhG1aFE5eRwkIsFBdl9pqm38zK+J5Bdaf3vKe
         nkrpyLmw+EjPvBk2JXAZ4BvmRf2L6/0QkW2Bg9NsPWMLNlNiNWuvedJ4uerb9nd+qFTA
         bJeA==
X-Gm-Message-State: AOAM5321QMtjtTOaoGXttYIDTjJMPe4Meofeq5EbP2hNCZV61Rulqfsk
        dBqhYwvrsvsBJm2oz6j6rBfuQ/RlsfwnMvYR
X-Google-Smtp-Source: ABdhPJzx2oJnAJehuC8ueDi+L9zp9s7bHRnweeOMEWptNIKQmM5xJu2sYC/uYEEg1NEMclHrGt8Z2mA+Nm3Atxz2
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:3908:b0:1dc:710e:643 with SMTP
 id ob8-20020a17090b390800b001dc710e0643mr2377006pjb.210.1652227717896; Tue,
 10 May 2022 17:08:37 -0700 (PDT)
Date:   Wed, 11 May 2022 00:08:09 +0000
In-Reply-To: <20220511000811.384766-1-vannapurve@google.com>
Message-Id: <20220511000811.384766-8-vannapurve@google.com>
Mime-Version: 1.0
References: <20220511000811.384766-1-vannapurve@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC V2 PATCH 7/8] selftests: kvm: Add hugepage support to
 priv_memfd_test suite.
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shauh@kernel.org, yang.zhong@intel.com,
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
        diviness@google.com, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Austin Diviness <diviness@google.com>

Adds ability to run priv_memfd_test test suite across various sizes of pages
for shared/private memory. Shared and private memory can be allocated
with different sized pages. In order to verify that there isn't a
behavior change based on different page sizes, this change runs the
tests using the currently supported permutations.

Adds command line flags to adjust whether the tests should run with
hugepages backing the test memory.

Signed-off-by: Austin Diviness <diviness@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/priv_memfd_test.c | 369 ++++++++++++++----
 1 file changed, 294 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/kvm/priv_memfd_test.c b/tools/testing/selftests/kvm/priv_memfd_test.c
index c2ea8f67337c..dbe6ead92ba7 100644
--- a/tools/testing/selftests/kvm/priv_memfd_test.c
+++ b/tools/testing/selftests/kvm/priv_memfd_test.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE /* for program_invocation_short_name */
 #include <fcntl.h>
+#include <limits.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -17,9 +18,18 @@
 #include <kvm_util.h>
 #include <processor.h>
 
+#define BYTE_MASK 0xFF
+
+// flags for mmap
+#define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
+#define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
+
+// page sizes
+#define PAGE_SIZE_4KB ((size_t)0x1000)
+#define PAGE_SIZE_2MB (PAGE_SIZE_4KB * (size_t)512)
+#define PAGE_SIZE_1GB ((PAGE_SIZE_4KB * 256) * 1024)
+
 #define TEST_MEM_GPA		0xb0000000
-#define TEST_MEM_SIZE		0x2000
-#define TEST_MEM_END		(TEST_MEM_GPA + TEST_MEM_SIZE)
 #define TEST_MEM_DATA_PAT1	0x6666666666666666
 #define TEST_MEM_DATA_PAT2	0x9999999999999999
 #define TEST_MEM_DATA_PAT3	0x3333333333333333
@@ -34,8 +44,16 @@ enum mem_op {
 
 #define VCPU_ID			0
 
+// address where guests can receive the mem size of the data
+// allocated to them by the vmm
+#define MEM_SIZE_MMIO_ADDRESS 0xa0000000
+
 #define VM_STAGE_PROCESSED(x)	pr_info("Processed stage %s\n", #x)
 
+// global used for storing the current mem allocation size
+// for the running test
+static size_t test_mem_size;
+
 typedef bool (*vm_stage_handler_fn)(struct kvm_vm *,
 				void *, uint64_t);
 typedef void (*guest_code_fn)(void);
@@ -47,6 +65,36 @@ struct test_run_helper {
 	int priv_memfd;
 };
 
+enum page_size {
+	PAGE_4KB,
+	PAGE_2MB,
+	PAGE_1GB
+};
+
+struct page_combo {
+	enum page_size shared;
+	enum page_size private;
+};
+
+static char *page_size_to_str(enum page_size x)
+{
+	switch (x) {
+	case PAGE_4KB:
+		return "PAGE_4KB";
+	case PAGE_2MB:
+		return "PAGE_2MB";
+	case PAGE_1GB:
+		return "PAGE_1GB";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static uint64_t test_mem_end(const uint64_t start, const uint64_t size)
+{
+	return start + size;
+}
+
 /* Guest code in selftests is loaded to guest memory using kvm_vm_elf_load
  * which doesn't handle global offset table updates. Calling standard libc
  * functions would normally result in referring to the global offset table.
@@ -103,7 +151,7 @@ static bool pmpat_handle_vm_stage(struct kvm_vm *vm,
 	case PMPAT_GUEST_STARTED: {
 		/* Initialize the contents of shared memory */
 		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory update failure");
 		VM_STAGE_PROCESSED(PMPAT_GUEST_STARTED);
 		break;
@@ -111,7 +159,7 @@ static bool pmpat_handle_vm_stage(struct kvm_vm *vm,
 	case PMPAT_GUEST_PRIV_MEM_UPDATED: {
 		/* verify host updated data is still intact */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(PMPAT_GUEST_PRIV_MEM_UPDATED);
 		break;
@@ -131,18 +179,20 @@ static void pmpat_guest_code(void)
 
 	GUEST_SYNC(PMPAT_GUEST_STARTED);
 
+	const size_t mem_size = *((size_t *)MEM_SIZE_MMIO_ADDRESS);
+
 	/* Mark the GPA range to be treated as always accessed privately */
 	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
-		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		mem_size >> MIN_PAGE_SHIFT,
 		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
 	GUEST_ASSERT_1(ret == 0, ret);
 
 	GUEST_ASSERT(do_mem_op(SET_PAT, priv_mem, TEST_MEM_DATA_PAT2,
-			TEST_MEM_SIZE));
+			mem_size));
 	GUEST_SYNC(PMPAT_GUEST_PRIV_MEM_UPDATED);
 
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, priv_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 
 	GUEST_DONE();
 }
@@ -175,7 +225,7 @@ static bool pmsat_handle_vm_stage(struct kvm_vm *vm,
 	case PMSAT_GUEST_STARTED: {
 		/* Initialize the contents of shared memory */
 		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory update failed");
 		VM_STAGE_PROCESSED(PMSAT_GUEST_STARTED);
 		break;
@@ -183,7 +233,7 @@ static bool pmsat_handle_vm_stage(struct kvm_vm *vm,
 	case PMSAT_GUEST_TEST_MEM_UPDATED: {
 		/* verify data to be same as what guest wrote */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT2, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(PMSAT_GUEST_TEST_MEM_UPDATED);
 		break;
@@ -199,13 +249,14 @@ static bool pmsat_handle_vm_stage(struct kvm_vm *vm,
 static void pmsat_guest_code(void)
 {
 	void *shared_mem = (void *)TEST_MEM_GPA;
+	const size_t mem_size = *((size_t *)MEM_SIZE_MMIO_ADDRESS);
 
 	GUEST_SYNC(PMSAT_GUEST_STARTED);
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT1, mem_size));
 
 	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 	GUEST_SYNC(PMSAT_GUEST_TEST_MEM_UPDATED);
 
 	GUEST_DONE();
@@ -240,12 +291,12 @@ static bool smsat_handle_vm_stage(struct kvm_vm *vm,
 		/* Remove the backing private memory storage */
 		int ret = fallocate(priv_memfd,
 				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				0, TEST_MEM_SIZE);
+				0, test_mem_size);
 		TEST_ASSERT(ret != -1,
 			"fallocate failed in smsat handling");
 		/* Initialize the contents of shared memory */
 		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory updated failed");
 		VM_STAGE_PROCESSED(SMSAT_GUEST_STARTED);
 		break;
@@ -253,7 +304,7 @@ static bool smsat_handle_vm_stage(struct kvm_vm *vm,
 	case SMSAT_GUEST_TEST_MEM_UPDATED: {
 		/* verify data to be same as what guest wrote */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT2, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(SMSAT_GUEST_TEST_MEM_UPDATED);
 		break;
@@ -269,13 +320,14 @@ static bool smsat_handle_vm_stage(struct kvm_vm *vm,
 static void smsat_guest_code(void)
 {
 	void *shared_mem = (void *)TEST_MEM_GPA;
+	const size_t mem_size = *((size_t *)MEM_SIZE_MMIO_ADDRESS);
 
 	GUEST_SYNC(SMSAT_GUEST_STARTED);
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT1, mem_size));
 
 	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 	GUEST_SYNC(SMSAT_GUEST_TEST_MEM_UPDATED);
 
 	GUEST_DONE();
@@ -309,12 +361,12 @@ static bool smpat_handle_vm_stage(struct kvm_vm *vm,
 		/* Remove the backing private memory storage */
 		int ret = fallocate(priv_memfd,
 				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				0, TEST_MEM_SIZE);
+				0, test_mem_size);
 		TEST_ASSERT(ret != -1,
 			"fallocate failed in smpat handling");
 		/* Initialize the contents of shared memory */
 		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory updated failed");
 		VM_STAGE_PROCESSED(SMPAT_GUEST_STARTED);
 		break;
@@ -322,7 +374,7 @@ static bool smpat_handle_vm_stage(struct kvm_vm *vm,
 	case SMPAT_GUEST_TEST_MEM_UPDATED: {
 		/* verify data to be same as what vmm wrote earlier */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(SMPAT_GUEST_TEST_MEM_UPDATED);
 		break;
@@ -342,17 +394,19 @@ static void smpat_guest_code(void)
 
 	GUEST_SYNC(SMPAT_GUEST_STARTED);
 
+	const size_t mem_size = *((size_t *)MEM_SIZE_MMIO_ADDRESS);
+
 	/* Mark the GPA range to be treated as always accessed privately */
 	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
-		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		mem_size >> MIN_PAGE_SHIFT,
 		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
 	GUEST_ASSERT_1(ret == 0, ret);
 
 	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 	GUEST_SYNC(SMPAT_GUEST_TEST_MEM_UPDATED);
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 
 	GUEST_DONE();
 }
@@ -394,7 +448,7 @@ static bool psat_handle_vm_stage(struct kvm_vm *vm,
 	case PSAT_GUEST_STARTED: {
 		/* Initialize the contents of shared memory */
 		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory update failed");
 		VM_STAGE_PROCESSED(PSAT_GUEST_STARTED);
 		break;
@@ -402,7 +456,7 @@ static bool psat_handle_vm_stage(struct kvm_vm *vm,
 	case PSAT_GUEST_PRIVATE_MEM_UPDATED: {
 		/* verify data to be same as what vmm wrote earlier */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(PSAT_GUEST_PRIVATE_MEM_UPDATED);
 		break;
@@ -414,7 +468,7 @@ static bool psat_handle_vm_stage(struct kvm_vm *vm,
 		 */
 		int ret = fallocate(priv_memfd,
 				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				0, TEST_MEM_SIZE);
+				0, test_mem_size);
 		TEST_ASSERT(ret != -1,
 			"fallocate failed in smpat handling");
 		VM_STAGE_PROCESSED(PSAT_GUEST_PRIVATE_MEM_VERIFIED);
@@ -423,7 +477,7 @@ static bool psat_handle_vm_stage(struct kvm_vm *vm,
 	case PSAT_GUEST_SHARED_MEM_UPDATED: {
 		/* verify data to be same as what guest wrote */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT2, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(PSAT_GUEST_SHARED_MEM_UPDATED);
 		break;
@@ -442,17 +496,20 @@ static void psat_guest_code(void)
 	int ret;
 
 	GUEST_SYNC(PSAT_GUEST_STARTED);
+
+	const size_t mem_size = *((size_t *)MEM_SIZE_MMIO_ADDRESS);
+
 	/* Mark the GPA range to be treated as always accessed privately */
 	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
-		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		mem_size >> MIN_PAGE_SHIFT,
 		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
 	GUEST_ASSERT_1(ret == 0, ret);
 
 	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 	GUEST_SYNC(PSAT_GUEST_PRIVATE_MEM_UPDATED);
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 
 	GUEST_SYNC(PSAT_GUEST_PRIVATE_MEM_VERIFIED);
 
@@ -461,10 +518,10 @@ static void psat_guest_code(void)
 		0, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
 	GUEST_ASSERT_1(ret == 0, ret);
 	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 	GUEST_SYNC(PSAT_GUEST_SHARED_MEM_UPDATED);
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 
 	GUEST_DONE();
 }
@@ -509,13 +566,13 @@ static bool spat_handle_vm_stage(struct kvm_vm *vm,
 		 */
 		int ret = fallocate(priv_memfd,
 				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				0, TEST_MEM_SIZE);
+				0, test_mem_size);
 		TEST_ASSERT(ret != -1,
 			"fallocate failed in spat handling");
 
 		/* Initialize the contents of shared memory */
 		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory updated failed");
 		VM_STAGE_PROCESSED(SPAT_GUEST_STARTED);
 		break;
@@ -523,11 +580,11 @@ static bool spat_handle_vm_stage(struct kvm_vm *vm,
 	case SPAT_GUEST_SHARED_MEM_UPDATED: {
 		/* verify data to be same as what guest wrote earlier */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT2, test_mem_size),
 			"Shared memory view mismatch");
 		/* Allocate memory for private backing store */
 		int ret = fallocate(priv_memfd,
-				0, 0, TEST_MEM_SIZE);
+				0, 0, test_mem_size);
 		TEST_ASSERT(ret != -1,
 			"fallocate failed in spat handling");
 		VM_STAGE_PROCESSED(SPAT_GUEST_SHARED_MEM_UPDATED);
@@ -536,7 +593,7 @@ static bool spat_handle_vm_stage(struct kvm_vm *vm,
 	case SPAT_GUEST_PRIVATE_MEM_UPDATED: {
 		/* verify data to be same as what guest wrote earlier */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT2, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(SPAT_GUEST_PRIVATE_MEM_UPDATED);
 		break;
@@ -554,23 +611,26 @@ static void spat_guest_code(void)
 	void *shared_mem = (void *)TEST_MEM_GPA;
 	int ret;
 
+	const size_t mem_size = *((size_t *)MEM_SIZE_MMIO_ADDRESS);
+
 	GUEST_SYNC(SPAT_GUEST_STARTED);
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT1, mem_size));
 	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
+
 	GUEST_SYNC(SPAT_GUEST_SHARED_MEM_UPDATED);
 	/* Mark the GPA range to be treated as always accessed privately */
 	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
-		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		mem_size >> MIN_PAGE_SHIFT,
 		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
 	GUEST_ASSERT_1(ret == 0, ret);
 
 	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT1, mem_size));
 	GUEST_SYNC(PSAT_GUEST_PRIVATE_MEM_UPDATED);
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT1, mem_size));
 	GUEST_DONE();
 }
 
@@ -617,7 +677,7 @@ static bool pspahct_handle_vm_stage(struct kvm_vm *vm,
 	case PSPAHCT_GUEST_STARTED: {
 		/* Initialize the contents of shared memory */
 		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory update failed");
 		VM_STAGE_PROCESSED(PSPAHCT_GUEST_STARTED);
 		break;
@@ -625,7 +685,7 @@ static bool pspahct_handle_vm_stage(struct kvm_vm *vm,
 	case PSPAHCT_GUEST_PRIVATE_MEM_UPDATED: {
 		/* verify data to be same as what guest wrote earlier */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT1, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED);
 		break;
@@ -633,7 +693,7 @@ static bool pspahct_handle_vm_stage(struct kvm_vm *vm,
 	case PSPAHCT_GUEST_SHARED_MEM_UPDATED: {
 		/* verify data to be same as what guest wrote earlier */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT2, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(PSPAHCT_GUEST_SHARED_MEM_UPDATED);
 		break;
@@ -641,7 +701,7 @@ static bool pspahct_handle_vm_stage(struct kvm_vm *vm,
 	case PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2: {
 		/* verify data to be same as what guest wrote earlier */
 		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			TEST_MEM_DATA_PAT2, test_mem_size),
 			"Shared memory view mismatch");
 		VM_STAGE_PROCESSED(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2);
 		break;
@@ -661,21 +721,23 @@ static void pspahct_guest_code(void)
 
 	GUEST_SYNC(PSPAHCT_GUEST_STARTED);
 
+	const size_t mem_size = *((size_t *)MEM_SIZE_MMIO_ADDRESS);
+
 	/* Mark the GPA range to be treated as always accessed privately */
 	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
-		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		mem_size >> MIN_PAGE_SHIFT,
 		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
 	GUEST_ASSERT_1(ret == 0, ret);
 	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
-		TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+		TEST_MEM_DATA_PAT2, mem_size));
 
 	GUEST_SYNC(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED);
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 
 	/* Map the GPA range to be treated as shared */
 	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
-		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		mem_size >> MIN_PAGE_SHIFT,
 		KVM_MAP_GPA_RANGE_DECRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
 	GUEST_ASSERT_1(ret == 0, ret);
 
@@ -687,17 +749,17 @@ static void pspahct_guest_code(void)
 	GUEST_ASSERT_1(ret == 0, ret);
 
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT1, mem_size));
 	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 	GUEST_SYNC(PSPAHCT_GUEST_SHARED_MEM_UPDATED);
 
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
-			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT2, mem_size));
 
 	/* Map the GPA range to be treated as private */
 	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
-		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		mem_size >> MIN_PAGE_SHIFT,
 		KVM_MAP_GPA_RANGE_ENCRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
 	GUEST_ASSERT_1(ret == 0, ret);
 
@@ -705,15 +767,15 @@ static void pspahct_guest_code(void)
 	 * access
 	 */
 	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
-		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		mem_size >> MIN_PAGE_SHIFT,
 		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
 	GUEST_ASSERT_1(ret == 0, ret);
 
 	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT1, mem_size));
 	GUEST_SYNC(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2);
 	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
-			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+			TEST_MEM_DATA_PAT1, mem_size));
 	GUEST_DONE();
 }
 
@@ -758,7 +820,7 @@ static struct test_run_helper priv_memfd_testsuite[] = {
 static void handle_vm_exit_hypercall(struct kvm_run *run,
 	uint32_t test_id)
 {
-	uint64_t gpa, npages, attrs;
+	uint64_t gpa, npages, attrs, mem_end;
 	int priv_memfd =
 		priv_memfd_testsuite[test_id].priv_memfd;
 	int ret;
@@ -772,9 +834,10 @@ static void handle_vm_exit_hypercall(struct kvm_run *run,
 	gpa = run->hypercall.args[0];
 	npages = run->hypercall.args[1];
 	attrs = run->hypercall.args[2];
+	mem_end = test_mem_end(gpa, test_mem_size);
 
 	if ((gpa < TEST_MEM_GPA) || ((gpa +
-		(npages << MIN_PAGE_SHIFT)) > TEST_MEM_END)) {
+		(npages << MIN_PAGE_SHIFT)) > mem_end)) {
 		TEST_FAIL("Unhandled gpa 0x%lx npages %ld\n",
 			gpa, npages);
 	}
@@ -800,7 +863,7 @@ static void handle_vm_exit_hypercall(struct kvm_run *run,
 static void handle_vm_exit_memory_error(struct kvm_run *run,
 	uint32_t test_id)
 {
-	uint64_t gpa, size, flags;
+	uint64_t gpa, size, flags, mem_end;
 	int ret;
 	int priv_memfd =
 		priv_memfd_testsuite[test_id].priv_memfd;
@@ -809,9 +872,10 @@ static void handle_vm_exit_memory_error(struct kvm_run *run,
 	gpa = run->memory.gpa;
 	size = run->memory.size;
 	flags = run->memory.flags;
+	mem_end = test_mem_end(gpa, test_mem_size);
 
 	if ((gpa < TEST_MEM_GPA) || ((gpa + size)
-					> TEST_MEM_END)) {
+					> mem_end)) {
 		TEST_FAIL("Unhandled gpa 0x%lx size 0x%lx\n",
 			gpa, size);
 	}
@@ -858,6 +922,22 @@ static void vcpu_work(struct kvm_vm *vm, uint32_t test_id)
 			continue;
 		}
 
+		if (run->exit_reason == KVM_EXIT_MMIO) {
+			if (run->mmio.phys_addr == MEM_SIZE_MMIO_ADDRESS) {
+				// tell the guest the size of the memory
+				// it's been allocated
+				int shift_amount = 0;
+
+				for (int i = 0; i < sizeof(uint64_t); ++i) {
+					run->mmio.data[i] =
+						(test_mem_size >>
+							shift_amount) & BYTE_MASK;
+					shift_amount += CHAR_BIT;
+				}
+			}
+			continue;
+		}
+
 		if (run->exit_reason == KVM_EXIT_HYPERCALL) {
 			handle_vm_exit_hypercall(run, test_id);
 			continue;
@@ -896,7 +976,9 @@ static void priv_memory_region_add(struct kvm_vm *vm, void *mem, uint32_t slot,
 		guest_addr);
 }
 
-static void setup_and_execute_test(uint32_t test_id)
+static void setup_and_execute_test(uint32_t test_id,
+	const enum page_size shared,
+	const enum page_size private)
 {
 	struct kvm_vm *vm;
 	int priv_memfd;
@@ -907,27 +989,82 @@ static void setup_and_execute_test(uint32_t test_id)
 	vm = vm_create_default(VCPU_ID, 0,
 				priv_memfd_testsuite[test_id].guest_fn);
 
+	// use 2 pages by default
+	size_t mem_size = PAGE_SIZE_4KB * 2;
+	bool using_hugepages = false;
+
+	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
+
+	switch (shared) {
+	case PAGE_4KB:
+		// no additional flags are needed
+		break;
+	case PAGE_2MB:
+		mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB | MAP_POPULATE;
+		mem_size = max(mem_size, PAGE_SIZE_2MB);
+		using_hugepages = true;
+		break;
+	case PAGE_1GB:
+		mmap_flags |= MAP_HUGETLB | MAP_HUGE_1GB | MAP_POPULATE;
+		mem_size = max(mem_size, PAGE_SIZE_1GB);
+		using_hugepages = true;
+		break;
+	default:
+		TEST_FAIL("unknown page size for shared memory\n");
+	}
+
+	unsigned int memfd_flags = MFD_INACCESSIBLE;
+
+	switch (private) {
+	case PAGE_4KB:
+		// no additional flags are needed
+		break;
+	case PAGE_2MB:
+		memfd_flags |= MFD_HUGETLB | MFD_HUGE_2MB;
+		mem_size = PAGE_SIZE_2MB;
+		using_hugepages = true;
+		break;
+	case PAGE_1GB:
+		memfd_flags |= MFD_HUGETLB | MFD_HUGE_1GB;
+		mem_size = PAGE_SIZE_1GB;
+		using_hugepages = true;
+		break;
+	default:
+		TEST_FAIL("unknown page size for private memory\n");
+	}
+
+	// set global for mem size to use later
+	test_mem_size = mem_size;
+
 	/* Allocate shared memory */
-	shared_mem = mmap(NULL, TEST_MEM_SIZE,
+	shared_mem = mmap(NULL, mem_size,
 			PROT_READ | PROT_WRITE,
-			MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
+			mmap_flags, -1, 0);
 	TEST_ASSERT(shared_mem != MAP_FAILED, "Failed to mmap() host");
 
+	if (using_hugepages) {
+		ret = madvise(shared_mem, mem_size, MADV_WILLNEED);
+		TEST_ASSERT(ret == 0, "madvise failed");
+	}
+
 	/* Allocate private memory */
-	priv_memfd = memfd_create("vm_private_mem", MFD_INACCESSIBLE);
+	priv_memfd = memfd_create("vm_private_mem", memfd_flags);
 	TEST_ASSERT(priv_memfd != -1, "Failed to create priv_memfd");
-	ret = fallocate(priv_memfd, 0, 0, TEST_MEM_SIZE);
+	ret = fallocate(priv_memfd, 0, 0, mem_size);
 	TEST_ASSERT(ret != -1, "fallocate failed");
 
 	priv_memory_region_add(vm, shared_mem,
-				TEST_MEM_SLOT, TEST_MEM_SIZE,
+				TEST_MEM_SLOT, mem_size,
 				TEST_MEM_GPA, priv_memfd, 0);
 
-	pr_info("Mapping test memory pages 0x%x page_size 0x%x\n",
-					TEST_MEM_SIZE/vm_get_page_size(vm),
+	pr_info("Mapping test memory pages 0x%zx page_size 0x%x\n",
+					mem_size/vm_get_page_size(vm),
 					vm_get_page_size(vm));
 	virt_map(vm, TEST_MEM_GPA, TEST_MEM_GPA,
-					(TEST_MEM_SIZE/vm_get_page_size(vm)));
+					(mem_size/vm_get_page_size(vm)));
+
+	// add mmio communication page
+	virt_map(vm, MEM_SIZE_MMIO_ADDRESS, MEM_SIZE_MMIO_ADDRESS, 1);
 
 	/* Enable exit on KVM_HC_MAP_GPA_RANGE */
 	pr_info("Enabling exit on map_gpa_range hypercall\n");
@@ -945,24 +1082,106 @@ static void setup_and_execute_test(uint32_t test_id)
 	priv_memfd_testsuite[test_id].priv_memfd = priv_memfd;
 	vcpu_work(vm, test_id);
 
-	munmap(shared_mem, TEST_MEM_SIZE);
+	munmap(shared_mem, mem_size);
 	priv_memfd_testsuite[test_id].shared_mem = NULL;
 	close(priv_memfd);
 	priv_memfd_testsuite[test_id].priv_memfd = -1;
 	kvm_vm_free(vm);
 }
 
+static void hugepage_requirements_text(const struct page_combo matrix)
+{
+	int pages_needed_2mb = 0;
+	int pages_needed_1gb = 0;
+	enum page_size sizes[] = { matrix.shared, matrix.private };
+
+	for (int i = 0; i < ARRAY_SIZE(sizes); ++i) {
+		if (sizes[i] == PAGE_2MB)
+			++pages_needed_2mb;
+		if (sizes[i] == PAGE_1GB)
+			++pages_needed_1gb;
+	}
+	if (pages_needed_2mb != 0 && pages_needed_1gb != 0) {
+		pr_info("This test requires %d 2MB page(s) and %d 1GB page(s)\n",
+				pages_needed_2mb, pages_needed_1gb);
+	} else if (pages_needed_2mb != 0) {
+		pr_info("This test requires %d 2MB page(s)\n", pages_needed_2mb);
+	} else if (pages_needed_1gb != 0) {
+		pr_info("This test requires %d 1GB page(s)\n", pages_needed_1gb);
+	}
+}
+
+static bool should_skip_test(const struct page_combo matrix,
+	const bool use_2mb_pages,
+	const bool use_1gb_pages)
+{
+	if ((matrix.shared == PAGE_2MB || matrix.private == PAGE_2MB)
+		&& !use_2mb_pages)
+		return true;
+	if ((matrix.shared == PAGE_1GB || matrix.private == PAGE_1GB)
+		&& !use_1gb_pages)
+		return true;
+	return false;
+}
+
+static void print_help(const char *const name)
+{
+	puts("");
+	printf("usage %s [-h] [-m] [-g]\n", name);
+	puts("");
+	printf(" -h: Display this help message\n");
+	printf(" -m: include test runs using 2MB page permutations\n");
+	printf(" -g: include test runs using 1GB page permutations\n");
+	exit(0);
+}
+
 int main(int argc, char *argv[])
 {
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
 
+	// arg parsing
+	int opt;
+	bool use_2mb_pages = false;
+	bool use_1gb_pages = false;
+
+	while ((opt = getopt(argc, argv, "mgh")) != -1) {
+		switch (opt) {
+		case 'm':
+			use_2mb_pages = true;
+			break;
+		case 'g':
+			use_1gb_pages = true;
+			break;
+		case 'h':
+		default:
+			print_help(argv[0]);
+		}
+	}
+
+	struct page_combo page_size_matrix[] = {
+		{ .shared = PAGE_4KB, .private = PAGE_4KB },
+		{ .shared = PAGE_2MB, .private = PAGE_4KB },
+	};
+
 	for (uint32_t i = 0; i < ARRAY_SIZE(priv_memfd_testsuite); i++) {
-		pr_info("=== Starting test %s... ===\n",
-				priv_memfd_testsuite[i].test_desc);
-		setup_and_execute_test(i);
-		pr_info("--- completed test %s ---\n\n",
-				priv_memfd_testsuite[i].test_desc);
+		for (uint32_t j = 0; j < ARRAY_SIZE(page_size_matrix); j++) {
+			const struct page_combo current_page_matrix = page_size_matrix[j];
+
+			if (should_skip_test(current_page_matrix,
+				use_2mb_pages, use_1gb_pages))
+				break;
+			pr_info("=== Starting test %s... ===\n",
+					priv_memfd_testsuite[i].test_desc);
+			pr_info("using page sizes shared: %s private: %s\n",
+					page_size_to_str(current_page_matrix.shared),
+					page_size_to_str(current_page_matrix.private));
+			hugepage_requirements_text(current_page_matrix);
+			setup_and_execute_test(i, current_page_matrix.shared,
+				current_page_matrix.private);
+			pr_info("--- completed test %s ---\n\n",
+					priv_memfd_testsuite[i].test_desc);
+		}
 	}
 
 	return 0;
-- 
2.36.0.550.gb090851708-goog

