Return-Path: <linux-kselftest+bounces-8992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 877268B48C7
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 00:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33ED9281A0B
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 22:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AEF146596;
	Sat, 27 Apr 2024 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbDNLUAk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F61DA53;
	Sat, 27 Apr 2024 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714255506; cv=none; b=u6Iw6EhD06Yp3T3l/061vfPpuRP6DCWeyAvKu+nVXtCPV6LFW3tPCVhO4VHE0t94pXNMz3B3RIwPzp7OJUOLzqsVC056LN06KAAqxbn19VLCIwj3PBLDY8IhLXZbY3D9fFT59BANSXyefv1cUf2IPrPZPAsAO9EMAjYp5AJJAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714255506; c=relaxed/simple;
	bh=7GBSK+Hyf9SCNgb85ocwjZMGNYxa455/4++fxccLUng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XmqXzjSWIQhcMmkk5piS51FhM5tZ2CUb4siTFOc0HXQt0uOqwC1XilKO2de3SZLo24yy25rhs2ccGxLqeKssmbFwnfI1e4CJH8J4HgKs+Xv/+LFl77UIWo6wT17jGy8RfklO1k62/Npp60wrYJWULZ3TgzSjjuDIZNlqCn6iSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbDNLUAk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-349bd110614so603192f8f.3;
        Sat, 27 Apr 2024 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714255498; x=1714860298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+2Ze/IJu6OUa75PXS4xR6MdW3r/Cubn/vb3rWJFccs=;
        b=GbDNLUAkKBfTlSaKXNd396P3hTrHqx9njwJFzsUpAhzPyjQxqk52rFim+s00P+PNlb
         Ay5CC9uTEzyMcBarxxpVLbZNx8CEfhKxIeELlpDiAhG6zpQrtL9STS6Ox0L+qNMjSvw6
         VVRthccP5kvD2fI2rCOGYremq9wPKE75byVFfG5QxMlVtWpscLgM/Y78E2gpj6aAqFI/
         EoEZgikSZ6JB/njL5urz1o1wJq0lDUCh/3nu/8umv7HLQm3xEYzxkiDz26kjA20eFmQC
         Kv4xtJe+OmHGe31euEJ7YqS7H0Ba5w8RTAu8PsJLsJRCXDKP2X3440s5hmVBKBUuf0fi
         jv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714255498; x=1714860298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+2Ze/IJu6OUa75PXS4xR6MdW3r/Cubn/vb3rWJFccs=;
        b=ZRARLOJdWyNLTULwyWjypY+U3TcV0kHWmZt1iH4L7W6jjPQA9QGmL5MPLsp79BwqL5
         txMP7ECMqNtLPZKGX9SUttiCYy/JA30mFRPpiq87Ijh0MmwzWfgMqOJRPqGT8wF6dLc5
         rIPmHp5KfvTEyMCFx9595mEbW7gNY1kbJ30otaASHA0kYyr4qgSofayAbkfPSOWYq1VL
         pPiKRNQf3lTZ/Ml3NpDazeYymEtxKXWUo7XYavAL5LRcbCdRcz87EmsEGApl640PzVQZ
         Qv7q3gd+DsKpck5WBXA5beY4esyj2noTSeQg/A0goPv2HJ6S/Hof+WHrRn0/FSJq7Owb
         l3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXmS1qqL+lDWBRXlkiqdfZSUVQQMgdoQhHbu193Jj+Uou9ohkFa7c1+IPwk79NOR+udqC+bLEfN9DYexo/pTX0EOkn6+TVO5M0tLHe3nsIL2H3A5CXNgrOtqueWuE71aNNVzR9TBL6m+c3dUHIU
X-Gm-Message-State: AOJu0Yy2mRX9iO37oTv22t74JrTX67OUZLi0ZBCFvMQ6TF+oNDusx7FL
	8kzPDrhSvlWyexwksH9ugE8ZdEA0gteFnZydpNUJtZVv+Ioie+0wS1Z7PQ==
X-Google-Smtp-Source: AGHT+IHZWVxu+dql7daYSh4PRmTijQBGjV+aw9jK03kaqMdEidkl32G1X2O7VSgNT1FuLpoRd3wTdg==
X-Received: by 2002:adf:f4c5:0:b0:34a:5640:453c with SMTP id h5-20020adff4c5000000b0034a5640453cmr4234881wrp.2.1714255498314;
        Sat, 27 Apr 2024 15:04:58 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:2873:5c61:36dd:aae2])
        by smtp.gmail.com with ESMTPSA id w14-20020adfee4e000000b00343d6c7240fsm25685943wro.35.2024.04.27.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 15:04:57 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] kunit: Cover 'assert.c' with tests
