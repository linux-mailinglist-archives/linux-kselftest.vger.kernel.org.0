Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA013CF05B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jul 2021 01:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhGSXNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jul 2021 19:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388727AbhGSVBc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jul 2021 17:01:32 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94C9C0613E4
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jul 2021 14:39:21 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z9so21677759iob.8
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jul 2021 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1XYgnjzAg7DsLLuF7dQCiT5m3Bavug3Psl0UPr+yEg=;
        b=UEg+So4FaqHi/jiXjQuX7UuaQIbgfx5inmQtjzkmaXb0tgxJOeziM5NOB1IV2N96C7
         qX//djAlTA1lH1a5IpoEH3mclT8wTVWBorTh0Fe+rOZQa3OyS040Kud+2ukKoWAHuPK8
         gozw9+qTLpGo0qqRlfKRWS7GftetXnAFNZcNwBjZLLfVplhBb/YBebj5ioLySp+PjKTs
         qus4Z/ogyUJU1UIuM4ePCQkRCgfvUb4RHC/tnLvLZolgGCpdBiN8IJ1RUi1ke/njL0Hb
         HIp+Y7OZv983qM7+A8ZEFWbZjG09ucogp5WPenxHWnqFaXpktyen3zFtmWabF1jnu9UV
         USkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1XYgnjzAg7DsLLuF7dQCiT5m3Bavug3Psl0UPr+yEg=;
        b=q38rkaMMQama+BiIuK08Hgh35l57QsGAFJhGjdDcevmOrQy2XVU1GGU1rhhA9xYBVS
         qEZ+u+vic6nePREtmz8MFz9FQJDTMWRcok83vqQoT+BJnz+bCFdi6sDG3bCrujbOFVN/
         hDoV7/KWpzNQKtfW9cVGTkZj5FfHlKwf+RTw5QtTnHSfEugTuDjHULBj1TbrnbU8YrpZ
         jkv1zc0q/Gn8G88jJ7pCNjxdoIUvK4bosi8O+YW7r8m3xImSllDVOOvkH9oOJTvFQjQV
         VV8qiQz+S3aFNkmIsqtcmG3cHaLdmGXF5uRFJrdF4k9yicdQyjoGCbCK6Cbv5/KuDcBj
         +V2A==
X-Gm-Message-State: AOAM530u1SAJltYmmE9iTrSbyPZnwCuiv4VBTuNjLRIeiIXebozWO5lR
        eiZn4wbJQkleUoYfk492OCBLfD9YfymC2S+jGMHY2w==
X-Google-Smtp-Source: ABdhPJyV7nALZ5qlmA5O7ExjBPmPeEzyK4jcz5FkMMrZc+upG4Pw+hFnULCUup7+k5Ss+7tOz6YEnH/rkit1xge3dY4=
X-Received: by 2002:a02:cab9:: with SMTP id e25mr15438249jap.25.1626730760955;
 Mon, 19 Jul 2021 14:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210719212302.167186-1-dlatypov@google.com>
In-Reply-To: <20210719212302.167186-1-dlatypov@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 19 Jul 2021 14:39:03 -0700
Message-ID: <CAGS_qxrX-+9AKOXz39xfsd+gY5cMZaJYo14WWc4T1ObqsA2dJQ@mail.gmail.com>
Subject: Re: [PATCH] lib/test: convert test_min_heap.c to use KUnit
To:     irogers@google.com
Cc:     peterz@infradead.org, brendanhiggins@google.com,
        davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 19, 2021 at 2:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> We leave the file names and Kconfig option unchanged for now to minimize
> disruption.

Oh, I missed that there was an equivalent patch before
https://lore.kernel.org/linux-kselftest/20201015170217.291916-1-vitor@massaru.org/

The main difference is the fact this doesn't change Kconfig options or
module names and the test case organization.
The other had test cases for each of the 3 ops, but added "true/false"
instead of the more human readable "min/max".
This change just has "test_min_heap" and "test_max_heap" test cases.

