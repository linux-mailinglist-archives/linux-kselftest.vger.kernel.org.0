Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BDE28EB14
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 04:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgJOCTw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 22:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgJOCTh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 22:19:37 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7DC0251B9
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 16:49:50 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c3so765348ybl.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 16:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NabSdpmMQ1vva+/AZtpuk+T3qndusn3TpLaVrL7qIzE=;
        b=t4nohFcfw2lR0cmsxuEwUydRlZzt74N80IJb8NFhFxcBHZgq5sOnY32HvpKcQBArZY
         bVr1Wizx2yn4E4wY7GUt2RgFGJgApp6dPxz72XTCXhy4hHzLpQ6vOQGs/IiDkT8aM/W9
         9PrBDht/zbyAtENULD9I9oqoQ3yN7gfnl9U6GHATawA355a6TY6R4dbMn/yQLLNo+CYJ
         hKk2cSbjky5rdJEqbyfg5L5wBajwfV51dlK8teZq4fF77qpDPHfmTrBpXpMezW+R7egl
         aF7IZY98ONqgPTunjOhw0X7X5alOblJM4pIZr82AYI+Cy3AIoG2AehRCFEMrZKFUmn+T
         Z87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NabSdpmMQ1vva+/AZtpuk+T3qndusn3TpLaVrL7qIzE=;
        b=A5C/9MBszgafg7f9lRi6zM21M+SrY0ruRNmc+Sex+RzoK5hXgzsrO4AB/yS5AK3wAW
         /zSEzwmJllQOGgnY/q1WzPPCu+8lpFCdsy37AaIB+75AY2jXR6DAQVxU6nse+opruyI8
         jJqax/z9OBIYabHTYBqhrNHtNF4OV4wtK7SaOfSXT9XDclGi9LBHp1vsOAIqR+3cmIf3
         LP8f16iR5p0vYr5RwprbEZybw8BEF4aHCiymd4OTV4N7kxji97xqRW+8KoXUVx0qFit5
         tSXSHADgjxEXHyESON363iAIFLydrBNN03blNOOy5F+0LRcUqqD0S9D6Zyb9/hUYO3Vd
         YP0A==
X-Gm-Message-State: AOAM532Vzw3/+7dvOBEfe8FcyREqP+ay50GiqbrZ/BnEtpEpGXD6Txbq
        X6z8kZ9dffZamHWr3eKW2VJDIFcB6jRInfL+0og2qg==
X-Google-Smtp-Source: ABdhPJx24zHf3QVmYPbCxs4He15Uxk/SAyG8VIzdxPPq5akLLg3E68lgD0PpO2sDaUq9s33b76AiJdJ6S3VwG+yOcmM=
X-Received: by 2002:a25:b006:: with SMTP id q6mr1746880ybf.57.1602719389585;
 Wed, 14 Oct 2020 16:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200729201146.537433-1-vitor@massaru.org> <CAP-5=fWCMPyBYqn4p+_=Ra5_sXqUbr4h_OCuYS4iY-6fsnevvA@mail.gmail.com>
In-Reply-To: <CAP-5=fWCMPyBYqn4p+_=Ra5_sXqUbr4h_OCuYS4iY-6fsnevvA@mail.gmail.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 14 Oct 2020 20:49:13 -0300
Message-ID: <CADQ6JjWg70GcQJizwcHpL1bXE7rKYDdaEeQszKDVz4kf4+SVOA@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
To:     Ian Rogers <irogers@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ian,


