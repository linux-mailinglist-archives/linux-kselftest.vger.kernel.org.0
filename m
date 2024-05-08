Return-Path: <linux-kselftest+bounces-9702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC47B8BFEB6
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21DBB22065
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE778C7F;
	Wed,  8 May 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ4lsd35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E07A15A;
	Wed,  8 May 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174766; cv=none; b=jI/FDLWIg7b3AVR5QX7Z8/OrfgO4Zzz3oZXJ7LvaNTH5nrdR6aoxCi3Fbt+YxDgWQzNTsB+t5mbO/yhAhSoipLttKnq85sdZE0dPUmpznZKsrpMrFjw6i4XQs8yg6T4Tj6ARDzuM3sWnwwrldtxji3IIgi+ZB1Dk2t0pudpnsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174766; c=relaxed/simple;
	bh=MAqxTvhgjm1oEziajJjjjGYxTJo1gKqr0BM3su7Nyoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SvALSepiXZzwc0rEpl+mtZdw8dLyV+54z9151cxXk4+WlbNTXNpS9aJ4B0AMWr0WS1DRmaGcI0EgSwpCkI2fR7AJ72iglOeyG9OqK8Td8Y4YX0U7S9q9xc5sE9GlYMBbjkY+BVnCK7PMHM2p77KkW0TkupuJk5wXQXkWF3hpt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ4lsd35; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41c017ee8deso136405e9.2;
        Wed, 08 May 2024 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715174761; x=1715779561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0kgMONDxGre1TMBprpb2YAsADbJp7hrnZXRcTxcl4I=;
        b=CQ4lsd359CC2aUbkK5o4cNdlIa9cIigT6amt0hM0rL8RqsLyIbGvhHrOl/oSF9en3J
         jSGnPCFw/+g+Jo/YnHBjbgfiX7eXI86FVjT3oXNpGltnXS2tryUI/mGl4+GJo6omNTi1
         H7k9GG11r5thPQpioTkbRNMIPvr74YA45GxeDn4z8cZeo8+j5vJ4u9UALZnljJ5PVqzC
         jFcqhKjHTpWHopGa4ruyt56+GA974avzwRN28LzKPAmREJVgMJsBnTZRpkYT3R/b6g5o
         F5JF6fi0h8+OX/4IbnaIFf9BBlr3c4fIzX8QdzP8AGJwWymlQaHspKVqzL4Cm61ypIU8
         S/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715174761; x=1715779561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0kgMONDxGre1TMBprpb2YAsADbJp7hrnZXRcTxcl4I=;
        b=mNrA2I5aPESgPll6Hj3Zz9yzSwd04Gut34+kmjmTg8A9GqitzSyB+wR+QOtsyPkpkI
         R14ySQELfhK7alGynJTJSXvcZkaVjo86N1kWRUYNPOHSmtJj4QXu5dQisHCosFBjoHHg
         zjXapBzqwKZLyGhBUZFerDXPICaBTX+yTNbBp9UCfO85pqPQpGoSTCpZPfCF0sc2a4PJ
         N0+jr0rqcwgWtVqg0wzi1eVGlt7N3MPawevFBU/cUmevwwZn3Me6GeZrelFA4Yd1Y3Ip
         5vPT+9cLkvy5x6x1IHCUJ7lBzTcP2fLWVzMZ0tJNmdjHzMIHC74c6/62IXhvtlrfoSQe
         cxFA==
X-Forwarded-Encrypted: i=1; AJvYcCWEc17WYOnTbZ6M1snffiMu6DjuZN5HpoV1FsmmmlGCY++APmNPiy6hCDziOfpKgX3yoYwqdJfmv5px06v75KmOiIcNWZmuXCOIfxJSU1m5g8M8dvoGJpmAMt4mzqvZpi8qDljla7UAM4IXH7Q3
X-Gm-Message-State: AOJu0YzISCRsPW2ejuEtC9A5ZSmhW1OluRgQTxGmJWPBuRMEihnAtHbf
	+2iIktIgDSDwWJizyRKGEVzZIbmr7XmpJJt7x9+m0/DiMzB4FVa9IdOAvg==
X-Google-Smtp-Source: AGHT+IHDM3f1NSFk8ZJw3/Nr4c+LOEHPXQhK5oxNQbl6mYGjS282RjqjHOPgpv93R5w1e75+CcYmcQ==
X-Received: by 2002:a05:600c:4f49:b0:41b:e58c:e007 with SMTP id 5b1f17b1804b1-41f71cbf49dmr19938555e9.4.1715174760582;
        Wed, 08 May 2024 06:26:00 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id s8-20020adfecc8000000b0034dda041ccasm15410566wro.102.2024.05.08.06.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:26:00 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2] kunit: Cover 'assert.c' with tests
Date: Wed,  8 May 2024 14:25:57 +0100
Message-Id: <20240508132557.599213-1-ivan.orlov0322@gmail.com>
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

 include/kunit/assert.h  |  11 ++
 lib/kunit/Makefile      |   1 +
 lib/kunit/assert.c      |  24 ++-
 lib/kunit/assert_test.c | 389 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 417 insertions(+), 8 deletions(-)
 create mode 100644 lib/kunit/assert_test.c

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 24c2b9fa61e8..31e655abbce9 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -218,4 +218,15 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
 			     const struct va_format *message,
 			     struct string_stream *stream);
 
+#if IS_ENABLED(CONFIG_KUNIT_TEST)
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
index 000000000000..dd26a82b9fd7
--- /dev/null
+++ b/lib/kunit/assert_test.c
@@ -0,0 +1,389 @@
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
+struct kunit_case assert_test_cases[] = {
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
+struct kunit_suite assert_test_suite = {
+	.name = "kunit-assert",
+	.test_cases = assert_test_cases,
+};
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+kunit_test_suites(&assert_test_suite);
-- 
2.34.1


