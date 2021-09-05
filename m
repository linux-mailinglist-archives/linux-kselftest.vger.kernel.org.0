Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0B24011FB
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Sep 2021 00:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhIEWlR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Sep 2021 18:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhIEWlR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Sep 2021 18:41:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB5EC061575
        for <linux-kselftest@vger.kernel.org>; Sun,  5 Sep 2021 15:40:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dm15so6814578edb.10
        for <linux-kselftest@vger.kernel.org>; Sun, 05 Sep 2021 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoHJHDDUQvDuxt5VzrZQ7aDSXlW3dvl3n4+BEi9wJZM=;
        b=hmwVZv0IehSDHdKr/5gEMvaA4SxOUAKSho+Jh+NgZ1YtJJgB87/nqAiVmkq66RdbcM
         m+ku3jJOCWZwOt2J5SoOy3JSSPHsPHq/HNv3OST+Lj4JPBXdJbI5bWnRVPkzOHJ/bgyL
         hDAAmJUDK7Yf/504RbkVBTMeqTlIYtS5Axr6ED6mLvfljtZRZRHq8umoerOAbOYfvHvo
         7SK0Ll3OUpn2XZdNw35HWbMzVovHYKntMZKX4Am3V5qDrrBvCQrmM20NtEc7zgpd8+pX
         6CCKzma4s/8LIWTRLRNTjmG0ylRPBY8z5WgYsZzuIZ0MSe31xdzN2Y6fxwEfSybJiBgY
         krOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoHJHDDUQvDuxt5VzrZQ7aDSXlW3dvl3n4+BEi9wJZM=;
        b=Co+PTo5gsNTrKzScFmqUuBQ2EJE0UtWNd1U4KGgEoFROYDyMorl4MyN76BP+Xm9VlL
         qdBzjKdc/IINhWwTu08wSU4DuSZ2wiDJbGQwxNpYVPREHJYXr0p7iPAdYxPdCToz4Fdz
         2q8QAwfv7gkGIQy4lzUxpQzn/xEJdOI3yl3hwk/SGL3mAoAcWvWc9GAPHQQyb96vy+Ia
         JHxBG17pEheFznLKXsOvZLKtecl3iHlSoNZdkBpAc3I119zfvHFk0V82jHhjcGCdlb3l
         kqsEamTYSoXJDJJeUpTh5guJhZ1SwpT4MfPb6cDuCVwINflG6FUKdXzywkqe1CxJLHE0
         xtiw==
X-Gm-Message-State: AOAM533jiPGEn//T8FTZpd/QwNUa0fYtuhyZvGrxnG2+uC6IP2bS1RrU
        QO1iNtImrZXU1O/x4m1062L5VH/5mKb5hyQO6tK7nQ==
X-Google-Smtp-Source: ABdhPJxaX8EKh1++EIPdXEy9vz+JqwIHdkgVBY0k1neyuVfIClkmj6c97zfxXYhjxFQKVzDWdG2PNPtf63cT4sN/knE=
X-Received: by 2002:aa7:de92:: with SMTP id j18mr10392290edv.141.1630881611812;
 Sun, 05 Sep 2021 15:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
 <20210826012626.1163705-3-isabellabdoamaral@usp.br> <CANpmjNPdP4OZGE3is4twths1fejCjZeEKAweVpgdqBUc=e59ww@mail.gmail.com>
In-Reply-To: <CANpmjNPdP4OZGE3is4twths1fejCjZeEKAweVpgdqBUc=e59ww@mail.gmail.com>
From:   Isabella B do Amaral <isabellabdoamaral@usp.br>
Date:   Sun, 5 Sep 2021 19:40:00 -0300
Message-ID: <CAAniXFSQck-pyHiyPWca0JW+vKPsP59W6X5Q2Fq_Yr-rKxn92w@mail.gmail.com>
Subject: Re: [PATCH 2/6] test_hash.c: move common definitions to top of file
To:     Marco Elver <elver@google.com>
Cc:     geert@linux-m68k.org, Enzo Ferreira <ferreiraenzoa@gmail.com>,
        =?UTF-8?Q?Augusto_Dur=C3=A3es_Camargo?= 
        <augusto.duraes33@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, ~lkcamp/patches@lists.sr.ht,
        rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Marco,

