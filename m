Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EBC49D955
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 04:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiA0Dj5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 22:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiA0Dj5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 22:39:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D39C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 19:39:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so1060445wme.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 19:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhsNNzCsrT+IO9FFEkmOPihHWILho1+mWYSrj3LT5+g=;
        b=fuU3Maa7qkO8ByteJtpThZ+Wf8abVwhMd70TiyfjlBzXEMwcM9HiK3ZiacIH+L6T2z
         lleFCDQaLz3Kq78iQIsYxOz81E8xuUP//zkEwgeDvsR4dUPQZWphcOuPldJSxpYy1Mnb
         AMrOXh4SdBWFPNwGlsiAe8YQOKs4ky+UVWYRjrVHm52hjjZtCNey1roxkh9zTVG1tU1V
         hJRsnbZFE/3pfpi6Ifu4Xx2JeDvVeZoH1vCy5Bseubc2MJo6NzQq049LkxATZiSyxFwJ
         730EXlJcALxj/MkRd6485vP7ZNpWkDpCxeqR0rVBE0jVklKyDBZxQmfZcvSZ/bL65u0B
         GN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhsNNzCsrT+IO9FFEkmOPihHWILho1+mWYSrj3LT5+g=;
        b=C/ACViWKG7w+bvvbBBdgTj/7Q8g7KHCJ3CKrXTZyE8OI9ytKY+TaulGJkiBvVfNrbt
         gkSBlsJpABgNmHTnI11Fms6tl0svDFnmf/x0e0djOmv6rhuw4kByoibV3qoHR4hRCL27
         GOUKmgz/ztpjOdJemSgdXKkXckCpL4BdxHgMJIISpyAZkm0zHjHCTpvLWKw+NLK0QROF
         zDSM8g5FBCKNYuoXGba/EfHN9qdIWEmsKs3jsaomam1Ksz5V1Fk11etC0gpJihHQvp/H
         DYkthR+gWl0CBnBY4wW715SBevoIpS4TSNkr+XhFn3E2Ar/U6MAnEJJzrBCGDzLby8EK
         cV2g==
X-Gm-Message-State: AOAM533l/P8p8ZakPcEZuHuY8dZHE51TYSpVNfB5mYCGnMJvZJDCd4xz
        s/M4oHQ2s9JN9LQ7XUy+E/NNMP003xTJ8v25CqkCvg==
X-Google-Smtp-Source: ABdhPJz2kFgM4YgWjlsi4iS8QYqc+G87JpVUvOLRZKFL04zD290XMk9D80MIclwhYMgQIydKhqiqsobxj+cniXJCU+o=
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr10142565wmc.18.1643254795210;
 Wed, 26 Jan 2022 19:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-4-dlatypov@google.com>
