Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F492910C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Oct 2020 10:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437688AbgJQI1j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Oct 2020 04:27:39 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:40438 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437686AbgJQI1i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Oct 2020 04:27:38 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2020 04:27:37 EDT
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id C4A021B3B65;
        Sat, 17 Oct 2020 17:19:12 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 09H8JBBu1521675
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 17 Oct 2020 17:19:12 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 09H8JBR81459094
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 17 Oct 2020 17:19:11 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 09H8JAU71459093;
        Sat, 17 Oct 2020 17:19:10 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: Add KUnit tests for checksums and timestamps
References: <20201017064107.375174-1-davidgow@google.com>
Date:   Sat, 17 Oct 2020 17:19:10 +0900
In-Reply-To: <20201017064107.375174-1-davidgow@google.com> (David Gow's
        message of "Fri, 16 Oct 2020 23:41:07 -0700")
Message-ID: <87o8l1tgch.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David Gow <davidgow@google.com> writes:

> Add some basic sanity-check tests for the fat_checksum() function and
> the fat_time_unix2fat() and fat_time_fat2unix() functions. These unit
> tests verify these functions return correct output for a number of test
> inputs.
>
> These tests were inspored by -- and serve a similar purpose to -- the
> timestamp parsing KUnit tests in ext4[1].
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/inode-test.c
>
> Signed-off-by: David Gow <davidgow@google.com>

