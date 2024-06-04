Return-Path: <linux-kselftest+bounces-11183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 464DD8FB25A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67A71F2196D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD6C148318;
	Tue,  4 Jun 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahdNyXNa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B080147C98;
	Tue,  4 Jun 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504378; cv=none; b=bnENGIeQtCFQJjaaJEXJhmQagp2jWvKaqvmn/B91oNGurckQ9JguEPggjJIGiFhE36W8lg+RyfplZYin1913y9JPcY0RyWzEsbpRd2q6reFEqSh/mKA7aaE/nfzkPgCh85vprkFc0uGYiSlWRJ+flSUA9MIPFtfmyaoTB0E7yhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504378; c=relaxed/simple;
	bh=K7PTBAzXAoBgSJ+xKfvJW7X0sYaTeuzUtC1J50VAFJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QnzXs14cshRvqzu8gSCfBdWMQYc+j12avlj6PzGbp5UnJasoR27puGOOJRWMvgJxdbyQBJJu/5A5gZWbBpgXgiWEjiNeMdoTCrU3GmAVjnUDZE3zaPrpvjBXjyW5ZEt6GSuivXLmHj4nUPAj6/6me9VWrVivGiGZTmqHqD+L5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahdNyXNa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42111c2892bso6499455e9.1;
        Tue, 04 Jun 2024 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504374; x=1718109174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSP18lcHx1ChZ83uy+ELGIcQeD+03tu22F2jT4KbnYI=;
        b=ahdNyXNa2+MATWHbFKzpaXg+podc+i8s0dbiByFwIowXDzyoVDMgDGEnsQ+u8tU+yT
         WawxM6VvRqeVCPhMGS6TK07bDswRlX+EWiAKeB9sMX8p/6WAIbICyWs2DeoKxMmDm97Y
         7AxHBkkBCCXdh/qDatvlVcL8nF64MHPOLw77IWZsUZCvqJIcZKB4eOvFs4Gjgbk4C7N/
         HXxLsQDYVnpKkBOt5nwXH7IdcjG9caGawvt7yr7/3bGSsjTj0qGB4rQd3lCYm5LqI94F
         v3wyLzJZUKBqLv6qDkZXEvqPwi4hX2JZoHWggFFqfh594zout5Jr/AkQv2KDyvpz9J2k
         WGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504374; x=1718109174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSP18lcHx1ChZ83uy+ELGIcQeD+03tu22F2jT4KbnYI=;
        b=XOdomwIJczgAuqEfrrn9qcYWGT8IlQH91Ts3z9IuR2l4+RD0t/H3DPNM7RCOcup1ea
         hxFxkRSjvxwGKhhKEByPRgJ2NuvfCEErrkXhPcw6RvvSkeC441OFcKOuNz7zFsaB+7xs
         zDNy1MoEn5ndWMuLZXB9pWP9zpE/QqH2AFrErX4j8TW4KodfFJES4hItFcbA47NthF1r
         VC+mMrwlLlEE7FyaymjgYIfgmTTh7cBw/pmLHN0RU0p/EgkfHJC/oMjcl47VEuDVL6U1
         AtKX7q5nrXnJzsKDt+esmaxmtbQw6nFk8yca5BdyinkX0RGemyeWLDc5jnENXcMP3cHv
         Th5g==
X-Forwarded-Encrypted: i=1; AJvYcCVWj+uFaviy3tH69BSErXxXva3iredevU63rkPlkrlUtTam6doYJpWJKFW1FmfXfIFOUFWEqi5LoRXMrHGIbEStx5TQ+v1O+YZ08hYoxGfO8cXeb4u2jvaRTGocbLNmpt+kBtA2sYE2Gr2R6DZC
X-Gm-Message-State: AOJu0YzOX0bd+MLIuKWXLSAsf9NeFW7eY90r9Z82lehdeKBw4ixWs7KG
	tQpqMm5o1WjNLJHqwM4beNay4xBG9MMD37gsycAf2upcdmKQjeZKHc8pWw==
X-Google-Smtp-Source: AGHT+IET0TS86z2KqiYXtuk/kiig8sl/pspB76KANZzBCBdXrzbcFE49iLmENZHc8lCCnPrJkCAL4Q==
X-Received: by 2002:a05:600c:3ca6:b0:41a:408c:579c with SMTP id 5b1f17b1804b1-4212e046157mr95442955e9.1.1717504374171;
        Tue, 04 Jun 2024 05:32:54 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e535567e9sm7209179f8f.21.2024.06.04.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:32:53 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] kunit: Merge assertion test into kunit-test.c
