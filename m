Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99A73FCF88
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Sep 2021 00:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbhHaWUR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 18:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhHaWUP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 18:20:15 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D407EC061575
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Aug 2021 15:19:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b10so1169592ioq.9
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Aug 2021 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language;
        bh=Q4HywcCEJfCcBQAS5pkp0gkCknz0dG6EbUxELQJa7EQ=;
        b=IOsko+dgjp2PTH6o7Au3FWYMITsD/KSZGsae+XFOIuIdydSQ5N3lDH0powv8ZXEDEd
         sGfMtbIJx2AhfAFumbFNFUg4ux/hb0ICJelbLGBNII0A3sn9xIzoXupOQS8ZqYQRNxw/
         CpkjPIRsVp6IYonYTjMQdB+OrNBoyquIZ+UYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language;
        bh=Q4HywcCEJfCcBQAS5pkp0gkCknz0dG6EbUxELQJa7EQ=;
        b=j6uCD6Nh4c73lCRMYQqDfO8THAdpddr0FmmFkMn9Pxs2lpCMmLWMztlQ6USvnK/HOy
         19vlOfZP5gZtIER6ncvctaql6Dx/JZNnYwHp0OGoxUR42vJE4RJ4JgNTIxYO8NEzfnlb
         xUhoT1i3Y5hy8qIZi50S5iiN0HGyxumAd9z8bnjm3VPyljbmYDKt9v/AgXRXkPFFn3DE
         acmP7V9w3RMFB0cEa6/MDh20R6gNZ4EziKzvdQBOdNZwVzbEIJvNuUktHZFFzfDNV/yO
         lc/VbJA1P8FZfi8ZgKuxSZ5YAYaxd/UI3wf5xlg4TdZquWWAe0JZdFXHFydOvyJtPq64
         m4WQ==
X-Gm-Message-State: AOAM530ihSuMKhoEr6NLzJbBfygcqFn7wVGzWCnP5LDIoE5ORjUHtOaI
        1Npb5lOQrLkkm9jRXarx5LpUig==
X-Google-Smtp-Source: ABdhPJxYjf3V6K9z5ybRK1sL/AfjcQWL+rXPU+LZA06Z7CTs3rCak1243BfOyQj3o9iDUKYQNOnaSA==
X-Received: by 2002:a02:9566:: with SMTP id y93mr4884271jah.55.1630448359229;
        Tue, 31 Aug 2021 15:19:19 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c25sm11230804iom.9.2021.08.31.15.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 15:19:18 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <78c09ebd-7377-00f7-2f2e-fbdf30309f18@linuxfoundation.org>
Date:   Tue, 31 Aug 2021 16:19:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DC9ADF906BE2F2476D3C55B7"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------DC9ADF906BE2F2476D3C55B7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit update for Linux 5.15-rc1.

This KUnit update for Linux 5.15-rc1 adds new features and tests:

tool:
-- support for --kernel_args to allow setting module params
-- support for --raw_output option to show just the kunit output during
    make

tests:
-- KUnit tests for checksums and timestamps
-- Print test statistics on failure
-- Integrates UBSAN into the KUnit testing framework.
    It fails KUnit tests whenever it reports undefined behavior.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

   Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.15-rc1

