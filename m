Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB063114DF1
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2019 10:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLFJBs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Dec 2019 04:01:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:50490 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfLFJBm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Dec 2019 04:01:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 01:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,283,1571727600"; 
   d="scan'208";a="219395101"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.57])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2019 01:01:40 -0800
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] KVM: VMX: Fix the spelling of CPU_BASED_USE_TSC_OFFSETTING
Date:   Fri,  6 Dec 2019 16:45:26 +0800
Message-Id: <20191206084526.131861-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191206084526.131861-1-xiaoyao.li@intel.com>
References: <20191206084526.131861-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The mis-spelling is found by checkpatch.pl, so fix them.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/include/asm/vmx.h                               | 2 +-
 arch/x86/kvm/vmx/nested.c                                | 8 ++++----
 arch/x86/kvm/vmx/vmx.c                                   | 6 +++---
 tools/testing/selftests/kvm/include/x86_64/vmx.h         | 2 +-
 tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 06d4420508c5..d716fe938fc0 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -20,7 +20,7 @@
  * Definitions of Primary Processor-Based VM-Execution Controls.
  */
 #define CPU_BASED_INTR_WINDOW_EXITING           0x00000004
-#define CPU_BASED_USE_TSC_OFFSETING             0x00000008
+#define CPU_BASED_USE_TSC_OFFSETTING            0x00000008
 #define CPU_BASED_HLT_EXITING                   0x00000080
 #define CPU_BASED_INVLPG_EXITING                0x00000200
 #define CPU_BASED_MWAIT_EXITING                 0x00000400
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f8b9da53191e..8c215da368b7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3230,7 +3230,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	}
 
 	enter_guest_mode(vcpu);
-	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
 
 	if (prepare_vmcs02(vcpu, vmcs12, &exit_qual))
@@ -3294,7 +3294,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	 * 26.7 "VM-entry failures during or after loading guest state".
 	 */
 vmentry_fail_vmexit_guest_mode:
-	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
 	leave_guest_mode(vcpu);
 
@@ -4209,7 +4209,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	if (nested_cpu_has_preemption_timer(vmcs12))
 		hrtimer_cancel(&to_vmx(vcpu)->nested.preemption_timer);
 
-	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
 
 	if (likely(!vmx->fail)) {
@@ -6016,7 +6016,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps,
 		CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR;
 	msrs->procbased_ctls_high &=
 		CPU_BASED_INTR_WINDOW_EXITING |
-		CPU_BASED_NMI_WINDOW_EXITING | CPU_BASED_USE_TSC_OFFSETING |
+		CPU_BASED_NMI_WINDOW_EXITING | CPU_BASED_USE_TSC_OFFSETTING |
 		CPU_BASED_HLT_EXITING | CPU_BASED_INVLPG_EXITING |
 		CPU_BASED_MWAIT_EXITING | CPU_BASED_CR3_LOAD_EXITING |
 		CPU_BASED_CR3_STORE_EXITING |
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 84ceee734e98..ec0bada57792 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1724,7 +1724,7 @@ static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
 	if (is_guest_mode(vcpu) &&
-	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
+	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING))
 		return vcpu->arch.tsc_offset - vmcs12->tsc_offset;
 
 	return vcpu->arch.tsc_offset;
@@ -1742,7 +1742,7 @@ static u64 vmx_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 	 * to the newly set TSC to get L2's TSC.
 	 */
 	if (is_guest_mode(vcpu) &&
-	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
+	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING))
 		g_tsc_offset = vmcs12->tsc_offset;
 
 	trace_kvm_write_tsc_offset(vcpu->vcpu_id,
@@ -2363,7 +2363,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	      CPU_BASED_CR3_STORE_EXITING |
 	      CPU_BASED_UNCOND_IO_EXITING |
 	      CPU_BASED_MOV_DR_EXITING |
-	      CPU_BASED_USE_TSC_OFFSETING |
+	      CPU_BASED_USE_TSC_OFFSETTING |
 	      CPU_BASED_MWAIT_EXITING |
 	      CPU_BASED_MONITOR_EXITING |
 	      CPU_BASED_INVLPG_EXITING |
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 7eb38451c359..3d27069b9ed9 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -19,7 +19,7 @@
  * Definitions of Primary Processor-Based VM-Execution Controls.
  */
 #define CPU_BASED_INTR_WINDOW_EXITING		0x00000004
-#define CPU_BASED_USE_TSC_OFFSETING		0x00000008
+#define CPU_BASED_USE_TSC_OFFSETTING		0x00000008
 #define CPU_BASED_HLT_EXITING			0x00000080
 #define CPU_BASED_INVLPG_EXITING		0x00000200
 #define CPU_BASED_MWAIT_EXITING			0x00000400
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 5590fd2bcf87..69e482a95c47 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -98,7 +98,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	prepare_vmcs(vmx_pages, l2_guest_code,
 		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
-	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETING;
+	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETTING;
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 	vmwrite(TSC_OFFSET, TSC_OFFSET_VALUE);
 
-- 
2.19.1

