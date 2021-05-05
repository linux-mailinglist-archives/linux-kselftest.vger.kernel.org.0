Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD2F374B2D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 May 2021 00:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhEEWYJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 May 2021 18:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhEEWYI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 May 2021 18:24:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85254C06174A
        for <linux-kselftest@vger.kernel.org>; Wed,  5 May 2021 15:23:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w3so5264454ejc.4
        for <linux-kselftest@vger.kernel.org>; Wed, 05 May 2021 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mt+Qg1JrnJEreITDANxBmHknj6ni8spPEnxGYMvdZrY=;
        b=dIrDE8WW8dVjG+IxcpkThLlbUPfYpcLEj7Jru9b4XvKV1S5Bmnh6DgUnE0IclEGr0L
         IxxNyfp0zilxzrEUyQE/BO0hSvN/E6ktlRCFOuCSb87jPt8fX9HyCD1Syb/v9zDR1bx/
         XlBNCDW68nkeeI/s8LM6ogX2+4Q0a8dyBCWMmcu6qg9OMTJLPTLDEwWCtjHFRWX89On6
         48QIyoPRfpUnXcp0wX6JhxzehO9Fslp3SQAjy8KK4xY9j3T3AUwJJKV+aopcIObF6A2w
         eWkDZgueenFMzFa/rDZLWhN9jTWDN0I+ZIKUyEnLW8t+Szjl31BuxWDY9f2GxfkI0jOZ
         8Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mt+Qg1JrnJEreITDANxBmHknj6ni8spPEnxGYMvdZrY=;
        b=DrKoaan76pS8lhCoccTH0r7FgNsNxibgMBet/3l+HV5Un4ZoT+AFyam+GpSoyfmaT4
         w+2Y0j+Ut1ZSSENr5nhEDyiLjA+QXwtfrMN7cPEns1HrdQVyJkIII+BoUYQvmtDYAHSc
         3tayHb1lutsB00HZqKg81mZk3fE8e93wfxJLqKu30xTXgRN8bUVIGwHr8EeKTbcSnXP3
         ZyGUWD+Ar73lhTpq0EKEuLZIE3cwaf/SGytr/oeVymv/Zivk6Ui/VZSObCec6oVKMHZx
         T6bduJGb6rgl67qVUPf0ddGnvkqmlkDVtNLDW8gEYKp/itmnemUl5aozbMfZSCAkQ3Ir
         Kl2A==
X-Gm-Message-State: AOAM532LWT77DfBBWRIaYvlWD0+Zoa2yYP6R1SsSj7UYnaBpJLTRudto
        vXGvDfHE/ZRDBvaiqR0cHYQ0N04cC62BuDMn1Rf74g==
X-Google-Smtp-Source: ABdhPJwguRIiJAJz8m41MtdEheS5whCRFQRDyemYFlhB6GUX2l00ViqSt5RPX2pckCudRpvgxfr5qHBdfkgbg/OKbpM=
X-Received: by 2002:a17:906:d0c8:: with SMTP id bq8mr911325ejb.423.1620253389837;
 Wed, 05 May 2021 15:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210416065623.882364-1-davidgow@google.com>
In-Reply-To: <20210416065623.882364-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 5 May 2021 15:22:58 -0700
Message-ID: <CAGS_qxpnVJWgPBV9bCTHZNXiHtjEC3MWxA0-jG1EU9PUUUvKhw@mail.gmail.com>
Subject: Re: [PATCH v8] fat: Add KUnit tests for checksums and timestamps
To:     David Gow <davidgow@google.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Brendan Higgins <brendanhiggins@google.com>,
        shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 15, 2021 at 11:56 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add some basic sanity-check tests for the fat_checksum() function and
> the fat_time_unix2fat() and fat_time_fat2unix() functions. These unit
> tests verify these functions return correct output for a number of test
> inputs.
>
> These tests were inspored by -- and serve a similar purpose to -- the
> timestamp parsing KUnit tests in ext4[1].
>
> Note that, unlike fat_time_unix2fat, fat_time_fat2unix wasn't previously
> exported, so this patch exports it as well. This is required for the
> case where we're building the fat and fat_test as modules.
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/inode-test.c
>
> Signed-off-by: David Gow <davidgow@google.com>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Tested-by: Daniel Latypov <dlatypov@google.com>

The KUnit side of things looks good to me, added some minor nits below.
I had been hoping to run this using coverage, but something about that
is newly broken for my machine, so I haven't been able to :|

