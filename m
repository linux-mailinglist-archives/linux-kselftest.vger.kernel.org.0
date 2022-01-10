Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8CA48A302
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 23:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbiAJWdD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 17:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbiAJWdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 17:33:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D9C061748
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:33:02 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i5so6018693edf.9
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yUyA3kF4TyoDY7fJI1rswctkI7DoFPRquevsmMCbKw=;
        b=asBhcryaNp3vUkTNKu2AepHZ486eJ5AUxw/RmSZRaCj9lWLi8ZKC/IEeCpL/8BWI2K
         U87Yvz8Sl5Zy+BaG4ACcTPLA97xMoE2Hvu5AFrV7CFcEsx0+MNiBa+tBmN0jc+FI1XLW
         aqT8IPVAalg273G0/+1AChrRpLEjZQFuUW81M5KXGrmDJwsZX1wMvqVsEhPis4l4c47C
         ADLbZtJlxcQ+6BI2GUqZ57Lzb5EzamLOIkblt+xr42uQrOUyJdEAzJjS9OYzjYsagebU
         ZAgw+SGdFDbZHxPtcAd+TIxqkQ2DBBIfyVPuYBJrmbm/rtIpD4wmSUws9Jf8dMTiXJ3J
         FXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yUyA3kF4TyoDY7fJI1rswctkI7DoFPRquevsmMCbKw=;
        b=f5QgqWB2rS2sGIHVqmBSWn4bH9z5CT0ysI5lCV2mJsZy4SonHYDetmgO8rC0adMaZw
         GMfO52KSwRpGFPo6hi9ImyYsPD9/AOhvlp6TlbeAwZeEUJfcnsKK7ytzGqAYfxBNLPUU
         bAM+MJGqZrBY0uCvTqE++sCJMGDsUBrMcT0+d4C1fOpkAk5I6kuG39OYxmEkAWGZMEjK
         TyZOh6Mh+LznHxv8doQOh3h3o4sJtjRFOkSuZgNzM3gInClRJ5NhAU8EeFAqcKV5BXUi
         i1A2y6616xYHtmycMxH41eOnlklQMFgqLoNgq06Rjd3W1VtsUFI3QzNiD5qpMbUfIFJ9
         +abg==
X-Gm-Message-State: AOAM531n9nw4RGRhuqSzRJwEwtVttbU4KzQFudxxo9niGlDfbN7jPA7F
        hD/dyexL2scrWlCQ34GZIVTOVDrbiCeMGO1InwmzSwuiN1Y=
X-Google-Smtp-Source: ABdhPJypV8q6W6FO7jt10mVZSmvL3v/XVjry60WwpfutYkFPixIHHzzb9maC66YA2apCHfda9GzFKQ//AwpoJrQ9hxA=
X-Received: by 2002:a17:907:3f0c:: with SMTP id hq12mr1372451ejc.358.1641853981056;
 Mon, 10 Jan 2022 14:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-3-dlatypov@google.com>
 <CAFd5g45HcdzB_CTNRRpH8BFbBvG0nDS4_6VUj3Tqx8XOuVTNOQ@mail.gmail.com>
