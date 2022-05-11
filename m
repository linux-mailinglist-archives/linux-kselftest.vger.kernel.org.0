Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DD4522839
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 02:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiEKAJQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 20:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbiEKAIk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 20:08:40 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4C66C9D
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:33 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r16-20020a17090b051000b001db302efed7so339109pjz.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+OvHhqt+M1RLlLwyc9HE0Jj3sR2gjcJo/jfqnOHXFtA=;
        b=pDdvYl4liRqjWSaJccStjWYwZZV9ExTf0TKOqyZH/a0lXvGR6JPGMutccbUkwXwEjC
         O0E455AAnVQY7wmeDgpPMRVSQqY6IVoeJ+ueNBr/Z/oRcAN325cjTiBBk282CDqXPreT
         0l/4xm6ztKCiAn+wELjc2d/8QVtDZFYdTl9Xf6omeAzXArKc9KkBQIyaVnoevwHXYCPE
         jIJ9BjoCoFX0eChwxxagIni3jDz/TL9XTEZ2OFclurVRhl67K2iqkxscPnSzF3fNhjBr
         f4yiTS6mDrLKN2PeRcezWbMlKgRNM37sHLWpgVhGbbSTTGYs8SrP/UILcgudfVFlgfQN
         VX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+OvHhqt+M1RLlLwyc9HE0Jj3sR2gjcJo/jfqnOHXFtA=;
        b=GJB79Io7vI1lMbzMhykKbFZeokOK7cjy6NBWJrefHiXM79vDCMBg1EKedfHSA2Xu0J
         7rp+7vDfJp1oraaseisJpvrfK0h2LQVZ5vtRd7ETE7cJIeOX9ukQTRoPhwRmZftqZSUG
         whM8dMsiOby2asxHzc1ZsEXJ2ysjC5NtroBzwo5RHoyvtncEsp/AP+bQ+hH5DR7iZQck
         yi/vMwng7+4uzsljet/dZ+zLP3BmMrLV4YptA1xRBYGgFW9fxNXhi3UMpfo3G+IYnT6U
         gy5Ri/XLIHq1DRjasPM/6k9LRe0W6v08igzuDDRvcYALciRV9+pXxgOMALDxA5vxf6FT
         n7fw==
X-Gm-Message-State: AOAM5308nylRqc+gZK9qQmHQLfCyPqQ5/I3NMk2ysFWg9yf82nCuZjSd
        Hrjr5X7AWjR1ifpMdRc3ZYDj3vrjYoeUlh3r
X-Google-Smtp-Source: ABdhPJxkoMI9iyLMP/Xf2UCY0LX57CH7UuCXvd7tBR3phxh4aQm7Y1+mJkCzCI+BwFYC/MJVg+Jsw2Eb7yRnd1t7
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:ecc2:b0:15e:9add:104c with SMTP
 id a2-20020a170902ecc200b0015e9add104cmr22970611plh.140.1652227712910; Tue,
 10 May 2022 17:08:32 -0700 (PDT)
Date:   Wed, 11 May 2022 00:08:07 +0000
In-Reply-To: <20220511000811.384766-1-vannapurve@google.com>
Message-Id: <20220511000811.384766-6-vannapurve@google.com>
Mime-Version: 1.0
References: <20220511000811.384766-1-vannapurve@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC V2 PATCH 5/8] selftests: kvm: Add implicit memory conversion tests
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests to exercise implicit memory conversion path.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/priv_memfd_test.c | 384 +++++++++++++++++-
 1 file changed, 383 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/priv_memfd_test.c b/tools/testing/selftests/kvm/priv_memfd_test.c
index 48bc4343e7b5..f6f6b064a101 100644
--- a/tools/testing/selftests/kvm/priv_memfd_test.c
+++ b/tools/testing/selftests/kvm/priv_memfd_test.c
@@ -211,6 +211,369 @@ static void pmsat_guest_code(void)
 	GUEST_DONE();
 }
 
