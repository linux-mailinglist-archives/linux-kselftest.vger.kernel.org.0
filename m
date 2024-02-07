Return-Path: <linux-kselftest+bounces-4260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4CB84D08C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1B41C21F9B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D36112EBD8;
	Wed,  7 Feb 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fO7IYgeQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D311292F1;
	Wed,  7 Feb 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328756; cv=none; b=VZRVu6p36VNJd0ddFG8HKv9tfi7s6PlqsLGDyp9B7q6tcmXv8XwA32oZ1rkOeGh6ZMzBF6mgTI8QOZpw4dEp6fUfru2ezAQM2PqlEYGMRBYvsjkw17+K+2woXH7w8tP/fSsa47iOvvmou2JJWg8y3R/+TpBpMY9+JXCgFlhzLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328756; c=relaxed/simple;
	bh=hhNjuLldlaiHvg8yHAWCF4e5LFJRIyWq4h1vGubEja0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQoa2B7Ie0UgU8V2A7PGOYwnjJLNo5IjVdwmHilLGAogJ52UD/Uh58NftfVEwZLr3WixpmJilDmFMZvvX+dBWlOfd8FWBICdbFCkGEhamkQtb20/vuv3P406DYW6vrcK8/JNftbk168q96jSYEN6Rs2KAQRS01Jb9Fawp8QTZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fO7IYgeQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328751; x=1738864751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hhNjuLldlaiHvg8yHAWCF4e5LFJRIyWq4h1vGubEja0=;
  b=fO7IYgeQUbqdeSvfHMkunhdYm2z7KFbce0Khf1MZZPApeSHq6avBBd/P
   AfDOyLZZnCop5Tujmbb5wVprnMfVWycXAIGDJ6p9HHSyUCOktfyfmyElk
   zVRVrEq22tAcURuQ3tt2MX4JpjY00B2ClRJqerExVzGrRzzbrbKTj6bKW
   Pf3d+5yRnb1hgYvSVgYtbspKbT8eiWzZg6U076iKzzWtuevZnybzfG/6G
   HWWfQ/28nTQ3nC+mpqEdAUlcWEFD1CEDGzYlrXDLtg7rlGtBqrZmH87v+
   HiehAvIkEifonG9ctyHJBMX+biETwB4u/UpaJBHHStXOUQnUCfSb5B/Th
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622581"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622581"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020730"
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
Subject: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
Date: Wed,  7 Feb 2024 09:26:32 -0800
Message-ID: <20240207172646.3981-13-xin3.li@intel.com>
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

Set injected-event data when injecting a #PF, #DB, or #NM caused
by extended feature disable using FRED event delivery, and save
original-event data for being used as injected-event data.

Unlike IDT using some extra CPU register as part of an event
context, e.g., %cr2 for #PF, FRED saves a complete event context
in its stack frame, e.g., FRED saves the faulting linear address
of a #PF into the event data field defined in its stack frame.

Thus a new VMX control field called injected-event data is added
to provide the event data that will be pushed into a FRED stack
frame for VM entries that inject an event using FRED event delivery.
In addition, a new VM exit information field called original-event
data is added to store the event data that would have saved into a
FRED stack frame for VM exits that occur during FRED event delivery.
After such a VM exit is handled to allow the original-event to be
delivered, the data in the original-event data VMCS field needs to
be set into the injected-event data VMCS field for the injection of
the original event.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Change since v1:
* Document event data should be equal to CR2/DR6/IA32_XFD_ERR instead
  of using WARN_ON() (Chao Gao).
* Zero event data if a #NM was not caused by extended feature disable
  (Chao Gao).
