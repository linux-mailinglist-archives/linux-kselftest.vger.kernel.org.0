Return-Path: <linux-kselftest+bounces-23116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46F9EB83E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 18:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892151886258
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123486345;
	Tue, 10 Dec 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvlvrpOu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31D23ED60
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851708; cv=none; b=rYULfKv806Nr88PmhOXgcD7aKZA4FWiy/Lzhl+RKY0cTUgxlPz3rBf3ndM7GqUM2p6D424b0vnxzxLdUoD81QvSPrl5zjKFt+77u1r7WXJ/5tH6KpbPs1jY/K3HErR1aG5s7SpK8sm9IVD4SrI9ZpCCobLGA7dA9FvSDSEqnK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851708; c=relaxed/simple;
	bh=PITXxIvrpP3dd0YiiFrlSJTh8tPjUUf3rGEZ76cpg6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdSnYsHpYs/qeDQgZR4SpGiHS5E49GN1UJpaekGvbxDjUesLHzNXxbtd2JjCgjIaNySJvbUY94jIs1jv8o38uhXVvB2BcQpI3+MRq80esUszbIaBOAxNkfzEUkzrbZiQdllMmgpa08ioeLWBRNWE64mK9DEMCmhG/ru/9OCKuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvlvrpOu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3a58827e25so1408438276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 09:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733851706; x=1734456506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxVhJwl3OLRoogX0vJCyHypohUZXmgGvC215FNUeOwM=;
        b=mvlvrpOuNBXfHO34QxFaxFdE/CfwthaUIl6UltkHwawp7pVGAlxQT6eN2eSPorc8+4
         OuldDG371AzPxoqn57xhW5FCHANPPt0dFQhLlt+lSJ6/STlolOHeFQTuPWMD1JR/IqJn
         QM0dwcOawkPUUNR/pN+S9pWOlTpaOtIuWg5SbsrqSAEVh1hdI5j08yJU3fYB3zBOBMoh
         w6CflQlshowUQijYnB6SeOc+yCYWTI1/Q1d2+9ji5xHOwt+91JmUiki4T0lHVNWvxAQt
         LLRFGOFixkFsWs2tb2w3Byoonjlirc9UEvZhUXE1P+HIJE6TecrGUWOnqBk3+YzZNMYP
         XLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851706; x=1734456506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxVhJwl3OLRoogX0vJCyHypohUZXmgGvC215FNUeOwM=;
        b=GpXJnOkfKL/J1Lh9hYxQA5mrZY4q7N4BPx9LF1he1u6iuadBTRG4xElhSE5UFYWm7O
         MiqCO9qnsRZNM8rUWEINIt1gr/Cy5OczNdqTP5BV0PmY7c2QAn1Owk3WYWlxJkhNROC3
         oImg0GkjUh7U39ik41n80boniIovLeZGjyUN7WS5WlChw68D7OZqw5faJ4Z0ndebAmtP
         GLNqBNCSMnkelxq/ueSQ09NQjWjhCiM5qlKL1lWp/3jeUeVVf9iMVWFtpmz3TwHS4lsE
         BIpvWSZTvFfdpLe1GokoWtfa9rUAZxU7i++F85/J2mEfuroy3IXerryy6avajGLw4bWN
         yamw==
X-Forwarded-Encrypted: i=1; AJvYcCWh3cwT/L0X/1lZSa7ejoOY10MhFeOAmUrbIINYKhuV1usACKkKO+By3rOqcaB1qq1hJMqazraM83Pd5NORNko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJCQEFNL5YVZ/9PunEqjAaljKT7a6vzn3u8kkR6f5B2xrsfKg
	m0Gaam9/Eh1epdhEN/1fWP6HSWSYpHQ/GX9jzblwQsVOlcgpvXYb
X-Gm-Gg: ASbGnctcaKySzMArYoDMsUT+bNG2KY+zJWvxoujAlil3szbv14FZkozyYllgw0PVuPz
	xnIRrUF8bthrTX9dbbv0bP7cTV7f11h5qHiCmoDEpQxGXBzA8kintO/ArL2dXsK4JWmgBxOTqUJ
	B4/aL/OGqTeXN+wsplRZYPKAK1ls86yyQxOImsZfO6t8jVk7d+B2MFCCp2/UDsGc+X3pZhTqzft
	99sTid4LXWFSUcXBbH2pd6ErY1BZZEtip7aPCapJMEyp8KZvR8fTVU=
X-Google-Smtp-Source: AGHT+IGmppz3mlH9kZHz99Dx7/YsghJEH0N6qwXv/Ip9J9iCdUHS4ZM2YrzcSWEcGgdGwzD+L/Qg5g==
X-Received: by 2002:a05:6902:3402:b0:e39:9df1:67c2 with SMTP id 3f1490d57ef6-e3a0b485186mr13775245276.47.1733851705662;
        Tue, 10 Dec 2024 09:28:25 -0800 (PST)
Received: from x13.. ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e39f7138861sm3124081276.52.2024.12.10.09.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:28:25 -0800 (PST)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: davidgow@google.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	npitre@baylibre.com,
	skhan@linuxfoundation.org,
	rbm@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	kunit-dev@googlegroups.com
Subject: [PATCH v4] lib/math: Add int_sqrt test suite
Date: Tue, 10 Dec 2024 12:28:07 -0500
Message-ID: <20241210172822.97683-1-luis.hernandez093@gmail.com>
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
  - Remove unnecesary new line after Kconfig entry for INT_SQRT_KUNIT_TEST
  - Correct int_sqrt instances with int_sqrt() in commit message and kconfig
entry desc
  - Fix limits.h header include path

Changes in v4
  - Fix Kconfig entry: remove redundant word test
---
 lib/Kconfig.debug               | 15 ++++++++++
 lib/math/Makefile               |  1 +
 lib/math/tests/Makefile         |  1 +
 lib/math/tests/int_sqrt_kunit.c | 51 +++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100644 lib/math/tests/int_sqrt_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..cc00c4ace855 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3161,6 +3161,21 @@ config INT_POW_TEST
 
 	  If unsure, say N
 
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
2.47.1


