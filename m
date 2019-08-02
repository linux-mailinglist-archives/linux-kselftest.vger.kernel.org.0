Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B27FF1C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2019 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391095AbfHBRDd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Aug 2019 13:03:33 -0400
Received: from foss.arm.com ([217.140.110.172]:55008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391092AbfHBRDd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Aug 2019 13:03:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6724344;
        Fri,  2 Aug 2019 10:03:30 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFAC53F575;
        Fri,  2 Aug 2019 10:03:29 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com
Subject: [PATCH v3 00/11] Add arm64/signal initial kselftest support
Date:   Fri,  2 Aug 2019 18:02:49 +0100
Message-Id: <20190802170300.20662-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

this patchset aims to add the initial arch-specific arm64 support to
kselftest starting with signals-related test-cases.
A common internal test-case layout is proposed which then it is anyway
wired-up to the toplevel kselftest Makefile, so that it should be possible
at the end to run it on an arm64 target in the usual way with KSFT.

~/linux# make TARGETS=arm64 kselftest

New KSFT arm64 testcases live inside tools/testing/selftests/arm64 grouped by
family inside subdirectories: arm64/signal is the first family proposed with
this series. arm64/signal tests can be run via KSFT or standalone.

Thanks

Cristian


Notes:
-----
- further details in the included READMEs

- more tests still to be written (current strategy is going through the related
  Kernel signal-handling code and write a test for each possible and sensible code-path)
  A few ideas in testcases/TODO.readme

- a bit of overlap around KSFT arm64/ Makefiles is expected with this:
  https://lore.kernel.org/linux-arm-kernel/c1e6aad230658bc175b42d92daeff2e30050302a.1563904656.git.andreyknvl@google.com/


Changes:
--------

 v2-->v3:
 - rebased on v5.3-rc2
 - better test result characterization looking for
   SEGV_ACCERR in si_code on SIGSEGV
 - using KSFT Framework macros for retvalues
 - removed SAFE_WRITE()/dump_uc: buggy, un-needed and unused
 - reviewed generation process of test_arm64_signals.sh runner script
 - re-added a fixed fake_sigreturn_misaligned_sp testcase and a properly
   extended fake_sigreturn() helper
 - added tests' TODO notes


 v1-->v2:
- rebased on 5.2-rc7
- various makefile's cleanups
- mixed READMEs fixes
- fixed test_arm64_signals.sh runner script
- cleaned up assembly code in signal.S
- improved get_current_context() logic
- fixed SAFE_WRITE()
- common support code splitted into more chunks, each one introduced when
  needed by some new testcases
- fixed some headers validation routines in testcases.c
- removed some still broken/immature tests:
  + fake_sigreturn_misaligned
  + fake_sigreturn_overflow_reserved
  + mangle_pc_invalid
  + mangle_sp_misaligned
- fixed some other testcases:
  + mangle_pstate_ssbs_regs: better checks of SSBS bit when feature unsupported
  + mangle_pstate_invalid_compat_toggle: name fix
  + mangle_pstate_invalid_mode_el[1-3]: precautionary zeroing PSTATE.MODE
  + fake_sigreturn_bad_magic, fake_sigreturn_bad_size,
    fake_sigreturn_bad_size_for_magic0:
    - accounting for available space...dropping extra when needed
    - keeping alignent
- new testcases on FPSMID context:
  + fake_sigreturn_missing_fpsimd
  + fake_sigreturn_duplicated_fpsimd


Cristian Marussi (11):
  kselftest: arm64: introduce new boilerplate code
  kselftest: arm64: adds first test and common utils
  kselftest: arm64: mangle_pstate_invalid_daif_bits
  kselftest: arm64: mangle_pstate_invalid_mode_el
  kselftest: arm64: mangle_pstate_ssbs_regs
  kselftest: arm64: fake_sigreturn_bad_magic
  kselftest: arm64: fake_sigreturn_bad_size_for_magic0
  kselftest: arm64: fake_sigreturn_missing_fpsimd
  kselftest: arm64: fake_sigreturn_duplicated_fpsimd
  kselftest: arm64: fake_sigreturn_bad_size
  kselftest: arm64: fake_sigreturn_misaligned_sp

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/arm64/Makefile        |  51 +++
 tools/testing/selftests/arm64/README          |  43 +++
 .../testing/selftests/arm64/signal/.gitignore |   6 +
 tools/testing/selftests/arm64/signal/Makefile |  88 +++++
 tools/testing/selftests/arm64/signal/README   |  59 +++
 .../testing/selftests/arm64/signal/signals.S  |  73 ++++
 .../arm64/signal/test_arm64_signals.src_shell |  55 +++
 .../selftests/arm64/signal/test_signals.c     |  26 ++
 .../selftests/arm64/signal/test_signals.h     | 141 +++++++
 .../arm64/signal/test_signals_utils.c         | 354 ++++++++++++++++++
 .../arm64/signal/test_signals_utils.h         |  16 +
 .../arm64/signal/testcases/.gitignore         |  11 +
 .../arm64/signal/testcases/TODO.readme        |   7 +
 .../testcases/fake_sigreturn_bad_magic.c      |  63 ++++
 .../testcases/fake_sigreturn_bad_size.c       |  85 +++++
 .../fake_sigreturn_bad_size_for_magic0.c      |  57 +++
 .../fake_sigreturn_duplicated_fpsimd.c        |  62 +++
 .../testcases/fake_sigreturn_misaligned_sp.c  |  30 ++
 .../testcases/fake_sigreturn_missing_fpsimd.c |  44 +++
 .../mangle_pstate_invalid_compat_toggle.c     |  25 ++
 .../mangle_pstate_invalid_daif_bits.c         |  28 ++
 .../mangle_pstate_invalid_mode_el1.c          |  29 ++
 .../mangle_pstate_invalid_mode_el2.c          |  29 ++
 .../mangle_pstate_invalid_mode_el3.c          |  29 ++
 .../testcases/mangle_pstate_ssbs_regs.c       |  56 +++
 .../arm64/signal/testcases/testcases.c        | 150 ++++++++
 .../arm64/signal/testcases/testcases.h        |  83 ++++
 28 files changed, 1701 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100644 tools/testing/selftests/arm64/README
 create mode 100644 tools/testing/selftests/arm64/signal/.gitignore
 create mode 100644 tools/testing/selftests/arm64/signal/Makefile
 create mode 100644 tools/testing/selftests/arm64/signal/README
 create mode 100644 tools/testing/selftests/arm64/signal/signals.S
 create mode 100755 tools/testing/selftests/arm64/signal/test_arm64_signals.src_shell
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals.c
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals.h
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.c
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.h
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/.gitignore
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/TODO.readme
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_missing_fpsimd.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_compat_toggle.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.h

-- 
2.17.1

