Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D54D10C190
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2019 02:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfK1BkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 20:40:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:10957 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbfK1BkY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 20:40:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 17:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="221166498"
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
Subject: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using VMX_FEATURES_*
Date:   Wed, 27 Nov 2019 17:40:08 -0800
Message-Id: <20191128014016.4389-12-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128014016.4389-1-sean.j.christopherson@intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for generating VMX feature names in capflags.c and use the
resulting x86_vmx_flags to print the VMX flags in /proc/cpuinfo.  Don't
print VMX flags if no bits are set in word 0, which holds Pin Controls.
Pin Control's INTR and NMI exiting are fundamental pillars of VMX, if
they are not supported then the CPU is broken, it does not actually
support VMX, or the kernel wasn't built with support for the target CPU.

Print the features in a dedicated "vmx flags" line to avoid polluting
the common "flags" and to avoid having to prefix all flags with "vmx_",
which results in horrendously long names.

Keep synthetic VMX flags in cpufeatures to preserve /proc/cpuinfo's ABI
for those flags.  This means that "flags" and "vmx flags" will have
duplicate entries for tpr_shadow (virtual_tpr), vnmi (virtual_nmis),
ept, flexpriority, vpid and ept_ad, but caps the pollution of "flags" at
those six VMX features.  The vendor specific code that populates the
synthetic flags will be consolidated in a future patch to futher
minimize the lasting damage.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/boot/mkcpustr.c          |  1 +
 arch/x86/kernel/cpu/Makefile      |  5 +++--
 arch/x86/kernel/cpu/mkcapflags.sh | 15 +++++++++++----
 arch/x86/kernel/cpu/proc.c        | 15 +++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
index 9caa10e82217..da0ccc5de538 100644
--- a/arch/x86/boot/mkcpustr.c
+++ b/arch/x86/boot/mkcpustr.c
@@ -15,6 +15,7 @@
 #include "../include/asm/required-features.h"
 #include "../include/asm/disabled-features.h"
 #include "../include/asm/cpufeatures.h"
+#include "../include/asm/vmxfeatures.h"
 #include "../kernel/cpu/capflags.c"
 
 int main(void)
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 4173b0de7a2f..dba6a83bc349 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -57,11 +57,12 @@ obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
-      cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $< $@
+      cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ $^
 
 cpufeature = $(src)/../../include/asm/cpufeatures.h
+vmxfeature = $(src)/../../include/asm/vmxfeatures.h
 
-$(obj)/capflags.c: $(cpufeature) $(src)/mkcapflags.sh FORCE
+$(obj)/capflags.c: $(cpufeature) $(vmxfeature) $(src)/mkcapflags.sh FORCE
 	$(call if_changed,mkcapflags)
 endif
 targets += capflags.c
diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapflags.sh
index aed45b8895d5..1db560ed2ca3 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -6,8 +6,7 @@
 
 set -e
 
-IN=$1
-OUT=$2
+OUT=$1
 
 dump_array()
 {
@@ -15,6 +14,7 @@ dump_array()
 	SIZE=$2
 	PFX=$3
 	POSTFIX=$4
+	IN=$5
 
 	PFX_SZ=$(echo $PFX | wc -c)
 	TABS="$(printf '\t\t\t\t\t')"
@@ -57,11 +57,18 @@ trap 'rm "$OUT"' EXIT
 	echo "#endif"
 	echo ""
 
-	dump_array "x86_cap_flags" "NCAPINTS*32" "X86_FEATURE_" ""
+	dump_array "x86_cap_flags" "NCAPINTS*32" "X86_FEATURE_" "" $2
 	echo ""
 
-	dump_array "x86_bug_flags" "NBUGINTS*32" "X86_BUG_" "NCAPINTS*32"
+	dump_array "x86_bug_flags" "NBUGINTS*32" "X86_BUG_" "NCAPINTS*32" $2
+	echo ""
 
+	echo "#ifdef CONFIG_X86_VMX_FEATURE_NAMES"
+	echo "#ifndef _ASM_X86_VMXFEATURES_H"
+	echo "#include <asm/vmxfeatures.h>"
+	echo "#endif"
+	dump_array "x86_vmx_flags" "NVMXINTS*32" "VMX_FEATURE_" "" $3
+	echo "#endif /* CONFIG_X86_VMX_FEATURE_NAMES */"
 ) > $OUT
 
 trap - EXIT
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index cb2e49810d68..4eec8889b0ff 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -7,6 +7,10 @@
 
 #include "cpu.h"
 
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+extern const char * const x86_vmx_flags[NVMXINTS*32];
+#endif
+
 /*
  *	Get CPU information for use by the procfs.
  */
@@ -102,6 +106,17 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		if (cpu_has(c, i) && x86_cap_flags[i] != NULL)
 			seq_printf(m, " %s", x86_cap_flags[i]);
 
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+	if (cpu_has(c, X86_FEATURE_VMX) && c->vmx_capability[0]) {
+		seq_puts(m, "\nvmx flags\t:");
+		for (i = 0; i < 32*NVMXINTS; i++) {
+			if (test_bit(i, (unsigned long *)c->vmx_capability) &&
+			    x86_vmx_flags[i] != NULL)
+				seq_printf(m, " %s", x86_vmx_flags[i]);
+		}
+	}
+#endif
+
 	seq_puts(m, "\nbugs\t\t:");
 	for (i = 0; i < 32*NBUGINTS; i++) {
 		unsigned int bug_bit = 32*NCAPINTS + i;
-- 
2.24.0

