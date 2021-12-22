Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286EF47D23B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbhLVMmf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:42:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:11441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240591AbhLVMl6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176918; x=1671712918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mcJXn64JGu5vCi+1e3/iFncLwSWAIL5VMmqM8cXOyVs=;
  b=gZm/tOOtEFwVKRfFvIiFbWESnxJJUXX/nSxdpLh7S12O7U7bag6onCf5
   Hh8trXZJ8L94s8/AkxsKn6EMWEdAs7O6NgjiZH5o94miSkxjRubasgjEO
   3WI2xJg/IeCU6jOiBQZ1ZOLLY6K5wHb0aT37DkDElDlT/o14aTvTfOD3t
   WeRGK7Dt8QzXTwnF8ufpfc5b/dP27A3gXngrsd4bLw+MSjLrjEL+NNqQd
   gi8d+WT+jHIreKNpKsnuv3p8ioZCytV8/NGVkmeHFdKaHw50Sv5lTK7KD
   QtjTjmiMRUiQIeRqJEgA1SOmEAu3l54rJWjj7V5SxYd6N8iDi8hpF2amo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833441"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833441"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002792"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:41:09 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on demand
Date:   Wed, 22 Dec 2021 04:40:52 -0800
Message-Id: <20211222124052.644626-23-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Always intercepting IA32_XFD causes non-negligible overhead when this
register is updated frequently in the guest.

Disable r/w emulation after intercepting the first WRMSR(IA32_XFD)
with a non-zero value.

Disable WRMSR emulation implies that IA32_XFD becomes out-of-sync
with the software states in fpstate and the per-cpu xfd cache. Call
fpu_sync_guest_vmexit_xfd_state() to bring them back in-sync, before
preemption is enabled.

p.s. We have confirmed that SDM is being revised to say that
when setting IA32_XFD[18] the AMX register state is not guaranteed
to be preserved. This clarification avoids adding mess for a creative
guest which sets IA32_XFD[18]=1 before saving active AMX state to
its own storage.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/vmx.c          | 4 ++++
 arch/x86/kvm/vmx/vmx.h          | 2 +-
 arch/x86/kvm/x86.c              | 3 +++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f7a661f35d1a..7b81d324b32a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -641,6 +641,7 @@ struct kvm_vcpu_arch {
 	bool tpr_access_reporting;
 	bool xsaves_enabled;
 	bool trap_nm;
+	bool xfd_out_of_sync;
 	u64 ia32_xss;
 	u64 microcode_version;
 	u64 arch_capabilities;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8595a3e8fbd8..7aaf905e13b4 100644
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
@@ -1968,6 +1969,9 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_XFD:
 		ret = kvm_set_msr_common(vcpu, msr_info);
 		if (!ret && data) {
+			vmx_disable_intercept_for_msr(vcpu, MSR_IA32_XFD, MSR_TYPE_RW);
+			vcpu->arch.xfd_out_of_sync = true;
+
 			vcpu->arch.trap_nm = true;
 			vmx_update_exception_bitmap(vcpu);
 		}
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
index 3b756ff13103..10a08aa2aa45 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10024,6 +10024,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_fpu.xfd_err)
 		wrmsrl(MSR_IA32_XFD_ERR, 0);
 
+	if (vcpu->arch.xfd_out_of_sync)
+		fpu_sync_guest_vmexit_xfd_state();
+
 	/*
 	 * Consume any pending interrupts, including the possible source of
 	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
-- 
2.27.0