Date: Sat, 27 Apr 2024 23:04:47 +0100
Message-Id: <20240427220447.231475-1-ivan.orlov0322@gmail.com>
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
formatting functions. As you can see, it covers some of the static
helper functions as well, so we have to import the test source in the
`assert.c` file in order to be able to call and validate them.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 lib/kunit/assert.c      |   4 +
 lib/kunit/assert_test.c | 416 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 420 insertions(+)
 create mode 100644 lib/kunit/assert_test.c

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index dd1d633d0fe2..ab68c6daf546 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -270,3 +270,7 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
 	}
 }
 EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
+
+#if IS_ENABLED(CONFIG_KUNIT_TEST)
+#include "assert_test.c"
+#endif
diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
new file mode 100644
index 000000000000..d54841740761
--- /dev/null
+++ b/lib/kunit/assert_test.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * KUnit test for the assertion formatting functions.
+ * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
+ */
+#include <kunit/test.h>
+
+#define TEST_PTR_EXPECTED_BUF_SIZE 128
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
+	KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream),
+			   "EXPECTATION FAILED at testfile.c:1337\n");
+
+	/* Test an assertion fail prologue */
+	string_stream_clear(stream);
+	kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
+	KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream),
+			   "ASSERTION FAILED at testfile.c:1337\n");
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
+ * validates the result string from the stream.
+ */
+static void validate_assert(assert_format_t format_func, struct kunit *test,
+			    const struct kunit_assert *assert,
+			    const char *expected, struct string_stream *stream)
+{
+	struct va_format message = { NULL, NULL };
+
+	string_stream_clear(stream);
+	format_func(assert, &message, stream);
+	KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expected);
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
+			KUNIT_SUBTEST_INDENT
+			"Expected expr to be true, but is false\n",
+			stream);
+
+	un_assert.expected_true = false;
+	validate_assert(kunit_unary_assert_format, test, &un_assert.assert,
+			KUNIT_SUBTEST_INDENT
+			"Expected expr to be false, but is true\n",
+			stream);
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
+			KUNIT_SUBTEST_INDENT
+			"Expected expr is not null, but is\n",
+			stream);
+
+	/* Value is not NULL, but looks like an error pointer. Error should be printed out */
+	not_err_assert.value = (void *)-12;
+	validate_assert(kunit_ptr_not_err_assert_format, test,
+			&not_err_assert.assert,
+			KUNIT_SUBTEST_INDENT
+			"Expected expr is not error, but is: -12\n",
+			stream);
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
+	 * the right argument is "literal" (see test for `is_literal` above),
+	 * so the right argument won't be printed out separately.
+	 */
+	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
+			KUNIT_SUBTEST_INDENT
+			"Expected 1 + 2 == 2, but\n" KUNIT_SUBSUBTEST_INDENT
+			"1 + 2 == 3 (0x3)\n",
+			stream);
+
+	/* Now both arguments are not "literal". They both will be printed out separately  */
+	text.right_text = "4 - 2";
+	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
+			KUNIT_SUBTEST_INDENT
+			"Expected 1 + 2 == 4 - 2, but\n" KUNIT_SUBSUBTEST_INDENT
+			"1 + 2 == 3 (0x3)\n" KUNIT_SUBSUBTEST_INDENT
+			"4 - 2 == 2 (0x2)",
+			stream);
+
+	/* Now the left argument is "literal", so it won't be printed out */
+	text.left_text = "3";
+	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
+			KUNIT_SUBTEST_INDENT
+			"Expected 3 == 4 - 2, but\n" KUNIT_SUBSUBTEST_INDENT
+			"4 - 2 == 2 (0x2)",
+			stream);
+
+	/* The left and the right arguments are not "literal", so they won't be printed out */
+	text.right_text = "2";
+	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
+			KUNIT_SUBTEST_INDENT "Expected 3 == 2, but\n", stream);
+}
+
+static void kunit_test_binary_ptr_assert_format(struct kunit *test)
+{
+	struct string_stream *stream;
+	struct kunit_assert assert = {};
+	char *expected;
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
+	expected = kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected);
+	/*
+	 * Print the expected string to the buffer first.
+	 * This is necessary as we may have different count of leading zeros in the pointer
+	 * on different architectures.
+	 */
+	snprintf(expected, TEST_PTR_EXPECTED_BUF_SIZE,
+		 KUNIT_SUBTEST_INDENT
+		 "Expected var_a == var_b, but\n" KUNIT_SUBSUBTEST_INDENT
+		 "var_a == %px\n" KUNIT_SUBSUBTEST_INDENT "var_b == %px",
+		 var_a, var_b);
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	validate_assert(kunit_binary_ptr_assert_format, test,
+			&binary_ptr_assert.assert, expected, stream);
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
+	/* Both arguments are not "string literals", so they should be printed separately */
+	validate_assert(kunit_binary_str_assert_format, test,
+			&binary_str_assert.assert,
+			KUNIT_SUBTEST_INDENT
+			"Expected var_a == var_b, but\n" KUNIT_SUBSUBTEST_INDENT
+			"var_a == \"abacaba\"\n" KUNIT_SUBSUBTEST_INDENT
+			"var_b == \"kernel\"",
+			stream);
+
+	/* Left argument is a "string literal", so it shouldn't be printed separately */
+	text.left_text = "\"abacaba\"";
+	validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
+			KUNIT_SUBTEST_INDENT "Expected \"abacaba\" == var_b, but\n"
+			KUNIT_SUBSUBTEST_INDENT "var_b == \"kernel\"", stream);
+
+	/* Both arguments are "string literals", so they shouldn't be printed separately */
+	text.right_text = "\"kernel\"";
+	validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
+			KUNIT_SUBTEST_INDENT "Expected \"abacaba\" == \"kernel\", but\n", stream);
+}
+
+static const u8 hex_testbuf1[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
+				   0x45, 0x9d, 0x47, 0xd6, 0x47,
+				   0x1,  0x89, 0x8c, 0x81, 0x94,
+				   0x12, 0xfe, 0x01 };
+static const u8 hex_testbuf2[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
+				   0x45, 0x9d, 0x47, 0x21, 0x47,
+				   0xcd, 0x89, 0x24, 0x50, 0x94,
+				   0x12, 0xba, 0x01 };
+static void kunit_test_assert_hexdump(struct kunit *test)
+{
+	struct string_stream *stream;
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	/*
+	 * Check that we are getting numbers like <xx> on the right places.
+	 * Also check that we get a newline after 16 bytes
+	 */
+	kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf2, sizeof(hex_testbuf1));
+	KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), KUNIT_SUBSUBTEST_INDENT
+			   " 26  74  6b  9c  55  45  9d  47 <d6> 47 <01> 89 <8c><81> 94  12 \n"
+			   KUNIT_SUBSUBTEST_INDENT "<fe> 01 ");
+
+	/*
+	 * We shouldn't get any <xx> numbers when comparing the buffer with itself.
+	 * We still should get a newline after 16 printed bytes
+	 */
+	string_stream_clear(stream);
+	kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf1, sizeof(hex_testbuf1));
+	KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream),
+			   KUNIT_SUBSUBTEST_INDENT
+			   " 26  74  6b  9c  55  45  9d  47  d6  47  01  89  8c  81  94  12 \n"
+			   KUNIT_SUBSUBTEST_INDENT " fe  01 ");
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
+			KUNIT_SUBTEST_INDENT
+			"Expected hex_testbuf1 is not null, but is\n",
+			stream);
+
+	/* The right value is NULL, the left value is not NULL */
+	mem_assert.left_value = hex_testbuf1;
+	mem_assert.right_value = NULL;
+	validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
+			KUNIT_SUBTEST_INDENT
+			"Expected hex_testbuf2 is not null, but is\n",
+			stream);
+
+	/* Both arguments are not null */
+	mem_assert.left_value = hex_testbuf1;
+	mem_assert.right_value = hex_testbuf2;
+
+	/*
+	 * Building the expected buffer.
+	 */
+	string_stream_add(expected_stream,
+			  KUNIT_SUBTEST_INDENT "Expected hex_testbuf1 == hex_testbuf2, but\n");
+	string_stream_add(expected_stream, KUNIT_SUBSUBTEST_INDENT "hex_testbuf1 ==\n");
+	kunit_assert_hexdump(expected_stream, hex_testbuf1, hex_testbuf2, mem_assert.size);
+	string_stream_add(expected_stream,
+			  "\n" KUNIT_SUBSUBTEST_INDENT "hex_testbuf2 ==\n");
+	kunit_assert_hexdump(expected_stream, hex_testbuf2, hex_testbuf1, mem_assert.size);
+
+	validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
+			get_str_from_stream(test, expected_stream), stream);
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
+kunit_test_suites(&assert_test_suite);
-- 
2.34.1


