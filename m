Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253841AE98C
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 05:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgDRDSv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 23:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgDRDSs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 23:18:48 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5997CC061A0F
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Apr 2020 20:18:47 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id w4so4127139pjt.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Apr 2020 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KjuhJjKQQb7YT0HRwB6PPqCXcgSLxnxCVsCILm1vXYg=;
        b=BhjWeQqf0jwxyLFd+gz30xGyWIGa/9G6Lxpa9R/Yvli5he47biVJDisY1gTdS/sLVZ
         cb1NYUWi1xgWdkWR26A7ailOIScVbx6ixZky7TzTw3vOrmbxe/MHGH5C2x0QvSnogAgH
         kj53OxkpJpZ18pJvXRpycV68TiDF5LXsYpL2ZtyA5q5hQhlv7avy1DYuey/N7ONPzAtB
         vsEvA3+JAnkdTfF9MgbEdXD4wS7UNxYIFZoqo+7YBsFN7B3F5vEMzZ6gpkG0VGU/UGih
         089QVeXThyXUABdz55pgwAhyx2kBLebgfbjwGtZ0MVLiDazMdRWowdoIoRZxsrxcPIXC
         Y/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KjuhJjKQQb7YT0HRwB6PPqCXcgSLxnxCVsCILm1vXYg=;
        b=RGG88qRlNxLcA0WytXKMs0a/rFCdHnhMd2Rx3sIim/9IFdCnHCJ1GxupjPvGmHeIWb
         GrpvB3dUXkLvDXEbcK4wEzMgsSQ1dKX8tVg5nI3JZg8LWBmFTOj60yT/H2EvdANgO5Sn
         PL219YxQgLvX4AJZ1f9Uh/IaWKw3lfh/xJq0QIYUD6vGQAUCYBbSIozKZaGnBkeBi33O
         wq0cb5ZuYy6Pk1o91a6bOeqOGeV4iCaRIxh15URbgLhCQR1OePd8L3E7Jz3vOsDRbSQL
         PG+o1u3BQd63F0Eqr19c2zMJfrdBE2seS7MRzIPs/3cSV7lMeY8yEcjUvs2cPEi9BTKj
         +E5g==
X-Gm-Message-State: AGi0PuZn+tpxWin8fZNcOLbNnwKTu07Pms0ZeSfW6R/cAoUUUHyFR7ml
        za2+ANuGzPJuEyAWKwTFS2fBS53pr28yfQ==
X-Google-Smtp-Source: APiQypLkPacc4j3rOyN49jUwOnpUASo2kT4u1R1meA5kQ6Q9TXZw3wcSS0ORxKvT7+0+NY/4qp6KGxJ2B5CKPQ==
X-Received: by 2002:a63:d510:: with SMTP id c16mr6300263pgg.123.1587179926575;
 Fri, 17 Apr 2020 20:18:46 -0700 (PDT)
Date:   Fri, 17 Apr 2020 20:18:28 -0700
Message-Id: <20200418031833.234942-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v6 0/5] KUnit-KASAN Integration
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset contains everything needed to integrate KASAN and KUnit.

KUnit will be able to:
(1) Fail tests when an unexpected KASAN error occurs
(2) Pass tests when an expected KASAN error occurs

Convert KASAN tests to KUnit with the exception of copy_user_test
because KUnit is unable to test those.

Add documentation on how to run the KASAN tests with KUnit and what to
expect when running these tests.

Depends on "[PATCH v3 kunit-next 0/2] kunit: extend kunit resources
API" patchset [1]

Changes from v5:
 - Split out the panic_on_warn changes to a separate patch.
 - Fix documentation to fewer to the new Kconfig names.
 - Fix some changes which were in the wrong patch.
 - Rebase on top of kselftest/kunit (currently identical to 5.7-rc1)

Changes from v4:
 - KASAN no longer will panic on errors if both panic_on_warn and
   kasan_multishot are enabled.
 - As a result, the KASAN tests will no-longer disable panic_on_warn.
 - This also means panic_on_warn no-longer needs to be exported.
 - The use of temporary "kasan_data" variables has been cleaned up
   somewhat.
 - A potential refcount/resource leak should multiple KASAN errors
   appear during an assertion was fixed.
 - Some wording changes to the KASAN test Kconfig entries.

Changes from v3:
 - KUNIT_SET_KASAN_DATA and KUNIT_DO_EXPECT_KASAN_FAIL have been
 combined and included in KUNIT_DO_EXPECT_KASAN_FAIL() instead.
 - Reordered logic in kasan_update_kunit_status() in report.c to be
 easier to read.
 - Added comment to not use the name "kasan_data" for any kunit tests
 outside of KUNIT_EXPECT_KASAN_FAIL().

Changes since v2:
 - Due to Alan's changes in [1], KUnit can be built as a module.
 - The name of the tests that could not be run with KUnit has been
 changed to be more generic: test_kasan_module.
 - Documentation on how to run the new KASAN tests and what to expect
 when running them has been added.
 - Some variables and functions are now static.
 - Now save/restore panic_on_warn in a similar way to kasan_multi_shot
 and renamed the init/exit functions to be more generic to accommodate.
 - Due to [2] in kasan_strings, kasan_memchr, and
 kasan_memcmp will fail if CONFIG_AMD_MEM_ENCRYPT is enabled so return
 early and print message explaining this circumstance.
 - Changed preprocessor checks to C checks where applicable.

Changes since v1:
 - Make use of Alan Maguire's suggestion to use his patch that allows
   static resources for integration instead of adding a new attribute to
   the kunit struct
 - All KUNIT_EXPECT_KASAN_FAIL statements are local to each test
 - The definition of KUNIT_EXPECT_KASAN_FAIL is local to the
   test_kasan.c file since it seems this is the only place this will
   be used.
 - Integration relies on KUnit being builtin
 - copy_user_test has been separated into its own file since KUnit
   is unable to test these. This can be run as a module just as before,
   using CONFIG_TEST_KASAN_USER
 - The addition to the current task has been separated into its own
   patch as this is a significant enough change to be on its own.


[1] https://lore.kernel.org/linux-kselftest/1585313122-26441-1-git-send-email-alan.maguire@oracle.com/T/#t
[2] https://bugzilla.kernel.org/show_bug.cgi?id=206337

David Gow (1):
  mm: kasan: Do not panic if both panic_on_warn and kasan_multishot set

Patricia Alfonso (4):
  Add KUnit Struct to Current Task
  KUnit: KASAN Integration
  KASAN: Port KASAN Tests to KUnit
  KASAN: Testing Documentation

 Documentation/dev-tools/kasan.rst |  70 +++
 include/kunit/test.h              |   5 +
 include/linux/kasan.h             |   6 +
 include/linux/sched.h             |   4 +
 lib/Kconfig.kasan                 |  18 +-
 lib/Makefile                      |   3 +-
 lib/kunit/test.c                  |  13 +-
 lib/test_kasan.c                  | 682 +++++++++++++-----------------
 lib/test_kasan_module.c           |  76 ++++
 mm/kasan/report.c                 |  37 +-
 10 files changed, 513 insertions(+), 401 deletions(-)
 create mode 100644 lib/test_kasan_module.c

-- 
2.26.1.301.g55bc3eb7cb9-goog

