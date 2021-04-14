Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A233135EA05
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Apr 2021 02:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348858AbhDNAdf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 20:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348320AbhDNAdf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 20:33:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B014DC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 17:33:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a11so16879542ioo.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 17:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajkY9cSvM0yJXBaUdfH+EY6hPA2iU5BvpjfgTOX51Fk=;
        b=H/wsEyTwh3fVtfXOc81Q37NwyeheY5mjBR6Uvlzh0UYMnxEHIMGsTJ0qcvbaInhgJc
         HnnScWvpxipVGxugIaipkfttKD0HHeWYixRsfHtkRfFwOvdX/Qx59YWEFMsNfmBfYz46
         oK6GXu998Y3aVddI5gOMlrI+4xxUb2eDbfiAjDgj6leP2emIRJ2HtkhHTFg6qJ1u+WMl
         sDEs3xJbMDXMtVSqF3Wgs8rsS4sDcXvm4Uvu68+3peKDwmk1VLatWoqzLJSAmMVQlRES
         YNee2BQVn+nPG7oW/m/0Omix+YMMA+000P7BPmftBVQxL8hfgh76B3nBi4X7B1Vy7cex
         nH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajkY9cSvM0yJXBaUdfH+EY6hPA2iU5BvpjfgTOX51Fk=;
        b=RerAeXgclUKEdOSwlX3RSWRB1B3FEVwQDcmVJPC7+5gGyCnGFMT2/K8cWeslKscIXV
         pK8IVyam2HmdqRQ7WC6flVWhI+xIvGyDj/aM/zDbrQph1v16jt6pNsirtjfJiLd1XoKp
         HTPjE8oJ7mU7tw8q72pmf1jDuSI/rqPfmieGcvvECW4mb3EPBjtMPGXQIJccjoe4lJEp
         cP2bq+HYmPYH5IK0c8riYOU66E6bcNewdPon/mbbW4jq4TluXvvBkLzw6DmnC0IyTe78
         PpHfGzusuk/QT2W5R/UyyWS9r7yYAUdIKs+h8vlLJZQ3GyEpDSs1T7MN28PuDNCd3c2R
         mgUA==
X-Gm-Message-State: AOAM531PCZR5200FC3bWaAK9Pr1Bl3phkb3Wv7swpLNtsNKbkHLF7Yay
        LpYvB/uWFWJRkIUWkd/V2avKFxuEBo5a5AY1Yqg/EA==
X-Google-Smtp-Source: ABdhPJwOKqsKv+OAXpb8uIShaFRPB3HxM8MSdwBmCP+iucCaLStLkTNLQ7R4xq+nOGbZ+syDNvZNR+vKp305VmP2cNQ=
X-Received: by 2002:a6b:fa14:: with SMTP id p20mr27435380ioh.168.1618360393909;
 Tue, 13 Apr 2021 17:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210412190715.555883-1-dlatypov@google.com> <CABVgOSnn1WYyPspo6xu2Dua_ryk0xsRqMpE-OTnvW4q6gG7Ykg@mail.gmail.com>
