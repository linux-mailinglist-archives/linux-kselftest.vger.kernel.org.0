Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB2240710
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHJN6n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 09:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgHJN6m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 09:58:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F14EC061787
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 06:58:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so4902304pgm.7
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8E54KhSpuBKWIMIaL7v/gAGTdmACWSLUtq/+2ecsU0=;
        b=ZzRMPMu4QHGxdavXq5roXcPP14sQMzdzJlsaORxRh+EPbLl/jHYKSmQXoJc3goLZJR
         +2Db7/O1vf+Kro9hGUzrceNhDA0CH4DtzBS+OKOFD0pHPTKQ9DshgESjMu55TeF9GdJn
         Fmi/dqW1pJI4mrllTA7ShzcowP1VVeB04M9KRQDd15kztHUC/GumV4yQtedSIvmkTRyM
         ikJd4q2yrvmR4g6Pm/ByO+iBxYc3KBUUKWL/Np+pXTYOpBLXxZa26et9uXLD7GeJwQgB
         lzLDePevWrB5drdAft/1Jmm/sZcBNXY8idYzksQ2FZc1p2BDR3C8R/mWQKqSDsdbMiKO
         ui6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8E54KhSpuBKWIMIaL7v/gAGTdmACWSLUtq/+2ecsU0=;
        b=BybuILk8XmBuD0dYLwyKFYQtdcNF2dgy3jEfbpiMzeBQMlYsqZShfTVHLNYevBK0ZZ
         085bTDuyJkPRy4KyElJP737O3QhCVXB/9dnT3XLK09XoowpCw3i+sNZUof/WOjlPHXxo
         lWyUJ4DMRpRKJUE5oY8hgYmT8XpgEt4e58sYCKgVqXLPJa+8c9ASLhZSuyoTiK8Mldti
         /PLiu0LVVDciezt0iJvxzMZfJIdu4TqZnzdySqzi2YekXsMkqWL/Y2Rb5EM8PyXLUU2c
         j6C8Dv6aG7Xvvv3m4M/JguiMGwvC42QEZ66eF/5VqWWoaKjIwoCRgMkLAl/8lDoYjAHq
         EmYQ==
X-Gm-Message-State: AOAM531EhIBpSMW9uJY+CTIeDfLLepY2vOZ0soF+h4+Y5Iho1K8RY4XU
        1x5CQ2PDz0koLreVDtXZ+rRCOTUbOPMZoB/W16tNfA==
X-Google-Smtp-Source: ABdhPJy6bZutnX+fwibVdBYheR7RyPIa6s8hHHFzodTYlRSOhDbn9VvrFFP+wwixr2dP3U4jhWuQvP2d1b6I2zqNy5c=
X-Received: by 2002:a65:4bc7:: with SMTP id p7mr21951623pgr.440.1597067921141;
 Mon, 10 Aug 2020 06:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200805042938.2961494-1-davidgow@google.com> <CAAeHK+wPt46879AnV3n3d7+JZqkv2Vo652OPBAjHcuyru56h9w@mail.gmail.com>
 <CABVgOSmveFxFq-Kvtq9+EQa61ko-wQ4CTJ2WCfJWbjUWzBaQrg@mail.gmail.com>
In-Reply-To: <CABVgOSmveFxFq-Kvtq9+EQa61ko-wQ4CTJ2WCfJWbjUWzBaQrg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 10 Aug 2020 15:58:30 +0200
Message-ID: <CAAeHK+y-P-ML-MYovFqpvLU4Nur98WOAnYH_1B0=GUJs1=PZKw@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] KASAN-KUnit Integration
To:     David Gow <davidgow@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 8, 2020 at 5:27 AM David Gow <davidgow@google.com> wrote:
>
> On Fri, Aug 7, 2020 at 9:15 PM 'Andrey Konovalov' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > On Wed, Aug 5, 2020 at 6:29 AM David Gow <davidgow@google.com> wrote:
> > >
> > > This patchset contains everything needed to integrate KASAN and KUnit.
> > >
> > > KUnit will be able to:
> > > (1) Fail tests when an unexpected KASAN error occurs
> > > (2) Pass tests when an expected KASAN error occurs
> > >
> > > Convert KASAN tests to KUnit with the exception of copy_user_test
> > > because KUnit is unable to test those.
> > >
> > > Add documentation on how to run the KASAN tests with KUnit and what to
> > > expect when running these tests.
> > >
> > > This patchset depends on:
> > > - "kunit: extend kunit resources API" [1]
> > >  - This is included in the KUnit 5.9-rci pull request[8]
> > >
> > > I'd _really_ like to get this into 5.9 if possible: we also have some
> > > other changes which depend on some things here.
> >
> > Found a small issue in patch #3, but otherwise:
> >
> > Tested-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > for the series.
>
> Cheers! The issue in #3 looks to be a rebase issue: I'll send a fixed
> version out soon.
> >
> > The patches apply cleanly on top of the latest linux-next/akpm branch.
> >
> > There are some tests that fail for tag-based mode, but those are
> > unrelated to this series, and require KASAN improvements.
> >
> Do you think it's worth disabling these tests if tag-based mode is
> disabled?

