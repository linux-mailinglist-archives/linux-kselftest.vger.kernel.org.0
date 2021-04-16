Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D76E361A26
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Apr 2021 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbhDPG4w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Apr 2021 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhDPG4w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Apr 2021 02:56:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFC3C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 23:56:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e185so5135175ybf.4
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 23:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yfznvfhxWI9IPMcPWR1ywqNo58hzVB/wvWPYLtjWjJA=;
        b=nviH1F8KnTn88UrvTJwTfvUOO+no5bQSXE8NWrlfdAhBzYFyQ/DBz6VWd5b1Jxwhr7
         br7uE1lU43XzhdfU95wtewDjQGMIDsLPUj5ija1ZGe9Shjb1t7D4UbfOvuRGYHx+2mNQ
         es9SDiHcz0tt5n7Sjb21bfpIZKTMLpiZajZ9AdHj5/ZcEBy50i8CzAWDMlytXT9/T1m8
         V0XpWxQlwU8Cv0WsMPiygGMqCRSjMJhXuCD/X3S+0ESszetB5syUqIKi+P0tbVXqXnPx
         m/ISy28aAyDrRFqgpb4y1pu2T+tH9/mTZJoIHCVzKSo8rH97Vz07dbbrjztNtKPbnlyv
         aX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yfznvfhxWI9IPMcPWR1ywqNo58hzVB/wvWPYLtjWjJA=;
        b=Zm7eqvZst7iOIpIq95ey4gsH+g+meD/mjyHzDfUQUWFvGb+3qKVfIdmOb6MEO3cIP1
         fA2FB4LSy3KwZJobLzoonmQNreAKjzQlrfXYTwrjECQIHW8zTDgWB9x0atL8Er44TUBp
         tU6UjrOhngyb8xUypj3ozb+J8rj8KcoroEALgyerdH8wAMGan14JBheyU4SHmBnhXw35
         sqpjmKtnOspVmvrdTqxfHSVQ8sEQf3DzTALa3jR6jounzzwZzASV4kd7j48ZFPnp2H9l
         esharPCEuUVKJn5lbvxKfLf5guct/HFVVnyYUOEHQjBO3eHdrdh0JTM5zhS6717qa9LE
         ukyA==
X-Gm-Message-State: AOAM533OPtSqal8iAFnaw4ubDMa2ctkVhIrUWzF6Wv27rgbEiq4mWslg
        UJsQlFYdmZHRy/5QnFxPZSCEO0EdkLQYXg==
X-Google-Smtp-Source: ABdhPJxz0+kbsgxZyDgYjIKLVabLgCKP2FXN2R11XrBOHmwX6Pp/Grsy8+JgwSKbUdUI6dvJtyRW2j1Jv6hRpQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:fe36:58a6:c432:3234])
 (user=davidgow job=sendgmr) by 2002:a25:2443:: with SMTP id
 k64mr10032328ybk.154.1618556187020; Thu, 15 Apr 2021 23:56:27 -0700 (PDT)
Date:   Thu, 15 Apr 2021 23:56:23 -0700
Message-Id: <20210416065623.882364-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v8] fat: Add KUnit tests for checksums and timestamps
From:   David Gow <davidgow@google.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some basic sanity-check tests for the fat_checksum() function and
the fat_time_unix2fat() and fat_time_fat2unix() functions. These unit
tests verify these functions return correct output for a number of test
inputs.

These tests were inspored by -- and serve a similar purpose to -- the
timestamp parsing KUnit tests in ext4[1].

Note that, unlike fat_time_unix2fat, fat_time_fat2unix wasn't previously
exported, so this patch exports it as well. This is required for the
case where we're building the fat and fat_test as modules.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/inode-test.c

Signed-off-by: David Gow <davidgow@google.com>
Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

It's been a while, but this hopefully is a final version of the FAT KUnit
patchset. It has a number of changes to keep it up-to-date with current
KUnit standards, notably the use of parameterised tests and the addition
of a '.kunitconfig' file to allow for easy testing. It also fixes an
endianness tagging issue picked up by the kernel test robot under sparse
on pa-risc.

Cheers,
-- David

Changes since v7:
https://lore.kernel.org/linux-kselftest/20201028064631.3774908-1-davidgow@google.com/
- Make the two timestamp tests parameterised: this means that the KUnit
  runtime and tooling are aware of the different testcases (and print a
  nice list of them to the TAP log when the test is run).
- Fix some issues sparse picked up with __le32 tagged integers.
- Add an fs/fat/.kunitconfig file which contains all the Kconfig entries
  needed to run the test. The test can now be run with:
  ./tools/testing/kunit/kunit.py run --kunitconfig fs/fat/.kunitconfig

Changes since v6:
https://lore.kernel.org/linux-kselftest/20201024060558.2556249-1-davidgow@google.com/
- Make CONFIG_FAT_DEFAULT_CODEPAGE depend on FAT_FS, rather than either
  VFAT_FS or MSDOS_FS.
  - This means that FAT_KUNIT_TEST can now also just depend of FAT_FS
