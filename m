Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053A8432720
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRTMP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRTMO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C6AC6128A;
        Mon, 18 Oct 2021 19:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584203;
        bh=XEJEFu7z3tIrJNxhbBWitQuj0jN4IBcH/SsspJ6IX5M=;
        h=From:To:Cc:Subject:Date:From;
        b=d9rcxpOIrZEtrWxq1lgaSJpIqmMUur2YezpHoh3p/rh9hWYijAO0XREPHp7RXTuLG
         CCKCOAemcccevrKH+ZRVb5oScy7+hg4DUlhlqv/mkk1mGMdyG8smEtfeeXQDXv1mWE
         6l7NUQY+EeC/WKpA3rMnIqaws/hx5AiVsniXrfyxOLlUYAFCHbEMHktIkH8wLW9LdB
         b76nLm6jyu7guYwKnOSB0z0tVjTX6fDDMGugBY7QjHWaX9tNwBbHJeEuVBtr8pJPYg
         yvisDySpAuUtkCUo26QmomrSr6plk8Cr5BF8MtXY8Bt8LIYitoCHBf1jyI2IgR1297
         05S2CQayFCQ2w==
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
Subject: [PATCH v2 00/42] arm64/sme: Initial support for the Scalable Matrix Extension
Date:   Mon, 18 Oct 2021 20:08:16 +0100
Message-Id: <20211018190858.2119209-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11533; h=from:subject; bh=XEJEFu7z3tIrJNxhbBWitQuj0jN4IBcH/SsspJ6IX5M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcYn4DJzE8dtRO+VbDzDfECcyVTGJ2B0RFLl2Cju neCJ/xSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GJwAKCRAk1otyXVSH0MQqB/ 9Q9QjlEZB/hEHyd/yjWYY6U+DU4k0aQF4SQHPnRaPSjTbkohewPDBcj5GsvYI41+3RX6ZNgrzBzTqU mynSmlizTK2153CZEIXqIGPxa5nJvDWSWu2QRQuycNQgyDV87tMz/ZCIWTRBqGg1YrjwvzK3HMn9TS lqoo9gskC4+B2ec7ubYTVUWbl7tEQJDD10SZ+w4Hv0oYYeHDp5CvrDZSVHQ6Pqb7WYW4z/XEFRhfLW cEH7AlQb9phYyvQlHcnhfV7OrYRksiCOyMd66F/3OVL3QbWcSuwlYwgUcVXnz/lLA3SZsSoQtYd58v h+ciGy9hFswo6Q8FZ1zKXft/J0RMBR
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

Due to dependencies on kselftest changes already upstreamed this series
is based on for-next/kselftest in the arm64 tree.

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

