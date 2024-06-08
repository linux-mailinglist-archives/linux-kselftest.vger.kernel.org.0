Return-Path: <linux-kselftest+bounces-11491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C509F90111E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5761E282F9F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839617838A;
	Sat,  8 Jun 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+4NLjMV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05E178384
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Jun 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838454; cv=none; b=HxzO8zfHkc/u2KCumP4XMhxuaW4KMVjqeckI3WIwGIpQQ+FFz6f+ZVsVxfFFrUAl0KssDhCdOUJYWq8K3p6b9cDf0UzbM7gwssYeGdRHZVQ5W3iElqKWj2gyLRXvzuiyEzcZCcRnICV5qRRXnGkxbGuLtY6XUaDaztSvWtOCu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838454; c=relaxed/simple;
	bh=H+0M5zrk67VBi6Mk9Yk4GhMA05ZVT1NRtwp5wdMZBsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xacy7hK4vTxLgiLQJmH2haTr0EgZEGOm8g8GS87r9UneBk3bSViEcF0nBA9GuSr9U8BKk8UlkK/nCI01653bRNT4QEADdmrDIWmCYQpxFUl1cZwR3WBkS0TN4iIR81jrljDxVKvwluzDvP3uaK39+cdMjnKBMkJRumVqVlIPvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+4NLjMV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44056f72257so149801cf.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Jun 2024 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717838451; x=1718443251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azACAz8xmgEqYxc6cW31XEqpn/pNRhVCEXQTdEdalhU=;
        b=Y+4NLjMVd8xcOXHe4UfEyd/FcuCpvSVa6HjZSx2YOL0K1AUOz7K16tsITQIX+ev3JA
         OQdEKzEb6Obou0gu92ix2NIMRnrFh60lNUQk+IdJl6d/+JLEEtD3AulppWSbROYb/Edk
         cA5RuAq8z8ZlMliQ1eOjk3WC427sD0DK/gH3HAzlYmgzBG2/MkrZO48weRrIzlhkuPN7
         B3Wam1iAkTWJ2dZbkm3mBYi5o71uzkp/vw6URVEnDgLdkw5wa00w6sFF4yTs0Dqk2uN4
         N3U4GS04P616q8nPI3eEw03XVIDdeJprPIQoJDpS4D3HcGrrVEfCjJo4eMs8PkppPgOM
         o4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717838451; x=1718443251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azACAz8xmgEqYxc6cW31XEqpn/pNRhVCEXQTdEdalhU=;
        b=QxUAWDgRH/507szhN9/irLpe6HgBGctagFeBP/VnCd8LcqJEaYYOZRCxLijzghau9t
         WfShd6himTcMujVkO8xhpzWU615HyyM9JMsjAGPiscYUhmY7I4IKmo07E8UtzPmp/UCm
         zJeZDdOjKFa7UxpRGYGDRlaAGdZ4srVKNVnsku+JiSY4sXcZtPfcSS5qF4sPk9XuqKmb
         0wBzCCgs2Ehh4427FhDNoAO2wMZf4/kUQFb3nNJh/IwWDm9GSKt57WLGEnMtDMblio/g
         xu+/j03TcCvruDnRSgL7x7g+JR9yLpNk9Q3zp/1gceaovh0X6BFs3XX7LD+jZ3jAeRiD
         H+nA==
X-Forwarded-Encrypted: i=1; AJvYcCU/9D3tqTCN5Bf5kV9BDUZe88NHfMSiv5xQ6RtWaP77JCmJIh2BQz+SMI/hUMqqTG1n+vMRipwvNUH+tsM6xRODdt4SpkLEe8IIgbJlZF4r
X-Gm-Message-State: AOJu0YwEhorb6oxk2d4PIhMlPqDXJxKq5Mx3hBE344XlNQm/jParWkOl
	d0sfOipLQZGoCMti6u3Hh9SEcE/WVCiWUiT+AIFlv6bZJOd1URuY2ugk62iHbXOxBZy30Zra6HH
	Yl1I8LaTIE5kaVrWzjaqcBZpiT3ZGaHYYrrTV
