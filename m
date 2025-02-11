Return-Path: <linux-kselftest+bounces-26278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24624A2FF23
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D2BF7A1FCB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D013A1C5F34;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qimTdQHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03431C3F36;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233897; cv=none; b=Fw5HRUv/QqgGiBSdZhyRsmSituRXbjqMyswXhKuuSrPaHmHM9UpnCM/71tsUQlPPLPJJ4CmLXThRHTta2C4o0Q+rWTteluHXiZd4HhDF7Aa4EK701CpFQ5zHSKvMVSVulh5BrMTrxMCUQrb6nR+UI4S3psm/JrLt/e7cDAgsb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233897; c=relaxed/simple;
	bh=/PR9AB+QpWzqEeX3zFKe7QITS4cHv803/0AieWg4tIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1SUg/D9TPAm0L6yVFyQPDy0OuFnCnbdEk4hDvkxKDA8/YwHMcMMzqbDi646HctKWnrBfz+XrRjJ5IDNucIqQZbd77aOuyqDMk82qMozi2YC9ew9nhPnEzmB/Za6Y1nh2VXFfR+wh2N9OkxxjoGek2bohmUIalM4UUwyeaEzrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qimTdQHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067CBC4CEF5;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739233897;
	bh=/PR9AB+QpWzqEeX3zFKe7QITS4cHv803/0AieWg4tIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qimTdQHkHrV7M7T/TX+bmLorH+5rf7VHKUGtE5rIQj3LRSvKlkoojVxxG0xEEkhBR
	 jkSF7aT2xcjR1fiTCftT0OV9FG2TsS9HjYnCyVpVQ3gbn0jSL52wI7pvONxjcEIHfD
	 69fQtpKqbWbNVyoqflAt5ub96jO7FCjcvGhuqNrUMaCGGqt1ekisPidbuKFhar5bds
	 WqhHqBciwHvQMsIp3pIugIrZSsyEZZF8e1V+xNJo0AuOYID+0xQC0slx+k9sD1Iw/O
	 P4uZV9iN7CgfobCGkdnbK2DVBzFBfXm8F39oE0JWNhGKzjg4UMsr9ggOg+q51xdj7x
	 hmCmdiQCTzZFA==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Pedro Orlando <porlando@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Rae Moar <rmoar@google.com>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH v2 5/6] unicode: kunit: refactor selftest to kunit tests
Date: Mon, 10 Feb 2025 16:31:33 -0800
Message-Id: <20250211003136.2860503-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211002600.it.339-kees@kernel.org>
References: <20250211002600.it.339-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11462; i=kees@kernel.org; h=from:subject; bh=qneY3+E6WQflVJ8FUJLVj8OKpCtnR1WKhTjP+Ezmn4M=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmrZqUda+t6s7pcz37vjKLlXT7aYXt3L7Q9Yndx0bL/5 jde//qQ0FHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCRa7cY/lk0sv9unah/gOvV w5A1l2u0qkpfL5giGSiyWMPVsftuBTMjw5mXO/wmKN258no1+36DhckChiFBDLE7bHf4J93gFtB 4xAoA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Refactoring 'test' functions into kunit tests, to test utf-8 support in
unicode subsystem.

This allows the utf8 tests to be run alongside the KUnit test suite
using kunit-tool, quickly compiling and running all desired tests as
part of the KUnit test suite, instead of compiling the selftest module
and loading it.

The refactoring kept the original testing logic intact, while adopting a
testing pattern across different kernel modules and leveraging KUnit's
benefits.

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Rae Moar <rmoar@google.com>
Link: https://lore.kernel.org/r/20241202075545.3648096-6-davidgow@google.com
Signed-off-by: Kees Cook <kees@kernel.org>
---
 fs/unicode/.kunitconfig    |   3 +
 fs/unicode/Kconfig         |   5 +-
 fs/unicode/Makefile        |   2 +-
 fs/unicode/utf8-norm.c     |   2 +-
 fs/unicode/utf8-selftest.c | 149 +++++++++++++++++--------------------
 5 files changed, 77 insertions(+), 84 deletions(-)
 create mode 100644 fs/unicode/.kunitconfig

diff --git a/fs/unicode/.kunitconfig b/fs/unicode/.kunitconfig
new file mode 100644
index 000000000000..62dd5c171f9c
--- /dev/null
+++ b/fs/unicode/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_UNICODE=y
+CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST=y
diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
index da786a687fdc..4ad2c36550f1 100644
--- a/fs/unicode/Kconfig
+++ b/fs/unicode/Kconfig
@@ -10,6 +10,7 @@ config UNICODE
 	  be a separate loadable module that gets requested only when a file
 	  system actually use it.
 
