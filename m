Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0252283C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiEKAJX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 20:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbiEKAIj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 20:08:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A826060DA2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:31 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z34-20020a056a001da200b0050e057fdd7eso241105pfw.12
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wLjvVbIdoRCH49YCihnoSmA9ubv4t2s+xqBSCz7F9jg=;
        b=Ki3eaTjsQ7M5NE3TLT5tuYldDGfIk2buuSWB26+3w04czbg6Ph679zSyiiZgtT9PQs
         6chWf7oec2aK+bxvv3wEI653g/J5vu6EkLMuyK1wYj3x1tTeDby0vt6KjCQvEFwUIBH6
         ut043eELAUSze7vzZH+uxRVRXoRZFSZuFvoMuWscyNgr/3bM6OtHGPWEXelTgJauaNk+
         nBcCnvg+3SPAcI2O7dVVV3wQPahjvvLidqndO5FdjzqXtuFuRteNvFVbzjClCWZza/us
         AILv/Sr51khSNwawZts3gpqxwMCWbPAm0liWiAInJ/kTt3VltafGCej6wxxvpmkL1Isn
         jn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wLjvVbIdoRCH49YCihnoSmA9ubv4t2s+xqBSCz7F9jg=;
        b=KDWPBNFGWcAKoAYVJKVOpdMdGOKxUsvwuvx8t6/BJ21PLMOjxTaV9fnbhuXlzBumng
         LAkNl7GbJ8oObuuO/GBkJ6tsEynNzzEMGvdWmA0krdZN5OoJZPphhuF7B8NxNbksifui
         GCLm2/bLLXX1rv60WiYWnxFMemWrJmnB8r1rPqGjfVQaTJ3JclSrUlfkhCa0t8AguXWA
         v92UyUqDGmS4Az5s2lAXS/5mYpjX5ukFlk8spqB9jxwaXAGcSi6ioWyEKXlqzl2cpOcX
         qKx8H7sJ4itk6ttwKctbDJIeMVr5YyKEfXU0kJq9Qi3edhr/w+nEILnXWx81sXAII7AI
         ChaQ==
X-Gm-Message-State: AOAM531Jl2to3v4Y6J/bcNDXdZoETQU0eCiauS2RoNNytWsfBcNA6st9
        kSu01cdXGu/K0SppPYYJAvFwNp62hHX0g+Ff
X-Google-Smtp-Source: ABdhPJzVAtm2BkSdXZuq4Ku3XaizDmU0qHSs3QkXhQaKqeH6miipiHUsyaTDTE95H36auWRbhZrpMBywulp15kHC
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:e510:b0:1d9:ee23:9fa1 with SMTP
 id t16-20020a17090ae51000b001d9ee239fa1mr55560pjy.0.1652227710272; Tue, 10
 May 2022 17:08:30 -0700 (PDT)
Date:   Wed, 11 May 2022 00:08:06 +0000
In-Reply-To: <20220511000811.384766-1-vannapurve@google.com>
Message-Id: <20220511000811.384766-5-vannapurve@google.com>
Mime-Version: 1.0
References: <20220511000811.384766-1-vannapurve@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC V2 PATCH 4/8] selftests: kvm: priv_memfd_test: Add shared access test
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

Add a test to access private memory in shared fashion
which should exercise implicit memory conversion path
using KVM_EXIT_MEMORY_ERROR.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/priv_memfd_test.c | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/kvm/priv_memfd_test.c b/tools/testing/selftests/kvm/priv_memfd_test.c
index 55e24c893b07..48bc4343e7b5 100644
--- a/tools/testing/selftests/kvm/priv_memfd_test.c
+++ b/tools/testing/selftests/kvm/priv_memfd_test.c
@@ -147,12 +147,81 @@ static void pmpat_guest_code(void)
 	GUEST_DONE();
 }
 
+/* Test to verify guest shared accesses on private memory with following steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM populates the shared memory with known pattern and continues guest
+ *    execution.
+ * 3) Guest reads private gpa range in a shared fashion and verifies that it
+ *    reads what VMM has written in step2.
+ * 3) Guest writes a different pattern on the shared memory and signals VMM
+ *      that it has updated the shared memory.
+ * 4) VMM verifies shared memory contents to be same as the data populated
+ *      in step 3 and continues guest execution.
+ */
+#define PMSAT_ID				1
+#define PMSAT_DESC				"PrivateMemorySharedAccessTest"
+
+/* Guest code execution stages for private mem access test */
+#define PMSAT_GUEST_STARTED			0ULL
+#define PMSAT_GUEST_TEST_MEM_UPDATED		1ULL
+
+static bool pmsat_handle_vm_stage(struct kvm_vm *vm,
+			void *test_info,
+			uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+
+	switch (stage) {
+	case PMSAT_GUEST_STARTED: {
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
+			"Shared memory update failed");
+		VM_STAGE_PROCESSED(PMSAT_GUEST_STARTED);
+		break;
+	}
+	case PMSAT_GUEST_TEST_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PMSAT_GUEST_TEST_MEM_UPDATED);
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
+static void pmsat_guest_code(void)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+
+	GUEST_SYNC(PMSAT_GUEST_STARTED);
+	GUEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE));
+
+	GUEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
+	GUEST_SYNC(PMSAT_GUEST_TEST_MEM_UPDATED);
+
+	GUEST_DONE();
+}
+
 static struct test_run_helper priv_memfd_testsuite[] = {
 	[PMPAT_ID] = {
 		.test_desc = PMPAT_DESC,
 		.vmst_handler = pmpat_handle_vm_stage,
 		.guest_fn = pmpat_guest_code,
 	},
+	[PMSAT_ID] = {
+		.test_desc = PMSAT_DESC,
+		.vmst_handler = pmsat_handle_vm_stage,
+		.guest_fn = pmsat_guest_code,
+	},
 };
 
 static void handle_vm_exit_hypercall(struct kvm_run *run,
-- 
2.36.0.550.gb090851708-goog

