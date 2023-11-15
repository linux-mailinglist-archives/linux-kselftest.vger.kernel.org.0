Return-Path: <linux-kselftest+bounces-182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DBC7ED5A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 22:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3770E1F284CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB645BE5;
	Wed, 15 Nov 2023 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="l3nZwRC7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FFF198;
	Wed, 15 Nov 2023 13:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700082503;
	bh=EY9qn8OaUJTv8V5Cu9il13Y11SYGGS69Eb4C8YMvjnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l3nZwRC7JGGgSRz0lsO64pqUwcDE9YfWL5JqUZFHkGj5vexiXDIPkpnfQow/8f/x+
	 0HEv1SPACnNYJgLXqUeO/IDfKpl51m7XdFz1C53zN6cKycu5VXb9CSS477AZdhv1no
	 hcSevf0LgJEE6lu/HTPBSKashg/fcFTn3mg05D/4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 15 Nov 2023 22:08:19 +0100
Subject: [PATCH RFC 1/3] selftests/nolibc: add custom test harness
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231115-nolibc-harness-v1-1-4d61382d9bf3@weissschuh.net>
References: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
In-Reply-To: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700082502; l=8371;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EY9qn8OaUJTv8V5Cu9il13Y11SYGGS69Eb4C8YMvjnE=;
 b=OY3t7f91GO/MYUPQCGbAW97VDJ8RZ4ip5LgOGCwX2mJS1Ijqq4vkG3guL2zCavyAsCrogFocr
 Tu/7Dd2bZIcDxtg0m6hxGtVIM3lLpmyykRB4jDOcFgOKl3X4MxakFSb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The harness provides a framework to write unit tests for nolibc itself
and kernel selftests using nolibc.

Advantages over the current harness:
* Makes it possible to emit KTAP for integration into kselftests.
* Provides familiarity with the kselftest harness and google test.
* It is nicer to write testcases that are longer than one line.

Design goals:
* Compatibility with nolibc. kselftest-harness requires setjmp() and
  signals which are not supported on nolibc.
* Provide the same output as the existing unittests.
* Provide a way to emit KTAP.

Notes:
* This differs from kselftest-harness in its support for test suites,
  the same as google test.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-harness.h | 269 ++++++++++++++++++++++++
 1 file changed, 269 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-harness.h b/tools/testing/selftests/nolibc/nolibc-harness.h
