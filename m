Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5FF7E5DA7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjKHTAf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjKHTAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5824D2122;
        Wed,  8 Nov 2023 11:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470025; x=1731006025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQ4FISgASIcWYJS30SjDIHqTv0Q/p1RTwWJD5uGREMo=;
  b=nL/MS41ck8PtNKJFKnaAUO11ZYjYDOzvnZ9qbxWAJxcP/JZcKFSjwhXv
   sZ0z+2xv2nruvrLdDA8+oqudmALmxqF9TRuzzirqWJgLpNYSc2vt0Gjpl
   DUlWx97rYU36shGlXZ9pV6lcAlDmGbc+oyrtc+eSLLmcfI1qM63xOxUfL
   TehEgmfros7ufmqyfCmtsLyR01JA9j5Np+pRzKJvua6+5KrjwqHl5Xh+n
   Yet6pvzwTB1L+4sAH+W9/r3GotxXNqZPe2mx53TtFfFjMc6PEBrj85/uS
   7xxz1+dcKHtjogIHXTlyNiug2pV0BfAtjMsEp8yA2tPk/GYncIZMLA6oe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486382"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486382"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892488"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:23 -0800
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
Subject: [PATCH v1 15/23] KVM: nVMX: Add support for the secondary VM exit controls
Date:   Wed,  8 Nov 2023 10:29:55 -0800
Message-ID: <20231108183003.5981-16-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enable the secondary VM exit controls to prepare for nested FRED.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 Documentation/virt/kvm/x86/nested-vmx.rst |  1 +
 arch/x86/include/asm/hyperv-tlfs.h        |  1 +
 arch/x86/kvm/vmx/capabilities.h           |  1 +
 arch/x86/kvm/vmx/hyperv.c                 | 18 +++++++++++++++++-
 arch/x86/kvm/vmx/nested.c                 | 18 +++++++++++++++++-
 arch/x86/kvm/vmx/vmcs12.c                 |  1 +
 arch/x86/kvm/vmx/vmcs12.h                 |  2 ++
 arch/x86/kvm/x86.h                        |  2 +-
 8 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/x86/nested-vmx.rst b/Documentation/virt/kvm/x86/nested-vmx.rst
index ac2095d41f02..e64ef231f310 100644
--- a/Documentation/virt/kvm/x86/nested-vmx.rst
+++ b/Documentation/virt/kvm/x86/nested-vmx.rst
@@ -217,6 +217,7 @@ struct shadow_vmcs is ever changed.
 		u16 host_fs_selector;
 		u16 host_gs_selector;
 		u16 host_tr_selector;
+		u64 secondary_vm_exit_controls;
 	};
 
 
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 2ff26f53cd62..299554708e37 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -616,6 +616,7 @@ struct hv_enlightened_vmcs {
 	u64 host_ssp;
 	u64 host_ia32_int_ssp_table_addr;
 	u64 padding64_6;
+	u64 secondary_vm_exit_controls;
 } __packed;
 
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE			0
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index e8f3ad0f79ee..caf38a54856c 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -38,6 +38,7 @@ struct nested_vmx_msrs {
 	u32 pinbased_ctls_high;
 	u32 exit_ctls_low;
 	u32 exit_ctls_high;
+	u64 secondary_exit_ctls;
 	u32 entry_ctls_low;
 	u32 entry_ctls_high;
 	u32 misc_low;
diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index 313b8bb5b8a7..b8cd53601a00 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -103,7 +103,10 @@
 	 VM_EXIT_LOAD_IA32_EFER |					\
 	 VM_EXIT_CLEAR_BNDCFGS |					\
 	 VM_EXIT_PT_CONCEAL_PIP |					\
-	 VM_EXIT_CLEAR_IA32_RTIT_CTL)
+	 VM_EXIT_CLEAR_IA32_RTIT_CTL |					\
+	 VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+
+#define EVMCS1_SUPPORTED_VMEXIT_CTRL2 (0ULL)
 
 #define EVMCS1_SUPPORTED_VMENTRY_CTRL					\
 	(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR |				\
@@ -315,6 +318,8 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1),
 	EVMCS1_FIELD(VM_EXIT_CONTROLS, vm_exit_controls,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1),
