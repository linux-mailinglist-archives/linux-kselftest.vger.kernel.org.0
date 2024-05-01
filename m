Return-Path: <linux-kselftest+bounces-9250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841C8B9231
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 01:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABE41C20FDC
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF17168AE4;
	Wed,  1 May 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2nRTaKV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B95165FAA
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605630; cv=none; b=PoSDgjS908RNQiZ1SQrlrRMUgTO3b/Lfgla5Q9D1mwvCideOTSpCi6a4Ra7zqgAjngKOXB2sC5Aev+fuHQ96Z2lcJbC7nqe7YrvAKzzZsskw+n1nla9ByOlr9DyWguef18JojZbcjqTdf16BitJnmXaF5PNkokO04upjlZ6TQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605630; c=relaxed/simple;
	bh=FfAcT60OTZxrBXU3XMCh/Q74J34rQBTTiJHoUDtHV8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vv9WID615RYIQMxOrKP3cOJEz6PQ4WGUDSrb14AT/KTmfQhc4CSVj5uzTgz/a95V9udloUUug4q5ebaLiPynqAEQvuyY6gc3mVRHElPVuymu3ZuKetKD//kvZrtZ1o08X71EUHG7/WNje2FxOo9dmNdxEhvFfUkcmiRSa5C9TjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2nRTaKV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-439b1c72676so101071cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605627; x=1715210427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEZkxkwhgtTx0NvMGLlLrfli5x/gWfMQKijcqUJLPFQ=;
        b=k2nRTaKVIKvzonrXWhci7dJm6ktesNNGz4wgEgtowcnevdY1LU/LUijlGV17Ctlqei
         xNrbc0WfP/c/EErZPzAlaaC/LvZ3m+f2+IxMEl94WA4jtt4VCv/njJr5cmCMbFlgVJBo
         +6nfDOfHpE7u7ZrMXBySZOVdzAhEusfYhBL370fEOp38ocpI2oQODFSpi9wzDm5UWRmW
         tuKf4Nsb91Zd8YJk2Ui9HkzOhETyRsxKEHZNcZAoL9isSBOITIAfmUEm1VUNJ9bQApfi
         1evM7cR5DlOs0KMQ7LGkfJdCNmLk1jW8ZnC91JKdnm7aSTsdpoZykYPpNHsiZklgRg1o
         BySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605627; x=1715210427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEZkxkwhgtTx0NvMGLlLrfli5x/gWfMQKijcqUJLPFQ=;
        b=Tl++Xe7qrCHy4xAvTK1atmJ+IaDOs+0ZZSr/pioL7TTQ44fNOgLtoyCUhY9GY0uwn3
         ot9uNSqUHDeQ2X8B4ysp3HVzYU8vqPi1JuTQfx5hNIDmBDcTnhv9MFc9bTkfDRCqO5vc
         VEp+gxSfxgqQxfaR6iPkIm8uJUONHGBzSIK69T3wugWcFM9iNrSp5R8VjQaxCGigOXZn
         NqsWaLWRc5jL/OWBAG5vp04A22X4wnvrF/5lcx4JlXy3WLnyy7RIwVpXINO/5t0JQzn9
         U46rBAPD3grsZ3e1CEzVZQthlZajXx7uaX4kEsCn22/P/GUp9xqyuI6alN2z5G0vFutM
         Omzg==
X-Forwarded-Encrypted: i=1; AJvYcCXsT9yMAIUyM8xl7/5WaGBE2HWlrZMFhprh+RF3AhgVoG+SDbn4dvuNnt2j5IRIukL36h2v9WraY0DoD0epSzGKWjoafKI/PD3yfJwCYWB0
X-Gm-Message-State: AOJu0YyfL3fQLrWbLmOn7d+q+zvqYRBYePUCcIOnEgNaCLwFlrIaWNJZ
	Dlbr1rYSQQHEdkHbVBDUXJkAatO/eZH2GtUzV3DIF5wtSGiuH+DuKWS0PTCzxotCzeQPy85r7Vg
	i5tnbyB+0/6bz5tEag6oGqg8XXBmP92YoOBdH
