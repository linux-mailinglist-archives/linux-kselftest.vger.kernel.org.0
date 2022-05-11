Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F00522833
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiEKAIt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 20:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbiEKAIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 20:08:47 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD83153E
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:41 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b184-20020a62cfc1000000b0050d209cb8dcso254602pfg.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FKYCy8nTeKBSce/4iCSXAO9o2F9LxoRfpI1neokEeTE=;
        b=ssPbYUDDUR7Lk75ZwCroNZYn4ps9HZK45xYG0ZA/1nAmYyewmiB9+4jTK3lomDzHCU
         bP1sovRM/YX1uIo2/l1kOLMSeItaVf9KI6OUJN/9MvLBkBOq/hgF8YgLyfK8iCTSWWBA
         xW54BCXfW5Erd2zyTo259DTs1cZi2LgsB1J0ve5P7UlLI+P9G6L1Uxe3dD2cZ0pRPOHR
         wFOYkgJh4+qea58ZVGFCdzMK6fAHF+cv4Kp25iMEUIKSqHMNHlBN3z7kZf5Rm53gtQox
         dtNcYWkO4FsXB5F3Auf7UEIizxCT51k6ldFJPdqdprMxnhah1vRLXSU/pkLoUHW2ePn9
         isMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FKYCy8nTeKBSce/4iCSXAO9o2F9LxoRfpI1neokEeTE=;
        b=fOTD0oEOdyVlswi6uY5H1InxqN+UNOxpzpsoovR/AkKPaZdIW1DBIa2xnHwkUphQar
         MpF6/1r/rRh+BGY9yCj/5gEjRl4T9x/RBZPWBM41hk+rA6gUsb7jC3XYNWtHryxD+NOF
         xI9egbVZSva+Bi498wy1Bmbr/+g1a7UvGgZapvSSBMJD9msNnerjGhBxuuhc4v5WUoe0
         ScIdGA/AcbnN0uYYhxaNr/3k82eMCrmnBtHBd7ebsOTSr2reZyCgrB89oXwsk8c6pW+4
         nunx+Kls5Z4llA0Tv1Ls1cyCc4DydHb96ODPwGRDotLqtcDTDuIqvr0W3i7Xz40DZRof
         3niA==
X-Gm-Message-State: AOAM532rBN6BE3RWwzBj6tqBA6Fhb94QwsCQQtHtu2jx8wnDnGlvckH5
        vKUx0tA7q0lht5sPeJelcvQVLCAAV/xWyhZk
X-Google-Smtp-Source: ABdhPJzR473SpZp8Yag+VqE5GdAoG5IupcfbIthbh8IUjySyWZjJRrDwxsWbsBYaG8nQDo2oH5pQpOExjRQNMOsZ
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:a0e:b0:4fd:fa6e:95fc with SMTP
 id p14-20020a056a000a0e00b004fdfa6e95fcmr22764103pfh.17.1652227720345; Tue,
 10 May 2022 17:08:40 -0700 (PDT)
Date:   Wed, 11 May 2022 00:08:10 +0000
In-Reply-To: <20220511000811.384766-1-vannapurve@google.com>
Message-Id: <20220511000811.384766-9-vannapurve@google.com>
Mime-Version: 1.0
References: <20220511000811.384766-1-vannapurve@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC V2 PATCH 8/8] selftests: kvm: priv_memfd: Add test avoiding
 double allocation
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a memory conversion test without leading to double allocation
of memory backing gpa ranges.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/priv_memfd_test.c | 225 ++++++++++++++++--
 1 file changed, 211 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/priv_memfd_test.c b/tools/testing/selftests/kvm/priv_memfd_test.c
index dbe6ead92ba7..3b6e84cf6a44 100644
--- a/tools/testing/selftests/kvm/priv_memfd_test.c
+++ b/tools/testing/selftests/kvm/priv_memfd_test.c
@@ -63,6 +63,8 @@ struct test_run_helper {
 	guest_code_fn guest_fn;
 	void *shared_mem;
 	int priv_memfd;
+	bool disallow_boot_shared_access;
+	bool toggle_shared_mem_state;
 };
 
 enum page_size {
@@ -779,6 +781,151 @@ static void pspahct_guest_code(void)
 	GUEST_DONE();
 }
 
