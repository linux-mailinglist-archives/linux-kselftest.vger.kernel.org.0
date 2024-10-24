Return-Path: <linux-kselftest+bounces-20571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D19AF304
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36802817E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E2318BB8F;
	Thu, 24 Oct 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0W6uuFi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D084037
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799719; cv=none; b=I5TixksY3yI+/UwfID8pJKSirO69Sb9ud+EXER0K5fV53o+fdmaqHEZMuY8HuA/lb04mbAYByj9NFhEpoknCZVBfxfE60n0Ta8+LzzlxtXkrIJSQOvyW85iF8XQircf3qoVW5OJwHETF09JeQui3m6nSM4ymrUYGjG4wpC3EDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799719; c=relaxed/simple;
	bh=YUcfI3mJydqMZ5SbUUyKpBqgyyQ1WhBvhzCjDpbUXAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttFPHan51UDRGvVTFjhLDNd6UreW4pS7e2AhCcuIPYbmCOjcniZiq1oF8dWbFA95yn67VCGgA5JBnSVGxEmvbbZAIjf/S1Q608BUGgOzt98GqVLp6/Y2gjdfiWEZNLrcRZNuIf0OAF+kMrzHpF25n72PPOPoBvF31V4kMKJFcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0W6uuFi; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e35f08e23eso12904087b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729799716; x=1730404516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQbL6xtxKdi2l7nN5S7Vs3vuzfztUrnDWB3s/MG43AU=;
        b=R0W6uuFiMQzTD7CcEJhDK89JBFJNO7RpiBN1AR8a/am8hw0bsL+NoY9NSalUTu0FZB
         qst1OKp2k799prgWcwzgztPPmc5jv73BWiepwPwxWP5dSqPoppNgaiCe8pnKRR48wu66
         9H5OAuDGRLG7QEVcnmXaPFpuDPzmLaP2uivS1zV0W8D8DWdQ4XF60R8SM5MMC0yPXDil
         tD8+VxWl9EW+dktwOUTVlWTDz4NL/uByIM0mmNxy2/73x/tiRVbqsp2kLtFB2D4ezHD5
         XHKEs4rh2iOBa7IlJQm6MSVG7NuF8xvtYW79Zgr/iuOGBlGAjvd82tWXIm8QBcoIxC5/
         l9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799716; x=1730404516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQbL6xtxKdi2l7nN5S7Vs3vuzfztUrnDWB3s/MG43AU=;
        b=Y5XiE7G7LwpvTMZx7usrIso5jkIcf7mdEnbmrj6Dd7QQqBaWDaDUOcNQm9nuRSByy+
         4Ik8m93a5gTIXAruUZ11/qKYUhh3aYEdj6Avvzcg0+MiSLupqocELiWM+5lmpukHhykt
         +YFo3d11G4aSxJa95Bfu/KOt7zNI6iMJoLsqxJC+AnJgJ7fXw5XQpJuGtK4aID2XAX1w
         eeTw/nn8Kx5pcnCyeR75RbyTxD0i1jZRNySwteE2aeJs4uWFkahV9W0Bw3DAdbYpC+1S
         PHbM8350Hj6vAKjO6KZAqXzUFpGy7d087MFnZ4tsACxZyc9mUPtIqIlUc7JNUUt8kwh1
         krpg==
X-Forwarded-Encrypted: i=1; AJvYcCW9odhHtNpvwc/2lHBa/QnMdfWv//rQbrTpxXzFNWr3VQDg/rafqmvznxGIEYA+1DPzUvBLhojvtPxrF/x+EdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWYhq0ffrIP7o4uSWOiXPpECuNUnQOGau0JQny1z7k3/vhsGld
	fb9OIngBXRMX4o9vcuxniL43wyBUDnyRHNbSLHqdt6I3BVYibNNf
X-Google-Smtp-Source: AGHT+IEFgp8o1SzksY5ernF9kkYPxkwMOor1qgU4ZUNCodmKUOEuvE8Z7c7hjA5y7ESax62tTgQPzw==
X-Received: by 2002:a05:690c:6f8c:b0:672:e1f2:feef with SMTP id 00721157ae682-6e866332642mr41647867b3.43.1729799715765;
        Thu, 24 Oct 2024 12:55:15 -0700 (PDT)
Received: from x13.. ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4d396sm21296137b3.38.2024.10.24.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:55:15 -0700 (PDT)
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
Subject: [PATCH v2] lib/math: Add int_sqrt test suite
Date: Thu, 24 Oct 2024 15:55:09 -0400
Message-ID: <20241024195511.72674-1-luis.hernandez093@gmail.com>
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
 lib/Kconfig.debug               | 16 +++++++++++
 lib/math/Makefile               |  1 +
 lib/math/tests/Makefile         |  1 +
 lib/math/tests/int_sqrt_kunit.c | 51 +++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100644 lib/math/tests/int_sqrt_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..772c681dff3e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2993,6 +2993,22 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
+config INT_SQRT_KUNIT_TEST
+	tristate "Integer square root test test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the int_sqrt function,
+	  which performs square root calculation. The test suite checks
+	  various scenarios, including edge cases, to ensure correctness.
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
index 000000000000..a93aba31cd05
--- /dev/null
+++ b/lib/math/tests/int_sqrt_kunit.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <limits.h>
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