X-Google-Smtp-Source: AGHT+IEgnMKaoYgG0vEpOJgibOlFzONd4YstkWvtt23P9GBQeWq7rYRdpy7NJUA6v7Bn79CAQOFu4/g8djuuG9QwlhU=
X-Received: by 2002:ac8:7f03:0:b0:437:99d8:ea6e with SMTP id
 d75a77b69052e-43ca9f44792mr1211571cf.2.1714605626818; Wed, 01 May 2024
 16:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427220447.231475-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20240427220447.231475-1-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 1 May 2024 19:20:13 -0400
Message-ID: <CA+GJov45uEfrXVWSUxvzOLYKPCnTeYeGqHvk=W4n-W_TLYyRuQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Cover 'assert.c' with tests
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 6:04=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> There are multiple assertion formatting functions in the `assert.c`
> file, which are not covered with tests yet. Implement the KUnit test
> for these functions.
>
> The test consists of 11 test cases for the following functions:
>
> 1) 'is_literal'
> 2) 'is_str_literal'
> 3) 'kunit_assert_prologue', test case for multiple assert types
> 4) 'kunit_assert_print_msg'
> 5) 'kunit_unary_assert_format'
> 6) 'kunit_ptr_not_err_assert_format'
> 7) 'kunit_binary_assert_format'
> 8) 'kunit_binary_ptr_assert_format'
> 9) 'kunit_binary_str_assert_format'
> 10) 'kunit_assert_hexdump'
> 11) 'kunit_mem_assert_format'
>
> The test aims at maximizing the branch coverage for the assertion
> formatting functions. As you can see, it covers some of the static
> helper functions as well, so we have to import the test source in the
> `assert.c` file in order to be able to call and validate them.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hello!

This is a great patch and addition of KUnit tests. Happy to see it.
Thank you very much!

I do have a few comments below. But none of them are deal breakers.

Thanks!
-Rae

> ---
>  lib/kunit/assert.c      |   4 +
>  lib/kunit/assert_test.c | 416 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 420 insertions(+)
>  create mode 100644 lib/kunit/assert_test.c
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index dd1d633d0fe2..ab68c6daf546 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -270,3 +270,7 @@ void kunit_mem_assert_format(const struct kunit_asser=
t *assert,
>         }
>  }
>  EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
> +
> +#if IS_ENABLED(CONFIG_KUNIT_TEST)
> +#include "assert_test.c"
> +#endif

I might consider using the macro VISIBLE_IF_KUNIT macro, found in
include/kunit/visibility.h, to make the static functions in assert.c
visible only if KUnit is enabled. To avoid having to add the include
here. What do you think?

> diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
> new file mode 100644
> index 000000000000..d54841740761
> --- /dev/null
> +++ b/lib/kunit/assert_test.c
> @@ -0,0 +1,416 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * KUnit test for the assertion formatting functions.
> + * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
> + */
> +#include <kunit/test.h>
> +
> +#define TEST_PTR_EXPECTED_BUF_SIZE 128
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
> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hell=
o, World!"));
> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba=
\""));
> +}
> +
> +KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
> +
> +/* this function is used to get a "char *" string from the string stream=
 and defer its cleanup  */
> +static char *get_str_from_stream(struct kunit *test, struct string_strea=
m *stream)
> +{
> +       char *str =3D string_stream_get_string(stream);
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
> +       const struct kunit_loc location =3D {
> +               .file =3D "testfile.c",
> +               .line =3D 1337,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Test an expectation fail prologue */
> +       kunit_assert_prologue(&location, KUNIT_EXPECTATION, stream);
> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream),
> +                          "EXPECTATION FAILED at testfile.c:1337\n");
> +
> +       /* Test an assertion fail prologue */
> +       string_stream_clear(stream);
> +       kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream),
> +                          "ASSERTION FAILED at testfile.c:1337\n");

My one main concern with some of these tests is that they test for
exact matches to string error messages. I worry that these error
messages are likely to change over time, especially the indentation
and spacing of the messages. This applies more to some of the tests
below that check for the indentation.

I think it is most important that we test for the message containing
the correct information. Is there a way to instead check if the stream
contains each of a list of important information. So for example in
the test above, I think it is important to check the stream contains
the following strings: "ASSERTION" (maybe even not check for case),
"testfile.c",  "1337", and "\n" at the end of the stream.

