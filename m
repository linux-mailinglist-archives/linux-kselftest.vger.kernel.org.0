Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990412B3F2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 09:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgKPIxm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 03:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgKPIxk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 03:53:40 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF8C0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 00:53:39 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id t16so17942644oie.11
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 00:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkX3czK+fbRYaZuXoB4DEn+0Ko5lqadBX0VN06YRjVc=;
        b=GGNV+n7lWD5VBi9GsyrUcq5BUfeLfvqjxQI38yd/159lWM8mBmUIb+IhbnFfVRHM5O
         5yjyg3yOZjWavw4PbGUSMtsj6gfuD+lXpU5uVMJEYxoTiV9ZEynHYpxKSgXrzscRbUOi
         GdHE4WUmVlO+Y3xRFTyKv5p0wRvtFfoNFYsuc2UgdpQtj0F8CvWHxZ7itIM6yo9Z6qGJ
         SE+Hesr4awK9p1cqoDwg1X6rHKdfk9Jg8t01StD7wSW+dzsRW2tCDOqnE4jd6lRmZGuI
         ubwGEfTjAprjpb4SrrqBGnsVgeIOdaj3oSiZhMb9fsbaTbolqmIQZCH23hFhOP+jR6Al
         w5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkX3czK+fbRYaZuXoB4DEn+0Ko5lqadBX0VN06YRjVc=;
        b=mgJo2fEa1hJwdWXwwF8HpOj7yaOyZTx/Wbvco2rTUcIpuc7qW6jWlg/7WHtsptEtH5
         QGdYp0IyfqRWLDajqSSLQjg7V7wvKugUs+V8d8hulnvd3wo8C6KmkC//OlqurguDhQMF
         wJyPNuyGDSKSRZlL8UVMI8xIvnl4MAH7zQQPNYhi+S5k6E6VAVV6S31YfWkzRKraxn1K
         jXESLR40pqQaL98XKclZkPLldoSlVqJbrhqDuV+BdsG4mIHdLVx7C/kniadLcLFXS9Qf
         HCsc/uhwWGYUVmLkLCGokZhY4ji37w2va5kuNT/edDMe5IynGFWyBUlmPTDyXmGeCg52
         kdgg==
X-Gm-Message-State: AOAM532svHa+DnvjSXrWNrm57i1cBome4nJyjtaaGi0VLmJAMCW6ofQm
        ifNobnm8iOwnv3nO2JqmRl4o6jkCmT8XOU5l/xwDXswTllSK1Q==
X-Google-Smtp-Source: ABdhPJxZAKJ4LHOMQHRGvuS7TYY5xthkxV7U20xCSql92bwl5xhKU3jG6bX7d+NJJJgzAMNXCjBxv7wQIUyyEJ7xA/c=
X-Received: by 2002:aca:a988:: with SMTP id s130mr9148649oie.172.1605516818373;
 Mon, 16 Nov 2020 00:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com>
In-Reply-To: <20201116054035.211498-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 16 Nov 2020 09:53:27 +0100
Message-ID: <CANpmjNNFeXU_9JYoJMS7n9Zm-CRXOnRBXjW7pGjfNsaGZeS=Qg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Tim Bird <Tim.Bird@sony.com>, David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 16 Nov 2020 at 06:41, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Implementation of support for parameterized testing in KUnit. This
> approach requires the creation of a test case using the
> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
>
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides a macro to
> generate common-case generators based on arrays. Generators may also
> optionally provide a human-readable description of parameters, which is
> displayed where available.
>
> Note, currently the result of each parameter run is displayed in
> diagnostic lines, and only the overall test case output summarizes
> TAP-compliant success or failure of all parameter runs. In future, when
> supported by kunit-tool, these can be turned into subsubtest outputs.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

This and patch 2/2 look good to me.

Thank you!

-- Marco

