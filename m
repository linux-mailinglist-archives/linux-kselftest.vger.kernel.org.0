Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8C49AA35
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 05:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1324993AbiAYDfW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 22:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3420461AbiAYCYX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 21:24:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3BC038AD7
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 16:15:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7250F61354
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499EFC340E4;
        Tue, 25 Jan 2022 00:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069722;
        bh=oQFaodbzt5WVe6CO56CBPQS4+bHv2dPRcgH3GEtal1s=;
        h=From:To:Cc:Subject:Date:From;
        b=ftnKt/ffVipJZ7A3F1KXXd2Uh+uZQw8/MAlWmMBeDCAaj3xSm8aoLcaxEchXajK8/
         Ng5us/1Xz5cUxb25VpjlE97Y0Somkleg1rLgFq8hej5FV1rcluDEHhPhDendC4p6e1
         /tKz2i5FIb0LcMEuuJP/DAlrFwZXugOHg5mLRL2hf1hJ33VwqI3ZGJ9CuaFVb7pmhT
         lV6Z4eHhjtlp3TckCiiRdJoTzXkMisHVbcBGrfEgt8fqiu4jfneapPF9654jsqwHFl
         wreK9ASzvQLyyfM3E3RhfxiMjDF0iCrpvoWt3vmTYZdsVC3GKWPnuHUf7YWZd6Fudd
         /gNZQMfxkNxDQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v8 00/38] arm64/sme: Initial support for the Scalable Matrix Extension
Date:   Tue, 25 Jan 2022 00:10:36 +0000
Message-Id: <20220125001114.193425-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14370; h=from:subject; bh=oQFaodbzt5WVe6CO56CBPQS4+bHv2dPRcgH3GEtal1s=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AB5rrdCLJ3i79jbqhc5EyKq3eooe9HGIx6byf6 IJhjIMiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9AAQAKCRAk1otyXVSH0Mz0B/ 4ynWv6bK2a6WmDWy4aq6dlP3aR2Yjtl+2LMUnLzg8wbBOkS0A0o344MgFFvjuvyEOEuPUgxKpS5vg/ TfLrKygg0Y8eWAc0XKHV+gAfqIEIqNrV447kc1R84T+qSRjQuYL+i432Ee29fTdc7tTDZzp2QYW3ZI 7siXDbUk2uFHcWCNVsLiuoWehqiiZSyl5GTdIcRbs5Y/71VA+a/C+8qWbd67SfZiS/gPY1bFtSHtTg Ki5ZcgzdFeA8uuKapWrd3uGkPobO+kEwEXivpUmyxm2JKIXbV1eFgc/MgBUrNOP7eDGgSAV9i+4Jm/ OppqF0ne2yH4DqoHM5zK+p1Nyjw0RH
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

 - SME is currently not supported for KVM guests, this will be done as a
   followup series.  A host system can use SME and run KVM guests but
   SME is not available in the guests.
 - The KVM host support is done in a very simplistic way, were anyone to
   attempt to use it in production there would be performance impacts on
   hosts with SME support. As part of this we also add enumeration of
   fine grained traps.
 - There is not currently ptrace or signal support TPIDR2, this will be
   done as a followup series.
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

v8:
 - Rebase onto v5.17-rc1.
 - Support interoperation with KVM, SME is disabled for KVM guests with
   minimal handling for cleaning up SME state when entering and leaving
   the guest.
 - Document and implement that signal handlers are invoked with ZA and
   streaming mode disabled.
 - Use the RDSVL instruction introduced in EAC2 of the architecture to
   obtain the streaming mode vector length during enumeration, ZA state
   loading/saving and in test programs.
 - Store a pointer to SVCR in fpsimd_last_state and use it in fpsimd_save()
   for interoperation with KVM.
 - Add a test case sme_trap_no_sm checking that we generate a SIGILL
   when using an instruction that requires streaming mode without
   enabling it.
 - Add basic ZA context form validation to testcases helper library.
 - Move signal tests over to validating streaming VL from ZA information.
 - Pulled in patch removing ARRAY_SIZE() so that kselftest builds
   cleanly and to avoid trivial conflicts.
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