Looks good, thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/Kconfig    |  13 +++
>  fs/fat/Makefile   |   2 +
>  fs/fat/fat_test.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 fs/fat/fat_test.c
>
> diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> index 66532a71e8fd..fdef03b79c69 100644
> --- a/fs/fat/Kconfig
> +++ b/fs/fat/Kconfig
> @@ -115,3 +115,16 @@ config FAT_DEFAULT_UTF8
>  	  Say Y if you use UTF-8 encoding for file names, N otherwise.
>  
>  	  See <file:Documentation/filesystems/vfat.rst> for more information.
> +
> +config FAT_KUNIT_TEST
> +	tristate "Unit Tests for FAT filesystems" if !KUNIT_ALL_TESTS
> +	select FAT_FS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the FAT KUnit tests
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit
> +
> +	  If unsure, say N
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
> index 000000000000..c1b4348b9b3b
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
> +	/* With no extension. */
> +	KUNIT_EXPECT_EQ(test, fat_checksum("VMLINUX    "), 44);
> +	/* With 3-letter extension. */
> +	KUNIT_EXPECT_EQ(test, fat_checksum("README  TXT"), 115);
> +	/* With short (1-letter) extension. */
> +	KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), 98);
> +}
> +
> +
> +struct fat_timestamp_testcase {
> +	const char *name;
> +	struct timespec64 ts;
> +	__le16 time;
> +	__le16 date;
> +	u8 cs;
> +	int time_offset;
> +};
> +
> +const static struct fat_timestamp_testcase time_test_cases[] = {
> +	{
> +		.name = "Earliest possible UTC (1980-01-01 00:00:00)",
> +		.ts = {.tv_sec = 315532800LL, .tv_nsec = 0L},
> +		.time = 0,
> +		.date = 33,
> +		.cs = 0,
> +		.time_offset = 0,
> +	},
> +	{
> +		.name = "Latest possible UTC (2107-12-31 23:59:58)",
> +		.ts = {.tv_sec = 4354819198LL, .tv_nsec = 0L},
> +		.time = 49021,
> +		.date = 65439,
> +		.cs = 0,
> +		.time_offset = 0,
> +	},
> +	{
> +		.name = "Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)",
> +		.ts = {.tv_sec = 315493200LL, .tv_nsec = 0L},
> +		.time = 0,
> +		.date = 33,
> +		.cs = 0,
> +		.time_offset = 11 * 60,
> +	},
> +	{
> +		.name = "Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)",
> +		.ts = {.tv_sec = 4354858798LL, .tv_nsec = 0L},
> +		.time = 49021,
> +		.date = 65439,
> +		.cs = 0,
> +		.time_offset = -11 * 60,
> +	},
> +	{
> +		.name = "Leap Day / Year (1996-02-29 00:00:00)",
> +		.ts = {.tv_sec = 825552000LL, .tv_nsec = 0L},
> +		.time = 0,
> +		.date = 8285,
> +		.cs = 0,
> +		.time_offset = 0,
> +	},
> +	{
> +		.name = "Year 2000 is leap year (2000-02-29 00:00:00)",
> +		.ts = {.tv_sec = 951782400LL, .tv_nsec = 0L},
> +		.time = 0,
> +		.date = 10333,
> +		.cs = 0,
> +		.time_offset = 0,
> +	},
> +	{
> +		.name = "Year 2100 not leap year (2100-03-01 00:00:00)",
> +		.ts = {.tv_sec = 4107542400LL, .tv_nsec = 0L},
> +		.time = 0,
> +		.date = 61537,
> +		.cs = 0,
> +		.time_offset = 0,
> +	},
> +	{
> +		.name = "Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)",
> +		.ts = {.tv_sec = 1078014600LL, .tv_nsec = 0L},
> +		.time = 48064,
> +		.date = 12380,
> +		.cs = 0,
> +		.time_offset = -60,
> +	},
> +	{
> +		.name = "Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)",
> +		.ts = {.tv_sec = 1078097400LL, .tv_nsec = 0L},
> +		.time = 960,
> +		.date = 12385,
> +		.cs = 0,
> +		.time_offset = 60,
> +	},
> +	{
> +		.name = "VFAT odd-second resolution (1999-12-31 23:59:59)",
> +		.ts = {.tv_sec = 946684799LL, .tv_nsec = 0L},
> +		.time = 49021,
> +		.date = 10143,
> +		.cs = 100,
> +		.time_offset = 0,
> +	},
> +	{
> +		.name = "VFAT 10ms resolution (1980-01-01 00:00:00:0010)",
> +		.ts = {.tv_sec = 315532800LL, .tv_nsec = 10000000L},
> +		.time = 0,
> +		.date = 33,
> +		.cs = 1,
> +		.time_offset = 0,
> +	},
> +};
> +
> +static void fat_time_fat2unix_test(struct kunit *test)
> +{
> +	struct msdos_sb_info fake_sb;
> +	int i;
> +	struct timespec64 ts;
> +
> +	for (i = 0; i < ARRAY_SIZE(time_test_cases); ++i) {
> +		fake_sb.options.tz_set = 1;
> +		fake_sb.options.time_offset = time_test_cases[i].time_offset;
> +
> +		fat_time_fat2unix(&fake_sb, &ts,
> +				  time_test_cases[i].time,
> +				  time_test_cases[i].date,
> +				  time_test_cases[i].cs);
> +		KUNIT_EXPECT_EQ_MSG(test,
> +				    time_test_cases[i].ts.tv_sec,
> +				    ts.tv_sec,
> +				    "Timestamp mismatch (seconds) in case \"%s\"\n",
> +				    time_test_cases[i].name);
> +		KUNIT_EXPECT_EQ_MSG(test,
> +				    time_test_cases[i].ts.tv_nsec,
> +				    ts.tv_nsec,
> +				    "Timestamp mismatch (nanoseconds) in case \"%s\"\n",
> +				    time_test_cases[i].name);
> +	}
> +}
> +
> +static void fat_time_unix2fat_test(struct kunit *test)
> +{
> +	struct msdos_sb_info fake_sb;
> +	int i;
> +	__le16 date, time;
> +	u8 cs;
> +
> +	for (i = 0; i < ARRAY_SIZE(time_test_cases); ++i) {
> +		fake_sb.options.tz_set = 1;
> +		fake_sb.options.time_offset = time_test_cases[i].time_offset;
> +
> +		fat_time_unix2fat(&fake_sb, &time_test_cases[i].ts,
> +				  &time, &date, &cs);
> +		KUNIT_EXPECT_EQ_MSG(test,
> +				    time_test_cases[i].time,
> +				    time,
> +				    "Time mismatch in case \"%s\"\n",
> +				    time_test_cases[i].name);
> +		KUNIT_EXPECT_EQ_MSG(test,
> +				    time_test_cases[i].date,
> +				    date,
> +				    "Date mismatch in case \"%s\"\n",
> +				    time_test_cases[i].name);
> +		KUNIT_EXPECT_EQ_MSG(test,
> +				    time_test_cases[i].cs,
> +				    cs,
> +				    "Centisecond mismatch in case \"%s\"\n",
> +				    time_test_cases[i].name);
> +	}
> +}
> +
> +static struct kunit_case fat_test_cases[] = {
> +	KUNIT_CASE(fat_checksum_test),
> +	KUNIT_CASE(fat_time_fat2unix_test),
> +	KUNIT_CASE(fat_time_unix2fat_test),
> +	{},
> +};
> +
> +static struct kunit_suite fat_test_suite = {
> +	.name = "fat_test",
> +	.test_cases = fat_test_cases,
> +};
> +
> +kunit_test_suites(&fat_test_suite);
> +
> +MODULE_LICENSE("GPL v2");
> +

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
