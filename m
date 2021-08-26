Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E777C3F815B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 06:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhHZECr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 00:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhHZECr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 00:02:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CF0C0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 21:02:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i6so2763593wrv.2
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3HM/bXG5zSwq9GUwco4MejfEHbVjMmT87jzrLt6TPLQ=;
        b=QsRNc6MuUobVxBq9hrJ4hN/oUm02ypYpGftX33ffll7Gpa15Hpbh+1/cKuZ/DibU2c
         IW9De6iNWwxeeI0V6U7vMuQ10e7Uy2aKW2p+h94sSWHcpHGNrCqceNXW48AncmkdnBh7
         Jco37SvmqoDjwukXkktHML3wXwh4+zRCY2FzIYQhE87pirW5rzaFq1aipdL8wL/cIRCF
         oLKlEgFezJfyUFbo/ZM63U540Nb67JTL2ORLHSmZKtAWgQOPyOvLV31ix5Q8sQ6cum2f
         Zx5h9EYh0f5ZASyKUq/KTVpzMTWnq0mJKwd6n8T4yBZJgvRlEdYDDWdZl3DspC8d+TVV
         5cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3HM/bXG5zSwq9GUwco4MejfEHbVjMmT87jzrLt6TPLQ=;
        b=BVDMhoXyWzthwsyIfLzFIsW50ckeHBNYOvjzhnkiYkUxP7WanRPy1Igq29A02xY5YO
         ChBL4axpT6R1maUpEZ4r/fOAfKxhKU1XKTWPiHtrwTK9HBHdoYfCFdYkbH1iK1UUVe+L
         QTqdEhljcgiTgmWrQHDfWRiEqetjFHb7v0qXFYiWSYsDhC9nvpqeNAQDjHh7cUrzl9p3
         FF21NbXOiI1oSCKNdzGUvfxuuf1/ulbDv7H+adELJtlmcHv8g1WwJeK984GG6olhS/MB
         //6sbBjNIFJO4+4fGVxOEciWfkBo0cSop5jCyTUx8LOO6N15jAS/DyDwcCR5J7OaXR8U
         NnwA==
X-Gm-Message-State: AOAM533gspRzOt/DneA1l068KvUULyOzYiKMaf12eDIsk91D15Ptl1Zz
        M4PVbfxG/gT8AZ2mfwJ3B9SLQo8yTJNtn9WMrZfhpQ==
X-Google-Smtp-Source: ABdhPJw+gz/u7mF0GN738G6TB5eettn1ES3QbnqEM0LQB+i4OH/RDfjmaFO8bgetCRetbIXetdYLi0e7mN9DywpcWaY=
X-Received: by 2002:adf:8006:: with SMTP id 6mr1394954wrk.38.1629950517907;
 Wed, 25 Aug 2021 21:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br> <20210826012626.1163705-2-isabellabdoamaral@usp.br>
In-Reply-To: <20210826012626.1163705-2-isabellabdoamaral@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Thu, 26 Aug 2021 12:01:46 +0800
Message-ID: <CABVgOS==dbwMyFcP5ZMhMWGSNTXgsCw1gm2DnoCCnhA0SRhpzw@mail.gmail.com>
Subject: Re: [PATCH 1/6] hash.h: remove unused define directive
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     linux@sciencehorizons.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 26, 2021 at 9:26 AM Isabella Basso <isabellabdoamaral@usp.br> w=
rote:
>
> The HAVE_ARCH_HASH_32 (single underscore) define hasn't been used for
> any known supported architectures that have their own hash function
> implementation (i.e. m68k, Microblaze, H8/300, pa-risc) since George's
> patch [1], which introduced it.
>
> The supported 32-bit architectures from the list above have only been
> making use of the (more general) HAVE_ARCH__HASH_32 define, which only
> lacks the right shift operator, that wasn't targeted for optimizations
> so far.
>
> [1] https://lore.kernel.org/lkml/20160525073311.5600.qmail@ns.sciencehori=
zons.net/
>
> Co-developed-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> Signed-off-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---

I'm not familiar with the hash functions here, so take this with the
appropriate heap of salt, but it took me a little while to understand
exactly what this is doing.

As I understand it:
- There are separate __hash_32() and hash_32() functions.
- Both of these have generic implementations, which can optionally be
overridden by an architecture-specific optimised version.
- There aren't any architectures which provide an optimised hash_32()
implementation.
- This patch therefore removes support for architecture-specific
hash_32() implementations, and leaves only the generic implementation.
- This generic implementation of hash_32() itself relies on
__hash_32(), which may still be optimised.