- Fix a few warnings that KUnit tool was eating:
  - KUnit's type checking needs a specific cast for the fat_checksum()
    expected results.
  - The time test cases shouldn't be 'const'
  - The fake superblock is now static, as otherwise it increased the
    stack size too much.

Changes since v4/5:
https://lore.kernel.org/linux-kselftest/20201024052047.2526780-1-davidgow@google.com/
- Fix a typo introduced in the Kconfig. It builds now.

Changes since v3:
https://lore.kernel.org/linux-kselftest/20201021061713.1545931-1-davidgow@google.com/
- Update the Kconfig entry to use "depends on" rather than "select", as
  discussed in [2].
- Depend on "MSDOS_FS || VFAT_FS", rather than "FAT_FS", as we need the
  CONFIG_FAT_DEFAULT_CODEPAGE symbol to be defined.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20201020055856.1270482-1-davidgow@google.com/
- Comment that the export for fat_time_fat2unix() function is for KUnit
  tests.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20201017064107.375174-1-davidgow@google.com/
- Now export fat_time_fat2unix() so that the test can access it when
  built as a module.


[2]:
https://lore.kernel.org/linux-ext4/52959e99-4105-3de9-730c-c46894b82bdd@infradead.org/T/#t



 fs/fat/.kunitconfig |   5 ++
 fs/fat/Kconfig      |  14 +++-
 fs/fat/Makefile     |   2 +
 fs/fat/fat_test.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/misc.c       |   2 +
 5 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 fs/fat/.kunitconfig
 create mode 100644 fs/fat/fat_test.c

diff --git a/fs/fat/.kunitconfig b/fs/fat/.kunitconfig
new file mode 100644
index 000000000000..0a6971dbeccb
--- /dev/null
+++ b/fs/fat/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_KUNIT_TEST=y
diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index 66532a71e8fd..238cc55f84c4 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -77,7 +77,7 @@ config VFAT_FS
 
 config FAT_DEFAULT_CODEPAGE
 	int "Default codepage for FAT"
-	depends on MSDOS_FS || VFAT_FS
+	depends on FAT_FS
 	default 437
 	help
 	  This option should be set to the codepage of your FAT filesystems.
@@ -115,3 +115,15 @@ config FAT_DEFAULT_UTF8
 	  Say Y if you use UTF-8 encoding for file names, N otherwise.
 
 	  See <file:Documentation/filesystems/vfat.rst> for more information.
+
+config FAT_KUNIT_TEST
+	tristate "Unit Tests for FAT filesystems" if !KUNIT_ALL_TESTS
+	depends on KUNIT && FAT_FS
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the FAT KUnit tests
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit
+
+	  If unsure, say N
diff --git a/fs/fat/Makefile b/fs/fat/Makefile
index 70645ce2f7fc..2b034112690d 100644
--- a/fs/fat/Makefile
+++ b/fs/fat/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_MSDOS_FS) += msdos.o
 fat-y := cache.o dir.o fatent.o file.o inode.o misc.o nfs.o
 vfat-y := namei_vfat.o
 msdos-y := namei_msdos.o