In-Reply-To: <CAFd5g45HcdzB_CTNRRpH8BFbBvG0nDS4_6VUj3Tqx8XOuVTNOQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 10 Jan 2022 14:32:49 -0800
Message-ID: <CAGS_qxqhhu=Jy+vwWZGZLRG4qW5=ZJ8t7QbjtL54onc4-NFnrw@mail.gmail.com>
Subject: Re: [PATCH 2/6] kunit: move check if assertion passed into the macros
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 10, 2022 at 2:21 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jan 7, 2022 at 8:23 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Currently the code always calls kunit_do_assertion() even though it does
> > nothing when `pass` is true.
> >
> > This change moves the `if(!(pass))` check into the macro instead
> > and renames the function to kunit_failed_assertion().
> > I feel this a  bit easier to read and understand.
> >
> > This has the potential upside of avoiding a function call that does
> > nothing most of the time (assuming your tests are passing) but comes
> > with the downside of generating a bit more code and branches.
> >
> > This also means we don't have to initialize structs that we don't need,
> > which will become a tiny bit more expensive if we switch over to using
> > static variables to try and reduce stack usage. (There's runtime code
> > to check if the variable has been initialized yet or not).
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> Tiny nit, see below. Otherwise:
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
> >  include/kunit/test.h | 20 ++++++++++----------
> >  lib/kunit/test.c     | 13 ++++---------
> >  2 files changed, 14 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index b26400731c02..690a28dfc795 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -770,18 +770,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
> >   */
> >  #define KUNIT_SUCCEED(test) do {} while (0)
> >
> > -void kunit_do_assertion(struct kunit *test,
> > -                       struct kunit_assert *assert,
> > -                       bool pass,
> > -                       const char *fmt, ...);
> > +void kunit_failed_assertion(struct kunit *test,
> > +                           struct kunit_assert *assert,
> > +                           const char *fmt, ...);
>
> Tiny nit: I think this should be kunit_fail_assertion. I think
> functions should be in the active tense, imperative mood since when
> you call a function you are telling it to do something.
>
> Also, do we need to worry about this getting confused with KUNIT_FAIL,
> or KUNIT_FAIL_ASSERTION:

So do we want to try and pick a different name from
kunit_fail_assertion() to avoid confusion with the macro?
That's partly why I went with past tense.
Perhaps: "kunit_do_assertion() => kunit_do_failed_assertion()" instead?

Tangent: we have some similar confusing names, e.g. KUNIT_ASSERTION is
both the name of a macro and an enum (kunit_assert_type), and those
have the exact same case.

>
> https://elixir.bootlin.com/linux/v5.16/source/include/kunit/test.h#L788
>
> ?
>
> >  #define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
> > -       struct assert_class __assertion = INITIALIZER;                         \
> > -       kunit_do_assertion(test,                                               \
> > -                          &__assertion.assert,                                \
> > -                          pass,                                               \
> > -                          fmt,                                                \
> > -                          ##__VA_ARGS__);                                     \
> > +       if (!(pass)) {                                                         \
> > +               struct assert_class __assertion = INITIALIZER;                 \
> > +               kunit_failed_assertion(test,                                   \
> > +                                      &__assertion.assert,                    \
> > +                                      fmt,                                    \
> > +                                      ##__VA_ARGS__);                         \
> > +       }                                                                      \
> >  } while (0)
> >
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index c7ed4aabec04..5ad671745483 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -275,16 +275,11 @@ static void __noreturn kunit_abort(struct kunit *test)
> >         WARN_ONCE(true, "Throw could not abort from test!\n");
> >  }
> >
> > -void kunit_do_assertion(struct kunit *test,
> > -                       struct kunit_assert *assert,
> > -                       bool pass,
> > -                       const char *fmt, ...)
> > +void kunit_failed_assertion(struct kunit *test,
> > +                           struct kunit_assert *assert,
> > +                           const char *fmt, ...)
> >  {
> >         va_list args;
> > -
> > -       if (pass)
> > -               return;
> > -
> >         va_start(args, fmt);
> >
> >         assert->message.fmt = fmt;
> > @@ -297,7 +292,7 @@ void kunit_do_assertion(struct kunit *test,
> >         if (assert->type == KUNIT_ASSERTION)
> >                 kunit_abort(test);
> >  }
> > -EXPORT_SYMBOL_GPL(kunit_do_assertion);
> > +EXPORT_SYMBOL_GPL(kunit_failed_assertion);
> >
> >  void kunit_init_test(struct kunit *test, const char *name, char *log)
> >  {
> > --
> > 2.34.1.575.g55b058a8bb-goog
> >
