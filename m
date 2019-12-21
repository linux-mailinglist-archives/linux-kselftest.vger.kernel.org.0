Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98161286DF
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2019 05:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLUEpx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 23:45:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:31824 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfLUEpw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 23:45:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 20:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="scan'208";a="222620045"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2019 20:45:50 -0800
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
Subject: [PATCH v5 00/19] x86/cpu: Clean up handling of VMX features
Date:   Fri, 20 Dec 2019 20:44:54 -0800
Message-Id: <20191221044513.21680-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Clean up a handful of interrelated warts in the kernel's handling of VMX:

  - Enable VMX in IA32_FEATURE_CONTROL during boot instead of on-demand
    during KVM load to avoid future contention over IA32_FEATURE_CONTROL.

  - Rework VMX feature reporting so that it is accurate and up-to-date,
    now and in the future.

  - Consolidate code across CPUs that support VMX.

This series stems from two separate but related issues.  The first issue,
pointed out by Boris in the SGX enabling series[*], is that the kernel
currently doesn't ensure the IA32_FEATURE_CONTROL MSR is configured during
boot.  The second issue is that the kernel's reporting of VMX features is
stale, potentially inaccurate, and difficult to maintain.

v5:
  - Rebase to tip/master, ec7b10f2d023 ("Merge branch 'x86/cleanups'")
  - Fix a missing IA32_FEAT_CTL change in the idle driver (which amusingly
    reads the MSR to deal with SGX). [kbuild test robot]
  - Tweak the displayed names for VMX flags. [Boris, Paolo, Liran]
  - Add a comment above the raw rdmsr() calls in the VMX feature flag
    parsing. [Boris]
  - Fix a few changelog typos. [Boris]
  - Use VMX_F() instead of F() for the VMX flag extraction macro. [Boris]
  - Drop 'PROC' from the PRIMARY_CTLS and SECONDARY_CTLS enums to keep
    line lengths sane.
  - Keep the pr_fmt at the top of feat_ctl.c when the flag populating code
    is introduced (previously got buried in the middle of the file).

v4:
  - Rebase to tip/master, 8a1b070333f4 ("Merge branch 'WIP.x86/mm'")
  - Rename everything feature control related to IA32_FEAT_CTL. [Boris]
  - Minor coding style tweaks [Boris and Jarkko].
  - Print VMX feature flags in "vmx flags" to avoid polluting "flags",
    but keep printing the current synthetic VMX in "flags" so as not to
    break the ABI. [Boris]
  - Don't bother printing an error message in the extremely unlikely
    event VMX is supported but IA32_FEAT_CTL doesn't exist. [Boris]
  - Beef up a few changelogs and comments. [Boris]
  - Add a comment in the LMCE code for the new WARN. [Jarkko]
  - Check CONFIG_KVM_INTEL instead of CONFIG_KVM when deciding whether
    or not to enable VMX.
  - Add a patch to introduce X86_FEATURE_MSR_IA32_FEAT_CTL.
  - Dropped Jim's Reviewed-by from a few KVM patches due to the above
    addition.

