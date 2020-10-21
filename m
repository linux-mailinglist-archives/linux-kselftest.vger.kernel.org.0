Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6369C294814
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 08:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408618AbgJUGRV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 02:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408616AbgJUGRU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 02:17:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B78C0613CE
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 23:17:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z4so1432739ybk.15
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 23:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=LpVIGd5HIuX+qLRAJrr12jqUKjRV3zOFha5ePu1lKMs=;
        b=XJZLHIVVr78b5gQtRZoyfofdEFSxz7eksjGKiWtpfTiXxanvywbWMgSsdqBpJVAbYT
         zj0UvL0dayGuVixjCYRrIOte6O8gHi68xFn9ZAWufzltHelG+M89QIUMuU1IYkJFs0oo
         c8fLxQxfoSUIoN3NKQU2Wb+Djy4l6IhMf6t7FlrgY36IZkjLEv6tIQqNiNKZn65HPzs/
         g05+xSAeA76Hp0X97UDWqm5m13q/yUTSYL6ZlcB45sIZtoNi2tL5U9c74NUUIzh9GXL0
         drrICeVV5L9MbpWnsAGpUvIkGGKpSenB4Qlm58kkb66SX+0/EAFcgwxqMXYWEbbieB9B
         twCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=LpVIGd5HIuX+qLRAJrr12jqUKjRV3zOFha5ePu1lKMs=;
        b=hzoKVuNgOCzjz+PP/7iTriJk+/7JmYeS694kCA7ytZyV34/TVcdJHXbIGaaPADhmKM
         1GYFM2Y27B3W/hP8/LiLmQGQ9zOdNLAl9wsGWNTzCzWBSHcnl3HYKKT2W6nh+dZikRT1
         yns46ae1OjXlOPgAX7yj/PobYXKMBgV/E/fMDURUaSdD0amMVrp9GDqJrz17gXkdPvEL
         S5OaJXHz9ZhfLrZ43qwsQufD3aiOJj1lfM0lb6YzpSQ8kyr0RAccei7INQbLs5B92Iwe
         i4mW4CoiXsd4MuwDLMzp+SSWSPwk5laYfR1mX/yOew5H2/A7RgDpQGa/apx61oi7OwgM
         w2XQ==
X-Gm-Message-State: AOAM531bZGl9oNifo99KtWYrro5wfD13KFNRErFacOEMvPIMBoqodpu0
        GRQrQhBTgvcwJO2ijkgwfbqosUaQ9/po+w==
X-Google-Smtp-Source: ABdhPJy+0T6e13GUud3Sb7WLqPqfHI7lfqHvkesUYYEdbp/sA0eepH4W4uc2EehWwxwD2QkDZfmkkEHBD8RA6Q==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:a224:: with SMTP id
 b33mr3158364ybi.109.1603261039492; Tue, 20 Oct 2020 23:17:19 -0700 (PDT)
Date:   Tue, 20 Oct 2020 23:17:13 -0700
Message-Id: <20201021061713.1545931-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v3] fat: Add KUnit tests for checksums and timestamps
From:   David Gow <davidgow@google.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
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

Changes since v2:
https://lore.kernel.org/linux-kselftest/20201020055856.1270482-1-davidgow@google.com/
- Comment that the export for fat_time_fat2unix() function is for KUnit
  tests.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20201017064107.375174-1-davidgow@google.com/
- Now export fat_time_fat2unix() so that the test can access it when
  built as a module.

Cheers,
-- David

 fs/fat/Kconfig    |  13 +++
 fs/fat/Makefile   |   2 +
 fs/fat/fat_test.c | 196 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/misc.c     |   2 +
 4 files changed, 213 insertions(+)
 create mode 100644 fs/fat/fat_test.c

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index 66532a71e8fd..fdef03b79c69 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -115,3 +115,16 @@ config FAT_DEFAULT_UTF8
 	  Say Y if you use UTF-8 encoding for file names, N otherwise.
 
 	  See <file:Documentation/filesystems/vfat.rst> for more information.
+
+config FAT_KUNIT_TEST
+	tristate "Unit Tests for FAT filesystems" if !KUNIT_ALL_TESTS
+	select FAT_FS
+	depends on KUNIT
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
index 000000000000..c99bfbdf89bb
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
+	KUNIT_EXPECT_EQ(test, fat_checksum("VMLINUX    "), 44);
+	/* With 3-letter extension. */
+	KUNIT_EXPECT_EQ(test, fat_checksum("README  TXT"), 115);
+	/* With short (1-letter) extension. */
+	KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), 98);
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
+const static struct fat_timestamp_testcase time_test_cases[] = {
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
+	struct msdos_sb_info fake_sb;
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
+	struct msdos_sb_info fake_sb;
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

base-commit: c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
-- 
2.29.0.rc1.297.gfa9743e501-goog

