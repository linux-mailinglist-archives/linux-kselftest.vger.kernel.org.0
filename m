Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25132346CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jul 2020 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGaNZl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgGaNZl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 09:25:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59406C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 06:25:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kr4so5449324pjb.2
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEI7QlNd+n7mCSlqUP8tfyoHThcUKaKtV6i9WVkU4rE=;
        b=EFgAoxc1lBpnfSfRcu0ipTMSOcGQ7QweQKKGPauCln797EF9dMpL2jrHlvP3viERy7
         6qFdcVq+tn90iXkFML2huGj/kTaqeYwd/tS810ojOyiuFUrhQFrwyxc/BeYr/842OzXU
         rynPBE1lj5slETpR/oow2+ToDsadtR/BoUqLKLoYKWnwR+HH/2DB10GikHFfbj3t1v+m
         N2DahEtaTYkIgdoQgbYSWJrCzpoBgZOPeTCxZnDOL16sPbRrhknatvMqejsiLYOKvu4w
         Y2LKrE/WO8yydETeJfQxH1xUVrEduccDSUWqhacBZZisj+q50doQ8BMdgdT9lokDc13Q
         qZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEI7QlNd+n7mCSlqUP8tfyoHThcUKaKtV6i9WVkU4rE=;
        b=IE+JNneCAbXjWFu7FgCINKv36/yCeSYGtfhfKoZpQHVeJyrzY7YblGkeDCbgBLQrkU
         glH1k2Bua+LOKlJLQmqj4FsSfWrZUv2LydhdpQ8Pr9xQCm6/jTt3MvgByoAOM2m2nixt
         DNcQ7qC0V/8PKEqXpU7V7m6tFFRzM797WsDa5z6uD3yhbEWuOh0ScXjNHQqpDcmZs/wT
         ar/EumP5dUTQwyMABrWsCjM9KkvSvm4Higitj29V+KLm5NWbnTgOvZh1jyF/Trw+2Lt/
         8BQFeDHyuNEUSvL7C5SuX7z+ZmIn6jB47z1VsYygqUeokVzEeOOg57VQA09i5u3SkCLy
         m2Cw==
X-Gm-Message-State: AOAM532589G6J9bW0WH2WVE5FusUyVFUrtsBg1pCi+/mzsS37nwHeG/s
        5OrMuEbfnSU6rwp/QnSL3MP/HfK00NJCQD5nBIFAwA==
X-Google-Smtp-Source: ABdhPJwOM1X62UcHRYe5CnKGFs2rbUxLwcrdYvfymYqKedcGjdjR5g/NUfO5j/eCNp+kDkNJ/+yyjpopjON6YKGdS6w=
X-Received: by 2002:a17:90a:6a8d:: with SMTP id u13mr3852021pjj.166.1596201940297;
 Fri, 31 Jul 2020 06:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200731044242.1323143-1-davidgow@google.com>
In-Reply-To: <20200731044242.1323143-1-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 31 Jul 2020 15:25:29 +0200
Message-ID: <CAAeHK+z0wJ-3+dXey9o3zysy9fPOqk-YdFFtVOB5==WcG3B8+Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] KASAN-KUnit Integration
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
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
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 31, 2020 at 6:43 AM David Gow <davidgow@google.com> wrote:
>
> This patchset contains everything needed to integrate KASAN and KUnit.
>
> KUnit will be able to:
> (1) Fail tests when an unexpected KASAN error occurs
> (2) Pass tests when an expected KASAN error occurs
>
> Convert KASAN tests to KUnit with the exception of copy_user_test
> because KUnit is unable to test those.
>
> Add documentation on how to run the KASAN tests with KUnit and what to
> expect when running these tests.
>
> This patchset depends on:
> - "kunit: extend kunit resources API" [1]
>  - This is already present in the kselftest/kunit branch
>
> I'd _really_ like to get this into 5.9 if possible: we also have some
> other changes which depend on some things here.

Hi David,

You'll need to rebase this on top of the mm tree, which currently
contains Walter's patch titled "kasan: fix KASAN unit tests for
tag-based KASAN".

There's also another patch that touches KASAN tests in the series I've
just mailed titled "kasan: support stack instrumentation for tag-based
mode".

Thanks!


