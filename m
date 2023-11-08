Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6867E5D93
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjKHTAW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjKHTAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1148B2110;
        Wed,  8 Nov 2023 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470020; x=1731006020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fdY+4UiWU7txxIIX8tQBBVkqeGakHWhQSqAUgojOiL0=;
  b=RPWI7BFk37C/2hEoMC9bqzVfePnZfCWyRbG6RYrcI7MteDYIcu3JxDG0
   952orTVp6ckzlMi9ZM/CITecWeapafsJ1hec4bPn7K0LOcnrEi/8RCKy4
   5lWc31tEPmfTgVwLVoufOBodXZhOpvVyUWXuUPes25CeMKqTLaCDu64eI
   9y/SDQ8XZnFdu5QWzT61i4Is2N+MCwmDG+b2DIdqgthUQ08GVlbvNna+P
   yn8xmzVHIZcZl4Dh6PHuauXBm7XdOGswRmH/2OjKm3725jFySbnOdjX5h
   VcR53C50EhthdCAy1fCVqF4t6k60QZM6xTwkSp+Zetu/a5G3WZ4tKD8qI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486227"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486227"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892415"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:15 -0800
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
Subject: [PATCH v1 02/23] KVM: VMX: Cleanup VMX misc information defines and usages
Date:   Wed,  8 Nov 2023 10:29:42 -0800
Message-ID: <20231108183003.5981-3-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Define VMX misc information fields with BIT_ULL()/GENMASK_ULL(), and move
VMX misc field macros to vmx.h if used in multiple files or where they are
used only once.

Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/msr-index.h |  5 -----
 arch/x86/include/asm/vmx.h       | 12 +++++------
 arch/x86/kvm/vmx/capabilities.h  |  4 ++--
 arch/x86/kvm/vmx/nested.c        | 34 ++++++++++++++++++++++++--------
 arch/x86/kvm/vmx/nested.h        |  2 +-
 arch/x86/kvm/vmx/vmx.c           |  8 +++-----
 6 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 68c75c299300..d7d4eace5dae 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1126,11 +1126,6 @@
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
-/* MSR_IA32_VMX_MISC bits */
-#define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
-#define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
-#define MSR_IA32_VMX_MISC_PREEMPTION_TIMER_SCALE   0x1F
-
 /* AMD-V MSRs */
 #define MSR_VM_CR                       0xc0010114
 #define MSR_VM_IGNNE                    0xc0010115
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 273960225a3b..5771c5751e7e 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -129,12 +129,10 @@
 #define VMX_BASIC_32BIT_PHYS_ADDR_ONLY		BIT_ULL(48)
 #define VMX_BASIC_INOUT				BIT_ULL(54)
 
-#define VMX_MISC_PREEMPTION_TIMER_RATE_MASK	0x0000001f
-#define VMX_MISC_SAVE_EFER_LMA			0x00000020
-#define VMX_MISC_ACTIVITY_HLT			0x00000040
-#define VMX_MISC_ACTIVITY_WAIT_SIPI		0x00000100
-#define VMX_MISC_ZERO_LEN_INS			0x40000000
-#define VMX_MISC_MSR_LIST_MULTIPLIER		512
+/* VMX_MISC bits and bitmasks */
+#define VMX_MISC_INTEL_PT			BIT_ULL(14)
+#define VMX_MISC_VMWRITE_SHADOW_RO_FIELDS	BIT_ULL(29)
+#define VMX_MISC_ZERO_LEN_INS			BIT_ULL(30)
 
 /* VMFUNC functions */
 #define VMFUNC_CONTROL_BIT(x)	BIT((VMX_FEATURE_##x & 0x1f) - 28)
