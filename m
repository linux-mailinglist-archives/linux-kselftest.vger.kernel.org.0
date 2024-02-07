Return-Path: <linux-kselftest+bounces-4263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8FB84D09B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DD71C20DA1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87331350DA;
	Wed,  7 Feb 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPl/j3GQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7F84A21;
	Wed,  7 Feb 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328759; cv=none; b=d2CfiBDlkCV7Pl9D9HHPlFM2ZAhk8cATphAfVaG3uj6i6YGhMQqYplBwlHF7YsF0C2V+9h09ejXgY2yk6K2Uw115+bUf5AhdQJicIM4UdqD8guSmqpslQMD7cPNevcZnlok4tyDDUY7dabUAHfMKK8uctf010vHEQs9GFSIdW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328759; c=relaxed/simple;
	bh=edLH9zVNg+M5C8W3UpTDiXcfqi/CQzK1tlqmCjLesjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JunnZopjCoVdrb0PjgZC3eZ1NL7IA2YKJ2xmf7PbY4KS1itY+FMYO06X6EyBRwYBuU1H/JivrJ8VPF66wvwcu3KEsjLwadW/bQSQW3I2QVYwVwF9echbifTD72wDRjSXELHvqMZEB15ioEGb2mtqN3NWib14Nov+ItgSGdbAH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPl/j3GQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328754; x=1738864754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=edLH9zVNg+M5C8W3UpTDiXcfqi/CQzK1tlqmCjLesjM=;
  b=SPl/j3GQYzSjAvPegSB+me3LHOMz2S1EoYKc1pOjksiGxnH998BaLHvT
   BLP5Btq7JKTGZ/LPFqClpeVH3lEAxo0V7XkbViVRxTt9jFWtKa1yNGp4g
   xSkqDvFFA7yeyaVLO7dvVpUNXBiC9y02mrvcX0xPsMd7DoEhclVwB8J6p
   wGMW4w8oOSLCS+/CtEXRkfxATVqcDzNqNqnNjpC+cHpNapl8N4FA6947r
   /ue2ZN4Wlo4/82Mf6VEnBSjcoNO+U2NIzjyGe+L9wNYOHUHKoUg7il0rz
   U2Ohz3cPZemYpz5RJmCwfeDqfWIHNlUNcgmojJ70GwJ5C4Nlp+escOj4Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622603"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622603"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020734"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:56 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com,
	xin@zytor.com
Subject: [PATCH v2 13/25] KVM: VMX: Handle VMX nested exception for FRED
Date: Wed,  7 Feb 2024 09:26:33 -0800
Message-ID: <20240207172646.3981-14-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207172646.3981-1-xin3.li@intel.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set VMX nested exception bit in the VM-entry interruption information
VMCS field when injecting a nested exception using FRED event delivery
to ensure:
  1) The nested exception is injected on a correct stack level.
  2) The nested bit defined in FRED stack frame is set.

The event stack level used by FRED event delivery depends on whether the
event was a nested exception encountered during delivery of another event,
because a nested exception is "regarded" as happening on ring 0.  E.g.,
when #PF is configured to use stack level 1 in IA32_FRED_STKLVLS MSR:
  - nested #PF will be delivered on stack level 1 when encountered in
    ring 3.
  - normal #PF will be delivered on stack level 0 when encountered in
    ring 3.

