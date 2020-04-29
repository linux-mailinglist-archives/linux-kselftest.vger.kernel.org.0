Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C51BDA94
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Apr 2020 13:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD2L3A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Apr 2020 07:29:00 -0400
Received: from foss.arm.com ([217.140.110.172]:37490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2L3A (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Apr 2020 07:29:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CFAC1063;
        Wed, 29 Apr 2020 04:28:59 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5775D3F73D;
        Wed, 29 Apr 2020 04:28:58 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/4] kselftest: Extend vDSO tests
Date:   Wed, 29 Apr 2020 12:28:30 +0100
Message-Id: <20200429112834.24908-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series extends the kselftests for the vDSO library making sure: that
they compile correctly on non x86 platforms, that they can be cross
compiled and introducing new tests that verify the correctness of the
library.

The so extended vDSO kselftests have been verified on all the platforms
supported by the unified vDSO library [1].

The only new patch that this series introduces is the first one, patch 2 and
patch 3 have already been reviewed in past as part of other series [2] [3].

[1] https://lore.kernel.org/lkml/20190621095252.32307-1-vincenzo.frascino@arm.com
[2] https://lore.kernel.org/lkml/20190621095252.32307-26-vincenzo.frascino@arm.com
[3] https://lore.kernel.org/lkml/20190523112116.19233-4-vincenzo.frascino@arm.com

Changes:
--------
v2:
  - Addressed review comments from Andy.
  - Rebased on 5.7-rc3.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (4):
  kselftest: Enable vDSO test on non x86 platforms
  kselftest: Extend vDSO selftest
  kselftest: Extend vDSO selftest to clock_getres
  kselftest: Move test_vdso to the vDSO test suite

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/vDSO/Makefile         |  16 +-
 .../selftests/vDSO/vdso_clock_getres.c        | 124 +++++++++
 tools/testing/selftests/vDSO/vdso_config.h    |  90 +++++++
 .../vdso_correctness_test_x86.c}              |   0
 tools/testing/selftests/vDSO/vdso_full_test.c | 244 ++++++++++++++++++
 tools/testing/selftests/x86/Makefile          |   2 +-
 7 files changed, 472 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_config.h
 rename tools/testing/selftests/{x86/test_vdso.c => vDSO/vdso_correctness_test_x86.c} (100%)
 create mode 100644 tools/testing/selftests/vDSO/vdso_full_test.c

-- 
2.25.2

