Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E301923C48F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 06:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgHEE3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 00:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgHEE3t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 00:29:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0497C061756
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 21:29:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u206so17757083ybb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 21:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NPvcc5+BxYjhobsJ3xVoRbExfcueCfGL3AJz9ZlSlfw=;
        b=mMDKVECHAIqY41N7LEb3YKckU5iMI878+oyqjEcjUJVgg5NIyaEARt33EFyO73R4BU
         EtbAEaSohJZrn362V1mDRprhCo/9FmXzrklr6mSt2XVV6B83tdlkUUz10n7ukyi7efNM
         zgQcLH3DQz0Ihs+VWtsYpUjE/B3ZDAsv/kBe4oxh3AaEM+0pjLK3t2Ar8PvjGe0ltU0s
         37BarES6w+3H4xu1rygfseIQEMbKD+sWMW3EsmJN0J2qOhza6YY1DvYHbgXayqqg4xqZ
         gSGXoKnpD4PoDbQjOaOe/eoC+L6xR2yqu4ma8jR8LkWggXtzNxWUPhIjbrf+CYaHNe81
         WpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NPvcc5+BxYjhobsJ3xVoRbExfcueCfGL3AJz9ZlSlfw=;
        b=nE2ccIlIPnmAdg4zMctBXhKmUYQX4E+p6iq3PtP/TDpnGgL58Ibe64hbmUuyzceqUQ
         0IU+wBqCKl1kKQIIsS+s51WPO7mEn1SvcorJVIynaEGutweC408H9iHjQY/s9vZrvZxg
         sTjTIUsCYzhAuHA2gds4rykc1Xq8zIyfAcjPRzrBaA7Z1El2kDKNX5JyfCh9rcQPnvVI
         SywOt56JvOwIfb7zPUqztJ88T4SlBp1nZHxxd2x8yVaVpSZ+oQ4Lt61C9A9B3fI9uXkd
         2NaPPqk86BIBG0VdEEkXBRGzCpP5bhzdwy5qdrIjKTyDAPa2Z5MYB5uvWS7rzwoV/SDI
         vDFg==
X-Gm-Message-State: AOAM5319L39TJnmUxOLVAzWcCzqv3LB/09wpwUfmONCh47oT7Rzv4Mn2
        mrPd3g/mN+q5UcD8T/72ksrcTZXHRAggTA==
X-Google-Smtp-Source: ABdhPJzSVS3w8X4KEq9fwMCsy193ha7yrk4OtSA+famrLPCvMR4aksz/BHh+NCHwg8G7oDpaChMELipbErOUSw==
X-Received: by 2002:a25:4945:: with SMTP id w66mr2061459yba.285.1596601787731;
 Tue, 04 Aug 2020 21:29:47 -0700 (PDT)
Date:   Tue,  4 Aug 2020 21:29:32 -0700
Message-Id: <20200805042938.2961494-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v11 0/6] KASAN-KUnit Integration
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
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
 - This is included in the KUnit 5.9-rci pull request[8]

I'd _really_ like to get this into 5.9 if possible: we also have some
other changes which depend on some things here.

Changes from v10:
 - Fixed some whitespace issues in patch 2.
 - Split out the renaming of the KUnit test suite into a separate patch.

Changes from v9:
 - Rebased on top of linux-next (20200731) + kselftest/kunit and [7]
 - Note that the kasan_rcu_uaf test has not been ported to KUnit, and
   remains in test_kasan_module. This is because:
   (a) KUnit's expect failure will not check if the RCU stacktraces
       show.
   (b) KUnit is unable to link the failure to the test, as it occurs in
       an RCU callback.

Changes from v8:
 - Rebased on top of kselftest/kunit
 - (Which, with this patchset, should rebase cleanly on 5.8-rc7)
 - Renamed the KUnit test suite, config name to patch the proposed
   naming guidelines for KUnit tests[6]

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
[6] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/
[7] https://lkml.org/lkml/2020/7/31/571
[8] https://lore.kernel.org/linux-kselftest/8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org/T/#u


David Gow (2):
  kasan: test: Make KASAN KUnit test comply with naming guidelines
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
 lib/Kconfig.kasan                 |  22 +-
 lib/Makefile                      |   7 +-
 lib/kasan_kunit.c                 | 770 +++++++++++++++++++++++++
 lib/kunit/test.c                  |  13 +-
 lib/test_kasan.c                  | 903 ------------------------------
 lib/test_kasan_module.c           | 111 ++++
 mm/kasan/report.c                 |  34 +-
 11 files changed, 1028 insertions(+), 917 deletions(-)
 create mode 100644 lib/kasan_kunit.c
 delete mode 100644 lib/test_kasan.c
 create mode 100644 lib/test_kasan_module.c

-- 
2.28.0.163.g6104cc2f0b6-goog

