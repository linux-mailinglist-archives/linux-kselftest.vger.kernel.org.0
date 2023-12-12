Return-Path: <linux-kselftest+bounces-1752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E980F867
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760082845A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA5A65A66;
	Tue, 12 Dec 2023 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+xXdegY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F52125
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d749e4fa3dso76113727b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414072; x=1703018872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9b8Rem1AmPjfYzBNcLPCGf0Ya+tJ/F2me7CGYJ1U7yY=;
        b=c+xXdegYuCLIzMpK1wqjjpEBsZ3P55jFe4ZwmICAMcSiQ23B3Ru+Aghc88Xh0OZazr
         A1NZz/VwuLXLVINEPI/B8liuqzf8fqjqSQEH7VuQhnXnjwEkW6odAPMBtRdEStly1Fod
         iQIkmoMo8z226Po8HUqzwajGJZZ/8UnBGb1Z2G/ypIoyVMTIrI7yKBklzczTEhjND7zF
         vZhhgGNr+B9QeVSt80m1Zwdb7VUsjJNAOlo+T3a4kkN3grVzvcOPtC84XS312Yl7L3V2
         If5HPkCmEvy3K6XfzAMDn9FAnBZLANr8FJQ36CdOI1MF/mQNUcT96Y9pVMD35/Km5J81
         ErbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414072; x=1703018872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9b8Rem1AmPjfYzBNcLPCGf0Ya+tJ/F2me7CGYJ1U7yY=;
        b=pgulKcJe5TAD0w8A8yhutX/No6uwAml4SYWpDo4dC8Us4Zx0yR2Pbr0+ViM1NhpxWK
         Wo+MOEsSaehzCKPbWwpoBk2QEm43kv95nB92lHasAMtVpnW3o7Be0Ktq6ctCfRFSoHad
         O13juHsPVCbP/19y+p8YLWMzDflXbDnnGjXctLSVcdH5Oz9iqn99pkKGZzDbNdMbMOYt
         Zg5URTJEqWdU7vMs8hJJzPA1X1lZFjZRnZS7n9/zZHbuSd2ENyOdHVVFtZVuaoa2RJQG
         7T6kWmQE1QZ5gxTH8KioPmqVkmGluYH8OeFFXl1DCmRcKE/yY2FN3Fb2ZG4jGIr99STJ
         V0LQ==
X-Gm-Message-State: AOJu0Yyd/eyiMltpOl5n29CifblECuYCCkY2XObcb8ZR+LThNCM0BoL4
	joV12Kmm40Yc1vv8CqY84Yu6JFj5Qe/3cWGCfYrxD/FlhZ5EFMpIfiK5dcVEZ8bOScFMVzanj4q
	L3g5Ha9pQMxoRwwzsG5jKW0vXOeVR4UgrNR2TKSPns8143zSSyUBZly0dMACVhyIX20IdQoc=
X-Google-Smtp-Source: AGHT+IFxV+KrDYmcwmn1PDxvzNdlpDP4pWeOD1xeuiQDvWiuL5pZVy4R12KnOvAQ3fLYUpwzgPkXIIMt+Q==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:690c:891:b0:5d8:eec5:f57c with SMTP id
 cd17-20020a05690c089100b005d8eec5f57cmr64746ywb.4.1702414070805; Tue, 12 Dec
 2023 12:47:50 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:44 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-30-sagis@google.com>
Subject: [RFC PATCH v5 29/29] KVM: selftests: TDX: Add TDX UPM selftests for
 implicit conversion
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

This tests the use of guest memory without explicit MapGPA calls.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/x86_64/tdx_upm_test.c       | 86 +++++++++++++++++--
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
index 44671874a4f1..bfa921f125a0 100644
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
+				vm, vcpu->run->memory_fault.gpa,
+				vcpu->run->memory_fault.size,
+				vcpu->run->memory_fault.flags == KVM_MEMORY_EXIT_FLAG_PRIVATE);
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
2.43.0.472.g3155946c3a-goog


