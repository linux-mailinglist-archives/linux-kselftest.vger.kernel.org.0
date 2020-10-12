Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F19A28B353
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Oct 2020 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbgJLLBJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 07:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgJLLBH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 07:01:07 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A407C0613CE
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 04:01:07 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t15so15521956otk.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2YFWJ4pOihJHXPodcnaJ3e2LKbXyuwWQOZ0b/XSrV8=;
        b=tIb4U4SQcIv4Nhyx/JYzQed9+OXaMfwLCji838eUt700PeULZsa+2OTq+TpRk0yKyY
         RjcKqMI9CKAfUKSKrlJl0YyjZJvRZLww1+rOM+s+F0rgJoUNLswuUBz/Iz8jpJH1NE4q
         Rm+gypk/4N8QlZfSHHy/ifmzL/QT9rcB4K6/78l5JpvLUf2C6Fz0rae3W6hpr7YrwJJW
         uz0fC9woH5/3GthhMgNgFv47m2o7YsrwJt87Zc1dogDBtSReB8fYIamXdiWeLn6bMB1y
         NOPe+WvoxD0DZT4vKKedDKk+zHxlBaAX6JjwFNbmuwomwwS3rsoTl7xij5IkQsbnrfFJ
         Nung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2YFWJ4pOihJHXPodcnaJ3e2LKbXyuwWQOZ0b/XSrV8=;
        b=KBJqA+577MwAKSXVSdBbHA8+yxS5gyUFeGeLY80PTgCoTNu7cIXZyLg9Ty2JK6Xkao
         eMeu/sTAUL/647wslJXHinIjAsxpmMm74dlFuoIBuqcoO9cY5CYVM3Mh926lwFEgM0Cy
         oHoOSK7QXbZYOkfSVFgxVC3ZbfyALu25cDvssS7Q24jjn6I3dgIr/JaswHY1qDvG2WZJ
         XUku4HCx6WZ4NWSg/RK/p+aUCS1pB7WLvG9X36fErqNvCcf6u2R1XB/y3RYgweld+7oz
         qrNTpVcpcW6FZ0xWst4kaKmz+0JOmGf3AlIwGO2MfygN0gQbhwtlnorbiFAawUv4i8bU
         IBng==
X-Gm-Message-State: AOAM531oPm5jvq70PeNJw7xxStbTWW1sWz/giB/G9LzejJ49H97oToIm
        RzqjAjpm8fA+7GQ/zd7rUXc/RCY1fEh/E+zl1NoTMw==
X-Google-Smtp-Source: ABdhPJw+swSWmxv1x2aPtX24h3ONkzSGRkKogbhvAzbeYS+3/LewQEMZnQ2O5aCjFapU1Zgd/wDJAOaL5I/bk+ksh9g=
X-Received: by 2002:a9d:66a:: with SMTP id 97mr18798931otn.233.1602500466129;
 Mon, 12 Oct 2020 04:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201010145357.60886-1-98.arpi@gmail.com>
In-Reply-To: <20201010145357.60886-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Oct 2020 13:00:54 +0200
Message-ID: <CANpmjNOmbPsx-eEQ+TfC0X5CM-Jgy2NBqpYo=h2L9e33rnajSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, yzaikin@google.com,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 10 Oct 2020 at 16:54, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> Implementation of support for parameterized testing in KUnit.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---
>  include/kunit/test.h | 29 +++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 59f3144f009a..4740d66269b4 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -140,10 +140,14 @@ struct kunit;
>  struct kunit_case {
>         void (*run_case)(struct kunit *test);
>         const char *name;
> +       void* (*get_params)(void);
> +       int max_parameters_count;
> +       int parameter_size;
>
>         /* private: internal use only. */
>         bool success;
>         char *log;
> +       bool parameterized;

Why do you need this bool? Doesn't get_params being non-NULL tell you
if the test case is parameterized?

>  };
>
>  static inline char *kunit_status_to_string(bool status)
> @@ -162,6 +166,11 @@ static inline char *kunit_status_to_string(bool status)
>   */
>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
>
> +#define KUNIT_CASE_PARAM(test_name, getparams, count, size)                            \
> +               { .run_case = test_name, .name = #test_name,                            \
> +                 .parameterized = true, .get_params = (void* (*)(void))getparams,      \
> +                 .max_parameters_count = count, .parameter_size = size }
> +

I think this interface is overly complex. For one, if the only purpose
of the getparams function is to return a pointer to some array, then
there are only few cases where I see getparams being a function could
be useful.

Instead, could we make the getparams function behave like a generator?
Because then you do not need count, nor size. Its function signature
would be:

void* (*generate_params)(void* prev_param);

The protocol would be:

- The first call to generate_params is passed prev_param of NULL, and
returns a pointer to the first parameter P[0].

- Every nth successive call to generate_params is passed the previous
parameter P[n-1].

