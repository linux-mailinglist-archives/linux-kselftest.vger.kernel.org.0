Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD648B9D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 22:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbiAKVnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 16:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245429AbiAKVnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 16:43:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1C5C061748
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 13:43:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id hv15so1243817pjb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 13:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MemVO5dygI0J21UA0CeXXewmz7SBrtBH8W/9usKSoOI=;
        b=ZH0F+Ij++iXFAb/Q//8LkKB/s+OX1IoZqc8TWG9q8KcqeebK3IRoezrw6IZ6T0DYui
         lTLOrukTT7n2TZLQe0yMeyzea1tkapm3pN1FGkwF6/9ssEL5pN4ElvJYeLaiJcYzUzK8
         82s978d1VVSjSsM9IcQPAp8UpTDVN3AOPfMBQ1AsuPCGSFh7TqW8E19zDIJsj41cwe6t
         2d/WLBue/eBeJCrUQTVm+t/ixIAqCp669Cb9ZJH7O9jEqjVS27rNnQhMtMB63lU/0hsy
         TgiyJAiMESNVkD3ziydZj+HDXj7s3vY456ouRlXVWGP/Bo6NPYkScyGV5XdFr9CWW6Yz
         Xf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MemVO5dygI0J21UA0CeXXewmz7SBrtBH8W/9usKSoOI=;
        b=IN73RRKKB79jex0SiW1SK6tfr3PKovQ2FXD7mxAOKSSPOaVRwq2pOjKJVNDp9O3t1E
         OsLArw3FGWCOxRSqdb6eTosZLVvdUT9K5N/OMyBWIeSA6DyfPIECSCd8o9NxppEBIh1l
         Kwig356bavT6C6jSBVd7VT4CkqGIoktqBEIeYkVPTivPY9qgIm8eubdozIlGGa9JCgK3
         ci/kZvEzUyukuHb+QsRXWRdqPfSwkHBjI+eObIPdm7oHKfXbRVJYE3VubhCMghiTTUUH
         HrhWWVtsTx/0MTb3vzZFGDyiEwJBKRIoDcJrZCHFFGNkSNo7bfisAcdSLskse/6rAvIL
         6M7w==
X-Gm-Message-State: AOAM532KF3PyKH8Zfyd0n1jl+kNENyOH900O8G3/t4198K6SZQmnF296
        iiceanaOwouuffx2l31EMIzW6ePknzdBp1HX6/RCTQ==
X-Google-Smtp-Source: ABdhPJyMZpnDb0Hx/oPUCN+HhwrusS3W/Nl+tdTy7Ba+A2gL4wxX/P3NKM1OyoymR5IU3xgR5xz/FhOmowsDhWxnlxY=
X-Received: by 2002:a62:80c2:0:b0:4bb:47a:6983 with SMTP id
 j185-20020a6280c2000000b004bb047a6983mr6512138pfd.24.1641937420216; Tue, 11
 Jan 2022 13:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com> <20220111194231.1797841-6-dlatypov@google.com>
 <CAFd5g46bCr4DEqruLbtgcLOpuPQUgS32ePDicrezBwOXL_r5Hg@mail.gmail.com> <CAGS_qxrNAuXUN2VftJ2e9k=zt+vp+7P-WuZM8FJOa98vsZtFHQ@mail.gmail.com>
In-Reply-To: <CAGS_qxrNAuXUN2VftJ2e9k=zt+vp+7P-WuZM8FJOa98vsZtFHQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Jan 2022 16:43:29 -0500
Message-ID: <CAFd5g46R9L+moE+wcv1HOHPpd4NJus8oJ=JwQgPP9MWOMGE4_A@mail.gmail.com>
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

