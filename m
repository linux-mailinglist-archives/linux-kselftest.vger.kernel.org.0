Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6341FD512
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgFQTFP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 15:05:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:48978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgFQTFM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 15:05:12 -0400
IronPort-SDR: NooAGNyQf0ZPhrz42xP9jstf9Gded30rYMc3C7Pr7lebLop2SdcCjeEBA8MAl2wsQFi0pagCu2
 tJjbBA3sdeEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 12:05:11 -0700
IronPort-SDR: 16liMDp6fjMJskgBNoaSNQ/ghF+MJxz6rqa/Oic4ytifJV5tNpXBCV6ChubOykl3ZRrsk1hjFv
 8O6IvGieAe+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="273609675"
Received: from gza.jf.intel.com ([10.54.75.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2020 12:05:11 -0700
From:   John Andersen <john.s.andersen@intel.com>
To:     corbet@lwn.net, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, sean.j.christopherson@intel.com,
        liran.alon@oracle.com, drjones@redhat.com,
        rick.p.edgecombe@intel.com, kristen@linux.intel.com
Cc:     vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, mchehab+huawei@kernel.org,
        gregkh@linuxfoundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        mike.kravetz@oracle.com, oneukum@suse.com, luto@kernel.org,
        peterz@infradead.org, fenghua.yu@intel.com,
        reinette.chatre@intel.com, vineela.tummalapalli@intel.com,
        dave.hansen@linux.intel.com, john.s.andersen@intel.com,
        arjan@linux.intel.com, caoj.fnst@cn.fujitsu.com, bhe@redhat.com,
        nivedita@alum.mit.edu, keescook@chromium.org,
        dan.j.williams@intel.com, eric.auger@redhat.com,
        aaronlewis@google.com, peterx@redhat.com,
        makarandsonare@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 4/4] X86: Use KVM CR pin MSRs
Date:   Wed, 17 Jun 2020 12:07:57 -0700
Message-Id: <20200617190757.27081-5-john.s.andersen@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617190757.27081-1-john.s.andersen@intel.com>
References: <20200617190757.27081-1-john.s.andersen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Strengthen existing control register pinning when running
paravirtualized under KVM. Check which bits KVM supports pinning for
each control register and only pin supported bits which are already
pinned via the existing native protection. Write to KVM CR0/4 pinned
MSRs to enable pinning.

Initiate KVM assisted pinning directly following the setup of native
pinning on boot CPU. For non-boot CPUs initiate paravirtualized pinning
on CPU identification.

Identification of non-boot CPUs takes place after the boot CPU has setup
native CR pinning. Therefore, non-boot CPUs access pinned bits setup by
the boot CPU and request that those be pinned. All CPUs request
paravirtualized pinning of the same bits which are already pinned
natively.

Guests using the kexec system call currently do not support
paravirtualized control register pinning. This is due to early boot
code writing known good values to control registers, these values do
not contain the protected bits. This is due to CPU feature
identification being done at a later time, when the kernel properly
checks if it can enable protections. As such, the pv_cr_pin command line
option has been added which instructs the kernel to disable kexec in
favor of enabling paravirtualized control register pinning. crashkernel
is also disabled when the pv_cr_pin parameter is specified due to its
reliance on kexec.

When we fix kexec, we will still need a way for a kernel with support to
know if the kernel it is attempting to load has support. If a kernel
with this enabled attempts to kexec a kernel where this is not
supported, it would trigger a fault almost immediately.

Liran suggested adding a section to the built image acting as a flag to
signify support for being kexec'd by a kernel with pinning enabled.
Should that approach be implemented, it is likely that the command line
flag (pv_cr_pin) would still be desired for some deprecation period. We
wouldn't want the default behavior to change from being able to kexec
older kernels to not being able to, as this might break some users
workflows.

Signed-off-by: John Andersen <john.s.andersen@intel.com>
---
 .../admin-guide/kernel-parameters.txt         | 11 ++++++
 arch/x86/Kconfig                              | 10 +++++
 arch/x86/include/asm/kvm_para.h               | 28 +++++++++++++
 arch/x86/kernel/cpu/common.c                  |  5 +++
 arch/x86/kernel/kvm.c                         | 39 +++++++++++++++++++
 arch/x86/kernel/setup.c                       |  8 ++++
 6 files changed, 101 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 89386f6f3ab6..54fb2b5ab8fc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3926,6 +3926,17 @@
 			[KNL] Number of legacy pty's. Overwrites compiled-in
 			default number.
 
+	pv_cr_pin	[SECURITY,X86]
+			Enable paravirtualized control register pinning. When
+			running paravirutalized under KVM, request that KVM not
+			allow the guest to disable kernel protection features
+			set in CPU control registers. Specifying this option
+			will disable kexec (and crashkernel). If kexec support
+			has not been compiled into the kernel and host KVM
+			supports paravirtualized control register pinning, it
+			will be active by default without the need to specify
+			this parameter.
+
 	quiet		[KNL] Disable most log messages
 
 	r128=		[HW,DRM]
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67f6a40b5e93..bc0b27483001 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -800,6 +800,7 @@ config KVM_GUEST
 	bool "KVM Guest support (including kvmclock)"
 	depends on PARAVIRT
 	select PARAVIRT_CLOCK
+	select PARAVIRT_CR_PIN
 	select ARCH_CPUIDLE_HALTPOLL
 	default y
 	---help---
@@ -835,6 +836,15 @@ config PARAVIRT_TIME_ACCOUNTING
 config PARAVIRT_CLOCK
 	bool
 
+config PARAVIRT_CR_PIN
+       bool "Paravirtual bit pinning for CR0 and CR4"
+       depends on KVM_GUEST
+       help
+         Select this option to have the virtualised guest request that the
+         hypervisor disallow it from disabling protections set in control
+         registers. The hypervisor will prevent exploits from disabling
+         features such as SMEP, SMAP, UMIP, and WP.
+
 config JAILHOUSE_GUEST
 	bool "Jailhouse non-root cell support"
 	depends on X86_64 && PCI
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 57fd1966c4ea..f021531e98dc 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -112,6 +112,23 @@ static inline void kvm_spinlock_init(void)
 }
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
+#ifdef CONFIG_PARAVIRT_CR_PIN
+void __init kvm_paravirt_cr_pinning_init(void);
+void kvm_setup_paravirt_cr_pinning(unsigned long cr0_pinned_bits,
+				   unsigned long cr4_pinned_bits);
+#else
+static inline void kvm_paravirt_cr_pinning_init(void)
+{
+	return;
+}
+
+static inline void kvm_setup_paravirt_cr_pinning(unsigned long cr0_pinned_bits,
+						 unsigned long cr4_pinned_bits)
+{
+	return;
+}
+#endif /* CONFIG_PARAVIRT_CR_PIN */
+
 #else /* CONFIG_KVM_GUEST */
 #define kvm_async_pf_task_wait_schedule(T) do {} while(0)
 #define kvm_async_pf_task_wake(T) do {} while(0)
