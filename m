Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E619648B5DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 19:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbiAKSmV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 13:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbiAKSmU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 13:42:20 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17114C06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 10:42:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u25so37879edf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 10:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlv1m0oWEWqiXdzkq1FrQ63DGvpn5XRpuHy2G/KiWa4=;
        b=FeMHMKmjeGqqoYlN0lmvGnc5tvk3svsJhTjO0oXhkGS+MxcT2SfRcnFfUp2+B2K+wO
         2giMGlEp4nctatlgshafQW9MJU0m6j7U42SJ6Xrcj55fqJUzUY5NJ1TrDT0HfbpaYj8U
         NChHW1WQd/Pdkn0F7iI78aEW0Y2x+6xR3FtyaReaYMTsnoIyxSbuiKT3rzcEwevjB0i0
         esNnm3fe45iu6MU3Zp7IzWTldqLeyv2w6toL0iFdD9o/XpQJWCeobXZkEbbGf87pnTyO
         pofazbD3rQmYJKMTiXONjjYDuTeYJC4Yw/6ycol1EHluaoVYV3qkQs2BghFTqMDleYd/
         4EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlv1m0oWEWqiXdzkq1FrQ63DGvpn5XRpuHy2G/KiWa4=;
        b=dUOPV1vx+ZTjnYSP0StyyRR3JRCqAVF+C8pWZ5+Ka3aesp1uM4KzCcHkSK+fpjqaU2
         CqTQdmA5pR8rVeTt1phdKra7GsH+85tzPtocy+H6MiV+j+BM1F8zScOV+aACk1rOV42u
         mh/LaeglToeqfanMtNZqPu6ukZvdhLnqZKWtR6r9OaipfAU0vtz4s8o2Gl6xeBnPPADs
         mwnJZyOhMKkh1uvu2QKmxijkHDRFnGUcFEEV3W298dLzXIUh/M2nNUD9AcrWUbvf0mEZ
         SfoXZeYtS6j7rEaQaRoGJQhm5wF3TrG3E56BWn6m4ghfx/P+7/thJZY8ma9rdSkBun9m
         tHIg==
X-Gm-Message-State: AOAM532+AjLt8RY9ikvlzsKTG1FWtEwY9E0sbbn9h9I/HHdP99mN1ZRk
        9OVpTdlEc/DYcWuvQs0Ft2eziM/JVGcvwp45VaVYvw==
X-Google-Smtp-Source: ABdhPJybavSkCnT8Lo198i/c+n/vKgJF4wCc1ZFYWGqHcCkfCu5pdx6cl6czugcmgdCiv4Je0yqkD95FQHmQfXIoyQg=
X-Received: by 2002:aa7:d785:: with SMTP id s5mr5460664edq.215.1641926537331;
 Tue, 11 Jan 2022 10:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-3-dlatypov@google.com>
 <CAFd5g45HcdzB_CTNRRpH8BFbBvG0nDS4_6VUj3Tqx8XOuVTNOQ@mail.gmail.com>
 <CAGS_qxqhhu=Jy+vwWZGZLRG4qW5=ZJ8t7QbjtL54onc4-NFnrw@mail.gmail.com> <CABVgOSkyJvM=beWD8PM-sobHnVNRyqQYQpjeBYhbUEP4Lz8bLA@mail.gmail.com>