for you to fetch changes up to acd8e8407b8fcc3229d6d8558cac338bea801aed:

   kunit: Print test statistics on failure (2021-08-13 13:38:31 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.15-rc1

This KUnit update for Linux 5.15-rc1 adds new features and tests:

tool:
-- support for --kernel_args to allow setting module params
-- support for --raw_output option to show just the kunit output during
    make

tests:
-- KUnit tests for checksums and timestamps
-- Print test statistics on failure
-- Integrates UBSAN into the KUnit testing framework.
    It fails KUnit tests whenever it reports undefined behavior.

----------------------------------------------------------------
Daniel Latypov (2):
       kunit: tool: add --kernel_args to allow setting module params
       kunit: tool: make --raw_output support only showing kunit output

David Gow (2):
       fat: Add KUnit tests for checksums and timestamps
       kunit: Print test statistics on failure

Uriel Guajardo (1):
       kunit: ubsan integration

  Documentation/dev-tools/kunit/kunit-tool.rst   |   9 +-
  Documentation/dev-tools/kunit/running_tips.rst |  10 ++
  fs/fat/.kunitconfig                            |   5 +
  fs/fat/Kconfig                                 |  14 +-
  fs/fat/Makefile                                |   2 +
  fs/fat/fat_test.c                              | 196 +++++++++++++++++++++++++
  fs/fat/misc.c                                  |   3 +
  lib/kunit/test.c                               | 109 ++++++++++++++
  lib/ubsan.c                                    |   3 +
  tools/testing/kunit/kunit.py                   |  36 +++--
  tools/testing/kunit/kunit_parser.py            |   6 +-
  tools/testing/kunit/kunit_tool_test.py         |  29 +++-
  12 files changed, 398 insertions(+), 24 deletions(-)
  create mode 100644 fs/fat/.kunitconfig
  create mode 100644 fs/fat/fat_test.c
----------------------------------------------------------------

--------------DC9ADF906BE2F2476D3C55B7
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.15-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.15-rc1.diff"

diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index c7ff9afe407a..ae52e0f489f9 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -114,9 +114,12 @@ results in TAP format, you can pass the ``--raw_output`` argument.
 
 	./tools/testing/kunit/kunit.py run --raw_output
 
-.. note::
-	The raw output from test runs may contain other, non-KUnit kernel log
-	lines.
+The raw output from test runs may contain other, non-KUnit kernel log
+lines. You can see just KUnit output with ``--raw_output=kunit``:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --raw_output=kunit
 
 If you have KUnit results in their raw TAP format, you can parse them and print
 the human-readable summary with the ``parse`` command for kunit_tool. This
diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index d1626d548fa5..30d2147eb5b5 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -80,6 +80,16 @@ file ``.kunitconfig``, you can just pass in the dir, e.g.
 	automagically, but tests could theoretically depend on incompatible
 	options, so handling that would be tricky.
 
+Setting kernel commandline parameters
+-------------------------------------
+
+You can use ``--kernel_args`` to pass arbitrary kernel arguments, e.g.
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kernel_args=param=42 --kernel_args=param2=false
+
+
 Generating code coverage reports under UML
 ------------------------------------------
 
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
index 000000000000..2dab4ca1d0d8
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
+	fat_time_unix2fat(&fake_sb, &testcase->ts,
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
index 18a50a46b57f..91ca3c304211 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -230,6 +230,9 @@ void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
 	}
 }
 
+/* Export fat_time_fat2unix() for the fat_test KUnit tests. */
+EXPORT_SYMBOL_GPL(fat_time_fat2unix);
+
 /* Convert linear UNIX date to a FAT time/date pair. */
 void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
 		       __le16 *time, __le16 *date, u8 *time_cs)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d79ecb86ea57..f246b847024e 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,6 +10,7 @@
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/moduleparam.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -51,6 +52,51 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
 EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
 #endif
 
+/*
+ * KUnit statistic mode:
+ * 0 - disabled
+ * 1 - only when there is more than one subtest
+ * 2 - enabled
+ */
+static int kunit_stats_enabled = 1;
+module_param_named(stats_enabled, kunit_stats_enabled, int, 0644);
+MODULE_PARM_DESC(stats_enabled,
+		  "Print test stats: never (0), only for multiple subtests (1), or always (2)");
+
+struct kunit_result_stats {
+	unsigned long passed;
+	unsigned long skipped;
+	unsigned long failed;
+	unsigned long total;
+};
+
+static bool kunit_should_print_stats(struct kunit_result_stats stats)
+{
+	if (kunit_stats_enabled == 0)
+		return false;
+
+	if (kunit_stats_enabled == 2)
+		return true;
+
+	return (stats.total > 1);
+}
+
+static void kunit_print_test_stats(struct kunit *test,
+				   struct kunit_result_stats stats)
+{
+	if (!kunit_should_print_stats(stats))
+		return;
+
+	kunit_log(KERN_INFO, test,
+		  KUNIT_SUBTEST_INDENT
+		  "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
+		  test->name,
+		  stats.passed,
+		  stats.failed,
+		  stats.skipped,
+		  stats.total);
+}
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -393,15 +439,69 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 		test_case->status = KUNIT_SUCCESS;
 }
 
