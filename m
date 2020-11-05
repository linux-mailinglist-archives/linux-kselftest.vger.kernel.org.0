Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C140F2A7957
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 09:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgKEIab (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 03:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbgKEIaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 03:30:30 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4EC0613D3
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 00:30:28 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id c80so892918oib.2
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 00:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkuZsUOVhJV1Ad+u1YfqB0fBlaMURczWfLzaGVwvWSY=;
        b=tyPkD/mPzHvFNYSxyA1XcS23bfAagwQ24kx6Dt89XKfM31FNb+KZvpkVFxhzMGRzYu
         EkDBvjVwLYD22Tyc8VycqEiQOnpFYIul/0S64MVhH0WvmvsQnWXWkpFSH4jg1PBypMd3
         NT8MlKqIiaQmxc8ssAI13hgJ0KUKlHziNJ/FUq4SSv+yu2LofDk0c7nuty1aspo5qJJz
         Qthr6pxYahaIcstv/lMUp3D68FjhyrQVqnhiKHF5vLaL5FegOU+3B8eiwqRzAfhbbxgb
         DtBpOKUMJ6YcK3trss4oSNjsrQBNR5uOxUFt0EfXa3/2kV7BacQhxeBLdlWlJ3eQkUyG
         dL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkuZsUOVhJV1Ad+u1YfqB0fBlaMURczWfLzaGVwvWSY=;
        b=s2f79rXw5OsyoNVUq5EfApiGEiq2fI8bNfhboZ1Ihf1HoXcFQYy22MK7fWIQMpXC4m
         Ys8bQTG2b3cyiGBhhWGOY8s9+ESoDlrV4w2zYFhM48fuvm8kEtaI4AddtoMwieyppiQS
         j15cA72JP2/qjOuqGwwKedCVTd2O25fa2tCQCcHwMpgUaCWzHbemhRMhndiVER54cuVF
         eak0/RJNhc07pCaQ1lbYjd4llzkorM+HWhZLvjtPE3Vg+BuZLAoYVQbtX7VOKC+knT/V
         7NzuOZXP6tq6pYJuYrmDkdXc5uvxJbOhocMQQkiJyIxo08SxbjqxdeG1h2fJxcThyCdG
         /OfQ==
X-Gm-Message-State: AOAM532WcPVmbpn5AzfATX0RR/mugOTDvAgNxxFOLTx/Nr6NXTYBhSU8
        KL2pdTQCaMAmEqvmJ18ieC7OQ42+1Py8RcHlF/DyEw==
X-Google-Smtp-Source: ABdhPJxmkF4nv8Utu37j+MvtkmPCj01a6rYJA7RpZ13Tei3SnC2uFfpvNY3TUeJQU/e5t6mmkC7DrcwvbBCbM6Zn43U=
X-Received: by 2002:a54:4812:: with SMTP id j18mr940805oij.70.1604565027831;
 Thu, 05 Nov 2020 00:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20201027174630.85213-1-98.arpi@gmail.com> <CANpmjNOpbXHs4gs9Ro-u7hyN_zZ7s3AqDcdDy1Nqxq4ckThugA@mail.gmail.com>
 <73c4e46c-10f1-9362-b4fb-94ea9d74e9b2@gmail.com>
In-Reply-To: <73c4e46c-10f1-9362-b4fb-94ea9d74e9b2@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 5 Nov 2020 09:30:16 +0100
Message-ID: <CANpmjNPxqQM0_f14ZwV3rHZzwhCtqx2fbOhHmXmiJawou6=z6Q@mail.gmail.com>
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

On Thu, 5 Nov 2020 at 08:32, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> On 28/10/20 12:51 am, Marco Elver wrote:
> > On Tue, 27 Oct 2020 at 18:47, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >>
> >> Implementation of support for parameterized testing in KUnit.
> >> This approach requires the creation of a test case using the
> >> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> >> This generator function should return the next parameter given the
> >> previous parameter in parameterized tests. It also provides
> >> a macro to generate common-case generators.
> >>
> >> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> >> Co-developed-by: Marco Elver <elver@google.com>
> >> Signed-off-by: Marco Elver <elver@google.com>
> >> ---
> >> Changes v3->v4:
> >> - Rename kunit variables
> >> - Rename generator function helper macro
> >> - Add documentation for generator approach
> >> - Display test case name in case of failure along with param index
> >> Changes v2->v3:
> >> - Modifictaion of generator macro and method
> >> Changes v1->v2:
> >> - Use of a generator method to access test case parameters
> >>
> >>  include/kunit/test.h | 34 ++++++++++++++++++++++++++++++++++
> >>  lib/kunit/test.c     | 21 ++++++++++++++++++++-
> >>  2 files changed, 54 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/kunit/test.h b/include/kunit/test.h
> >> index 9197da792336..ec2307ee9bb0 100644
> >> --- a/include/kunit/test.h
> >> +++ b/include/kunit/test.h
> >> @@ -107,6 +107,13 @@ struct kunit;
> >>   *
> >>   * @run_case: the function representing the actual test case.
> >>   * @name:     the name of the test case.
> >> + * @generate_params: the generator function for parameterized tests.
> >> + *
> >> + * The generator function is used to lazily generate a series of
> >> + * arbitrarily typed values that fit into a void*. The argument @prev
> >> + * is the previously returned value, which should be used to derive the
> >> + * next value; @prev is set to NULL on the initial generator call.
> >> + * When no more values are available, the generator must return NULL.
> >>   *
> >
> > Hmm, should this really be the first paragraph? I think it should be
> > the paragraph before "Example:" maybe. But then that paragraph should
> > refer to generate_params e.g. "The generator function @generate_params
> > is used to ........".
> >
> > The other option you have is to move this paragraph to the kernel-doc
> > comment for KUNIT_CASE_PARAM, which seems to be missing a kernel-doc
> > comment.
> >
> >>   * A test case is a function with the signature,
> >>   * ``void (*)(struct kunit *)``
> >> @@ -141,6 +148,7 @@ struct kunit;
> >>  struct kunit_case {
> >>         void (*run_case)(struct kunit *test);
> >>         const char *name;
> >> +       void* (*generate_params)(void *prev);
> >>
> >>         /* private: internal use only. */
> >>         bool success;
> >> @@ -162,6 +170,9 @@ static inline char *kunit_status_to_string(bool status)
> >>   * &struct kunit_case for an example on how to use it.
> >>   */
> >>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> >
> > I.e. create a new kernel-doc comment for KUNIT_CASE_PARAM here, and
> > simply move the paragraph describing the generator protocol into that
> > comment.
> >
> >> +#define KUNIT_CASE_PARAM(test_name, gen_params)                        \
> >> +               { .run_case = test_name, .name = #test_name,    \
> >> +                 .generate_params = gen_params }
> >>
> >>  /**
> >>   * struct kunit_suite - describes a related collection of &struct kunit_case
> >> @@ -208,6 +219,15 @@ struct kunit {
> >>         const char *name; /* Read only after initialization! */
> >>         char *log; /* Points at case log after initialization */
> >>         struct kunit_try_catch try_catch;
> >> +       /* param_value points to test case parameters in parameterized tests */
> >
> > Hmm, not quite: param_value is the current parameter value for a test
> > case. Most likely it's a pointer, but it doesn't need to be.
> >
> >> +       void *param_value;
> >> +       /*
> >> +        * param_index stores the index of the parameter in
> >> +        * parameterized tests. param_index + 1 is printed
> >> +        * to indicate the parameter that causes the test
> >> +        * to fail in case of test failure.
> >> +        */
> >
> > I think this comment needs to be reformatted, because you can use at
> > the very least use 80 cols per line. (If you use vim, visual select
> > and do 'gq'.)
> >
> >> +       int param_index;
> >>         /*
> >>          * success starts as true, and may only be set to false during a
> >>          * test case; thus, it is safe to update this across multiple
> >> @@ -1742,4 +1762,18 @@ do {                                                                            \
> >>                                                 fmt,                           \
> >>                                                 ##__VA_ARGS__)
> >>
> >> +/**
> >> + * KUNIT_ARRAY_PARAM() - Helper method for test parameter generators
> >> + *                      required in parameterized tests.
> >> + * @name:  prefix of the name for the test parameter generator function.
> >> + *        It will be suffixed by "_gen_params".
> >> + * @array: a user-supplied pointer to an array of test parameters.
> >> + */
> >> +#define KUNIT_ARRAY_PARAM(name, array)                                                         \
> >> +       static void *name##_gen_params(void *prev)                                              \
> >> +       {                                                                                       \
> >> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \
> >> +               return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;                  \
> >> +       }
> >> +
> >>  #endif /* _KUNIT_TEST_H */
> >> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> >> index 750704abe89a..8ad908b61494 100644
> >> --- a/lib/kunit/test.c
> >> +++ b/lib/kunit/test.c
> >> @@ -127,6 +127,12 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
> >>  }
> >>  EXPORT_SYMBOL_GPL(kunit_test_case_num);
> >>
> >> +static void kunit_print_failed_param(struct kunit *test)
> >> +{
> >> +       kunit_err(test, "\n\tTest failed at:\n\ttest case: %s\n\tparameter: %d\n",
> >> +                                               test->name, test->param_index + 1);
> >> +}
> >
> > Hmm, perhaps I wasn't clear, but I think I also misunderstood how the
> > test case successes are presented: they are not, and it's all bunched
> > into a single test case.
> >
> > Firstly, kunit_err() already prints the test name, so if we want
> > something like "  # : the_test_case_name: failed at parameter #X",
> > simply having
> >
> >     kunit_err(test, "failed at parameter #%d\n", test->param_index + 1)
> >
> > would be what you want.
> >
> > But I think I missed that parameters do not actually produce a set of
> > test cases (sorry for noticing late). I think in their current form,
> > the parameterized tests would not be useful for my tests, because each
> > of my tests have test cases that have specific init and exit
> > functions. For each parameter, these would also need to run.
> >
> > Ideally, each parameter produces its own independent test case
> > "test_case#param_index". That way, CI systems will also be able to
> > logically separate different test case params, simply because each
> > param produced its own distinct test case.
> >
> > So, for example, we would get a series of test cases from something
> > like KUNIT_CASE_PARAM(test_case, foo_gen_params), and in the output
> > we'd see:
> >
> >     ok X - test_case#1
> >     ok X - test_case#2
> >     ok X - test_case#3
> >     ok X - test_case#4
> >     ....
> >
> > Would that make more sense?
> >
> > That way we'd ensure that test-case specific initialization and
> > cleanup done in init and exit functions is properly taken care of, and
> > you wouldn't need kunit_print_failed_param().
> >
> > AFAIK, for what I propose you'd have to modify kunit_print_ok_not_ok()
> > (show param_index if parameterized test) and probably
> > kunit_run_case_catch_errors() (generate params and set
> > test->param_value and param_index).
> >
> > Was there a reason why each param cannot be a distinct test case? If
> > not, I think this would be more useful.
> >
>
> I tried adding support to run each parameter as a distinct test case by
> making changes to kunit_run_case_catch_errors(). The issue here is that
> since the results are displayed in KTAP format, this change will result in
> each parameter being considered a subtest of another subtest (test case
> in KUnit).

Do you have example output? That might help understand what's going on.

> To make this work, a lot of changes in other parts will be required,
> and it will get complicated. Running all parameters as one test case seems
> to be a better option right now. So for now, I will modify what is displayed
> by kunit_err() in case of test failure.
>
> >>  static void kunit_print_string_stream(struct kunit *test,
> >>                                       struct string_stream *stream)
> >>  {
> >> @@ -168,6 +174,8 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
> >>         assert->format(assert, stream);
> >>
> >>         kunit_print_string_stream(test, stream);
> >> +       if (test->param_value)
> >> +               kunit_print_failed_param(test);
> >>
> >>         WARN_ON(string_stream_destroy(stream));
> >>  }
> >> @@ -239,7 +247,18 @@ static void kunit_run_case_internal(struct kunit *test,
> >>                 }
> >>         }
> >>
> >> -       test_case->run_case(test);
> >> +       if (!test_case->generate_params) {
> >> +               test_case->run_case(test);
> >> +       } else {
> >> +               test->param_value = test_case->generate_params(NULL);
> >> +               test->param_index = 0;
> >> +
> >> +               while (test->param_value) {
> >> +                       test_case->run_case(test);
> >> +                       test->param_value = test_case->generate_params(test->param_value);
> >> +                       test->param_index++;
> >> +               }
> >> +       }
> >
> > Thanks,
> > -- Marco
> >
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/73c4e46c-10f1-9362-b4fb-94ea9d74e9b2%40gmail.com.
