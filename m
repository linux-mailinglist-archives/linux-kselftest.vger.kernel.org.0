Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF916114DED
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2019 10:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfLFJBl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Dec 2019 04:01:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:50484 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfLFJBj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Dec 2019 04:01:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 01:01:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,283,1571727600"; 
   d="scan'208";a="219395090"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.57])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2019 01:01:37 -0800
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/3] KVM: VMX: Rename INTERRUPT_PENDING to INTERRUPT_WINDOW
Date:   Fri,  6 Dec 2019 16:45:24 +0800
Message-Id: <20191206084526.131861-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191206084526.131861-1-xiaoyao.li@intel.com>
References: <20191206084526.131861-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename interrupt-windown exiting related definitions to match the
latest Intel SDM. No functional changes.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/include/asm/vmx.h                       |  2 +-
 arch/x86/include/uapi/asm/vmx.h                  |  4 ++--
 arch/x86/kvm/vmx/nested.c                        | 12 ++++++------
 arch/x86/kvm/vmx/vmx.c                           | 10 +++++-----
 tools/arch/x86/include/uapi/asm/vmx.h            |  4 ++--
 tools/testing/selftests/kvm/include/x86_64/vmx.h |  4 ++--
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 1835767aa335..5acda8d9b9a7 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -19,7 +19,7 @@
 /*
  * Definitions of Primary Processor-Based VM-Execution Controls.
  */
-#define CPU_BASED_VIRTUAL_INTR_PENDING          0x00000004
+#define CPU_BASED_INTR_WINDOW_EXITING           0x00000004
 #define CPU_BASED_USE_TSC_OFFSETING             0x00000008
 #define CPU_BASED_HLT_EXITING                   0x00000080
 #define CPU_BASED_INVLPG_EXITING                0x00000200
diff --git a/arch/x86/include/uapi/asm/vmx.h b/arch/x86/include/uapi/asm/vmx.h
index 3eb8411ab60e..e95b72ec19bc 100644
--- a/arch/x86/include/uapi/asm/vmx.h
+++ b/arch/x86/include/uapi/asm/vmx.h
@@ -33,7 +33,7 @@
 #define EXIT_REASON_TRIPLE_FAULT        2
 #define EXIT_REASON_INIT_SIGNAL			3
 
-#define EXIT_REASON_PENDING_INTERRUPT   7
+#define EXIT_REASON_INTERRUPT_WINDOW    7
 #define EXIT_REASON_NMI_WINDOW          8
 #define EXIT_REASON_TASK_SWITCH         9
 #define EXIT_REASON_CPUID               10
@@ -94,7 +94,7 @@
 	{ EXIT_REASON_EXTERNAL_INTERRUPT,    "EXTERNAL_INTERRUPT" }, \
 	{ EXIT_REASON_TRIPLE_FAULT,          "TRIPLE_FAULT" }, \
 	{ EXIT_REASON_INIT_SIGNAL,           "INIT_SIGNAL" }, \
-	{ EXIT_REASON_PENDING_INTERRUPT,     "PENDING_INTERRUPT" }, \
+	{ EXIT_REASON_INTERRUPT_WINDOW,      "INTERRUPT_WINDOW" }, \
 	{ EXIT_REASON_NMI_WINDOW,            "NMI_WINDOW" }, \
 	{ EXIT_REASON_TASK_SWITCH,           "TASK_SWITCH" }, \
 	{ EXIT_REASON_CPUID,                 "CPUID" }, \
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4aea7d304beb..a77e92bd3f72 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2172,7 +2172,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 	 * EXEC CONTROLS
 	 */
 	exec_control = vmx_exec_control(vmx); /* L0's desires */
-	exec_control &= ~CPU_BASED_VIRTUAL_INTR_PENDING;
+	exec_control &= ~CPU_BASED_INTR_WINDOW_EXITING;
 	exec_control &= ~CPU_BASED_VIRTUAL_NMI_PENDING;
 	exec_control &= ~CPU_BASED_TPR_SHADOW;
 	exec_control |= vmcs12->cpu_based_vm_exec_control;
