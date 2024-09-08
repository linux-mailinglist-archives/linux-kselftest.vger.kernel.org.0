Return-Path: <linux-kselftest+bounces-17453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09A970A8D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 00:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0071C20AB6
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310C714A60D;
	Sun,  8 Sep 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2ExeHAO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723E1F942
	for <linux-kselftest@vger.kernel.org>; Sun,  8 Sep 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725835759; cv=none; b=dJUruLhuC3nuRjMgp+XVdAEKQilOnuTo1cmT4LiUK00y+KJMk3zt2Q4DKUTpojEFC2Sqv8aBstvxHHJ8LXZ+iL6p/LpIULE6P5qsLi0CGuQ3Oo/VjZJ8IYo0x79XpGcjAqK8lsDZETPod8eHLnbx/J59lZcs7+E2hnrNqbr8w8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725835759; c=relaxed/simple;
	bh=XobwUWOh56A2ORGRWy81jc+sC2IYkaIf/WVd7sEd5IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=plieUy+82MR9OFOOGWRQoUZco+pxnU8xwOko364EnGB6Av1ysWuyj7bT3nO23fJ9k2QwsQ2JZBw6lxfNRMKoBaYqfy9ojGWqXBAP551ZFT3EXZvM/hsiD7UfTo2vVtEFShcC4ril+4QnYAFoY5EPRKj38aA3KwOILhitMbZs60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2ExeHAO; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-501204753c4so1843745e0c.0
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Sep 2024 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725835756; x=1726440556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZG8fE7MnIIWkTK02T0n0emfeqd4RC7NYBpEVwjqHdI=;
        b=i2ExeHAOu9rLVQdOyjZRJ70bKk6TI5MCkIJl53TZ9Fe+bB1pr+Sa4AJvwHjNYSkkJt
         VIGZnNPZT6kMDbqeMT3f4VQWDsaXWPi+KWYVl50drJ3kk0rhoKk+rSOjnkUxywSHQQE9
         RxXQ0FUH25T+e6icS8hwq4kspj/DtKvo8Kso4UhA4EaxmwoLe52ev5b3mtfOzEc/DKdz
         VWTImDOWEdhVsRvilBHKgeg6nXED/9mr2P1TrXcsqrJG06TQZlENjsZaAIekfrs3ziN5
         D8+JWyl7/YXtJDGi75qUxteag5rwjjzcygYaWIxahZ1mAmtBq8Ph053UoQ4elp1ikLjY
         HiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725835756; x=1726440556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZG8fE7MnIIWkTK02T0n0emfeqd4RC7NYBpEVwjqHdI=;
        b=Dm+DXP0soB7rl/Gomall17q8wMHDBCxqN/H/RTC53f4HUsls97673Cs6PTxt4uqGLO
         FiiYyl1TKE15NuYqlj2Qen+0OtNBd9thBz4v8jLGdCPiQzvd3OQArEtEf3F1h+oiEoh+
         jrEnznJSPtYBirEBrWEDhMpcZRZkuWWLcuImd2J+dPqXJg5yInv8PlrnNzuN/ODojSYC
         g7egF6AQLdJ9FUVjJQAve0HOP8fc1W1xOquJMTixJQeo4y4G5ti8FOvOh02Ys0G3FLP8
         4zPzg8xnXZwiWxvyuwWS7r0s8B1FC33p1nBCnYdclJPJMEqVcbqWnQh5XCiSJ+7A+oOj
         sYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbFnB6oHx/Z6UaWrqPUOVa3l8dC0hQME1Q75VURIs2QY9ldDl7jGbEqh4vvpvZlCycR0bm/x9eazNGEixApao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNnjCnmtDA5ZfdHi/onvlD+I1JlqGX7cGy5G5R4kwZL1l6y64
	4wsGMmpOehNXOfRGxAiks03Ekib0aKpRET2I5G+NcQ6joowDx8JD
X-Google-Smtp-Source: AGHT+IHK1MHSN0mrxVtNABHivQ+TMISsFu0SsBlaZrouldvmIKbkDlpJl51j9FRBYFVQCovYvlMGxA==
X-Received: by 2002:a05:6122:904:b0:4ef:58c8:4777 with SMTP id 71dfb90a1353d-5019d455718mr6869788e0c.4.1725835756314;
        Sun, 08 Sep 2024 15:49:16 -0700 (PDT)
Received: from x13.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-502c2419fb3sm262914e0c.37.2024.09.08.15.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 15:49:15 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4] lib/math: Add int_pow test suite
Date: Sun,  8 Sep 2024 18:49:00 -0400
Message-ID: <20240908224901.78595-1-luis.hernandez093@gmail.com>
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
Changes in v4:
  - Address checkpatch warning and make kconfig description longer
  - Use GPL-2.0-only for consistency
  - Spelling fix fith -> fifth
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
index a30c03a66172..0f98f73d4322 100644
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
+         This option enables the KUnit test suite for the int_pow function,
+         which performs integer exponentiation. The test suite is designed to
+         verify that the implementation of int_pow correctly computes the power
+         of a given base raised to a given exponent.
+
+         Enabling this option will include tests that check various scenarios
+         and edge cases to ensure the accuracy and reliability of the exponentiation
+         function.
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
index 000000000000..7b6a5ae70eb4
--- /dev/null
+++ b/lib/math/tests/int_pow_kunit.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+	{ 5, 5, 3125, "Five raised to the fifth power" },
+	{ U64_MAX, 1, U64_MAX, "Max base" },
+	{ 2, 63, 9223372036854775808, "Large result"},
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


