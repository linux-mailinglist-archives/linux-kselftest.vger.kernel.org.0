Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C9A362765
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Apr 2021 20:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhDPSFE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Apr 2021 14:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbhDPSFA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Apr 2021 14:05:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1867DC061756
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 11:04:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l30so7145644ybj.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/H+m+ALhQKW7Ilv+GzFO9pjCjZCj8F3VFmPCGy2tCIo=;
        b=vLxB60jVT0HTycIJZPpEqlQuwieieL8FDJrJIuCXXvh2kzWOc1RBN2K7mIEmvdiws9
         jjY94AbGyrgyj2x5BwWsn95lOw2WMQE8arPljZoMOuE4vvDU/RvOHigmVKszYaoDFEwc
         7jbeJyqevWz+nNycoYkpxn0pmIhZIUwBWySRdOuU6XOf8D0cTXyoTQkM4cYem/tMyOcs
         6VZH5U0THlUzmkYP3vrcF2lvDbCkaK9lcNliKcIivI0S3Fk/vj1ogCRhwX9VpVAQkohc
         ZaNmg0v1KzeXjrk3CHe8p25Ajh1Yp2iDT4ZFuvIocKan8xBm+hd0a1x3R/ukOR/LuiKW
         57Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/H+m+ALhQKW7Ilv+GzFO9pjCjZCj8F3VFmPCGy2tCIo=;
        b=qH0BnbSNgrsDljZYTvLs2jU6Jguw6q7xG9pQzUVvsO9khXma7peGpgpZ+sSMJpiVfw
         vU81BnR/L0Q77TMPcxe+3Ky3aLk/P5wik8tZ4kNxNlC2WfkykVm3Pol/6WGIFH5oZSqL
         McggrbzQAGGWqnauH7Gcnk6rlRHEiugkolkQE5i4STYQ66Wpr1C5w/vJYhk683dCVQK2
         AgiYTrEKIRyipYwXYSzjHvDPVuKMAOryZIf/0RtPpUL4ypQ7HLa4CJjzoSHSGwCLgFuB
         CL3H9JBPHCX0n03LAQY+5h1D9cW5dl+KOOh7e69SC8sdCyg+W/3xSA/Fi85j+WY4aVEl
         l7QQ==
X-Gm-Message-State: AOAM531QRRiDGtmuAfLi6oNHcStg/GKcOA7KmAj1wfin+TMzBIVXdh1R
        oZtci2/VOPd9w6wuw2CpyPHy45LZCkJcoA==
X-Google-Smtp-Source: ABdhPJz30tGFtJUwlKaM9nGSiqouCiCRUIXx70H9H9TaPmMQbbQyemicL7XoJFvdOrIc/8Fgpl7n5m+InP/OtQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:78ba:f620:dba8:af82])
 (user=dlatypov job=sendgmr) by 2002:a25:943:: with SMTP id
 u3mr432192ybm.489.1618596273231; Fri, 16 Apr 2021 11:04:33 -0700 (PDT)