This applies to the tests below as well. Although, I do see how it may
be difficult to change this. If there is a way to at least remove the
checks for indentation and any filler words that would be great.

> +}
> +
> +/*
> + * This function accepts an arbitrary count of parameters and generates =
a va_format struct,
> + * which can be used to validate kunit_assert_print_msg function
> + */
> +static void verify_assert_print_msg(struct kunit *test,
> +                                   struct string_stream *stream,
> +                                   char *expected, const char *format, .=
..)
> +{
> +       va_list list;
> +       const struct va_format vformat =3D {
> +               .fmt =3D format,
> +               .va =3D &list,
> +       };
> +
> +       va_start(list, format);
> +       string_stream_clear(stream);
> +       kunit_assert_print_msg(&vformat, stream);
> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expec=
ted);
> +}
> +
> +static void kunit_test_assert_print_msg(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       verify_assert_print_msg(test, stream, "\nTest", "Test");
> +       verify_assert_print_msg(test, stream, "\nAbacaba -123 234", "%s %=
d %u",
> +                               "Abacaba", -123, 234U);
> +       verify_assert_print_msg(test, stream, "", NULL);
> +}
> +
> +/*
> + * Further code contains the tests for different assert format functions=
.
> + * This helper function accepts the assert format function, executes it =
and
> + * validates the result string from the stream.
> + */
> +static void validate_assert(assert_format_t format_func, struct kunit *t=
est,
> +                           const struct kunit_assert *assert,
> +                           const char *expected, struct string_stream *s=
tream)
> +{
> +       struct va_format message =3D { NULL, NULL };
> +
> +       string_stream_clear(stream);
> +       format_func(assert, &message, stream);
> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), expec=
ted);
> +}
> +
> +static void kunit_test_unary_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       struct kunit_unary_assert un_assert =3D {
> +               .assert =3D assert,
> +               .condition =3D "expr",
> +               .expected_true =3D true,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       validate_assert(kunit_unary_assert_format, test, &un_assert.asser=
t,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected expr to be true, but is false\n",
> +                       stream);
> +
> +       un_assert.expected_true =3D false;
> +       validate_assert(kunit_unary_assert_format, test, &un_assert.asser=
t,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected expr to be false, but is true\n",
> +                       stream);
> +}
> +
> +static void kunit_test_ptr_not_err_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       struct kunit_ptr_not_err_assert not_err_assert =3D {
> +               .assert =3D assert,
> +               .text =3D "expr",
> +               .value =3D NULL,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Value is NULL. The corresponding message should be printed out=
 */
> +       validate_assert(kunit_ptr_not_err_assert_format, test,
> +                       &not_err_assert.assert,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected expr is not null, but is\n",
> +                       stream);
> +
> +       /* Value is not NULL, but looks like an error pointer. Error shou=
ld be printed out */
> +       not_err_assert.value =3D (void *)-12;
> +       validate_assert(kunit_ptr_not_err_assert_format, test,
> +                       &not_err_assert.assert,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected expr is not error, but is: -12\n",
> +                       stream);
> +}
> +
> +static void kunit_test_binary_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "1 + 2",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "2",
> +       };
> +       const struct kunit_binary_assert binary_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D 3,
> +               .right_value =3D 2,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /*
> +        * the right argument is "literal" (see test for `is_literal` abo=
ve),
> +        * so the right argument won't be printed out separately.
> +        */
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected 1 + 2 =3D=3D 2, but\n" KUNIT_SUBSUBTEST=
_INDENT
> +                       "1 + 2 =3D=3D 3 (0x3)\n",
> +                       stream);
> +
> +       /* Now both arguments are not "literal". They both will be printe=
d out separately  */
> +       text.right_text =3D "4 - 2";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected 1 + 2 =3D=3D 4 - 2, but\n" KUNIT_SUBSUB=
TEST_INDENT
> +                       "1 + 2 =3D=3D 3 (0x3)\n" KUNIT_SUBSUBTEST_INDENT
> +                       "4 - 2 =3D=3D 2 (0x2)",
> +                       stream);
> +
> +       /* Now the left argument is "literal", so it won't be printed out=
 */
