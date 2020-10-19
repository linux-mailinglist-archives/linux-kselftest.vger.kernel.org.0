Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D4293177
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Oct 2020 00:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbgJSWqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Oct 2020 18:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgJSWqR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Oct 2020 18:46:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62362C0613CE
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Oct 2020 15:46:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b25so1429968ybj.2
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Oct 2020 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=K70MxSj+2OE65nM6g95dThjeSyocm0AZeC9Tw9edd68=;
        b=uB2JXBpMQ918dzYu8qQ3qRkFHUgj+7xmXa90XoNXf9pweoimeWCjtf6G4Orkj6hMHx
         B2QbdaEMyzjnz3c5pmFJT1rGl3IMSlxMgIsDBNG8aEF2I44lVaENxIJZkMs0mQIlI+Iu
         znwRPH0cb6ayA5EhdZpKTro1o3Gu4pdLBAEgTV3uLWCGqvQqn0CEBYNTZ21vSlmhP4zF
         Pqkzd6thezg2cSS+Vahyu4qh/JPOcSe0iVIRMO0MCXw2ik8d56FqklYH6TW4u6aBBfSB
         8WLV57T1FhCUijpMsVELON7QlPwAkWwBPtOykhRXXX4w1Cr8Dj3XF3z8c6nQqRmuplij
         9Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=K70MxSj+2OE65nM6g95dThjeSyocm0AZeC9Tw9edd68=;
        b=X8UX2fbntpzWeVl/YacbqCwD1sXSH6B1z1pvUVzRzj9lbbnofe0BXw733TYwdePv7n
         tS51SvG8FC8wZ/EpyGDh/wtvDgG9K7J25TN+d13PMkOHFMx+YGNz2lVkoJX1rGCMg5o0
         OsQ2tsDor09NvisOzM5H5c/6qXth6DH+PWtqYprHlCgynUCCCgP34PZ0RAnb3hxtXe1B
         Br5lAAisRHJE6ZvW4+dh0ZuqrRwIV1fqJNvSyC2Cr5/Uabqg06+S4vGcSaEp/YOgo7yM
         PklKhKy2mD4iXFOxBA33rWTHeCNrb7ylp6PGNvB1eEJhnotv5HOuhxrR2LXFhC5aXhGs
         L/ow==
X-Gm-Message-State: AOAM533lbvgwpNifr3lvMp/EBDv1O3FewFJch+ArIazODMOO3pZgyTjg
        +g9b+bj/QgB0iYI15Mhof+MNh1c5q/mU3Q==
X-Google-Smtp-Source: ABdhPJwY4xYMujZ6PI7EM/bxqGoAYO39jXrFBwPF29BGLRi2LEKk+dCDwGZiNWKmcn1n+MVL7dSq5Z9QXduErQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:dce:: with SMTP id
 197mr81966ybn.437.1603147575859; Mon, 19 Oct 2020 15:46:15 -0700 (PDT)
Date:   Mon, 19 Oct 2020 15:45:56 -0700
Message-Id: <20201019224556.3536790-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] lib: add basic KUnit test for lib/math
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

These tests aren't particularly interesting, but
* they're chosen as easy to understand examples of how to write tests
* provides a place to add tests for any new files in this dir
* written so adding new test cases to cover edge cases should be easy

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/math/Kconfig     |   5 ++
 lib/math/Makefile    |   2 +
 lib/math/math_test.c | 197 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 lib/math/math_test.c

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
index be6909e943bd..fba6fe90f50b 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -4,3 +4,5 @@ obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
 obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