+	EVMCS1_FIELD(SECONDARY_VM_EXIT_CONTROLS, secondary_vm_exit_controls,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1),
 	EVMCS1_FIELD(SECONDARY_VM_EXEC_CONTROL, secondary_vm_exec_control,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1),
 	EVMCS1_FIELD(GUEST_ES_LIMIT, guest_es_limit,
@@ -464,6 +469,7 @@ enum evmcs_revision {
 
 enum evmcs_ctrl_type {
 	EVMCS_EXIT_CTRLS,
+	EVMCS_2NDEXIT,
 	EVMCS_ENTRY_CTRLS,
 	EVMCS_EXEC_CTRL,
 	EVMCS_2NDEXEC,
@@ -477,6 +483,9 @@ static const u32 evmcs_supported_ctrls[NR_EVMCS_CTRLS][NR_EVMCS_REVISIONS] = {
 	[EVMCS_EXIT_CTRLS] = {
 		[EVMCSv1_LEGACY] = EVMCS1_SUPPORTED_VMEXIT_CTRL,
 	},
+	[EVMCS_2NDEXIT] = {
+		[EVMCSv1_LEGACY] = EVMCS1_SUPPORTED_VMEXIT_CTRL2,
+	},
 	[EVMCS_ENTRY_CTRLS] = {
 		[EVMCSv1_LEGACY] = EVMCS1_SUPPORTED_VMENTRY_CTRL,
 	},
@@ -539,6 +548,9 @@ void nested_evmcs_filter_control_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *
 			supported_ctrls &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
 		ctl_high &= supported_ctrls;
 		break;
+	case MSR_IA32_VMX_EXIT_CTLS2:
+		ctl_low &= evmcs_get_supported_ctls(EVMCS_2NDEXIT);
+		break;
 	case MSR_IA32_VMX_ENTRY_CTLS:
 	case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
 		supported_ctrls = evmcs_get_supported_ctls(EVMCS_ENTRY_CTRLS);
@@ -589,6 +601,10 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 					       vmcs12->vm_exit_controls)))
 		return -EINVAL;
 
+	if (CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXIT,
+					       vmcs12->secondary_vm_exit_controls)))
+		return -EINVAL;
+
 	if (CC(!nested_evmcs_is_valid_controls(EVMCS_ENTRY_CTRLS,
 					       vmcs12->vm_entry_controls)))
 		return -EINVAL;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ff07d6e736a2..d6341845df43 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1411,6 +1411,7 @@ int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
 	case MSR_IA32_VMX_PINBASED_CTLS:
 	case MSR_IA32_VMX_PROCBASED_CTLS:
 	case MSR_IA32_VMX_EXIT_CTLS:
+	case MSR_IA32_VMX_EXIT_CTLS2:
 	case MSR_IA32_VMX_ENTRY_CTLS:
 		/*
 		 * The "non-true" VMX capability MSRs are generated from the
@@ -1489,6 +1490,9 @@ int vmx_get_vmx_msr(struct nested_vmx_msrs *msrs, u32 msr_index, u64 *pdata)
 		if (msr_index == MSR_IA32_VMX_EXIT_CTLS)
 			*pdata |= VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR;
 		break;
+	case MSR_IA32_VMX_EXIT_CTLS2:
+		*pdata = msrs->secondary_exit_ctls;
+		break;
 	case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
 	case MSR_IA32_VMX_ENTRY_CTLS:
 		*pdata = vmx_control_msr(
@@ -1692,6 +1696,8 @@ static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields
 		vmcs12->pin_based_vm_exec_control =
 			evmcs->pin_based_vm_exec_control;
 		vmcs12->vm_exit_controls = evmcs->vm_exit_controls;
+		vmcs12->secondary_vm_exit_controls =
+			evmcs->secondary_vm_exit_controls;
 		vmcs12->secondary_vm_exec_control =
 			evmcs->secondary_vm_exec_control;
 	}
@@ -1894,6 +1900,7 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
 	 * evmcs->vmcs_link_pointer = vmcs12->vmcs_link_pointer;
 	 * evmcs->pin_based_vm_exec_control = vmcs12->pin_based_vm_exec_control;
 	 * evmcs->vm_exit_controls = vmcs12->vm_exit_controls;
+	 * evmcs->secondary_vm_exit_controls = vmcs12->secondary_vm_exit_controls;
 	 * evmcs->secondary_vm_exec_control = vmcs12->secondary_vm_exec_control;
 	 * evmcs->page_fault_error_code_mask =
 	 *		vmcs12->page_fault_error_code_mask;
@@ -2411,6 +2418,11 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 		exec_control &= ~VM_EXIT_LOAD_IA32_EFER;
 	vm_exit_controls_set(vmx, exec_control);
 
+	if (exec_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
+		exec_control = __secondary_vm_exit_controls_get(vmcs01);
+		secondary_vm_exit_controls_set(vmx, exec_control);
+	}
+
 	/*
 	 * Interrupt/Exception Fields
 	 */
