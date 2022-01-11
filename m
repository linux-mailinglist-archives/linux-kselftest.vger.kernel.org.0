Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2996348B73F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 20:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiAKTV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 14:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiAKTV2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 14:21:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AB4C06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:21:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i5so273823edf.9
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGLy45IyW7t3NPBI6jzCK8xwZXwNtX5diKcB1uVS9k8=;
        b=T4+n2vHFSQ9oAQC2BCtgIUIFzcfOQfT4SJ9/QgfX+ulNwxehWFbDte6iljFy71KLbo
         EX21t0rCsYdUMkvtXzPSAgWdAY7iFKcYFK6xYmTgRqh0gPmi8Hg+boWHHwuL3uPP6lKI
         joBDALvGR+oT4A5bJP3pUfuJAEX+7NhUTeIYv1JNumoEmF21FyVlpXpB0QOxxcCarPhz
         UFOQCbul75sljQ93LqZegtRoWNZO722gXQtkx85hs2Yr3RHH9Wj5PGwyUxeJW4YZP5xM
         mLzdEnyP/1E/WuX2HMp9jOo6FgeVAkTNu8DaX2k6wyGsNmw2snF3vOb8TACvU++bX9S7
         pywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGLy45IyW7t3NPBI6jzCK8xwZXwNtX5diKcB1uVS9k8=;
        b=GeSvI4wUtWZI5pGFX2StxggBxWdlUUnX/+CG+GDGo/fp1WKcBqL27eZd0TDTTpF0QA
         /Oi1qBYikD5wMrMdZPZt5AZGifT0fXxYmy9UGfM417IgXiOw4MqZEdAIBPkzPGLOYf+Q
         n1yoP+RSuW9qPXka1ckNzlqrjBDh47TXdvxaZ9TtHJW24wPBpeHgVqNL2CCw9T04a4tt
         m/g66gGkhZ0QmtTqFgJ2zOMdlZEaWEN1WlG3+WStH1x4m2iMGwq1tOgSCpOb/vAOagJe
         zFpYD5tPO4P8MD8tFt/WRn5/UJ98mqpmoibbjFX9LmByuKOq//rIYfmjvWf286motZZL
         qI1g==
X-Gm-Message-State: AOAM532Y6zOY/Gs3KblOHNgbwGAGnWGOIVcjhcjLYHRn6t5B6xs1eJDx
        xyS7tI2ILv1EIiHz3KNp4L0tVvFCUDrbeJG3I2WoeA==
X-Google-Smtp-Source: ABdhPJzfyPtlcG9cHKa1LzvrHaCSDU56RbnAfxx9Bfd2z2AEEjvi5dc+/nuNJgrMoPNKNWQujeFCvYuGcLM98n2PdhQ=
X-Received: by 2002:a17:907:7f86:: with SMTP id qk6mr3330069ejc.425.1641928886418;
 Tue, 11 Jan 2022 11:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-7-dlatypov@google.com>
 <CABVgOSkOqMkPNUWpn+eavb0ykv+psbRAEEv0sQfd7xpG0zmogQ@mail.gmail.com>
In-Reply-To: <CABVgOSkOqMkPNUWpn+eavb0ykv+psbRAEEv0sQfd7xpG0zmogQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 11 Jan 2022 11:21:14 -0800
Message-ID: <CAGS_qxpOG76Dn62Mi0h4KV3Bvu4rqGo1GpagS-aK_k8eceZA8g@mail.gmail.com>
Subject: Re: [PATCH 6/6] kunit: drop unused assert_type from kunit_assert and
 clean up macros
To:     David Gow <davidgow@google.com>
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