Date:   Fri, 16 Apr 2021 11:04:27 -0700
Message-Id: <20210416180427.1545645-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v6] lib: add basic KUnit test for lib/math
From:   Daniel Latypov <dlatypov@google.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic test coverage for files that don't require any config options:
* part of math.h (what seem to be the most commonly used macros)
* gcd.c
* lcm.c
* int_sqrt.c
* reciprocal_div.c
(Ignored int_pow.c since it's a simple textbook algorithm.)

These tests aren't particularly interesting, but they
* provide short and simple examples of parameterized tests
* provide a place to add tests for any new files in this dir
* are written so adding new test cases to cover edge cases should be easy
  * looking at code coverage, we hit all the branches in the .c files

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
Changes since v5:
* add in test cases for roundup/rounddown
* address misc comments from David

Changes since v4:
* add in test cases for some math.h macros (abs, round_up/round_down,
  div_round_down/closest)
* use parameterized testing less to keep things terser

Changes since v3:
* fix `checkpatch.pl --strict` warnings
* add test cases for gcd(0,0) and lcm(0,0)
* minor: don't test both gcd(a,b) and gcd(b,a) when a == b

Changes since v2: mv math_test.c => math_kunit.c

Changes since v1:
* Rebase and rewrite to use the new parameterized testing support.
* misc: fix overflow in literal and inline int_sqrt format string.
* related: commit 1f0e943df68a ("Documentation: kunit: provide guidance
for testing many inputs") was merged explaining the patterns shown here.
  * there's an in-flight patch to update it for parameterized testing.
---
 lib/math/Kconfig      |  12 ++
 lib/math/Makefile     |   2 +
 lib/math/math_kunit.c | 291 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 lib/math/math_kunit.c

diff --git a/lib/math/Kconfig b/lib/math/Kconfig
index f19bc9734fa7..a974d4db0f9c 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -15,3 +15,15 @@ config PRIME_NUMBERS
 
 config RATIONAL
 	bool
+
+config MATH_KUNIT_TEST
+	tristate "KUnit test for lib/math and math.h" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+		This builds unit tests for lib/math and math.h.
+
+		For more information on KUnit and unit tests in general, please refer
+		to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+		If unsure, say N.
diff --git a/lib/math/Makefile b/lib/math/Makefile
index be6909e943bd..30abb7a8d564 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -4,3 +4,5 @@ obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
 obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
+
+obj-$(CONFIG_MATH_KUNIT_TEST)	+= math_kunit.o
diff --git a/lib/math/math_kunit.c b/lib/math/math_kunit.c
new file mode 100644
index 000000000000..556c23b17c3c
--- /dev/null
+++ b/lib/math/math_kunit.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple KUnit suite for math helper funcs that are always enabled.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Daniel Latypov <dlatypov@google.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/gcd.h>
+#include <linux/kernel.h>
+#include <linux/lcm.h>
+#include <linux/reciprocal_div.h>
+
+static void abs_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, abs((char)0), (char)0);
+	KUNIT_EXPECT_EQ(test, abs((char)42), (char)42);
+	KUNIT_EXPECT_EQ(test, abs((char)-42), (char)42);
+
+	/* The expression in the macro is actually promoted to an int. */
+	KUNIT_EXPECT_EQ(test, abs((short)0),  0);
+	KUNIT_EXPECT_EQ(test, abs((short)42),  42);
+	KUNIT_EXPECT_EQ(test, abs((short)-42),  42);
+
+	KUNIT_EXPECT_EQ(test, abs(0),  0);
+	KUNIT_EXPECT_EQ(test, abs(42),  42);
+	KUNIT_EXPECT_EQ(test, abs(-42),  42);
+
+	KUNIT_EXPECT_EQ(test, abs(0L), 0L);
+	KUNIT_EXPECT_EQ(test, abs(42L), 42L);
+	KUNIT_EXPECT_EQ(test, abs(-42L), 42L);
+
+	KUNIT_EXPECT_EQ(test, abs(0LL), 0LL);
+	KUNIT_EXPECT_EQ(test, abs(42LL), 42LL);
+	KUNIT_EXPECT_EQ(test, abs(-42LL), 42LL);
+
+	/* Unsigned types get casted to signed. */
+	KUNIT_EXPECT_EQ(test, abs(0ULL), 0LL);
+	KUNIT_EXPECT_EQ(test, abs(42ULL), 42LL);
+}
+
+static void int_sqrt_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, int_sqrt(0UL), 0UL);
+	KUNIT_EXPECT_EQ(test, int_sqrt(1UL), 1UL);
+	KUNIT_EXPECT_EQ(test, int_sqrt(4UL), 2UL);
+	KUNIT_EXPECT_EQ(test, int_sqrt(5UL), 2UL);
+	KUNIT_EXPECT_EQ(test, int_sqrt(8UL), 2UL);
+	KUNIT_EXPECT_EQ(test, int_sqrt(1UL << 30), 1UL << 15);
+}
+
+static void round_up_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, round_up(0, 1), 0);
+	KUNIT_EXPECT_EQ(test, round_up(1, 2), 2);
+	KUNIT_EXPECT_EQ(test, round_up(3, 2), 4);
+	KUNIT_EXPECT_EQ(test, round_up((1 << 30) - 1, 2), 1 << 30);
+	KUNIT_EXPECT_EQ(test, round_up((1 << 30) - 1, 1 << 29), 1 << 30);
+}
+
+static void round_down_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, round_down(0, 1), 0);
+	KUNIT_EXPECT_EQ(test, round_down(1, 2), 0);
+	KUNIT_EXPECT_EQ(test, round_down(3, 2), 2);
+	KUNIT_EXPECT_EQ(test, round_down((1 << 30) - 1, 2), (1 << 30) - 2);
+	KUNIT_EXPECT_EQ(test, round_down((1 << 30) - 1, 1 << 29), 1 << 29);
+}
+
+/* These versions can round to numbers that aren't a power of two */
+static void roundup_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, roundup(0, 1), 0);
+	KUNIT_EXPECT_EQ(test, roundup(1, 2), 2);
+	KUNIT_EXPECT_EQ(test, roundup(3, 2), 4);
+	KUNIT_EXPECT_EQ(test, roundup((1 << 30) - 1, 2), 1 << 30);
+	KUNIT_EXPECT_EQ(test, roundup((1 << 30) - 1, 1 << 29), 1 << 30);
+
+	KUNIT_EXPECT_EQ(test, roundup(3, 2), 4);
+	KUNIT_EXPECT_EQ(test, roundup(4, 3), 6);
+}
+
+static void rounddown_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, rounddown(0, 1), 0);
+	KUNIT_EXPECT_EQ(test, rounddown(1, 2), 0);
+	KUNIT_EXPECT_EQ(test, rounddown(3, 2), 2);
+	KUNIT_EXPECT_EQ(test, rounddown((1 << 30) - 1, 2), (1 << 30) - 2);
+	KUNIT_EXPECT_EQ(test, rounddown((1 << 30) - 1, 1 << 29), 1 << 29);
+
+	KUNIT_EXPECT_EQ(test, rounddown(3, 2), 2);
+	KUNIT_EXPECT_EQ(test, rounddown(4, 3), 3);
+}
+
+static void div_round_up_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(0, 1), 0);
+	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(20, 10), 2);
+	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(21, 10), 3);
+	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(21, 20), 2);
+	KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(21, 99), 1);
+}
+
+static void div_round_closest_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(0, 1), 0);
+	KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(20, 10), 2);
+	KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(21, 10), 2);
+	KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(25, 10), 3);
+}
+
+/* Generic test case for unsigned long inputs. */
+struct test_case {
+	unsigned long a, b;
+	unsigned long result;
+};
+
+static struct test_case gcd_cases[] = {
+	{
+		.a = 0, .b = 0,
+		.result = 0,
+	},
+	{
+		.a = 0, .b = 1,
+		.result = 1,
+	},
+	{
+		.a = 2, .b = 2,
+		.result = 2,
+	},
+	{
+		.a = 2, .b = 4,
+		.result = 2,
+	},
+	{
+		.a = 3, .b = 5,
+		.result = 1,
+	},
+	{
+		.a = 3 * 9, .b = 3 * 5,
+		.result = 3,
+	},
+	{
+		.a = 3 * 5 * 7, .b = 3 * 5 * 11,
+		.result = 15,
+	},
+	{
+		.a = 1 << 21,
+		.b = (1 << 21) - 1,
+		.result = 1,
+	},
+};
+
+KUNIT_ARRAY_PARAM(gcd, gcd_cases, NULL);
+
+static void gcd_test(struct kunit *test)
+{
+	const char *message_fmt = "gcd(%lu, %lu)";
+	const struct test_case *test_param = test->param_value;
+
+	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
+			    gcd(test_param->a, test_param->b),
+			    message_fmt, test_param->a,
+			    test_param->b);
+
+	if (test_param->a == test_param->b)
+		return;
+
+	/* gcd(a,b) == gcd(b,a) */
+	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
+			    gcd(test_param->b, test_param->a),
+			    message_fmt, test_param->b,
+			    test_param->a);
+}
+
+static struct test_case lcm_cases[] = {
+	{
+		.a = 0, .b = 0,
+		.result = 0,
+	},
+	{
+		.a = 0, .b = 1,
+		.result = 0,
+	},
+	{
+		.a = 1, .b = 2,
+		.result = 2,
+	},
+	{
+		.a = 2, .b = 2,
+		.result = 2,
+	},
+	{
+		.a = 3 * 5, .b = 3 * 7,
+		.result = 3 * 5 * 7,
+	},
+};
+
+KUNIT_ARRAY_PARAM(lcm, lcm_cases, NULL);
+
+static void lcm_test(struct kunit *test)
+{
+	const char *message_fmt = "lcm(%lu, %lu)";
+	const struct test_case *test_param = test->param_value;
+
+	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
+			    lcm(test_param->a, test_param->b),
+			    message_fmt, test_param->a,
+			    test_param->b);
+
+	if (test_param->a == test_param->b)
+		return;
+
+	/* lcm(a,b) == lcm(b,a) */
+	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
+			    lcm(test_param->b, test_param->a),
+			    message_fmt, test_param->b,
+			    test_param->a);
+}
+
+struct u32_test_case {
+	u32 a, b;
+	u32 result;
+};
+
+static struct u32_test_case reciprocal_div_cases[] = {
+	{
+		.a = 0, .b = 1,
+		.result = 0,
+	},
+	{
+		.a = 42, .b = 20,
+		.result = 2,
+	},
+	{
+		.a = 42, .b = 9999,
+		.result = 0,
+	},
+	{
+		.a = (1 << 16), .b = (1 << 14),
+		.result = 1 << 2,
+	},
+};
+
+KUNIT_ARRAY_PARAM(reciprocal_div, reciprocal_div_cases, NULL);
+
+static void reciprocal_div_test(struct kunit *test)
+{
+	const struct u32_test_case *test_param = test->param_value;
+	struct reciprocal_value rv = reciprocal_value(test_param->b);
+
+	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
+			    reciprocal_divide(test_param->a, rv),
+			    "reciprocal_divide(%u, %u)",
+			    test_param->a, test_param->b);
+}
+
+static void reciprocal_scale_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, reciprocal_scale(0u, 100), 0u);
+	KUNIT_EXPECT_EQ(test, reciprocal_scale(1u, 100), 0u);
+	KUNIT_EXPECT_EQ(test, reciprocal_scale(1u << 4, 1 << 28), 1u);
+	KUNIT_EXPECT_EQ(test, reciprocal_scale(1u << 16, 1 << 28), 1u << 12);
+	KUNIT_EXPECT_EQ(test, reciprocal_scale(~0u, 1 << 28), (1u << 28) - 1);
+}
+
+static struct kunit_case math_test_cases[] = {
+	KUNIT_CASE(abs_test),
+	KUNIT_CASE(int_sqrt_test),
+	KUNIT_CASE(round_up_test),
+	KUNIT_CASE(round_down_test),
+	KUNIT_CASE(roundup_test),
+	KUNIT_CASE(rounddown_test),
+	KUNIT_CASE(div_round_up_test),
+	KUNIT_CASE(div_round_closest_test),
+	KUNIT_CASE_PARAM(gcd_test, gcd_gen_params),
+	KUNIT_CASE_PARAM(lcm_test, lcm_gen_params),
+	KUNIT_CASE_PARAM(reciprocal_div_test, reciprocal_div_gen_params),
+	KUNIT_CASE(reciprocal_scale_test),
+	{}
+};
+
+static struct kunit_suite math_test_suite = {
+	.name = "lib-math",
+	.test_cases = math_test_cases,
+};
+
+kunit_test_suites(&math_test_suite);
+
+MODULE_LICENSE("GPL v2");

base-commit: 7e25f40eab52c57ff6772d27d2aef3640a3237d7
-- 
2.31.1.368.gbe11c130af-goog

