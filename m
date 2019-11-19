Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57081011FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 04:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfKSDO0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 22:14:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:21246 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfKSDMz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 22:12:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 19:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="218105736"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2019 19:12:42 -0800
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
Subject: [PATCH v3 12/19] x86/vmx: Introduce VMX_FEATURES_*
Date:   Mon, 18 Nov 2019 19:12:33 -0800
Message-Id: <20191119031240.7779-13-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119031240.7779-1-sean.j.christopherson@intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a VMX specific variant of X86_FEATURE_* flags, which will eventually
supplant the synthetic VMX flags defined in cpufeatures word 8.  Use the
Intel-defined layouts for the major VMX execution controls so that their
word entries can be directly populated from their respective MSRs, and
so that the VMX_FEATURE_* flags can be used to define the existing bit
definitions in asm/vmx.h, i.e. force developers to define a VMX_FEATURE
flag when adding support for a new hardware feature.

The majority of Intel's (and compatible CPU's) VMX capabilities are
enumerated via MSRs and not CPUID, i.e. querying /proc/cpuinfo doesn't
naturally provide any insight into the virtualization capabilities of
VMX enabled CPUs.  Commit e38e05a85828d ("x86: extended "flags" to show
virtualization HW feature in /proc/cpuinfo") attempted to address the
issue by synthesizing select VMX features into a Linux-defined word in
cpufeatures.

The synthetic cpufeatures approach has several flaws:

  - The set of synthesized VMX flags has become extremely stale with
    respect to the full set of VMX features, e.g. only one new flag
    (EPT A/D) has been added in the the decade since the introduction of
    the synthetic VMX features.  Failure to keep the VMX flags up to
    date is likely due to the lack of a mechanism that forces developers
    to consider whether or not a new feature is worth reporting.

  - The synthetic flags may incorrectly be misinterpreted as affecting
    kernel behavior, i.e. KVM, the kernel's sole consumer of VMX,
    completely ignores the synthetic flags.

  - New CPU vendors that support VMX have duplicated the hideous code
    that propagates VMX features from MSRs to cpufeatures.  Bringing the
    synthetic VMX flags up to date would exacerbate the copy+paste
    trainwreck.

Define separate VMX_FEATURE flags to set the stage for enumerating VMX
capabilities outside of the cpu_has() framework, and for adding
functional usage of VMX_FEATURE_* to help ensure the features reported
via /proc/cpuinfo is up to date with respect to kernel recognition of
VMX capabilities.

Note, the displayed names 'vnmi', 'tpr_shadow' and 'flexpriority' are
retained for backwards compatibility with the existing ABI.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 MAINTAINERS                        |  2 +-
 arch/x86/include/asm/processor.h   |  1 +
 arch/x86/include/asm/vmxfeatures.h | 81 ++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/vmxfeatures.h

diff --git a/MAINTAINERS b/MAINTAINERS
index df711965c377..6b736e78ee9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9009,7 +9009,7 @@ F:	arch/x86/include/uapi/asm/svm.h
 F:	arch/x86/include/asm/kvm*
 F:	arch/x86/include/asm/pvclock-abi.h
 F:	arch/x86/include/asm/svm.h
-F:	arch/x86/include/asm/vmx.h
+F:	arch/x86/include/asm/vmx*.h
 F:	arch/x86/kernel/kvm.c
 F:	arch/x86/kernel/kvmclock.c
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b4e29d8b9e5a..772de8917430 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -25,6 +25,7 @@ struct vm86;
 #include <asm/special_insns.h>
 #include <asm/fpu/types.h>
 #include <asm/unwind_hints.h>
+#include <asm/vmxfeatures.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vmxfeatures.h
new file mode 100644
index 000000000000..aea39b9f1587
--- /dev/null
+++ b/arch/x86/include/asm/vmxfeatures.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_VMXFEATURES_H
+#define _ASM_X86_VMXFEATURES_H
+
+/*
+ * Note: If the comment begins with a quoted string, that string is used
+ * in /proc/cpuinfo instead of the macro name.  If the string is "",
+ * this feature bit is not displayed in /proc/cpuinfo at all.
+ */
+
+/* Pin-Based VM-Execution Controls, EPT/VPID, APIC and VM-Functions, word 0 */
+#define VMX_FEATURE_INTR_EXITING	( 0*32+  0) /* "" VM-Exit on vectored interrupts */
+#define VMX_FEATURE_NMI_EXITING		( 0*32+  3) /* "" VM-Exit on NMIs */
+#define VMX_FEATURE_VIRTUAL_NMIS	( 0*32+  5) /* "vnmi" NMI virtualization */
+#define VMX_FEATURE_PREEMPTION_TIMER	( 0*32+  6) /* VMX Preemption Timer */
+#define VMX_FEATURE_POSTED_INTR		( 0*32+  7) /* Posted Interrupts */
+
+/* EPT/VPID features, scattered to bits 16-23 */
+#define VMX_FEATURE_INVVPID	        ( 0*32+ 16) /* INVVPID is supported */
+#define VMX_FEATURE_EPT_EXECUTE_ONLY	( 0*32+ 17) /* "ept_x_only" EPT entries can be execute only */
+#define VMX_FEATURE_EPT_AD      	( 0*32+ 18) /* EPT Accessed/Dirty bits */
+#define VMX_FEATURE_EPT_1GB      	( 0*32+ 19) /* 1GB EPT pages */
+
+/* Aggregated APIC features 24-27 */
+#define VMX_FEATURE_FLEXPRIORITY	( 0*32+ 24) /* TPR shadow + virt APIC */
+#define VMX_FEATURE_APICV	        ( 0*32+ 25) /* TPR shadow + APIC reg virt + virt intr delivery + posted interrupts */
+
+/* VM-Functions, shifted to bits 28-31 */
+#define VMX_FEATURE_EPTP_SWITCHING	( 0*32+ 28) /* EPTP switching (in guest) */
+
+/* Primary Processor-Based VM-Execution Controls, word 1 */
+#define VMX_FEATURE_VIRTUAL_INTR_PENDING ( 1*32+  2) /* "" VM-Exit if INTRs are unblocked in guest */
+#define VMX_FEATURE_TSC_OFFSETTING	( 1*32+  3) /* Offset hardware TSC when read in guest */
+#define VMX_FEATURE_HLT_EXITING		( 1*32+  7) /* "" VM-Exit on HLT */
+#define VMX_FEATURE_INVLPG_EXITING	( 1*32+  9) /* "" VM-Exit on INVLPG */
+#define VMX_FEATURE_MWAIT_EXITING	( 1*32+ 10) /* "" VM-Exit on MWAIT */
+#define VMX_FEATURE_RDPMC_EXITING	( 1*32+ 11) /* "" VM-Exit on RDPMC */
+#define VMX_FEATURE_RDTSC_EXITING	( 1*32+ 12) /* "" VM-Exit on RDTSC */
+#define VMX_FEATURE_CR3_LOAD_EXITING	( 1*32+ 15) /* "" VM-Exit on writes to CR3 */
+#define VMX_FEATURE_CR3_STORE_EXITING	( 1*32+ 16) /* "" VM-Exit on reads from CR3 */
+#define VMX_FEATURE_CR8_LOAD_EXITING	( 1*32+ 19) /* "" VM-Exit on writes to CR8 */
+#define VMX_FEATURE_CR8_STORE_EXITING	( 1*32+ 20) /* "" VM-Exit on reads from CR8 */
+#define VMX_FEATURE_VIRTUAL_TPR		( 1*32+ 21) /* "tpr_shadow" TPR virtualization */
+#define VMX_FEATURE_VIRTUAL_NMI_PENDING	( 1*32+ 22) /* "" VM-Exit if NMIs are unblocked in guest */
+#define VMX_FEATURE_MOV_DR_EXITING	( 1*32+ 23) /* "" VM-Exit on accesses to debug registers */
+#define VMX_FEATURE_UNCOND_IO_EXITING	( 1*32+ 24) /* "" VM-Exit on *all* IN{S} and OUT{S}*/
+#define VMX_FEATURE_USE_IO_BITMAPS	( 1*32+ 25) /* "" VM-Exit based on I/O port */
+#define VMX_FEATURE_MONITOR_TRAP_FLAG	( 1*32+ 27) /* "mtf" VMX single-step VM-Exits */
+#define VMX_FEATURE_USE_MSR_BITMAPS	( 1*32+ 28) /* "" VM-Exit based on MSR index */
+#define VMX_FEATURE_MONITOR_EXITING	( 1*32+ 29) /* "" VM-Exit on MONITOR (MWAIT's accomplice) */
+#define VMX_FEATURE_PAUSE_EXITING	( 1*32+ 30) /* "" VM-Exit on PAUSE (unconditionally) */
+#define VMX_FEATURE_SEC_CONTROLS	( 1*32+ 31) /* "" Enable Secondary VM-Execution Controls */
+
+/* Secondary Processor-Based VM-Execution Controls, word 2 */
+#define VMX_FEATURE_VIRT_APIC_ACCESSES	( 2*32+  0) /* Virtualize memory mapped APIC accesses */
+#define VMX_FEATURE_EPT			( 2*32+  1) /* Extended Page Tables, a.k.a. Two-Dimensional Paging */
+#define VMX_FEATURE_DESC_EXITING	( 2*32+  2) /* "" VM-Exit on {S,L}*DT instructions */
+#define VMX_FEATURE_RDTSCP		( 2*32+  3) /* "" Enable RDTSCP in guest */
+#define VMX_FEATURE_VIRTUAL_X2APIC	( 2*32+  4) /* "" Virtualize X2APIC for the guest */
+#define VMX_FEATURE_VPID		( 2*32+  5) /* Virtual Processor ID (TLB ASID modifier) */
+#define VMX_FEATURE_WBINVD_EXITING	( 2*32+  6) /* "" VM-Exit on WBINVD */
+#define VMX_FEATURE_UNRESTRICTED_GUEST	( 2*32+  7) /* Allow Big Real Mode and other "invalid" states */
+#define VMX_FEATURE_APIC_REGISTER_VIRT	( 2*32+  8) /* Hardware emulation of reads to the virtual-APIC */
+#define VMX_FEATURE_VIRT_INTR_DELIVERY	( 2*32+  9) /* Evaluation and delivery of pending virtual interrupts */
+#define VMX_FEATURE_PAUSE_LOOP_EXITING	( 2*32+ 10) /* "ple" Conditionally VM-Exit on PAUSE at CPL0 */
+#define VMX_FEATURE_RDRAND_EXITING	( 2*32+ 11) /* "" VM-Exit on RDRAND*/
+#define VMX_FEATURE_INVPCID		( 2*32+ 12) /* "" Enable INVPCID in guest */
+#define VMX_FEATURE_VMFUNC		( 2*32+ 13) /* "" Enable VM-Functions (leaf dependent) */
+#define VMX_FEATURE_SHADOW_VMCS		( 2*32+ 14) /* VMREAD/VMWRITE in guest can access shadow VMCS */
+#define VMX_FEATURE_ENCLS_EXITING	( 2*32+ 15) /* "" VM-Exit on ENCLS (leaf dependent) */
+#define VMX_FEATURE_RDSEED_EXITING	( 2*32+ 16) /* "" VM-Exit on RDSEED */
+#define VMX_FEATURE_PAGE_MOD_LOGGING	( 2*32+ 17) /* "pml" Log dirty pages into buffer */
+#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* "" Conditionally reflect EPT violations as #VE exceptions */
+#define VMX_FEATURE_PT_CONCEAL_VMX	( 2*32+ 19) /* "" Suppress VMX indicators in Processor Trace */
+#define VMX_FEATURE_XSAVES		( 2*32+ 20) /* "" Enable XSAVES and XRSTORS in guest */
+#define VMX_FEATURE_MODE_BASED_EPT_EXEC	( 2*32+ 22) /* Enable separate EPT EXEC bits for supervisor vs. user */
+#define VMX_FEATURE_PT_USE_GPA		( 2*32+ 24) /* "" Processor Trace logs GPAs */
+#define VMX_FEATURE_TSC_SCALING		( 2*32+ 25) /* Scale hardware TSC when read in guest */
+#define VMX_FEATURE_ENCLV_EXITING	( 2*32+ 28) /* "" VM-Exit on ENCLV (leaf dependent) */
+
+#endif /* _ASM_X86_VMXFEATURES_H */
-- 
2.24.0

