Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1D617EA7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 14:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKCN7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 09:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiKCN7T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 09:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF815815
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 06:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667483896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xh9XjKVpdKktTC0L857mGk/x8fhesffzK2L3gtVSzgY=;
        b=Ca27ZdQfPl2Q7Bb1ZTWGqOJUKD8tEeGihgVjDw/gQ/foJ19sMpY48f9DVmkuV6AiFiVH8Y
        EmCcMIJQA8FMUOkTDD6NF1O5lTHr77JCl4baTzbWk3bqq+WjTBDya66HKqePWbhGiKaiaj
        SB7UiukrLtpvxsfu+HgcMPlJA4dji4U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-6i5D2xr4M0GzaFidO2bTDQ-1; Thu, 03 Nov 2022 09:58:12 -0400
X-MC-Unique: 6i5D2xr4M0GzaFidO2bTDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E16863C0F429;
        Thu,  3 Nov 2022 13:58:11 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97BC440C83D9;
        Thu,  3 Nov 2022 13:58:07 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Colton Lewis <coltonlewis@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 8/9] KVM: selftests: add svm part to triple_fault_test
Date:   Thu,  3 Nov 2022 15:57:35 +0200
Message-Id: <20221103135736.42295-9-mlevitsk@redhat.com>
In-Reply-To: <20221103135736.42295-1-mlevitsk@redhat.com>
References: <20221103135736.42295-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a SVM implementation to triple_fault_test to test that
emulated/injected shutdown works.

Since instead of the VMX, the SVM allows the hypervisor to avoid intercepting
shutdown in guest, don't intercept shutdown to test that
KVM suports this correctly.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../kvm/x86_64/triple_fault_event_test.c      | 71 ++++++++++++++-----
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c b/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
index 70b44f0b52fef2..78d2941f7c1f0d 100644
--- a/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
+++ b/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
@@ -3,6 +3,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "vmx.h"
+#include "svm_util.h"
 
 #include <string.h>
 #include <sys/ioctl.h>
@@ -20,10 +21,11 @@ static void l2_guest_code(void)
 		     : : [port] "d" (ARBITRARY_IO_PORT) : "rax");
 }
 
-void l1_guest_code(struct vmx_pages *vmx)
-{
 #define L2_GUEST_STACK_SIZE 64
-	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+
+void l1_guest_code_vmx(struct vmx_pages *vmx)
+{
 
 	GUEST_ASSERT(vmx->vmcs_gpa);
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
@@ -38,24 +40,51 @@ void l1_guest_code(struct vmx_pages *vmx)
 	GUEST_DONE();
 }
 
+void l1_guest_code_svm(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	generic_svm_setup(svm, l2_guest_code,
+			&l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	/* don't intercept shutdown to test the case of SVM allowing to do so */
+	vmcb->control.intercept &= ~(BIT(INTERCEPT_SHUTDOWN));
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	/* should not reach here, L1 should crash  */
+	GUEST_ASSERT(0);
+}
+
 int main(void)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
 	struct kvm_vcpu_events events;
-	vm_vaddr_t vmx_pages_gva;
 	struct ucall uc;
 
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+	bool has_vmx = kvm_cpu_has(X86_FEATURE_VMX);
+	bool has_svm = kvm_cpu_has(X86_FEATURE_SVM);
+
+	TEST_REQUIRE(has_vmx || has_svm);
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_TRIPLE_FAULT_EVENT));
 
-	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
-	vm_enable_cap(vm, KVM_CAP_X86_TRIPLE_FAULT_EVENT, 1);
 
+	if (has_vmx) {
+		vm_vaddr_t vmx_pages_gva;
+		vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code_vmx);
+		vcpu_alloc_vmx(vm, &vmx_pages_gva);
+		vcpu_args_set(vcpu, 1, vmx_pages_gva);
+	} else {
+		vm_vaddr_t svm_gva;
+		vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code_svm);
+		vcpu_alloc_svm(vm, &svm_gva);
+		vcpu_args_set(vcpu, 1, svm_gva);
+	}
+
+	vm_enable_cap(vm, KVM_CAP_X86_TRIPLE_FAULT_EVENT, 1);
 	run = vcpu->run;
-	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vcpu, 1, vmx_pages_gva);
 	vcpu_run(vcpu);
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
@@ -78,13 +107,21 @@ int main(void)
 		    "No triple fault pending");
 	vcpu_run(vcpu);
 
-	switch (get_ucall(vcpu, &uc)) {
-	case UCALL_DONE:
-		break;
-	case UCALL_ABORT:
-		REPORT_GUEST_ASSERT(uc);
-	default:
-		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
-	}
 
+	if (has_svm) {
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
+			    "Got exit_reason other than KVM_EXIT_SHUTDOWN: %u (%s)\n",
+			    run->exit_reason,
+			    exit_reason_str(run->exit_reason));
+		return 0;
+	} else {
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_DONE:
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+		}
+	}
 }
-- 
2.34.3