@@ -159,7 +157,7 @@ static inline u32 vmx_basic_vmcs_mem_type(u64 vmx_basic)
 
 static inline int vmx_misc_preemption_timer_rate(u64 vmx_misc)
 {
-	return vmx_misc & VMX_MISC_PREEMPTION_TIMER_RATE_MASK;
+	return vmx_misc & GENMASK_ULL(4, 0);
 }
 
 static inline int vmx_misc_cr3_count(u64 vmx_misc)
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 86ce8bb96bed..cb6588238f46 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -223,7 +223,7 @@ static inline bool cpu_has_vmx_vmfunc(void)
 static inline bool cpu_has_vmx_shadow_vmcs(void)
 {
 	/* check if the cpu supports writing r/o exit information fields */
-	if (!(vmcs_config.misc & MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS))
+	if (!(vmcs_config.misc & VMX_MISC_VMWRITE_SHADOW_RO_FIELDS))
 		return false;
 
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
@@ -365,7 +365,7 @@ static inline bool cpu_has_vmx_invvpid_global(void)
 
 static inline bool cpu_has_vmx_intel_pt(void)
 {
-	return (vmcs_config.misc & MSR_IA32_VMX_MISC_INTEL_PT) &&
+	return (vmcs_config.misc & VMX_MISC_INTEL_PT) &&
 		(vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_PT_USE_GPA) &&
 		(vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_RTIT_CTL);
 }
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 23704f8d9035..ff07d6e736a2 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -886,6 +886,8 @@ static int nested_vmx_store_msr_check(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+#define VMX_MISC_MSR_LIST_MULTIPLIER	512
+
 static u32 nested_vmx_max_atomic_switch_msrs(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -1295,18 +1297,34 @@ vmx_restore_control_msr(struct vcpu_vmx *vmx, u32 msr_index, u64 data)
 	return 0;
 }
 
+#define VMX_MISC_SAVE_EFER_LMA		BIT_ULL(5)
+#define VMX_MISC_ACTIVITY_STATE_BITMAP	GENMASK_ULL(8, 6)
+#define VMX_MISC_ACTIVITY_HLT		BIT_ULL(6)
+#define VMX_MISC_ACTIVITY_WAIT_SIPI	BIT_ULL(8)
+#define VMX_MISC_RDMSR_IN_SMM		BIT_ULL(15)
+#define VMX_MISC_VMXOFF_BLOCK_SMI	BIT_ULL(28)
+
+#define VMX_MISC_FEATURES_MASK			\
+	(VMX_MISC_SAVE_EFER_LMA |		\
+	 VMX_MISC_ACTIVITY_STATE_BITMAP |	\
+	 VMX_MISC_INTEL_PT |			\
+	 VMX_MISC_RDMSR_IN_SMM |		\
+	 VMX_MISC_VMXOFF_BLOCK_SMI |		\
+	 VMX_MISC_VMWRITE_SHADOW_RO_FIELDS |	\
+	 VMX_MISC_ZERO_LEN_INS)
+
+#define VMX_MISC_RESERVED_BITS			\
+	(BIT_ULL(31) | GENMASK_ULL(13, 9))
+
 static int vmx_restore_vmx_misc(struct vcpu_vmx *vmx, u64 data)
 {
-	const u64 feature_and_reserved_bits =
-		/* feature */
-		BIT_ULL(5) | GENMASK_ULL(8, 6) | BIT_ULL(14) | BIT_ULL(15) |
-		BIT_ULL(28) | BIT_ULL(29) | BIT_ULL(30) |
-		/* reserved */
-		GENMASK_ULL(13, 9) | BIT_ULL(31);
 	u64 vmx_misc = vmx_control_msr(vmcs_config.nested.misc_low,
 				       vmcs_config.nested.misc_high);
 
-	if (!is_bitwise_subset(vmx_misc, data, feature_and_reserved_bits))
+	static_assert(!(VMX_MISC_FEATURES_MASK & VMX_MISC_RESERVED_BITS));
+
+	if (!is_bitwise_subset(vmx_misc, data,
+			       VMX_MISC_FEATURES_MASK | VMX_MISC_RESERVED_BITS))
 		return -EINVAL;
 
 	if ((vmx->nested.msrs.pinbased_ctls_high &
@@ -6956,7 +6974,7 @@ static void nested_vmx_setup_misc_data(struct vmcs_config *vmcs_conf,
 {
 	msrs->misc_low = (u32)vmcs_conf->misc & VMX_MISC_SAVE_EFER_LMA;
 	msrs->misc_low |=
-		MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS |
+		VMX_MISC_VMWRITE_SHADOW_RO_FIELDS |
 		VMX_MISC_EMULATED_PREEMPTION_TIMER_RATE |
 		VMX_MISC_ACTIVITY_HLT |
 		VMX_MISC_ACTIVITY_WAIT_SIPI;
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index b4b9d51438c6..24ff4df509b6 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -108,7 +108,7 @@ static inline unsigned nested_cpu_vmx_misc_cr3_count(struct kvm_vcpu *vcpu)
 static inline bool nested_cpu_has_vmwrite_any_field(struct kvm_vcpu *vcpu)
 {
 	return to_vmx(vcpu)->nested.msrs.misc_low &
-		MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS;
+		VMX_MISC_VMWRITE_SHADOW_RO_FIELDS;
 }
 
 static inline bool nested_cpu_has_zero_length_injection(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6b3b2df11cea..396a806bf2b2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2576,7 +2576,6 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	u32 _vmexit_control = 0;
 	u32 _vmentry_control = 0;
 	u64 basic_msr;
-	u64 misc_msr;
 	int i;
 
 	/*
@@ -2710,8 +2709,6 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	if (vmx_basic_vmcs_mem_type(basic_msr) != MEM_TYPE_WB)
 		return -EIO;
 
-	rdmsrl(MSR_IA32_VMX_MISC, misc_msr);
-
 	vmcs_conf->basic = basic_msr;
 	vmcs_conf->pin_based_exec_ctrl = _pin_based_exec_control;
 	vmcs_conf->cpu_based_exec_ctrl = _cpu_based_exec_control;
@@ -2719,7 +2716,8 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	vmcs_conf->cpu_based_3rd_exec_ctrl = _cpu_based_3rd_exec_control;
 	vmcs_conf->vmexit_ctrl         = _vmexit_control;
 	vmcs_conf->vmentry_ctrl        = _vmentry_control;
-	vmcs_conf->misc	= misc_msr;
+
+	rdmsrl(MSR_IA32_VMX_MISC, vmcs_conf->misc);
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (enlightened_vmcs)
@@ -8555,7 +8553,7 @@ static __init int hardware_setup(void)
 		u64 use_timer_freq = 5000ULL * 1000 * 1000;
 
 		cpu_preemption_timer_multi =
-			vmcs_config.misc & VMX_MISC_PREEMPTION_TIMER_RATE_MASK;
+			vmx_misc_preemption_timer_rate(vmcs_config.misc);
 
 		if (tsc_khz)
 			use_timer_freq = (u64)tsc_khz * 1000;
-- 
2.42.0

