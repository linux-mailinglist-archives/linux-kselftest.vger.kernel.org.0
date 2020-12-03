Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E750A2CDC1C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 18:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501950AbgLCRNg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 12:13:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728925AbgLCRNf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 12:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hX5d7i1onM6KJjcxjt4YgWrUzJK2cIDgrBlA7uN5Mk=;
        b=MDzMptkIb51QzHUWu7AbFpA5KAhqkqvqW634w553OfQFwFEE3HK7Tzzn69XFElrD0CcikO
        Nos/r6ApkyvlF4CGhPALJqbyri9yDAPtH1f/bQFFVnMwtB1QuCNu43yGDXLvc/C8KPmCgf
        sMCNourTkI1D2+kWc7Fm4K5xVQFl8tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-mzLNlnliPHCl5vKZ2vvgKg-1; Thu, 03 Dec 2020 12:12:03 -0500
X-MC-Unique: mzLNlnliPHCl5vKZ2vvgKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 053AD805EE3;
        Thu,  3 Dec 2020 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6431F6085A;
        Thu,  3 Dec 2020 17:11:35 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v2 2/3] KVM: x86: introduce KVM_X86_QUIRK_TSC_HOST_ACCESS
Date:   Thu,  3 Dec 2020 19:11:17 +0200
Message-Id: <20201203171118.372391-3-mlevitsk@redhat.com>
In-Reply-To: <20201203171118.372391-1-mlevitsk@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This quirk reflects the fact that we currently treat MSR_IA32_TSC
and MSR_TSC_ADJUST access by the host (e.g qemu) in a way that is different
compared to an access from the guest.

For host's MSR_IA32_TSC read we currently always return L1 TSC value, and for
host's write we do the tsc synchronization.

For host's MSR_TSC_ADJUST write, we don't make the tsc 'jump' as we should
for this msr.

When the hypervisor uses the new TSC GET/SET state ioctls, all of this is no
longer needed, thus leave this enabled only with a quirk
which the hypervisor can disable.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/x86.c              | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 8e76d3701db3f..2a60fc6674164 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -404,6 +404,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	   (1 << 2)
 #define KVM_X86_QUIRK_OUT_7E_INC_RIP	   (1 << 3)
 #define KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT (1 << 4)
+#define KVM_X86_QUIRK_TSC_HOST_ACCESS      (1 << 5)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b8a2fe3a2398..aabded17abae4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3091,7 +3091,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_TSC_ADJUST:
 		if (guest_cpuid_has(vcpu, X86_FEATURE_TSC_ADJUST)) {
-			if (!msr_info->host_initiated) {
+			if (!msr_info->host_initiated ||
+			    !kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_TSC_HOST_ACCESS)) {
 				s64 adj = data - vcpu->arch.ia32_tsc_adjust_msr;
 				adjust_tsc_offset_guest(vcpu, adj);
 			}
@@ -3118,7 +3119,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.msr_ia32_power_ctl = data;
 		break;
 	case MSR_IA32_TSC:
-		if (msr_info->host_initiated) {
+		if (msr_info->host_initiated &&
+		    kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_TSC_HOST_ACCESS)) {
 			kvm_synchronize_tsc(vcpu, data);
 		} else {
 			u64 adj = kvm_compute_tsc_offset(vcpu, data) - vcpu->arch.l1_tsc_offset;
@@ -3409,17 +3411,24 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = vcpu->arch.msr_ia32_power_ctl;
 		break;
 	case MSR_IA32_TSC: {
+		u64 tsc_offset;
+
 		/*
 		 * Intel SDM states that MSR_IA32_TSC read adds the TSC offset
 		 * even when not intercepted. AMD manual doesn't explicitly
 		 * state this but appears to behave the same.
 		 *
-		 * On userspace reads and writes, however, we unconditionally
+		 * On userspace reads and writes, when KVM_X86_QUIRK_SPECIAL_TSC_READ
+		 * is present, however, we unconditionally
 		 * return L1's TSC value to ensure backwards-compatible
 		 * behavior for migration.
 		 */
-		u64 tsc_offset = msr_info->host_initiated ? vcpu->arch.l1_tsc_offset :
-							    vcpu->arch.tsc_offset;
+
+		if (msr_info->host_initiated &&
+		    kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_TSC_HOST_ACCESS))
+			tsc_offset = vcpu->arch.l1_tsc_offset;
+		else
+			tsc_offset = vcpu->arch.tsc_offset;
 
 		msr_info->data = kvm_scale_tsc(vcpu, rdtsc()) + tsc_offset;
 		break;
-- 
2.26.2