+static void kunit_print_suite_stats(struct kunit_suite *suite,
+				    struct kunit_result_stats suite_stats,
+				    struct kunit_result_stats param_stats)
+{
+	if (kunit_should_print_stats(suite_stats)) {
+		kunit_log(KERN_INFO, suite,
+			  "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
+			  suite->name,
+			  suite_stats.passed,
+			  suite_stats.failed,
+			  suite_stats.skipped,
+			  suite_stats.total);
+	}
+
+	if (kunit_should_print_stats(param_stats)) {
+		kunit_log(KERN_INFO, suite,
+			  "# Totals: pass:%lu fail:%lu skip:%lu total:%lu",
+			  param_stats.passed,
+			  param_stats.failed,
+			  param_stats.skipped,
+			  param_stats.total);
+	}
+}
+
+static void kunit_update_stats(struct kunit_result_stats *stats,
+			       enum kunit_status status)
+{
+	switch (status) {
+	case KUNIT_SUCCESS:
+		stats->passed++;
+		break;
+	case KUNIT_SKIPPED:
+		stats->skipped++;
+		break;
+	case KUNIT_FAILURE:
+		stats->failed++;
+		break;
+	}
+
+	stats->total++;
+}
+
+static void kunit_accumulate_stats(struct kunit_result_stats *total,
+				   struct kunit_result_stats add)
+{
+	total->passed += add.passed;
+	total->skipped += add.skipped;
+	total->failed += add.failed;
+	total->total += add.total;
+}
+
 int kunit_run_tests(struct kunit_suite *suite)
 {
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
 	struct kunit_case *test_case;
+	struct kunit_result_stats suite_stats = { 0 };
+	struct kunit_result_stats total_stats = { 0 };
 
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
+		struct kunit_result_stats param_stats = { 0 };
 		test_case->status = KUNIT_SKIPPED;
 
 		if (test_case->generate_params) {
@@ -431,14 +531,23 @@ int kunit_run_tests(struct kunit_suite *suite)
 				test.param_value = test_case->generate_params(test.param_value, param_desc);
 				test.param_index++;
 			}
+
+			kunit_update_stats(&param_stats, test.status);
+
 		} while (test.param_value);
 
+		kunit_print_test_stats(&test, param_stats);
+
 		kunit_print_ok_not_ok(&test, true, test_case->status,
 				      kunit_test_case_num(suite, test_case),
 				      test_case->name,
 				      test.status_comment);
+
+		kunit_update_stats(&suite_stats, test_case->status);
+		kunit_accumulate_stats(&total_stats, param_stats);
 	}
 
+	kunit_print_suite_stats(suite, suite_stats, total_stats);
 	kunit_print_subtest_end(suite);
 
 	return 0;
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 26229973049d..bdc380ff5d5c 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <kunit/test-bug.h>
 
 #include "ubsan.h"
 
@@ -141,6 +142,8 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
 		"========================================\n");
 	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
 		loc->line & LINE_MASK, loc->column & COLUMN_MASK);
+
+	kunit_fail_current_test("%s in %s", reason, loc->file_name);
 }
 
 static void ubsan_epilogue(void)
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 6276ce0c0196..5a931456e718 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -16,6 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
 
 from collections import namedtuple
 from enum import Enum, auto
+from typing import Iterable
 
 import kunit_config
 import kunit_json
@@ -30,12 +31,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-			      ['timeout', 'build_dir', 'alltests', 'filter_glob'])
+                              ['timeout', 'build_dir', 'alltests',
+                               'filter_glob', 'kernel_args'])
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'input_data', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'alltests', 'filter_glob',
-					   'json', 'make_options'])
+					   'kernel_args', 'json', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -94,6 +96,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
 	test_start = time.time()
 	result = linux.run_kernel(
+		args=request.kernel_args,
 		timeout=None if request.alltests else request.timeout,
                 filter_glob=request.filter_glob,
 		build_dir=request.build_dir)
@@ -112,7 +115,16 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
 					      'Tests not Parsed.')
 
 	if request.raw_output:
-		kunit_parser.raw_output(request.input_data)
+		output: Iterable[str] = request.input_data
+		if request.raw_output == 'all':
+			pass
+		elif request.raw_output == 'kunit':
+			output = kunit_parser.extract_tap_lines(output)
+		else:
+			print(f'Unknown --raw_output option "{request.raw_output}"', file=sys.stderr)
+		for line in output:
+			print(line.rstrip())
+
 	else:
 		test_result = kunit_parser.parse_run_tests(request.input_data)
 	parse_end = time.time()