> +       text.left_text =3D "3";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected 3 =3D=3D 4 - 2, but\n" KUNIT_SUBSUBTEST=
_INDENT
> +                       "4 - 2 =3D=3D 2 (0x2)",
> +                       stream);
> +
> +       /* The left and the right arguments are not "literal", so they wo=
n't be printed out */
> +       text.right_text =3D "2";
> +       validate_assert(kunit_binary_assert_format, test, &binary_assert.=
assert,
> +                       KUNIT_SUBTEST_INDENT "Expected 3 =3D=3D 2, but\n"=
, stream);
> +}
> +
> +static void kunit_test_binary_ptr_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       char *expected;
> +       static const void *var_a =3D (void *)0xDEADBEEF;
> +       static const void *var_b =3D (void *)0xBADDCAFE;
> +       struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "var_a",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "var_b",
> +       };
> +       struct kunit_binary_ptr_assert binary_ptr_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D var_a,
> +               .right_value =3D var_b,
> +       };
> +
> +       expected =3D kunit_kzalloc(test, TEST_PTR_EXPECTED_BUF_SIZE, GFP_=
KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected);
> +       /*
> +        * Print the expected string to the buffer first.
> +        * This is necessary as we may have different count of leading ze=
ros in the pointer
> +        * on different architectures.
> +        */
> +       snprintf(expected, TEST_PTR_EXPECTED_BUF_SIZE,
> +                KUNIT_SUBTEST_INDENT
> +                "Expected var_a =3D=3D var_b, but\n" KUNIT_SUBSUBTEST_IN=
DENT
> +                "var_a =3D=3D %px\n" KUNIT_SUBSUBTEST_INDENT "var_b =3D=
=3D %px",
> +                var_a, var_b);
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       validate_assert(kunit_binary_ptr_assert_format, test,
> +                       &binary_ptr_assert.assert, expected, stream);
> +}
> +
> +static void kunit_test_binary_str_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct kunit_assert assert =3D {};
> +       static const char *var_a =3D "abacaba";
> +       static const char *var_b =3D "kernel";
> +       struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "var_a",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "var_b",
> +       };
> +       struct kunit_binary_str_assert binary_str_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D var_a,
> +               .right_value =3D var_b,
> +       };
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Both arguments are not "string literals", so they should be pr=
inted separately */
> +       validate_assert(kunit_binary_str_assert_format, test,
> +                       &binary_str_assert.assert,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected var_a =3D=3D var_b, but\n" KUNIT_SUBSUB=
TEST_INDENT
> +                       "var_a =3D=3D \"abacaba\"\n" KUNIT_SUBSUBTEST_IND=
ENT
> +                       "var_b =3D=3D \"kernel\"",
> +                       stream);
> +
> +       /* Left argument is a "string literal", so it shouldn't be printe=
d separately */
> +       text.left_text =3D "\"abacaba\"";
> +       validate_assert(kunit_binary_str_assert_format, test, &binary_str=
_assert.assert,
> +                       KUNIT_SUBTEST_INDENT "Expected \"abacaba\" =3D=3D=
 var_b, but\n"
> +                       KUNIT_SUBSUBTEST_INDENT "var_b =3D=3D \"kernel\""=
, stream);
> +
> +       /* Both arguments are "string literals", so they shouldn't be pri=
nted separately */
> +       text.right_text =3D "\"kernel\"";
> +       validate_assert(kunit_binary_str_assert_format, test, &binary_str=
_assert.assert,
> +                       KUNIT_SUBTEST_INDENT "Expected \"abacaba\" =3D=3D=
 \"kernel\", but\n", stream);