@@ -6819,13 +6831,17 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
 		VM_EXIT_HOST_ADDR_SPACE_SIZE |
 #endif
 		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT |
-		VM_EXIT_CLEAR_BNDCFGS;
+		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_ACTIVATE_SECONDARY_CONTROLS;
 	msrs->exit_ctls_high |=
 		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
 		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
 		VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON_EXIT |
 		VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
 
+	/* secondary exit controls */
+	if (msrs->exit_ctls_high & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+		rdmsrl(MSR_IA32_VMX_EXIT_CTLS2, msrs->secondary_exit_ctls);
+
 	/* We support free control of debug control saving. */
 	msrs->exit_ctls_low &= ~VM_EXIT_SAVE_DEBUG_CONTROLS;
 }
diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
index 106a72c923ca..98457d7b2b23 100644
--- a/arch/x86/kvm/vmx/vmcs12.c
+++ b/arch/x86/kvm/vmx/vmcs12.c
@@ -73,6 +73,7 @@ const unsigned short vmcs12_field_offsets[] = {
 	FIELD(PAGE_FAULT_ERROR_CODE_MATCH, page_fault_error_code_match),
 	FIELD(CR3_TARGET_COUNT, cr3_target_count),
 	FIELD(VM_EXIT_CONTROLS, vm_exit_controls),
+	FIELD(SECONDARY_VM_EXIT_CONTROLS, secondary_vm_exit_controls),
 	FIELD(VM_EXIT_MSR_STORE_COUNT, vm_exit_msr_store_count),
 	FIELD(VM_EXIT_MSR_LOAD_COUNT, vm_exit_msr_load_count),
 	FIELD(VM_ENTRY_CONTROLS, vm_entry_controls),
diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
index 01936013428b..f50f897b9b5f 100644
--- a/arch/x86/kvm/vmx/vmcs12.h
+++ b/arch/x86/kvm/vmx/vmcs12.h
@@ -185,6 +185,7 @@ struct __packed vmcs12 {
 	u16 host_gs_selector;
 	u16 host_tr_selector;
 	u16 guest_pml_index;
+	u64 secondary_vm_exit_controls;
 };
 
 /*
@@ -358,6 +359,7 @@ static inline void vmx_check_vmcs12_offsets(void)
 	CHECK_OFFSET(host_gs_selector, 992);
 	CHECK_OFFSET(host_tr_selector, 994);
 	CHECK_OFFSET(guest_pml_index, 996);
+	CHECK_OFFSET(secondary_vm_exit_controls, 998);
 }
 
 extern const unsigned short vmcs12_field_offsets[];
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 63e543c6834b..96ad139adc3f 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -47,7 +47,7 @@ void kvm_spurious_fault(void);
  * associated feature that KVM supports for nested virtualization.
  */
 #define KVM_FIRST_EMULATED_VMX_MSR	MSR_IA32_VMX_BASIC
-#define KVM_LAST_EMULATED_VMX_MSR	MSR_IA32_VMX_VMFUNC
+#define KVM_LAST_EMULATED_VMX_MSR	MSR_IA32_VMX_EXIT_CTLS2
 
 #define KVM_DEFAULT_PLE_GAP		128
 #define KVM_VMX_DEFAULT_PLE_WINDOW	4096
-- 
2.42.0

