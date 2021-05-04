Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8651C37308F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 May 2021 21:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhEDTPh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 May 2021 15:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhEDTP3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 May 2021 15:15:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7781FC061574
        for <linux-kselftest@vger.kernel.org>; Tue,  4 May 2021 12:14:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n25so11740624edr.5
        for <linux-kselftest@vger.kernel.org>; Tue, 04 May 2021 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZL4jKl8SbdWECCRLvlZ3jaQSrEUlGsQhmXcQwm0FHNE=;
        b=fE0oVtcmhoiXvOqs6V5qmCRaP8NTfUmxLU4sueVIjNbujVBU5h3bZ/SOxElpYw/F66
         P7Pg2tyLmxBLaYXO7V6lmY3i/tve/TDhZlM7DhGrp8W+B0TUtSL9Qm1rKf+8F4vDgbEd
         DA/E8OhNiTIuHjawU0mt4CE1at+pC1wA29zHTSc/rLQeEEuthCDfJU1dF76QYAMlH/8I
         eyCBHv71cU+1uWg/T5cEjnXqKMtCf10pnsr3rxDjjKmqcWYz3l5tRBxV+iL6CmChILPA
         ExjZSJn6/tkvciOvpDWrfiCeGo9N9vPaItiVRVQOmmnYUcvGedWdcbfc/YPZVDvne05X
         9QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZL4jKl8SbdWECCRLvlZ3jaQSrEUlGsQhmXcQwm0FHNE=;
        b=O3Mcu0pFXaxnKmz3p+a6sooxOXHs2W/o/8m2mF0tHUvZl+1+gSIpUFhIvU8cWk0xHV
         gd6GE9QMVbbHhYE/pek+uziG77wwjWhNreHNhP44c5k8xxyGRwdTT7C6cs8A3IzNGVDb
         dGM0+ZVPVyCW3r7QHnz8jtHiKoigXrfycFS09OW/i8ffxC/Nt+FnT5bhWbKr7QzurhB0
         BwCFI2Ut9QoC4l82oghjeipj3IDrWgVpVohNV2m51GwGrXjvPJ/DaYuTP5I4Q8lNoiOl
         lyR5+QPDFpMc689oJ0vkmyvT2ndrr1i1g61CKxDunGc9CvcuNFuqt/wUwjDBjn4lbXBS
         HfCQ==
X-Gm-Message-State: AOAM5313hKRf588YJYMzjYurjQPkgFfHHqQKoIO4k83WlMVng47n935n
        QhRacXcbIBMEtajAR0hVYUUjptSmNmnt07Za0fHeFA==
X-Google-Smtp-Source: ABdhPJyXrLJaJL1emAtGMal1UVijj72+TvSp6qk+anTqHE6uFyYYodiiuQbuZhfgNoUV+thc4HmVysH1jCsar3+2XOA=
X-Received: by 2002:a05:6402:22c3:: with SMTP id dm3mr26563532edb.307.1620155671773;
 Tue, 04 May 2021 12:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210503211536.1384578-1-dlatypov@google.com> <CABVgOSm49+kT_ZN4NGdsUYWL5ntdFJeCCVS1prESbwCGPXhWYw@mail.gmail.com>
In-Reply-To: <CABVgOSm49+kT_ZN4NGdsUYWL5ntdFJeCCVS1prESbwCGPXhWYw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 4 May 2021 12:14:20 -0700
Message-ID: <CAGS_qxp2hDSvHEMe=c8fm-wfJe1ce=sFWMhyCPbrMZs3LRQOrQ@mail.gmail.com>
Subject: Re: [PATCH] lib/test: convert test_overflow.c to use KUnit
To:     David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
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

