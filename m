Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F053F101203
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 04:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfKSDOj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 22:14:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:21257 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfKSDMz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 22:12:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 19:12:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="218105699"
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
Subject: [PATCH v3 00/19] x86/cpu: Clean up handling of VMX features
Date:   Mon, 18 Nov 2019 19:12:21 -0800
Message-Id: <20191119031240.7779-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
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
pointed out by Boris in the SGX enabling series[1], is that the kernel
currently doesn't ensure the IA32_FEATURE_CONTROL MSR is configured during
boot.  The second issue is that the kernel's reporting of VMX features is
stale, potentially inaccurate, and difficult to maintain.

Please holler if you don't want to be cc'd on future versions of this
series, or only want to be cc'd on select patches.

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
  - Fix a changelog typoe [Boris].

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

[1] https://lkml.kernel.org/r/20190925085156.GA3891@zn.tnic

Sean Christopherson (19):
  x86/msr-index: Clean up bit defines for IA32_FEATURE_CONTROL MSR
  selftests: kvm: Replace manual MSR defs with common msr-index.h
  tools arch x86: Sync msr-index.h from kernel sources
  x86/intel: Initialize IA32_FEATURE_CONTROL MSR at boot
  x86/mce: WARN once if IA32_FEATURE_CONTROL MSR is left unlocked
  x86/centaur: Use common IA32_FEATURE_CONTROL MSR initialization
  x86/zhaoxin: Use common IA32_FEATURE_CONTROL MSR initialization
  KVM: VMX: Drop initialization of IA32_FEATURE_CONTROL MSR
  x86/cpu: Clear VMX feature flag if VMX is not fully enabled
  KVM: VMX: Use VMX feature flag to query BIOS enabling
  KVM: VMX: Check for full VMX support when verifying CPU compatibility
  x86/vmx: Introduce VMX_FEATURES_*
  x86/cpu: Detect VMX features on Intel, Centaur and Zhaoxin CPUs
  x86/cpu: Print VMX flags in /proc/cpuinfo using VMX_FEATURES_*
  x86/cpufeatures: Drop synthetic VMX feature flags
  KVM: VMX: Use VMX_FEATURE_* flags to define VMCS control bits
  x86/cpufeatures: Clean up synthetic virtualization flags
  perf/x86: Provide stubs of KVM helpers for non-Intel CPUs
  KVM: VMX: Allow KVM_INTEL when building for Centaur and/or Zhaoxin
    CPUs

 MAINTAINERS                                   |   2 +-
 arch/x86/Kconfig.cpu                          |   8 +
 arch/x86/boot/mkcpustr.c                      |   1 +
 arch/x86/include/asm/cpufeatures.h            |  15 +-
 arch/x86/include/asm/msr-index.h              |  11 +-
 arch/x86/include/asm/perf_event.h             |  22 +-
 arch/x86/include/asm/processor.h              |   4 +
 arch/x86/include/asm/vmx.h                    | 105 +--
 arch/x86/include/asm/vmxfeatures.h            |  86 +++
 arch/x86/kernel/cpu/Makefile                  |   6 +-
 arch/x86/kernel/cpu/centaur.c                 |  35 +-
 arch/x86/kernel/cpu/common.c                  |   3 +
 arch/x86/kernel/cpu/cpu.h                     |   4 +
 arch/x86/kernel/cpu/feature_control.c         | 127 +++
 arch/x86/kernel/cpu/intel.c                   |  49 +-
 arch/x86/kernel/cpu/mce/intel.c               |   7 +-
 arch/x86/kernel/cpu/mkcapflags.sh             |  15 +-
 arch/x86/kernel/cpu/proc.c                    |  14 +
 arch/x86/kernel/cpu/zhaoxin.c                 |  35 +-
 arch/x86/kvm/Kconfig                          |  10 +-
 arch/x86/kvm/vmx/nested.c                     |   4 +-
 arch/x86/kvm/vmx/vmx.c                        |  57 +-
 arch/x86/kvm/vmx/vmx.h                        |   2 +-
 tools/arch/x86/include/asm/msr-index.h        |  27 +-
 tools/testing/selftests/kvm/Makefile          |   4 +-
 .../selftests/kvm/include/x86_64/processor.h  | 726 +-----------------
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |   4 +-
 27 files changed, 400 insertions(+), 983 deletions(-)
 create mode 100644 arch/x86/include/asm/vmxfeatures.h
 create mode 100644 arch/x86/kernel/cpu/feature_control.c

-- 
2.24.0

