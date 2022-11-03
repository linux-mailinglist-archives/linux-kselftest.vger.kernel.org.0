Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE1617F31
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiKCOQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiKCOPh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F114D23
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667484874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLisqYCuvhrvJZvVGDjJWbAbpZRyes0U6eXBtx/XUoI=;
        b=cg2eT4xq2szfJN8jlbNSPIcunn3VADazyVuvZTAwFpJzZwj7PgPcIQt7BPFJhq/RCPuPbu
        opJrAHjWirXok8x2ctQMQybT1DXV7doLQVnlrYVfDM56VgtXPjQmRYqlPDWEQyj+yTu2lm
        KyE7YoUcjeXowtDgUCz0nq57HNnrLqQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-XYaCv1I2OcytzkJHCNS6sw-1; Thu, 03 Nov 2022 10:14:31 -0400
X-MC-Unique: XYaCv1I2OcytzkJHCNS6sw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91AE0800B30;
        Thu,  3 Nov 2022 14:14:29 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4F4B40C6EC3;
        Thu,  3 Nov 2022 14:14:24 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        Borislav Petkov <bp@alien8.de>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        David Matlack <dmatlack@google.com>
Subject: [PATCH v2 8/9] KVM: selftests: add svm part to triple_fault_test
Date:   Thu,  3 Nov 2022 16:13:50 +0200
Message-Id: <20221103141351.50662-9-mlevitsk@redhat.com>
In-Reply-To: <20221103141351.50662-1-mlevitsk@redhat.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Since instead of the VMX, the SVM allows the hypervisor to avoid
intercepting shutdown in guest, don't intercept shutdown to test that
KVM suports this correctly.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../kvm/x86_64/triple_fault_event_test.c      | 73 ++++++++++++++-----
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c b/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
index 70b44f0b52fef2..ead5d878a71c45 100644
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
@@ -38,24 +40,53 @@ void l1_guest_code(struct vmx_pages *vmx)
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
+
+		vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code_vmx);
+		vcpu_alloc_vmx(vm, &vmx_pages_gva);
+		vcpu_args_set(vcpu, 1, vmx_pages_gva);
+	} else {
+		vm_vaddr_t svm_gva;
+
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
@@ -78,13 +109,21 @@ int main(void)
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
+	return 0;
 }
-- 
2.34.3