@@ -145,6 +162,17 @@ static inline bool kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	return false;
 }
+
+static inline void kvm_paravirt_cr_pinning_init(void)
+{
+	return;
+}
+
+static inline void kvm_setup_paravirt_cr_pinning(unsigned long cr0_pinned_bits,
+						 unsigned long cr4_pinned_bits)
+{
+	return;
+}
 #endif
 
 #endif /* _ASM_X86_KVM_PARA_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 921e67086a00..ee17223b1fa8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -21,6 +21,7 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
+#include <linux/kvm_para.h>
 
 #include <asm/stackprotector.h>
 #include <asm/perf_event.h>
@@ -416,6 +417,8 @@ static void __init setup_cr_pinning(void)
 	mask = (X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP);
 	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & mask;
 	static_key_enable(&cr_pinning.key);
+
+	kvm_setup_paravirt_cr_pinning(X86_CR0_WP, cr4_pinned_bits);
 }
 
 /*
@@ -1551,6 +1554,8 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 	mtrr_ap_init();
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
+
+	kvm_setup_paravirt_cr_pinning(X86_CR0_WP, cr4_pinned_bits);
 }
 
 static __init int setup_noclflush(char *arg)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7e6403a8d861..def913b86a99 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -23,6 +23,8 @@
 #include <linux/kprobes.h>
 #include <linux/nmi.h>
 #include <linux/swait.h>
+#include <linux/init.h>
+#include <linux/kexec.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -33,6 +35,7 @@
 #include <asm/hypervisor.h>
 #include <asm/tlb.h>
 #include <asm/cpuidle_haltpoll.h>
+#include <asm/cmdline.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
 
@@ -723,6 +726,7 @@ static void __init kvm_apic_init(void)
 static void __init kvm_init_platform(void)
 {
 	kvmclock_init();
+	kvm_paravirt_cr_pinning_init();
 	x86_platform.apic_post_init = kvm_apic_init;
 }
 
@@ -877,6 +881,41 @@ void __init kvm_spinlock_init(void)
 
 #endif	/* CONFIG_PARAVIRT_SPINLOCKS */
 
+#ifdef CONFIG_PARAVIRT_CR_PIN
+static int kvm_paravirt_cr_pinning_enabled __ro_after_init;
+
+void __init kvm_paravirt_cr_pinning_init(void)
+{
+#ifdef CONFIG_KEXEC_CORE
+	if (!cmdline_find_option_bool(boot_command_line, "pv_cr_pin"))
+		return;
+
+	/* Paravirtualized CR pinning is currently incompatible with kexec */
+	kexec_load_disabled = 1;
+#endif
+
+	kvm_paravirt_cr_pinning_enabled = 1;
+}
+
+void kvm_setup_paravirt_cr_pinning(unsigned long cr0_pinned_bits,
+				   unsigned long cr4_pinned_bits)
+{
+	u64 mask;
+
+	if (!kvm_paravirt_cr_pinning_enabled)
+		return;
+
+	if (!kvm_para_has_feature(KVM_FEATURE_CR_PIN))
+		return;
+
+	rdmsrl(MSR_KVM_CR0_PIN_ALLOWED, mask);
+	wrmsrl(MSR_KVM_CR0_PINNED_HIGH, cr0_pinned_bits & mask);
+
+	rdmsrl(MSR_KVM_CR4_PIN_ALLOWED, mask);
+	wrmsrl(MSR_KVM_CR4_PINNED_HIGH, cr4_pinned_bits & mask);
+}
+#endif
+
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 
 static void kvm_disable_host_haltpoll(void *i)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d9c678b37a9b..ed3bcc85d40d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -27,6 +27,9 @@
 #include <asm/apic.h>
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
+#include <asm/kasan.h>
+#include <asm/cmdline.h>
+
 #include <asm/cpu.h>
 #include <asm/efi.h>
 #include <asm/gart.h>
@@ -502,6 +505,11 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
+	if (cmdline_find_option_bool(boot_command_line, "pv_cr_pin")) {
+		pr_info("Ignoring crashkernel since pv_cr_pin present in cmdline\n");
+		return;
+	}
+
 	/* 0 means: find the address automatically */
 	if (!crash_base) {
 		/*
-- 
2.21.0

