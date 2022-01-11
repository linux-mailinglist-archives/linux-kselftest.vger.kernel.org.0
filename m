Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C848B5B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 19:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345171AbiAKSe1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 13:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345142AbiAKSe0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 13:34:26 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7EDC06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 10:34:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i5so17158964edf.9
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 10:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbcJr69eo4lbU4zhrQw9YdKDn5i2JTpJM9CjQKhnU08=;
        b=D6oMv/3KxCor+0QrXJYT489/fgORrqWm+mSQ/sJBnsvcdNtGSFaPAVbCp+b+GKYUal
         l3rRqEMKt6ejHbQaXKhJt87/bc3G6Xz2QP9kYL8BEO9/m/worSSZra/vRNlaqTxh/1bG
         hqchk+8nlXMLtCuBKjbSHNuixJzydsFoVSZ9PQNhyvL2hgsc9Lp3x42skMLVdkqvPuzj
         fnGNgfk27eylvR2SBuY3IKq+SlGwfRBIzni4cvAzK98jwYelE3saEM+OonsqKfTs7NZF
         ds9H35AjEAsFV34WCjLwo6tz0VUpXz+NrSbN5fgNaqikn9KxRdiAyWAQwSx/0iefVpvJ
         cYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbcJr69eo4lbU4zhrQw9YdKDn5i2JTpJM9CjQKhnU08=;
        b=F6uiIIPyyLqaSm8cqix1wIKV9E2diYx0JN05S5eWmXC5gtYU2Do7Qy+ufSsF96NoKt
         /aUiYgGc8hmtsnhQjjj1vAbxbLALFXHhcPEmnCjem2iqHXhxuIT9EtL0Xe6xGACZmlmj
         fE77wlztjO03s46D66Dyuru/Z3f6dZdF5U13bqssYGLCMGo9+WGyRGG9V7uB6T87iSEE
         /+aYy2rzVR2JSuyeORCJd81XBCrUBbagdwCZpExgh6YTAAw9SWz8R8SvulmlbxXxmKIK
         vmqWJ/bbh6RGj9wTnFMyDV9BgdFVoI/FGG6IYV++ln1rJQdWyZ9ArlsgZ6uy/rzBKnZh
         a9Bw==
X-Gm-Message-State: AOAM532vUqAeyBZ1VrrcEr2UcvtXykCAytAjrJsLsgWrNRsi0gWYskt6
        O8UN5KVFJ5ri1hYFQ5zFVGFNIUmUXGc5CajspJiJqw==
X-Google-Smtp-Source: ABdhPJxqZOr6wztclNOl/uOgqeq9w+nyJjlLo1hy9SEyN9T5uaZt3WLH9SgPzY/2RaJ8zBNe8nP6IirH35xCzZKjDJM=
X-Received: by 2002:a17:907:7f86:: with SMTP id qk6mr3200918ejc.425.1641926064066;
 Tue, 11 Jan 2022 10:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-4-dlatypov@google.com>
 <CABVgOSmCNTrObvALYr-fg5GyAjkNigUwS+amwQqK3co1YYEDQQ@mail.gmail.com>
In-Reply-To: <CABVgOSmCNTrObvALYr-fg5GyAjkNigUwS+amwQqK3co1YYEDQQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 11 Jan 2022 10:34:12 -0800
Message-ID: <CAGS_qxoKyxWnnCq4C8ifoH70Cx5Q_LisbOPW-6x75BQaE8rm_g@mail.gmail.com>
Subject: Re: [PATCH 3/6] kunit: drop unused kunit* field in kunit_assert
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 10, 2022 at 10:51 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Jan 8, 2022 at 9:23 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > The `struct kunit* test` field in kunit_assert is unused.
> > Note: we have access to `test` where we need it via the string_stream
> > object. I assume `test` in `kunit_assert` predates this and was leftover
> > after some refactoring.
>
> Note that I don't like the idea of accessing 'test' via the string
> stream in general, but we don't seem to ever actually do this (as far
> as I can tell). Maybe if we wanted to be super nitpicky, rewording the
> note to say "if we need it" rather than "where we need it" would be
> clearer.

Ah, I had meant "where we need it" == "where string_stream needs it,
as its the only user that doesn't get test passed as a parameter
everywhere".

Updated the wording to
  Note: string_stream needs it, but it has its own `test` field.

