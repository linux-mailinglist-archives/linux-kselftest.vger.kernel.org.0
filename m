Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB36549AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 01:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiLWAOt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 19:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiLWAO3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 19:14:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553E2CC99
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i65-20020a25d144000000b0074dd0da5b01so3529318ybg.7
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg/JgGzimgcKVfqgQO+cUvnCvql5iWRhml8JYXpDmXI=;
        b=sKa9lZOuyXiASyHL4kp9hKmVWR3zOuZrETb1wLibzqRJxzfzbNiXmD3S/Ng64NhoIV
         dG0JMir7Cp6iNktQKkX5sBYxyju/rlNqCnClo9LzUHp/AWgs2Rqw4X/ISUkosL7Vk3hF
         vOtpWhHppffPQzTZWm8ePcCZB4Mg0y1R3GLScM3UVXHIb1oriQz3rC37vJh6KSbT9dk9
         QwVio4xoJMLgsmYL9wa/th4KU9kK7Ifj82VKjZ6iiKgfpicNUasXw2+pT10Imdo1LYz6
         RsxZ4cYzbTWlVUGCpcI+kuwa0buaX4maiwjQf007tXO124EPcBnjuFRyKclaij46vGZJ
         GmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg/JgGzimgcKVfqgQO+cUvnCvql5iWRhml8JYXpDmXI=;
        b=UXJ6R9WX4am99OG3FPz0ew/mqEfxN89me8n3oA85vsLBr/ieD5Uk+jWlJ/+yoiSOCN
         Sy22Ya6E58U3lAc33/Uv5jSkYwUwzB0JZ21gDwkKF28UmqnyrsnHjNGwnQGpzI6S2wfS
         /kSCp6JSq5Kc2u649s5pxqDejL7xtG38R9gicg3wGiBP8n0+X8j04Ie4meRGxCSrgaq3
         JrNskH4ibJQLFi7wkSs0UvpqnozHvIGGPSn5FL+Bdo2Ia8QPQZHP4RtUllCfrE0oPPMm
         CbGkbbyhWJsq1o5Uw3gk8GyoVZSH6Oc7udLppLzJL4cgV30h8KGABX3295kNjPeuSfNT
         zhWQ==
X-Gm-Message-State: AFqh2kpQH0PfbeenL83ipCz6JbvBcPdrzUidNkGA4/c7OfVo6XN4+LAc
        NnPB2KrMNsxr58rq0hwYUFeKsWm25vEJg6sy
X-Google-Smtp-Source: AMrXdXsGUdmfYazAx27DakjPtcERF5H/JBaT1GEG+jEsY0D2C/qM670rVyWuDdWr5cFAJrkfpPOF+5JCcq5fk0Li
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a25:4485:0:b0:764:2d1e:4345 with SMTP
 id r127-20020a254485000000b007642d1e4345mr404750yba.551.1671754451977; Thu,
 22 Dec 2022 16:14:11 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:51 +0000
In-Reply-To: <20221223001352.3873203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221223001352.3873203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-8-vannapurve@google.com>
Subject: [V3 PATCH 7/8] KVM: selftests: private_mem_test: Add support for SEV VMs
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support of executing private mem test with SEV VMs to allow
creating SEV VMs and make the guest code do page table updates in
case of executiong from SEV VM context.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../include/x86_64/private_mem_test_helper.h  |  3 ++
 .../kvm/lib/x86_64/private_mem_test_helper.c  | 37 +++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h b/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
index 4d32c025876c..e54870b72369 100644
--- a/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
+++ b/tools/testing/selftests/kvm/include/x86_64/private_mem_test_helper.h
@@ -12,4 +12,7 @@
 void execute_vm_with_private_test_mem(
 			enum vm_mem_backing_src_type test_mem_src);
 
+void execute_sev_vm_with_private_test_mem(
+			enum vm_mem_backing_src_type test_mem_src);
+
 #endif /* SELFTEST_KVM_PRIVATE_MEM_TEST_HELPER_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c b/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c
index 600bd21d1bb8..36a8b1ab1c74 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/private_mem_test_helper.c
@@ -22,6 +22,9 @@
 #include <private_mem.h>
 #include <private_mem_test_helper.h>
 #include <processor.h>
+#include <sev.h>
+
+static bool is_guest_sev_vm;
 
 #define TEST_AREA_SLOT		10
 #define TEST_AREA_GPA		0xC0000000
@@ -104,6 +107,8 @@ static void guest_conv_test_fn(void)
 	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
 		TEST_MEM_DATA_PATTERN1));
 
+	if (is_guest_sev_vm)
+		guest_set_region_shared(guest_test_mem, guest_test_size);
 	kvm_hypercall_map_shared((uint64_t)guest_test_mem, guest_test_size);
 
 	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PATTERN2);
@@ -112,6 +117,9 @@ static void guest_conv_test_fn(void)
 	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
 		TEST_MEM_DATA_PATTERN5));
 
+	if (is_guest_sev_vm)
+		guest_set_region_private(guest_test_mem, guest_test_size);
+
 	kvm_hypercall_map_private((uint64_t)guest_test_mem, guest_test_size);
 
 	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PATTERN3);
@@ -170,14 +178,19 @@ static void host_conv_test_fn(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	ASSERT_GUEST_DONE(vcpu);
 }
 
-void execute_vm_with_private_test_mem(
-			enum vm_mem_backing_src_type test_mem_src)
+static void execute_private_mem_test(enum vm_mem_backing_src_type test_mem_src,
+	bool is_sev_vm)
 {
 	struct kvm_vm *vm;
 	struct kvm_enable_cap cap;
 	struct kvm_vcpu *vcpu;
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_conv_test_fn);
+	if (is_sev_vm)
+		vm = sev_vm_init_with_one_vcpu(SEV_POLICY_NO_DBG,
+			guest_conv_test_fn, &vcpu);
+	else
+		vm = vm_create_with_one_vcpu(&vcpu, guest_conv_test_fn);
+	TEST_ASSERT(vm, "VM creation failed\n");
 
 	vm_check_cap(vm, KVM_CAP_EXIT_HYPERCALL);
 	cap.cap = KVM_CAP_EXIT_HYPERCALL;
@@ -191,7 +204,25 @@ void execute_vm_with_private_test_mem(
 
 	virt_map(vm, TEST_AREA_GPA, TEST_AREA_GPA, TEST_AREA_SIZE/vm->page_size);
 
+	if (is_sev_vm) {
+		is_guest_sev_vm = true;
+		sync_global_to_guest(vm, is_guest_sev_vm);
+		sev_vm_finalize(vm, SEV_POLICY_NO_DBG);
+	}
+
 	host_conv_test_fn(vm, vcpu);
 
 	kvm_vm_free(vm);
 }
+
+void execute_vm_with_private_test_mem(
+			enum vm_mem_backing_src_type test_mem_src)
+{
+	execute_private_mem_test(test_mem_src, false);
+}
+
+void execute_sev_vm_with_private_test_mem(
+			enum vm_mem_backing_src_type test_mem_src)
+{
+	execute_private_mem_test(test_mem_src, true);
+}
-- 
2.39.0.314.g84b9a713c41-goog

