Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E624B943A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 23:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiBPW5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Feb 2022 17:57:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiBPW5k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Feb 2022 17:57:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394031BAC4F
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Feb 2022 14:57:25 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hw13so2593174ejc.9
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Feb 2022 14:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mqe0+G6V9CfdIdvkgSzyYRhAkhfJCdArCtl4cStmXYw=;
        b=Mx0zyCTQHb8b40DJsEN5lfCGG5aX/JxpgnXCQaly5oZBTwEshxRJ3WtGq/5x4qRQxm
         Pm34+0qA7QAtQqPXg1o0rFWpmlxiE3CSLU3d5TNeNnQQc6FOIO/bQBxRMfcNPSvUsnRU
         +Fmin0xO5wtAVNqyUVFivgOIGwbVxTJBeqcPT6iZTQwsI1r2BopcbvkaDfRWWM2ZDc0T
         yFf5k2bDUkSDFuod2BUuCwFvl2CIegE6CdMktUCGh9gXS+BkvMSrW7fZ8iq/1zwfO6tB
         Xh/IWd3hc1jENu+uaJR9hkfgQ5bWMmtNOjofbhHJNPbUwXIMBOvVCeO+6yIZ1Vnr7ujC
         euIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mqe0+G6V9CfdIdvkgSzyYRhAkhfJCdArCtl4cStmXYw=;
        b=xNlgi6/COvlgBbNHi/40m9Qzmo23OXpRxa2XL7yAcqaihOr3UPnTHQsMN21AQLxSsM
         fDNGVP0zwSm45siV4LslbSRclu+mFV6euxpaqZuPqeElJeBp6vdIq9QdD1O4CVMaC1tI
         KWtXrNM2xPi/QehVcxETrBbAcPRzXW3lZlH6nsvenvfM6BzFKdy5DUVhGq2wnNX2cASZ
         IAvnyvHeB+YOO/jrPb37+gMT7Z2msGd0yUinz4R6ioeWw6VYeiqTlok+kF5Br27PIFh8
         m8UJFvsIvuoXoNrJ+yMgepsnrK0MckqNFa1dQ9FgC0S5UkhZHAQdIBCEI+avrbN7uGKg
         BsBA==
X-Gm-Message-State: AOAM533nxVQq44aZymF4kp6RJP4QetUXi3dxYtL9oKO2lxxo/zNh2HyM
        Vooqy76dZf3qmORqWyOyac4IiPJ76v8wSpHX/uM7sg==
X-Google-Smtp-Source: ABdhPJxAVfEvjiN8ca3NdECukV4qwRBC9aW+a1f/kFGrmImX7x3jl6N2q1lGR6nJ8xJMqXQbRdBdziIqChpeo1RhcVU=
X-Received: by 2002:a17:906:c282:b0:6ce:369d:3d5 with SMTP id
 r2-20020a170906c28200b006ce369d03d5mr177440ejz.425.1645052243504; Wed, 16 Feb
 2022 14:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20220216224153.2242451-1-keescook@chromium.org>
In-Reply-To: <20220216224153.2242451-1-keescook@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 16 Feb 2022 14:57:12 -0800
Message-ID: <CAGS_qxoOYjOtX6BQm-ozcarnazyED2vocd4iV+VdDVnMWpjWjg@mail.gmail.com>
Subject: Re: [PATCH] lib: overflow: Convert to Kunit
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 16, 2022 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
>
> Convert overflow unit tests to KUnit, for better integration into the
> kernel self test framework. Includes a rename of test_overflow.c to
> overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
>
> $ ./tools/testing/kunit/kunit.py config
> ...
> $ ./tools/testing/kunit/kunit.py run overflow

JFYI, you can run this as a one-liner via

$ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
CONFIG_KUNIT=y
CONFIG_TEST_OVERFLOW=y
EOF