new file mode 100644
index 000000000000..4c82581fab86
--- /dev/null
+++ b/tools/testing/selftests/nolibc/nolibc-harness.h
@@ -0,0 +1,269 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Test harness for NOLIBC
+ *
+ * Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
+ * Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+static void putcharn(char c, size_t n)
+{
+	char buf[64];
+
+	memset(buf, c, n);
+	buf[n] = '\0';
+	fputs(buf, stdout);
+}
+
+struct __test_setup;
+
+struct __test_execution {
+	int finished, failed, skipped, llen;
+};
+
+struct __test_metadata {
+	const char *name;
+	const char *suite;
+	unsigned int suite_count;
+	void (*func)(struct __test_metadata *metadata);
+	struct __test_metadata *next;
+	struct __test_setup *setup;
+	struct __test_execution exe;
+};
+
+struct __test_setup {
+	struct __test_metadata *start, *end;
+} __test_setup __attribute__((weak));
+
+static void __add_metadata(struct __test_metadata *metadata)
+{
+	struct __test_metadata *m;
+
+	if (!__test_setup.start)
+		__test_setup.start = metadata;
+
+	if (!__test_setup.end) {
+		__test_setup.end = metadata;
+	} else {
+		__test_setup.end->next = metadata;
+		__test_setup.end = metadata;
+	}
+
+	metadata->setup = &__test_setup;
+
+	for (m = __test_setup.start; m; m = m->next) {
+		if (strcmp(metadata->suite, m->suite) == 0)
+			metadata->suite_count++;
+	}
+}
+
+#define TEST(_suite, _name) \
+	static void _testfunc_ ## _suite ## _name(struct __test_metadata *); \
+	static struct __test_metadata _metadata_ ## _suite ## _name = { \
+		.name = #_name, \
+		.suite = #_suite, \
+		.func = _testfunc_ ## _suite ## _name, \
+	}; \
+	__attribute__((constructor)) \
+	static void _register_testfunc_ ## _suite ## _name(void) \
+	{ __add_metadata(&_metadata_ ## _suite ## _name); } \
+	static void _testfunc_ ## _suite ## _name( \
+		struct __test_metadata *_metadata __attribute__((unused)))
+
+#define SKIP(statement) __extension__ ({ \
+	_metadata->exe.skipped = 1; \
+	statement; \
+})
+
+#define FAIL(statement) __extension__ ({ \
+	_metadata->exe.failed = 1; \
+	statement; \
+})
+
+static void __run_test(struct __test_metadata *metadata)
+{
+	metadata->func(metadata);
+	metadata->exe.finished = 1;
+}
+
+static __attribute__((unused))
+unsigned int count_test_suites(void)
+{
+	struct __test_metadata *m;
+	unsigned int r = 0;
+
+	for (m = __test_setup.start; m && m->suite_count; m = m->next)
+		r++;
+
+	return r;
+}
+
+static __attribute__((unused))
+int count_tests(void)
+{
+	struct __test_metadata *m;
+	unsigned int r = 0;
+
+	for (m = __test_setup.start; m; m = m->next)
+		r++;
+
+	return r;
+}
+
+static unsigned int count_suite_tests(const char *suite)
+{
+	struct __test_metadata *m;
+	unsigned int c = 0;
+
+	for (m = __test_setup.start; m && m->suite_count; m = m->next)
+		if (strcmp(m->suite, suite) == 0)
+			c = m->suite_count;
+
+	return c;
+}
+
+static __attribute__((unused))
+void dump_test_plan(void)
+{
+	struct __test_metadata *m;
+	const char *suite = "";
+
+	printf("PLAN:\n");
+	for (m = __test_setup.start; m; m = m->next) {
+		if (strcmp(suite, m->suite)) {
+			suite = m->suite;
+			printf("  Suite %s (%d):\n", suite, count_suite_tests(suite));
+		}
+		printf("    %10s:%s %d\n", m->suite, m->name, m->suite_count - 1);
+	}
+}
+
+static unsigned int run_test_suite(const char *suite, int min, int max)
+{
+	struct __test_metadata *m;
+	const char *status;
+	unsigned int errors = 0;
+	int printed;
+
+	for (m = __test_setup.start; m; m = m->next) {
+		int testnum = m->suite_count - 1;
+
+		if (strcmp(suite, m->suite) == 0 && testnum >= min && testnum <= max) {
+			printed = printf("%d %s", testnum, m->name);
+			__run_test(m);
+			printed += m->exe.llen;
+			if (printed < 64)
+				putcharn(' ', 64 - printed);
+
+			if (m->exe.failed)
+				status = " [FAIL]";
+			else if (m->exe.skipped)
+				status = "[SKIPPED]";
+			else
+				status = "  [OK]";
+
+			printf("%s\n", status);
+			if (m->exe.failed)
+				errors++;
+		}
+	}
+	return errors;
+};
+
+static __attribute__((unused))
+void reset_tests(void)
+{
+	struct __test_metadata *m;
+
+	for (m = __test_setup.start; m; m = m->next)
+		memset(&m->exe, 0, sizeof(m->exe));
+}
+
+static __attribute__((unused))
+unsigned int run_all_tests(void)
+{
+	struct __test_metadata *m;
+	unsigned int suite_errors, errors = 0;
+
+	for (m = __test_setup.start; m; m = m->next) {
+		if (!m->exe.finished) {
+			printf("Running test '%s'\n", m->suite);
+			suite_errors = run_test_suite(m->suite, 0, INT_MAX);
+			printf("Errors during this test: %d\n\n", suite_errors);
+			errors += suite_errors;
+		}
+	}
+
+	printf("Total number of errors: %d\n", errors);
+	return errors;
+}
+
+#define ASSERT_EQ(expected, seen) \
+	__ASSERT(expected, #expected, seen, #seen, ==)
+#define ASSERT_NE(expected, seen) \
+	__ASSERT(expected, #expected, seen, #seen, !=)
+#define ASSERT_LT(expected, seen) \
+	__ASSERT(expected, #expected, seen, #seen, <)
+#define ASSERT_LE(expected, seen) \
+	__ASSERT(expected, #expected, seen, #seen, <=)
+#define ASSERT_GT(expected, seen) \
+	__ASSERT(expected, #expected, seen, #seen, >)
+#define ASSERT_GE(expected, seen) \
+	__ASSERT(expected, #expected, seen, #seen, >=)
+#define ASSERT_NULL(seen) \
+	__ASSERT(NULL, "NULL", seen, #seen, ==)
+#define ASSERT_TRUE(seen) \
+	__ASSERT(0, "0", seen, #seen, !=)
+#define ASSERT_FALSE(seen) \
+	__ASSERT(0, "0", seen, #seen, ==)
+
+#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
+#define is_pointer_type(var)	(__builtin_classify_type(var) == 5)
+
+#define __ASSERT(_expected, _expected_str, _seen, _seen_str, _t) __extension__ ({ \
+	/* Avoid multiple evaluation of the cases */ \
+	__typeof__(_expected) __exp = (_expected); \
+	__typeof__(_seen) __seen = (_seen); \
+	int __ok = __exp _t __seen; \
+	if (!__ok) \
+		_metadata->exe.failed = 1; \
+	if (is_pointer_type(__exp)) { \
+		void * __expected_print = (void *)(uintptr_t)__exp; \
+		_metadata->exe.llen = printf(" = <%p> ", __expected_print); \
+	} else if (is_signed_type(__exp)) { \
+		long long __expected_print = (intptr_t)__exp; \
+		_metadata->exe.llen = printf(" = %lld ", __expected_print); \
+	} else { \
+		unsigned long long __expected_print = (uintptr_t)__exp; \
+		_metadata->exe.llen = printf(" = %llu ", __expected_print); \
+	} \
+	__ok; \
+})
+
+#define ASSERT_STREQ(expected, seen) \
+	__ASSERT_STR(expected, seen, ==)
+#define ASSERT_STRNE(expected, seen) \
+	__ASSERT_STR(expected, seen, !=)
+
+#define __ASSERT_STR(_expected, _seen, _t) __extension__ ({ \
+	const char *__exp = (_expected); \
+	const char *__seen = (_seen); \
+	int __ok = __seen && __exp && strcmp(__exp, __seen) _t 0; \
+	if (!__ok) \
+		_metadata->exe.failed = 1; \
+	_metadata->exe.llen = printf(" = <%s> ", __exp ? __exp : ""); \
+	__ok; \
+})
+
+#define ASSERT_STRNZ(seen) __extension__ ({ \
+	const char *__seen = (seen); \
+	int __ok = !!__seen; \
+	if (!__ok) \
+		_metadata->exe.failed = 1; \
+	_metadata->exe.llen = printf(" = <%s> ", __seen); \
+	__ok; \
+})

-- 
2.42.1


