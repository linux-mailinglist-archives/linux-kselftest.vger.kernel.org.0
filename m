Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3140B39C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhINPva (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235439AbhINPvN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ncVr4kL+N9re2Ax5j40BktILoXmljuWD8PAGlleOTQ=;
        b=C/s3Onqm/XOgAZpIboF+/rYScHmCKclsOZDexsgkJ/4bfOx6pQpmc1Y+871ARYAsudcOVG
        9oqMXV4/rzAtWR16fN8ErYSiZkpeaL74oy4LIfG2987gssBa809JBsUOYTKTSSM3RVx+un
        OjEMPE1MMSakche8zjMKWCRONScMp3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-ZHxdYFYsNliIJqQZAssuqw-1; Tue, 14 Sep 2021 11:49:54 -0400
X-MC-Unique: ZHxdYFYsNliIJqQZAssuqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20F14CC622;
        Tue, 14 Sep 2021 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2E5C5C1BB;
        Tue, 14 Sep 2021 15:49:47 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Maxim Levitsky <mlevitsk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 09/14] KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running
Date:   Tue, 14 Sep 2021 18:48:20 +0300
Message-Id: <20210914154825.104886-10-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When L2 is running without LBR virtualization, we should ensure
that L1's LBR msrs continue to update as usual.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 11 +++++
 arch/x86/kvm/svm/svm.c    | 98 +++++++++++++++++++++++++++++++--------
 arch/x86/kvm/svm/svm.h    |  2 +
 3 files changed, 92 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4df59d9795b6..c6f09b591696 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -502,6 +502,9 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 		svm->vcpu.arch.dr6  = vmcb12->save.dr6 | DR6_ACTIVE_LOW;
 		vmcb_mark_dirty(svm->vmcb, VMCB_DR);
 	}
+
+	if (unlikely(svm->vmcb01.ptr->control.virt_ext & LBR_CTL_ENABLE_MASK))
+		svm_copy_lbrs(svm->vmcb01.ptr, svm->vmcb);
 }
 
 static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
@@ -550,6 +553,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	svm->vmcb->control.event_inj           = svm->nested.ctl.event_inj;
 	svm->vmcb->control.event_inj_err       = svm->nested.ctl.event_inj_err;
 
+	svm->vmcb->control.virt_ext            = svm->vmcb01.ptr->control.virt_ext &
+						 LBR_CTL_ENABLE_MASK;
+
 	nested_svm_transition_tlb_flush(vcpu);
 
 	/* Enter Guest-Mode */
@@ -808,6 +814,11 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
 
+	if (unlikely(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK)) {
+		svm_copy_lbrs(svm->nested.vmcb02.ptr, svm->vmcb);
+		svm_update_lbrv(vcpu);
+	}
+
 	/*
 	 * On vmexit the  GIF is set to false and
 	 * no event can be injected in L1.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b08c5d826208..981cc9765b95 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -792,6 +792,17 @@ static void init_msrpm_offsets(void)
 	}
 }
 
+void svm_copy_lbrs(struct vmcb *from_vmcb, struct vmcb *to_vmcb)
+{
+	to_vmcb->save.dbgctl		= from_vmcb->save.dbgctl;
+	to_vmcb->save.br_from		= from_vmcb->save.br_from;
+	to_vmcb->save.br_to		= from_vmcb->save.br_to;
+	to_vmcb->save.last_excp_from	= from_vmcb->save.last_excp_from;
+	to_vmcb->save.last_excp_to	= from_vmcb->save.last_excp_to;
+
+	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
+}
+
 static void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -801,6 +812,10 @@ static void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP, 1, 1);
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP, 1, 1);
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP, 1, 1);
+
+	/* Move the LBR msrs to the vmcb02 so that the guest can see them. */
+	if (is_guest_mode(vcpu))
+		svm_copy_lbrs(svm->vmcb01.ptr, svm->vmcb);
 }
 
 static void svm_disable_lbrv(struct kvm_vcpu *vcpu)
