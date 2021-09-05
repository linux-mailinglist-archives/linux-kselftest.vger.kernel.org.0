Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC77401204
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Sep 2021 00:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhIEWzQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Sep 2021 18:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhIEWzP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Sep 2021 18:55:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3604DC061575
        for <linux-kselftest@vger.kernel.org>; Sun,  5 Sep 2021 15:54:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bt14so9695773ejb.3
        for <linux-kselftest@vger.kernel.org>; Sun, 05 Sep 2021 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sRsr7rlJU7xPFVBenjaWwyJN2JUHQZAp/JvZzzHDgo=;
        b=oxen/Ncc+XPzSdHn7g/ZaAWOYcqBcAE1YVh7hGJIwzXZ5SHkRloGz2yCSl9GGnzBfE
         ekEBE1uenPz7At89363Tiba5Bu6GORTqYDGHKtWgRl690oRg81iKci2a+AvCf4S5jprZ
         8icquHSeGTV7WeutXjOOkptYjEdSyVH1fN3LDH7KlImsQQ0trtQhbDSWzT4wAxSsL1bE
         LtfEeqa1mOnd9dX3you53xZIFzBJ420rO0nWC6tD3PGVAF8EP6rC91RxrK7K+olc1+J2
         3uH4yiB2hxpTzGUXqa/kUqeXLILLoCiDZuHWI60tMv6TxaRxxQKk5RbmtXtuiEO41qRl
         +Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sRsr7rlJU7xPFVBenjaWwyJN2JUHQZAp/JvZzzHDgo=;
        b=rCGUiFJ1lfK4JouZsAHFE8Dsmza1rG3dB7eYKIawP5bgMdVrEtdZly3nB704fUsOcx
         8zDFsET9wqW3dlLaGuUnhtybOMigxq5RqeAWFhF0wXvcsLhOC7mJYS3roSq34p2SUx/x
         TBGQHDGyuDvCgGDW+PLTei7mY98b4Ioaz6p0Qb9OIjeA+FVQTaxfBXuW32/yiVrOrnoY
         wljEBjMIT2JFEPKcna3+KxPw4pLI3X9FHbf6+3sxGMbGwDFRGrQSHX+nMLA3+fgWfg6c
         eaY4TX201zALPPKxh0c5MMxoKo2es/fj1XwG8mr+2zq8kGkLbfo/ZcpTh2yTGCYFA2ZP
         DdXg==
X-Gm-Message-State: AOAM533AHZfBBspPuh2iWcjy3/tx5p+PGdvm65Vsi5x0CEx3FaXoh1qS
        L3CPP0LcN1CTf1IApT6D2VMhopm6/yICdau+IkrJag==
X-Google-Smtp-Source: ABdhPJygIi2bgU/gVGQd2H9OtrX6AvuGAUexHuFgmGjPeO3vWLQqayFXjayCpEoNn4XVC+jigllVjemC93gV8L8vvq8=
X-Received: by 2002:a17:906:498b:: with SMTP id p11mr10478413eju.295.1630882449650;
 Sun, 05 Sep 2021 15:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
 <20210826012626.1163705-4-isabellabdoamaral@usp.br> <CABVgOSkhN-DPYnhuTG1hGU-2aP0MEaKjz+0=Sr_VNKUhpgz79g@mail.gmail.com>
In-Reply-To: <CABVgOSkhN-DPYnhuTG1hGU-2aP0MEaKjz+0=Sr_VNKUhpgz79g@mail.gmail.com>
From:   Isabella B do Amaral <isabellabdoamaral@usp.br>
Date:   Sun, 5 Sep 2021 19:53:56 -0300
Message-ID: <CAAniXFQBZUFrRV6c_g9L_yqFMYyvz4DDyof5cOtPc8kWMR+jiw@mail.gmail.com>
Subject: Re: [PATCH 3/6] test_hash.c: split test_int_hash into arch-specific functions
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
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, David,

