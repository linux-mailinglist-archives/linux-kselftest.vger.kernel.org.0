Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B443E574
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJ1PvK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1PvK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 11:51:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BF7C061570
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 08:48:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r4so26103742edi.5
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbZ9TZiWVecEQFiE8v0DssKnTP5W+NVcms/8fiOavLY=;
        b=IL+vSHwit3FV6PaMoc8v9POwLt+FCZzBEedybH5B42uCW5WDwt689x4g/UywfEgpvt
         k7Nu4Rzg3vlI1y82D/ACednq26m+YAepiVRc5TYaieaarxW7zfy6/VqwlleaL0J6k6xW
         YQpP/7t++vw+oJz94ANpMCaroaJ+qhQuYuezemuSaDD7NMga8XPK0Qxj7cVNzOtCqgBi
         MTU3eZJLAdHB4bEzRZAx7aGROcd8yhtOR2CUFqSeHKhj3tIkSlEHBwwfydcXZ6e4pbCA
         6RlcRoJ1WalAI1RNzk+xnduYU/eUYa5k/iWfoLyJrqB0it6c7hF9v7NWXKEW4sBN5wHT
         D++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbZ9TZiWVecEQFiE8v0DssKnTP5W+NVcms/8fiOavLY=;
        b=YRsKF6bdo2kGKnpTHaIWyIYqU7cTaX8P+MhTolO2T6pNYlZ+ohlRRqSBvzQlVxTf1t
         Cg/wl3PRop8dqrg6V222IIoJT2vRqylLLn3G1c8RNbsxrAga/doiZruJqqlocFfPUj1z
         GBjpOAIj+m5R6GmcJ+v2XY+T4tWTx74MKzNxc/fpOqhvi9VHiUuKtCW+1CCKNHs3PYmx
         BA9npcMaYOI2gQ7n4Q0wkFPmr5KvGRoi/hXRtyamcxVSYvG7ojYadvMMO+lMzV5z8DxJ
         YQ6GxnYeGllkDoQaycCLkWq0ps9QC1QGSoL1/FjFPfx9wUv4rxK7S35gbWGb5CitpONf
         0j3Q==
X-Gm-Message-State: AOAM531DhHSnH4UKIZGRtnupI7iJnrZ7ghA1mdtZ38qIBSf7ZAKE3HJH
        H6zNJS4Qyl+fj6hv1yQTvEL09XvbCatrYtxy+bK9NQ==
X-Google-Smtp-Source: ABdhPJzpURV/X2pcYNSnFQ/13FLM6rnmE8k8wsgO1aYcW50j9BbWGHTPX8lqHy5MNGKXjJSdDEPEYOvwXhthwhHdZZM=
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr7153749edt.168.1635436117146;
 Thu, 28 Oct 2021 08:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
 <20210926223322.848641-3-isabellabdoamaral@usp.br> <CABVgOS=kzCyfHgR_5OwoqMuNZBmziYFFa5gTVzH-W4ZbV101xQ@mail.gmail.com>
