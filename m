Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EEF5B9175
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 02:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIOAF2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 20:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIOAFO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 20:05:14 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3AC175AE
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:05:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s16-20020a170902ea1000b00176cf52a348so11287644plg.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+j6ja5Y8ST1lkDCiHrGAifRKnD79hDMFlzwZSvjPxXQ=;
        b=QAWMMruvJue7fpk0q7rTxhmv1/nR3Btqv60serdgaAQxfhYBAxwMMmes1d1aDaLBMp
         QwMgBZ94purcmy+hVuYnwJv/mXEGJbfACNNBBaeL4luhK0ffVSg3oma2uevdZlV+kbqd
         OZVQZ92W6KmhRRWqfHKH1NCqhewjZ+PBclCtDjC4YakhZarYeaDdupySzq7VrwGUDPjN
         RBf8u9GsN7Gft1zyCdOgqtITbTQuFVWpSl7Yu/Mdojry7AB6EV14qiFPUcfPMwOHe9WN
         xtCWOkpfvaAFkuzTkIMgj7f91fUb7uaclz0xrypu7H7cR1qpBV3fPafl94OHMyDkUAU9
         Ve+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+j6ja5Y8ST1lkDCiHrGAifRKnD79hDMFlzwZSvjPxXQ=;
        b=zmBKQs/4xgYS090do8mk1e8KqqAE9eiAZwto4wsjHLD9YdBg1mdjunFADx1o/iY4UZ
         /lLYVHhv+KcGWnmPTOUhPb6++B5cA7HquKdibGD42l2ZntF4cTmwDGy9x5w69rayJ5FF
         NyXzJqrG6YqN/1qOH6NHYWdq8QRVz3bRKrbK46zlQUyNwCjxL7g+KqxZ4YcStpzbEAw8
         zGH2Hbu66D2BjXTmHZnwOrQm1fZOv93YdoOGbUppvHS7nWtmSBWVPF3uFtV/A5nuHoOR
         gSFpfao2aIZMQ7AZVAW0Q3iedX1fHU41eIEXgHRlIW63zbCc8ToemJciUpDrX8RKGOUg
         pSIw==
X-Gm-Message-State: ACrzQf3llPs927yDapt+tkLD+ea6iLmq1UnH4Z/lTevv1Tgx1WSLJjgT
        sIY+Sml6olljpqt/caBxWGLqHZgaOOvH07K1
X-Google-Smtp-Source: AMsMyM6lGW2/ydAIfjak7HAJ8xIaVLtWwyvqLD3KhxTIabn7lIHH9YeU5ohRTlyX27Z0FalUC+VoD/qjyrMbVsYr
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:903:2445:b0:178:38ee:70f with SMTP
 id l5-20020a170903244500b0017838ee070fmr1495757pls.164.1663200305003; Wed, 14
 Sep 2022 17:05:05 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:04:46 +0000
In-Reply-To: <20220915000448.1674802-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915000448.1674802-7-vannapurve@google.com>
Subject: [V2 PATCH 6/8] KVM: selftests: x86: Execute cpu specific hypercall
 from nested guests
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Execute vmcall/vmmcall from nested guests according to the cpu type.
This avoid exit to KVM which would anyway patch the hypercall
instruction according to the cpu type.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h      |  2 ++
 tools/testing/selftests/kvm/include/x86_64/vmx.h  |  9 ---------
 .../selftests/kvm/lib/x86_64/perf_test_util.c     |  2 +-
 .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 +++++++++++++++
 tools/testing/selftests/kvm/x86_64/smm_test.c     |  2 +-
 tools/testing/selftests/kvm/x86_64/state_test.c   |  8 ++++----
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c     |  2 +-
 .../kvm/x86_64/vmx_preemption_timer_test.c        |  2 +-
 8 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 0cbc71b7af50..18a8a6a2b786 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -833,6 +833,8 @@ void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3);
 
