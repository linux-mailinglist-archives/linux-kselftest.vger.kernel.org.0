Return-Path: <linux-kselftest+bounces-21097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C19B646E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440671C20F7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978381E9092;
	Wed, 30 Oct 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqWFGFnC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702331E32D8
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295853; cv=none; b=TOzVWOcN8y3qQbnjTlOSnZVI7DtTBCI6U+jb79Kbfxpfa4e/9BV1VmNcU+Pyvva8Fupg0y68zI2im4uSXn25NdJLyiWStDCr51NBctRFtV9AAlMmR+Epv1EnZ68HN6mfEva0U6s3kYVjgVTdjKvrDXShI8LnVuMOQHUSdavbu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295853; c=relaxed/simple;
	bh=nUon+G46zP2CSR3tR1gbd+JLlhnCUVcpuNgOZP3VoGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tEBpfWjfUgSkm4rtOCnXMm90tb5f/NaNCmvn0Se8LJATQIcec4Ee9wrDuOG8FN/dystNU9kZ/m1l65TwcgAGoAUQcV+MUZ7X7vt30mquqPTBpdHsc3c3dOu1ugl/QPIZZvTHiM07asyruRwxtMb6fqhYqwDoi4n6fPejxrlG5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqWFGFnC; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e5cec98cceso55579917b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730295850; x=1730900650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gohomfedkfXRjVspcTaXGu7eMc1O0Uh2mGX5FqgSJHQ=;
        b=RqWFGFnCkjuCq/zBZgBQl5cpsDezLzaAHlo8CfL1yC6JNOXtpNnnnwYS+sp1XrkaQE
         vD2c2u3O5RkqsZGimsGKt/ZSK8ehx2xs2fStOgP8ZWBQB6mmsfJZ+a7uZn7iOM5vnSoA
         F8bJe6GsjJFJyRFfdER1KemW8EzyGv39MNA1qrJJkhstV1uG16U/a646TB0DkAZfZgfW
         xSqKf07MkUAgB8bNjoUbn8h9FowyQI6utU7Pqu/LzasIX5sKd2vIOc9HftwtVq9v48kn
         H4zR4q0XlUFIFKRD5OJ+Gc3FK6f4pYvAdbOzhf13t8NlDxIa27/K+v2Ezp+mogz3bkr1
         CqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730295850; x=1730900650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gohomfedkfXRjVspcTaXGu7eMc1O0Uh2mGX5FqgSJHQ=;
        b=cTWWf5ViI10TPWM7v24gvPMwUM4rDxEcj8tJ6NMxwcyNKo83mawWTnk0pc/D4Z+pIZ
         I8pkS2K7otTBs8Uo7ULg60swWFdZ4z+6ZoTbLxvjFsuj9LL2u6V5dFrF8FEZLO6rU48l
         iSOWJ0yjfMOrn1iLM4H5U9LlXiApJWqOODosPppSTh5pIV5Pr7Ok3cWWiFEiKaVqT408
         wtkz3BGWg4nky55Inkc5uAnQ+vk5lnPZzB+Pqq5jZO1pXl8R/eI9ps09yIHmRlv32osN
         /cl/GZJv6Og4l2Th6ygWVvemUuJHnzgmHeun5JyU4U6TV1HdHbZwbNQWFmzRR+8rL33H
         +/jg==
X-Forwarded-Encrypted: i=1; AJvYcCVtJGzSyX9gr+XHEyZ6QGCdQGNEw+h9vyEgT4Jmx6sLB84N8ouUifMjVtxViXYVkFY6zeQeM6TmbuexxG+TbQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKKk5M+W9TRk4toyrbgYMGYSy1OAUrVWXbPB6lp02IvjtAlUs
	Dh6QeHQKAIdNo/tbTYvIwMATOrq+vKgqboK+n/C6Yl5VemBMDtj2
X-Google-Smtp-Source: AGHT+IFpXFYXK4s+dOnVRg7C2fehk9sad2Yniq1DKN9iBPyfplZXUV1i/apuQDy41OL24kqCCBUiWw==
X-Received: by 2002:a05:690c:f87:b0:6e3:2e4b:ad9a with SMTP id 00721157ae682-6e9d895d649mr170300547b3.12.1730295850206;
        Wed, 30 Oct 2024 06:44:10 -0700 (PDT)
Received: from x13.. ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c19d42sm24600357b3.71.2024.10.30.06.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:44:09 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	andriy.shevchenko@linux.intel.com
Subject: [PATCH v3] lib/math: Add int_sqrt test suite
Date: Wed, 30 Oct 2024 09:43:53 -0400
Message-ID: <20241030134355.14294-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.47.0
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
  - Remove unnecesary new line after Kconfig entry for INT_SQRT_KUNIT_TEST
  - Correct int_sqrt instances with int_sqrt() in commit message and kconfig
entry desc
  - Fix limits.h header include path
---
 lib/Kconfig.debug               | 15 ++++++++++
 lib/math/Makefile               |  1 +
 lib/math/tests/Makefile         |  1 +
 lib/math/tests/int_sqrt_kunit.c | 51 +++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100644 lib/math/tests/int_sqrt_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..c83f5dc9bb48 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2993,6 +2993,21 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
+config INT_SQRT_KUNIT_TEST
+	tristate "Integer square root test test" if !KUNIT_ALL_TESTS
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
index 000000000000..3590142d2012
--- /dev/null
+++ b/lib/math/tests/int_sqrt_kunit.c
@@ -0,0 +1,51 @@
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