Because I felt committed to checking the coverage somehow, I added
some pr_info()s to see which branches are being taken.
We're hitting all of them except for the two in fat_time_unix2fat:
* the one for dates before 1980
* the one for dates after 2107

We have the earliest and latest possible dates as test cases already,
so it's probably not that important to hit those.

> ---
>
> It's been a while, but this hopefully is a final version of the FAT KUnit
> patchset. It has a number of changes to keep it up-to-date with current
> KUnit standards, notably the use of parameterised tests and the addition
> of a '.kunitconfig' file to allow for easy testing. It also fixes an
> endianness tagging issue picked up by the kernel test robot under sparse
> on pa-risc.
>
> Cheers,
> -- David
>
> Changes since v7:
> https://lore.kernel.org/linux-kselftest/20201028064631.3774908-1-davidgow@google.com/
> - Make the two timestamp tests parameterised: this means that the KUnit
>   runtime and tooling are aware of the different testcases (and print a
>   nice list of them to the TAP log when the test is run).
> - Fix some issues sparse picked up with __le32 tagged integers.
> - Add an fs/fat/.kunitconfig file which contains all the Kconfig entries
>   needed to run the test. The test can now be run with:
>   ./tools/testing/kunit/kunit.py run --kunitconfig fs/fat/.kunitconfig

FYI, if you do rebase send out a new revision, the test can be run via
$ ./tools/testing/kunit/kunit.py run --kunitconfig fs/fat

