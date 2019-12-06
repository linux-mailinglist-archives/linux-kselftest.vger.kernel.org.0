Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEF2114DEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2019 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLFJBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Dec 2019 04:01:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:50489 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfLFJBl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Dec 2019 04:01:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 01:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,283,1571727600"; 
   d="scan'208";a="219395098"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.57])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2019 01:01:39 -0800
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] KVM: VMX: Rename NMI_PENDING to NMI_WINDOW
Date:   Fri,  6 Dec 2019 16:45:25 +0800
Message-Id: <20191206084526.131861-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191206084526.131861-1-xiaoyao.li@intel.com>
References: <20191206084526.131861-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename the NMI-window exiting related definitions to match the latest
Intel SDM. No functional changes.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/include/asm/vmx.h                       |  2 +-
 arch/x86/kvm/vmx/nested.c                        | 12 ++++++------
 arch/x86/kvm/vmx/vmx.c                           |  4 ++--
 tools/testing/selftests/kvm/include/x86_64/vmx.h |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 5acda8d9b9a7..06d4420508c5 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -31,7 +31,7 @@
 #define CPU_BASED_CR8_LOAD_EXITING              0x00080000
 #define CPU_BASED_CR8_STORE_EXITING             0x00100000
 #define CPU_BASED_TPR_SHADOW                    0x00200000
-#define CPU_BASED_VIRTUAL_NMI_PENDING		0x00400000
+#define CPU_BASED_NMI_WINDOW_EXITING		0x00400000
 #define CPU_BASED_MOV_DR_EXITING                0x00800000
 #define CPU_BASED_UNCOND_IO_EXITING             0x01000000
 #define CPU_BASED_USE_IO_BITMAPS                0x02000000
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a77e92bd3f72..f8b9da53191e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2173,7 +2173,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 	 */
 	exec_control = vmx_exec_control(vmx); /* L0's desires */
 	exec_control &= ~CPU_BASED_INTR_WINDOW_EXITING;
-	exec_control &= ~CPU_BASED_VIRTUAL_NMI_PENDING;
+	exec_control &= ~CPU_BASED_NMI_WINDOW_EXITING;
 	exec_control &= ~CPU_BASED_TPR_SHADOW;
 	exec_control |= vmcs12->cpu_based_vm_exec_control;
 
@@ -2566,7 +2566,7 @@ static int nested_vmx_check_nmi_controls(struct vmcs12 *vmcs12)
 		return -EINVAL;
 
 	if (CC(!nested_cpu_has_virtual_nmis(vmcs12) &&
-	       nested_cpu_has(vmcs12, CPU_BASED_VIRTUAL_NMI_PENDING)))
+	       nested_cpu_has(vmcs12, CPU_BASED_NMI_WINDOW_EXITING)))
 		return -EINVAL;
 
 	return 0;
@@ -3183,7 +3183,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	u32 exit_qual;
 
 	evaluate_pending_interrupts = exec_controls_get(vmx) &
-		(CPU_BASED_INTR_WINDOW_EXITING | CPU_BASED_VIRTUAL_NMI_PENDING);
+		(CPU_BASED_INTR_WINDOW_EXITING | CPU_BASED_NMI_WINDOW_EXITING);
 	if (likely(!evaluate_pending_interrupts) && kvm_vcpu_apicv_active(vcpu))
 		evaluate_pending_interrupts |= vmx_has_apicv_interrupt(vcpu);
 
@@ -3407,7 +3407,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 */
 	if ((vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) &&
 	    !(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK) &&
-	    !(vmcs12->cpu_based_vm_exec_control & CPU_BASED_VIRTUAL_NMI_PENDING) &&
+	    !(vmcs12->cpu_based_vm_exec_control & CPU_BASED_NMI_WINDOW_EXITING) &&
 	    !((vmcs12->cpu_based_vm_exec_control & CPU_BASED_INTR_WINDOW_EXITING) &&
 	      (vmcs12->guest_rflags & X86_EFLAGS_IF))) {
 		vmx->nested.nested_run_pending = 0;
@@ -5527,7 +5527,7 @@ bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu, u32 exit_reason)
 	case EXIT_REASON_INTERRUPT_WINDOW:
 		return nested_cpu_has(vmcs12, CPU_BASED_INTR_WINDOW_EXITING);
 	case EXIT_REASON_NMI_WINDOW:
-		return nested_cpu_has(vmcs12, CPU_BASED_VIRTUAL_NMI_PENDING);
+		return nested_cpu_has(vmcs12, CPU_BASED_NMI_WINDOW_EXITING);
 	case EXIT_REASON_TASK_SWITCH:
 		return true;
 	case EXIT_REASON_CPUID:
@@ -6016,7 +6016,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps,
 		CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR;
 	msrs->procbased_ctls_high &=
 		CPU_BASED_INTR_WINDOW_EXITING |
-		CPU_BASED_VIRTUAL_NMI_PENDING | CPU_BASED_USE_TSC_OFFSETING |
+		CPU_BASED_NMI_WINDOW_EXITING | CPU_BASED_USE_TSC_OFFSETING |
 		CPU_BASED_HLT_EXITING | CPU_BASED_INVLPG_EXITING |
 		CPU_BASED_MWAIT_EXITING | CPU_BASED_CR3_LOAD_EXITING |
 		CPU_BASED_CR3_STORE_EXITING |
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0e3ba51436e4..84ceee734e98 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4371,7 +4371,7 @@ static void enable_nmi_window(struct kvm_vcpu *vcpu)
 		return;
 	}
 
-	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_NMI_PENDING);
+	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_NMI_WINDOW_EXITING);
 }
 
 static void vmx_inject_irq(struct kvm_vcpu *vcpu)
@@ -5192,7 +5192,7 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
 static int handle_nmi_window(struct kvm_vcpu *vcpu)
 {
 	WARN_ON_ONCE(!enable_vnmi);
-	exec_controls_clearbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_NMI_PENDING);
+	exec_controls_clearbit(to_vmx(vcpu), CPU_BASED_NMI_WINDOW_EXITING);
 	++vcpu->stat.nmi_window_exits;
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index c6e442d7a241..7eb38451c359 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -30,7 +30,7 @@
 #define CPU_BASED_CR8_LOAD_EXITING		0x00080000
 #define CPU_BASED_CR8_STORE_EXITING		0x00100000
 #define CPU_BASED_TPR_SHADOW			0x00200000
-#define CPU_BASED_VIRTUAL_NMI_PENDING		0x00400000
+#define CPU_BASED_NMI_WINDOW_EXITING		0x00400000
 #define CPU_BASED_MOV_DR_EXITING		0x00800000
 #define CPU_BASED_UNCOND_IO_EXITING		0x01000000
 #define CPU_BASED_USE_IO_BITMAPS		0x02000000
-- 
2.19.1

