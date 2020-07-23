Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A906622B8C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgGWVgW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 17:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGWVgW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 17:36:22 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE2FC0619DC
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jul 2020 14:36:22 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c14so3621988ybj.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jul 2020 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHBgOaH9rShd+LgrA3+Q4NHQ/bMHrKBnPtGj9l3yv0o=;
        b=rMMQpSeBF9Gg9H7FXzPcFsO+fwtUU6a1cezeSgJtffQ08JRK8YahxolkZL9CENlLLi
         ucHcQh6Ugc8ajkd26SrqBm0CGeiBd6zF+3wOroAKwqrHfizFXTsHYLIIjA+nSx1SDmlI
         LB2ifk4pc154P+atOXiMz+Z89RBf1W9gqfzLcOl4sCYdm5yXuOPzBS0Udi118IUbJLDW
         P374833k6CY3xb+jDLQCscOkNx65S2uMKk/nt6gFozlsjoYQ8vF6qsR/MuFVFtBgd3tw
         XNGy0zdWUT0eYAKCl61DvO8WVnxW5+zEdX6b4i0qGWzxzhYAHaEx8S0naEKjx+wSNACc
         GWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHBgOaH9rShd+LgrA3+Q4NHQ/bMHrKBnPtGj9l3yv0o=;
        b=clHldTiiL6f9TZ6dFsIvf69yqpC89gQMJXUYSkwRlsw6J6FfvdXmqguwpY3V4LS92o
         lyF1Nmpoq+t/Bn9rQxxdG6oWmR2yyYZSi/l5pe2SyNJeRG9z6AnZMn5c+kwRUST1U2be
         Nohh2PJNjWU4VxZJlYbcqwajdP6LQKwOhrJuI7ORXkYR11pRjNiJ+RZMH7jquyXatqa8
         XvLsGlkXPy95kByJf4URiAClY0kmh+wrVB4evesaI0rcvm07KTFEDaNY+Awqnoz786Kl
         Trs+cs+NBkXE4yQnknZBTKTEayIfHyugvuzfGjL0aqOlGaZ3KfM5DFw2cGj4F9FAyGlC
         KHiw==
X-Gm-Message-State: AOAM530cLrEJ6Dhkp/EhN76+1hW2UXZJCb3UBSwllQLUIrjzUPJ3iNdy
        Ys6lFI7xShJX2vLkRI1Yo6Yn7kAe7V3NTExUqq50Dw==
X-Google-Smtp-Source: ABdhPJzSfleDVTuuVunTIPrLaJJoQq2xczRiHGcnhpsN1k5/W7L156VGSE35CK5zadod5t0d+RP2IMhc6jib+Nv45tY=
X-Received: by 2002:a25:cfd2:: with SMTP id f201mr9991355ybg.286.1595540181282;
 Thu, 23 Jul 2020 14:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200720224418.200495-1-vitor@massaru.org> <202007211150.73CF60A9@keescook>
 <CADQ6JjUm10vPcSO5Wto=BjfM7dtdQZ924d0x-C6kxQKKZJr=qQ@mail.gmail.com> <CAFd5g468HLqzTVX7cOeHnWWBBmTMKcKPEURSgwiDC-8Hcq_vuw@mail.gmail.com>
