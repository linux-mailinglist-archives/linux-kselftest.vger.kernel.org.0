Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F510C1BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2019 02:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfK1BkW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 20:40:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:10954 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfK1BkW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 20:40:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 17:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="221166477"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 27 Nov 2019 17:40:19 -0800
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
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v4 04/19] x86/intel: Initialize IA32_FEAT_CTL MSR at boot
Date:   Wed, 27 Nov 2019 17:40:01 -0800
Message-Id: <20191128014016.4389-5-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128014016.4389-1-sean.j.christopherson@intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Opportunistically initialize IA32_FEAT_CTL to enable VMX when the MSR is
left unlocked by BIOS.  Configuring feature control at boot time paves
the way for similar enabling of other features, e.g. Software Guard
Extensions (SGX).

Temporarily leave equivalent KVM code in place in order to avoid
introducing a regression on Centaur and Zhaoxin CPUs, e.g. removing
KVM's code would leave the MSR unlocked on those CPUs and would break
existing functionality if people are loading kvm_intel on Centaur and/or
Zhaoxin.  Defer enablement of the boot-time configuration on Centaur and
Zhaoxin to future patches to aid bisection.

Note, Local Machine Check Exceptions (LMCE) are also supported by the
kernel and enabled via feature control, but the kernel currently uses
LMCE if and and only if the feature is explicitly enabled by BIOS.  Keep
the current behavior to avoid introducing bugs, future patches can opt
in to opportunistic enabling if it's deemed desirable to do so.

Always lock IA32_FEAT_CTL if it exists, even if the CPU doesn't support
VMX, so that other existing and future kernel code that queries the MSR
can assume it's locked.

Start from a clean slate when constructing the value to write to
IA32_FEAT_CTL, i.e. ignore whatever value BIOS left in the MSR so as not
to enable random features or fault on the WRMSR.

Suggested-by: Borislav Petkov <bp@suse.de>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/Kconfig.cpu           |  4 ++++
 arch/x86/kernel/cpu/Makefile   |  1 +
 arch/x86/kernel/cpu/cpu.h      |  4 ++++
 arch/x86/kernel/cpu/feat_ctl.c | 37 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c    |  2 ++
 5 files changed, 48 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/feat_ctl.c

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index af9c967782f6..98be76fa2978 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -387,6 +387,10 @@ config X86_DEBUGCTLMSR
 	def_bool y
 	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX || M586TSC || M586 || M486SX || M486) && !UML
 
+config IA32_FEAT_CTL
+	def_bool y
+	depends on CPU_SUP_INTEL
+
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
 	---help---
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index a704fb9ee98e..4173b0de7a2f 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -32,6 +32,7 @@ obj-y			+= umwait.o
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
 
+obj-$(CONFIG_IA32_FEAT_CTL) += feat_ctl.o
 ifdef CONFIG_CPU_SUP_INTEL
 obj-y			+= intel.o intel_pconfig.o tsx.o
 obj-$(CONFIG_PM)	+= intel_epb.o
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 38ab6e115eac..37fdefd14f28 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -80,4 +80,8 @@ extern void x86_spec_ctrl_setup_ap(void);
 
 extern u64 x86_read_arch_cap_msr(void);
 
+#ifdef CONFIG_IA32_FEAT_CTL
+void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
+#endif
+
 #endif /* ARCH_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
new file mode 100644
index 000000000000..c4f8f767853b
--- /dev/null
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/tboot.h>
+
+#include <asm/cpufeature.h>
+#include <asm/msr-index.h>
+#include <asm/processor.h>
+
+void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
+{
+	u64 msr;
+
+	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr))
+		return;
+
+	if (msr & FEAT_CTL_LOCKED)
+		return;
+
+	/*
+	 * Ignore whatever value BIOS left in the MSR to avoid enabling random
+	 * features or faulting on the WRMSR.
+	 */
+	msr = FEAT_CTL_LOCKED;
+
+	/*
+	 * Enable VMX if and only if the kernel may do VMXON at some point,
+	 * i.e. KVM is enabled, to avoid unnecessarily adding an attack vector
+	 * for the kernel, e.g. using VMX to hide malicious code.
+	 */
+	if (cpu_has(c, X86_FEATURE_VMX) && IS_ENABLED(CONFIG_KVM_INTEL)) {
+		msr |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
+
+		if (tboot_enabled())
+			msr |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
+	}
+
+	wrmsrl(MSR_IA32_FEAT_CTL, msr);
+}
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4a900804a023..9129c170ea11 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -755,6 +755,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 	/* Work around errata */
 	srat_detect_node(c);
 
+	init_ia32_feat_ctl(c);
+
 	if (cpu_has(c, X86_FEATURE_VMX))
 		detect_vmx_virtcap(c);
 
-- 
2.24.0

