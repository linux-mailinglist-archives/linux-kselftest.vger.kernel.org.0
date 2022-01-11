Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DD48B9C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 22:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245365AbiAKVlN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 16:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbiAKVlN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 16:41:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB3C06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 13:41:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u21so1719171edd.5
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 13:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRft7F9qbd0sLcWJbamLPoi+pNYux+iGGbxHhoSk7vY=;
        b=UXNvfzWDTaA7GWmf9EFwEmVTWICRfCyTEix2ERDPHXrQGf2wLZ1KACGAhcNNBfB1pr
         3EkPIQhSaRu+ywLf0BlfEvMS2SxEEGWYnO2cI6isR2z78D6pHi5FnEKmIzo5nqnSG3Zf
         XE/YBbhG87GpQS8dHVnmcbq3Pg4+yZWU8XU9gHbzy4kOp+YK38PD5m+amwC4Pn2PYEcC
         DAdV59LXUrenku4k0M/0NdYAQthn//hoDm3V/VdWeXNa0kzzwE/+a3n9ty9K5hNODcGq
         X/R7HLf/mozZjLRAWJ78I9f4HdFzotXPEcKHRBe/lGZi8HWPgUGySo/AdXqBnpBHXrTo
         n0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRft7F9qbd0sLcWJbamLPoi+pNYux+iGGbxHhoSk7vY=;
        b=Eb5Rd6s36DVqwR7ryuNYzCGSkobz+4SCyRBnzjA10w0JbFDXUv+LR62cW16bZ25N24
         cZsaCEBrAhN05OhX1ws+MDpK+SUxfeLJ1dU7qz+spWIVhjRawOS+g0k/0AffruTsUcZY
         Za3YPEMus94I/esvtr/qde96Hg45/MyZ7dbRaFQNy3MXqNyQqtP/TqnMVvvmg7uLTQO+
         cKkOZ+6Qhsa58/Y8OdIlO3zDxOTqcNzf9bbO2Qvcln8ehFgy3YwfiJLVbp7RvGbz6rWL
         y4qV7x9nScLPGoJUFfpBqYTAttBAizPFimPYTD2EQ6q6EdrZAVFiN3lnL7moNiCiB9Io
         PRfQ==
X-Gm-Message-State: AOAM530wsP0BgRs0Cr8M66/EW1geDzT104Y9dgPE/JCRc4Mt0AP+zXS/
        Ts5ZepmmOKDGrRI/pnDvOn2s2bwPIGUifi2KrsM9Zw==
X-Google-Smtp-Source: ABdhPJy2jFcVSHacK9cBAXSGViqz+bdTAIAKJi1AvsFKLICgvo7IR/Yxciyco3MyvoeloNa4L12Jx9q/RlgGi+9hy/A=
X-Received: by 2002:a50:f105:: with SMTP id w5mr6122865edl.222.1641937271005;
 Tue, 11 Jan 2022 13:41:11 -0800 (PST)
MIME-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com> <20220111194231.1797841-6-dlatypov@google.com>
 <CAFd5g46bCr4DEqruLbtgcLOpuPQUgS32ePDicrezBwOXL_r5Hg@mail.gmail.com>
In-Reply-To: <CAFd5g46bCr4DEqruLbtgcLOpuPQUgS32ePDicrezBwOXL_r5Hg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 11 Jan 2022 13:40:59 -0800
Message-ID: <CAGS_qxrNAuXUN2VftJ2e9k=zt+vp+7P-WuZM8FJOa98vsZtFHQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] kunit: split out part of kunit_assert into a
 static const
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 11, 2022 at 1:35 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Jan 11, 2022 at 2:42 PM Daniel Latypov <dlatypov@google.com> wrote:
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
> >
> > In [1], it was suggested to also move out the format string as well, but
> > users could theoretically craft a format string at runtime, so we can't.
> >
> > This change leaves a copy of `assert_type` in kunit_assert for now
> > because cleaning up all the macros to not pass it around is a bit more
> > involved.
> >
> > Here's an example of the expanded code for KUNIT_FAIL():
> > if (__builtin_expect(!!(!(false)), 0)) {
> >   static const struct kunit_loc loc = { .file = ... };
> >   struct kunit_fail_assert __assertion = { .assert = { .type ...  };
> >   kunit_do_failed_assertion(test, &loc, KUNIT_EXPECTATION, &__assertion.assert, ...);
> > };
> >
> > [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Reviewed-by: David Gow <davidgow@google.com>
>
> One question below, but other than that,
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
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
>
> Can you provide some context for this?

This is what the commit desc is referring to.
We leave in the type field in this change so we can clean that up and
all the macros all at once.

This TODO is addressed and removed in the next commit, so I was being
a bit lazy with the TODO.
 I was hoping people could check `git blame` and find the context they
need, if people do somehow find their way to this intermediate commit.

If you want, I can update the TODO message to be more fleshed out.
Something like

TODO(...): delete this unused field when we've updated all the related
KUNIT_INIT_ASSERT macros.

?

>
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
> > index 25ea3bce6663..7b752175e614 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
