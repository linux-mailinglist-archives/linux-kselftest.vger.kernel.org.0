Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838FB49D94B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 04:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiA0DfI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 22:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiA0DfI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 22:35:08 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31F7C06173B
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 19:35:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so1056369wme.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 19:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVKPLfaJXEmBYBcy+VB+TTl5OO4I0GH/uS6JTBbbQ50=;
        b=hzBoLkMnDEPbpn6oxmCGDePJ/4Qmaf+uOD9U2MIZHvUuVLy14FW3B2AyOynzladXYY
         RnFYIZpOyEZaPHdVscE796B5mderquq00I8l3tWUvLwZl7uVQP1RDyq9+/m9yMmHxF1D
         93HCkHysq1GIa4x5m97cDkBPtrVrZhv0+L3Dn9Uf38K6tk19NF/9/NDapxod52ZHOq6H
         FO0Bx9MUU4lWKUJBNgU8fOilQG3XP/fcSsvbjd1/3CrBzlG+lrR/wJ31fGj5pZBB3we/
         kpAw8LhZB7mz0VeCANfHF+OGLd2jMvhrjelyRd72T1hurn8srueyKM8KmffQDoDWGo14
         P1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVKPLfaJXEmBYBcy+VB+TTl5OO4I0GH/uS6JTBbbQ50=;
        b=HG0jN7DCxho41eQIaIpkcbISyT5GvCjLpjq1KoZYtiZYcamQ/zyR0MZWMTdP9rraD3
         PYse+ABFrktrBjf4a/tsGRFSy4l5jeg0znpGKMu5L8Tj/JYJqtSUigXXHxkTq/hC8o8J
         Ommq2WRXrJZiu6FYimZglJKgJmwuPmjeuD5JKnVPBR2B3BRE+RuG5TZHABHd7sdxf1pb
         j0cD9ltvl4KJ7AWQd2WD4cL/yon85cEKTMvC7Y4CfUtCw3tGLRIgZN8BEqy0U5sK0B1k
         A5NO5HESuQhzqS4VONhhIsE4X/yBqvJKzrVkhLTwZmwqdL7OD0tKKkUWTuBcdx3da0X/
         C5xw==
X-Gm-Message-State: AOAM533d6OoeLwf7fZDWPVTYMto6MttBFj5M4zkThBzOqUjFeBH1TZ64
        jaKee+LXv9BNoT412axyonnN4wVRy5+k2fPStOaR+Q==
X-Google-Smtp-Source: ABdhPJyABomIaCy8xi99tq+obhtSn+rACTMfTDylGwnHkclxaVWgMOwR4ZBQ8Ll7d+BJbid7quAQ2/a4bK0UrEj6iRI=
X-Received: by 2002:a05:600c:350e:: with SMTP id h14mr1434832wmq.166.1643254506035;
 Wed, 26 Jan 2022 19:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-2-dlatypov@google.com>
