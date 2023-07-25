Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F67625AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjGYWEn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjGYWDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8212681
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:53 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56336f5dc6cso2587109a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322563; x=1690927363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eonYMJ7IPKS2BnVFH7UlnGnXVdnLxl/AbXQ7zYQVczY=;
        b=sYOLW6+pDsdSG22ALCCdIi5dySf8CVLA1W+cAyi3u3cvq8jwbjjzxe6YSbFnNA1Bxd
         RUxawyt7vXeX5orDLifWeurPhXSDoK3c+M9n3QJ6VVVv5TpnySXIv/wCnUnNkN5DfO0E
         3kbK/auVi7GmOYZxO+Hkfcn9yh5ltqeqsHqXab3sA4J5M3KUxUvKRN101EowrZbnE+DS
         +1iLolqqwUgs4TtBLZFDoPlw0+PplU/TNvXrY9LY2kAbp5k8RG0jWRMuSIKPCT4oAlmT
         iF8rupspZyHySXp0tucMfCdXO7Tweft1uAu0g1F1sHyWHEwIddhS2mIEsJoXgqHfjGh5
         0UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322563; x=1690927363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eonYMJ7IPKS2BnVFH7UlnGnXVdnLxl/AbXQ7zYQVczY=;
        b=D2GeV60UEvXvmxy46cDjJpTL7DHPHfQ17JDOcAikT8eiHiUN8jnkahAw0Btji4eTZ9
         H9vxH5D1QuzEKpkpuqmDrvKrfHR4LGUgUKsOX9v+eskoGrasPkA4VjWobpOtbV+W3/6a
         3NBjMvE8ebuR9X05tZzS0Pp13cYkUkh1NOrek7K6oSnIbKbZ6G50LXhS33YwnQhB6eZC
         cQEkKaBOYTSGvmnIQmWV399jqzy4WQbt6O1czgzlQS/RQUG1l5A5MBCGdDs/aQnReziw
         LgdwmFHQtb7kw5iqmpMSDW9FbeiOlB1CR/8yB9GXfWZ147n6tB+GLMpYdHYGb1yYEvLH
         1xdw==
X-Gm-Message-State: ABy/qLaNztsXgvUjHsdQVyTlzqTzVpDAolo+jjmu4wAmI7+9bKTodS1z
        jkKesYEZgtwC78592ryS4MYhcbHq7Oca+3JqkCRRhrbo3Ron+L59XdGdIWHZlvDiKXAwfMs0wVW
        C0veP/M2LnU99+G8tydUfAd0mfH3RIVY6wrCDc1YrHRSzkc+MZTUmFlhEuU8vn20LyQk4+EzAqH
        SU
X-Google-Smtp-Source: APBJJlF8oygwUBP6YRwB1Pau6BxWwjayrEKJw0OMi3pcQ46T1Yn+FytRT+hSLKQwVwNkBRqSSE2rUHR/sKEa
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:3855:0:b0:543:b015:600b with SMTP id
 h21-20020a633855000000b00543b015600bmr2108pgn.8.1690322562803; Tue, 25 Jul
 2023 15:02:42 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:21 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-29-afranji@google.com>
Subject: [PATCH v4 28/28] KVM: selftests: TDX: Add TDX UPM selftests for
 implicit conversion
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
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

From: Ackerley Tng <ackerleytng@google.com>

This tests the use of guest memory without explicit MapGPA calls.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Ib3832af218632ff3188fa3cbfbe88f127b64f5f7
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/x86_64/tdx_upm_test.c       | 86 +++++++++++++++++--
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
index 748a4ed5f88b..ecdbc97b5ff8 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
@@ -149,7 +149,7 @@ enum {
  * Does vcpu_run, and also manages memory conversions if requested by the TD.
  */
 void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
-					    struct kvm_vcpu *vcpu)
+					    struct kvm_vcpu *vcpu, bool handle_conversions)
 {
 	for (;;) {
 		vcpu_run(vcpu);
@@ -163,6 +163,13 @@ void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
 				!(vm->arch.s_bit & vmcall_info->in_r12));
 			vmcall_info->status_code = 0;
 			continue;
+		} else if (handle_conversions &&
+			vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT) {
+			handle_memory_conversion(
+				vm, vcpu->run->memory.gpa,
+				vcpu->run->memory.size,
+				vcpu->run->memory.flags == KVM_MEMORY_EXIT_FLAG_PRIVATE);
+			continue;
 		} else if (
 			vcpu->run->exit_reason == KVM_EXIT_IO &&
 			vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
@@ -243,8 +250,53 @@ static void guest_upm_explicit(void)
 	tdx_test_success();
 }
 