+
+obj-$(CONFIG_FAT_KUNIT_TEST) += fat_test.o
diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
new file mode 100644
index 000000000000..febd25f57d4b
--- /dev/null
+++ b/fs/fat/fat_test.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for FAT filesystems.
+ *
+ * Copyright (C) 2020 Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+#include <kunit/test.h>
+
+#include "fat.h"
+
+static void fat_checksum_test(struct kunit *test)
+{
+	/* With no extension. */
+	KUNIT_EXPECT_EQ(test, fat_checksum("VMLINUX    "), (u8)44);
+	/* With 3-letter extension. */
+	KUNIT_EXPECT_EQ(test, fat_checksum("README  TXT"), (u8)115);
+	/* With short (1-letter) extension. */
+	KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), (u8)98);
+}
+
+
+struct fat_timestamp_testcase {
+	const char *name;
+	struct timespec64 ts;
+	__le16 time;
+	__le16 date;
+	u8 cs;
+	int time_offset;
+};
+
+static struct fat_timestamp_testcase time_test_cases[] = {
+	{
+		.name = "Earliest possible UTC (1980-01-01 00:00:00)",
+		.ts = {.tv_sec = 315532800LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(0),
+		.date = cpu_to_le16(33),
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Latest possible UTC (2107-12-31 23:59:58)",
+		.ts = {.tv_sec = 4354819198LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(49021),
+		.date = cpu_to_le16(65439),
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)",
+		.ts = {.tv_sec = 315493200LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(0),
+		.date = cpu_to_le16(33),
+		.cs = 0,
+		.time_offset = 11 * 60,
+	},
+	{
+		.name = "Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)",
+		.ts = {.tv_sec = 4354858798LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(49021),
+		.date = cpu_to_le16(65439),
+		.cs = 0,
+		.time_offset = -11 * 60,
+	},
+	{
+		.name = "Leap Day / Year (1996-02-29 00:00:00)",
+		.ts = {.tv_sec = 825552000LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(0),
+		.date = cpu_to_le16(8285),
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Year 2000 is leap year (2000-02-29 00:00:00)",
+		.ts = {.tv_sec = 951782400LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(0),
+		.date = cpu_to_le16(10333),
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Year 2100 not leap year (2100-03-01 00:00:00)",
+		.ts = {.tv_sec = 4107542400LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(0),
+		.date = cpu_to_le16(61537),
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)",
+		.ts = {.tv_sec = 1078014600LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(48064),
+		.date = cpu_to_le16(12380),
+		.cs = 0,
+		.time_offset = -60,
+	},
+	{
+		.name = "Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)",
+		.ts = {.tv_sec = 1078097400LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(960),
+		.date = cpu_to_le16(12385),
+		.cs = 0,
+		.time_offset = 60,
+	},
+	{
+		.name = "VFAT odd-second resolution (1999-12-31 23:59:59)",
+		.ts = {.tv_sec = 946684799LL, .tv_nsec = 0L},
+		.time = cpu_to_le16(49021),
+		.date = cpu_to_le16(10143),
+		.cs = 100,
+		.time_offset = 0,
+	},
+	{
+		.name = "VFAT 10ms resolution (1980-01-01 00:00:00:0010)",
+		.ts = {.tv_sec = 315532800LL, .tv_nsec = 10000000L},
+		.time = cpu_to_le16(0),
+		.date = cpu_to_le16(33),
+		.cs = 1,
+		.time_offset = 0,
+	},
+};
+
+static void time_testcase_desc(struct fat_timestamp_testcase *t,
+			       char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(fat_time, time_test_cases, time_testcase_desc);
+
+static void fat_time_fat2unix_test(struct kunit *test)
+{
+	static struct msdos_sb_info fake_sb;
+	struct timespec64 ts;
+	struct fat_timestamp_testcase *testcase =
+		(struct fat_timestamp_testcase *)test->param_value;
+
+	fake_sb.options.tz_set = 1;
+	fake_sb.options.time_offset = testcase->time_offset;
+
+	fat_time_fat2unix(&fake_sb, &ts,
+			  testcase->time,
+			  testcase->date,
+			  testcase->cs);
+	KUNIT_EXPECT_EQ_MSG(test,
+			    testcase->ts.tv_sec,
+			    ts.tv_sec,
+			    "Timestamp mismatch (seconds)\n");
+	KUNIT_EXPECT_EQ_MSG(test,
+			    testcase->ts.tv_nsec,
+			    ts.tv_nsec,
+			    "Timestamp mismatch (nanoseconds)\n");
+}
+
+static void fat_time_unix2fat_test(struct kunit *test)
+{
+	static struct msdos_sb_info fake_sb;
+	__le16 date, time;
+	u8 cs;
+	struct fat_timestamp_testcase *testcase =
+		(struct fat_timestamp_testcase *)test->param_value;
+
+	fake_sb.options.tz_set = 1;
+	fake_sb.options.time_offset = testcase->time_offset;
+
+	fat_time_unix2fat(&fake_sb, &(testcase->ts),
+			  &time, &date, &cs);
+	KUNIT_EXPECT_EQ_MSG(test,
+			    le16_to_cpu(testcase->time),
+			    le16_to_cpu(time),
+			    "Time mismatch\n");
+	KUNIT_EXPECT_EQ_MSG(test,
+			    le16_to_cpu(testcase->date),
+			    le16_to_cpu(date),
+			    "Date mismatch\n");
+	KUNIT_EXPECT_EQ_MSG(test,
+			    testcase->cs,
+			    cs,
+			    "Centisecond mismatch\n");
+}
+
+static struct kunit_case fat_test_cases[] = {
+	KUNIT_CASE(fat_checksum_test),
+	KUNIT_CASE_PARAM(fat_time_fat2unix_test, fat_time_gen_params),
+	KUNIT_CASE_PARAM(fat_time_unix2fat_test, fat_time_gen_params),
+	{},
+};
+
+static struct kunit_suite fat_test_suite = {
+	.name = "fat_test",
+	.test_cases = fat_test_cases,
+};
+
+kunit_test_suites(&fat_test_suite);
+
+MODULE_LICENSE("GPL v2");
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 18a50a46b57f..9073fa927be3 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -229,6 +229,8 @@ void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
 		ts->tv_nsec = 0;
 	}
 }
+/* Export fat_time_fat2unix() for the fat_test KUnit tests. */
+EXPORT_SYMBOL_GPL(fat_time_fat2unix);
 
 /* Convert linear UNIX date to a FAT time/date pair. */
 void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
-- 
2.31.1.368.gbe11c130af-goog

