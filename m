Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5080E29E258
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 03:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgJ2CNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 22:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgJ1VgN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:13 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642AC0613D2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 14:36:12 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 19so464883pgq.18
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=yII+uaPvsxE2PFp2I5rOuRDVFOZv5fLj07T+nkGzp8I=;
        b=jlkuo3B6Pl1F3Vn2vJ1XYaPHDcKxuyzwX9wOlmIlQZ5LS98gKuKoGvFsMEtmEVoUbw
         4dwUSr2Gt9DVZDgx3TdbqbSxzYOsEZFuMlDPm0tCOqP88Tt+iNpbQJDxGPJ9w/1tGZHY
         8isvU3m/iicX8E9SjdGFjIBqUoooCYZytD2pVroFUiYZ+dz86sJiNeANhiNs2OtSfxKU
         6e1NLLtXPmr5U8FFyOBcx1DixK4JdAVyNWe1O4kweUhE+SX3QN2o7MzW7V2ktBu2Bdx6
         ERntghE3GdbO1c2dmKMBfXPCWC7zzPL/Wt1bXwIAiiYMmE2flSk8q+538za+ps1ObJsR
         RNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=yII+uaPvsxE2PFp2I5rOuRDVFOZv5fLj07T+nkGzp8I=;
        b=dlmsfTn8g5NTYOHVKOsKRJxv2w0ucoHM/Bo5qbu0OPgiZVvO/PQfmDaE0JtQclm22z
         VQsFk4sdgIvf/8WOoHYTNa9eTDfPrIvayYCuR5C0VANT+tHmHPDS3yqzus4zv8zwc9hr
         ZXzHB6IxXiwGhnf4+OEyNsI2Rja5I2EtWtEkBmuoF2MAcoSiFWEF/swbs7mar3MP4q+Y
         VCse/Nlv2vwAcOZxczvOsF4/rzwwV+SLI5w5hVmUpB529DyPlfVtoAfhCa7UrynU2YME
         xfVwA9XPiBpJ6/19wQ+ZiiJqFmrQUoAvxhO25kQJOYlUWs80oWdIdWCfSINbpjQqHWgW
         4Dcw==
X-Gm-Message-State: AOAM530r+Yqrc7hhhqn60d0jSpe+L5cTqZgFnMnpc2mCqxmL62XdIqfq
        UgPyZwj9IeZ3NhzYOwVeC0Zx9ZQwfVHhaQ==
X-Google-Smtp-Source: ABdhPJxLIJ9PHbbT1ONFSucgDLd3mRofoKorc6p0Tm+XdGf3VmYW3RsT1qZlYHtJvNRytkbW9hmRSz8QlKF3QA==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a0c:c2ce:: with SMTP id
 c14mr1791050qvi.20.1603867714279; Tue, 27 Oct 2020 23:48:34 -0700 (PDT)
