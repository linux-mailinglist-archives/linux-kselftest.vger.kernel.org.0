Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E11E1B6DD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 08:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgDXGNu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 02:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725967AbgDXGNt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 02:13:49 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F508C09B046
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:13:49 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t2so7410964pfc.15
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hEcvs1wHnncZBwVXSE4QsPgDAjpnjLGcoblNPYaX51o=;
        b=Rf7iTk787JhMOMOlutiO0vfDV8dULFEZYUlESd+B5wl7Qpy1mig60Y7025g5aL2bgc
         +TaV2w0KGZ7y7v2/iwkAHIcVgEonc5JHyuAjqld15XpTLIx2nXMzrHX4Sq1dx4TnY1rT
         W1c6Y6LmsSyzzzlfWa5B3EAlGnoplCna9G+V5a9iV4Y5BxRNtYG2ZhmKYGacN1PFbaQ+
         Gl3/ixcuG1Tn2SVtXHpvN/QFnrdzzdg+O46Wiw4U1v6DfJ3eGDDKiS+8yE4qYtmPnKql
         wBBMaR3wVptkS9q4aPS9vVZPRWy6RiyIYwzfA7q+esvZrrzzcjZ5ZLDJjZ9L1bvvkGpC
         4/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hEcvs1wHnncZBwVXSE4QsPgDAjpnjLGcoblNPYaX51o=;
        b=iF2q7tplUjj1St2YXoGVKjWwcPe4WlgoLPZ7KPNlYbgIoxiuAO2RUWM96Rs100CdZo
         YHaviLiz4NRXIRiidEtnvvXtT6E6WUR9lZ+Zbl0NyJwXzJhwVHJK/IOXBaJ+2DSGWApo
         i+O+fTXnlUPj3iI6XMFXDzULEUFcdaAXpqDulcdHn7KgQIx7BtpDxXVJn/ZE8+vXkVNh
         Z9Pi9MC8vpDCIFeGwAlmFUJsX4Lx+sZi8ydiSVChLKLwp3DxZMsyARSVq9mXLlpRh0bD
         ptLvnFRoTV3mmD2Zz7EJM7kcQePt3A92WrJp/K/OXaXTW1VSiMB6078ZbLg/hr6CPxO3
         fdHQ==
X-Gm-Message-State: AGi0PuYxVpxf1R9ienwikq2SIB7etjgx3Xr+SJvmZ3kzyT0QShDt7+IW
        IkDGqfk/ivYG3cqvJ/enF1P65KHBeBrHFw==
X-Google-Smtp-Source: APiQypLtHeSKKyehyWahOY/xAr2mXJ3uKHkQOf+NKzs6+Wdf41rMtAn1pJHtTD/fGBxATkoIkfiKdvyxo70bVw==
X-Received: by 2002:a17:90b:110d:: with SMTP id gi13mr4547288pjb.131.1587708828845;
 Thu, 23 Apr 2020 23:13:48 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:13:37 -0700
Message-Id: <20200424061342.212535-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v7 0/5] KUnit-KASAN Integration
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

This patchset depends on:
- "[PATCH v3 kunit-next 0/2] kunit: extend kunit resources API" [1]
- "[PATCH v3 0/3] Fix some incompatibilites between KASAN and
  FORTIFY_SOURCE" [2]

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
 - Due to [3] in kasan_strings, kasan_memchr, and
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
[2] https://lkml.org/lkml/2020/4/23/708
[3] https://bugzilla.kernel.org/show_bug.cgi?id=206337



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
 lib/test_kasan.c                  | 688 +++++++++++++-----------------
 lib/test_kasan_module.c           |  76 ++++
 mm/kasan/report.c                 |  34 +-
 10 files changed, 514 insertions(+), 403 deletions(-)
 create mode 100644 lib/test_kasan_module.c

-- 
2.26.2.303.gf8c07b1a785-goog