@@ -812,6 +827,63 @@ static void svm_disable_lbrv(struct kvm_vcpu *vcpu)
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP, 0, 0);
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP, 0, 0);
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP, 0, 0);
+
+	/*
+	 * Move the LBR msrs back to the vmcb01 to avoid copying them
+	 * on nested guest entries.
+	 */
+	if (is_guest_mode(vcpu))
+		svm_copy_lbrs(svm->vmcb, svm->vmcb01.ptr);
+}
+
+static int svm_get_lbr_msr(struct vcpu_svm *svm, u32 index)
+{
+	/*
+	 * If the LBR virtualization is disabled, the LBR msrs are always
+	 * kept in the vmcb01 to avoid copying them on nested guest entries.
+	 *
+	 * If nested, and the LBR virtualization is enabled/disabled, the msrs
+	 * are moved between the vmcb01 and vmcb02 as needed.
+	 */
+	struct vmcb *vmcb =
+		(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) ?
+			svm->vmcb : svm->vmcb01.ptr;
+
+	switch (index) {
+	case MSR_IA32_DEBUGCTLMSR:
+		return vmcb->save.dbgctl;
+	case MSR_IA32_LASTBRANCHFROMIP:
+		return vmcb->save.br_from;
+	case MSR_IA32_LASTBRANCHTOIP:
+		return vmcb->save.br_to;
+	case MSR_IA32_LASTINTFROMIP:
+		return vmcb->save.last_excp_from;
+	case MSR_IA32_LASTINTTOIP:
+		return vmcb->save.last_excp_to;
+	default:
+		KVM_BUG(false, svm->vcpu.kvm,
+			"%s: Unknown MSR 0x%x", __func__, index);
+		return 0;
+	}
+}
+
+void svm_update_lbrv(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	bool enable_lbrv = svm_get_lbr_msr(svm, MSR_IA32_DEBUGCTLMSR) &
+					   DEBUGCTLMSR_LBR;
+
+	bool current_enable_lbrv = !!(svm->vmcb->control.virt_ext &
+				      LBR_CTL_ENABLE_MASK);
+
+	if (enable_lbrv == current_enable_lbrv)
+		return;
+
+	if (enable_lbrv)
+		svm_enable_lbrv(vcpu);
+	else
+		svm_disable_lbrv(vcpu);
 }
 
 void disable_nmi_singlestep(struct vcpu_svm *svm)
@@ -2704,25 +2776,12 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_TSC_AUX:
 		msr_info->data = svm->tsc_aux;
 		break;
-	/*
-	 * Nobody will change the following 5 values in the VMCB so we can
-	 * safely return them on rdmsr. They will always be 0 until LBRV is
-	 * implemented.
-	 */
 	case MSR_IA32_DEBUGCTLMSR:
-		msr_info->data = svm->vmcb->save.dbgctl;
-		break;
 	case MSR_IA32_LASTBRANCHFROMIP:
-		msr_info->data = svm->vmcb->save.br_from;
-		break;
 	case MSR_IA32_LASTBRANCHTOIP:
-		msr_info->data = svm->vmcb->save.br_to;
-		break;
 	case MSR_IA32_LASTINTFROMIP:
-		msr_info->data = svm->vmcb->save.last_excp_from;
-		break;
 	case MSR_IA32_LASTINTTOIP:
-		msr_info->data = svm->vmcb->save.last_excp_to;
+		msr_info->data = svm_get_lbr_msr(svm, msr_info->index);
 		break;
 	case MSR_VM_HSAVE_PA:
 		msr_info->data = svm->nested.hsave_msr;
@@ -2940,12 +2999,13 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
-		svm->vmcb->save.dbgctl = data;
-		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
-		if (data & (1ULL<<0))
-			svm_enable_lbrv(vcpu);
+		if (svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK)
+			svm->vmcb->save.dbgctl = data;
 		else
-			svm_disable_lbrv(vcpu);
+			svm->vmcb01.ptr->save.dbgctl = data;
+
+		svm_update_lbrv(vcpu);
+
 		break;
 	case MSR_VM_HSAVE_PA:
 		/*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 524d943f3efc..0c351e9c4d6d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -417,6 +417,8 @@ u32 svm_msrpm_offset(u32 msr);
 u32 *svm_vcpu_alloc_msrpm(void);
 void svm_vcpu_init_msrpm(struct kvm_vcpu *vcpu, u32 *msrpm);
 void svm_vcpu_free_msrpm(u32 *msrpm);
+void svm_copy_lbrs(struct vmcb *from_vmcb, struct vmcb *to_vmcb);
+void svm_update_lbrv(struct kvm_vcpu *vcpu);
 
 int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer);
 void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
-- 
2.26.3