In-Reply-To: <CABVgOSnn1WYyPspo6xu2Dua_ryk0xsRqMpE-OTnvW4q6gG7Ykg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 13 Apr 2021 17:33:02 -0700
Message-ID: <CAGS_qxrD2+noEy7sF4bm1A_TBKuH7T_VWtpjvAppZeJk4098_w@mail.gmail.com>
Subject: Re: [PATCH v5] lib: add basic KUnit test for lib/math
To:     David Gow <davidgow@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 12, 2021 at 11:41 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Apr 13, 2021 at 3:07 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Add basic test coverage for files that don't require any config options:
> > * part of math.h (what seem to be the most commonly used macros)
> > * gcd.c
> > * lcm.c
> > * int_sqrt.c
> > * reciprocal_div.c
> > (Ignored int_pow.c since it's a simple textbook algorithm.)
> >
> > These tests aren't particularly interesting, but they
> > * provide short and simple examples of parameterized tests
> > * provide a place to add tests for any new files in this dir
> > * are written so adding new test cases to cover edge cases should be easy
> >   * looking at code coverage, we hit all the branches in the .c files
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> This looks good to me. A few comments/observations below, but nothing
> that I think should actually block this.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> -- David
>
> > ---
> > Changes since v4:
> > * add in test cases for some math.h macros (abs, round_up/round_down,
> >   div_round_down/closest)
> > * use parameterized testing less to keep things terser
> >
> > Changes since v3:
> > * fix `checkpatch.pl --strict` warnings
> > * add test cases for gcd(0,0) and lcm(0,0)
> > * minor: don't test both gcd(a,b) and gcd(b,a) when a == b
> >
> > Changes since v2: mv math_test.c => math_kunit.c
> >
> > Changes since v1:
> > * Rebase and rewrite to use the new parameterized testing support.
> > * misc: fix overflow in literal and inline int_sqrt format string.
> > * related: commit 1f0e943df68a ("Documentation: kunit: provide guidance
> > for testing many inputs") was merged explaining the patterns shown here.
> >   * there's an in-flight patch to update it for parameterized testing.
> >
> > v1: https://lore.kernel.org/lkml/20201019224556.3536790-1-dlatypov@google.com/
> > ---
> >  lib/math/Kconfig      |   5 +
> >  lib/math/Makefile     |   2 +
> >  lib/math/math_kunit.c | 264 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 271 insertions(+)
> >  create mode 100644 lib/math/math_kunit.c
> >
> > diff --git a/lib/math/Kconfig b/lib/math/Kconfig
> > index f19bc9734fa7..6ba8680439c1 100644
> > --- a/lib/math/Kconfig
> > +++ b/lib/math/Kconfig
> > @@ -15,3 +15,8 @@ config PRIME_NUMBERS
> >
> >  config RATIONAL
> >         bool
> > +
> > +config MATH_KUNIT_TEST
> > +       tristate "KUnit test for lib/math" if !KUNIT_ALL_TESTS
> > +       default KUNIT_ALL_TESTS
> > +       depends on KUNIT
>
> This could have a description of the test and KUnit here, as mentioned
> in the style guide doc:
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-kconfig-entries
>
> (I think it's sufficiently self explanatory that it's not essential,
> but it could be nice to have a more detailed description of the things
> being tested than just "lib/math".)
>

Done. I've left off the details about what the test tests so we have
less places to go and update if/when new tests are added.

> > diff --git a/lib/math/Makefile b/lib/math/Makefile
> > index be6909e943bd..30abb7a8d564 100644
> > --- a/lib/math/Makefile
> > +++ b/lib/math/Makefile
> > @@ -4,3 +4,5 @@ obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
> >  obj-$(CONFIG_CORDIC)           += cordic.o
> >  obj-$(CONFIG_PRIME_NUMBERS)    += prime_numbers.o
> >  obj-$(CONFIG_RATIONAL)         += rational.o
> > +
> > +obj-$(CONFIG_MATH_KUNIT_TEST)  += math_kunit.o
> > diff --git a/lib/math/math_kunit.c b/lib/math/math_kunit.c
> > new file mode 100644
> > index 000000000000..80a087a32884
> > --- /dev/null
> > +++ b/lib/math/math_kunit.c
> > @@ -0,0 +1,264 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Simple KUnit suite for math helper funcs that are always enabled.
> > + *
> > + * Copyright (C) 2020, Google LLC.
> > + * Author: Daniel Latypov <dlatypov@google.com>
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/gcd.h>
> > +#include <linux/kernel.h>
> > +#include <linux/lcm.h>
> > +#include <linux/reciprocal_div.h>
> > +
> > +static void abs_test(struct kunit *test)
> > +{
>
> There's something weird about taking the absolute values of char
> literals. I'm not sure if it's better to case integer literals (like
> with 'short' below), or keep it as-is.

I just thought it was amusing :)
Converting it to be like the short test below.

> > +       KUNIT_EXPECT_EQ(test, abs('\0'), '\0');
> > +       KUNIT_EXPECT_EQ(test, abs('a'), 'a');
> > +       KUNIT_EXPECT_EQ(test, abs(-'a'), 'a');
> > +
> > +       /* The expression in the macro is actually promoted to an int. */
> > +       KUNIT_EXPECT_EQ(test, abs((short)0),  0);
> > +       KUNIT_EXPECT_EQ(test, abs((short)42),  42);
> > +       KUNIT_EXPECT_EQ(test, abs((short)-42),  42);
> > +
> > +       KUNIT_EXPECT_EQ(test, abs(0),  0);
> > +       KUNIT_EXPECT_EQ(test, abs(42),  42);
> > +       KUNIT_EXPECT_EQ(test, abs(-42),  42);
> > +
> > +       KUNIT_EXPECT_EQ(test, abs(0L), 0L);
> > +       KUNIT_EXPECT_EQ(test, abs(42L), 42L);
> > +       KUNIT_EXPECT_EQ(test, abs(-42L), 42L);
> > +
> > +       KUNIT_EXPECT_EQ(test, abs(0LL), 0LL);
> > +       KUNIT_EXPECT_EQ(test, abs(42LL), 42LL);
> > +       KUNIT_EXPECT_EQ(test, abs(-42LL), 42LL);
> > +
> > +       /* Unsigned types get casted to signed. */
> > +       KUNIT_EXPECT_EQ(test, abs(0ULL), 0LL);
> > +       KUNIT_EXPECT_EQ(test, abs(42ULL), 42LL);
>
> A part of me is curious what the result is for -0x80000000, but I
> guess that's not defined, so shouldn't be tested. :-)

abs(-42ULL) == 42, but the compiler spits out a warning.

> > +}
> > +
> > +static void int_sqrt_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, int_sqrt(0UL), 0UL);
> > +       KUNIT_EXPECT_EQ(test, int_sqrt(1UL), 1UL);
> > +       KUNIT_EXPECT_EQ(test, int_sqrt(4UL), 2UL);
> > +       KUNIT_EXPECT_EQ(test, int_sqrt(5UL), 2UL);
> > +       KUNIT_EXPECT_EQ(test, int_sqrt(8UL), 2UL);
> > +       KUNIT_EXPECT_EQ(test, int_sqrt(1UL << 30), 1UL << 15);
> > +}
> > +
>
> _Maybe_ it's worth a comment here that round_up (and round_down) only
> support rounding to powers of two?
> (Either that, or also test roundup/rounddown to provide the contrast.)

