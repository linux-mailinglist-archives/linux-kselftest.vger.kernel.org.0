Return-Path: <linux-kselftest+bounces-9779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 507CB8C0D0A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 11:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7142B20B34
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5E14A085;
	Thu,  9 May 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG4NB3a8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5613C8F8;
	Thu,  9 May 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245553; cv=none; b=rdip+sSlFKCd+eQrinlTvQoCR+kl+v5SiHuu2kaenOLtOg7eEUUBvqSs21RGtk+nEjXVEbFTAgfrLJEHbOTvM3KczHOl2DwJY1ZC5wjrn5ueJnTRAc+4av6LxyL5XUSKnzCqzilQaFECEAdwWH9f4yYVzT3UqH2gJ2RdlGV60Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245553; c=relaxed/simple;
	bh=mmCuGtF5ajU+Sva/zqkCUzxTScPol2FZwoLEGvL7mGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X3YcLV318uSYW6cdF1EiiuNOdUFYIgyfzaWs+o0IYTUDmjqn4gCRvCngQiGCeXS0L459P1fzAvWKyLjTLb6IqrweHdNKb3MPntHEBKp5+GpD+QKG8N2qqSpVLGjgwVNkkfY984R6m6LnakBJeQiQ53yW1k0TJBNTJigrL97tsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG4NB3a8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-345606e8ac0so132132f8f.0;
        Thu, 09 May 2024 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715245550; x=1715850350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jaBYb1yFahSZKJ3Yb6zI/3hEKVFLSmEWv7FERERX+t0=;
        b=OG4NB3a8KkxIjQLQcKi0ehyMzS4unnWImz2TUvo2rS/rnljKKDnBt+W4hmBZ+PWTXs
         aInaHe3ktbr59GwRqyKoTTgg8VJtLpBxpkZT3x2rLxlt9QHcSsYgqDIKvmMd3RoHDbcN
         T5Lp6J6jdAAl0k4x/rXr8bUYwC005rH1j6Lyqo7AGNFTk9v0o3iwm4FySk4LY1Nc8kvl
         YIN2bpkZiVLEk1zvn1MnHrTesLrggRHf1lFhZXaznt3rUhanubbqwubdFeAcejzTMROj
         DdTiy0nYjSiINPV7FzUaOAowxjdrwhNVPSo1uKV/3lADjTItEf9AQ14VE0WsCsMX8QKt
         Z2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715245550; x=1715850350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaBYb1yFahSZKJ3Yb6zI/3hEKVFLSmEWv7FERERX+t0=;
        b=A7VA8nGjAcMMwa4xDVuCSboNB1e6/d2fJvgVT3IeZ7SiyiDbf2uuPU0JgIGNGMhyrt
         J6Fqir4DAGANXl5dcs9TEwlW2n8dCiPBbNkVTugkOF7o06ufFqnXxmRjXhejl/nQkEWA
         iykoobKQUynseMPHiqRrwTB1ZSEgwDD0uuBW9JoReyJHx7AO9oQ5iPBplrj5XeoeiXam
         2etEBTnOl/9fqarGJ+hQHdS4bWJnavPjJTfapg5KoTKsgF+eRlW/stOWJX8+H3gVHm+P
         ZabeN0vepOCLhzQA0aThgrgLl7yjaqV6pa43ILPrVX214udNLqer2JOD04BXv6RiQ/8+
         Rg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVq+1Jm7hEpjMWoImnbmpIqRarvkJxIJlQsRMhvawzdzZkejTyk9PFstqLN5eL3eoHQRYaAD3tP24uGz7s5AdVVuOsj+uoAz0pwHvxUmz14u2Hp/IxG6A+ili4G+jGK6XNxH4PhXer07v2B3T4e
X-Gm-Message-State: AOJu0YzcZ3OEBs9lNpD3vUlkjZYeDp7HUh+bs6FyG0Hop+Wyl7t+8197
	BPrI7VyOpEBSV2jxungnrKKPpnl2jkjRr2o9rGSWz5VrbKRnpGOo
X-Google-Smtp-Source: AGHT+IEJ5U1htuLTwBlUJSRvajPUWoYl9byQfgM4xPAQ4gaYbBYgU6wJKCmLMA/AzcDEdnvCVvrFfg==
X-Received: by 2002:a5d:5709:0:b0:34d:a29d:a8d5 with SMTP id ffacd0b85a97d-34fcb2b45damr3498638f8f.4.1715245549402;
        Thu, 09 May 2024 02:05:49 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:e3bb:8444:4138:914c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a89sm1124926f8f.31.2024.05.09.02.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:05:48 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org
