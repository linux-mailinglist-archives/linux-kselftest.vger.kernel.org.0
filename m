Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8E48B9CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 22:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbiAKVml (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 16:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbiAKVml (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 16:42:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16229C061748
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 13:42:41 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id oa15so1241786pjb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCtl+aQhoJ9DtvkfZHIukzRqBwMxSUFEaktu28rcleI=;
        b=L2suR1S5x2NrE5nWhMWmHQ0Q9QMrw6Hnka1mcs9wr7FQ4piDNqL1vlZPWi20qxqXj8
         tqaRC2O0Y46QqyoGHkokENtzkVbvYM964uZ78ncSNkUw6vR1GRmMmL8UBEvU1VQzTu/A
         uhiUicwK0L7kyddr5paUhdoiKW8NqBK1Ut3VnnOX/Qx6jgeXGX6BpxzvSVDPb/YtgqPx
         yzpN49BC2VwacO82evRM9qryk4s2qETORf5omgosxBwPILqsUS7R1sKL4qTn8Jm7FXSG
         KdjyQMMpT13uk2dqQdmVYsa8brcJ3b+G3jPbfQdEbmNT1IfDYRjdrcpd+rYv61HX3jgh
         HcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCtl+aQhoJ9DtvkfZHIukzRqBwMxSUFEaktu28rcleI=;
        b=OE8TUKhCe2RFyBV2qGeZxNTYhlzIbRmvg36cuUEi1AMGQ5e/fMfm0YQCaYq+ZNrCKY
         FTuBQUOVCdWIBfGaR5HqUnSlMmdPA6fNEo5m34b83mR+3KC/SlgFUN6rbpiTubCYo+ru
         XGuhstQJbQwzGTAGUHvVAM5CzWKjVFsM+qooRGii2O7bGCbFFl/5JYwz+oEwPBrMWryq
         l1Bm8K3jcAC3tS93GygwGIZhs/Say4W+T1EgVaAjbK9Luk/nLgJjTw/qwjEAoAC2k3Zh
         KguZ2c1mxOV0Q7efXrdt3olApXqgpOGcc7Z8DkBzmbxu+6dhAm3JOvZ+d6qMlzDc6uqh
         5ShA==
X-Gm-Message-State: AOAM532jTuF+BRvmyjbYHs01YXVawRY9cDdrcqwO1WyRKNNp2JXhgngM
        gYZ4HKZSxWYzxye2h5triyJ1tpCufVq9MPc3H/076w==
X-Google-Smtp-Source: ABdhPJzT3LGBUJRGgB9WED/csvGPJLe27sUUkxGU7Ra5c/k1nyJkl7smPQc41ZISVZvOn5JBLZ6GtgrCjuTfxZGcO84=
X-Received: by 2002:a05:6a00:24c2:b0:4bc:bea:1e60 with SMTP id
 d2-20020a056a0024c200b004bc0bea1e60mr6390678pfv.63.1641937360270; Tue, 11 Jan
 2022 13:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com> <20220111194231.1797841-6-dlatypov@google.com>
 <CAFd5g46bCr4DEqruLbtgcLOpuPQUgS32ePDicrezBwOXL_r5Hg@mail.gmail.com>
In-Reply-To: <CAFd5g46bCr4DEqruLbtgcLOpuPQUgS32ePDicrezBwOXL_r5Hg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Jan 2022 16:42:29 -0500
Message-ID: <CAFd5g47F3uRmVZXWxz9Xkx23=PccLnZ3j_CsSqBnA4o5uEutKw@mail.gmail.com>
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

On Tue, Jan 11, 2022 at 4:35 PM Brendan Higgins
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

NVM, I saw the context in the next patch. Could you maybe mention that
it is removed in a later patch in the comment?

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
