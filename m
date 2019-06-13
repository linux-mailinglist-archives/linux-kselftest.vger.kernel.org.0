Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913CA43BA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfFMPag (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:30:36 -0400
Received: from foss.arm.com ([217.140.110.172]:38050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfFMLON (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 07:14:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28B34367;
        Thu, 13 Jun 2019 04:14:12 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A45D73F694;
        Thu, 13 Jun 2019 04:15:54 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com, andreyknvl@google.com
Subject: [PATCH 00/13] Add arm64/signal initial kselftest support
Date:   Thu, 13 Jun 2019 12:13:22 +0100
Message-Id: <20190613111335.7645-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

this patch aims to add the initial arch-specific arm64 support to
kselftest starting with signals-related test-cases.
A common internal test-case layout is proposed which then it is
anyway wired-up to the toplevel kselftest Makefile, so that it
should be possible at the end to run it on an arm64 target in the
usual way with KSFT.

~/linux# make TARGETS=arm64 kselftest

Notes:
-----
- further details in the included READMEs

- more tests still to be written (current strategy is going through the related
  Kernel signal-handling code and write a test for each possible and sensible code-path)

- a bit of overlap around KSFT arm64/ Makefiles is expected with this recently
  proposed patch-series:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2019-June/659432.html


Cristian Marussi (13):
  kselftest: arm64: introduce new boilerplate code
  kselftest: arm64: adds arm64/signal support code
  kselftest: arm64: mangle_sp_misaligned
  kselftest: arm64: mangle_pc_invalid
  kselftest: arm64: mangle_pstate_invalid_daif_bits
  kselftest: arm64: mangle_pstate_invalid_state_toggle
  kselftest: arm64: mangle_pstate_invalid_mode_el?
  kselftest: arm64: mangle_pstate_ssbs_regs
  kselftest: arm64: fake_sigreturn_misaligned
  kselftest: arm64: fake_sigreturn_bad_magic
  kselftest: arm64: fake_sigreturn_bad_size
  kselftest: arm64: fake_sigreturn_bad_size_for_magic0
  kselftest: arm64: fake_sigreturn_overflow_reserved

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/arm64/Makefile        |  51 ++++
 tools/testing/selftests/arm64/README          |  44 +++
 .../testing/selftests/arm64/signal/.gitignore |   5 +
 tools/testing/selftests/arm64/signal/Makefile |  86 ++++++
 tools/testing/selftests/arm64/signal/README   |  56 ++++
 .../testing/selftests/arm64/signal/signals.S  |  64 +++++
 .../arm64/signal/test_arm64_signals.sh        |  44 +++
 .../selftests/arm64/signal/test_signals.c     |  30 ++
 .../selftests/arm64/signal/test_signals.h     | 136 ++++++++++
 .../arm64/signal/test_signals_utils.c         | 256 ++++++++++++++++++
 .../arm64/signal/test_signals_utils.h         | 110 ++++++++
 .../arm64/signal/testcases/.gitignore         |  13 +
 .../testcases/fake_sigreturn_bad_magic.c      |  42 +++
 .../testcases/fake_sigreturn_bad_size.c       |  40 +++
 .../fake_sigreturn_bad_size_for_magic0.c      |  44 +++
 .../testcases/fake_sigreturn_misaligned.c     |  30 ++
 .../fake_sigreturn_overflow_reserved.c        |  48 ++++
 .../signal/testcases/mangle_pc_invalid.c      |  24 ++
 .../mangle_pstate_invalid_daif_bits.c         |  25 ++
 .../mangle_pstate_invalid_mode_el1.c          |  25 ++
 .../mangle_pstate_invalid_mode_el2.c          |  25 ++
 .../mangle_pstate_invalid_mode_el3.c          |  25 ++
 .../mangle_pstate_invalid_state_toggle.c      |  25 ++
 .../testcases/mangle_pstate_ssbs_regs.c       |  41 +++
 .../signal/testcases/mangle_sp_misaligned.c   |  24 ++
 .../arm64/signal/testcases/testcases.c        | 123 +++++++++
 .../arm64/signal/testcases/testcases.h        |  85 ++++++
 28 files changed, 1522 insertions(+)
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
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_overflow_reserved.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pc_invalid.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_state_toggle.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_sp_misaligned.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.h

-- 
2.17.1