On Thu, Aug 26, 2021 at 11:36 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, 26 Aug 2021 at 03:26, 'Isabella Basso' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> > Keep function signatures minimal by making common definitions static.
> > This does not change any behavior.
>
> This seems like an odd change; if I read it right it's changing the
> out-param passed to test_int_hash() to simply be static globals.
>
> For one, it makes the code harder to read because now test_int_hash()
> is no longer "pure" (no global side-effects ... modulo printfs), and
> what was previously an out-param, is now a global.
>
> Unfortunately this is poor style and likely to lead to hard-to-debug
> problems. One such problem is if suddenly you have multiple threads
> involved. While this is just a test and unlikely to be a problem, I
> would recommend not introducing global state carelessly.

I see. My peers at LKCamp and I talked over the thread-safety problems for a
while but we concluded it wasn't a big deal (precisely because this is a test).
Though being stylistically poor seems a huge heads up, so I'm really thankful
for your thorough explanation(, and review)! Noted! :)

> An alternative common idiom, where a set of variables are always
> passed around to other functions, is to introduce a struct and pass a
> pointer to it along.
>
> > Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> > ---
> >  lib/test_hash.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/test_hash.c b/lib/test_hash.c
> > index d4b0cfdb0377..8bcc645a7294 100644
> > --- a/lib/test_hash.c
> > +++ b/lib/test_hash.c
> > @@ -23,6 +23,11 @@
> >  #include <linux/stringhash.h>
> >  #include <linux/printk.h>
> >
> > +#define SIZE 256 /* Run time is cubic in SIZE */
> > +
> > +static u32 string_or; /* stores or-ed string output */
> > +static u32 hash_or[2][33] = { { 0, } }; /* stores or-ed hash output */
>
> These now use up memory for as long as this module is loaded, vs.
> before where it would only use up stack space. (For a test that's not
> a problem, but in non-test code it might.)
>
> >  /* 32-bit XORSHIFT generator.  Seed must not be zero. */
> >  static u32 __init __attribute_const__
> >  xorshift(u32 seed)
> > @@ -66,7 +71,7 @@ fill_buf(char *buf, size_t len, u32 seed)
> >   * recompile and re-test the module without rebooting.
> >   */
> >  static bool __init
> > -test_int_hash(unsigned long long h64, u32 hash_or[2][33])
> > +test_int_hash(unsigned long long h64)
> >  {
> >         int k;
> >         u32 h0 = (u32)h64, h1, h2;
> > @@ -123,17 +128,15 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
> >         return true;
> >  }
> >
> > -#define SIZE 256       /* Run time is cubic in SIZE */
> > -
> >  static int __init
> >  test_hash_init(void)
> >  {
> >         char buf[SIZE+1];
> > -       u32 string_or = 0, hash_or[2][33] = { { 0, } };
> >         unsigned tests = 0;
> >         unsigned long long h64 = 0;
> >         int i, j;
> >
> > +       string_or = 0;
>
> That's another problem with changes like this; now the compiler has no
> chance to warn you in case the variable is not initialized correctly.
>
> Also, I don't see string_or used anywhere else. Why make it global?
> If a later change would require that, it should say so in the commit
> message. But my guess is you can avoid all that by bundling everything
> up in a struct.
>
> >         fill_buf(buf, SIZE, 1);
> >
> >         /* Test every possible non-empty substring in the buffer. */
> > @@ -161,7 +164,7 @@ test_hash_init(void)
> >
> >                         string_or |= h0;
> >                         h64 = h64 << 32 | h0;   /* For use with hash_64 */
> > -                       if (!test_int_hash(h64, hash_or))
> > +                       if (!test_int_hash(h64))
> >                                 return -EINVAL;
> >                         tests++;
> >                 } /* i */
> > --
> > 2.33.0

Thanks,
--
Isabella Basso