On Tue, Jan 11, 2022 at 4:41 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Tue, Jan 11, 2022 at 1:35 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Tue, Jan 11, 2022 at 2:42 PM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > This is per Linus's suggestion in [1].
> > >
> > > The issue there is that every KUNIT_EXPECT/KUNIT_ASSERT puts a
> > > kunit_assert object onto the stack. Normally we rely on compilers to
> > > elide this, but when that doesn't work out, this blows up the stack
> > > usage of kunit test functions.
> > >
> > > We can move some data off the stack by making it static.
> > > This change introduces a new `struct kunit_loc` to hold the file and
> > > line number and then just passing assert_type (EXPECT or ASSERT) as an
> > > argument.
> > >
> > > In [1], it was suggested to also move out the format string as well, but
> > > users could theoretically craft a format string at runtime, so we can't.
> > >
> > > This change leaves a copy of `assert_type` in kunit_assert for now
> > > because cleaning up all the macros to not pass it around is a bit more
> > > involved.
> > >
> > > Here's an example of the expanded code for KUNIT_FAIL():
> > > if (__builtin_expect(!!(!(false)), 0)) {
> > >   static const struct kunit_loc loc = { .file = ... };
> > >   struct kunit_fail_assert __assertion = { .assert = { .type ...  };
> > >   kunit_do_failed_assertion(test, &loc, KUNIT_EXPECTATION, &__assertion.assert, ...);
> > > };
> > >
> > > [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Reviewed-by: David Gow <davidgow@google.com>
> >
> > One question below, but other than that,
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > > ---
> > >  include/kunit/assert.h | 25 ++++++++++++++++---------
> > >  include/kunit/test.h   | 12 +++++++++++-
> > >  lib/kunit/assert.c     |  9 +++++----
> > >  lib/kunit/test.c       | 15 +++++++++------
> > >  4 files changed, 41 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > > index 3da6c792496c..4f91dbdb886a 100644
> > > --- a/include/kunit/assert.h
> > > +++ b/include/kunit/assert.h
> > > @@ -28,11 +28,21 @@ enum kunit_assert_type {
> > >         KUNIT_EXPECTATION,
> > >  };
> > >
> > > +/**
> > > + * struct kunit_loc - Identifies the source location of a line of code.
> > > + * @line: the line number in the file.
> > > + * @file: the file name.
> > > + */
> > > +struct kunit_loc {
> > > +       int line;
> > > +       const char *file;
> > > +};
> > > +
> > > +#define KUNIT_CURRENT_LOC { .file = __FILE__, .line = __LINE__ }
> > > +
> > >  /**
> > >   * struct kunit_assert - Data for printing a failed assertion or expectation.
> > >   * @type: the type (either an expectation or an assertion) of this kunit_assert.
> > > - * @line: the source code line number that the expectation/assertion is at.
> > > - * @file: the file path of the source file that the expectation/assertion is in.
> > >   * @message: an optional message to provide additional context.
> > >   * @format: a function which formats the data in this kunit_assert to a string.
> > >   *
> > > @@ -40,9 +50,7 @@ enum kunit_assert_type {
> > >   * format a string to a user reporting the failure.
> > >   */
> > >  struct kunit_assert {
> > > -       enum kunit_assert_type type;
> > > -       int line;
> > > -       const char *file;
> > > +       enum kunit_assert_type type; // TODO(dlatypov@google.com): delete this
> >
> > Can you provide some context for this?
>
> This is what the commit desc is referring to.
> We leave in the type field in this change so we can clean that up and
> all the macros all at once.
>
> This TODO is addressed and removed in the next commit, so I was being
> a bit lazy with the TODO.
>  I was hoping people could check `git blame` and find the context they
> need, if people do somehow find their way to this intermediate commit.
>
> If you want, I can update the TODO message to be more fleshed out.
> Something like
>
> TODO(...): delete this unused field when we've updated all the related
> KUNIT_INIT_ASSERT macros.
>
> ?

Yeah, I like that better.

> >
> > >         struct va_format message;
> > >         void (*format)(const struct kunit_assert *assert,
> > >                        struct string_stream *stream);
> > > @@ -65,14 +73,13 @@ struct kunit_assert {
> > >   */
> > >  #define KUNIT_INIT_ASSERT_STRUCT(assert_type, fmt) {                          \
> > >         .type = assert_type,                                                   \
> > > -       .file = __FILE__,                                                      \
> > > -       .line = __LINE__,                                                      \
> > >         .message = KUNIT_INIT_VA_FMT_NULL,                                     \
> > >         .format = fmt                                                          \
> > >  }
> > >
> > > -void kunit_base_assert_format(const struct kunit_assert *assert,
> > > -                             struct string_stream *stream);
> > > +void kunit_assert_prologue(const struct kunit_loc *loc,
> > > +                          enum kunit_assert_type type,
> > > +                          struct string_stream *stream);
> > >
> > >  void kunit_assert_print_msg(const struct kunit_assert *assert,
> > >                             struct string_stream *stream);
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index 25ea3bce6663..7b752175e614 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