Date: Tue,  4 Jun 2024 13:32:04 +0100
Message-Id: <20240604123204.10412-6-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since assert_test covers the part of the KUnit core (the assertion
formatting functions), I believe it would be better to have it merged
into kunit-test (as it is done for other tests for the KUnit core).

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 lib/kunit/Makefile      |   5 -
 lib/kunit/assert_test.c | 388 ----------------------------------------
 lib/kunit/kunit-test.c  | 379 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 378 insertions(+), 394 deletions(-)
 delete mode 100644 lib/kunit/assert_test.c

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 4793a3960f07..f41d2eab1f8d 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -20,9 +20,4 @@ obj-y +=				hooks.o
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 obj-$(CONFIG_KUNIT_STRING_STREAM_TEST) += string-stream-test.o
 
-# string-stream-test compiles built-in only.
-ifeq ($(CONFIG_KUNIT_TEST),y)
-obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
-endif
-
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
deleted file mode 100644
index 4a5967712186..000000000000
--- a/lib/kunit/assert_test.c
+++ /dev/null
@@ -1,388 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * KUnit test for the assertion formatting functions.
- * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
- */
-#include <kunit/test.h>
-#include "string-stream.h"
-
-#define TEST_PTR_EXPECTED_BUF_SIZE 32
-#define HEXDUMP_TEST_BUF_LEN 5
-#define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(test, strstr(str, substr))
-#define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALSE(test, strstr(str, substr))
-
-static void kunit_test_is_literal(struct kunit *test)
-{
-	KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
-	KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
-	KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
-	KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890));
-	KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
-	KUNIT_EXPECT_FALSE(test, is_literal("", 0));
-	KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
-	KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
-}
-
-static void kunit_test_is_str_literal(struct kunit *test)
-{
-	KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hello, World!"));
-	KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
-	KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba\""));
-}
-
-KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
-
-/* this function is used to get a "char *" string from the string stream and defer its cleanup  */
-static char *get_str_from_stream(struct kunit *test, struct string_stream *stream)
-{
-	char *str = string_stream_get_string(stream);
-
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
-	kunit_add_action(test, kfree_wrapper, (void *)str);
-
-	return str;
-}
-
-static void kunit_test_assert_prologue(struct kunit *test)
-{
-	struct string_stream *stream;
-	char *str;
-	const struct kunit_loc location = {
-		.file = "testfile.c",
-		.line = 1337,
-	};
-
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	/* Test an expectation fail prologue */
-	kunit_assert_prologue(&location, KUNIT_EXPECTATION, stream);
-	str = get_str_from_stream(test, stream);
-	ASSERT_TEST_EXPECT_CONTAIN(test, str, "EXPECTATION");
-	ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
-	ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
-
-	/* Test an assertion fail prologue */
-	string_stream_clear(stream);
-	kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
-	str = get_str_from_stream(test, stream);
-	ASSERT_TEST_EXPECT_CONTAIN(test, str, "ASSERTION");
-	ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
-	ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
-}
-
-/*
- * This function accepts an arbitrary count of parameters and generates a va_format struct,
- * which can be used to validate kunit_assert_print_msg function
- */
-static void verify_assert_print_msg(struct kunit *test,
-				    struct string_stream *stream,
-				    char *expected, const char *format, ...)
-{
-	va_list list;
-	const struct va_format vformat = {
-		.fmt = format,
-		.va = &list,
-	};
-
-	va_start(list, format);
-	string_stream_clear(stream);
-	kunit_assert_print_msg(&vformat, stream);
-	KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expected);
-}
-
-static void kunit_test_assert_print_msg(struct kunit *test)
-{
-	struct string_stream *stream;
-
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	verify_assert_print_msg(test, stream, "\nTest", "Test");
-	verify_assert_print_msg(test, stream, "\nAbacaba -123 234", "%s %d %u",
-				"Abacaba", -123, 234U);
-	verify_assert_print_msg(test, stream, "", NULL);
-}
-
-/*
- * Further code contains the tests for different assert format functions.
- * This helper function accepts the assert format function, executes it and
- * validates the result string from the stream by checking that all of the
- * substrings exist in the output.
- */
-static void validate_assert(assert_format_t format_func, struct kunit *test,
-			    const struct kunit_assert *assert,
-			    struct string_stream *stream, int num_checks, ...)
-{
-	size_t i;
-	va_list checks;
-	char *cur_substr_exp;
-	struct va_format message = { NULL, NULL };
-
-	va_start(checks, num_checks);
-	string_stream_clear(stream);
-	format_func(assert, &message, stream);
-
-	for (i = 0; i < num_checks; i++) {
-		cur_substr_exp = va_arg(checks, char *);
-		ASSERT_TEST_EXPECT_CONTAIN(test, get_str_from_stream(test, stream), cur_substr_exp);
-	}
-}
-
-static void kunit_test_unary_assert_format(struct kunit *test)
-{
-	struct string_stream *stream;
-	struct kunit_assert assert = {};
-	struct kunit_unary_assert un_assert = {
-		.assert = assert,
-		.condition = "expr",
-		.expected_true = true,
-	};
-
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	validate_assert(kunit_unary_assert_format, test, &un_assert.assert,
-			stream, 2, "true", "is false");
-
-	un_assert.expected_true = false;
-	validate_assert(kunit_unary_assert_format, test, &un_assert.assert,
-			stream, 2, "false", "is true");
-}
-
-static void kunit_test_ptr_not_err_assert_format(struct kunit *test)
-{
-	struct string_stream *stream;
-	struct kunit_assert assert = {};
-	struct kunit_ptr_not_err_assert not_err_assert = {
-		.assert = assert,
-		.text = "expr",
-		.value = NULL,
-	};
-
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	/* Value is NULL. The corresponding message should be printed out */
-	validate_assert(kunit_ptr_not_err_assert_format, test,
-			&not_err_assert.assert,
-			stream, 1, "null");
-
-	/* Value is not NULL, but looks like an error pointer. Error should be printed out */
-	not_err_assert.value = (void *)-12;
-	validate_assert(kunit_ptr_not_err_assert_format, test,
-			&not_err_assert.assert, stream, 2,
-			"error", "-12");
-}
-
-static void kunit_test_binary_assert_format(struct kunit *test)
-{
-	struct string_stream *stream;
-	struct kunit_assert assert = {};
-	struct kunit_binary_assert_text text = {
-		.left_text = "1 + 2",
-		.operation = "==",
-		.right_text = "2",
-	};
-	const struct kunit_binary_assert binary_assert = {
-		.assert = assert,
-		.text = &text,
-		.left_value = 3,
-		.right_value = 2,
-	};
-
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	/*
-	 * Printed values should depend on the input we provide: the left text, right text, left
-	 * value and the right value.
-	 */
-	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
-			stream, 4, "1 + 2", "2", "3", "==");
-
-	text.right_text = "4 - 2";
-	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
-			stream, 3, "==", "1 + 2", "4 - 2");
-
-	text.left_text = "3";
-	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
-			stream, 4, "3", "4 - 2", "2", "==");
-
-	text.right_text = "2";
-	validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
-			stream, 3, "3", "2", "==");
-}
-
-static void kunit_test_binary_ptr_assert_format(struct kunit *test)
-{
-	struct string_stream *stream;
-	struct kunit_assert assert = {};
-	char *addr_var_a, *addr_var_b;
-	static const void *var_a = (void *)0xDEADBEEF;
-	static const void *var_b = (void *)0xBADDCAFE;
-	struct kunit_binary_assert_text text = {
-		.left_text = "var_a",
-		.operation = "==",
-		.right_text = "var_b",
-	};
-	struct kunit_binary_ptr_assert binary_ptr_assert = {
-		.assert = assert,
-		.text = &text,
-		.left_value = var_a,
-		.right_value = var_b,
-	};
-
-	addr_var_a = kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_a);
-	addr_var_b = kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_b);
-	/*
-	 * Print the addresses to the buffers first.
-	 * This is necessary as we may have different count of leading zeros in the pointer
-	 * on different architectures.
-	 */
-	snprintf(addr_var_a, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_a);
-	snprintf(addr_var_b, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_b);
-
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-	validate_assert(kunit_binary_ptr_assert_format, test, &binary_ptr_assert.assert,
-			stream, 3, addr_var_a, addr_var_b, "==");
-}
-
-static void kunit_test_binary_str_assert_format(struct kunit *test)
-{
-	struct string_stream *stream;
-	struct kunit_assert assert = {};
-	static const char *var_a = "abacaba";
-	static const char *var_b = "kernel";
-	struct kunit_binary_assert_text text = {
-		.left_text = "var_a",
-		.operation = "==",
-		.right_text = "var_b",
-	};
-	struct kunit_binary_str_assert binary_str_assert = {
-		.assert = assert,
-		.text = &text,
-		.left_value = var_a,
-		.right_value = var_b,
-	};
-
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	validate_assert(kunit_binary_str_assert_format, test,
-			&binary_str_assert.assert,
-			stream, 5, "var_a", "var_b", "\"abacaba\"",
-			"\"kernel\"", "==");
-
-	text.left_text = "\"abacaba\"";
-	validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
-			stream, 4, "\"abacaba\"", "var_b", "\"kernel\"", "==");
-
-	text.right_text = "\"kernel\"";
-	validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
-			stream, 3, "\"abacaba\"", "\"kernel\"", "==");
-}
-
-static const u8 hex_testbuf1[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
-				   0x45, 0x9d, 0x47, 0xd6, 0x47,
-				   0x2,  0x89, 0x8c, 0x81, 0x94,
-				   0x12, 0xfe, 0x01 };
-static const u8 hex_testbuf2[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
-				   0x45, 0x9d, 0x47, 0x21, 0x47,
-				   0xcd, 0x89, 0x24, 0x50, 0x94,
-				   0x12, 0xba, 0x01 };
-static void kunit_test_assert_hexdump(struct kunit *test)
-{
-	struct string_stream *stream;
-	char *str;
-	size_t i;
-	char buf[HEXDUMP_TEST_BUF_LEN];
-
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-	/* Check that we are getting output like <xx> for non-matching numbers. */
-	kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf2, sizeof(hex_testbuf1));
-	str = get_str_from_stream(test, stream);
-	for (i = 0; i < sizeof(hex_testbuf1); i++) {
-		snprintf(buf, HEXDUMP_TEST_BUF_LEN, "<%02x>", hex_testbuf1[i]);
-		if (hex_testbuf1[i] != hex_testbuf2[i])
-			ASSERT_TEST_EXPECT_CONTAIN(test, str, buf);
-	}
-	/* We shouldn't get any <xx> numbers when comparing the buffer with itself. */
-	string_stream_clear(stream);
-	kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf1, sizeof(hex_testbuf1));
-	str = get_str_from_stream(test, stream);
-	ASSERT_TEST_EXPECT_NCONTAIN(test, str, "<");
-	ASSERT_TEST_EXPECT_NCONTAIN(test, str, ">");
-}
-
-static void kunit_test_mem_assert_format(struct kunit *test)
-{
-	struct string_stream *stream;
-	struct string_stream *expected_stream;
-	struct kunit_assert assert = {};
-	static const struct kunit_binary_assert_text text = {
-		.left_text = "hex_testbuf1",
-		.operation = "==",
-		.right_text = "hex_testbuf2",
-	};
-	struct kunit_mem_assert mem_assert = {
-		.assert = assert,
-		.text = &text,
-		.left_value = NULL,
-		.right_value = hex_testbuf2,
-		.size = sizeof(hex_testbuf1),
-	};
-
-	expected_stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_stream);
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	/* The left value is NULL */
-	validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
-			stream, 2, "hex_testbuf1", "is not null");
-
-	/* The right value is NULL, the left value is not NULL */
-	mem_assert.left_value = hex_testbuf1;
-	mem_assert.right_value = NULL;
-	validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
-			stream, 2, "hex_testbuf2", "is not null");
-
-	/* Both arguments are not null */
-	mem_assert.left_value = hex_testbuf1;
-	mem_assert.right_value = hex_testbuf2;
-
-	validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
-			stream, 3, "hex_testbuf1", "hex_testbuf2", "==");
-}
-
-static struct kunit_case assert_test_cases[] = {
-	KUNIT_CASE(kunit_test_is_literal),
-	KUNIT_CASE(kunit_test_is_str_literal),
-	KUNIT_CASE(kunit_test_assert_prologue),
-	KUNIT_CASE(kunit_test_assert_print_msg),
-	KUNIT_CASE(kunit_test_unary_assert_format),
-	KUNIT_CASE(kunit_test_ptr_not_err_assert_format),
-	KUNIT_CASE(kunit_test_binary_assert_format),
-	KUNIT_CASE(kunit_test_binary_ptr_assert_format),
-	KUNIT_CASE(kunit_test_binary_str_assert_format),
-	KUNIT_CASE(kunit_test_assert_hexdump),
-	KUNIT_CASE(kunit_test_mem_assert_format),
-	{}
-};
-
-static struct kunit_suite assert_test_suite = {
-	.name = "kunit-assert",
-	.test_cases = assert_test_cases,
-};
-
-kunit_test_suites(&assert_test_suite);
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 42178d5a97d1..efba189442c2 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -849,10 +849,387 @@ static struct kunit_suite kunit_current_test_suite = {
 	.test_cases = kunit_current_test_cases,
 };
 
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
+static struct kunit_case kunit_assert_test_cases[] = {
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
+static struct kunit_suite kunit_assert_test_suite = {
+	.name = "kunit-assert",
+	.test_cases = kunit_assert_test_cases,
+};
+
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_log_test_suite, &kunit_status_test_suite,
 		  &kunit_current_test_suite, &kunit_device_test_suite,
-		  &kunit_fault_test_suite);
+		  &kunit_fault_test_suite, &kunit_assert_test_suite);
 
 MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
 MODULE_LICENSE("GPL v2");
-- 
2.34.1


