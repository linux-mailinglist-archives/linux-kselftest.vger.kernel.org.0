Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB047090D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhLJSrN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48854 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSrM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 346DBB82959
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B43C00446;
        Fri, 10 Dec 2021 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161815;
        bh=fRRKToJPFPhA6pQ7tX8slKdw9pZOXd82PCzrXZ0qKko=;
        h=From:To:Cc:Subject:Date:From;
        b=jYqoj/1LbFSjvzUycvY6rrWqvFziCfiw72njFVUgbli44ZGHfEqLNSXO/NrGz9oba
         1mTLvcf/3fY8DwSXgHDkQQv2Hhi+0URskSjagRlfrrXp0VTjDNAj07+XfKQJE9Jzrb
         3nxxez9fv+WPinLaIZFEP/TOgecGhyNvdNZ6yfT24IoLJlgmTo2+hvAiuBFbh69Ra8
         0PGUSln9umXyvNNIAtV7sEJzgCBX9mhGL5A+qXmVWHT1cAu5lYGjs7xWnOAZi3ftQK
         KWZZC7pRSK2ky1UoSgAKfy7yCbKUStP47rXoG5lw1m02V8FliF5C0hSIYoBTasimCX
         RAckOmBXAWi6A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v7 00/37] arm64/sme: Initial support for the Scalable Matrix Extension
Date:   Fri, 10 Dec 2021 18:40:56 +0000
Message-Id: <20211210184133.320748-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13163; h=from:subject; bh=fRRKToJPFPhA6pQ7tX8slKdw9pZOXd82PCzrXZ0qKko=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs58+Otow5KbzYIGHKpJeG/cI1JmvEkTcn/OgngtH 1uDqM9yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfPgAKCRAk1otyXVSH0NIwB/ 91LZLr0KVuRLbJRIP3Axbnzeh56UzwEGEImwQUiJWGaBLg4PO+ysBHLZmnHSjUhRR965kyazvi/Bgq nhKXS8t9pDTwAtzsY4KK/qm2Xbko1EXzZBWwIdvjDHRoy62JSR58S55/KKT3vHjUlVm3w4Jhz85jKE kkKwit9Wm8/oZO5Cup8P6wtQZsaol+e2yqfIoOQy/EunmK04byVHgvqRsoeOibmknOQwrRbmaUlHU2 3MpxVCEguF+2RuuCYS/ELAGkR6sUh38OH6ehgf25kgmfQOlslu+TWbGkyRP0VRDAxyNemgEm8mTL4h WG0vsaf6Il4SHaQcOTOIn/VlhS9lL0
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series provides initial support for the ARMv9 Scalable Matrix
Extension (SME).  SME takes the approach used for vectors in SVE and
extends this to provide architectural support for matrix operations.  A
more detailed overview can be found in [1].

For the kernel SME can be thought of as a series of features which are
intended to be used together by applications but operate mostly
orthogonally:

 - The ZA matrix register.
 - Streaming mode, in which ZA can be accessed and a subset of SVE
   features are available.
 - A second vector length, used for streaming mode SVE and ZA and
   controlled using a similar interface to that for SVE.
 - TPIDR2, a new userspace controllable system register intended for use
   by the C library for storing context related to the ZA ABI.

A substantial part of the series is dedicated to refactoring the
existing SVE support so that we don't need to duplicate code for
handling vector lengths and the SVE registers, this involves creating an
array of vector types and making the users take the vector type as a
parameter.  I'm not 100% happy with this but wasn't able to come up with
anything better, duplicating code definitely felt like a bad idea so
this felt like the least bad thing.  If this approach makes sense to
people it might make sense to split this off into a separate series
and/or merge it while the rest is pending review to try to make things a
little more digestable, the series is very large so it'd probably make
things easier to digest if some of the preparatory refactoring could be
merged before the rest is ready.

One feature of the architecture of particular note is that switching
to and from streaming mode may change the size of and invalidate the
contents of the SVE registers, and when in streaming mode the FFR is not
accessible.  This complicates aspects of the ABI like signal handling
and ptrace.

This initial implementation is mainly intended to get the ABI in place,
there are several areas which will be worked on going forwards - some of
these will be blockers, others could be handled in followup serieses:

 - KVM is not currently supported and we depend on !KVM, this is
   obviously not good - in hopefully the next version I will add support
   for coexisting with KVM and then in a subsequent series implement
   support for use of SME by KVM guests.
 - It is likely some build configurations have issues, I've not fully
   checked this yet.  In general testing is still ongoing, I anticipate
   finding and fixing some issues in the implementation.
 - No support is currently provided for scheduler control of SME or SME
   applications, given the size of the SME register state the context
   switch overhead may be noticable so this may be needed especially for
   real time applications.  Similar concerns already exist for larger
   SVE vector lengths but are amplified for SME, particularly as the
   vector length increases.
 - There has been no work on optimising the performance of anything the
   kernel does.

