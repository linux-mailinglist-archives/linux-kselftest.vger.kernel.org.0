Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01649481369
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhL2NPt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:15:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:28047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236179AbhL2NPU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783719; x=1672319719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7O+Es7o+eCrwHN35mK6kNOWodcC1efhp1RiDWaOF2Dw=;
  b=CWOJ8UKq7Q0SJWzLNlMzrhEeDIzIoR7/k/zFXZXFpPF4HQfxcog3W99n
   IiOKKeNs+cZxXafAWUDESnyemj1G45XQf8YsPqDUZGKXXFvzYcroFDohO
   uPr+mOK7iiOD5crkh/rbgHxrOvo+rjSdI4Q6AtGeSdPYc+H7eV3xpATV6
   z3iGIN5qW65+V661/iam4axTN2V/ASmvHeZ24ghReSx7Y653z0b2WB+ID
   dv6EIQhTFev5eecSGGyoKYQTncwe/vBdWRSXeuX9+Yu3ytI2Vpwws8HLA
   GmhWSdD1AENBOIwV2iVGHpMC7kEx86IVUiJ1JirANMhiVGA5bMWjhK2po
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876170"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281231"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:44 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 21/21] kvm: x86: Disable interception for IA32_XFD on demand
Date:   Wed, 29 Dec 2021 05:13:28 -0800
Message-Id: <20211229131328.12283-22-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
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
with the software states in fpstate and the per-cpu xfd cache. Call
fpu_sync_guest_vmexit_xfd_state() to bring them back in-sync, before
preemption is enabled.

Always trap #NM once write interception is disabled for IA32_XFD.
The #NM exception is rare if the guest doesn't use dynamic features.
Otherwise, there is at most one exception per guest task given a
dynamic feature.

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
 arch/x86/kvm/vmx/vmx.c          | 23 ++++++++++++++++++-----
 arch/x86/kvm/vmx/vmx.h          |  2 +-
 arch/x86/kvm/x86.c              |  3 +++
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 555f4de47ef2..a372dfe6f407 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -640,6 +640,7 @@ struct kvm_vcpu_arch {
 	u64 smi_count;
 	bool tpr_access_reporting;
 	bool xsaves_enabled;
+	bool xfd_no_write_intercept;
 	u64 ia32_xss;
 	u64 microcode_version;
 	u64 arch_capabilities;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 638665b3e241..21c4d7409433 100644
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
@@ -766,10 +767,11 @@ void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu)
 	}
 
 	/*
-	 * Trap #NM if guest xfd contains a non-zero value so guest XFD_ERR
-	 * can be saved timely.
+	 * Disabling xfd interception indicates that dynamically-enabled
+	 * features might be used in the guest. Always trap #NM in this case
+	 * for proper virtualization of guest xfd_err.
 	 */
-	if (vcpu->arch.guest_fpu.fpstate->xfd)
+	if (vcpu->arch.xfd_no_write_intercept)
 		eb |= (1u << NM_VECTOR);
 
 	vmcs_write32(EXCEPTION_BITMAP, eb);
@@ -1971,9 +1973,20 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_XFD:
 		ret = kvm_set_msr_common(vcpu, msr_info);
-		/* Update #NM interception according to guest xfd */
-		if (!ret)
+		/*
+		 * Always intercepting WRMSR could incur non-negligible
+		 * overhead given xfd might be touched in guest context
+		 * switch. Disable write interception upon the first write
+		 * with a non-zero value (indicate potential guest usage
+		 * on dynamic xfeatures). Also update exception bitmap
+		 * to trap #NM for proper virtualization of guest xfd_err.
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
index bf9d3051cd6c..0a00242a91e7 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -340,7 +340,7 @@ struct vcpu_vmx {
 	struct lbr_desc lbr_desc;
 
 	/* Save desired MSR intercept (read: pass-through) state */
-#define MAX_POSSIBLE_PASSTHROUGH_MSRS	14
+#define MAX_POSSIBLE_PASSTHROUGH_MSRS	15
 	struct {
 		DECLARE_BITMAP(read, MAX_POSSIBLE_PASSTHROUGH_MSRS);
 		DECLARE_BITMAP(write, MAX_POSSIBLE_PASSTHROUGH_MSRS);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 76e1941db223..4990d6de5359 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10027,6 +10027,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_fpu.xfd_err)
 		wrmsrl(MSR_IA32_XFD_ERR, 0);
 
+	if (vcpu->arch.xfd_no_write_intercept)
+		fpu_sync_guest_vmexit_xfd_state();
+
 	/*
 	 * Consume any pending interrupts, including the possible source of
 	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
