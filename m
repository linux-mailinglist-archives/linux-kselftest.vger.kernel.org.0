Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8DA441C32
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhKAOHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 10:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232403AbhKAOHX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 10:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635775489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqFACOXhEcJG3lG05yOBjnRQCBdeh1h+5Q34ehwpRUE=;
        b=TMTgiSLpe6QAlcffZa8cME6u5jhtNwc7gmf3NZceFSG1lLWk/u2cBNfDzQhgYnEcONguCn
        eJWGjSXEA/WmR2trk9ACAxywewuRynDAs15UvSCYPxQu8dFhMhuFkSKNsjy2kQR+q2aSYz
        JLMBoscqJnw82CLrbYjX4JSLgtn8yz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-Rw_TfYVRMuqm9FzZilBEuw-1; Mon, 01 Nov 2021 10:04:44 -0400
X-MC-Unique: Rw_TfYVRMuqm9FzZilBEuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E48680A5C0;
        Mon,  1 Nov 2021 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B69D8101E5AE;
        Mon,  1 Nov 2021 14:04:37 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Wei Huang <wei.huang2@amd.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 5/6] KVM: x86: nSVM: support PAUSE filter threshold and count when cpu_pm=on
Date:   Mon,  1 Nov 2021 16:03:23 +0200
Message-Id: <20211101140324.197921-6-mlevitsk@redhat.com>
In-Reply-To: <20211101140324.197921-1-mlevitsk@redhat.com>
References: <20211101140324.197921-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow L1 to use these settings if L0 disables PAUSE interception
(AKA cpu_pm=on)

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c |  6 ++++++
 arch/x86/kvm/svm/svm.c    | 17 +++++++++++++++++
 arch/x86/kvm/svm/svm.h    |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2dc97cca68f7c..15be37368380d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -617,6 +617,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	if (!nested_vmcb_needs_vls_intercept(svm))
 		svm->vmcb->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
 
+	if (svm->pause_filter_enabled)
+		svm->vmcb->control.pause_filter_count = svm->nested.ctl.pause_filter_count;
+
+	if (svm->pause_threshold_enabled)
+		svm->vmcb->control.pause_filter_thresh = svm->nested.ctl.pause_filter_thresh;
+
 	nested_svm_transition_tlb_flush(vcpu);
 
 	/* Enter Guest-Mode */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 77fd0922c4060..ff1447a3551fc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1026,6 +1026,12 @@ static __init void svm_set_cpu_caps(void)
 		if (vls)
 			kvm_cpu_cap_set(X86_FEATURE_V_VMSAVE_VMLOAD);
 
+		if (pause_filter_count)
+			kvm_cpu_cap_set(X86_FEATURE_PAUSEFILTER);
+
+		if (pause_filter_thresh)
+			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
@@ -4163,6 +4169,17 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	svm->v_vmload_vmsave_enabled = vls && guest_cpuid_has(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
+	if (kvm_pause_in_guest(vcpu->kvm)) {
+		svm->pause_filter_enabled = pause_filter_count > 0 &&
+					    guest_cpuid_has(vcpu, X86_FEATURE_PAUSEFILTER);
+
+		svm->pause_threshold_enabled = pause_filter_thresh > 0 &&
+					    guest_cpuid_has(vcpu, X86_FEATURE_PFTHRESHOLD);
+	} else {
+		svm->pause_filter_enabled = false;
+		svm->pause_threshold_enabled = false;
+	}
+
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
 	/* For sev guests, the memory encryption bit is not reserved in CR3.  */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ec8dd09e41e69..75781d66cbd60 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -166,6 +166,8 @@ struct vcpu_svm {
 	bool tsc_scaling_enabled          : 1;
 	bool lbrv_enabled                 : 1;
 	bool v_vmload_vmsave_enabled      : 1;
+	bool pause_filter_enabled         : 1;
+	bool pause_threshold_enabled      : 1;
 
 	u32 ldr_reg;
 	u32 dfr_reg;
-- 
2.26.3

