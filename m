Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67849D94F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 04:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiA0Dg7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 22:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiA0Dg6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 22:36:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B73C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 19:36:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u15so2327135wrt.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 19:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NB/kw64Q7TGRiqyrKvvF4M9Nd3RO8vAx5w3bpLJjNkA=;
        b=aEIhHV3ycVb3fT1MwZgjBlsd80DqiyPakkW+BxeH1CbHczAFjXVvX8SKPCsMQoTQYc
         6FFr6Th/cwQ4JkHOVSaF+qsWlDQK5wwjgEYkhXJCqqKadiAPEsTBcf+jgZ3mBhibcBaF
         pI89gerjH3/GxPwqIPOzDiwWuvHHj0MK0PfTA5mNVOI7EDoNX0PJcEu8gZknEZPpRFG5
         vHQw4SKjiur1XJslnOnNlfbXsmAUxbPPN5e7nsqemhQ0NQ7LY0ko4Yz7qmtMln70TkEO
         6pNvt4TuYvYZjj4stUktzvhpfi8MjY4vlLUMnuednrWPLhjADLLi5VfJGJugInhs+HH0
         5PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NB/kw64Q7TGRiqyrKvvF4M9Nd3RO8vAx5w3bpLJjNkA=;
        b=I7PzgoiAcvWprOpRIP8AWaGWcfHi6yYxJGcOX01Jjsfik/dbUCf1SXGeXapqPmC4eR
         3lIOUbcmhi0mI7wbYDzUWiSnkk3aSKxY4N+pJU1v/SwdjMID2ph9cAW6f5GJV1+EKdOT
         K736iBNQSqWHadGH3tvFoBvmCMz5IrHptbeHP3agGM8Q4Mwywi4TYvygjeDQPSXJQtvv
         DUBWP/OJPMz8ZpJcrQy0J23x6lIApOnD99HyhuOmM6F+fUht9S3+5ysCYtv6qkFuTP7Z
         LnLUBYF8yNQsNin+uJ1aVjkaGSXmr9rdj8SNHYKyuUJD8M9w4NwC62jngzvsB6h4dDua
         yeeA==
X-Gm-Message-State: AOAM532CdJXFCTWkyaPy4ajI3DdqZuZ6XE83TZOIWIIgpEgSdA9ELnCF
        TMufQr0DarNOh2rHWVGCfl8ZJSw+cAXhWsnnrXuqbQ==
X-Google-Smtp-Source: ABdhPJy1K2ZDOw1TxPAyyPvsSSpWYJL3voRl+byUDjlkXu20U0n86tUAi1AySDfZJHwvCIkNPPqfOUrPzTpTvs/CK4E=
X-Received: by 2002:a5d:6644:: with SMTP id f4mr1295527wrw.113.1643254616629;
 Wed, 26 Jan 2022 19:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-3-dlatypov@google.com>
In-Reply-To: <20220125210011.3817742-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 Jan 2022 11:36:45 +0800
Message-ID: <CABVgOSmESbi9Cm6GqGn+G1vD8qmX8wwPwtCxzUOZp-qRpBKQYA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: consolidate KUNIT_INIT_BINARY_ASSERT_STRUCT macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 26, 2022 at 5:00 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> We currently have 2 other versions of KUNIT_INIT_BINARY_ASSERT_STRUCT.
> The only differences are that
> * the format funcition they pass is different
Minor nit: s/funcition/function/
> * the types of left_val/right_val should be different (integral,
> pointer, string).
>
> The latter doesn't actually matter since these macros are just plumbing
> them along to KUNIT_ASSERTION where they will get type checked.
>
> So combine them all into a single KUNIT_INIT_BINARY_ASSERT_STRUCT that
> now also takes the format function as a parameter.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Makes sense to me.

One minor spelling nit: probably not worth a whole new version over,
but if v2 ever happens, worth fixing at the same time...

-- David


