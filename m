Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F385020A951
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 01:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgFYXne (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 19:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgFYXnd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 19:43:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9CEC08C5DB
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 16:43:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so3881791pje.4
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79LPjzJfPjrwajexHKM/PvOYmLTuibYRMTBOobWgx1Y=;
        b=Rf/9jOK3dlutZpsnza2/fBK3E7Q6s44FaXLkBnhwQYGEwt+orT3D4R0Uvi/OmPyAVL
         3dYf4zEq8oKTNtoeorsoQfnQrw6OhC6P4y5xNGuCCbgrmT0LBC3at+GTcm5AanLn8zeE
         ZFPv1Lye0N+1/an9ozH+fNr28dHvgWAw5Y2SdysEcoq/IpvqmPG+M654Mo3Av77+b1kr
         bJ1kEfnSc4VagKeOh3Q1KqWogKH5BJJrfxTNukZJ/uzOiOc5FvkFW9d2Wosa2NO51kAh
         1RhHlWJ+aJHzx2LEnrX8lRPW1TY/UExJKV0V+E0I8f5R1rFZNrtKWYctXOx3JZIXLqCz
         /YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79LPjzJfPjrwajexHKM/PvOYmLTuibYRMTBOobWgx1Y=;
        b=AuMDZTvRS+TSx9PK4fqxbjKz4M09Z9t6YVfHBKBJnp27oTklZaB7MDSkCvoZd3XZXs
         BYB3AMh8+qiXubzlLwWEtn8cN2yFiOAyP86WO2yaQF9sPrGAQZHtIT5M/uU/znYTpdRu
         hBgzRZSnDVJFvZV1ACbYjqF0wcuPNSwUYqwkqBiHmke+FyvZhSaF60E27+cInfKXbF44
         SSpkx0bcMJKKlRF8Qyb5mCVZzcDR/sYRdpNe2c6D/QoM16Y2vckGZ2ZxO7wpWAkYWHFQ
         xs7II21GXr4rE30evAPgFPnGFc6APamo2qavwEWQVih+AhBdlU/2/edvY8Br3MEHQewW
         c7fw==
X-Gm-Message-State: AOAM532bS2a+82TkXCFM/2MtL4nFLXKHK9QYdVnoX6R6VpdAnQlSYiTq
        aZJnkp743M3ByB86wLdPgQvc9T2DTql3sA16ROocKQ==
X-Google-Smtp-Source: ABdhPJxA+K5IzMkBnUGuNRnbB4jOLxpSVoyzSeUKYeSjQ7Pzvz8oWYEt89jRlw6W3smv2EYH9cQtyF4bIALEDpRsM44=
X-Received: by 2002:a17:90b:e01:: with SMTP id ge1mr494886pjb.20.1593128611012;
 Thu, 25 Jun 2020 16:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200618140814.135948-1-vitor@massaru.org> <202006181949.6402C456@keescook>
In-Reply-To: <202006181949.6402C456@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 25 Jun 2020 16:43:20 -0700
Message-ID: <CAFd5g45gAYxGYekJ-bs-TW9GVorDp7yuoD-UeqnpMVEpts5rZg@mail.gmail.com>
Subject: Re: [RESEND, PATCH v2] lib: overflow-test: add KUnit test of
 check_*_overflow functions
To:     Kees Cook <keescook@chromium.org>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 18, 2020 at 8:06 PM Kees Cook <keescook@chromium.org> wrote:

Apologies for just jumping in the middle of this late. Vitor just
brought something to my attention.

> On Thu, Jun 18, 2020 at 11:08:14AM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the runtime tests of check_*_overflow functions,
> > from `lib/test_overflow.c`to KUnit tests.
> >
> > The log similar to the one seen in dmesg running test_overflow.c can be
> > seen in `test.log`.
> >
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Tested-by: David Gow <davidgow@google.com>
> > ---
> > v2:
> >   * moved lib/test_overflow.c to lib/overflow-test.c;
>
> I still don't want a dash in the filename, as this creates a difference
> between the source name and the module name. While I still prefer
> overflow_kunit.c, I can get over it and accept overflow_test.c :)
>
> >     * back to original license;
> >     * fixed style code;
> >     * keeps __initconst and added _refdata on overflow_test_cases variable;
> >     * keeps macros intact making asserts with the variable err;
> >     * removed duplicate test_s8_overflow();
> >   * fixed typos on commit message;
> > ---
> >  lib/Kconfig.debug                        | 20 +++++++--
> >  lib/Makefile                             |  2 +-
> >  lib/{test_overflow.c => overflow-test.c} | 54 +++++++++---------------
> >  3 files changed, 38 insertions(+), 38 deletions(-)
> >  rename lib/{test_overflow.c => overflow-test.c} (96%)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d74ac0fd6b2d..fb8a3955e969 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2000,9 +2000,6 @@ config TEST_UUID
> >  config TEST_XARRAY
> >       tristate "Test the XArray code at runtime"
> >
> > -config TEST_OVERFLOW
> > -     tristate "Test check_*_overflow() functions at runtime"
> > -
> >  config TEST_RHASHTABLE
> >       tristate "Perform selftest on resizable hash table"
> >       help
> > @@ -2155,6 +2152,23 @@ config SYSCTL_KUNIT_TEST
> >
> >         If unsure, say N.
> >
> > +config OVERFLOW_KUNIT_TEST
> > +     tristate "KUnit test for overflow" if !KUNIT_ALL_TESTS
> > +     depends on KUNIT
> > +     default KUNIT_ALL_TESTS
> > +     help
> > +       This builds the overflow KUnit tests.
> > +
> > +       KUnit tests run during boot and output the results to the debug log
> > +       in TAP format (http://testanything.org/). Only useful for kernel devs
> > +       running KUnit test harness and are not for inclusion into a production
> > +       build.
> > +
> > +       For more information on KUnit and unit tests in general please refer
> > +       to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +       If unsure, say N.
> > +
> >  config LIST_KUNIT_TEST
> >       tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
> >       depends on KUNIT
> > diff --git a/lib/Makefile b/lib/Makefile
> > index b1c42c10073b..3b725c9f92d4 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -75,7 +75,6 @@ obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
> >  obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
> >  obj-$(CONFIG_TEST_LKM) += test_module.o
> >  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
> > -obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
> >  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
> >  obj-$(CONFIG_TEST_SORT) += test_sort.o
> >  obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
> > @@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
> >  # KUnit tests
> >  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> >  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> > +obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow-test.o
> > diff --git a/lib/test_overflow.c b/lib/overflow-test.c
> > similarity index 96%
> > rename from lib/test_overflow.c
> > rename to lib/overflow-test.c
> > index 7a4b6f6c5473..d40ef06b1ade 100644
> > --- a/lib/test_overflow.c
> > +++ b/lib/overflow-test.c
> > @@ -4,14 +4,11 @@
> >   */
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > +#include <kunit/test.h>
> >  #include <linux/device.h>
> >  #include <linux/init.h>
> > -#include <linux/kernel.h>
> >  #include <linux/mm.h>
> > -#include <linux/module.h>
> >  #include <linux/overflow.h>
> > -#include <linux/slab.h>
> > -#include <linux/types.h>
> >  #include <linux/vmalloc.h>
> >
> >  #define DEFINE_TEST_ARRAY(t)                 \
> > @@ -270,7 +267,7 @@ DEFINE_TEST_FUNC(u64, "%llu");
> >  DEFINE_TEST_FUNC(s64, "%lld");
> >  #endif
> >
> > -static int __init test_overflow_calculation(void)
> > +static void __init overflow_calculation_test(struct kunit *test)
> >  {
> >       int err = 0;
> >
> > @@ -285,10 +282,10 @@ static int __init test_overflow_calculation(void)
> >       err |= test_s64_overflow();
> >  #endif
> >
> > -     return err;
> > +     KUNIT_EXPECT_FALSE(test, err);
> >  }
>
> Ah! Well, yes, I guess that is one way to do it. :) I'm just curious:
> why the change away from doing EXPECTs on individual tests?
>
> >
> > -static int __init test_overflow_shift(void)
> > +static void __init overflow_shift_test(struct kunit *test)
> >  {
> >       int err = 0;
> >
> > @@ -479,7 +476,7 @@ static int __init test_overflow_shift(void)
> >       err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
> >       err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
> >
> > -     return err;
> > +     KUNIT_EXPECT_FALSE(test, err);
> >  }
> >
> >  /*
> > @@ -555,7 +552,7 @@ DEFINE_TEST_ALLOC(kvzalloc_node, kvfree,     0, 1, 1);
> >  DEFINE_TEST_ALLOC(devm_kmalloc,  devm_kfree, 1, 1, 0);
> >  DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
> >
> > -static int __init test_overflow_allocation(void)
> > +static void __init overflow_allocation_test(struct kunit *test)
> >  {
> >       const char device_name[] = "overflow-test";
> >       struct device *dev;
> > @@ -563,10 +560,8 @@ static int __init test_overflow_allocation(void)
> >
> >       /* Create dummy device for devm_kmalloc()-family tests. */
> >       dev = root_device_register(device_name);
> > -     if (IS_ERR(dev)) {
> > -             pr_warn("Cannot register test device\n");
> > -             return 1;
> > -     }
> > +     if (IS_ERR(dev))
> > +             kunit_warn(test, "Cannot register test device\n");
> >
> >       err |= test_kmalloc(NULL);
> >       err |= test_kmalloc_node(NULL);
> > @@ -585,30 +580,21 @@ static int __init test_overflow_allocation(void)
> >
> >       device_unregister(dev);
> >
> > -     return err;
> > +     KUNIT_EXPECT_FALSE(test, err);
> >  }
> >
> > -static int __init test_module_init(void)
> > -{
> > -     int err = 0;
> > -
> > -     err |= test_overflow_calculation();
> > -     err |= test_overflow_shift();
> > -     err |= test_overflow_allocation();
> > -
> > -     if (err) {
> > -             pr_warn("FAIL!\n");
> > -             err = -EINVAL;
> > -     } else {
> > -             pr_info("all tests passed\n");
> > -     }
> > +static struct kunit_case __refdata overflow_test_cases[] = {
>
> Erm, __refdata? This seems like it should be __initdata.
>
> > +     KUNIT_CASE(overflow_calculation_test),
> > +     KUNIT_CASE(overflow_shift_test),
> > +     KUNIT_CASE(overflow_allocation_test),
> > +     {}
> > +};
> >
> > -     return err;
> > -}
> > +static struct kunit_suite overflow_test_suite = {
>
> And this.
>
> > +     .name = "overflow",
> > +     .test_cases = overflow_test_cases,
> > +};
> >
> > -static void __exit test_module_exit(void)
> > -{ }
> > +kunit_test_suites(&overflow_test_suite);
>
> I suspect the problem causing the need for __refdata there is the lack
> of __init markings on the functions in kunit_test_suites()?

