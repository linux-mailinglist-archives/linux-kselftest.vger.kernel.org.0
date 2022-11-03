Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F601617F2F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiKCOQG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiKCOPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101111A2F
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667484869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcvbZGqx/pbGysS7eWOgjCD7HbL3pDHBihn3geMPwgo=;
        b=ddWP0u5eTeB7gDkz8fnQIMZSg16tduHowkfx+xpmvINqLFQPWJNS6slIto0e0BsFqr1jWC
        4Qp3BzYri+/9SOANW7Jkj2ZnXPQMEPWPGHnC8VbXOFk4JBwehPZp6vOjOPTFrVJ8noasm7
        EZbaIe6fxMUXR6T7t/XDzmaKCk21Q+8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-r7oC7QNnMnKdtxDRwXGArQ-1; Thu, 03 Nov 2022 10:14:25 -0400
X-MC-Unique: r7oC7QNnMnKdtxDRwXGArQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94C51101AA45;
        Thu,  3 Nov 2022 14:14:24 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDB7440C6EC3;
        Thu,  3 Nov 2022 14:14:20 +0000 (UTC)
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
Subject: [PATCH v2 7/9] KVM: x86: allow L1 to not intercept triple fault
Date:   Thu,  3 Nov 2022 16:13:49 +0200
Message-Id: <20221103141351.50662-8-mlevitsk@redhat.com>
In-Reply-To: <20221103141351.50662-1-mlevitsk@redhat.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is SVM correctness fix - although a sane L1 would intercept
SHUTDOWN event, it doesn't have to, so we have to honour this.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c |  6 ++++++
 arch/x86/kvm/vmx/nested.c |  1 +
 arch/x86/kvm/x86.c        | 11 ++++++-----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index bcc4f6620f8aec..3aa9184d1e4ed7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1092,6 +1092,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_SHUTDOWN))
+		return;
+
+	kvm_clear_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 	nested_svm_simple_vmexit(to_svm(vcpu), SVM_EXIT_SHUTDOWN);
 }
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1ebe141a0a015f..7924dea9367813 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4855,6 +4855,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 
 static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
 {
+	kvm_clear_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 	nested_vmx_vmexit(vcpu, EXIT_REASON_TRIPLE_FAULT, 0, 0);
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3fd900504e683b..f0a0102a78f5c3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9741,7 +9741,7 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
 
 int kvm_check_nested_events(struct kvm_vcpu *vcpu)
 {
-	if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
+	if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 		kvm_x86_ops.nested_ops->triple_fault(vcpu);
 		return 1;
 	}
@@ -10255,15 +10255,16 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			r = 0;
 			goto out;
 		}
-		if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
-			if (is_guest_mode(vcpu)) {
+		if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
+			if (is_guest_mode(vcpu))
 				kvm_x86_ops.nested_ops->triple_fault(vcpu);
-			} else {
+
+			if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 				vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
 				vcpu->mmio_needed = 0;
 				r = 0;
-				goto out;
 			}
+			goto out;
 		}
 		if (kvm_check_request(KVM_REQ_APF_HALT, vcpu)) {
 			/* Page is swapped out. Do synthetic halt */
-- 
2.34.3

