Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8C7E5D9D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjKHTAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjKHTAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EF62114;
        Wed,  8 Nov 2023 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470020; x=1731006020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LsNdQwHiUrqX8YGCdaIq6LWa12llh8k5EG8vDmKHiu8=;
  b=daAhlHBxchoiTN8bjik8yPpdqIhe8fREln3IrJxPdS3X1zhctcYywsN0
   k130ZolIxhm/fAXfSlILBSl5bjHGX1z0K9famlaDxwqnIiZ7TOFLVjM09
   1hJK56xAJztRN6gcLPYJl5+IAF2/hBSXMaGKBb7EpWmxwvILAVfjdIVKX
   UWDgwaTBHPV87KPFiRhq88eubxjD/sn1DJEir8nIQMaQs9Rok/wOtCE0b
   i+0UsKSfgQjsZWx2X3DFIvtf+TZ2j2PjClNho4loRDaDP3UnHD7sJitte
   Rea3pJPISpGODW+ObIGRgam18dogG8eeXiaruqoHXTF+iMWwzylLnM12U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486254"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486254"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892428"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:18 -0800
From:   Xin Li <xin3.li@intel.com>
To:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, vkuznets@redhat.com, peterz@infradead.org,
        ravi.v.shankar@intel.com
Subject: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit controls in vmcs_config
Date:   Wed,  8 Nov 2023 10:29:45 -0800
Message-ID: <20231108183003.5981-6-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Setup the global vmcs_config for FRED:
1) Add VM_ENTRY_LOAD_IA32_FRED to KVM_OPTIONAL_VMX_VM_ENTRY_CONTROLS to
   have a FRED CPU load guest FRED MSRs from VMCS upon VM entry.
2) Add SECONDARY_VM_EXIT_SAVE_IA32_FRED to
   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU save
   guest FRED MSRs to VMCS during VM exit.
3) add SECONDARY_VM_EXIT_LOAD_IA32_FRED to
   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU load
   host FRED MSRs from VMCS during VM exit.

Also add sanity checks to make sure FRED VM entry/exit controls can be
set on a FRED CPU.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/vmx.h |  3 +++
 arch/x86/kvm/vmx/vmx.c     | 19 ++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.h     |  7 +++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 4d4177ec802c..41796a733bc9 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -106,6 +106,8 @@
 #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
 #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
 #define VM_EXIT_ACTIVATE_SECONDARY_CONTROLS	0x80000000
+#define SECONDARY_VM_EXIT_SAVE_IA32_FRED	0x00000001
+#define SECONDARY_VM_EXIT_LOAD_IA32_FRED	0x00000002
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
@@ -119,6 +121,7 @@
 #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
 #define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
 #define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
+#define VM_ENTRY_LOAD_IA32_FRED			0x00800000
 
 #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index df769207cbe0..9186f41974ab 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2694,10 +2694,27 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		_vmexit_control &= ~x_ctrl;
 	}
 
-	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
 		_secondary_vmexit_control =
 			adjust_vmx_controls64(KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS,
 					      MSR_IA32_VMX_EXIT_CTLS2);
+		if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+		    !(_secondary_vmexit_control & SECONDARY_VM_EXIT_SAVE_IA32_FRED &&
+		      _secondary_vmexit_control & SECONDARY_VM_EXIT_LOAD_IA32_FRED)) {
+			pr_warn_once("FRED enabled but no VMX VM-Exit {SAVE,LOAD}_IA32_FRED controls: %llx\n",
+				     _secondary_vmexit_control);
+			if (error_on_inconsistent_vmcs_config)
+				return -EIO;
+		}
+	}
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    !(_vmentry_control & VM_ENTRY_LOAD_IA32_FRED)) {
+		pr_warn_once("FRED enabled but no VMX VM-Entry LOAD_IA32_FRED control: %x\n",
+			     _vmentry_control);
+		if (error_on_inconsistent_vmcs_config)
+			return -EIO;
+	}
 
 	rdmsrl(MSR_IA32_VMX_BASIC, basic_msr);
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 99a0f6783085..f8c02bd37069 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -480,7 +480,8 @@ static inline u8 vmx_get_rvi(void)
 	 VM_ENTRY_LOAD_IA32_EFER |					\
 	 VM_ENTRY_LOAD_BNDCFGS |					\
 	 VM_ENTRY_PT_CONCEAL_PIP |					\
-	 VM_ENTRY_LOAD_IA32_RTIT_CTL)
+	 VM_ENTRY_LOAD_IA32_RTIT_CTL |					\
+	 VM_ENTRY_LOAD_IA32_FRED)
 
 #define __KVM_REQUIRED_VMX_VM_EXIT_CONTROLS				\
 	(VM_EXIT_SAVE_DEBUG_CONTROLS |					\
@@ -506,7 +507,9 @@ static inline u8 vmx_get_rvi(void)
 	       VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
 
 #define KVM_REQUIRED_VMX_SECONDARY_VM_EXIT_CONTROLS (0)
-#define KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS (0)
+#define KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS			\
+	     (SECONDARY_VM_EXIT_SAVE_IA32_FRED |			\
+	      SECONDARY_VM_EXIT_LOAD_IA32_FRED)
 
 #define KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL			\
 	(PIN_BASED_EXT_INTR_MASK |					\
-- 
2.42.0