On Mon, May 3, 2021 at 11:49 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, May 4, 2021 at 5:15 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > This largely consists of:
> > * replacing `err |= test_func(...)` calls with `test_func(test, ...)`.
> > * changing pr_warn to KUNIT_*_MSG() macros to mark the failed test
> > while printing a diagnostic message
> > * dropping __init as there are concerns of this causing issues w/ KUnit
> > when running on some other arches.
> >
> > With the exception of now needing to set CONFIG_KUNIT=y, the test can
> > still be run as before, at boot time or as a test module.
> > But now the output of the test will be TAP (Test Anything Protocol),
> > the format used by kselftest instead of just warnings and printing
> > "FAIL!" , see [1].
> >
> > But now the test can also be run more quickly via kunit.py
> >
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> > CONFIG_KUNIT=y
> > CONFIG_TEST_OVERFLOW=y
> > EOF
> >
> > Note: after a mrproper this took
> > > Elapsed time: 38.683s total, 3.598s configuring, 32.141s building, 0.000s running
> >
> > (Normally would be less clunky as you wouldn't use a heredoc).
> >
> > [1] Here's an example failure message after tweaking the test array:
> >   TAP version 14
> >   1..1
> >       # Subtest: lib_overflow
> >       1..10
> >   u8 : 18 arithmetic tests
> >       # test_u8_overflow: EXPECTATION FAILED at lib/test_overflow.c:250
> >       Expected _got == p->sum, but
> >           _got == 1
> >           p->sum == 0
> >   wrong result for 1 + 0 (type u8)
> >   ...
> >       not ok 1 - test_u8_overflow
> >   s8 : 19 arithmetic tests
> >       ok 2 - test_s8_overflow
> >   ...
> >   ok: (s32)(0 << 31) == 0
> >   ok: (s64)(0 << 63) == 0
> >       ok 9 - test_overflow_shift
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> This worked fine for me (and correctly picked up on any errors I
> deliberately introduced). It's much nicer to be able to read the
> results from kunit_tool's summary.
>
> I will add that this is a very verbose test, and in particular it
> causes a stacktrace with the vmalloc overflow test. This doesn't
> appear to be new to the KUnit version (indeed, it's great to have
> kunit_tool to cut through the noise), but there are definitely a few
> extra places where some extra text output could be removed or
> streamlined. Some thoughts re: this below.

Yes, it can be verbose since it prints out all the passing test cases,
which I think can be useful.
I'm generally hesitant about changing the output of the test much more
than we already have (i.e. the additional TAP output interspersed with
the original) in this patch.

>
> This is, therefore:
> Tested-by: David Gow <davidgow@google.com>
>
>
> >  lib/Kconfig.debug   |   4 +-
> >  lib/test_overflow.c | 406 ++++++++++++++++++++------------------------
> >  2 files changed, 185 insertions(+), 225 deletions(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 678c13967580..8e19ba9ac22c 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2195,7 +2195,9 @@ config TEST_XARRAY
> >         tristate "Test the XArray code at runtime"
> >
> >  config TEST_OVERFLOW
> > -       tristate "Test check_*_overflow() functions at runtime"
> > +       tristate "Test check_*_overflow() functions at runtime" if !KUNIT_ALL_TESTS
> > +       depends on KUNIT
> > +       default KUNIT_ALL_TESTS
> >
> >  config TEST_RHASHTABLE
> >         tristate "Perform selftest on resizable hash table"
> > diff --git a/lib/test_overflow.c b/lib/test_overflow.c
> > index 7a4b6f6c5473..1719b924f04f 100644
> > --- a/lib/test_overflow.c
> > +++ b/lib/test_overflow.c
> > @@ -2,10 +2,9 @@
> >  /*
> >   * Test cases for arithmetic overflow checks.
> >   */
> > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +#include <kunit/test.h>
> >
> >  #include <linux/device.h>
> > -#include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> > @@ -19,7 +18,7 @@
> >                 t a, b;                         \
> >                 t sum, diff, prod;              \
> >                 bool s_of, d_of, p_of;          \
> > -       } t ## _tests[] __initconst
> > +       } t ## _tests[]
> >
> >  DEFINE_TEST_ARRAY(u8) = {
> >         {0, 0, 0, 0, 0, false, false, false},
> > @@ -215,48 +214,38 @@ DEFINE_TEST_ARRAY(s64) = {
> >         {0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
> >  };
> >
> > -#define check_one_op(t, fmt, op, sym, a, b, r, of) do {                \
> > -       t _r;                                                   \
> > -       bool _of;                                               \
> > -                                                               \
> > -       _of = check_ ## op ## _overflow(a, b, &_r);             \
> > -       if (_of != of) {                                        \
> > -               pr_warn("expected "fmt" "sym" "fmt              \
> > -                       " to%s overflow (type %s)\n",           \
> > -                       a, b, of ? "" : " not", #t);            \
> > -               err = 1;                                        \
> > -       }                                                       \
> > -       if (_r != r) {                                          \
> > -               pr_warn("expected "fmt" "sym" "fmt" == "        \
> > -                       fmt", got "fmt" (type %s)\n",           \
> > -                       a, b, r, _r, #t);                       \
> > -               err = 1;                                        \
> > -       }                                                       \
> > +#define check_one_op(t, fmt, op, sym, a, b, want, of) do {             \
> > +       t _got;                                                         \
> > +       bool _of;                                                       \
> > +                                                                       \
> > +       _of = check_ ## op ## _overflow(a, b, &_got);                   \
> > +       KUNIT_EXPECT_EQ_MSG(test, _of, of,                              \
> > +               "expected " fmt " " sym " " fmt " to%s overflow "       \
> > +               "(type %s)", a, b, of ? "" : " not", #t);               \
> > +                                                                       \
> > +       KUNIT_EXPECT_EQ_MSG(test, _got, want,                           \
> > +               "wrong result for " fmt " " sym " " fmt " (type %s)",   \
> > +               a, b, #t);                                              \
> >  } while (0)
> >
> >  #define DEFINE_TEST_FUNC(t, fmt)                                       \
> > -static int __init do_test_ ## t(const struct test_ ## t *p)            \
> > -{                                                                      \
> > -       int err = 0;                                                    \
> > -                                                                       \
> > +static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p)\
> > +{                                                                      \
> >         check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);    \
> >         check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);    \
> >         check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);   \
> >         check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);   \
> >         check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);   \
> > -                                                                       \
> > -       return err;                                                     \
> >  }                                                                      \
> >                                                                         \
> > -static int __init test_ ## t ## _overflow(void) {                      \
> > -       int err = 0;                                                    \
> > +static void test_ ## t ## _overflow(struct kunit *test)                        \
> > +{                                                                      \
> >         unsigned i;                                                     \
> >                                                                         \
> >         pr_info("%-3s: %zu arithmetic tests\n", #t,                     \
> >                 ARRAY_SIZE(t ## _tests));                               \
> >         for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)                   \
> > -               err |= do_test_ ## t(&t ## _tests[i]);                  \
> > -       return err;                                                     \
> > +               do_test_ ## t(test, &t ## _tests[i]);                   \
> >  }
> >
> >  DEFINE_TEST_FUNC(u8, "%d");
> > @@ -270,30 +259,10 @@ DEFINE_TEST_FUNC(u64, "%llu");
> >  DEFINE_TEST_FUNC(s64, "%lld");
> >  #endif
> >
> > -static int __init test_overflow_calculation(void)
> > +static void test_overflow_shift(struct kunit *test)
> >  {
> > -       int err = 0;
> > -
> > -       err |= test_u8_overflow();
> > -       err |= test_s8_overflow();
> > -       err |= test_u16_overflow();
> > -       err |= test_s16_overflow();
> > -       err |= test_u32_overflow();
> > -       err |= test_s32_overflow();
> > -#if BITS_PER_LONG == 64
> > -       err |= test_u64_overflow();
> > -       err |= test_s64_overflow();
> > -#endif
> > -
> > -       return err;
> > -}
> > -
> > -static int __init test_overflow_shift(void)
> > -{
> > -       int err = 0;
> > -
> >  /* Args are: value, shift, type, expected result, overflow expected */
> > -#define TEST_ONE_SHIFT(a, s, t, expect, of) ({                         \
> > +#define TEST_ONE_SHIFT(a, s, t, expect, of) do {                       \
> >         int __failed = 0;                                               \
> >         typeof(a) __a = (a);                                            \
> >         typeof(s) __s = (s);                                            \
> > @@ -316,153 +285,153 @@ static int __init test_overflow_shift(void)
> >         if (!__failed)                                                  \
> >                 pr_info("ok: (%s)(%s << %s) == %s\n", #t, #a, #s,       \
> >                         of ? "overflow" : #expect);                     \
>
> This is one of a number of pr_{info,warn}() calls in the
> TEST_ONE_SHIFT macro. Could we use the KUnit log here instead, so that
> potentially this output is kept if kunit's debugfs support is enabled?

KUNIT_LOG_SIZE == 512.
So we'd quickly overflow it w/ all the current pr_info() output.

The other test cases are more manageable and can be converted.
I was tempted to leave the informational logs as pr_info() for consistency.

(And the pr_warn()'s will all be gone in v2, see below)

> Or we could get rid of some to make the test less verbose...
>
> That being said, this macro still has a bunch of pr_warn() calls for
> "expected (something)" which might be better off as direct
> KUNIT_EXPECT_ calls.

Good catch.
I distinctly remember changing this part... I must have accidentally
reverted these changes.

Recreated them, this macro now looks like

#define TEST_ONE_SHIFT(a, s, t, expect, of) do {                        \
        int __failed = 0;                                               \
        typeof(a) __a = (a);                                            \
        typeof(s) __s = (s);                                            \
        t __want = (expect);                                            \
        t __got;                                                        \
        bool __of = check_shl_overflow(__a, __s, &__got);               \
        if (__of != of) {                                               \
                KUNIT_FAIL(test, "expected (%s)(%s << %s) to%s overflow"\
                           #t, #a, #s, of ? "" : " not");               \
                __failed = 1;                                           \
        } else if (!__of && __got != __want) {                          \
                KUNIT_EXPECT_EQ_MSG(test, __got, __want,                \
                        "expected (%s)(%s << %s) == %s",                \
                        #t, #a, #s, #expect);                           \
                __failed = 1;                                           \
        }                                                               \
        if (!__failed)                                                  \
                pr_info("ok: (%s)(%s << %s) == %s\n", #t, #a, #s,       \
                        of ? "overflow" : #expect);                     \
} while (0)


Example failure after messed up one caller:
    # test_overflow_shift: EXPECTATION FAILED at lib/test_overflow.c:288
    Expected __got == __want, but
        __got == 2
        __want == 1
expected (u8)(1 << 1) == 1 << 0
ok: (u8)(1 << 4) == 1 << 4


>
> > -       __failed;                                                       \
> > -})
> > +       KUNIT_EXPECT_EQ_MSG(test, __failed, 0,                          \
> > +                          "(%s)(%s << %s) failed", #t, #a, #s);        \
>
> This is not a particularly great failure message: if we replaced the
> pr_warn()s above, they would provide more context as to what exactly
> failed in the test.

Yeah, I meant to change this, see the updated version posted above.


>
> > +} while (0)
> >
> >         /* Sane shifts. */
> > -       err |= TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
> > -       err |= TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
> > -       err |= TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
> > -       err |= TEST_ONE_SHIFT(0xF, 4, u8, 0xF << 4, false);
> > -       err |= TEST_ONE_SHIFT(1, 0, u16, 1 << 0, false);
> > -       err |= TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
> > -       err |= TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
> > -       err |= TEST_ONE_SHIFT(0xFF, 8, u16, 0xFF << 8, false);
> > -       err |= TEST_ONE_SHIFT(1, 0, int, 1 << 0, false);
> > -       err |= TEST_ONE_SHIFT(1, 16, int, 1 << 16, false);
> > -       err |= TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
> > -       err |= TEST_ONE_SHIFT(1, 0, s32, 1 << 0, false);
> > -       err |= TEST_ONE_SHIFT(1, 16, s32, 1 << 16, false);
> > -       err |= TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
> > -       err |= TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
> > -       err |= TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
> > -       err |= TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
> > -       err |= TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
> > -       err |= TEST_ONE_SHIFT(1, 0, u32, 1U << 0, false);
> > -       err |= TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
> > -       err |= TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
> > -       err |= TEST_ONE_SHIFT(0xFFFFU, 16, u32, 0xFFFFU << 16, false);
> > -       err |= TEST_ONE_SHIFT(1, 0, u64, 1ULL << 0, false);
> > -       err |= TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
> > -       err |= TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
> > -       err |= TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64,
> > -                             0xFFFFFFFFULL << 32, false);
> > +       TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
> > +       TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
> > +       TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
> > +       TEST_ONE_SHIFT(0xF, 4, u8, 0xF << 4, false);
> > +       TEST_ONE_SHIFT(1, 0, u16, 1 << 0, false);
> > +       TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
> > +       TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
> > +       TEST_ONE_SHIFT(0xFF, 8, u16, 0xFF << 8, false);
> > +       TEST_ONE_SHIFT(1, 0, int, 1 << 0, false);
> > +       TEST_ONE_SHIFT(1, 16, int, 1 << 16, false);
> > +       TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
> > +       TEST_ONE_SHIFT(1, 0, s32, 1 << 0, false);
> > +       TEST_ONE_SHIFT(1, 16, s32, 1 << 16, false);
> > +       TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
> > +       TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
> > +       TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
> > +       TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
> > +       TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
> > +       TEST_ONE_SHIFT(1, 0, u32, 1U << 0, false);
> > +       TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
> > +       TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
> > +       TEST_ONE_SHIFT(0xFFFFU, 16, u32, 0xFFFFU << 16, false);
> > +       TEST_ONE_SHIFT(1, 0, u64, 1ULL << 0, false);
> > +       TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
> > +       TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
> > +       TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64, 0xFFFFFFFFULL << 32, false);
> >
> >         /* Sane shift: start and end with 0, without a too-wide shift. */
> > -       err |= TEST_ONE_SHIFT(0, 7, u8, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 15, u16, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 31, u32, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 63, u64, 0, false);
> > +       TEST_ONE_SHIFT(0, 7, u8, 0, false);
> > +       TEST_ONE_SHIFT(0, 15, u16, 0, false);
> > +       TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
> > +       TEST_ONE_SHIFT(0, 31, u32, 0, false);
> > +       TEST_ONE_SHIFT(0, 63, u64, 0, false);
> >
> >         /* Sane shift: start and end with 0, without reaching signed bit. */
> > -       err |= TEST_ONE_SHIFT(0, 6, s8, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 14, s16, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 30, int, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 30, s32, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 62, s64, 0, false);
> > +       TEST_ONE_SHIFT(0, 6, s8, 0, false);
> > +       TEST_ONE_SHIFT(0, 14, s16, 0, false);
> > +       TEST_ONE_SHIFT(0, 30, int, 0, false);
> > +       TEST_ONE_SHIFT(0, 30, s32, 0, false);
> > +       TEST_ONE_SHIFT(0, 62, s64, 0, false);
> >
> >         /* Overflow: shifted the bit off the end. */
> > -       err |= TEST_ONE_SHIFT(1, 8, u8, 0, true);
> > -       err |= TEST_ONE_SHIFT(1, 16, u16, 0, true);
> > -       err |= TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
> > -       err |= TEST_ONE_SHIFT(1, 32, u32, 0, true);
> > -       err |= TEST_ONE_SHIFT(1, 64, u64, 0, true);
> > +       TEST_ONE_SHIFT(1, 8, u8, 0, true);
> > +       TEST_ONE_SHIFT(1, 16, u16, 0, true);
> > +       TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
> > +       TEST_ONE_SHIFT(1, 32, u32, 0, true);
> > +       TEST_ONE_SHIFT(1, 64, u64, 0, true);
> >
> >         /* Overflow: shifted into the signed bit. */
> > -       err |= TEST_ONE_SHIFT(1, 7, s8, 0, true);
> > -       err |= TEST_ONE_SHIFT(1, 15, s16, 0, true);
> > -       err |= TEST_ONE_SHIFT(1, 31, int, 0, true);
> > -       err |= TEST_ONE_SHIFT(1, 31, s32, 0, true);
> > -       err |= TEST_ONE_SHIFT(1, 63, s64, 0, true);
> > +       TEST_ONE_SHIFT(1, 7, s8, 0, true);
> > +       TEST_ONE_SHIFT(1, 15, s16, 0, true);
> > +       TEST_ONE_SHIFT(1, 31, int, 0, true);
> > +       TEST_ONE_SHIFT(1, 31, s32, 0, true);
> > +       TEST_ONE_SHIFT(1, 63, s64, 0, true);
> >
> >         /* Overflow: high bit falls off unsigned types. */
> >         /* 10010110 */
> > -       err |= TEST_ONE_SHIFT(150, 1, u8, 0, true);
> > +       TEST_ONE_SHIFT(150, 1, u8, 0, true);
> >         /* 1000100010010110 */
> > -       err |= TEST_ONE_SHIFT(34966, 1, u16, 0, true);
> > +       TEST_ONE_SHIFT(34966, 1, u16, 0, true);
> >         /* 10000100000010001000100010010110 */
> > -       err |= TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
> > -       err |= TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
> > +       TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
> > +       TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
> >         /* 1000001000010000010000000100000010000100000010001000100010010110 */
> > -       err |= TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
> > +       TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
> >
> >         /* Overflow: bit shifted into signed bit on signed types. */
> >         /* 01001011 */
> > -       err |= TEST_ONE_SHIFT(75, 1, s8, 0, true);
> > +       TEST_ONE_SHIFT(75, 1, s8, 0, true);
> >         /* 0100010001001011 */
> > -       err |= TEST_ONE_SHIFT(17483, 1, s16, 0, true);
> > +       TEST_ONE_SHIFT(17483, 1, s16, 0, true);
> >         /* 01000010000001000100010001001011 */
> > -       err |= TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
> > -       err |= TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
> > +       TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
> > +       TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
> >         /* 0100000100001000001000000010000001000010000001000100010001001011 */
> > -       err |= TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
> > +       TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
> >
> >         /* Overflow: bit shifted past signed bit on signed types. */
> >         /* 01001011 */
> > -       err |= TEST_ONE_SHIFT(75, 2, s8, 0, true);
> > +       TEST_ONE_SHIFT(75, 2, s8, 0, true);
> >         /* 0100010001001011 */
> > -       err |= TEST_ONE_SHIFT(17483, 2, s16, 0, true);
> > +       TEST_ONE_SHIFT(17483, 2, s16, 0, true);
> >         /* 01000010000001000100010001001011 */
> > -       err |= TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
> > -       err |= TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
> > +       TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
> > +       TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
> >         /* 0100000100001000001000000010000001000010000001000100010001001011 */
> > -       err |= TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
> > +       TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
> >
> >         /* Overflow: values larger than destination type. */
> > -       err |= TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
> > -       err |= TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
> > -       err |= TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
> > -       err |= TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
> > -       err |= TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
> > -       err |= TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
> > -       err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
> > -       err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
> > -       err |= TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
> > +       TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
> > +       TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
> > +       TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
> > +       TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
> > +       TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
> > +       TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
> > +       TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
> > +       TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
> > +       TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
> >
> >         /* Nonsense: negative initial value. */
> > -       err |= TEST_ONE_SHIFT(-1, 0, s8, 0, true);
> > -       err |= TEST_ONE_SHIFT(-1, 0, u8, 0, true);
> > -       err |= TEST_ONE_SHIFT(-5, 0, s16, 0, true);
> > -       err |= TEST_ONE_SHIFT(-5, 0, u16, 0, true);
> > -       err |= TEST_ONE_SHIFT(-10, 0, int, 0, true);
> > -       err |= TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
> > -       err |= TEST_ONE_SHIFT(-100, 0, s32, 0, true);
> > -       err |= TEST_ONE_SHIFT(-100, 0, u32, 0, true);
> > -       err |= TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
> > -       err |= TEST_ONE_SHIFT(-10000, 0, u64, 0, true);
> > +       TEST_ONE_SHIFT(-1, 0, s8, 0, true);
> > +       TEST_ONE_SHIFT(-1, 0, u8, 0, true);
> > +       TEST_ONE_SHIFT(-5, 0, s16, 0, true);
> > +       TEST_ONE_SHIFT(-5, 0, u16, 0, true);
> > +       TEST_ONE_SHIFT(-10, 0, int, 0, true);
> > +       TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
> > +       TEST_ONE_SHIFT(-100, 0, s32, 0, true);
> > +       TEST_ONE_SHIFT(-100, 0, u32, 0, true);
> > +       TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
> > +       TEST_ONE_SHIFT(-10000, 0, u64, 0, true);
> >
> >         /* Nonsense: negative shift values. */
> > -       err |= TEST_ONE_SHIFT(0, -5, s8, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, -5, u8, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, -10, s16, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, -10, u16, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, -15, int, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, -20, s32, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, -20, u32, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, -30, s64, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, -30, u64, 0, true);
> > +       TEST_ONE_SHIFT(0, -5, s8, 0, true);
> > +       TEST_ONE_SHIFT(0, -5, u8, 0, true);
> > +       TEST_ONE_SHIFT(0, -10, s16, 0, true);
> > +       TEST_ONE_SHIFT(0, -10, u16, 0, true);
> > +       TEST_ONE_SHIFT(0, -15, int, 0, true);
> > +       TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
> > +       TEST_ONE_SHIFT(0, -20, s32, 0, true);
> > +       TEST_ONE_SHIFT(0, -20, u32, 0, true);
> > +       TEST_ONE_SHIFT(0, -30, s64, 0, true);
> > +       TEST_ONE_SHIFT(0, -30, u64, 0, true);
> >
> >         /* Overflow: shifted at or beyond entire type's bit width. */
> > -       err |= TEST_ONE_SHIFT(0, 8, u8, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 9, u8, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 8, s8, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 9, s8, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 16, u16, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 17, u16, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 16, s16, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 17, s16, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 32, u32, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 33, u32, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 32, int, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 33, int, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 32, s32, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 33, s32, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 64, u64, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 65, u64, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 64, s64, 0, true);
> > -       err |= TEST_ONE_SHIFT(0, 65, s64, 0, true);
> > +       TEST_ONE_SHIFT(0, 8, u8, 0, true);
> > +       TEST_ONE_SHIFT(0, 9, u8, 0, true);
> > +       TEST_ONE_SHIFT(0, 8, s8, 0, true);
> > +       TEST_ONE_SHIFT(0, 9, s8, 0, true);
> > +       TEST_ONE_SHIFT(0, 16, u16, 0, true);
> > +       TEST_ONE_SHIFT(0, 17, u16, 0, true);
> > +       TEST_ONE_SHIFT(0, 16, s16, 0, true);
> > +       TEST_ONE_SHIFT(0, 17, s16, 0, true);
> > +       TEST_ONE_SHIFT(0, 32, u32, 0, true);
> > +       TEST_ONE_SHIFT(0, 33, u32, 0, true);
> > +       TEST_ONE_SHIFT(0, 32, int, 0, true);
> > +       TEST_ONE_SHIFT(0, 33, int, 0, true);
> > +       TEST_ONE_SHIFT(0, 32, s32, 0, true);
> > +       TEST_ONE_SHIFT(0, 33, s32, 0, true);
> > +       TEST_ONE_SHIFT(0, 64, u64, 0, true);
> > +       TEST_ONE_SHIFT(0, 65, u64, 0, true);
> > +       TEST_ONE_SHIFT(0, 64, s64, 0, true);
> > +       TEST_ONE_SHIFT(0, 65, s64, 0, true);
> >
> >         /*
> >          * Corner case: for unsigned types, we fail when we've shifted
> > @@ -473,13 +442,11 @@ static int __init test_overflow_shift(void)
> >          * signed bit). So, for now, we will test this condition but
> >          * mark it as not expected to overflow.
> >          */
> > -       err |= TEST_ONE_SHIFT(0, 7, s8, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 15, s16, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 31, int, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
> > -       err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
> > -
> > -       return err;
> > +       TEST_ONE_SHIFT(0, 7, s8, 0, false);
> > +       TEST_ONE_SHIFT(0, 15, s16, 0, false);
> > +       TEST_ONE_SHIFT(0, 31, int, 0, false);
> > +       TEST_ONE_SHIFT(0, 31, s32, 0, false);
> > +       TEST_ONE_SHIFT(0, 63, s64, 0, false);
> >  }
> >
> >  /*
> > @@ -499,7 +466,7 @@ static int __init test_overflow_shift(void)
> >  #define TEST_SIZE              (5 * 4096)
> >
> >  #define DEFINE_TEST_ALLOC(func, free_func, want_arg, want_gfp, want_node)\
> > -static int __init test_ ## func (void *arg)                            \
> > +static void test_ ## func (struct kunit *test, void *arg)              \
> >  {                                                                      \
> >         volatile size_t a = TEST_SIZE;                                  \
> >         volatile size_t b = (SIZE_MAX / TEST_SIZE) + 1;                 \
> > @@ -507,31 +474,26 @@ static int __init test_ ## func (void *arg)                               \
> >                                                                         \
> >         /* Tiny allocation test. */                                     \
> >         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg, 1);\
> > -       if (!ptr) {                                                     \
> > -               pr_warn(#func " failed regular allocation?!\n");        \
> > -               return 1;                                               \
> > -       }                                                               \
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,                     \
> > +               #func " failed regular allocation?!");                  \
> >         free ## want_arg (free_func, arg, ptr);                         \
> >                                                                         \
> >         /* Wrapped allocation test. */                                  \
> >         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,    \
> >                                                           a * b);       \
> > -       if (!ptr) {                                                     \
> > -               pr_warn(#func " unexpectedly failed bad wrapping?!\n"); \
> > -               return 1;                                               \
> > -       }                                                               \
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,                     \
> > +               #func " unexpectedly failed bad wrapping?!");           \
> >         free ## want_arg (free_func, arg, ptr);                         \
> >                                                                         \
> >         /* Saturated allocation test. */                                \
> >         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,    \
> >                                                    array_size(a, b));   \
> >         if (ptr) {                                                      \
> > -               pr_warn(#func " missed saturation!\n");                 \
> > +               KUNIT_FAIL(test, #func " missed saturation!\n");        \
> >                 free ## want_arg (free_func, arg, ptr);                 \
> > -               return 1;                                               \
> > +               return;                                                 \
> >         }                                                               \
> >         pr_info(#func " detected saturation\n");                        \
> > -       return 0;                                                       \
> >  }
> >
> >  /*
> > @@ -555,60 +517,56 @@ DEFINE_TEST_ALLOC(kvzalloc_node, kvfree,     0, 1, 1);
> >  DEFINE_TEST_ALLOC(devm_kmalloc,  devm_kfree, 1, 1, 0);
> >  DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
> >
> > -static int __init test_overflow_allocation(void)
> > +static void test_overflow_allocation(struct kunit *test)
> >  {
> >         const char device_name[] = "overflow-test";
> >         struct device *dev;
> > -       int err = 0;
> >
> >         /* Create dummy device for devm_kmalloc()-family tests. */
> >         dev = root_device_register(device_name);
> > -       if (IS_ERR(dev)) {
> > -               pr_warn("Cannot register test device\n");
> > -               return 1;
> > -       }
> > -
> > -       err |= test_kmalloc(NULL);
> > -       err |= test_kmalloc_node(NULL);
> > -       err |= test_kzalloc(NULL);
> > -       err |= test_kzalloc_node(NULL);
> > -       err |= test_kvmalloc(NULL);
> > -       err |= test_kvmalloc_node(NULL);
> > -       err |= test_kvzalloc(NULL);
> > -       err |= test_kvzalloc_node(NULL);
> > -       err |= test_vmalloc(NULL);
> > -       err |= test_vmalloc_node(NULL);
> > -       err |= test_vzalloc(NULL);
> > -       err |= test_vzalloc_node(NULL);
> > -       err |= test_devm_kmalloc(dev);
> > -       err |= test_devm_kzalloc(dev);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, dev,
> > +                                        "Cannot register test device");
> > +
> > +       test_kmalloc(test, NULL);
> > +       test_kmalloc_node(test, NULL);
> > +       test_kzalloc(test, NULL);
> > +       test_kzalloc_node(test, NULL);
> > +       test_kvmalloc(test, NULL);
> > +       test_kvmalloc_node(test, NULL);
> > +       test_kvzalloc(test, NULL);
> > +       test_kvzalloc_node(test, NULL);
> > +       test_vmalloc(test, NULL);
> > +       test_vmalloc_node(test, NULL);
> > +       test_vzalloc(test, NULL);
> > +       test_vzalloc_node(test, NULL);
> > +       test_devm_kmalloc(test, dev);
> > +       test_devm_kzalloc(test, dev);
> >
> >         device_unregister(dev);
> > -
> > -       return err;
> >  }
> >
> > -static int __init test_module_init(void)
> > -{
> > -       int err = 0;
> > -
> > -       err |= test_overflow_calculation();
> > -       err |= test_overflow_shift();
> > -       err |= test_overflow_allocation();
> > +static struct kunit_case overflow_test_cases[] = {
> > +       KUNIT_CASE(test_u8_overflow),
> > +       KUNIT_CASE(test_s8_overflow),
> > +       KUNIT_CASE(test_u16_overflow),
> > +       KUNIT_CASE(test_s16_overflow),
> > +       KUNIT_CASE(test_u32_overflow),
> > +       KUNIT_CASE(test_s32_overflow),
> > +#if BITS_PER_LONG == 64
> > +       KUNIT_CASE(test_u64_overflow),
> > +       KUNIT_CASE(test_s64_overflow),
> > +#endif
> >
> > -       if (err) {
> > -               pr_warn("FAIL!\n");
> > -               err = -EINVAL;
> > -       } else {
> > -               pr_info("all tests passed\n");
> > -       }
> > +       KUNIT_CASE(test_overflow_shift),
> > +       KUNIT_CASE(test_overflow_allocation),
> > +       {}
> > +};
> >
> > -       return err;
> > -}
> > +static struct kunit_suite overflow_test_suite = {
> > +       .name = "lib_overflow",
> > +       .test_cases = overflow_test_cases,
> > +};
> >
> > -static void __exit test_module_exit(void)
> > -{ }
> > +kunit_test_suites(&overflow_test_suite);
> >
> > -module_init(test_module_init);
> > -module_exit(test_module_exit);
> >  MODULE_LICENSE("Dual MIT/GPL");
> >
> > base-commit: cda689f8708b6bef0b921c3a17fcdecbe959a079
> > --
> > 2.31.1.527.g47e6f16901-goog
> >
