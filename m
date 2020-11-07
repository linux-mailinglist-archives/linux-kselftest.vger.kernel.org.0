Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B2F2AA26E
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 05:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgKGE6g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 23:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgKGE6g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 23:58:36 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3514AC0613CF
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Nov 2020 20:58:36 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v18so3746625ljc.3
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 20:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrcPOo6i+nOKaGcssjeCtEpFiPKYd6jzH30EXtM+xO0=;
        b=asNQ1Vijk/0x433pPEUzyiHfiXBCMW/SaEE/XYh5Cr5VyIri1+of7lKMLILYqE2Jcy
         6HS+GVzQy55zdJ9S0RD6cRv8BTJJdLrvbvsCXqytxB0APRI2NIMYpz8JGQhHM/FE1LbR
         uHCYjBkugMl751yQ5IvuBpOWvsrBripyjwj9AQ2xfTGqfabtEqsMnpkG68ZlGiHVGqK3
         mlE8ydyD1+bIwUqWDB6QKST7bGAJiEQfrW2dCs4QOfiDGXSx3iloFqCOZYol0RXeDpAR
         dR+0f5+pg/Ia/sTBlHw4mrVaglPCqjrNBdbl1LaQCyzzZeGNnU80uDF4DuBTKo2FNZze
         F+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrcPOo6i+nOKaGcssjeCtEpFiPKYd6jzH30EXtM+xO0=;
        b=Tr82izBMISYRVbrdoobNLlMyIFjAkFju5rDAUf7UzgGmv7kACNpZPrOPS1XsVMfo/8
         i/dQUYQJDSjGBlBhZsuGfTx1DaBkxK2HtqNeSa9kUaAk7BUAXJ6iAw9nLY3XGndCSwAq
         81mX80/ymqI799WMxc8SEhnyPgDPhHyncK5xz3SkuNZ5l7wnBUWVyXFwzka5CiZgm07q
         4+oQXJP9yuYZQ74YLOVdUluMuE8nC5E49cCsB/UmjA5PltB/vpwP4CFoFQbKwnZXJgG2
         139qhw+Q93xI0DwQuv2dMtP9t5x9350lcibH89IjpezVoUvXx3djjNb4lPrIckiqzFZ5
         F94w==
X-Gm-Message-State: AOAM533ETo67xGRJlOQPNwdJrg93EV6bHaefj5P2ohmc8SWd/+zqyIBD
        TMfaU8IWuwZbDV5uizUahjzd750HAPdYeyPGNq8YNA==
X-Google-Smtp-Source: ABdhPJxjIeeHTsuTnNbico0DpKgO1y6BJLYflynAekFx9Ig3uYJ0B/hjIaTw6BRp9Z5i+si9det/23Pe+0kGpBA6yog=
X-Received: by 2002:a2e:9746:: with SMTP id f6mr2022414ljj.270.1604725113176;
 Fri, 06 Nov 2020 20:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com>
In-Reply-To: <20201106192154.51514-1-98.arpi@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 Nov 2020 12:58:21 +0800
Message-ID: <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 7, 2020 at 3:22 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Implementation of support for parameterized testing in KUnit.
> This approach requires the creation of a test case using the
> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides
> a macro to generate common-case generators.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---