Subject: [PATCH v3] kunit: Cover 'assert.c' with tests
Date: Thu,  9 May 2024 10:05:46 +0100
Message-Id: <20240509090546.944808-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are multiple assertion formatting functions in the `assert.c`
file, which are not covered with tests yet. Implement the KUnit test
for these functions.

The test consists of 11 test cases for the following functions:

1) 'is_literal'
2) 'is_str_literal'
3) 'kunit_assert_prologue', test case for multiple assert types
4) 'kunit_assert_print_msg'
5) 'kunit_unary_assert_format'
6) 'kunit_ptr_not_err_assert_format'
7) 'kunit_binary_assert_format'
8) 'kunit_binary_ptr_assert_format'
9) 'kunit_binary_str_assert_format'
10) 'kunit_assert_hexdump'
11) 'kunit_mem_assert_format'

The test aims at maximizing the branch coverage for the assertion
formatting functions.

As you can see, it covers some of the static helper functions as
well, so mark the static functions in `assert.c` as 'VISIBLE_IF_KUNIT'
and conditionally export them with EXPORT_SYMBOL_IF_KUNIT. Add the
corresponding definitions to `assert.h`.

Build the assert test when CONFIG_KUNIT_TEST is enabled, similar to
how it is done for the string stream test.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Check the output from the string stream for containing the key parts
instead of comparing the results with expected strings char by char, as
it was suggested by Rae Moar <rmoar@google.com>. Define two macros to
make it possible (ASSERT_TEST_EXPECT_CONTAIN and
ASSERT_TEST_EXPECT_NCONTAIN).
- Mark the static functions in `assert.c` as VISIBLE_IF_KUNIT and export
them conditionally if kunit is enabled instead of including the
`assert_test.c` file in the end of `assert.c`. This way we will decouple
the test from the implementation (SUT).
- Update the kunit_assert_hexdump test: now it checks for presense of
the brackets '<>' around the non-matching bytes, instead of comparing
the kunit_assert_hexdump output char by char.
V2 -> V3:
- Make test case array and test suite definitions static
- Change the condition in `assert.h`: we should declare VISIBLE_IF_KUNIT
functions in the header file when CONFIG_KUNIT is enabled, not
CONFIG_KUNIT_TEST. Otherwise, if CONFIG_KUNIT_TEST is disabled,
VISIBLE_IF_KUNIT functions in the `assert.c` are not static, and
prototypes for them can't be found.
- Add MODULE_LICENSE and MODULE_DESCRIPTION macros

 include/kunit/assert.h  |  11 ++
 lib/kunit/Makefile      |   1 +
 lib/kunit/assert.c      |  24 ++-
 lib/kunit/assert_test.c | 391 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 419 insertions(+), 8 deletions(-)
 create mode 100644 lib/kunit/assert_test.c

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 24c2b9fa61e8..7e7490a74b13 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -218,4 +218,15 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
 			     const struct va_format *message,
 			     struct string_stream *stream);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+void kunit_assert_print_msg(const struct va_format *message,
+			    struct string_stream *stream);
+bool is_literal(const char *text, long long value);
+bool is_str_literal(const char *text, const char *value);
+void kunit_assert_hexdump(struct string_stream *stream,
+			  const void *buf,
+			  const void *compared_buf,
+			  const size_t len);
+#endif
+
 #endif /*  _KUNIT_ASSERT_H */
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 309659a32a78..be7c9903936f 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -18,6 +18,7 @@ endif
 obj-y +=				hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index dd1d633d0fe2..382eb409d34b 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -7,6 +7,7 @@
  */
 #include <kunit/assert.h>
 #include <kunit/test.h>
+#include <kunit/visibility.h>
 
 #include "string-stream.h"
 
@@ -30,12 +31,14 @@ void kunit_assert_prologue(const struct kunit_loc *loc,
 }
 EXPORT_SYMBOL_GPL(kunit_assert_prologue);
 