Mark Brown (42):
  arm64/fp: Reindent fpsimd_save()
  arm64/sve: Remove sve_load_from_fpsimd_state()
  arm64/sve: Make sve_state_size() static
  arm64/sve: Make access to FFR optional
  arm64/sve: Rename find_supported_vector_length()
  arm64/sve: Use accessor functions for vector lengths in thread_struct
  arm64/sve: Put system wide vector length information into structs
  arm64/sve: Explicitly load vector length when restoring SVE state
  arm64/sve: Track vector lengths for tasks in an array
  arm64/sve: Make sysctl interface for SVE reusable by SME
  arm64/sve: Generalise vector length configuration prctl() for SME
  kselftest/arm64: Parameterise ptrace vector length information
  kselftest/arm64: Allow signal tests to trigger from a function
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

 Documentation/arm64/elf_hwcaps.rst            |  29 +
 Documentation/arm64/index.rst                 |   1 +
 Documentation/arm64/sme.rst                   | 428 +++++++++
 Documentation/arm64/sve.rst                   |  69 +-
 arch/arm64/Kconfig                            |  11 +
 arch/arm64/include/asm/cpu.h                  |   4 +
 arch/arm64/include/asm/cpufeature.h           |  18 +
 arch/arm64/include/asm/el2_setup.h            |  36 +
 arch/arm64/include/asm/esr.h                  |  13 +-
 arch/arm64/include/asm/exception.h            |   1 +
 arch/arm64/include/asm/fpsimd.h               | 222 ++++-
 arch/arm64/include/asm/fpsimdmacros.h         |  94 +-
 arch/arm64/include/asm/hwcap.h                |   7 +
 arch/arm64/include/asm/kvm_arm.h              |   1 +
 arch/arm64/include/asm/processor.h            |  67 +-
 arch/arm64/include/asm/sysreg.h               |  53 +
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   7 +
 arch/arm64/include/uapi/asm/ptrace.h          |  69 +-
 arch/arm64/include/uapi/asm/sigcontext.h      |  55 +-
 arch/arm64/kernel/cpufeature.c                |  96 +-
 arch/arm64/kernel/cpuinfo.c                   |  12 +
 arch/arm64/kernel/entry-common.c              |  10 +
 arch/arm64/kernel/entry-fpsimd.S              |  63 +-
 arch/arm64/kernel/fpsimd.c                    | 904 ++++++++++++++----
 arch/arm64/kernel/process.c                   |  28 +-
 arch/arm64/kernel/ptrace.c                    | 358 ++++++-
 arch/arm64/kernel/signal.c                    | 189 +++-
 arch/arm64/kernel/syscall.c                   |  43 +-
 arch/arm64/kernel/traps.c                     |   1 +
 arch/arm64/kvm/fpsimd.c                       |   3 +-
 arch/arm64/kvm/hyp/fpsimd.S                   |   6 +-
 arch/arm64/kvm/reset.c                        |  14 +-
 arch/arm64/tools/cpucaps                      |   1 +
 include/uapi/linux/elf.h                      |   2 +
 include/uapi/linux/prctl.h                    |   9 +
 kernel/sys.c                                  |  12 +
 tools/include/nolibc/nolibc.h                 |  18 +
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/abi/.gitignore  |   1 +
 tools/testing/selftests/arm64/abi/Makefile    |  13 +
 tools/testing/selftests/arm64/abi/tpidr2.c    | 298 ++++++
 tools/testing/selftests/arm64/fp/.gitignore   |   4 +
 tools/testing/selftests/arm64/fp/Makefile     |  12 +-
 tools/testing/selftests/arm64/fp/rdvl-sme.c   |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S       |  16 +
 tools/testing/selftests/arm64/fp/rdvl.h       |   1 +
 tools/testing/selftests/arm64/fp/ssve-stress  |  59 ++
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 230 +++--
 tools/testing/selftests/arm64/fp/sve-test.S   |  30 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c |  10 +
 tools/testing/selftests/arm64/fp/vlset.c      |  10 +-
 tools/testing/selftests/arm64/fp/za-ptrace.c  | 353 +++++++
 tools/testing/selftests/arm64/fp/za-stress    |  59 ++
 tools/testing/selftests/arm64/fp/za-test.S    | 582 +++++++++++
 .../testing/selftests/arm64/signal/.gitignore |   2 +
 .../selftests/arm64/signal/test_signals.h     |   2 +
 .../arm64/signal/test_signals_utils.c         |   5 +-
 .../testcases/fake_sigreturn_sme_change_vl.c  |  92 ++
 .../arm64/signal/testcases/sme_trap_za.c      |  36 +
 .../selftests/arm64/signal/testcases/sme_vl.c |  70 ++
 .../arm64/signal/testcases/ssve_regs.c        | 129 +++
 62 files changed, 4573 insertions(+), 415 deletions(-)
 create mode 100644 Documentation/arm64/sme.rst
 create mode 100644 tools/testing/selftests/arm64/abi/.gitignore
 create mode 100644 tools/testing/selftests/arm64/abi/Makefile
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


base-commit: 0ba1ce1e86052deea3f115285802ce8ffff3b152
-- 
2.30.2