No, I think we should keep them enabled, and eventually adopt them for
tag-based KASAN (or fix tag-based KASAN itself, if there are issues
with it). I'd only disable tests if we can actually explain why a
particular test can't work with tag-based KASAN at all.

> Personally, I'm leaning "no", but if the planned support for
> explicitly skipping tests existed, this could be a good case for it: a
> test which is expected to fail due to a feature not existing in the
> current config.
>
> Thanks,
> -- David
>
> > >
> > > Changes from v10:
> > >  - Fixed some whitespace issues in patch 2.
> > >  - Split out the renaming of the KUnit test suite into a separate patch.
> > >
> > > Changes from v9:
> > >  - Rebased on top of linux-next (20200731) + kselftest/kunit and [7]
> > >  - Note that the kasan_rcu_uaf test has not been ported to KUnit, and
> > >    remains in test_kasan_module. This is because:
> > >    (a) KUnit's expect failure will not check if the RCU stacktraces
> > >        show.
> > >    (b) KUnit is unable to link the failure to the test, as it occurs in
> > >        an RCU callback.
> > >
> > > Changes from v8:
> > >  - Rebased on top of kselftest/kunit
> > >  - (Which, with this patchset, should rebase cleanly on 5.8-rc7)
> > >  - Renamed the KUnit test suite, config name to patch the proposed
> > >    naming guidelines for KUnit tests[6]
> > >
> > > Changes from v7:
> > >  - Rebased on top of kselftest/kunit
> > >  - Rebased on top of v4 of the kunit resources API[1]
> > >  - Rebased on top of v4 of the FORTIFY_SOURCE fix[2,3,4]
> > >  - Updated the Kconfig entry to support KUNIT_ALL_TESTS
> > >
> > > Changes from v6:
> > >  - Rebased on top of kselftest/kunit
> > >  - Rebased on top of Daniel Axtens' fix for FORTIFY_SOURCE
> > >    incompatibilites [2]
> > >  - Removed a redundant report_enabled() check.
> > >  - Fixed some places with out of date Kconfig names in the
> > >    documentation.
> > >
> > > Changes from v5:
> > >  - Split out the panic_on_warn changes to a separate patch.
> > >  - Fix documentation to fewer to the new Kconfig names.
> > >  - Fix some changes which were in the wrong patch.
> > >  - Rebase on top of kselftest/kunit (currently identical to 5.7-rc1)
> > >
> > > Changes from v4:
> > >  - KASAN no longer will panic on errors if both panic_on_warn and
> > >    kasan_multishot are enabled.
> > >  - As a result, the KASAN tests will no-longer disable panic_on_warn.
> > >  - This also means panic_on_warn no-longer needs to be exported.
> > >  - The use of temporary "kasan_data" variables has been cleaned up
> > >    somewhat.
> > >  - A potential refcount/resource leak should multiple KASAN errors
> > >    appear during an assertion was fixed.
> > >  - Some wording changes to the KASAN test Kconfig entries.
> > >
> > > Changes from v3:
> > >  - KUNIT_SET_KASAN_DATA and KUNIT_DO_EXPECT_KASAN_FAIL have been
> > >  combined and included in KUNIT_DO_EXPECT_KASAN_FAIL() instead.
> > >  - Reordered logic in kasan_update_kunit_status() in report.c to be
> > >  easier to read.
> > >  - Added comment to not use the name "kasan_data" for any kunit tests
> > >  outside of KUNIT_EXPECT_KASAN_FAIL().
> > >
> > > Changes since v2:
> > >  - Due to Alan's changes in [1], KUnit can be built as a module.
> > >  - The name of the tests that could not be run with KUnit has been
> > >  changed to be more generic: test_kasan_module.
> > >  - Documentation on how to run the new KASAN tests and what to expect
> > >  when running them has been added.
> > >  - Some variables and functions are now static.
> > >  - Now save/restore panic_on_warn in a similar way to kasan_multi_shot
> > >  and renamed the init/exit functions to be more generic to accommodate.
> > >  - Due to [4] in kasan_strings, kasan_memchr, and
> > >  kasan_memcmp will fail if CONFIG_AMD_MEM_ENCRYPT is enabled so return
> > >  early and print message explaining this circumstance.
> > >  - Changed preprocessor checks to C checks where applicable.
> > >
> > > Changes since v1:
> > >  - Make use of Alan Maguire's suggestion to use his patch that allows
> > >    static resources for integration instead of adding a new attribute to
> > >    the kunit struct
> > >  - All KUNIT_EXPECT_KASAN_FAIL statements are local to each test
> > >  - The definition of KUNIT_EXPECT_KASAN_FAIL is local to the
> > >    test_kasan.c file since it seems this is the only place this will
> > >    be used.
> > >  - Integration relies on KUnit being builtin
> > >  - copy_user_test has been separated into its own file since KUnit
> > >    is unable to test these. This can be run as a module just as before,
> > >    using CONFIG_TEST_KASAN_USER
> > >  - The addition to the current task has been separated into its own
> > >    patch as this is a significant enough change to be on its own.
> > >
> > >
> > > [1] https://lore.kernel.org/linux-kselftest/CAFd5g46Uu_5TG89uOm0Dj5CMq+11cwjBnsd-k_CVy6bQUeU4Jw@mail.gmail.com/T/#t
> > > [2] https://lore.kernel.org/linux-mm/20200424145521.8203-1-dja@axtens.net/
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adb72ae1915db28f934e9e02c18bfcea2f3ed3b7
> > > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47227d27e2fcb01a9e8f5958d8997cf47a820afc
> > > [5] https://bugzilla.kernel.org/show_bug.cgi?id=206337
> > > [6] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/
> > > [7] https://lkml.org/lkml/2020/7/31/571
> > > [8] https://lore.kernel.org/linux-kselftest/8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org/T/#u
> > >
> > >
> > > David Gow (2):
> > >   kasan: test: Make KASAN KUnit test comply with naming guidelines
> > >   mm: kasan: Do not panic if both panic_on_warn and kasan_multishot set
> > >
> > > Patricia Alfonso (4):
> > >   Add KUnit Struct to Current Task
> > >   KUnit: KASAN Integration
> > >   KASAN: Port KASAN Tests to KUnit
> > >   KASAN: Testing Documentation
> > >
> > >  Documentation/dev-tools/kasan.rst |  70 +++
> > >  include/kunit/test.h              |   5 +
> > >  include/linux/kasan.h             |   6 +
> > >  include/linux/sched.h             |   4 +
> > >  lib/Kconfig.kasan                 |  22 +-
> > >  lib/Makefile                      |   7 +-
> > >  lib/kasan_kunit.c                 | 770 +++++++++++++++++++++++++
> > >  lib/kunit/test.c                  |  13 +-
> > >  lib/test_kasan.c                  | 903 ------------------------------
> > >  lib/test_kasan_module.c           | 111 ++++
> > >  mm/kasan/report.c                 |  34 +-
> > >  11 files changed, 1028 insertions(+), 917 deletions(-)
> > >  create mode 100644 lib/kasan_kunit.c
> > >  delete mode 100644 lib/test_kasan.c
> > >  create mode 100644 lib/test_kasan_module.c
> > >
> > > --
> > > 2.28.0.163.g6104cc2f0b6-goog
> > >
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CAAeHK%2BwPt46879AnV3n3d7%2BJZqkv2Vo652OPBAjHcuyru56h9w%40mail.gmail.com.
