Return-Path: <linux-kselftest+bounces-23296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 990229F03CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 05:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B7B1882D4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 04:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087F17E00B;
	Fri, 13 Dec 2024 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE8NNnh3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04C149E00;
	Fri, 13 Dec 2024 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734064029; cv=none; b=Y+DatMsIQcRFI6wIWEl993h1TxzunpDMTTXBAonsXBoX/VtbWXNtVRv3O/ErhfRUI3eZD1IK5GSUio/e5/8Zj1wVddcyKP/iY8ftiIMOAbPDd+Zl1uOKrcMNmrCUBqHn6/FNGbmM5PrfcgBQ0gvozqux04x7z6YxscFCChlykgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734064029; c=relaxed/simple;
	bh=PjL1Ykco8HVzG9IFl88OM+jnPP6HT71hIZ9O3TF4fb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BioEwyiuY2saC2kRv7ZB6HJAvqEWIvUMirD2NqNpG+eNGNxsbtlAdtv+yMtTkTgRsiyq99F1bA/9Ya0kgLfaFUzOXME7/jTUu6cfCyNsngICkBz8EWfDsYtV2MnuP8Kfa2lPrrEzYdto0EXqrJDqFhzRtBxtyUK1HK49GFsEwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE8NNnh3; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5189105c5f5so673845e0c.0;
        Thu, 12 Dec 2024 20:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734064027; x=1734668827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFIE2oFTL5RsiGL4yGnXOTeASsgxqZiZltFWWa94vak=;
        b=nE8NNnh3OkpRYnsDKnQQxhRKM2SxrMP8G6PXdvorZ7eq85MwJrRzdvlFCCu1N+jRg/
         ion19ogZ0hE6Y5fgZFSscMZFE6yES7uslaxTUh0TwZl1EXJVTFhSFMXLM/AB4QOOhqPH
         ubnWfOtgA3JtZ2EOFFJ7F4KLKER1pXrgmtVqRlGoQRxO+aMPtU76YIIa7qENx/jim2bf
         pMU/QJeBWaBVxnfE0gjukT8VHnIzHRlH9kpn78E0HtJWTOA0CSZKVcRXuUcoT3pIb3No
         L8mcoBX5vf743Rbz78g3PyE8PqJz1ANrQasFm+QqrWR70vNG3Y6mEo6K/OlfSvVKNs9B
         ODDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734064027; x=1734668827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFIE2oFTL5RsiGL4yGnXOTeASsgxqZiZltFWWa94vak=;
        b=heF/uX79KhqaqD3J6nIFe9XLxdT4+qw7lSFdIsZVmm5YTV2u0P5RAjpAzfjb2YdeVv
         B/TOuunAkdSyKL6tOlZfrVgBTwWYPijUdfSaCMbRA69xq70Dab6LMEQN0Ygrf9BewzVb
         92xlZRdT2RdocLf1IMVxHhcXLbbw8BGiG/CJ2pfUjQxf94Omlz3sd09cS2LYxKq9Pxw1
         rPpEyUa2uO/0QtyP4OT/fRnrZlyTDGRziwLGNOiG6U1mK67pYkV5V7x63jqXvlOwnvjO
         m+OAS7WrATOtVtsllc4JE7+zikpDQHuyTdtvHfTLYc4sojAqMy7YAV54U6aOuMhTDSXN
         6qKw==
X-Forwarded-Encrypted: i=1; AJvYcCUHeDYDaZy/SG0W5+Vsb3aMfXHVhu111n1ybiGQ1OnMUorBCT/xbsUvgamPwu+ScgX7qMXlwyZulARx7MM=@vger.kernel.org, AJvYcCW685ZeyvMfuDwTpuvba5IA02l5XrUgc2LCs64lWcrFnA3kCz5gdSQc4vnVjyCr+fodCN0mpCyeQeG1GGze+HeG@vger.kernel.org
X-Gm-Message-State: AOJu0YznrGq7tB6xY8ZZVt4Kj0tw2KQSmRvzF0RmlD8qX1qgBBHcFOr0
	Y+q8Vd9r9ypoOIZ3ovG38c+0QTbIj01dXvQgtAY3AwkV/GqW3UBj
X-Gm-Gg: ASbGncvfOLtILsjZzT5drWKSPCMu63I7/fnFX/WADl/BWqmJ5qI7PslvOuoRUuRFK1j
	FpQBw/vR4hOCL2wuHsa494I2LK5iFOtxPyB/2UaBDoUGkMbFFjH2aSFOJ5S6EaHjz0Dw9Vl7kzy
	vYI8GCiKi5kLOiLIfAhC2/bcar13WcdAvp6qzCsgAA9g3Q525ycZHXcubvLKcPJLvBkYkMkrDd7
	JDwUWaoaXB1pNd0c8rFIvmHYSwud898Tc0AoMKUX1LswAtdI/yXgIAvVUr1AajoTn/mtHxps1Xu
	hPDwGkW75hbSIlSy4Z4xW5LTXit9anbBZYFc
X-Google-Smtp-Source: AGHT+IGMpCNDA5EpRH+Yj2oXjYJ5jqJbGHiTvFiUeGCAQV6LTCnPR+Fm5peOQUpqg30Npa50ajF0IQ==
X-Received: by 2002:a05:6122:8c0f:b0:510:3a9:bb87 with SMTP id 71dfb90a1353d-518ca3850b9mr1575459e0c.1.1734064027137;
        Thu, 12 Dec 2024 20:27:07 -0800 (PST)
Received: from x13.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51887e3ef80sm716399e0c.18.2024.12.12.20.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:27:05 -0800 (PST)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: davidgow@google.com,
	akpm@linux-foundation.org
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	skhan@linuxfoundation.org,
	rbm@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7] lib/math: Add int_sqrt test suite
Date: Thu, 12 Dec 2024 23:26:50 -0500
Message-ID: <20241213042701.1037467-1-luis.hernandez093@gmail.com>
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
index 3ef11305f8d2..853f023ae537 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += tests/int_sqrt_kunit.o
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


