Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E956128718
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2019 05:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLUEq5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 23:46:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:31837 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfLUEqD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 23:46:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 20:46:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="scan'208";a="222620108"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2019 20:46:01 -0800
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v5 12/19] x86/cpu: Set synthetic VMX cpufeatures during init_ia32_feat_ctl()
Date:   Fri, 20 Dec 2019 20:45:06 -0800
Message-Id: <20191221044513.21680-13-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221044513.21680-1-sean.j.christopherson@intel.com>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Set the synthetic VMX cpufeatures, which need to be kept to preserve
/proc/cpuinfo's ABI, in the common IA32_FEAT_CTL initialization code.
Remove the vendor code that manually sets the synthetic flags.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kernel/cpu/centaur.c  | 35 ------------------------
 arch/x86/kernel/cpu/feat_ctl.c | 14 ++++++++++
 arch/x86/kernel/cpu/intel.c    | 49 ----------------------------------
 arch/x86/kernel/cpu/zhaoxin.c  | 35 ------------------------
 4 files changed, 14 insertions(+), 119 deletions(-)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 084f6040b4df..02d99feb333e 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -18,13 +18,6 @@
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 6)	/* MSR_VIA_RNG */
 
-#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
-#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
-#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
-#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
-#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
-#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
-
 static void init_c3(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
@@ -119,31 +112,6 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 	}
 }
 
-static void centaur_detect_vmx_virtcap(struct cpuinfo_x86 *c)
-{
-	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
-
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
-	msr_ctl = vmx_msr_high | vmx_msr_low;
-
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
-		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
-		set_cpu_cap(c, X86_FEATURE_VNMI);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
-		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		      vmx_msr_low, vmx_msr_high);
-		msr_ctl2 = vmx_msr_high | vmx_msr_low;
-		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
-		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
-			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
-			set_cpu_cap(c, X86_FEATURE_EPT);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
-			set_cpu_cap(c, X86_FEATURE_VPID);
-	}
-}
-
 static void init_centaur(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -251,9 +219,6 @@ static void init_centaur(struct cpuinfo_x86 *c)
 #endif
 
 	init_ia32_feat_ctl(c);
-
-	if (cpu_has(c, X86_FEATURE_VMX))
-		centaur_detect_vmx_virtcap(c);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index cbd8bfe9b87b..fcbb35533cef 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -75,6 +75,20 @@ static void init_vmx_capabilities(struct cpuinfo_x86 *c)
 	    (c->vmx_capability[SECONDARY_CTLS] & VMX_F(VIRT_INTR_DELIVERY)) &&
 	    (c->vmx_capability[MISC_FEATURES] & VMX_F(POSTED_INTR)))
 		c->vmx_capability[MISC_FEATURES] |= VMX_F(APICV);
+
+	/* Set the synthetic cpufeatures to preserve /proc/cpuinfo's ABI. */
+	if (c->vmx_capability[PRIMARY_CTLS] & VMX_F(VIRTUAL_TPR))
+		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
+	if (c->vmx_capability[MISC_FEATURES] & VMX_F(FLEXPRIORITY))
+		set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
+	if (c->vmx_capability[MISC_FEATURES] & VMX_F(VIRTUAL_NMIS))
+		set_cpu_cap(c, X86_FEATURE_VNMI);
+	if (c->vmx_capability[SECONDARY_CTLS] & VMX_F(EPT))
+		set_cpu_cap(c, X86_FEATURE_EPT);
+	if (c->vmx_capability[MISC_FEATURES] & VMX_F(EPT_AD))
+		set_cpu_cap(c, X86_FEATURE_EPT_AD);
+	if (c->vmx_capability[MISC_FEATURES] & VMX_F(VPID))
+		set_cpu_cap(c, X86_FEATURE_VPID);
 }
 #endif /* CONFIG_X86_VMX_FEATURE_NAMES */
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 9129c170ea11..57473e2c0869 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -494,52 +494,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
-{
-	/* Intel VMX MSR indicated features */
-#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
-#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
-#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
-#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
-#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
-#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
-#define x86_VMX_FEATURE_EPT_CAP_AD		0x00200000
-
-	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
-	u32 msr_vpid_cap, msr_ept_cap;
-
-	clear_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	clear_cpu_cap(c, X86_FEATURE_VNMI);
-	clear_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-	clear_cpu_cap(c, X86_FEATURE_EPT);
-	clear_cpu_cap(c, X86_FEATURE_VPID);
-	clear_cpu_cap(c, X86_FEATURE_EPT_AD);
-
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
-	msr_ctl = vmx_msr_high | vmx_msr_low;
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
-		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
-		set_cpu_cap(c, X86_FEATURE_VNMI);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
-		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		      vmx_msr_low, vmx_msr_high);
-		msr_ctl2 = vmx_msr_high | vmx_msr_low;
-		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
-		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
-			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT) {
-			set_cpu_cap(c, X86_FEATURE_EPT);
-			rdmsr(MSR_IA32_VMX_EPT_VPID_CAP,
-			      msr_ept_cap, msr_vpid_cap);
-			if (msr_ept_cap & x86_VMX_FEATURE_EPT_CAP_AD)
-				set_cpu_cap(c, X86_FEATURE_EPT_AD);
-		}
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
-			set_cpu_cap(c, X86_FEATURE_VPID);
-	}
-}
-
 #define MSR_IA32_TME_ACTIVATE		0x982
 
 /* Helpers to access TME_ACTIVATE MSR */
@@ -757,9 +711,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	init_ia32_feat_ctl(c);
 
-	if (cpu_has(c, X86_FEATURE_VMX))
-		detect_vmx_virtcap(c);
-
 	if (cpu_has(c, X86_FEATURE_TME))
 		detect_tme(c);
 
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 630a1450ea70..6b2d3b0a63e6 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -16,13 +16,6 @@
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 8)	/* MSR_ZHAOXIN_RNG */
 
-#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
-#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
-#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
-#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
-#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
-#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
-
 static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
@@ -89,31 +82,6 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)
 
 }
 
-static void zhaoxin_detect_vmx_virtcap(struct cpuinfo_x86 *c)
-{
-	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
-
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
-	msr_ctl = vmx_msr_high | vmx_msr_low;
-
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
-		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
-		set_cpu_cap(c, X86_FEATURE_VNMI);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
-		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		      vmx_msr_low, vmx_msr_high);
-		msr_ctl2 = vmx_msr_high | vmx_msr_low;
-		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
-		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
-			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
-			set_cpu_cap(c, X86_FEATURE_EPT);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
-			set_cpu_cap(c, X86_FEATURE_VPID);
-	}
-}
-
 static void init_zhaoxin(struct cpuinfo_x86 *c)
 {
 	early_init_zhaoxin(c);
@@ -142,9 +110,6 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
 #endif
 
 	init_ia32_feat_ctl(c);
-
-	if (cpu_has(c, X86_FEATURE_VMX))
-		zhaoxin_detect_vmx_virtcap(c);
 }
 
 #ifdef CONFIG_X86_32
-- 
2.24.1