It is not expected that any systems will be encountered that support SME
but not SVE, SME is an ARMv9 feature and SVE is mandatory for ARMv9.
The code attempts to handle any such systems that are encountered but
this hasn't been tested extensively.

Due to dependencies on changes already upstreamed this series is based
on a merge of for-next/kselftest and for-next/sve in the arm64 tree.

v7:
 - Rebase onto v5.16-rc3.
 - Reduce indentation when supporting custom triggers for signal tests
   as suggested by Catalin.
 - Change to specifying a width for all CPU features rather than adding
   single bit specific infrastructure.
 - Don't require zeroing of non-shared SVE state during syscalls.
v6:
 - Rebase onto v5.16-rc1.
 - Return to disabling TIF_SVE on kernel entry even if we have SME
   state, this avoids the need for KVM to handle the case where TIF_SVE
   is set on guest entry.
 - Add syscall-abi.h to SME updates to syscall-abi, mistakenly omitted
   from commit.
v5:
 - Rebase onto currently merged SVE and kselftest patches.
 - Add support for the FA64 option, introduced in the recently published
   EAC1 update to the specification.
 - Pull in test program for the syscall ABI previously sent separately
   with some revisions and add coverage for the SME ABI.
 - Fix checking for options with 1 bit fields in ID_AA64SMFR0_EL1.
 - Minor fixes and clarifications to the ABI documentation.
v4:
 - Rebase onto merged patches.
 - Remove an uneeded NULL check in vec_proc_do_default_vl().
 - Include patch to factor out utility routines in kselftests written in
   assembler.
 - Specify -ffreestanding when building TPIDR2 test.
v3:
 - Skip FFR rather than predicate registers in sve_flush_live().
 - Don't assume a bool is all zeros in sve_flush_live() as per AAPCS.
 - Don't redundantly specify a zero index when clearing FFR.
v2:
 - Fix several issues with !SME and !SVE configurations.
 - Preserve TPIDR2 when creating a new thread/process unless
   CLONE_SETTLS is set.
 - Report traps due to using features in an invalid mode as SIGILL.
 - Spell out streaming mode behaviour in SVE ABI documentation more
   directly.
 - Document TPIDR2 in the ABI document.
 - Use SMSTART and SMSTOP rather than read/modify/write sequences.
 - Rework logic for exiting streaming mode on syscall.
 - Don't needlessly initialise SVCR on access trap.
 - Always restore SME VL for userspace if SME traps are disabled.
 - Only yield to encourage preemption every 128 iterations in za-test,
   otherwise do a getpid(), and validate SVCR after syscall.
 - Leave streaming mode disabled except when reading the vector length
   in za-test, and disable ZA after detecting a mismatch.
 - Add SME support to vlset.
 - Clarifications and typo fixes in comments.
 - Move sme_alloc() forward declaration back a patch.

[1] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/scalable-matrix-extension-armv9-a-architecture

