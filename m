Return-Path: <linux-kselftest+bounces-4267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4584D0AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BCE1F2631A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830513665C;
	Wed,  7 Feb 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmPJLWKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9D132C0B;
	Wed,  7 Feb 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328763; cv=none; b=dvVOLoQ4/zF2Ym90rrm2tuS+0P1yJuXKbanwh6A0xMpk2MBNuOb+5Wn1suidqLuhb81TsepqPKUrEPidlJVKjEwL8bCPCuRv2cn9Amm48ha9LzYbtWDCiW5fuE3avic2LiCbtXQNSCecidg1UJ0dLcQBuyd8c8T1uA1UK6Nw0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328763; c=relaxed/simple;
	bh=YtO5DWyhvAtwXcTgipQxc/ReOppALwE6U4QgY3DH1UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrzkPeJnVcUfHAYTEhKMxNQaXMkR/wQc849akw7futdh1iisXQUq/scwnHxdkelvrNJSK4B+3cMP5ojyiX5gaSWcTGdwfK+Nk+Fvqvb2H4Jy7YzxeynCYUbCWrCXE79e3uXxacfuiENGdxA8Dj94qIUtfFP9SOhtiKjykoZC7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmPJLWKC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328758; x=1738864758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YtO5DWyhvAtwXcTgipQxc/ReOppALwE6U4QgY3DH1UI=;
  b=dmPJLWKCtYIFUriIpSKn5pfOkhA5cMfZHBuSlB/cXeSwCcNjZZ1EhiWt
   LEzTRxJf9X67cdzHtkAMkrnz8uiUbBbATuiPZ0QBZHtJEfU4fOefNuM/n
   xQ+mcGjva2ol1XwM57Ewk19yNU/jsjX18JcMWu3CB3LQWavfuOUhwYmwF
   5A287osD31le2ryi+CtH/b70XuVutLndF8N/7oBriptHe3YWDUg977V03
   KgWo4151zmVNdcuceGDh4EvBRQhuHPsDYkiFSMJbpuDVTGhRa64haVqhV
   tCPyMWmpjAwnDYpspuco1fcmWuDBf8rZ0sjaNDEzlX3IRYiKFAfeU0i3n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622657"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622657"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020755"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:58 -0800
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
Subject: [PATCH v2 19/25] KVM: nVMX: Add FRED VMCS fields
Date: Wed,  7 Feb 2024 09:26:39 -0800
Message-ID: <20240207172646.3981-20-xin3.li@intel.com>
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

Add FRED VMCS fields to nested VMX context management.

Todo: change VMCS12_REVISION, as struct vmcs12 is changed.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Change since v1:
* Remove hyperv TLFS related changes (Jeremi Piotrowski).
* Use kvm_cpu_cap_has() instead of cpu_feature_enabled() (Chao Gao).
---
 Documentation/virt/kvm/x86/nested-vmx.rst | 18 +++++
 arch/x86/kvm/vmx/nested.c                 | 91 +++++++++++++++++++----
 arch/x86/kvm/vmx/vmcs12.c                 | 18 +++++
 arch/x86/kvm/vmx/vmcs12.h                 | 36 +++++++++
 arch/x86/kvm/vmx/vmcs_shadow_fields.h     |  4 +
 5 files changed, 152 insertions(+), 15 deletions(-)

diff --git a/Documentation/virt/kvm/x86/nested-vmx.rst b/Documentation/virt/kvm/x86/nested-vmx.rst
index e64ef231f310..87fa9f3877ab 100644
--- a/Documentation/virt/kvm/x86/nested-vmx.rst
+++ b/Documentation/virt/kvm/x86/nested-vmx.rst
@@ -218,6 +218,24 @@ struct shadow_vmcs is ever changed.
 		u16 host_gs_selector;
 		u16 host_tr_selector;
 		u64 secondary_vm_exit_controls;