In-Reply-To: <CABVgOS=kzCyfHgR_5OwoqMuNZBmziYFFa5gTVzH-W4ZbV101xQ@mail.gmail.com>
From:   Isabella B do Amaral <isabellabdoamaral@usp.br>
Date:   Thu, 28 Oct 2021 12:48:26 -0300
Message-ID: <CAAniXFQE5O0Zcu6HoLrw_s3g7o2--1Dc5RD9hd2O3nThWC285w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] test_hash.c: split test_int_hash into
 arch-specific functions
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
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 2, 2021 at 4:20 AM David Gow <davidgow@google.com> wrote:
>
> On Mon, Sep 27, 2021 at 6:33 AM Isabella Basso <isabellabdoamaral@usp.br> wrote:
> >
> > Split the test_int_hash function to keep its mainloop separate from
> > arch-specific chunks, which are only compiled as needed. This aims at
> > improving readability.
> >
> > Tested-by: David Gow <davidgow@google.com>
> > Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> > ---
>
> This looks good to me. It's possibly worth fixing up the changelog
> mixup between this and patch 3 if you send out a v3.
>
> A minor suggestion re: commenting below, otherwise this is:
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> -- David
>
> >  lib/test_hash.c | 86 ++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 57 insertions(+), 29 deletions(-)
> >
> > diff --git a/lib/test_hash.c b/lib/test_hash.c
> > index d4b0cfdb0377..08fe63776c4f 100644
> > --- a/lib/test_hash.c
> > +++ b/lib/test_hash.c
> > @@ -56,6 +56,53 @@ fill_buf(char *buf, size_t len, u32 seed)
> >         }
> >  }
> >
> > +/* Holds most testing variables for the int test */
>
> It might be worth commenting what these variables actually are here,
> as it's pretty confusing on a quick read through.
>
> Maybe something like:
>
> > +struct test_hash_params {
> > +       unsigned long long *h64;
>
> /* Pointer to integer to be hashed. */
>
> > +       u32 h0;
>
> /* Low 32-bits of integer to be hashed. */
>
> > +       u32 h1;
>
> /* Arch-specific hash result. */
>
> > +       u32 h2;
>
> /* Generic hash result. */
>
> > +       u32 (*hash_or)[33];
>
> /* ORed hashes of given size (in bits) */
>

Those comments look pretty sensible to me! I think I'll stick with them :)

Thanks,
--
Isabella Basso

>
> > +};
> > +
> > +#ifdef HAVE_ARCH__HASH_32
> > +static bool __init
> > +test_int__hash_32(struct test_hash_params *params)
> > +{
> > +       params->hash_or[1][0] |= params->h2 = __hash_32_generic(params->h0);
> > +#if HAVE_ARCH__HASH_32 == 1
> > +       if (params->h1 != params->h2) {
> > +               pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
> > +                      params->h0, params->h1, params->h2);
> > +               return false;
> > +       }
> > +#endif
> > +       return true;
> > +}
> > +#endif
> > +
> > +#ifdef HAVE_ARCH_HASH_64
> > +static bool __init
> > +test_int_hash_64(struct test_hash_params *params, u32 const *m, int *k)
> > +{
> > +       params->h2 = hash_64_generic(*params->h64, *k);
> > +#if HAVE_ARCH_HASH_64 == 1
> > +       if (params->h1 != params->h2) {
> > +               pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
> > +                      *params->h64, *k, params->h1, params->h2);
> > +               return false;
> > +       }
> > +#else
> > +       if (params->h2 > *m) {
> > +               pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
> > +                      *params->h64, *k, params->h1, *m);
> > +               return false;
> > +       }
> > +#endif
> > +       return true;
> > +}
> > +#endif
> > +
> >  /*
> >   * Test the various integer hash functions.  h64 (or its low-order bits)
> >   * is the integer to hash.  hash_or accumulates the OR of the hash values,
> > @@ -69,19 +116,13 @@ static bool __init
> >  test_int_hash(unsigned long long h64, u32 hash_or[2][33])
> >  {
> >         int k;
> > -       u32 h0 = (u32)h64, h1, h2;
> > +       struct test_hash_params params = { &h64, (u32)h64, 0, 0, hash_or };
> >
> >         /* Test __hash32 */
> > -       hash_or[0][0] |= h1 = __hash_32(h0);
> > +       hash_or[0][0] |= params.h1 = __hash_32(params.h0);
> >  #ifdef HAVE_ARCH__HASH_32
> > -       hash_or[1][0] |= h2 = __hash_32_generic(h0);
> > -#if HAVE_ARCH__HASH_32 == 1
> > -       if (h1 != h2) {
> > -               pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
> > -                       h0, h1, h2);
> > +       if (!test_int__hash_32(&params))
> >                 return false;
> > -       }
> > -#endif
> >  #endif
> >
> >         /* Test k = 1..32 bits */
> > @@ -89,37 +130,24 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
> >                 u32 const m = ((u32)2 << (k-1)) - 1;    /* Low k bits set */
> >
> >                 /* Test hash_32 */
> > -               hash_or[0][k] |= h1 = hash_32(h0, k);
> > -               if (h1 > m) {
> > -                       pr_err("hash_32(%#x, %d) = %#x > %#x", h0, k, h1, m);
> > +               hash_or[0][k] |= params.h1 = hash_32(params.h0, k);
> > +               if (params.h1 > m) {
> > +                       pr_err("hash_32(%#x, %d) = %#x > %#x", params.h0, k, params.h1, m);
> >                         return false;
> >                 }
> >
> >                 /* Test hash_64 */
> > -               hash_or[1][k] |= h1 = hash_64(h64, k);
> > -               if (h1 > m) {
> > -                       pr_err("hash_64(%#llx, %d) = %#x > %#x", h64, k, h1, m);
> > +               hash_or[1][k] |= params.h1 = hash_64(h64, k);
> > +               if (params.h1 > m) {
> > +                       pr_err("hash_64(%#llx, %d) = %#x > %#x", h64, k, params.h1, m);
> >                         return false;
> >                 }
> >  #ifdef HAVE_ARCH_HASH_64
> > -               h2 = hash_64_generic(h64, k);
> > -#if HAVE_ARCH_HASH_64 == 1
> > -               if (h1 != h2) {
> > -                       pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() "
> > -                               "= %#x", h64, k, h1, h2);
> > +               if (!test_int_hash_64(&params, &m, &k))
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
> > --
> > 2.33.0
> >
