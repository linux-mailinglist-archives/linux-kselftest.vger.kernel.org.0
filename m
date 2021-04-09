Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F015359188
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 03:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDIBk1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 21:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBk0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 21:40:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E27C061760
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Apr 2021 18:40:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w9so3865684ybw.7
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Apr 2021 18:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LPkfXEcX7j03W4gFStiTJq0OGRMKXC4ALTO941+p63k=;
        b=THrHvnSdHdYVunDjdSo3QnSW4+VcXI2f2oCd4EGjEi+NppUjFadEwu/aGWiKPxqluP
         Y2uUAOSEDDWI6Ys593r4nXXWnx0JlSEglrFWw8X5Tt6xIsqX3PDEQPTpFWQHdCLLrmnB
         v08EYbzQc4V8hAP6MUyOlQG/h2EZv+cqAcOOiXCZ7BPCfsm0OyMsRaBYJAZqn5uNycVr
         8s+qMVlmdP1HYd9aj4bePIr+8RlXxEHGxkVBrS9ZoWYOrOVgW2TAifIqha43IsYyazDQ
         Lm9pe/3f/NlZSXaNr8edyLdy5rLYZyzfQNThC3AhmerI3pUPG96BDyTES917cTmOK5Y1
         uGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LPkfXEcX7j03W4gFStiTJq0OGRMKXC4ALTO941+p63k=;
        b=L+T2x3Izoh2Cw1lcVbwMBrcl+N9Fwo18vr2VImAKnrY3V0ADYkb8sI42+k32hCZCtG
         N6EmFW2z4TOU0VcBF2/rTjVJ/vcobVngSDUxDAdC3tBur8VbAMsIBF7ZRpZ4N6xZrJFm
         XGC7HvSWMebF7CrJycxnilkLvSlFZW1ZNazN4wBTuauM5gb86NYfKrhLX90IkW5XjTM3
         VXFlou28j+MpTDvSH9fORRgyUYmB8UB03h97TpcKhwgWHfQ6Hj8ArHLbJKHItT6VVn0F
         b7YO2u4Tr2xSt5IpeQSYPvX1lk4LKokrfGIzcD7ucWIT8nYjczbfoMRMxh6DVfkoanCZ
         JPZQ==
X-Gm-Message-State: AOAM53098QKHSXTPZ2dKT00T1+RW1Ewlb3skwbK5XWKdcktvJxpzmFmn
        Jij7VoLd92CpTfiozst2IUd6VTCFjeAsmQ==
X-Google-Smtp-Source: ABdhPJzqqGaQOoKXks68+kTPh9MTCoMcCu6Lz2LEH52hZjyk5pHQDu0UVXcwxB8Xs7C6Klj6LYbqeQ0ATO0TEw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:c92c:354b:50aa:d24a])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:102d:: with SMTP id
 x13mr14540935ybt.503.1617932414138; Thu, 08 Apr 2021 18:40:14 -0700 (PDT)
Date:   Thu,  8 Apr 2021 18:40:01 -0700
Message-Id: <20210409014001.2946212-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v4] lib: add basic KUnit test for lib/math
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
* gcd.c
* lcm.c
* int_sqrt.c
* reciprocal_div.c
(Ignored int_pow.c since it's a simple textbook algorithm.)

These tests aren't particularly interesting, but they
* provide short and simple examples of parameterized tests
* provide a place to add tests for any new files in this dir
* are written so adding new test cases to cover edge cases should be easy

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
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

v1: https://lore.kernel.org/lkml/20201019224556.3536790-1-dlatypov@google.com/
---
 lib/math/Kconfig      |   5 +
 lib/math/Makefile     |   2 +
 lib/math/math_kunit.c | 214 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 lib/math/math_kunit.c

diff --git a/lib/math/Kconfig b/lib/math/Kconfig
index f19bc9734fa7..6ba8680439c1 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -15,3 +15,8 @@ config PRIME_NUMBERS
 
 config RATIONAL
 	bool
+
+config MATH_KUNIT_TEST
+	tristate "KUnit test for lib/math" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	depends on KUNIT
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
index 000000000000..fed15ade8fb2
--- /dev/null
+++ b/lib/math/math_kunit.c
@@ -0,0 +1,214 @@
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
+static struct test_case int_sqrt_cases[] = {
+	{
+		.a = 0,
+		.result = 0,
+	},
+	{
+		.a = 1,
+		.result = 1,
+	},
+	{
+		.a = 4,
+		.result = 2,
+	},
+	{
+		.a = 5,
+		.result = 2,
+	},
+	{
+		.a = 8,
+		.result = 2,
+	},
+	{
+		.a = 1UL << 30,
+		.result = 1UL << 15,
+	},
+};
+
+KUNIT_ARRAY_PARAM(int_sqrt, int_sqrt_cases, NULL);
+
+static void int_sqrt_test(struct kunit *test)
+{
+	const struct test_case *test_param = test->param_value;
+
+	KUNIT_EXPECT_EQ_MSG(test, int_sqrt(test_param->a),
+			    test_param->result, "sqrt(%lu)",
+			    test_param->a);
+}
+
+struct reciprocal_test_case {
+	u32 a, b;
+	u32 result;
+};
+
+static struct reciprocal_test_case reciprocal_div_cases[] = {
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
+	const struct reciprocal_test_case *test_param = test->param_value;
+	struct reciprocal_value rv = reciprocal_value(test_param->b);
+
+	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
+			    reciprocal_divide(test_param->a, rv),
+			    "reciprocal_divide(%u, %u)",
+			    test_param->a, test_param->b);
+}
+
+static struct kunit_case math_test_cases[] = {
+	KUNIT_CASE_PARAM(gcd_test, gcd_gen_params),
+	KUNIT_CASE_PARAM(lcm_test, lcm_gen_params),
+	KUNIT_CASE_PARAM(int_sqrt_test, int_sqrt_gen_params),
+	KUNIT_CASE_PARAM(reciprocal_div_test, reciprocal_div_gen_params),
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

base-commit: 4fa56ad0d12e24df768c98bffe9039f915d1bc02
-- 
2.31.1.295.g9ea45b61b8-goog

