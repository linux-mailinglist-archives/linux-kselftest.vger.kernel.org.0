Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D57E5DAA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjKHTAi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjKHTAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D0212D;
        Wed,  8 Nov 2023 11:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470025; x=1731006025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0wosoEajlgVEljBzAln/5/tYc2HmZ/1IYFDCYq6/OQ4=;
  b=RY9WRLbQJm4ItEazgHn2DA8474bwUtdE8UdDixmOfPGzfOlqI/smFCsj
   ql8SVEY7nCCW08X7m011oqU+AvVbj/H+yWwqLzOSW6i6nQs+NSsho3oxi
   ItKp6EZtjaDwC1MPNu9OkuGwnGoaA23A8hvfUU4dxaDcUtsomAlyJoNSh
   CRSrArbMW76mD21NFXRbw4vmNSr/M2QiqXuiccba91I37wGoFydV9vxXw
   8VxdpDJRkQXSRqh1Y6Wdzof0+r9M+nkTHZjYEb6ec0JcXVfUu1GZ0sJxr
   abXJZYQ5zogFfGilNRnH6sfKU1s7PEkQDtZjs/m+lrwYsz53FiOdeCttd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486394"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486394"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892491"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:24 -0800
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
Subject: [PATCH v1 16/23] KVM: nVMX: Add FRED VMCS fields
Date:   Wed,  8 Nov 2023 10:29:56 -0800
Message-ID: <20231108183003.5981-17-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add FRED VMCS fields to nested VMX context management.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 Documentation/virt/kvm/x86/nested-vmx.rst |  18 +++
 arch/x86/include/asm/hyperv-tlfs.h        |  18 +++
 arch/x86/kvm/vmx/hyperv.c                 |  38 ++++++
 arch/x86/kvm/vmx/nested.c                 | 154 ++++++++++++++++++++--
 arch/x86/kvm/vmx/vmcs12.c                 |  18 +++
 arch/x86/kvm/vmx/vmcs12.h                 |  36 +++++
 arch/x86/kvm/vmx/vmcs_shadow_fields.h     |   6 +-
 7 files changed, 274 insertions(+), 14 deletions(-)

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
 
 
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 299554708e37..269dbf73b63f 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -617,6 +617,24 @@ struct hv_enlightened_vmcs {
 	u64 host_ia32_int_ssp_table_addr;
 	u64 padding64_6;
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
 } __packed;
 
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE			0
diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index b8cd53601a00..b12ef8fd76c9 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -243,6 +243,8 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
 	EVMCS1_FIELD(TSC_MULTIPLIER, tsc_multiplier,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
+	EVMCS1_FIELD(INJECTED_EVENT_DATA, injected_event_data,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT),
 	/*
 	 * Not used by KVM:
 	 *
@@ -262,11 +264,47 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
 	 *	     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
 	 */
 
+	/* FRED guest and host context */
+	EVMCS1_FIELD(GUEST_IA32_FRED_CONFIG, guest_ia32_fred_config,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_IA32_FRED_RSP1, guest_ia32_fred_rsp1,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_IA32_FRED_RSP2, guest_ia32_fred_rsp2,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_IA32_FRED_RSP3, guest_ia32_fred_rsp3,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_IA32_FRED_STKLVLS, guest_ia32_fred_stklvls,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_IA32_FRED_SSP1, guest_ia32_fred_ssp1,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_IA32_FRED_SSP2, guest_ia32_fred_ssp2,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_IA32_FRED_SSP3, guest_ia32_fred_ssp3,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(HOST_IA32_FRED_CONFIG, host_ia32_fred_config,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_IA32_FRED_RSP1, host_ia32_fred_rsp1,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_IA32_FRED_RSP2, host_ia32_fred_rsp2,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_IA32_FRED_RSP3, host_ia32_fred_rsp3,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_IA32_FRED_STKLVLS, host_ia32_fred_stklvls,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_IA32_FRED_SSP1, host_ia32_fred_ssp1,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_IA32_FRED_SSP2, host_ia32_fred_ssp2,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_IA32_FRED_SSP3, host_ia32_fred_ssp3,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+
 	/* 64 bit read only */
 	EVMCS1_FIELD(GUEST_PHYSICAL_ADDRESS, guest_physical_address,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
 	EVMCS1_FIELD(EXIT_QUALIFICATION, exit_qualification,
 		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(ORIGINAL_EVENT_DATA, original_event_data,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
 	/*
 	 * Not defined in KVM:
 	 *
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index d6341845df43..af616c4a3491 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -83,7 +83,18 @@ static void init_vmcs_shadow_fields(void)
 			pr_err("Missing field from shadow_read_only_field %x\n",
 			       field + 1);
 
+		switch (field) {
+		case ORIGINAL_EVENT_DATA:
+		case ORIGINAL_EVENT_DATA_HIGH:
+			if (!cpu_feature_enabled(X86_FEATURE_FRED))
+				continue;
+			break;
+		default:
+			break;
+		}
+
 		clear_bit(field, vmx_vmread_bitmap);
+
 		if (field & 1)
 #ifdef CONFIG_X86_64
 			continue;
@@ -126,6 +137,11 @@ static void init_vmcs_shadow_fields(void)
 			if (!cpu_has_vmx_apicv())
 				continue;
 			break;
+		case INJECTED_EVENT_DATA:
+		case INJECTED_EVENT_DATA_HIGH:
+			if (!cpu_feature_enabled(X86_FEATURE_FRED))
+				continue;
+			break;
 		default:
 			break;
 		}
@@ -650,6 +666,9 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
+
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
+					 MSR_IA32_FRED_RSP0, MSR_TYPE_RW);
 #endif
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_IA32_SPEC_CTRL, MSR_TYPE_RW);
@@ -1565,6 +1584,17 @@ static void copy_shadow_to_vmcs12(struct vcpu_vmx *vmx)
 
 	for (i = 0; i < max_shadow_read_write_fields; i++) {
 		field = shadow_read_write_fields[i];
+
+		switch (field.encoding) {
+		case INJECTED_EVENT_DATA:
+		case INJECTED_EVENT_DATA_HIGH:
+			if (!cpu_feature_enabled(X86_FEATURE_FRED))
+				continue;
+			break;
+		default:
+			break;
+		}
+
 		val = __vmcs_readl(field.encoding);
 		vmcs12_write_any(vmcs12, field.encoding, field.offset, val);
 	}
@@ -1599,6 +1629,19 @@ static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx)
 	for (q = 0; q < ARRAY_SIZE(fields); q++) {
 		for (i = 0; i < max_fields[q]; i++) {
 			field = fields[q][i];
+
+			switch (field.encoding) {
+			case INJECTED_EVENT_DATA:
+			case INJECTED_EVENT_DATA_HIGH:
+			case ORIGINAL_EVENT_DATA:
+			case ORIGINAL_EVENT_DATA_HIGH:
+				if (!cpu_feature_enabled(X86_FEATURE_FRED))
+					continue;
+				break;
+			default:
+				break;
+			}
+
 			val = vmcs12_read_any(vmcs12, field.encoding,
 					      field.offset);
 			__vmcs_writel(field.encoding, val);
@@ -1660,6 +1703,8 @@ static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields
 			evmcs->vm_entry_intr_info_field;
 		vmcs12->vm_entry_exception_error_code =
 			evmcs->vm_entry_exception_error_code;
+		vmcs12->injected_event_data =
+			evmcs->injected_event_data;
 		vmcs12->vm_entry_instruction_len =
 			evmcs->vm_entry_instruction_len;
 	}
@@ -1725,6 +1770,14 @@ static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields
 		vmcs12->guest_tr_base = evmcs->guest_tr_base;
 		vmcs12->guest_gdtr_base = evmcs->guest_gdtr_base;
 		vmcs12->guest_idtr_base = evmcs->guest_idtr_base;
+		vmcs12->guest_ia32_fred_config = evmcs->guest_ia32_fred_config;
+		vmcs12->guest_ia32_fred_rsp1 = evmcs->guest_ia32_fred_rsp1;
+		vmcs12->guest_ia32_fred_rsp2 = evmcs->guest_ia32_fred_rsp2;
+		vmcs12->guest_ia32_fred_rsp3 = evmcs->guest_ia32_fred_rsp3;
+		vmcs12->guest_ia32_fred_stklvls = evmcs->guest_ia32_fred_stklvls;
+		vmcs12->guest_ia32_fred_ssp1 = evmcs->guest_ia32_fred_ssp1;
+		vmcs12->guest_ia32_fred_ssp2 = evmcs->guest_ia32_fred_ssp2;
+		vmcs12->guest_ia32_fred_ssp3 = evmcs->guest_ia32_fred_ssp3;
 		vmcs12->guest_es_limit = evmcs->guest_es_limit;
 		vmcs12->guest_cs_limit = evmcs->guest_cs_limit;
 		vmcs12->guest_ss_limit = evmcs->guest_ss_limit;
@@ -1781,6 +1834,14 @@ static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields
 		vmcs12->host_tr_base = evmcs->host_tr_base;
 		vmcs12->host_gdtr_base = evmcs->host_gdtr_base;
 		vmcs12->host_idtr_base = evmcs->host_idtr_base;
+		vmcs12->host_ia32_fred_config = evmcs->host_ia32_fred_config;
+		vmcs12->host_ia32_fred_rsp1 = evmcs->host_ia32_fred_rsp1;
+		vmcs12->host_ia32_fred_rsp2 = evmcs->host_ia32_fred_rsp2;
+		vmcs12->host_ia32_fred_rsp3 = evmcs->host_ia32_fred_rsp3;
+		vmcs12->host_ia32_fred_stklvls = evmcs->host_ia32_fred_stklvls;
+		vmcs12->host_ia32_fred_ssp1 = evmcs->host_ia32_fred_ssp1;
+		vmcs12->host_ia32_fred_ssp2 = evmcs->host_ia32_fred_ssp2;
+		vmcs12->host_ia32_fred_ssp3 = evmcs->host_ia32_fred_ssp3;
 		vmcs12->host_rsp = evmcs->host_rsp;
 	}
 
@@ -1840,6 +1901,7 @@ static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields
 	 * vmcs12->vm_exit_intr_error_code = evmcs->vm_exit_intr_error_code;
 	 * vmcs12->idt_vectoring_info_field = evmcs->idt_vectoring_info_field;
 	 * vmcs12->idt_vectoring_error_code = evmcs->idt_vectoring_error_code;
+	 * vmcs12->original_event_data = evmcs->original_event_data;
 	 * vmcs12->vm_exit_instruction_len = evmcs->vm_exit_instruction_len;
 	 * vmcs12->vmx_instruction_info = evmcs->vmx_instruction_info;
 	 * vmcs12->exit_qualification = evmcs->exit_qualification;
@@ -1975,6 +2037,14 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
 	evmcs->guest_tr_base = vmcs12->guest_tr_base;
 	evmcs->guest_gdtr_base = vmcs12->guest_gdtr_base;
 	evmcs->guest_idtr_base = vmcs12->guest_idtr_base;
+	evmcs->guest_ia32_fred_config = vmcs12->guest_ia32_fred_config;
+	evmcs->guest_ia32_fred_rsp1 = vmcs12->guest_ia32_fred_rsp1;
+	evmcs->guest_ia32_fred_rsp2 = vmcs12->guest_ia32_fred_rsp2;
+	evmcs->guest_ia32_fred_rsp3 = vmcs12->guest_ia32_fred_rsp3;
+	evmcs->guest_ia32_fred_stklvls = vmcs12->guest_ia32_fred_stklvls;
+	evmcs->guest_ia32_fred_ssp1 = vmcs12->guest_ia32_fred_ssp1;
+	evmcs->guest_ia32_fred_ssp2 = vmcs12->guest_ia32_fred_ssp2;
+	evmcs->guest_ia32_fred_ssp3 = vmcs12->guest_ia32_fred_ssp3;
 
 	evmcs->guest_ia32_pat = vmcs12->guest_ia32_pat;
 	evmcs->guest_ia32_efer = vmcs12->guest_ia32_efer;
@@ -2005,6 +2075,7 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
 	evmcs->vm_exit_intr_error_code = vmcs12->vm_exit_intr_error_code;
 	evmcs->idt_vectoring_info_field = vmcs12->idt_vectoring_info_field;
 	evmcs->idt_vectoring_error_code = vmcs12->idt_vectoring_error_code;
+	evmcs->original_event_data = vmcs12->original_event_data;
 	evmcs->vm_exit_instruction_len = vmcs12->vm_exit_instruction_len;
 	evmcs->vmx_instruction_info = vmcs12->vmx_instruction_info;
 
@@ -2021,6 +2092,7 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
 	evmcs->vm_entry_intr_info_field = vmcs12->vm_entry_intr_info_field;
 	evmcs->vm_entry_exception_error_code =
 		vmcs12->vm_entry_exception_error_code;
+	evmcs->injected_event_data = vmcs12->injected_event_data;
 	evmcs->vm_entry_instruction_len = vmcs12->vm_entry_instruction_len;
 
 	evmcs->guest_rip = vmcs12->guest_rip;
@@ -2435,6 +2507,8 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 			     vmcs12->vm_entry_instruction_len);
 		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
 			     vmcs12->guest_interruptibility_info);
+		if (cpu_feature_enabled(X86_FEATURE_FRED))
+			vmcs_write64(INJECTED_EVENT_DATA, vmcs12->injected_event_data);
 		vmx->loaded_vmcs->nmi_known_unmasked =
 			!(vmcs12->guest_interruptibility_info & GUEST_INTR_STATE_NMI);
 	} else {
@@ -2485,6 +2559,17 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
 		vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
 
+		if (cpu_feature_enabled(X86_FEATURE_FRED)) {
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
 
@@ -3765,6 +3850,22 @@ vmcs12_guest_cr4(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
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
@@ -3772,6 +3873,8 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 	u32 idt_vectoring;
 	unsigned int nr;
 
+	vmcs12->original_event_data = 0;
+
 	/*
 	 * Per the SDM, VM-Exits due to double and triple faults are never
 	 * considered to occur during event delivery, even if the double/triple
@@ -3810,6 +3913,12 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
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
@@ -3900,19 +4009,7 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu)
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
@@ -4282,6 +4379,14 @@ static bool is_vmcs12_ext_field(unsigned long field)
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
@@ -4331,6 +4436,18 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
 	vmcs12->guest_tr_base = vmcs_readl(GUEST_TR_BASE);
 	vmcs12->guest_gdtr_base = vmcs_readl(GUEST_GDTR_BASE);
 	vmcs12->guest_idtr_base = vmcs_readl(GUEST_IDTR_BASE);
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
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
 
@@ -4555,6 +4672,17 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	vmcs_write32(GUEST_IDTR_LIMIT, 0xFFFF);
 	vmcs_write32(GUEST_GDTR_LIMIT, 0xFFFF);
 
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
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
index cad128d1657b..33c3e2a06e41 100644
--- a/arch/x86/kvm/vmx/vmcs_shadow_fields.h
+++ b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
@@ -41,9 +41,9 @@ SHADOW_FIELD_RW(HOST_GS_SELECTOR, host_gs_selector)
 SHADOW_FIELD_RO(VM_EXIT_REASON, vm_exit_reason)
 SHADOW_FIELD_RO(VM_EXIT_INTR_INFO, vm_exit_intr_info)
 SHADOW_FIELD_RO(VM_EXIT_INSTRUCTION_LEN, vm_exit_instruction_len)
+SHADOW_FIELD_RO(VM_EXIT_INTR_ERROR_CODE, vm_exit_intr_error_code)
 SHADOW_FIELD_RO(IDT_VECTORING_INFO_FIELD, idt_vectoring_info_field)
 SHADOW_FIELD_RO(IDT_VECTORING_ERROR_CODE, idt_vectoring_error_code)
-SHADOW_FIELD_RO(VM_EXIT_INTR_ERROR_CODE, vm_exit_intr_error_code)
 SHADOW_FIELD_RO(GUEST_CS_AR_BYTES, guest_cs_ar_bytes)
 SHADOW_FIELD_RO(GUEST_SS_AR_BYTES, guest_ss_ar_bytes)
 SHADOW_FIELD_RW(CPU_BASED_VM_EXEC_CONTROL, cpu_based_vm_exec_control)
@@ -74,6 +74,10 @@ SHADOW_FIELD_RW(HOST_GS_BASE, host_gs_base)
 /* 64-bit */
 SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS, guest_physical_address)
 SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS_HIGH, guest_physical_address)
+SHADOW_FIELD_RO(ORIGINAL_EVENT_DATA, original_event_data)
+SHADOW_FIELD_RO(ORIGINAL_EVENT_DATA_HIGH, original_event_data)
+SHADOW_FIELD_RW(INJECTED_EVENT_DATA, injected_event_data)
+SHADOW_FIELD_RW(INJECTED_EVENT_DATA_HIGH, injected_event_data)
 
 #undef SHADOW_FIELD_RO
 #undef SHADOW_FIELD_RW
-- 
2.42.0