On Wed, Jul 29, 2020 at 7:57 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jul 29, 2020 at 1:11 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
> >
> > This adds the conversion of the runtime tests of test_min_heap,
> > from `lib/test_min_heap.c` to KUnit tests.
> >
> > Please apply this commit first (linux-kselftest/kunit-fixes):
> > 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
>
> Thanks for this, I'm a fan of testing frameworks :-)
>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  lib/Kconfig.debug                         |  29 ++++--
> >  lib/Makefile                              |   2 +-
> >  lib/{test_min_heap.c => min_heap_kunit.c} | 117 ++++++++++++----------
> >  3 files changed, 83 insertions(+), 65 deletions(-)
> >  rename lib/{test_min_heap.c => min_heap_kunit.c} (60%)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 9ad9210d70a1..46674fc4972c 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1864,16 +1864,6 @@ config TEST_LIST_SORT
> >
> >           If unsure, say N.
> >
> > -config TEST_MIN_HEAP
> > -       tristate "Min heap test"
> > -       depends on DEBUG_KERNEL || m
> > -       help
> > -         Enable this to turn on min heap function tests. This test is
> > -         executed only once during system boot (so affects only boot time),
> > -         or at module load time.
> > -
> > -         If unsure, say N.
> > -
> >  config TEST_SORT
> >         tristate "Array-based sort test"
> >         depends on DEBUG_KERNEL || m
> > @@ -2185,6 +2175,25 @@ config LINEAR_RANGES_TEST
> >
> >           If unsure, say N.
> >
> > +config MIN_HEAP_KUNIT
> > +        tristate "KUnit test for Min heap"
> > +        depends on KUNIT
> > +        depends on DEBUG_KERNEL || m
> > +        help
> > +          Enable this to turn on min heap function tests. This test is
> > +          executed only once during system boot (so affects only boot time),
> > +          or at module load time.
> > +
> > +          KUnit tests run during boot and output the results to the debug log
> > +          in TAP format (http://testanything.org/). Only useful for kernel devs
> > +          running the KUnit test harness, and not intended for inclusion into a
> > +          production build.
> > +
> > +          For more information on KUnit and unit tests in general please refer
> > +          to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +          If unsure, say N.
> > +
>
> It's a shame we need a config option for this. Could we have one
> option to cover all basic library tests?
>
> >  config TEST_UDELAY
> >         tristate "udelay test driver"
> >         help
> > diff --git a/lib/Makefile b/lib/Makefile
> > index b1c42c10073b..748f57063160 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -72,7 +72,6 @@ CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
> >  UBSAN_SANITIZE_test_ubsan.o := y
> >  obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
> >  obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
> > -obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
> >  obj-$(CONFIG_TEST_LKM) += test_module.o
> >  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
> >  obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
> > @@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
> >  # KUnit tests
> >  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> >  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> > +obj-$(CONFIG_MIN_HEAP_KUNIT) += min_heap_kunit.o
> > diff --git a/lib/test_min_heap.c b/lib/min_heap_kunit.c
> > similarity index 60%
> > rename from lib/test_min_heap.c
> > rename to lib/min_heap_kunit.c
> > index d19c8080fd4d..398db1c63146 100644
> > --- a/lib/test_min_heap.c
> > +++ b/lib/min_heap_kunit.c
> > @@ -7,9 +7,8 @@
> >
> >  #include <linux/log2.h>
> >  #include <linux/min_heap.h>
> > -#include <linux/module.h>
> > -#include <linux/printk.h>
> >  #include <linux/random.h>
> > +#include <kunit/test.h>
> >
> >  static __init bool less_than(const void *lhs, const void *rhs)
> >  {
> > @@ -29,37 +28,34 @@ static __init void swap_ints(void *lhs, void *rhs)
> >         *(int *)rhs = temp;
> >  }
> >
> > -static __init int pop_verify_heap(bool min_heap,
> > +static __init void pop_verify_heap(struct kunit *context,
> > +                               bool min_heap,
> >                                 struct min_heap *heap,
> >                                 const struct min_heap_callbacks *funcs)
> >  {
> >         int *values = heap->data;
> > -       int err = 0;
> >         int last;
> >
> >         last = values[0];
> >         min_heap_pop(heap, funcs);
> >         while (heap->nr > 0) {
> >                 if (min_heap) {
> > -                       if (last > values[0]) {
> > -                               pr_err("error: expected %d <= %d\n", last,
> > -                                       values[0]);
> > -                               err++;
> > -                       }
> > +                       KUNIT_EXPECT_FALSE_MSG(context,
> > +                                              last > values[0],
> > +                                              "expected %d <= %d\n",
> > +                                              last, values[0]);
>
> I'm not familiar with kunit, is there a reason not to prefer:
> KUNIT_EXPECT_LT(context, last, values[0]);
>
> >                 } else {
> > -                       if (last < values[0]) {
> > -                               pr_err("error: expected %d >= %d\n", last,
> > -                                       values[0]);
> > -                               err++;
> > -                       }
> > +                       KUNIT_EXPECT_FALSE_MSG(context,
> > +                                              last < values[0],
> > +                                              "expected %d >= %d\n",
> > +                                              last, values[0]);
>
> Similarly KUNIT_EXPECT_GT.

In relation to this, instead of KUNIT_EXPECT_LT, we would have to have
something like KUNIT_EXPECT_LT_FALSE.
Otherwise the test will always fail.

>
> Thanks,
> Ian
>
> >                 }
> >                 last = values[0];
> >                 min_heap_pop(heap, funcs);
> >         }
> > -       return err;
> >  }
> >
> > -static __init int test_heapify_all(bool min_heap)
> > +static __init void test_heapify_all(struct kunit *context, bool min_heap)
> >  {
> >         int values[] = { 3, 1, 2, 4, 0x8000000, 0x7FFFFFF, 0,
> >                          -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
> > @@ -73,12 +69,11 @@ static __init int test_heapify_all(bool min_heap)
> >                 .less = min_heap ? less_than : greater_than,
> >                 .swp = swap_ints,
> >         };
> > -       int i, err;
> > +       int i;
> >
> >         /* Test with known set of values. */
> >         min_heapify_all(&heap, &funcs);
> > -       err = pop_verify_heap(min_heap, &heap, &funcs);
> > -
> > +       pop_verify_heap(context, min_heap, &heap, &funcs);
> >
> >         /* Test with randomly generated values. */
> >         heap.nr = ARRAY_SIZE(values);
> > @@ -86,12 +81,10 @@ static __init int test_heapify_all(bool min_heap)
> >                 values[i] = get_random_int();
> >
> >         min_heapify_all(&heap, &funcs);
> > -       err += pop_verify_heap(min_heap, &heap, &funcs);
> > -
> > -       return err;
> > +       pop_verify_heap(context, min_heap, &heap, &funcs);
> >  }
> >
> > -static __init int test_heap_push(bool min_heap)
> > +static __init void test_heap_push(struct kunit *context, bool min_heap)
> >  {
> >         const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
> >                              -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
> > @@ -106,25 +99,22 @@ static __init int test_heap_push(bool min_heap)
> >                 .less = min_heap ? less_than : greater_than,
> >                 .swp = swap_ints,
> >         };
> > -       int i, temp, err;
> > +       int i, temp;
> >
> >         /* Test with known set of values copied from data. */
> >         for (i = 0; i < ARRAY_SIZE(data); i++)
> >                 min_heap_push(&heap, &data[i], &funcs);
> > -
> > -       err = pop_verify_heap(min_heap, &heap, &funcs);
> > +       pop_verify_heap(context, min_heap, &heap, &funcs);
> >
> >         /* Test with randomly generated values. */
> >         while (heap.nr < heap.size) {
> >                 temp = get_random_int();
> >                 min_heap_push(&heap, &temp, &funcs);
> >         }
> > -       err += pop_verify_heap(min_heap, &heap, &funcs);
> > -
> > -       return err;
> > +       pop_verify_heap(context, min_heap, &heap, &funcs);
> >  }
> >
> > -static __init int test_heap_pop_push(bool min_heap)
> > +static __init void test_heap_pop_push(struct kunit *context, bool min_heap)
> >  {
> >         const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
> >                              -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
> > @@ -139,7 +129,7 @@ static __init int test_heap_pop_push(bool min_heap)
> >                 .less = min_heap ? less_than : greater_than,
> >                 .swp = swap_ints,
> >         };
> > -       int i, temp, err;
> > +       int i, temp;
> >
> >         /* Fill values with data to pop and replace. */
> >         temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
> > @@ -149,8 +139,7 @@ static __init int test_heap_pop_push(bool min_heap)
> >         /* Test with known set of values copied from data. */
> >         for (i = 0; i < ARRAY_SIZE(data); i++)
> >                 min_heap_pop_push(&heap, &data[i], &funcs);
> > -
> > -       err = pop_verify_heap(min_heap, &heap, &funcs);
> > +       pop_verify_heap(context, min_heap, &heap, &funcs);
> >
> >         heap.nr = 0;
> >         for (i = 0; i < ARRAY_SIZE(data); i++)
> > @@ -161,34 +150,54 @@ static __init int test_heap_pop_push(bool min_heap)
> >                 temp = get_random_int();
> >                 min_heap_pop_push(&heap, &temp, &funcs);
> >         }
> > -       err += pop_verify_heap(min_heap, &heap, &funcs);
> > +       pop_verify_heap(context, min_heap, &heap, &funcs);
> > +}
> >
> > -       return err;
> > +static void __init test_heapify_all_true(struct kunit *context)
> > +{
> > +       test_heapify_all(context, true);
> >  }
> >
> > -static int __init test_min_heap_init(void)
> > +static void __init test_heapify_all_false(struct kunit *context)
> >  {
> > -       int err = 0;
> > -
> > -       err += test_heapify_all(true);
> > -       err += test_heapify_all(false);
> > -       err += test_heap_push(true);
> > -       err += test_heap_push(false);
> > -       err += test_heap_pop_push(true);
> > -       err += test_heap_pop_push(false);
> > -       if (err) {
> > -               pr_err("test failed with %d errors\n", err);
> > -               return -EINVAL;
> > -       }
> > -       pr_info("test passed\n");
> > -       return 0;
> > +       test_heapify_all(context, true);
> > +}
> > +
> > +static void __init test_heap_push_true(struct kunit *context)
> > +{
> > +       test_heap_push(context, true);
> > +}
> > +
> > +static void __init test_heap_push_false(struct kunit *context)
> > +{
> > +       test_heap_push(context, false);
> >  }
> > -module_init(test_min_heap_init);
> >
> > -static void __exit test_min_heap_exit(void)
> > +static void __init test_heap_pop_push_true(struct kunit *context)
> >  {
> > -       /* do nothing */
> > +       test_heap_pop_push(context, true);
> >  }
> > -module_exit(test_min_heap_exit);
> > +
> > +static void __init test_heap_pop_push_false(struct kunit *context)
> > +{
> > +       test_heap_pop_push(context, false);
> > +}
> > +
> > +static struct kunit_case __refdata min_heap_test_cases[] = {
> > +       KUNIT_CASE(test_heapify_all_true),
> > +       KUNIT_CASE(test_heapify_all_false),
> > +       KUNIT_CASE(test_heap_push_true),
> > +       KUNIT_CASE(test_heap_push_false),
> > +       KUNIT_CASE(test_heap_pop_push_true),
> > +       KUNIT_CASE(test_heap_pop_push_false),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite min_heap_test_suite = {
> > +       .name = "min-heap",
> > +       .test_cases = min_heap_test_cases,
> > +};
> > +
> > +kunit_test_suites(&min_heap_test_suite);
> >
> >  MODULE_LICENSE("GPL");
> >
> > base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
> > --
> > 2.26.2
> >