>
> Changes since v6:
> https://lore.kernel.org/linux-kselftest/20201024060558.2556249-1-davidgow@google.com/
> - Make CONFIG_FAT_DEFAULT_CODEPAGE depend on FAT_FS, rather than either
>   VFAT_FS or MSDOS_FS.
>   - This means that FAT_KUNIT_TEST can now also just depend of FAT_FS
> - Fix a few warnings that KUnit tool was eating:
>   - KUnit's type checking needs a specific cast for the fat_checksum()
>     expected results.
>   - The time test cases shouldn't be 'const'
>   - The fake superblock is now static, as otherwise it increased the
>     stack size too much.
>
> Changes since v4/5:
> https://lore.kernel.org/linux-kselftest/20201024052047.2526780-1-davidgow@google.com/
> - Fix a typo introduced in the Kconfig. It builds now.
>
> Changes since v3:
> https://lore.kernel.org/linux-kselftest/20201021061713.1545931-1-davidgow@google.com/
> - Update the Kconfig entry to use "depends on" rather than "select", as
>   discussed in [2].
> - Depend on "MSDOS_FS || VFAT_FS", rather than "FAT_FS", as we need the
>   CONFIG_FAT_DEFAULT_CODEPAGE symbol to be defined.
>
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20201020055856.1270482-1-davidgow@google.com/
> - Comment that the export for fat_time_fat2unix() function is for KUnit
>   tests.
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20201017064107.375174-1-davidgow@google.com/
> - Now export fat_time_fat2unix() so that the test can access it when
>   built as a module.
>
>
> [2]:
> https://lore.kernel.org/linux-ext4/52959e99-4105-3de9-730c-c46894b82bdd@infradead.org/T/#t
>
>
>
>  fs/fat/.kunitconfig |   5 ++
>  fs/fat/Kconfig      |  14 +++-
>  fs/fat/Makefile     |   2 +
>  fs/fat/fat_test.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/fat/misc.c       |   2 +
>  5 files changed, 219 insertions(+), 1 deletion(-)
>  create mode 100644 fs/fat/.kunitconfig
>  create mode 100644 fs/fat/fat_test.c
>
> diff --git a/fs/fat/.kunitconfig b/fs/fat/.kunitconfig
> new file mode 100644
> index 000000000000..0a6971dbeccb
> --- /dev/null
> +++ b/fs/fat/.kunitconfig
> @@ -0,0 +1,5 @@
> +CONFIG_KUNIT=y
> +CONFIG_FAT_FS=y
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_FAT_KUNIT_TEST=y
> diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> index 66532a71e8fd..238cc55f84c4 100644
> --- a/fs/fat/Kconfig
> +++ b/fs/fat/Kconfig
> @@ -77,7 +77,7 @@ config VFAT_FS
>
>  config FAT_DEFAULT_CODEPAGE
>         int "Default codepage for FAT"
> -       depends on MSDOS_FS || VFAT_FS
> +       depends on FAT_FS
>         default 437
>         help
>           This option should be set to the codepage of your FAT filesystems.
> @@ -115,3 +115,15 @@ config FAT_DEFAULT_UTF8
>           Say Y if you use UTF-8 encoding for file names, N otherwise.
>
>           See <file:Documentation/filesystems/vfat.rst> for more information.
> +
> +config FAT_KUNIT_TEST
> +       tristate "Unit Tests for FAT filesystems" if !KUNIT_ALL_TESTS
> +       depends on KUNIT && FAT_FS
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the FAT KUnit tests
> +
> +         For more information on KUnit and unit tests in general, please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit
> +
> +         If unsure, say N
> diff --git a/fs/fat/Makefile b/fs/fat/Makefile
> index 70645ce2f7fc..2b034112690d 100644
> --- a/fs/fat/Makefile
> +++ b/fs/fat/Makefile
> @@ -10,3 +10,5 @@ obj-$(CONFIG_MSDOS_FS) += msdos.o
>  fat-y := cache.o dir.o fatent.o file.o inode.o misc.o nfs.o
>  vfat-y := namei_vfat.o
>  msdos-y := namei_msdos.o
> +
> +obj-$(CONFIG_FAT_KUNIT_TEST) += fat_test.o
> diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
> new file mode 100644
> index 000000000000..febd25f57d4b
> --- /dev/null
> +++ b/fs/fat/fat_test.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for FAT filesystems.
> + *
> + * Copyright (C) 2020 Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +#include <kunit/test.h>
> +
> +#include "fat.h"
> +
> +static void fat_checksum_test(struct kunit *test)
> +{
> +       /* With no extension. */
> +       KUNIT_EXPECT_EQ(test, fat_checksum("VMLINUX    "), (u8)44);
> +       /* With 3-letter extension. */
> +       KUNIT_EXPECT_EQ(test, fat_checksum("README  TXT"), (u8)115);
> +       /* With short (1-letter) extension. */
> +       KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), (u8)98);
> +}
> +
> +
> +struct fat_timestamp_testcase {
> +       const char *name;
> +       struct timespec64 ts;
> +       __le16 time;
> +       __le16 date;
> +       u8 cs;
> +       int time_offset;

Optional: it could be easier to read if we grouped the fields together, e.g.

struc timespec64 ts;
/* fields used by FAT */
time, date, cs;
int time_offset;

Or we could add a test-only struct

struct fat_timestamp {
  time, date, cs;
};

to keep things more readable, e.g. in unix2fat_test

struct fat_timestamp got;
...
KUNIT_EXPECT_EQ_MSG(test, test_case->cs, got.cs, "...")


> +};
> +
> +static struct fat_timestamp_testcase time_test_cases[] = {
> +       {
> +               .name = "Earliest possible UTC (1980-01-01 00:00:00)",
> +               .ts = {.tv_sec = 315532800LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(0),
> +               .date = cpu_to_le16(33),
> +               .cs = 0,
> +               .time_offset = 0,
> +       },
> +       {
> +               .name = "Latest possible UTC (2107-12-31 23:59:58)",
> +               .ts = {.tv_sec = 4354819198LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(49021),
> +               .date = cpu_to_le16(65439),
> +               .cs = 0,
> +               .time_offset = 0,
> +       },
> +       {
> +               .name = "Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)",
> +               .ts = {.tv_sec = 315493200LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(0),
> +               .date = cpu_to_le16(33),
> +               .cs = 0,
> +               .time_offset = 11 * 60,
> +       },
> +       {
> +               .name = "Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)",
> +               .ts = {.tv_sec = 4354858798LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(49021),
> +               .date = cpu_to_le16(65439),
> +               .cs = 0,
> +               .time_offset = -11 * 60,
> +       },
> +       {
> +               .name = "Leap Day / Year (1996-02-29 00:00:00)",
> +               .ts = {.tv_sec = 825552000LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(0),
> +               .date = cpu_to_le16(8285),
> +               .cs = 0,
> +               .time_offset = 0,
> +       },
> +       {
> +               .name = "Year 2000 is leap year (2000-02-29 00:00:00)",
> +               .ts = {.tv_sec = 951782400LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(0),
> +               .date = cpu_to_le16(10333),
> +               .cs = 0,
> +               .time_offset = 0,
> +       },
> +       {
> +               .name = "Year 2100 not leap year (2100-03-01 00:00:00)",
> +               .ts = {.tv_sec = 4107542400LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(0),
> +               .date = cpu_to_le16(61537),
> +               .cs = 0,
> +               .time_offset = 0,
> +       },
> +       {
> +               .name = "Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)",
> +               .ts = {.tv_sec = 1078014600LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(48064),
> +               .date = cpu_to_le16(12380),
> +               .cs = 0,
> +               .time_offset = -60,
> +       },
> +       {
> +               .name = "Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)",
> +               .ts = {.tv_sec = 1078097400LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(960),
> +               .date = cpu_to_le16(12385),
> +               .cs = 0,
> +               .time_offset = 60,
> +       },
> +       {
> +               .name = "VFAT odd-second resolution (1999-12-31 23:59:59)",
> +               .ts = {.tv_sec = 946684799LL, .tv_nsec = 0L},
> +               .time = cpu_to_le16(49021),
> +               .date = cpu_to_le16(10143),
> +               .cs = 100,
> +               .time_offset = 0,
> +       },
> +       {
> +               .name = "VFAT 10ms resolution (1980-01-01 00:00:00:0010)",
> +               .ts = {.tv_sec = 315532800LL, .tv_nsec = 10000000L},
> +               .time = cpu_to_le16(0),
> +               .date = cpu_to_le16(33),
> +               .cs = 1,
> +               .time_offset = 0,
> +       },
> +};
> +
> +static void time_testcase_desc(struct fat_timestamp_testcase *t,
> +                              char *desc)
> +{
> +       strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +KUNIT_ARRAY_PARAM(fat_time, time_test_cases, time_testcase_desc);
> +
> +static void fat_time_fat2unix_test(struct kunit *test)
> +{
> +       static struct msdos_sb_info fake_sb;
> +       struct timespec64 ts;
> +       struct fat_timestamp_testcase *testcase =
> +               (struct fat_timestamp_testcase *)test->param_value;
> +
> +       fake_sb.options.tz_set = 1;
> +       fake_sb.options.time_offset = testcase->time_offset;
> +
> +       fat_time_fat2unix(&fake_sb, &ts,
> +                         testcase->time,
> +                         testcase->date,
> +                         testcase->cs);
> +       KUNIT_EXPECT_EQ_MSG(test,
> +                           testcase->ts.tv_sec,
> +                           ts.tv_sec,
> +                           "Timestamp mismatch (seconds)\n");

Nit: if I delete these \n's, I don't see a difference in kunit.py output.
I also don't think I see a difference in the raw output either.

If I put \n\n, then I'll see a difference.

So should we drop these single trailing \n?

> +       KUNIT_EXPECT_EQ_MSG(test,
> +                           testcase->ts.tv_nsec,
> +                           ts.tv_nsec,
> +                           "Timestamp mismatch (nanoseconds)\n");
> +}
> +
> +static void fat_time_unix2fat_test(struct kunit *test)
> +{
> +       static struct msdos_sb_info fake_sb;
> +       __le16 date, time;
> +       u8 cs;
> +       struct fat_timestamp_testcase *testcase =
> +               (struct fat_timestamp_testcase *)test->param_value;
> +
> +       fake_sb.options.tz_set = 1;
> +       fake_sb.options.time_offset = testcase->time_offset;
> +
> +       fat_time_unix2fat(&fake_sb, &(testcase->ts),
> +                         &time, &date, &cs);
> +       KUNIT_EXPECT_EQ_MSG(test,
> +                           le16_to_cpu(testcase->time),
> +                           le16_to_cpu(time),
> +                           "Time mismatch\n");
> +       KUNIT_EXPECT_EQ_MSG(test,
> +                           le16_to_cpu(testcase->date),
> +                           le16_to_cpu(date),
> +                           "Date mismatch\n");
> +       KUNIT_EXPECT_EQ_MSG(test,
> +                           testcase->cs,
> +                           cs,
> +                           "Centisecond mismatch\n");
> +}
> +
> +static struct kunit_case fat_test_cases[] = {
> +       KUNIT_CASE(fat_checksum_test),
> +       KUNIT_CASE_PARAM(fat_time_fat2unix_test, fat_time_gen_params),
> +       KUNIT_CASE_PARAM(fat_time_unix2fat_test, fat_time_gen_params),
> +       {},
> +};
> +
> +static struct kunit_suite fat_test_suite = {
> +       .name = "fat_test",
> +       .test_cases = fat_test_cases,
> +};
> +
> +kunit_test_suites(&fat_test_suite);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 18a50a46b57f..9073fa927be3 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -229,6 +229,8 @@ void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
>                 ts->tv_nsec = 0;
>         }
>  }
> +/* Export fat_time_fat2unix() for the fat_test KUnit tests. */
> +EXPORT_SYMBOL_GPL(fat_time_fat2unix);
>
>  /* Convert linear UNIX date to a FAT time/date pair. */
>  void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
> --
> 2.31.1.368.gbe11c130af-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210416065623.882364-1-davidgow%40google.com.
