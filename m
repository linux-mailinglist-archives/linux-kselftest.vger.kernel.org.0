Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA78741909E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 10:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhI0IS7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Sep 2021 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhI0IS7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Sep 2021 04:18:59 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3945C061575
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Sep 2021 01:17:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t189so24547699oie.7
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Sep 2021 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FoCYB0R53oYzBihqJ0jC7V9Vzxsrx6Am9iqfRfp7sI=;
        b=Xd+AnOxfDiFYeiOcZueBZXexoumw2PhRlFDAY4hLoG/UsDCNYvOv0Eo69YkjloOP9Z
         I7ouOJf+nhKWGDppjph7ngafcimWznTToLKCHlwXYcZTupOLZY+nGHFijPxeVl3Hgv15
         Y6ryiE5CQhyGL+ccvnjVqkICgt1/GjRPv69F0feQVsQGXpL7kFte20u0CoGQhuHDXmLw
         HRGxo9nzaMTI8BLBHMx+U5ooOxWOnY2kfjfYiRR/qcBN44j6ENhjDOV5KNJtFP8utSVQ
         f3FCm5uZOCWRtzZ50FJKJftekarJ3LljNmw3A0mWH47TLRsHWFt4Gebui0WPrsyIAz3y
         RA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FoCYB0R53oYzBihqJ0jC7V9Vzxsrx6Am9iqfRfp7sI=;
        b=aMyFV+kKLjkw1he6AL7mRJ8hWUyh/Xr/hmxSEyDZ0FxeuF1DUSj6Glp4GP4YsPL1kX
         eEfZC5ZjwWqaYvGASqfJtqnELqT3ITkOzGQDA2D+KHC5WRQvB5l+9tsyejEBu84L/wkR
         eOvr5HIUuvfJv2Jyz0zBXdDFlEiI7i8n/X8sATg+WDr2w7B9nNQ2xe8u7qpVhvAn43M1
         9y2KU0294AIJ89MJ/tw2ECUUdtvNjneeUcOk9K2siREx9FImxKBNPY79wse8uO1dm9kh
         J5OLwMMyKTPoiVuKZHU1zr8x7E5/kmc5cA0MLFLYA+3L9fQGg/KYAAlxpoW2Ojqn74OY
         ZRZw==
X-Gm-Message-State: AOAM533r/z41YzeJ26+2xwJ8te6/BseUJYJftYn53mNA6CA0yussKBPm
        LQMv13HsrnZFg8wdYFVr+iGrcuc0rkaPFoKjz9BxCcOsjqA=
X-Google-Smtp-Source: ABdhPJzcAoxej7VfJZs6Tn5ZhaWxOvPVbzTJM/rOc3miUaWr4129ddSP/2dCrWczbItE6fEqv2M3WYjETIE9OnvxI3E=
X-Received: by 2002:aca:db06:: with SMTP id s6mr11005425oig.70.1632730640739;
 Mon, 27 Sep 2021 01:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br> <20210926223322.848641-4-isabellabdoamaral@usp.br>
In-Reply-To: <20210926223322.848641-4-isabellabdoamaral@usp.br>
From:   Marco Elver <elver@google.com>
Date:   Mon, 27 Sep 2021 10:17:09 +0200
Message-ID: <CANpmjNN4z9YsD=KjGjgdXsQbKD68RGh5bu-AEX6FeryZ2GdXCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] test_hash.c: split test_hash_init
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     geert@linux-m68k.org, ferreiraenzoa@gmail.com,
        augusto.duraes33@gmail.com, brendanhiggins@google.com,
        dlatypov@google.com, davidgow@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, ~lkcamp/patches@lists.sr.ht,
        rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 27 Sept 2021 at 00:33, 'Isabella Basso' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Split up test_hash_init so that it calls each test more explicitly
