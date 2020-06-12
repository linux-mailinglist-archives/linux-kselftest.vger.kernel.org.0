Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B576B1F7D57
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 21:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgFLTGu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgFLTGu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 15:06:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FAFC03E96F
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 12:06:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so4758319pfb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4OYeJTnlUiwocjCJA6tVKh9CCWsHAiUf4fQydznS+M=;
        b=nWec12JE2XMpIUuptlUfxEH0W5aAbQSYFuloNX8T/3BurfS2Hf5uaIMkQz1dkGVZ6y
         AdY5nF30fm4qz+K/KL0Tm14ZfgZ6rrjNaTcQljsZNlaFt7n8RGZW/5aXc3Vk2Z7nJvrj
         KTOMn2vXTYixdPLt8SBoFPv+4MF2eapCRrak6+3F9I/q1I8P8eK/3voRdmxNl8PQdEWW
         XN4ENiCfysT7o8538cL4ab1jJH+XxXr2555/NCeLwlqkGR3wvzakIsm4nkEIAI80smwZ
         iMbIr7f1b+HgnKvF6XqUZ0AJj7YJ6o48eqpk4ADcuTEjx9PyAhBT27mx8l8/5Yo0s9DM
         XbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4OYeJTnlUiwocjCJA6tVKh9CCWsHAiUf4fQydznS+M=;
        b=P/8mabbnexpsZ6gF9SSWIo60A5HRPL5C/EGfKw8WFeYWS+ZCn1FJU5TZT6gHShqKp7
         LEt2a4O77xPSm2fBOYea4bN4Oy+6io9AT+MjPbomGp387TaGoyYUmTkiJOHKztEv3Ojs
         7/pmghpEig0JY+sq+ZqTRSQ85T9AS0h5Zc3hkUQBSyFqLjnesbQ7yJZ5WafnhrQm/HnJ
         LIFRpjIPij17tq/2LAIAJyc7tnAg7MFhhWLzZu5LZPyhfgFYvdixWYCu061TYEoQaOvk
         h3N/y8qe2egFWRqfBMHoCUoHuu4sZHkya1IaCB3kywEcG7YjfHp+j1DeWgT9d9TrxLg9
         I2Aw==
X-Gm-Message-State: AOAM530CdMBU4GIT2uZ8O3trcTTSe203/dWKx2q/uhvBoiRQbKiZfMFe
        fUM0CDpbg+yMu1R0ajdUrRx3XB4nWqLPfDr71Bp181Ja
X-Google-Smtp-Source: ABdhPJy6EAe9yNGESipjXqYRzW0MTCMEzqaSx/H9GvWXovjTvy5/Bg1y54Ky0UHY1DGizFQfk/NiMuXsk8kHLJREMHI=
X-Received: by 2002:a62:216:: with SMTP id 22mr10876505pfc.106.1591988807768;
 Fri, 12 Jun 2020 12:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200611215501.213058-1-vitor@massaru.org>