+		u64 guest_ia32_fred_config;
+		u64 guest_ia32_fred_rsp1;
+		u64 guest_ia32_fred_rsp2;
+		u64 guest_ia32_fred_rsp3;
+		u64 guest_ia32_fred_stklvls;
+		u64 guest_ia32_fred_ssp1;
+		u64 guest_ia32_fred_ssp2;
+		u64 guest_ia32_fred_ssp3;
+		u64 host_ia32_fred_config;
+		u64 host_ia32_fred_rsp1;
+		u64 host_ia32_fred_rsp2;
+		u64 host_ia32_fred_rsp3;
+		u64 host_ia32_fred_stklvls;
+		u64 host_ia32_fred_ssp1;
+		u64 host_ia32_fred_ssp2;
+		u64 host_ia32_fred_ssp3;
+		u64 injected_event_data;
+		u64 original_event_data;
 	};
 
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 94da6a0a2f81..f9c1fbeac302 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -686,6 +686,9 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
+
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
+					 MSR_IA32_FRED_RSP0, MSR_TYPE_RW);
 #endif
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_IA32_SPEC_CTRL, MSR_TYPE_RW);
@@ -2498,6 +2501,8 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 			     vmcs12->vm_entry_instruction_len);
 		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
 			     vmcs12->guest_interruptibility_info);
+		if (kvm_cpu_cap_has(X86_FEATURE_FRED))
+			vmcs_write64(INJECTED_EVENT_DATA, vmcs12->injected_event_data);
 		vmx->loaded_vmcs->nmi_known_unmasked =
 			!(vmcs12->guest_interruptibility_info & GUEST_INTR_STATE_NMI);
 	} else {
@@ -2548,6 +2553,17 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
 		vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
 
+		if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+			vmcs_write64(GUEST_IA32_FRED_CONFIG, vmcs12->guest_ia32_fred_config);
+			vmcs_write64(GUEST_IA32_FRED_RSP1, vmcs12->guest_ia32_fred_rsp1);
+			vmcs_write64(GUEST_IA32_FRED_RSP2, vmcs12->guest_ia32_fred_rsp2);
+			vmcs_write64(GUEST_IA32_FRED_RSP3, vmcs12->guest_ia32_fred_rsp3);
+			vmcs_write64(GUEST_IA32_FRED_STKLVLS, vmcs12->guest_ia32_fred_stklvls);
+			vmcs_write64(GUEST_IA32_FRED_SSP1, vmcs12->guest_ia32_fred_ssp1);
+			vmcs_write64(GUEST_IA32_FRED_SSP2, vmcs12->guest_ia32_fred_ssp2);
+			vmcs_write64(GUEST_IA32_FRED_SSP3, vmcs12->guest_ia32_fred_ssp3);
+		}
+
 		vmx->segment_cache.bitmask = 0;
 	}
 
@@ -3835,6 +3851,22 @@ vmcs12_guest_cr4(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 			vcpu->arch.cr4_guest_owned_bits));
 }
 
+static inline unsigned long
+nested_vmx_get_event_data(struct kvm_vcpu *vcpu, bool for_ex_vmexit)
+{
+	struct kvm_queued_exception *ex = for_ex_vmexit ?
+		&vcpu->arch.exception_vmexit : &vcpu->arch.exception;
+
+	if (ex->has_payload)
+		return ex->payload;
+	else if (ex->vector == PF_VECTOR)
+		return vcpu->arch.cr2;
+	else if (ex->vector == DB_VECTOR)
+		return (vcpu->arch.dr6 & ~DR6_BT) ^ DR6_ACTIVE_LOW;
+	else
+		return 0;
+}
+
 static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 				      struct vmcs12 *vmcs12,
 				      u32 vm_exit_reason, u32 exit_intr_info)
@@ -3842,6 +3874,8 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 	u32 idt_vectoring;
 	unsigned int nr;
 
