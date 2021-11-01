Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F4E441C34
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 15:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhKAOHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 10:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232487AbhKAOHi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 10:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635775504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6B0VxLQI1vBxKxE4KBUueszbiUbdBit+lWmouyGJ5Us=;
        b=HrQvaZ2bNdKmvrPJj1h9h7Msd9QQbVFiY6VcA5d+X8DFh0swaDe+O7KBr1KVE6/A6KSVgZ
        7rlMtqB9CfoKvRSACKO8oo5CD/xpAbXtQaaXW1vEU+QVEFCaEdIBgQGv76Bwk8LKRQeCKn
        n7eydd5ZNXnjwUtushvkVUXE0zCoQTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-pi21nRj_OP6D9jtnT1FFjw-1; Mon, 01 Nov 2021 10:05:01 -0400
X-MC-Unique: pi21nRj_OP6D9jtnT1FFjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C9DB1054F90;
        Mon,  1 Nov 2021 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBD54101E5AE;
        Mon,  1 Nov 2021 14:04:42 +0000 (UTC)
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
Subject: [PATCH v2 6/6] KVM: x86: SVM: implement nested vGIF
Date:   Mon,  1 Nov 2021 16:03:24 +0200
Message-Id: <20211101140324.197921-7-mlevitsk@redhat.com>
In-Reply-To: <20211101140324.197921-1-mlevitsk@redhat.com>
References: <20211101140324.197921-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In case L1 enables vGIF for L2, the L2 cannot affect L1's GIF, regardless
of STGI/CLGI intercepts, and since VM entry enables GIF, this means
that L1's GIF is always 1 while L2 is running.

Thus in this case leave L1's vGIF in vmcb01, while letting L2
control the vGIF thus implementing nested vGIF.

Also allow KVM to toggle L1's GIF during nested entry/exit
by always using vmcb01.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 17 +++++++++++++----
 arch/x86/kvm/svm/svm.c    |  5 +++++
 arch/x86/kvm/svm/svm.h    | 25 +++++++++++++++++++++----
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 15be37368380d..4e4e3aea519be 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -384,6 +384,10 @@ void nested_sync_control_from_vmcb02(struct vcpu_svm *svm)
 		 */
 		mask &= ~V_IRQ_MASK;
 	}
+
+	if (nested_vgif_enabled(svm))
+		mask |= V_GIF_MASK;
+
 	svm->nested.ctl.int_ctl        &= ~mask;
 	svm->nested.ctl.int_ctl        |= svm->vmcb->control.int_ctl & mask;
 }
@@ -555,10 +559,8 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 
 static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 {
-	const u32 int_ctl_vmcb01_bits =
-		V_INTR_MASKING_MASK | V_GIF_MASK | V_GIF_ENABLE_MASK;
-
-	const u32 int_ctl_vmcb12_bits = V_TPR_MASK | V_IRQ_INJECTION_BITS_MASK;
+	u32 int_ctl_vmcb01_bits = V_INTR_MASKING_MASK;
+	u32 int_ctl_vmcb12_bits = V_TPR_MASK | V_IRQ_INJECTION_BITS_MASK;
 
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
@@ -573,6 +575,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 */
 	WARN_ON(kvm_apicv_activated(svm->vcpu.kvm));
 
+
+
+	if (svm->vgif_enabled && (svm->nested.ctl.int_ctl & V_GIF_ENABLE_MASK))
+		int_ctl_vmcb12_bits |= (V_GIF_MASK | V_GIF_ENABLE_MASK);
+	else
+		int_ctl_vmcb01_bits |= (V_GIF_MASK | V_GIF_ENABLE_MASK);
+
 	/* Copied from vmcb01.  msrpm_base can be overwritten later.  */
 	svm->vmcb->control.nested_ctl = svm->vmcb01.ptr->control.nested_ctl;
 	svm->vmcb->control.iopm_base_pa = svm->vmcb01.ptr->control.iopm_base_pa;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ff1447a3551fc..0461a3430d529 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1032,6 +1032,9 @@ static __init void svm_set_cpu_caps(void)
 		if (pause_filter_thresh)
 			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
 
+		if (vgif)
+			kvm_cpu_cap_set(X86_FEATURE_VGIF);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
@@ -4180,6 +4183,8 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		svm->pause_threshold_enabled = false;
 	}
 
+	svm->vgif_enabled = vgif && guest_cpuid_has(vcpu, X86_FEATURE_VGIF);
+
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
 	/* For sev guests, the memory encryption bit is not reserved in CR3.  */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 75781d66cbd60..06e5c43ce18a8 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -168,6 +168,7 @@ struct vcpu_svm {
 	bool v_vmload_vmsave_enabled      : 1;
 	bool pause_filter_enabled         : 1;
 	bool pause_threshold_enabled      : 1;
+	bool vgif_enabled                 : 1;
 
 	u32 ldr_reg;
 	u32 dfr_reg;
@@ -386,31 +387,47 @@ static inline bool svm_is_intercept(struct vcpu_svm *svm, int bit)
 	return vmcb_is_intercept(&svm->vmcb->control, bit);
 }
 
+static bool nested_vgif_enabled(struct vcpu_svm *svm)
+{
+	if (!is_guest_mode(&svm->vcpu) || !svm->vgif_enabled)
+		return false;
+	return svm->nested.ctl.int_ctl & V_GIF_ENABLE_MASK;
+}
+
 static inline bool vgif_enabled(struct vcpu_svm *svm)
 {
-	return !!(svm->vmcb->control.int_ctl & V_GIF_ENABLE_MASK);
+	struct vmcb *vmcb = nested_vgif_enabled(svm) ? svm->vmcb01.ptr : svm->vmcb;
+
+	return !!(vmcb->control.int_ctl & V_GIF_ENABLE_MASK);
 }
 
 static inline void enable_gif(struct vcpu_svm *svm)
 {
+	struct vmcb *vmcb = nested_vgif_enabled(svm) ? svm->vmcb01.ptr : svm->vmcb;
+
 	if (vgif_enabled(svm))
-		svm->vmcb->control.int_ctl |= V_GIF_MASK;
+		vmcb->control.int_ctl |= V_GIF_MASK;
 	else
 		svm->vcpu.arch.hflags |= HF_GIF_MASK;
 }
 
 static inline void disable_gif(struct vcpu_svm *svm)
 {
+	struct vmcb *vmcb = nested_vgif_enabled(svm) ? svm->vmcb01.ptr : svm->vmcb;
+
 	if (vgif_enabled(svm))
-		svm->vmcb->control.int_ctl &= ~V_GIF_MASK;
+		vmcb->control.int_ctl &= ~V_GIF_MASK;
 	else
 		svm->vcpu.arch.hflags &= ~HF_GIF_MASK;
+
 }
 
 static inline bool gif_set(struct vcpu_svm *svm)
 {
+	struct vmcb *vmcb = nested_vgif_enabled(svm) ? svm->vmcb01.ptr : svm->vmcb;
+
 	if (vgif_enabled(svm))
-		return !!(svm->vmcb->control.int_ctl & V_GIF_MASK);
+		return !!(vmcb->control.int_ctl & V_GIF_MASK);
 	else
 		return !!(svm->vcpu.arch.hflags & HF_GIF_MASK);
 }
-- 
2.26.3

