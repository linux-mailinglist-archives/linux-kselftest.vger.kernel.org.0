Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C072B47D200
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbhLVMlY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:41:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:11441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245075AbhLVMlK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176870; x=1671712870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yAlG6SskOKjiVPf01LTa++cLf5fZLFFJcjUWQBMgWA=;
  b=UBOrVyVqHMc2uqaYU8gngcwrKTotsLWEDlCrxBus3FIYwf05RtO0vTqY
   Lue/LiPU1jMpsql3rQTwrdvuL+m5L8aZ8RtSgUa7jiABx0p0MU/Q1Y/fH
   3LzZ3NWtA/TfAhCV/FKvfK3E5OgRqPgNajRAklBZUyqJFHYhlNg5CtkCy
   zkxAa6xV78NEg0Ei5V/0VheC6PEA3ZOmsWMouCF9W4CIW8LLpx7hD327n
   0a4o271UZQv0YNl+L8scOVA6iNPpSPA3vXCCLgacuHnv1HFqhxsy4vi6D
   zWR9Fe+P22o0g6WV0M+P63R+vLkkeSCvABKyeVuGYSnmiYEatrN/TCMkk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833422"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833422"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002752"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:41:02 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 13/22] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Date:   Wed, 22 Dec 2021 04:40:43 -0800
Message-Id: <20211222124052.644626-14-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Guest IA32_XFD_ERR is generally modified in two places:

  - Set by CPU when #NM is triggered;
  - Cleared by guest in its #NM handler;

Intercept #NM for the first case, if guest writes XFD as nonzero for
the first time which indicates guest is possible to use XFD generating
the exception. #NM is rare if the guest doesn't use dynamic features.
Otherwise, there is at most one exception per guest task given a
dynamic feature.

Save the current XFD_ERR value to the guest_fpu container in the #NM
VM-exit handler. This must be done with interrupt/preemption disabled,
otherwise the unsaved MSR value may be clobbered by host operations.

Inject a virtual #NM to the guest after saving the MSR value.

Restore the host value (always ZERO outside of the host #NM
handler) before enabling preemption.

Restore the guest value from the guest_fpu container right before
entering the guest (with preemption disabled).

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx/vmcs.h         |  5 +++++
 arch/x86/kvm/vmx/vmx.c          | 22 +++++++++++++++++++++-
 arch/x86/kvm/x86.c              |  6 ++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 555f4de47ef2..f7a661f35d1a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -640,6 +640,7 @@ struct kvm_vcpu_arch {
 	u64 smi_count;
 	bool tpr_access_reporting;
 	bool xsaves_enabled;
+	bool trap_nm;
 	u64 ia32_xss;
 	u64 microcode_version;
 	u64 arch_capabilities;
diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
index 6e5de2e2b0da..c57798b56f95 100644
--- a/arch/x86/kvm/vmx/vmcs.h
+++ b/arch/x86/kvm/vmx/vmcs.h
@@ -129,6 +129,11 @@ static inline bool is_machine_check(u32 intr_info)
 	return is_exception_n(intr_info, MC_VECTOR);
 }
 
+static inline bool is_nm(u32 intr_info)
+{
+	return is_exception_n(intr_info, NM_VECTOR);
+}
+
 /* Undocumented: icebp/int1 */
 static inline bool is_icebp(u32 intr_info)
 {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5974a88c9d35..57d256fbf34b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -36,6 +36,7 @@
 #include <asm/debugreg.h>
 #include <asm/desc.h>
 #include <asm/fpu/api.h>
+#include <asm/fpu/xstate.h>
 #include <asm/idtentry.h>
 #include <asm/io.h>
 #include <asm/irq_remapping.h>
@@ -763,6 +764,9 @@ void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu)
 		vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, match);
 	}
 
+	if (vcpu->arch.trap_nm)
+		eb |= (1u << NM_VECTOR);
+
 	vmcs_write32(EXCEPTION_BITMAP, eb);
 }
 
@@ -1960,6 +1964,13 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_KERNEL_GS_BASE:
 		vmx_write_guest_kernel_gs_base(vmx, data);
 		break;
+	case MSR_IA32_XFD:
+		ret = kvm_set_msr_common(vcpu, msr_info);
+		if (!ret && data) {
+			vcpu->arch.trap_nm = true;
+			vmx_update_exception_bitmap(vcpu);
+		}
+		break;
 #endif
 	case MSR_IA32_SYSENTER_CS:
 		if (is_guest_mode(vcpu))
@@ -4746,7 +4757,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 	vect_info = vmx->idt_vectoring_info;
 	intr_info = vmx_get_intr_info(vcpu);
 
-	if (is_machine_check(intr_info) || is_nmi(intr_info))
+	if (is_machine_check(intr_info) || is_nmi(intr_info) || is_nm(intr_info))
 		return 1; /* handled by handle_exception_nmi_irqoff() */
 
 	if (is_invalid_opcode(intr_info))
@@ -6350,6 +6361,12 @@ static void handle_interrupt_nmi_irqoff(struct kvm_vcpu *vcpu,
 	kvm_after_interrupt(vcpu);
 }
 
+static void handle_exception_nm(struct kvm_vcpu *vcpu)
+{
+	rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+	kvm_queue_exception(vcpu, NM_VECTOR);
+}
+
 static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
 {
 	const unsigned long nmi_entry = (unsigned long)asm_exc_nmi_noist;
@@ -6358,6 +6375,9 @@ static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
 	/* if exit due to PF check for async PF */
 	if (is_page_fault(intr_info))
 		vmx->vcpu.arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
+	/* if exit due to NM, handle before preemptions are enabled */
+	else if (is_nm(intr_info))
+		handle_exception_nm(&vmx->vcpu);
 	/* Handle machine checks before interrupts are enabled */
 	else if (is_machine_check(intr_info))
 		kvm_machine_check();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 36677b754ac9..b22defad5cab 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9893,6 +9893,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		switch_fpu_return();
 
+	if (vcpu->arch.guest_fpu.xfd_err)
+		wrmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+
 	if (unlikely(vcpu->arch.switch_db_regs)) {
 		set_debugreg(0, 7);
 		set_debugreg(vcpu->arch.eff_db[0], 0);
@@ -9956,6 +9959,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	static_call(kvm_x86_handle_exit_irqoff)(vcpu);
 
+	if (vcpu->arch.guest_fpu.xfd_err)
+		wrmsrl(MSR_IA32_XFD_ERR, 0);
+
 	/*
 	 * Consume any pending interrupts, including the possible source of
 	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
-- 
2.27.0

