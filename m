Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6518B7E5DA5
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjKHTAe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjKHTAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F91211F;
        Wed,  8 Nov 2023 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470024; x=1731006024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cIflAivR9VCqnr0B5EZbFjn1ryM/tjY6g5E/Ilbnc7k=;
  b=DNtVIFN2FpOfmXbsAC+XDvhzvrv22e15/2v19iw+PG0ZVNkQoEH4cMT/
   QRw2z4CV60M8Zr9l+kqcg7ZKL9N1spMoEBXMceE7K72+qP5P5o5b2pfPa
   VOQPr4IMBqFeByLOB8A5s+vNUgJfFE8Pi5h4UnQY3FYrYxkRpF7gUOr3Q
   4bHw0RooBFg5as8A9A7rGDSn2/CdBUhdDLVHK7E8IyNTx+fQnlpK18t71
   J+by/qbuJkt/UH4lsW/rukhtjzkZAObx76cgBEjCfMZstuPt8qbp8R0xB
   Sp+9ddIstJ/ONaZ+CCyIahUREMqiozlyW7Ojs/R0hHqYwaegUASwpRwki
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486358"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486358"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892480"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:22 -0800
From:   Xin Li <xin3.li@intel.com>
To:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, vkuznets@redhat.com, peterz@infradead.org,
        ravi.v.shankar@intel.com
Subject: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Date:   Wed,  8 Nov 2023 10:29:53 -0800
Message-ID: <20231108183003.5981-14-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Set VMX nested exception bit in the VM-entry interruption information
VMCS field when injecting a nested exception using FRED event delivery
to ensure:
  1) The nested exception is injected on a correct stack level.
  2) The nested bit defined in FRED stack frame is set.

The event stack level used by FRED event delivery depends on whether the
event was a nested exception encountered during delivery of another event,
because a nested exception is "regarded" as happening on ring 0.  E.g.,
when #PF is configured to use stack level 1 in IA32_FRED_STKLVLS MSR:
  - nested #PF will be delivered on stack level 1 when triggered from
    user level.
  - normal #PF will be delivered on stack level 0 when triggered from
    user level.

The VMX nested-exception support ensures the correct event stack level is
chosen when a VM entry injects a nested exception.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++--
 arch/x86/include/asm/vmx.h      |  4 +++-
 arch/x86/kvm/svm/svm.c          |  4 ++--
 arch/x86/kvm/vmx/vmx.c          | 26 +++++++++++++++++++++-----
 arch/x86/kvm/x86.c              | 22 +++++++++++++---------
 arch/x86/kvm/x86.h              |  1 +
 6 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1e5a6d9439f8..2ae8cc83dbb3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -721,6 +721,7 @@ struct kvm_queued_exception {
 	u32 error_code;
 	unsigned long payload;
 	bool has_payload;
+	bool nested;
 };
 
 struct kvm_vcpu_arch {
@@ -2015,8 +2016,9 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
-void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr);
-void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
+void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr, bool nested);
+void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr,
+			     u32 error_code, bool nested);
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
 void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				    struct x86_exception *fault);
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 97729248e844..020dfd3f6b44 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -132,6 +132,7 @@
 /* VMX_BASIC bits and bitmasks */
 #define VMX_BASIC_32BIT_PHYS_ADDR_ONLY		BIT_ULL(48)
 #define VMX_BASIC_INOUT				BIT_ULL(54)
+#define VMX_BASIC_NESTED_EXCEPTION		BIT_ULL(58)
 
 /* VMX_MISC bits and bitmasks */
 #define VMX_MISC_INTEL_PT			BIT_ULL(14)
@@ -404,8 +405,9 @@ enum vmcs_field {
 #define INTR_INFO_INTR_TYPE_MASK        0x700           /* 10:8 */
 #define INTR_INFO_DELIVER_CODE_MASK     0x800           /* 11 */
 #define INTR_INFO_UNBLOCK_NMI		0x1000		/* 12 */
+#define INTR_INFO_NESTED_EXCEPTION_MASK	0x2000		/* 13 */
 #define INTR_INFO_VALID_MASK            0x80000000      /* 31 */
-#define INTR_INFO_RESVD_BITS_MASK       0x7ffff000
+#define INTR_INFO_RESVD_BITS_MASK       0x7fffd000
 
 #define VECTORING_INFO_VECTOR_MASK           	INTR_INFO_VECTOR_MASK
 #define VECTORING_INFO_TYPE_MASK        	INTR_INFO_INTR_TYPE_MASK
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 712146312358..78a9ff5cfcad 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4047,10 +4047,10 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 
 		if (exitintinfo & SVM_EXITINTINFO_VALID_ERR) {
 			u32 err = svm->vmcb->control.exit_int_info_err;
-			kvm_requeue_exception_e(vcpu, vector, err);
+			kvm_requeue_exception_e(vcpu, vector, err, false);
 
 		} else
-			kvm_requeue_exception(vcpu, vector);
+			kvm_requeue_exception(vcpu, vector, false);
 		break;
 	case SVM_EXITINTINFO_TYPE_INTR:
 		kvm_queue_interrupt(vcpu, vector, false);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 67fd4a56d031..518e68ee5a0d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1901,6 +1901,8 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
 				event_data = vcpu->arch.guest_fpu.xfd_err;
 
 			vmcs_write64(INJECTED_EVENT_DATA, event_data);
+
+			intr_info |= ex->nested ? INTR_INFO_NESTED_EXCEPTION_MASK : 0;
 		}
 	}
 