@@ -3183,7 +3183,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	u32 exit_qual;
 
 	evaluate_pending_interrupts = exec_controls_get(vmx) &
-		(CPU_BASED_VIRTUAL_INTR_PENDING | CPU_BASED_VIRTUAL_NMI_PENDING);
+		(CPU_BASED_INTR_WINDOW_EXITING | CPU_BASED_VIRTUAL_NMI_PENDING);
 	if (likely(!evaluate_pending_interrupts) && kvm_vcpu_apicv_active(vcpu))
 		evaluate_pending_interrupts |= vmx_has_apicv_interrupt(vcpu);
 
@@ -3408,7 +3408,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if ((vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) &&
 	    !(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK) &&
 	    !(vmcs12->cpu_based_vm_exec_control & CPU_BASED_VIRTUAL_NMI_PENDING) &&
-	    !((vmcs12->cpu_based_vm_exec_control & CPU_BASED_VIRTUAL_INTR_PENDING) &&
+	    !((vmcs12->cpu_based_vm_exec_control & CPU_BASED_INTR_WINDOW_EXITING) &&
 	      (vmcs12->guest_rflags & X86_EFLAGS_IF))) {
 		vmx->nested.nested_run_pending = 0;
 		return kvm_vcpu_halt(vcpu);
@@ -5524,8 +5524,8 @@ bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu, u32 exit_reason)
 		return false;
 	case EXIT_REASON_TRIPLE_FAULT:
 		return true;
-	case EXIT_REASON_PENDING_INTERRUPT:
-		return nested_cpu_has(vmcs12, CPU_BASED_VIRTUAL_INTR_PENDING);
+	case EXIT_REASON_INTERRUPT_WINDOW:
+		return nested_cpu_has(vmcs12, CPU_BASED_INTR_WINDOW_EXITING);
 	case EXIT_REASON_NMI_WINDOW:
 		return nested_cpu_has(vmcs12, CPU_BASED_VIRTUAL_NMI_PENDING);
 	case EXIT_REASON_TASK_SWITCH:
@@ -6015,7 +6015,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps,
 	msrs->procbased_ctls_low =
 		CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR;
 	msrs->procbased_ctls_high &=
-		CPU_BASED_VIRTUAL_INTR_PENDING |
+		CPU_BASED_INTR_WINDOW_EXITING |
 		CPU_BASED_VIRTUAL_NMI_PENDING | CPU_BASED_USE_TSC_OFFSETING |
 		CPU_BASED_HLT_EXITING | CPU_BASED_INVLPG_EXITING |
 		CPU_BASED_MWAIT_EXITING | CPU_BASED_CR3_LOAD_EXITING |
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e7ea332ad1e8..0e3ba51436e4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4360,7 +4360,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 static void enable_irq_window(struct kvm_vcpu *vcpu)
 {
-	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_INTR_PENDING);
+	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_INTR_WINDOW_EXITING);
 }
 
 static void enable_nmi_window(struct kvm_vcpu *vcpu)
@@ -4979,7 +4979,7 @@ static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
 
 static int handle_interrupt_window(struct kvm_vcpu *vcpu)
 {
-	exec_controls_clearbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_INTR_PENDING);
+	exec_controls_clearbit(to_vmx(vcpu), CPU_BASED_INTR_WINDOW_EXITING);
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
@@ -5213,7 +5213,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	WARN_ON_ONCE(vmx->emulation_required && vmx->nested.nested_run_pending);
 
 	intr_window_requested = exec_controls_get(vmx) &
