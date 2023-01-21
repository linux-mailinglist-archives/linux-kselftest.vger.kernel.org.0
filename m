Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D67676266
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjAUAaB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjAUA3z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:29:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09951C4E83
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:29:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y66-20020a253245000000b007cb4f1e3e57so7437005yby.8
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DCwT0vOmg1kvE5C/ZmiO0Q3IunPA+bJBAyC1WliYPU=;
        b=UKfUq51zNuwJ1s8RoAy4DKxdjfKNX60WlC3mQo2LPz454muDFSLBiSU6Lg104sdJ3h
         1D2D4ZWi3MlujhpVjBeBYy/DVsxaYDDG/xY+ZTE6SUwCV/W5nixFHUH47KzNY5O5nMUd
         +V6OnoU5yuGHvDak/bGBvLf4EfNcXGq08rHgjcTSGe3laadp8N3fU+rNhnJeBAx2V2wG
         0s9W8l12xEGM1MZTkc4KzrpQeVEM2/HVoThePaCNd5+yBm2BAHcuk3v31tMnCgAr0uzB
         x9w2hDFjNf1T0v4gBms5OXgjSUtaIvdZvNnZkKfqiru7e8/AXLVj/kDoihEnAvAM/ErV
         nRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DCwT0vOmg1kvE5C/ZmiO0Q3IunPA+bJBAyC1WliYPU=;
        b=xehhSQ0vaRphrNkB9dyouywI1yf9KzekGNgF1gmRJ69vfIshUSL6M6HZB06N5355H8
         At1k3QLxOIcijgid0CRRQLc6KUkBqPtZA3W/45xfXWl/WHWvLtxKKl5RRiKwgwuqLLX1
         /IEfY4zs/TrHj7qNTgS7ymc7r0OIGtWH1hHVzzglaqeEF2ADkeBsSoS7ad8GltueMFMW
         HoYJZFALjqvDlEwEuRYl8V6/Kt88nosy8pl0j1Q1KeN5X/D8ruE5pyYWY2080u8/h+0V
         OpeZBWegPbIEsuotldeWljVA/gXHsROZ8QFCtoBhzA55wwg4l+D6poFF2TFqaVmMupuH
         kLnw==
X-Gm-Message-State: AFqh2krc3WNFjW/xicKPkjadXOEBdrtyYm4uDPIM30k4mA39i8b40uQj
        28KuALBftjEi9J1ghkql3pk/FAXTIthWooCa6e+TfuooeyNMwWFmNJewP52ppnkEKs6zMluot94
        KzKFi2YTtl7B+DWYmYG1zSUNctoNQ0/Edau3Ess2SccWNoIGlT8BER1l8bgY0Xvsvj86BwC238y
        dGeVJXjFMf2vA=
X-Google-Smtp-Source: AMrXdXuLbmhgtGWdFAgKnD+yNqKI8Xaq12OTyFBCP0UJI16En+uZ/3BxfhP5lOEKrFWt/DwBqtrpjBp5AD2mFLoVxA==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a25:8d03:0:b0:7a0:7cd5:602d with SMTP
 id n3-20020a258d03000000b007a07cd5602dmr2002572ybl.426.1674260308219; Fri, 20
 Jan 2023 16:18:28 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:42 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-32-ackerleytng@google.com>
Subject: [RFC PATCH v3 31/31] KVM: selftests: TDX: Add TDX UPM selftests for
 implicit conversion
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This tests the use of restricted memory without explicit MapGPA calls.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86_64/tdx_upm_test.c       | 88 ++++++++++++++++---
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
index 13914aebd7da7..56ba3d4fb15a5 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
@@ -149,11 +149,18 @@ enum {
  * Does vcpu_run, and also manages memory conversions if requested by the TD.
  */
 void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
-					    struct kvm_vcpu *vcpu)
+					    struct kvm_vcpu *vcpu, bool handle_conversions)
 {
 	for (;;) {
 		vcpu_run(vcpu);
-		if (
+		if (handle_conversions &&
+			vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT) {
+			handle_memory_conversion(
+				vm, vcpu->run->memory.gpa,
+				vcpu->run->memory.size,
+				vcpu->run->memory.flags == KVM_MEMORY_EXIT_FLAG_PRIVATE);
+			continue;
+		} else if (
 			vcpu->run->exit_reason == KVM_EXIT_IO &&
 			vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
 			uint64_t gpa = tdx_test_read_64bit(
@@ -233,8 +240,53 @@ static void guest_upm_explicit(void)
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
@@ -253,7 +305,7 @@ static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
 		"Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");
 
-	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	vcpu_run_and_manage_memory_conversions(vm, vcpu, implicit);
 	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
 	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
 		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
@@ -270,7 +322,7 @@ static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
 		    "Host should be able to use shared memory.");
 
-	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	vcpu_run_and_manage_memory_conversions(vm, vcpu, implicit);
 	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
 	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
 		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
@@ -319,18 +371,20 @@ static void guest_ve_handler(struct ex_regs *regs)
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
 
@@ -370,13 +424,26 @@ static void verify_upm_test(void)
 
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
@@ -388,5 +455,6 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	run_in_new_process(&verify_upm_test);
+	run_in_new_process(&verify_upm_test_explicit);
+	run_in_new_process(&verify_upm_test_implicit);
 }
-- 
2.39.0.246.g2a6d74b583-goog