The VMX nested-exception support ensures the correct event stack level is
chosen when a VM entry injects a nested exception.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Changes since v1:
* Set the nested flag when there is an original interrupt (Chao Gao).
---
 arch/x86/include/asm/kvm_host.h |  6 +++--
 arch/x86/include/asm/vmx.h      |  5 ++--
 arch/x86/kvm/svm/svm.c          |  4 +--
 arch/x86/kvm/vmx/vmx.c          |  8 ++++--
 arch/x86/kvm/x86.c              | 46 ++++++++++++++++++++++++++-------
 arch/x86/kvm/x86.h              |  1 +
 6 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0d88873eba63..ef278ee0b6ca 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -736,6 +736,7 @@ struct kvm_queued_exception {
 	u32 error_code;
 	unsigned long payload;
 	bool has_payload;
+	bool nested;
 };
 
 struct kvm_vcpu_arch {
@@ -2060,8 +2061,9 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
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
index 6b796c5c9c2b..68af74e48788 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -134,7 +134,7 @@
 #define VMX_BASIC_DUAL_MONITOR_TREATMENT	BIT_ULL(49)
 #define VMX_BASIC_INOUT				BIT_ULL(54)
 #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
-
+#define VMX_BASIC_NESTED_EXCEPTION		BIT_ULL(58)
 
 /* VMX_MISC bits and bitmasks */
 #define VMX_MISC_INTEL_PT			BIT_ULL(14)
@@ -407,8 +407,9 @@ enum vmcs_field {
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
index e90b429c84f1..c220b690a37c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4057,10 +4057,10 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 
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
index f622fb90a098..1f265d526daf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1891,6 +1891,8 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
 				event_data = to_vmx(vcpu)->fred_xfd_event_data;
 
 			vmcs_write64(INJECTED_EVENT_DATA, event_data);
+
+			intr_info |= ex->nested ? INTR_INFO_NESTED_EXCEPTION_MASK : 0;
 		}
 	}
 
@@ -7281,9 +7283,11 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu, bool vectoring)
 		}
 
 		if (event_id & INTR_INFO_DELIVER_CODE_MASK)
-			kvm_requeue_exception_e(vcpu, vector, vmcs_read32(error_code_field));
+			kvm_requeue_exception_e(vcpu, vector, vmcs_read32(error_code_field),
+						event_id & INTR_INFO_NESTED_EXCEPTION_MASK);
 		else
-			kvm_requeue_exception(vcpu, vector);
+			kvm_requeue_exception(vcpu, vector,
+					      event_id & INTR_INFO_NESTED_EXCEPTION_MASK);
 		break;
 	case INTR_TYPE_SOFT_INTR:
 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 00c0062726ae..725819262085 100644
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
@@ -696,6 +697,13 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 			vcpu->arch.exception.pending = true;
 			vcpu->arch.exception.injected = false;
 		}
+
+		vcpu->arch.exception.nested = vcpu->arch.exception.nested ||
+					      (kvm_is_fred_enabled(vcpu) &&
+					       ((reinject && nested) ||
+					        vcpu->arch.nmi_injected ||
+					        vcpu->arch.interrupt.injected));
+
 		vcpu->arch.exception.has_error_code = has_error;
 		vcpu->arch.exception.vector = nr;
 		vcpu->arch.exception.error_code = error_code;
@@ -725,8 +733,28 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 		vcpu->arch.exception.injected = false;
 		vcpu->arch.exception.pending = false;
 
+		/*
+		 * A #DF is NOT a nested event per its definition, however per
+		 * FRED spec 5.0 Appendix B, its delivery determines the new
+		 * stack level as is done for events occurring when CPL = 0.
+		 */
+		vcpu->arch.exception.nested = false;
+
 		kvm_queue_exception_e(vcpu, DF_VECTOR, 0);
 	} else {
+		/*
+		 * FRED spec 5.0 Appendix B: delivery of a nested exception
+		 * determines the new stack level as is done for events
+		 * occurring when CPL = 0.
+		 *
+		 * IOW, FRED event delivery of an event encountered in ring 3
+		 * normally uses stack level 0 unconditionally.  However, if
+		 * the event is an exception nested on any earlier event,
+		 * delivery of the nested exception will consult the FRED MSR
+		 * IA32_FRED_STKLVLS to determine which stack level to use.
+		 */
+		vcpu->arch.exception.nested = kvm_is_fred_enabled(vcpu);
+
 		/* replace previous exception with a new one in a hope
 		   that instruction re-execution will regenerate lost
 		   exception */
@@ -736,20 +764,20 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 
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
 
@@ -757,7 +785,7 @@ static void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
 				    u32 error_code, unsigned long payload)
 {
 	kvm_multiple_exception(vcpu, nr, true, error_code,
-			       true, payload, false);
+			       true, payload, false, false);
 }
 
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err)
@@ -829,13 +857,13 @@ void kvm_inject_nmi(struct kvm_vcpu *vcpu)
 
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
index 9a52016ebf5a..c1f1d5696080 100644
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
2.43.0