In-Reply-To: <CABVgOSkyJvM=beWD8PM-sobHnVNRyqQYQpjeBYhbUEP4Lz8bLA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 11 Jan 2022 10:42:06 -0800
Message-ID: <CAGS_qxo3Va9EybJ4O109qF4wyAv7K2_4_ZBLsc5ovioAVDjb=Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] kunit: move check if assertion passed into the macros
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 10, 2022 at 10:51 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Jan 11, 2022 at 6:33 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Mon, Jan 10, 2022 at 2:21 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Fri, Jan 7, 2022 at 8:23 PM Daniel Latypov <dlatypov@google.com> wrote:
> > > >
> > > > Currently the code always calls kunit_do_assertion() even though it does
> > > > nothing when `pass` is true.
> > > >
> > > > This change moves the `if(!(pass))` check into the macro instead
> > > > and renames the function to kunit_failed_assertion().
> > > > I feel this a  bit easier to read and understand.
> > > >
> > > > This has the potential upside of avoiding a function call that does
> > > > nothing most of the time (assuming your tests are passing) but comes
> > > > with the downside of generating a bit more code and branches.
> > > >
> > > > This also means we don't have to initialize structs that we don't need,
> > > > which will become a tiny bit more expensive if we switch over to using
> > > > static variables to try and reduce stack usage. (There's runtime code
> > > > to check if the variable has been initialized yet or not).
> > > >
> > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > >
> > > Tiny nit, see below. Otherwise:
> > >
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > >
> > > > ---
> > > >  include/kunit/test.h | 20 ++++++++++----------
> > > >  lib/kunit/test.c     | 13 ++++---------
> > > >  2 files changed, 14 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > index b26400731c02..690a28dfc795 100644
> > > > --- a/include/kunit/test.h
> > > > +++ b/include/kunit/test.h
> > > > @@ -770,18 +770,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
> > > >   */
> > > >  #define KUNIT_SUCCEED(test) do {} while (0)
> > > >
> > > > -void kunit_do_assertion(struct kunit *test,
> > > > -                       struct kunit_assert *assert,
> > > > -                       bool pass,
> > > > -                       const char *fmt, ...);
> > > > +void kunit_failed_assertion(struct kunit *test,
> > > > +                           struct kunit_assert *assert,
> > > > +                           const char *fmt, ...);
> > >
> > > Tiny nit: I think this should be kunit_fail_assertion. I think
> > > functions should be in the active tense, imperative mood since when
> > > you call a function you are telling it to do something.
> > >
> > > Also, do we need to worry about this getting confused with KUNIT_FAIL,
> > > or KUNIT_FAIL_ASSERTION:
> >
> > So do we want to try and pick a different name from
> > kunit_fail_assertion() to avoid confusion with the macro?
> > That's partly why I went with past tense.
> > Perhaps: "kunit_do_assertion() => kunit_do_failed_assertion()" instead?
>
> I'm not particularly picky about the name personally. But if I had to
> join the bikeshedding, I'd probably go with kunit_assertion_fail() or
> similar (kunit_assertion_failed works too, past-tense-wise.)
>
> But kunit_do_fail{,ed}_assertion() would work too.

I've gone ahead and locally renamed it to kunit_do_failed_assertion().
Talking offline, Brendan seemed ok with it, so we have 2 votes of
"it's good enough".

>
>
> >
> > Tangent: we have some similar confusing names, e.g. KUNIT_ASSERTION is
> > both the name of a macro and an enum (kunit_assert_type), and those
> > have the exact same case.
> >
> > >
> > > https://elixir.bootlin.com/linux/v5.16/source/include/kunit/test.h#L788
> > >
> > > ?
> > >
> > > >  #define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
> > > > -       struct assert_class __assertion = INITIALIZER;                         \
> > > > -       kunit_do_assertion(test,                                               \
> > > > -                          &__assertion.assert,                                \
> > > > -                          pass,                                               \
> > > > -                          fmt,                                                \
> > > > -                          ##__VA_ARGS__);                                     \
> > > > +       if (!(pass)) {                                                         \
> > > > +               struct assert_class __assertion = INITIALIZER;                 \
> > > > +               kunit_failed_assertion(test,                                   \
> > > > +                                      &__assertion.assert,                    \
> > > > +                                      fmt,                                    \
> > > > +                                      ##__VA_ARGS__);                         \
> > > > +       }                                                                      \
> > > >  } while (0)
> > > >
> > > >
> > > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > > index c7ed4aabec04..5ad671745483 100644
> > > > --- a/lib/kunit/test.c
> > > > +++ b/lib/kunit/test.c
> > > > @@ -275,16 +275,11 @@ static void __noreturn kunit_abort(struct kunit *test)
> > > >         WARN_ONCE(true, "Throw could not abort from test!\n");
> > > >  }
> > > >
> > > > -void kunit_do_assertion(struct kunit *test,
> > > > -                       struct kunit_assert *assert,
> > > > -                       bool pass,
> > > > -                       const char *fmt, ...)
> > > > +void kunit_failed_assertion(struct kunit *test,
> > > > +                           struct kunit_assert *assert,
> > > > +                           const char *fmt, ...)
> > > >  {
> > > >         va_list args;
> > > > -
> > > > -       if (pass)
> > > > -               return;
> > > > -
> > > >         va_start(args, fmt);
> > > >
> > > >         assert->message.fmt = fmt;
> > > > @@ -297,7 +292,7 @@ void kunit_do_assertion(struct kunit *test,
> > > >         if (assert->type == KUNIT_ASSERTION)
> > > >                 kunit_abort(test);
> > > >  }
> > > > -EXPORT_SYMBOL_GPL(kunit_do_assertion);
> > > > +EXPORT_SYMBOL_GPL(kunit_failed_assertion);
> > > >
> > > >  void kunit_init_test(struct kunit *test, const char *name, char *log)
> > > >  {
> > > > --
> > > > 2.34.1.575.g55b058a8bb-goog
> > > >
