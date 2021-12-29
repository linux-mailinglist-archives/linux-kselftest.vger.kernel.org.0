Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49812481342
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhL2NOW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:14:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:28047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240232AbhL2NNw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783632; x=1672319632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4TzUDbb6yYbOCFDms0kxgG7E1/7D6l1xZh8+vE8IPCQ=;
  b=jxJ9bomeB+gfUuR8rs4ijs4Dh58l+itfNOkOELvgMvkqCrPgVDwl7407
   FcKAC1Kgnwd1yh/WEQfB1DPPnKQcUblXC3gsWRY9gGtKl1y+1fKMpI4TG
   YRTHvZT7qZudAOwdKsYTtN/cuZL7pdwEwLo45UMeh9uu8PWHcimXAlBe0
   vOMCsu0ULQMBNDYcx95cDXuqQO4f+HyiniSHIYSld2j95wpLPaGrsyQkx
   ORaueyTn2Plps7fS+s7FplQwj3YzkS3gYXGHbo28EwF1z5az6w9/4rn3T
   2wGU6rf546efbP2hqDI+E7GGIrBGrQnsEpeINlvlc0KUYQ14TABvA0MxM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876139"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876139"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281192"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:38 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 12/21] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Date:   Wed, 29 Dec 2021 05:13:19 -0800
Message-Id: <20211229131328.12283-13-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

Guest IA32_XFD_ERR is generally modified in two places:

  - Set by CPU when #NM is triggered;
  - Cleared by guest in its #NM handler;

Intercept #NM for the first case when a nonzero value is written
to IA32_XFD. Nonzero indicates that the guest is willing to do
dynamic fpstate expansion for certain xfeatures, thus KVM needs to
manage and virtualize guest XFD_ERR properly. The vcpu exception
bitmap is updated according to guest_fpu::xfd in XFD write emulation.

Save the current XFD_ERR value to the guest_fpu container in the #NM
VM-exit handler. This must be done with interrupt disabled, otherwise
the unsaved MSR value may be clobbered by host operations.

Inject a virtual #NM to the guest after saving the MSR value.

Restore the host value (always ZERO outside of the host #NM
handler) before enabling interrupt.

Restore the guest value from the guest_fpu container right before
entering the guest (with interrupt disabled).

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kvm/vmx/vmcs.h |  5 +++++
 arch/x86/kvm/vmx/vmx.c  | 26 +++++++++++++++++++++++++-
 arch/x86/kvm/x86.c      |  6 ++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
index 6e5de2e2b0da..e325c290a816 100644
--- a/arch/x86/kvm/vmx/vmcs.h
+++ b/arch/x86/kvm/vmx/vmcs.h
@@ -129,6 +129,11 @@ static inline bool is_machine_check(u32 intr_info)
 	return is_exception_n(intr_info, MC_VECTOR);
 }
 
+static inline bool is_nm_fault(u32 intr_info)
+{
+	return is_exception_n(intr_info, NM_VECTOR);
+}
+
 /* Undocumented: icebp/int1 */
 static inline bool is_icebp(u32 intr_info)
 {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0dbf94eb954f..4e51de876085 100644
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
@@ -763,6 +764,13 @@ void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu)
 		vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, match);
 	}
 
+	/*
+	 * Trap #NM if guest xfd contains a non-zero value so guest XFD_ERR
+	 * can be saved timely.
+	 */
+	if (vcpu->arch.guest_fpu.fpstate->xfd)
+		eb |= (1u << NM_VECTOR);
+
 	vmcs_write32(EXCEPTION_BITMAP, eb);
 }
 
@@ -1960,6 +1968,12 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_KERNEL_GS_BASE:
 		vmx_write_guest_kernel_gs_base(vmx, data);
 		break;
+	case MSR_IA32_XFD:
+		ret = kvm_set_msr_common(vcpu, msr_info);
+		/* Update #NM interception according to guest xfd */
+		if (!ret)
+			vmx_update_exception_bitmap(vcpu);
+		break;
 #endif
 	case MSR_IA32_SYSENTER_CS:
 		if (is_guest_mode(vcpu))
@@ -4745,7 +4759,8 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 	vect_info = vmx->idt_vectoring_info;
 	intr_info = vmx_get_intr_info(vcpu);
 
-	if (is_machine_check(intr_info) || is_nmi(intr_info))
+	if (is_machine_check(intr_info) || is_nmi(intr_info) ||
+	    is_nm_fault(intr_info))
 		return 1; /* handled by handle_exception_nmi_irqoff() */
 
 	if (is_invalid_opcode(intr_info))
@@ -6349,6 +6364,12 @@ static void handle_interrupt_nmi_irqoff(struct kvm_vcpu *vcpu,
 	kvm_after_interrupt(vcpu);
 }
 
+static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
+{
+	rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+	kvm_queue_exception(vcpu, NM_VECTOR);
+}
+
 static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
 {
 	const unsigned long nmi_entry = (unsigned long)asm_exc_nmi_noist;
@@ -6357,6 +6378,9 @@ static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
 	/* if exit due to PF check for async PF */
 	if (is_page_fault(intr_info))
 		vmx->vcpu.arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
+	/* if exit due to NM, handle before preemptions are enabled */
+	else if (is_nm_fault(intr_info))
+		handle_nm_fault_irqoff(&vmx->vcpu);
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
