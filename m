Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0580748529F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbiAEMgQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:6474 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240105AbiAEMgL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386171; x=1672922171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yBqoKfVLohfyGXaWeQ4n6LnbKVPFY37z/4UJzBWLFPM=;
  b=fyZDJ1ijFE3d7hjvbYFaYTaJt/GM7iO8ScE4SGZ5//H0LN9XaVMw7jlW
   ls2f0GojSYOORk85f7F9V9PiNKreQ0UrJ1YOAPma8FXo66UZAXLRComeq
   ZyuqrjeURG0D8cLp7vCpew58yvolxrMcWWQeZ+TWmqYe47dvo/Fe4TL70
   BCFYSLJOkD5tgc8yZPKQVWTCDBPWSRQInOB8UqIlVsZNXlQiiQnB4eYgk
   RUJL1YAwiWn58M+yor6o+9kCU14iytPyBQnKMTIuZKMcOh/gt2Rgi6tDm
   PAcKy/0Ez5KlDrDZUVxrfx3V6LExmaL/zWRqgPuf5VBFoXmneZ2O24T1v
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249380"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249380"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004862"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:38 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 12/21] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Date:   Wed,  5 Jan 2022 04:35:23 -0800
Message-Id: <20220105123532.12586-13-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
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
bitmap is updated in XFD write emulation according to guest_fpu::xfd.

Save the current XFD_ERR value to the guest_fpu container in the #NM
VM-exit handler. This must be done with interrupt disabled, otherwise
the unsaved MSR value may be clobbered by host activity.

The saving operation is conducted conditionally only when guest_fpu:xfd
includes a non-zero value. Doing so also avoids misread on a platform
which doesn't support XFD but #NM is triggered due to L1 interception.

Queueing #NM to the guest is postponed to handle_exception_nmi(). This
goes through the nested_vmx check so a virtual vmexit is queued instead
when #NM is triggered in L2 but L1 wants to intercept it.

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
 arch/x86/kvm/vmx/vmx.c  | 48 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c      |  6 ++++++
 3 files changed, 59 insertions(+)

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
index fe06b02994e6..939e6aad128c 100644
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
@@ -761,6 +762,13 @@ void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu)
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
 
@@ -1967,6 +1975,12 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -4798,6 +4812,17 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 	if (is_machine_check(intr_info) || is_nmi(intr_info))
 		return 1; /* handled by handle_exception_nmi_irqoff() */
 
+	/*
+	 * Queue the exception here instead of in handle_nm_fault_irqoff().
+	 * This ensures the nested_vmx check is not skipped so vmexit can
+	 * be reflected to L1 (when it intercepts #NM) before reaching this
+	 * point.
+	 */
+	if (is_nm_fault(intr_info)) {
+		kvm_queue_exception(vcpu, NM_VECTOR);
+		return 1;
+	}
+
 	if (is_invalid_opcode(intr_info))
 		return handle_ud(vcpu);
 
@@ -6399,6 +6424,26 @@ static void handle_interrupt_nmi_irqoff(struct kvm_vcpu *vcpu,
 	kvm_after_interrupt(vcpu);
 }
 
+static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Save xfd_err to guest_fpu before interrupt is enabled, so the
+	 * MSR value is not clobbered by the host activity before the guest
+	 * has chance to consume it.
+	 *
+	 * We should not blindly read xfd_err here, since this exception
+	 * might be caused by L1 interception on a platform which doesn't
+	 * support xfd at all.
+	 *
+	 * Do it conditionally upon guest_fpu::xfd. xfd_err matters
+	 * only when xfd contains a non-zero value.
+	 *
+	 * Queuing exception is done in vmx_handle_exit. See comment there.
+	 */
+	if (vcpu->arch.guest_fpu.fpstate->xfd)
+		rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+}
+
 static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
 {
 	const unsigned long nmi_entry = (unsigned long)asm_exc_nmi_noist;
@@ -6407,6 +6452,9 @@ static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
 	/* if exit due to PF check for async PF */
 	if (is_page_fault(intr_info))
 		vmx->vcpu.arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
+	/* if exit due to NM, handle before interrupts are enabled */
+	else if (is_nm_fault(intr_info))
+		handle_nm_fault_irqoff(&vmx->vcpu);
 	/* Handle machine checks before interrupts are enabled */
 	else if (is_machine_check(intr_info))
 		kvm_machine_check();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 21ce65220e38..2c988f8ca616 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9953,6 +9953,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		switch_fpu_return();
 
+	if (vcpu->arch.guest_fpu.xfd_err)
+		wrmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+
 	if (unlikely(vcpu->arch.switch_db_regs)) {
 		set_debugreg(0, 7);
 		set_debugreg(vcpu->arch.eff_db[0], 0);
@@ -10016,6 +10019,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	static_call(kvm_x86_handle_exit_irqoff)(vcpu);
 
+	if (vcpu->arch.guest_fpu.xfd_err)
+		wrmsrl(MSR_IA32_XFD_ERR, 0);
+
 	/*
 	 * Consume any pending interrupts, including the possible source of
 	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
