Return-Path: <linux-kselftest+bounces-22659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 352959DFB79
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 08:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB58B23146
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E11F9AA1;
	Mon,  2 Dec 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5wHyPu6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF71F9ECE
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126164; cv=none; b=K3InRyPTypywLQdX43tiK1MJ99Ry0p1uXydAzydSHuJG5nbu5n0gOsFk+C9pMAwNMlydi2KqOXzoxhSjQUU0WNj8mO+U1UfKoeA9BKvLXaYpDpIHjyI/kS4+1YZnvVE9D1qPAoAlszKJZStrY+9m3lPVHmgVq8RrtZURpu4UmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126164; c=relaxed/simple;
	bh=nbueRVBos35Jd0w0Fs92uix6M/wXE70O/B7AJCCsung=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XMLXUxqWNSGb55XzN+1P4Dbdq/pPHkyQ52+P4Vi5LBmP2HYWa+VXR0ATxwwXMK3OC1ZzOPk6mmJClikiokKcJcKO9gvX/H4OreQ4TZFVzgi/uJdrENsLCcO8Dlr8fw+6xK8Ohtpp0zWPtu7g0En8XwOXbajmcBobFPkiUW+fOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5wHyPu6; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-71d54613bd0so1452682a34.1
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 23:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733126162; x=1733730962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3kLn7RQs1ULBrkt7yOpn48cLrUbNfXddCOpEZeS+DI=;
        b=f5wHyPu6mXEzWqYwvl19tbaZ3coGMywcPk0kE43Uha4cijKMxDvl3bftMkSJ83LEeM
         8qyymhOWbjm3BnvxffxSc4qAGikkgf5pLgr86Sr3qObc5+u0YIhf5C+JmxzJkteT4iVr
         4JatMR3iFzj5HVYtdSFKX3LNhUXUJ+cp4KaOVEuS4TTwdEpN0x06YqRWK1ZzrRVeBNaI
         DDANqdk2SSfVT4Ab5pCglQ4e3js3WKEA2RXDQ/ea+J31ykK7AI2YA5uWa/Q0VQ8+/xeb
         MTYDvz8ntZE5KxFTgzgYsTBfzBzA1tNnrWxB610OXqU2GxDZy+KZIAWBFH7u97bUmuY5
         gBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733126162; x=1733730962;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N3kLn7RQs1ULBrkt7yOpn48cLrUbNfXddCOpEZeS+DI=;
        b=TZh9YhSQDr3i8DO5iKnuzyP4baXwhIWuXl563MJ3zJu6Rru+aYg6NuXSk0VC17qkHc
         U7rcyVO1/ZHn5UFebTDyfd8Ar0TyjhMhzto36jTswUQ/jl7rQbSV0z4z1eAMknEacJE+
         tnwRyPxn292J12jwccIKzSPUTbN6uLv4cIu8U0Zz4XA+r0iLIbfxdGHBG2jR4XGLnJJ7
         jLfb9BvQvR+0wSYbKEqGbzcwHaIjtSEwHHrgWnTpF4ypRo79oIwE0KDr/xNhj+OIHIes
         WRrz9ZiSeuHgJSCkURAd6usixbkn2qYQFdr2FrMJIbVPgEnmkm8GrFvY1TtabI9YZ+ou
         NIwg==
X-Forwarded-Encrypted: i=1; AJvYcCXC7sSR9jkJkErT+Qfi29VO3mXQpaV+kyIPMDe+IAZ9DdmdfbxEB1VXgF4txTnHrYg+ofxi/FENtfKTmMAiUVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfY74SY7EN/9ap+1k4ztdWNBOWxT6tUknuWeXOVS89ZSoBZNoA
	8TwJb5VJC6gyuTtHEK3Jl0aIzj7vL0/vkJ679USv2zENi3Gt0YmnmphCoSnX06egVmEn7D9+3rM
	GfD75ZIyiYQ==
X-Google-Smtp-Source: AGHT+IFCO19Xvb3y7rt+r6XXmNI1VzwuYgyApTRsR5pWP46AKGk7VjUFzs89sMZSvzb+dXbwlWFlbGI4uMFIVQ==
X-Received: from pgbcv13.prod.google.com ([2002:a05:6a02:420d:b0:7fc:3a6b:47f2])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:7318:b0:71a:6845:7d7a with SMTP id 46e09a7af769-71d65c7692dmr19101143a34.5.1733126162507;
 Sun, 01 Dec 2024 23:56:02 -0800 (PST)
