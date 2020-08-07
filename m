Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40D323EDF7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Aug 2020 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgHGNO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Aug 2020 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgHGNO6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Aug 2020 09:14:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D638FC061574
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Aug 2020 06:14:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so989733pfh.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Aug 2020 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ta64/e/ZJXKZ0XNP6hKz3om+KF+Ie9VnHpiNymcsYTM=;
        b=JGA6dj+DD1jReAGoU3LbP7ZXU/K6oO4BPKb976rU81CUW28KY8MJre3rNbMLUWkES4
         EI2gZqp9RP3KAGdGbXY8gPkqO8ceaFe+akIM50UlKj1aVgbzCoiIiKs0BsSxKZCZAy+O
         5XWKVACJw3ND5kWwcMtJaR7hxCjeNbJ5nnV38QbRoExyEYxy3LxGZDCsxE+aYdTqeh2l
         MadATAAar++G1QC9PyJgoVDYWxk1phxGyuOGWxIyUm9pAG4osaJAE28wvhLgqY1Dw+Js
         TXvDXugcaJEBfkbUMdxudrhklOikzDAkfgSa6snsncqlpX5UMHRLrQGofYgpLs/4/sQ/
         sx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ta64/e/ZJXKZ0XNP6hKz3om+KF+Ie9VnHpiNymcsYTM=;
        b=QzP163gk4vNp7dr9NClhd1OxRmKoAMWCFSXrxshaTdCDICdZeAataltVeUbHDnbT4w
         JMHgjUGz4grLeutpNN/LaXq3qekvN0Xy6L8ITx/hs3afe1dIHUT9OGskOySyjmEtJDTA
         AtY6sBo97L6aijPS8csXBzrqPO6NC6meylNnzY+R8OtFJR1YYN+2cB4pKkW8Uac/kPsK
         9/PeCnp+jPJiC5XAnfH4Qs1MWXjjye8f2TxAQAOhryNdTu4+I5yOrcbuA2QbWqfm2kN3
         aFHWgI5J2aclewV9mFV3q+fFSeiTP5KefZab5Dv/TJTbf1BXwJgS1AU4kaohwGot6wug
         +tKQ==
X-Gm-Message-State: AOAM532LzH6/taWO9rsspvk122K/eEQmvPBiy2gQAidsIZQOMCnLFHHf
        AvsMdWfBodmN8mYswOb/gAlVJ/D6F4d54EQWWOsy1A==
X-Google-Smtp-Source: ABdhPJxKLrONkjifLUfgP8ksF37uHjBeWDM3I30l9dzlJKdsC8XO8dt9P/MD9SR6NcMrlr8df+hA6gKne/UjiJkW92w=
X-Received: by 2002:a05:6a00:2a2:: with SMTP id q2mr1649947pfs.306.1596806098023;
 Fri, 07 Aug 2020 06:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200805042938.2961494-1-davidgow@google.com>
In-Reply-To: <20200805042938.2961494-1-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 7 Aug 2020 15:14:46 +0200
Message-ID: <CAAeHK+wPt46879AnV3n3d7+JZqkv2Vo652OPBAjHcuyru56h9w@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] KASAN-KUnit Integration
To:     David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 5, 2020 at 6:29 AM David Gow <davidgow@google.com> wrote:
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
>  - This is included in the KUnit 5.9-rci pull request[8]
>
> I'd _really_ like to get this into 5.9 if possible: we also have some
> other changes which depend on some things here.

Found a small issue in patch #3, but otherwise:

Tested-by: Andrey Konovalov <andreyknvl@google.com>

for the series.

The patches apply cleanly on top of the latest linux-next/akpm branch.

There are some tests that fail for tag-based mode, but those are
unrelated to this series, and require KASAN improvements.

>
> Changes from v10:
>  - Fixed some whitespace issues in patch 2.
>  - Split out the renaming of the KUnit test suite into a separate patch.
>
> Changes from v9:
>  - Rebased on top of linux-next (20200731) + kselftest/kunit and [7]
>  - Note that the kasan_rcu_uaf test has not been ported to KUnit, and
>    remains in test_kasan_module. This is because:
>    (a) KUnit's expect failure will not check if the RCU stacktraces
>        show.
>    (b) KUnit is unable to link the failure to the test, as it occurs in
>        an RCU callback.
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
> [7] https://lkml.org/lkml/2020/7/31/571
> [8] https://lore.kernel.org/linux-kselftest/8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org/T/#u
>
>
> David Gow (2):
>   kasan: test: Make KASAN KUnit test comply with naming guidelines
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
>  lib/kasan_kunit.c                 | 770 +++++++++++++++++++++++++
>  lib/kunit/test.c                  |  13 +-
>  lib/test_kasan.c                  | 903 ------------------------------
>  lib/test_kasan_module.c           | 111 ++++
>  mm/kasan/report.c                 |  34 +-
>  11 files changed, 1028 insertions(+), 917 deletions(-)
>  create mode 100644 lib/kasan_kunit.c
>  delete mode 100644 lib/test_kasan.c
>  create mode 100644 lib/test_kasan_module.c
>
> --
> 2.28.0.163.g6104cc2f0b6-goog
>