---
 arch/x86/include/asm/vmx.h |   4 ++
 arch/x86/kvm/vmx/vmx.c     | 109 ++++++++++++++++++++++++++++---------
 arch/x86/kvm/vmx/vmx.h     |   1 +
 arch/x86/kvm/x86.c         |  10 +++-
 4 files changed, 95 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 4889754415b5..6b796c5c9c2b 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -256,8 +256,12 @@ enum vmcs_field {
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
 	SECONDARY_VM_EXIT_CONTROLS	= 0x00002044,
 	SECONDARY_VM_EXIT_CONTROLS_HIGH	= 0x00002045,
+	INJECTED_EVENT_DATA		= 0x00002052,
+	INJECTED_EVENT_DATA_HIGH	= 0x00002053,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
+	ORIGINAL_EVENT_DATA		= 0x00002404,
+	ORIGINAL_EVENT_DATA_HIGH	= 0x00002405,
 	VMCS_LINK_POINTER               = 0x00002800,
 	VMCS_LINK_POINTER_HIGH          = 0x00002801,
 	GUEST_IA32_DEBUGCTL             = 0x00002802,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ee61d2c25cb0..f622fb90a098 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1871,9 +1871,29 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
 		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
 			     vmx->vcpu.arch.event_exit_inst_len);
 		intr_info |= INTR_TYPE_SOFT_EXCEPTION;
-	} else
+	} else {
 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
 
+		if (kvm_is_fred_enabled(vcpu)) {
+			u64 event_data = 0;
+
+			if (is_debug(intr_info))
+				/*
+				 * Compared to DR6, FRED #DB event data saved on
+				 * the stack frame have bits 4 ~ 11 and 16 ~ 31
+				 * inverted, i.e.,
+				 *   fred_db_event_data = dr6 ^ 0xFFFF0FF0UL
+				 */
+				event_data = vcpu->arch.dr6 ^ DR6_RESERVED;
+			else if (is_page_fault(intr_info))
+				event_data = vcpu->arch.cr2;
+			else if (is_nm_fault(intr_info))
+				event_data = to_vmx(vcpu)->fred_xfd_event_data;
+
+			vmcs_write64(INJECTED_EVENT_DATA, event_data);
+		}
+	}
+
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
 
 	vmx_clear_hlt(vcpu);
@@ -7082,8 +7102,11 @@ static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 	 *
 	 * Queuing exception is done in vmx_handle_exit. See comment there.
 	 */
-	if (vcpu->arch.guest_fpu.fpstate->xfd)
+	if (vcpu->arch.guest_fpu.fpstate->xfd) {
 		rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+		to_vmx(vcpu)->fred_xfd_event_data = vcpu->arch.cr0 & X86_CR0_TS
+			? 0 : vcpu->arch.guest_fpu.xfd_err;
+	}
 }
 
 static void handle_exception_irqoff(struct vcpu_vmx *vmx)
@@ -7199,29 +7222,28 @@ static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
 					      vmx->loaded_vmcs->entry_time));
 }
 
