Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC848B2E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 18:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbiAKRIC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 12:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241342AbiAKRHw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 12:07:52 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ABAC061759
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 09:07:51 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a18so68819708edj.7
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvSmAB4UDkgWPU3JkcEKexp9ZNEuqIz3KMzS+puOmsI=;
        b=hdareiLE5KYpwa23t1jYUbqEpvbMKicuhiSZHpGvFmfw5QIUj5DKpmYNbYzeGnVO8K
         SuVJNiXNkAOusCEihDZ0VYB0tD03IRoSBRRZpcSgShXU0w9+y1uqJY7FR18F6H8oQtLL
         0PFkeORNzHa5pJeE+UBBDG+m9DnrjyEz5CB0xOTVmUzabhppn2j4P8FE2puMqlec+51X
         Vhu8BClDhD2DD70ZFv0Wgd0FuxhnbBoLsRk57v0etupWIMQgxu2bzvRYg5jNC47Aji4I
         Rz3N0ASp11AUJXHKTEi/Yf4pL0PkagD9L6alrBzeGu3bG7RsQi7NoLBIXZFoPzej1hhx
         mqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvSmAB4UDkgWPU3JkcEKexp9ZNEuqIz3KMzS+puOmsI=;
        b=EiL/aKKww/QGfGM14zznSgKmxI8Dvcwd7xvGg20AS3kJ3jcfspb/hfDkNBegt+vrRy
         j/NyghJAXkDNlWsOZXbELKjjXmBlt916qHDkltFIl8Zt0zVUM1eI3RxPNSyDk4MKMchg
         9Cz2uVvLJ3ZzuO1QS66LcIm1GXv21wuBWlVP3kEPHGMKlyp0t2jQlocexvRbK28WN5HL
         ARvA5uKwi7a0bnxQBkO94dp3w3odBoYLEtxVj9pn18TTvLOxoliatiTxj73/JiHBhu7e
         7PpnGR4n7iFqHcfUkvD310N8vLCc1BY/yC9PwNt2kTZ18/eKFgBScd48l5PE9UOQfprt
         xmWQ==
X-Gm-Message-State: AOAM530y57TTyi+h1iBr8fIErtVxXPiqEmW94J2ZlgyNJzFEtiOgLxXi
        IF0q5x+6qaik/3snKwKvz+D1PBATqpAif9PLmzD/AyG7fkA=
X-Google-Smtp-Source: ABdhPJza9m9PTVbk+zscHT+VR1E+KfZ3bJyb0OKWY2t4oQUy0nD6EK1emcRKZGf4+vByae6nhQyM6RCv7oiC72kiVTE=
X-Received: by 2002:a17:907:6da4:: with SMTP id sb36mr4280419ejc.542.1641920869464;
 Tue, 11 Jan 2022 09:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-6-dlatypov@google.com>
 <CABVgOSnd3nUgM0Lgy4kLY9EiyTHSff8YYw4=NNGr6BQFyDCRbQ@mail.gmail.com>
In-Reply-To: <CABVgOSnd3nUgM0Lgy4kLY9EiyTHSff8YYw4=NNGr6BQFyDCRbQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 11 Jan 2022 09:07:38 -0800
Message-ID: <CAGS_qxpm3BMZWdtMsdwjR7bHMem=-xNq0Gzgk46J+X-1omYmiA@mail.gmail.com>
Subject: Re: [PATCH 5/6] kunit: split out part of kunit_assert into a static const
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 10, 2022 at 10:57 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Jan 8, 2022 at 9:23 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > This is per Linus's suggestion in [1].
> >
> > The issue there is that every KUNIT_EXPECT/KUNIT_ASSERT puts a
> > kunit_assert object onto the stack. Normally we rely on compilers to
> > elide this, but when that doesn't work out, this blows up the stack
> > usage of kunit test functions.
> >
> > We can move some data off the stack by making it static.
> > This change introduces a new `struct kunit_loc` to hold the file and
> > line number and then just passing assert_type (EXPECT or ASSERT) as an
> > argument.
>
> A part of me feels that logically, this struct is really
> "kunit_assert_static_data" (the collection of everything we can make
> static), rather than specifically reserved for location information,

That's exactly what I originally called it.
I was passing it around as
  const struct kunit_assert_data *data,
 and later
  const struct kunit_assert_static_data *data,

But "data" isn't really a readable name.
Especially not when being plumbed through layers of macros as we'd
have to do to move more data into it, see below.

So I settled for dropping kunit_assert_type from the struct so we
could have a more explicit name (kunit_loc) for now.

> but that's an uglier name. My only concern is that, if we do manage to
> make more things static const, will we want to rename this struct?

As noted in the cover letter, the other stuff we'd want to move out
are specific to each assertion type, thus making that trickier.

We could have

struct kunit_assert_static_data {
  struct kunit_loc loc;
  enum kunit_assert_type type;
  /* Optional fields: not all assertions will use these */
  const char *left;
  const char *right;
};

if we go down that path in the future.