+/* Test to verify guest accesses without double allocation:
+ * Guest starts with shared memory access disallowed by default.
+ * 1) Guest writes the private memory privately via a known pattern
+ * 3) Guest reads the private memory privately and verifies that the contents
+ *    are same as written.
+ * 4) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as shared
+ *    and marks the range to be accessed via shared access.
+ * 5) Guest writes shared memory with another pattern and signals VMM
+ * 6) VMM verifies the memory contents to be same as written by guest in step
+ *    5 and updates the memory with a different pattern
+ * 7) Guest verifies the memory contents to be same as written in step 6.
+ * 8) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as private
+ *    and marks the range to be accessed via private access.
+ * 9) Guest writes a known pattern to the test memory and verifies the contents
+ *    to be same as written.
+ * 10) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as shared
+ *    and marks the range to be accessed via shared access.
+ * 11) Guest writes shared memory with another pattern and signals VMM
+ * 12) VMM verifies the memory contents to be same as written by guest in step
+ *    5 and updates the memory with a different pattern
+ * 13) Guest verifies the memory contents to be same as written in step 6.
+ */
+#define PSAWDAT_ID	7
+#define PSAWDAT_DESC	"PrivateSharedAccessWithoutDoubleAllocationTest"
+
+#define PSAWDAT_GUEST_SHARED_MEM_UPDATED1		1ULL
+#define PSAWDAT_GUEST_SHARED_MEM_UPDATED2		2ULL
+
+static bool psawdat_handle_vm_stage(struct kvm_vm *vm,
+			void *test_info,
+			uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+
+	switch (stage) {
+	case PSAWDAT_GUEST_SHARED_MEM_UPDATED1: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, test_mem_size),
+			"Shared memory view mismatch");
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared mem update Failure");
+		VM_STAGE_PROCESSED(PSAWDAT_GUEST_SHARED_MEM_UPDATED);
+		break;
+	}
+	case PSAWDAT_GUEST_SHARED_MEM_UPDATED2: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT3, test_mem_size),
+			"Shared memory view mismatch");
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT4, test_mem_size),
+			"Shared mem update Failure");
+		VM_STAGE_PROCESSED(PSAWDAT_GUEST_SHARED_MEM_UPDATED2);
+		break;
+	}
+	default:
+		printf("Unhandled VM stage %ld\n", stage);
+		return false;
+	}
+
+	return true;
+}
+
+static void psawdat_guest_code(void)
+{
+	void *test_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	const size_t mem_size = *((size_t *)MEM_SIZE_MMIO_ADDRESS);
+
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+
+	/* Map the GPA range to be treated as shared */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MAP_GPA_RANGE_DECRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	/* Mark the GPA range to be treated as always accessed via shared
+	 * access
+	 */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, 0, 0,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_SYNC(PSAWDAT_GUEST_SHARED_MEM_UPDATED1);
+
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+
+	/* Map the GPA range to be treated as private */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MAP_GPA_RANGE_ENCRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	/* Mark the GPA range to be treated as always accessed via private
+	 * access
+	 */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+
+	/* Map the GPA range to be treated as shared */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MAP_GPA_RANGE_DECRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	/* Mark the GPA range to be treated as always accessed via shared
+	 * access
+	 */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, 0, 0,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT3, mem_size));
+	GUEST_SYNC(PSAWDAT_GUEST_SHARED_MEM_UPDATED2);
+
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT4, mem_size));
+
+	GUEST_DONE();
+}
+
 static struct test_run_helper priv_memfd_testsuite[] = {
 	[PMPAT_ID] = {
 		.test_desc = PMPAT_DESC,
@@ -815,6 +962,13 @@ static struct test_run_helper priv_memfd_testsuite[] = {
 		.vmst_handler = pspahct_handle_vm_stage,
 		.guest_fn = pspahct_guest_code,
 	},
+	[PSAWDAT_ID] = {
+		.test_desc = PSAWDAT_DESC,
+		.vmst_handler = psawdat_handle_vm_stage,
+		.guest_fn = psawdat_guest_code,
+		.toggle_shared_mem_state = true,
+		.disallow_boot_shared_access = true,
+	},
 };
 
 static void handle_vm_exit_hypercall(struct kvm_run *run,
@@ -825,6 +979,10 @@ static void handle_vm_exit_hypercall(struct kvm_run *run,
 		priv_memfd_testsuite[test_id].priv_memfd;
 	int ret;
 	int fallocate_mode;
+	void *shared_mem = priv_memfd_testsuite[test_id].shared_mem;
+	bool toggle_shared_mem_state =
+		priv_memfd_testsuite[test_id].toggle_shared_mem_state;
+	int mprotect_mode;
 
 	if (run->hypercall.nr != KVM_HC_MAP_GPA_RANGE) {
 		TEST_FAIL("Unhandled Hypercall %lld\n",
@@ -842,11 +1000,13 @@ static void handle_vm_exit_hypercall(struct kvm_run *run,
 			gpa, npages);
 	}
 
-	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED)
+	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED) {
 		fallocate_mode = 0;
-	else {
+		mprotect_mode = PROT_NONE;
+	} else {
 		fallocate_mode = (FALLOC_FL_PUNCH_HOLE |
 			FALLOC_FL_KEEP_SIZE);
+		mprotect_mode = PROT_READ | PROT_WRITE;
 	}
 	pr_info("Converting off 0x%lx pages 0x%lx to %s\n",
 		(gpa - TEST_MEM_GPA), npages,
@@ -857,6 +1017,17 @@ static void handle_vm_exit_hypercall(struct kvm_run *run,
 		npages << MIN_PAGE_SHIFT);
 	TEST_ASSERT(ret != -1,
 		"fallocate failed in hc handling");
+	if (toggle_shared_mem_state) {
+		if (fallocate_mode) {
+			ret = madvise(shared_mem, test_mem_size,
+				MADV_DONTNEED);
+			TEST_ASSERT(ret != -1,
+				"madvise failed in hc handling");
+		}
+		ret = mprotect(shared_mem, test_mem_size, mprotect_mode);
+		TEST_ASSERT(ret != -1,
+			"mprotect failed in hc handling");
+	}
 	run->hypercall.ret = 0;
 }
 
@@ -867,7 +1038,11 @@ static void handle_vm_exit_memory_error(struct kvm_run *run,
 	int ret;
 	int priv_memfd =
 		priv_memfd_testsuite[test_id].priv_memfd;
+	void *shared_mem = priv_memfd_testsuite[test_id].shared_mem;
+	bool toggle_shared_mem_state =
+		priv_memfd_testsuite[test_id].toggle_shared_mem_state;
 	int fallocate_mode;
+	int mprotect_mode;
 
 	gpa = run->memory.gpa;
 	size = run->memory.size;
@@ -880,11 +1055,13 @@ static void handle_vm_exit_memory_error(struct kvm_run *run,
 			gpa, size);
 	}
 
-	if (flags & KVM_MEMORY_EXIT_FLAG_PRIVATE)
+	if (flags & KVM_MEMORY_EXIT_FLAG_PRIVATE) {
 		fallocate_mode = 0;
-	else {
+		mprotect_mode = PROT_NONE;
+	} else {
 		fallocate_mode = (FALLOC_FL_PUNCH_HOLE |
 				FALLOC_FL_KEEP_SIZE);
+		mprotect_mode = PROT_READ | PROT_WRITE;
 	}
 	pr_info("Converting off 0x%lx size 0x%lx to %s\n",
 		(gpa - TEST_MEM_GPA), size,
@@ -894,6 +1071,18 @@ static void handle_vm_exit_memory_error(struct kvm_run *run,
 		(gpa - TEST_MEM_GPA), size);
 	TEST_ASSERT(ret != -1,
 		"fallocate failed in memory error handling");
+
+	if (toggle_shared_mem_state) {
+		if (fallocate_mode) {
+			ret = madvise(shared_mem, test_mem_size,
+				MADV_DONTNEED);
+			TEST_ASSERT(ret != -1,
+				"madvise failed in memory error handling");
+		}
+		ret = mprotect(shared_mem, test_mem_size, mprotect_mode);
+		TEST_ASSERT(ret != -1,
+			"mprotect failed in memory error handling");
+	}
 }
 
 static void vcpu_work(struct kvm_vm *vm, uint32_t test_id)
@@ -924,14 +1113,14 @@ static void vcpu_work(struct kvm_vm *vm, uint32_t test_id)
 
 		if (run->exit_reason == KVM_EXIT_MMIO) {
 			if (run->mmio.phys_addr == MEM_SIZE_MMIO_ADDRESS) {
-				// tell the guest the size of the memory
-				// it's been allocated
+				/* tell the guest the size of the memory it's
+				 * been allocated
+				 */
 				int shift_amount = 0;
 
 				for (int i = 0; i < sizeof(uint64_t); ++i) {
-					run->mmio.data[i] =
-						(test_mem_size >>
-							shift_amount) & BYTE_MASK;
+					run->mmio.data[i] = (test_mem_size >>
+						shift_amount) & BYTE_MASK;
 					shift_amount += CHAR_BIT;
 				}
 			}
@@ -985,6 +1174,9 @@ static void setup_and_execute_test(uint32_t test_id,
 	int ret;
 	void *shared_mem;
 	struct kvm_enable_cap cap;
+	bool disallow_boot_shared_access =
+		priv_memfd_testsuite[test_id].disallow_boot_shared_access;
+	int prot_flags = PROT_READ | PROT_WRITE;
 
 	vm = vm_create_default(VCPU_ID, 0,
 				priv_memfd_testsuite[test_id].guest_fn);
@@ -1036,10 +1228,12 @@ static void setup_and_execute_test(uint32_t test_id,
 	// set global for mem size to use later
 	test_mem_size = mem_size;
 
+	if (disallow_boot_shared_access)
+		prot_flags = PROT_NONE;
+
 	/* Allocate shared memory */
 	shared_mem = mmap(NULL, mem_size,
-			PROT_READ | PROT_WRITE,
-			mmap_flags, -1, 0);
+			prot_flags, mmap_flags, -1, 0);
 	TEST_ASSERT(shared_mem != MAP_FAILED, "Failed to mmap() host");
 
 	if (using_hugepages) {
@@ -1166,7 +1360,8 @@ int main(int argc, char *argv[])
 
 	for (uint32_t i = 0; i < ARRAY_SIZE(priv_memfd_testsuite); i++) {
 		for (uint32_t j = 0; j < ARRAY_SIZE(page_size_matrix); j++) {
-			const struct page_combo current_page_matrix = page_size_matrix[j];
+			const struct page_combo current_page_matrix =
+							page_size_matrix[j];
 
 			if (should_skip_test(current_page_matrix,
 				use_2mb_pages, use_1gb_pages))
@@ -1174,8 +1369,10 @@ int main(int argc, char *argv[])
 			pr_info("=== Starting test %s... ===\n",
 					priv_memfd_testsuite[i].test_desc);
 			pr_info("using page sizes shared: %s private: %s\n",
-					page_size_to_str(current_page_matrix.shared),
-					page_size_to_str(current_page_matrix.private));
+					page_size_to_str(
+						current_page_matrix.shared),
+					page_size_to_str(
+						current_page_matrix.private));
 			hugepage_requirements_text(current_page_matrix);
 			setup_and_execute_test(i, current_page_matrix.shared,
 				current_page_matrix.private);
-- 
2.36.0.550.gb090851708-goog