> ---
> Changes v8->v9:
> - No change to this patch of the patch series
>
> Changes v7->v8:
> - Increase KUNIT_PARAM_DESC_SIZE to 128
> - Format pointer style appropriately
>
> Changes v6->v7:
> - Clarify commit message.
> - Introduce ability to optionally generate descriptions for parameters;
>   if no description is provided, we'll still print 'param-N'.
> - Change diagnostic line format to:
>         # <test-case-name>: <ok|not ok> N - [<param description>]
>
> Changes v5->v6:
> - Fix alignment to maintain consistency
>
> Changes v4->v5:
> - Update kernel-doc comments.
> - Use const void* for generator return and prev value types.
> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> - Rework parameterized test case execution strategy: each parameter is executed
>   as if it was its own test case, with its own test initialization and cleanup
>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
>   protocol once we have already started execution. Instead, log the result of
>   each parameter run as a diagnostic comment.
>
> Changes v3->v4:
> - Rename kunit variables
> - Rename generator function helper macro
> - Add documentation for generator approach
> - Display test case name in case of failure along with param index
>
> Changes v2->v3:
> - Modifictaion of generator macro and method
>
> Changes v1->v2:
> - Use of a generator method to access test case parameters
> Changes v6->v7:
> - Clarify commit message.
> - Introduce ability to optionally generate descriptions for parameters;
>   if no description is provided, we'll still print 'param-N'.
> - Change diagnostic line format to:
>         # <test-case-name>: <ok|not ok> N - [<param description>]
> - Before execution of parameterized test case, count number of
>   parameters and display number of parameters. Currently also as a
>   diagnostic line, but this may be used in future to generate a subsubtest
>   plan. A requirement of this change is that generators must generate a
>   deterministic number of parameters.
>
> Changes v5->v6:
> - Fix alignment to maintain consistency
>
> Changes v4->v5:
> - Update kernel-doc comments.
> - Use const void* for generator return and prev value types.
> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> - Rework parameterized test case execution strategy: each parameter is executed
>   as if it was its own test case, with its own test initialization and cleanup
>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
>   protocol once we have already started execution. Instead, log the result of
>   each parameter run as a diagnostic comment.
>
> Changes v3->v4:
> - Rename kunit variables
> - Rename generator function helper macro
> - Add documentation for generator approach
> - Display test case name in case of failure along with param index
>
> Changes v2->v3:
> - Modifictaion of generator macro and method
>
> Changes v1->v2:
> - Use of a generator method to access test case parameters
>
>  include/kunit/test.h | 51 ++++++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 59 ++++++++++++++++++++++++++++++++++----------
>  2 files changed, 97 insertions(+), 13 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index db1b0ae666c4..27b42a008c7a 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -94,6 +94,9 @@ struct kunit;
>  /* Size of log associated with test. */
>  #define KUNIT_LOG_SIZE 512
>
> +/* Maximum size of parameter description string. */
> +#define KUNIT_PARAM_DESC_SIZE 128
> +
>  /*
>   * TAP specifies subtest stream indentation of 4 spaces, 8 spaces for a
>   * sub-subtest.  See the "Subtests" section in
> @@ -107,6 +110,7 @@ struct kunit;
>   *
>   * @run_case: the function representing the actual test case.
>   * @name:     the name of the test case.
> + * @generate_params: the generator function for parameterized tests.
>   *
>   * A test case is a function with the signature,
>   * ``void (*)(struct kunit *)``
> @@ -141,6 +145,7 @@ struct kunit;
>  struct kunit_case {
>         void (*run_case)(struct kunit *test);
>         const char *name;
> +       const void* (*generate_params)(const void *prev, char *desc);
>
>         /* private: internal use only. */
>         bool success;
> @@ -163,6 +168,27 @@ static inline char *kunit_status_to_string(bool status)
>   */
>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
>
> +/**
> + * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
> + *
> + * @test_name: a reference to a test case function.
> + * @gen_params: a reference to a parameter generator function.
> + *
> + * The generator function::
> + *
> + *     const void* gen_params(const void *prev, char *desc)
> + *
> + * is used to lazily generate a series of arbitrarily typed values that fit into
> + * a void*. The argument @prev is the previously returned value, which should be
> + * used to derive the next value; @prev is set to NULL on the initial generator
> + * call. When no more values are available, the generator must return NULL.
> + * Optionally write a string into @desc (size of KUNIT_PARAM_DESC_SIZE)
> + * describing the parameter.
> + */
> +#define KUNIT_CASE_PARAM(test_name, gen_params)                        \
> +               { .run_case = test_name, .name = #test_name,    \
> +                 .generate_params = gen_params }
> +
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
>   *
> @@ -208,6 +234,10 @@ struct kunit {
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
> @@ -1742,4 +1772,25 @@ do {                                                                            \
>                                                 fmt,                           \
>                                                 ##__VA_ARGS__)
>
> +/**
> + * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: array of test parameters.
> + * @get_desc: function to convert param to description; NULL to use default
> + *
> + * Define function @name_gen_params which uses @array to generate parameters.
> + */
> +#define KUNIT_ARRAY_PARAM(name, array, get_desc)                                               \
> +       static const void *name##_gen_params(const void *prev, char *desc)                      \
> +       {                                                                                       \
> +               typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
> +               if (__next - (array) < ARRAY_SIZE((array))) {                                   \
> +                       void (*__get_desc)(typeof(__next), char *) = get_desc;                  \
> +                       if (__get_desc)                                                         \
> +                               __get_desc(__next, desc);                                       \
> +                       return __next;                                                          \
> +               }                                                                               \
> +               return NULL;                                                                    \
> +       }
> +
>  #endif /* _KUNIT_TEST_H */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 750704abe89a..ec9494e914ef 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -325,39 +325,72 @@ static void kunit_catch_run_case(void *data)
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
>  {
> +       char param_desc[KUNIT_PARAM_DESC_SIZE];
>         struct kunit_case *test_case;
>
>         kunit_print_subtest_start(suite);
>
> -       kunit_suite_for_each_test_case(suite, test_case)
> -               kunit_run_case_catch_errors(suite, test_case);
> +       kunit_suite_for_each_test_case(suite, test_case) {
> +               struct kunit test = { .param_value = NULL, .param_index = 0 };
> +               bool test_success = true;
> +
> +               if (test_case->generate_params) {
> +                       /* Get initial param. */
> +                       param_desc[0] = '\0';
> +                       test.param_value = test_case->generate_params(NULL, param_desc);
> +               }
> +
> +               do {
> +                       kunit_run_case_catch_errors(suite, test_case, &test);
> +                       test_success &= test_case->success;
> +
> +                       if (test_case->generate_params) {
> +                               if (param_desc[0] == '\0') {
> +                                       snprintf(param_desc, sizeof(param_desc),
> +                                                "param-%d", test.param_index);
> +                               }
> +
> +                               kunit_log(KERN_INFO, &test,
> +                                         KUNIT_SUBTEST_INDENT
> +                                         "# %s: %s %d - %s",
> +                                         test_case->name,
> +                                         kunit_status_to_string(test.success),
> +                                         test.param_index + 1, param_desc);
> +
> +                               /* Get next param. */
> +                               param_desc[0] = '\0';
> +                               test.param_value = test_case->generate_params(test.param_value, param_desc);
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