Adding in those test cases for v6.
Andy had asked for those as well but I had forgotten them by the time
I sent out v5.

>
> > +static void round_up_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, round_up(0, 1), 0);
> > +       KUNIT_EXPECT_EQ(test, round_up(1, 2), 2);
> > +       KUNIT_EXPECT_EQ(test, round_up(3, 2), 4);
> > +       KUNIT_EXPECT_EQ(test, round_up((1 << 30) - 1, 2), 1 << 30);
> > +       KUNIT_EXPECT_EQ(test, round_up((1 << 30) - 1, 1 << 29), 1 << 30);
> > +}
> > +
> > +static void round_down_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, round_down(0, 1), 0);
> > +       KUNIT_EXPECT_EQ(test, round_down(1, 2), 0);
> > +       KUNIT_EXPECT_EQ(test, round_down(3, 2), 2);
> > +       KUNIT_EXPECT_EQ(test, round_down((1 << 30) - 1, 2), (1 << 30) - 2);
> > +       KUNIT_EXPECT_EQ(test, round_down((1 << 30) - 1, 1 << 29), 1 << 29);
> > +}
> > +
> > +static void div_round_up_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(0, 1), 0);
> > +       KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(20, 10), 2);
> > +       KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(21, 10), 3);
> > +       KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(21, 20), 2);
> > +       KUNIT_EXPECT_EQ(test, DIV_ROUND_UP(21, 99), 1);
> > +}
> > +
> > +static void div_round_closest_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(0, 1), 0);
> > +       KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(20, 10), 2);
> > +       KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(21, 10), 2);
> > +       KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(25, 10), 3);
> > +}
> > +
> > +/* Generic test case for unsigned long inputs. */
> > +struct test_case {
> > +       unsigned long a, b;
> > +       unsigned long result;
> > +};
> > +
> > +static struct test_case gcd_cases[] = {
> > +       {
> > +               .a = 0, .b = 0,
> > +               .result = 0,
> > +       },
> > +       {
> > +               .a = 0, .b = 1,
> > +               .result = 1,
> > +       },
> > +       {
> > +               .a = 2, .b = 2,
> > +               .result = 2,
> > +       },
> > +       {
> > +               .a = 2, .b = 4,
> > +               .result = 2,
> > +       },
> > +       {
> > +               .a = 3, .b = 5,
> > +               .result = 1,
> > +       },
> > +       {
> > +               .a = 3 * 9, .b = 3 * 5,
> > +               .result = 3,
> > +       },
> > +       {
> > +               .a = 3 * 5 * 7, .b = 3 * 5 * 11,
> > +               .result = 15,
> > +       },
> > +       {
> > +               .a = 1 << 21,
> > +               .b = (1 << 21) - 1,
> > +               .result = 1,
> > +       },
> > +};
> > +
> > +KUNIT_ARRAY_PARAM(gcd, gcd_cases, NULL);
> > +
> > +static void gcd_test(struct kunit *test)
> > +{
> > +       const char *message_fmt = "gcd(%lu, %lu)";
> > +       const struct test_case *test_param = test->param_value;
> > +
> > +       KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> > +                           gcd(test_param->a, test_param->b),
> > +                           message_fmt, test_param->a,
> > +                           test_param->b);
> > +
> > +       if (test_param->a == test_param->b)
> > +               return;
> > +
> > +       /* gcd(a,b) == gcd(b,a) */
> > +       KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> > +                           gcd(test_param->b, test_param->a),
> > +                           message_fmt, test_param->b,
> > +                           test_param->a);
> > +}
> > +
> > +static struct test_case lcm_cases[] = {
> > +       {
> > +               .a = 0, .b = 0,
> > +               .result = 0,
> > +       },
> > +       {
> > +               .a = 0, .b = 1,
> > +               .result = 0,
> > +       },
> > +       {
> > +               .a = 1, .b = 2,
> > +               .result = 2,
> > +       },
> > +       {
> > +               .a = 2, .b = 2,
> > +               .result = 2,
> > +       },
> > +       {
> > +               .a = 3 * 5, .b = 3 * 7,
> > +               .result = 3 * 5 * 7,
> > +       },
> > +};
> > +
> > +KUNIT_ARRAY_PARAM(lcm, lcm_cases, NULL);
> > +
> > +static void lcm_test(struct kunit *test)
> > +{
> > +       const char *message_fmt = "lcm(%lu, %lu)";
> > +       const struct test_case *test_param = test->param_value;
> > +
> > +       KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> > +                           lcm(test_param->a, test_param->b),
> > +                           message_fmt, test_param->a,
> > +                           test_param->b);
> > +
> > +       if (test_param->a == test_param->b)
> > +               return;
> > +
> > +       /* lcm(a,b) == lcm(b,a) */
> > +       KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> > +                           lcm(test_param->b, test_param->a),
> > +                           message_fmt, test_param->b,
> > +                           test_param->a);
> > +}
> > +
> > +struct u32_test_case {
> > +       u32 a, b;
> > +       u32 result;
> > +};
> > +
> > +static struct u32_test_case reciprocal_div_cases[] = {
> > +       {
> > +               .a = 0, .b = 1,
> > +               .result = 0,
> > +       },
> > +       {
> > +               .a = 42, .b = 20,
> > +               .result = 2,
> > +       },
> > +       {
> > +               .a = 42, .b = 9999,
> > +               .result = 0,
> > +       },
> > +       {
> > +               .a = (1 << 16), .b = (1 << 14),
> > +               .result = 1 << 2,
> > +       },
> > +};
> > +
> > +KUNIT_ARRAY_PARAM(reciprocal_div, reciprocal_div_cases, NULL);
>
> Is there a reason this test is using KUNIT_EXPECT_EQ_MSG() rather than
> a get_desc function in KUNIT_ARRAY_PARAM()? I can sort-of see how the
> former is a little simpler, so I'm not opposed to keeping it as-is,
> but it's nice to have KUnit aware of a nicer name for the parameter if
> all else is equal.
> (I think there's a stronger case for keeping the gcd/lcm tests as is
> because they actually have two checks per parameter, but even then,
> it's not absurdly silly. And it'd be possible to have both a get_desc
> function and use EXPECT_..._MSG() to get the best of both worlds,
> albeit with twice as much work.)

