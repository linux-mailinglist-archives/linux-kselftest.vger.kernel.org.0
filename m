Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12EA7E5DB2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjKHTAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjKHTAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30612132;
        Wed,  8 Nov 2023 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470026; x=1731006026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ukS+/b5BwUHCj+QqTdfJhuP2WcGpUwcg7AQHZyyo+p8=;
  b=m4G+UnkAQRoNu38+P1kCKjofAFVvUV6r0FiYU935R73M8WSEqnr5UJ6V
   v63xRYU/pJMC1zzA24/oeD+bmCwc5sM0imvFcOmTj7JsL/1CO3qAGOwmr
   FZipAswXLEJNdhyWP4Ioz2Uay+nv/Itv78aZpDvypYxJOfxIiBaATMGCg
   LVNJtx0KMUlRBHgs/XXfuTMXkJjUkzNm64NZAG2IicHdDajB3DAGpqms1
   p9OWqONJeB1vqu9dp4DN6Ttt4f92jhYcuWKWrTDOg0YOctq26qjuQon1a
   fYbqjfNJXMIJIQhvagS2f4ZQ82ZomIcMwfN2ftPYlH33pSyTuL9MMMe06
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486422"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486422"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892498"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:25 -0800
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
Subject: [PATCH v1 18/23] KVM: nVMX: Add VMCS FRED states checking
Date:   Wed,  8 Nov 2023 10:29:58 -0800
Message-ID: <20231108183003.5981-19-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add FRED related VMCS fields checkings.

As real hardware, nested VMX performs checks on various VMCS fields,
including both controls and guest/host states.  With the introduction
of VMX FRED, add FRED related VMCS fields checkings.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 70 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b85cd5c0ec98..bbfa09d575d3 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2940,6 +2940,7 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 					  struct vmcs12 *vmcs12)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	bool fred_enabled = !!(vmcs12->guest_cr4 & X86_CR4_FRED);
 
 	if (CC(!vmx_control_verify(vmcs12->vm_entry_controls,
 				    vmx->nested.msrs.entry_ctls_low,
@@ -2958,6 +2959,7 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		u32 intr_type = intr_info & INTR_INFO_INTR_TYPE_MASK;
 		bool has_error_code = intr_info & INTR_INFO_DELIVER_CODE_MASK;
 		bool should_have_error_code;
+		bool has_nested_exception = vmx->nested.msrs.basic & VMX_BASIC_NESTED_EXCEPTION;
 		bool urg = nested_cpu_has2(vmcs12,
 					   SECONDARY_EXEC_UNRESTRICTED_GUEST);
 		bool prot_mode = !urg || vmcs12->guest_cr0 & X86_CR0_PE;
@@ -2971,7 +2973,9 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		/* VM-entry interruption-info field: vector */
 		if (CC(intr_type == INTR_TYPE_NMI_INTR && vector != NMI_VECTOR) ||
 		    CC(intr_type == INTR_TYPE_HARD_EXCEPTION && vector > 31) ||
-		    CC(intr_type == INTR_TYPE_OTHER_EVENT && vector != 0))
+		    CC(intr_type == INTR_TYPE_OTHER_EVENT &&
+		       ((!fred_enabled && vector > 0) ||
+		        (fred_enabled && vector > 2))))
 			return -EINVAL;
 
 		/* VM-entry interruption-info field: deliver error code */
@@ -2990,6 +2994,15 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		if (CC(intr_info & INTR_INFO_RESVD_BITS_MASK))
 			return -EINVAL;
 
+		/*
+		 * When the CPU enumerates VMX nested-exception support, bit 13
+		 * (set to indicate a nested exception) of the intr info field
+		 * may have value 1. Otherwise the bit 13 is reserved.
+		 */
+		if (CC(!has_nested_exception &&
+		       (intr_info & INTR_INFO_NESTED_EXCEPTION_MASK)))
+			return -EINVAL;
+
 		/* VM-entry instruction length */
 		switch (intr_type) {
 		case INTR_TYPE_SOFT_EXCEPTION:
@@ -2999,6 +3012,12 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 			    CC(vmcs12->vm_entry_instruction_len == 0 &&
 			    CC(!nested_cpu_has_zero_length_injection(vcpu))))
 				return -EINVAL;
+			break;
+		case INTR_TYPE_OTHER_EVENT:
+			if (fred_enabled && (vector == 1 || vector == 2))
+				if (CC(vmcs12->vm_entry_instruction_len > 15))
+					return -EINVAL;
+			break;
 		}
 	}
 