In-Reply-To: <20200611215501.213058-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 12 Jun 2020 12:06:36 -0700
Message-ID: <CAFd5g47sPgL6goY3+ee3i_kgZBHnr0jja03ad1npWYcY+DAcXw@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit_test_overflow: add KUnit test of
 check_*_overflow functions
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 11, 2020 at 2:55 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the convertion of the runtime tests of check_*_overflow fuctions,
> from `lib/test_overflow.c`to KUnit tests.
>
> The log similar to the one seen in dmesg running test_overflow can be
> seen in `test.log`.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  lib/Kconfig.debug         |  17 ++
>  lib/Makefile              |   1 +
>  lib/kunit_overflow_test.c | 590 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 608 insertions(+)
>  create mode 100644 lib/kunit_overflow_test.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1f4ab7a2bdee..72fcfe1f24a4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2075,6 +2075,23 @@ config SYSCTL_KUNIT_TEST
>
>           If unsure, say N.
>
> +config OVERFLOW_KUNIT_TEST
> +       tristate "KUnit test for overflow" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the overflow KUnit tests.
> +
> +         KUnit tests run during boot and output the results to the debug log
> +         in TAP format (http://testanything.org/). Only useful for kernel devs
> +         running KUnit test harness and are not for inclusion into a production
> +         build.
> +
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.

Since this is a migration of the overflow runtime test, I feel like
you should delete it here. I also think it would probably make this
easier to read for Kees and the other maintainers since it highlights
what you are changing in the test.

>  config LIST_KUNIT_TEST
>         tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index 685aee60de1d..a3290adc0019 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -309,3 +309,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>
>  # KUnit tests
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> +obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += kunit_overflow_test.o
> diff --git a/lib/kunit_overflow_test.c b/lib/kunit_overflow_test.c
> new file mode 100644
> index 000000000000..c3eb8f0d3d50
> --- /dev/null
> +++ b/lib/kunit_overflow_test.c
> @@ -0,0 +1,590 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  This code is the conversion of the overflow test in runtime to KUnit tests.
> + */
> +
> +/*
> + * Test cases for arithmetic overflow checks.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <kunit/test.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/overflow.h>
> +#include <linux/vmalloc.h>
> +
> +#define DEFINE_TEST_ARRAY(t)                   \
> +       static const struct test_ ## t {        \
> +               t a, b;                         \
> +               t sum, diff, prod;              \
> +               bool s_of, d_of, p_of;          \
> +       } t ## _tests[]
> +
> +DEFINE_TEST_ARRAY(u8) = {
> +       {0, 0, 0, 0, 0, false, false, false},
> +       {1, 1, 2, 0, 1, false, false, false},
> +       {0, 1, 1, U8_MAX, 0, false, true, false},
> +       {1, 0, 1, 1, 0, false, false, false},
> +       {0, U8_MAX, U8_MAX, 1, 0, false, true, false},
> +       {U8_MAX, 0, U8_MAX, U8_MAX, 0, false, false, false},
> +       {1, U8_MAX, 0, 2, U8_MAX, true, true, false},
> +       {U8_MAX, 1, 0, U8_MAX-1, U8_MAX, true, false, false},
> +       {U8_MAX, U8_MAX, U8_MAX-1, 0, 1, true, false, true},
> +
> +       {U8_MAX, U8_MAX-1, U8_MAX-2, 1, 2, true, false, true},
> +       {U8_MAX-1, U8_MAX, U8_MAX-2, U8_MAX, 2, true, true, true},
> +
> +       {1U << 3, 1U << 3, 1U << 4, 0, 1U << 6, false, false, false},
> +       {1U << 4, 1U << 4, 1U << 5, 0, 0, false, false, true},
> +       {1U << 4, 1U << 3, 3*(1U << 3), 1U << 3, 1U << 7, false, false, false},
> +       {1U << 7, 1U << 7, 0, 0, 0, true, false, true},
> +
> +       {48, 32, 80, 16, 0, false, false, true},
> +       {128, 128, 0, 0, 0, true, false, true},
> +       {123, 234, 101, 145, 110, true, true, true},
> +};
> +
> +DEFINE_TEST_ARRAY(u16) = {
> +       {0, 0, 0, 0, 0, false, false, false},
> +       {1, 1, 2, 0, 1, false, false, false},
> +       {0, 1, 1, U16_MAX, 0, false, true, false},
> +       {1, 0, 1, 1, 0, false, false, false},
> +       {0, U16_MAX, U16_MAX, 1, 0, false, true, false},
> +       {U16_MAX, 0, U16_MAX, U16_MAX, 0, false, false, false},
> +       {1, U16_MAX, 0, 2, U16_MAX, true, true, false},
> +       {U16_MAX, 1, 0, U16_MAX-1, U16_MAX, true, false, false},
> +       {U16_MAX, U16_MAX, U16_MAX-1, 0, 1, true, false, true},
> +
> +       {U16_MAX, U16_MAX-1, U16_MAX-2, 1, 2, true, false, true},
> +       {U16_MAX-1, U16_MAX, U16_MAX-2, U16_MAX, 2, true, true, true},
> +
> +       {1U << 7, 1U << 7, 1U << 8, 0, 1U << 14, false, false, false},
> +       {1U << 8, 1U << 8, 1U << 9, 0, 0, false, false, true},
> +       {1U << 8, 1U << 7, 3*(1U << 7), 1U << 7, 1U << 15, false, false, false},
> +       {1U << 15, 1U << 15, 0, 0, 0, true, false, true},
> +
> +       {123, 234, 357, 65425, 28782, false, true, false},
> +       {1234, 2345, 3579, 64425, 10146, false, true, true},
> +};
> +
> +DEFINE_TEST_ARRAY(u32) = {
> +       {0, 0, 0, 0, 0, false, false, false},
> +       {1, 1, 2, 0, 1, false, false, false},
> +       {0, 1, 1, U32_MAX, 0, false, true, false},
> +       {1, 0, 1, 1, 0, false, false, false},
> +       {0, U32_MAX, U32_MAX, 1, 0, false, true, false},
> +       {U32_MAX, 0, U32_MAX, U32_MAX, 0, false, false, false},
> +       {1, U32_MAX, 0, 2, U32_MAX, true, true, false},
> +       {U32_MAX, 1, 0, U32_MAX-1, U32_MAX, true, false, false},
> +       {U32_MAX, U32_MAX, U32_MAX-1, 0, 1, true, false, true},
> +
> +       {U32_MAX, U32_MAX-1, U32_MAX-2, 1, 2, true, false, true},
> +       {U32_MAX-1, U32_MAX, U32_MAX-2, U32_MAX, 2, true, true, true},
> +
> +       {1U << 15, 1U << 15, 1U << 16, 0, 1U << 30, false, false, false},
> +       {1U << 16, 1U << 16, 1U << 17, 0, 0, false, false, true},
> +       {1U << 16, 1U << 15, 3*(1U << 15), 1U << 15, 1U << 31, false, false, false},
> +       {1U << 31, 1U << 31, 0, 0, 0, true, false, true},
> +
> +       {-2U, 1U, -1U, -3U, -2U, false, false, false},
> +       {-4U, 5U, 1U, -9U, -20U, true, false, true},
> +};
> +
> +DEFINE_TEST_ARRAY(u64) = {
> +       {0, 0, 0, 0, 0, false, false, false},
> +       {1, 1, 2, 0, 1, false, false, false},
> +       {0, 1, 1, U64_MAX, 0, false, true, false},
> +       {1, 0, 1, 1, 0, false, false, false},
> +       {0, U64_MAX, U64_MAX, 1, 0, false, true, false},
> +       {U64_MAX, 0, U64_MAX, U64_MAX, 0, false, false, false},
> +       {1, U64_MAX, 0, 2, U64_MAX, true, true, false},
> +       {U64_MAX, 1, 0, U64_MAX-1, U64_MAX, true, false, false},
> +       {U64_MAX, U64_MAX, U64_MAX-1, 0, 1, true, false, true},
> +
> +       {U64_MAX, U64_MAX-1, U64_MAX-2, 1, 2, true, false, true},
> +       {U64_MAX-1, U64_MAX, U64_MAX-2, U64_MAX, 2, true, true, true},
> +
> +       {1ULL << 31, 1ULL << 31, 1ULL << 32, 0, 1ULL << 62, false, false, false},
> +       {1ULL << 32, 1ULL << 32, 1ULL << 33, 0, 0, false, false, true},
> +       {1ULL << 32, 1ULL << 31, 3*(1ULL << 31), 1ULL << 31, 1ULL << 63, false, false, false},
> +       {1ULL << 63, 1ULL << 63, 0, 0, 0, true, false, true},
> +       {1000000000ULL /* 10^9 */, 10000000000ULL /* 10^10 */,
> +        11000000000ULL, 18446744064709551616ULL, 10000000000000000000ULL,
> +        false, true, false},
> +       {-15ULL, 10ULL, -5ULL, -25ULL, -150ULL, false, false, true},
> +};
> +
> +DEFINE_TEST_ARRAY(s8) = {
> +       {0, 0, 0, 0, 0, false, false, false},
> +
> +       {0, S8_MAX, S8_MAX, -S8_MAX, 0, false, false, false},
> +       {S8_MAX, 0, S8_MAX, S8_MAX, 0, false, false, false},
> +       {0, S8_MIN, S8_MIN, S8_MIN, 0, false, true, false},
> +       {S8_MIN, 0, S8_MIN, S8_MIN, 0, false, false, false},
> +
> +       {-1, S8_MIN, S8_MAX, S8_MAX, S8_MIN, true, false, true},
> +       {S8_MIN, -1, S8_MAX, -S8_MAX, S8_MIN, true, false, true},
> +       {-1, S8_MAX, S8_MAX-1, S8_MIN, -S8_MAX, false, false, false},
> +       {S8_MAX, -1, S8_MAX-1, S8_MIN, -S8_MAX, false, true, false},
> +       {-1, -S8_MAX, S8_MIN, S8_MAX-1, S8_MAX, false, false, false},
> +       {-S8_MAX, -1, S8_MIN, S8_MIN+2, S8_MAX, false, false, false},
> +
> +       {1, S8_MIN, -S8_MAX, -S8_MAX, S8_MIN, false, true, false},
> +       {S8_MIN, 1, -S8_MAX, S8_MAX, S8_MIN, false, true, false},
> +       {1, S8_MAX, S8_MIN, S8_MIN+2, S8_MAX, true, false, false},
> +       {S8_MAX, 1, S8_MIN, S8_MAX-1, S8_MAX, true, false, false},
> +
> +       {S8_MIN, S8_MIN, 0, 0, 0, true, false, true},
> +       {S8_MAX, S8_MAX, -2, 0, 1, true, false, true},
> +
> +       {-4, -32, -36, 28, -128, false, false, true},
> +       {-4, 32, 28, -36, -128, false, false, false},
> +};
> +
> +DEFINE_TEST_ARRAY(s16) = {
> +       {0, 0, 0, 0, 0, false, false, false},
> +
> +       {0, S16_MAX, S16_MAX, -S16_MAX, 0, false, false, false},
> +       {S16_MAX, 0, S16_MAX, S16_MAX, 0, false, false, false},
> +       {0, S16_MIN, S16_MIN, S16_MIN, 0, false, true, false},
> +       {S16_MIN, 0, S16_MIN, S16_MIN, 0, false, false, false},
> +
> +       {-1, S16_MIN, S16_MAX, S16_MAX, S16_MIN, true, false, true},
> +       {S16_MIN, -1, S16_MAX, -S16_MAX, S16_MIN, true, false, true},
> +       {-1, S16_MAX, S16_MAX-1, S16_MIN, -S16_MAX, false, false, false},
> +       {S16_MAX, -1, S16_MAX-1, S16_MIN, -S16_MAX, false, true, false},
> +       {-1, -S16_MAX, S16_MIN, S16_MAX-1, S16_MAX, false, false, false},
> +       {-S16_MAX, -1, S16_MIN, S16_MIN+2, S16_MAX, false, false, false},
> +
> +       {1, S16_MIN, -S16_MAX, -S16_MAX, S16_MIN, false, true, false},
> +       {S16_MIN, 1, -S16_MAX, S16_MAX, S16_MIN, false, true, false},
> +       {1, S16_MAX, S16_MIN, S16_MIN+2, S16_MAX, true, false, false},
> +       {S16_MAX, 1, S16_MIN, S16_MAX-1, S16_MAX, true, false, false},
> +
> +       {S16_MIN, S16_MIN, 0, 0, 0, true, false, true},
> +       {S16_MAX, S16_MAX, -2, 0, 1, true, false, true},
> +};
> +
> +DEFINE_TEST_ARRAY(s32) = {
> +       {0, 0, 0, 0, 0, false, false, false},
> +
> +       {0, S32_MAX, S32_MAX, -S32_MAX, 0, false, false, false},
> +       {S32_MAX, 0, S32_MAX, S32_MAX, 0, false, false, false},
> +       {0, S32_MIN, S32_MIN, S32_MIN, 0, false, true, false},
> +       {S32_MIN, 0, S32_MIN, S32_MIN, 0, false, false, false},
> +
> +       {-1, S32_MIN, S32_MAX, S32_MAX, S32_MIN, true, false, true},
> +       {S32_MIN, -1, S32_MAX, -S32_MAX, S32_MIN, true, false, true},
> +       {-1, S32_MAX, S32_MAX-1, S32_MIN, -S32_MAX, false, false, false},
> +       {S32_MAX, -1, S32_MAX-1, S32_MIN, -S32_MAX, false, true, false},
> +       {-1, -S32_MAX, S32_MIN, S32_MAX-1, S32_MAX, false, false, false},
> +       {-S32_MAX, -1, S32_MIN, S32_MIN+2, S32_MAX, false, false, false},
> +
> +       {1, S32_MIN, -S32_MAX, -S32_MAX, S32_MIN, false, true, false},
> +       {S32_MIN, 1, -S32_MAX, S32_MAX, S32_MIN, false, true, false},
> +       {1, S32_MAX, S32_MIN, S32_MIN+2, S32_MAX, true, false, false},
> +       {S32_MAX, 1, S32_MIN, S32_MAX-1, S32_MAX, true, false, false},
> +
> +       {S32_MIN, S32_MIN, 0, 0, 0, true, false, true},
> +       {S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
> +};
> +
> +DEFINE_TEST_ARRAY(s64) = {
> +       {0, 0, 0, 0, 0, false, false, false},
> +
> +       {0, S64_MAX, S64_MAX, -S64_MAX, 0, false, false, false},
> +       {S64_MAX, 0, S64_MAX, S64_MAX, 0, false, false, false},
> +       {0, S64_MIN, S64_MIN, S64_MIN, 0, false, true, false},
> +       {S64_MIN, 0, S64_MIN, S64_MIN, 0, false, false, false},
> +
> +       {-1, S64_MIN, S64_MAX, S64_MAX, S64_MIN, true, false, true},
> +       {S64_MIN, -1, S64_MAX, -S64_MAX, S64_MIN, true, false, true},
> +       {-1, S64_MAX, S64_MAX-1, S64_MIN, -S64_MAX, false, false, false},
> +       {S64_MAX, -1, S64_MAX-1, S64_MIN, -S64_MAX, false, true, false},
> +       {-1, -S64_MAX, S64_MIN, S64_MAX-1, S64_MAX, false, false, false},
> +       {-S64_MAX, -1, S64_MIN, S64_MIN+2, S64_MAX, false, false, false},
> +
> +       {1, S64_MIN, -S64_MAX, -S64_MAX, S64_MIN, false, true, false},
> +       {S64_MIN, 1, -S64_MAX, S64_MAX, S64_MIN, false, true, false},
> +       {1, S64_MAX, S64_MIN, S64_MIN+2, S64_MAX, true, false, false},
> +       {S64_MAX, 1, S64_MIN, S64_MAX-1, S64_MAX, true, false, false},
> +
> +       {S64_MIN, S64_MIN, 0, 0, 0, true, false, true},
> +       {S64_MAX, S64_MAX, -2, 0, 1, true, false, true},
> +
> +       {-1, -1, -2, 0, 1, false, false, false},
> +       {-1, -128, -129, 127, 128, false, false, false},
> +       {-128, -1, -129, -127, 128, false, false, false},
> +       {0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
> +};
> +
> +#define check_one_op(test, t, fmt, op, sym, a, b, r, of) do {          \
> +       t _r;                                                           \
> +       bool _of;                                                       \
> +                                                                       \
> +       _of = check_ ## op ## _overflow(a, b, &_r);                     \
> +       if (_of != of) {                                                \
> +               KUNIT_FAIL(test, "Expected "fmt" "sym" "fmt             \
> +                       " to%s overflow (type %s)\n",                   \
> +                       a, b, of ? "" : " not", #t);                    \
> +       }                                                               \
> +       if (_r != r) {                                                  \
> +               KUNIT_FAIL(test, "Expected "fmt" "sym" "fmt" == "       \
> +                       fmt", got "fmt" (type %s)\n",                   \
> +                       a, b, r, _r, #t);                               \
> +       }                                                               \
> +} while (0)
> +
> +#define DEFINE_TEST_FUNC(test, t, fmt)                                         \
> +static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p)      \
> +{                                                                              \
> +       check_one_op(test, t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);      \
> +       check_one_op(test, t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);      \
> +       check_one_op(test, t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);     \
> +       check_one_op(test, t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);     \
> +       check_one_op(test, t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);     \
> +}                                                                              \
> +                                                                               \
> +static void  test_ ## t ## _overflow(struct kunit *test)                       \
> +{                                                                              \
> +       unsigned i;                                                             \
> +                                                                               \
> +       kunit_warn(test, "%-3s: %zu arithmetic tests\n", #t,                    \
> +               ARRAY_SIZE(t ## _tests));                                       \
> +       for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)                           \
> +               do_test_ ## t(test, &t ## _tests[i]);                           \
> +}
> +
> +DEFINE_TEST_FUNC(test, u8, "%d");
> +DEFINE_TEST_FUNC(test, s8, "%d");
> +DEFINE_TEST_FUNC(test, u16, "%d");
> +DEFINE_TEST_FUNC(test, s16, "%d");
> +DEFINE_TEST_FUNC(test, u32, "%u");
> +DEFINE_TEST_FUNC(test, s32, "%d");
> +#if BITS_PER_LONG == 64
> +DEFINE_TEST_FUNC(test, u64, "%llu");
> +DEFINE_TEST_FUNC(test, s64, "%lld");
> +#endif
> +
> +static void  overflow_calculation_test(struct kunit *test)
> +{
> +
> +       test_u8_overflow(test);
> +       test_s8_overflow(test);
> +       test_s8_overflow(test);
> +       test_u16_overflow(test);
> +       test_s16_overflow(test);
> +       test_u32_overflow(test);
> +       test_s32_overflow(test);
> +#if BITS_PER_LONG == 64
> +       test_u64_overflow(test);
> +       test_s64_overflow(test);
> +#endif
> +}
> +
> +static void overflow_shift_test(struct kunit *test)
> +{
> +/* Args are: value, shift, type, expected result, overflow expected */
> +#define TEST_ONE_SHIFT(a, s, t, expect, of) ({                                 \
> +       int __failed = 0;                                                       \
> +       typeof(a) __a = (a);                                                    \
> +       typeof(s) __s = (s);                                                    \
> +       t __e = (expect);                                                       \
> +       t __d;                                                                  \
> +       bool __of = check_shl_overflow(__a, __s, &__d);                         \
> +       if (__of != of) {                                                       \
> +               KUNIT_FAIL(test, "Expected (%s)(%s << %s) to%s overflow\n",     \

I mentioned this offline: I am of two minds on this. Part of me would
like to make it more KUnit-y, but part of me thinks that it is best to
not change the test more than necessary. I am fine either way, I just
wanted to draw attention to it for other reviewers who may care.

> +                       #t, #a, #s, of ? "" : " not");                          \
> +               __failed = 1;                                                   \
> +       } else if (!__of && __d != __e) {                                       \
> +               KUNIT_FAIL(test, "Expected (%s)(%s << %s) == %s\n",             \
> +                       #t, #a, #s, #expect);                                   \
> +               if ((t)-1 < 0)                                                  \
> +                       KUNIT_FAIL(test, "got %lld\n", (s64)__d);               \
> +               else                                                            \
> +                       KUNIT_FAIL(test, "got %llu\n", (u64)__d);               \
> +               __failed = 1;                                                   \
> +       }                                                                       \
> +       if (!__failed)                                                          \
> +               kunit_info(test, "ok: (%s)(%s << %s) == %s\n", #t, #a, #s,      \
> +                       of ? "overflow" : #expect);                             \
> +       __failed;                                                               \
> +})
> +
> +       /* Sane shifts. */
> +       TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
> +       TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
> +       TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
> +       TEST_ONE_SHIFT(0xF, 4, u8, 0xF << 4, false);
> +       TEST_ONE_SHIFT(1, 0, u16, 1 << 0, false);
> +       TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
> +       TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
> +       TEST_ONE_SHIFT(0xFF, 8, u16, 0xFF << 8, false);
> +       TEST_ONE_SHIFT(1, 0, int, 1 << 0, false);
> +       TEST_ONE_SHIFT(1, 16, int, 1 << 16, false);
> +       TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
> +       TEST_ONE_SHIFT(1, 0, s32, 1 << 0, false);
> +       TEST_ONE_SHIFT(1, 16, s32, 1 << 16, false);
> +       TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
> +       TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
> +       TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
> +       TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
> +       TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
> +       TEST_ONE_SHIFT(1, 0, u32, 1U << 0, false);
> +       TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
> +       TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
> +       TEST_ONE_SHIFT(0xFFFFU, 16, u32, 0xFFFFU << 16, false);
> +       TEST_ONE_SHIFT(1, 0, u64, 1ULL << 0, false);
> +       TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
> +       TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
> +       TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64,
> +                             0xFFFFFFFFULL << 32, false);
> +
> +       /* Sane shift: start and end with 0, without a too-wide shift. */
> +       TEST_ONE_SHIFT(0, 7, u8, 0, false);
> +       TEST_ONE_SHIFT(0, 15, u16, 0, false);
> +       TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
> +       TEST_ONE_SHIFT(0, 31, u32, 0, false);
> +       TEST_ONE_SHIFT(0, 63, u64, 0, false);
> +
> +       /* Sane shift: start and end with 0, without reaching signed bit. */
> +       TEST_ONE_SHIFT(0, 6, s8, 0, false);
> +       TEST_ONE_SHIFT(0, 14, s16, 0, false);
> +       TEST_ONE_SHIFT(0, 30, int, 0, false);
> +       TEST_ONE_SHIFT(0, 30, s32, 0, false);
> +       TEST_ONE_SHIFT(0, 62, s64, 0, false);
> +
> +       /* Overflow: shifted the bit off the end. */
> +       TEST_ONE_SHIFT(1, 8, u8, 0, true);
> +       TEST_ONE_SHIFT(1, 16, u16, 0, true);
> +       TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(1, 32, u32, 0, true);
> +       TEST_ONE_SHIFT(1, 64, u64, 0, true);
> +
> +       /* Overflow: shifted into the signed bit. */
> +       TEST_ONE_SHIFT(1, 7, s8, 0, true);
> +       TEST_ONE_SHIFT(1, 15, s16, 0, true);
> +       TEST_ONE_SHIFT(1, 31, int, 0, true);
> +       TEST_ONE_SHIFT(1, 31, s32, 0, true);
> +       TEST_ONE_SHIFT(1, 63, s64, 0, true);
> +
> +       /* Overflow: high bit falls off unsigned types. */
> +       /* 10010110 */
> +       TEST_ONE_SHIFT(150, 1, u8, 0, true);
> +       /* 1000100010010110 */
> +       TEST_ONE_SHIFT(34966, 1, u16, 0, true);
> +       /* 10000100000010001000100010010110 */
> +       TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
> +       TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
> +       /* 1000001000010000010000000100000010000100000010001000100010010110 */
> +       TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
> +
> +       /* Overflow: bit shifted into signed bit on signed types. */
> +       /* 01001011 */
> +       TEST_ONE_SHIFT(75, 1, s8, 0, true);
> +       /* 0100010001001011 */
> +       TEST_ONE_SHIFT(17483, 1, s16, 0, true);
> +       /* 01000010000001000100010001001011 */
> +       TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
> +       /* 0100000100001000001000000010000001000010000001000100010001001011 */
> +       TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
> +
> +       /* Overflow: bit shifted past signed bit on signed types. */
> +       /* 01001011 */
> +       TEST_ONE_SHIFT(75, 2, s8, 0, true);
> +       /* 0100010001001011 */
> +       TEST_ONE_SHIFT(17483, 2, s16, 0, true);
> +       /* 01000010000001000100010001001011 */
> +       TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
> +       /* 0100000100001000001000000010000001000010000001000100010001001011 */
> +       TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
> +
> +       /* Overflow: values larger than destination type. */
> +       TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
> +       TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
> +       TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
> +       TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
> +       TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
> +
> +       /* Nonsense: negative initial value. */
> +       TEST_ONE_SHIFT(-1, 0, s8, 0, true);
> +       TEST_ONE_SHIFT(-1, 0, u8, 0, true);
> +       TEST_ONE_SHIFT(-5, 0, s16, 0, true);
> +       TEST_ONE_SHIFT(-5, 0, u16, 0, true);
> +       TEST_ONE_SHIFT(-10, 0, int, 0, true);
> +       TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(-100, 0, s32, 0, true);
> +       TEST_ONE_SHIFT(-100, 0, u32, 0, true);
> +       TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
> +       TEST_ONE_SHIFT(-10000, 0, u64, 0, true);
> +
> +       /* Nonsense: negative shift values. */
> +       TEST_ONE_SHIFT(0, -5, s8, 0, true);
> +       TEST_ONE_SHIFT(0, -5, u8, 0, true);
> +       TEST_ONE_SHIFT(0, -10, s16, 0, true);
> +       TEST_ONE_SHIFT(0, -10, u16, 0, true);
> +       TEST_ONE_SHIFT(0, -15, int, 0, true);
> +       TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(0, -20, s32, 0, true);
> +       TEST_ONE_SHIFT(0, -20, u32, 0, true);
> +       TEST_ONE_SHIFT(0, -30, s64, 0, true);
> +       TEST_ONE_SHIFT(0, -30, u64, 0, true);
> +
> +       /* Overflow: shifted at or beyond entire type's bit width. */
> +       TEST_ONE_SHIFT(0, 8, u8, 0, true);
> +       TEST_ONE_SHIFT(0, 9, u8, 0, true);
> +       TEST_ONE_SHIFT(0, 8, s8, 0, true);
> +       TEST_ONE_SHIFT(0, 9, s8, 0, true);
> +       TEST_ONE_SHIFT(0, 16, u16, 0, true);
> +       TEST_ONE_SHIFT(0, 17, u16, 0, true);
> +       TEST_ONE_SHIFT(0, 16, s16, 0, true);
> +       TEST_ONE_SHIFT(0, 17, s16, 0, true);
> +       TEST_ONE_SHIFT(0, 32, u32, 0, true);
> +       TEST_ONE_SHIFT(0, 33, u32, 0, true);
> +       TEST_ONE_SHIFT(0, 32, int, 0, true);
> +       TEST_ONE_SHIFT(0, 33, int, 0, true);
> +       TEST_ONE_SHIFT(0, 32, s32, 0, true);
> +       TEST_ONE_SHIFT(0, 33, s32, 0, true);
> +       TEST_ONE_SHIFT(0, 64, u64, 0, true);
> +       TEST_ONE_SHIFT(0, 65, u64, 0, true);
> +       TEST_ONE_SHIFT(0, 64, s64, 0, true);
> +       TEST_ONE_SHIFT(0, 65, s64, 0, true);
> +
> +       /*
> +        * Corner case: for unsigned types, we fail when we've shifted
> +        * through the entire width of bits. For signed types, we might
> +        * want to match this behavior, but that would mean noticing if
> +        * we shift through all but the signed bit, and this is not
> +        * currently detected (but we'll notice an overflow into the
> +        * signed bit). So, for now, we will test this condition but
> +        * mark it as not expected to overflow.
> +        */
> +       TEST_ONE_SHIFT(0, 7, s8, 0, false);
> +       TEST_ONE_SHIFT(0, 15, s16, 0, false);
> +       TEST_ONE_SHIFT(0, 31, int, 0, false);
> +       TEST_ONE_SHIFT(0, 31, s32, 0, false);
> +       TEST_ONE_SHIFT(0, 63, s64, 0, false);
> +}
> +
> +/*
> + * Deal with the various forms of allocator arguments. See comments above
> + * the DEFINE_TEST_ALLOC() instances for mapping of the "bits".
> + */
> +#define alloc_GFP               (GFP_KERNEL | __GFP_NOWARN)
> +#define alloc010(alloc, arg, sz) alloc(sz, alloc_GFP)
> +#define alloc011(alloc, arg, sz) alloc(sz, alloc_GFP, NUMA_NO_NODE)
> +#define alloc000(alloc, arg, sz) alloc(sz)
> +#define alloc001(alloc, arg, sz) alloc(sz, NUMA_NO_NODE)
> +#define alloc110(alloc, arg, sz) alloc(arg, sz, alloc_GFP)
> +#define free0(free, arg, ptr)   free(ptr)
> +#define free1(free, arg, ptr)   free(arg, ptr)
> +
> +/* Wrap around to 16K */
> +#define TEST_SIZE              (5 * 4096)
> +
> +#define DEFINE_TEST_ALLOC(test, func, free_func, want_arg, want_gfp, want_node)        \
> +static void test_ ## func (struct kunit *test, void *arg)                      \
> +{                                                                              \
> +       volatile size_t a = TEST_SIZE;                                          \
> +       volatile size_t b = (SIZE_MAX / TEST_SIZE) + 1;                         \
> +       void *ptr;                                                              \
> +                                                                               \
> +       /* Tiny allocation test. */                                             \
> +       ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg, 1);        \
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr);                                \
> +       if (!ptr) {                                                             \
> +               kunit_err(test, #func " failed regular allocation?!\n");        \
> +       }                                                                       \
> +       free ## want_arg (free_func, arg, ptr);                                 \
> +                                                                               \
> +       /* Wrapped allocation test. */                                          \
> +       ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg, a * b);    \
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr);                                \
> +       if (!ptr) {                                                             \
> +               kunit_err(test, #func " unexpectedly failed bad wrapping?!\n"); \
> +       }                                                                       \
> +       free ## want_arg (free_func, arg, ptr);                                 \
> +                                                                               \
> +       /* Saturated allocation test. */                                        \
> +       ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,            \
> +                                                  array_size(a, b));           \
> +       KUNIT_ASSERT_TRUE(test, IS_ERR_OR_NULL(ptr));                           \
> +       if (ptr) {                                                              \
> +               kunit_err(test, #func " missed saturation!\n");                 \
> +               free ## want_arg (free_func, arg, ptr);                         \
> +       }                                                                       \
> +       kunit_info(test, #func " detected saturation\n");                       \
> +}
> +
> +/*
> + * Allocator uses a trailing node argument -------------------+  (e.g. kmalloc_node())
> + * Allocator uses the gfp_t argument ----------------------+  |  (e.g. kmalloc())
> + * Allocator uses a special leading argument -----------+  |  |  (e.g. devm_kmalloc())
> + *                                                     |  |  |
> + */
> +DEFINE_TEST_ALLOC(test, kmalloc,       kfree,          0, 1, 0);
> +DEFINE_TEST_ALLOC(test, kmalloc_node,  kfree,          0, 1, 1);
> +DEFINE_TEST_ALLOC(test, kzalloc,       kfree,          0, 1, 0);
> +DEFINE_TEST_ALLOC(test, kzalloc_node,  kfree,          0, 1, 1);
> +DEFINE_TEST_ALLOC(test, vmalloc,       vfree,          0, 0, 0);
> +DEFINE_TEST_ALLOC(test, vmalloc_node,  vfree,          0, 0, 1);
> +DEFINE_TEST_ALLOC(test, vzalloc,       vfree,          0, 0, 0);
> +DEFINE_TEST_ALLOC(test, vzalloc_node,  vfree,          0, 0, 1);
> +DEFINE_TEST_ALLOC(test, kvmalloc,      kvfree,         0, 1, 0);
> +DEFINE_TEST_ALLOC(test, kvmalloc_node, kvfree,         0, 1, 1);
> +DEFINE_TEST_ALLOC(test, kvzalloc,      kvfree,         0, 1, 0);
> +DEFINE_TEST_ALLOC(test, kvzalloc_node, kvfree,         0, 1, 1);
> +DEFINE_TEST_ALLOC(test, devm_kmalloc,  devm_kfree,     1, 1, 0);
> +DEFINE_TEST_ALLOC(test, devm_kzalloc,  devm_kfree,     1, 1, 0);
> +
> +static void overflow_allocation_test(struct kunit *test)
> +{
> +       const char device_name[] = "overflow-test";
> +       struct device *dev;
> +
> +       /* Create dummy device for devm_kmalloc()-family tests. */
> +       dev = root_device_register(device_name);
> +       if (IS_ERR(dev))
> +               kunit_warn(test, "Cannot register test device\n");
> +
> +       test_kmalloc(test, NULL);
> +       test_kmalloc_node(test, NULL);
> +       test_kzalloc(test, NULL);
> +       test_kzalloc_node(test, NULL);
> +       test_kvmalloc(test, NULL);
> +       test_kvmalloc_node(test, NULL);
> +       test_kvzalloc(test, NULL);
> +       test_kvzalloc_node(test, NULL);
> +       test_vmalloc(test, NULL);
> +       test_vmalloc_node(test, NULL);
> +       test_vzalloc(test, NULL);
> +       test_vzalloc_node(test, NULL);
> +       test_devm_kmalloc(test, dev);
> +       test_devm_kzalloc(test, dev);
> +
> +       device_unregister(dev);
> +}
> +
> +static struct kunit_case overflow_test_cases[] = {
> +       KUNIT_CASE(overflow_calculation_test),
> +       KUNIT_CASE(overflow_shift_test),
> +       KUNIT_CASE(overflow_allocation_test),
> +       {}
> +};
> +
> +static struct kunit_suite overflow_test_suite = {
> +       .name = "overflow",
> +       .test_cases = overflow_test_cases,
> +};
> +
> +kunit_test_suites(&overflow_test_suite);
> +
> +MODULE_LICENSE("GPL v2");
> --
> 2.26.2
>
