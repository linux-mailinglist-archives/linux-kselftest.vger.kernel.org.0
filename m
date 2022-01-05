Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4C4852B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbiAEMgn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:6467 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240158AbiAEMgP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386175; x=1672922175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+VhmcyZLI52kxigvxsRrOyN1WGA41WgS5IooB8rfF4I=;
  b=McaGpxguhubMcvau3s4M0vs0uQ8agd72/gxWHcehKwtYTkdvO3uwJM45
   lhJhK7dXzwCg4nX5GTKGjG1r+jfNO0O2xg8bfUkJxwINO3K+xmEffkbFB
   elpebTQ/jF+bWj28/4yw9SGY0r6iWOpiQEb11cyPUC285Ojp+H/XzTw0i
   3LnlkGN+xc5KRLXblGtGLWKVxV3BJqQUqUJ+vYYWZrluc9VqFFsZdaB0p
   F4fQAz5pBHP7fNprlA1h7AV2aYnPm4fKg2Ky7qHfr8vslOamDpbhVm3so
   Obll0Bv58jpFsfnWVR2TrXggRZ6GasYAgg5Af3N2m08oE5rrEuO1dMJEz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249395"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249395"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004905"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:43 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 21/21] kvm: x86: Disable interception for IA32_XFD on demand
Date:   Wed,  5 Jan 2022 04:35:32 -0800
Message-Id: <20220105123532.12586-22-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kevin Tian <kevin.tian@intel.com>

Always intercepting IA32_XFD causes non-negligible overhead when this
register is updated frequently in the guest.

Disable r/w emulation after intercepting the first WRMSR(IA32_XFD)
with a non-zero value.

Disable WRMSR emulation implies that IA32_XFD becomes out-of-sync
with the software states in fpstate and the per-cpu xfd cache. This
leads to two additional changes accordingly:

  - Call fpu_sync_guest_vmexit_xfd_state() after vm-exit to bring
    software states back in-sync with the MSR, before handle_exit_irqoff()
    is called.

  - Always trap #NM once write interception is disabled for IA32_XFD.
    The #NM exception is rare if the guest doesn't use dynamic
    features. Otherwise, there is at most one exception per guest
    task given a dynamic feature.

p.s. We have confirmed that SDM is being revised to say that
when setting IA32_XFD[18] the AMX register state is not guaranteed
to be preserved. This clarification avoids adding mess for a creative
guest which sets IA32_XFD[18]=1 before saving active AMX state to
its own storage.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx/vmx.c          | 24 +++++++++++++++++++-----
 arch/x86/kvm/vmx/vmx.h          |  2 +-
 arch/x86/kvm/x86.c              |  8 ++++++++
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5d97f4adc1cb..2e8ffe269c23 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -647,6 +647,7 @@ struct kvm_vcpu_arch {
 	u64 smi_count;
 	bool tpr_access_reporting;
 	bool xsaves_enabled;
+	bool xfd_no_write_intercept;
 	u64 ia32_xss;
 	u64 microcode_version;
 	u64 arch_capabilities;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b601dc8a7f13..a3be4b02df2c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -162,6 +162,7 @@ static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
 	MSR_FS_BASE,
 	MSR_GS_BASE,
 	MSR_KERNEL_GS_BASE,
+	MSR_IA32_XFD,
 	MSR_IA32_XFD_ERR,
 #endif
 	MSR_IA32_SYSENTER_CS,
@@ -764,10 +765,11 @@ void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu)
 	}
 
 	/*
-	 * Trap #NM if guest xfd contains a non-zero value so guest XFD_ERR
-	 * can be saved timely.
+	 * Disabling xfd interception indicates that dynamic xfeatures
+	 * might be used in the guest. Always trap #NM in this case
+	 * to save guest xfd_err timely.
 	 */
-	if (vcpu->arch.guest_fpu.fpstate->xfd)
+	if (vcpu->arch.xfd_no_write_intercept)
 		eb |= (1u << NM_VECTOR);
 
 	vmcs_write32(EXCEPTION_BITMAP, eb);
@@ -1978,9 +1980,21 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_XFD:
 		ret = kvm_set_msr_common(vcpu, msr_info);
-		/* Update #NM interception according to guest xfd */
-		if (!ret)
+		/*
+		 * Always intercepting WRMSR could incur non-negligible
+		 * overhead given xfd might be changed frequently in
+		 * guest context switch. Disable write interception
+		 * upon the first write with a non-zero value (indicating
+		 * potential usage on dynamic xfeatures). Also update
+		 * exception bitmap to trap #NM for proper virtualization
+		 * of guest xfd_err.
+		 */
+		if (!ret && data) {
+			vmx_disable_intercept_for_msr(vcpu, MSR_IA32_XFD,
+						      MSR_TYPE_RW);
+			vcpu->arch.xfd_no_write_intercept = true;
 			vmx_update_exception_bitmap(vcpu);
+		}
 		break;
 #endif
 	case MSR_IA32_SYSENTER_CS:
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index e0922c80c9d1..7f2c82e7f38f 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -352,7 +352,7 @@ struct vcpu_vmx {
 	struct lbr_desc lbr_desc;
 
 	/* Save desired MSR intercept (read: pass-through) state */
-#define MAX_POSSIBLE_PASSTHROUGH_MSRS	14
+#define MAX_POSSIBLE_PASSTHROUGH_MSRS	15
 	struct {
 		DECLARE_BITMAP(read, MAX_POSSIBLE_PASSTHROUGH_MSRS);
 		DECLARE_BITMAP(write, MAX_POSSIBLE_PASSTHROUGH_MSRS);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 92a1ea13ad51..df0150671b98 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10084,6 +10084,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	vcpu->mode = OUTSIDE_GUEST_MODE;
 	smp_wmb();
 
+	/*
+	 * Sync xfd before calling handle_exit_irqoff() which may
+	 * rely on the fact that guest_fpu::xfd is up-to-date (e.g.
+	 * in #NM irqoff handler).
+	 */
+	if (vcpu->arch.xfd_no_write_intercept)
+		fpu_sync_guest_vmexit_xfd_state();
+
 	static_call(kvm_x86_handle_exit_irqoff)(vcpu);
 
 	if (vcpu->arch.guest_fpu.xfd_err)