>
> Changes from v8:
>  - Rebased on top of kselftest/kunit
>  - (Which, with this patchset, should rebase cleanly on 5.8-rc7)
>  - Renamed the KUnit test suite, config name to patch the proposed
>    naming guidelines for KUnit tests[6]
>
> Changes from v7:
>  - Rebased on top of kselftest/kunit
>  - Rebased on top of v4 of the kunit resources API[1]
>  - Rebased on top of v4 of the FORTIFY_SOURCE fix[2,3,4]
>  - Updated the Kconfig entry to support KUNIT_ALL_TESTS
>
> Changes from v6:
>  - Rebased on top of kselftest/kunit
>  - Rebased on top of Daniel Axtens' fix for FORTIFY_SOURCE
>    incompatibilites [2]
>  - Removed a redundant report_enabled() check.
>  - Fixed some places with out of date Kconfig names in the
>    documentation.
>
> Changes from v5:
>  - Split out the panic_on_warn changes to a separate patch.
>  - Fix documentation to fewer to the new Kconfig names.
>  - Fix some changes which were in the wrong patch.
>  - Rebase on top of kselftest/kunit (currently identical to 5.7-rc1)
>
> Changes from v4:
>  - KASAN no longer will panic on errors if both panic_on_warn and
>    kasan_multishot are enabled.
>  - As a result, the KASAN tests will no-longer disable panic_on_warn.
>  - This also means panic_on_warn no-longer needs to be exported.
>  - The use of temporary "kasan_data" variables has been cleaned up
>    somewhat.
>  - A potential refcount/resource leak should multiple KASAN errors
>    appear during an assertion was fixed.
>  - Some wording changes to the KASAN test Kconfig entries.
>
> Changes from v3:
>  - KUNIT_SET_KASAN_DATA and KUNIT_DO_EXPECT_KASAN_FAIL have been
>  combined and included in KUNIT_DO_EXPECT_KASAN_FAIL() instead.
>  - Reordered logic in kasan_update_kunit_status() in report.c to be
>  easier to read.
>  - Added comment to not use the name "kasan_data" for any kunit tests
>  outside of KUNIT_EXPECT_KASAN_FAIL().
>
> Changes since v2:
>  - Due to Alan's changes in [1], KUnit can be built as a module.
>  - The name of the tests that could not be run with KUnit has been
>  changed to be more generic: test_kasan_module.
>  - Documentation on how to run the new KASAN tests and what to expect
>  when running them has been added.
>  - Some variables and functions are now static.
>  - Now save/restore panic_on_warn in a similar way to kasan_multi_shot
>  and renamed the init/exit functions to be more generic to accommodate.
>  - Due to [4] in kasan_strings, kasan_memchr, and
>  kasan_memcmp will fail if CONFIG_AMD_MEM_ENCRYPT is enabled so return
>  early and print message explaining this circumstance.
>  - Changed preprocessor checks to C checks where applicable.
>
> Changes since v1:
>  - Make use of Alan Maguire's suggestion to use his patch that allows
>    static resources for integration instead of adding a new attribute to
>    the kunit struct
>  - All KUNIT_EXPECT_KASAN_FAIL statements are local to each test
>  - The definition of KUNIT_EXPECT_KASAN_FAIL is local to the
>    test_kasan.c file since it seems this is the only place this will
>    be used.
>  - Integration relies on KUnit being builtin
>  - copy_user_test has been separated into its own file since KUnit
>    is unable to test these. This can be run as a module just as before,
>    using CONFIG_TEST_KASAN_USER
>  - The addition to the current task has been separated into its own
>    patch as this is a significant enough change to be on its own.
>
>
> [1] https://lore.kernel.org/linux-kselftest/CAFd5g46Uu_5TG89uOm0Dj5CMq+11cwjBnsd-k_CVy6bQUeU4Jw@mail.gmail.com/T/#t
> [2] https://lore.kernel.org/linux-mm/20200424145521.8203-1-dja@axtens.net/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adb72ae1915db28f934e9e02c18bfcea2f3ed3b7
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47227d27e2fcb01a9e8f5958d8997cf47a820afc
> [5] https://bugzilla.kernel.org/show_bug.cgi?id=206337
> [6] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/
>
>
> David Gow (1):
>   mm: kasan: Do not panic if both panic_on_warn and kasan_multishot set
>
> Patricia Alfonso (4):
>   Add KUnit Struct to Current Task
>   KUnit: KASAN Integration
>   KASAN: Port KASAN Tests to KUnit
>   KASAN: Testing Documentation
>
>  Documentation/dev-tools/kasan.rst |  70 +++
>  include/kunit/test.h              |   5 +
>  include/linux/kasan.h             |   6 +
>  include/linux/sched.h             |   4 +
>  lib/Kconfig.kasan                 |  22 +-
>  lib/Makefile                      |   7 +-
>  lib/kunit/test.c                  |  13 +-
>  lib/test_kasan.c                  | 858 ------------------------------
>  mm/kasan/report.c                 |  34 +-
>  9 files changed, 147 insertions(+), 872 deletions(-)
>  delete mode 100644 lib/test_kasan.c
>
> --
> 2.28.0.163.g6104cc2f0b6-goog
>