Could the commit description be updated to make this a bit clearer?
While we are getting rid of the HAVE_ARCH_HASH_32 #define, that seems
to be a side-effect/implementation detail of removing support for
architecture-specific hash_32() implementations...

The other wild, out-there option would be to remove __hash_32()
entirely and make everything use hash_32(), which then could have
architecture-specific implementations. A quick grep reveals that
there's only one use of __hash_32() outside of the hashing code itself
(in fs/namei.c). This would be much more consistent with what
hash_64() does, but also would be significantly more work, and
potentially could have some implication (full_name_hash() performance
maybe?) which I'm not aware of. So it's possibly not worth it.

Cheers,
-- David

>  include/linux/hash.h       |  5 +----
>  lib/test_hash.c            | 24 +-----------------------
>  tools/include/linux/hash.h |  5 +----
>  3 files changed, 3 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/hash.h b/include/linux/hash.h
> index ad6fa21d977b..38edaa08f862 100644
> --- a/include/linux/hash.h
> +++ b/include/linux/hash.h
> @@ -62,10 +62,7 @@ static inline u32 __hash_32_generic(u32 val)
>         return val * GOLDEN_RATIO_32;
>  }
>
> -#ifndef HAVE_ARCH_HASH_32
> -#define hash_32 hash_32_generic
> -#endif
> -static inline u32 hash_32_generic(u32 val, unsigned int bits)
> +static inline u32 hash_32(u32 val, unsigned int bits)
>  {
>         /* High bits are more random, so use them. */
>         return __hash_32(val) >> (32 - bits);
> diff --git a/lib/test_hash.c b/lib/test_hash.c
> index 0ee40b4a56dd..d4b0cfdb0377 100644
> --- a/lib/test_hash.c
> +++ b/lib/test_hash.c
> @@ -94,22 +94,7 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][3=
3])
>                         pr_err("hash_32(%#x, %d) =3D %#x > %#x", h0, k, h=
1, m);
>                         return false;
>                 }
> -#ifdef HAVE_ARCH_HASH_32
> -               h2 =3D hash_32_generic(h0, k);
> -#if HAVE_ARCH_HASH_32 =3D=3D 1
> -               if (h1 !=3D h2) {
> -                       pr_err("hash_32(%#x, %d) =3D %#x !=3D hash_32_gen=
eric() "
> -                               " =3D %#x", h0, k, h1, h2);
> -                       return false;
> -               }
> -#else
> -               if (h2 > m) {
> -                       pr_err("hash_32_generic(%#x, %d) =3D %#x > %#x",
> -                               h0, k, h1, m);
> -                       return false;
> -               }
> -#endif
> -#endif
> +
>                 /* Test hash_64 */
>                 hash_or[1][k] |=3D h1 =3D hash_64(h64, k);
>                 if (h1 > m) {
> @@ -227,13 +212,6 @@ test_hash_init(void)
>  #else
>         pr_info("__hash_32() has no arch implementation to test.");
>  #endif
> -#ifdef HAVE_ARCH_HASH_32
> -#if HAVE_ARCH_HASH_32 !=3D 1
> -       pr_info("hash_32() is arch-specific; not compared to generic.");
> -#endif
> -#else
> -       pr_info("hash_32() has no arch implementation to test.");
> -#endif
>  #ifdef HAVE_ARCH_HASH_64
>  #if HAVE_ARCH_HASH_64 !=3D 1
>         pr_info("hash_64() is arch-specific; not compared to generic.");
> diff --git a/tools/include/linux/hash.h b/tools/include/linux/hash.h
> index ad6fa21d977b..38edaa08f862 100644
> --- a/tools/include/linux/hash.h
> +++ b/tools/include/linux/hash.h
> @@ -62,10 +62,7 @@ static inline u32 __hash_32_generic(u32 val)
>         return val * GOLDEN_RATIO_32;
>  }
>
> -#ifndef HAVE_ARCH_HASH_32
> -#define hash_32 hash_32_generic
> -#endif
> -static inline u32 hash_32_generic(u32 val, unsigned int bits)
> +static inline u32 hash_32(u32 val, unsigned int bits)
>  {
>         /* High bits are more random, so use them. */
>         return __hash_32(val) >> (32 - bits);
> --
> 2.33.0
>