In-Reply-To: <20220125210011.3817742-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 Jan 2022 11:39:43 +0800
Message-ID: <CABVgOSm4EWFK5-KWto1HF3AEY9c77s5MufufXRDek3PAcWCccA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: factor out str constants from binary assertion structs
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
> If the compiler doesn't optimize them away, each kunit assertion (use of
> KUNIT_EXPECT_EQ, etc.) can use 88 bytes of stack space in the worst and
> most common case. This has led to compiler warnings and a suggestion
> from Linus to move data from the structs into static const's where
> possible [1].
>
> This builds upon [2] which did so for the base struct kunit_assert type.
> That only reduced sizeof(struct kunit_binary_assert) from 88 to 64.
>
> Given these are by far the most commonly used asserts, this patch
> factors out the textual representations of the operands and comparator
> into another static const, saving 16 more bytes.
>
> In detail, KUNIT_EXPECT_EQ(test, 2 + 2, 5) yields the following struct
>   (struct kunit_binary_assert) {
>     .assert = <struct kunit_assert>,
>     .operation = "==",
>     .left_text = "2 + 2",
>     .left_value = 4,
>     .right_text = "5",
>     .right_value = 5,
>   }
> After this change
>   static const struct kunit_binary_assert_text __text = {
>     .operation = "==",
>     .left_text = "2 + 2",
>     .right_text = "5",
>   };
>   (struct kunit_binary_assert) {
>     .assert = <struct kunit_assert>,
>     .text = &__text,
>     .left_value = 4,
>     .right_value = 5,
>   }
>
> This also DRYs the code a bit more since these str fields were repeated
> for the string and pointer versions of kunit_binary_assert.
>
> Note: we could name the kunit_binary_assert_text fields left/right
> instead of left_text/right_text. But that would require changing the
> macros a bit since they have args called "left" and "right" which would
> be substituted in `.left = #left` as `.2 + 2 = \"2 + 2\"`.
>
> [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
> [2] https://lore.kernel.org/linux-kselftest/20220113165931.451305-6-dlatypov@google.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This definitely _feels_ like it's adding a bit more complexity than
would be ideal by splitting this out into a separate function, but I
do agree that it's worth it.

I think left_text / right_text are good enough names, too: I wouldn't
bother trying to make them .left/.right.


Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/assert.h | 49 +++++++++++++++++++-----------------------
>  include/kunit/test.h   | 20 +++++++++++------
>  lib/kunit/assert.c     | 38 ++++++++++++++++----------------
>  3 files changed, 54 insertions(+), 53 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 649bfac9f406..4b52e12c2ae8 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -150,14 +150,25 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>         .value = val                                                           \
>  }
>
> +/**
> + * struct kunit_binary_assert_text - holds strings for &struct
> + *     kunit_binary_assert and friends to try and make the structs smaller.
> + * @operation: A string representation of the comparison operator (e.g. "==").
> + * @left_text: A string representation of the left expression (e.g. "2+2").
> + * @right_text: A string representation of the right expression (e.g. "2+2").
> + */
> +struct kunit_binary_assert_text {
> +       const char *operation;
> +       const char *left_text;
> +       const char *right_text;
> +};
> +
>  /**
>   * struct kunit_binary_assert - An expectation/assertion that compares two
>   *     non-pointer values (for example, KUNIT_EXPECT_EQ(test, 1 + 1, 2)).
>   * @assert: The parent of this type.
> - * @operation: A string representation of the comparison operator (e.g. "==").
> - * @left_text: A string representation of the expression in the left slot.
> + * @text: Holds the textual representations of the operands and op (e.g.  "==").
>   * @left_value: The actual evaluated value of the expression in the left slot.
> - * @right_text: A string representation of the expression in the right slot.
>   * @right_value: The actual evaluated value of the expression in the right slot.
>   *
>   * Represents an expectation/assertion that compares two non-pointer values. For
> @@ -166,10 +177,8 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>   */
>  struct kunit_binary_assert {
>         struct kunit_assert assert;
> -       const char *operation;
> -       const char *left_text;
> +       const struct kunit_binary_assert_text *text;
>         long long left_value;
> -       const char *right_text;
>         long long right_value;
>  };
>
> @@ -182,10 +191,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>   *     kunit_binary_assert, kunit_binary_ptr_assert, etc.
>   *
>   * @format_func: a function which formats the assert to a string.
> - * @op_str: A string representation of the comparison operator (e.g. "==").
> - * @left_str: A string representation of the expression in the left slot.
> + * @text_: Pointer to a kunit_binary_assert_text.
>   * @left_val: The actual evaluated value of the expression in the left slot.
> - * @right_str: A string representation of the expression in the right slot.
>   * @right_val: The actual evaluated value of the expression in the right slot.
>   *
>   * Initializes a binary assert like kunit_binary_assert,
> @@ -194,16 +201,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>   * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
>   */
>  #define KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,                          \
> -                                       op_str,                                \
> -                                       left_str,                              \
> +                                       text_,                                 \
>                                         left_val,                              \
> -                                       right_str,                             \
>                                         right_val) {                           \
>         .assert = { .format = format_func },                                   \
> -       .operation = op_str,                                                   \
> -       .left_text = left_str,                                                 \
> +       .text = text_,                                                         \
>         .left_value = left_val,                                                \
> -       .right_text = right_str,                                               \
>         .right_value = right_val                                               \
>  }
>
> @@ -211,10 +214,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>   * struct kunit_binary_ptr_assert - An expectation/assertion that compares two
>   *     pointer values (for example, KUNIT_EXPECT_PTR_EQ(test, foo, bar)).
>   * @assert: The parent of this type.
> - * @operation: A string representation of the comparison operator (e.g. "==").
> - * @left_text: A string representation of the expression in the left slot.
> + * @text: Holds the textual representations of the operands and op (e.g.  "==").
>   * @left_value: The actual evaluated value of the expression in the left slot.
> - * @right_text: A string representation of the expression in the right slot.
>   * @right_value: The actual evaluated value of the expression in the right slot.
>   *
>   * Represents an expectation/assertion that compares two pointer values. For
> @@ -223,10 +224,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>   */
>  struct kunit_binary_ptr_assert {
>         struct kunit_assert assert;
> -       const char *operation;
> -       const char *left_text;
> +       const struct kunit_binary_assert_text *text;
>         const void *left_value;
> -       const char *right_text;
>         const void *right_value;
>  };
>
> @@ -238,10 +237,8 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>   * struct kunit_binary_str_assert - An expectation/assertion that compares two
>   *     string values (for example, KUNIT_EXPECT_STREQ(test, foo, "bar")).
>   * @assert: The parent of this type.
> - * @operation: A string representation of the comparison operator (e.g. "==").
> - * @left_text: A string representation of the expression in the left slot.
> + * @text: Holds the textual representations of the operands and comparator.
>   * @left_value: The actual evaluated value of the expression in the left slot.
> - * @right_text: A string representation of the expression in the right slot.
>   * @right_value: The actual evaluated value of the expression in the right slot.
>   *
>   * Represents an expectation/assertion that compares two string values. For
> @@ -250,10 +247,8 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>   */
>  struct kunit_binary_str_assert {
>         struct kunit_assert assert;
> -       const char *operation;
> -       const char *left_text;
> +       const struct kunit_binary_assert_text *text;
>         const char *left_value;
> -       const char *right_text;
>         const char *right_value;
>  };
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index a93dfb8ff393..088ff394ae94 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -874,16 +874,19 @@ void kunit_do_failed_assertion(struct kunit *test,
>  do {                                                                          \
>         typeof(left) __left = (left);                                          \
>         typeof(right) __right = (right);                                       \
> +       static const struct kunit_binary_assert_text __text = {                \
> +               .operation = #op,                                              \
> +               .left_text = #left,                                            \
> +               .right_text = #right,                                          \
> +       };                                                                     \
>                                                                                \
>         KUNIT_ASSERTION(test,                                                  \
>                         assert_type,                                           \
>                         __left op __right,                                     \
>                         assert_class,                                          \
>                         KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,           \
> -                                                       #op,                   \
> -                                                       #left,                 \
> +                                                       &__text,               \
>                                                         __left,                \
> -                                                       #right,                \
>                                                         __right),              \
>                         fmt,                                                   \
>                         ##__VA_ARGS__);                                        \
> @@ -928,17 +931,20 @@ do {                                                                             \
>                                    ...)                                        \
>  do {                                                                          \
>         const char *__left = (left);                                           \
> -       const char *__right = (right);                                 \
> +       const char *__right = (right);                                         \
> +       static const struct kunit_binary_assert_text __text = {                \
> +               .operation = #op,                                              \
> +               .left_text = #left,                                            \
> +               .right_text = #right,                                          \
> +       };                                                                     \
>                                                                                \
>         KUNIT_ASSERTION(test,                                                  \
>                         assert_type,                                           \
>                         strcmp(__left, __right) op 0,                          \
>                         kunit_binary_str_assert,                               \
>                         KUNIT_INIT_BINARY_ASSERT_STRUCT(kunit_binary_str_assert_format,\
> -                                                       #op,                   \
> -                                                       #left,                 \
> +                                                       &__text,               \
>                                                         __left,                \
> -                                                       #right,                \
>                                                         __right),              \
>                         fmt,                                                   \
>                         ##__VA_ARGS__);                                        \
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index c9c7ee0dfafa..d00d6d181ee8 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -122,18 +122,18 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>
>         string_stream_add(stream,
>                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> -                         binary_assert->left_text,
> -                         binary_assert->operation,
> -                         binary_assert->right_text);
> -       if (!is_literal(stream->test, binary_assert->left_text,
> +                         binary_assert->text->left_text,
> +                         binary_assert->text->operation,
> +                         binary_assert->text->right_text);
> +       if (!is_literal(stream->test, binary_assert->text->left_text,
>                         binary_assert->left_value, stream->gfp))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> -                                 binary_assert->left_text,
> +                                 binary_assert->text->left_text,
>                                   binary_assert->left_value);
> -       if (!is_literal(stream->test, binary_assert->right_text,
> +       if (!is_literal(stream->test, binary_assert->text->right_text,
>                         binary_assert->right_value, stream->gfp))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> -                                 binary_assert->right_text,
> +                                 binary_assert->text->right_text,
>                                   binary_assert->right_value);
>         kunit_assert_print_msg(message, stream);
>  }
> @@ -150,14 +150,14 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>
>         string_stream_add(stream,
>                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> -                         binary_assert->left_text,
> -                         binary_assert->operation,
> -                         binary_assert->right_text);
> +                         binary_assert->text->left_text,
> +                         binary_assert->text->operation,
> +                         binary_assert->text->right_text);
>         string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
> -                         binary_assert->left_text,
> +                         binary_assert->text->left_text,
>                           binary_assert->left_value);
>         string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
> -                         binary_assert->right_text,
> +                         binary_assert->text->right_text,
>                           binary_assert->right_value);
>         kunit_assert_print_msg(message, stream);
>  }
> @@ -190,16 +190,16 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>
>         string_stream_add(stream,
>                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> -                         binary_assert->left_text,
> -                         binary_assert->operation,
> -                         binary_assert->right_text);
> -       if (!is_str_literal(binary_assert->left_text, binary_assert->left_value))
> +                         binary_assert->text->left_text,
> +                         binary_assert->text->operation,
> +                         binary_assert->text->right_text);
> +       if (!is_str_literal(binary_assert->text->left_text, binary_assert->left_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"\n",
> -                                 binary_assert->left_text,
> +                                 binary_assert->text->left_text,
>                                   binary_assert->left_value);
> -       if (!is_str_literal(binary_assert->right_text, binary_assert->right_value))
> +       if (!is_str_literal(binary_assert->text->right_text, binary_assert->right_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
> -                                 binary_assert->right_text,
> +                                 binary_assert->text->right_text,
>                                   binary_assert->right_value);
>         kunit_assert_print_msg(message, stream);
>  }
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