This looks good to me! A couple of minor thoughts about the output
format below, but I'm quite happy to have this as-is regardless.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Changes v5->v6:
> - Fix alignment to maintain consistency
> Changes v4->v5:
> - Update kernel-doc comments.
> - Use const void* for generator return and prev value types.
> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> - Rework parameterized test case execution strategy: each parameter is executed
>   as if it was its own test case, with its own test initialization and cleanup
>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
>   protocol once we have already started execution. Instead, log the result of
>   each parameter run as a diagnostic comment.
> Changes v3->v4:
> - Rename kunit variables
> - Rename generator function helper macro
> - Add documentation for generator approach
> - Display test case name in case of failure along with param index
> Changes v2->v3:
> - Modifictaion of generator macro and method
> Changes v1->v2:
> - Use of a generator method to access test case parameters
>
>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 69 insertions(+), 13 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index db1b0ae666c4..16616d3974f9 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -107,6 +107,7 @@ struct kunit;
>   *
>   * @run_case: the function representing the actual test case.
>   * @name:     the name of the test case.
> + * @generate_params: the generator function for parameterized tests.
>   *
>   * A test case is a function with the signature,
>   * ``void (*)(struct kunit *)``
> @@ -141,6 +142,7 @@ struct kunit;
>  struct kunit_case {
>         void (*run_case)(struct kunit *test);
>         const char *name;
> +       const void* (*generate_params)(const void *prev);
>
>         /* private: internal use only. */
>         bool success;
> @@ -163,6 +165,22 @@ static inline char *kunit_status_to_string(bool status)
>   */
>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
>
> +/**
> + * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
> + *
> + * @test_name: a reference to a test case function.
> + * @gen_params: a reference to a parameter generator function.
> + *
> + * The generator function ``const void* gen_params(const void *prev)`` is used
> + * to lazily generate a series of arbitrarily typed values that fit into a
> + * void*. The argument @prev is the previously returned value, which should be
> + * used to derive the next value; @prev is set to NULL on the initial generator
> + * call.  When no more values are available, the generator must return NULL.
> + */
> +#define KUNIT_CASE_PARAM(test_name, gen_params)                        \
> +               { .run_case = test_name, .name = #test_name,    \
> +                 .generate_params = gen_params }
> +
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
>   *
> @@ -208,6 +226,10 @@ struct kunit {
>         const char *name; /* Read only after initialization! */
>         char *log; /* Points at case log after initialization */
>         struct kunit_try_catch try_catch;
> +       /* param_value is the current parameter value for a test case. */
> +       const void *param_value;
> +       /* param_index stores the index of the parameter in parameterized tests. */
> +       int param_index;
>         /*
>          * success starts as true, and may only be set to false during a
>          * test case; thus, it is safe to update this across multiple
> @@ -1742,4 +1764,18 @@ do {                                                                            \
>                                                 fmt,                           \
>                                                 ##__VA_ARGS__)
>
> +/**
> + * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: array of test parameters.
> + *
> + * Define function @name_gen_params which uses @array to generate parameters.
> + */
> +#define KUNIT_ARRAY_PARAM(name, array)                                                         \
> +       static const void *name##_gen_params(const void *prev)                                  \
> +       {                                                                                       \
> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \
> +               return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;                  \
> +       }
> +
>  #endif /* _KUNIT_TEST_H */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 750704abe89a..329fee9e0634 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -325,29 +325,25 @@ static void kunit_catch_run_case(void *data)
>   * occur in a test case and reports them as failures.
>   */
>  static void kunit_run_case_catch_errors(struct kunit_suite *suite,
> -                                       struct kunit_case *test_case)
> +                                       struct kunit_case *test_case,
> +                                       struct kunit *test)
>  {
>         struct kunit_try_catch_context context;
>         struct kunit_try_catch *try_catch;
> -       struct kunit test;
>
> -       kunit_init_test(&test, test_case->name, test_case->log);
> -       try_catch = &test.try_catch;
> +       kunit_init_test(test, test_case->name, test_case->log);
> +       try_catch = &test->try_catch;
>
>         kunit_try_catch_init(try_catch,
> -                            &test,
> +                            test,
>                              kunit_try_run_case,
>                              kunit_catch_run_case);
> -       context.test = &test;
> +       context.test = test;
>         context.suite = suite;
>         context.test_case = test_case;
>         kunit_try_catch_run(try_catch, &context);
>
> -       test_case->success = test.success;
> -
> -       kunit_print_ok_not_ok(&test, true, test_case->success,
> -                             kunit_test_case_num(suite, test_case),
> -                             test_case->name);
> +       test_case->success = test->success;
>  }
>
>  int kunit_run_tests(struct kunit_suite *suite)
> @@ -356,8 +352,32 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>         kunit_print_subtest_start(suite);
>
> -       kunit_suite_for_each_test_case(suite, test_case)
> -               kunit_run_case_catch_errors(suite, test_case);
> +       kunit_suite_for_each_test_case(suite, test_case) {
> +               struct kunit test = { .param_value = NULL, .param_index = 0 };
> +               bool test_success = true;
> +
> +               if (test_case->generate_params)
> +                       test.param_value = test_case->generate_params(NULL);
> +
> +               do {
> +                       kunit_run_case_catch_errors(suite, test_case, &test);
> +                       test_success &= test_case->success;
> +
> +                       if (test_case->generate_params) {
> +                               kunit_log(KERN_INFO, &test,
> +                                         KUNIT_SUBTEST_INDENT
> +                                         "# %s: param-%d %s",

Would it make sense to have this imitate the TAP format a bit more?
So, have "# [ok|not ok] - [name]" as the format? [name] could be
something like "[test_case->name]:param-[index]" or similar.
If we keep it commented out and don't indent it further, it won't
formally be a nested test (though if we wanted to support those later,
it'd be easy to add), but I think it would be nicer to be consistent
here.

My other suggestion -- albeit one outside the scope of this initial
version -- would be to allow the "param-%d" name to be overridden
somehow by a test. For example, the ext4 inode test has names for all
its test cases: it'd be nice to be able to display those instead (even
if they're not formatted as identifiers as-is).

> +                                         test_case->name, test.param_index,
> +                                         kunit_status_to_string(test.success));
> +                               test.param_value = test_case->generate_params(test.param_value);
> +                               test.param_index++;
> +                       }
> +               } while (test.param_value);
> +
> +               kunit_print_ok_not_ok(&test, true, test_success,
> +                                     kunit_test_case_num(suite, test_case),
> +                                     test_case->name);
> +       }
>
>         kunit_print_subtest_end(suite);
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20201106192154.51514-1-98.arpi%40gmail.com.
