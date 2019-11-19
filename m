Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9BC1011D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 04:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfKSDNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 22:13:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:21246 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727619AbfKSDM5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 22:12:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 19:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="218105707"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2019 19:12:41 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v3 03/19] tools arch x86: Sync msr-index.h from kernel sources
Date:   Mon, 18 Nov 2019 19:12:24 -0800
Message-Id: <20191119031240.7779-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119031240.7779-1-sean.j.christopherson@intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sync msr-index.h to pull in recent renames of the IA32_FEATURE_CONTROL
MSR bit definitions.  Update KVM's VMX selftest accordingly.  While
using the renamed defines is by no means necessary, do the sync now to
avoid leaving a landmine that will get stepped on the next time
msr-index.h needs to be refreshed for some other reason.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 tools/arch/x86/include/asm/msr-index.h       | 27 ++++++++++++++++----
 tools/testing/selftests/kvm/lib/x86_64/vmx.c |  4 +--
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 20ce682a2540..4c80d530f751 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -93,6 +93,18 @@
 						  * Microarchitectural Data
 						  * Sampling (MDS) vulnerabilities.
 						  */
+#define ARCH_CAP_PSCHANGE_MC_NO		BIT(6)	 /*
+						  * The processor is not susceptible to a
+						  * machine check error due to modifying the
+						  * code page size along with either the
+						  * physical address or cache type
+						  * without TLB invalidation.
+						  */
+#define ARCH_CAP_TSX_CTRL_MSR		BIT(7)	/* MSR for TSX control is available. */
+#define ARCH_CAP_TAA_NO			BIT(8)	/*
+						 * Not susceptible to
+						 * TSX Async Abort (TAA) vulnerabilities.
+						 */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
@@ -103,6 +115,10 @@
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
 
+#define MSR_IA32_TSX_CTRL		0x00000122
+#define TSX_CTRL_RTM_DISABLE		BIT(0)	/* Disable RTM feature */
+#define TSX_CTRL_CPUID_CLEAR		BIT(1)	/* Disable TSX enumeration */
+
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175
 #define MSR_IA32_SYSENTER_EIP		0x00000176
@@ -540,7 +556,13 @@
 #define MSR_IA32_EBL_CR_POWERON		0x0000002a
 #define MSR_EBC_FREQUENCY_ID		0x0000002c
 #define MSR_SMI_COUNT			0x00000034
+
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
+#define FEAT_CTL_LOCKED				BIT(0)
+#define FEAT_CTL_VMX_ENABLED_INSIDE_SMX		BIT(1)
+#define FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX	BIT(2)
+#define FEAT_CTL_LMCE_ENABLED			BIT(20)
+
 #define MSR_IA32_TSC_ADJUST             0x0000003b
 #define MSR_IA32_BNDCFGS		0x00000d90
 
@@ -548,11 +570,6 @@
 
 #define MSR_IA32_XSS			0x00000da0
 
-#define FEATURE_CONTROL_LOCKED				(1<<0)
-#define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
-#define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
-#define FEATURE_CONTROL_LMCE				(1<<20)
-
 #define MSR_IA32_APICBASE		0x0000001b
 #define MSR_IA32_APICBASE_BSP		(1<<8)
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index f6ec97b7eaef..32dfa4f5bbd3 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -157,8 +157,8 @@ bool prepare_for_vmx_operation(struct vmx_pages *vmx)
 	 *  Bit 2: Enables VMXON outside of SMX operation. If clear, VMXON
 	 *    outside of SMX causes a #GP.
 	 */
-	required = FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
-	required |= FEATURE_CONTROL_LOCKED;
+	required = FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
+	required |= FEAT_CTL_LOCKED;
 	feature_control = rdmsr(MSR_IA32_FEATURE_CONTROL);
 	if ((feature_control & required) != required)
 		wrmsr(MSR_IA32_FEATURE_CONTROL, feature_control | required);
-- 
2.24.0

