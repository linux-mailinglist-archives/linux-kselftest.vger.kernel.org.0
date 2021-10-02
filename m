Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117FE41FA3D
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhJBHWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Oct 2021 03:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhJBHWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Oct 2021 03:22:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B799DC061775
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Oct 2021 00:20:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso8294761wme.0
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Oct 2021 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FnGZoxeDqkUXZxDHIuKWA3WY8/3b4UZNXWAVQLvHaU=;
        b=mQ1RQo+1hJqiCB4hNcMrnvesT/bvrEbIBGsDvIud4xTJ+zIA0qj9hAYx3z22O24DT1
         M3Aicm75v5Ui80tx1LSG6gdBXkuWEyPv82Sr6oWlsKBT+sfFguCJLhbjYKtLBrPgpv2z
         dEvNMFz3myDZo/sDzq/Xqr/sK311NhjZq38O7hsgoPoqsPcQbHFpanBi106FUR2f1bwB
         gd5/CFIWSu255BXLxAXHcrSlhMv83l1GKVD4Otyo/zkZExMQAuP8gj+lGIeuywa60fl2
         B1qmpM40b9SrtLTLho0oW9qc0eqaZkRsoFGQYiJGLyxM7fhxAq2uuiSHVgVddov/lT7O
         udig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FnGZoxeDqkUXZxDHIuKWA3WY8/3b4UZNXWAVQLvHaU=;
        b=EfvifPgAkoH3nlw2DBZnw4ZW/zgQHSvW23Rq5TGFV0UxKQUH1ynuuCPBZ8AElGhGqu
         HIekjzwPugbq7EIvw7kugc/5Egif/KJx654/ZlfGDA+KYSePTchS1zsoZLepL0rJLbKy
         ZoFsxP9ai42ySz/1oG8qdvzWDVcOReDeOU9Kz01ud4152Dv+btzD4qpQIB6W6WqU0S3u
         Ax2WPl7CoWiAKIa4QT8xJrOXTE2P6G2DwZfOrASCIlfaFo67De67TD79xcTzL2ZTGs6u
         cHxafMLrV+GUQmF5zGIgvx8z4Qmtwu1ihr0/yG+oxsmsLySKviLmYDPlTrCaZSAy/SNo
         OkQA==
X-Gm-Message-State: AOAM532KuHzzfVzGalEyuXc1ucBKjBNqcbdTBu/6MZQzCVCKq0F14tE5
        C9dbYg4vxYGwOHzuSlQpkkWq+0cc0nL7Qj3v+tntkQ==
X-Google-Smtp-Source: ABdhPJzjELT9F60D42m4Yx/7U10YB04bKrU0ShGAnqywmTaJZHXJkeIma30H9xv619fTILqUMPcxmZs9JNes5fn6GTQ=
X-Received: by 2002:a7b:c453:: with SMTP id l19mr8062506wmi.7.1633159225169;
 Sat, 02 Oct 2021 00:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br> <20210926223322.848641-3-isabellabdoamaral@usp.br>
In-Reply-To: <20210926223322.848641-3-isabellabdoamaral@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Oct 2021 15:20:14 +0800
Message-ID: <CABVgOS=kzCyfHgR_5OwoqMuNZBmziYFFa5gTVzH-W4ZbV101xQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] test_hash.c: split test_int_hash into
 arch-specific functions
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, ferreiraenzoa@gmail.com,
        augusto.duraes33@gmail.com,
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

On Mon, Sep 27, 2021 at 6:33 AM Isabella Basso <isabellabdoamaral@usp.br> wrote:
>
> Split the test_int_hash function to keep its mainloop separate from
> arch-specific chunks, which are only compiled as needed. This aims at
> improving readability.
>
> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---

This looks good to me. It's possibly worth fixing up the changelog
mixup between this and patch 3 if you send out a v3.

A minor suggestion re: commenting below, otherwise this is:

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  lib/test_hash.c | 86 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 57 insertions(+), 29 deletions(-)
>
> diff --git a/lib/test_hash.c b/lib/test_hash.c
> index d4b0cfdb0377..08fe63776c4f 100644
> --- a/lib/test_hash.c
> +++ b/lib/test_hash.c
> @@ -56,6 +56,53 @@ fill_buf(char *buf, size_t len, u32 seed)
>         }
>  }
>
> +/* Holds most testing variables for the int test */

It might be worth commenting what these variables actually are here,
as it's pretty confusing on a quick read through.

Maybe something like:

