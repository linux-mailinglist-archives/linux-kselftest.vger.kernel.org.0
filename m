Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8C258B79
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIAJ1g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 05:27:36 -0400
Received: from foss.arm.com ([217.140.110.172]:39126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIAJ1f (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 05:27:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C8021045;
        Tue,  1 Sep 2020 02:27:34 -0700 (PDT)
Received: from a077416.arm.com (unknown [10.57.6.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 071983F71F;
        Tue,  1 Sep 2020 02:27:31 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH 0/6] kselftest: arm64/mte: Tests for user-space MTE
Date:   Tue,  1 Sep 2020 14:57:13 +0530
Message-Id: <20200901092719.9918-1-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These patch series adds below kselftests to test the user-space support for the
ARMv8.5 Memory Tagging Extension present in arm64 tree [1].

1) This test-case verifies that the memory allocated by kernel mmap interface
can support tagged memory access. It first checks the presence of tags at
address[56:59] and then proceeds with read and write. The pass criteria for
this test is that tag fault exception should not happen.

2) This test-case crosses the valid memory to the invalid memory. In this
memory area valid tags are not inserted so read and write should not pass. The
pass criteria for this test is that tag fault exception should happen for all
the illegal addresses. This test also verfies that PSTATE.TCO works properly.

3) This test-case verifies that the memory inherited by child process from
parent process should have same tags copied. The pass criteria for this test is
that tag fault exception should not happen.

4) This test checks different mmap flags with PROT_MTE memory protection.

5) This testcase checks that KSM should not merge pages containing different
MTE tag values. However, if the tags are same then the pages may merge. This
testcase uses the generic ksm sysfs interfaces to verify the MTE behaviour, so
this testcase is not fullproof and may be impacted due to other load in the system.

6) Fifth test verifies that syscalls read/write etc works by considering that
user pointer has valid/invalid allocation tags.

To simplify the testing, a copy of the patchset on top of a recent linux
tree can be found at [2].


Thanks,
Amit Daniel

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/mte
[2]: http://linux-arm.org/git?p=linux-ak.git;a=shortlog;h=refs/heads/kselftest-mte-mainline-v1


Amit Daniel Kachhap (6):
  kselftest/arm64: Add utilities and a test to validate mte memory
  kselftest/arm64: Verify mte tag inclusion via prctl
  kselftest/arm64: Check forked child mte memory accessibility
  kselftest/arm64: Verify all different mmap MTE options
  kselftest/arm64: Verify KSM page merge for MTE pages
  kselftest/arm64: Check mte tagged user address in kernel

 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/mte/.gitignore  |   6 +
 tools/testing/selftests/arm64/mte/Makefile    |  29 ++
 .../selftests/arm64/mte/check_buffer_fill.c   | 476 ++++++++++++++++++
 .../selftests/arm64/mte/check_child_memory.c  | 195 +++++++
 .../selftests/arm64/mte/check_ksm_options.c   | 131 +++++
 .../selftests/arm64/mte/check_mmap_options.c  | 262 ++++++++++
 .../arm64/mte/check_tags_inclusion.c          | 183 +++++++
 .../selftests/arm64/mte/check_user_mem.c      | 118 +++++
 .../selftests/arm64/mte/mte_common_util.c     | 374 ++++++++++++++
 .../selftests/arm64/mte/mte_common_util.h     | 135 +++++
 tools/testing/selftests/arm64/mte/mte_def.h   |  26 +
 .../testing/selftests/arm64/mte/mte_helper.S  | 116 +++++
 13 files changed, 2052 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/mte/.gitignore
 create mode 100644 tools/testing/selftests/arm64/mte/Makefile
 create mode 100644 tools/testing/selftests/arm64/mte/check_buffer_fill.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_child_memory.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_ksm_options.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_mmap_options.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_tags_inclusion.c
 create mode 100644 tools/testing/selftests/arm64/mte/check_user_mem.c
 create mode 100644 tools/testing/selftests/arm64/mte/mte_common_util.c
 create mode 100644 tools/testing/selftests/arm64/mte/mte_common_util.h
 create mode 100644 tools/testing/selftests/arm64/mte/mte_def.h
 create mode 100644 tools/testing/selftests/arm64/mte/mte_helper.S

-- 
2.17.1

