Return-Path: <linux-kselftest+bounces-4271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A384D0BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C021F26A74
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B811384A4;
	Wed,  7 Feb 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRavKVRV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DA135400;
	Wed,  7 Feb 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328767; cv=none; b=Ux9iTZfhROBcqiYqIYCr6nLbHPg1GDddBbqSPTiEQzNJf/d+wAgpwdtLk4EBGW30xeGwY0vYboEuL0XoTgVLMaeStY/TUIMp2u8VYaw0MtyBWAfb8a16glWKnb0Va7sgQjKNollBLTEuxlsWs2D6H1sBXqc0ESFF0/ADD6LoLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328767; c=relaxed/simple;
	bh=8BZSbnRLnmeG5U3FhWc8N6oHSSHjwpiY4v6RG2oTEPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tuq3na8c8z14G9q0/gEdrqPKEKX8CbidNTIbW26JkbcGy2qIxQfuYYii55B9p7FMiEUX0vpD3cWd6hxJFYDrup8ts/AbmiVa2DAmfnyCpF3HMZK5MNbHg1vOy4HQB7KZsNc6VnWkgmr8pvE0aFuvv6fYWoJ3oLGyddCzBW+0UOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRavKVRV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328762; x=1738864762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8BZSbnRLnmeG5U3FhWc8N6oHSSHjwpiY4v6RG2oTEPU=;
  b=gRavKVRVYLF5Y1IJIGGdYroeqglKfJBzP3K/c3JGbwQQyj17SoFPkybk
   qRJZcopbgzT6Y/XRJfETHY4q7VsqVjT2IMUwldJfYU42ZrQlXfQB+AQ4N
   oKVwyIumgAppac5cLjjxzH53BVFeth6X9ldafNR9uhQ95qg0GkdG2OmAi
   FDrTEpeef/R7YKgnemkqefmhu8xdqnlc1OK6s3BjBfNSaY5ZCxzqu63ZT
   qH5WY1a6UzPPcEpXt20VSpj/TXCxPd/EkYvmJaV/e3Lsdu32jT4uuiY4U
   9JDfoKjAclZvo/3dzmVRyE2eyu0T/ft2OzZN8bwI3zOPbmCYtIBRyIsoS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622668"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622668"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:59:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020762"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:59 -0800
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
Subject: [PATCH v2 21/25] KVM: nVMX: Add VMCS FRED states checking
Date: Wed,  7 Feb 2024 09:26:41 -0800
Message-ID: <20240207172646.3981-22-xin3.li@intel.com>
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

Add FRED related VMCS fields checkings.