X-Google-Smtp-Source: AGHT+IFSnIpSZ4g63rxJZna9HGk8Q9zFN4hlddiwmddTHoIX3AfvBKYnVoJRmpk5g/4VvEgym3nN7qaDZ+9ndiylyoY=
X-Received: by 2002:a05:622a:4d4e:b0:440:416a:5aa9 with SMTP id
 d75a77b69052e-4405647f206mr2414011cf.20.1717838450432; Sat, 08 Jun 2024
 02:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com> <20240604123204.10412-6-ivan.orlov0322@gmail.com>
In-Reply-To: <20240604123204.10412-6-ivan.orlov0322@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Jun 2024 17:20:38 +0800
Message-ID: <CABVgOSkc+t0J2tbgRHnsao9mhhDDKcjp+62R+F_fUQv7aBvTbA@mail.gmail.com>
Subject: Re: [PATCH 5/5] kunit: Merge assertion test into kunit-test.c
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a8b990061a5d6e3a"

--000000000000a8b990061a5d6e3a
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 20:32, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>
> Since assert_test covers the part of the KUnit core (the assertion
> formatting functions), I believe it would be better to have it merged
> into kunit-test (as it is done for other tests for the KUnit core).
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

Personally, I don't mind if the assert tests are in a separate file,
but do think it's worth having them in the same module.

Do you think it'd be better to keep them as separate source files (but
put them in the same module via the Makefile), or is having a single
source file cleaner?

Either way, I think this should be merged with the previous patch (see
my comments there.)

Cheers,
-- David