In-Reply-To: <CAFd5g468HLqzTVX7cOeHnWWBBmTMKcKPEURSgwiDC-8Hcq_vuw@mail.gmail.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Thu, 23 Jul 2020 18:35:45 -0300
Message-ID: <CADQ6JjWW520V=eGhkP7Qoi7uOq7iL1r_Pk64y=R6DEB8gmfeBw@mail.gmail.com>
Subject: Re: [PATCH v3] lib: overflow_kunit: add KUnit test conversion of check_*_overflow
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 21, 2020 at 8:47 PM 'Brendan Higgins' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> On Tue, Jul 21, 2020 at 12:38 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
> >
> > On Tue, Jul 21, 2020 at 3:55 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Jul 20, 2020 at 07:44:18PM -0300, Vitor Massaru Iha wrote:
> > > > This adds the conversion of the runtime tests of check_*_overflow functions,
> > > > from `lib/test_overflow.c`to KUnit tests.
> > > >
> > > > The log similar to the one seen in dmesg running test_overflow.c can be
> > > > seen in `test.log`.
> > > >
> > > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > > Tested-by: David Gow <davidgow@google.com>
> > > > ---
> > > > v2:
> > > >   * moved lib/test_overflow.c to lib/overflow-test.c;
> > > >     * back to original license;
> > > >     * fixed style code;
> > > >     * keeps __initconst and added _refdata on overflow_test_cases variable;
> > > >     * keeps macros intact making asserts with the variable err;
> > > >     * removed duplicate test_s8_overflow();
> > > >   * fixed typos on commit message;
> > > >
> > > > v3:
> > > >   * changed filename to overflow_kunit.c;
> > > >   * replace _refdata by _inidata;
> > >
> > > It looks like this still needs to be _refdata (says the test bot)
> >
> > I replaced it because you said `Erm, __refdata? This seems like it
> > should be __initdata.` in v2.
> >
> > >
> > > > -static int __init test_ ## t ## _overflow(void) {                    \
> > > > +static int __init test_ ## t ## _overflow(struct kunit *test) {      \
> > >
> > > style nit: it seems like "test" isn't a great variable name. Why not
> > > make this "kunit" or "context" or something more specific?
> >
> > I tried to follow the pattern I saw in other KUnit tests.
>
> Yep, that's the pattern that pretty much all other KUnit tests follow.
> Maybe you are right and maybe we should change that convention. Still,
> this is consistent with what we do now.
>
> > >
> > > >       int err = 0;                                                    \
> > > >       unsigned i;                                                     \
> > > >                                                                       \
> > > > @@ -256,6 +253,7 @@ static int __init test_ ## t ## _overflow(void) {                 \
> > > >               ARRAY_SIZE(t ## _tests));                               \
> > > >       for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)                   \
> > > >               err |= do_test_ ## t(&t ## _tests[i]);                  \
> > > > +     KUNIT_EXPECT_FALSE(test, err);                                  \
> > > >       return err;                                                     \
> > > >  }
> > >
> > > Also, if the caller is being made "void", probably this can be made void
> > > too?
> > >
> > > And if that's happening, maybe just plumb the EXPECT into the
> > > do_test_... call instead?
> >
> > I did something similar in v1, but you said:
> > "Only callers of the do_test_*() would need to be changed. I think all of
> > these macros just need the pr_warn/KUNIT_FAIL changes, and the function
> > prototypes updated to include struct kunit *test."
> >
> > >
> > > >
> > > > @@ -270,25 +268,25 @@ DEFINE_TEST_FUNC(u64, "%llu");
> > > >  DEFINE_TEST_FUNC(s64, "%lld");
> > > >  #endif
> > > >
> > > > -static int __init test_overflow_calculation(void)
> > > > +static void __init overflow_calculation_test(struct kunit *test)
> > > >  {
> > > >       int err = 0;
> > > >
> > > > -     err |= test_u8_overflow();
> > > > -     err |= test_s8_overflow();
> > > > -     err |= test_u16_overflow();
> > > > -     err |= test_s16_overflow();
> > > > -     err |= test_u32_overflow();
> > > > -     err |= test_s32_overflow();
> > > > +     err |= test_u8_overflow(test);
> > > > +     err |= test_s8_overflow(test);
> > > > +     err |= test_u16_overflow(test);
> > > > +     err |= test_s16_overflow(test);
> > > > +     err |= test_u32_overflow(test);
> > > > +     err |= test_s32_overflow(test);
> > > >  #if BITS_PER_LONG == 64
> > > > -     err |= test_u64_overflow();
> > > > -     err |= test_s64_overflow();
> > > > +     err |= test_u64_overflow(test);
> > > > +     err |= test_s64_overflow(test);
> > > >  #endif
> > > >
> > > > -     return err;
> > > > +     KUNIT_EXPECT_FALSE(test, err);
> > >
> > > This seems redundant (the tests were already tested)?
> >
> > Yep, I just tried to do something you said in v1:
> >
> > "I think it might be nice to keep the "err" vars around for a final report
> > line (maybe per test)? (It would keep the diff churn way lower, too...)"
> >
> > > >  }
> > > >
> > > > -static int __init test_overflow_shift(void)
> > > > +static void __init overflow_shift_test(struct kunit *test)
> > > >  {
> > > >       int err = 0;
> > > >
> > > > @@ -313,9 +311,9 @@ static int __init test_overflow_shift(void)
> > > >                       pr_warn("got %llu\n", (u64)__d);                \
> > > >               __failed = 1;                                           \
> > > >       }                                                               \
> > > > -     if (!__failed)                                                  \
> > > > -             pr_info("ok: (%s)(%s << %s) == %s\n", #t, #a, #s,       \
> > > > -                     of ? "overflow" : #expect);                     \
> > > > +     KUNIT_EXPECT_FALSE_MSG(test, __failed,                          \
> > > > +                            "ok: (%s)(%s << %s) == %s\n", #t, #a, #s,\
> > > > +                            of ? "overflow" : #expect);              \
> > > >       __failed;                                                       \
> > > >  })
> > > >
> > > > @@ -479,7 +477,7 @@ static int __init test_overflow_shift(void)
> > > >       err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
> > > >       err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
> > > >
> > > > -     return err;
> > > > +     KUNIT_EXPECT_FALSE(test, err);
> > > >  }
> > > >
> > > >  /*
> > > > @@ -499,7 +497,7 @@ static int __init test_overflow_shift(void)
> > > >  #define TEST_SIZE            (5 * 4096)
> > > >
> > > >  #define DEFINE_TEST_ALLOC(func, free_func, want_arg, want_gfp, want_node)\
> > > > -static int __init test_ ## func (void *arg)                          \
> > > > +static int __init test_ ## func (struct kunit *test, void *arg)              \
> > > >  {                                                                    \
> > > >       volatile size_t a = TEST_SIZE;                                  \
> > > >       volatile size_t b = (SIZE_MAX / TEST_SIZE) + 1;                 \
> > > > @@ -507,19 +505,15 @@ static int __init test_ ## func (void *arg)                             \
> > > >                                                                       \
> > > >       /* Tiny allocation test. */                                     \
> > > >       ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg, 1);\
> > > > -     if (!ptr) {                                                     \
> > > > -             pr_warn(#func " failed regular allocation?!\n");        \
> > > > -             return 1;                                               \
> > > > -     }                                                               \
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,                     \
> > > > +                     #func " failed regular allocation?!\n");        \
> > > >       free ## want_arg (free_func, arg, ptr);                         \
> > > >                                                                       \
> > > >       /* Wrapped allocation test. */                                  \
> > > >       ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,    \
> > > >                                                         a * b);       \
> > > > -     if (!ptr) {                                                     \
> > > > -             pr_warn(#func " unexpectedly failed bad wrapping?!\n"); \
> > > > -             return 1;                                               \
> > > > -     }                                                               \
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,                     \
> > > > +                     #func " unexpectedly failed bad wrapping?!\n"); \
> > > >       free ## want_arg (free_func, arg, ptr);                         \
> > > >                                                                       \
> > > >       /* Saturated allocation test. */                                \
> > > > @@ -555,7 +549,7 @@ DEFINE_TEST_ALLOC(kvzalloc_node, kvfree,     0, 1, 1);
> > > >  DEFINE_TEST_ALLOC(devm_kmalloc,  devm_kfree, 1, 1, 0);
> > > >  DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
> > > >
> > > > -static int __init test_overflow_allocation(void)
> > > > +static void __init overflow_allocation_test(struct kunit *test)
> > > >  {
> > > >       const char device_name[] = "overflow-test";
> > > >       struct device *dev;
> > > > @@ -563,52 +557,40 @@ static int __init test_overflow_allocation(void)
> > > >
> > > >       /* Create dummy device for devm_kmalloc()-family tests. */
> > > >       dev = root_device_register(device_name);
> > > > -     if (IS_ERR(dev)) {
> > > > -             pr_warn("Cannot register test device\n");
> > > > -             return 1;
> > > > -     }
> > > > -
> > > > -     err |= test_kmalloc(NULL);
> > > > -     err |= test_kmalloc_node(NULL);
> > > > -     err |= test_kzalloc(NULL);
> > > > -     err |= test_kzalloc_node(NULL);
> > > > -     err |= test_kvmalloc(NULL);
> > > > -     err |= test_kvmalloc_node(NULL);
> > > > -     err |= test_kvzalloc(NULL);
> > > > -     err |= test_kvzalloc_node(NULL);
> > > > -     err |= test_vmalloc(NULL);
> > > > -     err |= test_vmalloc_node(NULL);
> > > > -     err |= test_vzalloc(NULL);
> > > > -     err |= test_vzalloc_node(NULL);
> > > > -     err |= test_devm_kmalloc(dev);
> > > > -     err |= test_devm_kzalloc(dev);
> > > > +     KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev), "Cannot register test device\n");
> > > > +
> > > > +     err |= test_kmalloc(test, NULL);
> > > > +     err |= test_kmalloc_node(test, NULL);
> > > > +     err |= test_kzalloc(test, NULL);
> > > > +     err |= test_kzalloc_node(test, NULL);
> > > > +     err |= test_kvmalloc(test, NULL);
> > > > +     err |= test_kvmalloc_node(test, NULL);
> > > > +     err |= test_kvzalloc(test, NULL);
> > > > +     err |= test_kvzalloc_node(test, NULL);
> > > > +     err |= test_vmalloc(test, NULL);
> > > > +     err |= test_vmalloc_node(test, NULL);
> > > > +     err |= test_vzalloc(test, NULL);
> > > > +     err |= test_vzalloc_node(test, NULL);
> > > > +     err |= test_devm_kmalloc(test, dev);
> > > > +     err |= test_devm_kzalloc(test, dev);
> > > >
> > > >       device_unregister(dev);
> > > >
> > > > -     return err;
> > > > +     KUNIT_EXPECT_FALSE(test, err);
> > > >  }
> > > >
> > > > -static int __init test_module_init(void)
> > > > -{
> > > > -     int err = 0;
> > > > -
> > > > -     err |= test_overflow_calculation();
> > > > -     err |= test_overflow_shift();
> > > > -     err |= test_overflow_allocation();
> > > > -
> > > > -     if (err) {
> > > > -             pr_warn("FAIL!\n");
> > > > -             err = -EINVAL;
> > > > -     } else {
> > > > -             pr_info("all tests passed\n");
> > > > -     }
> > >
> > > The reason for older feedback on leaving "err" as it was, was to make
> > > sure it was easy for a human to see if everything passed or not. If
> > > KUnit provides a summary of all the tests at the end, then I don't need
> > > to preserve that here (in which case "err" can go away). However, if
> > > that summary does not exist for KUnit yet, then I'd like to keep the
> > > summary that is being removed here.

Kees, do you prefer a more detailed result this way for example ?

    # Subtest: overflow
    1..10
    ok 1 - test_u8_overflow
    ok 2 - test_s8_overflow
    ok 3 - test_u16_overflow
    ok 4 - test_s16_overflow
    ok 5 - test_u32_overflow
    ok 6 - test_s32_overflow
    ok 7 - test_u64_overflow
    ok 8 - test_s64_overflow
    ok 9 - overflow_shift_test
[snip]

> >
> > Kunit shows the result this way:
> >
> > [16:24:44] ======== [PASSED] overflow ========
> > [16:24:44] [PASSED] overflow_calculation_test
> > [16:24:44] [PASSED] overflow_shift_test
> > [16:24:44] [PASSED] overflow_allocation_test
> > [16:24:44] ============================================================
> >
> > >
> > > > +static struct kunit_case __initdata overflow_test_cases[] = {
> > > > +     KUNIT_CASE(overflow_calculation_test),
> > > > +     KUNIT_CASE(overflow_shift_test),
> > > > +     KUNIT_CASE(overflow_allocation_test),
> > > > +     {}
> > > > +};
> > > >
> > > > -     return err;
> > > > -}
> > > > +static struct kunit_suite __initdata overflow_test_suite = {
> > > > +     .name = "overflow",
> > > > +     .test_cases = overflow_test_cases,
> > > > +};
> > > >
> > > > -static void __exit test_module_exit(void)
> > > > -{ }
> > > > +kunit_test_suites(&overflow_test_suite);
> > > >
> > > > -module_init(test_module_init);
> > > > -module_exit(test_module_exit);
> > > >  MODULE_LICENSE("Dual MIT/GPL");
> > > >
> > > > base-commit: c63d2dd7e134ebddce4745c51f9572b3f0d92b26
> > > > --
> > > > 2.26.2
> > > >
> > >
> > > --
> > > Kees Cook
> >
> > In this version I tried to leave as few changes as possible.
> > It seemed to me that it would be better to leave a smaller diff.
> >
> > Thanks for the review!
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CAFd5g468HLqzTVX7cOeHnWWBBmTMKcKPEURSgwiDC-8Hcq_vuw%40mail.gmail.com.