-static void kunit_assert_print_msg(const struct va_format *message,
-				   struct string_stream *stream)
+VISIBLE_IF_KUNIT
+void kunit_assert_print_msg(const struct va_format *message,
+			    struct string_stream *stream)
 {
 	if (message->fmt)
 		string_stream_add(stream, "\n%pV", message);
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      const struct va_format *message,
@@ -89,7 +92,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
 /* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
-static bool is_literal(const char *text, long long value)
+VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
 {
 	char *buffer;
 	int len;
@@ -110,6 +113,7 @@ static bool is_literal(const char *text, long long value)
 
 	return ret;
 }
+EXPORT_SYMBOL_IF_KUNIT(is_literal);
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				const struct va_format *message,
@@ -166,7 +170,7 @@ EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 /* Checks if KUNIT_EXPECT_STREQ() args were string literals.
  * Note: `text` will have ""s where as `value` will not.
  */
-static bool is_str_literal(const char *text, const char *value)
+VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value)
 {
 	int len;
 
@@ -178,6 +182,7 @@ static bool is_str_literal(const char *text, const char *value)
 
 	return strncmp(text + 1, value, len - 2) == 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(is_str_literal);
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
@@ -208,10 +213,11 @@ EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
 /* Adds a hexdump of a buffer to a string_stream comparing it with
  * a second buffer. The different bytes are marked with <>.
  */
-static void kunit_assert_hexdump(struct string_stream *stream,
-				 const void *buf,
-				 const void *compared_buf,
-				 const size_t len)
+VISIBLE_IF_KUNIT
+void kunit_assert_hexdump(struct string_stream *stream,
+			  const void *buf,
+			  const void *compared_buf,
+			  const size_t len)
 {
 	size_t i;
 	const u8 *buf1 = buf;
@@ -229,6 +235,7 @@ static void kunit_assert_hexdump(struct string_stream *stream,
 			string_stream_add(stream, " %02x ", buf1[i]);
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
 
 void kunit_mem_assert_format(const struct kunit_assert *assert,
 			     const struct va_format *message,
@@ -269,4 +276,5 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
 		kunit_assert_print_msg(message, stream);
 	}
 }
+
 EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
new file mode 100644
index 000000000000..1347a964204b
--- /dev/null
+++ b/lib/kunit/assert_test.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * KUnit test for the assertion formatting functions.
+ * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
+ */
+#include <kunit/test.h>
+#include "string-stream.h"
+
+#define TEST_PTR_EXPECTED_BUF_SIZE 32
+#define HEXDUMP_TEST_BUF_LEN 5
+#define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(test, strstr(str, substr))
+#define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALSE(test, strstr(str, substr))
+
+static void kunit_test_is_literal(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
+	KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
+	KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
+	KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890));
+	KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
+	KUNIT_EXPECT_FALSE(test, is_literal("", 0));
+	KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
+	KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
+}
+
+static void kunit_test_is_str_literal(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hello, World!"));
+	KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
+	KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
+	KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
+	KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
+	KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
+	KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
+	KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba\""));
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
+
+/* this function is used to get a "char *" string from the string stream and defer its cleanup  */
+static char *get_str_from_stream(struct kunit *test, struct string_stream *stream)
+{
+	char *str = string_stream_get_string(stream);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
+	kunit_add_action(test, kfree_wrapper, (void *)str);
+
+	return str;
+}
+
+static void kunit_test_assert_prologue(struct kunit *test)
+{
+	struct string_stream *stream;
+	char *str;
+	const struct kunit_loc location = {
+		.file = "testfile.c",
+		.line = 1337,
+	};
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	/* Test an expectation fail prologue */
+	kunit_assert_prologue(&location, KUNIT_EXPECTATION, stream);
+	str = get_str_from_stream(test, stream);
+	ASSERT_TEST_EXPECT_CONTAIN(test, str, "EXPECTATION");
+	ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
+	ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
+
+	/* Test an assertion fail prologue */
+	string_stream_clear(stream);
+	kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
+	str = get_str_from_stream(test, stream);
+	ASSERT_TEST_EXPECT_CONTAIN(test, str, "ASSERTION");
+	ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
+	ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
+}
+
+/*
+ * This function accepts an arbitrary count of parameters and generates a va_format struct,
+ * which can be used to validate kunit_assert_print_msg function
+ */
+static void verify_assert_print_msg(struct kunit *test,
+				    struct string_stream *stream,
+				    char *expected, const char *format, ...)
+{
+	va_list list;
+	const struct va_format vformat = {
+		.fmt = format,
+		.va = &list,
+	};
+
+	va_start(list, format);
+	string_stream_clear(stream);
+	kunit_assert_print_msg(&vformat, stream);
+	KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expected);
+}
+
+static void kunit_test_assert_print_msg(struct kunit *test)
+{
+	struct string_stream *stream;
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	verify_assert_print_msg(test, stream, "\nTest", "Test");
+	verify_assert_print_msg(test, stream, "\nAbacaba -123 234", "%s %d %u",
+				"Abacaba", -123, 234U);
+	verify_assert_print_msg(test, stream, "", NULL);
+}
+
+/*
+ * Further code contains the tests for different assert format functions.
+ * This helper function accepts the assert format function, executes it and
+ * validates the result string from the stream by checking that all of the
+ * substrings exist in the output.
+ */
+static void validate_assert(assert_format_t format_func, struct kunit *test,
+			    const struct kunit_assert *assert,
+			    struct string_stream *stream, int num_checks, ...)
+{
+	size_t i;
+	va_list checks;
+	char *cur_substr_exp;
+	struct va_format message = { NULL, NULL };
+
+	va_start(checks, num_checks);
+	string_stream_clear(stream);
+	format_func(assert, &message, stream);
+
+	for (i = 0; i < num_checks; i++) {
+		cur_substr_exp = va_arg(checks, char *);
+		ASSERT_TEST_EXPECT_CONTAIN(test, get_str_from_stream(test, stream), cur_substr_exp);
+	}
+}
+
+static void kunit_test_unary_assert_format(struct kunit *test)
+{
+	struct string_stream *stream;
+	struct kunit_assert assert = {};
+	struct kunit_unary_assert un_assert = {
+		.assert = assert,
+		.condition = "expr",
+		.expected_true = true,
+	};
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	validate_assert(kunit_unary_assert_format, test, &un_assert.assert,
+			stream, 2, "true", "is false");
+
+	un_assert.expected_true = false;
+	validate_assert(kunit_unary_assert_format, test, &un_assert.assert,
+			stream, 2, "false", "is true");
+}
+
+static void kunit_test_ptr_not_err_assert_format(struct kunit *test)
+{
+	struct string_stream *stream;
+	struct kunit_assert assert = {};
+	struct kunit_ptr_not_err_assert not_err_assert = {
+		.assert = assert,
+		.text = "expr",
+		.value = NULL,
+	};
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	/* Value is NULL. The corresponding message should be printed out */
+	validate_assert(kunit_ptr_not_err_assert_format, test,
+			&not_err_assert.assert,
+			stream, 1, "null");
+
+	/* Value is not NULL, but looks like an error pointer. Error should be printed out */
+	not_err_assert.value = (void *)-12;
+	validate_assert(kunit_ptr_not_err_assert_format, test,
+			&not_err_assert.assert, stream, 2,
+			"error", "-12");
+}
+
+static void kunit_test_binary_assert_format(struct kunit *test)
+{
+	struct string_stream *stream;
+	struct kunit_assert assert = {};
+	struct kunit_binary_assert_text text = {
+		.left_text = "1 + 2",
+		.operation = "==",
+		.right_text = "2",
+	};
+	const struct kunit_binary_assert binary_assert = {
+		.assert = assert,
+		.text = &text,
+		.left_value = 3,
+		.right_value = 2,
+	};
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	/*
+	 * Printed values should depend on the input we provide: the left text, right text, left
+	 * value and the right value.
+	 */
+	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
+			stream, 4, "1 + 2", "2", "3", "==");
+
+	text.right_text = "4 - 2";
+	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
+			stream, 3, "==", "1 + 2", "4 - 2");
+
+	text.left_text = "3";
+	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
+			stream, 4, "3", "4 - 2", "2", "==");
+
+	text.right_text = "2";
+	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
+			stream, 3, "3", "2", "==");
+}
+
+static void kunit_test_binary_ptr_assert_format(struct kunit *test)
+{
+	struct string_stream *stream;
+	struct kunit_assert assert = {};
+	char *addr_var_a, *addr_var_b;
+	static const void *var_a = (void *)0xDEADBEEF;
+	static const void *var_b = (void *)0xBADDCAFE;
+	struct kunit_binary_assert_text text = {
+		.left_text = "var_a",
+		.operation = "==",
+		.right_text = "var_b",
+	};
+	struct kunit_binary_ptr_assert binary_ptr_assert = {
+		.assert = assert,
+		.text = &text,
+		.left_value = var_a,
+		.right_value = var_b,
+	};
+
+	addr_var_a = kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_a);
+	addr_var_b = kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_b);
+	/*
+	 * Print the addresses to the buffers first.
+	 * This is necessary as we may have different count of leading zeros in the pointer
+	 * on different architectures.
+	 */
+	snprintf(addr_var_a, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_a);
+	snprintf(addr_var_b, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_b);
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	validate_assert(kunit_binary_ptr_assert_format, test, &binary_ptr_assert.assert,
+			stream, 3, addr_var_a, addr_var_b, "==");
+}
+
+static void kunit_test_binary_str_assert_format(struct kunit *test)
+{
+	struct string_stream *stream;
+	struct kunit_assert assert = {};
+	static const char *var_a = "abacaba";
+	static const char *var_b = "kernel";
+	struct kunit_binary_assert_text text = {
+		.left_text = "var_a",
+		.operation = "==",
+		.right_text = "var_b",
+	};
+	struct kunit_binary_str_assert binary_str_assert = {
+		.assert = assert,
+		.text = &text,
+		.left_value = var_a,
+		.right_value = var_b,
+	};
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	validate_assert(kunit_binary_str_assert_format, test,
+			&binary_str_assert.assert,
+			stream, 5, "var_a", "var_b", "\"abacaba\"",
+			"\"kernel\"", "==");
+
+	text.left_text = "\"abacaba\"";
+	validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
+			stream, 4, "\"abacaba\"", "var_b", "\"kernel\"", "==");
+
+	text.right_text = "\"kernel\"";
+	validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
+			stream, 3, "\"abacaba\"", "\"kernel\"", "==");
+}
+
+static const u8 hex_testbuf1[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
+				   0x45, 0x9d, 0x47, 0xd6, 0x47,
+				   0x2,  0x89, 0x8c, 0x81, 0x94,
+				   0x12, 0xfe, 0x01 };
+static const u8 hex_testbuf2[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
+				   0x45, 0x9d, 0x47, 0x21, 0x47,
+				   0xcd, 0x89, 0x24, 0x50, 0x94,
+				   0x12, 0xba, 0x01 };
+static void kunit_test_assert_hexdump(struct kunit *test)
+{
+	struct string_stream *stream;
+	char *str;
+	size_t i;
+	char buf[HEXDUMP_TEST_BUF_LEN];
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	/* Check that we are getting output like <xx> for non-matching numbers. */
+	kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf2, sizeof(hex_testbuf1));
+	str = get_str_from_stream(test, stream);
+	for (i = 0; i < sizeof(hex_testbuf1); i++) {
+		snprintf(buf, HEXDUMP_TEST_BUF_LEN, "<%02x>", hex_testbuf1[i]);
+		if (hex_testbuf1[i] != hex_testbuf2[i])
+			ASSERT_TEST_EXPECT_CONTAIN(test, str, buf);
+	}
+	/* We shouldn't get any <xx> numbers when comparing the buffer with itself. */
+	string_stream_clear(stream);
+	kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf1, sizeof(hex_testbuf1));
+	str = get_str_from_stream(test, stream);
+	ASSERT_TEST_EXPECT_NCONTAIN(test, str, "<");
+	ASSERT_TEST_EXPECT_NCONTAIN(test, str, ">");
+}
+
+static void kunit_test_mem_assert_format(struct kunit *test)
+{
+	struct string_stream *stream;
+	struct string_stream *expected_stream;
+	struct kunit_assert assert = {};
+	static const struct kunit_binary_assert_text text = {
+		.left_text = "hex_testbuf1",
+		.operation = "==",
+		.right_text = "hex_testbuf2",
+	};
+	struct kunit_mem_assert mem_assert = {
+		.assert = assert,
+		.text = &text,
+		.left_value = NULL,
+		.right_value = hex_testbuf2,
+		.size = sizeof(hex_testbuf1),
+	};
+
+	expected_stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_stream);
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	/* The left value is NULL */
+	validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
+			stream, 2, "hex_testbuf1", "is not null");
+
+	/* The right value is NULL, the left value is not NULL */
+	mem_assert.left_value = hex_testbuf1;
+	mem_assert.right_value = NULL;
+	validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
+			stream, 2, "hex_testbuf2", "is not null");
+
+	/* Both arguments are not null */
+	mem_assert.left_value = hex_testbuf1;
+	mem_assert.right_value = hex_testbuf2;
+
+	validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
+			stream, 3, "hex_testbuf1", "hex_testbuf2", "==");
+}
+
+static struct kunit_case assert_test_cases[] = {
+	KUNIT_CASE(kunit_test_is_literal),
+	KUNIT_CASE(kunit_test_is_str_literal),
+	KUNIT_CASE(kunit_test_assert_prologue),
+	KUNIT_CASE(kunit_test_assert_print_msg),
+	KUNIT_CASE(kunit_test_unary_assert_format),
+	KUNIT_CASE(kunit_test_ptr_not_err_assert_format),
+	KUNIT_CASE(kunit_test_binary_assert_format),
+	KUNIT_CASE(kunit_test_binary_ptr_assert_format),
+	KUNIT_CASE(kunit_test_binary_str_assert_format),
+	KUNIT_CASE(kunit_test_assert_hexdump),
+	KUNIT_CASE(kunit_test_mem_assert_format),
+	{}
+};
+
+static struct kunit_suite assert_test_suite = {
+	.name = "kunit-assert",
+	.test_cases = assert_test_cases,
+};
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+kunit_test_suites(&assert_test_suite);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Test for the KUnit assertion format functions.");
-- 
2.34.1


