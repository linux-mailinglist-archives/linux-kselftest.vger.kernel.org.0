Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6DB7E5DA3
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjKHTAd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjKHTAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F5A211D;
        Wed,  8 Nov 2023 11:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470023; x=1731006023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bFpGIxylK8ZmSMW102hy9IXnv91TDM4GB/lAo5qMasw=;
  b=MJylD18kXkXZqAWyjXz0YKXklSXZNjGGz42kvWw/nfQnDm34KVZK7PK9
   a7JP8NlItAtm7CKWDKT1nehIoBFIJZnYKDqh+1zLwgeNPGLJyvDQXt5hl
   OYdGTiccmWa11R3TdQsl8F6oCCq56pbh3ga2Zr/bNAbz3XbGcnlEabo8c
   MbxTrOsJA67ZDh50jqEScmAXng0CWd9EtfRGFffKETLQO+WwgvLrFew6r
   BF2SKzXKIpi2qGW//TbUtgAeXWe9yEij9fm/6ckixK+GK6nFRURDH3coZ
   HiqeCJHoPtTssqrimr317krnzWwWC7J9ROdyZRYSCy6U6bJQSM1/pJX70
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486348"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486348"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892473"
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
Subject: [PATCH v1 12/23] KVM: VMX: Handle FRED event data
Date:   Wed,  8 Nov 2023 10:29:52 -0800
Message-ID: <20231108183003.5981-13-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/vmx.h |  4 ++
 arch/x86/kvm/vmx/vmx.c     | 84 +++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/x86.c         | 10 ++++-
 3 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index d54a1a1057b0..97729248e844 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -253,8 +253,12 @@ enum vmcs_field {
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
index 58d01e845804..67fd4a56d031 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1880,9 +1880,30 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
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
+			else if (is_nm_fault(intr_info) &&
+				 vcpu->arch.guest_fpu.fpstate->xfd)
+				event_data = vcpu->arch.guest_fpu.xfd_err;
+
+			vmcs_write64(INJECTED_EVENT_DATA, event_data);
+		}
+	}
+
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
 
 	vmx_clear_hlt(vcpu);
@@ -7226,7 +7247,8 @@ static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
 static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 				      u32 idt_vectoring_info,
 				      int instr_len_field,
-				      int error_code_field)
+				      int error_code_field,
+				      int event_data_field)
 {
 	u8 vector;
 	int type;
@@ -7260,6 +7282,37 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
 		fallthrough;
 	case INTR_TYPE_HARD_EXCEPTION:
+		if (kvm_is_fred_enabled(vcpu) && event_data_field) {
+			/*
+			 * Save original-event data for being used as injected-event data.
+			 */
+			u64 event_data = vmcs_read64(event_data_field);
+
+			switch (vector) {
+			case DB_VECTOR:
+				get_debugreg(vcpu->arch.dr6, 6);
+				WARN_ON(vcpu->arch.dr6 != (event_data ^ DR6_RESERVED));
+				vcpu->arch.dr6 = event_data ^ DR6_RESERVED;
+				break;
+			case NM_VECTOR:
+				if (vcpu->arch.guest_fpu.fpstate->xfd) {
+					rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+					WARN_ON(vcpu->arch.guest_fpu.xfd_err != event_data);
+					vcpu->arch.guest_fpu.xfd_err = event_data;
+				} else {
+					WARN_ON(event_data != 0);
+				}
+				break;
+			case PF_VECTOR:
+				WARN_ON(vcpu->arch.cr2 != event_data);
+				vcpu->arch.cr2 = event_data;
+				break;
+			default:
+				WARN_ON(event_data != 0);
+				break;
+			}
+		}
+
 		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK) {
 			u32 err = vmcs_read32(error_code_field);
 			kvm_requeue_exception_e(vcpu, vector, err);
@@ -7279,9 +7332,11 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 
 static void vmx_complete_interrupts(struct vcpu_vmx *vmx)
 {
-	__vmx_complete_interrupts(&vmx->vcpu, vmx->idt_vectoring_info,
+	__vmx_complete_interrupts(&vmx->vcpu,
+				  vmx->idt_vectoring_info,
 				  VM_EXIT_INSTRUCTION_LEN,
-				  IDT_VECTORING_ERROR_CODE);
+				  IDT_VECTORING_ERROR_CODE,
+				  ORIGINAL_EVENT_DATA);
 }
 
 static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
@@ -7289,7 +7344,8 @@ static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
 	__vmx_complete_interrupts(vcpu,
 				  vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
 				  VM_ENTRY_INSTRUCTION_LEN,
-				  VM_ENTRY_EXCEPTION_ERROR_CODE);
+				  VM_ENTRY_EXCEPTION_ERROR_CODE,
+				  0);
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);
 }
@@ -7406,6 +7462,24 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
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
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c5a55810647f..d190bfc63fc4 100644
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
2.42.0