-static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
-				      u32 idt_vectoring_info,
-				      int instr_len_field,
-				      int error_code_field)
+static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu, bool vectoring)
 {
-	u8 vector;
-	int type;
-	bool idtv_info_valid;
-
-	idtv_info_valid = idt_vectoring_info & VECTORING_INFO_VALID_MASK;
+	u32 event_id = vectoring ? to_vmx(vcpu)->idt_vectoring_info
+				 : vmcs_read32(VM_ENTRY_INTR_INFO_FIELD);
+	int instr_len_field = vectoring ? VM_EXIT_INSTRUCTION_LEN
+					: VM_ENTRY_INSTRUCTION_LEN;
+	int error_code_field = vectoring ? IDT_VECTORING_ERROR_CODE
+					 : VM_ENTRY_EXCEPTION_ERROR_CODE;
+	int event_data_field = vectoring ? ORIGINAL_EVENT_DATA
+					 : INJECTED_EVENT_DATA;
+	u8 vector = event_id & INTR_INFO_VECTOR_MASK;
+	int type = event_id & INTR_INFO_INTR_TYPE_MASK;
 
 	vcpu->arch.nmi_injected = false;
 	kvm_clear_exception_queue(vcpu);
 	kvm_clear_interrupt_queue(vcpu);
 
-	if (!idtv_info_valid)
+	if (!(event_id & INTR_INFO_VALID_MASK))
 		return;
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
-	vector = idt_vectoring_info & VECTORING_INFO_VECTOR_MASK;
-	type = idt_vectoring_info & VECTORING_INFO_TYPE_MASK;
-
 	switch (type) {
 	case INTR_TYPE_NMI_INTR:
 		vcpu->arch.nmi_injected = true;
@@ -7236,10 +7258,31 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
 		fallthrough;
 	case INTR_TYPE_HARD_EXCEPTION:
-		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK) {
-			u32 err = vmcs_read32(error_code_field);
-			kvm_requeue_exception_e(vcpu, vector, err);
-		} else
+		if (kvm_is_fred_enabled(vcpu)) {
+			/* Save event data for being used as injected-event data */
+			u64 event_data = vmcs_read64(event_data_field);
+
+			switch (vector) {
+			case DB_VECTOR:
+				/* %dr6 should be equal to (event_data ^ DR6_RESERVED) */
+				vcpu->arch.dr6 = event_data ^ DR6_RESERVED;
+				break;
+			case NM_VECTOR:
+				to_vmx(vcpu)->fred_xfd_event_data = event_data;
+				break;
+			case PF_VECTOR:
+				/* %cr2 should be equal to event_data */
+				vcpu->arch.cr2 = event_data;
+				break;
+			default:
+				WARN_ON(event_data != 0);
+				break;
+			}
+		}
+
+		if (event_id & INTR_INFO_DELIVER_CODE_MASK)
+			kvm_requeue_exception_e(vcpu, vector, vmcs_read32(error_code_field));
+		else
 			kvm_requeue_exception(vcpu, vector);
 		break;
 	case INTR_TYPE_SOFT_INTR:
@@ -7255,18 +7298,12 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 
 static void vmx_complete_interrupts(struct vcpu_vmx *vmx)
 {
-	__vmx_complete_interrupts(&vmx->vcpu, vmx->idt_vectoring_info,
-				  VM_EXIT_INSTRUCTION_LEN,
-				  IDT_VECTORING_ERROR_CODE);
+	__vmx_complete_interrupts(&vmx->vcpu, true);
 }
 
 static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
 {
-	__vmx_complete_interrupts(vcpu,
-				  vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
-				  VM_ENTRY_INSTRUCTION_LEN,
-				  VM_ENTRY_EXCEPTION_ERROR_CODE);
-
+	__vmx_complete_interrupts(vcpu, false);
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);
 }
 
@@ -7382,6 +7419,24 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	vmx_disable_fb_clear(vmx);
 
+	/*
+	 * %cr2 needs to be saved after a VM exit and restored before a VM
+	 * entry in case a VM exit happens immediately after delivery of a
+	 * guest #PF but before guest reads %cr2.
+	 *
+	 * A FRED guest should read its #PF faulting linear address from
+	 * the event data field in its FRED stack frame instead of %cr2.
+	 * But the FRED 5.0 spec still requires a FRED CPU to update %cr2
+	 * in the normal way, thus %cr2 is still updated even for a FRED
+	 * guest.
+	 *
+	 * Note, an NMI could interrupt KVM:
+	 *   1) after VM exit but before CR2 is saved.
+	 *   2) after CR2 is restored but before VM entry.
+	 * And a #PF could happen durng NMI handlng, which overwrites %cr2.
+	 * Thus exc_nmi() should save and restore %cr2 upon entering and
+	 * before leaving to make sure %cr2 not corrupted.
+	 */
 	if (vcpu->arch.cr2 != native_read_cr2())
 		native_write_cr2(vcpu->arch.cr2);
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 176ad39be406..d5738c5a4814 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -266,6 +266,7 @@ struct vcpu_vmx {
 	u32                   exit_intr_info;
 	u32                   idt_vectoring_info;
 	ulong                 rflags;
+	u64                   fred_xfd_event_data;
 
 	/*
 	 * User return MSRs are always emulated when enabled in the guest, but
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4e8d60f248e3..00c0062726ae 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -680,8 +680,14 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 			vcpu->arch.exception.injected = true;
 			if (WARN_ON_ONCE(has_payload)) {
 				/*
-				 * A reinjected event has already
-				 * delivered its payload.
+				 * For a reinjected event, KVM delivers its
+				 * payload through:
+				 *   #PF: save %cr2 into arch.cr2 immediately
+				 *        after VM exits.
+				 *   #DB: save %dr6 into arch.dr6 later in
+				 *        sync_dirty_debug_regs().
+				 *
+				 * For FRED guest, see __vmx_complete_interrupts().
 				 */
 				has_payload = false;
 				payload = 0;
-- 
2.43.0