That is correct, Kees.

This problem goes all the way back to the initial KUnit RFC. I forget
who first brought it up, but there was an issue that KUnit runs in
init and consequently has access to __init stuff, but we weren't sure
that we want to mark *everything* in KUnit as __init. This was for a
number of reasons: one of these reasons was that we were considering
allowing KUnit to run at different times; with Alan's KUNIT_DEBUGFS
patches, this is now a reality. Thus, in some configurations, KUnit
can run its tests after kernel init is done, but also not as a module.

Sorry for not seeing this before.

> (Or maybe this is explained somewhere else I've missed it.)
>
> For example, would this work? (I haven't tested it all.)
>
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 59f3144f009a..aad746d59d2f 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -233,9 +233,9 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
>  unsigned int kunit_test_case_num(struct kunit_suite *suite,
>                                  struct kunit_case *test_case);
>
> -int __kunit_test_suites_init(struct kunit_suite **suites);
> +int __init __kunit_test_suites_init(struct kunit_suite **suites);
>
> -void __kunit_test_suites_exit(struct kunit_suite **suites);
> +void __exit __kunit_test_suites_exit(struct kunit_suite **suites);
>
>  /**
>   * kunit_test_suites() - used to register one or more &struct kunit_suite
> @@ -263,8 +263,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
>   * everything else is definitely initialized.
>   */
>  #define kunit_test_suites(suites_list...)                              \
> -       static struct kunit_suite *suites[] = {suites_list, NULL};      \
> -       static int kunit_test_suites_init(void)                         \
> +       static struct kunit_suite *suites[] __initdata =                \
> +               {suites_list, NULL};                                    \
> +       static int __init kunit_test_suites_init(void)                  \
>         {                                                               \
>                 return __kunit_test_suites_init(suites);                \
>         }                                                               \
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c36037200310..bfb0f563721b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -381,7 +381,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
>         kunit_debugfs_create_suite(suite);
>  }
>
> -int __kunit_test_suites_init(struct kunit_suite **suites)
> +int __init __kunit_test_suites_init(struct kunit_suite **suites)
>  {
>         unsigned int i;
>
> @@ -393,7 +393,7 @@ int __kunit_test_suites_init(struct kunit_suite **suites)
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
>
> -static void kunit_exit_suite(struct kunit_suite *suite)
> +static void __exit kunit_exit_suite(struct kunit_suite *suite)
>  {
>         kunit_debugfs_destroy_suite(suite);
>  }
>
> >
> > -module_init(test_module_init);
> > -module_exit(test_module_exit);
> >  MODULE_LICENSE("Dual MIT/GPL");
> >
> > base-commit: 7bf200b3a4ac10b1b0376c70b8c66ed39eae7cdd
> > prerequisite-patch-id: e827b6b22f950b9f69620805a04e4a264cf4cc6a
> > --
> > 2.26.2
> >
>
> Thanks again for the conversion!
>
> --
> Kees Cook
