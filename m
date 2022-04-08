Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB044F9ED1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 23:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiDHVI2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 17:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbiDHVIK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 17:08:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A213CEFF
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 14:06:05 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id rm11-20020a17090b3ecb00b001c713925e58so8412422pjb.6
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4zsOaGoqxi5u8VVnNDFHZKxvAZS+RzVtuUFsffUUaGY=;
        b=JXLMkRS6JvIurR1ovHjYoZO2eSr4rOolTQWaY3+SzZUiP6Ub/2PveOAlWSzfq4VsNm
         4vLNloLowvGCB2fVvUbo1hVchL+aQd7NmdyHAsblXwunuqvXyvxKMxuuWFSUqdX6EiPG
         Npqog9MAPyGM9raiDtXv7Yi22unJsCuHoOWFtd8gxpYpffl2IRj4S5GrEnuvLRnDoVPH
         XpnuRYmpf+HQuPQN+9dX5vrJJeDHsD4UCFnkBXwcagjwSNsPu+vCiN4eYtirqv53S7fc
         z6x2YcLJ/uj6DLtjk1Xa+lHssjjp0HylnGiQClroP+Lzi+mM8+yTEqf9GKNjC+ZtYkOr
         VCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4zsOaGoqxi5u8VVnNDFHZKxvAZS+RzVtuUFsffUUaGY=;
        b=EJNL8RvpVCSoyis7oR5OKG79wjvZKbJKUJMo5KCEgdyTFxj2vPBCU5j6h8Rz+PYDpG
         6lwWAKWCTU4QdLqRXwUCjNLKhOYao80sLMXqX1P+JjH+k1OEkRfYxb+HwVjp3KAWsTP+
         ypIcMJk4346jl3+Y8L3g4F9YJ5MLMBalQ7xJaeXmGCBRwUzD1L3u3XM0EDbAnTM4nP9X
         0Wh+wjDRaui/q4uwoUrE6lC7z9rEFQwxC22q7OSLWa2/hxgABQdftksRDe+8HNY/Tfuo
         bP/7Z8+J1olxJGzBRDjE2ELusxdv3f7Kb7CsuLEK+u69eDEyrlSywgrNKnyM+aaKcuUV
         kh8g==
X-Gm-Message-State: AOAM533Un5Ysjbjsp9JmnTysXiYlz7fwreGiBT02sjQIwG52HUW3E7sh
        AIygin74Ne4sBXmwjg1E50C0D9QGbyccJ8bw
X-Google-Smtp-Source: ABdhPJxpiNMh3TIWz6tVEMCHA/ekNoUBOfzl+LYpi/yUPlJpNr7M5OLqAuI4cHyRkKTibbaTwiiYk99gwpeL6KnX
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:d511:b0:157:1304:e79e with SMTP
 id b17-20020a170902d51100b001571304e79emr8597077plg.100.1649451964891; Fri,
 08 Apr 2022 14:06:04 -0700 (PDT)
Date:   Fri,  8 Apr 2022 21:05:45 +0000
In-Reply-To: <20220408210545.3915712-1-vannapurve@google.com>
Message-Id: <20220408210545.3915712-6-vannapurve@google.com>
Mime-Version: 1.0
References: <20220408210545.3915712-1-vannapurve@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [RFC V1 PATCH 5/5] selftests: kvm: priv_memfd_test: Add shared access test
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
        pgonda@google.com, seanjc@google.com, diviness@google.com,
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

Add a test to access private memory in shared fashion
which should exercise implicit memory conversion path
using KVM_EXIT_MEMORY_ERROR.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/priv_memfd_test.c | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/kvm/priv_memfd_test.c b/tools/testing/selftests/kvm/priv_memfd_test.c
index 0e6c19501f27..607fdc149c7d 100644
--- a/tools/testing/selftests/kvm/priv_memfd_test.c
+++ b/tools/testing/selftests/kvm/priv_memfd_test.c
@@ -121,12 +121,78 @@ static void pmpat_guest_code(void)
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
+		memset(shared_mem, SHARED_MEM_DATA_BYTE, TEST_MEM_SIZE);
+		VM_STAGE_PROCESSED(PMSAT_GUEST_STARTED);
+		break;
+	}
+	case PMSAT_GUEST_TEST_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote */
+		TEST_ASSERT(verify_byte_pattern(shared_mem,
+			PRIV_MEM_DATA_BYTE, TEST_MEM_SIZE),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PMSAT_GUEST_PRIV_MEM_UPDATED);
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
+	GUEST_ASSERT(verify_byte_pattern(shared_mem,
+			SHARED_MEM_DATA_BYTE, TEST_MEM_SIZE));
+
+	memset(shared_mem, PRIV_MEM_DATA_BYTE, TEST_MEM_SIZE);
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
2.35.1.1178.g4f1659d476-goog