In-Reply-To: <20220125210011.3817742-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 Jan 2022 11:34:54 +0800
Message-ID: <CABVgOSnEdoRJVozkn+EHJCDhqC-KVShFmniFYdWHka55_GzhMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: remove va_format from kunit_assert
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
> The concern is that having a lot of redundant fields in kunit_assert can
> blow up stack usage if the compiler doesn't optimize them away [1].
>
> The comment on this field implies that it was meant to be initialized
> when the expect/assert was declared, but this only happens when we run
> kunit_do_failed_assertion().
>
> We don't need to access it outside of that function, so move it out of
> the struct and make it a local variable there.
>
> This change also takes the chance to reduce the number of macros by
> inlining the now simplified KUNIT_INIT_ASSERT_STRUCT() macro.
>
> [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me. I particularly like the removal of the
KUNIT_INIT_ASSERT_STRUCT() macro. I do feel that there's not much
point having a kunit_assert struct at all now that it's just one
function pointer, but the indirection is probably still useful enough
given that things are still changing, and function pointers are always
a little ugly.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  include/kunit/assert.h | 43 +++++++++++++-----------------------------
>  lib/kunit/assert.c     | 27 +++++++++++++++-----------
>  lib/kunit/test.c       | 12 +++++++-----
>  3 files changed, 36 insertions(+), 46 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index f2b3ae5cc2de..0b3704db54b6 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -42,44 +42,21 @@ struct kunit_loc {
>
>  /**
>   * struct kunit_assert - Data for printing a failed assertion or expectation.
> - * @message: an optional message to provide additional context.
>   * @format: a function which formats the data in this kunit_assert to a string.
>   *
>   * Represents a failed expectation/assertion. Contains all the data necessary to
>   * format a string to a user reporting the failure.
>   */
>  struct kunit_assert {
> -       struct va_format message;
>         void (*format)(const struct kunit_assert *assert,
> +                      const struct va_format *message,
>                        struct string_stream *stream);
>  };
>
> -/**
> - * KUNIT_INIT_VA_FMT_NULL - Default initializer for struct va_format.
> - *
> - * Used inside a struct initialization block to initialize struct va_format to
> - * default values where fmt and va are null.
> - */
> -#define KUNIT_INIT_VA_FMT_NULL { .fmt = NULL, .va = NULL }
> -
> -/**
> - * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
> - * @fmt: The formatting function which builds a string out of this kunit_assert.
> - *
> - * The base initializer for a &struct kunit_assert.
> - */
> -#define KUNIT_INIT_ASSERT_STRUCT(fmt) {                                               \
> -       .message = KUNIT_INIT_VA_FMT_NULL,                                     \
> -       .format = fmt                                                          \
> -}
> -
>  void kunit_assert_prologue(const struct kunit_loc *loc,
>                            enum kunit_assert_type type,
>                            struct string_stream *stream);
>
> -void kunit_assert_print_msg(const struct kunit_assert *assert,
> -                           struct string_stream *stream);
> -
>  /**
>   * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
>   * @assert: The parent of this type.
> @@ -91,6 +68,7 @@ struct kunit_fail_assert {
>  };
>
>  void kunit_fail_assert_format(const struct kunit_assert *assert,
> +                             const struct va_format *message,
>                               struct string_stream *stream);
>
>  /**
> @@ -100,7 +78,7 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
>  #define KUNIT_INIT_FAIL_ASSERT_STRUCT {                                        \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_fail_assert_format)    \
> +       .assert = { .format = kunit_fail_assert_format },               \
>  }
>
>  /**
> @@ -120,6 +98,7 @@ struct kunit_unary_assert {
>  };
>
>  void kunit_unary_assert_format(const struct kunit_assert *assert,
> +                              const struct va_format *message,
>                                struct string_stream *stream);
>
>  /**
> @@ -131,7 +110,7 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
>  #define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {                   \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_unary_assert_format),         \
> +       .assert = { .format = kunit_unary_assert_format },                     \
>         .condition = cond,                                                     \
>         .expected_true = expect_true                                           \
>  }
> @@ -153,6 +132,7 @@ struct kunit_ptr_not_err_assert {
>  };
>
>  void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
> +                                    const struct va_format *message,
>                                      struct string_stream *stream);
>
>  /**
> @@ -165,7 +145,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
>  #define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {                             \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_ptr_not_err_assert_format),   \
> +       .assert = { .format = kunit_ptr_not_err_assert_format },               \
>         .text = txt,                                                           \
>         .value = val                                                           \
>  }
> @@ -194,6 +174,7 @@ struct kunit_binary_assert {
>  };
>
>  void kunit_binary_assert_format(const struct kunit_assert *assert,
> +                               const struct va_format *message,
>                                 struct string_stream *stream);
>
>  /**
> @@ -213,7 +194,7 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>                                         left_val,                              \
>                                         right_str,                             \
>                                         right_val) {                           \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_assert_format),        \
> +       .assert = { .format = kunit_binary_assert_format },                    \
>         .operation = op_str,                                                   \
>         .left_text = left_str,                                                 \
>         .left_value = left_val,                                                \
> @@ -245,6 +226,7 @@ struct kunit_binary_ptr_assert {
>  };
>
>  void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
> +                                   const struct va_format *message,
>                                     struct string_stream *stream);
>
>  /**
> @@ -265,7 +247,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>                                             left_val,                          \
>                                             right_str,                         \
>                                             right_val) {                       \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_ptr_assert_format),    \
> +       .assert = { .format = kunit_binary_ptr_assert_format },                \
>         .operation = op_str,                                                   \
>         .left_text = left_str,                                                 \
>         .left_value = left_val,                                                \
> @@ -297,6 +279,7 @@ struct kunit_binary_str_assert {
>  };
>
>  void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> +                                   const struct va_format *message,
>                                     struct string_stream *stream);
>
>  /**
> @@ -316,7 +299,7 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>                                             left_val,                          \
>                                             right_str,                         \
>                                             right_val) {                       \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_str_assert_format),    \
> +       .assert = { .format = kunit_binary_str_assert_format },                \
>         .operation = op_str,                                                   \
>         .left_text = left_str,                                                 \
>         .left_value = left_val,                                                \
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 9f4492a8e24e..c9c7ee0dfafa 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -30,22 +30,23 @@ void kunit_assert_prologue(const struct kunit_loc *loc,
>  }
>  EXPORT_SYMBOL_GPL(kunit_assert_prologue);
>
> -void kunit_assert_print_msg(const struct kunit_assert *assert,
> -                           struct string_stream *stream)
> +static void kunit_assert_print_msg(const struct va_format *message,
> +                                  struct string_stream *stream)
>  {
> -       if (assert->message.fmt)
> -               string_stream_add(stream, "\n%pV", &assert->message);
> +       if (message->fmt)
> +               string_stream_add(stream, "\n%pV", message);
>  }
> -EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
>
>  void kunit_fail_assert_format(const struct kunit_assert *assert,
> +                             const struct va_format *message,
>                               struct string_stream *stream)
>  {
> -       string_stream_add(stream, "%pV", &assert->message);
> +       string_stream_add(stream, "%pV", message);
>  }
>  EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
>
>  void kunit_unary_assert_format(const struct kunit_assert *assert,
> +                              const struct va_format *message,
>                                struct string_stream *stream)
>  {
>         struct kunit_unary_assert *unary_assert;
> @@ -60,11 +61,12 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
>                 string_stream_add(stream,
>                                   KUNIT_SUBTEST_INDENT "Expected %s to be false, but is true\n",
>                                   unary_assert->condition);
> -       kunit_assert_print_msg(assert, stream);
> +       kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
>
>  void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
> +                                    const struct va_format *message,
>                                      struct string_stream *stream)
>  {
>         struct kunit_ptr_not_err_assert *ptr_assert;
> @@ -82,7 +84,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>                                   ptr_assert->text,
>                                   PTR_ERR(ptr_assert->value));
>         }
> -       kunit_assert_print_msg(assert, stream);
> +       kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
>
> @@ -110,6 +112,7 @@ static bool is_literal(struct kunit *test, const char *text, long long value,
>  }
>
>  void kunit_binary_assert_format(const struct kunit_assert *assert,
> +                               const struct va_format *message,
>                                 struct string_stream *stream)
>  {
>         struct kunit_binary_assert *binary_assert;
> @@ -132,11 +135,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
>                                   binary_assert->right_text,
>                                   binary_assert->right_value);
> -       kunit_assert_print_msg(assert, stream);
> +       kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
>
>  void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
> +                                   const struct va_format *message,
>                                     struct string_stream *stream)
>  {
>         struct kunit_binary_ptr_assert *binary_assert;
> @@ -155,7 +159,7 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>         string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
>                           binary_assert->right_text,
>                           binary_assert->right_value);
> -       kunit_assert_print_msg(assert, stream);
> +       kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
>
> @@ -176,6 +180,7 @@ static bool is_str_literal(const char *text, const char *value)
>  }
>
>  void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> +                                   const struct va_format *message,
>                                     struct string_stream *stream)
>  {
>         struct kunit_binary_str_assert *binary_assert;
> @@ -196,6 +201,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
>                                   binary_assert->right_text,
>                                   binary_assert->right_value);
> -       kunit_assert_print_msg(assert, stream);
> +       kunit_assert_print_msg(message, stream);
>  }
>  EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 7dec3248562f..3bca3bf5c15b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -241,7 +241,8 @@ static void kunit_print_string_stream(struct kunit *test,
>  }
>
>  static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
> -                      enum kunit_assert_type type, struct kunit_assert *assert)
> +                      enum kunit_assert_type type, struct kunit_assert *assert,
> +                      const struct va_format *message)
>  {
>         struct string_stream *stream;
>
> @@ -257,7 +258,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
>         }
>
>         kunit_assert_prologue(loc, type, stream);
> -       assert->format(assert, stream);
> +       assert->format(assert, message, stream);
>
>         kunit_print_string_stream(test, stream);
>
> @@ -284,12 +285,13 @@ void kunit_do_failed_assertion(struct kunit *test,
>                                const char *fmt, ...)
>  {
>         va_list args;
> +       struct va_format message;
>         va_start(args, fmt);
>
> -       assert->message.fmt = fmt;
> -       assert->message.va = &args;
> +       message.fmt = fmt;
> +       message.va = &args;
>
> -       kunit_fail(test, loc, type, assert);
> +       kunit_fail(test, loc, type, assert, &message);
>
>         va_end(args);
>
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