> +struct test_hash_params {
> +       unsigned long long *h64;

/* Pointer to integer to be hashed. */

> +       u32 h0;

/* Low 32-bits of integer to be hashed. */

> +       u32 h1;

/* Arch-specific hash result. */

> +       u32 h2;

/* Generic hash result. */

> +       u32 (*hash_or)[33];

/* ORed hashes of given size (in bits) */


> +};
> +
> +#ifdef HAVE_ARCH__HASH_32
> +static bool __init
> +test_int__hash_32(struct test_hash_params *params)
> +{
> +       params->hash_or[1][0] |= params->h2 = __hash_32_generic(params->h0);
> +#if HAVE_ARCH__HASH_32 == 1
> +       if (params->h1 != params->h2) {
> +               pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
> +                      params->h0, params->h1, params->h2);
> +               return false;
> +       }
> +#endif
> +       return true;
> +}
> +#endif
> +
> +#ifdef HAVE_ARCH_HASH_64
> +static bool __init
> +test_int_hash_64(struct test_hash_params *params, u32 const *m, int *k)
> +{
> +       params->h2 = hash_64_generic(*params->h64, *k);
> +#if HAVE_ARCH_HASH_64 == 1
> +       if (params->h1 != params->h2) {
> +               pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
> +                      *params->h64, *k, params->h1, params->h2);
> +               return false;
> +       }
> +#else
> +       if (params->h2 > *m) {
> +               pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
> +                      *params->h64, *k, params->h1, *m);
> +               return false;
> +       }
> +#endif
> +       return true;
> +}
> +#endif
> +
>  /*
>   * Test the various integer hash functions.  h64 (or its low-order bits)
>   * is the integer to hash.  hash_or accumulates the OR of the hash values,
> @@ -69,19 +116,13 @@ static bool __init
>  test_int_hash(unsigned long long h64, u32 hash_or[2][33])
>  {
>         int k;
> -       u32 h0 = (u32)h64, h1, h2;
> +       struct test_hash_params params = { &h64, (u32)h64, 0, 0, hash_or };
>
>         /* Test __hash32 */
> -       hash_or[0][0] |= h1 = __hash_32(h0);
> +       hash_or[0][0] |= params.h1 = __hash_32(params.h0);
>  #ifdef HAVE_ARCH__HASH_32
> -       hash_or[1][0] |= h2 = __hash_32_generic(h0);
> -#if HAVE_ARCH__HASH_32 == 1
> -       if (h1 != h2) {
> -               pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
> -                       h0, h1, h2);
> +       if (!test_int__hash_32(&params))
>                 return false;
> -       }
> -#endif
>  #endif
>
>         /* Test k = 1..32 bits */
> @@ -89,37 +130,24 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
>                 u32 const m = ((u32)2 << (k-1)) - 1;    /* Low k bits set */
>
>                 /* Test hash_32 */
> -               hash_or[0][k] |= h1 = hash_32(h0, k);
> -               if (h1 > m) {
> -                       pr_err("hash_32(%#x, %d) = %#x > %#x", h0, k, h1, m);
> +               hash_or[0][k] |= params.h1 = hash_32(params.h0, k);
> +               if (params.h1 > m) {
> +                       pr_err("hash_32(%#x, %d) = %#x > %#x", params.h0, k, params.h1, m);
>                         return false;
>                 }
>
>                 /* Test hash_64 */
> -               hash_or[1][k] |= h1 = hash_64(h64, k);
> -               if (h1 > m) {
> -                       pr_err("hash_64(%#llx, %d) = %#x > %#x", h64, k, h1, m);
> +               hash_or[1][k] |= params.h1 = hash_64(h64, k);
> +               if (params.h1 > m) {
> +                       pr_err("hash_64(%#llx, %d) = %#x > %#x", h64, k, params.h1, m);
>                         return false;
>                 }
>  #ifdef HAVE_ARCH_HASH_64
> -               h2 = hash_64_generic(h64, k);
> -#if HAVE_ARCH_HASH_64 == 1
> -               if (h1 != h2) {
> -                       pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() "
> -                               "= %#x", h64, k, h1, h2);
> +               if (!test_int_hash_64(&params, &m, &k))
>                         return false;
> -               }
> -#else
> -               if (h2 > m) {
> -                       pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
> -                               h64, k, h1, m);
> -                       return false;
> -               }
> -#endif
>  #endif
>         }
>
> -       (void)h2;       /* Suppress unused variable warning */
>         return true;
>  }
>
> --
> 2.33.0
>
