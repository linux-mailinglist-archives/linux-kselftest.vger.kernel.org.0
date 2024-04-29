Return-Path: <linux-kselftest+bounces-9082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F58B648D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155F11C2155B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DABF1836E4;
	Mon, 29 Apr 2024 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKXmBN+o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93B1836D7
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425999; cv=none; b=L/3uJUDCAvLh9R+P7CSEq3183zbrqpTsrAMis9J8/vpmIEp2WbfbkUzkpGOCUGpdfLC2zg5XrgqDVABMTPYJj6vSqUfSRQ+jMTCkTfffy8x3pUchJMm+z5U4b43PzDzHP262jMoYrglvGp2j+7drlQzFA1JYzBMOVpL+cVjx3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425999; c=relaxed/simple;
	bh=vSILQr/yG7rGELxw9Gfm7bA26qKdlSZZphCP6+QGNgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kK5vS75pO0ekwlt53qr/8qJmFrr7gqu4V1Ji+CiZftvaHWgFDgp6TaYpVJUfMP4DqiJtsLI/WVxfuuVKITM8PBipyNDQm97X+O3INPhSKH6xExC3h16SoWXIWgQwZQsjYlaWuvBRfe+HCaZffBHmaz3SOQvlbvegE6GH6gfefFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKXmBN+o; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-439b1c72676so45931cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714425995; x=1715030795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0ft88jlCsT6nL2pqDdl7P8q47yjZf5PZ6un+GujgeQ=;
        b=qKXmBN+owNB7EwJqRtNBgxO8xSef51JJ4sAiEtl681hB8fc/97BnLKIhsXXbxi5Ex9
         wdeoj5yKIktK3PTn5bSmnu8egkxMRKEMHBUpfGWFL5UNpCr2ejZHDPeHFm0igV8ZKvjB
         HHgtFjVnlGaGwyp8L92HohznR0jbwmnqmT+5sD3OZI3I1ig6gPgXdkA73Y3srfx6vHIm
         2cNkE0biPFVBhbvGYsgS6/3ygH1CqezTnV6DfPCRuNh/55ZFuaWOnkguxFVFQNu+GEp6
         VeLUDoeLZWezXeKwN7Nnkyqx5yJC3zqhusMXZf6qrC9i9tS0e5GzxpjK2/8glJJIlv8F
         yd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714425995; x=1715030795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0ft88jlCsT6nL2pqDdl7P8q47yjZf5PZ6un+GujgeQ=;
        b=jL58JNwECuAvVmJ/yunpR3gAhmnM0mYwX2VyzF2pxYo/jxf4oCTlxQLqJ0LHgrYvgu
         QWfM+FO4TIUmqDWgeHDoDLe4IpkSVJ38Ew7nRpns1m0hV7+QUe3v0hSGHMtRkP/40e3Y
         ZZuaICv6YUKD82DYfLtiLwCsLvZ378EVkWewklW/TWDWf5h9MxBiF0A/nU4G800iJIsq
         MiR+ebwUR37DhKKEHDTtGCDAv3fjNx3YI6B6fuKx7IasPQa7ugED1fWUuO0+rbj5shXN
         27JdUi0CsoSfzgQg5s7RXl7N7Tw9PSfFNA4wj1s3OMuQcVvCYL2q1DxwQ3KScbubhqdi
         HBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/NVZslinaVRWcJihTNXj3QS1tPqtOPR8FOPdM1NvZOzMQcqsSSwSHvzfriLIGfaGBaAGDCqLwNPi1+RC2fx4zcAMGuntZPYEV1mQOv789
X-Gm-Message-State: AOJu0YxN39H2Lz1vXyODZtAyCMcz/oN9Dq7PnTPLPQLjESfwhoAx9BpK
	kIO+bPnysoUeRxx5N/kJyKziglB6f4WqMb4U12M/ykpK36f1E3YNbNKgrvB+V/58IKk3W9eaCKm
	JiOOCnGp/WZX+2SUfe9vhDEXJUM3s/VzVctet
X-Google-Smtp-Source: AGHT+IFF+vs+DdaTG4vWSwELCy1I7OfA3uJGCFPpzRTkOyWf5BX+G7XRymOuFHgn0rRnDp60deyMAWH2H4k3Z7RH5E4=
X-Received: by 2002:a05:622a:42:b0:43a:b208:7cd9 with SMTP id
 y2-20020a05622a004200b0043ab2087cd9mr75695qtw.0.1714425994969; Mon, 29 Apr
 2024 14:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427220447.231475-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20240427220447.231475-1-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 29 Apr 2024 17:26:22 -0400
Message-ID: <CA+GJov5Ve+NksNMXrd32p6RCPcSuf0oCZ-QA8LdhcvFWA48ukA@mail.gmail.com>
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

Hello,

I'll give this a full review tomorrow. But with a quick glance and
test, this is looking good to me.

Tested-by: Rae Moar <rmoar@google.com>

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

