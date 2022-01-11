Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF348A805
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 07:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348361AbiAKG51 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 01:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348357AbiAKG51 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 01:57:27 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DDEC061748
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 22:57:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so500572wms.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 22:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWMFJfxrZ2OYRLghd5mWocUCR5XW0t4Pb34Y14Rarm4=;
        b=pMvvWb1br8iefdWkngIruceFMvML+xXPjNU8HWMVYPlMP2I5lW36lgyQLQEtktnwWy
         MrYefRKukVWeQbUN7I8g2H1MnrsOZD7RX2uJCnJ5JWcHG/wkqY3VWbjymYCbH/xjotEt
         llgVfzm+rqgXfB3g3kM8nvtkLJOoxYKUnUo/RBjbRKQA1UA8JhPChUPLG4ZJHV0Yyx24
         2D9itwjum+rhYaTBy3k1stNmHxEg4ff/cDzDt979eJh5Lt6Zf4zmHORZ69+AgeOceFHp
         VheenzOHjJyIDhs12otFIXBlirttx5Wl3njqc1rITGVY58lHq9lUssI+fhfoV6KZZ74c
         B9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWMFJfxrZ2OYRLghd5mWocUCR5XW0t4Pb34Y14Rarm4=;
        b=2nGfcV4MJxFYbTSq3FwZYCPD0L5Yw7oOZ0M0VaN1gW5V1UBhbhs7alaKk8riZMmOS1
         qomulvfy+G5BX4fE3EooSEDCHnAzCSEEoqZpFhYnLYbMdJnXSeAr1aUVfLyIMkJQRK8h
         XuCgz0ucYy6MFKI7kL7/0LV+DARWYxi5cGUMRHn2vjw8Yncuj7HJjP8DyhpoQpRQuiyg
         Loa4cwgZ5OU3ESr3yOfwydqwHo+XhH+1MiJ1YEVFpbl2nTTdp53cwuqYUpV1NUMtjoSD
         fRoy0NAYCC8dpRJsIlS3m75yAgnEzB8VP5vlJcH/+hx/UPPC4chkhk6zMWqbxcrFDAOO
         yo+A==
X-Gm-Message-State: AOAM530qiFGI7bQ6y9BypMFRFmxJacsJGvcE0TUva03coAb1SiSarXUF
        d6bi3hXYkbmg9r0lXTQmWWQlbUrggpyk16D8STPiyA==
X-Google-Smtp-Source: ABdhPJzhQLbwuALA5FW/+KP4fjqgY42IVvKWwopAXm9gLtPY6eWE+V3FQuGz2ILwcd4KXoCfGjg2ecRgEPuXyFtYrK8=
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr1107570wmq.166.1641884245200;
 Mon, 10 Jan 2022 22:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-7-dlatypov@google.com>
In-Reply-To: <20220108012304.1049587-7-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 11 Jan 2022 14:57:13 +0800
Message-ID: <CABVgOSkOqMkPNUWpn+eavb0ykv+psbRAEEv0sQfd7xpG0zmogQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] kunit: drop unused assert_type from kunit_assert and
 clean up macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 8, 2022 at 9:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This field has been split out from kunit_assert to make the struct less
> heavy along with the filename and line number.
>
> This change drops the assert_type field and cleans up all the macros
> that were plumbing assert_type into kunit_assert.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me. Anything that simplifies these macros is a good
thing, in my opinion.

One minor formatting nitpick below.

Reviewed-by: David Gow <davidgow@google.com>

-- David


