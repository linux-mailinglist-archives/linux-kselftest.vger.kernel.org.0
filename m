Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2440B3B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhINPwQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235315AbhINPvo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOE0crkOwV8Xe98ZUlMpfni3es5pLcDJQ76pDP+haw4=;
        b=ZgWw+Zy/Oei2wg3JGKypTsm18N33RPYj7vETeIm1M6Ov/YTuPa5rPUWrhWwwsxIiU7KZGa
        BooB0uZi9grpg6GCrvPPSZ5lUCzph22NknvQRu6xv4x9X4o7Er+Cc+dP0JWQV6cDNgXA33
        abrR1ovv9UE+aQe6E9XFlTV4GI136gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-D7M7ObJBOgOoIFjKEmiv5Q-1; Tue, 14 Sep 2021 11:50:25 -0400
X-MC-Unique: D7M7ObJBOgOoIFjKEmiv5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88DD0835DE0;
        Tue, 14 Sep 2021 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 673655C1D1;
        Tue, 14 Sep 2021 15:50:19 +0000 (UTC)
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
Subject: [PATCH 13/14] KVM: x86: nSVM: implement nested TSC scaling
Date:   Tue, 14 Sep 2021 18:48:24 +0300
Message-Id: <20210914154825.104886-14-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This was tested by booting a nested guest with TSC=1Ghz,
observing the clocks, and doing about 100 cycles of migration.

Note that qemu patch is needed to support migration because
of a new MSR that needs to be placed in the migration state.

The patch will be sent to the qemu mailing list soon.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 29 +++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.c    | 30 ++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.h    |  5 +++++
 arch/x86/kvm/vmx/vmx.c    |  1 +
 arch/x86/kvm/x86.c        |  1 +
 5 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 29b5d0f85960..4c26417f36b8 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -572,8 +572,17 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	if (nested_npt_enabled(svm))
 		nested_svm_init_mmu_context(vcpu);
 
-	svm->vmcb->control.tsc_offset = vcpu->arch.tsc_offset =
-		vcpu->arch.l1_tsc_offset + svm->nested.ctl.tsc_offset;
+	vcpu->arch.tsc_offset = kvm_calc_nested_tsc_offset(
+			vcpu->arch.l1_tsc_offset,
+			svm->nested.ctl.tsc_offset,
+			svm->tsc_ratio_msr);
+
+	svm->vmcb->control.tsc_offset = vcpu->arch.tsc_offset;
+
+	if (svm->tsc_ratio_msr != kvm_default_tsc_scaling_ratio) {
+		WARN_ON(!svm->tsc_scaling_enabled);
+		nested_svm_update_tsc_ratio_msr(vcpu);
+	}
 
 	svm->vmcb->control.int_ctl             =
 		(svm->nested.ctl.int_ctl & int_ctl_vmcb12_bits) |
@@ -872,6 +881,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 		vmcb_mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
 	}
 