> insofar it is possible without rewriting the entire file. This aims at
> improving readability.
>
> Split tests performed on string_or as they don't interfere with those
> performed in hash_or. Also separate pr_info calls about skipped tests as
> they're not part of the tests themselves, but only warn about
> (un)defined arch-specific hash functions.
>
> Changes since v1:
> - As suggested by David Gow:
>   1. Rename arch-specific test functions.
>   2. Remove spare whitespace changes.
> - As suggested by Marco Elver:
>   1. Add struct for carrying test variables.

Did the patches get mixed up? The struct doesn't appear to be introduced here.

> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---
>  lib/test_hash.c | 66 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 54 insertions(+), 12 deletions(-)
>
> diff --git a/lib/test_hash.c b/lib/test_hash.c
> index 08fe63776c4f..db9dd18b4e8b 100644
> --- a/lib/test_hash.c
> +++ b/lib/test_hash.c
> @@ -153,11 +153,39 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
>
>  #define SIZE 256       /* Run time is cubic in SIZE */
>
> -static int __init
> -test_hash_init(void)
> +static int __init test_string_or(void)
>  {
>         char buf[SIZE+1];
> -       u32 string_or = 0, hash_or[2][33] = { { 0, } };
> +       u32 string_or = 0;
> +       int i, j;
> +
> +       fill_buf(buf, SIZE, 1);
> +
> +       /* Test every possible non-empty substring in the buffer. */
> +       for (j = SIZE; j > 0; --j) {
> +               buf[j] = '\0';
> +
> +               for (i = 0; i <= j; i++) {
> +                       u32 h0 = full_name_hash(buf+i, buf+i, j-i);
> +
> +                       string_or |= h0;
> +               } /* i */
> +       } /* j */
> +
> +       /* The OR of all the hash values should cover all the bits */
> +       if (~string_or) {
> +               pr_err("OR of all string hash results = %#x != %#x",
> +                      string_or, -1u);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int __init test_hash_or(void)
> +{
> +       char buf[SIZE+1];
> +       u32 hash_or[2][33] = { { 0, } };
>         unsigned tests = 0;
>         unsigned long long h64 = 0;
>         int i, j;
> @@ -187,7 +215,6 @@ test_hash_init(void)
>                                 return -EINVAL;
>                         }
>
> -                       string_or |= h0;
>                         h64 = h64 << 32 | h0;   /* For use with hash_64 */
>                         if (!test_int_hash(h64, hash_or))
>                                 return -EINVAL;
> @@ -195,12 +222,6 @@ test_hash_init(void)
>                 } /* i */
>         } /* j */
>
> -       /* The OR of all the hash values should cover all the bits */
> -       if (~string_or) {
> -               pr_err("OR of all string hash results = %#x != %#x",
> -                       string_or, -1u);
> -               return -EINVAL;
> -       }
>         if (~hash_or[0][0]) {
>                 pr_err("OR of all __hash_32 results = %#x != %#x",
>                         hash_or[0][0], -1u);
> @@ -232,6 +253,13 @@ test_hash_init(void)
>                 }
>         }
>
> +       pr_notice("%u tests passed.", tests);
> +
> +       return 0;
> +}
> +
> +static void __init notice_skipped_tests(void)
> +{
>         /* Issue notices about skipped tests. */
>  #ifdef HAVE_ARCH__HASH_32
>  #if HAVE_ARCH__HASH_32 != 1
> @@ -247,10 +275,24 @@ test_hash_init(void)
>  #else
>         pr_info("hash_64() has no arch implementation to test.");
>  #endif
> +}
>
> -       pr_notice("%u tests passed.", tests);
> +static int __init
> +test_hash_init(void)
> +{
> +       int ret;
>
> -       return 0;
> +       ret = test_string_or();
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = test_hash_or();
> +       if (ret < 0)
> +               return ret;
> +
> +       notice_skipped_tests();
> +
> +       return ret;
>  }
>
>  static void __exit test_hash_exit(void)
> --
> 2.33.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210926223322.848641-4-isabellabdoamaral%40usp.br.