+/* Test to verify guest shared accesses on shared memory with following steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM deallocates the backing private memory and populates the shared memory
+ *    with known pattern and continues guest execution.
+ * 3) Guest reads shared gpa range in a shared fashion and verifies that it
+ *    reads what VMM has written in step2.
+ * 3) Guest writes a different pattern on the shared memory and signals VMM
+ *      that it has updated the shared memory.
+ * 4) VMM verifies shared memory contents to be same as the data populated
+ *      in step 3 and continues guest execution.
+ */
+#define SMSAT_ID				2
+#define SMSAT_DESC				"SharedMemorySharedAccessTest"
+
+#define SMSAT_GUEST_STARTED			0ULL
+#define SMSAT_GUEST_TEST_MEM_UPDATED		1ULL
+
+static bool smsat_handle_vm_stage(struct kvm_vm *vm,
+			void *test_info,
+			uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+	int priv_memfd = ((struct test_run_helper *)test_info)->priv_memfd;
+
+	switch (stage) {
+	case SMSAT_GUEST_STARTED: {
+		/* Remove the backing private memory storage */
+		int ret = fallocate(priv_memfd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				0, TEST_MEM_SIZE);
+		TEST_ASSERT(ret != -1,
+			"fallocate failed in smsat handling");
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			"Shared memory updated failed");
+		VM_STAGE_PROCESSED(SMSAT_GUEST_STARTED);
+		break;
+	}
+	case SMSAT_GUEST_TEST_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(SMSAT_GUEST_TEST_MEM_UPDATED);
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
+static void smsat_guest_code(void)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+
+	GUEST_SYNC(SMSAT_GUEST_STARTED);
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+
+	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+	GUEST_SYNC(SMSAT_GUEST_TEST_MEM_UPDATED);
+
+	GUEST_DONE();
+}
+
+/* Test to verify guest private accesses on shared memory with following steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM deallocates the backing private memory and populates the shared memory
+ *    with known pattern and continues guest execution.
+ * 3) Guest writes gpa range via private access and signals VMM.
+ * 4) VMM verifies shared memory contents to be same as the data populated
+ *    in step 2 and continues guest execution.
+ * 5) Guest reads gpa range via private access and verifies that the contents
+ *    are same as written in step 3.
+ */
+#define SMPAT_ID				3
+#define SMPAT_DESC				"SharedMemoryPrivateAccessTest"
+
+#define SMPAT_GUEST_STARTED			0ULL
+#define SMPAT_GUEST_TEST_MEM_UPDATED		1ULL
+
+static bool smpat_handle_vm_stage(struct kvm_vm *vm,
+			void *test_info,
+			uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+	int priv_memfd = ((struct test_run_helper *)test_info)->priv_memfd;
+
+	switch (stage) {
+	case SMPAT_GUEST_STARTED: {
+		/* Remove the backing private memory storage */
+		int ret = fallocate(priv_memfd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				0, TEST_MEM_SIZE);
+		TEST_ASSERT(ret != -1,
+			"fallocate failed in smpat handling");
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			"Shared memory updated failed");
+		VM_STAGE_PROCESSED(SMPAT_GUEST_STARTED);
+		break;
+	}
+	case SMPAT_GUEST_TEST_MEM_UPDATED: {
+		/* verify data to be same as what vmm wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(SMPAT_GUEST_TEST_MEM_UPDATED);
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
+static void smpat_guest_code(void)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	GUEST_SYNC(SMPAT_GUEST_STARTED);
+
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+	GUEST_SYNC(SMPAT_GUEST_TEST_MEM_UPDATED);
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+
+	GUEST_DONE();
+}
+
+/* Test to verify guest shared and private accesses on memory with following
+ * steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM populates the shared memory with known pattern and continues guest
+ *    execution.
+ * 3) Guest writes shared gpa range in a private fashion and signals VMM
+ * 4) VMM verifies that shared memory still contains the pattern written in
+ *    step 2 and continues guest execution.
+ * 5) Guest verifies private memory contents to be same as the data populated
+ *    in step 3 and signals VMM.
+ * 6) VMM removes the private memory backing which should also clear out the
+ *    second stage mappings for the VM
+ * 6) Guest does shared write access on shared memory and signals vmm
+ * 7) VMM reads the shared memory and verifies that the data is same as what
+ *    guest wrote in step 6 and continues guest execution.
+ * 8) Guest reads the private memory and verifies that the data is same as
+ *    written in step 6.
+ */
+#define PSAT_ID			4
+#define PSAT_DESC		"PrivateSharedAccessTest"
+
+#define PSAT_GUEST_STARTED			0ULL
+#define PSAT_GUEST_PRIVATE_MEM_UPDATED		1ULL
+#define PSAT_GUEST_PRIVATE_MEM_VERIFIED		2ULL
+#define PSAT_GUEST_SHARED_MEM_UPDATED		3ULL
+
+static bool psat_handle_vm_stage(struct kvm_vm *vm,
+			void *test_info,
+			uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+	int priv_memfd = ((struct test_run_helper *)test_info)->priv_memfd;
+
+	switch (stage) {
+	case PSAT_GUEST_STARTED: {
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			"Shared memory update failed");
+		VM_STAGE_PROCESSED(PSAT_GUEST_STARTED);
+		break;
+	}
+	case PSAT_GUEST_PRIVATE_MEM_UPDATED: {
+		/* verify data to be same as what vmm wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSAT_GUEST_PRIVATE_MEM_UPDATED);
+		break;
+	}
+	case PSAT_GUEST_PRIVATE_MEM_VERIFIED: {
+		/* Remove the backing private memory storage so that
+		 * subsequent accesses from guest cause a second stage
+		 * page fault
+		 */
+		int ret = fallocate(priv_memfd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				0, TEST_MEM_SIZE);
+		TEST_ASSERT(ret != -1,
+			"fallocate failed in smpat handling");
+		VM_STAGE_PROCESSED(PSAT_GUEST_PRIVATE_MEM_VERIFIED);
+		break;
+	}
+	case PSAT_GUEST_SHARED_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSAT_GUEST_SHARED_MEM_UPDATED);
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
+static void psat_guest_code(void)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	GUEST_SYNC(PSAT_GUEST_STARTED);
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+	GUEST_SYNC(PSAT_GUEST_PRIVATE_MEM_UPDATED);
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+
+	GUEST_SYNC(PSAT_GUEST_PRIVATE_MEM_VERIFIED);
+
+	/* Mark no GPA range to be treated as accessed privately */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, 0,
+		0, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+	GUEST_SYNC(PSAT_GUEST_SHARED_MEM_UPDATED);
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+
+	GUEST_DONE();
+}
+
+/* Test to verify guest shared and private accesses on memory with following
+ * steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM removes the private memory backing and populates the shared memory
+ *    with known pattern and continues guest execution.
+ * 3) Guest reads shared gpa range in a shared fashion and verifies that it
+ *    reads what VMM has written in step2.
+ * 4) Guest writes a different pattern on the shared memory and signals VMM
+ *      that it has updated the shared memory.
+ * 5) VMM verifies shared memory contents to be same as the data populated
+ *      in step 4 and installs private memory backing again to allow guest
+ *      to do private access and invalidate second stage mappings.
+ * 6) Guest does private write access on shared memory and signals vmm
+ * 7) VMM reads the shared memory and verified that the data is still same
+ *    as in step 4 and continues guest execution.
+ * 8) Guest reads the private memory and verifies that the data is same as
+ *    written in step 6.
+ */
+#define SPAT_ID					5
+#define SPAT_DESC				"SharedPrivateAccessTest"
+
+#define SPAT_GUEST_STARTED			0ULL
+#define SPAT_GUEST_SHARED_MEM_UPDATED		1ULL
+#define SPAT_GUEST_PRIVATE_MEM_UPDATED		2ULL
+
+static bool spat_handle_vm_stage(struct kvm_vm *vm,
+			void *test_info,
+			uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+	int priv_memfd = ((struct test_run_helper *)test_info)->priv_memfd;
+
+	switch (stage) {
+	case SPAT_GUEST_STARTED: {
+		/* Remove the backing private memory storage so that
+		 * subsequent accesses from guest cause a second stage
+		 * page fault
+		 */
+		int ret = fallocate(priv_memfd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				0, TEST_MEM_SIZE);
+		TEST_ASSERT(ret != -1,
+			"fallocate failed in spat handling");
+
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			"Shared memory updated failed");
+		VM_STAGE_PROCESSED(SPAT_GUEST_STARTED);
+		break;
+	}
+	case SPAT_GUEST_SHARED_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		/* Allocate memory for private backing store */
+		int ret = fallocate(priv_memfd,
+				0, 0, TEST_MEM_SIZE);
+		TEST_ASSERT(ret != -1,
+			"fallocate failed in spat handling");
+		VM_STAGE_PROCESSED(SPAT_GUEST_SHARED_MEM_UPDATED);
+		break;
+	}
+	case SPAT_GUEST_PRIVATE_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(SPAT_GUEST_PRIVATE_MEM_UPDATED);
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
+static void spat_guest_code(void)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	GUEST_SYNC(SPAT_GUEST_STARTED);
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+	GUEST_SYNC(SPAT_GUEST_SHARED_MEM_UPDATED);
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+	GUEST_SYNC(PSAT_GUEST_PRIVATE_MEM_UPDATED);
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+	GUEST_DONE();
+}
+
 static struct test_run_helper priv_memfd_testsuite[] = {
 	[PMPAT_ID] = {
 		.test_desc = PMPAT_DESC,
@@ -222,6 +585,26 @@ static struct test_run_helper priv_memfd_testsuite[] = {
 		.vmst_handler = pmsat_handle_vm_stage,
 		.guest_fn = pmsat_guest_code,
 	},
+	[SMSAT_ID] = {
+		.test_desc = SMSAT_DESC,
+		.vmst_handler = smsat_handle_vm_stage,
+		.guest_fn = smsat_guest_code,
+	},
+	[SMPAT_ID] = {
+		.test_desc = SMPAT_DESC,
+		.vmst_handler = smpat_handle_vm_stage,
+		.guest_fn = smpat_guest_code,
+	},
+	[PSAT_ID] = {
+		.test_desc = PSAT_DESC,
+		.vmst_handler = psat_handle_vm_stage,
+		.guest_fn = psat_guest_code,
+	},
+	[SPAT_ID] = {
+		.test_desc = SPAT_DESC,
+		.vmst_handler = spat_handle_vm_stage,
+		.guest_fn = spat_guest_code,
+	},
 };
 
 static void handle_vm_exit_hypercall(struct kvm_run *run,
@@ -365,7 +748,6 @@ static void priv_memory_region_add(struct kvm_vm *vm, void *mem, uint32_t slot,
 		guest_addr);
 }
 
-/* Do private access to the guest's private memory */
 static void setup_and_execute_test(uint32_t test_id)
 {
 	struct kvm_vm *vm;
-- 
2.36.0.550.gb090851708-goog

