Return-Path: <linux-kselftest+bounces-20569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69869AF28D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E55228B20F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015842178F4;
	Thu, 24 Oct 2024 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6TZmFxW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEF208968
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797459; cv=none; b=WyALqpTvAwHlZQ6GRfh+e+1wpNgmniI7GPtJGYd3hrCX/uAo94GnpGXy0CFWcv+duS5KFNwE531rcVLd7PaoJKrBcTnvab5LjdHBrAmlyPfO6XLX+WvLst4KGn+K95kkWE6Tj2B1h67DU3zbUzyekrIrAvdb4zZ+zFkZPmLxW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797459; c=relaxed/simple;
	bh=+4IttYR4kTs3BgakyteqDLXe6FUHJAKHRCl8Q2HFcqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ty7f8wa56Nau0PCKHeXJyKXnGBf+DsLsJPwjY+olO6dpLWzUo7B0/LogXPHlpXt1EyTiwL8icJcWfz9uuC+Jdd9EBqXe1pHWuP4ibEuhRWuWUSyV/kzvDYjZW/r0QbWwOOH6mtJsPY7VXmz6ZLmJow6OQUU7Aq3+3UR02RcHo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6TZmFxW; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2e2d013f2dso1498836276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729797456; x=1730402256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOWx7jnVLhhYqmmc0kk5hR8SpqsjGY3VnKJpFaYMEEE=;
        b=N6TZmFxWheJccVY/baKcZSlIYT3iSBhH1PSkgbbrX/NkPfYY2eMIoAX+YK/yFYuoln
         7tQ3O4il7Nt4U/KoUdPY6rQYOrjnj696zWfExtRYhgUlyyASWYZMgQIyOR7qdllfBsBg
         m+U1fYSRaegSea00Pp5uFuMtOWnYdrL8zFHwSSLsSnKMCQ6qk9JvqM6oEZFP7ZBp9xJP
         PB1POR3F7bVQ02+6Imz2HC1HetUIRUXH10yicsuy7hRShwC4fS+CnJst+h2zy7V8brV1
         Pts1d4dr4psreryyC6/mQQQxyvpSmVP12m5s1Cdf9O7ibtcNkemZ19aBqjVymlzXhZ+R
         54pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729797456; x=1730402256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOWx7jnVLhhYqmmc0kk5hR8SpqsjGY3VnKJpFaYMEEE=;
        b=V/BslcJ6+nl6laoV8z7neNz4+g4gc6sFLwMLKycYVWuAwcemydBzlypWDC5CzGVmGr
         gJwIkwCGkywaePna7i2Vhb3nm8GFeTfVZrJvTEYT90S5mOY4r2rJwLOKhLZ+DtuTI6th
         WY15vFY+d85/38lbFIN6Ebzbc4QOwoxGFCf54wKV7I5jGd4QP3xqiGcJzVLXxbz7irY4
         Y9sxC2sT0Tk9qwLT5o9oMsuM9Ta36C25vLPGzPNdpFfn7ilMBk+JDGnmPa3CUlmCumWu
         LQKAh8A+uHcGBLPju7bu8Y9c3aA5cFUp6+AE/AsnceLL8sHVi4spwl7ovjYHHQHex6t4
         v2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUmZ/SEMDTJzFPweCPzKuSuajahNwNeRktJANi4x8aBMP69O2tQqksnjBwdSjDSLbxgJZZVUc8pM5TL/Hed20k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzndieYGSErGiN+9RcB6k3UNP9lHKWwsTXhjqmmw4CvmOtZiv4m
	VupSQIXJv1J+jxCqewN6PHaIJSHJCpMrK7LCorcMy9u/UGDibJAX
X-Google-Smtp-Source: AGHT+IHNpssd6UN8JLxojgixsRYKJvUh/JkCow3Wp0tb3/0LUzQwzYXgmxyzyOR6if9R4VcVR1Ma2A==
X-Received: by 2002:a05:690c:308a:b0:6e2:50a:f436 with SMTP id 00721157ae682-6e7f0f7e58cmr76490317b3.36.1729797456463;
        Thu, 24 Oct 2024 12:17:36 -0700 (PDT)
Received: from x13.. ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d749e2sm20787287b3.142.2024.10.24.12.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:17:35 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	davidlohr.bueso@hp.com
Subject: [PATCH] lib/math: Add int_sqrt test suite
Date: Thu, 24 Oct 2024 15:17:28 -0400
Message-ID: <20241024191730.69542-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds test suite for integer based square root function.

The test suite is designed to verify the correctness of the int_sqrt
math library function.

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
 lib/Kconfig.debug               | 17 ++++++++++++
 lib/math/Makefile               |  1 +
 lib/math/tests/Makefile         |  1 +
 lib/math/tests/int_sqrt_kunit.c | 48 +++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 lib/math/tests/int_sqrt_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..a7e63dae9281 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2993,6 +2993,23 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
+config INT_SQRT_KUNIT_TEST
+	tristate "Integer square root test test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the int_sqrt function,
+	  which performs square root calculation. The test suite is designed to
+	  verify that the implementation of int_sqrt correctly computes the
+	  square root of a number.
+
+	  Enabling this option will include tests that check various scenarios
+	  and edge cases to ensure the accuracy and reliability of the square root
+	  function.
+
+	  If unsure, say N
+
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 3ef11305f8d2..c7b043ffb249 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+obj-y  += tests/
\ No newline at end of file
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index 6a169123320a..e1a79f093b2d 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
+obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += int_sqrt_kunit.o
diff --git a/lib/math/tests/int_sqrt_kunit.c b/lib/math/tests/int_sqrt_kunit.c
new file mode 100644
index 000000000000..9935f52e808f
--- /dev/null
+++ b/lib/math/tests/int_sqrt_kunit.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+#include <linux/math.h>
+
+struct test_case_params {
+	unsigned long x;
+	unsigned long expected_result;
+	const char *name;
+};
+
+static const struct test_case_params params[] = {
+	{ 0, 0, "edge-case: square root of 0" },
+	{ 4, 2, "perfect square: square root of 4" },
+	{ 81, 9, "perfect square: square root of 9" },
+	{ 2, 1, "non-perfect square: square root of 2" },
+	{ 5, 2, "non-perfect square: square root of 5"},
+	{ ULONG_MAX, 4294967295, "large input"},
+};
+
+static void get_desc(const struct test_case_params *tc, char *desc)
+{
+	strscpy(desc, tc->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(int_sqrt, params, get_desc);
+
+static void int_sqrt_test(struct kunit *test)
+{
+	const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, int_sqrt(tc->x));
+}
+
+static struct kunit_case math_int_sqrt_test_cases[] = {
+	KUNIT_CASE_PARAM(int_sqrt_test, int_sqrt_gen_params),
+	{}
+};
+
+static struct kunit_suite int_sqrt_test_suite = {
+	.name = "math-int_sqrt",
+	.test_cases = math_int_sqrt_test_cases,
+};
+
+kunit_test_suites(&int_sqrt_test_suite);
+
+MODULE_DESCRIPTION("math.int_sqrt KUnit test suite");
+MODULE_LICENSE("GPL");
-- 
2.47.0


