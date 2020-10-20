Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90637294155
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Oct 2020 19:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390954AbgJTRXh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 13:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390905AbgJTRXh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 13:23:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E6C0613D1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 10:23:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so2649800wmf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHul1OxumjXdzLDFboabsxgP+T8wu9OYStK55aNunxk=;
        b=HwMoGSohPzWVlNfG4Z/+SYlX1rZDSqxxQkRj94FVYgfvOBuVCInBTS8uEIKoC0PW6P
         YWkueLP9ZP9VKntRpePZK+VOUMB5ZFjLrZojLdqOBZIdZJNrF511bV5Ng2y08AI3Uq3E
         Xld/Qn4WCDjyuitZz+sRaDNQZZ6m7cMmLWM0SDt204ZrBmAkavhUQidDAJ2GUMrxIPst
         vhCw6B5zEPRWJDNbc2gMJ6mGLl2ISM2E9gLEdrFFVawnSFBux7ujvkBsR1PCb7yUt9+x
         eUE/aW0NgOGxTDpI0KYlnSkq7Oy2XoqyrOJE8KZQuC0UUW/OBa5RLI9bVw7GYyrLYSwu
         DHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHul1OxumjXdzLDFboabsxgP+T8wu9OYStK55aNunxk=;
        b=NZ3zcC7mFCvkrmXf7hC+MxB2ALULCy/vARfHxrPWudmRoGP6qCxnipvJ8pVmGleTr5
         lmt1DljJu8mvT8gxf70/tf8lGp78NbjIcH+P2/cbDNPar3vgyh0wSFnJSZcniTRR5kVW
         cI4ztL0ljD4+kMrRpg5GPArFrAFYu4GHdtV+98JySrFcOBcMCwVQfwcKwgywRBZHvdFe
         7Yvu8H4IwwXolTZv99ba9NMMzgBeLypiI0Sgj8n78+wQ++P1jMe5lTwEHig6zPDHwr3A
         BiQXcli+DTqLwp9WFZjmqPFcnugvW0jRdKdx44TuIgWppj/+C4/CrRCIPXfpKb5JBaFd
         xExw==
X-Gm-Message-State: AOAM533jXhjmJD7sd3oVTOpDofDhqYnSKKDuu2vX0jozNvQVsDJBqfOi
        iFU7MJ/3gs+Grl4J7YRMu+dXbtPSzoGFEDlMV7YPaxgOLv8=
X-Google-Smtp-Source: ABdhPJyBz8fiCvV4lgzvnRTjIxDLzCtl8EGS2CXkKOerO4VVgWpe8sC2tT8oe6pv8aiQhwhb9gUHlr6JLMqrbzinG7A=
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr4136218wms.77.1603214615616;
 Tue, 20 Oct 2020 10:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201015170217.291916-1-vitor@massaru.org>