>  include/kunit/assert.h | 46 +++++++++++++-----------------------------
>  include/kunit/test.h   | 14 +++++--------
>  2 files changed, 19 insertions(+), 41 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 4f91dbdb886a..21299232c120 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -42,7 +42,6 @@ struct kunit_loc {
>
>  /**
>   * struct kunit_assert - Data for printing a failed assertion or expectation.
> - * @type: the type (either an expectation or an assertion) of this kunit_assert.
>   * @message: an optional message to provide additional context.
>   * @format: a function which formats the data in this kunit_assert to a string.
>   *
> @@ -50,7 +49,6 @@ struct kunit_loc {
>   * format a string to a user reporting the failure.
>   */
>  struct kunit_assert {
> -       enum kunit_assert_type type; // TODO(dlatypov@google.com): delete this
>         struct va_format message;
>         void (*format)(const struct kunit_assert *assert,
>                        struct string_stream *stream);
> @@ -66,13 +64,11 @@ struct kunit_assert {
>
>  /**
>   * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
> - * @assert_type: The type (assertion or expectation) of this kunit_assert.
>   * @fmt: The formatting function which builds a string out of this kunit_assert.
>   *
>   * The base initializer for a &struct kunit_assert.
>   */
> -#define KUNIT_INIT_ASSERT_STRUCT(assert_type, fmt) {                          \
> -       .type = assert_type,                                                   \
> +#define KUNIT_INIT_ASSERT_STRUCT(fmt) {                                               \
>         .message = KUNIT_INIT_VA_FMT_NULL,                                     \
>         .format = fmt                                                          \
>  }
> @@ -98,15 +94,13 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
>                               struct string_stream *stream);
>
>  /**
> - * KUNIT_INIT_FAIL_ASSERT_STRUCT() - Initializer for &struct kunit_fail_assert.
> - * @type: The type (assertion or expectation) of this kunit_assert.
> + * KUNIT_INIT_FAIL_ASSERT_STRUCT - Initializer for &struct kunit_fail_assert.
>   *
>   * Initializes a &struct kunit_fail_assert. Intended to be used in
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
> -#define KUNIT_INIT_FAIL_ASSERT_STRUCT(type) {                         \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> -                                          kunit_fail_assert_format)           \
> +#define KUNIT_INIT_FAIL_ASSERT_STRUCT {                                        \
> +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_fail_assert_format)    \
>  }
>
>  /**
> @@ -130,16 +124,14 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
>
>  /**
>   * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
> - * @type: The type (assertion or expectation) of this kunit_assert.
>   * @cond: A string representation of the expression asserted true or false.
>   * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
>   *
>   * Initializes a &struct kunit_unary_assert. Intended to be used in
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
> -#define KUNIT_INIT_UNARY_ASSERT_STRUCT(type, cond, expect_true) {             \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> -                                          kunit_unary_assert_format),         \
> +#define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {                   \
> +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_unary_assert_format),         \
>         .condition = cond,                                                     \
>         .expected_true = expect_true                                           \
>  }
> @@ -166,16 +158,14 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>  /**
>   * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
>   *     &struct kunit_ptr_not_err_assert.
> - * @type: The type (assertion or expectation) of this kunit_assert.
>   * @txt: A string representation of the expression passed to the expectation.
>   * @val: The actual evaluated pointer value of the expression.
>   *
>   * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
> -#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(type, txt, val) {                               \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> -                                          kunit_ptr_not_err_assert_format),   \
> +#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {                             \
> +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_ptr_not_err_assert_format),   \
>         .text = txt,                                                           \
>         .value = val                                                           \
>  }
> @@ -209,7 +199,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>  /**
>   * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
>   *     &struct kunit_binary_assert.
> - * @type: The type (assertion or expectation) of this kunit_assert.
>   * @op_str: A string representation of the comparison operator (e.g. "==").
>   * @left_str: A string representation of the expression in the left slot.
>   * @left_val: The actual evaluated value of the expression in the left slot.
> @@ -219,14 +208,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>   * Initializes a &struct kunit_binary_assert. Intended to be used in
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
> -#define KUNIT_INIT_BINARY_ASSERT_STRUCT(type,                                 \
> -                                       op_str,                                \
> +#define KUNIT_INIT_BINARY_ASSERT_STRUCT(op_str,                                       \
>                                         left_str,                              \
>                                         left_val,                              \
>                                         right_str,                             \
>                                         right_val) {                           \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> -                                          kunit_binary_assert_format),        \
> +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_assert_format),        \
>         .operation = op_str,                                                   \
>         .left_text = left_str,                                                 \
>         .left_value = left_val,                                                \
> @@ -273,14 +260,12 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>   * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
> -#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(type,                             \
> -                                           op_str,                            \
> +#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(op_str,                           \
>                                             left_str,                          \
>                                             left_val,                          \
>                                             right_str,                         \
>                                             right_val) {                       \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> -                                          kunit_binary_ptr_assert_format),    \
> +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_ptr_assert_format),    \
>         .operation = op_str,                                                   \
>         .left_text = left_str,                                                 \
>         .left_value = left_val,                                                \
> @@ -317,7 +302,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>  /**
>   * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
>   *     &struct kunit_binary_str_assert.
> - * @type: The type (assertion or expectation) of this kunit_assert.
>   * @op_str: A string representation of the comparison operator (e.g. "==").
>   * @left_str: A string representation of the expression in the left slot.
>   * @left_val: The actual evaluated value of the expression in the left slot.
> @@ -327,14 +311,12 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>   * Initializes a &struct kunit_binary_str_assert. Intended to be used in
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
> -#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(type,                             \
> -                                           op_str,                            \
> +#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(op_str,                           \
>                                             left_str,                          \
>                                             left_val,                          \
>                                             right_str,                         \
>                                             right_val) {                       \
> -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> -                                          kunit_binary_str_assert_format),    \
> +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_str_assert_format),    \
>         .operation = op_str,                                                   \
>         .left_text = left_str,                                                 \
>         .left_value = left_val,                                                \
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 6e201b45ada6..6f9074ec1995 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -795,7 +795,7 @@ void kunit_failed_assertion(struct kunit *test,
>                         assert_type,                                           \
>                         false,                                                 \
>                         kunit_fail_assert,                                     \
> -                       KUNIT_INIT_FAIL_ASSERT_STRUCT(assert_type),      \
> +                       KUNIT_INIT_FAIL_ASSERT_STRUCT,                        \

The '\' at the end of this line is misaligned. (The others seem fine,
but it's possible I missed one.)




>                         fmt,                                                   \
>                         ##__VA_ARGS__)
>
> @@ -826,8 +826,7 @@ void kunit_failed_assertion(struct kunit *test,
>                         assert_type,                                           \
>                         !!(condition) == !!expected_true,                      \
>                         kunit_unary_assert,                                    \
> -                       KUNIT_INIT_UNARY_ASSERT_STRUCT(assert_type,            \
> -                                                      #condition,             \
> +                       KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,             \
>                                                        expected_true),         \
>                         fmt,                                                   \
>                         ##__VA_ARGS__)
> @@ -885,8 +884,7 @@ do {                                                                               \
>                         assert_type,                                           \
>                         __left op __right,                                     \
>                         assert_class,                                          \
> -                       ASSERT_CLASS_INIT(assert_type,                         \
> -                                         #op,                                 \
> +                       ASSERT_CLASS_INIT(#op,                                 \
>                                           #left,                               \
>                                           __left,                              \
>                                           #right,                              \
> @@ -1240,8 +1238,7 @@ do {                                                                             \
>                         assert_type,                                           \
>                         strcmp(__left, __right) op 0,                          \
>                         kunit_binary_str_assert,                               \
> -                       KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(assert_type,       \
> -                                                       #op,                   \
> +                       KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(#op,               \
>                                                         #left,                 \
>                                                         __left,                \
>                                                         #right,                \
> @@ -1300,8 +1297,7 @@ do {                                                                             \
>                         assert_type,                                           \
>                         !IS_ERR_OR_NULL(__ptr),                                \
>                         kunit_ptr_not_err_assert,                              \
> -                       KUNIT_INIT_PTR_NOT_ERR_STRUCT(assert_type,             \
> -                                                     #ptr,                    \
> +                       KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr,                    \
>                                                       __ptr),                  \
>                         fmt,                                                   \
>                         ##__VA_ARGS__);                                        \
> --
> 2.34.1.575.g55b058a8bb-goog
>