As real hardware, nested VMX performs checks on various VMCS fields,
including both controls and guest/host states.  With the introduction
of VMX FRED, add FRED related VMCS fields checkings.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 80 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 04a9cdb0361f..ef0bd46eb0ce 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2933,6 +2933,8 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 					  struct vmcs12 *vmcs12)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	bool fred_enabled = (vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE) &&
+			    (vmcs12->guest_cr4 & X86_CR4_FRED);
 
 	if (CC(!vmx_control_verify(vmcs12->vm_entry_controls,
 				    vmx->nested.msrs.entry_ctls_low,
@@ -2951,6 +2953,7 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		u32 intr_type = intr_info & INTR_INFO_INTR_TYPE_MASK;
 		bool has_error_code = intr_info & INTR_INFO_DELIVER_CODE_MASK;
 		bool should_have_error_code;
+		bool has_nested_exception = vmx->nested.msrs.basic & VMX_BASIC_NESTED_EXCEPTION;
 		bool urg = nested_cpu_has2(vmcs12,
 					   SECONDARY_EXEC_UNRESTRICTED_GUEST);
 		bool prot_mode = !urg || vmcs12->guest_cr0 & X86_CR0_PE;
@@ -2964,7 +2967,9 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		/* VM-entry interruption-info field: vector */
 		if (CC(intr_type == INTR_TYPE_NMI_INTR && vector != NMI_VECTOR) ||
 		    CC(intr_type == INTR_TYPE_HARD_EXCEPTION && vector > 31) ||
-		    CC(intr_type == INTR_TYPE_OTHER_EVENT && vector != 0))
+		    CC(intr_type == INTR_TYPE_OTHER_EVENT &&
+		       ((!fred_enabled && vector > 0) ||
+		        (fred_enabled && vector > 2))))
 			return -EINVAL;
 
 		/* VM-entry interruption-info field: deliver error code */
@@ -2983,6 +2988,15 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		if (CC(intr_info & INTR_INFO_RESVD_BITS_MASK))
 			return -EINVAL;
 
+		/*
+		 * When the CPU enumerates VMX nested-exception support, bit 13
+		 * (set to indicate a nested exception) of the intr info field
+		 * may have value 1. Otherwise bit 13 is reserved.
+		 */
+		if (CC(!has_nested_exception &&
+		       (intr_info & INTR_INFO_NESTED_EXCEPTION_MASK)))
+			return -EINVAL;
+
 		/* VM-entry instruction length */
 		switch (intr_type) {
 		case INTR_TYPE_SOFT_EXCEPTION:
@@ -2992,6 +3006,12 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
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
 
@@ -3054,9 +3074,30 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 	if (ia32e) {
 		if (CC(!(vmcs12->host_cr4 & X86_CR4_PAE)))
 			return -EINVAL;
+		if (vmcs12->vm_exit_controls & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS &&
+		    vmcs12->secondary_vm_exit_controls & SECONDARY_VM_EXIT_LOAD_IA32_FRED) {
+			/* Bit 11, bits 5:4, and bit 2 of the IA32_FRED_CONFIG must be zero */
+			if (CC(vmcs12->host_ia32_fred_config &
+			       (BIT_ULL(11) | GENMASK_ULL(5, 4) | BIT_ULL(2))) ||
+			    CC(vmcs12->host_ia32_fred_rsp1 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->host_ia32_fred_rsp2 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->host_ia32_fred_rsp3 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->host_ia32_fred_ssp1 & GENMASK_ULL(2, 0)) ||
+			    CC(vmcs12->host_ia32_fred_ssp2 & GENMASK_ULL(2, 0)) ||
+			    CC(vmcs12->host_ia32_fred_ssp3 & GENMASK_ULL(2, 0)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_config & PAGE_MASK, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_rsp1, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_rsp2, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_rsp3, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_ssp1, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_ssp2, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->host_ia32_fred_ssp3, vcpu)))
+				return -EINVAL;
+		}
 	} else {
 		if (CC(vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE) ||
 		    CC(vmcs12->host_cr4 & X86_CR4_PCIDE) ||
+		    CC(vmcs12->host_cr4 & X86_CR4_FRED) ||
 		    CC((vmcs12->host_rip) >> 32))
 			return -EINVAL;
 	}
@@ -3200,6 +3241,43 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	     CC((vmcs12->guest_bndcfgs & MSR_IA32_BNDCFGS_RSVD))))
 		return -EINVAL;
 
+	if (ia32e) {
+		if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_FRED) {
+			/* Bit 11, bits 5:4, and bit 2 of the IA32_FRED_CONFIG must be zero */
+			if (CC(vmcs12->guest_ia32_fred_config &
+			       (BIT_ULL(11) | GENMASK_ULL(5, 4) | BIT_ULL(2))) ||
+			    CC(vmcs12->guest_ia32_fred_rsp1 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_rsp2 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_rsp3 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_ssp1 & GENMASK_ULL(2, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_ssp2 & GENMASK_ULL(2, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_ssp3 & GENMASK_ULL(2, 0)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_config & PAGE_MASK, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_rsp1, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_rsp2, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_rsp3, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_ssp1, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_ssp2, vcpu)) ||
+			    CC(is_noncanonical_address(vmcs12->guest_ia32_fred_ssp3, vcpu)))
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
2.43.0


