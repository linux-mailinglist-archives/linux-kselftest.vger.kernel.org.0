Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED8E2FC4C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 00:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbhASXdJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 18:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbhASXbz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 18:31:55 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28FBC061575
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 15:31:14 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 18so16853230pgf.19
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 15:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=u5ae+vuXZcV+WmBXakynzeiDTM3Z0PJsnet9IO41bao=;
        b=NbAYqmXPLEv0WI+rk12Hf3SNsiZkufhxKeVmtYuFpj75kYX2Z6WEWLmEhpLb1zR/m5
         NE6dGFqJ+uktjI/HRsf4teGliH/LOyi9MisOaopYRb7qZgHpdDRCGMXok5h11/4X/0ou
         MEJqyRR5AKdjvJq4uCjEy7WH34GYYXLKAvB5yZbxUk7kVjL9saxVYLgHIcVRMjHqCmLL
         USyGejRMAu0/AIVlRDI9ahJtQHU7wsOwlVvi54bCNTm2KIIIbajg3sCJ1xsnJyY/iicp
         mFnhcVxdrcOIiGCEdNye/Zq04w/DPKUHOkzN2FJYimcM+eC0NWNXSsyO38zezfJXSxMk
         Ru0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=u5ae+vuXZcV+WmBXakynzeiDTM3Z0PJsnet9IO41bao=;
        b=mOFE3ASnhSvCJEP5rV9H/ucHCWBH/ZiPOFzK/zLW7zbmImFlNCB4EQeXsFdQ4jnIFg
         MqPVbYtTe2ujdR8F5WgGDVxA7qwVJl+BZJVf7lePGM0pKgMHHhl6hL4Xx3mAettzfyse
         2mQEuP7pGIZA2O0QKt0r3qilhWS2Jia6IGN/y8LU425QGBVaEt/HlOrAa7nzlP3ty5B+
         Fd8ye9uyWd5AA0kvBvY+1ZvWAeyOabWtIKosGwG7i7iLwm7U+oOE7nTbkdoZZnlNWjGd
         w6MLmnComAIs/iNS3SnN+ed50vwsU/i6jb/ICVMsJUrvfOyKPwutRwQZH4wJCgzKEV0e
         FRvw==
X-Gm-Message-State: AOAM532rj4oySlq4Cn4O3jLRWx/3+FSOmLbXLLQVj74bW6AI2DL4Is5U
        InnZDQFsw5lmUAHgg9tTyCB4vVuReRoy6Q==
X-Google-Smtp-Source: ABdhPJzfVEYaZ094dovQtWcGiU213dwazxyfNARPu09ZJbN83EBo4gkvfMECFfFR0+k/fjBHbMFpJ+9CJSBRLw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:33c4:: with SMTP id
 lk4mr2299876pjb.157.1611099074127; Tue, 19 Jan 2021 15:31:14 -0800 (PST)
Date:   Tue, 19 Jan 2021 15:30:58 -0800
Message-Id: <20210119233058.84687-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3] lib: add basic KUnit test for lib/math
From:   Daniel Latypov <dlatypov@google.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
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
Changes since v2: mv math_test.c => math_kunit.c

Changes since v1:
* Rebase and rewrite to use the new parameterized testing support.
* misc: fix overflow in literal and inline int_sqrt format string.
* related: commit 1f0e943df68a ("Documentation: kunit: provide guidance
for testing many inputs") was merged explaining the patterns shown here.
  * there's an in-flight patch to update it for parameterized testing.

v1: https://lore.kernel.org/lkml/20201019224556.3536790-1-dlatypov@google.com/
---
 lib/math/Kconfig      |   5 ++
 lib/math/Makefile     |   2 +
 lib/math/math_kunit.c | 197 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
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
index 000000000000..cb2637a24942
--- /dev/null
+++ b/lib/math/math_kunit.c
@@ -0,0 +1,197 @@
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
+		.a = 3*9, .b = 3*5,
+		.result = 3,
+	},
+	{
+		.a = 3*5*7, .b = 3*5*11,
+		.result = 15,
+	},
+	{
+		.a = 1 << 21,
+		.b = (1 << 21) - 1,
+		.result = 1,
+	},
+};
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
+	/* gcd(a,b) == gcd(b,a) */
+	KUNIT_EXPECT_EQ_MSG(test, test_param->result,
+			    gcd(test_param->b, test_param->a),
+			    message_fmt, test_param->b,
+			    test_param->a);
+}
+
+
+static struct test_case lcm_cases[] = {
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
+		.a = 3*5, .b = 3*7,
+		.result = 3*5*7,
+	},
+};
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
+		.a = (1<<16), .b = (1<<14),
+		.result = 1<<2,
+	},
+};
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

base-commit: 65f0d2414b7079556fbbcc070b3d1c9f9587606d
-- 
2.30.0.296.g2bfb1c46d8-goog