-config UNICODE_NORMALIZATION_SELFTEST
+config UNICODE_NORMALIZATION_KUNIT_TEST
 	tristate "Test UTF-8 normalization support"
-	depends on UNICODE
+	depends on UNICODE && KUNIT
+	default KUNIT_ALL_TESTS
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index e309afe2b2bb..37bbcbc628a1 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y			+= unicode.o
 endif
 obj-$(CONFIG_UNICODE)	+= utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 768f8ab448b8..7b998c99c88d 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -586,7 +586,7 @@ int utf8byte(struct utf8cursor *u8c)
 	}
 }
 
-#ifdef CONFIG_UNICODE_NORMALIZATION_SELFTEST_MODULE
+#if IS_MODULE(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST)
 EXPORT_SYMBOL_GPL(utf8version_is_supported);
 EXPORT_SYMBOL_GPL(utf8nlen);
 EXPORT_SYMBOL_GPL(utf8ncursor);
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 5ddaf27b21a6..9476ab012baa 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -1,35 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Kernel module for testing utf-8 support.
+ * KUnit tests for utf-8 support.
  *
  * Copyright 2017 Collabora Ltd.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/printk.h>
 #include <linux/unicode.h>
-#include <linux/dcache.h>
+#include <kunit/test.h>
 
 #include "utf8n.h"
 
-static unsigned int failed_tests;
-static unsigned int total_tests;
-
-#define _test(cond, func, line, fmt, ...) do {				\
-		total_tests++;						\
-		if (!cond) {						\
-			failed_tests++;					\
-			pr_err("test %s:%d Failed: %s%s",		\
-			       func, line, #cond, (fmt?":":"."));	\
-			if (fmt)					\
-				pr_err(fmt, ##__VA_ARGS__);		\
-		}							\
-	} while (0)
-#define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__VA_ARGS__)
-#define test(cond) _test(cond, __func__, __LINE__, "")
-
 static const struct {
 	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
 	unsigned char str[10];
@@ -167,69 +147,74 @@ static int utf8cursor(struct utf8cursor *u8c, const struct unicode_map *um,
 	return utf8ncursor(u8c, um, n, s, (unsigned int)-1);
 }
 
-static void check_utf8_nfdi(struct unicode_map *um)
+static void check_utf8_nfdi(struct kunit *test)
 {
 	int i;
 	struct utf8cursor u8c;
+	struct unicode_map *um = test->priv;
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 		int len = strlen(nfdi_test_data[i].str);
 		int nlen = strlen(nfdi_test_data[i].dec);
 		int j = 0;
 		unsigned char c;
+		int ret;
+
+		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDI, nfdi_test_data[i].str), nlen);
+		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len),
+				nlen);
 
-		test((utf8len(um, UTF8_NFDI, nfdi_test_data[i].str) == nlen));
-		test((utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len) ==
-			nlen));
 
-		if (utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str) < 0)
-			pr_err("can't create cursor\n");
+		ret = utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str);
+		KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
 
 		while ((c = utf8byte(&u8c)) > 0) {
-			test_f((c == nfdi_test_data[i].dec[j]),
-			       "Unexpected byte 0x%x should be 0x%x\n",
-			       c, nfdi_test_data[i].dec[j]);
+			KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].dec[j],
+					    "Unexpected byte 0x%x should be 0x%x\n",
+					    c, nfdi_test_data[i].dec[j]);
 			j++;
 		}
 
-		test((j == nlen));
+		KUNIT_EXPECT_EQ(test, j, nlen);
 	}
 }
 
-static void check_utf8_nfdicf(struct unicode_map *um)
+static void check_utf8_nfdicf(struct kunit *test)
 {
 	int i;
 	struct utf8cursor u8c;
+	struct unicode_map *um = test->priv;
 
 	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
 		int len = strlen(nfdicf_test_data[i].str);
 		int nlen = strlen(nfdicf_test_data[i].ncf);
 		int j = 0;
+		int ret;
 		unsigned char c;
 
-		test((utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str) ==
-				nlen));
-		test((utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len) ==
-				nlen));
+		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str),
+				nlen);
+		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len),
+				nlen);
 
-		if (utf8cursor(&u8c, um, UTF8_NFDICF,
-				nfdicf_test_data[i].str) < 0)
-			pr_err("can't create cursor\n");
+		ret = utf8cursor(&u8c, um, UTF8_NFDICF, nfdicf_test_data[i].str);
+		KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
 
 		while ((c = utf8byte(&u8c)) > 0) {
-			test_f((c == nfdicf_test_data[i].ncf[j]),
-			       "Unexpected byte 0x%x should be 0x%x\n",
-			       c, nfdicf_test_data[i].ncf[j]);
+			KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].ncf[j],
+					    "Unexpected byte 0x%x should be 0x%x\n",
+					    c, nfdicf_test_data[i].ncf[j]);
 			j++;
 		}
 
