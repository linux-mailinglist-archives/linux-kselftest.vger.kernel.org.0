Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF011286E9
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2019 05:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLUEqC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 23:46:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:31836 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfLUEqB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 23:46:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 20:45:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="scan'208";a="222620096"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2019 20:46:00 -0800
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
Subject: [PATCH v5 10/19] x86/cpu: Detect VMX features on Intel, Centaur and Zhaoxin CPUs
Date:   Fri, 20 Dec 2019 20:45:04 -0800
Message-Id: <20191221044513.21680-11-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221044513.21680-1-sean.j.christopherson@intel.com>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add an entry in struct cpuinfo_x86 to track VMX capabilities and fill
the capabilities during IA32_FEAT_CTL MSR initialization.

Make the VMX capabilities dependent on IA32_FEAT_CTL and
X86_FEATURE_NAMES so as to avoid unnecessary overhead on CPUs that can't
possibly support VMX, or when /proc/cpuinfo is not available.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/Kconfig.cpu               |  4 ++
 arch/x86/include/asm/processor.h   |  3 ++
 arch/x86/include/asm/vmxfeatures.h |  5 ++
 arch/x86/kernel/cpu/common.c       |  3 ++
 arch/x86/kernel/cpu/feat_ctl.c     | 74 ++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 526425fcaedc..bc3a497c029c 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -391,6 +391,10 @@ config IA32_FEAT_CTL
 	def_bool y
 	depends on CPU_SUP_INTEL || CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN
 
+config X86_VMX_FEATURE_NAMES
+	def_bool y
+	depends on IA32_FEAT_CTL && X86_FEATURE_NAMES
+
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
 	---help---
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b49b88bae92f..6fb4870ed759 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -85,6 +85,9 @@ struct cpuinfo_x86 {
 #ifdef CONFIG_X86_64
 	/* Number of 4K pages in DTLB/ITLB combined(in pages): */
 	int			x86_tlbsize;
+#endif
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+	__u32			vmx_capability[NVMXINTS];
 #endif
 	__u8			x86_virt_bits;
 	__u8			x86_phys_bits;
diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vmxfeatures.h
index 4c743ba40ff1..0d04d8bf15a5 100644
--- a/arch/x86/include/asm/vmxfeatures.h
+++ b/arch/x86/include/asm/vmxfeatures.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_X86_VMXFEATURES_H
 #define _ASM_X86_VMXFEATURES_H
 
+/*
+ * Defines VMX CPU feature bits
+ */
+#define NVMXINTS			3 /* N 32-bit words worth of info */
+
 /*
  * Note: If the comment begins with a quoted string, that string is used
  * in /proc/cpuinfo instead of the macro name.  If the string is "",
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9d6a35a4586e..df1eacd26443 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1449,6 +1449,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 #endif
 	c->x86_cache_alignment = c->x86_clflush_size;
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
+#endif
 
 	generic_identify(c);
 
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index a46c9e46f937..cbd8bfe9b87b 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -4,10 +4,80 @@
 #include <asm/cpufeature.h>
 #include <asm/msr-index.h>
 #include <asm/processor.h>
+#include <asm/vmx.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"x86/cpu: " fmt
 
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+enum vmx_feature_leafs {
+	MISC_FEATURES = 0,
+	PRIMARY_CTLS,
+	SECONDARY_CTLS,
+	NR_VMX_FEATURE_WORDS,
+};
+
+#define VMX_F(x) BIT(VMX_FEATURE_##x & 0x1f)
+
+static void init_vmx_capabilities(struct cpuinfo_x86 *c)
+{
+	u32 supported, funcs, ept, vpid, ign;
+
+	BUILD_BUG_ON(NVMXINTS != NR_VMX_FEATURE_WORDS);
+
+	/*
+	 * The high bits contain the allowed-1 settings, i.e. features that can
+	 * be turned on.  The low bits contain the allowed-0 settings, i.e.
+	 * features that can be turned off.  Ignore the allowed-0 settings,
+	 * if a feature can be turned on then it's supported.
+	 *
+	 * Use raw rdmsr() for primary processor controls and pin controls MSRs
+	 * as they exist on any CPU that supports VMX, i.e. we want the WARN if
+	 * the RDMSR faults.
+	 */
+	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, ign, supported);
+	c->vmx_capability[PRIMARY_CTLS] = supported;
+
+	rdmsr_safe(MSR_IA32_VMX_PROCBASED_CTLS2, &ign, &supported);
+	c->vmx_capability[SECONDARY_CTLS] = supported;
+
+	rdmsr(MSR_IA32_VMX_PINBASED_CTLS, ign, supported);
+	rdmsr_safe(MSR_IA32_VMX_VMFUNC, &ign, &funcs);
+
+	/*
+	 * Except for EPT+VPID, which enumerates support for both in a single
+	 * MSR, low for EPT, high for VPID.
+	 */
+	rdmsr_safe(MSR_IA32_VMX_EPT_VPID_CAP, &ept, &vpid);
+
+	/* Pin, EPT, VPID and VM-Func are merged into a single word. */
+	WARN_ON_ONCE(supported >> 16);
+	WARN_ON_ONCE(funcs >> 4);
+	c->vmx_capability[MISC_FEATURES] = (supported & 0xffff) |
+					   ((vpid & 0x1) << 16) |
+					   ((funcs & 0xf) << 28);
+
+	/* EPT bits are full on scattered and must be manually handled. */
+	if (ept & VMX_EPT_EXECUTE_ONLY_BIT)
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(EPT_EXECUTE_ONLY);
+	if (ept & VMX_EPT_AD_BIT)
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(EPT_AD);
+	if (ept & VMX_EPT_1GB_PAGE_BIT)
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(EPT_1GB);
+
+	/* Synthetic APIC features that are aggregates of multiple features. */
+	if ((c->vmx_capability[PRIMARY_CTLS] & VMX_F(VIRTUAL_TPR)) &&
+	    (c->vmx_capability[SECONDARY_CTLS] & VMX_F(VIRT_APIC_ACCESSES)))
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(FLEXPRIORITY);
+
+	if ((c->vmx_capability[PRIMARY_CTLS] & VMX_F(VIRTUAL_TPR)) &&
+	    (c->vmx_capability[SECONDARY_CTLS] & VMX_F(APIC_REGISTER_VIRT)) &&
+	    (c->vmx_capability[SECONDARY_CTLS] & VMX_F(VIRT_INTR_DELIVERY)) &&
+	    (c->vmx_capability[MISC_FEATURES] & VMX_F(POSTED_INTR)))
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(APICV);
+}
+#endif /* CONFIG_X86_VMX_FEATURE_NAMES */
+
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 {
 	bool tboot = tboot_enabled();
@@ -50,5 +120,9 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 		pr_err_once("VMX (%s TXT) disabled by BIOS\n",
 			    tboot ? "inside" : "outside");
 		clear_cpu_cap(c, X86_FEATURE_VMX);
+	} else {
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+		init_vmx_capabilities(c);
+#endif
 	}
 }
-- 
2.24.1