+
+obj-$(CONFIG_MATH_KUNIT_TEST)	+= math_test.o
diff --git a/lib/math/math_test.c b/lib/math/math_test.c
new file mode 100644
index 000000000000..6f4681ea7c72
--- /dev/null
+++ b/lib/math/math_test.c
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
+static void gcd_test(struct kunit *test)
+{
+	const char *message_fmt = "gcd(%lu, %lu)";
+	int i;
+
+	struct test_case test_cases[] = {
+		{
+			.a = 0, .b = 1,
+			.result = 1,
+		},
+		{
+			.a = 2, .b = 2,
+			.result = 2,
+		},
+		{
+			.a = 2, .b = 4,
+			.result = 2,
+		},
+		{
+			.a = 3, .b = 5,
+			.result = 1,
+		},
+		{
+			.a = 3*9, .b = 3*5,
+			.result = 3,
+		},
+		{
+			.a = 3*5*7, .b = 3*5*11,
+			.result = 15,
+		},
+		{
+			.a = (1 << 21) - 1,
+			.b = (1 << 22) - 1,
+			.result = 1,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
+		KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
+				    gcd(test_cases[i].a, test_cases[i].b),
+				    message_fmt, test_cases[i].a,
+				    test_cases[i].b);
+
+		/* gcd(a,b) == gcd(b,a) */
+		KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
+				    gcd(test_cases[i].b, test_cases[i].a),
+				    message_fmt, test_cases[i].b,
+				    test_cases[i].a);
+	}
+}
+
+static void lcm_test(struct kunit *test)
+{
+	const char *message_fmt = "lcm(%lu, %lu)";
+	int i;
+
+	struct test_case test_cases[] = {
+		{
+			.a = 0, .b = 1,
+			.result = 0,
+		},
+		{
+			.a = 1, .b = 2,
+			.result = 2,
+		},
+		{
+			.a = 2, .b = 2,
+			.result = 2,
+		},
+		{
+			.a = 3*5, .b = 3*7,
+			.result = 3*5*7,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
+		KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
+				    lcm(test_cases[i].a, test_cases[i].b),
+				    message_fmt, test_cases[i].a,
+				    test_cases[i].b);
+
+		/* lcm(a,b) == lcm(b,a) */
+		KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
+				    lcm(test_cases[i].b, test_cases[i].a),
+				    message_fmt, test_cases[i].b,
+				    test_cases[i].a);
+	}
+}
+
+static void int_sqrt_test(struct kunit *test)
+{
+	const char *message_fmt = "sqrt(%lu)";
+	int i;
+
+	struct test_case test_cases[] = {
+		{
+			.a = 0,
+			.result = 0,
+		},
+		{
+			.a = 1,
+			.result = 1,
+		},
+		{
+			.a = 4,
+			.result = 2,
+		},
+		{
+			.a = 5,
+			.result = 2,
+		},
+		{
+			.a = 8,
+			.result = 2,
+		},
+		{
+			.a = 1UL >> 32,
+			.result = 1UL >> 16,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
+		KUNIT_EXPECT_EQ_MSG(test, int_sqrt(test_cases[i].a),
+				    test_cases[i].result, message_fmt,
+				    test_cases[i].a);
+	}
+}
+
+struct reciprocal_test_case {
+	u32 a, b;
+	u32 result;
+};
+
+static void reciprocal_div_test(struct kunit *test)
+{
+	int i;
+	struct reciprocal_value rv;
+	struct reciprocal_test_case test_cases[] = {
+		{
+			.a = 0, .b = 1,
+			.result = 0,
+		},
+		{
+			.a = 42, .b = 20,
+			.result = 2,
+		},
+		{
+			.a = (1<<16), .b = (1<<14),
+			.result = 1<<2,
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
+		rv = reciprocal_value(test_cases[i].b);
+		KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
+				    reciprocal_divide(test_cases[i].a, rv),
+				    "reciprocal_divide(%u, %u)",
+				    test_cases[i].a, test_cases[i].b);
+	}
+}
+
+static struct kunit_case math_test_cases[] = {
+	KUNIT_CASE(gcd_test),
+	KUNIT_CASE(lcm_test),
+	KUNIT_CASE(int_sqrt_test),
+	KUNIT_CASE(reciprocal_div_test),
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

base-commit: 7cf726a59435301046250c42131554d9ccc566b8
-- 
2.29.0.rc1.297.gfa9743e501-goog