The above is taken from my own duplicate version of this patch
[1] https://lore.kernel.org/linux-kselftest/20210503211536.1384578-1-dlatypov@google.com/

> ...
> [14:33:51] Starting KUnit Kernel (1/1)...
> [14:33:51] ============================================================
> [14:33:51] ================== overflow (11 subtests) ==================
> [14:33:51] [PASSED] u8_overflow_test
> [14:33:51] [PASSED] s8_overflow_test
> [14:33:51] [PASSED] u16_overflow_test
> [14:33:51] [PASSED] s16_overflow_test
> [14:33:51] [PASSED] u32_overflow_test
> [14:33:51] [PASSED] s32_overflow_test
> [14:33:51] [PASSED] u64_overflow_test
> [14:33:51] [PASSED] s64_overflow_test
> [14:33:51] [PASSED] overflow_shift_test
> [14:33:51] [PASSED] overflow_allocation_test
> [14:33:51] [PASSED] overflow_size_helpers_test
> [14:33:51] ==================== [PASSED] overflow =====================
> [14:33:51] ============================================================
> [14:33:51] Testing complete. Passed: 11, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> [14:33:51] Elapsed time: 12.525s total, 0.001s configuring, 12.402s building, 0.101s running
>
> Cc: David Gow <davidgow@google.com>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: https://lore.kernel.org/lkml/20200720224418.200495-1-vitor@massaru.org/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks good to me, some minor nits/suggestions wrt KUnit usage.
Nice to see this test converted over!

> ---
> Assuming no one objects, I'll carry this in my for-next/overflow tree. :)
> ---
>  lib/Kconfig.debug                         |  16 +-
>  lib/Makefile                              |   2 +-
>  lib/{test_overflow.c => overflow_kunit.c} | 562 ++++++++++------------
>  3 files changed, 270 insertions(+), 310 deletions(-)
>  rename lib/{test_overflow.c => overflow_kunit.c} (54%)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 14b89aa37c5c..14d90d03bc8d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2214,9 +2214,6 @@ config TEST_UUID
>  config TEST_XARRAY
>         tristate "Test the XArray code at runtime"
>
> -config TEST_OVERFLOW
> -       tristate "Test check_*_overflow() functions at runtime"
> -
>  config TEST_RHASHTABLE
>         tristate "Perform selftest on resizable hash table"
>         help
> @@ -2501,6 +2498,19 @@ config MEMCPY_KUNIT_TEST
>
>           If unsure, say N.
>
> +config OVERFLOW_KUNIT_TEST
> +       tristate "Test check_*_overflow() functions at runtime" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Builds unit tests for the check_*_overflow(), size_*(), allocation, and
> +         related functions.
> +
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index 300f569c626b..fdfcbfaff32f 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -77,7 +77,6 @@ obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
>  obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
>  obj-$(CONFIG_TEST_LKM) += test_module.o
>  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
> -obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
>  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
>  obj-$(CONFIG_TEST_SORT) += test_sort.o
>  obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
> @@ -363,6 +362,7 @@ obj-$(CONFIG_BITS_TEST) += test_bits.o
>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
>  obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
>  obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
> +obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>
> diff --git a/lib/test_overflow.c b/lib/overflow_kunit.c
> similarity index 54%
> rename from lib/test_overflow.c
> rename to lib/overflow_kunit.c
> index f6530fce799d..4cc27b9926a1 100644
> --- a/lib/test_overflow.c
> +++ b/lib/overflow_kunit.c
> @@ -1,9 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
> - * Test cases for arithmetic overflow checks.
> + * Test cases for arithmetic overflow checks. See:
> + * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
> + *     ./tools/testing/kunit/kunit.py config
> + *     ./tools/testing/kunit/kunit.py run overflow [--raw_output]
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

We can drop the pr_fmt now, I think