On Mon, Jan 10, 2022 at 10:57 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Jan 8, 2022 at 9:23 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > This field has been split out from kunit_assert to make the struct less
> > heavy along with the filename and line number.
> >
> > This change drops the assert_type field and cleans up all the macros
> > that were plumbing assert_type into kunit_assert.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Looks good to me. Anything that simplifies these macros is a good
> thing, in my opinion.
>
> One minor formatting nitpick below.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> -- David
>
>
> >  include/kunit/assert.h | 46 +++++++++++++-----------------------------
> >  include/kunit/test.h   | 14 +++++--------
> >  2 files changed, 19 insertions(+), 41 deletions(-)
> >
> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > index 4f91dbdb886a..21299232c120 100644
> > --- a/include/kunit/assert.h
> > +++ b/include/kunit/assert.h
> > @@ -42,7 +42,6 @@ struct kunit_loc {
> >
> >  /**
> >   * struct kunit_assert - Data for printing a failed assertion or expectation.
> > - * @type: the type (either an expectation or an assertion) of this kunit_assert.
> >   * @message: an optional message to provide additional context.
> >   * @format: a function which formats the data in this kunit_assert to a string.
> >   *
> > @@ -50,7 +49,6 @@ struct kunit_loc {
> >   * format a string to a user reporting the failure.
> >   */
> >  struct kunit_assert {
> > -       enum kunit_assert_type type; // TODO(dlatypov@google.com): delete this
> >         struct va_format message;
> >         void (*format)(const struct kunit_assert *assert,
> >                        struct string_stream *stream);
> > @@ -66,13 +64,11 @@ struct kunit_assert {
> >
> >  /**
> >   * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
> > - * @assert_type: The type (assertion or expectation) of this kunit_assert.
> >   * @fmt: The formatting function which builds a string out of this kunit_assert.
> >   *
> >   * The base initializer for a &struct kunit_assert.
> >   */
> > -#define KUNIT_INIT_ASSERT_STRUCT(assert_type, fmt) {                          \
> > -       .type = assert_type,                                                   \
> > +#define KUNIT_INIT_ASSERT_STRUCT(fmt) {                                               \
> >         .message = KUNIT_INIT_VA_FMT_NULL,                                     \
> >         .format = fmt                                                          \
> >  }
> > @@ -98,15 +94,13 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
> >                               struct string_stream *stream);
> >
> >  /**
> > - * KUNIT_INIT_FAIL_ASSERT_STRUCT() - Initializer for &struct kunit_fail_assert.
> > - * @type: The type (assertion or expectation) of this kunit_assert.
> > + * KUNIT_INIT_FAIL_ASSERT_STRUCT - Initializer for &struct kunit_fail_assert.
> >   *
> >   * Initializes a &struct kunit_fail_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_FAIL_ASSERT_STRUCT(type) {                         \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> > -                                          kunit_fail_assert_format)           \
> > +#define KUNIT_INIT_FAIL_ASSERT_STRUCT {                                        \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_fail_assert_format)    \
> >  }
> >
> >  /**
> > @@ -130,16 +124,14 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
> >
> >  /**
> >   * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
> > - * @type: The type (assertion or expectation) of this kunit_assert.
> >   * @cond: A string representation of the expression asserted true or false.
> >   * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
> >   *
> >   * Initializes a &struct kunit_unary_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_UNARY_ASSERT_STRUCT(type, cond, expect_true) {             \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> > -                                          kunit_unary_assert_format),         \
> > +#define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {                   \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_unary_assert_format),         \
> >         .condition = cond,                                                     \
> >         .expected_true = expect_true                                           \
> >  }
> > @@ -166,16 +158,14 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
> >  /**
> >   * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
> >   *     &struct kunit_ptr_not_err_assert.
> > - * @type: The type (assertion or expectation) of this kunit_assert.
> >   * @txt: A string representation of the expression passed to the expectation.
> >   * @val: The actual evaluated pointer value of the expression.
> >   *
> >   * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(type, txt, val) {                               \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> > -                                          kunit_ptr_not_err_assert_format),   \
> > +#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {                             \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_ptr_not_err_assert_format),   \
> >         .text = txt,                                                           \
> >         .value = val                                                           \
> >  }
> > @@ -209,7 +199,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >  /**
> >   * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
> >   *     &struct kunit_binary_assert.
> > - * @type: The type (assertion or expectation) of this kunit_assert.
> >   * @op_str: A string representation of the comparison operator (e.g. "==").
> >   * @left_str: A string representation of the expression in the left slot.
> >   * @left_val: The actual evaluated value of the expression in the left slot.
> > @@ -219,14 +208,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >   * Initializes a &struct kunit_binary_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_BINARY_ASSERT_STRUCT(type,                                 \
> > -                                       op_str,                                \
> > +#define KUNIT_INIT_BINARY_ASSERT_STRUCT(op_str,                                       \
> >                                         left_str,                              \
> >                                         left_val,                              \
> >                                         right_str,                             \
> >                                         right_val) {                           \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> > -                                          kunit_binary_assert_format),        \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_assert_format),        \
> >         .operation = op_str,                                                   \
> >         .left_text = left_str,                                                 \
> >         .left_value = left_val,                                                \
> > @@ -273,14 +260,12 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
> >   * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(type,                             \
> > -                                           op_str,                            \
> > +#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(op_str,                           \
> >                                             left_str,                          \
> >                                             left_val,                          \
> >                                             right_str,                         \
> >                                             right_val) {                       \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> > -                                          kunit_binary_ptr_assert_format),    \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_ptr_assert_format),    \
> >         .operation = op_str,                                                   \
> >         .left_text = left_str,                                                 \
> >         .left_value = left_val,                                                \
> > @@ -317,7 +302,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> >  /**
> >   * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
> >   *     &struct kunit_binary_str_assert.
> > - * @type: The type (assertion or expectation) of this kunit_assert.
> >   * @op_str: A string representation of the comparison operator (e.g. "==").
> >   * @left_str: A string representation of the expression in the left slot.
> >   * @left_val: The actual evaluated value of the expression in the left slot.
> > @@ -327,14 +311,12 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> >   * Initializes a &struct kunit_binary_str_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(type,                             \
> > -                                           op_str,                            \
> > +#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(op_str,                           \
> >                                             left_str,                          \
> >                                             left_val,                          \
> >                                             right_str,                         \
> >                                             right_val) {                       \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> > -                                          kunit_binary_str_assert_format),    \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(kunit_binary_str_assert_format),    \
> >         .operation = op_str,                                                   \
> >         .left_text = left_str,                                                 \
> >         .left_value = left_val,                                                \
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 6e201b45ada6..6f9074ec1995 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -795,7 +795,7 @@ void kunit_failed_assertion(struct kunit *test,
> >                         assert_type,                                           \
> >                         false,                                                 \
> >                         kunit_fail_assert,                                     \
> > -                       KUNIT_INIT_FAIL_ASSERT_STRUCT(assert_type),      \
> > +                       KUNIT_INIT_FAIL_ASSERT_STRUCT,                        \
>
> The '\' at the end of this line is misaligned. (The others seem fine,
> but it's possible I missed one.)

Fixed, will include in v2.

>
>
>
>
> >                         fmt,                                                   \
> >                         ##__VA_ARGS__)
> >
> > @@ -826,8 +826,7 @@ void kunit_failed_assertion(struct kunit *test,
> >                         assert_type,                                           \
> >                         !!(condition) == !!expected_true,                      \
> >                         kunit_unary_assert,                                    \
> > -                       KUNIT_INIT_UNARY_ASSERT_STRUCT(assert_type,            \
> > -                                                      #condition,             \
> > +                       KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,             \
> >                                                        expected_true),         \
> >                         fmt,                                                   \
> >                         ##__VA_ARGS__)
> > @@ -885,8 +884,7 @@ do {                                                                               \
> >                         assert_type,                                           \
> >                         __left op __right,                                     \
> >                         assert_class,                                          \
> > -                       ASSERT_CLASS_INIT(assert_type,                         \
> > -                                         #op,                                 \
> > +                       ASSERT_CLASS_INIT(#op,                                 \
> >                                           #left,                               \
> >                                           __left,                              \
> >                                           #right,                              \
> > @@ -1240,8 +1238,7 @@ do {                                                                             \
> >                         assert_type,                                           \
> >                         strcmp(__left, __right) op 0,                          \
> >                         kunit_binary_str_assert,                               \
> > -                       KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(assert_type,       \
> > -                                                       #op,                   \
> > +                       KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(#op,               \
> >                                                         #left,                 \
> >                                                         __left,                \
> >                                                         #right,                \
> > @@ -1300,8 +1297,7 @@ do {                                                                             \
> >                         assert_type,                                           \
> >                         !IS_ERR_OR_NULL(__ptr),                                \
> >                         kunit_ptr_not_err_assert,                              \
> > -                       KUNIT_INIT_PTR_NOT_ERR_STRUCT(assert_type,             \
> > -                                                     #ptr,                    \
> > +                       KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr,                    \
> >                                                       __ptr),                  \
> >                         fmt,                                                   \
> >                         ##__VA_ARGS__);                                        \
> > --
> > 2.34.1.575.g55b058a8bb-goog
> >
