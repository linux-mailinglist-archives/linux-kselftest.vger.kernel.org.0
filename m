Return-Path: <linux-kselftest+bounces-23238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A602D9EDD70
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 03:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEF71653C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 02:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730D13A244;
	Thu, 12 Dec 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faTI0rhc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00684A35;
	Thu, 12 Dec 2024 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969588; cv=none; b=lheTzuOj8NqPI06UdveRPGfOvIU240m01RUO1djtgkYLKRG+2BQFCeTvh6IR7lSu/8zcwHdbbCaGPFB50ZdFtqFs+e6EY2Hb5VAvLyjHlKUYi12lU2odglmE1hvB5P3AKenwYt7YCYj2VYchcht3+neqeKe/cvkhFhVz71lhHL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969588; c=relaxed/simple;
	bh=fFWHZp3MKlJnD43x2f0Z1mHjW9ZEBYL4CSXNLKb1tEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7MUSc0xqyAQkq5dLpFTNnoc89KU4lExUI6XmBUgjxZrrrXSLVWp8ROFXm9yKk480fYb7/D6J4y4Asb1Q5T3D4mFYraCaj1UuPR5TJHbbVh84b8Z1SPxgZ2nyY/I/+eapnGuoKNOCBJInLCsgprjfStrjJ7SSeUpck0mfUPyYQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faTI0rhc; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afeb79b52fso18220137.0;
        Wed, 11 Dec 2024 18:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733969585; x=1734574385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Y0wtLjBQsvZ6KC9hEfpTSMmwYeVYfpKKwx+sndi6I=;
        b=faTI0rhcNgdys4gBGcDJ6FaBDFWfe7kUEhLBc72/dOqvBN9VP34nYkR5fcyNvcPcXp
         fEmcl5hdbTkcLr9C5k/4Boq7L6ljHhzoGpnHmG2Z5UsGB1szmCeGqaNZiW3RO2Zss2AS
         e4s/TZ2qSrjddi+DUoQezIZIzPoQSGX0AaCNdAC9kibEPHzMyA4N/rzhPlUk38HED7nk
         4oM1N7WwYvF9e6saeR+myyhEJvEGuf/3E1M+K4MaZNZzfJ1U2JEshQ9gS7Uo6KudGHVQ
         DtVqN5kG7yM1Q8CRlDvZehVjheKgsds3LcE1060bsV96Z3DOnOX2cn6nGYRnCN7f5edq
         PUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733969585; x=1734574385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0Y0wtLjBQsvZ6KC9hEfpTSMmwYeVYfpKKwx+sndi6I=;
        b=MqT/whOX8JDJAMebcztjE1SQTjkkNLNSjjwMm20hDU5uiTuDD29tBozG+Q7mmSzIEl
         sVSsSofYQEr9Ea+aehjBYQfTRZDpTu4DSTAbahwqv4g7hdDeaLCH6z6iStaceRWHYLLI
         zWypuG6UQFdjvRmz6aRH59PiqLuUBp28sck+eYFDaeLWqz65jFaAFk2NTNCBEYx8oafe
         9wST9a4vvsQ/p7KELPocqJpxnr03bCp2qVBpUX0tUBMimx3Iuy1Eqwty1XrUth2gIYu5
         jSJ+c/GUcxDTeH5eoWh7gW1skAPUk77OUPPNrw54QZHIDTBqd5Ww4GlcMp9pS1h8rKM3
         EefA==
X-Forwarded-Encrypted: i=1; AJvYcCURIZxY0dQBjLwxLRv/UuXiuwb1iCFVMQqfjXyCN7mKDmoJFAQ/Ar8s50UWumNB4FnL+a3NrEZPNyYZzmc=@vger.kernel.org, AJvYcCWRqDrZJY3HOZCtob9O8Cyo/O3vLzoSLDr9uEF0TMOA8kCLkFgQANI085ntQWLhM0En6Eq24wBFLLQwDWw5RKEs@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrD/mIDQEGbylsc/FfWCzv4sx9UeRD3t2h1l1g72NXlqBOTe3
	5D89VzUXxZbjcPrQ3MLZyLQOoBttgzcV+frjyfUJIAUFcvm+2jOH
X-Gm-Gg: ASbGnctlow1ryq0EVF4sus3yiQJx53foJRruvQre9DeJQbTNrntx8YdsbgMHRKEfPd5
	22He5OSQ5LGbencn/Fpb1HW2mr0WnF5Mui8hHbLw1h/p2LGLcU1oNTlxX6EuTVplGlCo8BDkbqw
	jijdi5G1pmw9Zx9frdTOHRWlD1T3NON01YFyygZ/mOmGQ6g54bzbDi2zDEfunixzMVngvhEjqS7
	Rx5Y2sgi7knAsBPWMUhAUgL5GWj93qpzB80biZESEojzJlRekf9uqM60NW4zHZB1Lo6rcZ8+qhn
	qNe/0ei2ZjK7c3ADzZOYd+Anx9sMXQ1UR+QW
