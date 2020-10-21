Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239BC29470A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 05:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411806AbgJUDkh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 23:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411796AbgJUDkg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 23:40:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0522AC0613D3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 20:40:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so1090141lfl.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 20:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JoE0kjuYNgBx2amTFrwP2jZ4AlMXTR1jOZVE1qRHmg=;
        b=Dk1/Wx5tGmv4Yk9/p5QXncgQuBT6RNrlcFPcC96ZjucnlkoQCzl7IV7s9D0AkCWNP5
         ZaOEVsbrsr872Es5Snjm+Zw4AzzVOYX6/o2IZAW3oNC0/KTPsyZMXRC5EAypg3LBudJy
         0Tx/I9PPMtfe7VB80hp573mcMNj4C6lKVRkniBloZkU9MuFtC2anbsJNxp4T1CVDjJhL
         drk0XSTWrDTN32N8bGuO6MM6s4lvZ1ZC2X1VFZCDisC97QPW2NXeP5ydzcplCWErKPN/
         dtBOICPKpJ+m3ZrchlbpxCziMlBMHPTydT1H/afM2VVoe1a63wgxH4UNwneu0D041eGJ
         YjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JoE0kjuYNgBx2amTFrwP2jZ4AlMXTR1jOZVE1qRHmg=;
        b=KMbpRRqj9XjqQHS2xaCDwSMbDGZso1V2nCbOY7qDl3ojnaRR2rt7/a8MKC8fTgXTJ3
         OySptMvToWOeRunb3HGIMSnRapXDphLOHo41nk1+zV0dzcicjV/PSG/JM9qdCC1/d27r
         fhiMjmo6+eX26E7IRisaoPc4Gzc0tWkaB0SEAjo5jrOpkT0Xi7GZPo6UCITfakdZ+7kx
         x8D2jp907ZnccKGilMjHrakUu4j3a3P/p6m5ecdnnKJUrfu9cbPu1RQArnX/YvIW6X8K
         D/ZUw8bQ+9F0RV6WsHsQ5TwHj1zNhLlC1mphLAMhM5+XjAlfcTQSuVKDlSpasfuO/FSG
         hDhA==
X-Gm-Message-State: AOAM532+0TwTJR5URdA+p0socCPKjwW+8e61kPqUnvawTnlFUwvswPbI
        8PeVVGHtmy4CUAmgyIpbWG/IYoJWsMOnzk+xkgwOEw==
X-Google-Smtp-Source: ABdhPJwV/9B9pIMkPEIjM/8xuyHC4acUnUYj40tEDGr523skSmuf4LNG/0GQzL5nf0PlzTiS5TBxaqlBB2p/vubk5Vc=
X-Received: by 2002:a05:6512:3691:: with SMTP id d17mr334184lfs.243.1603251632186;
 Tue, 20 Oct 2020 20:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201019224556.3536790-1-dlatypov@google.com>
In-Reply-To: <20201019224556.3536790-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 21 Oct 2020 11:40:20 +0800
Message-ID: <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 20, 2020 at 6:46 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Add basic test coverage for files that don't require any config options:
> * gcd.c
> * lcm.c
> * int_sqrt.c
> * reciprocal_div.c
> (Ignored int_pow.c since it's a simple textbook algorithm.)
>
I don't see a particular reason why int_pow.c being a simple algorithm
means it shouldn't be tested. I'm not saying it has to be tested by
this particular change -- and I doubt the test would be
earth-shatteringly interesting -- but there's no real reason against
testing it.

> These tests aren't particularly interesting, but
> * they're chosen as easy to understand examples of how to write tests
> * provides a place to add tests for any new files in this dir
> * written so adding new test cases to cover edge cases should be easy

I think these tests can stand on their own merits, rather than just as
examples (though I do think they do make good additional examples for
how to test these sorts of functions).
So, I'd treat this as an actual test of the maths functions (and
you've got what seems to me a decent set of test cases for that,
though there are a couple of comments below) first, and any use it
gains as an example is sort-of secondary to that (anything that makes
it a better example is likely to make it a better test anyway).

In any case, modulo the comments below, this seems good to me.

-- David

> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>  lib/math/Kconfig     |   5 ++
>  lib/math/Makefile    |   2 +
>  lib/math/math_test.c | 197 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100644 lib/math/math_test.c
>
> diff --git a/lib/math/Kconfig b/lib/math/Kconfig
> index f19bc9734fa7..6ba8680439c1 100644
> --- a/lib/math/Kconfig
> +++ b/lib/math/Kconfig
> @@ -15,3 +15,8 @@ config PRIME_NUMBERS
>
>  config RATIONAL
>         bool
> +
> +config MATH_KUNIT_TEST
> +       tristate "KUnit test for lib/math" if !KUNIT_ALL_TESTS
> +       default KUNIT_ALL_TESTS
> +       depends on KUNIT
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index be6909e943bd..fba6fe90f50b 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -4,3 +4,5 @@ obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
>  obj-$(CONFIG_CORDIC)           += cordic.o
>  obj-$(CONFIG_PRIME_NUMBERS)    += prime_numbers.o
>  obj-$(CONFIG_RATIONAL)         += rational.o
> +
> +obj-$(CONFIG_MATH_KUNIT_TEST)  += math_test.o
> diff --git a/lib/math/math_test.c b/lib/math/math_test.c
> new file mode 100644
> index 000000000000..6f4681ea7c72
> --- /dev/null
> +++ b/lib/math/math_test.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Simple KUnit suite for math helper funcs that are always enabled.
> + *
> + * Copyright (C) 2020, Google LLC.
> + * Author: Daniel Latypov <dlatypov@google.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/gcd.h>
> +#include <linux/kernel.h>
> +#include <linux/lcm.h>
> +#include <linux/reciprocal_div.h>
> +
> +/* Generic test case for unsigned long inputs. */
> +struct test_case {
> +       unsigned long a, b;
> +       unsigned long result;
> +};
> +
> +static void gcd_test(struct kunit *test)
> +{
> +       const char *message_fmt = "gcd(%lu, %lu)";
> +       int i;
> +
> +       struct test_case test_cases[] = {
> +               {
> +                       .a = 0, .b = 1,
> +                       .result = 1,
> +               },
> +               {
> +                       .a = 2, .b = 2,
> +                       .result = 2,
> +               },
> +               {
> +                       .a = 2, .b = 4,
> +                       .result = 2,
> +               },
> +               {
> +                       .a = 3, .b = 5,
> +                       .result = 1,
> +               },
> +               {
> +                       .a = 3*9, .b = 3*5,
> +                       .result = 3,
> +               },
> +               {
> +                       .a = 3*5*7, .b = 3*5*11,
> +                       .result = 15,
> +               },
> +               {
> +                       .a = (1 << 21) - 1,
> +                       .b = (1 << 22) - 1,

It might be worth noting the factors of these (7^2*127*337 and
3*23*89*683) in a comment.
They aren't mersenne primes, if that's what you were going for, though
they are coprime.

> +                       .result = 1,
> +               },
> +       };
> +
> +       for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
> +               KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
> +                                   gcd(test_cases[i].a, test_cases[i].b),
> +                                   message_fmt, test_cases[i].a,
> +                                   test_cases[i].b);
> +
> +               /* gcd(a,b) == gcd(b,a) */
> +               KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
> +                                   gcd(test_cases[i].b, test_cases[i].a),
> +                                   message_fmt, test_cases[i].b,
> +                                   test_cases[i].a);
> +       }
> +}
> +
> +static void lcm_test(struct kunit *test)
> +{
> +       const char *message_fmt = "lcm(%lu, %lu)";
> +       int i;
> +
> +       struct test_case test_cases[] = {
> +               {
> +                       .a = 0, .b = 1,
> +                       .result = 0,
> +               },
> +               {
> +                       .a = 1, .b = 2,
> +                       .result = 2,
> +               },
> +               {
> +                       .a = 2, .b = 2,
> +                       .result = 2,
> +               },
> +               {
> +                       .a = 3*5, .b = 3*7,
> +                       .result = 3*5*7,
> +               },

If you were looking for extra testcases here, one where b < a would be nice.

> +       };
> +
> +       for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
> +               KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
> +                                   lcm(test_cases[i].a, test_cases[i].b),
> +                                   message_fmt, test_cases[i].a,
> +                                   test_cases[i].b);
> +
> +               /* lcm(a,b) == lcm(b,a) */
> +               KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
> +                                   lcm(test_cases[i].b, test_cases[i].a),
> +                                   message_fmt, test_cases[i].b,
> +                                   test_cases[i].a);
> +       }
> +}
> +

Again, not pushing for it in this test, but lcm_not_zero() could be
worth testing at some point, too...

> +static void int_sqrt_test(struct kunit *test)
> +{
> +       const char *message_fmt = "sqrt(%lu)";
> +       int i;
> +
> +       struct test_case test_cases[] = {
> +               {
> +                       .a = 0,
> +                       .result = 0,
> +               },
> +               {
> +                       .a = 1,
> +                       .result = 1,
> +               },
> +               {
> +                       .a = 4,
> +                       .result = 2,
> +               },
> +               {
> +                       .a = 5,
> +                       .result = 2,
> +               },
> +               {
> +                       .a = 8,
> +                       .result = 2,
> +               },
> +               {
> +                       .a = 1UL >> 32,
> +                       .result = 1UL >> 16,

As the kernel test robot noted, these are wrong (the shifts go the
wrong way, 2^32 might not fit in an unsigned long).

> +               },
> +       };
> +
> +       for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
> +               KUNIT_EXPECT_EQ_MSG(test, int_sqrt(test_cases[i].a),
> +                                   test_cases[i].result, message_fmt,
> +                                   test_cases[i].a);
> +       }
> +}
> +
> +struct reciprocal_test_case {
> +       u32 a, b;
> +       u32 result;
> +};
> +
> +static void reciprocal_div_test(struct kunit *test)
> +{
> +       int i;
> +       struct reciprocal_value rv;
> +       struct reciprocal_test_case test_cases[] = {
> +               {
> +                       .a = 0, .b = 1,
> +                       .result = 0,
> +               },
> +               {
> +                       .a = 42, .b = 20,
> +                       .result = 2,
> +               },
> +               {
> +                       .a = (1<<16), .b = (1<<14),
> +                       .result = 1<<2,
> +               },
> +       };
> +
> +       for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
> +               rv = reciprocal_value(test_cases[i].b);
> +               KUNIT_EXPECT_EQ_MSG(test, test_cases[i].result,
> +                                   reciprocal_divide(test_cases[i].a, rv),
> +                                   "reciprocal_divide(%u, %u)",
> +                                   test_cases[i].a, test_cases[i].b);
> +       }
> +}
> +
> +static struct kunit_case math_test_cases[] = {
> +       KUNIT_CASE(gcd_test),
> +       KUNIT_CASE(lcm_test),
> +       KUNIT_CASE(int_sqrt_test),
> +       KUNIT_CASE(reciprocal_div_test),
> +       {}
> +};
> +
> +static struct kunit_suite math_test_suite = {
> +       .name = "lib-math",
> +       .test_cases = math_test_cases,
> +};
> +
> +kunit_test_suites(&math_test_suite);
> +
> +MODULE_LICENSE("GPL v2");
>
> base-commit: 7cf726a59435301046250c42131554d9ccc566b8
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