@@ -2851,6 +2853,19 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	/* IA-32 SDM Vol 3B: 64-bit CPUs always have VMX_BASIC_MSR[48]==0. */
 	if (basic_msr & VMX_BASIC_32BIT_PHYS_ADDR_ONLY)
 		return -EIO;
+
+	/*
+	 * FRED draft Spec 5.0 Section 9.2:
+	 *
+	 * Any processor that enumerates support for FRED transitions
+	 * will also enumerate VMX nested-exception support.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    !(basic_msr & VMX_BASIC_NESTED_EXCEPTION)) {
+		pr_warn_once("FRED enabled but no VMX nested-exception support\n");
+		if (error_on_inconsistent_vmcs_config)
+			return -EIO;
+	}
 #endif
 
 	/* Require Write-Back (WB) memory type for VMCS accesses. */
@@ -7313,11 +7328,12 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 			}
 		}
 
-		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK) {
-			u32 err = vmcs_read32(error_code_field);
-			kvm_requeue_exception_e(vcpu, vector, err);
-		} else
-			kvm_requeue_exception(vcpu, vector);
+		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK)
+			kvm_requeue_exception_e(vcpu, vector, vmcs_read32(error_code_field),
+						idt_vectoring_info & INTR_INFO_NESTED_EXCEPTION_MASK);
+		else
+			kvm_requeue_exception(vcpu, vector,
+					      idt_vectoring_info & INTR_INFO_NESTED_EXCEPTION_MASK);
 		break;
 	case INTR_TYPE_SOFT_INTR:
 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d190bfc63fc4..51c07730f1b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -645,7 +645,8 @@ static void kvm_leave_nested(struct kvm_vcpu *vcpu)
 
 static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 		unsigned nr, bool has_error, u32 error_code,
-	        bool has_payload, unsigned long payload, bool reinject)
+	        bool has_payload, unsigned long payload,
+		bool reinject, bool nested)
 {
 	u32 prev_nr;
 	int class1, class2;
@@ -678,6 +679,7 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 			 */
 			WARN_ON_ONCE(kvm_is_exception_pending(vcpu));
 			vcpu->arch.exception.injected = true;
+			vcpu->arch.exception.nested = nested;
 			if (WARN_ON_ONCE(has_payload)) {
 				/*
 				 * For a reinjected event, KVM delivers its
@@ -727,6 +729,8 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 
 		kvm_queue_exception_e(vcpu, DF_VECTOR, 0);
 	} else {
+		vcpu->arch.exception.nested = true;
+
 		/* replace previous exception with a new one in a hope
 		   that instruction re-execution will regenerate lost
 		   exception */
@@ -736,20 +740,20 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr)
 {
-	kvm_multiple_exception(vcpu, nr, false, 0, false, 0, false);
+	kvm_multiple_exception(vcpu, nr, false, 0, false, 0, false, false);
 }
 EXPORT_SYMBOL_GPL(kvm_queue_exception);
 
-void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr)
+void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr, bool nested)
 {
-	kvm_multiple_exception(vcpu, nr, false, 0, false, 0, true);
+	kvm_multiple_exception(vcpu, nr, false, 0, false, 0, true, nested);
 }
 EXPORT_SYMBOL_GPL(kvm_requeue_exception);
 
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr,
 			   unsigned long payload)
 {
-	kvm_multiple_exception(vcpu, nr, false, 0, true, payload, false);
+	kvm_multiple_exception(vcpu, nr, false, 0, true, payload, false, false);
 }
 EXPORT_SYMBOL_GPL(kvm_queue_exception_p);
 
@@ -757,7 +761,7 @@ static void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
 				    u32 error_code, unsigned long payload)
 {
 	kvm_multiple_exception(vcpu, nr, true, error_code,
-			       true, payload, false);
+			       true, payload, false, false);
 }
 
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err)
@@ -829,13 +833,13 @@ void kvm_inject_nmi(struct kvm_vcpu *vcpu)
 
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
 {
-	kvm_multiple_exception(vcpu, nr, true, error_code, false, 0, false);
+	kvm_multiple_exception(vcpu, nr, true, error_code, false, 0, false, false);
 }
 EXPORT_SYMBOL_GPL(kvm_queue_exception_e);
 
-void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
+void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code, bool nested)
 {
-	kvm_multiple_exception(vcpu, nr, true, error_code, false, 0, true);
+	kvm_multiple_exception(vcpu, nr, true, error_code, false, 0, true, nested);
 }
 EXPORT_SYMBOL_GPL(kvm_requeue_exception_e);
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 60da8cbe6759..63e543c6834b 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -108,6 +108,7 @@ static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.exception.pending = false;
 	vcpu->arch.exception.injected = false;
+	vcpu->arch.exception.nested = false;
 	vcpu->arch.exception_vmexit.pending = false;
 }
 
-- 
2.42.0