-				CPU_BASED_VIRTUAL_INTR_PENDING;
+				CPU_BASED_INTR_WINDOW_EXITING;
 
 	while (vmx->emulation_required && count-- != 0) {
 		if (intr_window_requested && vmx_interrupt_allowed(vcpu))
@@ -5537,7 +5537,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_CPUID]                   = kvm_emulate_cpuid,
 	[EXIT_REASON_MSR_READ]                = kvm_emulate_rdmsr,
 	[EXIT_REASON_MSR_WRITE]               = kvm_emulate_wrmsr,
-	[EXIT_REASON_PENDING_INTERRUPT]       = handle_interrupt_window,
+	[EXIT_REASON_INTERRUPT_WINDOW]        = handle_interrupt_window,
 	[EXIT_REASON_HLT]                     = kvm_emulate_halt,
 	[EXIT_REASON_INVD]		      = handle_invd,
 	[EXIT_REASON_INVLPG]		      = handle_invlpg,
@@ -5917,7 +5917,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu)
 			return kvm_emulate_wrmsr(vcpu);
 		else if (exit_reason == EXIT_REASON_PREEMPTION_TIMER)
 			return handle_preemption_timer(vcpu);
-		else if (exit_reason == EXIT_REASON_PENDING_INTERRUPT)
+		else if (exit_reason == EXIT_REASON_INTERRUPT_WINDOW)
 			return handle_interrupt_window(vcpu);
 		else if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
 			return handle_external_interrupt(vcpu);
diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index 3eb8411ab60e..e95b72ec19bc 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -33,7 +33,7 @@
 #define EXIT_REASON_TRIPLE_FAULT        2
 #define EXIT_REASON_INIT_SIGNAL			3
 
-#define EXIT_REASON_PENDING_INTERRUPT   7
+#define EXIT_REASON_INTERRUPT_WINDOW    7
 #define EXIT_REASON_NMI_WINDOW          8
 #define EXIT_REASON_TASK_SWITCH         9
 #define EXIT_REASON_CPUID               10
@@ -94,7 +94,7 @@
 	{ EXIT_REASON_EXTERNAL_INTERRUPT,    "EXTERNAL_INTERRUPT" }, \
 	{ EXIT_REASON_TRIPLE_FAULT,          "TRIPLE_FAULT" }, \
 	{ EXIT_REASON_INIT_SIGNAL,           "INIT_SIGNAL" }, \
-	{ EXIT_REASON_PENDING_INTERRUPT,     "PENDING_INTERRUPT" }, \
+	{ EXIT_REASON_INTERRUPT_WINDOW,      "INTERRUPT_WINDOW" }, \
 	{ EXIT_REASON_NMI_WINDOW,            "NMI_WINDOW" }, \
 	{ EXIT_REASON_TASK_SWITCH,           "TASK_SWITCH" }, \
 	{ EXIT_REASON_CPUID,                 "CPUID" }, \
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index f52e0ba84fed..c6e442d7a241 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -18,7 +18,7 @@
 /*
  * Definitions of Primary Processor-Based VM-Execution Controls.
  */
-#define CPU_BASED_VIRTUAL_INTR_PENDING		0x00000004
+#define CPU_BASED_INTR_WINDOW_EXITING		0x00000004
 #define CPU_BASED_USE_TSC_OFFSETING		0x00000008
 #define CPU_BASED_HLT_EXITING			0x00000080
 #define CPU_BASED_INVLPG_EXITING		0x00000200
@@ -103,7 +103,7 @@
 #define EXIT_REASON_EXCEPTION_NMI	0
 #define EXIT_REASON_EXTERNAL_INTERRUPT	1
 #define EXIT_REASON_TRIPLE_FAULT	2
-#define EXIT_REASON_PENDING_INTERRUPT	7
+#define EXIT_REASON_INTERRUPT_WINDOW	7
 #define EXIT_REASON_NMI_WINDOW		8
 #define EXIT_REASON_TASK_SWITCH		9
 #define EXIT_REASON_CPUID		10
-- 
2.19.1