X-Google-Smtp-Source: AGHT+IFZbNn3kVb+kdh/aW+wmULIGh6BRjietFwtPeF+ZgMWgQ2LphVM3LQ3meQJQywglQBrzt3OVg==
X-Received: by 2002:a05:6102:5487:b0:4af:3973:6b22 with SMTP id ada2fe7eead31-4b2478a8ffcmr2253585137.22.1733969585166;
        Wed, 11 Dec 2024 18:13:05 -0800 (PST)
Received: from x13.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2b9f7980sm1886933241.13.2024.12.11.18.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:13:04 -0800 (PST)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: davidgow@google.com,
	akpm@linux-foundation.org,
	npitre@baylibre.com,
	stern@rowland.harvard.edu
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	u.kleine-koenig@baylibre.com,
	skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	rbm@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] lib/math: Add int_sqrt test suite
Date: Wed, 11 Dec 2024 21:12:58 -0500
Message-ID: <20241212021259.20591-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds test suite for integer based square root function.

The test suite is designed to verify the correctness of the int_sqrt()
math library function.

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
Changes in v2
  - Add new line at the end of int_sqrt_kunit.c
  - Add explicit header includes for MODULE_* macros, strscpy, and ULONG_MAX

Changes in v3
  - Remove unnecessary new line after Kconfig entry for INT_SQRT_KUNIT_TEST
  - Correct int_sqrt instances with int_sqrt() in commit message and kconfig
entry desc
  - Fix limits.h header include path

Changes in v4
  - Fix Kconfig entry: remove redundant word test

Changes in v5
  - Address review feedback by Nicolas Pitre <npitre@baylibre.com>
    - Make edge case portable by not relying on arch dependent macro
    - Add more edge cases
Changes in v6
  - Address review feedback by Alan Stern <stern@rowland.harvard.edu>
    - ref: https://lore.kernel.org/all/ad95d09e-ddbe-4d43-bf22-00c2008823d8@rowland.harvard.edu/
    - Correct recipient list
    - Spelling and typography fixes
      - sqaure -> square
      - remove extra white space
    - Add edge cases to validates boundaries around perfect square
---
 lib/Kconfig.debug               | 15 ++++++++
 lib/math/Makefile               |  1 +
 lib/math/tests/Makefile         |  1 +
 lib/math/tests/int_sqrt_kunit.c | 66 +++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 lib/math/tests/int_sqrt_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..147d9fef42e7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3161,6 +3161,21 @@ config INT_POW_TEST
 
 	  If unsure, say N
 
+config INT_SQRT_KUNIT_TEST
+	tristate "Integer square root test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the int_sqrt() function,
+	  which performs square root calculation. The test suite checks
+	  various scenarios, including edge cases, to ensure correctness.
+
+	  Enabling this option will include tests that check various scenarios
+	  and edge cases to ensure the accuracy and reliability of the square root
+	  function.
+
+	  If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 3ef11305f8d2..25bcb968b369 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+obj-y  += tests/
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
index 000000000000..1798e1312eb7
--- /dev/null
+++ b/lib/math/tests/int_sqrt_kunit.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+struct test_case_params {
+	unsigned long x;
+	unsigned long expected_result;
+	const char *name;
+};
+
+static const struct test_case_params params[] = {
+	{ 0, 0, "edge case: square root of 0" },
+	{ 1, 1, "perfect square: square root of 1" },
+	{ 2, 1, "non-perfect square: square root of 2" },
+	{ 3, 1, "non-perfect square: square root of 3" },
+	{ 4, 2, "perfect square: square root of 4" },
+	{ 5, 2, "non-perfect square: square root of 5" },
+	{ 6, 2, "non-perfect square: square root of 6" },
+	{ 7, 2, "non-perfect square: square root of 7" },
+	{ 8, 2, "non-perfect square: square root of 8" },
+	{ 9, 3, "perfect square: square root of 9" },
+	{ 15, 3, "non-perfect square: square root of 15 (N-1 from 16)" },
+	{ 16, 4, "perfect square: square root of 16" },
+	{ 17, 4, "non-perfect square: square root of 17 (N+1 from 16)" },
+	{ 80, 8, "non-perfect square: square root of 80 (N-1 from 81)" },
+	{ 81, 9, "perfect square: square root of 81" },
+	{ 82, 9, "non-perfect square: square root of 82 (N+1 from 81)" },
+	{ 255, 15, "non-perfect square: square root of 255 (N-1 from 256)" },
+	{ 256, 16, "perfect square: square root of 256" },
+	{ 257, 16, "non-perfect square: square root of 257 (N+1 from 256)" },
+	{ 2147483648, 46340, "large input: square root of 2147483648" },
+	{ 4294967295, 65535, "edge case: ULONG_MAX for 32-bit" },
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
2.47.1


