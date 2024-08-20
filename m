Return-Path: <linux-kselftest+bounces-15736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59553957AB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 03:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D51C20FCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF78DDA6;
	Tue, 20 Aug 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONWD3ra+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAEC8E9
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115845; cv=none; b=PSGh6XMaFBL1ivN96ze34jaEg5+dVvDl/2wJCLe5NZztvEJfUUEGGXwWuNYYkMl3VT7re3/2GTy5rNZ8sOzIltiWrwF8ABdrhTp794nJtcpW2IrFLrGIe+ngoWUfDUx6CSho/AJUvl1NXpXttEKek+SFGl+TuuM0DcyV4NBJR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115845; c=relaxed/simple;
	bh=IZLXBA7ZZL9JQUfezOi9Myz8vJBxrzmGTbhPuknJdBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aj/5eo3o9Qs52eRjtCyehxgDwKFN241KHadBmt+vXaAMMPR2Zefv9lGc3batG5VrPU8CKYJ5zNSxH9lkkCKQov05k7l0HyaqrTOfRHpkzdtiMa0YyyuFxOFts+QqR48jdRZ/+sCT+3Kd0Re1q5EN0e1s3kmdl7eonwdd6YCRNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONWD3ra+; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4929992a5e2so1695191137.2
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 18:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724115842; x=1724720642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9cBkJC0RP1zERiTMVgnYdt05/xaN8L9Ga6Qql299sY=;
        b=ONWD3ra++v4HFKWPsh8daZURKrLH3HeD6TqyfKNLgpKo7WbWRVTjrEvuRbPrNvTNHa
         RXjDDrjSZxhWE3uHsYkuCB5O4JHKJ3a6iuA1RHvu5rGc7T4miI64bSnN5G3pz4x3i4yn
         OM/0uyrNlGLmq8TpIP2RL9IKj5gVowUpQ/t6UkPlvs5T+tUGDgMgEQgeh8w7Uz2aBITS
         H+jQPJv1nHlTRfjBOYtPAHmswcZPNwQ6o3CcG9Kd+02MBv6iig/olHhLamNm2vXHRRm0
         5+ph1A9tflUc54wA5rEd1PjUB0DUFQfIUpzW9VbcIpppmjtFZ/ajAfZtrFf/UcxtDqte
         N0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724115842; x=1724720642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9cBkJC0RP1zERiTMVgnYdt05/xaN8L9Ga6Qql299sY=;
        b=ict7KdzUPQe9+p4079e/D6zk6Jmhko1fKEMNDHBE04OFNylligIGhS0I/nbU+naMQZ
         uQNayY9NJlr9FN1bhd8OKNsDStjq0CtzZKeKCl5lwaTc4/YA1kbw7OyiBxzhnwzu3bcx
         mz7fzH56vzEEECv1ujE2BZyBD9uDjmrLaD7mQs6kEP08J5TGyE86rk2xarCxQp1nS0O8
         bftO3LAZxAB1XyG5SBjNolsZpbLljlEdyjlR074tCrvKXwJ8hDwXklwwYDyGuif8W+xD
         aTR5uI3jicSqAapd50aQma7NTWIJN3XRIZiAr4o0MsDvNYA1zUNMXlPuzfylcswonMgI
         lgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzVNF6/tVHBII1QG9vNhmJt2MkScz2Sx1jfj1b4M6EBfA6LYfDrACtNxOvmo1ATZZ/KtxY8rdbg4eH20/6d8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV44gU+8cYFsjY7lo47zAjLDXXGmKG3Int3PcOVF3UT/nJlfYH
	Zv7kLyng4xjH/tmyR0C3kMibqY4ClBUHapUGByRZrHx4xAvVLd7I
X-Google-Smtp-Source: AGHT+IHmsFq3kmTL7RHWh4Pv3B7eZi49R5V1M7QDJNDVqWUuTMcARCMHA9u1QlKEKlwjTcX3UmcuZQ==
X-Received: by 2002:a05:6102:85:b0:498:9aff:a193 with SMTP id ada2fe7eead31-4989affa27amr5093189137.24.1724115842236;
        Mon, 19 Aug 2024 18:04:02 -0700 (PDT)
Received: from x13.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-842fb9c6170sm1395040241.27.2024.08.19.18.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:04:00 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] lib/math: Add int_pow test suite
Date: Mon, 19 Aug 2024 21:03:52 -0400
Message-ID: <20240820010353.7533-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds test suite for integer based power function.

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
Changes in v3:
- Fix compiler warning: explicitly define constant as unsigned int
- Add changes in patch revisions
Changes in v2:
- Address review feedback
  - Add kconfig entry
  - Use correct dir and file convention for KUnit
  - Fix typo
  - Remove unused static_stub header
  - Refactor test suite to use paramerterized test cases
  - Add close to max allowable value to in large_result test case
  - Add test case with non-power of two exponent
  - Fix module license 
---
 lib/Kconfig.debug              |  9 ++++++
 lib/math/Makefile              |  1 +
 lib/math/tests/Makefile        |  3 ++
 lib/math/tests/int_pow_kunit.c | 52 ++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)
 create mode 100644 lib/math/tests/Makefile
 create mode 100644 lib/math/tests/int_pow_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..b0bbd30d4cba 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3051,3 +3051,12 @@ config RUST_KERNEL_DOCTESTS
 endmenu # "Rust"
 
 endmenu # Kernel hacking
+
+config INT_POW_TEST
+       tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
+       depends on KUNIT
+       default KUNIT_ALL_TESTS
+       help
+         Enable this to test the int_pow maths function KUnit test.
+
+         If unsure, say N
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 91fcdb0c9efe..3c1f92a7459d 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
+obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
new file mode 100644
index 000000000000..6a169123320a
--- /dev/null
+++ b/lib/math/tests/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
diff --git a/lib/math/tests/int_pow_kunit.c b/lib/math/tests/int_pow_kunit.c
new file mode 100644
index 000000000000..e04dd73dabd1
--- /dev/null
+++ b/lib/math/tests/int_pow_kunit.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+#include <linux/math.h>
+
+struct test_case_params {
+	u64 base;
+	unsigned int exponent;
+	u64 expected_result;
+	const char *name;
+};
+
+static const struct test_case_params params[] = {
+	{ 64, 0, 1, "Power of zero" },
+	{ 64, 1, 64, "Power of one"},
+	{ 0, 5, 0, "Base zero" },
+	{ 1, 64, 1, "Base one" },
+	{ 2, 2, 4, "Two squared"},
+	{ 2, 3, 8, "Two cubed"},
+	{ 5, 5, 3125, "Five raised to the fith power" },
+	{ U64_MAX, 1, U64_MAX, "Max base" },
+	{ 2, 63, 9223372036854775808ULL, "Large result"},
+};
+
+static void get_desc(const struct test_case_params *tc, char *desc)
+{
+	strscpy(desc, tc->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(int_pow, params, get_desc);
+
+static void int_pow_test(struct kunit *test)
+{
+	const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, int_pow(tc->base, tc->exponent));
+}
+
+static struct kunit_case math_int_pow_test_cases[] = {
+	KUNIT_CASE_PARAM(int_pow_test, int_pow_gen_params),
+	{}
+};
+
+static struct kunit_suite int_pow_test_suite = {
+	.name = "math-int_pow",
+	.test_cases = math_int_pow_test_cases,
+};
+
+kunit_test_suites(&int_pow_test_suite);
+
+MODULE_DESCRIPTION("math.int_pow KUnit test suite");
+MODULE_LICENSE("GPL");
-- 
2.46.0