>
> +#include <kunit/test.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -19,7 +23,7 @@
>                 t a, b;                         \
>                 t sum, diff, prod;              \
>                 bool s_of, d_of, p_of;          \
> -       } t ## _tests[] __initconst
> +       } t ## _tests[]
>
>  DEFINE_TEST_ARRAY(u8) = {
>         {0, 0, 0, 0, 0, false, false, false},
> @@ -220,43 +224,31 @@ DEFINE_TEST_ARRAY(s64) = {
>         bool _of;                                               \
>                                                                 \
>         _of = check_ ## op ## _overflow(a, b, &_r);             \
> -       if (_of != of) {                                        \
> -               pr_warn("expected "fmt" "sym" "fmt              \
> -                       " to%s overflow (type %s)\n",           \
> -                       a, b, of ? "" : " not", #t);            \
> -               err = 1;                                        \
> -       }                                                       \
> -       if (_r != r) {                                          \
> -               pr_warn("expected "fmt" "sym" "fmt" == "        \
> -                       fmt", got "fmt" (type %s)\n",           \
> -                       a, b, r, _r, #t);                       \
> -               err = 1;                                        \
> -       }                                                       \
> +       KUNIT_EXPECT_EQ_MSG(test, _of, of,                      \
> +               "expected "fmt" "sym" "fmt" to%s overflow (type %s)\n", \
> +               a, b, of ? "" : " not", #t);                    \
> +       KUNIT_EXPECT_EQ_MSG(test, _r, r,                        \
> +               "expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
> +               a, b, r, _r, #t);                               \
>  } while (0)
>
>  #define DEFINE_TEST_FUNC(t, fmt)                                       \
> -static int __init do_test_ ## t(const struct test_ ## t *p)            \
> +static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
>  {                                                                      \
> -       int err = 0;                                                    \
> -                                                                       \
>         check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);    \
>         check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);    \
>         check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);   \
>         check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);   \
>         check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);   \
> -                                                                       \
> -       return err;                                                     \
>  }                                                                      \
>                                                                         \
> -static int __init test_ ## t ## _overflow(void) {                      \
> -       int err = 0;                                                    \
> +static void t ## _overflow_test(struct kunit *test) {                  \
>         unsigned i;                                                     \
>                                                                         \
>         for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)                   \
> -               err |= do_test_ ## t(&t ## _tests[i]);                  \
> -       pr_info("%zu %s arithmetic tests finished\n",                   \
> +               do_test_ ## t(test, &t ## _tests[i]);                   \
> +       kunit_info(test, "%zu %s arithmetic tests finished\n",          \
>                 ARRAY_SIZE(t ## _tests), #t);                           \
> -       return err;                                                     \
>  }
>
>  DEFINE_TEST_FUNC(u8, "%d");
> @@ -270,198 +262,176 @@ DEFINE_TEST_FUNC(u64, "%llu");
>  DEFINE_TEST_FUNC(s64, "%lld");
>  #endif
>
> -static int __init test_overflow_calculation(void)
> -{
> -       int err = 0;
> -
> -       err |= test_u8_overflow();
> -       err |= test_s8_overflow();
> -       err |= test_u16_overflow();
> -       err |= test_s16_overflow();
> -       err |= test_u32_overflow();
> -       err |= test_s32_overflow();
> -#if BITS_PER_LONG == 64
> -       err |= test_u64_overflow();
> -       err |= test_s64_overflow();
> -#endif
> -
> -       return err;
> -}
> -
> -static int __init test_overflow_shift(void)
> +static void overflow_shift_test(struct kunit *test)
>  {
> -       int err = 0;
>         int count = 0;
>
>  /* Args are: value, shift, type, expected result, overflow expected */
> -#define TEST_ONE_SHIFT(a, s, t, expect, of) ({                         \
> -       int __failed = 0;                                               \
> +#define TEST_ONE_SHIFT(a, s, t, expect, of)    do {                    \
>         typeof(a) __a = (a);                                            \
>         typeof(s) __s = (s);                                            \
>         t __e = (expect);                                               \
>         t __d;                                                          \
>         bool __of = check_shl_overflow(__a, __s, &__d);                 \
>         if (__of != of) {                                               \
> -               pr_warn("expected (%s)(%s << %s) to%s overflow\n",      \
> +               KUNIT_EXPECT_EQ_MSG(test, __of, of,                     \
> +                       "expected (%s)(%s << %s) to%s overflow\n",      \
>                         #t, #a, #s, of ? "" : " not");                  \
> -               __failed = 1;                                           \
>         } else if (!__of && __d != __e) {                               \
> -               pr_warn("expected (%s)(%s << %s) == %s\n",              \
> +               KUNIT_EXPECT_EQ_MSG(test, __d, __e,                     \
> +                       "expected (%s)(%s << %s) == %s\n",              \
>                         #t, #a, #s, #expect);                           \
>                 if ((t)-1 < 0)                                          \
> -                       pr_warn("got %lld\n", (s64)__d);                \
> +                       kunit_info(test, "got %lld\n", (s64)__d);       \
>                 else                                                    \
> -                       pr_warn("got %llu\n", (u64)__d);                \
> -               __failed = 1;                                           \
> +                       kunit_info(test, "got %llu\n", (u64)__d);       \
>         }                                                               \
>         count++;                                                        \
> -       __failed;                                                       \
> -})
> +} while (0)
>
>         /* Sane shifts. */
> -       err |= TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
> -       err |= TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
> -       err |= TEST_ONE_SHIFT(0xF, 4, u8, 0xF << 4, false);
> -       err |= TEST_ONE_SHIFT(1, 0, u16, 1 << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
> -       err |= TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
> -       err |= TEST_ONE_SHIFT(0xFF, 8, u16, 0xFF << 8, false);
> -       err |= TEST_ONE_SHIFT(1, 0, int, 1 << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 16, int, 1 << 16, false);
> -       err |= TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
> -       err |= TEST_ONE_SHIFT(1, 0, s32, 1 << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 16, s32, 1 << 16, false);
> -       err |= TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
> -       err |= TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
> -       err |= TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
> -       err |= TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
> -       err |= TEST_ONE_SHIFT(1, 0, u32, 1U << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
> -       err |= TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
> -       err |= TEST_ONE_SHIFT(0xFFFFU, 16, u32, 0xFFFFU << 16, false);
> -       err |= TEST_ONE_SHIFT(1, 0, u64, 1ULL << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
> -       err |= TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
> -       err |= TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64,
> -                             0xFFFFFFFFULL << 32, false);
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
> +       TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64, 0xFFFFFFFFULL << 32, false);
>
>         /* Sane shift: start and end with 0, without a too-wide shift. */
> -       err |= TEST_ONE_SHIFT(0, 7, u8, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 15, u16, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 31, u32, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 63, u64, 0, false);
> +       TEST_ONE_SHIFT(0, 7, u8, 0, false);
> +       TEST_ONE_SHIFT(0, 15, u16, 0, false);
> +       TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
> +       TEST_ONE_SHIFT(0, 31, u32, 0, false);
> +       TEST_ONE_SHIFT(0, 63, u64, 0, false);
>
>         /* Sane shift: start and end with 0, without reaching signed bit. */
> -       err |= TEST_ONE_SHIFT(0, 6, s8, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 14, s16, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 30, int, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 30, s32, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 62, s64, 0, false);
> +       TEST_ONE_SHIFT(0, 6, s8, 0, false);
> +       TEST_ONE_SHIFT(0, 14, s16, 0, false);
> +       TEST_ONE_SHIFT(0, 30, int, 0, false);
> +       TEST_ONE_SHIFT(0, 30, s32, 0, false);
> +       TEST_ONE_SHIFT(0, 62, s64, 0, false);
>
>         /* Overflow: shifted the bit off the end. */
> -       err |= TEST_ONE_SHIFT(1, 8, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 16, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 32, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 64, u64, 0, true);
> +       TEST_ONE_SHIFT(1, 8, u8, 0, true);
> +       TEST_ONE_SHIFT(1, 16, u16, 0, true);
> +       TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(1, 32, u32, 0, true);
> +       TEST_ONE_SHIFT(1, 64, u64, 0, true);
>
>         /* Overflow: shifted into the signed bit. */
> -       err |= TEST_ONE_SHIFT(1, 7, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 15, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 31, int, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 31, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 63, s64, 0, true);
> +       TEST_ONE_SHIFT(1, 7, s8, 0, true);
> +       TEST_ONE_SHIFT(1, 15, s16, 0, true);
> +       TEST_ONE_SHIFT(1, 31, int, 0, true);
> +       TEST_ONE_SHIFT(1, 31, s32, 0, true);
> +       TEST_ONE_SHIFT(1, 63, s64, 0, true);
>
>         /* Overflow: high bit falls off unsigned types. */
>         /* 10010110 */
> -       err |= TEST_ONE_SHIFT(150, 1, u8, 0, true);
> +       TEST_ONE_SHIFT(150, 1, u8, 0, true);
>         /* 1000100010010110 */
> -       err |= TEST_ONE_SHIFT(34966, 1, u16, 0, true);
> +       TEST_ONE_SHIFT(34966, 1, u16, 0, true);
>         /* 10000100000010001000100010010110 */
> -       err |= TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
> +       TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
>         /* 1000001000010000010000000100000010000100000010001000100010010110 */
> -       err |= TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
> +       TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
>
>         /* Overflow: bit shifted into signed bit on signed types. */
>         /* 01001011 */
> -       err |= TEST_ONE_SHIFT(75, 1, s8, 0, true);
> +       TEST_ONE_SHIFT(75, 1, s8, 0, true);
>         /* 0100010001001011 */
> -       err |= TEST_ONE_SHIFT(17483, 1, s16, 0, true);
> +       TEST_ONE_SHIFT(17483, 1, s16, 0, true);
>         /* 01000010000001000100010001001011 */
> -       err |= TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
>         /* 0100000100001000001000000010000001000010000001000100010001001011 */
> -       err |= TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
> +       TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
>
>         /* Overflow: bit shifted past signed bit on signed types. */
>         /* 01001011 */
> -       err |= TEST_ONE_SHIFT(75, 2, s8, 0, true);
> +       TEST_ONE_SHIFT(75, 2, s8, 0, true);
>         /* 0100010001001011 */
> -       err |= TEST_ONE_SHIFT(17483, 2, s16, 0, true);
> +       TEST_ONE_SHIFT(17483, 2, s16, 0, true);
>         /* 01000010000001000100010001001011 */
> -       err |= TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
>         /* 0100000100001000001000000010000001000010000001000100010001001011 */
> -       err |= TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
> +       TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
>
>         /* Overflow: values larger than destination type. */
> -       err |= TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
> +       TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
> +       TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
> +       TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
> +       TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
> +       TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
>
>         /* Nonsense: negative initial value. */
> -       err |= TEST_ONE_SHIFT(-1, 0, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(-1, 0, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(-5, 0, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(-5, 0, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(-10, 0, int, 0, true);
> -       err |= TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
> -       err |= TEST_ONE_SHIFT(-100, 0, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(-100, 0, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
> -       err |= TEST_ONE_SHIFT(-10000, 0, u64, 0, true);
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
>
>         /* Nonsense: negative shift values. */
> -       err |= TEST_ONE_SHIFT(0, -5, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -5, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -10, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -10, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -15, int, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -20, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -20, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -30, s64, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -30, u64, 0, true);
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
>
>         /* Overflow: shifted at or beyond entire type's bit width. */
> -       err |= TEST_ONE_SHIFT(0, 8, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 9, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 8, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 9, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 16, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 17, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 16, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 17, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 32, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 33, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 32, int, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 33, int, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 32, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 33, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 64, u64, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 65, u64, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 64, s64, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 65, s64, 0, true);
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
>
>         /*
>          * Corner case: for unsigned types, we fail when we've shifted
> @@ -472,17 +442,14 @@ static int __init test_overflow_shift(void)
>          * signed bit). So, for now, we will test this condition but
>          * mark it as not expected to overflow.
>          */
> -       err |= TEST_ONE_SHIFT(0, 7, s8, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 15, s16, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 31, int, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
> -
> -       pr_info("%d shift tests finished\n", count);
> +       TEST_ONE_SHIFT(0, 7, s8, 0, false);
> +       TEST_ONE_SHIFT(0, 15, s16, 0, false);
> +       TEST_ONE_SHIFT(0, 31, int, 0, false);
> +       TEST_ONE_SHIFT(0, 31, s32, 0, false);
> +       TEST_ONE_SHIFT(0, 63, s64, 0, false);
>
> +       kunit_info(test, "%d shift tests finished\n", count);
>  #undef TEST_ONE_SHIFT
> -
> -       return err;
>  }
>
>  /*
> @@ -502,7 +469,7 @@ static int __init test_overflow_shift(void)
>  #define TEST_SIZE              (5 * 4096)
>
>  #define DEFINE_TEST_ALLOC(func, free_func, want_arg, want_gfp, want_node)\
> -static int __init test_ ## func (void *arg)                            \
> +static void test_ ## func (struct kunit *test, void *arg)              \
>  {                                                                      \
>         volatile size_t a = TEST_SIZE;                                  \
>         volatile size_t b = (SIZE_MAX / TEST_SIZE) + 1;                 \
> @@ -510,30 +477,28 @@ static int __init test_ ## func (void *arg)                               \
>                                                                         \
>         /* Tiny allocation test. */                                     \
>         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg, 1);\
> -       if (!ptr) {                                                     \
> -               pr_warn(#func " failed regular allocation?!\n");        \
> -               return 1;                                               \
> -       }                                                               \
> +       KUNIT_EXPECT_FALSE_MSG(test, !ptr,                              \
> +                           #func " failed regular allocation?!\n");    \

Optional: we can consider using KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG() here.
It's a more heavy handed than just a `return` on failure, but if the
regular allocation failed, we're probably justified in bailing out on
the whole test case.

> +       if (!ptr)                                                       \
> +               return;                                                 \
>         free ## want_arg (free_func, arg, ptr);                         \
>                                                                         \
>         /* Wrapped allocation test. */                                  \
>         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,    \
>                                                           a * b);       \
> -       if (!ptr) {                                                     \
> -               pr_warn(#func " unexpectedly failed bad wrapping?!\n"); \
> -               return 1;                                               \
> -       }                                                               \
> +       KUNIT_EXPECT_FALSE_MSG(test, !ptr,                              \
> +                           #func " unexpectedly failed bad wrapping?!\n"); \
> +       if (!ptr)                                                       \
> +               return;                                                 \
>         free ## want_arg (free_func, arg, ptr);                         \
>                                                                         \
>         /* Saturated allocation test. */                                \
>         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,    \
>                                                    array_size(a, b));   \
> -       if (ptr) {                                                      \
> -               pr_warn(#func " missed saturation!\n");                 \
> +       KUNIT_EXPECT_FALSE_MSG(test, ptr,                               \
> +                           #func " missed saturation!\n");             \
> +       if (ptr)                                                        \

We can instead do

if (ptr) {
  KUNIT_FAIL(test, #func "missed saturation!");
 free...()
}

IMO, it's a bit easier to read that way, but not that important.

>                 free ## want_arg (free_func, arg, ptr);                 \
> -               return 1;                                               \
> -       }                                                               \
