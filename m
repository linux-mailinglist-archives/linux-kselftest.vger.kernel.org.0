Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2584C41E0B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353166AbhI3SRU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353145AbhI3SRU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BAC5619E5;
        Thu, 30 Sep 2021 18:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025737;
        bh=ygOFkF2dZYlZeE1AT9KvqNAJVuoLO4kL/pCf2qbAIYY=;
        h=From:To:Cc:Subject:Date:From;
        b=enpgq3mwf0VnBnjEZSMNUIXKTNFGsQ+B9BcOrcNLeSq5XqfDur5cBP5JPVYu4Bnmm
         8fTBSulP8wncZ3M+d4NIFPfsYgH0XadZqE1sKoiU4+aVnUKvF2wDtcIAY6CGoArJNj
         HeZ7C6X8x/xob6cknpaYDpi6L3g2sdD+v4rz/MLFOfXw06uExFV1H0YUSU8qnhRL2Q
         cyM9IxF17BcCSRV6sPb4xNCLe3uNCTFNWQ7xT++1T3aZjC6IDpsdJiy5ztRvynKnIs
         2ViNGCwhTh7zkqhAQD2lTJG95zmnx6JLWqSn2nn6RIA00ZQ5Uqi5NpxR3Xov34vm//
         wAGKq+D70M8rw==
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
Subject: [PATCH v1 00/38] arm64/sme: Initial support for the Scalable Matrix Extension
Date:   Thu, 30 Sep 2021 19:11:06 +0100
Message-Id: <20210930181144.10029-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10048; h=from:subject; bh=ygOFkF2dZYlZeE1AT9KvqNAJVuoLO4kL/pCf2qbAIYY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3B1tNlfdmfqq4ZVaCElHNgCi9tL7h9sQQKdGIa f/LMSUuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9wQAKCRAk1otyXVSH0HYEB/ oCCa8WrLhOi/oaZAZ172YODR/P5cjkvTthwD6W0Nm79cF1S2cllZnAbll2QpPcoUVH95FNz/NqicEP 8GAyseMvqcMZOgKrZPTvG2iMikreTIsiELaQOb7+0ah8r0EM600Xh6OoDeyyB09z1ha7gFETo0i1oy QKHaU6zFC2Lnjiz6LWVt56WsoBRuIjviXdhHFzpvdtIIgkKcxUyv3P6aq/U2NnfgvDKIQYwIUpYhbt rdfrtqfu7rlB3WTDuWJuG9Y+HoYsxemGlkVbbpGF36v1rB1hk0qZtWvmQnwx320SFfZnGX82KYcdyZ rM/zyM/xlIX1lGZ5dvXSAOezSwEvMc
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

 - KVM is not currently supported and we depend on !KVM, in hopefully
   the next version I will add support for coexisting with KVM and then
   in a subsequent series implement real support for KVM guests.
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

[1] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/scalable-matrix-extension-armv9-a-architecture