- When no more parameters are available, generate_params returns NULL.

- (generate_params should otherwise be stateless, but this is only
relevant if concurrent calls are expected.)


>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
>   *
> @@ -206,6 +215,23 @@ struct kunit {
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
>         char *log; /* Points at case log after initialization */
> +       bool parameterized; /* True for parameterized tests */
> +       /* param_values stores the test parameters
> +        * for parameterized tests.
> +        */
> +       void *param_values;
> +       /* max_parameters_count indicates maximum number of
> +        * parameters for parameterized tests.
> +        */
> +       int max_parameters_count;
> +       /* iterator_count is used by the iterator method
> +        * for parameterized tests.
> +        */
> +       int iterator_count;
> +       /* parameter_size indicates size of a single test case
> +        * for parameterized tests.
> +        */
> +       int parameter_size;

All of this would become much simpler if you used the generator
approach. Likely only 1 field would be required, which is the current
param.

>         struct kunit_try_catch try_catch;
>         /*
>          * success starts as true, and may only be set to false during a
> @@ -225,6 +251,7 @@ struct kunit {
>  };
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> +void kunit_init_param_test(struct kunit *test, struct kunit_case *test_case);
>
>  int kunit_run_tests(struct kunit_suite *suite);
>
> @@ -237,6 +264,8 @@ int __kunit_test_suites_init(struct kunit_suite **suites);
>
>  void __kunit_test_suites_exit(struct kunit_suite **suites);
>
> +void *get_test_case_parameters(struct kunit *test);
> +
>  /**
>   * kunit_test_suites() - used to register one or more &struct kunit_suite
>   *                      with KUnit.
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c36037200310..ab9e13c81d4a 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -142,6 +142,11 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
>  }
>  EXPORT_SYMBOL_GPL(kunit_test_case_num);
>
> +static void kunit_print_failed_param(struct kunit *test)
> +{
> +       kunit_err(test, "\n\tTest failed at parameter: %d\n", test->iterator_count);
> +}
> +
>  static void kunit_print_string_stream(struct kunit *test,
>                                       struct string_stream *stream)
>  {
> @@ -182,6 +187,9 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
>
>         assert->format(assert, stream);
>
> +       if (test->parameterized)
> +               kunit_print_failed_param(test);
> +
>         kunit_print_string_stream(test, stream);
>
>         WARN_ON(string_stream_destroy(stream));
> @@ -236,6 +244,18 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>
> +void kunit_init_param_test(struct kunit *test, struct kunit_case *test_case)
> +{
> +       spin_lock_init(&test->lock);
> +       INIT_LIST_HEAD(&test->resources);
> +       test->parameterized = true;
> +       test->param_values = (void *)(test_case->get_params());
> +       test->max_parameters_count = test_case->max_parameters_count;
> +       test->parameter_size = test_case->parameter_size;
> +       test->iterator_count = 0;
> +}
> +EXPORT_SYMBOL_GPL(kunit_init_param_test);
> +
>  /*
>   * Initializes and runs test case. Does not clean up or do post validations.
>   */
> @@ -254,7 +274,14 @@ static void kunit_run_case_internal(struct kunit *test,
>                 }
>         }
>
> -       test_case->run_case(test);
> +       if (!test->parameterized) {
> +               test_case->run_case(test);
> +       } else {
> +               int i;
> +
> +               for (i = 0; i < test->max_parameters_count; i++)
> +                       test_case->run_case(test);

With a generator approach, here you'd call generate_params. Most
likely, you'll need to stash its result somewhere, e.g. test->param,
so it can be retrieved by the test case.

> +       }
>  }
>
>  static void kunit_case_internal_cleanup(struct kunit *test)
> @@ -343,6 +370,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>         struct kunit test;
>
>         kunit_init_test(&test, test_case->name, test_case->log);
> +       if (test_case->parameterized)
> +               kunit_init_param_test(&test, test_case);
>         try_catch = &test.try_catch;
>
>         kunit_try_catch_init(try_catch,
> @@ -407,6 +436,19 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>
> +/*
> + * Iterator method for the parameterized test cases
> + */
> +void *get_test_case_parameters(struct kunit *test)
> +{
> +       int index = test->iterator_count * test->parameter_size;
> +
> +       if (test->iterator_count != test->max_parameters_count)
> +               test->iterator_count++;

This is quite confusing, because if get_test_case_parameters is called
multiple times within the same test case, we'll iterate through all
the test case params in the same test case? I think this function
should not have side-effects (like normal getters).

But if you use the generator approach, you'll likely not need this
function anyway.

> +       return (test->param_values + index);

Braces not needed.

> +}
> +EXPORT_SYMBOL_GPL(get_test_case_parameters);
> +
>  /*
>   * Used for static resources and when a kunit_resource * has been created by
>   * kunit_alloc_resource().  When an init function is supplied, @data is passed
> --
> 2.25.1
>