@@ -3056,14 +3075,31 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 					   vmcs12->host_ia32_perf_global_ctrl)))
 		return -EINVAL;
 
+	/* Host FRED state checking */
 	if (ia32e) {
 		if (CC(!(vmcs12->host_cr4 & X86_CR4_PAE)))
 			return -EINVAL;
+		if (vmcs12->vm_exit_controls & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS &&
+		    vmcs12->secondary_vm_exit_controls & SECONDARY_VM_EXIT_LOAD_IA32_FRED) {
+			/* Bit 2, bits 5:4, and bit 11 of the IA32_FRED_CONFIG must be zero */
+			if (CC(vmcs12->host_ia32_fred_config & 0x834) ||
+			    CC(vmcs12->host_ia32_fred_rsp1 & 0x3F) ||
+			    CC(vmcs12->host_ia32_fred_rsp2 & 0x3F) ||
+			    CC(vmcs12->host_ia32_fred_rsp3 & 0x3F))
+				return -EINVAL;
+			if (CC(is_noncanonical_address(vmcs12->host_ia32_fred_config & ~0xFFFULL, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_rsp1, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_rsp2, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_rsp3, vcpu)))
+				return -EINVAL;
+		}
 	} else {
 		if (CC(vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE) ||
 		    CC(vmcs12->host_cr4 & X86_CR4_PCIDE) ||
 		    CC((vmcs12->host_rip) >> 32))
 			return -EINVAL;
+		if (CC(vmcs12->host_cr4 & X86_CR4_FRED))
+			return -EINVAL;
 	}
 
 	if (CC(vmcs12->host_cs_selector & (SEGMENT_RPL_MASK | SEGMENT_TI_MASK)) ||
@@ -3205,6 +3241,38 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	     CC((vmcs12->guest_bndcfgs & MSR_IA32_BNDCFGS_RSVD))))
 		return -EINVAL;
 
+	/* Guest FRED state checking */
+	if (ia32e) {
+		if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_FRED) {
+			/* Bit 2, bits 5:4, and bit 11 of the IA32_FRED_CONFIG must be zero */
+			if (CC(vmcs12->guest_ia32_fred_config & 0x834) ||
+			    CC(vmcs12->guest_ia32_fred_rsp1 & 0x3F) ||
+			    CC(vmcs12->guest_ia32_fred_rsp2 & 0x3F) ||
+			    CC(vmcs12->guest_ia32_fred_rsp3 & 0x3F))
+				return -EINVAL;
+			if (CC(is_noncanonical_address(vmcs12->guest_ia32_fred_config & ~0xFFFULL, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_rsp1, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_rsp2, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_rsp3, vcpu)))
+				return -EINVAL;
+		}
+		if (vmcs12->guest_cr4 & X86_CR4_FRED) {
+			unsigned int ss_dpl = VMX_AR_DPL(vmcs12->guest_ss_ar_bytes);
+			if (CC(ss_dpl == 1 || ss_dpl == 2))
+				return -EINVAL;
+			if (ss_dpl == 0 &&
+			    CC(!(vmcs12->guest_cs_ar_bytes & VMX_AR_L_MASK)))
+				return -EINVAL;
+			if (ss_dpl == 3 &&
+			    (CC(vmcs12->guest_rflags & X86_EFLAGS_IOPL) ||
+			     CC(vmcs12->guest_interruptibility_info & GUEST_INTR_STATE_STI)))
+				return -EINVAL;
+		}
+	} else {
+		if (CC(vmcs12->guest_cr4 & X86_CR4_FRED))
+			return -EINVAL;
+	}
+
 	if (nested_check_guest_non_reg_state(vmcs12))
 		return -EINVAL;
 
-- 
2.42.0

