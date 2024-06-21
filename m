Return-Path: <linux-kselftest+bounces-12482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB84912F60
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 23:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1488D282603
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C969F17C21F;
	Fri, 21 Jun 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rX6rnjdY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E017B407
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004791; cv=none; b=bUG4xf0fEGAOLFmoR3RGNGrm3qpezux7bCzIMuJE2Uz96vUrFHMdyjLfPiojXtlfIPJjfplz+hW+Lo8Xp534hVcuz+W6Ar7TZ+XoAQSAnef5W31uYrALfzSQ+mD8ZeenSPGOezU8+tG59JVn9YwdP1Af8yLswt5ZpEG5RjnChzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004791; c=relaxed/simple;
	bh=5XHHMKk4nrpuQrS++N+tdEYS245V96nvkY6ZidvUSMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqLewF5oz5y+QkGupI5YXUoCkPzyfKIdbF742O4X4J3xNCTDNe63HVBabtlWYlQaQ8nbIXBFfRnnM2+Okva24Q61AzbSAPBmx6bNM7b8ydeYfedFDin526GXdLLBBR2fsDSyKrJjGIoPmU1oU5gfQ6tbuHv6SyySpMm4gsLA3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rX6rnjdY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424877221d6so9015e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719004788; x=1719609588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=487Z5jEIialMJaJUH5v8eHBq6SrBQrtZB46/x7TUKe8=;
        b=rX6rnjdYBv4zyxyolw3AfcZRmJ29eM2yeHfZXMwx2FPmUzCy9FFk0H4Qha20J6+2gF
         VUBgg5LVt0A+1dNCwZxTE91SXLz+Y016sm3Qj178GU/S2C6GXze+Ok3UmGo4jUnPox3q
         PSEf+bukgMquMK5V616iglgDBp4Xc9b0EG0YvrZo7dvxtVvXsCaPAbuOpA2g6tiI94bd
         zTK2DasBdDS9BfT1J15CRxiEA09kDuioUlPnWIhIhXyZPuJVB82AG97ggK5phcx+q34J
         3tUv8trakl/YD8zz4swl7zaaBVZPsseYTpUTnYpVdU5/vEdog9T9bTIsS4EWy261B+XC
         Uz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004788; x=1719609588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=487Z5jEIialMJaJUH5v8eHBq6SrBQrtZB46/x7TUKe8=;
        b=Tx7E0rJ5cOODSCISZIO022PlRUAOTBzgd0eVVwZ/XP/XuNucPUnHXmu27y3MyKwqj0
         CriDQ16Af6R8xgwcX1W0xdS2lqpbU3Us8pMP2nb+/netU32AQ2ZBuvKq0+G+mbEbS3Ul
         f/DTopOAZN7CAp6JnOD7bxuCCLlLTZfPF9Vxq5wLRWjFDd/1mFY+T/KApsKX2JtaDsOy
         gHfb7Ft3hTy9MJvyRGCZkn8M13Wn09WxONx72+EuoDhUh8ab/LP37YZWcTzdpx6X0IT/
         hgZVxcawNlxPbEasojU6jHEB8ru7JCqVoRqjegkyX2Y4oA0CsNsZAVoKuttwCRvjN/O7
         qLQw==
X-Forwarded-Encrypted: i=1; AJvYcCUvNKfhQToLBmXGy519Tgjc0KxrPhYsKyZtQf/zSqzhYICPmHEzRwNFaYvRGS5P97KOO9A5OdWSzylwnPgKq/EwCo2+UvHgFVOzJsI0bnrF
X-Gm-Message-State: AOJu0Yx4KrsiWJP+ky8b8ONVhfuF3U2JZiKwXHjnnvxJdzdTq3zVTCrF
	76OGMbBnP8gneGz1P1UbkklbOijBaYs9kWyNCTQNHJiBJDfneHR0DruWEtwW85+/NhZJjVGnwhY
	O5cibRYOcVQA0A27eZHMFsmiykXZIn/MnLBjG