@@ -133,7 +145,6 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
 	return KunitResult(KunitStatus.SUCCESS, test_result,
 				parse_end - parse_start)
 
-
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	run_start = time.time()
@@ -152,7 +163,8 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 		return build_result
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
-					request.alltests, request.filter_glob)
+				 request.alltests, request.filter_glob,
+				 request.kernel_args)
 	exec_result = exec_tests(linux, exec_request)
 	if exec_result.status != KunitStatus.SUCCESS:
 		return exec_result
@@ -178,7 +190,7 @@ def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
-                            type=str, default='.kunit', metavar='build_dir')
+			    type=str, default='.kunit', metavar='build_dir')
 	parser.add_argument('--make_options',
 			    help='X=Y make option, can be repeated.',
 			    action='append')
@@ -238,10 +250,14 @@ def add_exec_opts(parser) -> None:
 			    nargs='?',
 			    default='',
 			    metavar='filter_glob')
+	parser.add_argument('--kernel_args',
+			    help='Kernel command-line parameters. Maybe be repeated',
+			     action='append')
 
 def add_parse_opts(parser) -> None:
-	parser.add_argument('--raw_output', help='don\'t format output from kernel',
-			    action='store_true')
+	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
+			    'If set to --raw_output=kunit, filters to just KUnit output.',
+			    type=str, nargs='?', const='all', default=None)
 	parser.add_argument('--json',
 			    nargs='?',
 			    help='Stores test results in a JSON, and either '
@@ -309,6 +325,7 @@ def main(argv, linux=None):
 				       cli_args.build_dir,
 				       cli_args.alltests,
 				       cli_args.filter_glob,
+				       cli_args.kernel_args,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -363,7 +380,8 @@ def main(argv, linux=None):
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
 						cli_args.alltests,
-						cli_args.filter_glob)
+						cli_args.filter_glob,
+						cli_args.kernel_args)
 		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
 						  exec_result.result,
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index b88db3f51dc5..6310a641b151 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -106,10 +106,6 @@ def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
 				yield line_num, line[prefix_len:]
 	return LineStream(lines=isolate_kunit_output(kernel_output))
 
-def raw_output(kernel_output) -> None:
-	for line in kernel_output:
-		print(line.rstrip())
-
 DIVIDER = '=' * 60
 
 RESET = '\033[0;0m'
@@ -137,7 +133,7 @@ def print_log(log) -> None:
 	for m in log:
 		print_with_timestamp(m)
 
-TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
+TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*# (Subtest:|.*: kunit test case crashed!)).*$')
 
 def consume_non_diagnostic(lines: LineStream) -> None:
 	while lines and not TAP_ENTRIES.match(lines.peek()):
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 75045aa0f8a1..619c4554cbff 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -356,7 +356,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', filter_glob='', timeout=300)
+			args=None, build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
@@ -364,7 +364,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', filter_glob='', timeout=300)
+			args=None, build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_exec_passes_args_fail(self):
@@ -399,11 +399,20 @@ class KUnitMainTest(unittest.TestCase):
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
 			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
+	def test_run_raw_output_kunit(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		kunit.main(['run', '--raw_output=kunit'], self.linux_source_mock)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
+		for call in self.print_mock.call_args_list:
+			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
+
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', filter_glob='', timeout=timeout)
+			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
@@ -411,7 +420,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', filter_glob='', timeout=timeout)
+			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
@@ -419,7 +428,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir=build_dir, filter_glob='', timeout=300)
+			args=None, build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_config_builddir(self):
@@ -436,7 +445,7 @@ class KUnitMainTest(unittest.TestCase):
 		build_dir = '.kunit'
 		kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir=build_dir, filter_glob='', timeout=300)
+			args=None, build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
@@ -461,5 +470,13 @@ class KUnitMainTest(unittest.TestCase):
 							cross_compile=None,
 							qemu_config_path=None)
 
+	def test_run_kernel_args(self):
+		kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'], self.linux_source_mock)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+		      args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
+
 if __name__ == '__main__':
 	unittest.main()

--------------DC9ADF906BE2F2476D3C55B7--
