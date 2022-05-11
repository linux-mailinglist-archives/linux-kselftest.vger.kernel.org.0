Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB3522838
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 02:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbiEKAJN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbiEKAIl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 20:08:41 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81865207925
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:36 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id b10-20020a170902bd4a00b0015e7ee90842so164723plx.8
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xt6DblK/5Mc6y+G7wnyMgG6W7K9OB1zLu8lmSnC6BmA=;
        b=s7DCNPxAkIoe7rjo5twbzJaNF4Ge/oZxzkng81sloIIe4mURDY/NbjwUJUxHLo0wBH
         32Yvo7V45ahXwikJNl6C8yHAniozumjVaWzwNhrq2KAwAtH+n9dy3w5Qs7hzZUeGHmO3
         BqOvl+EZyihh+Jt2n8rtS3ttsbTX8gwCOOO5dWOOKAZ5cEO/KNCd5FCcvQRx1z4km0CP
         6Uv2CfRX5Z7EiXiJlN0t/BLZ1h6tZrkhBiNRrPOQK+HthMXHR8t5X/Az2Ufr5m9RewBP
         YbQsxR7VpTb7wOuf88nfdEFeDCRBSJzlcyVrIQUyYULdaDIWkQnvGQHuNF/Z0QlBPpja
         RTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xt6DblK/5Mc6y+G7wnyMgG6W7K9OB1zLu8lmSnC6BmA=;
        b=d7zuVUUkpVzvROmgixo+6QYyvffnUUS1SEGuY5zv4cWmJTTf3kesDg1LriJKuBNTfS
         JKzhwEIMd4GMD/xzy0ONtSSWrih8Y/LSaq7E/DKeRjKHU6vBa/hoiU978p5/hVCD593V
         3wEdEx7zG8urfol7XKFWBh7Ti3foyGR3FaG1T41mnzmAh5ltKpSJp3elhlX8gpbmc0Oh
         gy2SG7tU+EBtcJbtLcJGIc8UOpFKBwBbHXX87gp6YQU3m8TD2eLAkLwKKjqGQDutgbTM
         QXDUIVE1We5aJCsqu+0ajA4DHl7byS4bLXK1t+8Dr7KeaOJBb5kUFoQAlMlQdyl56Iio
         Yiow==
X-Gm-Message-State: AOAM531tG76gDdkOuL3FtNoEtFJJsS8R8DreRu1TCP8BUgy2ows6wrkr
        OShNuTCL3R2P5DELKbI5RFBpL2D0To6UPtqE
X-Google-Smtp-Source: ABdhPJwbj7MHfhMRq9CoUYw1eK/wvuJckUiIb8665/USZ+RSGQ888NUKRDhrIF1c7BL4wmnzAYfq9HXrbf4W5Kh7
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:8d83:b0:1dd:258c:7c55 with SMTP
 id d3-20020a17090a8d8300b001dd258c7c55mr55621pjo.1.1652227715196; Tue, 10 May
 2022 17:08:35 -0700 (PDT)
Date:   Wed, 11 May 2022 00:08:08 +0000
In-Reply-To: <20220511000811.384766-1-vannapurve@google.com>
Message-Id: <20220511000811.384766-7-vannapurve@google.com>
Mime-Version: 1.0
References: <20220511000811.384766-1-vannapurve@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC V2 PATCH 6/8] selftests: kvm: Add KVM_HC_MAP_GPA_RANGE hypercall test
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

Add test to exercise explicit memory conversion path using
KVM_HC_MAP_GPA_RANGE hypercall.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/priv_memfd_test.c | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/tools/testing/selftests/kvm/priv_memfd_test.c b/tools/testing/selftests/kvm/priv_memfd_test.c
index f6f6b064a101..c2ea8f67337c 100644
--- a/tools/testing/selftests/kvm/priv_memfd_test.c
+++ b/tools/testing/selftests/kvm/priv_memfd_test.c
@@ -574,6 +574,149 @@ static void spat_guest_code(void)
 	GUEST_DONE();
 }
 
+/* Test to verify guest private, shared, private accesses on memory with
+ * following steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM initializes the shared memory with known pattern and continues guest
+ *    execution
+ * 3) Guest writes the private memory privately via a known pattern and
+ *    signals VMM
+ * 4) VMM reads the shared memory and verifies that it's same as whats written
+ *    in step 2 and continues guest execution
+ * 5) Guest reads the private memory privately and verifies that the contents
+ *    are same as written in step 3.
+ * 6) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as shared
+ *    and marks the range to be accessed via shared access.
+ * 7) Guest does a shared access to shared memory and verifies that the
+ *    contents are same as written in step 2.
+ * 8) Guest writes known pattern to test memory and signals VMM.
+ * 9) VMM verifies the memory contents to be same as written by guest in step
+ *    8
+ * 10) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as private
+ *    and marks the range to be accessed via private access.
+ * 11) Guest writes a known pattern to the test memory and signals VMM.
+ * 12) VMM verifies the memory contents to be same as written by guest in step
+ *     8 and continues guest execution.
+ * 13) Guest verififes the memory pattern to be same as written in step 11.
+ */
+#define PSPAHCT_ID		6
+#define PSPAHCT_DESC		"PrivateSharedPrivateAccessHyperCallTest"
+
+#define PSPAHCT_GUEST_STARTED				0ULL
+#define PSPAHCT_GUEST_PRIVATE_MEM_UPDATED		1ULL
+#define PSPAHCT_GUEST_SHARED_MEM_UPDATED		2ULL
+#define PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2		3ULL
+
+static bool pspahct_handle_vm_stage(struct kvm_vm *vm,
+			void *test_info,
+			uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+
+	switch (stage) {
+	case PSPAHCT_GUEST_STARTED: {
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			"Shared memory update failed");
+		VM_STAGE_PROCESSED(PSPAHCT_GUEST_STARTED);
+		break;
+	}
+	case PSPAHCT_GUEST_PRIVATE_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED);
+		break;
+	}
+	case PSPAHCT_GUEST_SHARED_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSPAHCT_GUEST_SHARED_MEM_UPDATED);
+		break;
+	}
+	case PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2);
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
+static void pspahct_guest_code(void)
+{
+	void *test_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	GUEST_SYNC(PSPAHCT_GUEST_STARTED);
+
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
+		TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+
+	GUEST_SYNC(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED);
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+
+	/* Map the GPA range to be treated as shared */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
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
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+	GUEST_SYNC(PSPAHCT_GUEST_SHARED_MEM_UPDATED);
+
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+
+	/* Map the GPA range to be treated as private */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		KVM_MAP_GPA_RANGE_ENCRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	/* Mark the GPA range to be treated as always accessed via private
+	 * access
+	 */
+	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(ret == 0, ret);
+
+	GUEST_ASSERT(do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+	GUEST_SYNC(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2);
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+	GUEST_DONE();
+}
+
 static struct test_run_helper priv_memfd_testsuite[] = {
 	[PMPAT_ID] = {
 		.test_desc = PMPAT_DESC,
@@ -605,6 +748,11 @@ static struct test_run_helper priv_memfd_testsuite[] = {
 		.vmst_handler = spat_handle_vm_stage,
 		.guest_fn = spat_guest_code,
 	},
+	[PSPAHCT_ID] = {
+		.test_desc = PSPAHCT_DESC,
+		.vmst_handler = pspahct_handle_vm_stage,
+		.guest_fn = pspahct_guest_code,
+	},
 };
 
 static void handle_vm_exit_hypercall(struct kvm_run *run,
-- 
2.36.0.550.gb090851708-goog