+static void guest_upm_implicit(void)
+{
+	struct tdx_upm_test_area *test_area_gva_private =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_PRIVATE;
+	struct tdx_upm_test_area *test_area_gva_shared =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_SHARED;
+
+	/* Check: host reading private memory does not modify guest's view */
+	fill_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL);
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
+
+	TDX_UPM_TEST_ASSERT(
+		check_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/* Use focus area as shared */
+	fill_focus_area(test_area_gva_shared, PATTERN_GUEST_FOCUS);
+
+	/* General areas should not be affected */
+	TDX_UPM_TEST_ASSERT(
+		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
+
+	/* Check that guest has the same view of shared memory */
+	TDX_UPM_TEST_ASSERT(
+		check_focus_area(test_area_gva_shared, PATTERN_HOST_FOCUS));
+
+	/* Use focus area as private */
+	fill_focus_area(test_area_gva_private, PATTERN_GUEST_FOCUS);
+
+	/* General areas should be unaffected by remapping */
+	TDX_UPM_TEST_ASSERT(
+		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
+
+	/* Check that guest can use private memory after focus area is remapped as private */
+	TDX_UPM_TEST_ASSERT(
+		fill_and_check(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_success();
+}
+
 static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
-			 struct tdx_upm_test_area *test_area_base_hva)
+			 struct tdx_upm_test_area *test_area_base_hva,
+			 bool implicit)
 {
 	vcpu_run(vcpu);
 	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
@@ -263,7 +315,7 @@ static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
 		"Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");
 
-	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	vcpu_run_and_manage_memory_conversions(vm, vcpu, implicit);
 	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
 	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
 		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
@@ -280,7 +332,7 @@ static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
 		    "Host should be able to use shared memory.");
 
-	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	vcpu_run_and_manage_memory_conversions(vm, vcpu, implicit);
 	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
 	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
 		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
@@ -329,18 +381,20 @@ static void guest_ve_handler(struct ex_regs *regs)
 	TDX_UPM_TEST_ASSERT(!ret);
 }
 
-static void verify_upm_test(void)
+static void verify_upm_test(bool implicit)
 {
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
 
+	void *guest_code;
 	vm_vaddr_t test_area_gva_private;
 	struct tdx_upm_test_area *test_area_base_hva;
 	uint64_t test_area_npages;
 
 	vm = td_create();
 	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
-	vcpu = td_vcpu_add(vm, 0, guest_upm_explicit);
+	guest_code = implicit ? guest_upm_implicit : guest_upm_explicit;
+	vcpu = td_vcpu_add(vm, 0, guest_code);
 
 	vm_install_exception_handler(vm, VE_VECTOR, guest_ve_handler);
 
@@ -379,13 +433,26 @@ static void verify_upm_test(void)
 
 	td_finalize(vm);
 
-	printf("Verifying UPM functionality: explicit MapGPA\n");
+	if (implicit)
+		printf("Verifying UPM functionality: implicit conversion\n");
+	else
+		printf("Verifying UPM functionality: explicit MapGPA\n");
 
-	run_selftest(vm, vcpu, test_area_base_hva);
+	run_selftest(vm, vcpu, test_area_base_hva, implicit);
 
 	kvm_vm_free(vm);
 }
 
+void verify_upm_test_explicit(void)
+{
+	verify_upm_test(false);
+}
+
+void verify_upm_test_implicit(void)
+{
+	verify_upm_test(true);
+}
+
 int main(int argc, char **argv)
 {
 	/* Disable stdout buffering */
@@ -397,5 +464,6 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	run_in_new_process(&verify_upm_test);
+	run_in_new_process(&verify_upm_test_explicit);
+	run_in_new_process(&verify_upm_test_implicit);
 }
-- 
2.41.0.487.g6d72f3e995-goog