+void nested_guest_vmcall(void);
+
 void __vm_xsave_require_permission(int bit, const char *name);
 
 #define vm_xsave_require_permission(perm)	\
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 99fa1410964c..d8d4fd3353e5 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -480,15 +480,6 @@ static inline int vmresume(void)
 	return ret;
 }
 
-static inline void vmcall(void)
-{
-	/* Currently, L1 destroys our GPRs during vmexits.  */
-	__asm__ __volatile__("push %%rbp; vmcall; pop %%rbp" : : :
-			     "rax", "rbx", "rcx", "rdx",
-			     "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
-			     "r13", "r14", "r15");
-}
-
 static inline int vmread(uint64_t encoding, uint64_t *value)
 {
 	uint64_t tmp;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/perf_test_util.c b/tools/testing/selftests/kvm/lib/x86_64/perf_test_util.c
index 0f344a7c89c4..b420b35b7f45 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/perf_test_util.c
@@ -18,7 +18,7 @@
 void perf_test_l2_guest_code(uint64_t vcpu_id)
 {
 	perf_test_guest_code(vcpu_id);
-	vmcall();
+	nested_guest_vmcall();
 }
 
 extern char perf_test_l2_guest_entry[];
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c0ae938772f6..e12c8b543b8f 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1195,6 +1195,21 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 	return r;
 }
 
+void nested_guest_vmcall(void)
+{
+	/* Currently, L1 destroys our GPRs during vmexits.  */
+	if (is_amd_cpu())
+		__asm__ __volatile__("push %%rbp; vmmcall; pop %%rbp" : : :
+			     "rax", "rbx", "rcx", "rdx",
+			     "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
+			     "r13", "r14", "r15");
+	else
+		__asm__ __volatile__("push %%rbp; vmcall; pop %%rbp" : : :
+			     "rax", "rbx", "rcx", "rdx",
+			     "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
+			     "r13", "r14", "r15");
+}
+
 const struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
 {
 	static struct kvm_cpuid2 *cpuid;
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index 1f136a81858e..bf04c78c9c8e 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -61,7 +61,7 @@ static void l2_guest_code(void)
 
 	sync_with_host(10);
 
-	vmcall();
+	nested_guest_vmcall();
 }
 
 static void guest_code(void *arg)
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index ea578971fb9f..a9634c06dc60 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -26,10 +26,10 @@ void svm_l2_guest_code(void)
 {
 	GUEST_SYNC(4);
 	/* Exit to L1 */
-	vmcall();
+	nested_guest_vmcall();
 	GUEST_SYNC(6);
 	/* Done, exit to L1 and never come back.  */
-	vmcall();
+	nested_guest_vmcall();
 }
 
 static void svm_l1_guest_code(struct svm_test_data *svm)
@@ -57,7 +57,7 @@ void vmx_l2_guest_code(void)
 	GUEST_SYNC(6);
 
 	/* Exit to L1 */
-	vmcall();
+	nested_guest_vmcall();
 
 	/* L1 has now set up a shadow VMCS for us.  */
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
@@ -70,7 +70,7 @@ void vmx_l2_guest_code(void)
 	GUEST_SYNC(12);
 
 	/* Done, exit to L1 and never come back.  */
-	vmcall();
+	nested_guest_vmcall();
 }
 
 static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
index 2d8c23d639f7..fa24e69a806c 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
@@ -42,7 +42,7 @@ static void l2_guest_code(void)
 	GUEST_SYNC(false);
 
 	/* Exit to L1 and never come back.  */
-	vmcall();
+	nested_guest_vmcall();
 }
 
 void l1_guest_code(struct vmx_pages *vmx)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
index 0efdc05969a5..04bae6995344 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
@@ -38,7 +38,7 @@ void l2_guest_code(void)
 {
 	u64 vmx_pt_delta;
 
-	vmcall();
+	nested_guest_vmcall();
 	l2_vmx_pt_start = (rdtsc() >> vmx_pt_rate) << vmx_pt_rate;
 
 	/*
-- 
2.37.2.789.g6183377224-goog