>
> >
> > This patch removes the field and cleans up the macros to avoid
> > needlessly passing around `test`.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Looks good, thanks!
>
> Reviewed-by: David Gow <davidgow@google.com>
>
>
> >  include/kunit/assert.h | 45 ++++++++++++------------------------------
> >  include/kunit/test.h   | 14 +++++--------
> >  2 files changed, 18 insertions(+), 41 deletions(-)
> >
> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > index ad889b539ab3..3da6c792496c 100644
> > --- a/include/kunit/assert.h
> > +++ b/include/kunit/assert.h
> > @@ -30,7 +30,6 @@ enum kunit_assert_type {
> >
> >  /**
> >   * struct kunit_assert - Data for printing a failed assertion or expectation.
> > - * @test: the test case this expectation/assertion is associated with.
> >   * @type: the type (either an expectation or an assertion) of this kunit_assert.
> >   * @line: the source code line number that the expectation/assertion is at.
> >   * @file: the file path of the source file that the expectation/assertion is in.
> > @@ -41,7 +40,6 @@ enum kunit_assert_type {
> >   * format a string to a user reporting the failure.
> >   */
> >  struct kunit_assert {
> > -       struct kunit *test;
> >         enum kunit_assert_type type;
> >         int line;
> >         const char *file;
> > @@ -60,14 +58,12 @@ struct kunit_assert {
> >
> >  /**
> >   * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
> > - * @kunit: The test case that this expectation/assertion is associated with.
> >   * @assert_type: The type (assertion or expectation) of this kunit_assert.
> >   * @fmt: The formatting function which builds a string out of this kunit_assert.
> >   *
> >   * The base initializer for a &struct kunit_assert.
> >   */
> > -#define KUNIT_INIT_ASSERT_STRUCT(kunit, assert_type, fmt) {                   \
> > -       .test = kunit,                                                         \
> > +#define KUNIT_INIT_ASSERT_STRUCT(assert_type, fmt) {                          \
> >         .type = assert_type,                                                   \
> >         .file = __FILE__,                                                      \
> >         .line = __LINE__,                                                      \
> > @@ -96,15 +92,13 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
> >
> >  /**
> >   * KUNIT_INIT_FAIL_ASSERT_STRUCT() - Initializer for &struct kunit_fail_assert.
> > - * @test: The test case that this expectation/assertion is associated with.
> >   * @type: The type (assertion or expectation) of this kunit_assert.
> >   *
> >   * Initializes a &struct kunit_fail_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {                           \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(test,                               \
> > -                                          type,                               \
> > +#define KUNIT_INIT_FAIL_ASSERT_STRUCT(type) {                         \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> >                                            kunit_fail_assert_format)           \
> >  }
> >
> > @@ -129,7 +123,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
> >
> >  /**
> >   * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
> > - * @test: The test case that this expectation/assertion is associated with.
> >   * @type: The type (assertion or expectation) of this kunit_assert.
> >   * @cond: A string representation of the expression asserted true or false.
> >   * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
> > @@ -137,9 +130,8 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
> >   * Initializes a &struct kunit_unary_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_UNARY_ASSERT_STRUCT(test, type, cond, expect_true) {               \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(test,                               \
> > -                                          type,                               \
> > +#define KUNIT_INIT_UNARY_ASSERT_STRUCT(type, cond, expect_true) {             \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> >                                            kunit_unary_assert_format),         \
> >         .condition = cond,                                                     \
> >         .expected_true = expect_true                                           \
> > @@ -167,7 +159,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
> >  /**
> >   * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
> >   *     &struct kunit_ptr_not_err_assert.
> > - * @test: The test case that this expectation/assertion is associated with.
> >   * @type: The type (assertion or expectation) of this kunit_assert.
> >   * @txt: A string representation of the expression passed to the expectation.
> >   * @val: The actual evaluated pointer value of the expression.
> > @@ -175,9 +166,8 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
> >   * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(test, type, txt, val) {                 \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(test,                               \
> > -                                          type,                               \
> > +#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(type, txt, val) {                               \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> >                                            kunit_ptr_not_err_assert_format),   \
> >         .text = txt,                                                           \
> >         .value = val                                                           \
> > @@ -212,7 +202,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >  /**
> >   * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
> >   *     &struct kunit_binary_assert.
> > - * @test: The test case that this expectation/assertion is associated with.
> >   * @type: The type (assertion or expectation) of this kunit_assert.
> >   * @op_str: A string representation of the comparison operator (e.g. "==").
> >   * @left_str: A string representation of the expression in the left slot.
> > @@ -223,15 +212,13 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >   * Initializes a &struct kunit_binary_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_BINARY_ASSERT_STRUCT(test,                                 \
> > -                                       type,                                  \
> > +#define KUNIT_INIT_BINARY_ASSERT_STRUCT(type,                                 \
> >                                         op_str,                                \
> >                                         left_str,                              \
> >                                         left_val,                              \
> >                                         right_str,                             \
> >                                         right_val) {                           \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(test,                               \
> > -                                          type,                               \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> >                                            kunit_binary_assert_format),        \
> >         .operation = op_str,                                                   \
> >         .left_text = left_str,                                                 \
> > @@ -269,7 +256,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
> >  /**
> >   * KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT() - Initializes a
> >   *     &struct kunit_binary_ptr_assert.
> > - * @test: The test case that this expectation/assertion is associated with.
> >   * @type: The type (assertion or expectation) of this kunit_assert.
> >   * @op_str: A string representation of the comparison operator (e.g. "==").
> >   * @left_str: A string representation of the expression in the left slot.
> > @@ -280,15 +266,13 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
> >   * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(test,                             \
> > -                                           type,                              \
> > +#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(type,                             \
> >                                             op_str,                            \
> >                                             left_str,                          \
> >                                             left_val,                          \
> >                                             right_str,                         \
> >                                             right_val) {                       \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(test,                               \
> > -                                          type,                               \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> >                                            kunit_binary_ptr_assert_format),    \
> >         .operation = op_str,                                                   \
> >         .left_text = left_str,                                                 \
> > @@ -326,7 +310,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> >  /**
> >   * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
> >   *     &struct kunit_binary_str_assert.
> > - * @test: The test case that this expectation/assertion is associated with.
> >   * @type: The type (assertion or expectation) of this kunit_assert.
> >   * @op_str: A string representation of the comparison operator (e.g. "==").
> >   * @left_str: A string representation of the expression in the left slot.
> > @@ -337,15 +320,13 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> >   * Initializes a &struct kunit_binary_str_assert. Intended to be used in
> >   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> >   */
> > -#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,                             \
> > -                                           type,                              \
> > +#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(type,                             \
> >                                             op_str,                            \
> >                                             left_str,                          \
> >                                             left_val,                          \
> >                                             right_str,                         \
> >                                             right_val) {                       \
> > -       .assert = KUNIT_INIT_ASSERT_STRUCT(test,                               \
> > -                                          type,                               \
> > +       .assert = KUNIT_INIT_ASSERT_STRUCT(type,                               \
> >                                            kunit_binary_str_assert_format),    \
> >         .operation = op_str,                                                   \
> >         .left_text = left_str,                                                 \
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 690a28dfc795..ebd45593321e 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -789,7 +789,7 @@ void kunit_failed_assertion(struct kunit *test,
> >         KUNIT_ASSERTION(test,                                                  \
> >                         false,                                                 \
> >                         kunit_fail_assert,                                     \
> > -                       KUNIT_INIT_FAIL_ASSERT_STRUCT(test, assert_type),      \
> > +                       KUNIT_INIT_FAIL_ASSERT_STRUCT(assert_type),      \
> >                         fmt,                                                   \
> >                         ##__VA_ARGS__)
> >
> > @@ -819,8 +819,7 @@ void kunit_failed_assertion(struct kunit *test,
> >         KUNIT_ASSERTION(test,                                                  \
> >                         !!(condition) == !!expected_true,                      \
> >                         kunit_unary_assert,                                    \
> > -                       KUNIT_INIT_UNARY_ASSERT_STRUCT(test,                   \
> > -                                                      assert_type,            \
> > +                       KUNIT_INIT_UNARY_ASSERT_STRUCT(assert_type,            \
> >                                                        #condition,             \
> >                                                        expected_true),         \
> >                         fmt,                                                   \
> > @@ -878,8 +877,7 @@ do {                                                                               \
> >         KUNIT_ASSERTION(test,                                                  \
> >                         __left op __right,                                     \
> >                         assert_class,                                          \
> > -                       ASSERT_CLASS_INIT(test,                                \
> > -                                         assert_type,                         \
> > +                       ASSERT_CLASS_INIT(assert_type,                         \
> >                                           #op,                                 \
> >                                           #left,                               \
> >                                           __left,                              \
> > @@ -1233,8 +1231,7 @@ do {                                                                             \
> >         KUNIT_ASSERTION(test,                                                  \
> >                         strcmp(__left, __right) op 0,                          \
> >                         kunit_binary_str_assert,                               \
> > -                       KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,              \
> > -                                                       assert_type,           \
> > +                       KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(assert_type,       \
> >                                                         #op,                   \
> >                                                         #left,                 \
> >                                                         __left,                \
> > @@ -1293,8 +1290,7 @@ do {                                                                             \
> >         KUNIT_ASSERTION(test,                                                  \
> >                         !IS_ERR_OR_NULL(__ptr),                                \
> >                         kunit_ptr_not_err_assert,                              \
> > -                       KUNIT_INIT_PTR_NOT_ERR_STRUCT(test,                    \
> > -                                                     assert_type,             \
> > +                       KUNIT_INIT_PTR_NOT_ERR_STRUCT(assert_type,             \
> >                                                       #ptr,                    \
> >                                                       __ptr),                  \
> >                         fmt,                                                   \
> > --
> > 2.34.1.575.g55b058a8bb-goog
> >
