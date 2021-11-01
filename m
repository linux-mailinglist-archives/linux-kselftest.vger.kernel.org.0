Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29878441C2D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhKAOHR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 10:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232324AbhKAOHQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 10:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635775482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/+JsAYRl2YIeya7MElaJYq7pVl1+z8469TY/r5ECag=;
        b=C9+lDXmYLUYSiAVYIex8sNi1U8EQOTF1Yobl6o/LqCFEaswJXBz/hxledmTcWYh75wWvC2
        Y1z1VZHAcz53dtcISmxtwBTjBIDcfSGwfE8AoVzfLWm+NDTzLl0Kv4YeDudiYhVi0e1ihC
        aBCHLxbpSqLgHLqhCsSypV+3GMJqLD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-jLAcVwYPOPKBhEehHJmgQg-1; Mon, 01 Nov 2021 10:04:39 -0400
X-MC-Unique: jLAcVwYPOPKBhEehHJmgQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 472C410055BF;
        Mon,  1 Nov 2021 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 903F6100EB3D;
        Mon,  1 Nov 2021 14:04:32 +0000 (UTC)
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
Subject: [PATCH v2 4/6] KVM: x86: nSVM: implement nested VMLOAD/VMSAVE
Date:   Mon,  1 Nov 2021 16:03:22 +0200
Message-Id: <20211101140324.197921-5-mlevitsk@redhat.com>
In-Reply-To: <20211101140324.197921-1-mlevitsk@redhat.com>
References: <20211101140324.197921-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This was tested by booting L1,L2,L3 (all Linux) and checking
that no VMLOAD/VMSAVE vmexits happened.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 35 +++++++++++++++++++++++++++++------
 arch/x86/kvm/svm/svm.c    |  7 +++++++
 arch/x86/kvm/svm/svm.h    |  8 +++++++-
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index eca0f2f41bf30..2dc97cca68f7c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -119,6 +119,20 @@ static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 }
 
+static bool nested_vmcb_needs_vls_intercept(struct vcpu_svm *svm)
+{
+	if (!svm->v_vmload_vmsave_enabled)
+		return true;
+
+	if (!nested_npt_enabled(svm))
+		return true;
+
+	if (!(svm->nested.ctl.virt_ext & VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK))
+		return true;
+
+	return false;
+}
+
 void recalc_intercepts(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *c, *h, *g;
@@ -159,8 +173,17 @@ void recalc_intercepts(struct vcpu_svm *svm)
 	if (!intercept_smi)
 		vmcb_clr_intercept(c, INTERCEPT_SMI);
 
-	vmcb_set_intercept(c, INTERCEPT_VMLOAD);
-	vmcb_set_intercept(c, INTERCEPT_VMSAVE);
+	if (nested_vmcb_needs_vls_intercept(svm)) {
+		/*
+		 * If the virtual VMLOAD/VMSAVE is not enabled for the L2,
+		 * we must intercept these instructions to correctly
+		 * emulate them in case L1 doesn't intercept them.
+		 */
+		vmcb_set_intercept(c, INTERCEPT_VMLOAD);
+		vmcb_set_intercept(c, INTERCEPT_VMSAVE);
+	} else {
+		WARN_ON(!(c->virt_ext & VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK));
+	}
 }
 
 static void copy_vmcb_control_area(struct vmcb_control_area *dst,
@@ -402,10 +425,7 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 	vmcb12->control.exit_int_info = exit_int_info;
 }
 
-static inline bool nested_npt_enabled(struct vcpu_svm *svm)
-{
-	return svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
-}
+
 
 static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 {
@@ -594,6 +614,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 		svm->vmcb->control.virt_ext  |=
 			(svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK);
 
+	if (!nested_vmcb_needs_vls_intercept(svm))
+		svm->vmcb->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
+
 	nested_svm_transition_tlb_flush(vcpu);
 
 	/* Enter Guest-Mode */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0ae8fa9400902..77fd0922c4060 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1023,6 +1023,9 @@ static __init void svm_set_cpu_caps(void)
 		if (lbrv)
 			kvm_cpu_cap_set(X86_FEATURE_LBRV);
 
+		if (vls)
+			kvm_cpu_cap_set(X86_FEATURE_V_VMSAVE_VMLOAD);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
@@ -1274,6 +1277,8 @@ static inline void init_vmcb_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_EIP, 0, 0);
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_ESP, 0, 0);
+
+		svm->v_vmload_vmsave_enabled = false;
 	} else {
 		/*
 		 * If hardware supports Virtual VMLOAD VMSAVE then enable it
@@ -4156,6 +4161,8 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	svm->tsc_scaling_enabled = tsc_scaling && guest_cpuid_has(vcpu, X86_FEATURE_TSCRATEMSR);
 	svm->lbrv_enabled = lbrv && guest_cpuid_has(vcpu, X86_FEATURE_LBRV);
 
+	svm->v_vmload_vmsave_enabled = vls && guest_cpuid_has(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
+
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
 	/* For sev guests, the memory encryption bit is not reserved in CR3.  */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index c3d46fdf4b9ad..ec8dd09e41e69 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -161,10 +161,11 @@ struct vcpu_svm {
 	unsigned int3_injected;
 	unsigned long int3_rip;
 
-	/* cached guest cpuid flags for faster access */
+	/* optional nested SVM features that are enabled for this guest  */
 	bool nrips_enabled                : 1;
 	bool tsc_scaling_enabled          : 1;
 	bool lbrv_enabled                 : 1;
+	bool v_vmload_vmsave_enabled      : 1;
 
 	u32 ldr_reg;
 	u32 dfr_reg;
@@ -412,6 +413,11 @@ static inline bool gif_set(struct vcpu_svm *svm)
 		return !!(svm->vcpu.arch.hflags & HF_GIF_MASK);
 }
 
+static inline bool nested_npt_enabled(struct vcpu_svm *svm)
+{
+	return svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_NP_ENABLE;
+}
+
 /* svm.c */
 #define MSR_INVALID				0xffffffffU
 
-- 
2.26.3