v3:
  - Rebase to tip/master, ceceaf1f12ba ("Merge branch 'WIP.x86/cleanups'").
  - Rename the feature control MSR bit defines [Boris].
  - Rewrite the error message displayed when reading feature control MSR
    faults on a VMX capable CPU to explicitly state that it's likely a
    hardware or hypervisor issue [Boris].
  - Collect a Reviewed-by for the LMCE change [Boris].
  - Enable VMX in feature control (if it's unlocked) if and only if
    KVM is enabled [Paolo].
  - Remove a big pile of redudant MSR defines from the KVM selftests that
    was discovered when renaming the feature control defines.
  - Fix a changelog typo [Boris].

v2:
  - Rebase to latest tip/x86/cpu (1edae1ae6258, "x86/Kconfig: Enforce...)
  - Collect Jim's reviews.
  - Fix a typo in setting of EPT capabilities [TonyWWang-oc].
  - Remove defines for reserved VMX feature flags [Paolo].
  - Print the VMX features under "flags" and maintain all existing names
    to be backward compatible with the ABI [Paolo].
  - Create aggregate APIC features to report FLEXPRIORITY and APICV, so
    that the full feature *and* their associated individual features are
    printed, e.g. to aid in recognizing why an APIC feature isn't being
    used.
  - Fix a few copy paste errors in changelogs.

v1 cover letter:

== IA32_FEATURE_CONTROL ==
Lack of IA32_FEATURE_CONTROL configuration during boot isn't a functional
issue in the current kernel as the majority of platforms set and lock
IA32_FEATURE_CONTROL in firmware.  And when the MSR is left unlocked, KVM
is the only subsystem that writes IA32_FEATURE_CONTROL.  That will change
if/when SGX support is enabled, as SGX will also want to fully enable
itself when IA32_FEATURE_CONTROL is unlocked.

== VMX Feature Reporting ==
VMX features are not enumerated via CPUID, but instead are enumerated
through VMX MSRs.  As a result, new VMX features are not automatically
reported via /proc/cpuinfo.

An attempt was made long ago to report interesting and/or meaningful VMX
features by synthesizing select features into a Linux-defined cpufeatures
word.  Synthetic feature flags worked for the initial purpose, but the
existence of the synthetic flags was forgotten almost immediately, e.g.
only one new flag (EPT A/D) has been added in the the decade since the
synthetic VMX features were introduced, while VMX and KVM have gained
support for many new features.

Placing the synthetic flags in x86_capability also allows them to be
queried via cpu_has() and company, which is misleading as the flags exist
purely for reporting via /proc/cpuinfo.  KVM, the only in-kernel user of
VMX, ignores the flags.

Last but not least, VMX features are reported in /proc/cpuinfo even
when VMX is unusable due to lack of enabling in IA32_FEATURE_CONTROL.

== Caveats ==
All of the testing of non-standard flows was done in a VM, as I don't
have a system that leaves IA32_FEATURE_CONTROL unlocked, or locks it with
VMX disabled.

The Centaur and Zhaoxin changes are somewhat speculative, as I haven't
confirmed they actually support IA32_FEATURE_CONTROL, or that they want to
gain "official" KVM support.  I assume they unofficially support KVM given
that both CPUs went through the effort of enumerating VMX features.  That
in turn would require them to support IA32_FEATURE_CONTROL since KVM will
fault and refuse to load if the MSR doesn't exist.

[*] https://lkml.kernel.org/r/20190925085156.GA3891@zn.tnic

Sean Christopherson (19):
  x86/msr-index: Clean up bit defines for IA32_FEATURE_CONTROL MSR
  selftests: kvm: Replace manual MSR defs with common msr-index.h
  tools arch x86: Sync msr-index.h from kernel sources
  x86/intel: Initialize IA32_FEAT_CTL MSR at boot
  x86/mce: WARN once if IA32_FEAT_CTL MSR is left unlocked
  x86/centaur: Use common IA32_FEAT_CTL MSR initialization
  x86/zhaoxin: Use common IA32_FEAT_CTL MSR initialization
  x86/cpu: Clear VMX feature flag if VMX is not fully enabled
  x86/vmx: Introduce VMX_FEATURES_*
  x86/cpu: Detect VMX features on Intel, Centaur and Zhaoxin CPUs
  x86/cpu: Print VMX flags in /proc/cpuinfo using VMX_FEATURES_*
  x86/cpu: Set synthetic VMX cpufeatures during init_ia32_feat_ctl()
  x86/cpufeatures: Add flag to track whether MSR IA32_FEAT_CTL is
    configured
  KVM: VMX: Drop initialization of IA32_FEAT_CTL MSR
  KVM: VMX: Use VMX feature flag to query BIOS enabling
  KVM: VMX: Check for full VMX support when verifying CPU compatibility
  KVM: VMX: Use VMX_FEATURE_* flags to define VMCS control bits
  perf/x86: Provide stubs of KVM helpers for non-Intel CPUs
  KVM: VMX: Allow KVM_INTEL when building for Centaur and/or Zhaoxin
    CPUs

 MAINTAINERS                                   |   2 +-
 arch/x86/Kconfig.cpu                          |   8 +
 arch/x86/boot/mkcpustr.c                      |   1 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |  14 +-
 arch/x86/include/asm/perf_event.h             |  22 +-
 arch/x86/include/asm/processor.h              |   4 +
 arch/x86/include/asm/vmx.h                    | 105 +--
 arch/x86/include/asm/vmxfeatures.h            |  86 +++
 arch/x86/kernel/cpu/Makefile                  |   6 +-
 arch/x86/kernel/cpu/centaur.c                 |  35 +-
 arch/x86/kernel/cpu/common.c                  |   3 +
 arch/x86/kernel/cpu/cpu.h                     |   4 +
 arch/x86/kernel/cpu/feat_ctl.c                | 144 ++++
 arch/x86/kernel/cpu/intel.c                   |  49 +-
 arch/x86/kernel/cpu/mce/intel.c               |  15 +-
 arch/x86/kernel/cpu/mkcapflags.sh             |  15 +-
 arch/x86/kernel/cpu/proc.c                    |  15 +
 arch/x86/kernel/cpu/zhaoxin.c                 |  35 +-
 arch/x86/kvm/Kconfig                          |  10 +-
 arch/x86/kvm/vmx/nested.c                     |   4 +-
 arch/x86/kvm/vmx/vmx.c                        |  67 +-
 arch/x86/kvm/vmx/vmx.h                        |   2 +-
 arch/x86/kvm/x86.c                            |   2 +-
 drivers/idle/intel_idle.c                     |   2 +-
 tools/arch/x86/include/asm/msr-index.h        |  14 +-
 tools/power/x86/turbostat/turbostat.c         |   4 +-
 tools/testing/selftests/kvm/Makefile          |   4 +-
 .../selftests/kvm/include/x86_64/processor.h  | 726 +-----------------
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |   8 +-
 30 files changed, 420 insertions(+), 987 deletions(-)
 create mode 100644 arch/x86/include/asm/vmxfeatures.h
 create mode 100644 arch/x86/kernel/cpu/feat_ctl.c

-- 
2.24.1

