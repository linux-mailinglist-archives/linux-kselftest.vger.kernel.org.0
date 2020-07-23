Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01522A380
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 02:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgGWAIS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jul 2020 20:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgGWAIR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jul 2020 20:08:17 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B059C0619DC
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 17:08:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so3209429qtm.10
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 17:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIJE53JQkkzN5LFSQElzrK2dsjCi+Qx4vXk/TwFFyZo=;
        b=iFlAbOWWbZfvrAlTvRFOi3RUaabnAITRT/KxJ3GYUkN5crnBC9miqwoa7Dqh5p5y2z
         NKO8hTYz5votR4D2q68XcqzIyL/TO+DfLeGNdyHYPL9LATmCFjVXa1YoUwh9+HwA9UX0
         r4qWmmQmkpQ6xkp4rdjwJY8rGAHAU9oHeotOxdedTu3jMXvUi4UEO90IFexVLhyxR3Ee
         0aP7eKaSHwHQPIeS0qqONOFhW36Jol0SrQZi/UouQxm4V7FkfpdiEbpzurlf3yYs4N1y
         OJnlLFCcS7f616yGhk5fTAN96LD/4ARV8G84+aqrer7EWgemmNZcBzOTToP6xmmY9d9a
         EB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIJE53JQkkzN5LFSQElzrK2dsjCi+Qx4vXk/TwFFyZo=;
        b=Yqe3/+AYWV/i7hmOB1RkiVRdi0yipcssCq7y/tdUcWv93BUf5bd3fIF1uTWXUsXcQs
         leBf1X5alXLHQ2yzT24sAJZz7RSIJ/w0Xpo178RmU1JMf1LI0VPw3x0eJ863DIwqPgEv
         lgJsqK++rTKe2HPhOIM7DrSbxg4gtugv+AUDbg4JSYvaE7rB3d/0wRnsufbnPZNwbW/J
         3WtJXaEX5neY9hevZuoGkSzfqVv4GE15leoP/yI73TW37qn2cjSfSZSifqdupPQ2kOM+
         WpVnSnsTtK8Y7v2u61R+dljHgpRudU4EAmZv3yNqwvmcByh+jtw4nRUE0CMTq4A4U+xE
         ptbg==
X-Gm-Message-State: AOAM533VCPrDHea8Ma7xWAz9AcphN7+0vvOkt7i1RCpjm5JmlCQ2vZUk
        nFKHm0CQiWAMznkFnotL7/iqCQ==
X-Google-Smtp-Source: ABdhPJyoCLDw96+G5vz569EAbwZkgms47TpFmM8GeL89ABrUkEkgBQQH2U2yceS+o56uKcTJOxf4tA==
X-Received: by 2002:ac8:3963:: with SMTP id t32mr1962263qtb.152.1595462896422;
        Wed, 22 Jul 2020 17:08:16 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id l67sm1160598qkd.7.2020.07.22.17.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 17:08:15 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, fkostenzer@live.at,
        andriy.shevchenko@linux.intel.com, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: [PATCH] lib: kunit: Convert test_sort to KUnit test
Date:   Wed, 22 Jul 2020 21:08:07 -0300
Message-Id: <20200723000807.171940-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the conversion of the test_sort.c to KUnit test.

Please apply this commit first (linux-kselftest/kunit-fixes):
3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 lib/Kconfig.debug                 | 26 +++++++++++++++++---------
 lib/Makefile                      |  2 +-
 lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------
 3 files changed, 33 insertions(+), 26 deletions(-)
 rename lib/{test_sort.c => sort_kunit.c} (55%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..1fe19e78d7ca 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1874,15 +1874,6 @@ config TEST_MIN_HEAP

 	  If unsure, say N.

-config TEST_SORT
-	tristate "Array-based sort test"
-	depends on DEBUG_KERNEL || m
-	help
-	  This option enables the self-test function of 'sort()' at boot,
-	  or at module load time.
-
-	  If unsure, say N.
-
 config KPROBES_SANITY_TEST
 	bool "Kprobes sanity tests"
 	depends on DEBUG_KERNEL
@@ -2185,6 +2176,23 @@ config LINEAR_RANGES_TEST

 	  If unsure, say N.

+config SORT_KUNIT
+	tristate "KUnit test for Array-based sort"
+	depends on DEBUG_KERNEL || m
+	help
+	  This option enables the KUnit function of 'sort()' at boot,
+	  or at module load time.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..c22bb13b0a08 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,7 +77,6 @@ obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
-obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
@@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_SORT_KUNIT) += sort_kunit.o
diff --git a/lib/test_sort.c b/lib/sort_kunit.c
similarity index 55%
rename from lib/test_sort.c
rename to lib/sort_kunit.c
index 52edbe10f2e5..03ba1cf1285c 100644
--- a/lib/test_sort.c
+++ b/lib/sort_kunit.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/sort.h>
-#include <linux/slab.h>
-#include <linux/module.h>
+#include <kunit/test.h>

 /* a simple boot-time regression test */

@@ -12,13 +11,12 @@ static int __init cmpint(const void *a, const void *b)
 	return *(int *)a - *(int *)b;
 }

-static int __init test_sort_init(void)
+static void __init sort_test(struct kunit *test)
 {
-	int *a, i, r = 1, err = -ENOMEM;
+	int *a, i, r = 1;

 	a = kmalloc_array(TEST_LEN, sizeof(*a), GFP_KERNEL);
-	if (!a)
-		return err;
+	KUNIT_ASSERT_FALSE_MSG(test, a == NULL, "kmalloc_array failed");

 	for (i = 0; i < TEST_LEN; i++) {
 		r = (r * 725861) % 6599;
@@ -27,24 +25,25 @@ static int __init test_sort_init(void)

 	sort(a, TEST_LEN, sizeof(*a), cmpint, NULL);

-	err = -EINVAL;
 	for (i = 0; i < TEST_LEN-1; i++)
 		if (a[i] > a[i+1]) {
-			pr_err("test has failed\n");
+			KUNIT_FAIL(test, "test has failed");
 			goto exit;
 		}
-	err = 0;
-	pr_info("test passed\n");
 exit:
 	kfree(a);
-	return err;
 }

-static void __exit test_sort_exit(void)
-{
-}
+static struct kunit_case sort_test_cases[] = {
+	KUNIT_CASE(sort_test),
+	{}
+};
+
+static struct kunit_suite sort_test_suite = {
+	.name = "sort",
+	.test_cases = sort_test_cases,
+};

-module_init(test_sort_init);
-module_exit(test_sort_exit);
+kunit_test_suites(&sort_test_suite);

 MODULE_LICENSE("GPL");

base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
--
2.26.2