>  lib/kunit/Makefile      |   5 -
>  lib/kunit/assert_test.c | 388 ----------------------------------------
>  lib/kunit/kunit-test.c  | 379 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 378 insertions(+), 394 deletions(-)
>  delete mode 100644 lib/kunit/assert_test.c
>
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 4793a3960f07..f41d2eab1f8d 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -20,9 +20,4 @@ obj-y +=                              hooks.o
>  obj-$(CONFIG_KUNIT_TEST) +=            kunit-test.o
>  obj-$(CONFIG_KUNIT_STRING_STREAM_TEST) += string-stream-test.o
>
> -# string-stream-test compiles built-in only.
> -ifeq ($(CONFIG_KUNIT_TEST),y)
> -obj-$(CONFIG_KUNIT_TEST) +=            assert_test.o
> -endif
> -
>  obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=    kunit-example-test.o
> diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
> deleted file mode 100644
> index 4a5967712186..000000000000
> --- a/lib/kunit/assert_test.c
> +++ /dev/null
> @@ -1,388 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * KUnit test for the assertion formatting functions.
> - * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
> - */
> -#include <kunit/test.h>
> -#include "string-stream.h"
> -
> -#define TEST_PTR_EXPECTED_BUF_SIZE 32
> -#define HEXDUMP_TEST_BUF_LEN 5
> -#define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(test, strstr(str, substr))
> -#define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALSE(test, strstr(str, substr))
> -
> -static void kunit_test_is_literal(struct kunit *test)
> -{
> -       KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
> -       KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
> -       KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
> -       KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890));
> -       KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
> -       KUNIT_EXPECT_FALSE(test, is_literal("", 0));
> -       KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
> -       KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
> -}
> -
> -static void kunit_test_is_str_literal(struct kunit *test)
> -{
> -       KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hello, World!"));
> -       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
> -       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba\""));
> -}
> -
> -KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
> -
> -/* this function is used to get a "char *" string from the string stream and defer its cleanup  */
> -static char *get_str_from_stream(struct kunit *test, struct string_stream *stream)
> -{
> -       char *str = string_stream_get_string(stream);
> -
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
> -       kunit_add_action(test, kfree_wrapper, (void *)str);
> -
> -       return str;
> -}
> -
> -static void kunit_test_assert_prologue(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       char *str;
> -       const struct kunit_loc location = {
> -               .file = "testfile.c",
> -               .line = 1337,
> -       };
> -
> -       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       /* Test an expectation fail prologue */
> -       kunit_assert_prologue(&location, KUNIT_EXPECTATION, stream);
> -       str = get_str_from_stream(test, stream);
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "EXPECTATION");
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> -
> -       /* Test an assertion fail prologue */
> -       string_stream_clear(stream);
> -       kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
> -       str = get_str_from_stream(test, stream);
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "ASSERTION");
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> -       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> -}
> -
> -/*
> - * This function accepts an arbitrary count of parameters and generates a va_format struct,
> - * which can be used to validate kunit_assert_print_msg function
> - */
> -static void verify_assert_print_msg(struct kunit *test,
> -                                   struct string_stream *stream,
> -                                   char *expected, const char *format, ...)
> -{
> -       va_list list;
> -       const struct va_format vformat = {
> -               .fmt = format,
> -               .va = &list,
> -       };
> -
> -       va_start(list, format);
> -       string_stream_clear(stream);
> -       kunit_assert_print_msg(&vformat, stream);
> -       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expected);
> -}
> -
> -static void kunit_test_assert_print_msg(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -
> -       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       verify_assert_print_msg(test, stream, "\nTest", "Test");
> -       verify_assert_print_msg(test, stream, "\nAbacaba -123 234", "%s %d %u",
> -                               "Abacaba", -123, 234U);
> -       verify_assert_print_msg(test, stream, "", NULL);
> -}
> -
> -/*
> - * Further code contains the tests for different assert format functions.
> - * This helper function accepts the assert format function, executes it and
> - * validates the result string from the stream by checking that all of the
> - * substrings exist in the output.
> - */
> -static void validate_assert(assert_format_t format_func, struct kunit *test,
> -                           const struct kunit_assert *assert,
> -                           struct string_stream *stream, int num_checks, ...)
> -{
> -       size_t i;
> -       va_list checks;
> -       char *cur_substr_exp;
> -       struct va_format message = { NULL, NULL };
> -
> -       va_start(checks, num_checks);
> -       string_stream_clear(stream);
> -       format_func(assert, &message, stream);
> -
> -       for (i = 0; i < num_checks; i++) {
> -               cur_substr_exp = va_arg(checks, char *);
> -               ASSERT_TEST_EXPECT_CONTAIN(test, get_str_from_stream(test, stream), cur_substr_exp);
> -       }
> -}
> -
> -static void kunit_test_unary_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert = {};
> -       struct kunit_unary_assert un_assert = {
> -               .assert = assert,
> -               .condition = "expr",
> -               .expected_true = true,
> -       };
> -
> -       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       validate_assert(kunit_unary_assert_format, test, &un_assert.assert,
> -                       stream, 2, "true", "is false");
> -
> -       un_assert.expected_true = false;
> -       validate_assert(kunit_unary_assert_format, test, &un_assert.assert,
> -                       stream, 2, "false", "is true");
> -}
> -
> -static void kunit_test_ptr_not_err_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert = {};
> -       struct kunit_ptr_not_err_assert not_err_assert = {
> -               .assert = assert,
> -               .text = "expr",
> -               .value = NULL,
> -       };
> -
> -       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       /* Value is NULL. The corresponding message should be printed out */
> -       validate_assert(kunit_ptr_not_err_assert_format, test,
> -                       &not_err_assert.assert,
> -                       stream, 1, "null");
> -
> -       /* Value is not NULL, but looks like an error pointer. Error should be printed out */
> -       not_err_assert.value = (void *)-12;
> -       validate_assert(kunit_ptr_not_err_assert_format, test,
> -                       &not_err_assert.assert, stream, 2,
> -                       "error", "-12");
> -}
> -
> -static void kunit_test_binary_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert = {};
> -       struct kunit_binary_assert_text text = {
> -               .left_text = "1 + 2",
> -               .operation = "==",
> -               .right_text = "2",
> -       };
> -       const struct kunit_binary_assert binary_assert = {
> -               .assert = assert,
> -               .text = &text,
> -               .left_value = 3,
> -               .right_value = 2,
> -       };
> -
> -       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       /*
> -        * Printed values should depend on the input we provide: the left text, right text, left
> -        * value and the right value.
> -        */
> -       validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
> -                       stream, 4, "1 + 2", "2", "3", "==");
> -
> -       text.right_text = "4 - 2";
> -       validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
> -                       stream, 3, "==", "1 + 2", "4 - 2");
> -
> -       text.left_text = "3";
> -       validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
> -                       stream, 4, "3", "4 - 2", "2", "==");
> -
> -       text.right_text = "2";
> -       validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
> -                       stream, 3, "3", "2", "==");
> -}
> -
> -static void kunit_test_binary_ptr_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert = {};
> -       char *addr_var_a, *addr_var_b;
> -       static const void *var_a = (void *)0xDEADBEEF;
> -       static const void *var_b = (void *)0xBADDCAFE;
> -       struct kunit_binary_assert_text text = {
> -               .left_text = "var_a",
> -               .operation = "==",
> -               .right_text = "var_b",
> -       };
> -       struct kunit_binary_ptr_assert binary_ptr_assert = {
> -               .assert = assert,
> -               .text = &text,
> -               .left_value = var_a,
> -               .right_value = var_b,
> -       };
> -
> -       addr_var_a = kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_a);
> -       addr_var_b = kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_b);
> -       /*
> -        * Print the addresses to the buffers first.
> -        * This is necessary as we may have different count of leading zeros in the pointer
> -        * on different architectures.
> -        */
> -       snprintf(addr_var_a, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_a);
> -       snprintf(addr_var_b, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_b);
> -
> -       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -       validate_assert(kunit_binary_ptr_assert_format, test, &binary_ptr_assert.assert,
> -                       stream, 3, addr_var_a, addr_var_b, "==");
> -}
> -
> -static void kunit_test_binary_str_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct kunit_assert assert = {};
> -       static const char *var_a = "abacaba";
> -       static const char *var_b = "kernel";
> -       struct kunit_binary_assert_text text = {
> -               .left_text = "var_a",
> -               .operation = "==",
> -               .right_text = "var_b",
> -       };
> -       struct kunit_binary_str_assert binary_str_assert = {
> -               .assert = assert,
> -               .text = &text,
> -               .left_value = var_a,
> -               .right_value = var_b,
> -       };
> -
> -       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       validate_assert(kunit_binary_str_assert_format, test,
> -                       &binary_str_assert.assert,
> -                       stream, 5, "var_a", "var_b", "\"abacaba\"",
> -                       "\"kernel\"", "==");
> -
> -       text.left_text = "\"abacaba\"";
> -       validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
> -                       stream, 4, "\"abacaba\"", "var_b", "\"kernel\"", "==");
> -
> -       text.right_text = "\"kernel\"";
> -       validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
> -                       stream, 3, "\"abacaba\"", "\"kernel\"", "==");
> -}
> -
> -static const u8 hex_testbuf1[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> -                                  0x45, 0x9d, 0x47, 0xd6, 0x47,
> -                                  0x2,  0x89, 0x8c, 0x81, 0x94,
> -                                  0x12, 0xfe, 0x01 };
> -static const u8 hex_testbuf2[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> -                                  0x45, 0x9d, 0x47, 0x21, 0x47,
> -                                  0xcd, 0x89, 0x24, 0x50, 0x94,
> -                                  0x12, 0xba, 0x01 };
> -static void kunit_test_assert_hexdump(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       char *str;
> -       size_t i;
> -       char buf[HEXDUMP_TEST_BUF_LEN];
> -
> -       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -       /* Check that we are getting output like <xx> for non-matching numbers. */
> -       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf2, sizeof(hex_testbuf1));
> -       str = get_str_from_stream(test, stream);
> -       for (i = 0; i < sizeof(hex_testbuf1); i++) {
> -               snprintf(buf, HEXDUMP_TEST_BUF_LEN, "<%02x>", hex_testbuf1[i]);
> -               if (hex_testbuf1[i] != hex_testbuf2[i])
> -                       ASSERT_TEST_EXPECT_CONTAIN(test, str, buf);
> -       }
> -       /* We shouldn't get any <xx> numbers when comparing the buffer with itself. */
> -       string_stream_clear(stream);
> -       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf1, sizeof(hex_testbuf1));
> -       str = get_str_from_stream(test, stream);
> -       ASSERT_TEST_EXPECT_NCONTAIN(test, str, "<");
> -       ASSERT_TEST_EXPECT_NCONTAIN(test, str, ">");
> -}
> -
> -static void kunit_test_mem_assert_format(struct kunit *test)
> -{
> -       struct string_stream *stream;
> -       struct string_stream *expected_stream;
> -       struct kunit_assert assert = {};
> -       static const struct kunit_binary_assert_text text = {
> -               .left_text = "hex_testbuf1",
> -               .operation = "==",
> -               .right_text = "hex_testbuf2",
> -       };
> -       struct kunit_mem_assert mem_assert = {
> -               .assert = assert,
> -               .text = &text,
> -               .left_value = NULL,
> -               .right_value = hex_testbuf2,
> -               .size = sizeof(hex_testbuf1),
> -       };
> -
> -       expected_stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_stream);
> -       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> -
> -       /* The left value is NULL */
> -       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
> -                       stream, 2, "hex_testbuf1", "is not null");
> -
> -       /* The right value is NULL, the left value is not NULL */
> -       mem_assert.left_value = hex_testbuf1;
> -       mem_assert.right_value = NULL;
> -       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
> -                       stream, 2, "hex_testbuf2", "is not null");
> -
> -       /* Both arguments are not null */
> -       mem_assert.left_value = hex_testbuf1;
> -       mem_assert.right_value = hex_testbuf2;
> -
> -       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
> -                       stream, 3, "hex_testbuf1", "hex_testbuf2", "==");
> -}
> -
> -static struct kunit_case assert_test_cases[] = {
> -       KUNIT_CASE(kunit_test_is_literal),
> -       KUNIT_CASE(kunit_test_is_str_literal),
> -       KUNIT_CASE(kunit_test_assert_prologue),
> -       KUNIT_CASE(kunit_test_assert_print_msg),
> -       KUNIT_CASE(kunit_test_unary_assert_format),
> -       KUNIT_CASE(kunit_test_ptr_not_err_assert_format),
> -       KUNIT_CASE(kunit_test_binary_assert_format),
> -       KUNIT_CASE(kunit_test_binary_ptr_assert_format),
> -       KUNIT_CASE(kunit_test_binary_str_assert_format),
> -       KUNIT_CASE(kunit_test_assert_hexdump),
> -       KUNIT_CASE(kunit_test_mem_assert_format),
> -       {}
> -};
> -
> -static struct kunit_suite assert_test_suite = {
> -       .name = "kunit-assert",
> -       .test_cases = assert_test_cases,
> -};
> -
> -kunit_test_suites(&assert_test_suite);
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 42178d5a97d1..efba189442c2 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -849,10 +849,387 @@ static struct kunit_suite kunit_current_test_suite = {
>         .test_cases = kunit_current_test_cases,
>  };
>
> +#define TEST_PTR_EXPECTED_BUF_SIZE 32
> +#define HEXDUMP_TEST_BUF_LEN 5
> +#define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(test, strstr(str, substr))
> +#define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALSE(test, strstr(str, substr))
> +
> +static void kunit_test_is_literal(struct kunit *test)
> +{
> +       KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
> +       KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
> +       KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
> +       KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890));
> +       KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
> +       KUNIT_EXPECT_FALSE(test, is_literal("", 0));
> +       KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
> +       KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
> +}
> +
> +static void kunit_test_is_str_literal(struct kunit *test)
> +{
> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hello, World!"));
> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba\""));
> +}
> +
> +/* this function is used to get a "char *" string from the string stream and defer its cleanup  */
> +static char *get_str_from_stream(struct kunit *test, struct string_stream *stream)
> +{
> +       char *str = string_stream_get_string(stream);
> +
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
> +       kunit_add_action(test, kfree_wrapper, (void *)str);
> +
> +       return str;
> +}
> +
> +static void kunit_test_assert_prologue(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       char *str;
> +       const struct kunit_loc location = {
> +               .file = "testfile.c",
> +               .line = 1337,
> +       };
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Test an expectation fail prologue */
> +       kunit_assert_prologue(&location, KUNIT_EXPECTATION, stream);
> +       str = get_str_from_stream(test, stream);
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "EXPECTATION");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> +
> +       /* Test an assertion fail prologue */
> +       string_stream_clear(stream);
> +       kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
> +       str = get_str_from_stream(test, stream);
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "ASSERTION");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "testfile.c");
> +       ASSERT_TEST_EXPECT_CONTAIN(test, str, "1337");
> +}
> +
> +/*
> + * This function accepts an arbitrary count of parameters and generates a va_format struct,
> + * which can be used to validate kunit_assert_print_msg function
> + */
> +static void verify_assert_print_msg(struct kunit *test,
> +                                   struct string_stream *stream,
> +                                   char *expected, const char *format, ...)
> +{
> +       va_list list;
> +       const struct va_format vformat = {
> +               .fmt = format,
> +               .va = &list,
> +       };
> +
> +       va_start(list, format);
> +       string_stream_clear(stream);
> +       kunit_assert_print_msg(&vformat, stream);
> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expected);
> +}
> +
> +static void kunit_test_assert_print_msg(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       verify_assert_print_msg(test, stream, "\nTest", "Test");
> +       verify_assert_print_msg(test, stream, "\nAbacaba -123 234", "%s %d %u",
> +                               "Abacaba", -123, 234U);
> +       verify_assert_print_msg(test, stream, "", NULL);
> +}
> +
> +/*
> + * Further code contains the tests for different assert format functions.
> + * This helper function accepts the assert format function, executes it and
> + * validates the result string from the stream by checking that all of the
> + * substrings exist in the output.
> + */
> +static void validate_assert(assert_format_t format_func, struct kunit *test,
> +                           const struct kunit_assert *assert,
> +                           struct string_stream *stream, int num_checks, ...)
> +{
> +       size_t i;
> +       va_list checks;
> +       char *cur_substr_exp;
> +       struct va_format message = { NULL, NULL };
> +
> +       va_start(checks, num_checks);
> +       string_stream_clear(stream);
> +       format_func(assert, &message, stream);
> +
> +       for (i = 0; i < num_checks; i++) {
> +               cur_substr_exp = va_arg(checks, char *);
> +               ASSERT_TEST_EXPECT_CONTAIN(test, get_str_from_stream(test, stream), cur_substr_exp);
> +       }
> +}
> +
> +static void kunit_test_unary_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert = {};
> +       struct kunit_unary_assert un_assert = {
> +               .assert = assert,
> +               .condition = "expr",
> +               .expected_true = true,
> +       };
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       validate_assert(kunit_unary_assert_format, test, &un_assert.assert,
> +                       stream, 2, "true", "is false");
> +
> +       un_assert.expected_true = false;
> +       validate_assert(kunit_unary_assert_format, test, &un_assert.assert,
> +                       stream, 2, "false", "is true");
> +}
> +
> +static void kunit_test_ptr_not_err_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert = {};
> +       struct kunit_ptr_not_err_assert not_err_assert = {
> +               .assert = assert,
> +               .text = "expr",
> +               .value = NULL,
> +       };
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Value is NULL. The corresponding message should be printed out */
> +       validate_assert(kunit_ptr_not_err_assert_format, test,
> +                       &not_err_assert.assert,
> +                       stream, 1, "null");
> +
> +       /* Value is not NULL, but looks like an error pointer. Error should be printed out */
> +       not_err_assert.value = (void *)-12;
> +       validate_assert(kunit_ptr_not_err_assert_format, test,
> +                       &not_err_assert.assert, stream, 2,
> +                       "error", "-12");
> +}
> +
> +static void kunit_test_binary_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert = {};
> +       struct kunit_binary_assert_text text = {
> +               .left_text = "1 + 2",
> +               .operation = "==",
> +               .right_text = "2",
> +       };
> +       const struct kunit_binary_assert binary_assert = {
> +               .assert = assert,
> +               .text = &text,
> +               .left_value = 3,
> +               .right_value = 2,
> +       };
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /*
> +        * Printed values should depend on the input we provide: the left text, right text, left
> +        * value and the right value.
> +        */
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
> +                       stream, 4, "1 + 2", "2", "3", "==");
> +
> +       text.right_text = "4 - 2";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
> +                       stream, 3, "==", "1 + 2", "4 - 2");
> +
> +       text.left_text = "3";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
> +                       stream, 4, "3", "4 - 2", "2", "==");
> +
> +       text.right_text = "2";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.assert,
> +                       stream, 3, "3", "2", "==");
> +}
> +
> +static void kunit_test_binary_ptr_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert = {};
> +       char *addr_var_a, *addr_var_b;
> +       static const void *var_a = (void *)0xDEADBEEF;
> +       static const void *var_b = (void *)0xBADDCAFE;
> +       struct kunit_binary_assert_text text = {
> +               .left_text = "var_a",
> +               .operation = "==",
> +               .right_text = "var_b",
> +       };
> +       struct kunit_binary_ptr_assert binary_ptr_assert = {
> +               .assert = assert,
> +               .text = &text,
> +               .left_value = var_a,
> +               .right_value = var_b,
> +       };
> +
> +       addr_var_a = kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_a);
> +       addr_var_b = kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addr_var_b);
> +       /*
> +        * Print the addresses to the buffers first.
> +        * This is necessary as we may have different count of leading zeros in the pointer
> +        * on different architectures.
> +        */
> +       snprintf(addr_var_a, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_a);
> +       snprintf(addr_var_b, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_b);
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       validate_assert(kunit_binary_ptr_assert_format, test, &binary_ptr_assert.assert,
> +                       stream, 3, addr_var_a, addr_var_b, "==");
> +}
> +
> +static void kunit_test_binary_str_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert = {};
> +       static const char *var_a = "abacaba";
> +       static const char *var_b = "kernel";
> +       struct kunit_binary_assert_text text = {
> +               .left_text = "var_a",
> +               .operation = "==",
> +               .right_text = "var_b",
> +       };
> +       struct kunit_binary_str_assert binary_str_assert = {
> +               .assert = assert,
> +               .text = &text,
> +               .left_value = var_a,
> +               .right_value = var_b,
> +       };
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       validate_assert(kunit_binary_str_assert_format, test,
> +                       &binary_str_assert.assert,
> +                       stream, 5, "var_a", "var_b", "\"abacaba\"",
> +                       "\"kernel\"", "==");
> +
> +       text.left_text = "\"abacaba\"";
> +       validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
> +                       stream, 4, "\"abacaba\"", "var_b", "\"kernel\"", "==");
> +
> +       text.right_text = "\"kernel\"";
> +       validate_assert(kunit_binary_str_assert_format, test, &binary_str_assert.assert,
> +                       stream, 3, "\"abacaba\"", "\"kernel\"", "==");
> +}
> +
> +static const u8 hex_testbuf1[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> +                                  0x45, 0x9d, 0x47, 0xd6, 0x47,
> +                                  0x2,  0x89, 0x8c, 0x81, 0x94,
> +                                  0x12, 0xfe, 0x01 };
> +static const u8 hex_testbuf2[] = { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> +                                  0x45, 0x9d, 0x47, 0x21, 0x47,
> +                                  0xcd, 0x89, 0x24, 0x50, 0x94,
> +                                  0x12, 0xba, 0x01 };
> +static void kunit_test_assert_hexdump(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       char *str;
> +       size_t i;
> +       char buf[HEXDUMP_TEST_BUF_LEN];
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       /* Check that we are getting output like <xx> for non-matching numbers. */
> +       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf2, sizeof(hex_testbuf1));
> +       str = get_str_from_stream(test, stream);
> +       for (i = 0; i < sizeof(hex_testbuf1); i++) {
> +               snprintf(buf, HEXDUMP_TEST_BUF_LEN, "<%02x>", hex_testbuf1[i]);
> +               if (hex_testbuf1[i] != hex_testbuf2[i])
> +                       ASSERT_TEST_EXPECT_CONTAIN(test, str, buf);
> +       }
> +       /* We shouldn't get any <xx> numbers when comparing the buffer with itself. */
> +       string_stream_clear(stream);
> +       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf1, sizeof(hex_testbuf1));
> +       str = get_str_from_stream(test, stream);
> +       ASSERT_TEST_EXPECT_NCONTAIN(test, str, "<");
> +       ASSERT_TEST_EXPECT_NCONTAIN(test, str, ">");
> +}
> +
> +static void kunit_test_mem_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct string_stream *expected_stream;
> +       struct kunit_assert assert = {};
> +       static const struct kunit_binary_assert_text text = {
> +               .left_text = "hex_testbuf1",
> +               .operation = "==",
> +               .right_text = "hex_testbuf2",
> +       };
> +       struct kunit_mem_assert mem_assert = {
> +               .assert = assert,
> +               .text = &text,
> +               .left_value = NULL,
> +               .right_value = hex_testbuf2,
> +               .size = sizeof(hex_testbuf1),
> +       };
> +
> +       expected_stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_stream);
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* The left value is NULL */
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
> +                       stream, 2, "hex_testbuf1", "is not null");
> +
> +       /* The right value is NULL, the left value is not NULL */
> +       mem_assert.left_value = hex_testbuf1;
> +       mem_assert.right_value = NULL;
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
> +                       stream, 2, "hex_testbuf2", "is not null");
> +
> +       /* Both arguments are not null */
> +       mem_assert.left_value = hex_testbuf1;
> +       mem_assert.right_value = hex_testbuf2;
> +
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert,
> +                       stream, 3, "hex_testbuf1", "hex_testbuf2", "==");
> +}
> +
> +static struct kunit_case kunit_assert_test_cases[] = {
> +       KUNIT_CASE(kunit_test_is_literal),
> +       KUNIT_CASE(kunit_test_is_str_literal),
> +       KUNIT_CASE(kunit_test_assert_prologue),
> +       KUNIT_CASE(kunit_test_assert_print_msg),
> +       KUNIT_CASE(kunit_test_unary_assert_format),
> +       KUNIT_CASE(kunit_test_ptr_not_err_assert_format),
> +       KUNIT_CASE(kunit_test_binary_assert_format),
> +       KUNIT_CASE(kunit_test_binary_ptr_assert_format),
> +       KUNIT_CASE(kunit_test_binary_str_assert_format),
> +       KUNIT_CASE(kunit_test_assert_hexdump),
> +       KUNIT_CASE(kunit_test_mem_assert_format),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_assert_test_suite = {
> +       .name = "kunit-assert",
> +       .test_cases = kunit_assert_test_cases,
> +};
> +
>  kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
>                   &kunit_log_test_suite, &kunit_status_test_suite,
>                   &kunit_current_test_suite, &kunit_device_test_suite,
> -                 &kunit_fault_test_suite);
> +                 &kunit_fault_test_suite, &kunit_assert_test_suite);
>
>  MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
>  MODULE_LICENSE("GPL v2");
> --
> 2.34.1
>

--000000000000a8b990061a5d6e3a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIP7D+TdVWOxMH34XxqFNg1l0oiexuGln1KgF5of8MUBqMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwODA5MjA1MVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAGLm+2
+vC+5LIykb1nqp6X8bWsMRJe/MqVEFfeWsHIFxM7aRPHdBVt+dy7wQoAvYEA9Ujzysmn3KeXZrGn
ADBS27dazaKJp6HSmd8zeGQzAWUl3dj6+nCCVuXY9oi5+F+aDQKF6ll42mNbzGZFxOMKNly6Ziwt
f3YI4+2sZs/Z4J7rOGOHQUq3ZKhhAmBXl6Kwc9B233lAf8YpDvDwRcjcq+3zCXvZd+cFXHlXrHqX
511UPfjLF5DRXN6Ob7hntFywhPvWgcriBF4R4hEgdVcZA8nNpj6n9ak9bXEzz62joCFzxq57SYbn
A9H/XWaeF/ytNOD5Dx7Zfr7LTWgnNl4s
--000000000000a8b990061a5d6e3a--

