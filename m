Return-Path: <linux-kselftest+bounces-12165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBF290DA40
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 19:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC96E1F23EC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4594F14EC79;
	Tue, 18 Jun 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg2tidGL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C981149C63;
	Tue, 18 Jun 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730231; cv=none; b=Nm3PCFeskOGezMHz643vtXBDWTxhsB2UmK8BhEHlzX5nLlgegUiVJl4SyUMkMNH9ziZjzhihEe+45WBkLh9djNKjDL7+WcfzsOwB9M4e3d9XsNTNyifE4PM1wtQDT96XV69Noz+nRgBDhp6swYG4yRDtov/LSVck/VYltfQ3wm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730231; c=relaxed/simple;
	bh=/xPST6BiYupttxdybMSoJP7uwCbA5Uk7q0zxBsyg1+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LhlkS9XZVCjik5JtZI0sOx08rjlEPbiD7nFpFQhdAxds1x3ZagTNEBrjIGHi+c0d2P4lT5Ju+V8YG39gsE+NaLht/Yc0IP+l00fyQwsgLtJOs5uVL/N80yspaYwGRT+Lvm+eBJBlv3Li5nUUFsD7b5//KG0vADpa3YPmaAHh2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg2tidGL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f0dac5909so417729f8f.0;
        Tue, 18 Jun 2024 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718730227; x=1719335027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fjUVkrkDFzYbqIy88djnd7GU/dDU+/R+Z5cJ/0GW2M=;
        b=Gg2tidGLI1qR6mSe+ILP5+I2LpCXktANHmmHyDVYBi5dsqH7Ff7FcMo0IRLsM6/gN8
         JUJxytSsDEA/WuaI5Nn0VqbsHaIpH+WK6tvqIXlUOQ5X6xzOX1Yzi2yy1zKbBpEot3VK
         KLm1z84k+Crrog41g5od3Zh/2Eyx7cg+2bX5nMERjXcr/aR8EqWmrPVX6kWAN/IRbGhw
         nG/g9KhAKoXfwJWGBBU0LgzMKxFYeaMPU6Df1dds/mY2kZBOjB0yh0rfhwr0bTTqhaCl
         aNMUMcrZxNxSduq4d/suu7tlQWFjsFvlpSA7PkYCiCOa09kVZezBelC3LThL9NB106oG
         bLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730227; x=1719335027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fjUVkrkDFzYbqIy88djnd7GU/dDU+/R+Z5cJ/0GW2M=;
        b=cfLPsWFFzOrQclbPn0hYidYcqyF4jJAS4csp83tIguzT7Jwfpmv/YEU3dCtmdOf4Tu
         nr9xanVQSHs3guwYlHCZLA6h3seiVNddTWgzIh3CEZDoeJg1rd7ty6efLHzBLIubkBQm
         hjxCRvW/DwQ+eIy+yfq4mgh9X+xAODg0rf1WB2ZB6R1jCuhj9kJd0Le3SKhg79bhBkzO
         5nXSLOvXMHJ2kL+G79bkoPjVfW5h1iMxoeLnqQ7wZmwYfKF88T2aitmvD/FFw22KU35V
         3PEiD0Z+0fnQa1r+aE9Pf9XGGGVDz1LS86lgCsDkLBSqqYWOe1BraJWpYbyaBm1eUCr8
         7/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoHnIaho2UUKNHZNgAAH3JzrKv6Q5kjU8EHCygZAiYcx3p75gxarLz7ACfoQPdAc0NtreWZw14vRyRpk7iD2Swj4DvgYl7VJxr+iJOijSSHty36R2j2aml0Sp2cRZJHR/EIfXBHpoigiit6Y8B
X-Gm-Message-State: AOJu0YxYP/sRuESwTbyRxycw0/w0w2gB9MzhqS6JaxQmKXXj5rPWTbvh
	cRne15Bx7YfasibKkWTYodrkFRhBfYTfRAEV/2cAZKyKM+X7xCOi
X-Google-Smtp-Source: AGHT+IEVkNT/oMKSvLbhS9cgvujyV/zT784K+0IKcT/y1kJRkEkJaYOe3YN3d7vketUroD3CXRVdkQ==
X-Received: by 2002:a05:6000:4023:b0:35f:305d:d2c8 with SMTP id ffacd0b85a97d-363192d0626mr135037f8f.3.1718730226708;
        Tue, 18 Jun 2024 10:03:46 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:9a30:967d:12af:741a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114dcfsm14526163f8f.114.2024.06.18.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:03:46 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 5/5] kunit: Merge assertion test into kunit-test.c
Date: Tue, 18 Jun 2024 18:03:31 +0100
Message-Id: <20240618170331.264851-6-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
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
V1 -> V2:
- Update considering the changes in the previous patch (use
kunit_assert_ prefixed functions)

 lib/kunit/Makefile      |   5 -
 lib/kunit/assert_test.c | 388 ----------------------------------------
 lib/kunit/kunit-test.c  | 379 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 378 insertions(+), 394 deletions(-)
 delete mode 100644 lib/kunit/assert_test.c

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 478beb536dc9..18e506b897a6 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -21,9 +21,4 @@ obj-y +=				hooks.o
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
index 4999233180d6..000000000000
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
-static void kunit_test_assert_is_literal(struct kunit *test)
-{
-	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("5", 5));
-	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("0", 0));
-	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("1234567890", 1234567890));
-	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("-1234567890", -1234567890));
-	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("05", 5));
-	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("", 0));
-	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("-0", 0));
-	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("12#45", 1245));
-}
-
-static void kunit_test_assert_is_str_literal(struct kunit *test)
-{
-	KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"Hello, World!\"", "Hello, World!"));
-	KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"", ""));
-	KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"\"", "\""));
-	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("", ""));
-	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"", "\""));
-	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba", "Abacaba"));
-	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("Abacaba\"", "Abacaba"));
-	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba\"", "\"Abacaba\""));
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
-	KUNIT_CASE(kunit_test_assert_is_literal),
-	KUNIT_CASE(kunit_test_assert_is_str_literal),
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
index d86f7cb3b3e4..71a3edde2ff4 100644
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
+static void kunit_test_assert_is_literal(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("5", 5));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("0", 0));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("1234567890", 1234567890));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("-1234567890", -1234567890));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("05", 5));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("", 0));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("-0", 0));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("12#45", 1245));
+}
+
+static void kunit_test_assert_is_str_literal(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"Hello, World!\"", "Hello, World!"));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"", ""));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"\"", "\""));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("", ""));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"", "\""));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba", "Abacaba"));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("Abacaba\"", "Abacaba"));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba\"", "\"Abacaba\""));
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
+	KUNIT_CASE(kunit_test_assert_is_literal),
+	KUNIT_CASE(kunit_test_assert_is_str_literal),
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
 
 MODULE_DESCRIPTION("KUnit test for core test infrastructure");
 MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
-- 
2.34.1


