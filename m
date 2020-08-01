Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D52350E4
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Aug 2020 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgHAHJe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Aug 2020 03:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgHAHJd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Aug 2020 03:09:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA11C06174A
        for <linux-kselftest@vger.kernel.org>; Sat,  1 Aug 2020 00:09:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p138so17524038yba.12
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Aug 2020 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J6mfWqFl9ILoOse64w8NCh3ZibSveR4Njn3UWGLPdfQ=;
        b=IHYl/2b8ioPS0Ixk6ZqxEyZzi7bL3ob80l4mUJBpKjNJcd3mHQrn8HlvcpwtlzkYyc
         LW/KffjyXk0e+jfiCycHmADN+2bqC4fpwdlSuJeCOjoA9j7n2ykDazYuVGKHHdWTVamS
         SeXu7grSV0J3Ooi6Mg94+KVLRKZcTDXpaH1YV0vwbshtbItZsPn8CRFxasi89UHQR5re
         dQmwFQ1OL9SkTHo4WjKXKNxThxNYDm3Mc/+VejpZyNJnKY0P+jG2m99TRBMCGiTRT7Kx
         5PSsMDJf/XQ8UwKVXAi5rCGST7N1DN9FE8sByOKrqxYuTwhCvdMwF2WlUVCbFOOAwaUU
         1nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J6mfWqFl9ILoOse64w8NCh3ZibSveR4Njn3UWGLPdfQ=;
        b=RdPVePvKZBVKRFInzVcKtemxJmbhDD/NX+6VNujNmNF0BzB8O4IhW0yz0l9EMtnSLi
         MwLuJcesMAil0Py7FoACAfYJXqzjgA0HNr/woARcqN9DjdPT91UM8Rb1ysUU1vkcbQv3
         5jERA+nz6lkr5kuTjPH7kGI4/9u21E+mngopBKfUoMHNjoYQsk2WU+BnkhVKrRF3wRsU
         IExUtpAA/f/Y5yAtttREyO7tJUvmS8CmNuOy3aQbr1KRx/4s1qCd1dsPtXVeKbSiSW4o
         jWogxTLYTJCK7ntNANfEG0gPPQcvkg8ZB0itGmVpD4JmZAxkkmyy0DWWXjF5w8P5Cr74
         O+ow==
X-Gm-Message-State: AOAM5316y6VowSgQTMbZbvfjtVPz9QvPwKqZvR4SkwXXcEXRqliuDZZg
        kG8M9YKXg+xS/qNDPXvaw+3+n0NxrComNg==
X-Google-Smtp-Source: ABdhPJzNkcPVzTD7uIhVE5Ekt7ET6/gtOUIgCz117VASURufICXbNVKpvEEPTLkmueIxPpN5FkssbyeL1exgww==
X-Received: by 2002:a25:c145:: with SMTP id r66mr7371613ybf.244.1596265772670;
 Sat, 01 Aug 2020 00:09:32 -0700 (PDT)
Date:   Sat,  1 Aug 2020 00:09:19 -0700
Message-Id: <20200801070924.1786166-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v10 0/5] KASAN-KUnit Integration
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
 - This is already present in the kselftest/kunit branch

I'd _really_ like to get this into 5.9 if possible: we also have some
other changes which depend on some things here.

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