Date:   Tue, 27 Oct 2020 23:46:31 -0700
Message-Id: <20201028064631.3774908-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7] fat: Add KUnit tests for checksums and timestamps
From:   David Gow <davidgow@google.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
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



 fs/fat/Kconfig    |  14 +++-
 fs/fat/Makefile   |   2 +
 fs/fat/fat_test.c | 196 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/misc.c     |   2 +
 4 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 fs/fat/fat_test.c

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
index 000000000000..7d3fe928fbe6
--- /dev/null
+++ b/fs/fat/fat_test.c
@@ -0,0 +1,196 @@
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
+		.time = 0,
+		.date = 33,
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Latest possible UTC (2107-12-31 23:59:58)",
+		.ts = {.tv_sec = 4354819198LL, .tv_nsec = 0L},
+		.time = 49021,
+		.date = 65439,
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)",
+		.ts = {.tv_sec = 315493200LL, .tv_nsec = 0L},
+		.time = 0,
+		.date = 33,
+		.cs = 0,
+		.time_offset = 11 * 60,
+	},
+	{
+		.name = "Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)",
+		.ts = {.tv_sec = 4354858798LL, .tv_nsec = 0L},
+		.time = 49021,
+		.date = 65439,
+		.cs = 0,
+		.time_offset = -11 * 60,
+	},
+	{
+		.name = "Leap Day / Year (1996-02-29 00:00:00)",
+		.ts = {.tv_sec = 825552000LL, .tv_nsec = 0L},
+		.time = 0,
+		.date = 8285,
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Year 2000 is leap year (2000-02-29 00:00:00)",
+		.ts = {.tv_sec = 951782400LL, .tv_nsec = 0L},
+		.time = 0,
+		.date = 10333,
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Year 2100 not leap year (2100-03-01 00:00:00)",
+		.ts = {.tv_sec = 4107542400LL, .tv_nsec = 0L},
+		.time = 0,
+		.date = 61537,
+		.cs = 0,
+		.time_offset = 0,
+	},
+	{
+		.name = "Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)",
+		.ts = {.tv_sec = 1078014600LL, .tv_nsec = 0L},
+		.time = 48064,
+		.date = 12380,
+		.cs = 0,
+		.time_offset = -60,
+	},
+	{
+		.name = "Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)",
+		.ts = {.tv_sec = 1078097400LL, .tv_nsec = 0L},
+		.time = 960,
+		.date = 12385,
+		.cs = 0,
+		.time_offset = 60,
+	},
+	{
+		.name = "VFAT odd-second resolution (1999-12-31 23:59:59)",
+		.ts = {.tv_sec = 946684799LL, .tv_nsec = 0L},
+		.time = 49021,
+		.date = 10143,
+		.cs = 100,
+		.time_offset = 0,
+	},
+	{
+		.name = "VFAT 10ms resolution (1980-01-01 00:00:00:0010)",
+		.ts = {.tv_sec = 315532800LL, .tv_nsec = 10000000L},
+		.time = 0,
+		.date = 33,
+		.cs = 1,
+		.time_offset = 0,
+	},
+};
+
+static void fat_time_fat2unix_test(struct kunit *test)
+{
+	static struct msdos_sb_info fake_sb;
+	int i;
+	struct timespec64 ts;
+
+	for (i = 0; i < ARRAY_SIZE(time_test_cases); ++i) {
+		fake_sb.options.tz_set = 1;
+		fake_sb.options.time_offset = time_test_cases[i].time_offset;
+
+		fat_time_fat2unix(&fake_sb, &ts,
+				  time_test_cases[i].time,
+				  time_test_cases[i].date,
+				  time_test_cases[i].cs);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    time_test_cases[i].ts.tv_sec,
+				    ts.tv_sec,
+				    "Timestamp mismatch (seconds) in case \"%s\"\n",
+				    time_test_cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    time_test_cases[i].ts.tv_nsec,
+				    ts.tv_nsec,
+				    "Timestamp mismatch (nanoseconds) in case \"%s\"\n",
+				    time_test_cases[i].name);
+	}
+}
+
+static void fat_time_unix2fat_test(struct kunit *test)
+{
+	static struct msdos_sb_info fake_sb;
+	int i;
+	__le16 date, time;
+	u8 cs;
+
+	for (i = 0; i < ARRAY_SIZE(time_test_cases); ++i) {
+		fake_sb.options.tz_set = 1;
+		fake_sb.options.time_offset = time_test_cases[i].time_offset;
+
+		fat_time_unix2fat(&fake_sb, &time_test_cases[i].ts,
+				  &time, &date, &cs);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    time_test_cases[i].time,
+				    time,
+				    "Time mismatch in case \"%s\"\n",
+				    time_test_cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    time_test_cases[i].date,
+				    date,
+				    "Date mismatch in case \"%s\"\n",
+				    time_test_cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    time_test_cases[i].cs,
+				    cs,
+				    "Centisecond mismatch in case \"%s\"\n",
+				    time_test_cases[i].name);
+	}
+}
+
+static struct kunit_case fat_test_cases[] = {
+	KUNIT_CASE(fat_checksum_test),
+	KUNIT_CASE(fat_time_fat2unix_test),
+	KUNIT_CASE(fat_time_unix2fat_test),
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
index f1b2a1fc2a6a..3eabd07b38e2 100644
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
2.29.1.341.ge80a0c044ae-goog