+	if (svm->tsc_ratio_msr != kvm_default_tsc_scaling_ratio) {
+		WARN_ON(!svm->tsc_scaling_enabled);
+		vcpu->arch.tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
+		svm_write_tsc_multiplier(vcpu, vcpu->arch.tsc_scaling_ratio);
+	}
+
 	svm->nested.ctl.nested_cr3 = 0;
 
 	/*
@@ -1259,6 +1274,16 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
 	return NESTED_EXIT_CONTINUE;
 }
 
+void nested_svm_update_tsc_ratio_msr(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	vcpu->arch.tsc_scaling_ratio =
+		kvm_calc_nested_tsc_multiplier(vcpu->arch.l1_tsc_scaling_ratio,
+					       svm->tsc_ratio_msr);
+	svm_write_tsc_multiplier(vcpu, vcpu->arch.tsc_scaling_ratio);
+}
+
 static int svm_get_nested_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				u32 user_data_size)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 001a5af842ba..0b797351cfb9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1023,6 +1023,9 @@ static __init void svm_set_cpu_caps(void)
 		if (vls)
 			kvm_cpu_cap_set(X86_FEATURE_V_VMSAVE_VMLOAD);
 
+		if (tsc_scaling)
+			kvm_cpu_cap_set(X86_FEATURE_TSCRATEMSR);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
@@ -1215,7 +1218,9 @@ static u64 svm_get_l2_tsc_offset(struct kvm_vcpu *vcpu)
 
 static u64 svm_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu)
 {
-	return kvm_default_tsc_scaling_ratio;
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	return svm->tsc_ratio_msr;
 }
 
 static void svm_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
@@ -1227,7 +1232,7 @@ static void svm_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 	vmcb_mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
 }
 
-static void svm_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 multiplier)
+void svm_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 multiplier)
 {
 	wrmsrl(MSR_AMD64_TSC_RATIO, multiplier);
 }
@@ -1405,6 +1410,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 
 	enable_gif(svm);
 
+	svm->tsc_ratio_msr = kvm_default_tsc_scaling_ratio;
 }
 
 static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
@@ -2765,6 +2771,11 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	switch (msr_info->index) {
+	case MSR_AMD64_TSC_RATIO:
+		if (!msr_info->host_initiated && !svm->tsc_scaling_enabled)
+			return 1;
+		msr_info->data = svm->tsc_ratio_msr;
+		break;
 	case MSR_STAR:
 		msr_info->data = svm->vmcb01.ptr->save.star;
 		break;
@@ -2901,6 +2912,19 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	u32 ecx = msr->index;
 	u64 data = msr->data;
 	switch (ecx) {
+	case MSR_AMD64_TSC_RATIO:
+		if (!msr->host_initiated && !svm->tsc_scaling_enabled)
+			return 1;
+
+		if (data & TSC_RATIO_RSVD)
+			return 1;
+
+		svm->tsc_ratio_msr = data;
+
+		if (svm->tsc_scaling_enabled && is_guest_mode(vcpu))
+			nested_svm_update_tsc_ratio_msr(vcpu);
+
+		break;
 	case MSR_IA32_CR_PAT:
 		if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
 			return 1;
@@ -4107,6 +4131,8 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	svm->v_vmload_vmsave_enabled = vls && guest_cpuid_has(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
+	svm->tsc_scaling_enabled = tsc_scaling && guest_cpuid_has(vcpu, X86_FEATURE_TSCRATEMSR);
+
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
 	/* For sev guests, the memory encryption bit is not reserved in CR3.  */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 029340a7fbcc..c8ea3b14da73 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -140,6 +140,8 @@ struct vcpu_svm {
 	u64 next_rip;
 
 	u64 spec_ctrl;
+
+	u64 tsc_ratio_msr;
 	/*
 	 * Contains guest-controlled bits of VIRT_SPEC_CTRL, which will be
 	 * translated into the appropriate L2_CFG bits on the host to
@@ -163,6 +165,7 @@ struct vcpu_svm {
 	bool nrips_enabled                : 1;
 	bool lbrv_enabled                 : 1;
 	bool v_vmload_vmsave_enabled      : 1;
+	bool tsc_scaling_enabled          : 1;
 
 	u32 ldr_reg;
 	u32 dfr_reg;
@@ -491,6 +494,8 @@ int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
 			       bool has_error_code, u32 error_code);
 int nested_svm_exit_special(struct vcpu_svm *svm);
+void nested_svm_update_tsc_ratio_msr(struct kvm_vcpu *vcpu);
+void svm_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 multiplier);
 void nested_load_control_from_vmcb12(struct vcpu_svm *svm,
 				     struct vmcb_control_area *control);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fada1055f325..e1d8f0df8172 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6404,6 +6404,7 @@ static bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
 		return nested;
 	case MSR_AMD64_VIRT_SPEC_CTRL:
+	case MSR_AMD64_TSC_RATIO:
 		/* This is AMD only.  */
 		return false;
 	default:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 86539c1686fa..1b7881c7a516 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1374,6 +1374,7 @@ static const u32 emulated_msrs_all[] = {
 	MSR_PLATFORM_INFO,
 	MSR_MISC_FEATURES_ENABLES,
 	MSR_AMD64_VIRT_SPEC_CTRL,
+	MSR_AMD64_TSC_RATIO,
 	MSR_IA32_POWER_CTL,
 	MSR_IA32_UCODE_REV,
 
-- 
2.26.3

