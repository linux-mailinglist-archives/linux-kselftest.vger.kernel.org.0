Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F3975ED6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGXIZi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGXIZg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 04:25:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 521D01AD;
        Mon, 24 Jul 2023 01:25:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7F22DE0;
        Mon, 24 Jul 2023 01:26:15 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12A4C3F67D;
        Mon, 24 Jul 2023 01:25:30 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Mark Brown" <broonie@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Florent Revest" <revest@chromium.org>,
        "Peter Xu" <peterx@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/8] selftests/mm fixes for arm64
Date:   Mon, 24 Jul 2023 09:25:14 +0100
Message-Id: <20230724082522.1202616-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi All,

This is v3 of my series to clean up mm selftests so that they run correctly on
arm64. See [1] for full explanation.

Only patch 6 has changed vs v2. The rest are the same and already carry
reviewed/acked-bys. So I'm hoping I can get the final patch reviewed and this
series is hopefully then good enough to merge?

Changes Since v2 [2]
--------------------

  - Patch 6: Change approach to cleaning up child processes; Use "parent death
    signal", as suggested by David.
  - Added Reviewed-by/Acked-by tags: thanks to David, Mark and Peter!

Changes Since v1 [1]
--------------------

  - Patch 1: Explicitly set line buffer mode in ksft_print_header()
  - Dropped v1 patch 2 (set execute permissions): Andrew has taken this into his
    branch separately.
  - Patch 2: Don't compile `soft-dirty` suite for arm64 instead of skipping it
    at runtime.
  - Patch 2: Declare fewer tests and skip all of test_softdirty() if soft-dirty
    is not supported, rather than conditionally marking each check as skipped.
  - Added Reviewed-by tags: thanks DavidH!
  - Patch 8: Clarified commit message.


[1] https://lore.kernel.org/linux-mm/20230713135440.3651409-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230717103152.202078-1-ryan.roberts@arm.com/

Thanks,
Ryan


Ryan Roberts (8):
  selftests: Line buffer test program's stdout
  selftests/mm: Skip soft-dirty tests on arm64
  selftests/mm: Enable mrelease_test for arm64
  selftests/mm: Fix thuge-gen test bugs
  selftests/mm: va_high_addr_switch should skip unsupported arm64
    configs
  selftests/mm: Make migration test robust to failure
  selftests/mm: Optionally pass duration to transhuge-stress
  selftests/mm: Run all tests from run_vmtests.sh

 tools/testing/selftests/kselftest.h           |  9 ++
 tools/testing/selftests/kselftest/runner.sh   |  7 +-
 tools/testing/selftests/mm/Makefile           | 82 ++++++++++---------
 tools/testing/selftests/mm/madv_populate.c    | 26 +++++-
 tools/testing/selftests/mm/migration.c        | 12 ++-
 tools/testing/selftests/mm/mrelease_test.c    |  1 +
 tools/testing/selftests/mm/run_vmtests.sh     | 28 ++++++-
 tools/testing/selftests/mm/settings           |  2 +-
 tools/testing/selftests/mm/thuge-gen.c        |  4 +-
 tools/testing/selftests/mm/transhuge-stress.c | 12 ++-
 .../selftests/mm/va_high_addr_switch.c        |  2 +-
 11 files changed, 132 insertions(+), 53 deletions(-)

--
2.25.1

