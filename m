Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61D441C27
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 15:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhKAOHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 10:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231874AbhKAOHI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 10:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635775475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gM7AO5OOtc3qIzzXj1XX3dC+Uumbk2mOegBA6a5u5zw=;
        b=CQ5u6CspOrvSzT3vpjl2bikx6WMHR8lapYK6tGSKMwAmEftvdxcV7naL09cD+n7g8I/L/S
        XvwPZQwZqAzXSEKphnQ+bNf2wdmcUX5Ep9cHqSCc7I1MdZTPbYv30+7bCulOHdYH51GjUo
        8rAXbmF1bVSy0o1xxC3xKKTQVyDTELk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-xdvsj5LgPpmmI589lXHEHg-1; Mon, 01 Nov 2021 10:04:34 -0400
X-MC-Unique: xdvsj5LgPpmmI589lXHEHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21FDD802682;
        Mon,  1 Nov 2021 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FC6C100EB3D;
        Mon,  1 Nov 2021 14:04:05 +0000 (UTC)
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
Subject: [PATCH v2 3/6] KVM: x86: nSVM: implement nested LBR virtualization
Date:   Mon,  1 Nov 2021 16:03:21 +0200
Message-Id: <20211101140324.197921-4-mlevitsk@redhat.com>
In-Reply-To: <20211101140324.197921-1-mlevitsk@redhat.com>
References: <20211101140324.197921-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This was tested with kvm-unit-test that was developed
for this purpose.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 21 +++++++++++++++++++--
 arch/x86/kvm/svm/svm.c    |  8 ++++++++
 arch/x86/kvm/svm/svm.h    |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9239631846d88..eca0f2f41bf30 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -518,8 +518,19 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 		vmcb_mark_dirty(svm->vmcb, VMCB_DR);
 	}
 
-	if (unlikely(svm->vmcb01.ptr->control.virt_ext & LBR_CTL_ENABLE_MASK))
+	if (unlikely(svm->lbrv_enabled && (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
+		svm_copy_lbrs(vmcb12, svm->vmcb);
+		/*
+		 * TODO: to avoid TOC/TOU race,
+		 * make sure that we only pick LBR enable bit from
+		 * the guest.
+		 */
+		svm->vmcb->save.dbgctl &= LBR_CTL_ENABLE_MASK;
+		svm_update_lbrv(&svm->vcpu);
+
+	} else if (unlikely(svm->vmcb01.ptr->control.virt_ext & LBR_CTL_ENABLE_MASK)) {
 		svm_copy_lbrs(svm->vmcb01.ptr, svm->vmcb);
+	}
 }
 
 static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
@@ -579,6 +590,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 
 	svm->vmcb->control.virt_ext            = svm->vmcb01.ptr->control.virt_ext &
 						 LBR_CTL_ENABLE_MASK;
+	if (svm->lbrv_enabled)
+		svm->vmcb->control.virt_ext  |=
+			(svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK);
 
 	nested_svm_transition_tlb_flush(vcpu);
 
@@ -841,7 +855,10 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
 
-	if (unlikely(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK)) {
+	if (unlikely(svm->lbrv_enabled && (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
+		svm_copy_lbrs(svm->nested.vmcb02.ptr, vmcb12);
+		svm_update_lbrv(vcpu);
+	} else if (unlikely(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK)) {
 		svm_copy_lbrs(svm->nested.vmcb02.ptr, svm->vmcb);
 		svm_update_lbrv(vcpu);
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c08f8804d107f..0ae8fa9400902 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -884,6 +884,10 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 	bool current_enable_lbrv = !!(svm->vmcb->control.virt_ext &
 				      LBR_CTL_ENABLE_MASK);
 
+	if (unlikely(is_guest_mode(vcpu) && svm->lbrv_enabled))
+		if (unlikely(svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))
+			enable_lbrv = true;
+
 	if (enable_lbrv == current_enable_lbrv)
 		return;
 
@@ -1016,6 +1020,9 @@ static __init void svm_set_cpu_caps(void)
 		if (tsc_scaling)
 			kvm_cpu_cap_set(X86_FEATURE_TSCRATEMSR);
 
+		if (lbrv)
+			kvm_cpu_cap_set(X86_FEATURE_LBRV);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
@@ -4147,6 +4154,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 			     guest_cpuid_has(vcpu, X86_FEATURE_NRIPS);
 
 	svm->tsc_scaling_enabled = tsc_scaling && guest_cpuid_has(vcpu, X86_FEATURE_TSCRATEMSR);
+	svm->lbrv_enabled = lbrv && guest_cpuid_has(vcpu, X86_FEATURE_LBRV);
 
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ff84f84f697f7..c3d46fdf4b9ad 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -164,6 +164,7 @@ struct vcpu_svm {
 	/* cached guest cpuid flags for faster access */
 	bool nrips_enabled                : 1;
 	bool tsc_scaling_enabled          : 1;
+	bool lbrv_enabled                 : 1;
 
 	u32 ldr_reg;
 	u32 dfr_reg;
-- 
2.26.3

