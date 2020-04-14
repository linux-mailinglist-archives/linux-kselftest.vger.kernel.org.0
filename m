Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6E1A7193
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404224AbgDNDRT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 23:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404486AbgDNDRQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 23:17:16 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F6FC0A3BE2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 20:17:15 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c21so6886809pfn.14
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gxEoz/v6zI9kY9dLzPfoceYRowmrIoXtyev6zAIHHPw=;
        b=uc1OBjTiiSXG30kfljGMlpVcpXmDGsLmUjZtB0I8qQSHDSRYWXtgiwUgidg45QReKI
         wTGrybQZhRMOmV8jHzToluSkO75v5jgOdUE65cZuGfVbmngjyxhhmpie5FyzuDU2azps
         PCjiynfxw/6lB0bxh6ZxkC4b9glGl4DLVhpzB+vrnpbL6LJlZOrrAVyCsyi/OeV06gTu
         4fVDWmvmPwxg5UBaemLviDhfjidwvY7rAx7FHwtvkYkKt1bxY9hI1veSl8qLEV7AbojW
         k4VFIlREcOIeZj9wQP7E/D2HshMdOs3UySfbAs8sJjGdbm/q7y26Ig/2Nua6Qwnqj2u1
         aRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gxEoz/v6zI9kY9dLzPfoceYRowmrIoXtyev6zAIHHPw=;
        b=qcwNBlpuobb6jeDNu03gik3mvCP/xWVtOUIMowDgx5pf8ufLqQ7Lwi9/SHRQ1qO0Hn
         oMVl0mD7MhF66NovAtcwPVo6WnK0vQ9oeK0tUFI5JvrY4gREOXVzGsYlKzE6sFE//YZ5
         N1bcB65w7K9LnjXg9KXobmb8ehUj/iQCPOP2uai/K3FnJIUz7K+NIfguzaINcbstNX32
         +kNpSw5PnF/IrS8OHXx/zlk9BdsOGf+HGbKI9m5QkeJwPKz9COH1jrLqUazzY+F3YdYS
         2JRWTqveSEg6m4zc/EFSIAtduQrlhq75hURuWvNMo4cAAfzYLQnPNP87O/I0BsAztKYm
         PXyA==
X-Gm-Message-State: AGi0PuYeb6qHuaR3k27I/E3A7DzPNosqdZKCtfEk6BVrwC6HeF6yUuxe
        F+7EwOgdXd9XRma0C8/VvMYxN7kZ21G5zQ==
X-Google-Smtp-Source: APiQypIerSJJKGlbfphtAsom/uiMTUNo/u6cTOKUfW048G0iRUNJlEqD2Jc36VelAjyN/v4FksWQsP3Vyc1EOw==
X-Received: by 2002:a17:90b:19c9:: with SMTP id nm9mr827821pjb.86.1586834234588;
 Mon, 13 Apr 2020 20:17:14 -0700 (PDT)
Date:   Mon, 13 Apr 2020 20:16:43 -0700
Message-Id: <20200414031647.124664-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v5 0/4] KUnit-KASAN Integration
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

Patricia Alfonso (4):
  Add KUnit Struct to Current Task
  KUnit: KASAN Integration
  KASAN: Port KASAN Tests to KUnit
  KASAN: Testing Documentation

 Documentation/dev-tools/kasan.rst |  70 ++++
 include/kunit/test.h              |   5 +
 include/linux/kasan.h             |   6 +
 include/linux/sched.h             |   4 +
 lib/Kconfig.kasan                 |  18 +-
 lib/Makefile                      |   3 +-
 lib/kunit/test.c                  |  13 +-
 lib/test_kasan.c                  | 668 +++++++++++++-----------------
 lib/test_kasan_module.c           |  76 ++++
 mm/kasan/report.c                 |  34 +-
 10 files changed, 504 insertions(+), 393 deletions(-)
 create mode 100644 lib/test_kasan_module.c

-- 
2.26.0.110.g2183baf09c-goog