In-Reply-To: <20201015170217.291916-1-vitor@massaru.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 20 Oct 2020 10:23:24 -0700
Message-ID: <CAP-5=fV+4GijgjEPCqPZDL77HtqBO=tGzrt-PNiiO1d1xDS4kA@mail.gmail.com>
Subject: Re: [PATCH v3] lib: kunit: add test_min_heap test conversion to KUnit
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 10:02 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the conversion of the runtime tests of test_min_heap,
> from `lib/test_min_heap.c` to KUnit tests.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>   v2:
>     * change Kconfig entries to be more adherent to KUnit documentation,
>       min_heap test runs when enabling full test coverage (KUNIT_ALL_TESTS).
>     * make kconfig help more concise;
>     * fix KUNIT_TEST sufix;
>   v3:
>     * change KUNIT_EXPECT_FALSE_MSG for KUNIT_EXPECT_LE and KUNIT_EXPECT_GE
>       where they are applicable;
> ---
>  lib/Kconfig.debug                         |  24 +++--
>  lib/Makefile                              |   2 +-
>  lib/{test_min_heap.c => min_heap_kunit.c} | 111 +++++++++++-----------
>  3 files changed, 72 insertions(+), 65 deletions(-)
>  rename lib/{test_min_heap.c => min_heap_kunit.c} (62%)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4f09c6505a2e..0e10ef1176de 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1915,16 +1915,6 @@ config TEST_LIST_SORT
>
>           If unsure, say N.
>
> -config TEST_MIN_HEAP
> -       tristate "Min heap test"
> -       depends on DEBUG_KERNEL || m
> -       help
> -         Enable this to turn on min heap function tests. This test is
> -         executed only once during system boot (so affects only boot time),
> -         or at module load time.
> -
> -         If unsure, say N.
> -
>  config TEST_SORT
>         tristate "Array-based sort test"
>         depends on DEBUG_KERNEL || m
> @@ -2256,6 +2246,20 @@ config BITS_TEST
>
>           If unsure, say N.
>
> +config MIN_HEAP_KUNIT_TEST
> +       tristate "KUnit test for Min heap" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enable this to turn on min heap function tests. This test is
> +         executed only once during system boot (so affects only boot time),
> +         or at module load time.
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
> index d862d41fdc3d..03d12e672cf8 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -68,7 +68,6 @@ CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
>  UBSAN_SANITIZE_test_ubsan.o := y
>  obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
>  obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
> -obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
>  obj-$(CONFIG_TEST_LKM) += test_module.o
>  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
>  obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
> @@ -343,3 +342,4 @@ obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) += test_bits.o
> +obj-$(CONFIG_MIN_HEAP_KUNIT_TEST) += min_heap_kunit.o
> diff --git a/lib/test_min_heap.c b/lib/min_heap_kunit.c
> similarity index 62%
> rename from lib/test_min_heap.c
> rename to lib/min_heap_kunit.c
> index d19c8080fd4d..97c5771f2b5e 100644
> --- a/lib/test_min_heap.c
> +++ b/lib/min_heap_kunit.c
> @@ -7,9 +7,8 @@
>
>  #include <linux/log2.h>
>  #include <linux/min_heap.h>
> -#include <linux/module.h>
> -#include <linux/printk.h>
>  #include <linux/random.h>
> +#include <kunit/test.h>
>
>  static __init bool less_than(const void *lhs, const void *rhs)
>  {
> @@ -29,37 +28,28 @@ static __init void swap_ints(void *lhs, void *rhs)
>         *(int *)rhs = temp;
>  }
>
> -static __init int pop_verify_heap(bool min_heap,
> +static __init void pop_verify_heap(struct kunit *context,
> +                               bool min_heap,
>                                 struct min_heap *heap,
>                                 const struct min_heap_callbacks *funcs)
>  {
>         int *values = heap->data;
> -       int err = 0;
>         int last;
>
>         last = values[0];
>         min_heap_pop(heap, funcs);
>         while (heap->nr > 0) {
>                 if (min_heap) {
> -                       if (last > values[0]) {
> -                               pr_err("error: expected %d <= %d\n", last,
> -                                       values[0]);
> -                               err++;
> -                       }
> +            KUNIT_EXPECT_LE(context, last, values[0]);
>                 } else {
> -                       if (last < values[0]) {
> -                               pr_err("error: expected %d >= %d\n", last,
> -                                       values[0]);
> -                               err++;
> -                       }
> +            KUNIT_EXPECT_GE(context, last, values[0]);
>                 }
>                 last = values[0];
>                 min_heap_pop(heap, funcs);
>         }
> -       return err;
>  }
>
> -static __init int test_heapify_all(bool min_heap)
> +static __init void test_heapify_all(struct kunit *context, bool min_heap)
>  {
>         int values[] = { 3, 1, 2, 4, 0x8000000, 0x7FFFFFF, 0,
>                          -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
> @@ -73,12 +63,11 @@ static __init int test_heapify_all(bool min_heap)
>                 .less = min_heap ? less_than : greater_than,
>                 .swp = swap_ints,
>         };
> -       int i, err;
> +       int i;
>
>         /* Test with known set of values. */
>         min_heapify_all(&heap, &funcs);
> -       err = pop_verify_heap(min_heap, &heap, &funcs);
> -
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>
>         /* Test with randomly generated values. */
>         heap.nr = ARRAY_SIZE(values);
> @@ -86,12 +75,10 @@ static __init int test_heapify_all(bool min_heap)
>                 values[i] = get_random_int();
>
>         min_heapify_all(&heap, &funcs);
> -       err += pop_verify_heap(min_heap, &heap, &funcs);
> -
> -       return err;
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>  }
>
> -static __init int test_heap_push(bool min_heap)
> +static __init void test_heap_push(struct kunit *context, bool min_heap)
>  {
>         const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
>                              -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
> @@ -106,25 +93,22 @@ static __init int test_heap_push(bool min_heap)
>                 .less = min_heap ? less_than : greater_than,
>                 .swp = swap_ints,
>         };
> -       int i, temp, err;
> +       int i, temp;
>
>         /* Test with known set of values copied from data. */
>         for (i = 0; i < ARRAY_SIZE(data); i++)
>                 min_heap_push(&heap, &data[i], &funcs);
> -
> -       err = pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>
>         /* Test with randomly generated values. */
>         while (heap.nr < heap.size) {
>                 temp = get_random_int();
>                 min_heap_push(&heap, &temp, &funcs);
>         }
> -       err += pop_verify_heap(min_heap, &heap, &funcs);
> -
> -       return err;
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>  }
>
> -static __init int test_heap_pop_push(bool min_heap)
> +static __init void test_heap_pop_push(struct kunit *context, bool min_heap)
>  {
>         const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
>                              -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
> @@ -139,7 +123,7 @@ static __init int test_heap_pop_push(bool min_heap)
>                 .less = min_heap ? less_than : greater_than,
>                 .swp = swap_ints,
>         };
> -       int i, temp, err;
> +       int i, temp;
>
>         /* Fill values with data to pop and replace. */
>         temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
> @@ -149,8 +133,7 @@ static __init int test_heap_pop_push(bool min_heap)
>         /* Test with known set of values copied from data. */
>         for (i = 0; i < ARRAY_SIZE(data); i++)
>                 min_heap_pop_push(&heap, &data[i], &funcs);
> -
> -       err = pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>
>         heap.nr = 0;
>         for (i = 0; i < ARRAY_SIZE(data); i++)
> @@ -161,34 +144,54 @@ static __init int test_heap_pop_push(bool min_heap)
>                 temp = get_random_int();
>                 min_heap_pop_push(&heap, &temp, &funcs);
>         }
> -       err += pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
> +}
>
> -       return err;
> +static void __init test_heapify_all_true(struct kunit *context)
> +{
> +       test_heapify_all(context, true);
>  }
>
> -static int __init test_min_heap_init(void)
> +static void __init test_heapify_all_false(struct kunit *context)
>  {
> -       int err = 0;
> -
> -       err += test_heapify_all(true);
> -       err += test_heapify_all(false);
> -       err += test_heap_push(true);
> -       err += test_heap_push(false);
> -       err += test_heap_pop_push(true);
> -       err += test_heap_pop_push(false);
> -       if (err) {
> -               pr_err("test failed with %d errors\n", err);
> -               return -EINVAL;
> -       }
> -       pr_info("test passed\n");
> -       return 0;
> +       test_heapify_all(context, true);
> +}
> +
> +static void __init test_heap_push_true(struct kunit *context)
> +{
> +       test_heap_push(context, true);
> +}
> +
> +static void __init test_heap_push_false(struct kunit *context)
> +{
> +       test_heap_push(context, false);
>  }
> -module_init(test_min_heap_init);
>
> -static void __exit test_min_heap_exit(void)
> +static void __init test_heap_pop_push_true(struct kunit *context)
>  {
> -       /* do nothing */
> +       test_heap_pop_push(context, true);
>  }
> -module_exit(test_min_heap_exit);
> +
> +static void __init test_heap_pop_push_false(struct kunit *context)
> +{
> +       test_heap_pop_push(context, false);
> +}
> +
> +static struct kunit_case __refdata min_heap_test_cases[] = {
> +       KUNIT_CASE(test_heapify_all_true),
> +       KUNIT_CASE(test_heapify_all_false),
> +       KUNIT_CASE(test_heap_push_true),
> +       KUNIT_CASE(test_heap_push_false),
> +       KUNIT_CASE(test_heap_pop_push_true),
> +       KUNIT_CASE(test_heap_pop_push_false),
> +       {}
> +};
> +
> +static struct kunit_suite min_heap_test_suite = {
> +       .name = "min-heap",
> +       .test_cases = min_heap_test_cases,
> +};
> +
> +kunit_test_suites(&min_heap_test_suite);
>
>  MODULE_LICENSE("GPL");
>
> base-commit: d2585f5164c298aaaed14c2c8d313cbe7bd5b253
> --
> 2.26.2
>
