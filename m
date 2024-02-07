Return-Path: <linux-kselftest+bounces-4265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1AB84D0A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D7B1C20D42
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194AF135418;
	Wed,  7 Feb 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rn+Q2Da6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF912EBF0;
	Wed,  7 Feb 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328762; cv=none; b=KBq6blAsaoJC8HofcUm4S1Qg0CbCo6EFQ4L+Gba5QYYmY7aWl620GYKqKVCxj6QL8ezgmd2cp3zE04M4xCSzV/GgPetkxo2qhL8YdFs1pIZjLcwLU+WaucLTh9CxzrW+SzAhGqo/DbVmxL5J2GbIEFJKgVvDn/d93tB1Ku2/XLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328762; c=relaxed/simple;
	bh=USb5Ju1kxbbARTyuAyo5ZcKDfqzzPCpBdNzGP1yedVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueNNWiI8X0ST4cvCpa/PYVQ7sDfFH8kBq7QQmmJNpNBig6hZe1bBuh9np9VoRbrLy4zeKsFJX5kWVku997Y8ZeL+ZL2K5m8oK9lroaGSY0+ZSlaEvouvszJzDur4BrnpFISRMehNM+9FqwzU7ipK0fUUvPIMvRMnpoqGFQ6wBrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rn+Q2Da6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328757; x=1738864757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=USb5Ju1kxbbARTyuAyo5ZcKDfqzzPCpBdNzGP1yedVA=;
  b=Rn+Q2Da6qCkY/kpr+0pQ2Hsm0dSkq6ZZkpJwGteBpVVqWTs+f8evJjSM
   nIVPKirRfs/FQ075N+RcaG1jmX/vdOZYV0bmqSuP2NPEvBifTJ3ukMYC5
   aIAfek1qTXze7VIVWHOKeNsG8QZxYjefVBX015M80P4AUnP7ENEl1R19N
   5rUZJ54p+TzhZg6XsqFdEXEfMLHjiaNN81jzvo1E4X2wn5UsQmH/Tg2m5
   0jodA2mJSBT/b99Az4I4tCEl6vaa1qWUEVoz9++ecdrUthRMsEgRKkHA6
   R76UWdwNSgRSXP4qan1nLGtTcQdE8rUX1XLDkBSCnX53mxKXj/AmCqqZI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622644"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622644"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020748"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:57 -0800
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
Subject: [PATCH v2 17/25] KVM: nVMX: Add support for the secondary VM exit controls
Date: Wed,  7 Feb 2024 09:26:37 -0800
Message-ID: <20240207172646.3981-18-xin3.li@intel.com>
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

Enable the secondary VM exit controls to prepare for nested FRED.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---
 Documentation/virt/kvm/x86/nested-vmx.rst |  1 +
 arch/x86/kvm/vmx/capabilities.h           |  1 +
 arch/x86/kvm/vmx/nested.c                 | 15 ++++++++++++++-
 arch/x86/kvm/vmx/vmcs12.c                 |  1 +
 arch/x86/kvm/vmx/vmcs12.h                 |  2 ++
 arch/x86/kvm/x86.h                        |  2 +-
 6 files changed, 20 insertions(+), 2 deletions(-)

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
 
 
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 73bf6618c425..b41c2cde811d 100644
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
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8a5fda04e2de..1132e360ff13 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1431,6 +1431,7 @@ int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
 	case MSR_IA32_VMX_PINBASED_CTLS:
 	case MSR_IA32_VMX_PROCBASED_CTLS:
 	case MSR_IA32_VMX_EXIT_CTLS:
+	case MSR_IA32_VMX_EXIT_CTLS2:
 	case MSR_IA32_VMX_ENTRY_CTLS:
 		/*
 		 * The "non-true" VMX capability MSRs are generated from the
@@ -1509,6 +1510,9 @@ int vmx_get_vmx_msr(struct nested_vmx_msrs *msrs, u32 msr_index, u64 *pdata)
 		if (msr_index == MSR_IA32_VMX_EXIT_CTLS)
 			*pdata |= VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR;
 		break;
+	case MSR_IA32_VMX_EXIT_CTLS2:
+		*pdata = msrs->secondary_exit_ctls;
+		break;
 	case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
 	case MSR_IA32_VMX_ENTRY_CTLS:
 		*pdata = vmx_control_msr(
@@ -2443,6 +2447,11 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
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
@@ -6856,13 +6865,17 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
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
index c1f1d5696080..498bb6090b1e 100644
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
2.43.0