I can add in the get_desc for it if you want.

That's partly a relic of the previous versions of this patchset where
I reused the case arrays for the unary funcs as well.
But now the unary use case has disappeared and we only need to write
one get_desc.

But yeah, given it can test two calls of gcd, I've opted to keep it
using _MSG().
And I figured I'd keep the reciprocal_div test the same for
consistency (aka, I just copy-pasted it from gcd).




>
> > +
> > +static void reciprocal_div_test(struct kunit *test)
> > +{
> > +       const struct u32_test_case *test_param = test->param_value;
> > +       struct reciprocal_value rv = reciprocal_value(test_param->b);
> > +
> > +       KUNIT_EXPECT_EQ_MSG(test, test_param->result,
> > +                           reciprocal_divide(test_param->a, rv),
> > +                           "reciprocal_divide(%u, %u)",
> > +                           test_param->a, test_param->b);
> > +}
> > +
> > +static void reciprocal_scale_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, reciprocal_scale(0u, 100), 0u);
> > +       KUNIT_EXPECT_EQ(test, reciprocal_scale(1u, 100), 0u);
> > +       KUNIT_EXPECT_EQ(test, reciprocal_scale(1u << 4, 1 << 28), 1u);
> > +       KUNIT_EXPECT_EQ(test, reciprocal_scale(1u << 16, 1 << 28), 1u << 12);
> > +       KUNIT_EXPECT_EQ(test, reciprocal_scale(~0u, 1 << 28), (1u << 28) - 1);
> > +}
> > +
> > +static struct kunit_case math_test_cases[] = {
> > +       KUNIT_CASE(abs_test),
> > +       KUNIT_CASE(int_sqrt_test),
> > +       KUNIT_CASE(round_up_test),
> > +       KUNIT_CASE(round_down_test),
> > +       KUNIT_CASE(div_round_up_test),
> > +       KUNIT_CASE(div_round_closest_test),
> > +       KUNIT_CASE_PARAM(gcd_test, gcd_gen_params),
> > +       KUNIT_CASE_PARAM(lcm_test, lcm_gen_params),
> > +       KUNIT_CASE_PARAM(reciprocal_div_test, reciprocal_div_gen_params),
> > +       KUNIT_CASE(reciprocal_scale_test),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite math_test_suite = {
> > +       .name = "lib-math",
> > +       .test_cases = math_test_cases,
> > +};
> > +
> > +kunit_test_suites(&math_test_suite);
> > +
> > +MODULE_LICENSE("GPL v2");
> >
> > base-commit: 4fa56ad0d12e24df768c98bffe9039f915d1bc02
> > --
> > 2.31.1.295.g9ea45b61b8-goog
> >