-		test((j == nlen));
+		KUNIT_EXPECT_EQ(test, j, nlen);
 	}
 }
 
-static void check_utf8_comparisons(struct unicode_map *table)
+static void check_utf8_comparisons(struct kunit *test)
 {
 	int i;
+	struct unicode_map *um = test->priv;
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 		const struct qstr s1 = {.name = nfdi_test_data[i].str,
@@ -237,8 +222,9 @@ static void check_utf8_comparisons(struct unicode_map *table)
 		const struct qstr s2 = {.name = nfdi_test_data[i].dec,
 					.len = sizeof(nfdi_test_data[i].dec)};
 
-		test_f(!utf8_strncmp(table, &s1, &s2),
-		       "%s %s comparison mismatch\n", s1.name, s2.name);
+		/* strncmp returns 0 when strings are equal */
+		KUNIT_EXPECT_TRUE_MSG(test, utf8_strncmp(um, &s1, &s2) == 0,
+				    "%s %s comparison mismatch\n", s1.name, s2.name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
@@ -247,62 +233,65 @@ static void check_utf8_comparisons(struct unicode_map *table)
 		const struct qstr s2 = {.name = nfdicf_test_data[i].ncf,
 					.len = sizeof(nfdicf_test_data[i].ncf)};
 
-		test_f(!utf8_strncasecmp(table, &s1, &s2),
-		       "%s %s comparison mismatch\n", s1.name, s2.name);
+		/* strncasecmp returns 0 when strings are equal */
+		KUNIT_EXPECT_TRUE_MSG(test, utf8_strncasecmp(um, &s1, &s2) == 0,
+				    "%s %s comparison mismatch\n", s1.name, s2.name);
 	}
 }
 
-static void check_supported_versions(struct unicode_map *um)
+static void check_supported_versions(struct kunit *test)
 {
+	struct unicode_map *um = test->priv;
 	/* Unicode 7.0.0 should be supported. */
-	test(utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
 
 	/* Unicode 9.0.0 should be supported. */
-	test(utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
 
 	/* Unicode 1x.0.0 (the latest version) should be supported. */
-	test(utf8version_is_supported(um, UTF8_LATEST));
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UTF8_LATEST));
 
 	/* Next versions don't exist. */
-	test(!utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
-	test(!utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
-	test(!utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
 }
 
-static int __init init_test_ucd(void)
+static struct kunit_case unicode_normalization_test_cases[] = {
+	KUNIT_CASE(check_supported_versions),
+	KUNIT_CASE(check_utf8_comparisons),
+	KUNIT_CASE(check_utf8_nfdicf),
+	KUNIT_CASE(check_utf8_nfdi),
+	{}
+};
+
+static int init_test_ucd(struct kunit *test)
 {
-	struct unicode_map *um;
+	struct unicode_map *um = utf8_load(UTF8_LATEST);
 
-	failed_tests = 0;
-	total_tests = 0;
+	test->priv = um;
 
-	um = utf8_load(UTF8_LATEST);
-	if (IS_ERR(um)) {
-		pr_err("%s: Unable to load utf8 table.\n", __func__);
-		return PTR_ERR(um);
-	}
+	KUNIT_EXPECT_EQ_MSG(test, IS_ERR(um), 0,
+			    "%s: Unable to load utf8 table.\n", __func__);
 
-	check_supported_versions(um);
-	check_utf8_nfdi(um);
-	check_utf8_nfdicf(um);
-	check_utf8_comparisons(um);
-
-	if (!failed_tests)
-		pr_info("All %u tests passed\n", total_tests);
-	else
-		pr_err("%u out of %u tests failed\n", failed_tests,
-		       total_tests);
-	utf8_unload(um);
 	return 0;
 }
 
-static void __exit exit_test_ucd(void)
+static void exit_test_ucd(struct kunit *test)
 {
+	utf8_unload(test->priv);
 }
 
-module_init(init_test_ucd);
-module_exit(exit_test_ucd);
+static struct kunit_suite unicode_normalization_test_suite = {
+	.name = "unicode_normalization",
+	.test_cases = unicode_normalization_test_cases,
+	.init = init_test_ucd,
+	.exit = exit_test_ucd,
+};
+
+kunit_test_suite(unicode_normalization_test_suite);
+
 
 MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
-MODULE_DESCRIPTION("Kernel module for testing utf-8 support");
+MODULE_DESCRIPTION("KUnit tests for utf-8 support.");
 MODULE_LICENSE("GPL");
-- 
2.34.1