+	vmcs12->original_event_data = 0;
+
 	/*
 	 * Per the SDM, VM-Exits due to double and triple faults are never
 	 * considered to occur during event delivery, even if the double/triple
@@ -3880,6 +3914,12 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 				vcpu->arch.exception.error_code;
 		}
 
+		idt_vectoring |= vcpu->arch.exception.nested ?
+				INTR_INFO_NESTED_EXCEPTION_MASK : 0;
+
+		vmcs12->original_event_data =
+			nested_vmx_get_event_data(vcpu, false);
+
 		vmcs12->idt_vectoring_info_field = idt_vectoring;
 	} else if (vcpu->arch.nmi_injected) {
 		vmcs12->idt_vectoring_info_field =
@@ -3970,19 +4010,7 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu)
 	struct kvm_queued_exception *ex = &vcpu->arch.exception_vmexit;
 	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
-	unsigned long exit_qual;
-
-	if (ex->has_payload) {
-		exit_qual = ex->payload;
-	} else if (ex->vector == PF_VECTOR) {
-		exit_qual = vcpu->arch.cr2;
-	} else if (ex->vector == DB_VECTOR) {
-		exit_qual = vcpu->arch.dr6;
-		exit_qual &= ~DR6_BT;
-		exit_qual ^= DR6_ACTIVE_LOW;
-	} else {
-		exit_qual = 0;
-	}
+	unsigned long exit_qual = nested_vmx_get_event_data(vcpu, true);
 
 	/*
 	 * Unlike AMD's Paged Real Mode, which reports an error code on #PF
@@ -4003,10 +4031,12 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu)
 		intr_info |= INTR_INFO_DELIVER_CODE_MASK;
 	}
 
-	if (kvm_exception_is_soft(ex->vector))
+	if (kvm_exception_is_soft(ex->vector)) {
 		intr_info |= INTR_TYPE_SOFT_EXCEPTION;
-	else
+	} else {
 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
+		intr_info |= ex->nested ? INTR_INFO_NESTED_EXCEPTION_MASK : 0;
+	}
 
 	if (!(vmcs12->idt_vectoring_info_field & VECTORING_INFO_VALID_MASK) &&
 	    vmx_get_nmi_mask(vcpu))
@@ -4352,6 +4382,14 @@ static bool is_vmcs12_ext_field(unsigned long field)
 	case GUEST_TR_BASE:
 	case GUEST_GDTR_BASE:
 	case GUEST_IDTR_BASE:
+	case GUEST_IA32_FRED_CONFIG:
+	case GUEST_IA32_FRED_RSP1:
+	case GUEST_IA32_FRED_RSP2:
+	case GUEST_IA32_FRED_RSP3:
+	case GUEST_IA32_FRED_STKLVLS:
+	case GUEST_IA32_FRED_SSP1:
+	case GUEST_IA32_FRED_SSP2:
+	case GUEST_IA32_FRED_SSP3:
 	case GUEST_PENDING_DBG_EXCEPTIONS:
 	case GUEST_BNDCFGS:
 		return true;
@@ -4401,6 +4439,18 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
 	vmcs12->guest_tr_base = vmcs_readl(GUEST_TR_BASE);
 	vmcs12->guest_gdtr_base = vmcs_readl(GUEST_GDTR_BASE);
 	vmcs12->guest_idtr_base = vmcs_readl(GUEST_IDTR_BASE);
+
+	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+		vmcs12->guest_ia32_fred_config = vmcs_read64(GUEST_IA32_FRED_CONFIG);
+		vmcs12->guest_ia32_fred_rsp1 = vmcs_read64(GUEST_IA32_FRED_RSP1);
+		vmcs12->guest_ia32_fred_rsp2 = vmcs_read64(GUEST_IA32_FRED_RSP2);
+		vmcs12->guest_ia32_fred_rsp3 = vmcs_read64(GUEST_IA32_FRED_RSP3);
+		vmcs12->guest_ia32_fred_stklvls = vmcs_read64(GUEST_IA32_FRED_STKLVLS);
+		vmcs12->guest_ia32_fred_ssp1 = vmcs_read64(GUEST_IA32_FRED_SSP1);
+		vmcs12->guest_ia32_fred_ssp2 = vmcs_read64(GUEST_IA32_FRED_SSP2);
+		vmcs12->guest_ia32_fred_ssp3 = vmcs_read64(GUEST_IA32_FRED_SSP3);
+	}
+
 	vmcs12->guest_pending_dbg_exceptions =
 		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
 
@@ -4625,6 +4675,17 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	vmcs_write32(GUEST_IDTR_LIMIT, 0xFFFF);
 	vmcs_write32(GUEST_GDTR_LIMIT, 0xFFFF);
 
+	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+		vmcs_write64(GUEST_IA32_FRED_CONFIG, vmcs12->host_ia32_fred_config);
+		vmcs_write64(GUEST_IA32_FRED_RSP1, vmcs12->host_ia32_fred_rsp1);
+		vmcs_write64(GUEST_IA32_FRED_RSP2, vmcs12->host_ia32_fred_rsp2);
+		vmcs_write64(GUEST_IA32_FRED_RSP3, vmcs12->host_ia32_fred_rsp3);
+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, vmcs12->host_ia32_fred_stklvls);
+		vmcs_write64(GUEST_IA32_FRED_SSP1, vmcs12->host_ia32_fred_ssp1);
+		vmcs_write64(GUEST_IA32_FRED_SSP2, vmcs12->host_ia32_fred_ssp2);
+		vmcs_write64(GUEST_IA32_FRED_SSP3, vmcs12->host_ia32_fred_ssp3);
+	}
+
 	/* If not VM_EXIT_CLEAR_BNDCFGS, the L2 value propagates to L1.  */
 	if (vmcs12->vm_exit_controls & VM_EXIT_CLEAR_BNDCFGS)
 		vmcs_write64(GUEST_BNDCFGS, 0);
diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
index 98457d7b2b23..59f17fdfad11 100644
--- a/arch/x86/kvm/vmx/vmcs12.c
+++ b/arch/x86/kvm/vmx/vmcs12.c
@@ -80,6 +80,7 @@ const unsigned short vmcs12_field_offsets[] = {
 	FIELD(VM_ENTRY_MSR_LOAD_COUNT, vm_entry_msr_load_count),
 	FIELD(VM_ENTRY_INTR_INFO_FIELD, vm_entry_intr_info_field),
 	FIELD(VM_ENTRY_EXCEPTION_ERROR_CODE, vm_entry_exception_error_code),
+	FIELD(INJECTED_EVENT_DATA, injected_event_data),
 	FIELD(VM_ENTRY_INSTRUCTION_LEN, vm_entry_instruction_len),
 	FIELD(TPR_THRESHOLD, tpr_threshold),
 	FIELD(SECONDARY_VM_EXEC_CONTROL, secondary_vm_exec_control),
@@ -89,6 +90,7 @@ const unsigned short vmcs12_field_offsets[] = {
 	FIELD(VM_EXIT_INTR_ERROR_CODE, vm_exit_intr_error_code),
 	FIELD(IDT_VECTORING_INFO_FIELD, idt_vectoring_info_field),
 	FIELD(IDT_VECTORING_ERROR_CODE, idt_vectoring_error_code),
+	FIELD(ORIGINAL_EVENT_DATA, original_event_data),
 	FIELD(VM_EXIT_INSTRUCTION_LEN, vm_exit_instruction_len),
 	FIELD(VMX_INSTRUCTION_INFO, vmx_instruction_info),
 	FIELD(GUEST_ES_LIMIT, guest_es_limit),
@@ -152,5 +154,21 @@ const unsigned short vmcs12_field_offsets[] = {
 	FIELD(HOST_IA32_SYSENTER_EIP, host_ia32_sysenter_eip),
 	FIELD(HOST_RSP, host_rsp),
 	FIELD(HOST_RIP, host_rip),
+	FIELD(GUEST_IA32_FRED_CONFIG, guest_ia32_fred_config),
+	FIELD(GUEST_IA32_FRED_RSP1, guest_ia32_fred_rsp1),
+	FIELD(GUEST_IA32_FRED_RSP2, guest_ia32_fred_rsp2),
+	FIELD(GUEST_IA32_FRED_RSP3, guest_ia32_fred_rsp3),
+	FIELD(GUEST_IA32_FRED_STKLVLS, guest_ia32_fred_stklvls),
+	FIELD(GUEST_IA32_FRED_SSP1, guest_ia32_fred_ssp1),
+	FIELD(GUEST_IA32_FRED_SSP2, guest_ia32_fred_ssp2),
+	FIELD(GUEST_IA32_FRED_SSP3, guest_ia32_fred_ssp3),
+	FIELD(HOST_IA32_FRED_CONFIG, host_ia32_fred_config),
+	FIELD(HOST_IA32_FRED_RSP1, host_ia32_fred_rsp1),
+	FIELD(HOST_IA32_FRED_RSP2, host_ia32_fred_rsp2),
+	FIELD(HOST_IA32_FRED_RSP3, host_ia32_fred_rsp3),
+	FIELD(HOST_IA32_FRED_STKLVLS, host_ia32_fred_stklvls),
+	FIELD(HOST_IA32_FRED_SSP1, host_ia32_fred_ssp1),
+	FIELD(HOST_IA32_FRED_SSP2, host_ia32_fred_ssp2),
+	FIELD(HOST_IA32_FRED_SSP3, host_ia32_fred_ssp3),
 };
 const unsigned int nr_vmcs12_fields = ARRAY_SIZE(vmcs12_field_offsets);
diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
index f50f897b9b5f..edf7fcef8ccf 100644
--- a/arch/x86/kvm/vmx/vmcs12.h
+++ b/arch/x86/kvm/vmx/vmcs12.h
@@ -186,6 +186,24 @@ struct __packed vmcs12 {
 	u16 host_tr_selector;
 	u16 guest_pml_index;
 	u64 secondary_vm_exit_controls;
+	u64 guest_ia32_fred_config;
+	u64 guest_ia32_fred_rsp1;
+	u64 guest_ia32_fred_rsp2;
+	u64 guest_ia32_fred_rsp3;
+	u64 guest_ia32_fred_stklvls;
+	u64 guest_ia32_fred_ssp1;
+	u64 guest_ia32_fred_ssp2;
+	u64 guest_ia32_fred_ssp3;
+	u64 host_ia32_fred_config;
+	u64 host_ia32_fred_rsp1;
+	u64 host_ia32_fred_rsp2;
+	u64 host_ia32_fred_rsp3;
+	u64 host_ia32_fred_stklvls;
+	u64 host_ia32_fred_ssp1;
+	u64 host_ia32_fred_ssp2;
+	u64 host_ia32_fred_ssp3;
+	u64 injected_event_data;
+	u64 original_event_data;
 };
 
 /*
@@ -360,6 +378,24 @@ static inline void vmx_check_vmcs12_offsets(void)
 	CHECK_OFFSET(host_tr_selector, 994);
 	CHECK_OFFSET(guest_pml_index, 996);
 	CHECK_OFFSET(secondary_vm_exit_controls, 998);
+	CHECK_OFFSET(guest_ia32_fred_config, 1006);
+	CHECK_OFFSET(guest_ia32_fred_rsp1, 1014);
+	CHECK_OFFSET(guest_ia32_fred_rsp2, 1022);
+	CHECK_OFFSET(guest_ia32_fred_rsp3, 1030);
+	CHECK_OFFSET(guest_ia32_fred_stklvls, 1038);
+	CHECK_OFFSET(guest_ia32_fred_ssp1, 1046);
+	CHECK_OFFSET(guest_ia32_fred_ssp2, 1054);
+	CHECK_OFFSET(guest_ia32_fred_ssp3, 1062);
+	CHECK_OFFSET(host_ia32_fred_config, 1070);
+	CHECK_OFFSET(host_ia32_fred_rsp1, 1078);
+	CHECK_OFFSET(host_ia32_fred_rsp2, 1086);
+	CHECK_OFFSET(host_ia32_fred_rsp3, 1094);
+	CHECK_OFFSET(host_ia32_fred_stklvls, 1102);
+	CHECK_OFFSET(host_ia32_fred_ssp1, 1110);
+	CHECK_OFFSET(host_ia32_fred_ssp2, 1118);
+	CHECK_OFFSET(host_ia32_fred_ssp3, 1126);
+	CHECK_OFFSET(injected_event_data, 1134);
+	CHECK_OFFSET(original_event_data, 1142);
 }
 
 extern const unsigned short vmcs12_field_offsets[];
diff --git a/arch/x86/kvm/vmx/vmcs_shadow_fields.h b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
index 7f48056fe351..3885a3e0fbe8 100644
--- a/arch/x86/kvm/vmx/vmcs_shadow_fields.h
+++ b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
@@ -74,6 +74,10 @@ SHADOW_FIELD_RW(HOST_GS_BASE, host_gs_base, true)
 /* 64-bit */
 SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS, guest_physical_address, true)
 SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS_HIGH, guest_physical_address, true)
+SHADOW_FIELD_RO(ORIGINAL_EVENT_DATA, original_event_data, kvm_cpu_cap_has(X86_FEATURE_FRED))
+SHADOW_FIELD_RO(ORIGINAL_EVENT_DATA_HIGH, original_event_data, kvm_cpu_cap_has(X86_FEATURE_FRED))
+SHADOW_FIELD_RW(INJECTED_EVENT_DATA, injected_event_data, kvm_cpu_cap_has(X86_FEATURE_FRED))
+SHADOW_FIELD_RW(INJECTED_EVENT_DATA_HIGH, injected_event_data, kvm_cpu_cap_has(X86_FEATURE_FRED))
 
 #undef SHADOW_FIELD_RO
 #undef SHADOW_FIELD_RW
-- 
2.43.0


