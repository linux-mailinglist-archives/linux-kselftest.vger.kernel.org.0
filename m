Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB943E570
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 17:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhJ1Pth (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhJ1Ptg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 11:49:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E962CC061570
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 08:47:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r12so26840288edt.6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I35xArwltgiSIDBXrA/Vf3yctOp3/8GeHcmmTTSQz2I=;
        b=XfsWYOjc3jrRehmYG0Ww3uMg7/yWXF7kuZrYyXaUUL7XiAeEbVX3Qyi6dkCVQfTmWI
         yr9KVWBc5It7BdCCSQNzzncW7tg8SHQalJMAscKcV+wBvjCg8v5KXRfSia/m/GGQT0nH
         Z+0C6x6X/inK4kBotlFaie/jSAT/wY/JZSxH+N6nTLRYMLuRdGjFf5Yjr9Fg8SV3Ds5X
         drMFUdAHXrIfV2e6A508fxgfKhZeBmVw2EFJPTPE6caqLt6vuUIBvO5BBaBvhbF4arMf
         B6ynfIcEisPd64XP+BwWWbQbJ3MB3mWHQr2/x4haqqbS4OlwnctRHSW5+aV9nSNSuSOo
         BzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I35xArwltgiSIDBXrA/Vf3yctOp3/8GeHcmmTTSQz2I=;
        b=mhs+85FsVJSUsq03yrp7uW+95tJWj2Hz93a4OPEgTfIAZD2MevfSCeCrc4x/7vhpwG
         1Z3wM5f45SNgQxZM1Vz4G6XM+58e9B/bt2DUkD2mGP8ZVe+Iw8MxAL4FAUBlO/KRE02D
         HFBvwFfB5sn2uyMXnxtzCzOv6g3KnluAcAhFeyLczkgIAAMSDqjmL/B7y1UB3cin4n3l
         d4gsNvX5MS2OwMnom1mRuREzpt6zC0cJjujoZVzHRBmBiACyAjHHS7KOrjt6JJi4UFQp
         7Xmo/ZgD5zuVyl52TgIrdOl+ILDlj+ETO4gYQ/l0ZPEi01YDzzkyZzZl4beSwnAZRud2
         QVww==
X-Gm-Message-State: AOAM533lnrP/SMJz2cqXLNe1dsONYYn/Uic0PJ3al7d0ZZd57sWOshYw
        ILnotUJcoVZ7qMhXS7ywcu8MxPbgd51gFTU5R45RJKMhHrGhlQ==
X-Google-Smtp-Source: ABdhPJwAYSs3BPjpV09HmLQ7ZGUrfadfg/HQzTUY7V9O4KylolyNfDWq6MXXHmbJJUCYzHyxMPhxLQ5XHjPISctuniw=
X-Received: by 2002:a17:906:2a06:: with SMTP id j6mr6373148eje.401.1635436027126;
 Thu, 28 Oct 2021 08:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
 <20210926223322.848641-2-isabellabdoamaral@usp.br> <CABVgOS=Ux00jm9Qiy-u0zhhHUBpmXQCsnFdr=sEU-1q1XBWM7w@mail.gmail.com>
In-Reply-To: <CABVgOS=Ux00jm9Qiy-u0zhhHUBpmXQCsnFdr=sEU-1q1XBWM7w@mail.gmail.com>
From:   Isabella B do Amaral <isabellabdoamaral@usp.br>
Date:   Thu, 28 Oct 2021 12:46:55 -0300
Message-ID: <CAAniXFSgtYP3OFqTNmfRQg0kUtJb3oztT8od9XnMdj+LMNwNKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hash.h: remove unused define directive
To:     David Gow <davidgow@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Enzo Ferreira <ferreiraenzoa@gmail.com>,
        =?UTF-8?Q?Augusto_Dur=C3=A3es_Camargo?= 
        <augusto.duraes33@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, David,

On Sat, Oct 2, 2021 at 4:20 AM David Gow <davidgow@google.com> wrote:
>
> On Mon, Sep 27, 2021 at 6:33 AM Isabella Basso <isabellabdoamaral@usp.br>=
 wrote:
> >
> > Currently, there exist hash_32() and __hash_32() functions, which were
> > introduced in a patch [1] targeting architecture specific optimizations=
.
> > These functions can be overridden on a per-architecture basis to achiev=
e
> > such optimizations. They must set their corresponding define directive
> > (HAVE_ARCH_HASH_32 and HAVE_ARCH__HASH_32, respectively) so that header
> > files can deal with these overrides properly.
> >
> > As the supported 32-bit architectures that have their own hash function
> > implementation (i.e. m68k, Microblaze, H8/300, pa-risc) have only been
> > making use of the (more general) __hash_32() function (which only lacks
> > a right shift operation when compared to the hash_32() function),
> > remove the define directive corresponding to the arch-specific hash_32(=
)
> > implementation.
> >
> > [1] https://lore.kernel.org/lkml/20160525073311.5600.qmail@ns.scienceho=
rizons.net/
> >
> > Changes since v1:
> > - As suggested by David Gow:
> >   1. Reword commit message.
>
> Maybe move this changelog to below the "---", so it doesn't show up in
> the final commit message?

Oh, okay! Thanks for pointing that out :) I didn't quite know how I
should put these.