X-Google-Smtp-Source: AGHT+IG22zx+p5stxXawd4YC71kzI0L+IOhy05pWo+AJNfSlRjlWxAKw4a73Vz/nFJDN+H3NorrrrIW/tEhZn8I6nw0=
X-Received: by 2002:a7b:ce90:0:b0:424:8784:26f0 with SMTP id
 5b1f17b1804b1-42487842726mr247125e9.2.1719004786490; Fri, 21 Jun 2024
 14:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com> <20240618170331.264851-5-ivan.orlov0322@gmail.com>
In-Reply-To: <20240618170331.264851-5-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 21 Jun 2024 17:19:34 -0400
Message-ID: <CA+GJov7LzOSfFVRA4rSSeR_AeryWC7hPpXki8RDQDywa4ngEig@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kunit: assert_test: Prepare to be merged into kunit-test.c
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:03=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> Add 'kunit_assert_' prefix for 'is_literal' and 'is_str_literal'
> functions. This way we will be sure that we are not exporting ambiguous
> symbols into the KUnit namespace.
>
> Export these (and other) functions from assert into the KUnit namespace,
> so we could use them in the tests (and cover them as well).
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hi!

This looks good to me. I am happy with the changes since v1.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks for your work on this!
-Rae

> ---
> V1 -> V2:
> - Besides exporting the non-static functions from assert.c into the
> KUnit namespace, rename some of them as well (add kunit_assert_ prefix
> to make their names less ambiguous).
>
>  include/kunit/assert.h  |  4 ++--
>  lib/kunit/assert.c      | 19 +++++++++++++------
>  lib/kunit/assert_test.c | 40 ++++++++++++++++++++--------------------
>  3 files changed, 35 insertions(+), 28 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 7e7490a74b13..3994acc520ae 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -221,8 +221,8 @@ void kunit_mem_assert_format(const struct kunit_asser=
t *assert,
>  #if IS_ENABLED(CONFIG_KUNIT)
>  void kunit_assert_print_msg(const struct va_format *message,
>                             struct string_stream *stream);
> -bool is_literal(const char *text, long long value);
> -bool is_str_literal(const char *text, const char *value);
> +bool kunit_assert_is_literal(const char *text, long long value);
> +bool kunit_assert_is_str_literal(const char *text, const char *value);
>  void kunit_assert_hexdump(struct string_stream *stream,
>                           const void *buf,
>                           const void *compared_buf,
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 867aa5c4bccf..62b86bf5603e 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -38,6 +38,7 @@ void kunit_assert_print_msg(const struct va_format *mes=
sage,
>         if (message->fmt)
>                 string_stream_add(stream, "\n%pV", message);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
>
>  void kunit_fail_assert_format(const struct kunit_assert *assert,
>                               const struct va_format *message,
> @@ -91,7 +92,8 @@ void kunit_ptr_not_err_assert_format(const struct kunit=
_assert *assert,
>  EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
>
>  /* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
> -VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
> +VISIBLE_IF_KUNIT
> +bool kunit_assert_is_literal(const char *text, long long value)
>  {
>         char *buffer;
>         int len;
> @@ -112,6 +114,7 @@ VISIBLE_IF_KUNIT bool is_literal(const char *text, lo=
ng long value)
>
>         return ret;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_is_literal);
>
>  void kunit_binary_assert_format(const struct kunit_assert *assert,
>                                 const struct va_format *message,
> @@ -127,12 +130,12 @@ void kunit_binary_assert_format(const struct kunit_=
assert *assert,
>                           binary_assert->text->left_text,
>                           binary_assert->text->operation,
>                           binary_assert->text->right_text);
> -       if (!is_literal(binary_assert->text->left_text, binary_assert->le=
ft_value))
> +       if (!kunit_assert_is_literal(binary_assert->text->left_text, bina=
ry_assert->left_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D %lld (0x%llx)\n",
>                                   binary_assert->text->left_text,
>                                   binary_assert->left_value,
>                                   binary_assert->left_value);
> -       if (!is_literal(binary_assert->text->right_text, binary_assert->r=
ight_value))
> +       if (!kunit_assert_is_literal(binary_assert->text->right_text, bin=
ary_assert->right_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D %lld (0x%llx)",
>                                   binary_assert->text->right_text,
>                                   binary_assert->right_value,
> @@ -168,7 +171,8 @@ EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
>  /* Checks if KUNIT_EXPECT_STREQ() args were string literals.
>   * Note: `text` will have ""s where as `value` will not.
>   */
> -VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value=
)
> +VISIBLE_IF_KUNIT
> +bool kunit_assert_is_str_literal(const char *text, const char *value)
>  {
>         int len;
>
> @@ -180,6 +184,7 @@ VISIBLE_IF_KUNIT bool is_str_literal(const char *text=
, const char *value)
>
>         return strncmp(text + 1, value, len - 2) =3D=3D 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_is_str_literal);
>
>  void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>                                     const struct va_format *message,
> @@ -195,11 +200,12 @@ void kunit_binary_str_assert_format(const struct ku=
nit_assert *assert,
>                           binary_assert->text->left_text,
>                           binary_assert->text->operation,
>                           binary_assert->text->right_text);
> -       if (!is_str_literal(binary_assert->text->left_text, binary_assert=
->left_value))
> +       if (!kunit_assert_is_str_literal(binary_assert->text->left_text, =
binary_assert->left_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D \"%s\"\n",
>                                   binary_assert->text->left_text,
>                                   binary_assert->left_value);
> -       if (!is_str_literal(binary_assert->text->right_text, binary_asser=
t->right_value))
> +       if (!kunit_assert_is_str_literal(binary_assert->text->right_text,
> +                                        binary_assert->right_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s =3D=
=3D \"%s\"",
>                                   binary_assert->text->right_text,
>                                   binary_assert->right_value);
> @@ -232,6 +238,7 @@ void kunit_assert_hexdump(struct string_stream *strea=
m,
>                         string_stream_add(stream, " %02x ", buf1[i]);
>         }
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
>
>  void kunit_mem_assert_format(const struct kunit_assert *assert,
>                              const struct va_format *message,
> diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
> index 4a5967712186..4999233180d6 100644
> --- a/lib/kunit/assert_test.c
> +++ b/lib/kunit/assert_test.c
> @@ -11,28 +11,28 @@
>  #define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(=
test, strstr(str, substr))
>  #define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALS=
E(test, strstr(str, substr))
>
> -static void kunit_test_is_literal(struct kunit *test)
> +static void kunit_test_assert_is_literal(struct kunit *test)
>  {
> -       KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
> -       KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
> -       KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
> -       KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890));
> -       KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
> -       KUNIT_EXPECT_FALSE(test, is_literal("", 0));
> -       KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
> -       KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("5", 5));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("0", 0));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("1234567890", 123=
4567890));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("-1234567890", -1=
234567890));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("05", 5));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("", 0));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("-0", 0));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("12#45", 1245));
>  }
>
> -static void kunit_test_is_str_literal(struct kunit *test)
> +static void kunit_test_assert_is_str_literal(struct kunit *test)
>  {
> -       KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hell=
o, World!"));
> -       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
> -       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
> -       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba=
\""));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"Hello, Wor=
ld!\"", "Hello, World!"));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"", ""));
> +       KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"\"", "\"=
"));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("", ""));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"", "\""))=
;
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba",=
 "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("Abacaba\"",=
 "Abacaba"));
> +       KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba\"=
", "\"Abacaba\""));
>  }
>
>  KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
> @@ -366,8 +366,8 @@ static void kunit_test_mem_assert_format(struct kunit=
 *test)
>  }
>
>  static struct kunit_case assert_test_cases[] =3D {
> -       KUNIT_CASE(kunit_test_is_literal),
> -       KUNIT_CASE(kunit_test_is_str_literal),
> +       KUNIT_CASE(kunit_test_assert_is_literal),
> +       KUNIT_CASE(kunit_test_assert_is_str_literal),
>         KUNIT_CASE(kunit_test_assert_prologue),
>         KUNIT_CASE(kunit_test_assert_print_msg),
>         KUNIT_CASE(kunit_test_unary_assert_format),
> --
> 2.34.1
>

