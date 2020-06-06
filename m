Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217761F048F
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jun 2020 06:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFFED5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Jun 2020 00:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgFFED5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Jun 2020 00:03:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E444C08C5C3
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Jun 2020 21:03:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h129so14014396ybc.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 21:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lkHQ0AMN1NLC6Z6ECpqhjd9XH4I1l/DaQ7IG53sVopM=;
        b=qi0rYfZ2Vz7R7UUYW/v0PnJqEk0QGLvKOA6zsTuf7zUiqb7t5jnUe1RAEHfCQz+XGS
         NvqHwdaNyHgucl7rfIBaIvs8tDB3m8yIXSkrMCeLvWPpIrVcnGVM4UuTCOHdS66eD/uV
         zv1rhV1y2sdjz6m3K6o2kjZgTbJGB1azrWb2oFgl2qllXuiE5Jwcewp4Xrip6cAQM9Wl
         RzfcZtA8/1EBecqo0v6q1jBPBPNIXOy1oXLTjbuC6HS/pzT/dVHneFseYhprtEigiiqI
         wLnxQhuWaxrVpB7xFYlf1SibW4R8PfsYPgsxD89XbJLav5GgknsWXheSHP0LJ8XndADQ
         tSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lkHQ0AMN1NLC6Z6ECpqhjd9XH4I1l/DaQ7IG53sVopM=;
        b=oYdw1/OllwF/0JhaW/v2VLIkV6K9zRI+1E9lnPtQERB1h+Em4EepCUeChDYBXrC/i4
         FF+rQvgKQR4RItSeqjTg7XoWd3eHDxsbbBeWV3TA3pcqTYrogj7oiq2xLstepE8odIXh
         wCDP2m5oyg/ZRclLYMmxBPUMmwoTDBRggFkG3Ib+vmCxjDbqXT2fWlyZGmQ/3xgD02wc
         Lhg+DQffdRmn0W84UYQvuE29vjlZcgslV1i2JCSxqjPThBaLG7zz4YL0uGdUNm26Kh8E
         u0+8bwAFXqoTKR4pWILOtSO3kfxylTuBkel8tfqdFoWatvJSi3NN8QD2yPHElqyUoYkV
         pkpg==
X-Gm-Message-State: AOAM531HVQ9rAL8v87o4w6rXdG7y57TRreuxMleKUANNcqihgsCTtAmV
        MNyXSbUDBM2tMFYV1bbbfrzMWeh3dRsdSg==
X-Google-Smtp-Source: ABdhPJwRBv+1vaW1yDKasnaLw2XbVm4EnuxvnvqMWugg378lnavd1Zze7FDdKJR0mD0JCynXuT+3jBU5v/dPCA==
X-Received: by 2002:a25:328b:: with SMTP id y133mr21693800yby.468.1591416234543;
 Fri, 05 Jun 2020 21:03:54 -0700 (PDT)
Date:   Fri,  5 Jun 2020 21:03:44 -0700
Message-Id: <20200606040349.246780-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v8 0/5] KUnit-KASAN Integration
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com, shuah@kernel.org
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

This patchset depends on:
- "kunit: extend kunit resources API" [1]
- "Fix some incompatibilites between KASAN and FORTIFY_SOURCE" [2]
 - This is already upstream for 5.8[3,4]

Changes from v7:
 - Rebased on top of kselftest/kunit
 - Rebased on top of v4 of the kunit resources API[1]
 - Rebased on top of v4 of the FORTIFY_SOURCE fix[2,3,4]
 - Updated the Kconfig entry to support KUNIT_ALL_TESTS

Changes from v6:
 - Rebased on top of kselftest/kunit
 - Rebased on top of Daniel Axtens' fix for FORTIFY_SOURCE
   incompatibilites [2]
 - Removed a redundant report_enabled() check.
 - Fixed some places with out of date Kconfig names in the
   documentation.

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
 - Due to [4] in kasan_strings, kasan_memchr, and
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


[1] https://lore.kernel.org/linux-kselftest/CAFd5g46Uu_5TG89uOm0Dj5CMq+11cwjBnsd-k_CVy6bQUeU4Jw@mail.gmail.com/T/#t
[2] https://lore.kernel.org/linux-mm/20200424145521.8203-1-dja@axtens.net/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adb72ae1915db28f934e9e02c18bfcea2f3ed3b7
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47227d27e2fcb01a9e8f5958d8997cf47a820afc
[5] https://bugzilla.kernel.org/show_bug.cgi?id=206337

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
 lib/Kconfig.kasan                 |  19 +-
 lib/Makefile                      |   3 +-
 lib/kunit/test.c                  |  13 +-
 lib/test_kasan.c                  | 688 +++++++++++++-----------------
 lib/test_kasan_module.c           |  76 ++++
 mm/kasan/report.c                 |  34 +-
 10 files changed, 515 insertions(+), 403 deletions(-)
 create mode 100644 lib/test_kasan_module.c

-- 
2.27.0.278.ge193c7cf3a9-goog

