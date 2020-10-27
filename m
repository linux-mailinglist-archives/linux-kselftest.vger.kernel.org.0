Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1770829C8A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 20:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829836AbgJ0TWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 15:22:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44110 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829804AbgJ0TVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 15:21:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id m26so1973935otk.11
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nq9zEmsra/I9FskgMrWZwW4jiUKeh83zVbLmEJ7frGY=;
        b=hvjUrxeTnpKW11JqdRolGFlbjn/yYSrDZSBljizuyw98mqP/+42EJQeRg9IQ5N+mbt
         YK2asUVglRI0DGIMMA0SukSkVKO7BBMoEon9z5v8NkWZ9NvpMjDliPv4EDItaiS4FvwQ
         QgYoAx6QZCybILjrpxVneAnrCX85O3TAAA+oqfx7fhQxAhGcMxJfgaiq9Rt0Ezd82qdo
         rY7s7IViuNeP83O+ESncQvl8OwQZRhroog8poJljzzQIzrwxTnEwKDThGOkxQb3BPAxe
         W094rE9JA/5P+q8mqfIk8HX63+GoKCRylqUyl98aSIgjs2n5ZsAZ4D4STjBTdagEkVgd
         fH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nq9zEmsra/I9FskgMrWZwW4jiUKeh83zVbLmEJ7frGY=;
        b=RfljwsPJy/32XQulJg2ifOTstPIXlJE/ztSH6LKymk5l+fTSLOwbtJRmHSA6e9z9X6
         Lh85ceU5ggme8gVvfk6HQ6cXERxU/XLwOfw3ZHHxyfI4rbdNxyaTPYujEq5chBjwMG0W
         JeGRFPkL8zHwzzUYUye75ME7qHgBpy6G1i8E84LtXagoQbZJwyGk0LONMd6M1n2Lec2v
         jlLXo5tpTV5ZzqMmxNvdqTFXJNdiqSY/DRAndWU1mmVS2tYdfzOx1MJlOHYz1dJGqgEV
         Ams9ZdqNfDoLHYQv0PYFAVrBTkYwPU5Ac+vinw7SAjo0gmbzRV0e7Kwl4EZUbiMquTBp
         8s5w==
X-Gm-Message-State: AOAM532KoN3hs+YZIxy1jeojSpjs6gz7Kn2LmJKBHhMY6e2cCkNcysEM
        KUOUrG0oldSMocmNwunGvGuXesZxNSCrsFbXqn0Kfw==
X-Google-Smtp-Source: ABdhPJy41BE4xOtJgLoRUFUKd9T1jBqd55u8WiBk96SxzAPFBFX6yYc4b2eAoutgdTlEIJ0P6ZKJ3efEcKknqzr3n/M=
X-Received: by 2002:a9d:649:: with SMTP id 67mr2645328otn.233.1603826477947;
 Tue, 27 Oct 2020 12:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201027174630.85213-1-98.arpi@gmail.com>
In-Reply-To: <20201027174630.85213-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 27 Oct 2020 20:21:05 +0100
Message-ID: <CANpmjNOpbXHs4gs9Ro-u7hyN_zZ7s3AqDcdDy1Nqxq4ckThugA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
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

On Tue, 27 Oct 2020 at 18:47, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
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
>  include/kunit/test.h | 34 ++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 21 ++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9197da792336..ec2307ee9bb0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -107,6 +107,13 @@ struct kunit;
>   *
>   * @run_case: the function representing the actual test case.
>   * @name:     the name of the test case.
> + * @generate_params: the generator function for parameterized tests.
> + *
> + * The generator function is used to lazily generate a series of
> + * arbitrarily typed values that fit into a void*. The argument @prev
> + * is the previously returned value, which should be used to derive the
> + * next value; @prev is set to NULL on the initial generator call.
> + * When no more values are available, the generator must return NULL.
>   *

Hmm, should this really be the first paragraph? I think it should be
the paragraph before "Example:" maybe. But then that paragraph should
refer to generate_params e.g. "The generator function @generate_params
is used to ........".

The other option you have is to move this paragraph to the kernel-doc
comment for KUNIT_CASE_PARAM, which seems to be missing a kernel-doc
comment.

>   * A test case is a function with the signature,
>   * ``void (*)(struct kunit *)``
> @@ -141,6 +148,7 @@ struct kunit;
>  struct kunit_case {
>         void (*run_case)(struct kunit *test);
>         const char *name;
> +       void* (*generate_params)(void *prev);
>
>         /* private: internal use only. */
>         bool success;
> @@ -162,6 +170,9 @@ static inline char *kunit_status_to_string(bool status)
>   * &struct kunit_case for an example on how to use it.
>   */
>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }

I.e. create a new kernel-doc comment for KUNIT_CASE_PARAM here, and
simply move the paragraph describing the generator protocol into that
comment.

> +#define KUNIT_CASE_PARAM(test_name, gen_params)                        \
> +               { .run_case = test_name, .name = #test_name,    \
> +                 .generate_params = gen_params }
>
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
> @@ -208,6 +219,15 @@ struct kunit {
>         const char *name; /* Read only after initialization! */
>         char *log; /* Points at case log after initialization */
>         struct kunit_try_catch try_catch;
> +       /* param_value points to test case parameters in parameterized tests */

Hmm, not quite: param_value is the current parameter value for a test
case. Most likely it's a pointer, but it doesn't need to be.

> +       void *param_value;
> +       /*
> +        * param_index stores the index of the parameter in
> +        * parameterized tests. param_index + 1 is printed
> +        * to indicate the parameter that causes the test
> +        * to fail in case of test failure.
> +        */

I think this comment needs to be reformatted, because you can use at
the very least use 80 cols per line. (If you use vim, visual select
and do 'gq'.)

> +       int param_index;
>         /*
>          * success starts as true, and may only be set to false during a
>          * test case; thus, it is safe to update this across multiple
> @@ -1742,4 +1762,18 @@ do {                                                                            \
>                                                 fmt,                           \
>                                                 ##__VA_ARGS__)
>
> +/**
> + * KUNIT_ARRAY_PARAM() - Helper method for test parameter generators
> + *                      required in parameterized tests.
> + * @name:  prefix of the name for the test parameter generator function.
> + *        It will be suffixed by "_gen_params".
> + * @array: a user-supplied pointer to an array of test parameters.
> + */
> +#define KUNIT_ARRAY_PARAM(name, array)                                                         \
> +       static void *name##_gen_params(void *prev)                                              \
> +       {                                                                                       \
> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \
> +               return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;                  \
> +       }
> +
>  #endif /* _KUNIT_TEST_H */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 750704abe89a..8ad908b61494 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -127,6 +127,12 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
>  }
>  EXPORT_SYMBOL_GPL(kunit_test_case_num);
>
> +static void kunit_print_failed_param(struct kunit *test)
> +{
> +       kunit_err(test, "\n\tTest failed at:\n\ttest case: %s\n\tparameter: %d\n",
> +                                               test->name, test->param_index + 1);
> +}

Hmm, perhaps I wasn't clear, but I think I also misunderstood how the
test case successes are presented: they are not, and it's all bunched
into a single test case.

Firstly, kunit_err() already prints the test name, so if we want
something like "  # : the_test_case_name: failed at parameter #X",
simply having

    kunit_err(test, "failed at parameter #%d\n", test->param_index + 1)

would be what you want.

But I think I missed that parameters do not actually produce a set of
test cases (sorry for noticing late). I think in their current form,
the parameterized tests would not be useful for my tests, because each
of my tests have test cases that have specific init and exit
functions. For each parameter, these would also need to run.

Ideally, each parameter produces its own independent test case
"test_case#param_index". That way, CI systems will also be able to
logically separate different test case params, simply because each
param produced its own distinct test case.

So, for example, we would get a series of test cases from something
like KUNIT_CASE_PARAM(test_case, foo_gen_params), and in the output
we'd see:

    ok X - test_case#1
    ok X - test_case#2
    ok X - test_case#3
    ok X - test_case#4
    ....

Would that make more sense?

That way we'd ensure that test-case specific initialization and
cleanup done in init and exit functions is properly taken care of, and
you wouldn't need kunit_print_failed_param().

AFAIK, for what I propose you'd have to modify kunit_print_ok_not_ok()
(show param_index if parameterized test) and probably
kunit_run_case_catch_errors() (generate params and set
test->param_value and param_index).

Was there a reason why each param cannot be a distinct test case? If
not, I think this would be more useful.

>  static void kunit_print_string_stream(struct kunit *test,
>                                       struct string_stream *stream)
>  {
> @@ -168,6 +174,8 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
>         assert->format(assert, stream);
>
>         kunit_print_string_stream(test, stream);
> +       if (test->param_value)
> +               kunit_print_failed_param(test);
>
>         WARN_ON(string_stream_destroy(stream));
>  }
> @@ -239,7 +247,18 @@ static void kunit_run_case_internal(struct kunit *test,
>                 }
>         }
>
> -       test_case->run_case(test);
> +       if (!test_case->generate_params) {
> +               test_case->run_case(test);
> +       } else {
> +               test->param_value = test_case->generate_params(NULL);
> +               test->param_index = 0;
> +
> +               while (test->param_value) {
> +                       test_case->run_case(test);
> +                       test->param_value = test_case->generate_params(test->param_value);
> +                       test->param_index++;
> +               }
> +       }

Thanks,
-- Marco