Mark Brown (38):
  arm64: cpufeature: Always specify and use a field width for
    capabilities
  arm64: Add feature detection for fine grained traps
  kselftest/arm64: Remove local ARRAY_SIZE() definitions
  arm64/sme: Provide ABI documentation for SME
  arm64/sme: System register and exception syndrome definitions
  arm64/sme: Manually encode SME instructions
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
  arm64/sme: Disable ZA and streaming mode when handling signals
  arm64/sme: Implement streaming SVE signal handling
  arm64/sme: Implement ZA signal handling
  arm64/sme: Implement ptrace support for streaming mode SVE registers
  arm64/sme: Add ptrace support for ZA
  arm64/sme: Disable streaming mode and ZA when flushing CPU state
  arm64/sme: Save and restore streaming mode over EFI runtime calls
  KVM: arm64: Hide SME system registers from guests
  KVM: arm64: Trap SME usage in guest
  KVM: arm64: Handle SME host state when running guests
  arm64/sme: Provide Kconfig for SME
  kselftest/arm64: sme: Add streaming SME support to vlset
  kselftest/arm64: Add tests for TPIDR2
  kselftest/arm64: Extend vector configuration API tests to cover SME
  kselftest/arm64: sme: Provide streaming mode SVE stress test
  kselftest/arm64: signal: Allow tests to be incompatible with features
  kselftest/arm64: signal: Handle ZA signal context in core code
  kselftest/arm64: Add stress test for SME ZA context switching
  kselftest/arm64: signal: Add SME signal handling tests
  kselftest/arm64: Add streaming SVE to SVE ptrace tests
  kselftest/arm64: Add coverage for the ZA ptrace interface
  kselftest/arm64: Add SME support to syscall ABI test

 Documentation/arm64/elf_hwcaps.rst            |  33 +
 Documentation/arm64/index.rst                 |   1 +
 Documentation/arm64/sme.rst                   | 432 +++++++++++++
 Documentation/arm64/sve.rst                   |  70 ++-
 arch/arm64/Kconfig                            |  11 +
 arch/arm64/include/asm/cpu.h                  |   4 +
 arch/arm64/include/asm/cpufeature.h           |  25 +
 arch/arm64/include/asm/el2_setup.h            |  64 +-
 arch/arm64/include/asm/esr.h                  |  13 +-
 arch/arm64/include/asm/exception.h            |   1 +
 arch/arm64/include/asm/fpsimd.h               | 110 +++-
 arch/arm64/include/asm/fpsimdmacros.h         |  86 +++
 arch/arm64/include/asm/hwcap.h                |   8 +
 arch/arm64/include/asm/kvm_arm.h              |   1 +
 arch/arm64/include/asm/kvm_host.h             |   4 +
 arch/arm64/include/asm/processor.h            |  18 +-
 arch/arm64/include/asm/sysreg.h               |  64 ++
 arch/arm64/include/asm/thread_info.h          |   2 +
 arch/arm64/include/uapi/asm/hwcap.h           |   8 +
 arch/arm64/include/uapi/asm/ptrace.h          |  69 ++-
 arch/arm64/include/uapi/asm/sigcontext.h      |  55 +-
 arch/arm64/kernel/cpufeature.c                | 284 +++++++--
 arch/arm64/kernel/cpuinfo.c                   |  13 +
 arch/arm64/kernel/entry-common.c              |  11 +
 arch/arm64/kernel/entry-fpsimd.S              |  36 ++
 arch/arm64/kernel/fpsimd.c                    | 585 ++++++++++++++++--
 arch/arm64/kernel/process.c                   |  28 +-
 arch/arm64/kernel/ptrace.c                    | 356 +++++++++--
 arch/arm64/kernel/signal.c                    | 194 +++++-
 arch/arm64/kernel/syscall.c                   |  34 +-
 arch/arm64/kernel/traps.c                     |   1 +
 arch/arm64/kvm/fpsimd.c                       |  45 +-
 arch/arm64/kvm/hyp/nvhe/switch.c              |  30 +
 arch/arm64/kvm/hyp/vhe/switch.c               |  10 +-
 arch/arm64/kvm/sys_regs.c                     |   9 +-
 arch/arm64/tools/cpucaps                      |   3 +
 include/uapi/linux/elf.h                      |   2 +
 include/uapi/linux/prctl.h                    |   9 +
 kernel/sys.c                                  |  12 +
 tools/testing/selftests/arm64/abi/.gitignore  |   1 +
 tools/testing/selftests/arm64/abi/Makefile    |   9 +-
 .../selftests/arm64/abi/syscall-abi-asm.S     |  69 ++-
 .../testing/selftests/arm64/abi/syscall-abi.c | 205 +++++-
 .../testing/selftests/arm64/abi/syscall-abi.h |  15 +
 tools/testing/selftests/arm64/abi/tpidr2.c    | 298 +++++++++
 tools/testing/selftests/arm64/fp/.gitignore   |   4 +
 tools/testing/selftests/arm64/fp/Makefile     |  12 +-
 tools/testing/selftests/arm64/fp/rdvl-sme.c   |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S       |   8 +
 tools/testing/selftests/arm64/fp/rdvl.h       |   1 +
 tools/testing/selftests/arm64/fp/ssve-stress  |  59 ++
 tools/testing/selftests/arm64/fp/sve-ptrace.c |  13 +-
 tools/testing/selftests/arm64/fp/sve-test.S   |  30 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c |  10 +
 tools/testing/selftests/arm64/fp/vlset.c      |  10 +-
 tools/testing/selftests/arm64/fp/za-ptrace.c  | 354 +++++++++++
 tools/testing/selftests/arm64/fp/za-stress    |  59 ++
 tools/testing/selftests/arm64/fp/za-test.S    | 426 +++++++++++++
 .../testing/selftests/arm64/signal/.gitignore |   2 +
 .../selftests/arm64/signal/test_signals.h     |   5 +
 .../arm64/signal/test_signals_utils.c         |  40 +-
 .../arm64/signal/test_signals_utils.h         |   2 +
 .../testcases/fake_sigreturn_sme_change_vl.c  |  92 +++
 .../arm64/signal/testcases/sme_trap_no_sm.c   |  38 ++
 .../signal/testcases/sme_trap_non_streaming.c |  45 ++
 .../arm64/signal/testcases/sme_trap_za.c      |  36 ++
 .../selftests/arm64/signal/testcases/sme_vl.c |  68 ++
 .../arm64/signal/testcases/ssve_regs.c        | 129 ++++
 .../arm64/signal/testcases/testcases.c        |  36 ++
 .../arm64/signal/testcases/testcases.h        |   3 +-
 70 files changed, 4590 insertions(+), 244 deletions(-)
 create mode 100644 Documentation/arm64/sme.rst
 create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi.h
 create mode 100644 tools/testing/selftests/arm64/abi/tpidr2.c
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sme.c
 create mode 100644 tools/testing/selftests/arm64/fp/ssve-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-ptrace.c
 create mode 100644 tools/testing/selftests/arm64/fp/za-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-test.S
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_no_sm.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_non_streaming.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_za.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.30.2

