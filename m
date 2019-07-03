Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97D25E93F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCQgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 12:36:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCQgO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 12:36:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D702344;
        Wed,  3 Jul 2019 09:36:13 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F2F23F718;
        Wed,  3 Jul 2019 09:36:12 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com, andreyknvl@google.com
Subject: [PATCH v2 00/10] Add arm64/signal initial kselftest support
Date:   Wed,  3 Jul 2019 17:35:22 +0100
Message-Id: <20190703163532.7485-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

this patchset aims to add the initial arch-specific arm64 support to
kselftest starting with signals-related test-cases.
A common internal test-case layout is proposed which then it is
anyway wired-up to the toplevel kselftest Makefile, so that it
should be possible at the end to run it on an arm64 target in the
usual way with KSFT.

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

- a bit of overlap around KSFT arm64/ Makefiles is expected with this recently
  proposed patch-series:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2019-June/659432.html


Changes:
--------

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


Cristian Marussi (10):
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

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/arm64/Makefile        |  51 +++
 tools/testing/selftests/arm64/README          |  43 +++
 .../testing/selftests/arm64/signal/.gitignore |   5 +
 tools/testing/selftests/arm64/signal/Makefile |  86 +++++
 tools/testing/selftests/arm64/signal/README   |  59 ++++
 .../testing/selftests/arm64/signal/signals.S  |  64 ++++
 .../arm64/signal/test_arm64_signals.sh        |  55 +++
 .../selftests/arm64/signal/test_signals.c     |  26 ++
 .../selftests/arm64/signal/test_signals.h     | 141 ++++++++
 .../arm64/signal/test_signals_utils.c         | 331 ++++++++++++++++++
 .../arm64/signal/test_signals_utils.h         |  31 ++
 .../arm64/signal/testcases/.gitignore         |  11 +
 .../testcases/fake_sigreturn_bad_magic.c      |  63 ++++
 .../testcases/fake_sigreturn_bad_size.c       |  85 +++++
 .../fake_sigreturn_bad_size_for_magic0.c      |  57 +++
 .../fake_sigreturn_duplicated_fpsimd.c        |  62 ++++
 .../testcases/fake_sigreturn_missing_fpsimd.c |  44 +++
 .../mangle_pstate_invalid_compat_toggle.c     |  25 ++
 .../mangle_pstate_invalid_daif_bits.c         |  28 ++
 .../mangle_pstate_invalid_mode_el1.c          |  29 ++
 .../mangle_pstate_invalid_mode_el2.c          |  29 ++
 .../mangle_pstate_invalid_mode_el3.c          |  29 ++
 .../testcases/mangle_pstate_ssbs_regs.c       |  56 +++
 .../arm64/signal/testcases/testcases.c        | 150 ++++++++
 .../arm64/signal/testcases/testcases.h        |  83 +++++
 26 files changed, 1644 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100644 tools/testing/selftests/arm64/README
 create mode 100644 tools/testing/selftests/arm64/signal/.gitignore
 create mode 100644 tools/testing/selftests/arm64/signal/Makefile
 create mode 100644 tools/testing/selftests/arm64/signal/README
 create mode 100644 tools/testing/selftests/arm64/signal/signals.S
 create mode 100755 tools/testing/selftests/arm64/signal/test_arm64_signals.sh
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals.c
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals.h
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.c
 create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.h
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/.gitignore
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
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