On Thu, Aug 26, 2021 at 1:21 AM David Gow <davidgow@google.com> wrote:
>
> On Thu, Aug 26, 2021 at 9:26 AM Isabella Basso <isabellabdoamaral@usp.br> wrote:
> >
> > Split the The test_int_hash function to keep its mainloop separate from
> > arch-specific chunks, which are only compiled as needed. This aims at
> > improving readability.
> >
> > Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> > ---
>
> I like this, but have a note below. It _may_ be worth combining some
> of these test refactoring patches with the KUnit port patch:
> definitely a matter of taste rather than something I think is
> necessary, but I personally think they're related enough they could go
> together if you wanted.

I'm not really comfortable with such big diffs, to be honest, but I'll keep
this in mind!

> >  lib/test_hash.c | 84 +++++++++++++++++++++++++++++++------------------
> >  1 file changed, 54 insertions(+), 30 deletions(-)
> >
> > diff --git a/lib/test_hash.c b/lib/test_hash.c
> > index 8bcc645a7294..ed75c768c231 100644
> > --- a/lib/test_hash.c
> > +++ b/lib/test_hash.c
> > @@ -61,6 +61,45 @@ fill_buf(char *buf, size_t len, u32 seed)
> >         }
> >  }
> >
> > +#ifdef HAVE_ARCH__HASH_32
> > +static bool __init
> > +test_int_hash32(u32 *h0, u32 *h1, u32 *h2)
>
> I'm unsure about this name. Having test_int_hash32() test only
> __hash_32(), where test_int_hash64() tests hash_64() feels a little
> bit inconsistent. Maybe this is somewhere we should have the extra
> underscore like in HAVE_ARCH__HASH_32.
>
> I get that because the architecture-specific hash_32() is removed
> earlier, there's no need for an extra function to test how that
> compares against a generic function, so there's no conflict here, but
> it did confuse me briefly.

I see your point. This actually hadn't occurred to me. Now I'm thinking
test_int__hash_32() (and, by extension, test_int_hash_64()) should make for a
clearer naming convention.

> The other option is, as mentioned in the earlier patch, to keep the
> architecture-specific hash_32() (and _maybe_ get rid of __hash_32()
> entirely), in which case this name would be perfect for testing that.
>
> > +{
> > +       hash_or[1][0] |= *h2 = __hash_32_generic(h0);
> > +#if HAVE_ARCH__HASH_32 == 1
> > +       if (*h1 != *h2) {
> > +               pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
> > +                      *h0, *h1, *h2);
> > +               return false;
> > +       }
> > +#endif
> > +       return true;
> > +}
> > +#endif
> > +
> > +#ifdef HAVE_ARCH_HASH_64
> > +static bool __init
> > +test_int_hash64(unsigned long long h64, u32 *h0, u32 *h1, u32 *h2, u32 const *m, int k)
> > +{
> > +       *h2 = hash_64_generic(*h64, *k);
> > +#if HAVE_ARCH_HASH_64 == 1
> > +       if (*h1 != *h2) {
> > +               pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
> > +                      *h64, *k, *h1, *h2);
> > +               return false;
> > +       }
> > +#else
> > +       if (*h2 > *m) {
> > +               pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
> > +                      *h64, *k, *h1, *m);
> > +               return false;
> > +       }
> > +#endif
> > +       return true;
> > +
> > +}
> > +#endif
> > +
> >  /*
> >   * Test the various integer hash functions.  h64 (or its low-order bits)
> >   * is the integer to hash.  hash_or accumulates the OR of the hash values,
> > @@ -74,19 +113,17 @@ static bool __init
> >  test_int_hash(unsigned long long h64)
> >  {
> >         int k;
> > -       u32 h0 = (u32)h64, h1, h2;
> > +       u32 h0 = (u32)h64, h1;
> > +
> > +#if defined HAVE_ARCH__HASH_32 || defined HAVE_ARCH_HASH_64
> > +       u32 h2;
> > +#endif
> >
> >         /* Test __hash32 */
> >         hash_or[0][0] |= h1 = __hash_32(h0);
> >  #ifdef HAVE_ARCH__HASH_32
> > -       hash_or[1][0] |= h2 = __hash_32_generic(h0);
> > -#if HAVE_ARCH__HASH_32 == 1
> > -       if (h1 != h2) {
> > -               pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
> > -                       h0, h1, h2);
> > +       if (!test_int_hash32(&h0, &h1, &h2))
> >                 return false;
> > -       }
> > -#endif
> >  #endif
> >
> >         /* Test k = 1..32 bits */
> > @@ -107,24 +144,11 @@ test_int_hash(unsigned long long h64)
> >                         return false;
> >                 }
> >  #ifdef HAVE_ARCH_HASH_64
> > -               h2 = hash_64_generic(h64, k);
> > -#if HAVE_ARCH_HASH_64 == 1
> > -               if (h1 != h2) {
> > -                       pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() "
> > -                               "= %#x", h64, k, h1, h2);
> > +               if (!test_int_hash64(&h64, &h0, &h1, &h2, &m, &k))
> >                         return false;
> > -               }
> > -#else
> > -               if (h2 > m) {
> > -                       pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
> > -                               h64, k, h1, m);
> > -                       return false;
> > -               }
> > -#endif
> >  #endif
> >         }
> >
> > -       (void)h2;       /* Suppress unused variable warning */
> >         return true;
> >  }
> >
> > @@ -150,15 +174,15 @@ test_hash_init(void)
> >                         /* Check that hashlen_string gets the length right */
> >                         if (hashlen_len(hashlen) != j-i) {
> >                                 pr_err("hashlen_string(%d..%d) returned length"
> > -                                       " %u, expected %d",
> > -                                       i, j, hashlen_len(hashlen), j-i);
> > +                                      " %u, expected %d",
> > +                                      i, j, hashlen_len(hashlen), j-i);
>
> These whitespace changes probably aren't necessary.

