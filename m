Return-Path: <linux-kselftest+bounces-17562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070B972682
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED551F237DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 01:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DED6F2F4;
	Tue, 10 Sep 2024 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsMaJVKN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459882AEF1
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725930648; cv=none; b=dyOK1WdmrY708o28llt8RdQBtzr+5LV76wmSd5od7xXH9atCAPKELDwpRI34fk6p66TWYyZC6T34yAr8h+VYMW2yD036S3ZoIAG+KCYx6IrMgsuaCnm7cVpNpOQDFOxoFZYv5/1Pd9dND3VDBuKdE7lCl5uH/G6GREkcTO09l48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725930648; c=relaxed/simple;
	bh=oc9n6anzUCCgh/9mdVpHlXQsIkcCodF2xEspvvmhuHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SO4YkH2e/moOoFBGD2uOwSr2vBlvhnRxLQMSyquVtYShcHqQnc8mHqLP16m9IfuLBWqt22aSQ8mVbdiibXKf7ODdpQmaKqOotwiPrb1L3gO6KpYE5sNQbhWfQR9hpHBjkPZkvhztrPsBHigJ1fCYdirESPog7dpg6WkHFbENtfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsMaJVKN; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-49bd2b37fe9so1375535137.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Sep 2024 18:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725930646; x=1726535446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZo3dHoUlvsPvtWs9uI1nqTcMjUn5Xqg5a9hNWOoQ0U=;
        b=jsMaJVKNC8M5VBwH1LbHSWi14kqRtZK2nfScyh+vDdkwkjVX4c0pRbYLcYs2X21pr9
         CeVKBpovD+fziKUFKcIpEPfGRcoQWXkC6kdQGgTjr6qYEv8PpKT0j35DOvV/TtMUinKv
         J+miHcuOxJJ2W91ThKItkUIW7GHijyMfclRJQqVmbfh6v69CrwfBFkDbR85Nj40gPHEh
         ZWu2m8GOwSvEJvdMbQ/r4gFu2S5vnB0Rrr5aqhDljsRRqj5njoUlg4ijGBSyrltMIb/c
         B0Ohs/23EnM9xua3cTVStmDQBhuLv0E9g9shIilWqgfDqcczKP9W3FACQu6uPGGHGlEm
         30IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725930646; x=1726535446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZo3dHoUlvsPvtWs9uI1nqTcMjUn5Xqg5a9hNWOoQ0U=;
        b=HlpzSgSWA9V3XsFslkcKYBr6zALJ/RUQhx3nxSDuBdZkBJ0Vx7zwRjVRe05KvTuIXo
         AeXRu7Hde9UytKb5BP4WLOXNcZprIlfOY1cfJU4PQOGZHa4bXp9OUsgEPJgWJCHXsL+Z
         qxwAEkUxZn6iN6OrhcMs5+2ASSAAn7i9NoE0q140I7BrJtRwvtEJm1mHm2soBi/aUaN7
         zFV8x7et+3pXAjiuh30bvhYpTbfwFAoR2VAqcugB/m1SGfWAlXL94OxZVQl790wZPdHo
         ct11xEzMlkBrBT3Uzj+AuzmGSO3KCo8b1SSQ92j7iQXQfcbFdRoYXomPptq+y5SvrXFX
         TDJA==
X-Forwarded-Encrypted: i=1; AJvYcCXxwrgOVX9SguIOXhlPgD0BF93/c9yx+EfM+V060oftWqSPlvn0obbBvfzeBCDYUHHTi5t1VdYJMpT3x0pzUH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPQkF6idsDS9cZdClcHpKgHmJfxBf3tGFGwOhQKgImjJ67i0k
	Ik/geWheJpNXL6K2pHv5ZI9XYK6ylYSm+ze8i5/u5XAfDSYdok7+9Bl20uGf8Jk=
X-Google-Smtp-Source: AGHT+IGoJhK2So7eKTIKvEIwazC1BO+otrVme7YefkOZVBJ+ajYsgVH4p6E9Dk+sVmDa9vuxcpJDrQ==
X-Received: by 2002:a05:6102:c0e:b0:48f:cb62:231a with SMTP id ada2fe7eead31-49bde25de59mr9391558137.23.1725930646035;
        Mon, 09 Sep 2024 18:10:46 -0700 (PDT)
Received: from x13.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8489ad449acsm622584241.31.2024.09.09.18.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 18:10:42 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v5] lib/math: Add int_pow test suite
Date: Mon,  9 Sep 2024 21:10:34 -0400
Message-ID: <20240910011036.15117-1-luis.hernandez093@gmail.com>
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
Changes in v5:
  - Fix kernel test bot warning
  - Rebase with latest
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
 lib/Kconfig.debug              | 16 +++++++++++
 lib/math/Makefile              |  1 +
 lib/math/tests/Makefile        |  3 ++
 lib/math/tests/int_pow_kunit.c | 52 ++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)
 create mode 100644 lib/math/tests/Makefile
 create mode 100644 lib/math/tests/int_pow_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..c415f8ca43a7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3051,3 +3051,19 @@ config RUST_KERNEL_DOCTESTS
 endmenu # "Rust"
 
 endmenu # Kernel hacking
+
+config INT_POW_TEST
+	tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the int_pow function,
+	  which performs integer exponentiation. The test suite is designed to
+	  verify that the implementation of int_pow correctly computes the power
+	  of a given base raised to a given exponent.
+
+	  Enabling this option will include tests that check various scenarios
+	  and edge cases to ensure the accuracy and reliability of the exponentiation
+	  function.
+	  
+	  If unsure, say N
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
index 000000000000..34b33677d458
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


