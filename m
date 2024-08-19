Return-Path: <linux-kselftest+bounces-15602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F339560EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 03:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848E81F22369
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 01:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618B18E0E;
	Mon, 19 Aug 2024 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5QOXo4o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9339460
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724031692; cv=none; b=ODBtoQ3P5XgTclsxAsbCiyPOD7m4L9S7xRjyFxoW+odQWEV0l66YyDVsW3w9JTi7VFGJRwcTZSHXhPRbq9dvporny7ddpuQHiSCkVLaro13QmVUYrNIUdxYBoHt8l9FCkXHeFbg67p07CT+/bdy5cCHsF2Thivpd5dZSj7bf97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724031692; c=relaxed/simple;
	bh=Nh2IUPVzC3Cu7ZNM0NcDSnF9+JYCItVqEB7NhhbYed4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgAXQJaXbJBpwsnVKVYYwPjYuVvwfk71b47Vnjrpzkc/2G5sGXkkh5XrVX+ZPSQrmxCnEat5TCvOtIEep9u2HDJl3+Ac46dRTpC3SAD4S9th2YfAU4McEgvdg0kTgQDXTFZYjRrpWnaFxdNDq9CcLfYJG0QGdqIDfduwfRg5P+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5QOXo4o; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f89c9a1610so1384209e0c.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Aug 2024 18:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724031689; x=1724636489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPej5M+n6eDs+72yI9568u4PoP3Ufjq7SFsXIfTqhJQ=;
        b=i5QOXo4olBx9rINQ/U8RdJcJA6f8UchWOBa1j/4YccH/gMxqGowPh6g7E6XHRhNjSY
         hPRkvCNszeZBwXc98dEXCGBfsdcs1QRe7QXORnUIPCV6gKxZGEaEQJEG5bVI6oZazSfi
         oFDLL/Lb68VUmJBpgKEpSX1pK1bmXgoxoxpnd+pKC7enm2SrCjX+caZ/ZZPL2bpvvoqd
         gp6Z4Luz4A8UnoL5c1FP66XB8vBiemLnucbqrrcg85dqXmzUa+KfCJ+y2Me/i6xSiBRC
         C62s1i2BS9KbTp5Xo9yh+jCCab4+ZCC5j9zQOphAJeJJbvLDqH3bob4udWYE5m5Z3BOG
         S51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724031689; x=1724636489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPej5M+n6eDs+72yI9568u4PoP3Ufjq7SFsXIfTqhJQ=;
        b=lcD8q3JfS/wbHOen9QoIr3ouZ0FbsQmVkpuG4nMd8opDILqiKQ9SSWuepr+mKs1/ae
         TMthNN0faAp1Lpro1jsnK3oTc1vihqgdkT2p6tCw1loKxqNOTKfmgsRRkRvQPKViiekB
         SqV0Mihn5Ig5kmjunZi11GcF42CvisNmNoAFiH0Ztu2BwwfIoESoqr30LC2P56vEdoPb
         kkUXSpt5e+OtVwQXa6pUeG1Dkia7h5tpnCTJ5KBbdPqUV6R+uXoS24/eYSp67lBvGQsX
         LK22XwKXaOrYzdmDAnSV7zaPuGhTyZPLTNqOWL5+Se5CfSnssFl5JQ2Ns9rRMscMIrW9
         ySbA==
X-Forwarded-Encrypted: i=1; AJvYcCVntFeTzy3iISbAfZBttOwtziJmsGzVJCOl36Y5kdfSlbPm8zDN9z0u60xRQq4L6VjZp1E/CZYfJMeALlhrPWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5cJO5oCvkWk2QA2FeqD9AVkz8lvmhvlumfmctCNqVxwhM1lz
	uciHPQnK4chFf0oeWaDCMFBMplSuoazy8xLniU/wvk7ouR/3AnHz
X-Google-Smtp-Source: AGHT+IHT5tJfFHsNe6fV6zNaZSqMOa/LyftafMLYi1iZMhEcHeaGZcmOKZtJ4RP04Wo7FZxQaA995A==
X-Received: by 2002:a05:6122:a19:b0:4ed:185:258c with SMTP id 71dfb90a1353d-4fc6c71d829mr11796656e0c.2.1724031689468;
        Sun, 18 Aug 2024 18:41:29 -0700 (PDT)
Received: from x13.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b8c65b3sm973923e0c.5.2024.08.18.18.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 18:41:28 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] lib/math: Add int_pow test suite
Date: Sun, 18 Aug 2024 21:41:12 -0400
Message-ID: <20240819014115.221135-1-luis.hernandez093@gmail.com>
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