Mark Brown (37):
  arm64/sve: Make sysctl interface for SVE reusable by SME
  arm64/sve: Generalise vector length configuration prctl() for SME
  arm64/sve: Minor clarification of ABI documentation
  kselftest/arm64: Parameterise ptrace vector length information
  kselftest/arm64: Allow signal tests to trigger from a function
  kselftest/arm64: Add a test program to exercise the syscall ABI
  arm64: cpufeature: Always specify and use a field width for
    capabilities
  tools/nolibc: Implement gettid()
  arm64/sme: Provide ABI documentation for SME
  arm64/sme: System register and exception syndrome definitions
  arm64/sme: Define macros for manually encoding SME instructions
  arm64/sme: Early CPU setup for SME
  arm64/sme: Basic enumeration support
  arm64/sme: Identify supported SME vector lengths at boot
  arm64/sme: Implement sysctl to set the default vector length
  arm64/sme: Implement vector length configuration prctl()s
  arm64/sme: Implement support for TPIDR2
  arm64/sme: Implement SVCR context switching
  arm64/sme: Implement streaming SVE context switching
  arm64/sme: Implement ZA context switching
  arm64/sme: Implement traps and syscall handling for SME
  arm64/sme: Implement streaming SVE signal handling
  arm64/sme: Implement ZA signal handling
  arm64/sme: Implement ptrace support for streaming mode SVE registers
  arm64/sme: Add ptrace support for ZA
  arm64/sme: Disable streaming mode and ZA when flushing CPU state
  arm64/sme: Save and restore streaming mode over EFI runtime calls
  arm64/sme: Provide Kconfig for SME
  kselftest/arm64: sme: Add streaming SME support to vlset
  kselftest/arm64: Add tests for TPIDR2
  kselftest/arm64: Extend vector configuration API tests to cover SME
  kselftest/arm64: sme: Provide streaming mode SVE stress test
  kselftest/arm64: Add stress test for SME ZA context switching
  kselftest/arm64: signal: Add SME signal handling tests
  kselftest/arm64: Add streaming SVE to SVE ptrace tests
  kselftest/arm64: Add coverage for the ZA ptrace interface
  kselftest/arm64: Add SME support to syscall ABI test

 Documentation/arm64/elf_hwcaps.rst            |  33 +
 Documentation/arm64/index.rst                 |   1 +
 Documentation/arm64/sme.rst                   | 430 ++++++++++++
 Documentation/arm64/sve.rst                   |  72 +-
 arch/arm64/Kconfig                            |  11 +
 arch/arm64/include/asm/cpu.h                  |   4 +
 arch/arm64/include/asm/cpufeature.h           |  25 +
 arch/arm64/include/asm/el2_setup.h            |  45 ++
 arch/arm64/include/asm/esr.h                  |  13 +-
 arch/arm64/include/asm/exception.h            |   1 +
 arch/arm64/include/asm/fpsimd.h               | 112 ++-
 arch/arm64/include/asm/fpsimdmacros.h         |  77 ++
 arch/arm64/include/asm/hwcap.h                |   8 +
 arch/arm64/include/asm/kvm_arm.h              |   1 +
 arch/arm64/include/asm/processor.h            |  18 +-
 arch/arm64/include/asm/sysreg.h               |  58 ++
 arch/arm64/include/asm/thread_info.h          |   2 +
 arch/arm64/include/uapi/asm/hwcap.h           |   8 +
 arch/arm64/include/uapi/asm/ptrace.h          |  69 +-
 arch/arm64/include/uapi/asm/sigcontext.h      |  55 +-
 arch/arm64/kernel/cpufeature.c                | 269 +++++--
 arch/arm64/kernel/cpuinfo.c                   |  13 +
 arch/arm64/kernel/entry-common.c              |  10 +
 arch/arm64/kernel/entry-fpsimd.S              |  31 +
 arch/arm64/kernel/fpsimd.c                    | 657 ++++++++++++++++--
 arch/arm64/kernel/process.c                   |  28 +-
 arch/arm64/kernel/ptrace.c                    | 358 ++++++++--
 arch/arm64/kernel/signal.c                    | 187 ++++-
 arch/arm64/kernel/syscall.c                   |  34 +-
 arch/arm64/kernel/traps.c                     |   1 +
 arch/arm64/kvm/fpsimd.c                       |   3 +-
 arch/arm64/kvm/reset.c                        |   8 +-
 arch/arm64/tools/cpucaps                      |   2 +
 include/uapi/linux/elf.h                      |   2 +
 include/uapi/linux/prctl.h                    |   9 +
 kernel/sys.c                                  |  12 +
 tools/include/nolibc/nolibc.h                 |  18 +
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/abi/.gitignore  |   2 +
 tools/testing/selftests/arm64/abi/Makefile    |  15 +
 .../selftests/arm64/abi/syscall-abi-asm.S     | 307 ++++++++
 .../testing/selftests/arm64/abi/syscall-abi.c | 478 +++++++++++++
 .../testing/selftests/arm64/abi/syscall-abi.h |  15 +
 tools/testing/selftests/arm64/abi/tpidr2.c    | 298 ++++++++
 tools/testing/selftests/arm64/fp/.gitignore   |   4 +
 tools/testing/selftests/arm64/fp/Makefile     |  12 +-
 tools/testing/selftests/arm64/fp/rdvl-sme.c   |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S       |  16 +
 tools/testing/selftests/arm64/fp/rdvl.h       |   1 +
 tools/testing/selftests/arm64/fp/ssve-stress  |  59 ++
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 230 ++++--
 tools/testing/selftests/arm64/fp/sve-test.S   |  30 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c |  10 +
 tools/testing/selftests/arm64/fp/vlset.c      |  10 +-
 tools/testing/selftests/arm64/fp/za-ptrace.c  | 353 ++++++++++
 tools/testing/selftests/arm64/fp/za-stress    |  59 ++
 tools/testing/selftests/arm64/fp/za-test.S    | 431 ++++++++++++
 .../testing/selftests/arm64/signal/.gitignore |   2 +
 .../selftests/arm64/signal/test_signals.h     |   2 +
 .../arm64/signal/test_signals_utils.c         |  15 +-
 .../testcases/fake_sigreturn_sme_change_vl.c  |  92 +++
 .../arm64/signal/testcases/sme_trap_za.c      |  36 +
 .../selftests/arm64/signal/testcases/sme_vl.c |  70 ++
 .../arm64/signal/testcases/ssve_regs.c        | 129 ++++
 64 files changed, 5059 insertions(+), 318 deletions(-)
 create mode 100644 Documentation/arm64/sme.rst
 create mode 100644 tools/testing/selftests/arm64/abi/.gitignore
 create mode 100644 tools/testing/selftests/arm64/abi/Makefile
 create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi-asm.S
 create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi.c
 create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi.h
 create mode 100644 tools/testing/selftests/arm64/abi/tpidr2.c
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sme.c
 create mode 100644 tools/testing/selftests/arm64/fp/ssve-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-ptrace.c
 create mode 100644 tools/testing/selftests/arm64/fp/za-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-test.S
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_za.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c


base-commit: d58071a8a76d779eedab38033ae4c821c30295a5
-- 
2.30.2