>
> >
> > Tested-by: David Gow <davidgow@google.com>
> > Co-developed-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.co=
m>
> > Signed-off-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> > Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> > Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> > Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> > ---
>
> This looks sensible enough to me. Since no-one seems to be speaking up
> in architecture-specific hash_32()'s defence, let's get rid of it.
>
> Reviewed-by: David Gow <davidgow@google.com>
>

Alright! Thanks for the review.

Cheers,
--
Isabella B.

>
> >  include/linux/hash.h       |  5 +----
> >  lib/test_hash.c            | 24 +-----------------------
> >  tools/include/linux/hash.h |  5 +----
> >  3 files changed, 3 insertions(+), 31 deletions(-)
> >
> > diff --git a/include/linux/hash.h b/include/linux/hash.h
> > index ad6fa21d977b..38edaa08f862 100644
> > --- a/include/linux/hash.h
> > +++ b/include/linux/hash.h
> > @@ -62,10 +62,7 @@ static inline u32 __hash_32_generic(u32 val)
> >         return val * GOLDEN_RATIO_32;
> >  }
> >
> > -#ifndef HAVE_ARCH_HASH_32
> > -#define hash_32 hash_32_generic
> > -#endif
> > -static inline u32 hash_32_generic(u32 val, unsigned int bits)
> > +static inline u32 hash_32(u32 val, unsigned int bits)
> >  {
> >         /* High bits are more random, so use them. */
> >         return __hash_32(val) >> (32 - bits);
> > diff --git a/lib/test_hash.c b/lib/test_hash.c
> > index 0ee40b4a56dd..d4b0cfdb0377 100644
> > --- a/lib/test_hash.c
> > +++ b/lib/test_hash.c
> > @@ -94,22 +94,7 @@ test_int_hash(unsigned long long h64, u32 hash_or[2]=
[33])
> >                         pr_err("hash_32(%#x, %d) =3D %#x > %#x", h0, k,=
 h1, m);
> >                         return false;
> >                 }
> > -#ifdef HAVE_ARCH_HASH_32
> > -               h2 =3D hash_32_generic(h0, k);
> > -#if HAVE_ARCH_HASH_32 =3D=3D 1
> > -               if (h1 !=3D h2) {
> > -                       pr_err("hash_32(%#x, %d) =3D %#x !=3D hash_32_g=
eneric() "
> > -                               " =3D %#x", h0, k, h1, h2);
> > -                       return false;
> > -               }
> > -#else
> > -               if (h2 > m) {
> > -                       pr_err("hash_32_generic(%#x, %d) =3D %#x > %#x"=
,
> > -                               h0, k, h1, m);
> > -                       return false;
> > -               }
> > -#endif
> > -#endif
> > +
> >                 /* Test hash_64 */
> >                 hash_or[1][k] |=3D h1 =3D hash_64(h64, k);
> >                 if (h1 > m) {
> > @@ -227,13 +212,6 @@ test_hash_init(void)
> >  #else
> >         pr_info("__hash_32() has no arch implementation to test.");
> >  #endif
> > -#ifdef HAVE_ARCH_HASH_32
> > -#if HAVE_ARCH_HASH_32 !=3D 1
> > -       pr_info("hash_32() is arch-specific; not compared to generic.")=
;
> > -#endif
> > -#else
> > -       pr_info("hash_32() has no arch implementation to test.");
> > -#endif
> >  #ifdef HAVE_ARCH_HASH_64
> >  #if HAVE_ARCH_HASH_64 !=3D 1
> >         pr_info("hash_64() is arch-specific; not compared to generic.")=
;
> > diff --git a/tools/include/linux/hash.h b/tools/include/linux/hash.h
> > index ad6fa21d977b..38edaa08f862 100644
> > --- a/tools/include/linux/hash.h
> > +++ b/tools/include/linux/hash.h
> > @@ -62,10 +62,7 @@ static inline u32 __hash_32_generic(u32 val)
> >         return val * GOLDEN_RATIO_32;
> >  }
> >
> > -#ifndef HAVE_ARCH_HASH_32
> > -#define hash_32 hash_32_generic
> > -#endif
> > -static inline u32 hash_32_generic(u32 val, unsigned int bits)
> > +static inline u32 hash_32(u32 val, unsigned int bits)
> >  {
> >         /* High bits are more random, so use them. */
> >         return __hash_32(val) >> (32 - bits);
> > --
> > 2.33.0
> >