>  include/kunit/assert.h | 68 +++++++-----------------------------------
>  include/kunit/test.h   | 20 +++++++------
>  2 files changed, 22 insertions(+), 66 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 0b3704db54b6..649bfac9f406 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -178,23 +178,28 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>                                 struct string_stream *stream);
>
>  /**
> - * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
> - *     &struct kunit_binary_assert.
> + * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a binary assert like
> + *     kunit_binary_assert, kunit_binary_ptr_assert, etc.
> + *
> + * @format_func: a function which formats the assert to a string.
>   * @op_str: A string representation of the comparison operator (e.g. "==").
>   * @left_str: A string representation of the expression in the left slot.
>   * @left_val: The actual evaluated value of the expression in the left slot.
>   * @right_str: A string representation of the expression in the right slot.
>   * @right_val: The actual evaluated value of the expression in the right slot.
>   *
> - * Initializes a &struct kunit_binary_assert. Intended to be used in
> - * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> + * Initializes a binary assert like kunit_binary_assert,
> + * kunit_binary_ptr_assert, etc. This relies on these structs having the same
> + * fields but with different types for left_val/right_val.
> + * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
>   */
> -#define KUNIT_INIT_BINARY_ASSERT_STRUCT(op_str,                                       \
> +#define KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,                          \
> +                                       op_str,                                \
>                                         left_str,                              \
>                                         left_val,                              \
>                                         right_str,                             \
>                                         right_val) {                           \
> -       .assert = { .format = kunit_binary_assert_format },                    \
> +       .assert = { .format = format_func },                                   \
>         .operation = op_str,                                                   \
>         .left_text = left_str,                                                 \
>         .left_value = left_val,                                                \
> @@ -229,32 +234,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>                                     const struct va_format *message,
>                                     struct string_stream *stream);
>
> -/**
> - * KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT() - Initializes a
> - *     &struct kunit_binary_ptr_assert.
> - * @type: The type (assertion or expectation) of this kunit_assert.
> - * @op_str: A string representation of the comparison operator (e.g. "==").
> - * @left_str: A string representation of the expression in the left slot.
> - * @left_val: The actual evaluated value of the expression in the left slot.
> - * @right_str: A string representation of the expression in the right slot.
> - * @right_val: The actual evaluated value of the expression in the right slot.
> - *
> - * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
> - * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> - */
> -#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(op_str,                           \
> -                                           left_str,                          \
> -                                           left_val,                          \
> -                                           right_str,                         \
> -                                           right_val) {                       \
> -       .assert = { .format = kunit_binary_ptr_assert_format },                \
> -       .operation = op_str,                                                   \
> -       .left_text = left_str,                                                 \
> -       .left_value = left_val,                                                \
> -       .right_text = right_str,                                               \
> -       .right_value = right_val                                               \
> -}
> -
>  /**
>   * struct kunit_binary_str_assert - An expectation/assertion that compares two
>   *     string values (for example, KUNIT_EXPECT_STREQ(test, foo, "bar")).
> @@ -282,29 +261,4 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>                                     const struct va_format *message,
>                                     struct string_stream *stream);
>
> -/**
> - * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
> - *     &struct kunit_binary_str_assert.
> - * @op_str: A string representation of the comparison operator (e.g. "==").
> - * @left_str: A string representation of the expression in the left slot.
> - * @left_val: The actual evaluated value of the expression in the left slot.
> - * @right_str: A string representation of the expression in the right slot.
> - * @right_val: The actual evaluated value of the expression in the right slot.
> - *
> - * Initializes a &struct kunit_binary_str_assert. Intended to be used in
> - * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> - */
> -#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(op_str,                           \
> -                                           left_str,                          \
> -                                           left_val,                          \
> -                                           right_str,                         \
> -                                           right_val) {                       \
> -       .assert = { .format = kunit_binary_str_assert_format },                \
> -       .operation = op_str,                                                   \
> -       .left_text = left_str,                                                 \
> -       .left_value = left_val,                                                \
> -       .right_text = right_str,                                               \
> -       .right_value = right_val                                               \
> -}
> -
>  #endif /*  _KUNIT_ASSERT_H */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index bf82c313223b..a93dfb8ff393 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -864,7 +864,7 @@ void kunit_do_failed_assertion(struct kunit *test,
>   */
>  #define KUNIT_BASE_BINARY_ASSERTION(test,                                     \
>                                     assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> +                                   format_func,                               \
>                                     assert_type,                               \
>                                     left,                                      \
>                                     op,                                        \
> @@ -879,11 +879,12 @@ do {                                                                             \
>                         assert_type,                                           \
>                         __left op __right,                                     \
>                         assert_class,                                          \
> -                       ASSERT_CLASS_INIT(#op,                                 \
> -                                         #left,                               \
> -                                         __left,                              \
> -                                         #right,                              \
> -                                         __right),                            \
> +                       KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,           \
> +                                                       #op,                   \
> +                                                       #left,                 \
> +                                                       __left,                \
> +                                                       #right,                \
> +                                                       __right),              \
>                         fmt,                                                   \
>                         ##__VA_ARGS__);                                        \
>  } while (0)
> @@ -897,7 +898,7 @@ do {                                                                               \
>                                     ...)                                       \
>         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> -                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
> +                                   kunit_binary_assert_format,                \
>                                     assert_type,                               \
>                                     left, op, right,                           \
>                                     fmt,                                       \
> @@ -912,7 +913,7 @@ do {                                                                               \
>                                     ...)                                       \
>         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
>                                     kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> +                                   kunit_binary_ptr_assert_format,            \
>                                     assert_type,                               \
>                                     left, op, right,                           \
>                                     fmt,                                       \
> @@ -933,7 +934,8 @@ do {                                                                               \
>                         assert_type,                                           \
>                         strcmp(__left, __right) op 0,                          \
>                         kunit_binary_str_assert,                               \
> -                       KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(#op,               \
> +                       KUNIT_INIT_BINARY_ASSERT_STRUCT(kunit_binary_str_assert_format,\
> +                                                       #op,                   \
>                                                         #left,                 \
>                                                         __left,                \
>                                                         #right,                \
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