Date: Mon,  2 Dec 2024 15:55:39 +0800
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202075545.3648096-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202075545.3648096-3-davidgow@google.com>
Subject: [PATCH v2 2/6] lib/math: Add int_log test suite
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?=" <brunofrancadevsec@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Bruno Sobreira Fran=C3=A7a <brunofrancadevsec@gmail.com>

This commit introduces KUnit tests for the intlog2 and intlog10
functions, which compute logarithms in base 2 and base 10, respectively.
The tests cover a range of inputs to ensure the correctness of these
functions across common and edge cases.

Signed-off-by: Bruno Sobreira Fran=C3=A7a <brunofrancadevsec@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
[Rebased on top of v6.13-rc1]
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/Kconfig.debug              | 11 +++++
 lib/math/tests/Makefile        |  1 +
 lib/math/tests/int_log_kunit.c | 75 ++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 lib/math/tests/int_log_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7b90948666bf..8cc8bca6386d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3161,6 +3161,17 @@ config INT_POW_KUNIT_TEST
=20
 	  If unsure, say N
=20
+config INT_LOG_KUNIT_TEST
+        tristate "Integer log (int_log) test" if !KUNIT_ALL_TESTS
+        depends on KUNIT
+        default KUNIT_ALL_TESTS
+        help
+          This option enables the KUnit test suite for the int_log library=
, which
+          provides two functions to compute the integer logarithm in base =
2 and
+          base 10, called respectively as intlog2 and intlog10.
+
+          If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
=20
 config ARCH_USE_MEMTEST
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index 8ce8040e00c5..a1e9ddcbe038 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
 obj-$(CONFIG_INT_POW_KUNIT_TEST)  +=3D int_pow_kunit.o
+obj-$(CONFIG_INT_LOG_KUNIT_TEST)  +=3D int_log_kunit.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) +=3D rational_kunit.o
diff --git a/lib/math/tests/int_log_kunit.c b/lib/math/tests/int_log_kunit.=
c
new file mode 100644
index 000000000000..d750a1df37c1
--- /dev/null
+++ b/lib/math/tests/int_log_kunit.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/int_log.h>
+
+struct test_case_params {
+	u32 value;
+	unsigned int expected_result;
+	const char *name;
+};
+
+
+/* The expected result takes into account the log error */
+static const struct test_case_params intlog2_params[] =3D {
+	{0, 0, "Log base 2 of 0"},
+	{1, 0, "Log base 2 of 1"},
+	{2, 16777216, "Log base 2 of 2"},
+	{3, 26591232, "Log base 2 of 3"},
+	{4, 33554432, "Log base 2 of 4"},
+	{8, 50331648, "Log base 2 of 8"},
+	{16, 67108864, "Log base 2 of 16"},
+	{32, 83886080, "Log base 2 of 32"},
+	{U32_MAX, 536870911, "Log base 2 of MAX"},
+};
+
+static const struct test_case_params intlog10_params[] =3D {
+	{0, 0, "Log base 10 of 0"},
+	{1, 0, "Log base 10 of 1"},
+	{6, 13055203, "Log base 10 of 6"},
+	{10, 16777225, "Log base 10 of 10"},
+	{100, 33554450, "Log base 10 of 100"},
+	{1000, 50331675, "Log base 10 of 1000"},
+	{10000, 67108862, "Log base 10 of 10000"},
+	{U32_MAX, 161614247, "Log base 10 of MAX"}
+};
+
+static void get_desc(const struct test_case_params *tc, char *desc)
+{
+	strscpy(desc, tc->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+
+KUNIT_ARRAY_PARAM(intlog2, intlog2_params, get_desc);
+
+static void intlog2_test(struct kunit *test)
+{
+	const struct test_case_params *tc =3D (const struct test_case_params *)te=
st->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, intlog2(tc->value));
+}
+
+KUNIT_ARRAY_PARAM(intlog10, intlog10_params, get_desc);
+
+static void intlog10_test(struct kunit *test)
+{
+	const struct test_case_params *tc =3D (const struct test_case_params *)te=
st->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, intlog10(tc->value));
+}
+
+static struct kunit_case math_int_log_test_cases[] =3D {
+	KUNIT_CASE_PARAM(intlog2_test, intlog2_gen_params),
+	KUNIT_CASE_PARAM(intlog10_test, intlog10_gen_params),
+	{}
+};
+
+static struct kunit_suite int_log_test_suite =3D {
+	.name =3D "math-int_log",
+	.test_cases =3D  math_int_log_test_cases,
+};
+
+kunit_test_suites(&int_log_test_suite);
+
+MODULE_DESCRIPTION("math.int_log KUnit test suite");
+MODULE_LICENSE("GPL");
+
--=20
2.47.0.338.g60cca15819-goog


