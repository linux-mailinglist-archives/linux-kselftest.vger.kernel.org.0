Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1877E5D9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjKHTAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjKHTAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D892117;
        Wed,  8 Nov 2023 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470022; x=1731006022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rms9ESNha7ZAm2X3qCpWMJ7+MtkmVoWFSbDu1peBbj4=;
  b=XMVVPM4UBG3STRqjCIdixJk7YaQnpSN/T+2BMpZb8/6SnkqSKWsFY6bV
   1kBYn4YI0RYXtQ33M1neOx8CRgiEf7ZMqgBfBQJScCc8TNMJrgoV/b2vw
   1jrwEI47UvaAOXd/JoKjx6hB8rutXleHkah36iIBaXYLdLnmPdOjqUmMc
   FtYeCwL1nImkZADMa4MxHrlfofE2RLmGKQA2Fmw1Qq6eUR0kqi6K2ExZy
   9y6Z44YL34eF1ZVFEFsac5JKXyHZg634MgUge/ugM2d1ssQyKtYmoVSWA
   OkdITXImJ5Bmby4frEegYW3MTurzaRPSnutRtT+wWiRNkMTXDtCd0OG7F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486298"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486298"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892446"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:19 -0800
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
Subject: [PATCH v1 08/23] KVM: VMX: Initialize VMCS FRED fields
Date:   Wed,  8 Nov 2023 10:29:48 -0800
Message-ID: <20231108183003.5981-9-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Initialize host VMCS FRED fields with host FRED MSRs' value and
guest VMCS FRED fields to 0.

FRED CPU states are managed in 9 new FRED MSRs, as well as a few
existing CPU registers and MSRs, e.g., CR4.FRED.  To support FRED
context management, new VMCS fields corresponding to most of FRED
CPU state MSRs are added to both the host-state and guest-state
areas of VMCS.

Specifically no VMCS fields are added for FRED RSP0 and SSP0 MSRs,
because the 2 FRED MSRs are used during ring 3 event delivery only,
thus KVM, running on ring 0, can run safely even with guest FRED
RSP0 and SSP0.  It can be deferred to load host FRED RSP0 and SSP0
until before returning to user level.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/vmx.h | 16 ++++++++++++++++
 arch/x86/kvm/vmx/vmx.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 41796a733bc9..d54a1a1057b0 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -277,12 +277,28 @@ enum vmcs_field {
 	GUEST_BNDCFGS_HIGH              = 0x00002813,
 	GUEST_IA32_RTIT_CTL		= 0x00002814,
 	GUEST_IA32_RTIT_CTL_HIGH	= 0x00002815,
+	GUEST_IA32_FRED_CONFIG		= 0x0000281a,
+	GUEST_IA32_FRED_RSP1		= 0x0000281c,
+	GUEST_IA32_FRED_RSP2		= 0x0000281e,
+	GUEST_IA32_FRED_RSP3		= 0x00002820,
+	GUEST_IA32_FRED_STKLVLS		= 0x00002822,
+	GUEST_IA32_FRED_SSP1		= 0x00002824,
+	GUEST_IA32_FRED_SSP2		= 0x00002826,
+	GUEST_IA32_FRED_SSP3		= 0x00002828,
 	HOST_IA32_PAT			= 0x00002c00,
 	HOST_IA32_PAT_HIGH		= 0x00002c01,
 	HOST_IA32_EFER			= 0x00002c02,
 	HOST_IA32_EFER_HIGH		= 0x00002c03,
 	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,
 	HOST_IA32_PERF_GLOBAL_CTRL_HIGH	= 0x00002c05,
+	HOST_IA32_FRED_CONFIG		= 0x00002c08,
+	HOST_IA32_FRED_RSP1		= 0x00002c0a,
+	HOST_IA32_FRED_RSP2		= 0x00002c0c,
+	HOST_IA32_FRED_RSP3		= 0x00002c0e,
+	HOST_IA32_FRED_STKLVLS		= 0x00002c10,
+	HOST_IA32_FRED_SSP1		= 0x00002c12,
+	HOST_IA32_FRED_SSP2		= 0x00002c14,
+	HOST_IA32_FRED_SSP3		= 0x00002c16,
 	PIN_BASED_VM_EXEC_CONTROL       = 0x00004000,
 	CPU_BASED_VM_EXEC_CONTROL       = 0x00004002,
 	EXCEPTION_BITMAP                = 0x00004004,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 327e052d90c1..41772ecdd368 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1477,6 +1477,18 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 				    (unsigned long)(cpu_entry_stack(cpu) + 1));
 		}
 
+#ifdef CONFIG_X86_64
+		/* Per-CPU FRED MSRs */
+		if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+			vmcs_write64(HOST_IA32_FRED_RSP1, read_msr(MSR_IA32_FRED_RSP1));
+			vmcs_write64(HOST_IA32_FRED_RSP2, read_msr(MSR_IA32_FRED_RSP2));
+			vmcs_write64(HOST_IA32_FRED_RSP3, read_msr(MSR_IA32_FRED_RSP3));
+			vmcs_write64(HOST_IA32_FRED_SSP1, read_msr(MSR_IA32_FRED_SSP1));
+			vmcs_write64(HOST_IA32_FRED_SSP2, read_msr(MSR_IA32_FRED_SSP2));
+			vmcs_write64(HOST_IA32_FRED_SSP3, read_msr(MSR_IA32_FRED_SSP3));
+		}
+#endif
+
 		vmx->loaded_vmcs->cpu = cpu;
 	}
 }
@@ -4375,6 +4387,15 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 
 	if (cpu_has_load_ia32_efer())
 		vmcs_write64(HOST_IA32_EFER, host_efer);
+
+	/*
+	 * FRED MSRs are per-cpu, however FRED CONFIG and STKLVLS MSRs
+	 * are the same on all CPUs, thus they are initialized here.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		vmcs_write64(HOST_IA32_FRED_CONFIG, read_msr(MSR_IA32_FRED_CONFIG));
+		vmcs_write64(HOST_IA32_FRED_STKLVLS, read_msr(MSR_IA32_FRED_STKLVLS));
+	}
 }
 
 void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
@@ -4936,6 +4957,17 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vmcs_writel(GUEST_IDTR_BASE, 0);
 	vmcs_write32(GUEST_IDTR_LIMIT, 0xffff);
 
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
+		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
+		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
+		vmcs_write64(GUEST_IA32_FRED_RSP3, 0);
+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, 0);
+		vmcs_write64(GUEST_IA32_FRED_SSP1, 0);
+		vmcs_write64(GUEST_IA32_FRED_SSP2, 0);
+		vmcs_write64(GUEST_IA32_FRED_SSP3, 0);
+	}
+
 	vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
 	vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, 0);
 	vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS, 0);
-- 
2.42.0