I initially tried out going this way.
But it involved changing the macros a lot more, i.e. we pass around an
initializer for the assert struct right now, right? We'd need to also
pass around the kunit_assert_static_data initializer to allow the
flexibility to optionally set some of these fields now too.

Perhaps after trimming off a layer of indirection in the macros then
it won't be as unreadable...



>
> >
> > In [1], it was suggested to also move out the format string as well, but
> > users could theoretically craft a format string at runtime, so we can't.
> >
> > This change leaves a copy of `assert_type` in kunit_assert for now
> > because cleaning up all the macros to not pass it around is a bit more
> > involved.
> >
> > Here's an example of the expanded code for KUNIT_FAIL():
> > if (!(false)) {
> >   static const struct kunit_loc loc = { .file = ... };
> >   struct kunit_unary_assert __assertion = { .assert = { .type ...  };
> >   kunit_failed_assertion(test, &loc, &__assertion.assert, ((void *)0));
> > };
> >
> > [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > ---
>
> Nitpicky bikeshedding aside, this looks good to me.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
>
> >  include/kunit/assert.h | 25 ++++++++++++++++---------
> >  include/kunit/test.h   | 12 +++++++++++-
> >  lib/kunit/assert.c     |  9 +++++----
> >  lib/kunit/test.c       | 15 +++++++++------
> >  4 files changed, 41 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > index 3da6c792496c..4f91dbdb886a 100644
> > --- a/include/kunit/assert.h
> > +++ b/include/kunit/assert.h
> > @@ -28,11 +28,21 @@ enum kunit_assert_type {
> >         KUNIT_EXPECTATION,
> >  };
> >
> > +/**
> > + * struct kunit_loc - Identifies the source location of a line of code.
> > + * @line: the line number in the file.
> > + * @file: the file name.
> > + */
> > +struct kunit_loc {
> > +       int line;
> > +       const char *file;
> > +};
> > +
> > +#define KUNIT_CURRENT_LOC { .file = __FILE__, .line = __LINE__ }
> > +
> >  /**
> >   * struct kunit_assert - Data for printing a failed assertion or expectation.
> >   * @type: the type (either an expectation or an assertion) of this kunit_assert.
> > - * @line: the source code line number that the expectation/assertion is at.
> > - * @file: the file path of the source file that the expectation/assertion is in.
> >   * @message: an optional message to provide additional context.
> >   * @format: a function which formats the data in this kunit_assert to a string.
> >   *
> > @@ -40,9 +50,7 @@ enum kunit_assert_type {
> >   * format a string to a user reporting the failure.
> >   */
> >  struct kunit_assert {
> > -       enum kunit_assert_type type;
> > -       int line;
> > -       const char *file;
> > +       enum kunit_assert_type type; // TODO(dlatypov@google.com): delete this
> >         struct va_format message;
> >         void (*format)(const struct kunit_assert *assert,
> >                        struct string_stream *stream);
> > @@ -65,14 +73,13 @@ struct kunit_assert {
> >   */
> >  #define KUNIT_INIT_ASSERT_STRUCT(assert_type, fmt) {                          \
> >         .type = assert_type,                                                   \
> > -       .file = __FILE__,                                                      \
> > -       .line = __LINE__,                                                      \
> >         .message = KUNIT_INIT_VA_FMT_NULL,                                     \
> >         .format = fmt                                                          \
> >  }
> >
> > -void kunit_base_assert_format(const struct kunit_assert *assert,
> > -                             struct string_stream *stream);
> > +void kunit_assert_prologue(const struct kunit_loc *loc,
> > +                          enum kunit_assert_type type,
> > +                          struct string_stream *stream);
> >
> >  void kunit_assert_print_msg(const struct kunit_assert *assert,
> >                             struct string_stream *stream);
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index ebd45593321e..6e201b45ada6 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -771,13 +771,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
> >  #define KUNIT_SUCCEED(test) do {} while (0)
> >
> >  void kunit_failed_assertion(struct kunit *test,
> > +                           const struct kunit_loc *loc,
> > +                           enum kunit_assert_type type,
> >                             struct kunit_assert *assert,
> >                             const char *fmt, ...);
> >
> > -#define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
> > +#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
> >         if (!(pass)) {                                                         \
> > +               static const struct kunit_loc loc = KUNIT_CURRENT_LOC;         \
> >                 struct assert_class __assertion = INITIALIZER;                 \
> >                 kunit_failed_assertion(test,                                   \
> > +                                      &loc,                                   \
> > +                                      assert_type,                            \
> >                                        &__assertion.assert,                    \
> >                                        fmt,                                    \
> >                                        ##__VA_ARGS__);                         \
> > @@ -787,6 +792,7 @@ void kunit_failed_assertion(struct kunit *test,
> >
> >  #define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)                     \
> >         KUNIT_ASSERTION(test,                                                  \
> > +                       assert_type,                                           \
> >                         false,                                                 \
> >                         kunit_fail_assert,                                     \
> >                         KUNIT_INIT_FAIL_ASSERT_STRUCT(assert_type),      \
> > @@ -817,6 +823,7 @@ void kunit_failed_assertion(struct kunit *test,
> >                               fmt,                                             \
> >                               ...)                                             \
> >         KUNIT_ASSERTION(test,                                                  \
> > +                       assert_type,                                           \
> >                         !!(condition) == !!expected_true,                      \
> >                         kunit_unary_assert,                                    \
> >                         KUNIT_INIT_UNARY_ASSERT_STRUCT(assert_type,            \
> > @@ -875,6 +882,7 @@ do {                                                                               \
> >         typeof(right) __right = (right);                                       \
> >                                                                                \
> >         KUNIT_ASSERTION(test,                                                  \
> > +                       assert_type,                                           \
> >                         __left op __right,                                     \
> >                         assert_class,                                          \
> >                         ASSERT_CLASS_INIT(assert_type,                         \
> > @@ -1229,6 +1237,7 @@ do {                                                                             \
> >         const char *__right = (right);                                 \
> >                                                                                \
> >         KUNIT_ASSERTION(test,                                                  \
> > +                       assert_type,                                           \
> >                         strcmp(__left, __right) op 0,                          \
> >                         kunit_binary_str_assert,                               \
> >                         KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(assert_type,       \
> > @@ -1288,6 +1297,7 @@ do {                                                                             \
> >         typeof(ptr) __ptr = (ptr);                                             \
> >                                                                                \
> >         KUNIT_ASSERTION(test,                                                  \
> > +                       assert_type,                                           \
> >                         !IS_ERR_OR_NULL(__ptr),                                \
> >                         kunit_ptr_not_err_assert,                              \
> >                         KUNIT_INIT_PTR_NOT_ERR_STRUCT(assert_type,             \
> > diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> > index 4d9a1295efc7..9f4492a8e24e 100644
> > --- a/lib/kunit/assert.c
> > +++ b/lib/kunit/assert.c
> > @@ -10,12 +10,13 @@
> >
> >  #include "string-stream.h"
> >
> > -void kunit_base_assert_format(const struct kunit_assert *assert,
> > +void kunit_assert_prologue(const struct kunit_loc *loc,
> > +                          enum kunit_assert_type type,
> >                               struct string_stream *stream)
> >  {
> >         const char *expect_or_assert = NULL;
> >
> > -       switch (assert->type) {
> > +       switch (type) {
> >         case KUNIT_EXPECTATION:
> >                 expect_or_assert = "EXPECTATION";
> >                 break;
> > @@ -25,9 +26,9 @@ void kunit_base_assert_format(const struct kunit_assert *assert,
> >         }
> >
> >         string_stream_add(stream, "%s FAILED at %s:%d\n",
> > -                         expect_or_assert, assert->file, assert->line);
> > +                         expect_or_assert, loc->file, loc->line);
> >  }
> > -EXPORT_SYMBOL_GPL(kunit_base_assert_format);
> > +EXPORT_SYMBOL_GPL(kunit_assert_prologue);
> >
> >  void kunit_assert_print_msg(const struct kunit_assert *assert,
> >                             struct string_stream *stream)
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 735c1b67d843..3108ed0575d4 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -240,7 +240,8 @@ static void kunit_print_string_stream(struct kunit *test,
> >         }
> >  }
> >
> > -static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
> > +static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
> > +                      enum kunit_assert_type type, struct kunit_assert *assert)
> >  {
> >         struct string_stream *stream;
> >
> > @@ -250,12 +251,12 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
> >         if (!stream) {
> >                 WARN(true,
> >                      "Could not allocate stream to print failed assertion in %s:%d\n",
> > -                    assert->file,
> > -                    assert->line);
> > +                    loc->file,
> > +                    loc->line);
> >                 return;
> >         }
> >
> > -       kunit_base_assert_format(assert, stream);
> > +       kunit_assert_prologue(loc, type, stream);
> >         assert->format(assert, stream);
> >
> >         kunit_print_string_stream(test, stream);
> > @@ -277,6 +278,8 @@ static void __noreturn kunit_abort(struct kunit *test)
> >  }
> >
> >  void kunit_failed_assertion(struct kunit *test,
> > +                           const struct kunit_loc *loc,
> > +                           enum kunit_assert_type type,
> >                             struct kunit_assert *assert,
> >                             const char *fmt, ...)
> >  {
> > @@ -286,11 +289,11 @@ void kunit_failed_assertion(struct kunit *test,
> >         assert->message.fmt = fmt;
> >         assert->message.va = &args;
> >
> > -       kunit_fail(test, assert);
> > +       kunit_fail(test, loc, type, assert);
> >
> >         va_end(args);
> >
> > -       if (assert->type == KUNIT_ASSERTION)
> > +       if (type == KUNIT_ASSERTION)
> >                 kunit_abort(test);
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_failed_assertion);
> > --
> > 2.34.1.575.g55b058a8bb-goog
> >