Mark Brown (38):
  arm64/fp: Reindent fpsimd_save()
  arm64/sve: Remove sve_load_from_fpsimd_state()
  arm64/sve: Make access to FFR optional
  arm64/sve: Rename find_supported_vector_length()
  arm64/sve: Use accessor functions for vector lengths in thread_struct
  arm64/sve: Put system wide vector length information into structs
  arm64/sve: Explicitly load vector length when restoring SVE state
  arm64/sve: Track vector lengths for tasks in an array
  arm64/sve: Make sysctl interface for SVE reusable by SME
  arm64/sve: Generalise vector length configuration prctl() for SME
  selftests: arm64: Parameterise ptrace vector length information
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
  kselftest/arm64: Add tests for TPIDR2
  kselftest/arm64: Extend vector configuration API tests to cover SME
  kselftest/arm64: sme: Provide streaming mode SVE stress test
  kselftest/arm64: Add stress test for SME ZA context switching
  kselftest/arm64: signal: Add SME signal handling tests
  selftests: arm64: Add streaming SVE to SVE ptrace tests
  selftests: arm64: Add coverage for the ZA ptrace interface

 Documentation/arm64/elf_hwcaps.rst            |  29 +
 Documentation/arm64/index.rst                 |   1 +
 Documentation/arm64/sme.rst                   | 427 +++++++++
 Documentation/arm64/sve.rst                   |  62 +-
 arch/arm64/Kconfig                            |  11 +
 arch/arm64/include/asm/cpu.h                  |   4 +
 arch/arm64/include/asm/cpufeature.h           |  18 +
 arch/arm64/include/asm/el2_setup.h            |  36 +
 arch/arm64/include/asm/esr.h                  |   3 +-
 arch/arm64/include/asm/exception.h            |   1 +
 arch/arm64/include/asm/fpsimd.h               | 178 +++-
 arch/arm64/include/asm/fpsimdmacros.h         |  94 +-
 arch/arm64/include/asm/hwcap.h                |   7 +
 arch/arm64/include/asm/kvm_arm.h              |   1 +
 arch/arm64/include/asm/processor.h            |  67 +-
 arch/arm64/include/asm/sysreg.h               |  53 ++
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   7 +
 arch/arm64/include/uapi/asm/ptrace.h          |  69 +-
 arch/arm64/include/uapi/asm/sigcontext.h      |  55 +-
 arch/arm64/kernel/cpufeature.c                |  96 +-
 arch/arm64/kernel/cpuinfo.c                   |  12 +
 arch/arm64/kernel/entry-common.c              |  10 +
 arch/arm64/kernel/entry-fpsimd.S              |  63 +-
 arch/arm64/kernel/fpsimd.c                    | 900 ++++++++++++++----
 arch/arm64/kernel/process.c                   |  19 +-
 arch/arm64/kernel/ptrace.c                    | 358 ++++++-
 arch/arm64/kernel/signal.c                    | 189 +++-
 arch/arm64/kernel/syscall.c                   |  49 +-
 arch/arm64/kernel/traps.c                     |   1 +
 arch/arm64/kvm/fpsimd.c                       |   3 +-
 arch/arm64/kvm/hyp/fpsimd.S                   |   6 +-
 arch/arm64/kvm/reset.c                        |  14 +-
 arch/arm64/tools/cpucaps                      |   1 +
 include/uapi/linux/elf.h                      |   2 +
 include/uapi/linux/prctl.h                    |   9 +
 kernel/sys.c                                  |   6 +
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/abi/.gitignore  |   1 +
 tools/testing/selftests/arm64/abi/Makefile    |  13 +
 tools/testing/selftests/arm64/abi/tpidr2.c    | 204 ++++
 tools/testing/selftests/arm64/fp/.gitignore   |   4 +
 tools/testing/selftests/arm64/fp/Makefile     |  12 +-
 tools/testing/selftests/arm64/fp/rdvl-sme.c   |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S       |  16 +
 tools/testing/selftests/arm64/fp/rdvl.h       |   1 +
 tools/testing/selftests/arm64/fp/ssve-stress  |  59 ++
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 203 ++--
 tools/testing/selftests/arm64/fp/sve-test.S   |  30 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c |  10 +
 tools/testing/selftests/arm64/fp/za-ptrace.c  | 353 +++++++
 tools/testing/selftests/arm64/fp/za-stress    |  59 ++
 tools/testing/selftests/arm64/fp/za-test.S    | 545 +++++++++++
 .../testing/selftests/arm64/signal/.gitignore |   2 +
 .../selftests/arm64/signal/test_signals.h     |   2 +
 .../arm64/signal/test_signals_utils.c         |   3 +
 .../testcases/fake_sigreturn_sme_change_vl.c  |  92 ++
 .../selftests/arm64/signal/testcases/sme_vl.c |  70 ++
 .../arm64/signal/testcases/ssve_regs.c        | 129 +++
 59 files changed, 4293 insertions(+), 396 deletions(-)
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
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c


base-commit: 8694e5e6388695195a32bd5746635ca166a8df56
-- 
2.20.1

