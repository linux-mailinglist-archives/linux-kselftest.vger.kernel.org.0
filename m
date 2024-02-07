Return-Path: <linux-kselftest+bounces-4251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ED384D063
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1A01C270B6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9786147;
	Wed,  7 Feb 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2fUHiwa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913682D69;
	Wed,  7 Feb 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328747; cv=none; b=h92oXLdjWOfnqbwnzEmbj7DWWfS403LNrZtye73goGcYsDEKXB+uw4MPHQY/z8hIzrsS3lTvEKZgnNIKcR6/5ir9hphA07JgefYc5Y8ZZ2vf6iCQ4Tr15qPeZg2BsaMM0WLv9Y43GYOF+i724MP1DKXhON3y+YaDCZBaPLtH09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328747; c=relaxed/simple;
	bh=PcnQPgWK+YyII0rNNycJ8HWaVtKVITLhscfUd4NvpMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRidFXETO96n5zAWPE0sPiQPL/Nqnv79UllTTjsyA/D9UDHVxzFpZi/uYMD9FM6KBMUZ7OyTVbAFeQtsAhaSzBxgEVG/649fUh2hp6RVghZpXWf/vAv/0osZshZD0dMXz1+sXetHiCda5In7hEutmPbDcZBy4J68fppqrtyHRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2fUHiwa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328741; x=1738864741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PcnQPgWK+YyII0rNNycJ8HWaVtKVITLhscfUd4NvpMU=;
  b=K2fUHiwaZ7OtREtwzLH+3IA4CYJ02UhSURDT15f9NCvVYgYLhofwKhAz
   4vYboUb7udCRFjKAVyOKboJChGKjnVwX6WJGQ7iFAMZs+BjSV6Ss9lQaw
   qCY7JaE+b4Tz50yo+sB6pH07KnHMFiM3H24u50/dm+6/MkDOTfLPxRXax
   QCtFRUx9/pjNKNfMHqH+eYV5iiLv+WJqz1KmJZRdlCp6rSTLR2uXNtwS0
   lryGlwSx2WKF2X2q/+y2ksbxigh7IVIk9Ddvecb/31d4IOyCV/UOZloEw
   kzQtAKh4srHS7VHuhC2Jj3ExnG73v0AovF2BPTU9Akqy5MfYpBripLhtg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622513"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622513"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020701"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:54 -0800
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
Subject: [PATCH v2 03/25] KVM: VMX: Add support for the secondary VM exit controls
Date: Wed,  7 Feb 2024 09:26:23 -0800
Message-ID: <20240207172646.3981-4-xin3.li@intel.com>
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

Enable the secondary VM exit controls to prepare for FRED enabling.

The activation of the secondary VM exit controls is off now, and it
will be switched on when a VMX feature needing it is enabled.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Change since v1:
* Always load the secondary VM exit controls (Sean Christopherson).
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/include/asm/vmx.h       |  3 +++
 arch/x86/kvm/vmx/capabilities.h  |  9 ++++++++-
 arch/x86/kvm/vmx/vmcs.h          |  1 +
 arch/x86/kvm/vmx/vmx.c           | 17 ++++++++++++++++-
 arch/x86/kvm/vmx/vmx.h           |  7 ++++++-
 6 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4fa2b3dd743e..ab9ec10a3fff 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1112,6 +1112,7 @@
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
+#define MSR_IA32_VMX_EXIT_CTLS2		0x00000493
 
 /* Resctrl MSRs: */
 /* - Intel: */
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 76518e21c54d..272af2004111 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -105,6 +105,7 @@
 #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
 #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
 #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
+#define VM_EXIT_ACTIVATE_SECONDARY_CONTROLS	0x80000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
@@ -250,6 +251,8 @@ enum vmcs_field {
 	TERTIARY_VM_EXEC_CONTROL_HIGH	= 0x00002035,
 	PID_POINTER_TABLE		= 0x00002042,
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
+	SECONDARY_VM_EXIT_CONTROLS	= 0x00002044,
+	SECONDARY_VM_EXIT_CONTROLS_HIGH	= 0x00002045,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
 	VMCS_LINK_POINTER               = 0x00002800,
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index cb6588238f46..e8f3ad0f79ee 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -59,8 +59,9 @@ struct vmcs_config {
 	u32 cpu_based_exec_ctrl;
 	u32 cpu_based_2nd_exec_ctrl;
 	u64 cpu_based_3rd_exec_ctrl;
-	u32 vmexit_ctrl;
 	u32 vmentry_ctrl;
+	u32 vmexit_ctrl;
+	u64 secondary_vmexit_ctrl;
 	u64 misc;
 	struct nested_vmx_msrs nested;
 };
@@ -136,6 +137,12 @@ static inline bool cpu_has_tertiary_exec_ctrls(void)
 		CPU_BASED_ACTIVATE_TERTIARY_CONTROLS;
 }
 
