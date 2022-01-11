Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEBB48B9BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 22:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245388AbiAKVff (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 16:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245379AbiAKVff (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 16:35:35 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D88C06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 13:35:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l15so795566pls.7
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 13:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdG2m53ETOlwMcbtFF/x/1vOl4+46+U/a5/nmfTE6Vk=;
        b=EZz319cLAu+4PScX8dgMP6dU9/mgBBHAk2VG0B+wkbo0P93Jah9peK6qTQflxrJAHt
         Qy0xc0znqWUeFq1tEsrf4wHS7ijNqxGnYyfaKhz+Z6OhkFD4L3VtHOgIBxKLZLub9zrs
         RANnBjtsNi1+96VZDQFA33Y+Wwy7MCDDjvqjG0ZeNcYONwJikuipU3C0fbYT0shcqJ+y
         2oGtld1THKjaI/FQOtCNySoylAI7Fh3ca1EwGnfvE2VHmqMKQ5yv5J7QYKn8EyPaAj6J
         047GxbAt17M/QY9UmHx3USQvjdJ+cMWO30ZKhQ4S9KF1ZOgeF3LVejGFAQdSlWGvp3+6
         7a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdG2m53ETOlwMcbtFF/x/1vOl4+46+U/a5/nmfTE6Vk=;
        b=zH2DK8NOVFb+5g4j69oP6BFyXx9T2P0t0hKPvuqpyZgj1CK3gCo8Q5CSSCsyH6WJ4B
         W6Yi6mVWKJNTsvnY9fEoFYNwi909cmRWR7PXbBakG2POW+3KVRB7yGRBe0d2GSXu1vJZ
         K6lLLlXGD/b+N9PPV3BhV488ihatj3bpH3YqrpoFhwbNQcjxj7OViHyUFtCs7RSWFYTi
         6EX9IasTsB7zdj2xDH1fv2lVmqKQaKM1YGcEhamLbEpCQBYo3heJOmwdVsswU+0Hk3jS
         f7IirqWY45Z72xQdNOZrrDTdbehmwipaK6ASC7cQfvy0afrPJJ0inoaZ2hB4lrIpwL2H
         9qgg==
X-Gm-Message-State: AOAM530x0yJCWxzsAG/iouDNjNzx06RgRGsyHFg4gLYx2/HglwOxLfWX
        1APAk0t6hG32qqUlGn2k4yZJy0uCqnktP3ha1hU12vbEOYYwWz9E
X-Google-Smtp-Source: ABdhPJxL92ODFttquZ2LXPWMxI2KpYTx0d7CV4KWFXVh6NNJhSNI2N/vKK+FxD32zaVWJoRfCv3llDKqKsS7uuob7gA=
X-Received: by 2002:a63:b942:: with SMTP id v2mr5588485pgo.407.1641936934044;
 Tue, 11 Jan 2022 13:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com> <20220111194231.1797841-6-dlatypov@google.com>
In-Reply-To: <20220111194231.1797841-6-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Jan 2022 16:35:23 -0500
Message-ID: <CAFd5g46bCr4DEqruLbtgcLOpuPQUgS32ePDicrezBwOXL_r5Hg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] kunit: split out part of kunit_assert into a
 static const
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 11, 2022 at 2:42 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This is per Linus's suggestion in [1].
>
> The issue there is that every KUNIT_EXPECT/KUNIT_ASSERT puts a
> kunit_assert object onto the stack. Normally we rely on compilers to
> elide this, but when that doesn't work out, this blows up the stack
> usage of kunit test functions.
>
> We can move some data off the stack by making it static.
> This change introduces a new `struct kunit_loc` to hold the file and
> line number and then just passing assert_type (EXPECT or ASSERT) as an
> argument.
>
> In [1], it was suggested to also move out the format string as well, but
> users could theoretically craft a format string at runtime, so we can't.
>
> This change leaves a copy of `assert_type` in kunit_assert for now
> because cleaning up all the macros to not pass it around is a bit more
> involved.
>
> Here's an example of the expanded code for KUNIT_FAIL():
> if (__builtin_expect(!!(!(false)), 0)) {
>   static const struct kunit_loc loc = { .file = ... };
>   struct kunit_fail_assert __assertion = { .assert = { .type ...  };
>   kunit_do_failed_assertion(test, &loc, KUNIT_EXPECTATION, &__assertion.assert, ...);
> };
>
> [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: David Gow <davidgow@google.com>

One question below, but other than that,

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  include/kunit/assert.h | 25 ++++++++++++++++---------
>  include/kunit/test.h   | 12 +++++++++++-
>  lib/kunit/assert.c     |  9 +++++----
>  lib/kunit/test.c       | 15 +++++++++------
>  4 files changed, 41 insertions(+), 20 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 3da6c792496c..4f91dbdb886a 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -28,11 +28,21 @@ enum kunit_assert_type {
>         KUNIT_EXPECTATION,
>  };
>
> +/**
> + * struct kunit_loc - Identifies the source location of a line of code.
> + * @line: the line number in the file.
> + * @file: the file name.
> + */
> +struct kunit_loc {
> +       int line;
> +       const char *file;
> +};
> +
> +#define KUNIT_CURRENT_LOC { .file = __FILE__, .line = __LINE__ }
> +
>  /**
>   * struct kunit_assert - Data for printing a failed assertion or expectation.
>   * @type: the type (either an expectation or an assertion) of this kunit_assert.
> - * @line: the source code line number that the expectation/assertion is at.
> - * @file: the file path of the source file that the expectation/assertion is in.
>   * @message: an optional message to provide additional context.
>   * @format: a function which formats the data in this kunit_assert to a string.
>   *
> @@ -40,9 +50,7 @@ enum kunit_assert_type {
>   * format a string to a user reporting the failure.
>   */
>  struct kunit_assert {
> -       enum kunit_assert_type type;
> -       int line;
> -       const char *file;
> +       enum kunit_assert_type type; // TODO(dlatypov@google.com): delete this

Can you provide some context for this?

>         struct va_format message;
>         void (*format)(const struct kunit_assert *assert,
>                        struct string_stream *stream);
> @@ -65,14 +73,13 @@ struct kunit_assert {
>   */
>  #define KUNIT_INIT_ASSERT_STRUCT(assert_type, fmt) {                          \
>         .type = assert_type,                                                   \
> -       .file = __FILE__,                                                      \
> -       .line = __LINE__,                                                      \
>         .message = KUNIT_INIT_VA_FMT_NULL,                                     \
>         .format = fmt                                                          \
>  }
>
> -void kunit_base_assert_format(const struct kunit_assert *assert,
> -                             struct string_stream *stream);
> +void kunit_assert_prologue(const struct kunit_loc *loc,
> +                          enum kunit_assert_type type,
> +                          struct string_stream *stream);
>
>  void kunit_assert_print_msg(const struct kunit_assert *assert,
>                             struct string_stream *stream);
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 25ea3bce6663..7b752175e614 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
