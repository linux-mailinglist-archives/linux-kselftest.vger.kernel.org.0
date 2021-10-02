Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1957941FA3F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhJBHW1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Oct 2021 03:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhJBHWZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Oct 2021 03:22:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93755C0613E8
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Oct 2021 00:20:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b192-20020a1c1bc9000000b0030cfaf18864so8253782wmb.4
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Oct 2021 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1Ud3yDO/mU6TccdcskPnDQTaXDLehnkBGI7d6s35xM=;
        b=B0EcOkKcH3oEQb7zcg9ToBGl49Rxgm9YBwkA6a4QdbCQqnY+1hJkg5bV+35BR1Fc8M
         lf13Nv7bgPZWZOpYZMa9ytM+a1/VhHOMZBaU8CZBBOYsRxFxQdWCM0SIr3n1zHnh42gm
         zYKYo8xQGDzPmR+wJLwPMjH7hPL9JyYuOvPYx6P3LR0xMub7nCaGFZqaCZPLr49bO+tP
         8u40ttpjkXTtTZKDFgQQLFaJB8Qrh2Y/I5uFxeSvomknEV2BH385POo9XNfzxTkCKdqx
         DqUakPPOmGw995gSbqgCzGzMVctudL8OVyZZJVNh0pSi1aoYYWV1TDfjFB/13pEow5Y7
         lGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1Ud3yDO/mU6TccdcskPnDQTaXDLehnkBGI7d6s35xM=;
        b=VVgtwFYZt1lpTY9507zw+C+iiv3tLXh1BJaHzX7cAXqbtbZuXvVDJrUWqAiZonAucW
         Y/z9XVYTxSafzUZKC8rhR/KqlA3ZDb1sxCq4h10+JM6Sz2c7yRK7ND4nR2P5CkcLwf9w
         6xM0WBhL06l1TzxvCCPBdWNsk9OxFmXP+c4ZblKq/IF5+us2fFefQPyxlQTewiWp8Piu
         sdNm44+C7Lf8M74zHQvnSRfAWS70uVG3ZTeg9bGu42JRAaxPXhaRYT7EkU/ckKJljLoU
         M2Sr2Yo/cyIiBgIna0zPjqmZIS+a0Of78z8kWlAgYCvxSeQd7fxay1mUB+UUi2CJ78N2
         lE8w==
X-Gm-Message-State: AOAM530gzuxx/GqYuaj6zT+L8ZMfJu2wp1cL32fi0Ppolvv68U3XSTrr
        5i5dgZ9mpbS37CnhTIrFLWOz44Wxihb6gWmXvyL0yA==
X-Google-Smtp-Source: ABdhPJwKCgvihNpSg67yqGnXyI4AiEwkzgNsgM56wAarVRiqQCbt8q7UO17OBUwfkGmGTUukzt2yj+K6ygnxTsL8H4A=
X-Received: by 2002:a05:600c:4eca:: with SMTP id g10mr8303412wmq.16.1633159238067;
 Sat, 02 Oct 2021 00:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br> <20210926223322.848641-4-isabellabdoamaral@usp.br>
In-Reply-To: <20210926223322.848641-4-isabellabdoamaral@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Oct 2021 15:20:27 +0800
Message-ID: <CABVgOSnC0PfFaT8AWRfE=Rv-RyF5+ZKR6HjnwA9Gp2w35UXC0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] test_hash.c: split test_hash_init
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

Nit: Move the changelog to after the "---" (and the correct patch).

>
> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---

This seems good to me, though I admit this is the part I'm probably
least knowledgeable about. I'm pretty sure there has to be a more
straightforward way to test some of these hash functions, but it's
probably better to keep this as-is rather than doing anything too
drastic in the middle of the port to KUnit.

The biggest downside here is that we now double the number of calls to
fill_buffer() and full_name_hash(), so the test is likely to be a bit
slower. It still runs fast enough (at least with the default SIZE of
256) that it's not noticeable to me, though, so I don't think it's a
problem.

Apart from Marco's comment about the changelog in the commit message
is fixed, this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


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
