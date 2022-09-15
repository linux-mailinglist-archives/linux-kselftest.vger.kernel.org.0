Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295C5B917A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 02:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIOAFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 20:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIOAFS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 20:05:18 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605681901C
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:05:08 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r13-20020a635d0d000000b004344bb3de1bso8122619pgb.12
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=EMYMZKY/iGQIa3JbZzMfxs2+dRoXVRV6AgQCLEGivNg=;
        b=SKQoQmMvyzj6768UP8KES0UGW6Xnv8ko48tcNOa6IbyMbxEl0YhsbKvyqMLfnSaKfl
         deamK916iD3NTrVLtCTkm12Mv7J4/xB1kIrgbMi9hhIffdeFRoCzrWSIQYxOSIrpdqDy
         FAFvWUQ75HUlqniZBOVcm6JWob7h/iMO5UG3XpEMd6rsI9Ys+aKQn5rIo/oz57fi8U5q
         7baFSeo3wuk/mDAvJr83FVxbC3b9OrDhqZ/d+A21HRcKBJ2Cp+Xi4YswGI6HDC1XEvrJ
         kC0iT1x24CvvdmzG1pH8lV3gvkiYgvegubznE1s69M3M7DSi2owSwCB7NxRTWudJzuEA
         CCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=EMYMZKY/iGQIa3JbZzMfxs2+dRoXVRV6AgQCLEGivNg=;
        b=Cka36ro5RfRLBK/iBBAcGDvVQYYghMdztfOh/dZmWYNOV4XT3VJM7c0MB1/M4WR7Cg
         UO5PnBZbCuc5ni+yakxKIBPpqXAnDg9zdpy/0XtSvKt8iWGVPwwizkkVphKZl2iCnsCX
         Po38W8V7gXbFP/sORs7HpxqtrhW9Du9Bvejc/qO5eYzr2/v4ug7F7+6PssP6fid8YddX
         HdAdrI64voJ1VEaFk6WApHKFGvyIriNBr35aqCt/MGa1QLhR5e/OwCPf2Q3F4zdyTZXN
         KAHAoaOecRRbgLzdMgRE1CIN9fJTliWqxl4HCA72Du9EzhIuHtJl8Ewp+Wca9Qv0j/S7
         HKVQ==
X-Gm-Message-State: ACgBeo3TUzZJgJ9JxlPoCwnOw20NBl702nxkR6VR4rtb088SPN7IPpzz
        RXUcuFiixeml1XWmaP7Tk3VODOhIGuIZgIsa
X-Google-Smtp-Source: AA6agR7/1ZFORcwZpWMCn29kzEp4zuJU5BpWSxKndEtwG7dvrtDU8Qy27Oa7QgaBUKG4z97q+TmmbVu7qdC22psN
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a63:8843:0:b0:439:3c8e:c2c0 with SMTP
 id l64-20020a638843000000b004393c8ec2c0mr9651931pgd.404.1663200307191; Wed,
 14 Sep 2022 17:05:07 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:04:47 +0000
In-Reply-To: <20220915000448.1674802-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915000448.1674802-8-vannapurve@google.com>
Subject: [V2 PATCH 7/8] Kvm: selftests: x86: Execute cpu specific vmcall instruction
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update the vmcall instruction invocation to happen according to the cpu
type.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h    | 8 ++++++++
 tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c | 2 +-
 .../selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c    | 2 +-
 tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c  | 2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 18a8a6a2b786..74893a7a80f8 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -833,6 +833,14 @@ void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3);
 
+/*
+ * Execute vmcall instruction.
+ */
+static inline void vmcall(void)
+{
+	kvm_hypercall(0, 0, 0, 0, 0);
+}
+
 void nested_guest_vmcall(void);
 
 void __vm_xsave_require_permission(int bit, const char *name);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
index 5abecf06329e..8180711c8684 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
@@ -31,7 +31,7 @@
 static void l2_guest_code(void)
 {
 	/* Exit to L1 */
-	__asm__ __volatile__("vmcall");
+	vmcall();
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index 465a9434d61c..37da9d01d5d6 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -76,7 +76,7 @@ static void l2_guest_code(void)
 	check_tsc_freq(UCHECK_L2);
 
 	/* exit to L1 */
-	__asm__ __volatile__("vmcall");
+	vmcall();
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 5943187e8594..00192f564d9b 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -74,7 +74,7 @@ static void l2_guest_code(void)
 	check_ia32_tsc_adjust(-2 * TSC_ADJUST_VALUE);
 
 	/* Exit to L1 */
-	__asm__ __volatile__("vmcall");
+	vmcall();
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
-- 
2.37.2.789.g6183377224-goog