>
> So functionally, this just means that the test output will be slightly
> changed and it'll now depend on CONFIG_KUNIT=y/m.
>
> It'll still run at boot time and can still be built as a loadable
> module, but it can now be run a bit more easily via:
> $ ./tools/testing/kunit/kunit.py run
>
> By default, the above command will run with CONFIG_KUNIT_ALL_TESTS=y.
> Users could run this test individually via something like:
>
> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> CONFIG_KUNIT=y
> CONFIG_TEST_MIN_HEAP=y
> EOF
>
> Example output:
> [14:57:54] ============================================================
> [14:57:54] ======== [PASSED] lib_minmax_heap ========
> [14:57:54] [PASSED] test_min_heap
> [14:57:54] [PASSED] test_max_heap
> [14:57:54] ============================================================
> [14:57:54] Testing complete. 2 tests run. 0 failed. 0 crashed. 0 skipped.
> [14:57:54] Elapsed time: 39.696s total, 0.001s configuring, 36.705s building, 0.000s running
>
> Note: this is the time it took after a `make mrproper`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>  lib/Kconfig.debug   |   5 ++-
>  lib/test_min_heap.c | 102 ++++++++++++++++++++------------------------
>  2 files changed, 49 insertions(+), 58 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 831212722924..36e9529ede65 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2068,8 +2068,9 @@ config TEST_LIST_SORT
>           If unsure, say N.
>
>  config TEST_MIN_HEAP
> -       tristate "Min heap test"
> -       depends on DEBUG_KERNEL || m
> +       tristate "Min heap test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
>         help
>           Enable this to turn on min heap function tests. This test is
>           executed only once during system boot (so affects only boot time),
> diff --git a/lib/test_min_heap.c b/lib/test_min_heap.c
> index d19c8080fd4d..c0f1ef78c08e 100644
> --- a/lib/test_min_heap.c
> +++ b/lib/test_min_heap.c
> @@ -1,27 +1,27 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define pr_fmt(fmt) "min_heap_test: " fmt
> -
>  /*
>   * Test cases for the min max heap.
>   */
>
> +#include <kunit/test.h>
> +
>  #include <linux/log2.h>
>  #include <linux/min_heap.h>
>  #include <linux/module.h>
>  #include <linux/printk.h>
>  #include <linux/random.h>
>
> -static __init bool less_than(const void *lhs, const void *rhs)
> +static bool less_than(const void *lhs, const void *rhs)
>  {
>         return *(int *)lhs < *(int *)rhs;
>  }
>
> -static __init bool greater_than(const void *lhs, const void *rhs)
> +static bool greater_than(const void *lhs, const void *rhs)
>  {
>         return *(int *)lhs > *(int *)rhs;
>  }
>
> -static __init void swap_ints(void *lhs, void *rhs)
> +static void swap_ints(void *lhs, void *rhs)
>  {
>         int temp = *(int *)lhs;
>
> @@ -29,37 +29,27 @@ static __init void swap_ints(void *lhs, void *rhs)
>         *(int *)rhs = temp;
>  }
>
> -static __init int pop_verify_heap(bool min_heap,
> -                               struct min_heap *heap,
> -                               const struct min_heap_callbacks *funcs)
> +static void pop_verify_heap(struct kunit *test, bool min_heap,
> +                           struct min_heap *heap,
> +                           const struct min_heap_callbacks *funcs)
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
> +                       KUNIT_EXPECT_LE(test, last, values[0]);
>                 } else {
> -                       if (last < values[0]) {
> -                               pr_err("error: expected %d >= %d\n", last,
> -                                       values[0]);
> -                               err++;
> -                       }
> +                       KUNIT_EXPECT_GE(test, last, values[0]);
>                 }
>                 last = values[0];
>                 min_heap_pop(heap, funcs);
>         }
> -       return err;
>  }
>
> -static __init int test_heapify_all(bool min_heap)
> +static void test_heapify_all(struct kunit *test, bool min_heap)
>  {
>         int values[] = { 3, 1, 2, 4, 0x8000000, 0x7FFFFFF, 0,
>                          -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
> @@ -73,11 +63,11 @@ static __init int test_heapify_all(bool min_heap)
>                 .less = min_heap ? less_than : greater_than,
>                 .swp = swap_ints,
>         };
> -       int i, err;
> +       int i;
>
>         /* Test with known set of values. */
>         min_heapify_all(&heap, &funcs);
> -       err = pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(test, min_heap, &heap, &funcs);
>
>
>         /* Test with randomly generated values. */
> @@ -86,12 +76,10 @@ static __init int test_heapify_all(bool min_heap)
>                 values[i] = get_random_int();
>
>         min_heapify_all(&heap, &funcs);
> -       err += pop_verify_heap(min_heap, &heap, &funcs);
> -
> -       return err;
> +       pop_verify_heap(test, min_heap, &heap, &funcs);
>  }
>
> -static __init int test_heap_push(bool min_heap)
> +static void test_heap_push(struct kunit *test, bool min_heap)
>  {
>         const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
>                              -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
> @@ -106,25 +94,23 @@ static __init int test_heap_push(bool min_heap)
>                 .less = min_heap ? less_than : greater_than,
>                 .swp = swap_ints,
>         };
> -       int i, temp, err;
> +       int i, temp;
>
>         /* Test with known set of values copied from data. */
>         for (i = 0; i < ARRAY_SIZE(data); i++)
>                 min_heap_push(&heap, &data[i], &funcs);
>
> -       err = pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(test, min_heap, &heap, &funcs);
>
>         /* Test with randomly generated values. */
>         while (heap.nr < heap.size) {
>                 temp = get_random_int();
>                 min_heap_push(&heap, &temp, &funcs);
>         }
> -       err += pop_verify_heap(min_heap, &heap, &funcs);
> -
> -       return err;
> +       pop_verify_heap(test, min_heap, &heap, &funcs);
>  }
>
> -static __init int test_heap_pop_push(bool min_heap)
> +static void test_heap_pop_push(struct kunit *test, bool min_heap)
>  {
>         const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
>                              -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
> @@ -139,7 +125,7 @@ static __init int test_heap_pop_push(bool min_heap)
>                 .less = min_heap ? less_than : greater_than,
>                 .swp = swap_ints,
>         };
> -       int i, temp, err;
> +       int i, temp;
>
>         /* Fill values with data to pop and replace. */
>         temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
> @@ -150,7 +136,7 @@ static __init int test_heap_pop_push(bool min_heap)
>         for (i = 0; i < ARRAY_SIZE(data); i++)
>                 min_heap_pop_push(&heap, &data[i], &funcs);
>
> -       err = pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(test, min_heap, &heap, &funcs);
>
>         heap.nr = 0;
>         for (i = 0; i < ARRAY_SIZE(data); i++)
> @@ -161,34 +147,38 @@ static __init int test_heap_pop_push(bool min_heap)
>                 temp = get_random_int();
>                 min_heap_pop_push(&heap, &temp, &funcs);
>         }
> -       err += pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(test, min_heap, &heap, &funcs);
> +}
>
> -       return err;
> +static void test_heap(struct kunit *test, bool min_heap)
> +{
> +       test_heapify_all(test, min_heap);
> +       test_heap_push(test, min_heap);
> +       test_heap_pop_push(test, min_heap);
>  }
>
> -static int __init test_min_heap_init(void)
> +static void test_min_heap(struct kunit *test)
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
> +       test_heap(test, true);
>  }
> -module_init(test_min_heap_init);
>
> -static void __exit test_min_heap_exit(void)
> +static void test_max_heap(struct kunit *test)
>  {
> -       /* do nothing */
> +       test_heap(test, false);
>  }
> -module_exit(test_min_heap_exit);
> +
> +static struct kunit_case __refdata minmax_heap_test_cases[] = {
> +       KUNIT_CASE(test_min_heap),
> +       KUNIT_CASE(test_max_heap),
> +       {}
> +};
> +
> +static struct kunit_suite minmax_heap_test_suite = {
> +       .name = "lib_minmax_heap",
> +       .test_cases = minmax_heap_test_cases,
> +};
> +
> +kunit_test_suites(&minmax_heap_test_suite);
> +
>
>  MODULE_LICENSE("GPL");
>
> base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
> --
> 2.32.0.402.g57bb445576-goog
>