+static inline bool cpu_has_secondary_vmexit_ctrls(void)
+{
+	return vmcs_config.vmexit_ctrl &
+		VM_EXIT_ACTIVATE_SECONDARY_CONTROLS;
+}
+
 static inline bool cpu_has_vmx_virtualize_apic_accesses(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
index 7c1996b433e2..7d45a6504200 100644
--- a/arch/x86/kvm/vmx/vmcs.h
+++ b/arch/x86/kvm/vmx/vmcs.h
@@ -47,6 +47,7 @@ struct vmcs_host_state {
 struct vmcs_controls_shadow {
 	u32 vm_entry;
 	u32 vm_exit;
+	u64 secondary_vm_exit;
 	u32 pin;
 	u32 exec;
 	u32 secondary_exec;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 581967d20659..4023474ea002 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2569,6 +2569,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	u32 _cpu_based_2nd_exec_control = 0;
 	u64 _cpu_based_3rd_exec_control = 0;
 	u32 _vmexit_control = 0;
+	u64 _secondary_vmexit_control = 0;
 	u32 _vmentry_control = 0;
 	u64 basic_msr;
 	int i;
@@ -2688,6 +2689,11 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		_vmexit_control &= ~x_ctrl;
 	}
 
+	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+		_secondary_vmexit_control =
+			adjust_vmx_controls64(KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS,
+					      MSR_IA32_VMX_EXIT_CTLS2);
+
 	rdmsrl(MSR_IA32_VMX_BASIC, basic_msr);
 
 	/* IA-32 SDM Vol 3B: VMCS size is never greater than 4kB. */
@@ -2709,8 +2715,9 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	vmcs_conf->cpu_based_exec_ctrl = _cpu_based_exec_control;
 	vmcs_conf->cpu_based_2nd_exec_ctrl = _cpu_based_2nd_exec_control;
 	vmcs_conf->cpu_based_3rd_exec_ctrl = _cpu_based_3rd_exec_control;
-	vmcs_conf->vmexit_ctrl         = _vmexit_control;
 	vmcs_conf->vmentry_ctrl        = _vmentry_control;
+	vmcs_conf->vmexit_ctrl         = _vmexit_control;
+	vmcs_conf->secondary_vmexit_ctrl   = _secondary_vmexit_control;
 
 	rdmsrl(MSR_IA32_VMX_MISC, vmcs_conf->misc);
 
@@ -4421,6 +4428,11 @@ static u32 vmx_vmexit_ctrl(void)
 		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
 }
 
+static u64 vmx_secondary_vmexit_ctrl(void)
+{
+	return vmcs_config.secondary_vmexit_ctrl;
+}
+
 static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4766,6 +4778,9 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 
 	vm_exit_controls_set(vmx, vmx_vmexit_ctrl());
 
+	if (cpu_has_secondary_vmexit_ctrls())
+		secondary_vm_exit_controls_set(vmx, vmx_secondary_vmexit_ctrl());
+
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_set(vmx, vmx_vmentry_ctrl());
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index e3b0985bb74a..f470eeb2a5c8 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -506,7 +506,11 @@ static inline u8 vmx_get_rvi(void)
 	       VM_EXIT_LOAD_IA32_EFER |					\
 	       VM_EXIT_CLEAR_BNDCFGS |					\
 	       VM_EXIT_PT_CONCEAL_PIP |					\
-	       VM_EXIT_CLEAR_IA32_RTIT_CTL)
+	       VM_EXIT_CLEAR_IA32_RTIT_CTL |				\
+	       VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+
+#define KVM_REQUIRED_VMX_SECONDARY_VM_EXIT_CONTROLS (0)
+#define KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS (0)
 
 #define KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL			\
 	(PIN_BASED_EXT_INTR_MASK |					\
@@ -610,6 +614,7 @@ static __always_inline void lname##_controls_clearbit(struct vcpu_vmx *vmx, u##b
 }
 BUILD_CONTROLS_SHADOW(vm_entry, VM_ENTRY_CONTROLS, 32)
 BUILD_CONTROLS_SHADOW(vm_exit, VM_EXIT_CONTROLS, 32)
+BUILD_CONTROLS_SHADOW(secondary_vm_exit, SECONDARY_VM_EXIT_CONTROLS, 64)
 BUILD_CONTROLS_SHADOW(pin, PIN_BASED_VM_EXEC_CONTROL, 32)
 BUILD_CONTROLS_SHADOW(exec, CPU_BASED_VM_EXEC_CONTROL, 32)
 BUILD_CONTROLS_SHADOW(secondary_exec, SECONDARY_VM_EXEC_CONTROL, 32)
-- 
2.43.0


