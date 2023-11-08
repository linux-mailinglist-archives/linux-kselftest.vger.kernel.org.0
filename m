Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1077E5DB6
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjKHTAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjKHTAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D2211E;
        Wed,  8 Nov 2023 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470026; x=1731006026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQGmW+oXxSwWf91UKmGPw4FUojRiOmEbKecD33BDx8s=;
  b=FMrSpenntVH30An5xopafTniXl/3jP3iRcSaMKO0Mzr1BujQRTiNmLbR
   Dmhlg0wPEZ2X+0DbuizNig7bpFbccpSUBh2RIYSvqsUABwvGgkwYo/l04
   T8TtsAobwNFWcCGlfMdL+0C0f+DUS++1lR5OXxhTRxGQtQ1lgjDv4n0q7
   2nHmqg+tFhNOLIWBX/AsAui4iQDOPzfg8qqpHYH3O2usJJov01ldudbPz
   wIobGzceEHGM9l2Vy8M7xI0VheMCJ1kXEy46FGU9nZQb7nyKiyb6AyN30
   +SnkK8Wnexmlan30lGO4YCTzwZss3bnlz9VStLgpvEKZx3/+Y8QabIMHQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486408"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486408"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892494"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:24 -0800
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
Subject: [PATCH v1 17/23] KVM: nVMX: Add support for VMX FRED controls
Date:   Wed,  8 Nov 2023 10:29:57 -0800
Message-ID: <20231108183003.5981-18-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add VMX FRED controls to nested VMX controls and set the VMX
nested-exception support bit (bit 58) in the nested IA32_VMX_BASIC MSR
when FRED is enabled.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kvm/vmx/hyperv.c |  7 +++++--
 arch/x86/kvm/vmx/nested.c | 14 ++++++++++----
 arch/x86/kvm/vmx/vmx.c    |  3 +++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index b12ef8fd76c9..28fca62f3887 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -106,7 +106,9 @@
 	 VM_EXIT_CLEAR_IA32_RTIT_CTL |					\
 	 VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
 
-#define EVMCS1_SUPPORTED_VMEXIT_CTRL2 (0ULL)
+#define EVMCS1_SUPPORTED_VMEXIT_CTRL2					\
+	(SECONDARY_VM_EXIT_SAVE_IA32_FRED |				\
+	 SECONDARY_VM_EXIT_LOAD_IA32_FRED)
 
 #define EVMCS1_SUPPORTED_VMENTRY_CTRL					\
 	(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR |				\
@@ -117,7 +119,8 @@
 	 VM_ENTRY_LOAD_IA32_EFER |					\
 	 VM_ENTRY_LOAD_BNDCFGS |					\
 	 VM_ENTRY_PT_CONCEAL_PIP |					\
-	 VM_ENTRY_LOAD_IA32_RTIT_CTL)
+	 VM_ENTRY_LOAD_IA32_RTIT_CTL |					\
+	 VM_ENTRY_LOAD_IA32_FRED)
 
 #define EVMCS1_SUPPORTED_VMFUNC (0)
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index af616c4a3491..b85cd5c0ec98 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1230,10 +1230,12 @@ static bool is_bitwise_subset(u64 superset, u64 subset, u64 mask)
 #define VMX_BASIC_FEATURES_MASK			\
 	(VMX_BASIC_DUAL_MONITOR_TREATMENT |	\
 	 VMX_BASIC_INOUT |			\
-	 VMX_BASIC_TRUE_CTLS)
+	 VMX_BASIC_TRUE_CTLS |			\
+	 VMX_BASIC_NESTED_EXCEPTION)
 
-#define VMX_BASIC_RESERVED_BITS			\
-	(GENMASK_ULL(63, 56) | GENMASK_ULL(47, 45) | BIT_ULL(31))
+#define VMX_BASIC_RESERVED_BITS				\
+	(GENMASK_ULL(63, 59) | GENMASK_ULL(57, 56) |	\
+	 GENMASK_ULL(47, 45) | BIT_ULL(31))
 
 static int vmx_restore_vmx_basic(struct vcpu_vmx *vmx, u64 data)
 {
@@ -6985,7 +6987,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
 #ifdef CONFIG_X86_64
 		VM_ENTRY_IA32E_MODE |
 #endif
-		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
+		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
+		VM_ENTRY_LOAD_IA32_FRED;
 	msrs->entry_ctls_high |=
 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
 		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
@@ -7141,6 +7144,9 @@ static void nested_vmx_setup_basic(struct nested_vmx_msrs *msrs)
 
 	if (cpu_has_vmx_basic_inout())
 		msrs->basic |= VMX_BASIC_INOUT;
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		msrs->basic |= VMX_BASIC_NESTED_EXCEPTION;
 }
 
 static void nested_vmx_setup_cr_fixed(struct nested_vmx_msrs *msrs)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b826dc188fc7..3353fd6615a2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7970,6 +7970,9 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 	cr4_fixed1_update(X86_CR4_UMIP,       ecx, feature_bit(UMIP));
 	cr4_fixed1_update(X86_CR4_LA57,       ecx, feature_bit(LA57));
 
+	entry = kvm_find_cpuid_entry_index(vcpu, 0x7, 1);
+	cr4_fixed1_update(X86_CR4_FRED,       eax, feature_bit(FRED));
+
 #undef cr4_fixed1_update
 }
 
-- 
2.42.0