> +}
> +
> +static const u8 hex_testbuf1[] =3D { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> +                                  0x45, 0x9d, 0x47, 0xd6, 0x47,
> +                                  0x1,  0x89, 0x8c, 0x81, 0x94,
> +                                  0x12, 0xfe, 0x01 };
> +static const u8 hex_testbuf2[] =3D { 0x26, 0x74, 0x6b, 0x9c, 0x55,
> +                                  0x45, 0x9d, 0x47, 0x21, 0x47,
> +                                  0xcd, 0x89, 0x24, 0x50, 0x94,
> +                                  0x12, 0xba, 0x01 };
> +static void kunit_test_assert_hexdump(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       /*
> +        * Check that we are getting numbers like <xx> on the right place=
s.
> +        * Also check that we get a newline after 16 bytes
> +        */
> +       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf2, sizeof(h=
ex_testbuf1));
> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream), KUNIT=
_SUBSUBTEST_INDENT
> +                          " 26  74  6b  9c  55  45  9d  47 <d6> 47 <01> =
89 <8c><81> 94  12 \n"
> +                          KUNIT_SUBSUBTEST_INDENT "<fe> 01 ");
> +
> +       /*
> +        * We shouldn't get any <xx> numbers when comparing the buffer wi=
th itself.
> +        * We still should get a newline after 16 printed bytes
> +        */
> +       string_stream_clear(stream);
> +       kunit_assert_hexdump(stream, hex_testbuf1, hex_testbuf1, sizeof(h=
ex_testbuf1));
> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream),
> +                          KUNIT_SUBSUBTEST_INDENT
> +                          " 26  74  6b  9c  55  45  9d  47  d6  47  01  =
89  8c  81  94  12 \n"
> +                          KUNIT_SUBSUBTEST_INDENT " fe  01 ");

Similar to above, the exactness of this message worries me slightly,
especially the indentation formatting. And I am not 100 percent sure
if having a hex dump test is worth it. But I am good to keep this in.

> +}
> +
> +static void kunit_test_mem_assert_format(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       struct string_stream *expected_stream;
> +       struct kunit_assert assert =3D {};
> +       static const struct kunit_binary_assert_text text =3D {
> +               .left_text =3D "hex_testbuf1",
> +               .operation =3D "=3D=3D",
> +               .right_text =3D "hex_testbuf2",
> +       };
> +       struct kunit_mem_assert mem_assert =3D {
> +               .assert =3D assert,
> +               .text =3D &text,
> +               .left_value =3D NULL,
> +               .right_value =3D hex_testbuf2,
> +               .size =3D sizeof(hex_testbuf1),
> +       };
> +
> +       expected_stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_stream);
> +       stream =3D kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* The left value is NULL */
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected hex_testbuf1 is not null, but is\n",
> +                       stream);
> +
> +       /* The right value is NULL, the left value is not NULL */
> +       mem_assert.left_value =3D hex_testbuf1;
> +       mem_assert.right_value =3D NULL;
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> +                       KUNIT_SUBTEST_INDENT
> +                       "Expected hex_testbuf2 is not null, but is\n",
> +                       stream);
> +
> +       /* Both arguments are not null */
> +       mem_assert.left_value =3D hex_testbuf1;
> +       mem_assert.right_value =3D hex_testbuf2;
> +
> +       /*
> +        * Building the expected buffer.
> +        */
> +       string_stream_add(expected_stream,
> +                         KUNIT_SUBTEST_INDENT "Expected hex_testbuf1 =3D=
=3D hex_testbuf2, but\n");
> +       string_stream_add(expected_stream, KUNIT_SUBSUBTEST_INDENT "hex_t=
estbuf1 =3D=3D\n");
> +       kunit_assert_hexdump(expected_stream, hex_testbuf1, hex_testbuf2,=
 mem_assert.size);
> +       string_stream_add(expected_stream,
> +                         "\n" KUNIT_SUBSUBTEST_INDENT "hex_testbuf2 =3D=
=3D\n");
> +       kunit_assert_hexdump(expected_stream, hex_testbuf2, hex_testbuf1,=
 mem_assert.size);
> +
> +       validate_assert(kunit_mem_assert_format, test, &mem_assert.assert=
,
> +                       get_str_from_stream(test, expected_stream), strea=
m);
> +}
> +
> +struct kunit_case assert_test_cases[] =3D {
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
> +struct kunit_suite assert_test_suite =3D {
> +       .name =3D "kunit-assert",
> +       .test_cases =3D assert_test_cases,
> +};
> +
> +kunit_test_suites(&assert_test_suite);
> --
> 2.34.1
>