Oops, that's my bad. Really unintended changes, thanks for the heads up!

> >                                 return -EINVAL;
> >                         }
> >                         /* Check that the hashes match */
> >                         if (hashlen_hash(hashlen) != h0) {
> >                                 pr_err("hashlen_string(%d..%d) = %08x != "
> > -                                       "full_name_hash() = %08x",
> > -                                       i, j, hashlen_hash(hashlen), h0);
> > +                                      "full_name_hash() = %08x",
> > +                                      i, j, hashlen_hash(hashlen), h0);
>
> These whitespace changes probably aren't necessary.
>
> >                                 return -EINVAL;
> >                         }
> >
> > @@ -178,14 +202,14 @@ test_hash_init(void)
> >         }
> >         if (~hash_or[0][0]) {
> >                 pr_err("OR of all __hash_32 results = %#x != %#x",
> > -                       hash_or[0][0], -1u);
> > +                      hash_or[0][0], -1u);
>
> This whitespace change probably isn't necessary.
>
> >                 return -EINVAL;
> >         }
> >  #ifdef HAVE_ARCH__HASH_32
> >  #if HAVE_ARCH__HASH_32 != 1    /* Test is pointless if results match */
> >         if (~hash_or[1][0]) {
> >                 pr_err("OR of all __hash_32_generic results = %#x != %#x",
> > -                       hash_or[1][0], -1u);
> > +                      hash_or[1][0], -1u);
>
> You get the idea...
>
> >                 return -EINVAL;
> >         }
> >  #endif
> > @@ -197,12 +221,12 @@ test_hash_init(void)
> >
> >                 if (hash_or[0][i] != m) {
> >                         pr_err("OR of all hash_32(%d) results = %#x "
> > -                               "(%#x expected)", i, hash_or[0][i], m);
> > +                              "(%#x expected)", i, hash_or[0][i], m);
> >                         return -EINVAL;
> >                 }
> >                 if (hash_or[1][i] != m) {
> >                         pr_err("OR of all hash_64(%d) results = %#x "
> > -                               "(%#x expected)", i, hash_or[1][i], m);
> > +                              "(%#x expected)", i, hash_or[1][i], m);
> >                         return -EINVAL;
> >                 }
> >         }
> > --
> > 2.33.0

Thanks,
--
Isabella Basso
